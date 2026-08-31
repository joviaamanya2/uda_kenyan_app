<?php

namespace App\Http\Controllers\Admin;

use App\Admin\ResourceRegistry;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class CrudController extends Controller
{
    private function config(string $resource): array
    {
        $config = ResourceRegistry::get($resource);
        abort_if($config === null, 404);

        return $config;
    }

    public function index(Request $request, string $resource)
    {
        $config = $this->config($resource);
        $model = $config['model'];

        [$col, $dir] = $config['order'];
        $query = $model::query()->orderBy($col, $dir);

        if ($search = trim((string) $request->query('q'))) {
            $textFields = collect($config['fields'])
                ->whereIn('type', ['text', 'textarea', 'select'])
                ->pluck('name');
            $query->where(function ($q) use ($textFields, $search) {
                foreach ($textFields as $field) {
                    $q->orWhere($field, 'like', "%{$search}%");
                }
            });
        }

        $records = $query->paginate(20)->withQueryString();

        return view('admin.crud.index', compact('config', 'records', 'resource', 'search'));
    }

    public function create(string $resource)
    {
        $config = $this->config($resource);
        $record = new $config['model'];

        return view('admin.crud.form', compact('config', 'record', 'resource'));
    }

    public function store(Request $request, string $resource)
    {
        $config = $this->config($resource);
        $data = $this->validated($request, $config);
        $data = $this->handleUploads($request, $config, $data);

        $config['model']::create($data);

        return redirect()
            ->route('admin.resource.index', $resource)
            ->with('success', $config['label'].' created.');
    }

    public function edit(string $resource, int $id)
    {
        $config = $this->config($resource);
        $record = $config['model']::findOrFail($id);

        return view('admin.crud.form', compact('config', 'record', 'resource'));
    }

    public function update(Request $request, string $resource, int $id)
    {
        $config = $this->config($resource);
        $record = $config['model']::findOrFail($id);

        $data = $this->validated($request, $config);
        $data = $this->handleUploads($request, $config, $data, $record);

        $record->update($data);

        return redirect()
            ->route('admin.resource.index', $resource)
            ->with('success', $config['label'].' updated.');
    }

    public function destroy(string $resource, int $id)
    {
        $config = $this->config($resource);
        $record = $config['model']::findOrFail($id);

        foreach ($this->mediaFields($config) as $field) {
            $this->deleteStored($record->{$field['name']} ?? null);
        }

        $record->delete();

        return redirect()
            ->route('admin.resource.index', $resource)
            ->with('success', $config['label'].' deleted.');
    }

    private function validated(Request $request, array $config): array
    {
        $rules = [];
        foreach ($config['fields'] as $field) {
            $rules[$field['name']] = $field['rules'] ?? 'nullable';
        }

        $data = $request->validate($rules);

        // Normalise checkboxes / empty strings.
        foreach ($config['fields'] as $field) {
            $name = $field['name'];
            if ($field['type'] === 'boolean') {
                $data[$name] = $request->boolean($name);
            } elseif (($field['type'] === 'image' || $field['type'] === 'file')) {
                unset($data[$name]); // handled in handleUploads()
            } elseif (! array_key_exists($name, $data) && isset($field['default'])) {
                $data[$name] = $field['default'];
            } elseif (($data[$name] ?? null) === '') {
                $data[$name] = null;
            }
        }

        return $data;
    }

    private function handleUploads(Request $request, array $config, array $data, $record = null): array
    {
        foreach ($this->mediaFields($config) as $field) {
            $name = $field['name'];
            $current = $record?->{$name};

            if ($request->boolean($name.'_remove')) {
                $this->deleteStored($current);
                $data[$name] = null;

                continue;
            }

            if ($request->hasFile($name)) {
                $file = $request->file($name);
                $filename = Str::random(20).'.'.$file->getClientOriginalExtension();
                $path = $file->storeAs('uploads/'.$config['key'], $filename, 'public');
                $this->deleteStored($current);
                // Absolute URL against the current host:port so the mobile app
                // can load it directly (e.g. http://192.168.x.x:8000/storage/...).
                $data[$name] = url('storage/'.$path);

                continue;
            }

            // No new upload: keep what was there (unless a URL was typed in a
            // fallback text input named "<field>_url").
            $typedUrl = trim((string) $request->input($name.'_url'));
            if ($typedUrl !== '') {
                $data[$name] = $typedUrl;
            } elseif ($record !== null) {
                $data[$name] = $current;
            }
        }

        return $data;
    }

    private function mediaFields(array $config): array
    {
        return array_filter(
            $config['fields'],
            fn ($f) => in_array($f['type'], ['image', 'file'], true),
        );
    }

    private function deleteStored(?string $url): void
    {
        if (! $url) {
            return;
        }
        $prefix = '/storage/';
        $pos = strpos($url, $prefix);
        if ($pos === false) {
            return; // external URL or asset path — nothing we own
        }
        $relative = substr($url, $pos + strlen($prefix));
        Storage::disk('public')->delete($relative);
    }
}

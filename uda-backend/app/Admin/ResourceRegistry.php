<?php

namespace App\Admin;

use App\Models\Achievement;
use App\Models\Candidate;
use App\Models\CommunityGroup;
use App\Models\Event;
use App\Models\Fundraiser;
use App\Models\Leader;
use App\Models\Location;
use App\Models\News;
use App\Models\RadioStation;
use App\Models\Resource;
use App\Models\TVStation;
use App\Models\Video;

/**
 * Declarative schema for every content resource the admin dashboard manages.
 * The generic CrudController + Blade views are driven entirely by this file,
 * so adding a field is a one-line change here.
 *
 * Field types: text | textarea | number | date | datetime | boolean | select | image | file
 */
class ResourceRegistry
{
    public static function all(): array
    {
        return [
            'events' => [
                'model' => Event::class,
                'label' => 'Event',
                'plural' => 'Events',
                'group' => 'Content',
                'order' => ['start_time', 'desc'],
                'columns' => [
                    'title' => 'Title',
                    'category' => 'Category',
                    'location' => 'Location',
                    'start_time' => 'Starts',
                ],
                'fields' => [
                    ['name' => 'title', 'label' => 'Title', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'category', 'label' => 'Category', 'type' => 'text', 'rules' => 'nullable|string|max:255', 'default' => 'Event'],
                    ['name' => 'description', 'label' => 'Description', 'type' => 'textarea', 'rules' => 'nullable|string'],
                    ['name' => 'location', 'label' => 'Location', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'start_time', 'label' => 'Start time', 'type' => 'datetime', 'rules' => 'required|date'],
                    ['name' => 'end_time', 'label' => 'End time', 'type' => 'datetime', 'rules' => 'nullable|date|after_or_equal:start_time'],
                    ['name' => 'image_path', 'label' => 'Image', 'type' => 'image', 'rules' => 'nullable|image|max:5120'],
                ],
            ],

            'news' => [
                'model' => News::class,
                'label' => 'News article',
                'plural' => 'News',
                'group' => 'Content',
                'order' => ['published_at', 'desc'],
                'columns' => [
                    'title' => 'Title',
                    'category' => 'Category',
                    'published_at' => 'Published',
                ],
                'fields' => [
                    ['name' => 'title', 'label' => 'Title', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'category', 'label' => 'Category', 'type' => 'select', 'rules' => 'required|string', 'default' => 'General', 'options' => [
                        'General' => 'General',
                        'Politics' => 'Politics',
                        'Economy' => 'Economy',
                        'Youth' => 'Youth',
                        'Women' => 'Women',
                        'Development' => 'Development',
                    ], 'note' => 'Drives the category filter on the app news screen.'],
                    ['name' => 'content', 'label' => 'Content', 'type' => 'textarea', 'rules' => 'required|string', 'rows' => 10],
                    ['name' => 'published_at', 'label' => 'Published at', 'type' => 'datetime', 'rules' => 'nullable|date'],
                    ['name' => 'image_path', 'label' => 'Image', 'type' => 'image', 'rules' => 'nullable|image|max:5120'],
                ],
            ],

            'achievements' => [
                'model' => Achievement::class,
                'label' => 'Achievement',
                'plural' => 'Achievements',
                'group' => 'Content',
                'order' => ['date', 'desc'],
                'columns' => [
                    'title' => 'Title',
                    'date' => 'Date',
                ],
                'fields' => [
                    ['name' => 'title', 'label' => 'Title', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'description', 'label' => 'Description', 'type' => 'textarea', 'rules' => 'nullable|string'],
                    ['name' => 'date', 'label' => 'Date', 'type' => 'date', 'rules' => 'nullable|date'],
                    ['name' => 'image_path', 'label' => 'Image', 'type' => 'image', 'rules' => 'nullable|image|max:5120'],
                ],
            ],

            'candidates' => [
                'model' => Candidate::class,
                'label' => 'Candidate',
                'plural' => 'Candidates',
                'group' => 'Content',
                'order' => ['name', 'asc'],
                'columns' => [
                    'name' => 'Name',
                    'position' => 'Position',
                    'constituency' => 'Constituency',
                    'is_elected' => 'Elected',
                ],
                'fields' => [
                    ['name' => 'name', 'label' => 'Name', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'position', 'label' => 'Position', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'constituency', 'label' => 'Constituency', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'party', 'label' => 'Party', 'type' => 'text', 'rules' => 'nullable|string|max:255', 'default' => 'UDA'],
                    ['name' => 'bio', 'label' => 'Biography', 'type' => 'textarea', 'rules' => 'nullable|string'],
                    ['name' => 'is_elected', 'label' => 'Elected', 'type' => 'boolean', 'rules' => 'nullable|boolean'],
                    ['name' => 'photo_path', 'label' => 'Photo', 'type' => 'image', 'rules' => 'nullable|image|max:5120'],
                ],
            ],

            'fundraisers' => [
                'model' => Fundraiser::class,
                'label' => 'Fundraiser',
                'plural' => 'Fundraisers',
                'group' => 'Content',
                'order' => ['created_at', 'desc'],
                'columns' => [
                    'title' => 'Title',
                    'goal_amount' => 'Goal',
                    'raised_amount' => 'Raised',
                    'end_date' => 'Ends',
                ],
                'fields' => [
                    ['name' => 'title', 'label' => 'Title', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'description', 'label' => 'Description', 'type' => 'textarea', 'rules' => 'nullable|string'],
                    ['name' => 'goal_amount', 'label' => 'Goal amount (KES)', 'type' => 'number', 'rules' => 'nullable|numeric|min:0', 'step' => '0.01'],
                    ['name' => 'raised_amount', 'label' => 'Raised amount (KES)', 'type' => 'number', 'rules' => 'nullable|numeric|min:0', 'step' => '0.01'],
                    ['name' => 'start_date', 'label' => 'Start date', 'type' => 'date', 'rules' => 'nullable|date'],
                    ['name' => 'end_date', 'label' => 'End date', 'type' => 'date', 'rules' => 'nullable|date|after_or_equal:start_date'],
                    ['name' => 'image_path', 'label' => 'Image', 'type' => 'image', 'rules' => 'nullable|image|max:5120'],
                ],
            ],

            'videos' => [
                'model' => Video::class,
                'label' => 'Video',
                'plural' => 'Videos',
                'group' => 'Content',
                'order' => ['published_at', 'desc'],
                'columns' => [
                    'title' => 'Title',
                    'category' => 'Category',
                    'duration' => 'Duration',
                    'published_at' => 'Published',
                ],
                'fields' => [
                    ['name' => 'title', 'label' => 'Title', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'url', 'label' => 'Video URL (YouTube etc.)', 'type' => 'text', 'rules' => 'required|url|max:2048'],
                    ['name' => 'description', 'label' => 'Description', 'type' => 'textarea', 'rules' => 'nullable|string'],
                    ['name' => 'category', 'label' => 'Category', 'type' => 'select', 'rules' => 'nullable|string', 'options' => [
                        'Speeches' => 'Speeches',
                        'Interviews' => 'Interviews',
                        'Rallies' => 'Rallies',
                        'Highlights' => 'Highlights',
                    ]],
                    ['name' => 'duration', 'label' => 'Duration (e.g. 12:45)', 'type' => 'text', 'rules' => 'nullable|string|max:50'],
                    ['name' => 'published_at', 'label' => 'Published at', 'type' => 'datetime', 'rules' => 'nullable|date'],
                    ['name' => 'thumbnail_path', 'label' => 'Thumbnail', 'type' => 'image', 'rules' => 'nullable|image|max:5120'],
                ],
            ],

            'resources' => [
                'model' => Resource::class,
                'label' => 'Resource',
                'plural' => 'Resource Center',
                'group' => 'Content',
                'order' => ['published_at', 'desc'],
                'columns' => [
                    'title' => 'Title',
                    'type' => 'Type',
                    'published_at' => 'Published',
                ],
                'fields' => [
                    ['name' => 'title', 'label' => 'Title', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'type', 'label' => 'Type', 'type' => 'select', 'rules' => 'required|string', 'options' => ['document' => 'Document', 'tender' => 'Tender', 'notice' => 'Notice', 'financial_statement' => 'Financial statement', 'download' => 'Download'], 'default' => 'document'],
                    ['name' => 'description', 'label' => 'Description', 'type' => 'textarea', 'rules' => 'nullable|string'],
                    ['name' => 'published_at', 'label' => 'Published at', 'type' => 'datetime', 'rules' => 'nullable|date'],
                    ['name' => 'file_path', 'label' => 'File (PDF etc.)', 'type' => 'file', 'rules' => 'nullable|file|max:20480'],
                ],
            ],

            'community-groups' => [
                'model' => CommunityGroup::class,
                'label' => 'Community group',
                'plural' => 'Community Groups',
                'group' => 'Community',
                'order' => ['name', 'asc'],
                'columns' => [
                    'name' => 'Name',
                    'location' => 'Location',
                    'whatsapp' => 'WhatsApp',
                ],
                'fields' => [
                    ['name' => 'name', 'label' => 'Name', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'description', 'label' => 'Description', 'type' => 'textarea', 'rules' => 'nullable|string'],
                    ['name' => 'location', 'label' => 'Location', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'contact_info', 'label' => 'Contact info', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'whatsapp', 'label' => 'WhatsApp join link or number', 'type' => 'text', 'rules' => 'nullable|string|max:255', 'note' => 'A group invite link (https://chat.whatsapp.com/...) or a phone number in international format (+2547...).'],
                ],
            ],

            'tv-stations' => [
                'model' => TVStation::class,
                'label' => 'TV station',
                'plural' => 'TV Stations',
                'group' => 'Community',
                'order' => ['name', 'asc'],
                'columns' => [
                    'name' => 'Name',
                    'stream_url' => 'Stream URL',
                ],
                'fields' => [
                    ['name' => 'name', 'label' => 'Name', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'stream_url', 'label' => 'Stream URL', 'type' => 'text', 'rules' => 'nullable|url|max:2048'],
                    ['name' => 'description', 'label' => 'Description', 'type' => 'textarea', 'rules' => 'nullable|string'],
                ],
            ],

            'radio-stations' => [
                'model' => RadioStation::class,
                'label' => 'Radio station',
                'plural' => 'Radio Stations',
                'group' => 'Community',
                'order' => ['name', 'asc'],
                'columns' => [
                    'name' => 'Name',
                    'frequency' => 'Frequency',
                    'stream_url' => 'Stream URL',
                ],
                'fields' => [
                    ['name' => 'name', 'label' => 'Name', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'frequency', 'label' => 'Frequency', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'stream_url', 'label' => 'Stream URL', 'type' => 'text', 'rules' => 'nullable|url|max:2048'],
                    ['name' => 'description', 'label' => 'Description', 'type' => 'textarea', 'rules' => 'nullable|string'],
                ],
            ],

            'locations' => [
                'model' => Location::class,
                'label' => 'Location',
                'plural' => 'Locations',
                'group' => 'Community',
                'order' => ['name', 'asc'],
                'columns' => [
                    'name' => 'Name',
                    'address' => 'Address',
                    'latitude' => 'Lat',
                    'longitude' => 'Lng',
                ],
                'fields' => [
                    ['name' => 'name', 'label' => 'Name', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'address', 'label' => 'Address', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'latitude', 'label' => 'Latitude', 'type' => 'number', 'rules' => 'nullable|numeric|between:-90,90', 'step' => 'any'],
                    ['name' => 'longitude', 'label' => 'Longitude', 'type' => 'number', 'rules' => 'nullable|numeric|between:-180,180', 'step' => 'any'],
                ],
            ],

            'leaders' => [
                'model' => Leader::class,
                'label' => 'Leader',
                'plural' => 'Leaders',
                'group' => 'Content',
                'order' => ['sort_order', 'asc'],
                'columns' => [
                    'name' => 'Name',
                    'category' => 'Category',
                    'section' => 'Section',
                    'position' => 'Position',
                    'is_featured' => 'Featured',
                ],
                'fields' => [
                    ['name' => 'name', 'label' => 'Name', 'type' => 'text', 'rules' => 'required|string|max:255'],
                    ['name' => 'category', 'label' => 'Category', 'type' => 'select', 'rules' => 'required|string', 'options' => ['executive' => 'Executive (top leadership)', 'party_leadership' => 'Party leadership (sectioned roster)'], 'default' => 'executive'],
                    ['name' => 'section', 'label' => 'Section', 'type' => 'text', 'rules' => 'nullable|string|max:255', 'note' => 'Only for the party-leadership roster, e.g. "Secretary General".'],
                    ['name' => 'position', 'label' => 'Position', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'county', 'label' => 'County', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'constituency', 'label' => 'Constituency', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'bio', 'label' => 'Biography', 'type' => 'textarea', 'rules' => 'nullable|string'],
                    ['name' => 'office', 'label' => 'Office', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'email', 'label' => 'Email', 'type' => 'text', 'rules' => 'nullable|email|max:255'],
                    ['name' => 'phone', 'label' => 'Phone', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'term_label', 'label' => 'Term label', 'type' => 'text', 'rules' => 'nullable|string|max:255'],
                    ['name' => 'is_featured', 'label' => 'Featured', 'type' => 'boolean', 'rules' => 'nullable|boolean'],
                    ['name' => 'sort_order', 'label' => 'Sort order', 'type' => 'number', 'rules' => 'nullable|integer|min:0', 'default' => 0],
                    ['name' => 'photo_path', 'label' => 'Photo', 'type' => 'image', 'rules' => 'nullable|image|max:5120'],
                ],
            ],
        ];
    }

    public static function get(string $key): ?array
    {
        $config = static::all()[$key] ?? null;

        return $config ? $config + ['key' => $key] : null;
    }

    /** Sidebar glyph name (see resources/views/admin/partials/icon.blade.php) for a resource key. */
    public static function icon(string $key): string
    {
        return [
            'events' => 'calendar',
            'news' => 'news',
            'achievements' => 'trophy',
            'candidates' => 'flag',
            'fundraisers' => 'heart',
            'videos' => 'video',
            'resources' => 'folder',
            'community-groups' => 'chat',
            'tv-stations' => 'tv',
            'radio-stations' => 'radio',
            'locations' => 'pin',
            'leaders' => 'star',
        ][$key] ?? 'dot';
    }

    /** Sidebar-friendly grouping: ['Content' => ['events' => 'Events', ...], ...] */
    public static function grouped(): array
    {
        $groups = [];
        foreach (static::all() as $key => $config) {
            $groups[$config['group']][$key] = $config['plural'];
        }

        return $groups;
    }
}

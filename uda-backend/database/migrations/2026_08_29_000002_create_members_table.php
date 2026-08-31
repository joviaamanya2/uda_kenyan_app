<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('members', function (Blueprint $table) {
            $table->id();
            $table->string('surname');
            $table->string('other_name');
            $table->string('phone');
            $table->string('national_id_number')->nullable();
            $table->string('gender')->nullable();
            $table->string('district')->nullable();
            $table->string('village')->nullable();
            $table->string('sub_county')->nullable();
            $table->string('parish')->nullable();
            $table->string('id_front_path')->nullable();
            $table->string('id_back_path')->nullable();
            $table->boolean('was_in_uda')->default(false);
            $table->string('uda_from')->nullable();
            $table->string('uda_to')->nullable();
            $table->boolean('was_in_other_party')->default(false);
            $table->string('previous_party')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('members');
    }
};

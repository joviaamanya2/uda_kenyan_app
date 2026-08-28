<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::table('leaders', function (Blueprint $table) {
            // 'executive' = top national leadership (home screen + executive
            // committee). 'party_leadership' = the sectioned leaders roster.
            $table->string('category')->default('executive')->after('name');
            // Only used by the sectioned roster (e.g. "Secretary General").
            $table->string('section')->nullable()->after('category');
            $table->string('email')->nullable()->after('office');
            $table->string('phone')->nullable()->after('email');
        });
    }

    public function down()
    {
        Schema::table('leaders', function (Blueprint $table) {
            $table->dropColumn(['category', 'section', 'email', 'phone']);
        });
    }
};

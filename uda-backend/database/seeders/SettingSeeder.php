<?php

namespace Database\Seeders;

use App\Models\Setting;
use Illuminate\Database\Seeder;

class SettingSeeder extends Seeder
{
    public function run(): void
    {
        $defaults = [
            'contact_phone' => '020 2020405',
            'contact_email' => 'hello@uda.ke',
            'contact_address' => 'Hustler Plaza, Ngong Road, Nairobi',
            'contact_hours' => 'Mon - Fri: 8:00 AM - 5:00 PM',

            'social_facebook' => 'TheUDAKenya',
            'social_twitter' => 'UDAKenya',
            'social_instagram' => 'theudakenya',
            'social_youtube' => '',

            'about_intro' => 'The United Democratic Alliance (UDA) is a Kenyan political party led by H.E Dr. William Samoei Ruto, President of the Republic of Kenya. It is the largest party in the Kenya Kwanza coalition government.',
            'about_vision' => 'An equitably empowered Kenyan society living in a peaceful and united country.',
            'about_mission' => 'To ensure a just and prosperous nation through good governance, nurturing the right political atmosphere for businesses and industries to thrive, development of human resource, and fostering political stability and the welfare of the people of Kenya.',
            'about_values' => 'The party is founded on the principles of good governance including equity, diversity, love, unity, freedom, justice, accountability, transparency and peace.',

            'livetv_title' => 'UDA TV',
            'livetv_url' => '',
            'livetv_note' => 'Live broadcasts are coming soon. Stay tuned.',
        ];

        foreach ($defaults as $key => $value) {
            Setting::firstOrCreate(['key' => $key], ['value' => $value]);
        }
    }
}

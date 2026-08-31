<?php

namespace Database\Seeders;

use App\Models\RadioStation;
use App\Models\TVStation;
use Illuminate\Database\Seeder;

class MediaStationSeeder extends Seeder
{
    public function run(): void
    {
        $tv = [
            ['Citizen TV', 'https://www.youtube.com/@citizentvkenya/live', 'Kenya\'s most watched TV station.'],
            ['NTV Kenya', 'https://www.youtube.com/@NTVKenya/live', 'Nation Media Group news and entertainment.'],
            ['KTN News', 'https://www.youtube.com/@KTNNewsKenya/live', 'Standard Group 24-hour news channel.'],
            ['KTN Home', 'https://www.youtube.com/@ktnhomekenya/live', 'Standard Group general entertainment.'],
            ['K24 TV', 'https://www.youtube.com/@K24TV/live', 'Mediamax news and lifestyle.'],
            ['KBC Channel 1', 'https://www.youtube.com/@kbcchannel1/live', 'Kenya Broadcasting Corporation.'],
            ['TV47', 'https://www.youtube.com/@tv47ke/live', 'Cape Media news and entertainment.'],
            ['Inooro TV', 'https://www.youtube.com/@InooroTV/live', 'Royal Media Kikuyu-language station.'],
            ['Ramogi TV', 'https://www.youtube.com/@RamogiTV/live', 'Royal Media Dholuo-language station.'],
        ];

        $radio = [
            ['Radio Citizen', '106.7 FM', 'https://www.youtube.com/@radiocitizen/live', 'Royal Media Kiswahili radio.'],
            ['Radio Jambo', '97.5 FM', 'https://www.youtube.com/@radiojambo/live', 'Radio Africa Kiswahili radio.'],
            ['Kiss FM', '100.3 FM', 'https://www.youtube.com/@KissFmKe/live', 'Radio Africa English-language hits.'],
            ['Classic 105', '105.2 FM', 'https://www.youtube.com/@Classic105Ke/live', 'Radio Africa classic hits.'],
            ['Milele FM', '103.4 FM', 'https://www.youtube.com/@milelefmkenya/live', 'Mediamax Kiswahili radio.'],
            ['Radio Maisha', '104.7 FM', 'https://www.youtube.com/@RadioMaisha/live', 'Standard Group Kiswahili radio.'],
            ['KBC Radio Taifa', '89.1 FM', 'https://www.youtube.com/@kbcchannel1/live', 'Kenya Broadcasting Corporation national service.'],
            ['Ramogi FM', '107.1 FM', 'https://www.youtube.com/@RamogiFM/live', 'Royal Media Dholuo-language radio.'],
            ['Inooro FM', '95.5 FM', 'https://www.youtube.com/@InooroFM/live', 'Royal Media Kikuyu-language radio.'],
        ];

        foreach ($tv as [$name, $url, $desc]) {
            TVStation::updateOrCreate(['name' => $name], ['stream_url' => $url, 'description' => $desc]);
        }
        foreach ($radio as [$name, $freq, $url, $desc]) {
            RadioStation::updateOrCreate(
                ['name' => $name],
                ['frequency' => $freq, 'stream_url' => $url, 'description' => $desc],
            );
        }
    }
}

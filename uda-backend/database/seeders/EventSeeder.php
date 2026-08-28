<?php

namespace Database\Seeders;

use App\Models\Event;
use Illuminate\Database\Seeder;

class EventSeeder extends Seeder
{
    public function run(): void
    {
        $events = [
            [
                'title' => 'UDA Grassroots Elections 2024',
                'description' => 'Grassroots elections for all UDA party positions across the country. Members will elect their leaders at the ward level.',
                'location' => 'Nationwide',
                'category' => 'Election',
                'start_time' => 'April 15, 2024 08:00',
                'end_time' => 'April 15, 2024 17:00',
                'image_path' => 'assets/images/events images/grassroots_election.png',
            ],
            [
                'title' => 'Rurii Ward By-Election',
                'description' => 'By-election for the Rurii Ward Member of County Assembly position. All registered voters in Rurii Ward are encouraged to participate.',
                'location' => 'Rurii Ward, Nyandarua County',
                'category' => 'Election',
                'start_time' => 'September 20, 2024 06:00',
                'end_time' => 'September 20, 2024 17:00',
                'image_path' => 'assets/images/events images/rurii_byelection.png',
            ],
            [
                'title' => 'UDA National Delegates Convention 2024',
                'description' => 'Annual National Delegates Convention to review party progress, elect new leadership, and plan for the future of the party.',
                'location' => 'Nairobi',
                'category' => 'Convention',
                'start_time' => 'October 10, 2024 09:00',
                'end_time' => 'October 10, 2024 18:00',
                'image_path' => 'assets/images/events images/Training.png',
            ],
            [
                'title' => 'UDA Youth Summit 2026',
                'description' => 'Empowering the youth through political participation and leadership development. Open to all youth aged 18-35.',
                'location' => 'Nairobi',
                'category' => 'Summit',
                'start_time' => 'October 10, 2026 10:00',
                'end_time' => 'October 10, 2026 16:00',
                'image_path' => 'assets/images/events images/sensitization.png',
            ],
            [
                'title' => 'UDA Women League Conference',
                'description' => 'Conference focusing on women empowerment, economic development, and political participation for women in UDA.',
                'location' => 'Mombasa',
                'category' => 'Conference',
                'start_time' => 'November 5, 2024 08:30',
                'end_time' => 'November 5, 2024 17:30',
                'image_path' => 'assets/images/events images/Kabuchai by-election.png',
            ],
            [
                'title' => 'UDA Fundraising Gala 2024',
                'description' => 'Annual fundraising gala to support party activities and programs. All members and well-wishers are invited to attend.',
                'location' => 'Nairobi',
                'category' => 'Fundraising',
                'start_time' => 'December 1, 2024 18:00',
                'end_time' => 'December 1, 2024 22:00',
                'image_path' => 'assets/images/events images/rurii_byelection.png',
            ],
        ];

        foreach ($events as $event) {
            Event::updateOrCreate(['title' => $event['title']], $event);
        }
    }
}

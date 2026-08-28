<?php

namespace Database\Seeders;

use App\Models\News;
use Illuminate\Database\Seeder;

class NewsSeeder extends Seeder
{
    public function run(): void
    {
        $items = [
            [
                'title' => 'UDA Secretary General, Sen. Hassan Omar Hassan paid a courtesy call to the Embassy of the Republic of Kenya in Juba, South Sudan',
                'published_at' => 'July 23, 2026',
                'image_path' => 'assets/images/news images/pic6.PNG',
                'content' => 'Sen. Hassan Omar Hassan visited the Kenyan Embassy in Juba to strengthen diplomatic ties and discuss future cooperation with South Sudanese leadership.',
            ],
            [
                'title' => "UDA Party Leader, President William Ruto presided over the party's National Executive Committee (NEC) meeting",
                'published_at' => 'January 14, 2026',
                'image_path' => 'assets/images/news images/15.PNG',
                'content' => 'President Ruto led the NEC meeting to review UDA strategic priorities and reinforce party cohesion ahead of upcoming political engagements.',
            ],
            [
                'title' => "UDA establish '2027 Aspirants Forum'",
                'published_at' => 'January 21, 2026',
                'image_path' => 'assets/images/news images/19.PNG',
                'content' => 'UDA announced a new 2027 Aspirants Forum to support, mentor, and organize potential candidates across the country.',
            ],
            [
                'title' => 'UDA Grassroots Sensitization Training in Kiambu County',
                'published_at' => 'December 15, 2025',
                'image_path' => 'assets/images/news images/17.PNG',
                'content' => 'The party hosted a training session in Kiambu County focused on grassroots engagement and voter education for local communities.',
            ],
            [
                'title' => 'UDA Grassroots Sensitization Training in Uasin Gishu county',
                'published_at' => 'December 17, 2025',
                'image_path' => 'assets/images/news images/pic10.PNG',
                'content' => 'UDA continued its grassroots outreach with training in Uasin Gishu, empowering volunteers with civic education and mobilization tools.',
            ],
            [
                'title' => 'Hassan Omar Leads Delegation in Courtesy Call on South Sudan President Salva Kiir',
                'published_at' => 'July 21, 2026',
                'image_path' => 'assets/images/news images/pic9.PNG',
                'content' => 'A delegation led by Hassan Omar met South Sudan President Salva Kiir to discuss bilateral cooperation and regional stability.',
            ],
        ];

        foreach ($items as $item) {
            News::updateOrCreate(['title' => $item['title']], $item);
        }
    }
}

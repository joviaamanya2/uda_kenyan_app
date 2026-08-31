<?php

namespace Database\Seeders;

use App\Models\Location;
use Illuminate\Database\Seeder;

class LocationSeeder extends Seeder
{
    public function run(): void
    {
        $offices = [
            ['UDA National Headquarters', 'Hustler Plaza, Ngong Road, Nairobi', -1.30326, 36.78620],
            ['UDA Nairobi County Office', 'Nairobi CBD, Nairobi', -1.28333, 36.81667],
            ['UDA Mombasa County Office', 'Moi Avenue, Mombasa', -4.04350, 39.66820],
            ['UDA Kisumu County Office', 'Oginga Odinga Street, Kisumu', -0.09170, 34.76800],
            ['UDA Nakuru County Office', 'Kenyatta Avenue, Nakuru', -0.30310, 36.08000],
            ['UDA Eldoret (Uasin Gishu) Office', 'Uganda Road, Eldoret', 0.51430, 35.26980],
            ['UDA Nyeri County Office', 'Kimathi Way, Nyeri', -0.42010, 36.94760],
            ['UDA Embu County Office', 'Kenyatta Highway, Embu', -0.53100, 37.45040],
            ['UDA Meru County Office', 'Njuri Ncheke Street, Meru', 0.04720, 37.65560],
            ['UDA Kakamega County Office', 'Kakamega Town, Kakamega', 0.28270, 34.75190],
            ['UDA Kericho County Office', 'Kericho Town, Kericho', -0.36760, 35.28310],
            ['UDA Kiambu County Office', 'Biashara Street, Thika', -1.03330, 37.06930],
            ['UDA Machakos County Office', 'Machakos Town, Machakos', -1.51770, 37.26340],
            ['UDA Garissa County Office', 'Garissa Town, Garissa', -0.45690, 39.66410],
            ['UDA Kisii County Office', 'Kisii Town, Kisii', -0.68170, 34.76710],
            ['UDA Bungoma County Office', 'Bungoma Town, Bungoma', 0.56350, 34.56060],
            ['UDA Kitui County Office', 'Kitui Town, Kitui', -1.36670, 38.01060],
            ['UDA Kajiado County Office', 'Kajiado Town, Kajiado', -1.85200, 36.77680],
        ];

        foreach ($offices as [$name, $address, $lat, $lng]) {
            Location::updateOrCreate(
                ['name' => $name],
                ['address' => $address, 'latitude' => $lat, 'longitude' => $lng],
            );
        }
    }
}

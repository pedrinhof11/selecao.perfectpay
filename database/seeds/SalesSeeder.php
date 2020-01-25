<?php

use Illuminate\Database\Seeder;

class SalesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(App\Models\Customer::class, 4)->create();
        factory(App\Models\Product::class, 10)->create();

    }
}

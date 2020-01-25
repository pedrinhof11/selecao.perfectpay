<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Carbon;

class Sale extends Model
{
    protected $fillable = [
        'product_id',
        'customer_id',
        'quantity',
        'discount',
        'sale_amount',
        'status'
    ];

    protected $appends = ['date'];

    public function getDateAttribute() {
        $date = Carbon::createFromFormat('Y-m-d H:i:s', $this->attributes['created_at']);
        return $date->format('d/m/Y');
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

}

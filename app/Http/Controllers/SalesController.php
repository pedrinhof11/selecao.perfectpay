<?php

namespace App\Http\Controllers;

use App\Models\Sale;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SalesController extends Controller
{

    public function index()
    {
        return view('sales.index');
    }

//    public function edit($id)
//    {
//        $sale = Sale::with('customer')->find($id);
//        return view('sales.edit', compact('sale'));
//    }

    public function show($id)
    {
        $sale = Sale::with('customer')->find($id);
        return response($sale);
    }

    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'product_id' => ['required'],
            'customer_id' => ['required'],
            'quantity' => ['required', 'min:1', 'integer'],
            'discount' => ['required', 'min:0', 'max: 100', 'numeric'],
            'sale_amount' => ['required', 'numeric'],
            'status' => ['required']
        ]);

        $data = $request->all();

        $sale = Sale::find($id);
        $sale->fill($data);
        $sale->save();

        if($request->ajax())
            return response($sale);

        return redirect()->route('index')
            ->with('status-success', 'Venda atualizada com sucesso!');

    }

    public function salesList(Request $request)
    {
        $salesQuery = Sale::with('product');

        $this->searchSalesQueryRequest($salesQuery, $request);

        $sales = $salesQuery->get();
        return response($sales);
    }

    public function salesResultList(Request $request)
    {
        $salesQuery = DB::table('sales')
            ->selectRaw('status, sum(quantity) quantity, sum(quantity) quantity, sum(sale_amount) total_amount');

        $this->searchSalesQueryRequest($salesQuery, $request);

        $sales = $salesQuery
            ->groupBy('status')
            ->get();
        return response($sales);
    }

    private function searchSalesQueryRequest($salesQuery, $request)
    {
        if ($request->has('customer_id')) {
            $customer_id = $request->get('customer_id');
            $salesQuery->where('customer_id', $customer_id);
        }

        if ($request->has('period')) {
            $period = $request->get('period');
            $salesQuery->whereBetween('created_at', [$period." 00:00:00",$period." 23:59:59"]);
        }

        return $salesQuery;
    }

}

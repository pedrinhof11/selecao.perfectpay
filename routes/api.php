<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/customers', 'CustomersController@index');
Route::get('/products', 'ProductsController@index');
Route::get('/sales', 'SalesController@salesList');
Route::get('/sales/result', 'SalesController@salesResultList');
Route::get('/sales/{id}', 'SalesController@show');
Route::put('/sales/{id}', 'SalesController@update');

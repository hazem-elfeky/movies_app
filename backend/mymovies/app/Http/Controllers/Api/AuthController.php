<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use App\Http\Resources\UserResource;
use Illuminate\Support\Facades\Response;
class AuthController extends Controller
{
   
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email'    => 'required|email',
            'password' => 'required',
        ]);

        if ($validator->fails()) {
            return Response::api([], 1, $validator->errors()->first());
        }

        $credentials = $request->only(['email', 'password']);

        if (Auth::attempt($credentials)) {
            $user = Auth::user();

            $data['user']  = new UserResource($user);
            $data['token'] = $user->createToken('MyAppToken')->plainTextToken;

            return Response::api($data, 0, 'Login successful');
        }

        return Response::api([], 1, 'Authentication failed');
    }


    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name'     => 'required|string',
            'email'    => 'required|email|unique:users',
            'password' => 'required|min:6',
        ]);

        if ($validator->fails()) {
            return Response::api([], 1, $validator->errors()->first());
        }

        $request->merge([
            'password' => bcrypt($request->password),
            'type'     => 'user',
        ]);

        $user = User::create($request->all());

        $data['user']  = new UserResource($user);
        $data['token'] = $user->createToken('MyAppToken')->plainTextToken;

        return Response::api($data, 0, 'User registered successfully');
    }

    
    public function user()
    {
        $user = Auth::user();

        if (!$user) {
            return Response::api([], 1, 'User not authenticated');
        }

        $data['user'] = new UserResource($user);

        return Response::api($data, 0, 'User data retrieved');
    }
}
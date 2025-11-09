<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Role; 
use Illuminate\Support\Facades\Validator;


class RoleController extends Controller
{
   
    public function index()
    {
        $roles = Role::all();
        return view('admin.roles.index', compact('roles'));
    }

    
    public function create()
    {
        return view('admin.roles.create');
    }


    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:roles,name|max:50',
            'display_name' => 'required|max:50',
            'description' => 'nullable|max:255',
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }

        Role::create($request->all());

        return redirect()->route('admin.roles.index')->with('success', 'Role created successfully.');
    }


    public function edit($id)
    {
        $role = Role::findOrFail($id);
        return view('admin.roles.edit', compact('role'));
    }

 
    public function update(Request $request, $id)
    {
        $role = Role::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'name' => 'required|unique:roles,name,'.$id.'|max:50',
            'display_name' => 'required|max:50',
            'description' => 'nullable|max:255',
        ]);

        if ($validator->fails()) {
            return redirect()->back()->withErrors($validator)->withInput();
        }

        $role->update($request->all());

        return redirect()->route('admin.roles.index')->with('success', 'Role updated successfully.');
    }

    
    public function destroy($id)
    {
        $role = Role::findOrFail($id);
        $role->delete();

        return redirect()->route('admin.roles.index')->with('success', 'Role deleted successfully.');
    }
}
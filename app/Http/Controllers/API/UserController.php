<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Illuminate\Support\Facades\Auth;
use Validator;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{
	public $successStatus = 200;
	/** 
	 * login api 
	 * 
	 * @return \Illuminate\Http\Response 
	 */
	public function login()
	{
		if (Auth::attempt(['email' => request('email'), 'password' => request('password')])) {
			$user = Auth::user();
			$success['token'] =  $user->createToken('MyApp')->accessToken;
			$success['user_type'] = $user->user_type;
			return response()->json(['success' => $success], $this->successStatus);
		} else {
			return response()->json(['error' => 'Unauthorised'], 401);
		}
	}
	/** 
	 * Register api 
	 * 
	 * @return \Illuminate\Http\Response 
	 */
	public function register(Request $request)
	{
		$validator = Validator::make($request->all(), [
			'name' => 'required',
			'email' => 'required|email',
			'password' => 'required',
			'c_password' => 'required|same:password',
			'user_type' => 'required',
		]);
		if ($validator->fails()) {
			return response()->json(['error' => $validator->errors()], 401);
		}
		$input = $request->all();
		$input['password'] = bcrypt($input['password']);
		$user = DB::table('users')->where('email', $input['email'])->first();
		if (empty($user)) {
			$user = User::create($input);
			$success['token'] =  $user->createToken('MyApp')->accessToken;
			$success['name'] =  $user->name;
			$success['user_type'] =  $user->user_type;
			return response()->json(['success' => $success], $this->successStatus);
		} else {
			return response()->json(['error' => 'Email alredy registered'], 401);
		}
	}
	/** 
	 * details api 
	 * 
	 * @return \Illuminate\Http\Response 
	 */
	public function details()
	{
        $user = Auth::user();
        if($user["user_type"] == "school"){
            $details = Auth::user();
            $schoolprofile = DB::table('schoolprofile')->where('user_id', $user['id'])->first();
            $details["schoolProfile"] = $schoolprofile;
            return response()->json(['success' => $details], $this->successStatus);
        }
        if($user["user_type"] == "student"){
            $details = Auth::user();
            $studentprofile = DB::table('studentprofile')->where('user_id', $user['id'])->first();
            $details["studentprofile"] = $studentprofile;
            return response()->json(['success' => $details], $this->successStatus);
        }
	}

	/** 
	 * registerSchool api 
	 * 
	 * @return \Illuminate\Http\Response 
	 */

	public function registerSchool(Request $request)
	{
		$authUser = Auth::user();
		if (!empty($authUser) && $authUser['user_type'] == 'school') {
			$validator = Validator::make($request->all(), [
				'name' => 'required',
				'email' => 'required|email',
				'about' => 'required',
				'phone' => 'required',
				'add_line1' => 'required',
				'scholarship' => 'required',
				'fee_structure' => 'required',
				'course_detail' => 'required',
				'rating' => 'required',
			]);
			if ($validator->fails()) {
				return response()->json(['error' => $validator->errors()], 401);
			}
			$input = $request->all();
			$user = DB::table('schoolprofile')->where('name', $input['name'])->first();
			if (empty($user)) {
				$input['user_id'] = $authUser['id'];
				$schoolprofile = DB::table('schoolprofile')->insert($input);
				return response()->json(['success' => $schoolprofile], $this->successStatus);
			} else {
				return response()->json(['error' => 'School alredy registered'], 401);
			}
		} else {
			return response()->json(['error' => 'No Authorized'], 401);
		}
	}
	public function updateSchool(Request $request)
	{
		$input = $request->all();
		$schoolprofile = DB::table('schoolprofile')->where('id', $input['id'])->update($input);
		return response()->json(['success' => $schoolprofile], $this->successStatus);
	}
	public function getSchool(Request $request)
	{

		$input = $request->all();
		$orderbyFieldName = 'schoolprofile.id';
		$whereField = 'schoolprofile.id';
		$whereFieldValue = '0';
		$operator = '>';
		if (!empty($input)) {
			if (!empty($input['sort'])  && $input['sort'] == 'rating') {
				$orderbyFieldName = 'schoolprofile.rating';
			} else if (!empty($input['sort'])  &&  $input['sort'] == 'relevance') {
				$orderbyFieldName = 'schoolprofile.name';
			} else if (!empty($input['sort'])  &&  $input['sort'] == 'popularity') {
				$orderbyFieldName = 'schoolprofile.popularity';
			}
			if (!empty($input['name'])) {
				$whereField = 'schoolprofile.name';
				$whereFieldValue = $input['name'] . '%';;
				$operator = 'like';
			}
			if (!empty($input['location'])) {
				$whereField = 'schoolprofile.add_line1';
				$whereFieldValue = $input['location'] . '%';;
				$operator = 'like';
			}
		}
		$orderbyValue = 'DESC';
		$schoolList =
			DB::table('schoolprofile')
			->join('users', 'users.id', '=', 'schoolprofile.user_id')
			->select('users.name', 'users.user_type', 'schoolprofile.id', 'schoolprofile.admission_status', 'schoolprofile.name', 'schoolprofile.about', 'schoolprofile.email', 'schoolprofile.phone', 'schoolprofile.admission', 'schoolprofile.add_line1', 'schoolprofile.add_line2', 'schoolprofile.area_code', 'schoolprofile.user_id', 'schoolprofile.scholarship', 'schoolprofile.fee_structure', 'schoolprofile.course_detail', 'schoolprofile.rating','schoolprofile.profile_image','schoolprofile.banner')
			->where($whereField, $operator, $whereFieldValue)
			->orderBy($orderbyFieldName, $orderbyValue)
			->get();
		if (!empty($schoolList)) 
		{
			return response()->json(['success' => $schoolList], $this->successStatus);
		} 
		else 
		{
			return response()->json(['error' => 'No listing found'], 401);
		}
	}


	public function schollSaveByStudent(Request $request)
	{
		$user = Auth::user();
		if (!empty($user) && $user['user_type'] == 'student') {
			$validator = Validator::make($request->all(), [
				'schoolprofile_id' => 'required',
			]);
			if ($validator->fails()) {
				return response()->json(['error' => $validator->errors()], 401);
			}
			$input = $request->all();
			$schollIds = DB::table('studentprofile_saved_school')->where('schoolprofile_id', $input['schoolprofile_id'])->first();
			if (empty($schollIds)) {
				$input['studentprofile_id'] = $user['id'];
				$schoolprofile = DB::table('studentprofile_saved_school')->insert($input);
				return response()->json(['success' => $schoolprofile], $this->successStatus);
			} else {
				return response()->json(['error' => 'School alredy saved'], 401);
			}
		} else {
			return response()->json(['error' => 'No Authorized'], 401);
		}
	}

	public function schoolDetail($id, Request $request)
	{
		$user = Auth::user();
		$input = $request->all();
		$schoolprofile = DB::table('schoolprofile')->where('id', $id)->first();
		if (!empty($schoolprofile)) 
		{
			$school_images = DB::table('school_images')->where('id', $id)->get();
			$schoolprofile->otherImages = $school_images;
			return response()->json(['success' => $schoolprofile], $this->successStatus);
		} else {
			return response()->json(['error' => 'School not found'], 401);
		}
	}


	public function getSchoolSavedByStudent(Request $request)
	{
		$user = Auth::user();
		if (!empty($user) && $user['user_type'] == 'student') {
			$input = $request->all();
			$orderbyFieldName = 'schoolprofile.id';
			if (!empty($input)) {
				if ($input['sort'] == 'rating') {
					$orderbyFieldName = 'schoolprofile.rating';
				} else if ($input['sort'] == 'relevance') {
					$orderbyFieldName = 'schoolprofile.name';
				} else if ($input['sort'] == 'popularity') {
					$orderbyFieldName = 'schoolprofile.popularity';
				}
			}

			$orderbyValue = 'DESC';
			$schoolList =
				DB::table('studentprofile_saved_school')
				->join('users', 'users.id', '=', 'studentprofile_saved_school.studentprofile_id')
				->join('schoolprofile', 'schoolprofile.id', '=', 'studentprofile_saved_school.schoolprofile_id')
				->select('users.name', 'users.user_type', 'schoolprofile.id', 'schoolprofile.name', 'schoolprofile.about', 'schoolprofile.email', 'schoolprofile.phone', 'schoolprofile.admission', 'schoolprofile.add_line1', 'schoolprofile.add_line2', 'schoolprofile.area_code', 'schoolprofile.user_id', 'schoolprofile.scholarship', 'schoolprofile.fee_structure', 'schoolprofile.course_detail', 'schoolprofile.rating','schoolprofile.profile_image','schoolprofile.banner')
				->orderBy($orderbyFieldName, $orderbyValue)
				->get();
			if (!empty($schoolList)) {
				return response()->json(['success' => $schoolList], $this->successStatus);
			} else {
				return response()->json(['error' => 'No listing found'], 401);
			}
		} else {
			return response()->json(['error' => 'No Authorized'], 401);
		}
	}

	public function createEnquiry(Request $request)
	{
		$validator = Validator::make($request->all(), [
			'user_id' => 'required',
			'schoolprofile_id' => 'required',
			'age' => 'required',
			'course' => 'required',
			'phone' => 'required'
		]);
		if ($validator->fails()) {
			return response()->json(['error' => $validator->errors()], 401);
		}
		$input = $request->all();
		$student = DB::table('studentprofile')->where('user_id', $input['user_id'])->first();
		if (empty($student)) {
			$profile_data["phone"] = $input['phone'];
			$profile_data["user_id"] = $input['user_id'];
			$profile_data["admission"] = "pending";
			$profile_data["created_date"] = date("Y-m-d");
			$profile_data["updated_date"] = date("Y-m-d");
			$student = DB::table('studentprofile')->insert($profile_data);
		}
		$school = DB::table('schoolprofile')->where('id', $input['schoolprofile_id'])->first();
		if (empty($school)) {
			return response()->json(['error' => 'School is not registered'], 401);
		}
		$input["application_status"] = "pending";
		$admission_enquiry = DB::table('admission_enquiry')->insert($input);
		return response()->json(['success' => $admission_enquiry], $this->successStatus);
	}

	public function getEnquiry(Request $request)
	{
		$orderbyValue = 'DESC';
		$schoolprofile_id = $request->get('schoolprofile_id', null);
		$user_id = $request->get('user_id', null);

		if ($schoolprofile_id != null) {	
			$enqList = DB::table('admission_enquiry')
				->join('users', 'users.id', '=', 'admission_enquiry.user_id')
				->select('admission_enquiry.id', 'users.name', 'users.email', 'admission_enquiry.phone', 'admission_enquiry.age', 'admission_enquiry.course', 'admission_enquiry.application_status', 'admission_enquiry.created_date')
				->where('schoolprofile_id', $schoolprofile_id)
				->get();
			return response()->json(['success' => $enqList], $this->successStatus);
		}
		if ($user_id != null) {	
			$enqList = DB::table('admission_enquiry')
				->join('users', 'users.id', '=', 'admission_enquiry.user_id')
                ->join('schoolprofile', 'schoolprofile.id', '=', 'admission_enquiry.schoolprofile_id')
				->select('admission_enquiry.id', 'users.name', 'users.email', 'admission_enquiry.phone', 'admission_enquiry.age', 'admission_enquiry.course', 'admission_enquiry.application_status', 'admission_enquiry.created_date', 'schoolprofile.name', 'schoolprofile.email', 'schoolprofile.phone', 'schoolprofile.admission', 'schoolprofile.add_line1', 'schoolprofile.fee_structure', 'schoolprofile.rating', 'schoolprofile.admission_status', 'schoolprofile.popularity')
				->where('admission_enquiry.user_id', $user_id)
				->get();
			return response()->json(['success' => $enqList], $this->successStatus);
		}
		return response()->json(['error' => 'Please check the request params'], 401);
    }
    
    public function updateEnquiryStatus($id, Request $request)
    {
        $validator = Validator::make($request->all(), [
			'application_status' => 'required',
		]);
		if ($validator->fails()) {
			return response()->json(['error' => $validator->errors()], 401);
		}
		$input = $request->all();
        $admission_enquiry = DB::table('admission_enquiry')->where('id', $id)->update($input);
        if(!empty($admission_enquiry)){
            return response()->json(['success' => $admission_enquiry], $this->successStatus);
        }
        return response()->json(['error' => 'Please check the request params'], 401);
	}
	
	public function schoolImages()
	{
		//print(request()->school_id);exit;
		if(!empty(request()->id) && !empty(request()->image))
		{
			$id = request()->id;
			$type = request()->type;
			$urlPath =  url('/').'/images/';
			request()->validate([
				'image' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
			]);
			$imageName = time().'.'.request()->image->getClientOriginalExtension();
			if(request()->image->move(public_path('images'), $imageName))
			{
			   if($type=='user_profile')
				{
					DB::table('users')
					->where('id', $id)  // find your user by their email
					->limit(1)  // optional - to ensure only one record is updated.
					->update(array($type => $imageName)); 
					return response()->json(['success' => 'You have successfully upload image.','image_path'=>$urlPath.$imageName], 200);
			   }
			   else if($type=='profile_image' || $type=='banner')
			   {
					DB::table('schoolprofile')
					->where('id', $id)  // find your user by their email
					->limit(1)  // optional - to ensure only one record is updated.
					->update(array($type => $imageName)); 
					return response()->json(['success' => 'You have successfully upload image.','image_path'=>$urlPath.$imageName], 200);
			   }
			   else if($type=='other1' || $type=='other2' || $type=='other3' || $type=='other4' || $type=='other5')
			   {
					$school_images = DB::table('school_images')->where(
						array(
							'schoolprofile_id' => $id,
							'type' => $type,
							)
						)
					->first();
					$imgArr = array();
					$imgArr["image"] = $imageName;
					$imgArr["schoolprofile_id"] = $id;
					$imgArr["type"] = $type;
					if(!empty($school_images))
					{
						DB::table('school_images')
						->where('id', $id)  // find your user by their email
						->limit(1)  // optional - to ensure only one record is updated.
						->update(array('image' => $imageName)); 
						return response()->json(['success' => 'You have successfully upload image.','image_path'=>$urlPath.$imageName], 200);
					}
					else
					{
						$admission_enquiry = DB::table('school_images')->insert($imgArr);
						return response()->json(['success' => 'You have successfully upload image.','image_path'=>$urlPath.$imageName], 200);
					}
			   }
			}
			else
			{
				return response()->json(['error' => 'Please check the request params'], 401);
			}
		}
		else
		{
			return response()->json(['error' => 'Please check the request params'], 401);
		}
	} 


 function changePassword(Request $request) 
	{
		
		$user = Auth::user();
		//print_r($user);exit;
		$data = $request->all();
		//Changing the password only if is different of null
		if( isset($data['oldPassword']) && !empty($data['oldPassword']) && $data['oldPassword'] !== "" && $data['oldPassword'] !=='undefined') {
			//checking the old password first
			//echo 'hi ';exit;
			$check  = Auth::guard('web')->attempt([
				'email' => $user->email,
				'password' => $data['oldPassword']
			]);
			if($check && isset($data['newPassword']) && !empty($data['newPassword']) && $data['newPassword'] !== "" && $data['newPassword'] !=='undefined') {
				$user->password = bcrypt($data['newPassword']);
				
				//$user->isFirstTime = false; //variable created by me to know if is the dummy password or generated by user.
				$user->token()->revoke();
				$token = $user->createToken('MyApp')->accessToken;
				//Changing the type
				$user->save();
				return json_encode(array('token' => $token)); //sending the new token
			}
			else {
				return "Wrong password information";
			}
		}
		return "Wrong password information";
	}

}

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
		return response()->json(['success' => $user], $this->successStatus);
		//$input = $request->all(); 
		//$user = DB::table('users')->where('email', $input['email'])->get();
		//return response()->json(['success' => $user], $this-> successStatus); 
	}

	/** 
	 * registerSchool api 
	 * 
	 * @return \Illuminate\Http\Response 
	 */

	public function registerSchool(Request $request)
	{
		$user = Auth::user();
		if (!empty($user) && $user['user_type'] == 'school') {
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
				/*print_r($user);
                                        print_r($input);
					$input['user_id'] = $user['id'];*/
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
			->select('users.name', 'users.user_type', 'schoolprofile.id', 'schoolprofile.admission_status', 'schoolprofile.name', 'schoolprofile.about', 'schoolprofile.email', 'schoolprofile.phone', 'schoolprofile.admission', 'schoolprofile.add_line1', 'schoolprofile.add_line2', 'schoolprofile.area_code', 'schoolprofile.user_id', 'schoolprofile.scholarship', 'schoolprofile.fee_structure', 'schoolprofile.course_detail', 'schoolprofile.rating')
			->where($whereField, $operator, $whereFieldValue)
			->orderBy($orderbyFieldName, $orderbyValue)
			->get();
		if (!empty($schoolList)) {
			return response()->json(['success' => $schoolList], $this->successStatus);
		} else {
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

	public function schoolDetail(Request $request)
	{
		$user = Auth::user();
		//if(!empty($user))
		//{
		$input = $request->all();
		$validator = Validator::make($request->all(), [
			'id' => 'required',
		]);
		if ($validator->fails()) {
			return response()->json(['error' => $validator->errors()], 401);
		}
		$schoolprofile = DB::table('schoolprofile')->where('id', $input['id'])->first();
		if (!empty($schoolprofile)) {
			return response()->json(['success' => $schoolprofile], $this->successStatus);
		} else {
			return response()->json(['error' => 'School not found'], 401);
		}
		/*}
		else
		{
			return response()->json(['error'=>'No Authorized'], 401);
		} 
			*/
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
				->select('users.name', 'users.user_type', 'schoolprofile.id', 'schoolprofile.name', 'schoolprofile.about', 'schoolprofile.email', 'schoolprofile.phone', 'schoolprofile.admission', 'schoolprofile.add_line1', 'schoolprofile.add_line2', 'schoolprofile.area_code', 'schoolprofile.user_id', 'schoolprofile.scholarship', 'schoolprofile.fee_structure', 'schoolprofile.course_detail', 'schoolprofile.rating')
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
			'admission_status' => 'required',
		]);
		if ($validator->fails()) {
			return response()->json(['error' => $validator->errors()], 401);
		}
		$input = $request->all();
        $admission_enquiry = DB::table('admission_enquiry')->where('id', $id)->update($input)
        if(!empty($admission_enquiry){
            return response()->json(['success' => $admission_enquiry], $this->successStatus);
        }
        return response()->json(['error' => 'Please check the request params'], 401);
    }
}

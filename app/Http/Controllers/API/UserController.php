<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\User;
use Illuminate\Support\Facades\Auth;
use Validator;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;

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
                        $success['is_block'] = $user->is_block==0?"Un Block":"Block";
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
        
        public function forgotpassword(Request $request){
            $output =  array();
            $data = $request->all();
		if( isset($data['email']) && !empty($data['email']) && $data['email'] !== "" && $data['email'] !=='undefined') {
                    $email = $data['email'];
                        $get_email  = DB::table('users as u')->select('u.*')->where('u.email', '=', $email)->get();
                        if(count($get_email) > 0){
                            $radomsting = Str::random(8);
                            $newpass = Hash::make($radomsting); //md5($radomsting); 
                            $updatepass  = array();
                            $updatepass['password'] =  $newpass;
                            $isUpdate = User::where('email',$email)->update($updatepass);
                            $subject = "Forgot password";
                            $message = "your new password is: ".$radomsting; 
                          
                          $headers = 'From: System  rohitkagathara.it@gmail.com' . "\r\n" .
                            'Reply-To:  rohitkagathara.it@gmail.com' . "\r\n" .
                            'Content-Type: text/html; charset=ISO-8859-1'."\r\n".
                            'Content-type:text/html;charset=UTF-8' . "\r\n".
                            'X-Mailer: PHP/' . phpversion();
                          mail($email, $subject, $message, $headers);
                            $output['success'] = '1'; 
                          }else{
                             $output['success'] = '0';        
                          }
            if($output['success']==1){
                $output = 'A new password has been sent to your e-mail address. Check your inbox';
            }else{
                $output = 'Email not found';
            }
		}else{
            $output = 'Email not found';
        }
            
        return json_encode($output);
  }
  
    public function allstudentlist(Request $request){
        
        $data = $request->all();
        if( isset($data['page']) && !empty($data['page']) && $data['page'] !== "" && $data['page'] !=='undefined') {
            $page = $data['page']; 
        }else{
            $page = 1;
        }    
        
        $limitpage = 10;
        $end_page = $page * $limitpage;
        $offset = $end_page - $limitpage;
        $limit = $limitpage; 
        $output = $response = $student_list =  array();
        
        $get_count = DB::table('users as u')              
            ->select('u.*')
            ->where('u.user_type','student')
            ->get(); 
        $total_recourd = count($get_count);
        $total_page = $total_recourd / $limitpage;
        
        $get_students = DB::table('users as u')              
            ->select('u.*')
//            ->leftJoin('schoolprofile as sp', 'sp.user_id', '=', 'u.id')    
            ->where('u.user_type','student')
            ->offset($offset)
            ->limit($limit)    
            ->get();           

        if(count($get_students) > 0){
           foreach ($get_students as $key => $value) {
                $response[$key]['student_id'] = $value->id;
                $response[$key]['email'] = $value->email;
                $response[$key]['name'] = $value->name;
                $response[$key]['user_type'] = $value->user_type;
               $response[$key]['is_block'] = $value->is_block==0?"Un Block":"Block";
            }
            $student_list = $response;
        }
        $output['student_list'] = $student_list;
        $output['page_count'] = ceil($total_page); 
        return json_encode($output);
   }
   
   
    public function allschoollist(Request $request){
        
        $data = $request->all();
        if( isset($data['page']) && !empty($data['page']) && $data['page'] !== "" && $data['page'] !=='undefined') {
            $page = $data['page']; 
        }else{
            $page = 1;
        }
        $limitpage = 10;
        $end_page = $page * $limitpage;
        $offset = $end_page - $limitpage;
        $limit = $limitpage;
        $output = $response = $school_list =  array();
        
        $get_count = DB::table('users as u')              
            ->select('u.id','u.name','u.email','u.user_type','sp.name as school_name','sp.about','sp.email as school_email','sp.phone','sp.add_line1','sp.add_line2','sp.area_code','u.is_block') 
            ->leftJoin('schoolprofile as sp', 'sp.user_id', '=', 'u.id')     
            ->where('u.user_type','school')
            ->get(); 
        $total_recourd = count($get_count);
        $total_page = $total_recourd / $limitpage;
        
        
        
        $get_school = DB::table('users as u')              
            ->select('u.id','u.name', 'u.is_verify' , 'u.is_paid', 'u.email','u.user_type','sp.name as school_name','sp.about','sp.email as school_email','sp.phone','sp.add_line1','sp.add_line2','sp.area_code','u.is_block') 
            ->leftJoin('schoolprofile as sp', 'sp.user_id', '=', 'u.id')     
            ->where('u.user_type','school')
            ->offset($offset)
            ->limit($limit)    
            ->get();           

        if(count($get_school) > 0){
           foreach ($get_school as $key => $value) {
                $response[$key]['id'] = $value->id;
                $response[$key]['email'] = $value->email;
                $response[$key]['name'] = $value->name;
                $response[$key]['user_type'] = $value->user_type;
                $response[$key]['school_name'] = $value->school_name;
                $response[$key]['about'] = $value->about;
                $response[$key]['school_email'] = $value->school_email;
                $response[$key]['phone'] = $value->phone;
                $response[$key]['is_block'] = $value->is_block==0?"Un Block":"Block";
                $response[$key]['is_verify'] = $value->is_verify;
                $response[$key]['is_paid'] = $value->is_paid;
                //$response[$key]['add_line1'] = $value->add_line1;
                //$response[$key]['add_line2'] = $value->add_line2;
                //$response[$key]['area_code'] = $value->area_code;
            }
            $school_list = $response;
        }
        $output['school_list'] = $school_list;
        $output['page_count'] = ceil($total_page);             
        return json_encode($output);
   }

    public function allapplicationlist(Request $request){
        
        $data = $request->all();
        if( isset($data['page']) && !empty($data['page']) && $data['page'] !== "" && $data['page'] !=='undefined') {
            $page = $data['page']; 
        }else{
            $page = 1;
        }
        $limitpage = 10;
        $end_page = $page * $limitpage;
        $offset = $end_page - $limitpage;
        $limit = $limitpage;
        $output = $response = $admission_list =  array();
        
        $get_count = DB::table('users as u') 
            ->select('ae.id','ae.application_status','ae.course','ae.age','ae.phone','u.email','u.name','u.user_type')    
            ->leftJoin('admission_enquiry as ae', 'u.id', '=', 'ae.user_id')    
            ->where('u.user_type','student')
            ->get(); 
        $total_recourd = count($get_count);
        $total_page = $total_recourd / $limitpage;
        
        
        $get_admission = DB::table('users as u') 
            ->select('ae.id','ae.application_status','ae.course','ae.age','ae.phone','u.email','u.name','u.user_type','u.is_block')    
            ->leftJoin('admission_enquiry as ae', 'u.id', '=', 'ae.user_id')    
            ->where('u.user_type','student')
            ->offset($offset)
            ->limit($limit)    
            ->get();           

        if(count($get_admission) > 0){
           foreach ($get_admission as $key => $value) {
                $response[$key]['id'] = $value->id;
                $response[$key]['email'] = $value->email;
                $response[$key]['name'] = $value->name;
                $response[$key]['user_type'] = $value->user_type;
                $response[$key]['application_status'] = $value->application_status;
                $response[$key]['course'] = $value->course;
                $response[$key]['age'] = $value->age;
                $response[$key]['phone'] = $value->phone;
                $response[$key]['is_block'] = $value->is_block==0?"Un Block":"Block";
            }
            $admission_list = $response;
        }
        $output['admission_list'] = $admission_list;
        $output['page_count'] = ceil($total_page);              
        return json_encode($output);
   }

   public function update_user_status(Request $request){

       $data = $request->all();
       $output = array();
        if( isset($data['user_id']) && !empty($data['user_id']) && $data['user_id'] !== "" && $data['user_id'] !=='undefined') {
            $user_id = $data['user_id']; 
        }else{
            $user_id = ''; 
        }
        if( isset($data['is_block'])) {
            $is_block = $data['is_block']; 
        }else{
            $is_block = ''; 
        } 
        
        if($user_id !='' && $is_block !=''){
            $update_data['is_block'] = $is_block;
        $is_update = DB::table('users')              
            ->where('id', '=', $user_id)
            ->update($update_data);                    
        if($is_block == 0){
           $output = "Un block success.";
        }else{
          $output = "Block success.";  
        }
       }else{
         $output = "please enter your required fields.";  
       }
       return json_encode($output);          
   }
    
   
    public function update_student_profile(Request $request){

       $data = $request->all();
       $output = array();
        if( isset($data['user_id']) && !empty($data['user_id']) && $data['user_id'] !== "" && $data['user_id'] !=='undefined') {
            $user_id = $data['user_id']; 
        }else{
            $user_id = ''; 
        }
        if( isset($data['profile_name'])) {
            $profile_name = $data['profile_name']; 
        }else{
            $profile_name = ''; 
        }
        if( isset($data['mobile'])) {
            $mobile = $data['mobile']; 
        }else{
            $mobile = ''; 
        }
        if( isset($data['gender'])) {
            $gender = $data['gender']; 
        }else{
            $gender = ''; 
        }
        if($user_id !=''){
            $update_data= array();
            $update_data['profile_name']= $profile_name;
            $update_data['mobile']= $mobile;
            $update_data['gender']= $gender;
        $is_update = DB::table('studentprofile')              
            ->where('id', '=', $user_id)
            ->update($update_data);                    
           $output = "Update success.";
        }else{
          $output = "User not select.";  
        }
       return json_encode($output);          
   }
    
       
   public function update_payment_status(Request $request){

       $data = $request->all();
       $output = array();
        if( isset($data['user_id']) && !empty($data['user_id']) && $data['user_id'] !== "" && $data['user_id'] !=='undefined') {
            $user_id = $data['user_id']; 
        }else{
            $user_id = ''; 
        }
        if( isset($data['is_paid'])) {
            $is_paid = $data['is_paid']; 
        }else{
            $is_paid = ''; 
        } 
        
        if($user_id !='' && $is_paid !=''){
            $update_data['is_paid'] = $is_paid;
        $is_update = DB::table('users')              
            ->where('id', '=', $user_id)
            ->update($update_data);                    
        if($is_paid == 0){
           $output = "Un Paid.";
        }else{
          $output = "Paid.";  
        }
       }else{
         $output = "please enter your required fields.";  
       }
       return json_encode($output);          
   }
   
   
      public function update_verify_status(Request $request){

       $data = $request->all();
       $output = array();
        if( isset($data['user_id']) && !empty($data['user_id']) && $data['user_id'] !== "" && $data['user_id'] !=='undefined') {
            $user_id = $data['user_id']; 
        }else{
            $user_id = ''; 
        }
        if( isset($data['is_verify'])) {
            $is_verify = $data['is_verify']; 
        }else{
            $is_verify = ''; 
        } 
        
        if($user_id !='' && $is_verify !=''){
            $update_data['is_verify'] = $is_verify;
        $is_update = DB::table('users')              
            ->where('id', '=', $user_id)
            ->update($update_data);                    
        if($is_verify == 0){
           $output = "Not verify.";
        }else{
          $output = "Verify.";  
        }
       }else{
         $output = "please enter your required fields.";  
       }
       return json_encode($output);          
   }

    public function createSchoolByAdmin(Request $request){
        $data = $request->all();
       $output = array();
        if( isset($data['name'])) {
            $name = $data['name']; 
        }else{
            $name = ''; 
        }
        if( isset($data['email'])) {
            $email = $data['email']; 
        }else{
            $email = ''; 
        }
        if( isset($data['about'])) {
            $about = $data['about']; 
        }else{
            $about = ''; 
        }
        if( isset($data['phone'])) {
            $phone = $data['phone']; 
        }else{
            $phone = ''; 
        }
        if( isset($data['add_line1'])) {
            $add_line1 = $data['add_line1']; 
        }else{
            $add_line1 = ''; 
        }
        if( isset($data['scholarship'])) {
            $scholarship = $data['scholarship']; 
        }else{
            $scholarship = ''; 
        }
        if( isset($data['fee_structure'])) {
            $fee_structure = $data['fee_structure']; 
        }else{
            $fee_structure = ''; 
        }
        if( isset($data['course_detail'])) {
            $course_detail = $data['course_detail']; 
        }else{
            $course_detail = ''; 
        }
        if( isset($data['rating'])) {
            $rating = $data['rating']; 
        }else{
            $rating = ''; 
        }
        
        $insert_data= array();
        $insert_data['name']= $name;
        $insert_data['email']= $email;
        $insert_data['about']= $about;
        $insert_data['phone']= $phone;
        $insert_data['add_line1']= $add_line1;
        $insert_data['scholarship']= $scholarship;
        $insert_data['fee_structure']= $fee_structure;
        $insert_data['course_detail']= $course_detail;
        $insert_data['rating']= $rating;
        
        $radomsting = Str::random(8);
        $newpass = Hash::make($radomsting); //md5($radomsting); 
        $user_insert  = array();
        $user_insert['name'] = $insert_data['name'];
        $user_insert['email'] = $insert_data['email'];
        $user_insert['user_type'] = 'school';
        $user_insert['password'] =  $newpass;
        $user = User::create($user_insert);
        $insert_data['user_id']= $user->id;
        $schoolprofile = DB::table('schoolprofile')->insert($insert_data);
        $subject = "School Registration Successfull.";
        $message = "your new password is: ".$radomsting; 

        $headers = 'From: System  rohitkagathara.it@gmail.com' . "\r\n" .
          'Reply-To:  rohitkagathara.it@gmail.com' . "\r\n" .
          'Content-Type: text/html; charset=ISO-8859-1'."\r\n".
          'Content-type:text/html;charset=UTF-8' . "\r\n".
          'X-Mailer: PHP/' . phpversion();
        mail($email, $subject, $message, $headers);
      $output = "Created Successfull.";
       return json_encode($output);          
    }
   
}

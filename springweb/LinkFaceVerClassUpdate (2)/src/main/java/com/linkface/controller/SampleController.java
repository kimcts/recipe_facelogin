package com.linkface.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.session.SessionInformation;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.linkface.dto.PageDTO;
import com.linkface.dto.PageUnit;
import com.linkface.dto.UserDTO;
import com.linkface.entity.FoodItem;
import com.linkface.entity.FoodName;
import com.linkface.entity.RecipeGrade;
import com.linkface.entity.RecipeName;
import com.linkface.entity.UserData;
import com.linkface.security.AccessAccount;
import com.linkface.service.FoodIngredientsService;
import com.linkface.service.FoodItemsService;
import com.linkface.service.FoodNameService;
import com.linkface.service.FoodOrderService;
import com.linkface.service.RecipeGradeService;
import com.linkface.service.RecipeNameService;
import com.linkface.service.SanctionService;
import com.linkface.service.UserCRUDService;
import com.linkface.service.UserDataService;
import com.linkface.service.UserService;
import com.linkface.util.Aes256;
import com.linkface.util.DtoIteration;
import com.linkface.util.EmailHandler;
import com.linkface.util.SearchTrie;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@CrossOrigin("*")
@Controller
public class SampleController {
	private UserDTO userDTO;
	@Setter(onMethod_=@Autowired)
	private RecipeNameService service;
	@Setter(onMethod_=@Autowired)
	private UserDataService dataservice;
	@Setter(onMethod_=@Autowired)
	private FoodItemsService foodservice;
	
	@Setter(onMethod_ = @Autowired)
	private FoodNameService foodNameService;
	
	@Setter(onMethod_ = @Autowired)
	private FoodOrderService foodOrderService;
	
	@Setter(onMethod_ = @Autowired)
	private FoodIngredientsService foodIngredientsService;
	
	@Setter(onMethod_=@Autowired)
	private UserService userService;
	
	@Setter(onMethod_ = @Autowired)
	private UserCRUDService crudService;
	
	
	@Setter(onMethod_=@Autowired)
    private SessionRegistry sessionRegistry;
	
	@Setter(onMethod_=@Autowired)
	private RecipeGradeService recipeGradeService;
	
	@Setter(onMethod_=@Autowired)
	private SanctionService sanctionService;
	
	@GetMapping("/react/resp")
	public void reactResp(Model model) {
		model.addAttribute("resp", userDTO);
	}
	@PostMapping("/react/resp")
	public String reactResp(@RequestBody UserDTO resp) {
		System.out.println(resp.getId() + " " + resp.getPassword());
		userDTO = resp;
		return "redirect:/main";
	}
	
	@GetMapping("/react/register")
	public void reactRegister() {}
	

	@GetMapping("/homepage")
	public void homepage(Model model) {
		model.addAttribute("food", foodNameService.showAll());
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(!principal.equals("anonymousUser")) {
			AccessAccount account = (AccessAccount) principal;
			model.addAttribute("jjim", dataservice.getJJim(account.getUserInfo().getUserKey()));
		}
	}

	
	@GetMapping("/choice")
	public void choiceGet() {
		
	}
	
	@GetMapping("/chuchun")
	public void chuchunGet(Model model) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(!principal.equals("anonymousUser")) {
			AccessAccount account = (AccessAccount) principal;
			Long key = account.getUserInfo().getUserKey();
			List<FoodItem> fooditemlist = foodservice.getFoodItems(); 
		    List<String> fooditems = new ArrayList<String>();
		    List<Long> jjimlist = new ArrayList<>();
		    List<Long> recipeids = new ArrayList<Long>();
		    dataservice.getJJim(key).forEach(i->{
		    	if(i.getFoodingredients() != null) {
		    		fooditems.add(i.getFoodingredients());
		    	}
		    });

		    dataservice.getJJim(key).forEach(i->{
		    	if(i.getJjim() != null) {
			    	jjimlist.add(i.getJjim());	
			    }
		    });
		    fooditemlist.forEach(i->{
		    	fooditems.forEach(j->{
		    		if(i.getIrdntnm().equals(j)) {
		    			recipeids.add(i.getRecipeid());
		    		}
		    	});
		    });
		    List<RecipeName> recipelist = service.getList();
		    List<RecipeName> myrecipelist = new ArrayList<RecipeName>();
		    List<RecipeName> chuchunlist = new ArrayList<RecipeName>();
		    List<RecipeName> chuchun2list= new ArrayList<RecipeName>();

		    recipelist.forEach(i->{
		    	jjimlist.forEach(j->{
		    		if(i.getRECIPEID()==j) {
		    			myrecipelist.add(i);
		    		}
		    	});
		    });
		    recipelist.forEach(i->{
		    	myrecipelist.forEach(j->{
		    		if(i.getTYNM().equals(j.getTYNM()))
		    		{
		    			chuchunlist.add(i);
		    		}
		    		
		    	});
		    });
		    recipelist.forEach(i->{
		    	recipeids.forEach(j->{
		    		if(i.getRECIPEID()==j) {
		    			chuchun2list.add(i);
		    		}
		    	});
		    });
		    chuchun2list.forEach(i->System.out.println(i));
		    model.addAttribute("chuchun1", chuchunlist.stream().distinct().collect(Collectors.toList()));
		    model.addAttribute("chuchun2", chuchun2list.stream().distinct().collect(Collectors.toList()));
		      List<UserData> jjimdata = dataservice.getJJim(key);
		      List<FoodName> list = foodNameService.showAll();
		      List<FoodName> jjimlist1 = new ArrayList<FoodName>();
		      jjimdata.forEach(i->System.out.println(i));
		      list.forEach(i->{
		    	  jjimdata.forEach(j->{
		    		  if(j.getJjim() != null && i.getRECIPEID() == j.getJjim()){	
			    		  jjimlist1.add(i);
		    		  }
		    		  else {
		    			  log.info(j);
		    		  }
		    		  
		    	  });
		      });
		      model.addAttribute("jjimlist",jjimlist1);
		      model.addAttribute("jjim", dataservice.getJJim(account.getUserInfo().getUserKey()));
		    
		}
	}
	@GetMapping("/jjim")
	public void jjimGet(Model model) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(!principal.equals("anonymousUser")) {
	      AccessAccount account = (AccessAccount) principal;
	      Long key = account.getUserInfo().getUserKey();
	      List<UserData> jjimdata = dataservice.getJJim(key);
	      List<FoodName> list = foodNameService.showAll();
	      List<FoodName> jjimlist = new ArrayList<FoodName>();
	      jjimdata.forEach(i->System.out.println(i));
	      list.forEach(i->{
	    	  jjimdata.forEach(j->{
	    		  if(j.getJjim() != null && i.getRECIPEID() == j.getJjim()){	
		    		  jjimlist.add(i);
	    		  }
	    		  else {
	    			  log.info(j);
	    		  }
	    		  
	    	  });
	      });
	      model.addAttribute("jjimlist",jjimlist);
	      model.addAttribute("jjim", dataservice.getJJim(account.getUserInfo().getUserKey()));
		}
	}

	
	
	@PostMapping("/choice")
	public void myfooditemPost(UserData data) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(!principal.equals("anonymousUser")) {
			AccessAccount account = (AccessAccount) principal;
		    Long key = account.getUserInfo().getUserKey();
		    data.setUserKey(key);

		    dataservice.insertJJim(data);
		}
	}
	
	
	@GetMapping("/search")
	public void search(String search, Model model) {
		model.addAttribute("food", foodNameService.showList(search));
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(!principal.equals("anonymousUser")) {
	      AccessAccount account = (AccessAccount) principal;
	      Long key = account.getUserInfo().getUserKey();
	      List<UserData> jjimdata = dataservice.getJJim(key);
	      List<FoodName> list = foodNameService.showAll();
	      List<FoodName> jjimlist = new ArrayList<FoodName>();
	      jjimdata.forEach(i->System.out.println(i));
	      list.forEach(i->{
	    	  jjimdata.forEach(j->{
	    		  if(j.getJjim() != null && i.getRECIPEID() == j.getJjim()){	
		    		  jjimlist.add(i);
	    		  }
	    		  else {
	    			  log.info(j);
	    		  }
	    		  
	    	  });
	      });
	      model.addAttribute("jjimlist",jjimlist);
	      model.addAttribute("jjim", dataservice.getJJim(account.getUserInfo().getUserKey()));
		}
	}
	
	@GetMapping("/write")
	public void write(Model model) {
		model.addAttribute("food", foodNameService.showAll());
	}
	
	   private String getFolder() {
		      
		      SimpleDateFormat dataformat = new SimpleDateFormat("yyyy-MM-dd");
		      return dataformat.format(new Date()).replace("-", File.separator);
		   }
		   
		   @PostMapping(value = "/uploadImage", produces = "application/text; charset=UTF-8")
		   public ResponseEntity<String> fileUploadController(MultipartFile[] images,HttpServletRequest  request){
		      
		      // WepApp ??????
		      ServletContext servletContext = request.getSession().getServletContext();
		       String realPath = servletContext.getRealPath("/") + "resources";
		      
		       // + resources + ??????
		       
		      File uploadPath = new File(realPath,getFolder());
		      if(!uploadPath.exists()) { uploadPath.mkdirs(); }
		      
		      
		      for(MultipartFile image : images) {
		         
		         String imageName = image.getOriginalFilename().lastIndexOf("\\") == -1 ?
		               image.getOriginalFilename() :
		               image.getOriginalFilename().replace("\\", "");
		         
		         imageName = UUID.randomUUID().toString() + "_" + imageName;
		         
		         File save = new File(uploadPath,imageName);
		         
		         try {
		            image.transferTo(save);
		            return new ResponseEntity<>("\\resources\\" + getFolder() + "\\" + imageName,HttpStatus.OK);
		         } catch (IllegalStateException | IOException e) {
		            e.printStackTrace();
		         }
		      }
		      return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		   }
	@GetMapping("/food")
	public void food(int id, Model model) {
		model.addAttribute("food", foodNameService.showOne(id));
		model.addAttribute("order", foodOrderService.showOne(id));
		model.addAttribute("ingredients", foodIngredientsService.showOne(id));
	}
	
	@GetMapping("/userpage")
	public void userpage(Model model) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		AccessAccount account = (AccessAccount) principal;
		System.out.println("account " + account.getUserInfo().getUserEmail());
		model.addAttribute("account", account);
	}
	
	@GetMapping("/sendkey")
	public String sendKey(RedirectAttributes rttr) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		AccessAccount account = (AccessAccount) principal;
		rttr.addFlashAttribute("key", Aes256.encrypt(Long.toString(account.getUserInfo().getUserKey())));
		
		return "redirect:/newpassword";
	}
	
	@PostMapping("/modify")
	public String modify(UserDTO dto, RedirectAttributes rttr) { // ?????? ?????? ??????
		System.out.println(dto.getId() + " " + dto.getEmail() + " " + dto.getName() + " " + dto.getKey());
		if(crudService.modifyEmail(dto.getEmail(), dto.getKey())) {
			crudService.modifyUpdateDate(dto.getKey());
			userService.checkSessionAndUpdate(dto.getKey());
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			AccessAccount account = (AccessAccount) principal;
			EmailHandler.authLinkSendEmail("email", dto.getKey(), dto.getEmail(), account.getUserStatus().getAuthToken());
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/main";
	}
	
	@PostMapping("/wishlist")
	public ResponseEntity<String> wishlist(@RequestBody UserData userData) {
		System.out.println(userData);
		
		String result = "";
		if(dataservice.getOne(userData) == null) {
			dataservice.insertJJim(userData);
			result = "insert";
		}
		else {
			dataservice.deleteJJim(userData);
			result = "delete";
		}
		userService.checkSessionAndUpdate(userData.getUserKey());
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	
	@GetMapping("/searchtest")
	public void tests() {
		
	}

	// ??????
	@GetMapping(value={"","/main"})
	public String main(PageUnit unit,Model model) throws UnsupportedEncodingException {

		model.addAttribute("food",foodNameService.getPageingRecipeList(unit));
		model.addAttribute("page",new PageDTO(unit,foodNameService.getRecipeSize()));
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(!principal.equals("anonymousUser")) {
			AccessAccount account = (AccessAccount) principal;
			model.addAttribute("jjim", dataservice.getJJim(account.getUserInfo().getUserKey()));
		}
		return "main";
	}
	
	// ??????
	@GetMapping("/member")
	public void member() {
		Object getPrincipal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		System.out.println("principal " + getPrincipal);
		AccessAccount account = (AccessAccount) getPrincipal;
		System.out.println(account.getUserStatus().getRole());
		
		List<AccessAccount>principals = sessionRegistry.getAllPrincipals()
                .stream().map(o -> (AccessAccount) o).collect(Collectors.toList());
		for(AccessAccount principalQ: principals) {
			System.out.println(principalQ.getUserInfo().getUserKey());
		}
		
		EmailHandler.sendEmail(account.getUserInfo().getUserEmail(), "??????", "??????");
	}
	
	// ?????????
	@GetMapping("/admin")
	public void admin() {
		
	}
	
	// ?????????
	@GetMapping("/login")
	public void login() {
		
	}
	
	// ????????????
	@GetMapping("/signup")
	public void signup() {
		
	}
	// ID EMAIL ?????? ??????
	@PostMapping("/duplicatecheck")
	public ResponseEntity<Boolean> Check(@RequestBody UserDTO checkUser) {

		// id ?????? ????????? id ?????? / null ????????? email ??????
		// duplicateCheck ?????? ?????? ??????
		return new ResponseEntity<>
			(DtoIteration.userDTOCheckNonNull(checkUser, "id")  ?
					  userService.duplicateCheck(checkUser.getId(),"id")
					: userService.duplicateCheck(checkUser.getEmail(),"email"),HttpStatus.OK);
	}
	
	// ????????????
	@PostMapping("/signup")
	public ResponseEntity<String> signupPost(@RequestBody UserDTO newUser) {
	
		// ?????????
		boolean status = true;
		// ??????????????? ?????? ??????????????? ???????????? ?????? 
		status = userService.duplicateCheck(newUser.getId(),"id");
		status = userService.duplicateCheck(newUser.getEmail(),"email");
		status = newUser.getPassword().equals(newUser.getPasswordCheck());
		// DB ?????? ??? ?????? ????????? ??????
		status = userService.registUser(newUser);

		// ??????????????? ?????? ??????
		
		// ??? ?????? ??? ???????????? ????????? ?????? ?????? ??????
		return status ? 
				new ResponseEntity<>(newUser.getId(),HttpStatus.OK) :
				new ResponseEntity<>("BAD REQUEST",HttpStatus.BAD_REQUEST);
	}
	
	// ????????? ?????? , ????????? ?????? , ???????????? ????????? ??????
	@GetMapping("/certification/{urlText}")
	public String certification(@PathVariable String urlText, Model model) throws Exception {
		
	    String message = "";
	    
		Map<String,String> data = EmailHandler.analysisUrl(urlText);

		// ????????? ??????????????? ????????? ????????? email ?????? password ??? ???????????? ????????? ???????????? ??????
		if(data.isEmpty()){
			message = "?????? ??? ????????? ??????????????????. ?????? ????????? ?????????????????????";
		}
		// ????????? ??????
		else if(data.get("type").equals("email")) {
			message = userService.emailConformity
					(Long.parseLong(data.get("key")),data.get("email"),data.get("token"));
		}
		// ???????????? ???????????? ???????????? ????????? ??????
		else if(data.get("type").equals("password") && userService.userTokenCheck(
				Long.parseLong(data.get("key")),data.get("token"))) {
			// ?????? ????????? ??????
			model.addAttribute("key", Aes256.encrypt(data.get("key")));
			return "newpassword";
		}
		else {
			message = "???????????? ?????? ?????????????????????. ?????? ????????? ?????????????????????";
		}
		
		model.addAttribute("message", message);
		return "certification";
	}
	// ????????? ???????????? ??????
	@PostMapping(value = "/find", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> findPost(@RequestBody Map<String,UserDTO> checkObj) {
	
		String type = checkObj.keySet().iterator().next();
		
		String message = "";
		
		boolean status = true;
		
		// ?????? id password ??? ???????????? ????????? ????????? ?????? true
		status = (type.equals("id") || type.equals("password")) && checkObj.get(type) != null;
		// ?????? ?????? ????????? ????????? null ??? ???????????? true
		status = type.equals("password") ? 
					DtoIteration.userDTOCheckNonNull(checkObj.get(type), "email","name","id") :
					DtoIteration.userDTOCheckNonNull(checkObj.get(type), "email","name");
		
		message = userService.findUser(checkObj.get(type), type);
		System.out.println(message);
		if(!status) { message = "???????????? ???????????? ???????????? ????????????"; }

		System.out.println(message);
		return status ? 
				new ResponseEntity<>(message,HttpStatus.OK) :
				new ResponseEntity<>(message,HttpStatus.BAD_REQUEST);
	}
	
	// ???????????? ??????
	@GetMapping("/newpassword")
	public void newPassword() {
		
	}
	@PostMapping(value = "/newpassword", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> newPasswordPost(@RequestBody Map<String,String> passwordData,HttpServletRequest request) {
	
		
		if(passwordData.get("key").equals("") || passwordData.get("key") == null) {
			return new ResponseEntity<>("????????? ???????????????",HttpStatus.BAD_REQUEST);
		}
		Long key = Long.parseLong(Aes256.decrypt(passwordData.get("key")));
		
		// ??????????????? ???????????? ???????????? ?????? ????????? key ??????
		if(request.getSession().getAttribute("key") != null) {
			request.getSession().removeAttribute("key");
			request.getSession().removeAttribute("message");
		}
		
		if(userService.duplicateCheck(key, "key")) {
			return new ResponseEntity<>("???????????? ?????? ??????????????????",HttpStatus.BAD_REQUEST);
		}
		else if(!passwordData.get("password").equals(passwordData.get("passwordCheck"))) {
			return new ResponseEntity<>("??????????????? ???????????? ????????????",HttpStatus.BAD_REQUEST);
		}
		
		// ?????? ??????
		List<AccessAccount>principals = sessionRegistry.getAllPrincipals()
		                .stream().map(o -> (AccessAccount) o).collect(Collectors.toList());
		for(AccessAccount principal  : principals) {
			if(principal.getUserInfo().getUserKey() == key) {
				for(SessionInformation s : sessionRegistry.getAllSessions(principal, false)) {
						s.expireNow();
				}
			}
		}
		
		userService.createNewPassword(key,passwordData.get("password"));
		return new ResponseEntity<>("???????????? ????????? ?????????????????????. ???????????? ????????????",HttpStatus.OK);
	}
	
	// ?????? ????????????
	@PostMapping(value = "/recipegrade", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> recipegrade(@RequestBody RecipeGrade recipeGrade){
		
		String message = "";
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(!principal.equals("anonymousUser")) {
			AccessAccount account = (AccessAccount) principal;
			recipeGrade.setUserKey(account.getUserInfo().getUserKey());
			message = recipeGradeService.recipeGradeCUD(recipeGrade);
		}
		else {
			message = "?????? ????????? ?????????????????????";
		}

		return new ResponseEntity<>(message,HttpStatus.OK);
	}
	// ???????????? ?????????
	@GetMapping("/accessDenied")
	public void accessDenied() {
		
	}

	// ??????????????? ????????? ????????? ?????? & ????????? ?????? ?????? 5??? ??????
	@PostMapping(value = "/chartdata", produces = "application/json; charset=UTF-8")
	public ResponseEntity<Map<String, List<Object>>> chartDataReturnController(@RequestBody Map<String,String> dayAndType){

		return dayAndType.get("type").equals("categoryViewsCount") ? 
				new ResponseEntity<>(foodNameService.getViewsbyCategory(dayAndType.get("day")),HttpStatus.OK) :
				new ResponseEntity<>(foodNameService.getMostActiveUsers(dayAndType.get("day")),HttpStatus.OK);
	}
	
	// ????????? ??????
	@PostMapping(value = "/autocompleteuserid", produces = "application/json; charset=UTF-8")
	public ResponseEntity<List<String>> searchUserController(@RequestBody String id){

		List<String> data = SearchTrie.searchAutocompleteData(id.trim());
		if(data.isEmpty()) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		else if(data.size() > 5) {
			List<String> dataSizeFive = new ArrayList<>();
			for(int i = 0; i < 5; i++) {
				dataSizeFive.add(data.get(i));	
			}
			return new ResponseEntity<>(dataSizeFive,HttpStatus.OK);
		}
		return new ResponseEntity<>(data,HttpStatus.OK);
				
	}
	
	// ?????? ??????
	@PostMapping(value = "/userinfo", produces = "application/json; charset=UTF-8")
	public ResponseEntity<UserDTO> getUserInfoController(@RequestBody String id){
				
		UserDTO user = userService.adminLookupUserinfo(id);
		return user == null ?
			new ResponseEntity<>(HttpStatus.BAD_REQUEST) :
			new ResponseEntity<>(user,HttpStatus.OK);
	}
	
	@PostMapping(value = "/admindeleterecipe", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> adminDeleteRecipeController(@RequestBody Map<String,String> deleteRecipe){
		
		FoodName name = foodNameService.showOne(Integer.parseInt(deleteRecipe.get("recipeId")));
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		AccessAccount account = (AccessAccount) principal;
		if(deleteRecipe.get("reasons").trim().equals("")) {
			return new ResponseEntity<>("????????? ?????????????????????.",HttpStatus.BAD_REQUEST);
		}
		else if(name == null) {
			return new ResponseEntity<>("??? ??? ?????? ??????????????????.",HttpStatus.BAD_REQUEST);
		}
		else if(!userService.checkUserRole(account.getUserInfo().getUserKey(), name.getUserKey())) {
			return new ResponseEntity<>("?????? ???????????? ????????? ????????? ????????????.",HttpStatus.BAD_REQUEST);
		}
		// ????????? ??????
		foodNameService.deleteRecipe(name.getRECIPEID().intValue());
		// ???????????? ??????
		sanctionService.sanctionsRecipe(name.getUserKey(), name.getRECIPEID().intValue(),
				deleteRecipe.get("reasons"), account.getUserInfo().getUserKey());
		// ????????? ?????? ?????? (2)
		
		return new ResponseEntity<>("???????????? ?????????????????????",HttpStatus.OK);
		
	}
	@PostMapping(value = "/adminsanctionsuser", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> adminSanctionsUserController(@RequestBody Map<String,String> sanctionsUser){
		
		UserDTO user = userService.getUser(sanctionsUser.get("id"));
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		AccessAccount account = (AccessAccount) principal;
		int day;
		switch(sanctionsUser.get("day")){
	        case "day": 
	        	day = 3;
	        	break;
	        case "week":
	            day = 7;
	            break;
	        case "month" :
	            day = 30;
	            break;
	        case "permanence" :
	            day = 7300;
	            break;
	        default :
	            day = 0;
	    }
		if(day == 0) {
			return new ResponseEntity<>("????????? ???????????????.",HttpStatus.BAD_REQUEST);
		}
		else if(user == null) {
			return new ResponseEntity<>("??? ??? ?????? ??????????????????.",HttpStatus.BAD_REQUEST);
		}
		else if(!userService.checkUserRole(account.getUserInfo().getUserKey(), user.getKey())) {
			return new ResponseEntity<>("????????? ??? ?????? ???????????????.",HttpStatus.BAD_REQUEST);
		}
		userService.sanctionUser(user.getKey(), day, false);
		
		sanctionService.sanctionsUser(user.getKey(),
				sanctionsUser.get("reasons"), account.getUserInfo().getUserKey());
		
		List<AccessAccount>principals = sessionRegistry.getAllPrincipals()
                .stream().map(o -> (AccessAccount) o).collect(Collectors.toList());
		for(AccessAccount accessAccount  : principals) {
			if(accessAccount.getUserInfo().getUserKey() == user.getKey()) {
				for(SessionInformation s : sessionRegistry.getAllSessions(accessAccount, false)) {
						s.expireNow();
				}
			}
		}
		
		return new ResponseEntity<String>("?????????????????????.",HttpStatus.OK);
		
	}
	@PostMapping(value = "/changeuserrole", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> changeUserRoleController(@RequestBody Map<String,String> roleChangeUser){

		UserDTO user = userService.getUser(roleChangeUser.get("id"));
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		AccessAccount account = (AccessAccount) principal;
		String role = "ROLE_";
		
		if(user == null) {
			return new ResponseEntity<>("???????????? ?????? ??????????????????.",HttpStatus.BAD_REQUEST);
		}
		else if(user.getRole().equals("ROLE_UNKNOWN")) {
			return new ResponseEntity<>("????????? ???????????? ????????? ????????? ??? ????????????.",HttpStatus.BAD_REQUEST);
		}
		else if(!roleChangeUser.get("role").equals("MEMBER") && 
				!roleChangeUser.get("role").equals("MANAGER")) {
			return new ResponseEntity<>("????????? ???????????????.",HttpStatus.BAD_REQUEST);
		}
		else if(!userService.checkUserRole(account.getUserInfo().getUserKey(), user.getKey())) {
			return new ResponseEntity<>("????????? ???????????????.",HttpStatus.BAD_REQUEST);
		}

		role += roleChangeUser.get("role");
		userService.changeUserRole(user.getKey(), role);
		
		List<AccessAccount>principals = sessionRegistry.getAllPrincipals()
                .stream().map(o -> (AccessAccount) o).collect(Collectors.toList());
		for(AccessAccount accessAccount  : principals) {
			if(accessAccount.getUserInfo().getUserKey() == user.getKey()) {
				for(SessionInformation s : sessionRegistry.getAllSessions(accessAccount, false)) {
						s.expireNow();
				}
			}
		}
		
		return new ResponseEntity<>("????????? ?????????????????????",HttpStatus.OK);
		
	}
}

package com.hxd.site.ctl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hxd.bean.Resource;
import com.hxd.bean.ResourceGroup;
import com.hxd.interceptor.ControllerLog;
import com.hxd.service.ContentService;
import com.hxd.service.ResourceGroupService;
import com.hxd.service.ResourceService;
import com.hxd.util.DateUtil;
import com.hxd.util.StrUtil;
import com.hxd.vo.AdditionalParameters;
import com.hxd.vo.PageData;
import com.hxd.vo.ResourceGroupItem;
import com.hxd.vo.ResourceGroupVo;
import com.hxd.vo.ResourceVo;
import com.hxd.vo.StatusVo;

@Controller
@RequestMapping("/res")
public class ResCtl extends BaseCtl {

	@Autowired
	private ResourceService service;
	
	@Autowired
	private ResourceGroupService rgService;
	
	@Autowired
	private ContentService ctService;
	
	
    @ControllerLog(cleanData="false",desc="log.res.gallery.read")
	@RequiresPermissions("gallery:r")
	@RequestMapping("/gallery")
	public String gallery(HttpServletRequest req) {
		return "/view/res/gallery";
	}
	
	
    @ControllerLog(cleanData="false",desc="log.res.flash.read")
	@RequestMapping("/instorge")
	public String flash(Model model,HttpServletRequest req) {
		model.addAttribute("type", "1");
		return "/view/res/resourceList";
	}
	
    @ControllerLog(cleanData="false",desc="log.res.video.read")
	@RequestMapping("/outstorge")
	public String video(Model model,HttpServletRequest req) {
		model.addAttribute("type", "0");
		return "/view/res/resourceList";
	}
	
    @ControllerLog(cleanData="false",desc="log.res.file.read")
	@RequiresPermissions("file:r")
	@RequestMapping("/file")
	public String file(Model model,HttpServletRequest req) {
		model.addAttribute("type", "4");
		return "/view/res/resourceList";
	}
	
	@RequestMapping(value = "/listJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getListJsonWithGroupID(HttpServletRequest req,ResourceVo vo) {
		String json = null;
		try {
			
			List<Resource> list = null;
			int totalCount = 0;
			
			list = service.queryResourceByPage(vo);
			totalCount = service.queryResourceCount(vo);
			
			List<ResourceVo>  listVo = new ArrayList<ResourceVo>();
			ResourceVo rsVo = null;
			for (Resource rs : list) {
				rsVo = new ResourceVo();
				rsVo.setId(rs.getId());
				rsVo.setResName(rs.getResName());
				rsVo.setGroupid(rs.getGroupid());
				rsVo.setUnitPrice(rs.getUnitPrice());
				rsVo.setNumber(rs.getNumber());
				rsVo.setTotalPrice(rs.getTotalPrice());
				rsVo.setCreateTime(DateUtil.date2Str(rs.getCreateTime(), DateUtil.YMD_HMS));
				if(rs.getUpdateTime() != null){
					rsVo.setUpdateTime(DateUtil.date2Str(rs.getUpdateTime(), DateUtil.YMD_HMS));
				}else{
					rsVo.setUpdateTime("");
				}
				rsVo.setInfo(rs.getInfo());
				
				listVo.add(rsVo);
			}		
			
			//返回json数据给界面
			PageData data =new PageData();
			data.setsEcho(vo.getsEcho());
			data.setiTotalRecords(totalCount);
			data.setiTotalDisplayRecords(totalCount);
			data.setAaData(StrUtil.toJsonStrWithFixed(listVo));
			json = StrUtil.toJsonStrWithFixed(data);
		} catch (Exception e) {
			log.error(e);
		}
		return json;
	}
	
	@RequestMapping(value = "/treeListJson", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getFlashGroupListJson(@RequestBody String json) {
		
		List<ResourceGroupItem> listItem = new ArrayList<ResourceGroupItem>();
		try {
			log.debug("###@@@ getFlashListJson() ="+json);
			
			ResourceGroup rGroup = JSON.parseObject(json,ResourceGroup.class);
			List<ResourceGroup> listReourceGroup = rgService.queryListByParentId(rGroup);			
			ResourceGroupItem resourceGroupItem = null;
			for (ResourceGroup rg : listReourceGroup) {
				resourceGroupItem = new ResourceGroupItem();
				BeanUtils.copyProperties(rg,resourceGroupItem);
				resourceGroupItem.setText(rg.getGroupname());
				AdditionalParameters p = new AdditionalParameters();
				p.setId(String.valueOf(rg.getId()));
				resourceGroupItem.setAdditionalParameters(p);	
				if (rg.getCount()>0) {
					resourceGroupItem.setType("folder");						
				} else {
					resourceGroupItem.setType("item");
				}
				
				listItem.add(resourceGroupItem);
			}
			log.debug(StrUtil.toJsonStrWithFixed(listItem));

		} catch (Exception e) {
			log.error(e);
		}
		return StrUtil.toJsonStrWithFixed(listItem);
	}
	
	@RequestMapping(value = "/listGallery", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String getGalleryList(HttpServletRequest req,@RequestBody String json) {
		
		ResourceVo vo = JSON.parseObject(json,ResourceVo.class);
		
		try {
			
			System.out.println("#####@@@@@"+vo.getGroupid());
			System.out.println("#####@@@@@"+vo.getRestype());
			
			List<Resource> list = null;
			int totalCount = 0;
			
			list = service.queryResourceByPage(vo);
			totalCount = service.queryResourceCount(vo);

			//返回json数据给界面
			PageData data =new PageData();
			data.setsEcho(vo.getsEcho());
			data.setiTotalRecords(totalCount);
			data.setiTotalDisplayRecords(totalCount);
			log.debug("###@@@ list.size:"+list.size());
			//log.debug("###@@@ StrUtil.toJsonStrWithFixed(list):"+StrUtil.toJsonStrWithFixed(list));
			data.setAaData(StrUtil.toJsonStrWithFixed(list));
			json = StrUtil.toJsonStrWithFixed(list);
			//log.debug("###@@@ json:"+json);
		} catch (Exception e) {
			log.error(e);
		}
		return json;
	}
	
	
	//更新也走这里
	@RequestMapping(value = "/saveResourceGroup", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String saveResourceGroup(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);	
			ResourceGroup rGroup = JSON.parseObject(json,ResourceGroup.class);
			int i = 0;
			//id为空说明是增加一条新数据 否则为编辑数据
			if (rGroup.getId() == null)
			{
				i = rgService.insertResourceGroup(rGroup);
			}
			else {
				i = rgService.updateResourceGroupByPrimaryKey(rGroup);
			}
				
			if (i> 0) {
				//返回结果json数据给界面		
				sta.setSuccess(this.getMessage("op.success"));	
			} else {
				sta.setError(this.getMessage("op.fail"));
			}		
			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		log.debug("###@@@ status:"+StrUtil.toJsonStrWithFixed(sta));
		return StrUtil.toJsonStrWithFixed(sta);
	}
	
	
	@RequestMapping(value = "/deleteResourceGroup", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String deleteResourceGroup(@RequestBody String json) {
		StatusVo sta = new StatusVo();
		try {
			log.debug("####: json="+json);


			ResourceGroupVo rgVo = JSON.parseObject(json,ResourceGroupVo.class);
			int i = 0;
			//批量删除，单个删除特例
			if (rgVo.getId() != null)
			{
				//只有没有数据的叶节点才可以删除
				int childCount = rgService.queryChildCountByParentId(rgVo.getId());
				if (childCount > 0)
				{
					sta.setError(this.getMessage("tree_delete_error_1"));
					return StrUtil.toJsonStrWithFixed(sta);
				}
				
				Resource rs = new Resource();
				rs.setGroupid(rgVo.getId());
				
				int resourceCount = service.queryResourceCountByGroupID(rs);
				
				if (resourceCount > 0)
				{
					sta.setError(this.getMessage("tree_delete_error_2"));
					return StrUtil.toJsonStrWithFixed(sta);
				}
				
				//
				i = rgService.deleteResourceGroupByNodeId(rgVo.getId());
			}
			
				
			if (i> 0) {
				//返回结果json数据给界面		
				sta.setSuccess(this.getMessage("op.success"));	
			} else {
				sta.setError(this.getMessage("op.fail"));
			}		
			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		log.debug("###@@@ status:"+StrUtil.toJsonStrWithFixed(sta));
		return StrUtil.toJsonStrWithFixed(sta);
	}
	
	
	@ControllerLog(cleanData="true",desc="log.res.del")
	@RequiresPermissions("res:d")
	@RequestMapping(value = "/delete", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String delete(@RequestBody String json,HttpServletRequest request) {
		
		StatusVo sta = new StatusVo();
		
		try {
			log.debug("####: json="+json);

			ResourceVo rsVo = JSON.parseObject(json,ResourceVo.class);
			//执行删除操作，本地文件一起删除
			int i = 0;
			
			//批量删除，单个删除特例
			if (rsVo.getIdList().size() > 0)
			{
				i = service.deleteResourceByBatch(rsVo.getIdList());
			}
			
			if (i> 0) {
				//返回结果json数据给界面		
				sta.setSuccess(this.getMessage("op.success"));	
			} else {
				sta.setError(this.getMessage("op.fail"));
			}		
			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		log.debug("###@@@ status:"+StrUtil.toJsonStrWithFixed(sta));
		return StrUtil.toJsonStrWithFixed(sta);
	}
	
	@RequestMapping(value = "/insert", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String insertResource(@RequestBody String json) {
		
		log.debug("####: json="+json);
		
		StatusVo sta = new StatusVo();
		
		Resource rsVo = JSON.parseObject(json,Resource.class);
		String jsonRet = null;
		
		rsVo.setCreateTime(new Date());
		int i = 0;
		try {
			i = service.insertResourceSelective(rsVo);
			if (i > 0) {
				sta.setSuccess(this.getMessage("op.success"));	
			} else {
				sta.setError(this.getMessage("op.fail"));
			}		
			
			jsonRet = StrUtil.toJsonStrWithFixed(sta);
		} catch (Exception e) {
			log.error(e);
		}
		
		return jsonRet;
	}
	
	@RequestMapping(value = "/changePictureType", produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public String changePictureType(@RequestBody String json){
		StatusVo sta = new StatusVo();
		Resource rs = JSON.parseObject(json,Resource.class);
		try {
			int i = service.updateResourceByPrimaryKeySelective(rs);
			if (i >= 0) {
				sta.setSuccess(this.getMessage("op.success"));	
			} else {
				sta.setError(this.getMessage("op.fail"));
			}		
			
		} catch (Exception e) {
			log.error(e);
			sta.setError(this.getMessage("op.fail")+"\r\n"+e.getMessage());
			return StrUtil.toJsonStrWithFixed(sta);
		}
		return StrUtil.toJsonStrWithFixed(sta);
	}
	
}

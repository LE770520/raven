function getFormatNetTime()
	current = getNetTime();
	current_text = os.date("%Y:%m:%d %X", current);
	return current_text;
end

function getCurrentHour()
	local currentTimeStr=getFormatNetTime()
	local h=string.sub(currentTimeStr,12,13)

	return tonumber(h)
end

function getCurrentMinute()
	local currentTimeStr=getFormatNetTime()
	local minute=string.sub(currentTimeStr,15,16)

	return tonumber(minute)
end

--延迟3秒后加载界面
mSleep(3000)



local sz = require("sz");
local json = sz.json;
local w,h = getScreenSize();
MyTable = {
	["style"] = "default",
  	["width"] = w,
  	["height"] = h,
  	["config"] = "config.dat",
  	["rettype"] = "default",
  	["timer"] = 10,
  	views = {
		{
            ["type"] = "Label",
            ["text"] = "乱斗次数:",
            ["size"] = 24,
            ["align"] = "center",
            ["color"] = "0,0,255",
            ["width"] = "260",
            ["nowrap"] = "1"
	    },
	
        {
            ["type"] = "Edit",
            ["prompt"] = "乱斗次数",
            ["text"] = 60,
            ["size"] = 15,
            ["align"] = "center",
            ["color"] = "0,0,225",
            ["width"] = "160",
			["kbtype"]="number"
		},
		{
            ["type"] = "Label",
            ["text"] = "HOME键位置:",
            ["size"] = 24,
            ["align"] = "center",
            ["color"] = "0,0,255",
            ["width"] = "260",
            ["nowrap"] = "1"
	    },
		{
            ["type"] = "ComboBox",
            ["list"] = "竖屏在下,横屏在右,横屏在左",
            ["select"] = "1",
            ["width"] = "160"
		},
        
    
	}
}
local MyJsonString = json.encode(MyTable);
ret = {showUI(MyJsonString)}
--dialog(ret[3], 0)
mSleep(11000)

--竞技场循环次数
num=60
if(ret[2]~=nil )then
	num=ret[2]
end


--确定横屏竖屏
homeXY=1; --HOME建位置默认在右
if(ret[3]~=nil )then
	homeXY=ret[3]
end

--界面加载完成

--开始加载自定义函数
init('0',homeXY)


--增加乱斗时间判断，到了时间才开始执行乱斗代码
while (true) do
	
	local h=getCurrentHour();
	local currentTime=getFormatNetTime();
	if(h==13 or h==20 or h==23)then
		local currentMinute=getCurrentMinute();
		if(currentMinute>4)
		then
			mSleep(3000)
		else
			mSleep(90000)
		end
		
		break;
	else
		toast("乱斗场暂未开放,当前时间"..currentTime,15);
		mSleep(30000)
	end
	
end


function isColor(x,y,c,s)
    local fl,abs = math.floor,math.abs
    s = fl(0xff*(100-s)*0.01)
    local r,g,b = fl(c/0x10000),fl(c%0x10000/0x100),fl(c%0x100)
    local rr,gg,bb = getColorRGB(x,y)
    if abs(r-rr)<s and abs(g-gg)<s and abs(b-bb)<s then
        return true
    end
end

--记录日志
function log(str,logName)
	local fileName="ravenLog"
	
	if(logName~=nil and logName~='' and logName~="")
	then
		fileName=logName
	end
	
	initLog(fileName, 0);
    wLog(fileName,str);
    closeLog(fileName);  --关闭日志

end


function tap(x,y)
	touchDown(x,y)
	mSleep(50)
	touchUp(x,y)
	mSleep(50)
	log('tap_xy:'..x..","..y,nil)
end

--场景判断,取多个点颜色匹配成功则点击相应坐标
--x,y 点击坐标，judgeTable取点坐标和颜色judgeTable={取点1={100,100,0x444444}...}，s匹配系数
function sceneJudgment(x,y,judgeTable,s,sleepTime,overTime)
	
	
	local isEnter=false
	local num=#judgeTable
	
	local sleep=1000
	
	local overTimeDef=30--30秒
	if(overTime~=nil and overTime>0)then
		overTimeDef=overTime
	end
	
	
	if(sleepTime~=nil and sleepTime>0)then
		sleep=sleepTime
	end

	local time = os.time()
	
	while (true) do
		
		if(num==2)
		then
			if (isColor( judgeTable[1][1],  judgeTable[1][2], judgeTable[1][3], s) and 
				isColor( judgeTable[2][1],  judgeTable[2][2], judgeTable[2][3], s)
				
				) 
			then
				mSleep(sleep)
				tap(x,y)
				--log('tap_xy:'..x..","..y,nil)
				isEnter=true
				break
			else
				mSleep(1000)
			end	
		elseif(num==3)
		then
			if (isColor( judgeTable[1][1],  judgeTable[1][2], judgeTable[1][3], s) and 
				isColor( judgeTable[2][1],  judgeTable[2][2], judgeTable[2][3], s) and 	
				isColor( judgeTable[3][1],  judgeTable[3][2], judgeTable[3][3], s)
				) 
			then
				mSleep(sleep)
				tap(x,y)
				--log('tap_xy:'..x..","..y,nil)
				isEnter=true
				break
			else
				mSleep(1000)	
			end	
		elseif(num==4)
		then
			if (isColor( judgeTable[1][1],  judgeTable[1][2], judgeTable[1][3], s) and 
				isColor( judgeTable[2][1],  judgeTable[2][2], judgeTable[2][3], s) and 	
				isColor( judgeTable[3][1],  judgeTable[3][2], judgeTable[3][3], s) and
				isColor( judgeTable[4][1],  judgeTable[4][2], judgeTable[4][3], s)
				) 
			then
				mSleep(sleep)
				tap(x,y)
				--log('tap_xy:'..x..","..y,nil)
				isEnter=true
				break
			else
				mSleep(1000)	
			end	
		end
		
		local time2 = os.time()
		
		--超时退出
		if((time2-time)>overTimeDef)then
			
			break
			
		end
	end
	
	return isEnter
end



ravenConfigs={
	["r720_1280"]={
		["HOME角斗场"]={1000,  560, 0x1b394b },
		["乱斗场"]={920,  611, 0xdeb371 },
		["团队乱斗"]={890,  635, 0x562f0c },
		["乱斗场记录1"]={158,  132, 0xcbcbcb },
		["乱斗场记录2"]={207,  133, 0xc8c8c8},
		["团队乱斗1"]={300,  372, 0xc25511},
		["团队乱斗2"]={344,  398, 0xbb4411},
		["到胜分站结束"]={850,  590, 0x382100},
		["结束乱斗1"]={433,  560, 0xd58913},
		["结束乱斗2"]={459,  552, 0xe89615},
		["结束乱斗确认"]={1048,  664, 0xbb965f},
		["移动到准备界面"]={1152,  662, 0xc09b62},
		["移动到准备界面1"]={875,  665, 0xb8945e},
		["移动到准备界面2"]={900,  658, 0xcaa367},
		["乱斗房间返回"]={81,   35, 0x783713},
		["乱斗房间1"]={788,  119, 0xd9d9d9},
		["乱斗房间2"]={832,  119, 0xd9d9d9}
		
		
	},
	["r1920_1080"]={
		["HOME角斗场"]={1507,  844, 0x375a65 },
		["乱斗场"]={1394,  917, 0x712816 },
		["团队乱斗"]={1351,  959, 0x552e0b },
		["乱斗场记录1"]={1357,  335, 0xe29215 },
		["乱斗场记录2"]={1548,  332, 0xe69515},
		["没到开放时间1"]={1071,  470, 0xc7a165},
		["没到开放时间1"]={1093,  479, 0xb8955d},
		["没到开放时间确认"]={945,  825, 0xdeb371},
		["乱斗场服务器不稳定确认"]={961,  825, 0x6c2715},
		["乱斗场服务器不稳定1"]={1088,  486, 0xd2aa6b},
		["乱斗场服务器不稳定2"]={1120,  494, 0xc6a064},
		["网络连接超时确认"]={1182,  821, 0xbb975f},
		["网络连接超时1"]={1223,  482, 0xb3915b},
		["网络连接超时2"]={1264,  489, 0xa78755},
		["乱斗场返回"]={128,   47, 0xcf7728},
		["团队乱斗1"]={1307,  894, 0xdbad7e},
		["团队乱斗2"]={1439,  888, 0xe5bb8b},
		["到胜分站结束"]={1303,  896, 0x573a16},
		["无法找到对手确认"]={960,  829, 0x692514},
		["无法找到对手1"]={940,  496, 0xc29d63},
		["无法找到对手2"]={1020,  488, 0xd0a869},
		["进入战斗1"]={1832,  353, 0xd0d0d0},
		["进入战斗2"]={1820,  335, 0xf2f2f2},
		["进入战斗大招"]={1691,  618, 0xae388d},
		["结束乱斗1"]={381,   43, 0xe4a028},
		["结束乱斗2"]={510,   67, 0xc78c23},
		["结束乱斗确认"]={1575,  998, 0x2d1109},
		["移动到准备界面"]={1727,  998, 0x392e1d},
		["移动到准备界面1"]={1350,  987, 0xcba467},
		["移动到准备界面2"]={1313,  998, 0xb7945e},
		["乱斗未到开放时间1"]={1093,  479, 0xb8955e},
		["乱斗未到开放时间2"]={1104,  479, 0xb8955e },
		["乱斗未到开放时间确认"]={961,  828, 0x6a2614},
		["乱斗房间返回"]={124,   45, 0xdb852a},
		["乱斗房间1"]={1247,  179, 0xd8d8d8},
		["乱斗房间2"]={1321,  177, 0xdddddd},
		
		
	}
	
}

sleepTime=3000
slowSleepTime=20000
midSleepTime=5000
fastSleepTime=1000

overTime1=40
overTime2=350

local ravenConfig=ravenConfigs["r1920_1080"]

tap(ravenConfig["HOME角斗场"][1],ravenConfig["HOME角斗场"][2])

mSleep(midSleepTime)
tap(ravenConfig["乱斗场"][1],ravenConfig["乱斗场"][2])

for i=1,num,1 do
	
	--进入乱斗场记录界面，点击团队乱斗按钮
	mSleep(midSleepTime)
	local luandoujilu={ravenConfig["乱斗场记录1"],ravenConfig["乱斗场记录2"]}
	local result=sceneJudgment(ravenConfig["团队乱斗"][1],ravenConfig["团队乱斗"][2],luandoujilu,90,4000,overTime1)
	
	if(result==false)then
		dialog("进入“团队乱斗”超时异常", 0)
		break
	end
	
	--如果乱斗时间结束，则返回游戏主界面
	if (isColor( ravenConfig["没到开放时间1"][1],  ravenConfig["没到开放时间1"][2], ravenConfig["没到开放时间1"][3], 90) and 
				isColor( ravenConfig["没到开放时间1"][1],  ravenConfig["没到开放时间1"][2], ravenConfig["没到开放时间1"][3], 90)
				
		) 
	then
		mSleep(sleepTime)
		tap(ravenConfig["没到开放时间确认"][1],  ravenConfig["没到开放时间确认"][2])
		
		mSleep(sleepTime)
		tap(ravenConfig["乱斗场返回"][1],  ravenConfig["乱斗场返回"][2])
		
		mSleep(sleepTime)
		tap(ravenConfig["乱斗场返回"][1],  ravenConfig["乱斗场返回"][2])
		dialog("乱斗场没到开放时间。", 0)
		break
		
	end	

	--进入团队乱斗
	mSleep(sleepTime)
	local tuanduiluandou={ravenConfig["团队乱斗1"],ravenConfig["团队乱斗2"]}
	local result=sceneJudgment(ravenConfig["到胜分站结束"][1],ravenConfig["到胜分站结束"][2],tuanduiluandou,90,3000,overTime1)
	if(result==false)then
		dialog("进入“到胜分站结束”超时异常", 0)
		break
	end
	
	--处理未匹配到对手异常
	local wufazhaodaoduishou={ravenConfig["无法找到对手1"],ravenConfig["无法找到对手2"]}
	local result=sceneJudgment(ravenConfig["无法找到对手确认"][1],ravenConfig["无法找到对手确认"][2],wufazhaodaoduishou,90,3000,40)
	if(result)then
		mSleep(5000)
		--暂停10秒重新开始组队
		local luandoujilu={ravenConfig["乱斗场记录1"],ravenConfig["乱斗场记录2"]}
		local result=sceneJudgment(ravenConfig["团队乱斗"][1],ravenConfig["团队乱斗"][2],luandoujilu,90,midSleepTime,overTime1)
		
		mSleep(sleepTime)
		local tuanduiluandou={ravenConfig["团队乱斗1"],ravenConfig["团队乱斗2"]}
		local result=sceneJudgment(ravenConfig["到胜分站结束"][1],ravenConfig["到胜分站结束"][2],tuanduiluandou,90,3000,overTime1)
	end
	
	
	--进入乱斗中放大招
	local jieshuluandou={ravenConfig["进入战斗1"],ravenConfig["进入战斗2"]}
	local result=sceneJudgment(ravenConfig["进入战斗大招"][1],ravenConfig["进入战斗大招"][2],jieshuluandou,90,4000,overTime1)
	if(result==false)then
		--处理未匹配到对手异常
		local wufazhaodaoduishou={ravenConfig["无法找到对手1"],ravenConfig["无法找到对手2"]}
		local result=sceneJudgment(ravenConfig["无法找到对手确认"][1],ravenConfig["无法找到对手确认"][2],wufazhaodaoduishou,90,3000,5)
		if(result)then
			
			local luandoujilu={ravenConfig["乱斗场记录1"],ravenConfig["乱斗场记录2"]}
			local result=sceneJudgment(ravenConfig["团队乱斗"][1],ravenConfig["团队乱斗"][2],luandoujilu,90,midSleepTime,overTime1)
			
			mSleep(sleepTime)
			local tuanduiluandou={ravenConfig["团队乱斗1"],ravenConfig["团队乱斗2"]}
			local result=sceneJudgment(ravenConfig["到胜分站结束"][1],ravenConfig["到胜分站结束"][2],tuanduiluandou,90,3000,overTime1)
		end
	end
	
	--再次判断是否匹配到队伍
	--处理未匹配到对手异常
	local wufazhaodaoduishou={ravenConfig["无法找到对手1"],ravenConfig["无法找到对手2"]}
	local result=sceneJudgment(ravenConfig["无法找到对手确认"][1],ravenConfig["无法找到对手确认"][2],wufazhaodaoduishou,90,3000,33)
	if(result)then
		mSleep(5000)
		--暂停10秒重新开始组队
		local luandoujilu={ravenConfig["乱斗场记录1"],ravenConfig["乱斗场记录2"]}
		local result=sceneJudgment(ravenConfig["团队乱斗"][1],ravenConfig["团队乱斗"][2],luandoujilu,90,3000,overTime1)
		
		mSleep(sleepTime)
		local tuanduiluandou={ravenConfig["团队乱斗1"],ravenConfig["团队乱斗2"]}
		local result=sceneJudgment(ravenConfig["到胜分站结束"][1],ravenConfig["到胜分站结束"][2],tuanduiluandou,90,3000,overTime1)
	end
	
	
	--进入团队乱斗
	--mSleep(slowSleepTime)
	local jieshuluandou={ravenConfig["结束乱斗1"],ravenConfig["结束乱斗2"]}
	local result=sceneJudgment(ravenConfig["结束乱斗确认"][1],ravenConfig["结束乱斗确认"][2],jieshuluandou,90,4000,overTime2)
	
	if(result==false)then
		--再次判断是否匹配到队伍
		--处理未匹配到对手异常
		local wufazhaodaoduishou={ravenConfig["无法找到对手1"],ravenConfig["无法找到对手2"]}
		local result=sceneJudgment(ravenConfig["无法找到对手确认"][1],ravenConfig["无法找到对手确认"][2],wufazhaodaoduishou,90,3000,10)
		if(result)then
			mSleep(5000)
			--暂停10秒重新开始组队
			local luandoujilu={ravenConfig["乱斗场记录1"],ravenConfig["乱斗场记录2"]}
			local result=sceneJudgment(ravenConfig["团队乱斗"][1],ravenConfig["团队乱斗"][2],luandoujilu,90,3000,overTime1)
			
			mSleep(sleepTime)
			local tuanduiluandou={ravenConfig["团队乱斗1"],ravenConfig["团队乱斗2"]}
			local result=sceneJudgment(ravenConfig["到胜分站结束"][1],ravenConfig["到胜分站结束"][2],tuanduiluandou,90,3000,overTime1)
		
			--进入团队乱斗
			--mSleep(slowSleepTime)
			local jieshuluandou={ravenConfig["结束乱斗1"],ravenConfig["结束乱斗2"]}
			local result=sceneJudgment(ravenConfig["结束乱斗确认"][1],ravenConfig["结束乱斗确认"][2],jieshuluandou,90,4000,overTime2)
		else
			dialog("进入“结束乱斗确认”超时异常", 0)
			break
		end
	end

	--进入返回乱斗准备界面
	mSleep(sleepTime)
	local yidongdaozhunbeijiemian={ravenConfig["移动到准备界面1"],ravenConfig["移动到准备界面2"]}
	local result=sceneJudgment(ravenConfig["移动到准备界面"][1],ravenConfig["移动到准备界面"][2],yidongdaozhunbeijiemian,90,4000,overTime1)

	if(result==false)then
		dialog("进入“移动到准备界面”超时异常", 0)
		break
	end
	
	--乱斗时间结束，返回主界面
	local yidongdaozhunbeijiemian={ravenConfig["乱斗未到开放时间1"],ravenConfig["乱斗未到开放时间2"]}
	local result=sceneJudgment(ravenConfig["乱斗未到开放时间确认"][1],ravenConfig["乱斗未到开放时间确认"][2],yidongdaozhunbeijiemian,90,3000,5)
	if(result)then
		break;
	end

	--进入乱斗房间返回
	local yidongdaozhunbeijiemian={ravenConfig["乱斗房间1"],ravenConfig["乱斗房间2"]}
	local result=sceneJudgment(ravenConfig["乱斗房间返回"][1],ravenConfig["乱斗房间返回"][2],yidongdaozhunbeijiemian,90,4000,overTime1)
	
	if(result==false)then
		dialog("进入“乱斗房间返回”超时异常", 0)
		break
	end
	--mSleep(midSleepTime)	
	
	--进行网络异常处理
	
	
end
















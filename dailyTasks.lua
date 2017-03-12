function moveToLeft(x,y,d)
	touchDown(x, y);    
    for i = 0, d, 40 do   
        touchMove(x - i, y); 
        mSleep(200);        
    end
    touchUp(x - d, y);
end

function slipt(s, p)

    local rt= {}
    string.gsub(s, '[^'..p..']+', function(w) table.insert(rt, w) end )
    return rt

end

function getFormatNetTime()
	current = getNetTime();
	current_text = os.date("%Y:%m:%d %X", current);
	return current_text;
end

function getCurrentHour()
	currentTimeStr=getFormatNetTime()
	h=string.sub(currentTimeStr,12,13)

	return tonumber(h)
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

mSleep(3000);

local sz = require("sz");
local json = sz.json;
local w,h = getScreenSize();
MyTable = {
	["style"] = "default",
  	["width"] = w,
  	["height"] = h,
  	["config"] = "dailyTaskConfig.dat",
  	["rettype"] = "table",
  	["timer"] = 10,
  	views = {
		
		{
            ["type"] = "Label",
            ["text"] = "HOME键位置:",
            ["size"] = 24,
            ["align"] = "center",
            ["color"] = "0,0,255",
            ["width"] = "260",
            ["nowrap"] = "1"
	    },
		{	["id"] ="homeLocation",
            ["type"] = "ComboBox",
            ["list"] = "竖屏在下,横屏在右,横屏在左",
            ["select"] = "0",
            ["width"] = "160"
		},
		{	["id"] ="taskIds",
            ["type"] = "CheckBoxGroup",
            ["list"] = "团队副本,每日探险,公会战",
            ["select"] = "0@1@2",
            ["width"] = "160"
    	},
        
    
	}
}
local MyJsonString = json.encode(MyTable);
local UIret,values = showUI(MyJsonString);
--dialog(ret[3], 0)
mSleep(8000)




--确定横屏竖屏
local homeXY=0; --HOME建位置默认在右

if (UIret == 1) then
	homeXY=values.homeLocation;
	
end


--界面加载完成

--开始加载自定义函数
init('0',homeXY)



local ravenConfigs={
	["r1920_1080"]={
		["每日挑战"]={752,  432, 0xededed },
		["团队副本"]={1125,  374, 0xe6e6e6 },
		["网络连接超时1"]={831,  470, 0xc7a165 },
		["网络连接超时2"]={1264,  489, 0xa78755 },
		["网络连接超时确认"]={1196,  828, 0x6a2614 },
		["网络连接超时游戏重启1"]={1023,  460, 0xb18f5a },
		["网络连接超时游戏重启2"]={1039,  496, 0xc29d62 },
		["网络连接超时游戏重启确认"]={960,  831, 0x672414 },
		["马泰拉寺院是否打完"]={1245,  229, 0x0cc01d },
		["每日探险是否打完"]={421,  225, 0x766e66},
		["马泰拉进入"]={1391,  914, 0x732916 },
		["每日挑战进入"]={529,  914, 0x732916 },
		["马泰拉套装2"]={427,  175, 0xb98e62 },
		["马泰拉自动技能"]={1702,  334, 0x8c0d0d },
		["马泰拉开始探险"]={1395,  947, 0xc29e75 },
		["马泰拉探险结束1"]={1472,  139, 0xd78a14 },
		["马泰拉探险结束2"]={1680,  137, 0xd88c14 },
		["马泰拉探险结束确认"]={1674, 1003, 0x6a2614 },
		["马泰开始探险界面1"]={1706,  711, 0xffd35f },
		["马泰开始探险界面2"]={1751,  710, 0xffd35f},
		["马泰探险是否还有剩余次数"]={489,   50, 0x4d0000},
		["马泰开始探险界面返回"]={115,   51, 0xc86b1f},
		["每日挑战是否已经做完"]={667,  431, 0x10c320},
		["马泰拉成就奖励1"]={667,  431, 0x10c320},
		["马泰拉成就奖励2"]={667,  431, 0x10c320},
		["马泰拉成就奖励关闭"]={1820,  993, 0x190d04},
		
		["团队副本任务是否已做完"]={1013,  365, 0x0cbe1c },
		["单人团队副本次数是否已做完"]={425,  229, 0x0fbc1e },
		["团队副本进入"]={532,  917, 0x712816 },
		["开始团队副本界面1"]={1148,  290, 0xd98c14 },
		["开始团队副本界面2"]={1219,  292, 0xd78b14 },
		["开始团队副本"]={1409,  954, 0x791c05 },
		["每日团队副本界面1"]={1320,  306, 0x3c6317 },
		["每日团队副本界面2"]={1325,  328, 0x48741c },
		["每日团队副本开始战斗"]={1461,  929, 0x642414 },
		["每日团队组队界面1"]={1437,  167, 0xe1934a },
		["每日团队组队界面2"]={1401,  196, 0xa06935 },
		["每日团队组队界面选择队伍2"]={890,  186, 0xcdcdcd },
		["每日团队组队界面自动技能"]={1702,  333, 0x8d0d0d },
		["开始团队副本x0"]={1589,  957, 0x822005 },
		["团队副本成功1"]={521,   55, 0xe09e27 },
		["团队副本成功2"]={595,   58, 0xdd9c26 },
		["团队副本成功回到列表"]={1701,  995, 0x6f2716 },
		["团队副本成就奖励1"]={842, 1000, 0xebebeb },
		["团队副本成就奖励2"]={891, 1004, 0xe4e4e4 },
		["团队副本成就奖励关闭"]={1782,  983, 0x180d04 },
		["每日团队界面返回"]={122,   51, 0xbc641f },
		["每日团队副本滑动起点"]={1686,578, 0x1f1f0f },
		["寻找每日团队副本起点"]={112,  241, 0x705c47 },
		["寻找每日团队副本终点"]={1803,  993, 0x8d7862 },
		["每日团队副本颜色判断点"]={1108,  262, 0x619b28 },
		
		
		
		["每日探险信息界面1"]={281,  796, 0xca8442 },
		["每日探险信息界面2"]={155,  974, 0xcfcfcf },
		["每日探险信息界面困难"]={1661,  595, 0xa41100 },
		["每日探险信息界面准备探险"]={1430,  957, 0x170000 },
		["每日探险进入"]={527,  920, 0x6e2715 },
		["开始探险界面1"]={1255,  953, 0xba966d },
		["开始探险界面2"]={1369,  957, 0xb69169 },
		["开始探险界面套装1"]={343,  181, 0xb2b2b2 },
		["开始探险界面开始探险"]={1454,  955, 0x731a05},
		["开始探险界面自动技能"]={1703,  335, 0x99211e},
		["探险结束1"]={291,  420, 0xda8c14},
		["探险结束1"]={503,  425, 0xd68a14  },
		["探险结束返回主界面"]={220,  999, 0x6d2715 },
		
		["公会"]={1728,  695, 0x383837 },
		["公会主界面"]={208,  188, 0x5b1c13 },
		["公会主界面1"]={1682,  767, 0xc7a47a },
		["公会主界面2"]={1256,  486, 0xd68a13 },
		["公会对战"]={1682,  767, 0xc7a47a},
		["公会战剩余次数"]={208,  188, 0x5b1c13},
		["战争准备界面1"]={1364,  380, 0xcf8513},
		["战争准备界面2"]={1248,  436, 0xe59415},
		["战争准备"]={1423,  939, 0xb9946c},		
		["战争准备关闭奖励"]={1752,  940, 0x1e140e},
		["开始对战"]={1516,  954, 0x7c1d05},
		["开始对战界面1"]={1587,  939, 0xcaa77d},
		["开始对战界面2"]={186,  816, 0xbb976e},
		["推荐配置"]={517,  212, 0x611e12},
		["领取奖励"]={1649,  712, 0x130500},
		["开始对战会战剩余次数"]={651,   39, 0x700000},
		["开始对战关闭奖励"]={1854, 1003, 0x1a1a1a},
		["对战中1"]={950,   23, 0xe5e5e5},
		["对战中2"]={971,   20, 0xebebeb},
		["技能1"]={411,  895, 0x316f8d},
		["技能2"]={586,  902, 0x00070e},
		["技能3"]={902,  904, 0x3497b0},
		["技能4"]={1078,  910, 0x078fc8},
		["技能5"]={1390,  906, 0xad3625},
		["技能6"]={1567,  905, 0xfff5d5},
		["对战结束确认"]={904,  963, 0x6f2715},
		["对战结束1"]={604,  548, 0xe4b06e},
		["对战结束2"]={716,  749, 0xb45d00},
		["对战返回"]={119,   50, 0xc46a1f},

		
	}
	
	
}

local ravenConfig=ravenConfigs["r1920_1080"]

local slowSleep=10000;
local midSleep=7000;
local fastSleep=5000;
local HightS=90;
local lowS=80;
local judgmentOverTime2=150;
local judgmentOverTime1=25;

--每日挑战
function dailyChallenge()
	
	--判断每日挑战任务是否已经做完
	if (not isColor( ravenConfig["每日挑战是否已经做完"][1],  ravenConfig["每日挑战是否已经做完"][2], ravenConfig["每日挑战是否已经做完"][3], lowS)) 
	then
		--每日挑战已经做完，退出方法
		--toast("每日挑战任务已经做完",15);
		--return true;
	end
	
	--进入每日挑战
	mSleep(midSleep);
	tap(ravenConfig["每日挑战"][1],ravenConfig["每日挑战"][2]);
	mSleep(midSleep);
	

	--判断马泰拉寺院是否已经打完，打完了则跳过，没打完继续打。
	if (isColor( ravenConfig["马泰拉寺院是否打完"][1],  ravenConfig["马泰拉寺院是否打完"][2], ravenConfig["马泰拉寺院是否打完"][3], lowS)) 
	then
		--未打完，开始马泰拉任务
		--进入马泰拉
		tap(ravenConfig["马泰拉进入"][1],ravenConfig["马泰拉进入"][2]);
		mSleep(midSleep);
		
		--循环开始探险
		while (true) do
			
			mSleep(midSleep);
			tap(ravenConfig["马泰拉成就奖励关闭"][1],ravenConfig["马泰拉成就奖励关闭"][2]);
			mSleep(fastSleep);
			
			--判断马泰拉是否还有次数，有次数继续循环探险，没有次数则开始退出马泰拉寺院
			if (isColor( ravenConfig["马泰探险是否还有剩余次数"][1],  ravenConfig["马泰探险是否还有剩余次数"][2], ravenConfig["马泰探险是否还有剩余次数"][3], HightS)) 
			then
				--选择套装2
				tap(ravenConfig["马泰拉套装2"][1],ravenConfig["马泰拉套装2"][2]);
				mSleep(fastSleep);
				
				
				
				--判断是否已经开启自动技能，没有则需要开启
				if (isColor( ravenConfig["马泰拉自动技能"][1],  ravenConfig["马泰拉自动技能"][2], ravenConfig["马泰拉自动技能"][3], lowS)) 
				then
					--开启自动技能
					tap(ravenConfig["马泰拉自动技能"][1],ravenConfig["马泰拉自动技能"][2]);
				end
				mSleep(fastSleep);
				
				--开始探险
				tap(ravenConfig["马泰拉开始探险"][1],ravenConfig["马泰拉开始探险"][2]);
				
				--循环判断探险是否结束
				local points={ravenConfig["马泰拉探险结束1"],ravenConfig["马泰拉探险结束2"]}
				local result=sceneJudgment(ravenConfig["马泰拉探险结束确认"][1],ravenConfig["马泰拉探险结束确认"][2],points,HightS,fastSleep,judgmentOverTime2);
				
				--探险结束，判断游戏界面是否返回马泰拉开始探险界面
				local points={ravenConfig["马泰开始探险界面1"],ravenConfig["马泰开始探险界面2"]}
				local result=sceneJudgment(ravenConfig["马泰拉套装2"][1],ravenConfig["马泰拉套装2"][2],points,HightS,fastSleep,judgmentOverTime1);
				--判断是否出现成就奖励，出现则关闭。
				if(not result)
				then
					local points={ravenConfig["马泰拉成就奖励1"],ravenConfig["马泰拉成就奖励2"]}
					local result=sceneJudgment(ravenConfig["马泰拉成就奖励关闭"][1],ravenConfig["马泰拉成就奖励关闭"][2],points,HightS,fastSleep,judgmentOverTime1);
				end
				
			else
				--马泰拉次数已经打完退出寺院，进入每日探险和马泰拉选择界面
				tap(ravenConfig["马泰开始探险界面返回"][1],ravenConfig["马泰开始探险界面返回"][2]);
				toast("马泰拉寺院任务已经做完",15);
				break;
			end
		end
		
		
		
	else
		
	end
	
	--判断每日探险是否已经打完，打完了则跳过，没打完继续打。
	if (not isColor( ravenConfig["每日探险是否打完"][1],  ravenConfig["每日探险是否打完"][2], ravenConfig["每日探险是否打完"][3], lowS)) 
	then
		--未打完，开始每日探险任务
		
		--进入每日探险
		mSleep(fastSleep)
		tap(ravenConfig["每日探险进入"][1],ravenConfig["每日探险进入"][2]);
		
		--进入每日探险信息界面点击“困难”难度
		local points={ravenConfig["每日探险信息界面1"],ravenConfig["每日探险信息界面2"]}
		local result=sceneJudgment(ravenConfig["每日探险信息界面困难"][1],ravenConfig["每日探险信息界面困难"][2],points,HightS,fastSleep,judgmentOverTime1);
		mSleep(fastSleep)
		
		--点击“准备探索”
		tap(ravenConfig["每日探险信息界面准备探险"][1],ravenConfig["每日探险信息界面准备探险"][2]);
		
		--进入开始探险界面点击“套装1”
		local points={ravenConfig["开始探险界面1"],ravenConfig["开始探险界面2"]}
		local result=sceneJudgment(ravenConfig["开始探险界面套装1"][1],ravenConfig["开始探险界面套装1"][2],points,HightS,fastSleep,judgmentOverTime1);
		mSleep(fastSleep)
		
		--判断是否开启自动技能，没有则开启
		if (not isColor( ravenConfig["开始探险界面自动技能"][1],  ravenConfig["开始探险界面自动技能"][2], ravenConfig["开始探险界面自动技能"][3], lowS)) 
		then
			--开启自动技能
			tap(ravenConfig["开始探险界面自动技能"][1],ravenConfig["开始探险界面自动技能"][2]);
			
		end
		mSleep(fastSleep)
		
		--点击“开始探险”
		tap(ravenConfig["开始探险界面开始探险"][1],ravenConfig["开始探险界面开始探险"][2]);
		
		--判断探险是否已经结束
		local points={ravenConfig["探险结束1"],ravenConfig["探险结束2"]}
		local result=sceneJudgment(ravenConfig["探险结束返回主界面"][1],ravenConfig["探险结束返回主界面"][2],points,HightS,fastSleep,judgmentOverTime2);
		mSleep(fastSleep)
		
		
	else
		--返回游戏主界面
		tap(ravenConfig["每日团队界面返回"][1],ravenConfig["每日团队界面返回"][2]);
		mSleep(midSleep);
		tap(ravenConfig["每日团队界面返回"][1],ravenConfig["每日团队界面返回"][2]);
	end
	
	toast("每日挑战任务已经做完",15);
	return true;


	

end



--团队副本
function TeamCopy()
	--判断团队副本任务是否已经做完
	if (not isColor( ravenConfig["团队副本任务是否已做完"][1],  ravenConfig["团队副本任务是否已做完"][2], ravenConfig["团队副本任务是否已做完"][3], lowS)) 
	then
		
		toast("团队副本任务已经做完",15);
		return true;
	end
	
	--进入团队副本
	tap(ravenConfig["团队副本"][1],ravenConfig["团队副本"][2]);
	mSleep(midSleep);
	
	--判断单人团队副本任务是否已经做完
	if (not isColor( ravenConfig["单人团队副本次数是否已做完"][1],  ravenConfig["单人团队副本次数是否已做完"][2], ravenConfig["单人团队副本次数是否已做完"][3], lowS)) 
	then
		--单人团队副本已经做完，退出方法
		--团队副本已经做完，退出方法
		tap(ravenConfig["每日团队界面返回"][1],ravenConfig["每日团队界面返回"][2]);
		mSleep(midSleep);
		toast("单人团队副本任务已经做完",15);
		return true;
	end
	
	
	--进入单人团队副本
	tap(ravenConfig["团队副本进入"][1],ravenConfig["团队副本进入"][2]);
	mSleep(midSleep);
	
	while (true) do
		
		mSleep(midSleep)
		tap(ravenConfig["团队副本成就奖励关闭"][1],ravenConfig["团队副本成就奖励关闭"][2]);
		
		--团队副本界面点击“开始团队副本”按钮
		local points={ravenConfig["开始团队副本界面1"],ravenConfig["开始团队副本界面2"]}
		local result=sceneJudgment(ravenConfig["开始团队副本"][1],ravenConfig["开始团队副本"][2],points,HightS,fastSleep,judgmentOverTime1);
		mSleep(midSleep)
		
		--向左滑动屏幕，使每日团队副本出现在右边
		moveToLeft(ravenConfig["每日团队副本滑动起点"][1],ravenConfig["每日团队副本滑动起点"][2],1600);
		
		mSleep(fastSleep)
		--根据颜色判断每日副本，返回颜色坐标。然后根据相对位置寻找“开始战斗”坐标点
		x, y = findColorInRegionFuzzy(ravenConfig["每日团队副本颜色判断点"][3], 95,  ravenConfig["寻找每日团队副本起点"][1],ravenConfig["寻找每日团队副本起点"][2], ravenConfig["寻找每日团队副本终点"][1],ravenConfig["寻找每日团队副本终点"][2]); 
		if x ~= -1 and y ~= -1 
		then
			--寻找开始战斗的相对位置坐标点
			tap(x,y+660);
		else
			--团队副本任务完成，返回游戏主界面
			tap(ravenConfig["每日团队界面返回"][1],ravenConfig["每日团队界面返回"][2]);
			mSleep(midSleep);
			tap(ravenConfig["每日团队界面返回"][1],ravenConfig["每日团队界面返回"][2]);
			mSleep(midSleep);
			tap(ravenConfig["每日团队界面返回"][1],ravenConfig["每日团队界面返回"][2]);
			toast("每日团队副本任务已经做完",15);
			break;
		end
	
		
		
		
		
		
		--进入队友变更界面，点击组队配置“2”
		local points={ravenConfig["每日团队组队界面1"],ravenConfig["每日团队组队界面2"]}
		local result=sceneJudgment(ravenConfig["每日团队组队界面选择队伍2"][1],ravenConfig["每日团队组队界面选择队伍2"][2],points,HightS,fastSleep,judgmentOverTime1);
		
		--判断是否开启自动技能，没有则开启自动技能
		mSleep(fastSleep);
		if (isColor( ravenConfig["每日团队组队界面自动技能"][1],  ravenConfig["每日团队组队界面自动技能"][2], ravenConfig["每日团队组队界面自动技能"][3], lowS)) 
		then
			tap(ravenConfig["每日团队组队界面自动技能"][1],ravenConfig["每日团队组队界面自动技能"][2]);
		end
		
		--开始进入战斗
		mSleep(fastSleep);
		tap(ravenConfig["开始团队副本x0"][1],ravenConfig["开始团队副本x0"][2]);
		
		
		--判断团队副本是否打完
		local points={ravenConfig["团队副本成功1"],ravenConfig["团队副本成功2"]}
		local result=sceneJudgment(ravenConfig["团队副本成功回到列表"][1],ravenConfig["团队副本成功回到列表"][2],points,HightS,fastSleep,judgmentOverTime2);
		
		--判断是否已经返回开始团队副本界面，有成就奖励则关闭
		local points={ravenConfig["团队副本成就奖励1"],ravenConfig["团队副本成就奖励2"]}
		local result=sceneJudgment(ravenConfig["团队副本成就奖励关闭"][1],ravenConfig["团队副本成就奖励关闭"][2],points,HightS,fastSleep,judgmentOverTime1);
		
		
		
	end
	
	
	
end

--公会战
function guildWar()
	mSleep(fastSleep);
	tap(ravenConfig["公会"][1],ravenConfig["公会"][2]);
	
	--进入公会主界面
	local points={ravenConfig["公会主界面1"],ravenConfig["公会主界面2"]}
	local result=sceneJudgment(ravenConfig["公会主界面"][1],ravenConfig["公会主界面"][2],points,HightS,fastSleep,judgmentOverTime1);
	mSleep(midSleep)
	
	--判断公会战剩余次数
	if (not isColor( ravenConfig["公会战剩余次数"][1],  ravenConfig["公会战剩余次数"][2], ravenConfig["公会战剩余次数"][3], lowS)) 
	then
		tap(ravenConfig["对战返回"][1],ravenConfig["对战返回"][2]);	
		mSleep(midSleep);
		toast("工会战任务已经做完",15);
		return true;
	end
	
	--点击“公会对战”
	tap(ravenConfig["公会对战"][1],ravenConfig["公会对战"][2]);	
	
	--进入公会战准备主界面
	local points={ravenConfig["战争准备界面1"],ravenConfig["战争准备界面2"]}
	local result=sceneJudgment(ravenConfig["战争准备关闭奖励"][1],ravenConfig["战争准备关闭奖励"][2],points,HightS,fastSleep,judgmentOverTime1);
	mSleep(midSleep)
	
	--点击“战争准备”
	tap(ravenConfig["战争准备"][1],ravenConfig["战争准备"][2]);	
	
	
	
	
	--循环判断
	while (true) do
		
		mSleep(midSleep)
		--关闭奖励
		tap(ravenConfig["开始对战关闭奖励"][1],ravenConfig["开始对战关闭奖励"][2]);	
		mSleep(midSleep)
		
		--进入开始对战界面
		local points={ravenConfig["开始对战界面1"],ravenConfig["开始对战界面2"]}
		local result=sceneJudgment(ravenConfig["推荐配置"][1],ravenConfig["推荐配置"][2],points,HightS,fastSleep,judgmentOverTime1);
		mSleep(midSleep)
		
		
		--判断会战剩余次数
		if (not isColor( ravenConfig["开始对战会战剩余次数"][1],  ravenConfig["开始对战会战剩余次数"][2], ravenConfig["开始对战会战剩余次数"][3], lowS)) 
		then
			

			tap(ravenConfig["对战返回"][1],ravenConfig["对战返回"][2]);	
			mSleep(midSleep);
			tap(ravenConfig["对战返回"][1],ravenConfig["对战返回"][2]);	
			mSleep(midSleep);
			tap(ravenConfig["对战返回"][1],ravenConfig["对战返回"][2]);	

			
			toast("工会战任务已经做完",15);
			return true;
		end
		
		--领取奖励
		tap(ravenConfig["领取奖励"][1],ravenConfig["领取奖励"][2]);	
		mSleep(midSleep)
		
		--开始对战
		tap(ravenConfig["开始对战"][1],ravenConfig["开始对战"][2]);	
		
		
		--对战中
		while (true) do
			local complete=false;
			if ( isColor( ravenConfig["对战中1"][1],  ravenConfig["对战中1"][2], ravenConfig["对战中1"][3], HightS) and
				isColor( ravenConfig["对战中2"][1],  ravenConfig["对战中2"][2], ravenConfig["对战中2"][3], HightS)
				) 
			then
				toast("对战中...",15);
				while (true) do
					if ( isColor( ravenConfig["对战结束1"][1],  ravenConfig["对战结束1"][2], ravenConfig["对战结束1"][3], HightS) and
						isColor( ravenConfig["对战结束2"][1],  ravenConfig["对战结束2"][2], ravenConfig["对战结束2"][3], HightS)
						) 
					then
						--确认结束
						toast("对战结束确认...",15);
						tap(ravenConfig["对战结束确认"][1],ravenConfig["对战结束确认"][2]);	
						complete=true;
						break;
						
					else
						toast("释放技能中...",15);
						--释放技能
						tap(ravenConfig["技能1"][1],ravenConfig["技能1"][2]);	
						mSleep(500)
						tap(ravenConfig["技能2"][1],ravenConfig["技能2"][2]);	
						mSleep(500)
						tap(ravenConfig["技能3"][1],ravenConfig["技能3"][2]);	
						mSleep(500)
						tap(ravenConfig["技能4"][1],ravenConfig["技能4"][2]);	
						mSleep(500)
						tap(ravenConfig["技能5"][1],ravenConfig["技能5"][2]);	
						mSleep(500)
						tap(ravenConfig["技能6"][1],ravenConfig["技能6"][2]);	
						mSleep(500)
					end

				end
				
			else
				mSleep(2000)
			end
			
			if(complete)
			then
				toast("对战结束...",15);
				break;
				
			end
			
		end
		

		--进入开始对战界面
		local points={ravenConfig["开始对战界面1"],ravenConfig["开始对战界面2"]}
		local result=sceneJudgment(ravenConfig["推荐配置"][1],ravenConfig["推荐配置"][2],points,HightS,fastSleep,judgmentOverTime1);
		mSleep(midSleep)
		
		
		
	end
	
	
	
	
	
end



local taskIds="0@1@2";

if (UIret == 1) then
	taskIds=values.taskIds;
else
	
end

if(taskIds.find(taskIds,"0"))then
	
--团队副本任务开始
TeamCopy();
end

if(taskIds.find(taskIds,"1"))then
	
--每日挑战任务开始
dailyChallenge();
end

if(taskIds.find(taskIds,"2"))then
	
--公会乱斗
guildWar();
end



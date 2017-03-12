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
            ["text"] = "竞技场次数:",
            ["size"] = 24,
            ["align"] = "center",
            ["color"] = "0,0,255",
            ["width"] = "260",
            ["nowrap"] = "1"
	    },
	
        {
            ["type"] = "Edit",
            ["prompt"] = "竞技场次数",
            ["text"] = 19,
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
            ["select"] = "0",
            ["width"] = "160"
		},
        
    
	}
}
local MyJsonString = json.encode(MyTable);
ret = {showUI(MyJsonString)}
--dialog(ret[3], 0)
mSleep(12000)

--竞技场循环次数
num=19
if(ret[2]~=nil )then
	num=ret[2]
end


--确定横屏竖屏
homeXY=0; --HOME建位置默认在右
if(ret[3]~=nil )then
	homeXY=ret[3]
end

--界面加载完成

--开始加载自定义函数
init('0',homeXY)


function tap(x,y)
	touchDown(x,y)
	mSleep(50)
	touchUp(x,y)
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

--加载配置文件
ravenConfigs={
		["r720_1280"]={
			["HOME角斗场"]={1000,  560, 0x1b394b },
			["角斗场"]={340,  615, 0x997c4e },
			["角斗场记录关闭奖励"]={1238,  672, 0x201206 },
			["角斗场记录战争准备"]={1085,  637, 0x422e0c },
			["角斗场记录战争成就1"]={290,  549, 0xefefef },
			["角斗场记录战争成就2"]={321,  551, 0xebebeb },
			["角斗场记录战争准备1"]={1119,  632, 0xceac81 },
			["角斗场记录战争准备2"]={1145,  630, 0xd1b084 },
			["角斗场记录入场券"]={1145,  630, 0xd1b084 },
			["开始对战"]={937,  635, 0xbb966e },
			["开始对战领取奖励"]={1604,  720, 0x110400},
			["开始对战1"]={837,  635, 0xbb976e  },
			["开始对战2"]={920,  628, 0xc7a57a  },
			["对战开始准备1"]={1008,  672, 0x331100 },
			["对战开始准备2"]={723,  436, 0xaa3300 },
			["对战开始准备3"]={606,  335, 0xcc6622 },
			["对战结束1"]={457,  572, 0xc59600 },
			["对战结束2"]={461,  572, 0xc59600 },
			["对战结束奖励"]={1008,  597, 0xbc7b00 },
			["对战结束确认"]={1027,  649, 0x682514 },
			["对战中血瓶"]={1194,  292, 0x8e141d},
			["对战中贫血1"]={367,   57, 0x444444  },
			["对战中贫血2"]={365,   78, 0x191e1d  }
		},
		
		["r1920_1080"]={
			["HOME角斗场"]={1500,  850, 0xa2a2a2 },
			["角斗场"]={520,  922, 0x652414 },
			["角斗场记录关闭奖励"]={1861, 1010, 0x211206 },
			["角斗场记录战争准备"]={1634,  977, 0x160000 },
			["角斗场记录战争成就1"]={1709,  988, 0xbc956b },
			["角斗场记录战争成就2"]={1751,  983, 0xbc956b },
			["角斗场记录战争准备1"]={1678,  949, 0xcdab80 },
			["角斗场记录战争准备2"]={1726,  946, 0xd0af83 },
			["角斗场记录入场券"]={636,   52, 0x281f19},
			["开始对战"]={1415,  956, 0xb08c64 },
			["开始对战领取奖励"]={1604,  720, 0x110400},
			["开始对战1"]={1255,  953, 0xba966d  },
			["开始对战2"]={1380,  943, 0xc6a479  },
			["对战开始准备1"]={865,  514, 0xcc5511 },
			["对战开始准备2"]={978,  529, 0xffddc4 },
			["对战开始准备3"]={1511, 1009, 0x331100 },
			["对战结束1"]={305,   74, 0xdc8e14},
			["对战结束2"]={523,   83, 0xd68a14 },
			["对战结束奖励"]={1488,  902, 0x67544e },
			["对战结束确认"]={1580,  970, 0x6c5737 },
			["对战中血瓶"]={1792,  440, 0x80130f},
			["对战中贫血1"]={545,   87, 0x444444  },
			["对战中贫血2"]={545,  110, 0x222222  },
			["自动技能"]={1702,  334, 0x8c0d0d},
			
		}
	}

ravenConfig={}

if(w==720 and h==1280)
then
	ravenConfig=ravenConfigs["r720_1280"]

elseif(w==1080 and h==1920)
then

	ravenConfig=ravenConfigs["r1920_1080"]
elseif(w==1920 and h==1080)
then

	ravenConfig=ravenConfigs["r1920_1080"]
else

	ravenConfig=ravenConfigs["r1920_1080"]
end	


sleepTime=3000
fastSleepTime=1000
midSleepTime=2000
slowSleepTime=6000

--竞技场自动加血
function addLife()
	
	if (isColor( ravenConfig["对战中贫血1"][1],  ravenConfig["对战中贫血1"][2], ravenConfig["对战中贫血1"][3], 85) and 
				isColor( ravenConfig["对战中贫血2"][1],  ravenConfig["对战中贫血2"][2], ravenConfig["对战中贫血2"][3], 85)) 
	then
			tap(ravenConfig["对战中血瓶"][1], ravenConfig["对战中血瓶"][2])
			--dialog("加血", 0)
	else
			--dialog("没加血", 0)
			mSleep(1500)
	end	

end



--进入竞技场记录界面，还未开始战斗
function enterArena()
	tap(ravenConfig["HOME角斗场"][1], ravenConfig["HOME角斗场"][2])--进入角斗场和乱斗场选择界面
	mSleep(sleepTime)

	tap(ravenConfig["角斗场"][1], ravenConfig["角斗场"][2])--进入角斗场记录界面
	mSleep(sleepTime)

end

function cycleStartPlay(n)
	
	
	for i=1,n,1 do
		
		mSleep(slowSleepTime)
		tap(ravenConfig["角斗场记录关闭奖励"][1], ravenConfig["角斗场记录关闭奖励"][2])--进入战争准备界面
		mSleep(midSleepTime)

		tap(ravenConfig["角斗场记录战争准备"][1], ravenConfig["角斗场记录战争准备"][2])--进入战争准备界面
		mSleep(slowSleepTime)

		while (true) do
			if (isColor( ravenConfig["开始对战1"][1],  ravenConfig["开始对战1"][2], ravenConfig["开始对战1"][3], 95) and 
				isColor( ravenConfig["开始对战2"][1],  ravenConfig["开始对战2"][2], ravenConfig["开始对战2"][3], 95) 
				) 
			then
				mSleep(sleepTime)
				--判断是否开启自动技能
				if (isColor( ravenConfig["自动技能"][1],  ravenConfig["自动技能"][2], ravenConfig["自动技能"][3], 85))
				then
					tap(ravenConfig["自动技能"][1], ravenConfig["自动技能"][2])--开启自动技能
					mSleep(sleepTime)
				end
				
				tap(ravenConfig["开始对战领取奖励"][1], ravenConfig["开始对战领取奖励"][2])--领取奖励
				mSleep(sleepTime)
				tap(ravenConfig["开始对战"][1], ravenConfig["开始对战"][2])--进入战争准备界面
				break
			else
				mSleep(fastSleepTime)
			end
		end
		
		mSleep(slowSleepTime)


		--1对战开始前需要点击界面开始角斗
		while (true) do
			
			
			
			if (isColor( ravenConfig["对战开始准备1"][1],  ravenConfig["对战开始准备1"][2], ravenConfig["对战开始准备1"][3], 95) and 
				isColor( ravenConfig["对战开始准备2"][1],  ravenConfig["对战开始准备2"][2], ravenConfig["对战开始准备2"][3], 95) and
				isColor( ravenConfig["对战开始准备3"][1],  ravenConfig["对战开始准备3"][2], ravenConfig["对战开始准备3"][3], 95)
				) 
			then
				mSleep(midSleepTime)
				tap(500,500)
				break
			else
				mSleep(sleepTime)
			end
			
			
		end

		--2比赛结束点击确认结果
		while (true) do
			
			
			if (isColor( ravenConfig["对战结束1"][1],  ravenConfig["对战结束1"][2], ravenConfig["对战结束1"][3], 90) and 
				isColor( ravenConfig["对战结束2"][1],  ravenConfig["对战结束2"][2], ravenConfig["对战结束2"][3], 90)) 
			then
				mSleep(midSleepTime)
				tap(ravenConfig["对战结束奖励"][1],  ravenConfig["对战结束奖励"][2])
				mSleep(midSleepTime)
				tap(ravenConfig["对战结束确认"][1],  ravenConfig["对战结束确认"][2])
				break
			else
				
				addLife()
				--mSleep(midSleepTime)
			end	
		end
		
		--3判断比赛结束是否已经返回准备界面
		while (true) do
			if (isColor( ravenConfig["角斗场记录战争成就1"][1],  ravenConfig["角斗场记录战争成就1"][2], ravenConfig["角斗场记录战争成就1"][3], 90) and 
				isColor( ravenConfig["角斗场记录战争成就2"][1],  ravenConfig["角斗场记录战争成就2"][2], ravenConfig["角斗场记录战争成就2"][3], 90))
			then
				mSleep(midSleepTime)
				tap(ravenConfig["角斗场记录关闭奖励"][1], ravenConfig["角斗场记录关闭奖励"][2])
				break
			else if(isColor( ravenConfig["角斗场记录战争准备1"][1],  ravenConfig["角斗场记录战争准备1"][2], ravenConfig["角斗场记录战争准备1"][3], 90) and 
				   isColor( ravenConfig["角斗场记录战争准备2"][1],  ravenConfig["角斗场记录战争准备2"][2], ravenConfig["角斗场记录战争准备2"][3], 90))
			then	
				break
			else
				mSleep(midSleepTime)
			end
		end	
		
		
	end
	
	
	end


end



--进入竞技场
enterArena()

--进入竞技场循环准备比赛
cycleStartPlay(num)
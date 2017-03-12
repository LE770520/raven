    local sz = require("sz")
    local json = sz.json
    w,h = getScreenSize();
    MyTable = {
        ["style"]        = "default",
        ["rettype"]      = "table",
        ["width"]        = w,
        ["height"]       = h,
        ["config"]       = "save_01.dat",
        ["timer"]        = 99,
        ["orient"]       = 0,
        ["pagetype"]     = "multi",
        ["title"]        = "触动精灵脚本UI演示",
        ["cancelname"]   = "取消",
        ["okname"]       = "开始",
        pages            =
        {
            {
                {
                    ["type"] = "Label",
                    ["text"] = "第一页设置",
                    ["size"] = 25,
                    ["align"] = "center",
                    ["color"] = "0,0,0",
                },
                {
                    ["id"] = "a01",
                    ["type"] = "RadioGroup",
                    ["list"] = "选项1,选项2,选项3,选项4,选项5,选项6,选项7",
                    ["select"] = "1",
                },
                {
                    ["type"] = "Label",
                    ["text"] = "请选择",
                    ["width"] = 100,
                    ["nowrap"] = 1,
                },
                {
                    ["id"] = "year",
                    ["type"] = "Edit",
                    ["width"] = 100,
                    ["prompt"] = "年",
                    ["text"] = "1900",
                    ["kbtype"] = "number",
                    ["nowrap"] = 1,
                },
                {
                    ["type"] = "Label",
                    ["text"] = "年",
                    ["width"] = 30,
                    ["nowrap"] = 1,
                },
                {
                    ["id"] = "mon",
                    ["type"] = "ComboBox",
                    ["width"] = 130,
                    ["list"] = "一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月",
                    ["select"] = "1",
                    ["nowrap"] = 1,
                },
                {
                    ["type"] = "Label",
                    ["text"] = "月",
                    ["width"] = 30,
                    ["nowrap"] = 1,
                },
                {
                    ["id"] = "day",
                    ["type"] = "ComboBox",
                    ["width"] = 110,
                    ["list"] = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31",
                    ["select"] = "1",
                    ["nowrap"] = 1,
                },
                {
                    ["type"] = "Label",
                    ["text"] = "日",
                    ["width"] = 30,
                },
                {
                    ["type"] = "Label",
                    ["text"] = "请选择性别:",
                    ["width"] = 170,
                    ["nowrap"] = 1,
                },
                {
                    ["id"] = "sex",
                    ["type"] = "RadioGroup",
                    ["list"] = "男,女,人妖",
                    ["select"] = "1",
                },
            },{
                {
                    ["type"] = "Label",
                    ["text"] = "第二页设置",
                    ["size"] = 25,
                    ["align"] = "center",
                    ["color"] = "0,0,0",
                },
                {
                    ["id"] = "edit01",
                    ["type"] = "Edit",
                    ["prompt"] = "请输入一个字母",
                    ["text"] = "默认值",
                    ["kbtype"] = "ascii",
                },
                {
                    ["id"] = "edit02",
                    ["type"] = "Edit",
                    ["prompt"] = "请输入一个数字",
                    ["text"] = "默认值",
                    ["kbtype"] = "number",
                },
                {
                    ["type"] = "Label",
                    ["text"] = "请选择兵种",
                    ["size"] = 25,
                    ["align"] = "center",
                    ["color"] = "0,0,0",
                },
                {
                    ["id"] = "arm",
                    ["type"] = "CheckBoxGroup",
                    ["list"] = "兵种1,兵种2,兵种3,兵种4,兵种5,兵种6,兵种7,兵种8,兵种9,兵种10,兵种11,兵种12",
                    ["images"] = "a.png,b.png,c.png,d.png,e.png,f.png,g.png,h.png,i.png,j.png,k.png,l.png",
                    ["select"] = "3@5",
                    ["scale"] = 0.4,
                },
            },{
                {
                    ["type"] = "Label",
                    ["text"] = "第三页设置",
                    ["size"] = 25,
                    ["align"] = "center",
                    ["color"] = "0,0,0",
                },
                {
                    ["id"] = "a02",
                    ["type"] = "CheckBoxGroup",
                    ["list"] = "选项1,选项2,选项3,选项4,选项5,选项6,选项7",
                    ["select"] = "3@5",
                },
                {
                    ["id"] = "cb01",
                    ["type"] = "ComboBox",
                    ["list"] = "选项1,选项2,选项3",
                    ["select"] = "1",
                    ["data"] = "子选项1,子选项2,子选项3,子选项4#子选项5,子选项6,子选项7#子选项8,子选项9",
                    ["source"] = "test"
                },
                {
                    ["id"] = "cb02",
                    ["type"] = "ComboBox",
                    ["select"] = "1",
                    ["dataSource"] = "test"
                },
            }
        }   
    }
    local MyJsonString = json.encode(MyTable);
    UIret,values = showUI(MyJsonString)
	mSleep(4000)
    if UIret == 1 then
		dialog(values.year, 0);
        nLog("年:"..values.year)
        nLog("月:"..values.mon)
        nLog("日:"..values.day)
    end
	
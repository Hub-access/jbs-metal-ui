-- JBS 91 / 78 · native pink-purple metal grille
-- Generated from tools/build_ui.py. Install as a LocalScript in StarterPlayerScripts.
-- UI selection only. This project has no game callbacks or RemoteEvents.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
assert(player, "请在客户端 LocalScript 中运行")
local playerGui = player:WaitForChild("PlayerGui")
local previous = playerGui:FindFirstChild("JBS_91_78_Showcase")
if previous then previous:Destroy() end
-- INSERT_SCENE
local colorCache={}
local function rgb(hex)
 if not colorCache[hex] then colorCache[hex]=Color3.fromHex(hex:gsub("#", "")) end
 return colorCache[hex]
end
local P = scene.palette
local WHITE = Color3.new(1,1,1)
local function make(class, properties, parent)
 local object = Instance.new(class)
 for key, value in pairs(properties) do object[key] = value end
 object.Parent = parent
 return object
end
local function corner(object, radius) make("UICorner", {CornerRadius=UDim.new(0,radius)}, object) end
local function gradient(object, stops, rotation)
 local keys = {}
 for _, stop in ipairs(stops) do keys[#keys+1] = ColorSequenceKeypoint.new(stop[1],rgb(stop[2])) end
 return make("UIGradient",{Color=ColorSequence.new(keys),Rotation=rotation or 0},object)
end
local function stroke(object, color, thickness, transparency)
 return make("UIStroke",{Color=rgb(color),Thickness=thickness or 1,Transparency=transparency or 0,ApplyStrokeMode=Enum.ApplyStrokeMode.Border},object)
end
local function frame(parent,name,x,y,w,h,color,r,z,alpha)
 local o=make("Frame",{Name=name,Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),BackgroundColor3=rgb(color or P.base),BackgroundTransparency=alpha or 0,BorderSizePixel=0,Active=false,ZIndex=z or 1},parent)
 if r then corner(o,r) end
 return o
end
local function label(parent,name,text,x,y,w,h,size,color,bold,z)
 return make("TextLabel",{Name=name,Text=text,Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),BackgroundTransparency=1,BorderSizePixel=0,Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham,TextSize=size,TextColor3=rgb(color or P.white),TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,TextWrapped=false,Active=false,Selectable=false,ZIndex=z or 5},parent)
end
local function button(parent,name,x,y,w,h,r)
 local b=make("TextButton",{Name=name,Text="",Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),BackgroundTransparency=1,BorderSizePixel=0,AutoButtonColor=false,Selectable=true,ClipsDescendants=true,ZIndex=5},parent)
 if r then corner(b,r) end
 return b
end
local connections, tweens, temporaries = {}, {}, {}
local destroyed=false
local function connect(event,callback)
 local c=event:Connect(callback);connections[#connections+1]=c;return c
end
local function tween(object, properties, duration, delay)
 local t=TweenService:Create(object,TweenInfo.new(duration or .22,Enum.EasingStyle.Quart,Enum.EasingDirection.Out,0,false,delay or 0),properties)
 tweens[t]=true
 t.Completed:Once(function() tweens[t]=nil end)
 t:Play();return t
end
local gui=make("ScreenGui",{Name="JBS_91_78_Showcase",ResetOnSpawn=false,DisplayOrder=30,ScreenInsets=Enum.ScreenInsets.CoreUISafeInsets,ZIndexBehavior=Enum.ZIndexBehavior.Sibling},playerGui)
local viewport=frame(gui,"Viewport",0,0,0,0,P.base,nil,1,1)
viewport.Size=UDim2.fromScale(1,1)
local canvas=frame(viewport,"ReferenceCanvas",0,0,1016,726,P.base,nil,1,1)
canvas.Position=UDim2.fromScale(.5,.5);canvas.AnchorPoint=Vector2.new(.5,.5)
local scale=make("UIScale",{Scale=1},canvas)
local expanded=false
local function fit()
 local size=viewport.AbsoluteSize
 scale.Scale=math.max(.05,math.min((size.X-44)/1016,(size.Y-44)/726,expanded and 1.6 or 1.2))
end
connect(viewport:GetPropertyChangedSignal("AbsoluteSize"),fit);fit()
-- A CanvasGroup gives the whole window a clipped rounded composition and a real reveal.
local shell=make("CanvasGroup",{Name="Window",Size=UDim2.fromOffset(1016,726),BackgroundColor3=WHITE,BorderSizePixel=0,GroupTransparency=1,ClipsDescendants=true,ZIndex=2},canvas)
corner(shell,28)
local shellMetal=gradient(shell,{{0,"#64245D"},{.3,P.panel},{.58,P.base},{1,"#572476"}},30)
local rim=stroke(shell,P.white,1.5,.08)
local metalStops={{0,"#8B439F"},{.28,P.pink},{.43,P.pearl},{.49,P.white},{.53,"#562168"},{.7,P.violet},{1,"#D777D1"}}
local rimGradient=gradient(rim,metalStops,25)
local glows={}
for i,thickness in ipairs({16,9,4}) do
 local g=frame(canvas,"AmbientRim"..i,0,0,1016,726,P.base,28,1,1)
 local s=stroke(g,P.pink,thickness,.96-i*.025)
 glows[#glows+1]={object=g,stroke=s}
end
local inner=frame(shell,"InnerEdge",5,5,1006,716,P.base,23,2,1);stroke(inner,P.pearl,1,.78)
local headerLine=frame(shell,"HeaderLine",28,93,960,1,P.pearl,nil,3,.82)
local logo=label(shell,"HeaderJBS","JBS",28,21,89,52,43,P.white,true)
logo.TextColor3=WHITE
local logoGradient=gradient(logo,{{0,"#B36DCC"},{.25,P.pink},{.41,P.pearl},{.47,P.white},{.51,"#642075"},{.66,"#F38CD9"},{1,P.pearl}},15)
label(shell,"Title","JBS 力量传奇",135,24,320,26,20,P.white,true)
label(shell,"Tribe","部落 ID · 91 / 78",135,53,300,19,12,P.pearl)
for i=0,15 do
 local slat=frame(shell,"HeaderMetal",618+i*12,27,1,39,P.pearl,nil,3,.62)
 gradient(slat,{{0,"#69256C"},{.43,P.pink},{.5,P.white},{.59,"#713087"},{1,P.pearl}},75)
end
local minimize=button(shell,"Minimize",858,28,32,32,8)
local expand=button(shell,"Expand",902,28,32,32,8)
local close=button(shell,"Close",946,28,32,32,8)
label(minimize,"Glyph","—",6,0,26,30,20,P.pearl)
label(expand,"Glyph","□",7,0,26,30,22,P.pearl)
label(close,"Glyph","×",8,0,24,30,26,P.pearl)
local side=frame(shell,"Sidebar",13,94,350,619,P.panel,18,3,1)
local content=frame(shell,"Content",375,94,628,619,P.panel,18,3)
content.BackgroundColor3=WHITE;content.ClipsDescendants=true
local contentMetal=gradient(content,{{0,"#74286D"},{.45,"#2C103F"},{1,"#5D257C"}},34)
stroke(content,P.pearl,1,.38)
-- The glyph prototype is reused; one shared render loop controls spatial reflection.
-- All marks remain upright. Safe inset keeps their bounds inside the rounded corners.
local glyphs={}
local prototype=label(nil,"JBSMetalMark","JBS",0,0,29,17,scene.pattern.size,P.white,true,2)
prototype.TextColor3=WHITE
local protoGradient=gradient(prototype,{{0,"#A663BB"},{.27,"#F4AFE2"},{.42,P.white},{.49,"#7A398F"},{.67,"#BD76DE"},{1,"#EC97D6"}},90)
local function pattern(parent,w,h,opacity)
 local material=frame(parent,"BrandMaterial",0,0,w,h,P.base,nil,1,1)
 material.ClipsDescendants=true
 for row=0,math.floor((h-30)/28) do
  local y=12+row*28
  for col=0,math.floor(w/42) do
   local x=12+col*42+(row%2)*21
   if x+29<w-12 then
    local glyph=prototype:Clone();glyph.Position=UDim2.fromOffset(x,y);glyph.TextTransparency=1-opacity;glyph.Parent=material
    glyphs[#glyphs+1]={object=glyph,x=x,y=y,width=w,base=opacity}
   end
  end
 end
end
pattern(side,350,619,.29);pattern(content,628,619,.65);prototype:Destroy()
local searchMaterial=frame(side,"SearchMaterial",8,0,334,70,P.white,17,4)
searchMaterial.BackgroundColor3=WHITE
gradient(searchMaterial,{{0,"#542354"},{1,P.panel}},25)
stroke(searchMaterial,P.pearl,1,.55)
local search=make("TextBox",{Name="Search",PlaceholderText="搜索功能",Text="",ClearTextOnFocus=false,Position=UDim2.fromOffset(8,0),Size=UDim2.fromOffset(334,70),BackgroundTransparency=1,BackgroundColor3=WHITE,BorderSizePixel=0,TextColor3=rgb(P.white),PlaceholderColor3=rgb(P.pearl),Font=Enum.Font.Gotham,TextSize=18,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5},side)
corner(search,17)
make("UIPadding",{PaddingLeft=UDim.new(0,24),PaddingRight=UDim.new(0,18)},search)
for i=1,#scene.navigation do
 local backing=frame(side,"NavigationBacking",8,90+(i-1)*72,334,57,P.panel,12,3,.08)
end
local selection=frame(side,"SelectedNavigation",8,90,334,57,P.white,12,4)
selection.BackgroundColor3=WHITE;gradient(selection,{{0,"#E73CBD"},{.7,P.violet},{1,"#7F33D0"}},15);stroke(selection,P.white,1,.48)
local selectionGlow=frame(selection,"LightStrip",0,15,3,26,P.white,2,5)
local menuButtons={}
-- Consistent lightweight vector icons. These are UI symbols, with no external assets.
local function line(parent,x1,y1,x2,y2,color,width)
 local dx,dy=x2-x1,y2-y1
 local o=frame(parent,"IconStroke",(x1+x2)/2,(y1+y2)/2,math.sqrt(dx*dx+dy*dy),width or 1.6,color,1,6)
 o.AnchorPoint=Vector2.new(.5,.5);o.Rotation=math.deg(math.atan2(dy,dx));return o
end
local function icon(parent,kind,x,y)
 local p=frame(parent,"Icon",x,y,24,24,P.base,nil,6,1)
 local paths={bolt={{13,2,4,14},{4,14,11,14},{11,14,10,22},{10,22,20,9},{20,9,13,9},{13,9,13,2}},weight={{7,12,17,12},{4,7,4,17},{7,5,7,19},{17,5,17,19},{20,7,20,17}},pin={{4,9,12,3},{12,3,20,9},{20,9,18,15},{18,15,12,22},{12,22,6,15},{6,15,4,9}},pet={{4,9,3,3},{3,3,9,6},{9,6,15,6},{15,6,21,3},{21,3,20,16},{20,16,16,20},{16,20,8,20},{8,20,4,16},{4,16,4,9},{8,12,8,13},{16,12,16,13},{10,16,12,18},{12,18,14,16}},crown={{3,6,8,11},{8,11,12,3},{12,3,16,11},{16,11,21,6},{21,6,19,19},{19,19,5,19},{5,19,3,6},{6,16,18,16}},spark={{12,2,15,9},{15,9,22,12},{22,12,15,15},{15,15,12,22},{12,22,9,15},{9,15,2,12},{2,12,9,9},{9,9,12,2}}}
 for _,v in ipairs(paths[kind] or paths.spark) do line(p,v[1],v[2],v[3],v[4],P.pearl) end
 return p
end
for i,item in ipairs(scene.navigation) do
 local b=button(side,item.id,8,90+(i-1)*72,334,57,12)
 icon(b,item.icon,24,16)
 local title=label(b,"Label",item.label,68,0,210,57,19,P.pearl)
 label(b,"Index",string.format("%02d",i),299,0,27,57,11,P.pearl)
 menuButtons[i]={button=b,title=title,item=item}
end
frame(side,"SignatureRule",24,505,302,1,P.pearl,nil,4,.7)
local sideLogo=label(side,"SideJBS","JBS",24,524,140,50,45,P.white,true)
sideLogo.TextColor3=WHITE
local sideLogoGradient=gradient(sideLogo,metalStops,20)
label(side,"SignatureSubtitle","专属部落 · 金属印记",24,576,235,18,11,P.pearl)
label(side,"IDs","91 / 78",219,548,105,39,25,P.white,true)
local titleGuard=frame(content,"TitleGuard",1,1,626,115,P.panel,17,3,.02)
make("UIGradient",{Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(.35,0),NumberSequenceKeypoint.new(.65,.8),NumberSequenceKeypoint.new(1,1)})},titleGuard)
local pageTitle=label(content,"PageTitle","主要",26,23,325,35,25,P.white,true)
local description=label(content,"Description","功能列表 · 06",26,65,350,20,12,P.pearl)
local edition=frame(content,"Edition",474,26,127,33,P.white,7,4)
gradient(edition,{{0,"#AC4B9E"},{1,"#62288B"}},20);stroke(edition,P.pearl,1,.45)
label(edition,"EditionText","JBS · 91 / 78",12,0,106,33,12,P.white,true)
local list=make("CanvasGroup",{Name="Features",Position=UDim2.fromOffset(22,116),Size=UDim2.fromOffset(584,398),BackgroundTransparency=1,BorderSizePixel=0,GroupTransparency=0,ZIndex=5},content)
local footer=frame(content,"FooterShade",1,521,626,97,P.panel,nil,3,.13)
make("UIGradient",{Rotation=90,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)})},footer)
local dot=frame(content,"StatusLight",27,578,5,5,P.white,3,5);stroke(dot,P.pink,3,.72)
label(content,"Footer","JBS · 力量传奇",40,563,350,34,13,P.white,true)
label(content,"FooterIDs","91 × 78",530,563,85,34,14,P.white,true)
local stars={}
for i=1,16 do
 local x=28+(i*37)%570
 local y=i<=6 and 10+(i*7)%85 or 530+(i*13)%64
 local s=frame(content,"Spark",x,y,2,2,P.white,1,2,.5)
 stars[#stars+1]={object=s,phase=i*.77}
 if i%4==0 then
  for _,size in ipairs({{1,10},{10,1}}) do
   local ray=frame(s,"StarRay",1,1,size[1],size[2],P.white,nil,2,.3)
   ray.AnchorPoint=Vector2.new(.5,.5)
  end
 end
end
local notice=frame(shell,"ReadyNotice",688,631,300,65,P.white,12,15)
gradient(notice,{{0,"#852A77"},{1,"#3C185E"}},15);stroke(notice,P.pearl,1,.25)
label(notice,"Mark","JBS",17,10,66,44,26,P.white,true,16)
label(notice,"Ready","界面已就绪",95,10,190,25,15,P.white,true,16)
label(notice,"Details","91 / 78 · 金属印记",95,35,190,18,11,P.pearl,false,16)
notice.Visible=false
local restore=button(viewport,"RestoreJBS",0,0,222,56,14)
restore.Position=UDim2.fromScale(.5,.5);restore.AnchorPoint=Vector2.new(.5,.5);restore.BackgroundTransparency=0;restore.BackgroundColor3=WHITE
stroke(restore,P.pearl,1,.2);gradient(restore,{{0,"#982A80"},{1,"#6539A3"}},20)
label(restore,"Text","展开 JBS · 91 / 78",20,0,200,56,16,P.white,true)
restore.Visible=false
local actionEvent=make("BindableEvent",{Name="UISelectionChanged"},gui)
local category, chosen = "main", nil
local cards={}
local empty=label(list,"Empty","没有匹配的功能",4,4,576,70,15,P.pearl)
empty.TextXAlignment=Enum.TextXAlignment.Center;empty.Visible=false
local function ripple(b)
 local p=UserInputService:GetMouseLocation()-b.AbsolutePosition
 local wave=frame(b,"PressWave",p.X/scale.Scale,p.Y/scale.Scale,12,12,P.pink,150,9,.82)
 wave.AnchorPoint=Vector2.new(.5,.5);local edge=stroke(wave,P.white,1,.1)
 temporaries[wave]=true
 tween(wave,{Size=UDim2.fromOffset(240,240),BackgroundTransparency=1},.5)
 local t=tween(edge,{Transparency=1},.5)
 t.Completed:Once(function() temporaries[wave]=nil;wave:Destroy() end)
end
local function selectCard(id)
 chosen=id;gui:SetAttribute("SelectedFeature",id)
 for _,c in ipairs(cards) do
  local yes=c.item.id==id
  c.state.Text=yes and "已选中" or "查看"
  c.state.TextColor3=rgb(yes and "#FFB2EC" or P.pearl)
  c.selected= yes
  c.edge.Transparency=yes and .1 or .6
 end
 actionEvent:Fire(id) -- A UI hook only; no game operation is connected by this project.
end
local function filterCards(animate)
 local n=0;local q=string.lower(search.Text)
 for _,c in ipairs(cards) do
  local show=(category=="main" or c.item.category==category) and string.find(string.lower(c.item.label),q,1,true)~=nil
  c.button.Visible=show
  if show then
   c.y=n*66+4;c.button.Position=UDim2.fromOffset(4,c.y);n=n+1
  end
 end
 empty.Visible=n==0;description.Text=(q~="" and "搜索结果" or "功能列表")..string.format(" · %02d",n)
 if animate then
  list.Position=UDim2.fromOffset(22,125);list.GroupTransparency=.75;tween(list,{Position=UDim2.fromOffset(22,116),GroupTransparency=0},.28)
 end
end
for i,item in ipairs(scene.features) do
 local b=button(list,item.id,4,4+(i-1)*66,576,56,11)
 b.BackgroundTransparency=.01;b.BackgroundColor3=WHITE
 local fill=gradient(b,{{0,"#4B1B50"},{.6,"#2A103F"},{1,"#5A2572"}},15)
 local edge=stroke(b,P.pearl,1,.6)
 local c={button=b,item=item,edge=edge,fill=fill,y=4+(i-1)*66,hover=false,selected=false,sweep=-1}
 cards[#cards+1]=c
 label(b,"Order",string.format("%02d",i),15,0,22,56,11,P.pearl)
 icon(b,item.icon,47,16)
 label(b,"FeatureName",item.label,85,0,300,56,18,P.white)
 c.state=label(b,"State","查看",477,0,60,56,11,P.pearl)
 label(b,"Chevron","›",546,0,22,56,22,P.pearl)
 local shine=frame(b,"HoverSheen",0,0,576,56,P.white,11,2)
 c.shine=make("UIGradient",{Rotation=18,Offset=Vector2.new(-1,0),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.43,1),NumberSequenceKeypoint.new(.49,.78),NumberSequenceKeypoint.new(.54,1),NumberSequenceKeypoint.new(1,1)})},shine)
 connect(b.MouseEnter,function()
  c.hover=true;c.sweep=-1
  fill.Color=ColorSequence.new(rgb("#853572"),rgb("#6A3293"))
  tween(b,{Position=UDim2.fromOffset(4,c.y-2),BackgroundColor3=rgb("#FFD8FA")},.16)
  tween(edge,{Transparency=.08},.16)
 end)
 connect(b.MouseLeave,function()
  c.hover=false;fill.Color=ColorSequence.new(rgb("#4B1B50"),rgb("#5A2572"));tween(b,{Position=UDim2.fromOffset(4,c.y),BackgroundColor3=WHITE},.2)
  tween(edge,{Transparency=c.selected and .1 or .6},.2)
 end)
 connect(b.MouseButton1Down,function() tween(b,{Position=UDim2.fromOffset(4,c.y+1)},.07) end)
 connect(b.MouseButton1Up,function() tween(b,{Position=UDim2.fromOffset(4,c.y-(c.hover and 2 or 0))},.15) end)
 connect(b.Activated,function() ripple(b);selectCard(item.id) end)
end
for i,m in ipairs(menuButtons) do
 connect(m.button.Activated,function()
  category=m.item.id;gui:SetAttribute("SelectedPage",category);pageTitle.Text=m.item.label
  tween(selection,{Position=UDim2.fromOffset(8,90+(i-1)*72)},.28)
  for _,other in ipairs(menuButtons) do other.title.TextColor3=rgb(other==m and P.white or P.pearl) end
  ripple(m.button);filterCards(true)
 end)
end
connect(search:GetPropertyChangedSignal("Text"),function() filterCards(true) end)
local elapsed,acc=0,0
local visible=true
local animation
local function render(t,dt)
 local pointer=UserInputService:GetMouseLocation()
 local mx=math.clamp((pointer.X-content.AbsolutePosition.X)/math.max(1,content.AbsoluteSize.X),0,1)
 local angle=28+(mx-.5)*20
 contentMetal.Rotation=angle+math.sin(t*.3)*8
 contentMetal.Offset=Vector2.new(math.sin(t*.22)*.12,0)
 shellMetal.Rotation=30+math.sin(t*.25)*10
 rimGradient.Rotation=(t*40)%360
 rimGradient.Offset=Vector2.new(math.sin(t*.7)*.35,math.cos(t*.7)*.35)
 logoGradient.Offset=Vector2.new(math.sin(t*.8)*.65,0)
 sideLogoGradient.Offset=Vector2.new(math.sin(t*.5)*.45,0)
 for _,g in ipairs(glyphs) do
  local beam=(t/7.2%1)*(g.width+619*.52+330)-180
  local d=(g.x+g.y*(.48+(mx-.5)*.12))-beam
  local light=math.exp(-((d/63)^2))
  local narrow=math.exp(-((d/16)^2))
  g.object.TextTransparency=1-math.min(1,g.base+light*.3+narrow*.32)
  g.object.TextColor3= d<0 and rgb(P.pink):Lerp(WHITE,1-light*.35) or rgb(P.pearl):Lerp(WHITE,1-light*.4)
 end
 for _,s in ipairs(stars) do s.object.BackgroundTransparency=.35+.6*(.5+.5*math.sin(t*(.8+s.phase*.03)+s.phase)) end
 for _,c in ipairs(cards) do
  if c.sweep<1.2 and c.hover and c.button.Visible then c.sweep=c.sweep+dt*3;c.shine.Offset=Vector2.new(c.sweep,0) end
 end
 notice.Visible=t>2.4 and t<4.8
end
local function stop()
 if animation then animation:Disconnect();animation=nil end
 for t in pairs(tweens) do t:Cancel() end
 table.clear(tweens)
 for object in pairs(temporaries) do object:Destroy() end
 table.clear(temporaries)
 shell.GroupTransparency=0;shell.Position=UDim2.fromOffset(0,0)
 list.GroupTransparency=0;list.Position=UDim2.fromOffset(22,116)
 for i,m in ipairs(menuButtons) do if m.item.id==category then selection.Position=UDim2.fromOffset(8,90+(i-1)*72) end end
 for _,c in ipairs(cards) do c.button.Position=UDim2.fromOffset(4,c.y) end
end
local function start()
 if animation or destroyed or not visible or not gui.Enabled then return end
 animation=RunService.RenderStepped:Connect(function(dt)
  acc=acc+dt
  if acc<1/30 then return end
  local step=acc;acc=0;elapsed=elapsed+step;render(elapsed,step)
 end)
end
local function reveal()
 visible=true;shell.Visible=true;restore.Visible=false;elapsed=0;acc=0
 for _,g in ipairs(glows) do g.object.Visible=true end
 shell.GroupTransparency=1;shell.Position=UDim2.fromOffset(0,20)
 tween(shell,{GroupTransparency=0,Position=UDim2.fromOffset(0,0)},.7)
 list.Position=UDim2.fromOffset(22,128);list.GroupTransparency=1;tween(list,{Position=UDim2.fromOffset(22,116),GroupTransparency=0},.5,.3)
 start()
end
local function hide()
 visible=false;stop();shell.Visible=false;restore.Visible=true;notice.Visible=false
 for _,g in ipairs(glows) do g.object.Visible=false end
end
connect(close.Activated,hide);connect(minimize.Activated,hide);connect(restore.Activated,reveal)
connect(expand.Activated,function() expanded=not expanded;fit() end)
connect(gui:GetPropertyChangedSignal("Enabled"),function() if gui.Enabled then start() else stop() end end)
connect(UserInputService.WindowFocusReleased,stop)
connect(UserInputService.WindowFocused,start)
connect(shell:GetPropertyChangedSignal("Visible"),function() if shell.Visible and visible then start() else stop() end end)
connect(gui.Destroying,function()
 destroyed=true;stop()
 for _,c in ipairs(connections) do c:Disconnect() end
end)
gui:SetAttribute("SelectedPage","main")
filterCards(false);render(0,0);reveal()

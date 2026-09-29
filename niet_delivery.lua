                                                                                 local Players=game:   
                                                                        GetService("Players");local RunService=game:    
                                                                    GetService("RunService");local UserInputService=game:         
                                                                GetService("UserInputService");local TweenService=game:GetService(      
                                                            "TweenService");local VirtualInputManager=game:GetService(                    
                                                          "VirtualInputManager");local LocalPlayer=Players.LocalPlayer;local CONFIG={       
                                                        StartDistance=28,PickupDistance=30,DeliveryDistance=28,EndEarlyDistance=25,SafeOffset 
                                                      =5,LoopDelay=0.4,StreamWaitTime=0.8,PromptHoldExtra=0.2,TPHeight=3};local C={Bg=Color3.   
                                                    fromRGB(8,6,14),Panel=Color3.fromRGB(16,12,26),Card=Color3.fromRGB(26,20,42),CardHover=Color3 
                                                  .fromRGB(38,28,58),Accent=Color3.fromRGB(140,80,255),Accent2=Color3.fromRGB(200,100,255),         
                                                  AccentDark=Color3.fromRGB(70,35,140),Glow=Color3.fromRGB(180,120,255),Text=Color3.fromRGB(245,242,  
                                                255),SubText=Color3.fromRGB(150,140,175),Green=Color3.fromRGB(60,210,120),Red=Color3.fromRGB(230,70,90) 
                                                ,Yellow=Color3.fromRGB(240,190,70)};local State={Running=false,CurrentStage="Idle",Target=nil,TargetPos=  
                                              nil,TargetName=nil,Deadline=nil,Sequence=0,Reward=0,Deliveries=0,LastPrompt=0,StartTime=0};local function     
                                              Corner(obj,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 10 );c.Parent=obj;return c;end  
                                            local function Stroke(obj,color,thickness,transparency) local s=Instance.new("UIStroke");s.Color=color;s.         
                                            Thickness=thickness or 1 ;s.Transparency=transparency or 0 ;s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border;s.Parent= 
                                          obj;return s;end local function Gradient(obj,c1,c2,rotation) local g=Instance.new("UIGradient");g.Color=ColorSequence.  
                                          new(c1,c2);g.Rotation=rotation or 0 ;g.Parent=obj;return g;end local function Tween(obj,time,props) local t=TweenService: 
                                          Create(obj,TweenInfo.new(time,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),props);t:Play();return t;end local function   
                                          GetSafeGuiParent() local success,parent=pcall(function() if gethui then return gethui();end end);if (success and parent)    
                                        then return parent;end success,parent=pcall(function() return game:GetService("CoreGui");end);if (success and parent) then      
                                        return parent;end return LocalPlayer:WaitForChild("PlayerGui");end    --[[==============================]]local GuiParent=        
                                        GetSafeGuiParent();pcall(function() for _,name in ipairs({  --[[============================================]]"NietHub",          
                                        "NietDeliveryFarm","LitedirtHubUI","DeltaModernUI"}) do --[[======================================================]] local old=     
                                      GuiParent:FindFirstChild(name);if old then old:       --[[==========================================================]]Destroy();end end 
                                       end);local Gui=Instance.new("ScreenGui");Gui.Name= --[[==============================================================]]                
                                      "NietDeliveryFarm";Gui.ResetOnSpawn=false;Gui.      --[[================================================================]]IgnoreGuiInset= 
                                      true;Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling --[[==================================================================]];Gui.Parent=  
                                      GuiParent;local Main=Instance.new("Frame");Main.    --[[==================================================================]]Size=UDim2.       
                                    fromOffset(360,260);Main.Position=UDim2.new(0.5, -180 --[[====================================================================]],0.5, -130);  
                    Main.BackgroundColor3=C.Bg;Main.BorderSizePixel=0;Main.Active=true;   --[[====================================================================]]Main.Parent=Gui 
              ;Corner(Main,16);Stroke(Main,C.Accent,1.5,0.35);local GlowLayer=Instance.   --[[======================================================================]]new("Frame"); 
            GlowLayer.Size=UDim2.new(1,12,1,12);GlowLayer.Position=UDim2.fromOffset( -6,  --[[======================================================================]]-6);GlowLayer 
          .BackgroundColor3=C.Accent;GlowLayer.BackgroundTransparency=0.92;GlowLayer.     --[[======================================================================]]              
        BorderSizePixel=0;GlowLayer.ZIndex= -1;GlowLayer.Parent=Main;Corner(GlowLayer,20) --[[======================================================================]];local Header 
        =Instance.new("Frame");Header.Size=UDim2.new(1,0,0,52);Header.BackgroundColor3=C. --[[======================================================================]]Panel;Header. 
      BorderSizePixel=0;Header.Parent=Main;Corner(Header,16);Gradient(Header,C.AccentDark --[[======================================================================]],C.Panel,90); 
      local HeaderFix=Instance.new("Frame");HeaderFix.Size=UDim2.new(1,0,0,16);HeaderFix.   --[[==================================================================]]Position=UDim2. 
      new(0,0,1, -16);HeaderFix.BackgroundColor3=C.Panel;HeaderFix.BorderSizePixel=0;       --[[================================================================]]HeaderFix.Parent= 
    Header;local LogoFrame=Instance.new("Frame");LogoFrame.Size=UDim2.fromOffset(34,34);    --[[==============================================================]]LogoFrame.        
    Position=UDim2.fromOffset(12,9);LogoFrame.BackgroundColor3=C.Accent;LogoFrame.            --[[==========================================================]]BorderSizePixel=0;  
    LogoFrame.Parent=Header;Corner(LogoFrame,10);Gradient(LogoFrame,C.Accent,C.Accent2,45);     --[[====================================================]]local LogoText=Instance 
    .new("TextLabel");LogoText.Size=UDim2.new(1,0,1,0);LogoText.BackgroundTransparency=1;LogoText --[[==============================================]].Text="🚚";LogoText.      
    TextColor3=C.Text;LogoText.TextSize=18;LogoText.Font=Enum.Font.GothamBold;LogoText.Parent=        --[[====================================]]LogoFrame;local Title=        
    Instance.new("TextLabel");Title.Size=UDim2.new(1, -110,0,22);Title.Position=UDim2.fromOffset(54,7);   --[[========================]]Title.BackgroundTransparency=1;Title. 
    Text="NIET DELIVERY";Title.TextColor3=C.Text;Title.TextSize=16;Title.Font=Enum.Font.GothamBlack;Title.TextXAlignment=Enum.TextXAlignment.Left;Title.Parent=Header;local 
   SubTitle=Instance.new("TextLabel");SubTitle.Size=UDim2.new(1, -110,0,14);SubTitle.Position=UDim2.fromOffset(54,28);SubTitle.BackgroundTransparency=1;SubTitle.Text=    
  "Ride Storm Autofarm v1.2";SubTitle.TextColor3=C.Glow;SubTitle.TextSize=10;SubTitle.Font=Enum.Font.GothamMedium;SubTitle.TextXAlignment=Enum.TextXAlignment.Left;     
  SubTitle.Parent=Header;local Close=Instance.new("TextButton");Close.Size=UDim2.fromOffset(32,32);Close.Position=UDim2.new(1, -42,0,10);Close.BackgroundColor3=C.Card;   
  Close.Text="✕";Close.TextColor3=C.SubText;Close.TextSize=15;Close.Font=Enum.Font.GothamBold;Close.AutoButtonColor=false;Close.Parent=Header;Corner(Close,9);Stroke(     
  Close,C.Red,1,0.6);Close.MouseEnter:Connect(function() Tween(Close,0.15,{BackgroundColor3=C.Red,TextColor3=C.Text});end);Close.MouseLeave:Connect(function() Tween(     
  Close,0.15,{BackgroundColor3=C.Card,TextColor3=C.SubText});end);local StatusCard=Instance.new("Frame");StatusCard.Size=UDim2.new(1, -24,0,68);StatusCard.Position=UDim2 
  .fromOffset(12,64);StatusCard.BackgroundColor3=C.Card;StatusCard.BorderSizePixel=0;StatusCard.Parent=Main;Corner(StatusCard,12);Stroke(StatusCard,C.Accent,1,0.7);local 
   StatusIcon=Instance.new("TextLabel");StatusIcon.Size=UDim2.fromOffset(36,36);StatusIcon.Position=UDim2.fromOffset(12,16);StatusIcon.BackgroundColor3=C.CardHover;      
  StatusIcon.Text="⏸";StatusIcon.TextColor3=C.SubText;StatusIcon.TextSize=20;StatusIcon.Font=Enum.Font.GothamBold;StatusIcon.Parent=StatusCard;Corner(StatusIcon,10);     
  local StageLabel=Instance.new("TextLabel");StageLabel.Size=UDim2.new(1, -70,0,20);StageLabel.Position=UDim2.fromOffset(58,12);StageLabel.BackgroundTransparency=1;      
  StageLabel.Text="Durum: Bekliyor";StageLabel.TextColor3=C.Text;StageLabel.TextSize=13;StageLabel.Font=Enum.Font.GothamBold;StageLabel.TextXAlignment=Enum.              
  TextXAlignment.Left;StageLabel.Parent=StatusCard;local DeliveryLabel=Instance.new("TextLabel");DeliveryLabel.Size=UDim2.new(1, -70,0,16);DeliveryLabel.Position=UDim2.    
  fromOffset(58,32);DeliveryLabel.BackgroundTransparency=1;DeliveryLabel.Text="Teslimat: 0 | Süre: --";DeliveryLabel.TextColor3=C.SubText;DeliveryLabel.TextSize=11;        
  DeliveryLabel.Font=Enum.Font.Gotham;DeliveryLabel.TextXAlignment=Enum.TextXAlignment.Left;DeliveryLabel.Parent=StatusCard;local ToggleBtn=Instance.new("TextButton");     
  ToggleBtn.Size=UDim2.new(1, -24,0,50);ToggleBtn.Position=UDim2.fromOffset(12,142);ToggleBtn.BackgroundColor3=C.Accent;ToggleBtn.Text="BAŞLAT";ToggleBtn.TextColor3=C.Text 
  ;ToggleBtn.TextSize=15;ToggleBtn.Font=Enum.Font.GothamBlack;ToggleBtn.AutoButtonColor=false;ToggleBtn.Parent=Main;Corner(ToggleBtn,12);Stroke(ToggleBtn,C.Accent2,1.5,0.3 
  );Gradient(ToggleBtn,C.Accent,C.Accent2,45);ToggleBtn.MouseEnter:Connect(function() Tween(ToggleBtn,0.15,{BackgroundColor3=C.Accent2});end);ToggleBtn.MouseLeave:Connect( 
  function() Tween(ToggleBtn,0.15,{BackgroundColor3=(State.Running and C.Red) or C.Accent });end);local StatsLabel=Instance.new("TextLabel");StatsLabel.Size=UDim2.new(1, - 
  24,0,30);StatsLabel.Position=UDim2.new(0,12,1, -38);StatsLabel.BackgroundTransparency=1;StatsLabel.Text="Niet Hub v1.2 • Prompt Trigger Fix";StatsLabel.TextColor3=C.     
  SubText;StatsLabel.TextSize=10;StatsLabel.Font=Enum.Font.Gotham;StatsLabel.TextXAlignment=Enum.TextXAlignment.Center;StatsLabel.Parent=Main;local function GetCharacter() 
   return LocalPlayer.Character;end local function GetRoot() local char=GetCharacter();return char and char:FindFirstChild("HumanoidRootPart") ;end local function          
  GetJobFolder() local dj=workspace:FindFirstChild("DeliveryJob");if  not dj then return nil;end return dj:FindFirstChild("Job1");end local function GetPart(name) local    
  job=GetJobFolder();if  not job then return nil;end return job:FindFirstChild(name);end local function FindPartInWorkspace(name) for _,obj in ipairs(workspace:            
  GetDescendants()) do if (obj:IsA("BasePart") and (obj.Name==name)) then return obj;end end return nil;end local function TPTo(position) local root=GetRoot();if  not root 
   then return false;end root.CFrame=CFrame.new(position + Vector3.new(0,CONFIG.TPHeight,0) );root.AssemblyLinearVelocity=Vector3.zero;root.AssemblyAngularVelocity=      
  Vector3.zero;return true;end local function TPToPart(part,maxDistance) if  not part then return false;end local root=GetRoot();if  not root then return false;end local 
   partPos=part.Position;local currentPos=root.Position;local direction=currentPos-partPos ;if (direction.Magnitude<1) then direction=Vector3.new(1,0,0);end direction=   
    direction.Unit;local safeDist=maxDistance-CONFIG.SafeOffset ;local targetPos=partPos + (direction * safeDist) ;return TPTo(targetPos);end local function              
    TriggerPrompt(prompt) if  not prompt then return false;end if  not prompt.Enabled then return false;end local holdTime=prompt.HoldDuration or 0.5 ;if ((os.clock() -  
    State.LastPrompt)<0.5) then return false;end State.LastPrompt=os.clock();if fireproximityprompt then local ok=pcall(function() fireproximityprompt(prompt);end);if ok 
     then print("[Niet] Prompt tetiklendi (fireproximityprompt)");return true;end end local ok2=pcall(function() prompt:InputHoldBegin();end);if ok2 then task.wait(      
      holdTime + CONFIG.PromptHoldExtra );pcall(function() prompt:InputHoldEnd();end);print("[Niet] Prompt tetiklendi (InputHold)");return true;end task.wait(0.1);     
      pcall(function() VirtualInputManager:SendKeyEvent(true,Enum.KeyCode.E,false,game);task.wait(holdTime + CONFIG.PromptHoldExtra );VirtualInputManager:SendKeyEvent( 
      false,Enum.KeyCode.E,false,game);end);print("[Niet] Prompt tetiklendi (E tuşu)");return true;end local function TriggerPartPrompt(part) if  not part then return  
        false;end local prompt=part:FindFirstChild("DeliveryJobPrompt");if  not prompt then prompt=part:FindFirstChildOfClass("ProximityPrompt");end if prompt then     
        return TriggerPrompt(prompt);end return false;end local DeliveryRemotes=game:GetService("ReplicatedStorage"):WaitForChild("DeliveryJobRemotes",10);if           
        DeliveryRemotes then local StateRemote=DeliveryRemotes:FindFirstChild("State");if StateRemote then StateRemote.OnClientEvent:Connect(function(stateData) if     
          not stateData then return;end if stateData.active then State.CurrentStage=stateData.stage;State.Target=stateData.target;State.TargetPos=stateData.          
            targetPosition;State.TargetName=stateData.targetName;State.Deadline=stateData.deadline;State.Sequence=stateData.sequence or 0 ;State.Reward=stateData.    
              reward or 0 ;if (State.CurrentStage=="Pickup") then StageLabel.Text="Durum: Paket alınıyor";StatusIcon.Text="📦";elseif (State.CurrentStage=="Delivery" 
                ) then StageLabel.Text="Durum: Teslim ediliyor";StatusIcon.Text="🚚";end elseif State.Running then State.CurrentStage="Idle";State.Target=nil;State.  
                  TargetPos=nil;StageLabel.Text="Durum: Yeni iş başlatılıyor";StatusIcon.Text="🔄";end end);end end local function FarmStep() local root=GetRoot(); 
                      if  not root then return false;end if (State.CurrentStage=="Pickup") then local boxPickup=GetPart("BoxPickup") or FindPartInWorkspace(        
                                  "BoxPickup") ;if  not boxPickup then if State.TargetPos then TPTo(State.TargetPos);task.wait(CONFIG.StreamWaitTime);end return    
                                      true;end local dist=(root.Position-boxPickup.Position).Magnitude;if (dist>(CONFIG.PickupDistance-CONFIG.SafeOffset)) then     
                                      TPToPart(boxPickup,CONFIG.PickupDistance);task.wait(CONFIG.           LoopDelay);return true;end TriggerPartPrompt(boxPickup) 
                                      ;return true;end if (State.CurrentStage=="Delivery") then             local deliveryLoc=FindPartInWorkspace(                
                                      "DeliveryLocation");if  not deliveryLoc then local anchor=            workspace:FindFirstChild("DeliveryTargetAnchor");if   
                                      anchor then TPToPart(anchor,CONFIG.DeliveryDistance);elseif           State.TargetPos then TPTo(State.TargetPos);end task.  
                                      wait(CONFIG.StreamWaitTime);return true;end local dist=(root.           Position-deliveryLoc.Position).Magnitude;if (dist>( 
                                      CONFIG.DeliveryDistance-CONFIG.SafeOffset)) then TPToPart(              deliveryLoc,CONFIG.DeliveryDistance);task.wait(     
                                      CONFIG.LoopDelay);return true;end TriggerPartPrompt(                    deliveryLoc);return true;end if (State.           
                                        CurrentStage=="Idle") then local pad=GetPart("Pad");if pad            then local dist=(root.Position-pad.Position).     
                                        Magnitude;if (dist>(CONFIG.StartDistance-CONFIG.SafeOffset)             ) then TPToPart(pad,CONFIG.StartDistance);task. 
                                        wait(CONFIG.LoopDelay);return true;end TriggerPartPrompt(               pad);end return true;end return false;end     
                                        task.spawn(function() while true do task.wait(0.1);if                   State.Running then local ok,err=pcall(        
                                        FarmStep);if  not ok then warn("[Niet Delivery] Hata:",                   err);end if (State.StartTime>0) then      
                                        local elapsed=math.floor(os.clock() -State.StartTime );                   local mins=math.floor(elapsed/60 );local  
                                          secs=elapsed%60 ;DeliveryLabel.Text=string.format(                        "Teslimat: %d | Süre: %02d:%02d",     
                                          State.Deliveries,mins,secs);end end end end);                               ToggleBtn.Activated:Connect(    
                                            function() State.Running= not State.Running;if                              State.Running then        
                                            ToggleBtn.Text="DURDUR";ToggleBtn.                                                            
                                              BackgroundColor3=C.Red;ToggleBtn.UIStroke.    
                                                Color=C.Red;State.StartTime=os.clock();   
                                                    State.CurrentStage="Idle";State.    
                                                          Deliveries=0;StageLabel 


.Text="Durum: Başlatılıyor...";StatusIcon.Text="▶";print("[Niet Delivery] Autofarm BAŞLATILDI");else ToggleBtn.Text="BAŞLAT";ToggleBtn.BackgroundColor3=C.Accent;ToggleBtn.UIStroke.Color=C.Accent2;State.CurrentStage="Idle";State.Target=nil;State.TargetPos=nil;StageLabel.Text="Durum: Durduruldu";StatusIcon.Text="⏸";print("[Niet Delivery] Autofarm DURDURULDU");end end);local Dragging=false;local DragStart;local StartPosition;Header.InputBegan:Connect(function(Input) if ((Input.UserInputType==Enum.UserInputType.Touch) or (Input.UserInputType==Enum.UserInputType.MouseButton1)) then Dragging=true;DragStart=Input.Position;StartPosition=Main.Position;end end);UserInputService.InputChanged:Connect(function(Input) if  not Dragging then return;end if ((Input.UserInputType==Enum.UserInputType.Touch) or (Input.UserInputType==Enum.UserInputType.MouseMovement)) then local Delta=Input.Position-DragStart ;Main.Position=UDim2.new(StartPosition.X.Scale,StartPosition.X.Offset + Delta.X ,StartPosition.Y.Scale,StartPosition.Y.Offset + Delta.Y );end end);UserInputService.InputEnded:Connect(function(Input) if ((Input.UserInputType==Enum.UserInputType.Touch) or (Input.UserInputType==Enum.UserInputType.MouseButton1)) then Dragging=false;end end);local Open=Instance.new("TextButton");Open.Size=UDim2.fromOffset(120,40);Open.Position=UDim2.fromOffset(15,200);Open.BackgroundColor3=C.Accent;Open.Text="🚚 NIET DELIVERY";Open.TextColor3=C.Text;Open.TextSize=11;Open.Font=Enum.Font.GothamBlack;Open.Visible=false;Open.ZIndex=100;Open.AutoButtonColor=false;Open.Parent=Gui;Corner(Open,10);Stroke(Open,C.Accent2,1.5,0.3);Gradient(Open,C.Accent,C.Accent2,45);Close.Activated:Connect(function() Main.Visible=false;Open.Visible=true;end);Open.Activated:Connect(function() Main.Visible=true;Open.Visible=false;end);LocalPlayer.CharacterAdded:Connect(function() task.wait(1);if State.Running then State.CurrentStage="Idle";StageLabel.Text="Durum: Yeniden başlatılıyor";end end);print("[Niet Delivery] v1.2 yüklendi (Prompt Trigger Fix)");

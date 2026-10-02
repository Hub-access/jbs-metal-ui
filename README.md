# JBS · 粉紫金属中网

本版保留原图的 1016 × 726 窗口比例、顶部标题栏、左侧导航和右侧功能区，实际修改了网页预览与 Roblox 原生 Luau 两端。未使用游戏照片作为界面背景。

## 运行

网页：点击 GitHub 的 **Code → Download ZIP**，解压后双击 `index.html` 即可看动画。也可以在本目录运行：

```sh
python3 -m http.server 8765 --bind 127.0.0.1
```

然后在 Chrome 打开 http://127.0.0.1:8765/?metal-grid=2 。默认播放登场动画，此后保持连续材质反射。底部可重播、暂停；标题栏可收起、关闭和调整显示大小。关闭后有重新展开入口。

Roblox：将 `JBS_91_78.client.lua` 的内容放入 StarterPlayer → StarterPlayerScripts 的 LocalScript，在 Studio 中 Play。本机没有 Roblox Studio，尚未进行 Roblox 引擎实机验收。

## 本版效果

- 右侧 308 个、侧栏 165 个正向粗体 JBS，小标记 42 × 28 等距错行排列；右侧每行 14 个。
- 每个标记有粉紫金属亮暗面，斜向窄反射束按空间位置扫过。纹样受面板裁切，正文区域另有深色承托。
- 深紫底、亮粉到电紫的流动材质、锐利镜面亮带、流动边框和柔光，顶部独立金属 JBS。
- 导航渐变滑动、卡片悬停提亮与扫光、按压光波、页面进入动画、首次展开和细小星芒。
- 中文采用系统无衬线字体，网页标记采用 Arial Bold，Luau 使用 Gotham/GothamBold；没有衬线和倾斜字标。

## 交互范围

原项目没有游戏功能实现、开关/滑块逻辑或游戏事件绑定，只有六个功能名称。本次保留自动举重、极速训练、宠物进阶、世界传送、竞技主场、光环特效，新增的是界面交互：分类筛选、搜索、选中反馈和窗口控制。点击不会执行游戏操作。

网页发出 `jbs:select` CustomEvent，`detail.id` 为选中项。Luau 的 ScreenGui 包含 `UISelectionChanged` BindableEvent，并维护 `SelectedFeature`、`SelectedPage` 属性；未接入任何游戏事件。

## 源文件关系

- `tools/build_ui.py`：共享布局尺寸、配色参数、纹样参数、导航与功能目录。
- `tools/preview.html`：DOM/CSS 控件、缓存 Canvas 纹样和网页生命周期。
- `tools/runtime.lua`：原生 Roblox GUI、复用字标实例、共享反射循环与交互。
- `index.html`、`JBS_91_78.client.lua`：由上述源文件生成的交付入口。

```sh
python3 tools/build_ui.py
```

两端共享目录和设计参数，浏览器材质由 CSS/Canvas 实现，Luau 由原生 UIGradient/UIStroke/TextLabel 实现；它们并非同一个渲染器，不保证像素完全一致。Luau 无外部字体、纹理或网络依赖。

网页隐藏、关闭或暂停时取消渲染循环并暂停 CSS 动画；系统减少动态效果偏好会停用常驻动画。Luau 收起、禁用、失焦时断开 RenderStepped，销毁时清理事件和临时光波。没有为每个小字标创建独立 Tween。

此仓库发布当前金属中网版本。完整验证范围见 `design-qa.md`。

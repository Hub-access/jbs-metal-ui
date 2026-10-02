"""One shared layout/catalogue; native Luau and browser renderers consume it."""
import json
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
scene = {
    'version': 'metal-grid-2', 'width': 1016, 'height': 726,
    'palette': {'base': '#16091F', 'panel': '#251033', 'pink': '#FF4FD8', 'violet': '#A855F7', 'pearl': '#D8B4FE', 'white': '#FFE6FA'},
    'pattern': {'pitchX': 42, 'pitchY': 28, 'size': 13},
    'navigation': [
        {'id': 'main', 'label': '主要', 'icon': 'bolt'},
        {'id': 'travel', 'label': '传送', 'icon': 'pin'},
        {'id': 'pets', 'label': '宠物', 'icon': 'pet'},
        {'id': 'boss', 'label': 'Boss', 'icon': 'crown'},
        {'id': 'training', 'label': '训练', 'icon': 'weight'}],
    'features': [
        {'id': 'strength', 'label': '自动举重', 'category': 'training', 'icon': 'weight'},
        {'id': 'speed', 'label': '极速训练', 'category': 'training', 'icon': 'bolt'},
        {'id': 'companions', 'label': '宠物进阶', 'category': 'pets', 'icon': 'pet'},
        {'id': 'teleport', 'label': '世界传送', 'category': 'travel', 'icon': 'pin'},
        {'id': 'arena', 'label': '竞技主场', 'category': 'boss', 'icon': 'crown'},
        {'id': 'aura', 'label': '光环特效', 'category': 'pets', 'icon': 'spark'}]
}
def lua(v):
    if isinstance(v, str): return json.dumps(v, ensure_ascii=False)
    if isinstance(v, bool): return str(v).lower()
    if isinstance(v, (int,float)): return str(v)
    if isinstance(v, dict): return '{' + ', '.join(k+' = '+lua(a) for k,a in v.items()) + '}'
    return '{'+', '.join(lua(a) for a in v)+'}'
(ROOT/'design/scene.json').write_text(json.dumps(scene, ensure_ascii=False, indent=2))
(ROOT/'JBS_91_78.client.lua').write_text((ROOT/'tools/runtime.lua').read_text().replace('-- INSERT_SCENE','local scene = '+lua(scene)))
(ROOT/'index.html').write_text((ROOT/'tools/preview.html').read_text().replace('/* INSERT_SCENE */','const scene = '+json.dumps(scene,ensure_ascii=False)+';'))
print('Built shared metal-grid scene → index.html + JBS_91_78.client.lua')

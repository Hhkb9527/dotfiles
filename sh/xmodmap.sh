# 通过xmodmap命令查询按键映射
# xmodmap -pke | grep -i lock
# xmodmap -pke | grep -i esc

## 交换 CapsLock 和 Control
xmodmap -e "remove Lock = Caps_Lock"
xmodmap -e "remove Control = Control_L"

ctrl_line=$(xmodmap -pke | grep Control_L | sed 's/.*\([0-9]\{2\}\).*/\1/')
if [ $ctrl_line == 66 ]
then
  echo "Caps_Lock ==> Caps_Lock"
  echo "Control_L ==> Control_L"
  xmodmap -e "keycode 66 = Caps_Lock NoSymbol Caps_Lock"
  xmodmap -e "keycode 37 = Control_L NoSymbol Control_L"
else
  echo "Caps_Lock ==> Control_L"
  echo "Control_L ==> Caps_Lock"
  xmodmap -e "keycode 66 = Control_L NoSymbol Control_L"
  xmodmap -e "keycode 37 = Caps_Lock NoSymbol Caps_Lock"
fi

xmodmap -e "add Lock = Caps_Lock"
xmodmap -e "add Control = Control_L"

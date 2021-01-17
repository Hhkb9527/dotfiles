# 新建虚拟机

```python
值得注意：
1. 典型配置
  2. 直接选择镜像文件（官网下载）
  3. 版本选择 “其他Linux N.x 或更高版本内核64位”
  4. 开机前：虚拟机设置=>选项=>高级=>选择UEFI（必须）
```

# 配置

### 1. 确保网络畅通

```python
ping www.baidu.com
```

### 2. 更新时间

```python
timedatectl set-ntp true
```

### 3. 分区

```python
fdisk -l 查看硬盘设备信息
fdisk
    /dev/sda => 创建三个分区
    /dev/sda1作为引导分区（512M）
    /dev/sda3作为SWAP分区（1G）
    /dev/sda2作为主分区（剩余所有空间）

mkfs.fat -F32 /dev/sda1 系统引导分区FAT格式
mkfs.ext4 /dev/sda2 主分区ext4格式
mkswap /dev/sda3 制作SWAP
wapon /dev/sda3 打开SWAP
```

### 4. 配置pacman

```python
vim /etc/pacman.conf => 取消Color的注释 => [core] 下就是软件源的位置
vim /etc/pacman.d/mirrorlist =>
    添加国内源（Server = http://mirrors.163.com/archlinux/\$repo/os/\$arch）
```

### 5. 挂载并安装

```python
mount /dev/sda2 /mnt 主分区
mkdir /mnt/boot => mount /dev/sda1 /mnt/boot 启动分区
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
```

### 6. 更改...

```python
arch-chroot /mnt 进入系统
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 更改时区
hwclock --systohc 同步时间
exit 退出系统
vim /mnt/etc/locale.gen 取消en_US.UTF-8...的注释
arch-chroot /mnt
locale-gen 更新配置
exit
vim /mnt/etc/locale.conf => LANG=en_US.UTF-8
vim /mnt/etc/hostname => Fuck（主机名）
vim /mnt/etc/hosts => 127.0.0.1 localhost
arch-chroot /mnt
passwd（更改密码）
pacman -S grub efibootmgr intel-ucode os-prober
mkdir /boot/grub
grub-mkconfig > /boot/grub/grub.cfg
uname -m （cpu架构，一般为x86_64）
grub-install --target=x86_64-efi --efi-directory=/boot
```

### 7. 安装软件

```python
pacman -S gvim vi dhcpcd wget curl git networkmanager net-tools lua thefuck ccls clang diff-so-fancy gzip zip unzip htop xorg
```

### 8. 重启

```python
reboot
dhcpcd
ip addr
```

### 9. 输入法

```python
sudo pacman -S fcitx fcitx-configtool fcitx-gtk2 fcitx-gtk3 fcitx-qt5 libidn fcitx-sunpinyin
```

# 配环境

```python
pacman -S man base-devel i3 tmux zsh alacritty
useradd -m -G wheel elijah
passwd elijah
visudo 取消掉wheel行注释 => 切换用户
sudo pacman -S xorg sddm sddm-kcm 登录管理器
sudo systemctl enable sddm
有问题进不去系统？alt+ctrl+F1...F6
```

# 全屏（open-vm-tools）

```python
安装open-vm-tools 并自动自动适应屏幕大小
参考: https://poemdear.com/2019/11/29/%E5%9C%A8vmware%E8%99%9A%E6%8B%9F%E6%9C%BA%E4%B8%AD%E5%AE%89%E8%A3%85%E7%9A%84arch-linux%E9%87%8C%E5%AE%89%E8%A3%85vmware-tools/
sudo pacman -S  open-vm-tools
sudo pacman -S gtkmm gtk2  xf86-video-vmware
1.虚拟机设置: View -> Autosize -> Autofit Guest, 此项应该被勾选
2.编辑/etc/mkinitcpio.conf,找到MODULES,添加以下括号里的容 MODULES=(vsock vmw_vsock_vmci_transport vmw_balloon vmw_vmci vmwgfx) 之后回到终端执行: mkinitcpio -p linux
3.自启动设置: systemctl enable vmtoolsd
4.重启
```

# 个人配置
[https://github.com/Elijah-F/dotfiles](https://github.com/Elijah-F/dotfiles)
[https://github.com/Elijah-F/dot-vim](https://github.com/Elijah-F/dot-vim)

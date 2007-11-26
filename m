Message-ID: <e4ef24880711252130k5bc3d2d3p27ab471481050cf@domain.hid>
Date: Sun, 25 Nov 2007 21:30:34 -0800
From: "Robert Gubler" <rgubler@domain.hid>
In-Reply-To: <5a4b7020711252042v8cce5c4h5db9f4056600f6ad@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5360_26182600.1196055034707"
References: <5a4b7020711251915v402411d7i5365c099a8668073@domain.hid>
	<e4ef24880711251933kf0afe5au3fa461821c82ef80@domain.hid>
	<5a4b7020711252019s18f8248eyc251b050214fe55b@domain.hid>
	<e4ef24880711252034v12ca459ct4c09c3cb4cb4c306@domain.hid>
	<5a4b7020711252042v8cce5c4h5db9f4056600f6ad@domain.hid>
Subject: Re: [Xenomai-help] These options are known to cause troubles with
	Xenomai, Kernel panic - not syncing: VFS unable to mount root fs on
	unknown-block(8, 7)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jie zhang <xenomai.rtai@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_5360_26182600.1196055034707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

What does /boot/grub/menu.lst look like?

You should have an entry that looks something like:

title           Ubuntu 7, Xenomai and IPipe
root            (hd0,0)
kernel
/boot/vmlinuz-2.6.22root=UUID=4db354f4-1591-42a0-a09b-f551dd8405f8 ro
quiet splash

Change root to: root=/dev/sda7

What steps did you take to build your kernel?

-Rob




On Nov 25, 2007 8:42 PM, jie zhang <xenomai.rtai@domain.hid> wrote:

> Hi rob,
> my kernel version is 2.6.22 with ubuntu 7 , I still not know what is the
> reason.
> p.s I can't find grub.conf in /boot/grub, there are only
> drwxr-xr-x 2 root root   1024 2007-11-25 22:41 .
> drwxr-xr-x 4 root root   1024 2007-11-25 22:34 ..
> -rw-r--r-- 1 root root    197 2007-11-08 03:55 default
> -rw-r--r-- 1 root root     15 2007-11-08 03:55 device.map
> -rw-r--r-- 1 root root   8660 2007-11-08 03:55 e2fs_stage1_5
> -rw-r--r-- 1 root root   8452 2007-11-08 03:55 fat_stage1_5
> -rw-r--r-- 1 root root     15 2007-11-08 03:55 installed-version
> -rw-r--r-- 1 root root   9152 2007-11-08 03:55 jfs_stage1_5
> -rw-r--r-- 1 root root   4655 2007-11-25 22:41 menu.lst
> -rw-r--r-- 1 root root   7860 2007-11-08 03:55 minix_stage1_5
> -rw-r--r-- 1 root root  10132 2007-11-08 03:55 reiserfs_stage1_5
> -rw-r--r-- 1 root root    512 2007-11-08 03:55 stage1
> -rw-r--r-- 1 root root 110292 2007-11-08 03:55 stage2
> -rw-r--r-- 1 root root   9980 2007-11-08 03:55 xfs_stage1_5
>
> in my grub and my /etc/fstab
>
> proc            /proc           proc    defaults        0       0
> # /dev/sda7
> UUID=4db354f4-1591-42a0-a09b-f551dd8405f8 /               ext3
> defaults,errors=remount-ro 0       1
> # /dev/sda6
> UUID=42f7fcfe-1b59-45e0-8ecd-0dfed91edb9c /boot           ext3
> defaults        0       2
> # /dev/sda8
> UUID=41f8c15c-40ee-4b29-8b73-97ce3f3d4bc3 /home           ext3
> defaults        0       2
> # /dev/sda1
> UUID=2A1D-0905  /media/sda1     vfat    defaults,utf8,umask=007,gid=46 0
>     1
> # /dev/sda5
> UUID=ec55553e-b42c-4300-99d9-34333c78c468 none            swap    sw
>           0       0
> /dev/scd0       /media/cdrom0   udf,iso9660 user,noauto,exec 0       0
> ~
>
> thank you!
>

------=_Part_5360_26182600.1196055034707
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

What does /boot/grub/menu.lst look like?&nbsp; <br><br>You should have an entry that looks something like:<br><br>title&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ubuntu 7, Xenomai and IPipe<br>root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (hd0,0)<br>kernel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /boot/vmlinuz-2.6.22 root=UUID=4db354f4-1591-42a0-a09b-f551dd8405f8 ro quiet splash 
<br><br>Change root to: root=/dev/sda7<br><br>What steps did you take to build your kernel?<br><br>-Rob<br><br><br><br><br><div class="gmail_quote">On Nov 25, 2007 8:42 PM, jie zhang &lt;<a href="mailto:xenomai.rtai@domain.hid">
xenomai.rtai@domain.hid</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi rob,<br>my kernel version is 2.6.22 with ubuntu 7 , I still not know what is the reason.
<br>p.s I can&#39;t find grub.conf in /boot/grub, there are only<br>drwxr-xr-x 2 root root &nbsp; 1024 2007-11-25 22:41 .<br>drwxr-xr-x 4 root root &nbsp; 1024 2007-11-25 22:34 ..<br>-rw-r--r-- 1 root root &nbsp; &nbsp;197 2007-11-08 03:55 default
<br>-rw-r--r-- 1 root root &nbsp; &nbsp; 15 2007-11-08 03:55 device.map<br>-rw-r--r-- 1 root root &nbsp; 8660 2007-11-08 03:55 e2fs_stage1_5<br>-rw-r--r-- 1 root root &nbsp; 8452 2007-11-08 03:55 fat_stage1_5<br>-rw-r--r-- 1 root root &nbsp; &nbsp; 15 2007-11-08 03:55 installed-version
<br>-rw-r--r-- 1 root root &nbsp; 9152 2007-11-08 03:55 jfs_stage1_5<br>-rw-r--r-- 1 root root &nbsp; 4655 2007-11-25 22:41 menu.lst<br>-rw-r--r-- 1 root root &nbsp; 7860 2007-11-08 03:55 minix_stage1_5<br>-rw-r--r-- 1 root root &nbsp;10132 2007-11-08 03:55 reiserfs_stage1_5
<br>-rw-r--r-- 1 root root &nbsp; &nbsp;512 2007-11-08 03:55 stage1<br>-rw-r--r-- 1 root root 110292 2007-11-08 03:55 stage2<br>-rw-r--r-- 1 root root &nbsp; 9980 2007-11-08 03:55 xfs_stage1_5<br><br>in my grub and my /etc/fstab<br><br>
proc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/proc &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; proc &nbsp; &nbsp;defaults &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; 0<br># /dev/sda7<br>UUID=4db354f4-1591-42a0-a09b-f551dd8405f8 / &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ext3<br>defaults,errors=remount-ro 0 &nbsp; &nbsp; &nbsp; 1<br># /dev/sda6<br>UUID=42f7fcfe-1b59-45e0-8ecd-0dfed91edb9c /boot &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ext3
<br>defaults &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; 2<br># /dev/sda8<br>UUID=41f8c15c-40ee-4b29-8b73-97ce3f3d4bc3 /home &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ext3<br>defaults &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; 2<br># /dev/sda1<br>UUID=2A1D-0905 &nbsp;/media/sda1 &nbsp; &nbsp; vfat &nbsp; &nbsp;defaults,utf8,umask=007,gid=46 0 &nbsp; &nbsp; &nbsp; 1
<br># /dev/sda5<br>UUID=ec55553e-b42c-4300-99d9-34333c78c468 none &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;swap &nbsp; &nbsp;sw<br> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; 0<br>/dev/scd0 &nbsp; &nbsp; &nbsp; /media/cdrom0 &nbsp; udf,iso9660 user,noauto,exec 0 &nbsp; &nbsp; &nbsp; 0<br>~<br><br>thank you!<br></blockquote>
</div><br>

------=_Part_5360_26182600.1196055034707--


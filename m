Message-ID: <cbe23c50702200216m3fc98d78se1492c34685d69d6@domain.hid>
Date: Tue, 20 Feb 2007 11:16:38 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] patching continues
In-Reply-To: <45DAC3A8.2000707@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45D9F759.7020006@domain.hid>
	<cbe23c50702192323h370cd65fg3490d82fea34cd33@domain.hid>
	<45DAC3A8.2000707@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid

2007/2/20, Roland Tollenaar <rwatollenaar@domain.hid>:
> Hi Eric and List,
>
> This is what I did:
>
> 1-copy kernel code from linux-2.6.16 into a new directory under
> /usr/src/linux-2.6.16-ipipe
> 2-Extract xenomai (latest) in /usr/src/xenomai<version>
> 3-Place adeos patch 2.6.16-1.5-02 into tmp
> 4-cd /usr/src/xenomai<version>
> 5-prepare-kerne.sh --linux=/usr/src/linux-2.6.16-ipipe
> --adeos=/tmp/adeos<version>.patch --arch=i386
> 6-cd /usr/src/linux-2.6.16-ipipe
> 7-cp /usr/src/linux-2.6.16-ipipe/somewhere/defconfig
> /usr/src/linux-2.6.16-ipipe/.config

That step may be a wrong choice.
You should try to start with the .config your running system
is currently working with and then update it for Xenomai support.

You may find such file may somewhere in /boot directory.

> 8-make menuconfig (load .config, switch off powermanagement, select CAN
> module & PEAK parallel port module)

Loading the previous .config you may make small changes
for Xenomai support.

> 9-make all
> 10-make modules_install
> 11-find bzImage remane to vmlinuz (what current kernel is called) copy
> it to /boot.
> 12-reboot

After you recompile your kernel may may retry this.
But the trouble with this scheme is that you have no kernel choice
at boot time...

I'm no syslinux expert but I may be possible to keep
2 kernels in order to ease debug cycle since once
you have overwritten your booting kernel with a non-booting one
you are stuck no?

> result runs until I get this message:
> VFS Cannot open root device
> "ram0"or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic-not syncing:VFS: unable to mount root fs on unknown -block(0,0)

The kernel should be missing some builting FS support for your
the FS you root device is on.

> Keep in mind that my Slax USB uses neither grub nor lilo but syslinux.
> I realize that i should do something to initrd but do not know what

You should get your hand on the syslinux config file and verify that
if the default kernel is using initrd or not.

If YES then you should find some initrd file under /boot
so you have to do (after your make modules_install step)
  /sbin/mkinitrd -v -f /boot/<theinitrdfiletoreplace>  2.6.16-ipipe

If NO then you should be able to build a xenomai kernel
that does not need initrd.

>
> mkinitrd is not on my system. Where must I get it?

If it is not I'm pretty sure you should be able to build
a kernel that does not need it with an appropriate kernel .config file.

-- 
Erk


Message-ID: <45DAC3A8.2000707@domain.hid>
Date: Tue, 20 Feb 2007 10:47:20 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] patching continues
References: <45D9F759.7020006@domain.hid>
	<cbe23c50702192323h370cd65fg3490d82fea34cd33@domain.hid>
In-Reply-To: <cbe23c50702192323h370cd65fg3490d82fea34cd33@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai-help@domain.hid

Hi Eric and List,

This is what I did:


1-copy kernel code from linux-2.6.16 into a new directory under 
/usr/src/linux-2.6.16-ipipe
2-Extract xenomai (latest) in /usr/src/xenomai<version>
3-Place adeos patch 2.6.16-1.5-02 into tmp
4-cd /usr/src/xenomai<version>
5-prepare-kerne.sh --linux=/usr/src/linux-2.6.16-ipipe 
--adeos=/tmp/adeos<version>.patch --arch=i386
6-cd /usr/src/linux-2.6.16-ipipe
7-cp /usr/src/linux-2.6.16-ipipe/somewhere/defconfig 
/usr/src/linux-2.6.16-ipipe/.config
8-make menuconfig (load .config, switch off powermanagement, select CAN 
module & PEAK parallel port module)
9-make all
10-make modules_install
11-find bzImage remane to vmlinuz (what current kernel is called) copy 
it to /boot.
12-reboot

result
runs until I get this message:
VFS Cannot open root device
"ram0"or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic-not syncing:VFS: unable to mount root fs on unknown -block(0,0)


Keep in mind that my Slax USB uses neither grub nor lilo but syslinux.
I realize that i should do something to initrd but do not know what

mkinitrd is not on my system. Where must I get it?

Thanks for the help, I really need it. :(

Regards,

Roland



Eric Noulard wrote:
> 2007/2/19, Roland Tollenaar <rwatollenaar@domain.hid>:
>> Hi all,
>>
>> I have gone through the kernel patching steps and all seems to go well.
>> Except...
>>
>> 1
>> I don't seem to get an initrd from the make process and my system does
>> not have a mkinitrd on it. Is this normal? I get the vmlinux though
>> which I am very happy about :)
> 
> I don't know how you did compile your kernel but if you "only" did:
> 
> make YYYYconfig
> make
> make modules_install
> 
> you won't get initrd from this.
> you need to do it yourself for example with
> 
> /sbin/mkinitrd -v -f /what_ever_dir_is/boot/initrd-2.6.16-pipe.img 
> 2.6.16-pipe
> 
> which will create (OR REPLACE if it exists) your initrd file for kernel 
> version
> 
> 2.6.16-pipe
> 
> Note that you still to update your lilo.conf / grub.conf file for
> adding your freshly
> compiled kernel.
> 
>>
>> 2
>> Then the make modules install generates the lib/modules/2.6.16-pipe
>> directory but it has only a very few modules. Not nearly as many as the
>> current kernel seems to have.
> 
> It really depends on what you chose during
> 
> make YYYYconfig
> 
> step.
> 
> you may try to diff the .config obtained for your currently running kernel
> with the one used for xenomai-patched kernel.
> 
>>
>> Might anyone be able to give some hints as to what I could be doing 
>> wrong?
> 
> What is wrong did you manage to boot?
> 
> I don't if my answer are appropriate since I don't know
> exactly what step you did for compiling your kernel.
> 
> May be you can tell us what you did exactly (command lines)
> and what you expected that does not work
> (missing files, kernel does not boot, no new kernel boot menu...)
> 
> 


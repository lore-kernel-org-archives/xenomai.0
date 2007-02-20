Message-ID: <45DB1D0F.3050107@domain.hid>
Date: Tue, 20 Feb 2007 17:08:47 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] patching continues
References: <45D9F759.7020006@domain.hid>	
	<cbe23c50702192323h370cd65fg3490d82fea34cd33@domain.hid>	
	<45DACA75.8030001@domain.hid>
	<cbe23c50702200511t7fd6bfd6nbf131df680fcd80a@domain.hid>
In-Reply-To: <cbe23c50702200511t7fd6bfd6nbf131df680fcd80a@domain.hid>
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
To: Eric Noulard <eric.noulard@domain.hid>, Xenomai-help@domain.hid

Hi,

As my distro is using syslinux and not lilo or grub the install part 
does not work. In documentation of slax it appears that vmlinuz 
,initrd.gz and kernel_01.mo must be adapted.

I have found the correct .config file I think and since I am using the 
kernel src that belongs to the distro I would expect not even to have to 
change initrd or the kernel_01.mo (latter copies the modules to the 
lib/module directory I think)

If I understand correctly xenomai is statically built into the kernel if 
I use * instead of M. So I am hoping to be able to run off the same 
modules. In fact even skip the
make module and make module_install
steps?

Or am I misunderstanding something and is this stupid?

I must be because on trying the kernel that results it gives

error inserting module ehci-hdc(1) for your kernel 2.6.16
error inserting module ohci-hdc(1) for your kernel 2.6.16
error inserting module uhci-hdc(1) for your kernel 2.6.16
error inserting module usb-storage for your kernel 2.6.16

which means it cannot find the usb after that (which is almost 
ridiculous because it loads syslinux and the kernel and initrd from it 
to get to that stage)

Kind regards,

Roland.

Eric Noulard wrote:
> 2007/2/20, Wolfgang Grandegger <wg@domain.hid>:
>> Eric Noulard wrote:
> 
>> >
>> > Note that you still to update your lilo.conf / grub.conf file for
>> > adding your freshly
>> > compiled kernel.
>>
>> On my FC5 distro I simply do:
>>
>>    $ make bzImage
>>    $ make modules
>>    # make modules_install
>>    # make install
>>
>> Then I reboot and select the new entry in the grub boot loader. I guess
>> this works for other distros as well.
> 
> You are right
> 
> make install step usually calls a script
> as shown by "make help" you may call in a configured linux kernel 
> [build] tree
>>>>
>  install       - Install kernel using
>                   (your) ~/bin/installkernel or
>                   (distribution) /sbin/installkernel or
>                   install to $(INSTALL_PATH) and run lilo
>>>>
> 
> 
> 


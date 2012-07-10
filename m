MIME-Version: 1.0
In-Reply-To: <4FFBF7A0.7070601@xenomai.org>
References: <CAKSrRNzt7tRjShU79EFYv71SbYwhjmagP11KCAk7-LUCTqXdzA@mail.gmail.com>
	<4FFBEA93.5070202@xenomai.org>
	<CAKSrRNxNEU5f3eY93tgL1WQjtPP5500z1pbYFjLnYOf2P4T2Zg@mail.gmail.com>
	<4FFBF197.4050203@xenomai.org>
	<CAKSrRNwnjG1GRogzx5_QaXu_Jwe+HuQWoQVjqe8N_YQO9GT9Sg@mail.gmail.com>
	<4FFBF7A0.7070601@xenomai.org>
Date: Tue, 10 Jul 2012 07:23:46 -0400
Message-ID: <CAKSrRNxBZ+GYVRwZhjOxX+tb_LvXhJgjF8ydckmtUNU3PoQdzg@mail.gmail.com>
From: Sunetra Sashi <snmgmt19@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] XDDP and inter-driver API.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

What is the recommended methodology for kernel space modules to communicate
with each other across the Linux-Xenomai space?

I corrected the rtipc rtdm device as a protocol device (I must have changed
it in error) and I am able to load the xeno_rtipc.ko now. However, the
socket open still fails with the same error code.

Thanks



>
>>         I am making these calls from within the kernel, not from user
>> space.
>>         Hence I ended up using rtdm calls instead
>>
>>
>>
>>     /dev/rtp0 is a non-real-time user-space endpoint for the
>>     communication, between a regular linux application and a real-time
>>     component. It does not make sense to open it from kernel space.
>>
>>
>> My intent here is to set up something similar to xddp-echo.c  (RT - Non
>> RT communication) but in kernel space instead. How should I go about
>> creating the Linux endpoint for XDDP in the kernel?
>>
>>
> There is no direct way for that, this device/protocol is not intended for
> this purpose. This is a regular linux application to Xenomai real-time
> communication path, nothing else. Regular linux applications live in
> userland, only.
>
> We don't recommend building applications in kernel space.
>
>
>
>>
>>
>>
>>
>>                  Do I need to install any specific xenomai modules for
>>         this to work?
>>
>>
>>              Obviously, yes. Check IPC drivers in the "Drivers" sub-menu
>>         of the
>>              Xenomai configuration. You need to have
>>              CONFIG_XENO_DRIVERS_RTIPC_XDDP enabled.
>>
>>
>>         I already checked this in the configuration, It is enabled.
>>         Should this
>>         also be set to y? CONFIG_XENO_DRIVERS_RTIPC. In my configuration
>>         it is
>>         set to m.
>>
>>
>>     Did you load the xeno_rtipc module then?
>>
>>
>> It is not loaded. But I got an error when I did that.
>> Xenomai: assertion failed at /.../kernel/xenomai/skins/)
>> Xenomai: RTDM: missing open handler
>>
>
> It does not make any sense. This assertion can only trigger for a named
> device, not a protocol device. RTIPC is a protocol device.
>
> - did you change any of the driver code?
> - what command did you use to load the module, verbatim?
>
>  insmod: error inserting 'xeno_rtipc.ko': -1 Invalid parameters
>>
>>
>>
>>         Should I see any modules loaded in
>>         /proc/xenomai/rtdm/protocol___**devices?
>>
>>
>>     Yes.
>>
>>
>>
>>
>>                  Thanks
>>                  Shweta
>>                  ______________________________**_____________________
>>
>>                  Xenomai mailing list
>>         Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>
>>         <mailto:Xenomai@xenomai.org <mailto:Xenomai@xenomai.org>>
>>         http://www.xenomai.org/____**mailman/listinfo/xenomai<http://www.xenomai.org/____mailman/listinfo/xenomai>
>>         <http://www.xenomai.org/__**mailman/listinfo/xenomai<http://www.xenomai.org/__mailman/listinfo/xenomai>
>> >
>>
>>                  <http://www.xenomai.org/__**mailman/listinfo/xenomai<http://www.xenomai.org/__mailman/listinfo/xenomai>
>>         <http://www.xenomai.org/**mailman/listinfo/xenomai<http://www.xenomai.org/mailman/listinfo/xenomai>
>> >>
>>
>>
>>
>>              --
>>              Philippe.
>>
>>
>>
>>
>>
>>     --
>>     Philippe.
>>
>>
>>
>>
>
> --
> Philippe.
>
>
>

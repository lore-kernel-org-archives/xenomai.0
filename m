Message-ID: <472890E9.2050309@domain.hid>
Date: Wed, 31 Oct 2007 06:27:53 -0800
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
References: <mailman.679.1193823466.23395.xenomai@xenomai.org>
In-Reply-To: <mailman.679.1193823466.23395.xenomai@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai-help Digest, Vol 25, Issue 45
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org



xenomai-help-request@domain.hid wrote:
> Send Xenomai-help mailing list submissions to
> 	xenomai@xenomai.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://mail.gna.org/listinfo/xenomai-help
> or, via email, send a message with subject or body 'help' to
> 	xenomai-help-request@domain.hid
>
> You can reach the person managing the list at
> 	xenomai-help-owner@domain.hid
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Xenomai-help digest..."
>
>
> Today's Topics:
>
>    1. Re: build kernel missing  System.map, vmlinuz, initrd when
>       using $xenomai_root/configure --enable-x86-sep (Dennis Nguyen)
>    2. Xenomai loading module error when running xero-test
>       (Dennis Nguyen)
>    3. Re: [Xenomai-core] Xenomai v2.4-rc4 (Gilles Chanteperdrix)
>    4. Re: Comedi driver for use with xenomai (Alexis Berlemont)
>    5. Re: RT, nonRT communication (ROSSIER Daniel)
>    6. Re: RT, nonRT communication (Gilles Chanteperdrix)
>    7. Re: Comedi driver for use with xenomai (Leopold Palomo Avellaneda)
>    8. xntbase_get_jiffies in user space? (Thomas Necker)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 30 Oct 2007 07:13:24 -0800
> From: Dennis Nguyen <dennisnguy@domain.hid>
> Subject: Re: [Xenomai-help] build kernel missing  System.map, vmlinuz,
> 	initrd when using $xenomai_root/configure --enable-x86-sep
> To: Jan Kiszka <jan.kiszka@domain.hid>
> Cc: xenomai-help <xenomai@xenomai.org>
> Message-ID: <47274A14.6060500@domain.hid>
> Content-Type: text/plain; charset=UTF-8; format=flowed
>
> Thanks Jan,
> It worked,
> I need to use the $xenomai_root/configure in a build directory which 
> separated from $kernel_tree.
> Regards,
> Dennis
>
> Jan Kiszka wrote:
>   
>> Dennis Nguyen wrote:
>>   
>>     
>>> Yes, I used make install after run $xenomai/configure --enable-x86-sep. 
>>> Sorry, I forgot to mention in the previous email
>>> I could not get the System.map. vxlimux, and initrd.
>>> Also make clean, make menuconfig would not work after that.
>>> The message was: make: *** No rule to make target 'clean'. Stop.
>>> I have to remove the kernel and start over.
>>>     
>>>       
>> You need to run make install in the kernel directory. The other
>> "install" is for user land libs, tools, etc.
>>
>> Jan
>>   
>>     
>
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 30 Oct 2007 13:47:15 -0700
> From: Dennis Nguyen <dennisnguy@domain.hid>
> Subject: [Xenomai-help] Xenomai loading module error when running
> 	xero-test
> To: xenomai-help <xenomai@xenomai.org>
> Message-ID: <47279853.9050704@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Hello,
> I'm using linux kernel i386 2.6.20.10, xenomai 2.4-rc5, 
> adeos-ipipe-2.6.20-i386-1.10.10.patch.
> I got errors when running xenoo-test:
> FATAL: Error inserting xeno_nucleus 
> (/lib/modules/2.6.20.10/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko): 
> No such device
> WARNING: Error inserting xeno_nucleus 
> (/lib/modules/2.6.20.10/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko): 
> No such device
> FATAL: Error inserting xeno_posix 
> (/lib/modules/2.6.20.10/kernel/kernel/xenomai/skins/posix/xeno_posix.ko): 
> Unknown symbol in module, or unknown parameter (see dmesg)
> Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_posix?)
> ERROR: Module xeno_posix does not exist in /proc/modules
> ERROR: Module xeno_nucleus does not exist in /proc/modules
> I checked the xeno_nucleus.ko and  xeno_posix.ko files in the 
> directories and they were there.
> Any suggestion please?
> I had other PC which run exactly configuration (I copied the .config) 
> and the test done successful.
> Thanks,
> Dennis
>   
The problem also happened with kernel i386 2.6.22.10, xenomai 2.4rc5, 
adeos-ipipe-2.6.22-i386-1.10.11.patch. It could not load xeno_nucleus, 
xeno_native, xeno_rtdm, and xeno_timerbench. The messages were:
xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
ERROR: Modele xeno_timerbench doesnot exist in /proc/module
ERROR: Modele xeno_rdtm doesnot exist in /proc/module
ERROR: Modele xeno_native doesnot exist in /proc/module
ERROR: Modele xeno_nucleus doesnot exist in /proc/module
(I enabled CONFIG_XENO_OPT_PERVASIVE, and configured them as module (M)).

When I manually insmod the modules: insmode xeno_native.ko the message was:
insmod: error inserting 'xeno_native.ko': -1 Unknown symbol in module.

These issues occurred on an Intel  486  600MHz PC,
Any suggestion please,

Thanks
Dennis

> ------------------------------
>
> Message: 3
> Date: Tue, 30 Oct 2007 23:32:11 +0100
> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> Subject: Re: [Xenomai-help] [Xenomai-core] Xenomai v2.4-rc4
> To: "Daniel Schnell" <daniel.schnell@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID: <18215.45291.872538.68005@domain.hid>
> Content-Type: text/plain; charset=us-ascii
>
> Daniel Schnell wrote:
>  > Gilles Chanteperdrix wrote:
>  > > On 10/30/07, Daniel Schnell <daniel.schnell@domain.hid> wrote:
>  > >> However we think there might be a problem with
>  > >> pthread_cond_timedwait() in the POSIX skin.
>  > >> It seems that after return of ETIMEOUT the mutex is not acquired
>  > >> again by the function automatically
>  > > 
>  > > Ok, do you still observe the same behaviour with the attached patch ?
>  > 
>  > No, this patch fixes the issues. Thanks.
>  > 
>  > 
>  > Was the segmentation fault corelated to that fix or is it still waiting
>  > somewhere ?
>
> The segmentatino fault was due to a cleanup handler "pthread_cleanup_push"ed by
> __wrap_pthread_cond_timedwait that was not pthread_cleanup_poped in the
> error case.
>
>   


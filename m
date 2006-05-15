Message-ID: <4468694D.7080808@domain.hid>
Date: Mon, 15 May 2006 13:43:09 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] mutex_init() error when build
References: <4546494d0605150250h350fa8c6me325b6d7a73a6d6f@domain.hid>
	<4468652B.1050704@domain.hid>
In-Reply-To: <4468652B.1050704@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-help@domain.hid

Philippe Gerum wrote:
> Li Yi (Adam) wrote:
> 
>> Hi,
>>
>> I am using Xenomai-2.1.0 on Blackfin uClinux. When enabling "POSIX" 
>> interface and build the kernel, I got error message:
>>
> 
> It's a known issue involving a naming conflict between 2.6.16 and Xeno 
> 2.1.x. This has been fixed in 2.2, but we will likely have to backport 
> this fix.

This has already been fixed in 2.1.1. Please upgrade.

> 
>> "make
>> make ARCH=blackfin CROSS_COMPILE=bfin-uclinux- -C linux-2.6.x  || exit 1
>> make[1]: Entering directory 
>> `/home/adam/workspace/kernel/adeos/uClinux-dist_0425/linux-2.6.x'
>>   CHK     include/linux/version.h
>>   CHK     include/linux/compile.h
>>   CHK     usr/initramfs_list
>>   CC      kernel/xenomai/skins/posix/syscall.o
>> kernel/xenomai/skins/posix/syscall.c:810: error: conflicting types for 
>> '__mutex_init'
>> include/linux/mutex.h:94: error: previous declaration of 
>> '__mutex_init' was here
>> kernel/xenomai/skins/posix/syscall.c:810: error: conflicting types for 
>> '__mutex_init'
>> include/linux/mutex.h:94: error: previous declaration of 
>> '__mutex_init' was here
>> make[5]: *** [kernel/xenomai/skins/posix/syscall.o] Error 1
>> make[4]: *** [kernel/xenomai/skins/posix] Error 2
>> make[3]: *** [kernel/xenomai/skins] Error 2
>> make[2]: *** [kernel/xenomai] Error 2
>> make[1]: *** [kernel] Error 2
>> "
>>
>> include/linux/mutex.h:
>>
>> extern void fastcall __mutex_init(struct mutex *lock, const char *name);
>>
>> The function definition is different. I tried to add "static" in 
>> syscall.c: __mutex_init(), still cannot work. Could you please help?
>>
>> Thanks,
>> -Yi
>>
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
> 
> 
> 


-- 

Philippe.


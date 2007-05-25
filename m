Message-ID: <4656A8A1.5050202@domain.hid>
Date: Fri, 25 May 2007 11:13:05 +0200
From: Rodolfo Bamberg <rolfetas@domain.hid>
MIME-Version: 1.0
References: <4656A529.5000405@domain.hid> <4656A71C.2010801@domain.hid>
In-Reply-To: <4656A71C.2010801@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem compiling for user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

I thought I did compile xenomai for the same target by passing the
--build=i386-linux-uclibc option to .configure.

Gilles Chanteperdrix wrote:
> Rodolfo Bamberg wrote:
>   
>> I am trying to cross-compile for i386 a user-space xenomai RT binary, I
>> installed xenomai in the root file system of the target with the
>> --build=i386-linux-uclibc option to cross compile for the target. 
>>
>> Here's the relevant makefile part of the program I'm trying to compile:
>>
>> XENOMAI_INCLUDE_DIR_USP    :=/tftpboot/192.168.0.2/include
>> XENOMAI_INCLUDE_LIB_USP :=/tftpboot/192.168.0.2/lib
>>
>> user:
>>     i386-linux-uclibc-gcc -I$(XENOMAI_INCLUDE_DIR_USP)
>> -L$(XENOMAI_INCLUDE_LIB_USP) -lnative -o rt_process_user rt_process_user.c
>>     chmod a+x rt_process_user
>>
>> and here the error:
>>
>>  # make user
>> i386-linux-uclibc-gcc -I/tftpboot/192.168.0.2/include
>> -L/tftpboot/192.168.0.2/lib -lnative -o rt_process_user rt_process_user.c
>> rt_process_user.c: In function 'latency_init':
>> rt_process_user.c:115: warning: passing argument 2 of 'rt_task_start'
>> from incompatible pointer type
>> /home/rodolfo/buildroot-2/build_i386/staging_dir/lib/gcc/i386-linux-uclibc/4.1.2/../../../../i386-linux-uclibc/bin/ld:
>> warning: libc.so.6, needed by /tftpboot/192.168.0.2/lib/libnative.so,
>> not found (try using -rpath or -rpath-link)
>> /tftpboot/192.168.0.2/lib/libnative.so: undefined reference to
>> `free@domain.hid'........
>>
>> does anyone know why it needs libc.so.6? thanks!
>>     
>
> Well, it is pretty obvious from the error message you show us:
> libnative.so uses free and is linked with glibc. If you want to compile
> your applications with i386-linux-uclibc, you should compile Xenomai
> with the same compiler.
>
>   




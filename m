Message-ID: <44329186.3080908@domain.hid>
Date: Tue, 04 Apr 2006 11:32:22 -0400
From: Randy Smith <rsmith@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Questions porting existing rtai-24.1.12 app to
	xenomai (PART II)
References: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>
	<44328187.6080005@domain.hid> <44327F66.10800@domain.hid>
In-Reply-To: <44327F66.10800@domain.hid>
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
Cc: xenomai@xenomai.org



Philippe Gerum wrote:
>
> Make sure to read this then (also includes simple porting tips from 
> RTAI to the native API):
>
> http://download.gna.org/xenomai/documentation/branches/v2.1.x/pdf/Native-API-Tour.pdf 
>

Thanks...Already been looking it over.
>
>> I must have installed xenomai incorrectly as my code is not compiling 
>> without some header files complaining about basic types like atomic_t 
>> not being defined.  I have a kernel source tree installed in a 
>> non-standard place, lets call it /home/randy/linux and the xenomai 
>> package under /home/randy/xenomai-2.1.0.  I have applied the adios 
>> patch and done the prepare_kernel.sh thing.  So far so good.  I can 
>> then do make menuconfig and setup the realtime stuff then make uImage 
>> and the kernel builds correctly (yes, I am cross-compiling for a 
>> powerpc).  That all works ok.
>>
>> Where I'm confused is this.  Do I then do something like
>>
>> $ cd /home/randy
>> $ mkdir xenomai && cd xenomai
>> $ ../xenomai-2.1.0/configure --build=i686-linux --host=ppc-linux 
>> --prefix=/home/randy
>> $ make all
>> $ make install
>
> Make sure reading configure's output that the right ppc 
> (cross-)compiler is found and used.
Yes, the correct cross-compiler is being used.
>
>>
>> OR should I be in the kernel tree such as
>>
>> $ cd /home/randy/linux
>> $ ../xenomai-2.1.0/configure --build=i686-linux --host=ppc-linux 
>> --prefix=/home/randy/linux
>>
>
> This part is to build the user-space (only) support, so #1 is the 
> right one. Since 2.1, Xenomai clearly splits the kernel side from the 
> user-space support, so building the RT subsystem is just a matter of 
> configuring yet-another-linux-subsystem using the regular Linux 
> Kconfig interface, instead of fiddling with 
> yet-another-nonstandard-kconfig. It also makes possible to build such 
> RT subsystem statically into the kernel, and not only as external 
> modules, which is good for our poor TLBs.
>
> If we keep on being good boys in the future and don't change the skin 
> system call numbers and prototypes each time at full moon, we might 
> even reach some kind of reasonably stable ABI, so that the user-space 
> stuff could run on the largest possible set of older versions of the 
> kernel side.
>
> README.INSTALL gives simple examples for building the user-space 
> support for various archs; maybe this would help.
It got me started, but I was unsure (since my case is such a unique one 
of cross-compiling and source tree in non-standard place) of what to do.

>
>> ???
>>
>> One of the problems I am seeing is that after the make all and make 
>> install, there is built, an include file tree under 
>> /home/randy/include and when I include this path on the compiler 
>> command line, I get circular references such as
>>
>> #include <asm/atomic.h> from line 29 of /home/randy/include/asm/atomic.h
>>
>> which should refer to the kernel include of 
>> /home/randy/linux/include/asm/atomic.h but instead picks up itself 
>> again and doesn't define the atomic_t (among other things)
>>
>> Obviously I'm doing something wrong and any help would be appreciated.
>>
>
> Something looks like being badly trashed in your source tree, which 
> would be quite possible if #2 is current.
No, I haven't done the second case yet.  I am having so many problems 
compiling the kernel modules with case #1 that I thought I did something 
wrong.



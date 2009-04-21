Message-ID: <49EDD200.9050700@domain.hid>
Date: Tue, 21 Apr 2009 16:02:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1240088252.31471.6.camel@domain.hid>	<1240094529.26554.176.camel@domain.hid>
	<1240255022.8518.27.camel@domain.hid>	<1240258490.26554.241.camel@domain.hid>
	<1240315440.14934.9.camel@domain.hid>
In-Reply-To: <1240315440.14934.9.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Using xeno-config in cross compiling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jeff angielski <jeff@domain.hid>
Cc: xenomai@xenomai.org

jeff angielski wrote:
> On Mon, 2009-04-20 at 22:14 +0200, Philippe Gerum wrote:
>> On Mon, 2009-04-20 at 15:17 -0400, jeff angielski wrote:
>>> On Sun, 2009-04-19 at 00:42 +0200, Philippe Gerum wrote:
>>>> On Sat, 2009-04-18 at 16:57 -0400, jeff angielski wrote:
>>>>> What is the proper way to cross compiler a POSIX skin application in a
>>>>> cross compiler development setup?
>>>>>
>>>> The way you did it is probably ok; but you may want to tell xeno-config
>>>> where to find the staging directory via the DESTDIR variable, so it can
>>>> locate all the host files it needs locally (e.g. posix.wrappers).
>>>>
>>>> i.e.
>>>>
>>>> DESTDIR=/srv/nfs/srp-xen /srv/nfs/srp-xen/usr/xenomai/bin/xeno-config
>>>> --posix-cflags ...
>>> This compiles but won't run as-is on the target because it complains
>>> it's missing the pthread_rt library.
>>>
>>> # ./readirq-posix
>>> ./readirq-posix: error while loading shared libraries:
>>> libpthread_rt.so.1: cannot open shared object file: No such file or
>>> directory
>>>
>>> # ldd ./readirq-posix
>>>         linux-vdso32.so.1 =>  (0x00100000)
>>>         libpthread_rt.so.1 => not found
>>>         libpthread.so.0 => /lib/libpthread.so.0 (0x0ff98000)
>>>         librt.so.1 => /lib/librt.so.1 (0x0ff40000)
>>>         libc.so.6 => /lib/libc.so.6 (0x0fda1000)
>>>         /lib/ld.so.1 (0x48000000)
>>>
>>>
>>> I used LD_LIBRARY_PATH to get it to work but it seems like I must be
>>> missing a step somewhere in the process.
>>>
>>> # LD_LIBRARY_PATH=/usr/xenomai/lib ./readirq-posix
>>>
>>>
>>> Do other people cross compiling for POSIX skins have to do this?
>>>
>> You need to set up your dynamic linker config properly on the target;
>> see ldconfig related files, and particularly ld.so.conf (or ld.so.conf.d
>> with newer ld.so versions).
> 
> Sounds reasonable.  However, I do not have to play with the dynamic
> libraries when I run the cyclictest application which also uses the
> POSIX skins.
> 
> The difference, of course, is that my application uses the
> examples/posix Makefile [xeno-config] while cyclictest uses the automake
> generated Makefile in the src/testsuite/cyclic.
> 
> Perhaps even with using DESTDIR before make there is still something not
> being setup correctly.
> 

See:
http://www.linux.org/docs/ldp/howto/Program-Library-HOWTO/shared-libraries.html


-- 
                                                 Gilles.


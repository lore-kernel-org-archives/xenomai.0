Message-ID: <439AB1BE.1060506@domain.hid>
Date: Sat, 10 Dec 2005 11:45:18 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug?] set pthread stack size broken
References: <4398B958.8040705@domain.hid> <4399313A.6090004@domain.hid>
	<4399AE7A.2030507@domain.hid>
	<4399B477.6050101@domain.hid>
	<4399E1E9.6000509@domain.hid>
In-Reply-To: <4399E1E9.6000509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>
>>>Jan Kiszka wrote:
>>>
>>>
>>>>Jan Kiszka wrote:
>>>>
>>>>
>>>>>Hi,
>>>>>
>>>>>something for the night: Can someone explain why normal pthreads can be
>>>>>restricted to initially use only the stack size provided via
>>>>>pthread_attr_setstacksize() while any rt-mapped thread (posix and
>>>>>native) refuse to accept this? For a simple test, compile the attached
>>>>>program one time as normal
>>>>>
>>>>>   gcc -lpthread -o stacksize stacksize.c
>>>>>
>>>>>and the other time against xeno's posix skin
>>>>>
>>>>>   gcc `xeno-config --posix-cflags` `xeno-config --posix-ldflags` \
>>>>>       -o stacksize.o stacksize.c
>>>>>
>>>>>Then compare the memory requirements of both processes - they should
>>>>>differ by 2M, the stack size when pthread_attr_setstacksize is not
>>>>>used.
>>>>>Strange - and also critical when considering larger applications...
>>>>
>>>>
>>>>This has been nailed down now to be some strange linker problem: while
>>>>the standard version of the stacksize demo calls the latest
>>>>pthread_create (__pthread_create_2_1 in glibc-2.3.x), the wrapped
>>>>real-time version and likely also applications linked against libnative
>>>>call an older pthread_create (__pthread_create_2_0). That variant
>>>>assumes that pthread_attr_t does not yet contain things like the stack
>>>>size and fills in the standard value again. :(
>>>>
>>>>Can anyone with another build environment than my SuSE 10 confirm this?
>>>>
>>>>
>>>>
>>>>>So far I only tested against 2.1, but I don't see a reason why 2.0.x
>>>>>should behave different. Will get checked, though.
>>>>>
>>>>
>>>>Same behaviour on 2.0.x (SVN).
>>>>
>>>>Jan
>>>>
>>>
>>>
>>>The attached patch fixes this issue for 2.1-SVN. A similar patch should
>>>be applied to 2.0.x as well. And maybe it also hits the UVM, but this is
>>>something I cannot assess ATM.
>>>
>>>Well, you know, the smaller the bug... :-/
>>>
>>>Jan
>>>
>>>
>>>PS: For those you are interested why we need this, read
>>>
>>>https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=145941
>>>
>>>Found via google:"pthread_create NOTYPE" after I noticed the differences
>>>in "readelf -s libnative.so".
>>>
>>>
>>>------------------------------------------------------------------------
>>>
>>>Index: src/skins/native/Makefile.am
>>>===================================================================
>>>--- src/skins/native/Makefile.am    (revision 243)
>>>+++ src/skins/native/Makefile.am    (working copy)
>>>@@ -1,6 +1,6 @@
>>> lib_LTLIBRARIES = libnative.la
>>> 
>>>-libnative_la_LDFLAGS = -module -version-info 0:0:0
>>>+libnative_la_LDFLAGS = -module -version-info 0:0:0 -pthread
>>> 
>>> libnative_la_SOURCES = \
>>>     alarm.c \
>>>Index: src/skins/posix/Makefile.am
>>>===================================================================
>>>--- src/skins/posix/Makefile.am    (revision 243)
>>>+++ src/skins/posix/Makefile.am    (working copy)
>>>@@ -2,7 +2,7 @@
>>> 
>>> lib_LTLIBRARIES = libpthread_rt.la
>>> 
>>>-libpthread_rt_la_LDFLAGS = -module -version-info 0:0:0
>>>+libpthread_rt_la_LDFLAGS = -module -version-info 0:0:0 -lpthread
>>>
>>> libpthread_rt_la_SOURCES = \
>>>     init.c \
>>
>>
>>Applied (with -pthread everywhere), thanks.
>>
> 
> 
> Hmm, shouldn't is spell -lpthread? Seems like the autotools resolve this
> because it works with both versions for me (current posix/Makefile.in
> still has "-lpthread").
> 

gcc supports this actually, as a way to specify "whatever the platform 
needs to support POSIX threads". But, well, since not all platforms 
support this feature using the same option, I need to further check for 
the existing ports.

-- 

Philippe.


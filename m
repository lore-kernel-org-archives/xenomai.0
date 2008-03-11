Message-ID: <47D67075.7060504@domain.hid>
Date: Tue, 11 Mar 2008 12:43:49 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <47D65A87.3020004@domain.hid>
	<2ff1a98a0803110325w5f497596tb7206095aa211a65@domain.hid>
In-Reply-To: <2ff1a98a0803110325w5f497596tb7206095aa211a65@domain.hid>
Content-Type: multipart/mixed; boundary="------------070909010501000700000203"
Subject: Re: [Xenomai-core] Problems with satch.c under Linux 2.4
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------070909010501000700000203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Gilles Chanteperdrix wrote:
> On Tue, Mar 11, 2008 at 11:10 AM, Wolfgang Grandegger <wg@domain.hid> wrote:
>> Hello,
>>
>>  I tried to test the POSIX example program satch.c under Linux 2.4.25 for
>>  PPC. I was able to fix a few issues but the module does still not load.
>>  I have attached a patch for Xenomai 2.4.2 fixing:
>>
>>  - User-space satch: It was necessary to move time.h and signal.h to the
>>   end of the include block to get it compiled (otherwise clockid_t is
>>   defined, etc.)
> 
> This should not happen, header file should not depend on the inclusion order.

True, but it happens quite often :-(.


> 
>>  - User-space satch: It was necessary to move "#define xnprintf printf"
>>   behind the include block, otherwise the linker complains about missing
>>   symbols. I wonder how this can work with 2.6. And what is the status
>>   of xnprintf?
>>
>>  - Makefile: to avoid a mixup of CFLAG definitions for compiling the
>>   user-space and kernel-space part, I renamed CFLAGS to UCFLAGS etc.
>>   (see patch). Note sure if this is an issue for 2.6 as well.
>>
>>  - Makefile: I added -DPRODUCER to the module build with Linux 2.4.
> 
> I tested satch recently on trunk. I had to make the printf change
> (xnprintf is now defined in xenomai include files to xnarch_printf,
> but xnarch_printf is not defined when compiling in user space, so I
> replaced #define xnprintf printf with #define xnarch_printf printf) to
> make it work again, but I saw no problem with include file order.

The problem with xnprintf goes away with "#define xnarch_printf printf".
I have attached the make log showing the errors with the original
include file order.

>>  - I got the module build, but insmod fails with:
>>
>>   bash-2.05b# insmod satch.o
>>   satch.o: unresolved symbol shm_unlink
>>   satch.o: unresolved symbol ftruncate
>>   satch.o: unresolved symbol shm_open
>>   satch.o: unresolved symbol munmap
>>   satch.o: unresolved symbol mmap
>>   satch.o: unresolved symbol pse51_shm_close
>>
>>   Any idea why?
> 
> Because satch uses xenomai posix shared memories, so you have to
> enable support for shared memories in the posix module configuration.

OK, that fixed the problem. A hint in the README would be useful, though.

Thanks.

Wolfgang.


--------------070909010501000700000203
Content-Type: text/x-log;
 name="make1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="make1.log"

ppc_6xx-gcc -D__KERNEL__ -I/temp/test/linuxppc_2_4_devel/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/temp/test/linuxppc_2_4_devel/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -g -ggdb -DMODULE -DPRODUCER -I/temp/test/linuxppc_2_4_devel/include/xenomai -I/temp/test/linuxppc_2_4_devel/include/xenomai/compat -I/temp/test/linuxppc_2_4_devel/include/xenomai/posix   -c -o satch.o satch.c
In file included from satch.c:7:
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:61: error: parse error before "clock_id"
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:62: warning: function declaration isn't a prototype
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:64: error: parse error before "clock_id"
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:65: warning: function declaration isn't a prototype
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:67: error: parse error before "clock_id"
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:68: warning: function declaration isn't a prototype
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:70: error: parse error before "clock_id"
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:73: warning: function declaration isn't a prototype
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:78: error: parse error before "clockid"
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:80: warning: function declaration isn't a prototype
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:82: error: parse error before "timerid"
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:82: warning: function declaration isn't a prototype
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:84: error: parse error before "timerid"
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:87: warning: function declaration isn't a prototype
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:89: error: parse error before "timerid"
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:89: warning: function declaration isn't a prototype
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:91: error: parse error before "timerid"
/temp/test/linuxppc_2_4_devel/include/xenomai/posix/time.h:91: warning: function declaration isn't a prototype
In file included from /temp/test/linuxppc_2_4_devel/include/asm/xenomai/wrappers.h:27,
                 from /temp/test/linuxppc_2_4_devel/include/asm-generic/xenomai/hal.h:40,
                 from /temp/test/linuxppc_2_4_devel/include/asm/xenomai/hal.h:32,
                 from /temp/test/linuxppc_2_4_devel/include/asm-generic/xenomai/system.h:39,
                 from /temp/test/linuxppc_2_4_devel/include/asm/xenomai/system.h:29,
                 from /temp/test/linuxppc_2_4_devel/include/xenomai/nucleus/types.h:39,
                 from /temp/test/linuxppc_2_4_devel/include/xenomai/nucleus/queue.h:24,
                 from /temp/test/linuxppc_2_4_devel/include/xenomai/nucleus/timebase.h:29,
                 from /temp/test/linuxppc_2_4_devel/include/xenomai/nucleus/timer.h:26,
                 from /temp/test/linuxppc_2_4_devel/include/xenomai/nucleus/thread.h:25,
                 from /temp/test/linuxppc_2_4_devel/include/xenomai/nucleus/pod.h:34,
                 from /temp/test/linuxppc_2_4_devel/include/xenomai/nucleus/xenomai.h:23,
                 from /temp/test/linuxppc_2_4_devel/include/xenomai/posix/pthread.h:24,
                 from satch.c:12:
/temp/test/linuxppc_2_4_devel/include/asm-generic/xenomai/wrappers.h:169: error: parse error before numeric constant
make: *** [satch.o] Error 1


--------------070909010501000700000203--


Message-ID: <51398293.9030103@xenomai.org>
Date: Fri, 08 Mar 2013 07:17:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51372B12.2030400@mitrol.it>
	<51373149.4050700@xenomai.org>	<5137370B.2050402@mitrol.it>
	<51373841.70704@xenomai.org>	<51385910.80203@mitrol.it>
	<51388A3A.2090004@xenomai.org> <51388DD2.2020805@mitrol.it>
	<51388EB2.6000206@xenomai.org> <51389940.1090100@mitrol.it>
In-Reply-To: <51389940.1090100@mitrol.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Sporadic problem : rt_task_sleep locked
	after	debugging
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>, Xenomai <xenomai@xenomai.org>

On 03/07/2013 02:42 PM, Paolo Minazzi wrote:

> Il 07/03/2013 13.57, Gilles Chanteperdrix ha scritto:
>> #define ARM(x...)	x
>> #define	THUMB(x...)
> I have a problem of double definition of  __xn_tscinfo
> 
> #make
> 2ms.c: In function 'InitIrq':
> 2ms.c:182: warning: incompatible implicit declaration of built-in 
> function 'exit'
> /DVD/xenomai-2.6.2.1/src/skins/common/.libs/libxenomai.a(libxenomai_la-bind.o):(.data+0x0): 
> multiple definition of `__xn_tscinfo'
> /DVD/xenomai-2.6.2.1/src/skins/native/.libs/libnative.a(libnative_la-init.o):(.data+0x4): 
> first defined here
> collect2: ld returned 1 exit status
> make: *** [All] Error 1
> 
> 
> __xn_tscinfo is defined in src/include/asm/xenomai/bits/bind.h
> 
> ...
> ...
> #include <asm-generic/xenomai/bits/bind.h>
> #include <asm/xenomai/syscall.h>
> 
> struct __xn_full_tscinfo __xn_tscinfo = {
>          .kinfo = {
>                  .type = -1,
>          },
> };
> ...
> ...
> 
> It is strange define a struct in a .h file.


Right, normally this file should only be included in
src/skins/common/bind.c, but it happens to be included in all skins.
Will fix.

-- 
                                                                Gilles.


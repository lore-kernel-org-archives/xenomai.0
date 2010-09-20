From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=5RZVyUPvThyLDRPsmD9U0=A8_UPPm3bUi1E_q@domain.hid>
References: <AANLkTi=5RZVyUPvThyLDRPsmD9U0=A8_UPPm3bUi1E_q@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Sep 2010 07:23:47 +0200
Message-ID: <1284960227.4114.11.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pSOS+ simple example returns error code -14
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ronny meeus <ronny.meeus@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2010-09-19 at 16:04 +0100, ronny meeus wrote:
> Hello
> 
> I'm using xenomai in a qemu setup.
> My final goal is to use xenomai to port extisting pSOS application to
> the linux platform.
> 
> The first step I did was building a kernel with the pSOS skin enabled.
> These traces are generated at kernel startup:
> [    0.212363] I-pipe: Domain Xenomai registered.
> [    0.212363] Xenomai: hal/i386 started.
> [    0.212363] Xenomai: scheduling class idle registered.
> [    0.212363] Xenomai: scheduling class rt registered.
> [    0.246987] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
> [    0.246987] Xenomai: debug mode enabled.
> [    0.274658] Xenomai: starting native API services.
> [    0.274658] Xenomai: starting POSIX services.
> [    0.296357] Xenomai: starting RTDM services.
> [    0.296357] Xenomai: registered exported object RN#0 (regions)
> [    0.296357] Xenomai: starting pSOS+ services.
> [    0.305601] HugeTLB registered 4 MB page size, pre-allocated 0
> pages
> 
> This is the example application:
> 
> #include <psos+/psos.h>
> 
> void task2_func(u_long a,u_long b,u_long c,u_long d)
> {
>         while (1) {
>                 tm_wkafter(1000);
>         }
> }
> 
> int main(int argc, char **argv)
> {
>         unsigned long tid;
>         unsigned long args[4] = {0,0,0,0};
> 
>         t_create("TEST",10,160000,160000,0,&tid);
>         t_start(tid,0,task2_func,args);
>         while (1) {
>                 sleep(100);
>         }
> }

I'm unsure whether the code above is actually the one which issues the
output mentioned below. I see no t_shadow call, and no status printout
there.

> 
> The command line used during compilation is:
> 
> /home/meeusr/repo/xenomai-configs/buildroot-output/staging/usr/bin/i686-unknown-linux-uclibc-gcc -Os -pipe -Os -mtune=i686 -march=i686 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -I/home/meeusr/repo/xenomai-configs/buildroot-output/staging/usr/include -I/home/meeusr/repo/xenomai-configs/buildroot-output/staging/include --sysroot=/home/meeusr/repo/xenomai-configs/buildroot-output/staging/ -isysroot /home/meeusr/repo/xenomai-configs/buildroot-output/staging -I/home/meeusr/repo/xenomai-configs/buildroot-output/target/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ -I/home/meeusr/repo/xenomai-configs/buildroot-output/target/usr/xenomai/include/psos+  rtprint.c -lpsos -L/home/meeusr/repo/xenomai-configs/buildroot-output/target/usr/xenomai/lib -lxenomai -lpthread  -lpsos -Xlinker -rpath -Xlinker /home/meeusr/repo/xenomai-configs/buildroot-output/target/usr/xenomai/lib -lrtdk -o rtprint_ronny
> 
> 
> When I try to run the application I get (first time):
> # ./rtprint_ronny
> Xenomai pSOS skin init: t_shadow() failed, status -14# 
> #

Assuming your code does call t_shadow, the behavior you see is caused by
a regression in the pSOS skin. Please apply:
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=55c1b958c6bd11068cacb6258c7a957ab581ce73

> 
> The second time I get
> # ./rtprint_ronny
> [  145.049826] Xenomai: FAILED to register object MAIN (unknown type),
> status -17
> Xenomai pSOS skin init: t_shadow() failed, status -17# 
> # 

This was a consequence of the previous bug; the shadowing call would
raise a fault causing the calling task to die, but the cleanup code
could not run as expected, leaving a stale "MAIN" task entry in the
internal registry. This would in turn cause -EEXIST to be sent for any
attempt to create a "MAIN"-labeled task again. The patch mentioned above
should prevent this situation to occur.

> 
> I already read somewhere that the -14 and -17 error codes (negative
> values) indicate that there is a problem in the nucleus 
> Can somebody tell me what I do wrong? 

Nothing. The pSOS emulator code was wrong.

> 
> Best regards,
> Ronny
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.




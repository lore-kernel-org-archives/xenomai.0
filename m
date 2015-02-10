MIME-Version: 1.0
Date: Tue, 10 Feb 2015 16:00:30 +0000
Message-ID: <CAKJ14NfOzcES_Zk5do9TdhO8N_PayoqXJjg9P1hXaAS7BX0_+A@mail.gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] The latency test hang
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dauphin Alexandre <alexandre.dauphin@ecole.ensicaen.fr>
Cc: xenomai@xenomai.org

>>
>> Hello,
>>
>> My probleme is that i can't launch any latency tests , they always hang .
>> I work with a Imx6 quad core board ( arm architecture ) , my kernel
>> version is :
>>
>> # cat /proc/version
>> Linux version 3.0.43 (root@modx6sdk) (gcc version 4.7.1 20120402
>> (prerelease) (crosstool-NG linaro-1.13.1-2012.04-20120426 - Linaro GCC
>> 2012.04) )
>>
>> there , is the xenomai configuration i used :
>> # /usr/xenomai/bin/xeno-config
>> xeno-config --verbose
>> ??????? --version="2.6.4"
>> ??????? --cc="arm-linux-gnueabi-gcc"
>> ??????? --arch="arm"
>> ??????? --prefix="/usr/xenomai"
>> ??????? --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
>> -D__XENO__"
>> ??????? --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread -lrt "
>> ??????? --posix-cflags=""
>> ??????? --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers
>> -L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt "
>> ??????? --library-dir="/usr/xenomai/lib"
>>
>> Whene i run some latency test , it always hangs after "warming up..." and
>> nothing append then..
>>
>> # /usr/xenomai/bin/latency -p 1000
>> == Sampling period: 120000 us
>> == Test mode: periodic user-mode task
>> == All results in microseconds
>> warming up...
>
> This works on my imx6 quadcore board with the following output (see my
> configuration after the output)
>
[...]
> root@imx6q-pbab01:~/tmp# cat /proc/version
> Linux version 3.14.17-fslc+g6c6f90b (andreas@gorse) (gcc version 4.8.2
> (GCC) ) #3 SMP PREEMPT Wed Nov 26 13:05:24 GMT 2014
> root@imx6q-pbab01:~/tmp# cat /proc/xenomai/version
> 2.6.4
> root@imx6q-pbab01:~/tmp# cat /proc/ipipe/version
> 4
>
>
>>
>> I tried to change the periode ,but it doesn't make any changes.
>>
>> # /usr/xenomai/bin/latency -p 120000 -T 600
>> == Sampling period: 120000 us
>> == Test mode: periodic user-mode task
>> == All results in microseconds
>> warming up...
>>
>> ---|-----------|-----------|-----------|--------|------|-------------------------
>> RTS|? 25252.525|????? 0.000| -25252.526|?????? 0|???? 0|???
>> 00:10:00/00:10:00
>
> Works too on my board:
>
[...]
>
>
>
>>
>> In my configuration , CONFIG_CPU_FREQ? , CONFIG_CPU_IDLE and CONFIG_KGDB?
>> are disable ;
>>
>> I don't know what is wrong with my configuration and i thank you a lot for
>> your help.
>
> Does any other xenomai test run on your board?
>
> e.g. xeno-regression-test -t 0
>
>
>
> Whene I cross compiled and run on the board some programes with native API,
> it works.
>
> The latency and klatency test hangs forever ( i tried to wait a long time
> with period 1000us)
>
> the regression test gave me this :
>
> # ./xeno-regression-test -t 0
> Started child 1546: /bin/sh /usr/xenomai/bin/xeno-test-run-wrapper
> ./xeno-regression-test -t 0
> + echo 0
> + /usr/xenomai/bin/arith
> mul: 0x79364d93, shft: 26
> integ: 30, frac: 0x4d9364d9364d9364
>
[...]
> + /usr/xenomai/bin/clocktest -T 30
> == Tested clock: 0 (CLOCK_REALTIME)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0   -946684806505700.6            0.000          0            0.0
>   1   -946684806505700.2            0.000          0            0.0
>   2   -946684806505700.1            0.015          0            0.0
>   3   -946684806505700.2            0.011          0            0.0
> + /usr/xenomai/bin/cond-torture-native
> simple_condwait
>  ... and its stay blocked here.
>
> My ipipe version is old in comparison with yours Andreas , this may be a
> problem.
>
> # cat /proc/ipipe/version
> 1.18-13

Yes, it could be an incompatibility problem. Why not try 3.14.x
instead of 3.0.x? Originally I had an SDK based on the 3.0.x kernel
however it didn't have hard float support. That's why I went from
3.0.x directly to 3.14.x kernel using the newest stable xenomai. In my
case I had detailed instructions how to build the plain kernel without
xenomai [1] and full hardware support. The only thing left then was to
pull the corresponding changes from the ipipe.git, recompile the
kernel and cross-compile xenomai 2.6.4. If that's an option in your
case than I'd do this since I find the 3.14.x kernel series very
stable on ARM7.

Andreas

[1] http://phytec.com/wiki/index.php?title=PhyFLEX-i.MX6_Linux_Quickstart_PD14.1.0_EA2_Yocto#Building_the_BSP


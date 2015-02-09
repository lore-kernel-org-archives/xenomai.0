MIME-Version: 1.0
In-Reply-To: <mailman.3.1423479601.12448.xenomai@xenomai.org>
References: <mailman.3.1423479601.12448.xenomai@xenomai.org>
Date: Mon, 9 Feb 2015 11:51:46 +0000
Message-ID: <CAKJ14NfmnDYyO9suJeMj=w5sb2e7HDUV5mubWr3cJPv2O1RF+g@mail.gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Xenomai Digest, Vol 34, Issue 10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, alexandre.dauphin@ecole.ensicaen.fr, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

>
> Hello,
>
> My probleme is that i can't launch any latency tests , they always hang .
> I work with a Imx6 quad core board ( arm architecture ) , my kernel version is :
>
> # cat /proc/version
> Linux version 3.0.43 (root@modx6sdk) (gcc version 4.7.1 20120402 (prerelease) (crosstool-NG linaro-1.13.1-2012.04-20120426 - Linaro GCC 2012.04) )
>
> there , is the xenomai configuration i used :
> # /usr/xenomai/bin/xeno-config
> xeno-config --verbose
> ??????? --version="2.6.4"
> ??????? --cc="arm-linux-gnueabi-gcc"
> ??????? --arch="arm"
> ??????? --prefix="/usr/xenomai"
> ??????? --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__"
> ??????? --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread -lrt "
> ??????? --posix-cflags=""
> ??????? --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt "
> ??????? --library-dir="/usr/xenomai/lib"
>
> Whene i run some latency test , it always hangs after "warming up..." and nothing append then..
>
> # /usr/xenomai/bin/latency -p 1000
> == Sampling period: 120000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...

This works on my imx6 quadcore board with the following output (see my
configuration after the output)

root@imx6q-pbab01:~/tmp# /usr/local/bin/latency -p 1000
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     11.515|     30.878|     51.626|       0|     0|     11.515|     51.626

RTD|     10.065|     30.843|     52.919|       0|     0|     10.065|     52.919
RTD|     10.095|     30.540|     51.767|       0|     0|     10.065|     52.919
RTD|     20.101|     31.338|     56.363|       0|     0|     10.065|     56.363
RTD|     11.267|     31.070|     57.196|       0|     0|     10.065|     57.196
RTD|     11.368|     28.328|     48.202|       0|     0|     10.065|     57.196
RTD|     11.262|     24.580|     57.979|       0|     0|     10.065|     57.979
RTD|     11.621|     24.404|     44.404|       0|     0|     10.065|     57.979
RTD|     10.919|     24.787|     44.368|       0|     0|     10.065|     57.979
RTD|     11.297|     24.999|     49.681|       0|     0|     10.065|     57.979
RTD|     11.898|     24.661|     42.373|       0|     0|     10.065|     57.979
RTD|     11.878|     28.681|     50.040|       0|     0|     10.065|     57.979
RTD|     20.555|     30.797|     60.893|       0|     0|     10.065|     60.893
RTD|     21.474|     31.181|     58.646|       0|     0|     10.065|     60.893
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     10.065|     28.363|     60.893|       0|     0|    00:00:15/00:00:15
root@imx6q-pbab01:~/tmp# cat /proc/version
Linux version 3.14.17-fslc+g6c6f90b (andreas@gorse) (gcc version 4.8.2
(GCC) ) #3 SMP PREEMPT Wed Nov 26 13:05:24 GMT 2014
root@imx6q-pbab01:~/tmp# cat /proc/xenomai/version
2.6.4
root@imx6q-pbab01:~/tmp# cat /proc/ipipe/version
4


>
> I tried to change the periode ,but it doesn't make any changes.
>
> # /usr/xenomai/bin/latency -p 120000 -T 600
> == Sampling period: 120000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> ---|-----------|-----------|-----------|--------|------|-------------------------
> RTS|? 25252.525|????? 0.000| -25252.526|?????? 0|???? 0|??? 00:10:00/00:10:00

Works too on my board:

root@imx6q-pbab01:~/tmp#  /usr/xenomai/bin/latency -p 120000 -T 600
-sh: /usr/xenomai/bin/latency: No such file or directory
root@imx6q-pbab01:~/tmp# /usr/local/bin/latency -p 120000 -T 600
== Sampling period: 120000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 120000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     43.005|     48.494|     54.626|       0|     0|     43.005|     54.626
RTD|     41.348|     49.893|     63.641|       0|     0|     41.348|     63.641
RTD|     40.863|     49.121|     59.176|       0|     0|     40.863|     63.641
RTD|     40.843|     45.722|     55.141|       0|     0|     40.843|     63.641
RTD|     42.929|     51.747|     64.328|       0|     0|     40.843|     64.328
RTD|     43.616|     49.873|     58.813|       0|     0|     40.843|     64.328
RTD|     40.050|     52.313|     61.272|       0|     0|     40.050|     64.328
RTD|     39.792|     48.010|     61.909|       0|     0|     39.792|     64.328
RTD|     45.717|     57.247|     66.479|       0|     0|     39.792|     66.479
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|     39.792|     50.267|     66.479|       0|     0|    00:00:09/00:10:00
root@imx6q-pbab01:~/tmp#



>
> In my configuration , CONFIG_CPU_FREQ? , CONFIG_CPU_IDLE and CONFIG_KGDB? are disable ;
>
> I don't know what is wrong with my configuration and i thank you a lot for your help.

Does any other xenomai test run on your board?

e.g. xeno-regression-test -t 0


Andreas


>
> Thanks you,
> Alex


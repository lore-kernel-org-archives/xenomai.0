Message-ID: <4DD23F8A.5000107@domain.hid>
Date: Tue, 17 May 2011 11:27:38 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>	<4DCD2EE8.2010904@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B910B@ontex.i.omicron.de>	<4DD102DA.9080206@domain.hid>
	<4DD107AD.5000307@domain.hid>
	<89B30389DB4AE240AC1227F3FDBB7CCF029B910F@ontex.i.omicron.de>
	<4DD13882.8000708@domain.hid>
	<89B30389DB4AE240AC1227F3FDBB7CCF029B9110@domain.hid>
	<4DD22053.5030502@domain.hid>
	<89B30389DB4AE240AC1227F3FDBB7CCF029B9111@domain.hid>
In-Reply-To: <89B30389DB4AE240AC1227F3FDBB7CCF029B9111@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] build xenomai userspace app, illegal instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Koenig, Florian" <F.Koenig@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 05/17/2011 09:53 AM, Koenig, Florian wrote:
> Hi,
> 
> Do you have CONFIG_XENO_HW_FPU disabled? If not, please disable and
> retry. Illegal instructions are maybe due to hard-float instructions in
> the binary. I will check on our Walnut board when time permits...
> hopefully today.

Nobody will understand that the above paragraph was written by myself
without proper quoting!
 
> I set CONFIG_XENO_HW_FPU to 
> # CONFIG_XENO_HW_FPU is not set

Well, that should not be done manually and it could not be set via
"menuconfig", I just realized. It's not the problem anyway, I believe.

> I rebuild the xenomai userspace stuff (make clean;./configure
> --host=powerpc-linux;make;make install), but the same (illegal instruction),
> when i run it on powerpc cpu.

I just tried latency on my Walnut board and it works fine:

-bash-3.2# cat /proc/cpuinfo 
processor	: 0
cpu		: 405GP
clock		: 200.000000MHz
revision	: 1.69 (pvr 4011 0145)
bogomips	: 400.00
timebase	: 200000000
platform	: Walnut
model		: ibm,walnut
Memory		: 32 MB

-bash-3.2# cd /home/wolf/bin/
-bash-3.2# ./latency 
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|     10.840|     11.570|     35.235|       0|     0|     10.840|     35.235
RTD|      9.710|     10.675|     37.205|       0|     0|      9.710|     37.205
RTD|      9.710|     10.465|     35.995|       0|     0|      9.710|     37.205
RTD|      9.710|     10.475|     43.635|       0|     0|      9.710|     43.635
RTD|      9.710|     13.885|     45.525|       0|     0|      9.710|     45.525
RTD|      9.710|     11.605|     37.505|       0|     0|      9.710|     45.525
^C---|-----------|-----------|-----------|--------|------|-------------------------
RTS|      9.710|     11.445|     45.525|       0|     0|    00:00:07/00:00:07

And also the example trivial-periodic works:

-bash-3.2# export LD_LIBRARY_PATH=/home/wolf/lib
-bash-3.2# ./trivial-periodic
Time since last turn: 1000.009340 ms
Time since last turn: 1000.008920 ms
Time since last turn: 1000.001100 ms
Time since last turn: 999.989450 ms


> All other "normal" apps are running, only when i link to xenomai userspace
> libs i get illegal instructions. On linux side i dont need
> CONFIG_MATH_EMULATION enabled, because i want to use soft-float, that is
> correct, or?

I'm really puzzled what you are doing. It makes sense that you show us
your build commands step by step.

Wolfgang.


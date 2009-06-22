In-Reply-To: <4A3CE75D.1050005@domain.hid>
References: <1245495740.3498.8.camel@domain.hid>	
	<4A3CE75D.1050005@domain.hid>
Mime-Version: 1.0
Date: Mon, 22 Jun 2009 16:54:05 +0530
Message-ID: <1245669845.7250.8.camel@domain.hid>
From: Shashank Bhatia <shashank.bhatia@domain.hid>
content-type: text/plain
content-transfer-encoding: 7bit
Subject: Re: [Xenomai-core] Regarding enabling SMP with Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai Help <xenomai@xenomai.org>

Thanks a lot Gilles,

I used the Xenomai 2.4.8 version with a newer kernel 2.6.28.9 to be
precise.

Initially the kernel compilation gave error of NR_CPU flag, i lowered
the no of CPUs to 16 and it worked.

Now the xenomai is able to see two CPUs, the output
of /proc/xenomai/sched is :
CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
  0  0       -1      0          0          master    R          ROOT/0
  1  0       -1      0          0          master    R          ROOT/1



The output of dmesg |grep is
[    4.353912] I-pipe: Domain Xenomai registered.
[    4.353949] Xenomai: hal/i386 started.
[    4.354530] Xenomai: real-time nucleus v2.4.8 (Lords Of Karma)
loaded.
[    4.354612] Xenomai: SMI-enabled chipset found
[    4.354623] Xenomai: SMI workaround enabled
[    4.354647] Xenomai: starting native API services.
[    4.354650] Xenomai: starting POSIX services.
[    4.354693] Xenomai: starting RTDM services.



Thanks for your help..

Now i am facing just a small issue, i think the pipes for klatency tests
are not created, thats why when i run the klatency test, i get the error
as:
root@domain.hid# ./run 
*
*
* Type ^C to stop this application.
*
*
open(/proc/xenomai/registry/native/pipes/klat_pipe): No such file or
directory
modprobe klat_mod or try the -P option?


Please tell me if i am doing something wrong.


Thanks again!


Regards,
Shashank





On Sat, 2009-06-20 at 15:42 +0200, Gilles Chanteperdrix wrote:
> Gilles


-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India






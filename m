Message-ID: <34174.131.173.32.74.1184072898.squirrel@domain.hid>
Date: Tue, 10 Jul 2007 15:08:18 +0200 (CEST)
From: bboese@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Subject: [Xenomai-help] SMI workaround failed
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello.

I'm very new to Xenomai and Real Time Applications, so please be indulgent.

I'm using Ubuntu 7.4 on a Pentium IV 3,2 GHz system with 512mb ram. After
2 days of learning about kernel compiling, I've managed to compile a
vanilla 2.6.20 kernel with the Xenomai nucleus.

At first, I've checked if Adeos is working:
dmesg | grep I-pipe
I-pipe 1.7-03: pipeline enabled.
I-pipe: Domain Xenomai registered.

Then I've checked if Xenomai works properly:
dmesg | grep Xenomai
I-pipe: Domain Xenomai registered.
Xenomai: hal/x86 started.
Xenomai: real-time nucleus v2.3.1 (One Robot's Dream) loaded.
Xenomai: SMI-enabled chipset found, enabling SMI workaround.
Xenomai: SMI workaround failed!
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.

And here's a snippet of my .config file for the kernel:
#
# SMI workaround
#
# CONFIG_XENO_HW_SMI_DETECT_DISABLE is not set
CONFIG_XENO_HW_SMI_DETECT=y
CONFIG_XENO_HW_SMI_WORKAROUND=y
CONFIG_XENO_HW_SMI_ALL=y

As you can see, I've enabled the workaround. But somehow, it fails.

I've tried /usr/xenomai/bin/xeno-test, and my latencies are very high.
Maximum latency circles around 10ms, and average latency is about 0.5 ms.
I don't think this is normal, I was hoping for much lower latencies for my
realtime applications. I think SMI skyrockets the latency values, any idea
why the SMI workaround won't work or how to debug this problem properly ?

Which latency should I expect with a system like mine (PIV 3,2 GHz) ?


Kind regards,
Bastian Boese




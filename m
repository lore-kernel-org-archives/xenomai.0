MIME-Version: 1.0
Date: Tue, 24 May 2016 20:46:54 +0300
Message-ID: <CAJ2oMhKbZsPqppakvnKFGi3QnniTCiTJDE3mSsYc-YRSSdV9Jg@mail.gmail.com>
From: Ran Shalit <ranshalit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Failure with rtdm_dev_register in rtdmtest
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am trying to do initial testing of xenomai in my system.
It seems that the boot of kernel with xenomai is without any issues

zynq> dmesg | grep Xenomai
I-pipe: head domain Xenomai registered.
Xenomai: hal/arm started.
Xenomai: scheduling class idle registered.
Xenomai: scheduling class rt registered.
Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.
Xenomai: debug mode enabled.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
zynq> uname -a
Linux 192.168.1.8 3.8.0-xilinx #17 SMP PREEMPT Tue May 24 19:05:08 IDT
2016 armv7l GNU/Linux

But on trying to load rtdmtest, I get no /dev/rtdm :

zynq> insmod xeno_rtdmtest.ko
zynq> lsmod
xeno_rtdmtest 2239 0 - Live 0xbf000000
zynq>

zynq> ls /dev/rt
rtheap  rtp11   rtp15   rtp19   rtp22   rtp26   rtp3    rtp5    rtp9
rtp0    rtp12   rtp16   rtp2    rtp23   rtp27   rtp30   rtp6
rtp1    rtp13   rtp17   rtp20   rtp24   rtp28   rtp31   rtp7
rtp10   rtp14   rtp18   rtp21   rtp25   rtp29   rtp4    rtp8


I tried to debug and it seems that err =
rtdm_dev_register(&device[dev]) has failed.

Is there any idea what might be wrong ?

Regards,
Ran


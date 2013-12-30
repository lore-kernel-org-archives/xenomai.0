From: "Andreas Gareis" <andreas.gareis@hs-augsburg.de>
Date: Mon, 30 Dec 2013 17:00:03 +0100
Message-ID: <000201cf0578$33b94cf0$9b2be6d0$@hs-augsburg.de>
MIME-Version: 1.0
Content-Language: de
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm can on mpc5121e - no rtcan devices detected
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

> Von: Wolfgang Grandegger 

> 

> On Mon, 9 Dec 2013 20:35:12 +0100, "Andreas Gareis"

> < <mailto:andreas.gareis@hs-augsburg.de> andreas.gareis@hs-augsburg.de>
wrote:

> > Von: Wolfgang Grandegger

> >  Gesendet: Montag, 9. Dezember 2013 20:10

> >>

> >> On Mon, 9 Dec 2013 19:17:47 +0100, "Andreas Gareis"

> >> < <mailto:andreas.gareis@hs-augsburg.de> andreas.gareis@hs-augsburg.de>
wrote:

> >> > Von: Tom Evans

> >> >  Gesendet: Sonntag, 8. Dezember 2013 23:07

> >> >>

> >> >> Did the CAN devices work before you installed Xenomai? Get them

> >> >> working there first.

> >> >>

> >> >

> >> > Yes, the CAN devices worked before Xenomai installation. They were

> >> > shown in ifconfig and communication with other CAN-devices was

> >> > possible.

> >> >

> >> > When I select normal (non rt) CAN-support and xenomai kernel

> >> > (without

> >> > RT-CAN) in the kernelconfig, working CAN devices are also available.

> >> >

> >> > Now I want to use RT-CAN with xenomai. So, I activated

> "RT-Socket-CAN"

> >> > and "MSCAN driver for MPC52xx and MPC512x" in the kernelconfig.

> >> > When "normal" CAN support (Networking support => CAN bus

> subsystem

> >> > support => CAN Device Drivers Freescale MPC5xxx onboard CAN

> >> > controller) is disabled, the xenomai module "xeno_can_mscan.ko"

> >> > isn't able to start. When "normal" CAN support

> >>

> >> That's the real problem. What happen's if you want to start the CAN

> >> device?

> >

> > First I call "insmod xeno_can.ko". dmesg shows:

> >     RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team

> >

> > Then I call "insmod xeno_can_mscan.ko".

> > This operation gets stuck (the insmod doesn't return).

> > In dmesg there are no messages.

> > lsmod shows that xeno_can is running and xeno_can_mscan is still

> loading.

> 

> Add some pr_info/printk to the drivers probe function to see where it
hangs.

> 

> Wolfgang.

> 

 Sorry for my late answer. I've found the problem: I was using xenomai
2.6.0-rc5. In the function rtcan_mscan_mode_stop() in rtcan_mscan.c there is
a while() which is never terminated. So I used the code from current xenomai
version as there is a counter within the while(). The rtcan devices can be
used now.

 

Thank you for your help!

 

Andreas

 


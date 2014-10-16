Date: Thu, 16 Oct 2014 19:43:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141016174309.GD30661@sisyphus.hd.free.fr>
References: <1413464642.48297.YahooMailNeo@web141701.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1413464642.48297.YahooMailNeo@web141701.mail.bf1.yahoo.com>
Subject: Re: [Xenomai] RTDM problem with Advantech PCM-3680I
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?Q?R=C3=B3bert?= Marc <rob_marc2003@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, Oct 16, 2014 at 06:04:02AM -0700, Róbert Marc wrote:
> Dear Xenomai community,

Hi,

> 
> I am experiencing problems with my Advantech card under Xenomai.
> Please note that the card (Advantech PCM-3680I) functions
> perfectly under non-RT Linux (Ubuntu 12.04). I can send and
> receive messages.  Although the modules are loaded the devices
> can't be seen. See details below.
> 
> 
> Here are some technical details:
> 
> rtos@rtos-pc-104:~$ sudo rtcanconfig rtcan0 -b 1000000 -v start
> mode: start (0x1)
> Can't get interface index for rtcan0, code = -19
> 
> 
> >>  what is error code -19?

http://xenomai.org/2014/06/resolving-error-codes/

> 
> 
> rtos@rtos-pc-104:~$ lsmod | grep adv
> xeno_can_adv_pci       12730  0 
> advcan                             707511  4 
> xeno_can_sja1000       17366  1 xeno_can_adv_pci
> xeno_can                         28373  2 xeno_can_adv_pci,xeno_can_sja1000
> 
> 
> >> drivers are loaded 
> 
> 
> rtos@rtos-pc-104:~$ dmesg | grep CAN
> [    4.341607] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
> [    4.372061] RTCAN SJA1000 driver initialized
> [    4.405671] ADV-PCI-CAN 0000:01:04.0: RTCAN Registering card
> [    4.405697] ADV-PCI-CAN 0000:01:04.0: RTCAN detected Advantech PCI card at slot #4
> [    4.405712] ADV-PCI-CAN: Initializing device 13fe:c002:c002
> [    4.405731] ADV-PCI-CAN: base_addr=0001ef00 conf_addr=  (null) irq=16 ocr=0xfa cdr=0xc0
> [    4.405811] RTCAN: unregistered rtcan0
> [    4.405836] ADV-PCI-CAN: probe of 0000:01:04.0 failed with error -5
> [    4.494279] CAN Communication Driver.
> [    4.514136] Advantech CAN Port CAN Driver (c) Oct  3 2014 15:12:52
> [    4.514202] Advanteh PCI CAN devie c002 found( 2 CAN port)
> 
> 
> >> conf_addr=  (null) might be the problem???

Well from these traces, the rtcan0 device is registered, then
unregistered, no need to go further, rtcanconfig will not be able to
find it, this explains the ENODEV.

conf_addr set to null should not be the problem, as the driver code
sets it to NULL, then never uses it. See:
http://git.xenomai.org/xenomai-2.6.git/tree/ksrc/drivers/can/sja1000/rtcan_adv_pci.c

Maybe the full traces contain the reason for unregistering rtcan0?

-- 
					    Gilles.


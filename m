Message-ID: <1352035873.59875.YahooMailClassic@web161204.mail.bf1.yahoo.com>
Date: Sun, 4 Nov 2012 05:31:13 -0800 (PST)
From: thoga@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Xenomai] xeno_mod_isa for a 2 channel can-device with the same
	shared interrupt for both devices
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, wg@grandegger.com

Hi all,

I'm using XENOMAI 2.6.0 on a SYSLOGIC ML/COMPACT6 industrial pc, which has 2 ISA-CAN-bus controllers onbard. 

Both controllers share the same irq=11 while they have different i/o-port regions, the first uses io=0x7600 while the second uses io=0x7700.

When I load the xeno_can_isa module to use only one controller 

    modprobe xeno_can_isa io=0x7600 irq=11

everything works fine and realtime can-communication is possible. But when I want to initialize both can controllers by issuing

    modprobe xeno_can_isa io=0x7600,0x7700 irq=11,11

it says

FATAL: Error inserting xeno_can_isa (/lib/modules/2.6.38.8/kernel/drivers/xenomai/can/sja1000/xeno_can_isa.ko): Device or resource busy

On the other hand the command issued with two different irq (11 and 12)

    modprobe xeno_can_isa io=0x7600,0x7700 irq=11,12

works and the module loads successfully (but the second channel cannot be used due to wrong irq, of course).

Now, my question is: What does the message "Device or resource busy" mean? Does it refere to the irq=11 which is already in use for the first controller and is not available anymore for the second one?

Does anybody have experience in using the xeno_can_isa module with two controllers sharing the same irq ?

Best regards
Thomas









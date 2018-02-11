MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 10 Feb 2018 20:57:25 -0500
Message-ID: <CALLqZ8RC+5r7QhOf6EW5p_KGLpd-9+b7j511j19JgR90iopw_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] bcm2835 ipipe question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I'm getting the raspberry pi zero images ready and I see the following
in the dmesg:

[    0.000000] WARNING: CPU: 0 PID: 0 at
/home/ggallagher/devel/emb_linux/ipipe-arm/kernel/irq/chip.c:57
irq_set_chip+0x7c/0xac
[    0.000000] irqchip ARMCTRL-level is not pipeline-safe!
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.14.4-ipipe+ #2
[    0.000000] Hardware name: BCM2835
[    0.000000] I-pipe domain: Linux

it looks like cobalt isn't running either, I'm trying to find the best
way to debug this or if this is a bug?

Any help is appreciated

Greg


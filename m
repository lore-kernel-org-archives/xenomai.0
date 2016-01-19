MIME-Version: 1.0
Date: Tue, 19 Jan 2016 16:00:17 +0100
Message-ID: <CACBbF4VV6EwNub2A2R3t-xhUc5X=F9kY9MU=+f3Y3eAsHVDwuA@mail.gmail.com>
From: "LOYAU, Florian" <florian.loyau@edu.esiee.fr>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] rtskbs gone missing in 3.0.x stable versions,
	breaking most of RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

We've been attempting to run RTnet/Xenomai 3 for a school project
Our targets are 3.18.20 on a generic amd64,
and a patched 3.14.54 kernel on an I.MX6Q-SABRESD board (ARMv7HF)

We first attempted to run the i.MX6 with Xenomai 3.0-RC7 as that was the
latest available at the time.
However, i noticed options to build the ARM RT FEC driver had been dropped
from drivers' Kconfig, and attempted to re-enable it. This required minor
changes to two function calls whose signatures had been modified.

This was met with mixed success:
While on the one hand, the card did work with the built rt_fec module,
after about ~200 packets sent the driver runs out of rtskbs and outputs
"Memory squeeze: dropping packet" messages.

We proceeded to build the newer 3.0.1 Xenomai release onto the amd64
machine, this time without any modification, either on Xenomai or Linux
side,
and again have been met with strange results:

 * loopback and e1000 drivers do not work at all,
   throwing an EAGAIN when attempting to send packets.
   after a bit of printk'ing around, we determined this was due, again,
   to rtskb starvation in the device pool for some reason.

 * rt_e1000e works as expected, and we could test this, both with the
   i.MX6 running RC7, and looping back on the second port of our card.

Thinking we just broke the first one,
and had plain bad luck on the second one,
we pulled 3.0.x-stable branch and rebuilt it for the i.MX6.

The results were coherent with 3.0.1 :
 FEC doesn't work at all either, returning EAGAIN
 on packet sending due to rtskb starvation.
 We haven't tested yet with rt_igb and rt_e1000...

We're majorly confused regarding the state of the support of the different
drivers at present, and what looks like compat-breaking changes between
RTnet 1.7, Xenomai 3 RC, and Xenomai 3 stable. Can you provide us with
some information on the state of support and pointers on what can be done
to fix these problems ?

Thanks in advance,

Florian Loyau,
ESIEE Paris, E5FR Network & Communications branch

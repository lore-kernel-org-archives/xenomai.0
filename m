From: Lowell Gilbert <kludge@be-well.ilk.org>
Date: Mon, 07 Nov 2016 16:08:57 -0500
Message-ID: <44eg2nuhee.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Xenomai] irqchip missing?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi.

I have a system based on a Cortex A9. When I was running under Xenomai
2.6, I was able to grab interrupts in RTDM. A few months ago, I updated
from a 3.16 Linux kernel and 2.6.4 Xenomai to a 4.1 kernel with 3.0.2
Xenomai. I'm trying to grab the same IRQ now, and the irqchip doesn't
seem to have a set_affinity callback, so I get a kernel dump.

Where should I be checking for what changed? I can't find any relevant
changes in the device tree or in the init code that processes it.

Thanks for any guidance I can get.

Be well.


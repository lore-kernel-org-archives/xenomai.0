MIME-Version: 1.0
Date: Sat, 25 Aug 2012 15:19:36 +0430
Message-ID: <CAKKWdtdG5L24kjZ_WkWhLDL2iL2inCHP_5RE9JPgudEwkWuSuQ@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] The functionality of rthal_irq_enable()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

If i use rthal_irq_enable() inside a real time interrupt handler for
an IRQ. What happens if i receive the same IRQ and interrupt after
rthal_irq_enable()?
As far as life-with-adeos-rev-B.pdf is saying,  rthal_irq_enable()
does two things:
1) it enables IRQ in hardware
2) it unstalls the domain pipeline stage
And when the domain stage is unstalled, if the interrupt is received
the handler of that interrupt is called. So we have nested interrupt
handling here. Is that right?


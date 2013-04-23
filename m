Message-ID: <517652E1.3090104@thrane.com>
Date: Tue, 23 Apr 2013 11:22:41 +0200
From: Jesper Christensen <jbc@thrane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Lost interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi guys

I have a quick question regarding rtdm synchronisation. Is it possible
to "loose" an interrupt if it is generated while i am inside a critical
section protected by a rtdm_lock_get_irqsave/rtdm_lock_put_irqrestore?

I have a problem with an ethernet driver where the Tx Queue fills up and
i suspect that its because the Tx ISR isn't being executed for the above
mentioned reason.

/Jesper


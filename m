MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18187.56542.319792.74121@domain.hid>
Date: Tue, 9 Oct 2007 21:56:14 +0200
In-Reply-To: <470BC537.8010200@domain.hid>
References: <305035a40710091019n77e1a453gd0d349dc1eebc15d@domain.hid>
	<470BC537.8010200@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] RTAI and Xenomai latency in kernel
	mode	on	AT91SAM9261-EK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gregory CLEMENT wrote:
 > > Here, they are the last latency we get on AT91SAM9261-EK. As just now
 > > I haven't the board at home, I send the last result we stored. The
 > > prority of dbgu should be set to 6 instead of 7, but I can't assure
 > > it, for Xenomai.
 > 
 > Hmm, hardware interrupt priorities must not impact the worst-case
 > latency if I-pipe acks and mask them appropriately (the worst case is
 > when multiple interrupts happen in a row, not at the same time). But
 > this statement is not based on knowledge about potential pitfalls of
 > this arch. Are there specialities that require this tweaking?

During the port to AT91RM9200, I observed that under ping flood, the
ethernet driver interrupt was delaying the timer interrupt for unbounded
period of times, this because it had a higher priority. Changing the
interrupt priorities solved the issue. That said, I understand what you
mean, the interrupt should be masked when acked and should no longer
bother us until the I-pipe gives control to Linux to handle it.


 > 
 > > first Xenomai:
 > > 
 > > #insmod /lib/modules/2.6.20.13/kernel/drivers/xenomai/testing/xeno_timerbench.ko
 > > #cd /usr/xenomai/bin/
 > 
 > Which versions were you using for both tests? Do you still have the
 > involved .configs?
 > 
 > > #./latency -t 2 -p 150 -h -H 500

Why not -p 500 ? Since RTAI was tested with a 500 us period, the same
period should be use for Xenomai. I do not think this will change
anything, but who knows.

-- 


					    Gilles Chanteperdrix.


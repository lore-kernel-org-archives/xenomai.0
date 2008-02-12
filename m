From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18353.20580.55980.279684@domain.hid>
Date: Tue, 12 Feb 2008 08:53:08 +0100
In-Reply-To: <18353.17667.156910.185055@domain.hid>
References: <20080123065221.GB6573@domain.hid>
	<2ff1a98a0801230204s15e4eefaifdd2c946c44549df@domain.hid>
	<2ff1a98a0801230515i77f8c22bk866c4cd592a3a9b8@domain.hid>
	<20080124094150.GA7503@domain.hid>
	<18351.24380.551907.397687@domain.hid>
	<47B050A4.4060409@domain.hid>
	<18353.17667.156910.185055@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] AT91SAM9260 latency
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Juan Antonio Garcia Redondo <juan-antonio.garcia@domain.hid>, jagarcia@domain.hid, xenomai@xenomai.org

Gilles Chanteperdrix wrote:
 > 
 > And another here, whereas if I understand correctly, the mm did not
 > change. So, this is probably an unwanted effect of the cache flush
 > "optimization" in the arm patch.
 > 
 > I will now try to understand if this second cache flush is really normal.

Yes, it is normal: the first context switch, which xnshadow_relax does,
is a switch to whatever task Linux was running when preempted, not
necessarily latency (and it turns out to never be latency when we
capture the worst case) hence the first cache flush. We then re-interrupt
Linux after this context switch, and switch again to latency, and we get
a second cache flush.

So, the conclusion is: everything is normal. What we obtain when
pressing the enter key while latency is running in the background is a
wakeup of the shell process and this process uses cache, so that the
next latency context switches need to flush cache.

In other words: pressing the enter key yields the same latency as
running the cache calibrator because it has the same effect, it fills
the cache.

-- 


					    Gilles Chanteperdrix.


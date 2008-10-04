Message-ID: <48E778B3.8040004@domain.hid>
Date: Sat, 04 Oct 2008 16:07:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48E76494.9030901@domain.hid>
In-Reply-To: <48E76494.9030901@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] gdb lockup on multi-threaded process exit
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> I'm banging my head against this issue for several days now, first
> trying to sort out an unrelated bug I also came across at this chance,
> then trying to understand what happens, and finally getting mad about
> why this may only happen with Xenomai:

I have not tried to understand your problem (yet). But do you happen to
work with the latest TASK_ATOMICSWITCH changes? If yes, could you try to
revert them?

-- 
					    Gilles.


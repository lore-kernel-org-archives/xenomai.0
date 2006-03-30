Message-Id: <1143692865.28416.257881265@domain.hid>
From: "Saul" <xeno@domain.hid>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
References: <1143612388.32703.257789950@domain.hid>      
	<442A6F5C.50602@domain.hid>
Subject: Re: [Xenomai-help] Non-deterministic behaviour in primary mode
In-Reply-To: <442A6F5C.50602@domain.hid>
Date: Thu, 30 Mar 2006 15:27:45 +1100
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka said:
> No obvious problem with your program. Does the latency test of
> Xenomai show any significant times? Maybe the SMI workaround does not
> catch all issues on your system (though up to 60 ms jitter is still
> quite a lot).

This is after a few minutes with dd running to disk simultaneously from
/dev/zero and /dev/urandom:

RTD| 0.609| 7.218| 25.352|   0|  0.063| 53.592

This is the highest latency I've seen on this PC, except when I run
another task on the same priority :) This latency is in microseconds,
while the extra delays I'm seeing during processing are in ms, often
taking double or triple the expected execution time.

Curiously the worst case latency often shows up during low-load
conditions.

The SMI workaround is set to globally disable SMI. I haven't tried with
SMI enabled since disabling it has had no noticeable effects - USB
works, firewire works, etc.

Actually, I just noticed that starting video capture using xawtv and the
bttv driver causes an overrun in the latency test, then the worst sits
on 100+ us until the test is restarted. This may be a different issue.

Saul.


Message-ID: <494D1ED5.2090300@domain.hid>
Date: Sat, 20 Dec 2008 17:35:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081219084446.8148.89319.stgit@domain.hid>
In-Reply-To: <20081219084446.8148.89319.stgit@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH  0/3] NMI watchdog fixes / enhancements
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
> This is basically a repost of the NNI watchdog series I sent out a few
> weeks ago. I just rebased things over latest trunk and fixed some
> warnings.
> 
> All patches are also available at
> git://git.kiszka.org/xenomai.git nmi-wd-queue

That is a lot of stuff to review. I am afraid it is impossible to review
everything, so the only thing we can rely on is testing, hence the next
question: have these patches been tested in every configuration
(enabled, disabled, built-in, module, voluntary overrun)?

As for the 32nd bit issue, I am afraid it can not explain the spurious
shots observed on some platfomrs (note that I implemented the early shot
thing a bit in the dark: I never observed the spurious shots myself),
that is because the nmi timer is programmed for durations between 100us
and 10ms, which should be far from using the 32nd bit.

-- 
					    Gilles.


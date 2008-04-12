MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18432.56533.343662.272421@domain.hid>
Date: Sat, 12 Apr 2008 18:01:25 +0200
In-Reply-To: <50879.62.235.129.158.1208014366.squirrel@domain.hid>
References: <Pine.LNX.4.64.0804111759280.5433@domain.hid>
	<4800B4FA.1050309@domain.hid>
	<50879.62.235.129.158.1208014366.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] rt_task_sleep_until question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: klaas.gadeyne@domain.hid
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

klaas.gadeyne@domain.hid wrote:
 > > Klaas Gadeyne wrote:
 > >> I've noticed that threads which, in my ignorant opinion, are supposed
 > >> to be sleeping, get woken up much earlier than I expect them to be.
 > >>
 > >> Please find attached a modified version of the trivial-periodic.c
 > >> application, which creates a RT_TASK that should sleep as long as
 > >> possible (i.e. until unblocked by a signal handler).  However, the
 > >> task gets woken up much earlier (and many times) _before_ that time it
 > >> seems.
 > >>
 > >>  head /tmp/app.txt
 > >> current_time = 1207928393295939429
 > >> sleep until 18446744073709551615
 > >> [TIMERLOOP] Total errors = 1, return code = -110
 > >> current_time = 1207928393296000379
 > >> sleep until 18446744073709551615
 > >> [TIMERLOOP] Total errors = 2, return code = -110
 > >> current_time = 1207928393296005409
 > >> sleep until 18446744073709551615
 > >> [TIMERLOOP] Total errors = 3, return code = -110
 > >> current_time = 1207928393296009604
 > >>
 > >> What did I overlook here?
 > >
 > > Probably an overflow issue: (RTIME)~0 will be converted to TSCs, and if
 > > your box runs at > 1GHZ, the result of this conversion will by something
 > > < (RTIME)~0 due to the overflow. And this can result in an absolute
 > > timeout date (in TSC units) before the current date -> ETIMEDOUT. Can
 > > you confirm this?
 > 
 > I have no linux box at hand, but I noticed that [*]
 > xntimer_do_start_aperiodic() passes its xnticks_t interval argument (which
 > is an unsigned long long) to xnarch_ns_to_tsc, and that one expects a
 > (signed) long long.
 > 
 > If I did not make any calculation errors (a very small chance...) in "my"
 > case "interval" > LLONG_MAX so there's already an overflow there.

The problem is that we can not change xnarch_ns_to_tsc to use
xnarch_ullimd instead of xnarch_llimd: xnarch_ns_to_tsc may be used to
convert negative differences. Anyway, I do not think there is an
overflow in llimd, otherwise you would get a processor exception, not a
silent truncation (at least on x86). To solve this issue, we should
probably switch to saturation arithmetic, but it would probably have a
huge impact on performance (and on code also, since we would have to use
xnarch_saturated_add(foo, bar) instead of foo + bar).

-- 


					    Gilles.


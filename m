Message-ID: <464984B6.8000207@domain.hid>
Date: Tue, 15 May 2007 12:00:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202BF@FR0-MAILMB20.res.airbus.corp>
	<464982CD.8010609@domain.hid>
In-Reply-To: <464982CD.8010609@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [RTnet-users] Time scale problem.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, "RAKOTOSALAMA,
	Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>, rtnet-users@domain.hid

Jan Kiszka wrote:
>>rt_timer_ticks2ns(rt_timer_tsc())
> 
> 
> Are you sure that ticks == tsc? RTFM :->

No, there was a change some (long) time ago, one should use
rt_timer_tsc2ns for converting tsc, not rt_timer_ticks2ns.

-- 
                                                 Gilles Chanteperdrix


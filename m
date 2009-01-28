Message-ID: <49808679.8050309@domain.hid>
Date: Wed, 28 Jan 2009 16:23:21 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <498085C2.7090604@domain.hid>
In-Reply-To: <498085C2.7090604@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] trunk: xnsched_set_policy seems to set only cprio
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
> unfortunately I'm forced to switch to other bugs, but I found out a bit
> more about the issue that pthread_getschedparam doesn't return the
> correct policy&prio under trunk - at least when called from threads
> created via pthread_create as SCHED_FIFO:
> 
> Such threads start with SCHED_OTHER, but then the propagation via
> do_setsched_event and finally xnsched_set_policy only seems to affect
> thread.cprio, not bprio. Will see if I can continue debugging this
> later, but maybe /someone/ already knows what goes wrong...

Yes, pthread_getschedparam returns the priority in the glibc cache. And
this one may not be in sync with the priority known by the kernel(s).
However, this is supposed to be fixed by calling
__real_pthread_setschedparam in various key places.

-- 
                                                 Gilles.


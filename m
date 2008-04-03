Message-ID: <2ff1a98a0804030204m598488e8n51235caec147e942@domain.hid>
Date: Thu, 3 Apr 2008 11:04:29 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F41AD3.2020809@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47ED5DE3.60202@domain.hid> <47F2A7CC.4050301@domain.hid>
	<2ff1a98a0804020142r55bab884x8896c8191f8580d5@domain.hid>
	<47F3A00E.1020700@domain.hid>
	<2ff1a98a0804020807t4d2cc718x493ae3c48e9a042f@domain.hid>
	<47F3E0B3.2030805@domain.hid>
	<18419.57862.758026.458669@domain.hid>
	<47F3FE7E.6020302@domain.hid>
	<18420.2520.32895.319766@domain.hid>
	<47F41AD3.2020809@domain.hid>
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, Apr 3, 2008 at 1:46 AM, Tomas Kalibera <kalibera@domain.hid> wrote:
> Gilles Chanteperdrix wrote:
>
> > Of course, we are looking for all bugs. But please tell me: do you get
> > the lock-up even before fork is called ? If not, could you verify that
> > at least some Xenomai programs run correctly, for instance latency ?
> >
> >
>  The lock up with patch 5 happens before fork is called, but after a
> real-time task is started by the program. I don't know better now - I'd have
> to add more logging.  If I run in strace, the lock-up does not happen.
>
>  Thinking about that, it can be a bug in my program. If I understand the
> concept of Xenomai correctly, I can just write a real-time task that would
> starve the Linux kernel indefinitely, correct ? My program definitely does
> have bugs. So I'll do more debugging.

Yes, you can starve Linux, but after 4seconds the Xenomai watchdog
should trigger. You can also starve Linux with a vanilla Linux
application running with the SCHED_FIFO scheduling policy, but in this
case, it is Linux soft lockup detector which should trigger. I see
that you have the two options enabled, so, the lockup is probably
another bug.

-- 
 Gilles


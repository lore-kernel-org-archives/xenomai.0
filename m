Message-ID: <4656E887.7040406@domain.hid>
Date: Fri, 25 May 2007 15:45:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4656E62F.3090603@domain.hid>
In-Reply-To: <4656E62F.3090603@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [BUG] recursive fault on cyclictest termination
 --	scalable sched?
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
> People, we have some new troubles:
> 
> I'm reproducibly getting recursive faults on termination of cyclictest
> via ^C. It's all standard here: ipipe 1.8-02, Xenomai trunk #2469, no
> weird patches of mine.
> 
> Something goes utterly wrong, the debugger currently points into
> xnshadow_relax->rpi_push, and there into some queuing operation. Note
> that I have XENO_OPT_SCALABLE_SCHED on in my config, also
> XENO_OPT_PRIOCPL. Without XENO_OPT_SCALABLE_SCHED, things seems to work
> find. Who did last work on this? What was fixed?

Looking at svn log, you did the last modification. What about activating
queue debugging ?

-- 
                                                 Gilles Chanteperdrix


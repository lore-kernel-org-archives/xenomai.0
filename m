From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20091104055659.GA5280@domain.hid>
References: <20091103133407.GA9836@domain.hid>
	<1257259464.2210.32.camel@domain.hid>
	<20091104055659.GA5280@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Nov 2009 10:54:24 +0100
Message-ID: <1257328464.2210.66.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai core] Freeze on MPC8572 and P2020 with
	SMP
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-11-04 at 06:56 +0100, Richard Cochran wrote:
> On Tue, Nov 03, 2009 at 03:44:24PM +0100, Philippe Gerum wrote:
> > On Tue, 2009-11-03 at 14:34 +0100, Richard Cochran wrote:
> > > If I enable ipipe only, I can still boot SMP. If Xenomai is enabled,
> > > then the machine freezes as soon as Xenomai is started. (As a module,
> > > Xenomai locks the machine when loading).
> > 
> > Did you try enabling the pipeline debug options, like
> > CONFIG_IPIPE_DEBUG_CONTEXT and CONFIG_IPIPE_DEBUG_INTERNAL?
> 
> Yes, but it makes no difference, and I see no additional messages from
> the kernel on the console.
> 
> BTW, I also disabled CONFIG_XENO_OPT_PERVASIVE, but it still locks up.
> 

The issue is more likely in the interrupt pipeline. When Xenomai is
compiled as modules, does the system lock up when loading the nucleus,
or do things go wrong when the first skin is loaded on top of this?

> Richard


-- 
Philippe.




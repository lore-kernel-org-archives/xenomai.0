Date: Wed, 4 Nov 2009 15:08:32 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20091104140832.GA32220@domain.hid>
References: <20091103133407.GA9836@domain.hid>
	<1257259464.2210.32.camel@domain.hid>
	<20091104055659.GA5280@domain.hid>
	<1257328464.2210.66.camel@domain.hid>
	<20091104111536.GA14614@domain.hid>
	<1257334005.2210.86.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257334005.2210.86.camel@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Nov 04, 2009 at 12:26:45PM +0100, Philippe Gerum wrote:
> 
> Ok, this is a porting issue. The critical IPI (IPIPE_CRITICAL_IPI) does
> not seem to be properly handled on this platform.
> 
> > I'll try and pull this apart some more...

I was able to get SMP to boot, by accident.

Using the BDI3000 telnet console, I halted the second core, and booted
the SMP kernel on the first core. Then, I started the second core,
which seems to work just fine!

Weird. Wish me luck,

Richard


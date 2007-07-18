From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <2ff1a98a0707180103p67db415bsdee7c8195be80f21@domain.hid>
References: <18077.6356.94172.274545@domain.hid>
	<1184745003.6562.39.camel@domain.hid>
	<2ff1a98a0707180103p67db415bsdee7c8195be80f21@domain.hid>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 10:26:37 +0200
Message-Id: <1184747197.6562.64.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [patch] fix
	ximulator	xnarch_program_next_timer_shot.
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2007-07-18 at 10:03 +0200, Gilles Chanteperdrix wrote:
> On 7/18/07, Philippe Gerum <rpm@xenomai.org> wrote:
> > On Tue, 2007-07-17 at 21:30 +0200, Gilles Chanteperdrix wrote:
> > > The attached patch fixes this, though I am not sure it is the best way
> > > to fix it.
> >
> > Looks good.  The only thing that still bothers me is that, at some
> > point, it seems that we are triggering an immediate shot. Even if this
> > situation is clearly possible in the real environment, I find it a bit
> > suspicious in the simulated one. Maybe this is related to the timer
> > adjustement code that may raise such situation (which would explain it
> > then)?
> 
> Yes, this is because of the timer adjustment code. We enqueue timers
> with an already passed expiry date, so the timer code ends up calling
> xnarch_program_timer_shot with a null delay.
> 

Then your patch is definitely ok. Will merge for -rc2 along with the
timer adjustment code.

-- 
Philippe.




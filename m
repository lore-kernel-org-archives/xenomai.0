Subject: Re: [Xenomai-core] Unwanted mode switch.
In-Reply-To: <45A65984.3070402@domain.hid>
References: <45A656C6.6060406@domain.hid>  <45A65984.3070402@domain.hid>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 21:57:06 +0100
Message-Id: <1168549026.25399.176.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Philippe Gerum <philippe.gerum@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2007-01-11 at 16:36 +0100, Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
> > Hi,
> > 
> > in order to test the nocow patch, I wrote the attached test. Despite the
> > fact that there is no longer any page fault (I have nucleus debugging
> > on, so I would get a message if there was a fault), there is still an
> > unwanted mode switch at step 5. Any idea what could be the cause ?
> 
> I added a show_stack(NULL, NULL) in xnshadow_relax, and I get the
> following stack trace:
> xnshadow_relax
> hisyscall_event

  ^^^ Eeek... Which would mean that we would somehow be running the
hi-stage handler for a task on behalf of, say, xnshadow_harden()? Could
you confirm the backtrace? Any chance the frame unwinding went south
here?

Dumping the muxid/muxop pair for the hisyscall_event call which attempts
to relax the underlying task might be interesting.

> xnshadow_sys_migrate
> losyscall_event
> 
-- 
Philippe.




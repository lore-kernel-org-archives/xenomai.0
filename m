MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18342.45584.139117.182550@domain.hid>
Date: Mon, 4 Feb 2008 07:34:56 +0100
In-Reply-To: <47A63D49.4050700@domain.hid>
References: <18340.31233.591834.293535@domain.hid>
	<47A63D49.4050700@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 0/5] Support for select v2.
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
 > Gilles Chanteperdrix wrote:
 > > Hi,
 > > 
 > > after some tests, bug fixes and optimizations, here comes a second version of 
 > > the patch-set adding select support to xenomai posix skin.
 > > 
 > 
 > Puh, a lot of code, and my brain is still full of KGDB stuff I'm trying
 > to polish for mainline since days.
 > 
 > The approach looks consistent to me. I would just suggest to make the
 > whole thing configurable, so that it doesn't add overhead to systems
 > which do not use it.

The core support does not take that much code. The RTDM patch however is
huge, that is because we duplicate each rtdm_event and rtdm_sem service
for the select-enabled objects. What would you think of adding select
support to the rtdm_event and rtdm_sem objects without creating the new
rtdm_select_event_t and rtdm_select_sem_t objects if the whole select
support was configurable ? That is if select support is not selected,
RTDM is as before, if select is enabled, rtdm_event_t and rtdm_sem_t
objects may be used with select.

 > 
 > Out of curiosity: Did you already have a chance to compare a
 > multi-threaded demo application with one based on these new select services?

We compared two standard Linux applications, one using select, the other
being threaded, and there is no question: the select based scales much
better. But as usual, it was on low end ARM hardware.

 > 
 > I guess your current test cases are built on top of RTnet, aren't they?
 > Would be nice, also for regression testing, to have some demo for
 > /examples, e.g. exploiting the CAN stack (because it has virtual CAN,
 > thus it is usable without hardware).

Ok, will probably do that.


-- 


					    Gilles Chanteperdrix.


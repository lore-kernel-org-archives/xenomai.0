Subject: Re: [Xenomai-core] Xenomai on PXA
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17595.47131.142881.132531@domain.hid>
References: <200607071703.10700.vagninu@domain.hid>
	<17582.50372.830923.414981@domain.hid>
	<44B34343.9F56F13@domain.hid>
	<17595.47131.142881.132531@domain.hid>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 18:29:47 +0200
Message-Id: <1153153788.11603.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Mon, 2006-07-17 at 18:17 +0200, Gilles Chanteperdrix wrote:
> Detlef Vollmann wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Danilo Levantesi wrote:
>  > >  > So what is the status of the port? Is anything working on a pxa arch?
>  > > 
>  > > More recently, Detlef Vollmann seem also to have begun a port to
>  > > PXA.
>  > Unfortunately my priorities were shifted, so I'm not able to
>  > work on it for the next few weeks.
>  > 
>  > What I've done so far is attached.
>  > IT'S UNTESTED!!!
>  > So it's nothing you can just use, but something that you can build
>  > on (possibly).
>  > I'd be happy to hear about any experience with this.
>  > 
>  > What is missing is a look at entry-macro.S.
>  > Stelian Pop has done something for the Integrator that I don't
>  > really understand and therefore I can't say whether the PXA needs
>  > something similar.
>  > 
>  >  Detlef
> 
> Hi,
> 
> Starting from Detlef patch, I made some tests on an SA1100 based ARM,
> attached is a patch that works for me, which I also adapted to PXA
> without testing it. It would be nice if someone could test it on PXA.
> 
> In order to do these tests, I had to adapt the ARM ipipe 2.6.15 patch to
> linux 2.6.16, so the 2.6.16 ipipe patch is attached too for further
> testing. Note that I had to make a small modification in
> include/asm-arm/system.h, because the SA1100 version of __xchg uses
> local_irq_restore, which use PSR_I_BIT, which is defined elsewhere, so I
> replaced PSR_I_BIT with its value. I now wonder if it is the proper fix,
> or if __xchg should be fixed to use local_irq_save_hw and
> local_irq_restore_hw instead, as is the case for the atomic operations
> defined in atomic.h and bitops.h.

Definitely, it should be fixed to use hw masking ops.

-- 
Philippe.




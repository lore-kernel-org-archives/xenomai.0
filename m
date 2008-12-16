From: Roberto Bucher <roberto.bucher@domain.hid>
Date: Tue, 16 Dec 2008 15:34:25 +0100
References: <49477854.3030302@domain.hid>
	<200812161342.23742.roberto.bucher@domain.hid>
	<4947A3D3.1020502@domain.hid>
In-Reply-To: <4947A3D3.1020502@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200812161534.26351.roberto.bucher@domain.hid>
Subject: Re: [Adeos-main] [PATCH] x86-2.6.27: Cleanup redundant mtrr hunk
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

I'm sorry but my system freezes without giving some info in the log files...

I don't know exactly what I can do: basically I can reproduce the error, but I 
can't catch any log info about.

Roberto

On Tuesday 16 December 2008 13:49:23 you wrote:
> Roberto Bucher wrote:
> > I rebooted my laptop 10 minutes ago and the problem happens again!
>
> Grmbl. Still no chance to get hold of an oops message?
>
> Jan
>
> > Roberto
> >
> > On Tuesday 16 December 2008 10:43:48 Jan Kiszka wrote:
> >> Likely a merge artifact: IRQs are already reenabled a few lines above
> >> this hunk.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
> >>
> >> ---
> >>  arch/x86/kernel/cpu/mtrr/generic.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> Index: b/arch/x86/kernel/cpu/mtrr/generic.c
> >> ===================================================================
> >> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> >> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> >> @@ -575,7 +575,7 @@ static void generic_set_all(void)
> >>  			set_bit(count, &smp_changes_mask);
> >>  		mask >>= 1;
> >>  	}
> >> -	local_irq_restore_hw(flags);
> >> +
> >>  }
> >>
> >>  static void generic_set_mtrr(unsigned int reg, unsigned long base,
> >>
> >> _______________________________________________
> >> Adeos-main mailing list
> >> Adeos-main@domain.hid
> >> https://mail.gna.org/listinfo/adeos-main

-- 
University of Applied Sciences of Southern Switzerland
Dept. Innovative Technologies
CH-6928 Lugano-Manno
http://web.dti.supsi.ch/~bucher


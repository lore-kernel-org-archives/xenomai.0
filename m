Subject: Re: [Xenomai-help] invalid use of FPU in Xenomai context
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <450F0451.8070102@domain.hid>
References: <450B2BE1.1050105@domain.hid>
	<20060916042719.M57867@domain.hid>  <450F0451.8070102@domain.hid>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 23:23:18 +0200
Message-Id: <1158614598.5009.71.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2006-09-18 at 15:40 -0500, Jeff Webb wrote:
> Jeff Webb wrote:
> > Okay...  I have found a simple example that exhibits the problem on my
> > linux-2.4 system (see attached).  I am running xenomai 2.2.2 with the two RTAI
> > FIFO patches (and the latest FPU-related patch).  
> 
> I still get the same error with xenomai-2.2.3 on my 2.4.33.3 and 2.6.17.13 x86 machines.  Did anyone get a chance to try the sample kernel module I posted?
> 
>   https://mail.gna.org/public/xenomai-help/2006-09/msg00143.html
> 
> Perhaps this is related to the FPU bug Jan just reported?

There's a good chance that both issues are related. Several heads are
currently banging on proper walls to precisely spot the issue, since it
seems that not all x86 setups are affected.

> 
>   https://mail.gna.org/public/xenomai-core/2006-09/msg00138.html
> 
> If so, then maybe the problem is related to the rt-pipe changes...
> 
> > I get two unresolved
> > math-related symbols when I try to insert this module on my FC5 2.6 machine,
> > so I can't comment on the linux-2.6 behavior at this time.  But that's a
> > puzzle for another day...
> 
> FYI, I added "-ffast-math -mhard-float" to the CFLAGS to get rid of the unresolved symbols.
> 
> Thanks,
> 
> -Jeff
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.




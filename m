Message-ID: <2ff1a98a0708070549m4c4a5dffq92370ef61247b5c8@domain.hid>
Date: Tue, 7 Aug 2007 14:49:20 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <46B85236.9010107@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <46B1A842.1090708@domain.hid>
	<1186049556.6611.319.camel@domain.hid> <46B1B7DE.3080404@domain.hid>
	<1186053839.6611.326.camel@domain.hid> <46B2E1B3.2020102@domain.hid>
	<2ff1a98a0708060208k1d217ae6ge20389074d9bf1bd@domain.hid>
	<18103.2297.602539.889750@domain.hid>
	<46B85236.9010107@domain.hid>
Subject: Re: [Xenomai-help] Unexpected switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

On 8/7/07, Johan Borkhuis <j.borkhuis@domain.hid> wrote:
> Gilles,
>
> Gilles Chanteperdrix wrote:
> > Gilles Chanteperdrix wrote:
> >  > On 8/3/07, Johan Borkhuis <j.borkhuis@domain.hid> wrote:
> >  > > Philippe,
> >  > >
> >  > > (BTW: is this something that should be discussed in the Xenomai group,
> >  > > or would it be better to move this discussion to the Adeos mailing list?)
> >  > >
> >  > > I do have question on this. We already discussed this problem earlier,
> >  > > and I managed to find a very dirty work around for my application: I
> >  > > added a lot of "dummy" functions to my application, which are spread
> >  > > over the whole application. By calling these after the mlockall, but
> >  > > before I switch to RT-mode I manage to eliminate most of the switches.
> >  >
> >  > Before implementing the nocow patch, I opened /proc/self/maps and
> >  > caused a fault on every writable page, even if ugly, this looks
> >  > simpler than spreading dummy functions over the whole application.
> >
> > I posted the piece of code here:
> > https://mail.gna.org/public/xenomai-help/2006-12/msg00168.html
> >
> Thank you for this. However, it does not seem to work: when I execute
> this code it does not make any difference, when executed before I start
> a RT-task or even within a RT-task. The results are identical to the
> results as if no dummy functions were used. Only the pages that can be
> written are touched, but the code pages that cause the problem (afaik)
> are marked readonly, so they are not touched. I modified the linking, to
> mark the text-section as writable, but that also did not make any
> difference.
> The fact that this does not work could be caused by the fact that you
> are accessing the pages as data instead of code.
>
> Next I tried something different, more like a combination between my
> original approach and your approach: I tried to find a "return from
> subroutine" in each text-page, and if found call this location. It is
> extremely dirty, but it does seem to work quite well. Below is the code
> that I used:

The code I sent only access writable pages, and apparently you need to
also access read-only pages.

Why not doing something like:
else if(buffer[1] == 'r')  {
    static voltatile int dummy;
    dummy = *(volatile int *)begin;
}


-- 
                                               Gilles Chanteperdrix


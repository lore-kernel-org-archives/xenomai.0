From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Fri, 28 Jun 2013 10:44:21 +0200
References: <201306260906.22955.leo@alaxarxa.net>
	<201306271454.03648.leo@alaxarxa.net>
	<51CC36D8.8080709@xenomai.org>
In-Reply-To: <51CC36D8.8080709@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201306281044.21820.leo@alaxarxa.net>
Subject: Re: [Xenomai] Xenomai warn_upon_switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

A Dijous, 27 de juny de 2013, Gilles Chanteperdrix va escriure:
> On 06/27/2013 02:54 PM, Leopold Palomo-Avellaneda wrote:
> 
> > A Dijous, 27 de juny de 2013, Gilles Chanteperdrix va escriure:
> >> On 06/27/2013 11:09 AM, Leopold Palomo-Avellaneda wrote:
> >>
> >>> A Dimecres, 26 de juny de 2013, Gilles Chanteperdrix va escriure:
> >>>> On 06/26/2013 09:06 AM, Leopold Palomo-Avellaneda wrote:
> >>> AAnd I don't know how to silent (or if is possible) this messages.
> >>
> >>
> >> The point is that these messages are telling you that there is a bug,
> >> either in xenomai code (a bug was fixed since xenomai 2.6.2.1 which
> >> could explain such a behaviour), or in orocos code. When the bug is
> >> fixed the signal will disappear.
> > 
> > I have compiled a new kernel and the messages are still. I'm using 
2.6.2.1. I 
> > agree that there's a bug but in orocos. I understand that Xenomai emits a 
> > signal warning about context switch and orocos (or whatever application 
that 
> > uses Xenomai) must treat with it. This behavior was changed in 2.6.x.
> > 
> > Please could you confirm if is this the problem?
> 
> 
> As I said, to answer this question, you should change the SIGDEBUG
> signal handler as is done in examples/native/sigdebug.c to know the
> signal reason.
> 

Ok,

I see. I don't know how is the Orocos code, but I will try to look on it. The 
example you have post seems clear.

Thanks for all,

I will inform,


Best regards,

Leo


-- 
--
Linux User 152692
Catalonia


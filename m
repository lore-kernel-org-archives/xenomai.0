MIME-Version: 1.0
In-Reply-To: <4FE38513.2080607@xenomai.org>
References: <CA+K6ZL0db_K0NsuEcKrQO9rcJ4myrx6QVge6i7HyMEkDhkwWww@mail.gmail.com>
	<4FE38513.2080607@xenomai.org>
Date: Fri, 22 Jun 2012 08:57:39 +0200
Message-ID: <CA+K6ZL0zMjXK-kp51E_FBZq73Tkvpm+dcO8V6FbQj4SekiiVTA@mail.gmail.com>
From: Remco den Breeje <remco@vioco.nl>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] ARM I-pipe patch for 3.1+ kernels
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Thanks for pointing that out. I'll take a look.

Remco

On Thu, Jun 21, 2012 at 10:33 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 06/21/2012 10:14 PM, Remco den Breeje wrote:
> > Hi Gilles et.al.,
> >
> > I'm interested in running a Xenomai patched system on a Raspberry Pi
> > computer[1] that compromises a ARM11 CPU (ARMv6 architecture). The Linux
> > kernels supported on the Raspberry are either Linux 3.1 or 3.2 [2,3],
> while
> > the most recent ARM ipipe patch is written for a 3.0 kernel. Looking at
> > your ipipe git[4], there hasn't been ARM related work for more recent
> > kernels.
> > What are the changes of a forward port, rebased on 3.1 or 3.2 kernels?
> Are
> > there underlying technical difficulties?
> >
> > I'm aware that even if there was a >3.0 ARM patch available, the
> Raspberry
> > specific code needs to be ported. However, being a ARM-newby, porting
> board
> > specific code together with porting the ipipe code is one step too far ;)
>
> The ipipe branch core-3.2 supports kernel 3.2 on arm. Note however that
> a lot of things have changed in this patch version, so the I-pipe
> porting guide is completely helpless.
>
> More generally, the git repository with the current work on the arm
> architecture is:
> http://git.xenomai.org/ipipe-gch.git
>
> The branch for kernel x.y is for-ipipe-x.y-arm
>
> --
>                                                                Gilles.
>

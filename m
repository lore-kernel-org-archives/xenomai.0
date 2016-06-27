Date: Mon, 27 Jun 2016 13:12:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160627111228.GB18662@hermes.click-hack.org>
References: <CAJ2oMh+w8m_ZiWC45US8Qbi7oWU-X0SH28wsFghLQzYbmTfuyg@mail.gmail.com>
 <20160627105948.GA18662@hermes.click-hack.org>
 <CAJ2oMhL_Mde=pY2dVeaU-9WqWs2AhY9-1yVONC3wSXUYOD3omA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhL_Mde=pY2dVeaU-9WqWs2AhY9-1yVONC3wSXUYOD3omA@mail.gmail.com>
Subject: Re: [Xenomai] xenomai patch for kernel & omap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Mon, Jun 27, 2016 at 02:05:35PM +0300, Ran Shalit wrote:
> On Mon, Jun 27, 2016 at 1:59 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
> > On Mon, Jun 27, 2016 at 01:58:21PM +0300, Ran Shalit wrote:
> > > Hello,
> > >
> > > I need to patch a kernel version (which I don't know yet the exact
> > version)
> > > for OMAP4 processor.
> > >
> > > I've seen the following post:
> > > https://xenomai.org/pipermail/xenomai/2015-March/033649.html
> > >
> > > which explain that patch x.y.z should support ALL kernel version up to
> > x.y.z
> > >
> > > If I understand correctly,
> >
> > You did not understand correctly.
> >
> > --
> >                                             Gilles.
> > https://click-hack.org
> >
> 
> Hi Gilles,
> 
> When I used xenomai before (with zynq) , I worked with the exact kernel
> version 3.8.13 as this patch requires (trying to merge older kernel was
> too difficult).
> 
> Is it the correct thing to do ?
> I mean, when we have some old kernel, i.e. to try to merge it with the
> required kernel version as the patch requires ?

There is no "correct thing". Do the one that is the easiest for you.
For me, the simpler solution is to use a kernel for which
an I-ipipe patch already exists, but YMMV.

You have a large choice of them here:
https://xenomai.org/downloads/ipipe/v3.x/arm/
and here:
https://xenomai.org/downloads/ipipe/v4.x/arm/

The rule for matching I-pipe versions with Xenomai versions is
explained in the mail you quote.

-- 
					    Gilles.
https://click-hack.org


Date: Tue, 9 Feb 2016 10:23:42 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <1661765269.2313665.1455013422492.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <20160208224930.GF5654@hermes.click-hack.org>
References: <20160208224930.GF5654@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe tracer call trace during boot
Reply-To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> On Monday, 8 February 2016, 23:49, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, Feb 08, 2016 at 02:54:12PM +0000, Frederik Bayart wrote:
> > > On Saturday, 6 February 2016, 14:46, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > >
> > > On Fri, Feb 05, 2016 at 11:13:56AM +0000, Frederik Bayart wrote:
> > >
> > > > I have build an 3.18.20 kernel with xenomai 2.6.4 git latest with ipipe-core-3.18.20-x86-4.patch on debian jessie amd64 (64bit).
> > > >
> > > > I try to build an version with ipipe tracer.
> > > >
> > > > If I try to boot, I get a call trace : in __ipipe_init_tracer :
> > > >
> > > > RIP __ipipe_tracer_hrclock_initialized
> > >
> > > Hi,
> > >
> > > the problem is probably the commit you found. Will try your
> > > configuration soon.
> > > --
> > >                        Gilles.
> >
> > I tried with ipipe-core-3.18.20-x86-2.patch with doesn't contain that commit and I have still a call trace :
> >
> > RIP __ipipe_init_tracer
> 
> Hi,
> 
> I could reproduce this issue. Running "addr2line" on the RIP points
> to __BUILTIN_RETURN_ADDRESS1. I tried enabling frame pointers
> (CONFIG_FRAME_POINTER=y) and the kernel does not crash. I suspect
> __builtin_return_address(1) relies in fact on frame pointers.
> -- 
>                         Gilles.

Problem solved. Thanx for the help.

Frederik


MIME-Version: 1.0
In-Reply-To: <20150218232503.GS30317@hermes.click-hack.org>
References: <CA+C+_XS5KxwQ=YKXD6YZ_T41+xdh8q+ag4Xh-Me6EoHLHJ3-Dg@mail.gmail.com>
 <20150218195219.GL30317@hermes.click-hack.org>
 <CA+C+_XSPcEAc3EKJWVZUvkVCf617j-WygceMjUXYOXWAJc8gzQ@mail.gmail.com>
 <20150218205228.GN30317@hermes.click-hack.org>
 <CA+C+_XRUa5apka-aMAvgnd66tUVq+wY0dFqh8u3Fw5oa96HOjA@mail.gmail.com>
 <20150218212915.GQ30317@hermes.click-hack.org>
 <CA+C+_XQ0R6uRu7Ko6tLRLS8aExnr=oe05-=xXceqX5MS5gvrDw@mail.gmail.com>
 <CA+C+_XQSeV2N6PrdNuj2uNoSpwUqDJ6H0p0kL-XsW_CNHUtu4g@mail.gmail.com>
 <20150218232503.GS30317@hermes.click-hack.org>
Date: Mon, 23 Feb 2015 13:21:55 -0600
Message-ID: <CA+C+_XT8iFT-+A+OEFoeq7GVbj9UkE6FW0NHbSvzro362swigA@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Remote debugging problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Ok.  Thanks.

On Wed, Feb 18, 2015 at 5:25 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Feb 18, 2015 at 05:20:13PM -0600, Mathew Benson wrote:
> > I have the linaro toolchain installed and it seems to be running much
> > better.  It initializes with no errors but its dying without giving me a
> > chance to see where.  I think the gdbserver on the target is dying.
> Here's
> > my gdbinit:
> >
> > handle SIG63 nostop noprint pass
> > set sysroot remote:/
> >
> > I see the following error in my debugger:
> >
> > Interrupted while waiting for the program.
> > Give up (and stop debugging it)?
> > (y or n) [answered Y; input not from terminal]
> >
> > Any idea what this might be?
>
> No idea, but versions mismatch do this kind of stuff. Before trying
> with Xenomai, you should try with an unpatched kernel, and if you
> get weird behaviour, I suggest you try other sources of information.
> The xenomai mailing list is a list where we know about xenomai, but
> maybe not the best mailing list for gdb support.
>
> --
>                                             Gilles.
>

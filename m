MIME-Version: 1.0
In-Reply-To: <20150218205228.GN30317@hermes.click-hack.org>
References: <CA+C+_XS5KxwQ=YKXD6YZ_T41+xdh8q+ag4Xh-Me6EoHLHJ3-Dg@mail.gmail.com>
 <20150218195219.GL30317@hermes.click-hack.org>
 <CA+C+_XSPcEAc3EKJWVZUvkVCf617j-WygceMjUXYOXWAJc8gzQ@mail.gmail.com>
 <20150218205228.GN30317@hermes.click-hack.org>
Date: Wed, 18 Feb 2015 15:23:28 -0600
Message-ID: <CA+C+_XRUa5apka-aMAvgnd66tUVq+wY0dFqh8u3Fw5oa96HOjA@mail.gmail.com>
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

I just yum installed the cross compiler.  Are you saying I should get a
tool chain that contains both the host and target code?  I'm downloading
the Linaro tool chain now.

On Wed, Feb 18, 2015 at 2:52 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Feb 18, 2015 at 02:49:26PM -0600, Mathew Benson wrote:
> > That's what I thought.  I also gave you the wrong gdbserver version.  Its
> > 7.4.1.  The Fedora repos for my host have arm-linux-gnueabihf 7.6.2, but
> > I'm not finding 7.4.1 yet.  Do you have any recommendations of where to
> > find an RPM for gdb 7.4.1 on Fedora 21 x86_64?  I haven't found an rpm
> yet
> > and I prefer not to have to compile from source.  Or, should I upgrade
> the
> > target gdbserver to to 7.6.2?
>
> A well behaved toolchain provides the gdbserver and the
> corresponding cross gdb for the architecture for which you are
> compiling.
>
> --
>                                             Gilles.
>

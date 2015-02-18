MIME-Version: 1.0
In-Reply-To: <20150218195219.GL30317@hermes.click-hack.org>
References: <CA+C+_XS5KxwQ=YKXD6YZ_T41+xdh8q+ag4Xh-Me6EoHLHJ3-Dg@mail.gmail.com>
 <20150218195219.GL30317@hermes.click-hack.org>
Date: Wed, 18 Feb 2015 14:49:26 -0600
Message-ID: <CA+C+_XSPcEAc3EKJWVZUvkVCf617j-WygceMjUXYOXWAJc8gzQ@mail.gmail.com>
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

That's what I thought.  I also gave you the wrong gdbserver version.  Its
7.4.1.  The Fedora repos for my host have arm-linux-gnueabihf 7.6.2, but
I'm not finding 7.4.1 yet.  Do you have any recommendations of where to
find an RPM for gdb 7.4.1 on Fedora 21 x86_64?  I haven't found an rpm yet
and I prefer not to have to compile from source.  Or, should I upgrade the
target gdbserver to to 7.6.2?

On Wed, Feb 18, 2015 at 1:52 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Feb 18, 2015 at 01:45:06PM -0600, Mathew Benson wrote:
> > -  gdb 4.9.2
> > -  gdbserver 2.6.3
> >
> > Before I put more details up, is there anything with the configuration
> > above that stands out as being a problem?  Specifically, the gdb and
> > gdbserver versions?
>
> For gdb to work with gdbserver the versions must be exactly the same.
>
> --
>                                             Gilles.
>

MIME-Version: 1.0
In-Reply-To: <20150218212915.GQ30317@hermes.click-hack.org>
References: <CA+C+_XS5KxwQ=YKXD6YZ_T41+xdh8q+ag4Xh-Me6EoHLHJ3-Dg@mail.gmail.com>
 <20150218195219.GL30317@hermes.click-hack.org>
 <CA+C+_XSPcEAc3EKJWVZUvkVCf617j-WygceMjUXYOXWAJc8gzQ@mail.gmail.com>
 <20150218205228.GN30317@hermes.click-hack.org>
 <CA+C+_XRUa5apka-aMAvgnd66tUVq+wY0dFqh8u3Fw5oa96HOjA@mail.gmail.com>
 <20150218212915.GQ30317@hermes.click-hack.org>
Date: Wed, 18 Feb 2015 15:39:18 -0600
Message-ID: <CA+C+_XQ0R6uRu7Ko6tLRLS8aExnr=oe05-=xXceqX5MS5gvrDw@mail.gmail.com>
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

Damn.  Ok.  Learned something new.  Knowing that would have made my life a
lot easier.  I always compiled and/or installled tools as I needed them.
I'm downloading a preconfigured toolchain from the TI website now.  Thanks.

On Wed, Feb 18, 2015 at 3:29 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Wed, Feb 18, 2015 at 03:23:28PM -0600, Mathew Benson wrote:
> > I just yum installed the cross compiler.  Are you saying I should get a
> > tool chain that contains both the host and target code?  I'm downloading
> > the Linaro tool chain now.
>
> Yes, the cross toolchain usually contains some files which you can
> install on the target, like glibc, gdbserver, etc...
>
> --
>                                             Gilles.
>

Date: Thu, 19 Feb 2015 00:25:03 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150218232503.GS30317@hermes.click-hack.org>
References: <CA+C+_XS5KxwQ=YKXD6YZ_T41+xdh8q+ag4Xh-Me6EoHLHJ3-Dg@mail.gmail.com>
 <20150218195219.GL30317@hermes.click-hack.org>
 <CA+C+_XSPcEAc3EKJWVZUvkVCf617j-WygceMjUXYOXWAJc8gzQ@mail.gmail.com>
 <20150218205228.GN30317@hermes.click-hack.org>
 <CA+C+_XRUa5apka-aMAvgnd66tUVq+wY0dFqh8u3Fw5oa96HOjA@mail.gmail.com>
 <20150218212915.GQ30317@hermes.click-hack.org>
 <CA+C+_XQ0R6uRu7Ko6tLRLS8aExnr=oe05-=xXceqX5MS5gvrDw@mail.gmail.com>
 <CA+C+_XQSeV2N6PrdNuj2uNoSpwUqDJ6H0p0kL-XsW_CNHUtu4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XQSeV2N6PrdNuj2uNoSpwUqDJ6H0p0kL-XsW_CNHUtu4g@mail.gmail.com>
Subject: Re: [Xenomai] Remote debugging problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Feb 18, 2015 at 05:20:13PM -0600, Mathew Benson wrote:
> I have the linaro toolchain installed and it seems to be running much
> better.  It initializes with no errors but its dying without giving me a
> chance to see where.  I think the gdbserver on the target is dying.  Here's
> my gdbinit:
> 
> handle SIG63 nostop noprint pass
> set sysroot remote:/
> 
> I see the following error in my debugger:
> 
> Interrupted while waiting for the program.
> Give up (and stop debugging it)?
> (y or n) [answered Y; input not from terminal]
> 
> Any idea what this might be?

No idea, but versions mismatch do this kind of stuff. Before trying
with Xenomai, you should try with an unpatched kernel, and if you
get weird behaviour, I suggest you try other sources of information.
The xenomai mailing list is a list where we know about xenomai, but
maybe not the best mailing list for gdb support.

-- 
					    Gilles.


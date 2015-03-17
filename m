From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 17 Mar 2015 17:34:57 -0400
Message-ID: <20150317213457.GZ25508@csclub.uwaterloo.ca>
References: <CAEMXjGwam0jjOrUBgBY_FyFOaT15qHdobMo96G3bEsWx6rEcpA@mail.gmail.com>
 <20150317180654.GB16113@hermes.click-hack.org>
 <CAEMXjGxSMGQFfBvUG3VdepA_cRHb=6n1V_pO3QzXtofY2bUuMA@mail.gmail.com>
 <20150317192431.GY25508@csclub.uwaterloo.ca>
 <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEMXjGx6R0HtdJwU5_5AoDN=KV1T9nn5ug-ZwctJzd9B43NYSw@mail.gmail.com>
Subject: Re: [Xenomai] Building with hard float: cannot open shared object
 file libpthread_rt.so.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Tue, Mar 17, 2015 at 12:57:43PM -0700, Steve B wrote:
> Originally some other engineers on my project specified that we use
> Angstrom Linux which seems to only work with gnueabi.
> I noticed that the pow() function was causing problems so I looked at the
> disassembly of the libm.so with that toolchain and it looks suspiciously
> like soft floating point routines.
> 
> So I'm trying to run my simple test program on a Debian distribution which
> is built with gnueabihf. Seems like the issue is that if I use the
> -mhard-float option, I can't run with Xenomai, even if I built the Xenomai
> libraries with -mhard-float enabled.
> If I don't add in -mhard-float when I compile the program, the pow()
> function still takes much too long... if I enable -mhard-float and take
> away the Xenomai libs, then the pow() function executes in a reasonable
> amount of time.
> I guess there still may be something wrong in making sure everything is
> built the same.
> 
> Hopefully that makes more sense?

Xenomai runs fine on Debian with hard float, as long as your whole system
is built that way.  No specifying of -mhard-float, just using what the
tool chain of the system does by default, and of course on debian armhf,
that is hard float.

-- 
Len Sorensen


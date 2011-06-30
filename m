From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4E0C581C.5040701@domain.hid>
References: <18837_1309425123_4E0C3DE3_18837_902_2_ECB646CBB62FD044927FDEDF0252D3E701E388DDD283@domain.hid>
	<1309426397.2228.2.camel@domain.hid>
	<1454_1309428796_4E0C4C3C_1454_4301_1_ECB646CBB62FD044927FDEDF0252D3E701E388DDD4C1@domain.hid>
	<4E0C5400.7060200@domain.hid>  <4E0C581C.5040701@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Jun 2011 15:05:22 +0200
Message-ID: <1309439122.2228.116.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with Valgrind ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: varname <varname@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Thu, 2011-06-30 at 13:03 +0200, varname wrote:
> Gilles Chanteperdrix wrote:
> > On 06/30/2011 12:13 PM, VEYSSIERE Nicolas wrote:
> >> Ok, so is there something that can replace Valgrind and works with Xenomai ?
> >>
> >> I am using the VxWorks skin.
> >>
> > You can use valgrind either with Xenomai simulator, but that will not be
> > easy, or with Xenomai-solo. But not with the dual-kernel version.
> 
> Could you comment on the status of Xenomai-solo? Last time I checked 
> (some 7 months ago) it was missing parts of the native skin. I also 
> remember the git checkout was not compilable. I'm rather interested in 
> using it for (automated) testing purposes, such as memory leak checking.
> 

Xenomai-solo was proof of concept work, which eventually moved to the
xenomai-forge repository where the next Xenomai 3 architecture is being
developed. The development of the native API in the -solo branch is
discontinued, it will resume in another form in the -forge repo at some
point.

There is no documentation about the -forge contents yet. The survival
kit when browsing this code includes knowing that:

- it aims at providing support for both dual kernel based and
native-linux (typically PREEMPT_RT) platforms, using the largest
possible base of common code.

- most of the high level API implementation started to move to userland,
with no more API-specific kernel code. These APIs get real-time services
from the POSIX layer available with the underlying environment (dual
kernel's POSIX skin or nptl from native linux), which specifics are
hidden by an abstract service library.

- "copperplate" identifies the library which abstracts the real-time
services used by the high level APIs, so that their implementation is
not dependent on the underlying real-time core. It is a bit like the
nucleus API, but for userland client usage.

- this new architecture therefore exhibits two real-time cores, selected
at build time. The dual kernel core inherited from the Xenomai 2
architecture is nicknamed "cobalt" in the sources. The native linux core
inherited from the -solo work is called "mercury".

- the whole thing is still in flux.

-- 
Philippe.




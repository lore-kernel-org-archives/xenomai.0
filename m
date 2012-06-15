Message-ID: <4FDAD6C9.5030001@xenomai.org>
Date: Fri, 15 Jun 2012 08:31:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHyVJywDajR-Mwn27kB5mcX8SGeZqwCUWPUVE_v-oCkNg5U8wA@mail.gmail.com>	<4FD9A8BF.6040404@xenomai.org>
	<CAHyVJyzgeygWe6DszhJR1V7Q0aNu3DEnVewzUJ1o4XwbD3vz+A@mail.gmail.com>
In-Reply-To: <CAHyVJyzgeygWe6DszhJR1V7Q0aNu3DEnVewzUJ1o4XwbD3vz+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help??
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohit Jandwani <mohitjandwani@gmail.com>
Cc: xenomai@xenomai.org

On 06/15/2012 03:36 AM, Mohit Jandwani wrote:
> Hey is it possible to patch linux3.0.15(with arm config) with the help
> of adeos?

The adeos patch is made for 3.0.13, it may apply, or not, to 3.0.15, you
have to try it to know.

> The kernel code that I have is 3.0.15 and has been patched to make it
> run on my board(exynos4210).This is the reason why there is no time.c
> file in my mach-exynos folder because the patch changed it (I am trying
> to figure out how).

For the second time: the name of the file is irrelevant. What you need
to find is the file which handles the hardware timer. You do not care
how it is called. time.c in the guide is a shorthand for "the file which
contains the code handling the hardware timer".

> I can't find the patch for 3.0.13 (but I am searching).

The patch is in gna download area:
http://download.gna.org/adeos/patches/

However, for what you are trying to do it may make more sense to use git.

You will find the current development of I-pipe on ARM in this repository:
git://git.xenomai.org/ipipe-gch.git

The branch is named for-ipipe-3.0-arm

> If I have to use Ipipe core, then do I just download the source code and
> make it to get my patch?

The I-pipe core currently exists only as a git repository. It is the branch
for-ipipe-3.2-arm in the same repository, or the branche core-3.2, in
the following repository:

git://git.denx.de/ipipe.git

The address of xenomai mailing list is xenomai@xenomai.org, the other
addresses are now invalid.

-- 
                                                                Gilles.


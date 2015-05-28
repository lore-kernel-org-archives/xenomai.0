From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 28 May 2015 11:58:04 -0400
Message-ID: <20150528155804.GI6169@csclub.uwaterloo.ca>
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
 <20150527134318.GU27570@hermes.click-hack.org>
 <20150527155732.GX27570@hermes.click-hack.org>
 <2640138.cV33tOjW7h@indiana>
 <20150527235131.GZ27570@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150527235131.GZ27570@hermes.click-hack.org>
Subject: Re: [Xenomai] [PATCH] debian: remove xeno-config from
 libxenomai-dev package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, May 28, 2015 at 01:51:31AM +0200, Gilles Chanteperdrix wrote:
> I warn you, it is like when you have been knowing someone a very
> long time, you have tendency to find unbearable, some defaults that
> would seem very small to people with a shorter contact.
> 
> Anyway, my recriminations against Debian are:
> - the lib/dev/doc package split is really a major PITA when you are
> spending your time writing or compiling code built upon third party
> libraries;

Sure but it saves a lot of disk space and download time for those that
don't need it.

> - the removal of FSF info documentation is a major PITA for the
> workstation of a developer that was used to it;

Is that the stuff due to the non-free FSF documentation license?

> - Debian strives at being simple for the user, but to do so
> implements a lot of distribution-specific software, that has a
> complex design, requires you to learn how it works, and sometime
> even to debug it, because well, complex software inevitably contain
> bugs; I prefer a distribution that may be a little less easy to use,
> but based on tools with a simple design.

I didn't think that was the goal.

> - Debian is supposedly about freedom, but refuses access to its wiki
> to us unlucky people living in countries with state required
> surveillance policies by ISPs and/or censorship by internet servers
> blacklisting who consequently have to use off-shore VPNs to preserve
> their freedom;

I had not heard of that before.

> - the quality of software shipped by Debian depends on the work of
> its maintainer more than on the quality of the upstream package,
> because many Debian packages are patched to the teeth, resulting in:
> . security issues
> . packages with reworked organisation of the configuration, which is
> thus not the same as the documented upstream one;

If some upstreams didn't do such a shitty job they wouldn't have to.

> . linux kernels that oops and that require you to reboot your
> machine from time to time.

OK, never had this happen that I can recall.

> . poor packages quality when they are used by very little number of
> users, because well, no users tests them, and apparently neither the
> maintainer, including in the so-called "Debian stable" distribution

That is a problem in just about any distribution and often even in the
upstream code in that case.

> - Debian stable benefits from the best debugging cycle, so is the
> Debian distribution of choice, except that not all packages are
> debugged equally (see last point), so it is not that stable, but
> there is one thing for sure, the packages versions in Debian stable
> are outdated. This is mostly a problem for desktop software. I do
> not care about running an outdated apache on a server, so long as
> the security team provides security updates, I sure as hell care
> about the version of xorg, libva, mesa, libqt, firefox, ffmpeg, vlc
> or libreoffice I am using though. And no, debian backports and
> deb-multimedia do not contain all the packages I would like, and I
> do not want to use Debian testing or Debian unstable, because I have
> experience of doing so and having the repository containing broken
> packages occasionally, and remaining so for some time, which is too
> bad if you need the said package.

Well good testing and up to date software are pretty much mutually
exclusive.  Mint-DE tries.

> - since we are at it, the way Christian Marillat, the maintainer of
> the repository formerly called "Debian multimedia" was treated;

That could probably have been handled better.

> - the KDE desktop environment does not work so great in Debian, I do
> not know to which of the previous point this is due (not many users,
> too old versions, buggy patches, or maybe all combined, or maybe
> another reason). Unfortunately, this is the desktop I want to use.
> 
> - the systemd debacle

That was probably the biggest mess I have ever seen in Debian.

> - correct me if I am wrong, but a Debian maintainer is not required
> to contact upstream when he applies a patch, this results in Debian
> packages including patches that would never have been accepted
> upstream, and which degrade the package quality. Since a Debian
> maintainer also has his own bug tracking system, he can make things
> things up "behind upstream's back", cutting himself from the review
> of the upstream package, and cutting Debian users from the upstream
> package maintainers. This point happened to Xenomai Debian package.
> What is more, (again, correctly if I am wrong) a Debian maintainer
> is not exactly required to be a developer, so when a Debian user
> sends a patch that supposedly "fixes something", the patch may be
> utter crap and the maintainer not be able to judge, if he decides to
> work in isolation from upstream, the down goes again the package
> quality.

Not required to, but usually does submit upstream.  Of course there are
also cases of upstream being impossible to work with, or in some cases
no longer exists.  There are packages for which Debian has become the
defacto maintainer because the upstream is no longer there.

> I will not provide detailed bug reports, because, well, as I said, I
> no longer care about Debian. Maybe you will find this is FUD, and an
> easy escape. But you asked for it, and again, I do not care. I am
> certainly not going to boot a Debian again, just to give you precise
> details.

I think you have many very valid points.  I am sticking with Debian
because I find it works quite well, and I have not seen any distribution
that is better.

> So, you want to reiterate the previous maintainer mistakes, and
> continue to maintain the Xenomai Debian packaging outside of the
> Xenomai project. See my last point for why this is a bad idea.
> Please, come maintaining Xenomai debian directory, allowing us to
> review your work and discuss the patches proposed by Debian users.
> If you want to make a new release because of a correction in the
> Debian directory, we can arrange something I am sure with a
> maintenance branch, or a git tag.

Putting the package into Debian does not really make sense, because the
kernel in Debian is not xenomai enabled, and the xenomai patch rarely
applies to Debian's kernel source.

Using xenomai pretty much requires a custom kernel.  Using Debian packages
for the rest of the system, and hence being able to build the xenomai
libraries and such as debian packages is very handy.

So I very much like the debian directory in xenomai as it is (although
perhaps I should look into modernizing it and simplifying it if there
is any need for that), but to actually bother putting it into Debian
officially I see no value in.  It did not work very well before.

-- 
Len Sorensen


Date: Thu, 28 May 2015 01:51:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150527235131.GZ27570@hermes.click-hack.org>
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
 <20150527134318.GU27570@hermes.click-hack.org>
 <20150527155732.GX27570@hermes.click-hack.org>
 <2640138.cV33tOjW7h@indiana>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2640138.cV33tOjW7h@indiana>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Wed, May 27, 2015 at 11:27:27PM +0200, Leopold Palomo-Avellaneda wrote:
> El Dimecres, 27 de maig de 2015, a les 17:57:32, Gilles Chanteperdrix va 
> escriure:
> > On Wed, May 27, 2015 at 03:43:18PM +0200, Gilles Chanteperdrix wrote:
> > > On Wed, May 27, 2015 at 01:49:20PM +0200, Philippe Gerum wrote:
> > > > On 05/27/2015 01:09 PM, Henning Schild wrote:
> > > > > On Wed, 27 May 2015 11:21:33 +0200
> > > > > 
> > > > > Philippe Gerum <rpm@xenomai.org> wrote:
> > > > >> You mean this?
> > > > >> 
> > > > >> http://git.xenomai.org/xenomai-3.git/commit/?id=571ec165ad6a22d3f93f6
> > > > >> 197b64eb8edba8fbee4> > > 
> > > > > Ahh. Yes i meant this. The actual conclusion of the discussion to this
> > > > > patch was to revert the change that introduced the problem and not
> > > > > apply my patch. But for me either way is fine.
> > > > 
> > > > Actually, the right approach is to move xeno-config to the base package,
> > > > since it now delivers information about the runtime system as well.
> > > > 
> > > > > I also referred to another change i suggested and am still waiting for
> > > > > feedback:
> > > > > https://xenomai.org/pipermail/xenomai/2015-April/034105.html
> > > > 
> > > > Looks ok. I'll pick that one unless Gilles pulls the break for any
> > > > debian-specific issue.
> > > 
> > > No, that is fine by me. As of 2014, I have stopped being a Debian
> > > user (after being one for 17 years), so, I care less and less about
> > > it, I have reached a point where everything about this distribution
> > > seems over-designed, gets in the way on the desktop of someone who
> > > mainly does software development, and paradoxically lead to bad
> > > quality software.
> > > 
> > > In any case, I am no longer running Debian on my desktop, and
> > > restarting a server to test a Xenomai release is out of the
> > > question, so it would not be easy for me to test Debian packaging.
> > > Since we do not really have a Debian maintainer (and we never did
> > > really have one judging by the work the person that claimed to be
> > > one did), I would be in favor of dropping the ball and removing the
> > > debian directory, unless someone steps up for assuming this role,
> > > but I mean, with a real intention of commitment to the task.
> 
> It's sad to me that a debian user with a long experience like you have 
> abandoned the distro. But I'm sure that you will have a good reasons. Anyway, 
> please, share them and we could try to improve that.

I warn you, it is like when you have been knowing someone a very
long time, you have tendency to find unbearable, some defaults that
would seem very small to people with a shorter contact.

Anyway, my recriminations against Debian are:
- the lib/dev/doc package split is really a major PITA when you are
spending your time writing or compiling code built upon third party
libraries;

- the removal of FSF info documentation is a major PITA for the
workstation of a developer that was used to it;

- Debian strives at being simple for the user, but to do so
implements a lot of distribution-specific software, that has a
complex design, requires you to learn how it works, and sometime
even to debug it, because well, complex software inevitably contain
bugs; I prefer a distribution that may be a little less easy to use,
but based on tools with a simple design.

- Debian is supposedly about freedom, but refuses access to its wiki
to us unlucky people living in countries with state required
surveillance policies by ISPs and/or censorship by internet servers
blacklisting who consequently have to use off-shore VPNs to preserve
their freedom;

- the quality of software shipped by Debian depends on the work of
its maintainer more than on the quality of the upstream package,
because many Debian packages are patched to the teeth, resulting in:
. security issues
. packages with reworked organisation of the configuration, which is
thus not the same as the documented upstream one;
. linux kernels that oops and that require you to reboot your
machine from time to time.
. poor packages quality when they are used by very little number of
users, because well, no users tests them, and apparently neither the
maintainer, including in the so-called "Debian stable" distribution

- Debian stable benefits from the best debugging cycle, so is the
Debian distribution of choice, except that not all packages are
debugged equally (see last point), so it is not that stable, but
there is one thing for sure, the packages versions in Debian stable
are outdated. This is mostly a problem for desktop software. I do
not care about running an outdated apache on a server, so long as
the security team provides security updates, I sure as hell care
about the version of xorg, libva, mesa, libqt, firefox, ffmpeg, vlc
or libreoffice I am using though. And no, debian backports and
deb-multimedia do not contain all the packages I would like, and I
do not want to use Debian testing or Debian unstable, because I have
experience of doing so and having the repository containing broken
packages occasionally, and remaining so for some time, which is too
bad if you need the said package.

- since we are at it, the way Christian Marillat, the maintainer of
the repository formerly called "Debian multimedia" was treated;

- the KDE desktop environment does not work so great in Debian, I do
not know to which of the previous point this is due (not many users,
too old versions, buggy patches, or maybe all combined, or maybe
another reason). Unfortunately, this is the desktop I want to use.

- the systemd debacle

- correct me if I am wrong, but a Debian maintainer is not required
to contact upstream when he applies a patch, this results in Debian
packages including patches that would never have been accepted
upstream, and which degrade the package quality. Since a Debian
maintainer also has his own bug tracking system, he can make things
things up "behind upstream's back", cutting himself from the review
of the upstream package, and cutting Debian users from the upstream
package maintainers. This point happened to Xenomai Debian package.
What is more, (again, correctly if I am wrong) a Debian maintainer
is not exactly required to be a developer, so when a Debian user
sends a patch that supposedly "fixes something", the patch may be
utter crap and the maintainer not be able to judge, if he decides to
work in isolation from upstream, the down goes again the package
quality.

I will not provide detailed bug reports, because, well, as I said, I
no longer care about Debian. Maybe you will find this is FUD, and an
easy escape. But you asked for it, and again, I do not care. I am
certainly not going to boot a Debian again, just to give you precise
details.

> 
> > Just to add something more to the subject: I do not think being the
> > debian maintainer of the Xenomai package is a hard task. I mean come
> > on, it is just basically a Makefile shorter than some other
> > Makefiles in the project. But this requires staying in touch with
> > the Debian project to know what the "good practices" are, what
> > practices have become deprecated and what new debian helper could
> > make the packaging even simpler, things I do not care to do. In any
> > case, this should be a good reason not to botch the task. A botched
> > hard task is easier to understand than a botched easy task.
> 
> Just to inform, because i have been in silence all this thread that some weeks 
> ago (maybe two month) I contacted with the debian maintainer of xenomai. I 
> offered my help because I was interested in maintain the package. We finally 
> will work together, and the debian directory will be hosted in collab-maint 
> git, in alioth, a git server of debian.
> 
> Said that, because time constraints of the last weeks, I'm just in the 
> beginning of review all the packaging of xenomai. I will begin with 2.6.4 and 
> after that, I will jump to 3.0 when you released an official one. So, don't try 
> to find anything there, because I have nothing done. I will try to inform the 
> list about my progress.
> 
> Anyway, the idea is to drop your debian directory and put a new one, trying to 
> use the "good practices" and the updated debhelper tools. I will try to keep 
> the package in a good shape, sync with the upstream last versions, at least in 
> unstable. If I could, some backport (because I used it) could be possible.

So, you want to reiterate the previous maintainer mistakes, and
continue to maintain the Xenomai Debian packaging outside of the
Xenomai project. See my last point for why this is a bad idea.
Please, come maintaining Xenomai debian directory, allowing us to
review your work and discuss the patches proposed by Debian users.
If you want to make a new release because of a correction in the
Debian directory, we can arrange something I am sure with a
maintenance branch, or a git tag.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150528/8b49a348/attachment.sig>

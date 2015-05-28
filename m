Date: Thu, 28 May 2015 19:32:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150528173226.GC27570@hermes.click-hack.org>
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
 <20150527134318.GU27570@hermes.click-hack.org>
 <20150527155732.GX27570@hermes.click-hack.org>
 <2640138.cV33tOjW7h@indiana>
 <20150527235131.GZ27570@hermes.click-hack.org>
 <20150528155804.GI6169@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150528155804.GI6169@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Thu, May 28, 2015 at 11:58:04AM -0400, Lennart Sorensen wrote:
> On Thu, May 28, 2015 at 01:51:31AM +0200, Gilles Chanteperdrix wrote:
> > I warn you, it is like when you have been knowing someone a very
> > long time, you have tendency to find unbearable, some defaults that
> > would seem very small to people with a shorter contact.
> > 
> > Anyway, my recriminations against Debian are:
> > - the lib/dev/doc package split is really a major PITA when you are
> > spending your time writing or compiling code built upon third party
> > libraries;
> 
> Sure but it saves a lot of disk space and download time for those that
> don't need it.

As I said in the next mail, this is ridiculous. First a few headers
and a .pc file do not occupy that much room, I mean come on, people
have tera bytes disks now, and what does a Debian occupy with all
the packages installed 100 GiB ? And second the Debian system is
spending way much more space elsewhere with its package with all
options enabled that get a lot of stuff installed on your system
that you actually do not need. Look at libav dependencies for
instance. libav can be configured to have no external dependencies
and this is generally sufficient for common use like watching
videos. In addition to that, there are packages that you do not need
or want, that will cause apt to uninstall half the distribution if
you remove them, so, you have to keep them, and they are more than
just a few headers and a .pc file.

> 
> > - the removal of FSF info documentation is a major PITA for the
> > workstation of a developer that was used to it;
> 
> Is that the stuff due to the non-free FSF documentation license?

"non-free Free Software Foundation documentation" sounds like a
cheap oxymoron does not it? And does not Debian have a directory
named "non-free" in its repository for this case? From a user-space
experience point of view, this was a frustrating change. That and
the gratuitous move of /usr/doc to /usr/share/doc, but that was a
long time ago.

> > - Debian is supposedly about freedom, but refuses access to its wiki
> > to us unlucky people living in countries with state required
> > surveillance policies by ISPs and/or censorship by internet servers
> > blacklisting who consequently have to use off-shore VPNs to preserve
> > their freedom;
> 
> I had not heard of that before.

Well, I do not seem to have the problem right now, otherwise I would
have sent a screenshot. But I assure you I had it at some point.
Maybe it depends on some static IP range. But the error message made
it clear that your access was denied because you were using an
anonymous VPN service. Maybe the problem was fixed in the mean time.


> 
> > - the quality of software shipped by Debian depends on the work of
> > its maintainer more than on the quality of the upstream package,
> > because many Debian packages are patched to the teeth, resulting in:
> > . security issues
> > . packages with reworked organisation of the configuration, which is
> > thus not the same as the documented upstream one;
> 
> If some upstreams didn't do such a shitty job they wouldn't have to.

I do not find that the Apache httpd project does "a shitty job", but
I find the Debian apache configuration system over-engineered with
its specialized helpers, yet weak on the point of implicit
configuration file order, so shitty in a way. And requires to
acquire knowledge about the package not available in the upstream
documentation.

> 
> > . linux kernels that oops and that require you to reboot your
> > machine from time to time.
> 
> OK, never had this happen that I can recall.

My desktop runs 24/7, maybe that is the reason.

> 
> > . poor packages quality when they are used by very little number of
> > users, because well, no users tests them, and apparently neither the
> > maintainer, including in the so-called "Debian stable" distribution
> 
> That is a problem in just about any distribution and 

I currently use Slackware, and the Slackware base system only
contains very few packages (a Slackware with all packages installed,
yes, this includes the library headers and documentation, occupies 8
GiB of disk space), and I guess none that few people use. The
distribution does not make promises it can't keep.

> often even in the upstream code in that case.

>From my point of view, a Debian package maintainer is responsible
for the Debian package quality. So, if he can not reach that quality
because the upstream code does not have a high enough quality, he
should not package it. Packaging low quality software without fixing
the quality issue is a bad service to the user. Again, a frustrating
experience from the end-user point of view.

> 
> > - Debian stable benefits from the best debugging cycle, so is the
> > Debian distribution of choice, except that not all packages are
> > debugged equally (see last point), so it is not that stable, but
> > there is one thing for sure, the packages versions in Debian stable
> > are outdated. This is mostly a problem for desktop software. I do
> > not care about running an outdated apache on a server, so long as
> > the security team provides security updates, I sure as hell care
> > about the version of xorg, libva, mesa, libqt, firefox, ffmpeg, vlc
> > or libreoffice I am using though. And no, debian backports and
> > deb-multimedia do not contain all the packages I would like, and I
> > do not want to use Debian testing or Debian unstable, because I have
> > experience of doing so and having the repository containing broken
> > packages occasionally, and remaining so for some time, which is too
> > bad if you need the said package.
> 
> Well good testing and up to date software are pretty much mutually
> exclusive.  Mint-DE tries.

For some software (mostly server/infrastructure software) a good
testing matters. And for some other (mostly desktop software and
developer tools like the autotools, toolchain and debugger I forgot
to mention), having the latest version is imperative. By using
debian testing/unstable you give up on the first. By using debian
stable, you give up on the second. The only solution on Debian is to
compile testing packages on stable, but as I explained, even this
only available solution is made uselessly difficult by the control
files requiring newer versions of the libraries that they do not
actually strictly need. Compiling packages yourself is much easier
on other distributions.

> 
> > - since we are at it, the way Christian Marillat, the maintainer of
> > the repository formerly called "Debian multimedia" was treated;
> 
> That could probably have been handled better.
> 
> > - the KDE desktop environment does not work so great in Debian, I do
> > not know to which of the previous point this is due (not many users,
> > too old versions, buggy patches, or maybe all combined, or maybe
> > another reason). Unfortunately, this is the desktop I want to use.
> > 
> > - the systemd debacle
> 
> That was probably the biggest mess I have ever seen in Debian.

I was rather referring to the conclusion of the mess.

> 
> > - correct me if I am wrong, but a Debian maintainer is not required
> > to contact upstream when he applies a patch, this results in Debian
> > packages including patches that would never have been accepted
> > upstream, and which degrade the package quality. Since a Debian
> > maintainer also has his own bug tracking system, he can make things
> > things up "behind upstream's back", cutting himself from the review
> > of the upstream package, and cutting Debian users from the upstream
> > package maintainers. This point happened to Xenomai Debian package.
> > What is more, (again, correctly if I am wrong) a Debian maintainer
> > is not exactly required to be a developer, so when a Debian user
> > sends a patch that supposedly "fixes something", the patch may be
> > utter crap and the maintainer not be able to judge, if he decides to
> > work in isolation from upstream, the down goes again the package
> > quality.
> 
> Not required to, but usually does submit upstream.  Of course there are
> also cases of upstream being impossible to work with, or in some cases
> no longer exists.  There are packages for which Debian has become the
> defacto maintainer because the upstream is no longer there.

I do not think Xenomai was in either of these cases.

> 
> > I will not provide detailed bug reports, because, well, as I said, I
> > no longer care about Debian. Maybe you will find this is FUD, and an
> > easy escape. But you asked for it, and again, I do not care. I am
> > certainly not going to boot a Debian again, just to give you precise
> > details.
> 
> I think you have many very valid points.  I am sticking with Debian
> because I find it works quite well, and I have not seen any distribution
> that is better.

I thought it worked well, and believed like you that problems came
from upstream packages, until I tried another one and found out it
worked better, so, the Debian problems definitely not all come from
the upstream packages.

-- 
					    Gilles.


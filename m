From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 29 May 2015 16:16:18 -0400
Message-ID: <20150529201618.GM6169@csclub.uwaterloo.ca>
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
 <20150527134318.GU27570@hermes.click-hack.org>
 <20150527155732.GX27570@hermes.click-hack.org>
 <2640138.cV33tOjW7h@indiana>
 <20150527235131.GZ27570@hermes.click-hack.org>
 <20150528155804.GI6169@csclub.uwaterloo.ca>
 <20150528173226.GC27570@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150528173226.GC27570@hermes.click-hack.org>
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

On Thu, May 28, 2015 at 07:32:26PM +0200, Gilles Chanteperdrix wrote:
> As I said in the next mail, this is ridiculous. First a few headers
> and a .pc file do not occupy that much room, I mean come on, people
> have tera bytes disks now, and what does a Debian occupy with all
> the packages installed 100 GiB ? And second the Debian system is
> spending way much more space elsewhere with its package with all
> options enabled that get a lot of stuff installed on your system
> that you actually do not need. Look at libav dependencies for
> instance. libav can be configured to have no external dependencies
> and this is generally sufficient for common use like watching
> videos. In addition to that, there are packages that you do not need
> or want, that will cause apt to uninstall half the distribution if
> you remove them, so, you have to keep them, and they are more than
> just a few headers and a .pc file.

We ship Debian on systems with 512MB of flash.  Not everything is a
desktop or a server.  We like how Debian splits things, it is very
convinient.

> "non-free Free Software Foundation documentation" sounds like a
> cheap oxymoron does not it? And does not Debian have a directory
> named "non-free" in its repository for this case? From a user-space
> experience point of view, this was a frustrating change. That and
> the gratuitous move of /usr/doc to /usr/share/doc, but that was a
> long time ago.

That was a long time ago.  And the FSF making such a blunder is odd,
but they did it, not Debian.

> Well, I do not seem to have the problem right now, otherwise I would
> have sent a screenshot. But I assure you I had it at some point.
> Maybe it depends on some static IP range. But the error message made
> it clear that your access was denied because you were using an
> anonymous VPN service. Maybe the problem was fixed in the mean time.

I wonder if they came up with a better way to prevent spammers messing
with the wiki.

> I do not find that the Apache httpd project does "a shitty job", but
> I find the Debian apache configuration system over-engineered with
> its specialized helpers, yet weak on the point of implicit
> configuration file order, so shitty in a way. And requires to
> acquire knowledge about the package not available in the upstream
> documentation.

I think both the apache way and the Debian way are a mess. :)

> My desktop runs 24/7, maybe that is the reason.

Mine do too.

> I currently use Slackware, and the Slackware base system only
> contains very few packages (a Slackware with all packages installed,
> yes, this includes the library headers and documentation, occupies 8
> GiB of disk space), and I guess none that few people use. The
> distribution does not make promises it can't keep.

I can't possible go back to that shitty "packaging" system (if you can
even call it that)..  No way.  I went from there to redhat which was a
huge improvement, and then to Debian which was another huge improvement.

And last I checked it looked like slackware had been dead for a couple
of years, which would make it even more stale than Debian stable.

> > often even in the upstream code in that case.
> 
> From my point of view, a Debian package maintainer is responsible
> for the Debian package quality. So, if he can not reach that quality
> because the upstream code does not have a high enough quality, he
> should not package it. Packaging low quality software without fixing
> the quality issue is a bad service to the user. Again, a frustrating
> experience from the end-user point of view.

Well if people want the code even in the state it is in, it can be
packaged.  Perhaps Ubuntu's concept of having core packages, and then
optional repositories of lower quality software makes sense there.

> For some software (mostly server/infrastructure software) a good
> testing matters. And for some other (mostly desktop software and
> developer tools like the autotools, toolchain and debugger I forgot
> to mention), having the latest version is imperative. By using
> debian testing/unstable you give up on the first. By using debian
> stable, you give up on the second. The only solution on Debian is to
> compile testing packages on stable, but as I explained, even this
> only available solution is made uselessly difficult by the control
> files requiring newer versions of the libraries that they do not
> actually strictly need. Compiling packages yourself is much easier
> on other distributions.

That's a matter of ones preference.  I find building debian packages
fairly simply.  Redhat is complicated.  Some distributions I guess you
just build from source and throw it in and it's your problem to get the
things that work together right.  Some consider that easier.

> I was rather referring to the conclusion of the mess.

The conclussion and the entire progress towards it.  I am not convinced
it is even over yet.

> > Not required to, but usually does submit upstream.  Of course there are
> > also cases of upstream being impossible to work with, or in some cases
> > no longer exists.  There are packages for which Debian has become the
> > defacto maintainer because the upstream is no longer there.
> 
> I do not think Xenomai was in either of these cases.

I entirely agree. :)

> I thought it worked well, and believed like you that problems came
> from upstream packages, until I tried another one and found out it
> worked better, so, the Debian problems definitely not all come from
> the upstream packages.

Well I know slackware, and I can't think of anything it does well,
so unless you have some other distribution suggestions to look at,
I am stuck with Debian.  Oh well.

-- 
Len Sorensen


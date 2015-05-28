Date: Thu, 28 May 2015 15:01:53 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20150528150153.0ceb9539@md1em3qc>
In-Reply-To: <20150527235131.GZ27570@hermes.click-hack.org>
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
 <20150527134318.GU27570@hermes.click-hack.org>
 <20150527155732.GX27570@hermes.click-hack.org>
 <2640138.cV33tOjW7h@indiana>
 <20150527235131.GZ27570@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, 28 May 2015 01:51:31 +0200
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> > Just to inform, because i have been in silence all this thread that
> > some weeks ago (maybe two month) I contacted with the debian
> > maintainer of xenomai. I offered my help because I was interested
> > in maintain the package. We finally will work together, and the
> > debian directory will be hosted in collab-maint git, in alioth, a
> > git server of debian.
> > 
> > Said that, because time constraints of the last weeks, I'm just in
> > the beginning of review all the packaging of xenomai. I will begin
> > with 2.6.4 and after that, I will jump to 3.0 when you released an
> > official one. So, don't try to find anything there, because I have
> > nothing done. I will try to inform the list about my progress.
> > 
> > Anyway, the idea is to drop your debian directory and put a new
> > one, trying to use the "good practices" and the updated debhelper
> > tools. I will try to keep the package in a good shape, sync with
> > the upstream last versions, at least in unstable. If I could, some
> > backport (because I used it) could be possible.
> 
> So, you want to reiterate the previous maintainer mistakes, and
> continue to maintain the Xenomai Debian packaging outside of the
> Xenomai project. See my last point for why this is a bad idea.
> Please, come maintaining Xenomai debian directory, allowing us to
> review your work and discuss the patches proposed by Debian users.
> If you want to make a new release because of a correction in the
> Debian directory, we can arrange something I am sure with a
> maintenance branch, or a git tag.

It should stay in the tree, especially when using it against git and
not releases. So additional to the already mentioned problems we would
have to match two repos with submodules or whatever. Send patches to
two communities .. no thanks.
Several people said that they use it and want to keep it. And Leopold
offered to maintain it. I hope that offer stands also if the directory
stays in the xenomai tree. If so i think the problem is solved and we
can all continue this thread with a nice distro war ;).

Henning 



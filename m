Date: Wed, 27 May 2015 17:57:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150527155732.GX27570@hermes.click-hack.org>
References: <d0dc8c289d0b45fafbb6b39b839b468bd53f256f.1430395105.git.henning.schild@siemens.com>
 <20150527111126.2f03fa66@md1em3qc> <55658C9D.8020406@xenomai.org>
 <20150527130931.27f37fcb@md1em3qc> <5565AF40.3070502@xenomai.org>
 <20150527134318.GU27570@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150527134318.GU27570@hermes.click-hack.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, May 27, 2015 at 03:43:18PM +0200, Gilles Chanteperdrix wrote:
> On Wed, May 27, 2015 at 01:49:20PM +0200, Philippe Gerum wrote:
> > On 05/27/2015 01:09 PM, Henning Schild wrote:
> > > On Wed, 27 May 2015 11:21:33 +0200
> > > Philippe Gerum <rpm@xenomai.org> wrote:
> > >  
> > >> You mean this?
> > >>
> > >> http://git.xenomai.org/xenomai-3.git/commit/?id=571ec165ad6a22d3f93f6197b64eb8edba8fbee4
> > > 
> > > Ahh. Yes i meant this. The actual conclusion of the discussion to this
> > > patch was to revert the change that introduced the problem and not
> > > apply my patch. But for me either way is fine.
> > > 
> > 
> > Actually, the right approach is to move xeno-config to the base package,
> > since it now delivers information about the runtime system as well.
> > 
> > > I also referred to another change i suggested and am still waiting for
> > > feedback:
> > > https://xenomai.org/pipermail/xenomai/2015-April/034105.html
> > > 
> > 
> > Looks ok. I'll pick that one unless Gilles pulls the break for any
> > debian-specific issue.
> 
> No, that is fine by me. As of 2014, I have stopped being a Debian
> user (after being one for 17 years), so, I care less and less about
> it, I have reached a point where everything about this distribution
> seems over-designed, gets in the way on the desktop of someone who
> mainly does software development, and paradoxically lead to bad
> quality software. 
> 
> In any case, I am no longer running Debian on my desktop, and
> restarting a server to test a Xenomai release is out of the
> question, so it would not be easy for me to test Debian packaging.
> Since we do not really have a Debian maintainer (and we never did
> really have one judging by the work the person that claimed to be
> one did), I would be in favor of dropping the ball and removing the
> debian directory, unless someone steps up for assuming this role,
> but I mean, with a real intention of commitment to the task.

Just to add something more to the subject: I do not think being the
debian maintainer of the Xenomai package is a hard task. I mean come
on, it is just basically a Makefile shorter than some other
Makefiles in the project. But this requires staying in touch with
the Debian project to know what the "good practices" are, what
practices have become deprecated and what new debian helper could
make the packaging even simpler, things I do not care to do. In any
case, this should be a good reason not to botch the task. A botched
hard task is easier to understand than a botched easy task.

-- 
					    Gilles.


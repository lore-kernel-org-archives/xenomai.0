From: "Leopold Palomo-Avellaneda" <leo@alaxarxa.net>
Date: Mon, 22 Apr 2013 16:54:09 +0200
References: <201304191346.38739.leo@alaxarxa.net>
	<201304220918.35684.leo@alaxarxa.net>
	<5175220E.4090201@xenomai.org>
In-Reply-To: <5175220E.4090201@xenomai.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201304221654.10077.leo@alaxarxa.net>
Subject: Re: [Xenomai] Default options in the debian package
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>

A Dilluns, 22 d'abril de 2013, Gilles Chanteperdrix va escriure:
> On 04/22/2013 09:18 AM, Leopold Palomo-Avellaneda wrote:
> 
> > A Divendres, 19 d'abril de 2013, Gilles Chanteperdrix va escriure:
> >> On 04/19/2013 01:46 PM, Leopold Palomo-Avellaneda wrote:
> >>
> >>> [1] 
> >>> http://lists.mech.kuleuven.be/pipermail/orocos-users/2013-
> > April/006986.html
> >>
> >>
> >> Hi,
> >>
> >> that link does not tell us why you need this option. And that would be
> >> the most important information.
> > 
> > :-)
> > 
> > you are right. I have pointed vague information about that. The complete 
> > thread commented that some people are getting errors using orocos with 
> > xenomai. Orocos use intensively the plugin architecture. As you can see in 
> > this thread:
> > 
> > http://www.orocos.org/forum/orocos/orocos-users/problem-orocos-under-
xenomai
> > 
> > some user point that the solution to load the plugin is to activate this 
> > option in xenomai libs.
> > 
> >> If what you need to disable is TLS, then configuring xenomai with
> >> --without-__thread is sufficient
> >>
> >> If what you need is to avoid the main thread shadowing, we are not going
> >> to configure xenomai with --enable-dlopen-skins as it breaks otherwise
> >> conformant applications, but we can add an environment variable like
> >> XENO_PTHREAD_NO_AUTO_SHADOW to allow supporting both situations.
> >>
> > 
> > I don't know if this is a solution, it overpass my knowledge. I would like 
to 
> > put the detail that, under my subjective point of view, without numerical 
> > data, the orocos users (and cnc users) are the main users of the debian 
> > package. If, we activate that option and we solve this issue, no package 
> > recompilation are needed, that's all. 
> > 
> > I don't know the deep repercussion of that decision. Jan Kiszka said in 
> > another mail:
> > 
> >> default is a micro-performance degradation (likely not an issue) and the 
> > lacking auto-shadowing of the main thread when using POSIX skins
> > 
> > You are the main developers, your decisions are the most important, but I 
> > think that a lot of people activate that, at least the users that use that 
> > debian package.
> 
> 
> The problem is that if we do not shadow the main thread, we break
> programs that used to work, and also break programs for reasons which
> are hard to understand for a new-comer. Hence the question, would not
> --without__thread be sufficient for Orocos? Only an Orocos user has the
> answer to this question.
> 

I don't know. Orocos use intensively the plugins architecture so I don't know 
if this could solve it. But, as another person in the list has pointed, if you 
would like to use the Python modules you need it too.

I have asked to the Orocos main developer and I would try to test it,

Regards,

Leo


-- 
--
Linux User 152692
Catalonia


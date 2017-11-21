From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
Date: Tue, 21 Nov 2017 19:27:56 +0000
Message-ID: <f7ad8163bda5484292ccdf6e8cf1a484@P10-EX02.3DSystems.Internal>
References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
In-Reply-To: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi Philippe,

Is there an online bug tracking and feature request database? This would be=
 a useful way to distribute work and to sync up contributors. I think the k=
ernel uses Bugzilla, and Ubuntu has Launchpad. No doubt there are many othe=
rs.

I'd like to contribute in some way. I've been having a lot of fun as a Xeno=
mai user.

Regards,
Kendall


-----Original Message-----
From: Xenomai [mailto:xenomai-bounces@xenomai.org] On Behalf Of Philippe Ge=
rum
Sent: Tuesday, November 21, 2017 9:12 AM
To: Xenomai@xenomai.org
Subject: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room


As the GIT commit history shows, there has been no sustained effort in main=
taining several of the Xenomai I/O frameworks for several months (e.g. RTne=
t, analogy), even years in some cases, despite obvious bugs are still haunt=
ing the code base according to the mailing list. The situation has reached =
a point where I see no alternative to dropping them if the situation does n=
ot improve, because there is absolutely no point in this project shipping b=
it rot software that won't ever be fixed.

Unfortunately, this is only the tip of the iceberg. Let's face it, since Gi=
lles passed away last year, I have not been scaling to the Xenomai maintena=
nce, development and documentation tasks, with the requirement of running m=
y business in parallel.

The solution to this serious problem is fitting the project to the availabl=
e resources by narrowing its goal, or conversely, by growing the pool of co=
ntributors.

In addition, we can rework the most tricky part of the implementation to ma=
ke it simpler to maintain, better documented, drastically lowering the barr=
ier on entry for new contributors, which is what I've been working on for a=
 year with the 4th generation of the interrupt pipeline.
Progress on this front has been significant already, but once again limited=
 by the time I have been able to devote to this development so far.

For the past 16 years, this project has lived on various types of contribut=
ions from only a few committed people and companies. At this chance, let's =
mention that people who have been deploying Xenomai in industrial applicati=
ons owe a lot to Wolfgang Denk from Denx Engineering, Siemens's Jan Kiszka =
and Jorge Ramirez, who have supported the project in crucial ways directly =
or indirectly over the years, and still do.

Xenomai as a dual kernel technology showcase has been quietly delivering on=
 the promise of real-time Linux for more than a decade now, with marketing =
tools limited to showing decent code quality, good and reliable performance=
 figures. As a result, to my current knowledge, Xenomai is present in a bro=
ad range of applications and systems:
magnetic resonance scanners, 2D/3D printers, navigation & positioning, comm=
unication equipment, autonomous vehicles, control & automation systems in v=
arious plants.

On the sad side of the story, this project has virtually become a one-man s=
how the day Gilles - my long-time friend and hacking soul mate
- left us. That show is too big for me to run it alone, which entails
maintaining:

- the interrupt pipeline for 7 CPU architectures
- the Cobalt co-kernel
- 4 APIs, plus the "copperplate" mediating layer
- several real-time I/O frameworks, including CAN, RTnet, Analogy, SPI, GPI=
O
- the documentation (which is currently unfriendly to newcomers, and stalle=
d two years ago or so)
- the website
- the testing and release processes

So, let's talk about the elephant in the room: the current situation of the=
 Xenomai project is not viable in the long run. I can only encourage people=
 who feel concerned about it to discuss openly the practical steps to best =
address this challenge.

Thanks,

--
Philippe.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai


References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <8c1ebbb8-2513-275c-ba27-a5c42c856d11@numalliance.com>
Date: Fri, 1 Dec 2017 10:59:36 +0100
MIME-Version: 1.0
In-Reply-To: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [RFC] RTnet, Analogy and the elephant in the room
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

This may be offtopic regarding xenomai itself.

But, I am a member of the kde community, which is very active.Recently,=20
they made some proposals to improve onboarding of new contributors.

I think there are some very good ideas that can apply here, here is the=20
link.

https://phabricator.kde.org/T7116

Regards,

S.Ancelot


Le 21/11/2017 =C3=A0 18:11, Philippe Gerum a =C3=A9crit=C2=A0:
> As the GIT commit history shows, there has been no sustained effort in
> maintaining several of the Xenomai I/O frameworks for several months
> (e.g. RTnet, analogy), even years in some cases, despite obvious bugs
> are still haunting the code base according to the mailing list. The
> situation has reached a point where I see no alternative to dropping
> them if the situation does not improve, because there is absolutely no
> point in this project shipping bit rot software that won't ever be fixe=
d.
>
> Unfortunately, this is only the tip of the iceberg. Let's face it, sinc=
e
> Gilles passed away last year, I have not been scaling to the Xenomai
> maintenance, development and documentation tasks, with the requirement
> of running my business in parallel.
>
> The solution to this serious problem is fitting the project to the
> available resources by narrowing its goal, or conversely, by growing th=
e
> pool of contributors.
>
> In addition, we can rework the most tricky part of the implementation t=
o
> make it simpler to maintain, better documented, drastically lowering th=
e
> barrier on entry for new contributors, which is what I've been working
> on for a year with the 4th generation of the interrupt pipeline.
> Progress on this front has been significant already, but once again
> limited by the time I have been able to devote to this development so f=
ar.
>
> For the past 16 years, this project has lived on various types of
> contributions from only a few committed people and companies. At this
> chance, let's mention that people who have been deploying Xenomai in
> industrial applications owe a lot to Wolfgang Denk from Denx
> Engineering, Siemens's Jan Kiszka and Jorge Ramirez, who have supported
> the project in crucial ways directly or indirectly over the years, and
> still do.
>
> Xenomai as a dual kernel technology showcase has been quietly deliverin=
g
> on the promise of real-time Linux for more than a decade now, with
> marketing tools limited to showing decent code quality, good and
> reliable performance figures. As a result, to my current knowledge,
> Xenomai is present in a broad range of applications and systems:
> magnetic resonance scanners, 2D/3D printers, navigation & positioning,
> communication equipment, autonomous vehicles, control & automation
> systems in various plants.
>
> On the sad side of the story, this project has virtually become a
> one-man show the day Gilles - my long-time friend and hacking soul mate
> - left us. That show is too big for me to run it alone, which entails
> maintaining:
>
> - the interrupt pipeline for 7 CPU architectures
> - the Cobalt co-kernel
> - 4 APIs, plus the "copperplate" mediating layer
> - several real-time I/O frameworks, including CAN, RTnet, Analogy, SPI,=
 GPIO
> - the documentation (which is currently unfriendly to newcomers, and
> stalled two years ago or so)
> - the website
> - the testing and release processes
>
> So, let's talk about the elephant in the room: the current situation of
> the Xenomai project is not viable in the long run. I can only encourage
> people who feel concerned about it to discuss openly the practical step=
s
> to best address this challenge.
>
> Thanks,
>



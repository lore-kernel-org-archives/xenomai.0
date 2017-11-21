MIME-Version: 1.0
In-Reply-To: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
References: <abf31608-ffa8-17e0-e3eb-4d62f067e365@xenomai.org>
From: Greg Gallagher <ggallagher31@gmail.com>
Date: Tue, 21 Nov 2017 12:26:54 -0500
Message-ID: <CAPYpnLYwNtg3LtWL1Fi__b0X=tcxat69a3qzkGt3KxNb2=vOaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,
   I've been using Xenomai for a couple of years now and having been
preparing my first patch.
I'd love to help any way that is needed.  Documentation may be a good place
for me to start.  I'd also
be more than happy to help maintain some of the I/O frameworks.  I would
probably need a mentor
for guidance at the beginning.

Thanks

On Tue, Nov 21, 2017 at 12:11 PM, Philippe Gerum <rpm@xenomai.org> wrote:

>
> As the GIT commit history shows, there has been no sustained effort in
> maintaining several of the Xenomai I/O frameworks for several months
> (e.g. RTnet, analogy), even years in some cases, despite obvious bugs
> are still haunting the code base according to the mailing list. The
> situation has reached a point where I see no alternative to dropping
> them if the situation does not improve, because there is absolutely no
> point in this project shipping bit rot software that won't ever be fixed.
>
> Unfortunately, this is only the tip of the iceberg. Let's face it, since
> Gilles passed away last year, I have not been scaling to the Xenomai
> maintenance, development and documentation tasks, with the requirement
> of running my business in parallel.
>
> The solution to this serious problem is fitting the project to the
> available resources by narrowing its goal, or conversely, by growing the
> pool of contributors.
>
> In addition, we can rework the most tricky part of the implementation to
> make it simpler to maintain, better documented, drastically lowering the
> barrier on entry for new contributors, which is what I've been working
> on for a year with the 4th generation of the interrupt pipeline.
> Progress on this front has been significant already, but once again
> limited by the time I have been able to devote to this development so far.
>
> For the past 16 years, this project has lived on various types of
> contributions from only a few committed people and companies. At this
> chance, let's mention that people who have been deploying Xenomai in
> industrial applications owe a lot to Wolfgang Denk from Denx
> Engineering, Siemens's Jan Kiszka and Jorge Ramirez, who have supported
> the project in crucial ways directly or indirectly over the years, and
> still do.
>
> Xenomai as a dual kernel technology showcase has been quietly delivering
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
> - several real-time I/O frameworks, including CAN, RTnet, Analogy, SPI,
> GPIO
> - the documentation (which is currently unfriendly to newcomers, and
> stalled two years ago or so)
> - the website
> - the testing and release processes
>
> So, let's talk about the elephant in the room: the current situation of
> the Xenomai project is not viable in the long run. I can only encourage
> people who feel concerned about it to discuss openly the practical steps
> to best address this challenge.
>
> Thanks,
>
> --
> Philippe.
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>

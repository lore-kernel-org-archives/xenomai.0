MIME-Version: 1.0
References: <CAB9YM8jh8oB9JR8+08CPtaQ8e8ViEqKS2gvgeNgXpdU7coBzug@mail.gmail.com>
 <CAFc1U0sj6MXuD=ACKDWcbbPamrHjPG6f+RW4KLAn9TG=Sibw6Q@mail.gmail.com>
In-Reply-To: <CAFc1U0sj6MXuD=ACKDWcbbPamrHjPG6f+RW4KLAn9TG=Sibw6Q@mail.gmail.com>
From: Rui Queiroz <rqueiroz@dei.uc.pt>
Date: Thu, 1 Jul 2021 17:41:50 +0100
Message-ID: <CAB9YM8iMyYHjEQkca3qUwYnKjvHnxtOujcYQ8Mg=k38KCC7fug@mail.gmail.com>
Subject: Re: cyclictest + cobalt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai <xenomai@xenomai.org>

When you say

> The Xenomai version is based on rt-tests 0.92 (current version is 2.1).

Do you mean that there is an embedded cyclictest?

I could not find any trace of cyclictest. I had to install it using apt and
the rt-tests package.

I see a huge difference when executing cyclictest after booting with the
xenomai kernel vs the vanilla but how can I be sure that it is using cobalt=
?



Pierre FICHEUX via Xenomai <xenomai@xenomai.org> escreveu no dia quinta,
1/07/2021 =C3=A0(s) 17:20:

> AFAIK cyclictest uses the POSIX skin.
>
> The Xenomai version is based on rt-tests 0.92 (current version is 2.1).
>
> I do prefer using "latency" for Xenomai.
>
> Regards
>
>
> Le jeu. 1 juil. 2021 =C3=A0 16:24, Rui Queiroz via Xenomai <xenomai@xenom=
ai.org
> >
> a =C3=A9crit :
>
> > Hi,
> >
> > I have no experience with Xenomai and I was wondering if someone could
> > clarify if cyclictest is included in Xenomai 3.1?
> > Here [1] says "cyclictest is part of the Xenomai test suite..." but I
> could
> > not confirm it.
> >
> > If I simply install the rt-tests package and run cyclictest will it tak=
e
> > advantage of the cobalt "kernel" by default or do I need to preform som=
e
> > extra steps (activate a posix skin etc)
> >
> > Thank you
> >
> >
> > [1] http://manpages.ubuntu.com/manpages/groovy/en/man1/cyclictest.1.htm=
l
> >
>
>
> --
>
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
>                              http://www.smile.fr
>                              https://smile.eu/fr/offres/embarque-iot
> I would love to change the world, but they won't give me the source code
>

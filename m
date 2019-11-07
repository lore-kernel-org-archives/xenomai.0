MIME-Version: 1.0
References: <CAFc1U0spXP+BXnLFspsBmOo9opGcFRUwDVoivLMvxJiBMwY_mA@mail.gmail.com>
 <44a798wn8y.fsf@be-well.ilk.org>
In-Reply-To: <44a798wn8y.fsf@be-well.ilk.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Thu, 7 Nov 2019 06:47:42 +0100
Message-ID: <CAFc1U0voys1h1Rn09Dn57qXqyfYNiUhAOmmEqCZKNHeELdfHww@mail.gmail.com>
Subject: Re: rt_task_inquire() equivalent for POSIX ?
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
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: Pierre FICHEUX via Xenomai <xenomai@xenomai.org>

I've tried it but got the pid of the "main" thread not the RT one (that's
normal...).

regards

Le jeu. 7 nov. 2019 =C3=A0 01:20, Lowell Gilbert <kludge@be-well.ilk.org> a
=C3=A9crit :

> Pierre FICHEUX via Xenomai <xenomai@xenomai.org> writes:
>
> > Is there a way to get the Xenomai thread "pid" with POSIX API ? I didn'=
t
> > see anything in the "thread management" section.
>
> getpid()?
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code

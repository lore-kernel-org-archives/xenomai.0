MIME-Version: 1.0
References: <CAFc1U0spXP+BXnLFspsBmOo9opGcFRUwDVoivLMvxJiBMwY_mA@mail.gmail.com>
 <44a798wn8y.fsf@be-well.ilk.org>
 <CAFc1U0voys1h1Rn09Dn57qXqyfYNiUhAOmmEqCZKNHeELdfHww@mail.gmail.com>
 <148f7f7281a9350172cbd5895a223c500582f36d.camel@sprinte.eu>
 <956fff32-9301-4b91-14b7-b2583f12508c@xenomai.org>
In-Reply-To: <956fff32-9301-4b91-14b7-b2583f12508c@xenomai.org>
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Thu, 7 Nov 2019 10:03:52 +0100
Message-ID: <CAFc1U0trRygoKsURWkN1VeVVqh=XGwGp-CBXZmYfcnp8480P+g@mail.gmail.com>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Julien Blanc <julien.blanc@sprinte.eu>, Pierre FICHEUX via Xenomai <xenomai@xenomai.org>

Thx a lot, works fine with cobalt_thread_pid() !

regards



Le jeu. 7 nov. 2019 =C3=A0 09:44, Philippe Gerum <rpm@xenomai.org> a =C3=A9=
crit :

> On 2019-11-07 08:56, Julien Blanc via Xenomai wrote:
> > Le jeudi 07 novembre 2019 =C3=A0 06:47 +0100, Pierre FICHEUX via Xenoma=
i a
> > =C3=A9crit :
> >> I've tried it but got the pid of the "main" thread not the RT one
> >> (that's
> >> normal...).
> >>
> >
> > extern "C"
> > {
> >         int cobalt_thread_pid(pthread_t);
> > }
> >
> > int tid =3D cobalt_thread_pid(pthread_self())
> >
> > but i=E2=80=99m not sure what you mean by the cobalt thread id vs posix=
 thread
> > id. IIRC they have the same value (ie, syscal(__NR_gettid) would give
> > the same value (for rt threads), maybe at the expense of a mode
> > switch).
>
> This may be worth a read for context:
> http://man7.org/linux/man-pages/man2/gettid.2.html
>
> cobalt_thread_pid() translates POSIX thread identifiers to kernel thread
> identifiers some Linux-specific calls need (e.g. thread-directed signals)=
.
>
> --
> Philippe.
>


--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code

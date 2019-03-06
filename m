From: Richard Weinberger <richard@nod.at>
Subject: Re: Mixing cobalt and alchemy?
Date: Wed, 06 Mar 2019 21:20:17 +0100
Message-ID: <1763748.uoOIHctIBT@blindfold>
In-Reply-To: <bd50d09d-fe52-a7c5-c733-4d8ad50030bf@siemens.com>
References: <CAFLxGvxXBx+7UWD0aySskKxbrZHjvTBmJNvCEdfoBgLQOACHcw@mail.gmail.com>
 <bd50d09d-fe52-a7c5-c733-4d8ad50030bf@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Am Mittwoch, 6. M=E4rz 2019, 18:25:56 CET schrieb Jan Kiszka:
> On 06.03.19 10:59, Richard Weinberger via Xenomai wrote:
> > Hi!
> >=20
> > I have a Xenomai 2.6 application which makes heavy usage of
> > rt_dev_ioctl() and shadow threads
> > with rt_task_shadow().
> >=20
> > If I understand the new Xenomai 3 API correctly, rt_dev_ioctl() for
> > userspace is gone and the cobalt wrappers should be used such that
> > plain ioctl() calls will be routed through libcobalt.
> > What I don't fully understand is how to mix these with the alchemy
> > skin such that the application can use rt_task_shadow() and friends
> > because the cobalt wrapper also wraps pthread_create().
> > The application simply does not fully fit in either cobalt nor alchemy =
skins.
> >=20
> > Is it legal to modify lib/cobalt/cobalt.wrappers to wrap only read/clos=
e/ioctl?
> > Or can I directly issue cobalt syscalls from the application?
> >=20
>=20
> You can do __RT(ioctl(...)), that's also what the transition kit (trank) =
does to=20
> provide rt_dev_ioctl.

Good to know!
Then I'll use alchemy and the __RT() wrappers.

Thanks,
//richard




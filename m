Date: Thu, 8 Dec 2016 08:42:39 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20161208084239.3f0c064b@md1em3qc>
In-Reply-To: <340fed26-23db-86a4-faf5-4e58c15504cd@numalliance.com>
References: <50ba3868-6953-faef-5ad5-a650c0c0ea24@numalliance.com>
 <e1c90d44-be0d-91a7-98d4-e06ee0007ab1@xenomai.org>
 <340fed26-23db-86a4-faf5-4e58c15504cd@numalliance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] memory allocation performance in kernel ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U3TDqXBoYW5l?= Ancelot <sancelot@numalliance.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Am Thu, 8 Dec 2016 08:28:02 +0100
schrieb St=C3=A9phane Ancelot <sancelot@numalliance.com>:

> Le 07/12/2016 =C3=A0 17:16, Philippe Gerum a =C3=A9crit :
> > On 12/07/2016 03:15 PM, St=C3=A9phane Ancelot wrote: =20
> >> Hi,
> >>
> >> I noticed very bad memory allocation performance on some of my
> >> graphic programs (standard linux applications).
> >>
> >> If you run any classic program, you won't sea any difference, but
> >> it has been visible in the following context :
> >>
> >> I have an application that allocates thousends of graphic widgets,
> >> label, input fields  at startup (a data editor) .
> >>
> >> Using the standard kernel, the applications starts very quickly.
> >> But once the ipipe patch is applied to kernel, this application
> >> makes lot of seconds before appearing.
> >>
> >> I am using a 3.18 kernel.
> >> =20
> > Is there any question?
> > =20
> Euhhh ... yes,  it sounds this problem comes from ipipe
> modifications, But I have not managed to find the reason ???
> Is it a bug , a regression , a kernel routine where the problem is=20
> amplified once the patch is applied ?
>=20
> I remember I have not had this problem with previous kernel releases=20
> (3.16.x) . I will check again with previous configurations, in order
> to find a way of comparison.

You can also try 4.1. And more information could be useful. Which
version of xenomai are you using? Is your application using xenomai?
Which architecture are you on?

> Regards,
> S.Ancelot
>=20
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai



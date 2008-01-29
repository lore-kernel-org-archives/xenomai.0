Message-ID: <479F2F46.70108@domain.hid>
Date: Tue, 29 Jan 2008 14:51:02 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <479F2825.4000405@domain.hid> <479F2D33.2050209@domain.hid>
In-Reply-To: <479F2D33.2050209@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] bug in xnintr_irq_proc()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Wolfgang Grandegger wrote:
>> Hello,
>>
>> attached is a fix for a nice bug in xnintr_irq_proc() of Xenomai v2.3.x.
>=20
> Mmf... Thanks.
>=20
>> Check for tabs. I have not checked if it's present in recent versions as
>> well.
>=20
> Even if a bit overkill, I would even go for something like
> p +=3D sprintf(p, "...
> just to be sure we won't get hit again.

Yes, and replacing the tabs with "\t" in case we need them. They seem to
be gone in the trunk.

> (or even snprintf() for the parano=EFds among us).

Definitely, especially because the name field of xnintr_t is a pointer.

Wolfgang.


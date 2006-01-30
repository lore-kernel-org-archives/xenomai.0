Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] broken docs
Date: Mon, 30 Jan 2006 11:55:06 +0100
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0210CE1@domain.hid>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Dear Xenomai workers,

Would it be possible to have an updated API documentation for Xenomai =
2.0.x ? (I mean with formal parameters in function prototypes)

I tried to regenerate it with make generate-doc, but it seems that a SVN =
working dir is required.

It would be great.

Thanks a lot

Daniel

> -----Message d'origine-----
> De=A0: xenomai-core-bounces@domain.hid =
[mailto:xenomai-core-bounces@domain.hid] De
> la part de Jan Kiszka
> Envoy=E9=A0: mercredi, 18. janvier 2006 20:03
> =C0=A0: xenomai-core
> Objet=A0: [Xenomai-core] broken docs
>=20
> Hi,
>=20
> I noticed that the doxygen API output is partly broken. Under the
> nucleus and native skin modules most functions became variables. I
> haven't looked at the source yet, but I guess it should be resolvable,
> especially as the RTDM docs are fine. This mail is to file the issue,
> maybe I will have a look later - /maybe/.
>=20
> Moreover, I was lacking a reference to RT_MUTEX_INFO. Does this
> structure just needs to be added to the correct doxygen group? I guess
> there are other undocumented structures out there as well =
(RT_TASK_INFO,
> ...?).
>=20
> Jan



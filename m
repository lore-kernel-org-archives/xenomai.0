Date: Thu, 19 Feb 2015 14:46:49 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <1336047408.26809.1424353609735.JavaMail.zimbra@wandercraft.eu>
In-Reply-To: <CANWkrRN54ohRTAuyfySuc_hqZWB=cA277imt8uAQhfR5bVr5ig@mail.gmail.com>
References: <CANWkrRN54ohRTAuyfySuc_hqZWB=cA277imt8uAQhfR5bVr5ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Compiling issue Xenomai 3.0 rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>
Cc: xenomai@xenomai.org



----- Mail original -----
> De: "Michael Smith" <2michael.smith@gmail.com>
> =C3=80: xenomai@xenomai.org
> Envoy=C3=A9: Jeudi 19 F=C3=A9vrier 2015 14:40:35
> Objet: [Xenomai] Compiling issue Xenomai 3.0 rc3

> Hi. I'm having trouble compiling the newest release (Xenomai 3.0-rc3).
> With the error
>=20
> autotune.c: In function =E2=80=98main=E2=80=99:
> autotune.c:298:16: error: ignoring return value of =E2=80=98daemon=E2=80=
=99, declared with
> attribute warn_unused_result [-Werror=3Dunused-result]
>          daemon(0, 0);

See:=20
https://xenomai.org/pipermail/xenomai/2014-December/032690.html

>=20
> Is there an way to override the -Werror flags so it doesn't break on
> warnings without editing the make files?
> Or is the policy on Xenomai to always compile cleanly without warnings.
> Is this maybe my compilation method, but then again I did compile Xenomai
> 3.0-rc2 without an issue.
> But I assume when a release is done it does compile cleanly.
>=20
> Thanks
> Michael
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

--=20
Huy Cong
Wandercraft SAS


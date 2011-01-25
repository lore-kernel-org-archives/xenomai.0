Message-ID: <4D3ECF9E.5040308@domain.hid>
Date: Tue, 25 Jan 2011 14:26:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <14122707.101295961457625.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <14122707.101295961457625.JavaMail.SYSTEM@PC-MRINALDI>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel Rinaldi <automation.03@domain.hid>
Cc: xenomai@xenomai.org

Michel Rinaldi wrote:
> ----- Messaggio originale -----=20
> Da: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>=20
> A: "Michel Rinaldi" <automation.03@domain.hid>=20
> Cc: xenomai@xenomai.org
> Inviato: Luned=C3=AC, 24 gennaio 2011 17:54:51 GMT +01:00 Amsterdam/Ber=
lino/Berna/Roma/Stoccolma/Vienna=20
> Oggetto: Re: [Xenomai-help] Problems with rt_task_create and rt_task_jo=
in=20
>=20
>=20
>> Ok. Sorry, the rt_sem_p is actually waiting for the semaphore. So, for=
=20
>> it to take a long time, the kernel module would have to post it all th=
e=20
>> time. In the kernel module, you should check rtdm_task_wait_period=20
>> return value.=20
>>
>> Anyway, what I said still stands: if we suspect the application of bei=
ng=20
>> the culprit, we should try and run a system without this application=20
>> first. That is, only latency and some non real-time load.=20
>=20
> I run a latency test for about 2 hours, in concomitance with two=20
> dd if=3D/dev/zero of=3D/dev/null=20
> commands and some sporadic ssh big file transfers. Last row in test out=
put was:=20
>=20
> RTD| 6.546| 7.191| 10.346| 0| 0| 1.101| 29.508=20
>=20
> Maximum latencies was obtained during file transfers.=20
> With this result I think that I could assert that Xenomai works properl=
y on my system, is right?=20

Well, no. dd if=3D/dev/zero of=3D/dev/null is far from being a proper loa=
d.
What you should do is at least to create some disk and network activity,
continuously. And the ideal, is to run the LTP test in parallel. If you
can not, then at least run hackbench in a loop. All this during several
hours.

>=20
> In facts, same test (only without file transfer) under another system w=
ith 1GHz Intel Atom on a SCH (Poulsbo) chipset (not supported by Xenomai =
to disable SMIs) reports these results:=20
>=20
> RTD| 11.353| 13.808| 31.264| 3| 0| 2.934| 231.539=20
>=20
> I think high latencies are due to SMIs.=20
> By the way, is there a reason why Xenomai does not disable SMIs on SCH =
chipsets?=20

We add ids to the smi.c table when people send patches, and report that
the workaround... works. Anyway, if you suspect that the ICH workaround
does not work with SCH chipsets, you should have a look at the SCH
chipsets datasheet, to check whether the method for disabling SMIs is
the same.

What I do not understand, in on which system you get the issue with your
test application. If you want to know if the system on which you run the
test has an isssue, then surely you should test this system, not another.=
=2E.

--=20
                                                                Gilles.



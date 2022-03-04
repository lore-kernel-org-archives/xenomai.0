Date: Fri, 4 Mar 2022 13:15:25 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1918812394.108775.1646396125911.JavaMail.zimbra@nod.at>
In-Reply-To: <7cc78732bf4902691e4194f52738ef1380c52ca6.camel@siemens.com>
References: <1971847999.108624.1646393705887.JavaMail.zimbra@nod.at>
 <7cc78732bf4902691e4194f52738ef1380c52ca6.camel@siemens.com>
Subject: Re: Questiion on commit: demo/cyclictest: fix time delta calculation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

Florian,

----- Urspr=C3=BCngliche Mail -----
> Von: "Florian Bezdeka" <florian.bezdeka@siemens.com>
> An: "xenomai" <xenomai@xenomai.org>, "richard" <richard@nod.at>
> Gesendet: Freitag, 4. M=C3=A4rz 2022 13:01:08
> Betreff: Re: Questiion on commit: demo/cyclictest: fix time delta calcula=
tion

> Hi Richard,
>=20
> On Fri, 2022-03-04 at 12:35 +0100, Richard Weinberger via Xenomai
> wrote:
>> Hello,
>>=20
>> I'm investigating into a cyclictest issue where it reports negative valu=
es just
>> like this commit states:
>> https://source.denx.de/Xenomai/xenomai/-/commit/3069a7bbc48559f4d2a6184d=
6159b771f193a4e9
>=20
> Ipipe or Dovetail? Does running "autotune" help?

I'm on ipipe on an arm i.mx6 system. Let me try autotune. :)

>>=20
>> Since I'm on Xenomai 3.1.2 the said commit is already included.
>> But I have a hard time to understand what problem the commit actually fi=
xes.
>> Why is the old calculation wrong?
>=20
> old code: In case the second wrapped we have
> ts1.nsec =3D <small> (we consider t1 to be the later point in time)
> ts2.nsec =3D <big>
>=20
> diff +=3D t1 - t2 is now negative. Right?

It did:
> diff =3D NSEC_PER_SEC * (int64_t)(t1.tv_sec - t2.tv_sec);

At this point diff is always a multiple of NSEC_PER_SEC or 0.
It is only 0 if t1.tv_sec are the same t2.tv_sec value.

> diff +=3D (t1.tv_nsec - t2.tv_nsec);

Here is where we seem to disagree.
t1.tv_nsec - t2.tv_nsec can be negative, yes.
But it can get only negative if t1.tv_sec - t2.tv_sec is non-zero.
So subtracting the negative delta from diff (which is a multiple of NSEC_PE=
R_SEC)
cannot get negative.

Of course the whole calculation works only of the clock does not go backwar=
ds.

Thanks,
//richard


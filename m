References: <1971847999.108624.1646393705887.JavaMail.zimbra@nod.at>
 <7cc78732bf4902691e4194f52738ef1380c52ca6.camel@siemens.com>
 <1918812394.108775.1646396125911.JavaMail.zimbra@nod.at>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Questiion on commit: demo/cyclictest: fix time delta calculation
Date: Fri, 04 Mar 2022 18:57:39 +0100
In-reply-to: <1918812394.108775.1646396125911.JavaMail.zimbra@nod.at>
Message-ID: <87fsnxr3nc.fsf@xenomai.org>
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
To: Richard Weinberger <richard@nod.at>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@xenomai.org


Richard Weinberger via Xenomai <xenomai@xenomai.org> writes:

> Florian,
>
> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Florian Bezdeka" <florian.bezdeka@siemens.com>
>> An: "xenomai" <xenomai@xenomai.org>, "richard" <richard@nod.at>
>> Gesendet: Freitag, 4. M=C3=A4rz 2022 13:01:08
>> Betreff: Re: Questiion on commit: demo/cyclictest: fix time delta calcul=
ation
>
>> Hi Richard,
>>=20
>> On Fri, 2022-03-04 at 12:35 +0100, Richard Weinberger via Xenomai
>> wrote:
>>> Hello,
>>>=20
>>> I'm investigating into a cyclictest issue where it reports negative val=
ues just
>>> like this commit states:
>>> https://source.denx.de/Xenomai/xenomai/-/commit/3069a7bbc48559f4d2a6184=
d6159b771f193a4e9
>>=20
>> Ipipe or Dovetail? Does running "autotune" help?
>
> I'm on ipipe on an arm i.mx6 system. Let me try autotune. :)
>
>>>=20
>>> Since I'm on Xenomai 3.1.2 the said commit is already included.
>>> But I have a hard time to understand what problem the commit actually f=
ixes.
>>> Why is the old calculation wrong?
>>=20
>> old code: In case the second wrapped we have
>> ts1.nsec =3D <small> (we consider t1 to be the later point in time)
>> ts2.nsec =3D <big>
>>=20
>> diff +=3D t1 - t2 is now negative. Right?
>
> It did:
>> diff =3D NSEC_PER_SEC * (int64_t)(t1.tv_sec - t2.tv_sec);
>
> At this point diff is always a multiple of NSEC_PER_SEC or 0.
> It is only 0 if t1.tv_sec are the same t2.tv_sec value.
>
>> diff +=3D (t1.tv_nsec - t2.tv_nsec);
>
> Here is where we seem to disagree.
> t1.tv_nsec - t2.tv_nsec can be negative, yes.
> But it can get only negative if t1.tv_sec - t2.tv_sec is non-zero.
> So subtracting the negative delta from diff (which is a multiple of NSEC_=
PER_SEC)
> cannot get negative.
>
> Of course the whole calculation works only of the clock does not go backw=
ards.
>
> Thanks,
> //richard

Florian pointed in the right direction when mentioning autotune: if the
core timer is not calibrated properly, Cobalt might try to compensate
for the basic latency of the platform too much, leading to early timer
shots. If such an early shot arrives and the test loop wakes up too
early, say in the code implementing clock_nanosleep (-n) case, 'next'
might actually be later in the timeline than 'now', leading to negative
differences in calcdiff().

The change in calcdiff() is most likely a plain workaround for this
case, assuming the normalized delta is very unlikely to go over the top
and won't be used as a worst-case figure. The commit log is definitely
misleading.

--=20
Philippe.


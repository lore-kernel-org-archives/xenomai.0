Date: Fri, 3 Jul 2020 11:26:52 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1369055393.86744.1593768412852.JavaMail.zimbra@nod.at>
In-Reply-To: <50c505c0-39bc-26c0-6188-1e2a2fe41536@siemens.com>
References: <CAFLxGvxru2Y==qboUgwHdsQvOT5MEL2O8CexkhkQpKz0Qj+jqw@mail.gmail.com>
 <77dc555e-10dd-8e05-0770-1f1f673259fd@siemens.com>
 <1684715583.86100.1593757371692.JavaMail.zimbra@nod.at>
 <50c505c0-39bc-26c0-6188-1e2a2fe41536@siemens.com>
Subject: Re: RTDM module ownership
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
>>> First of all, your driver is apparently not reacting on the close
>>> request that it receives in that case. This leads the the stall you see=
.
>>=20
>> Huh? rmmmod triggers close of what?
>> *confused*
>>  =20
>=20
> rmmod -> module cleanup -> rtdm_dev_unregister -> rtdm_device_flush_fds

Sure. The driver has a close method where it cleans up everything, of cours=
e.
But it can't force userspace to close the fd, Linux has no fd revocation
mechanism.
=20
>>> Still, we could indeed run some module_put/get on open/socket/close. I
>>> thought we did, but that was once RTnet [1].
>>=20
>> Yes. Would be nice. :-)
>>=20
>=20
> Just like a patch would be...

Pushed to my TODO...

Thanks,
//richard


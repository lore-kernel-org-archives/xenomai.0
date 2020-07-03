Date: Fri, 3 Jul 2020 08:22:51 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1684715583.86100.1593757371692.JavaMail.zimbra@nod.at>
In-Reply-To: <77dc555e-10dd-8e05-0770-1f1f673259fd@siemens.com>
References: <CAFLxGvxru2Y==qboUgwHdsQvOT5MEL2O8CexkhkQpKz0Qj+jqw@mail.gmail.com>
 <77dc555e-10dd-8e05-0770-1f1f673259fd@siemens.com>
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
Cc: Richard Weinberger <richard.weinberger@gmail.com>, xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
>> In contrast, on regular Linux rmmod will refuse to unload the module
>> if the device node is still open because fops_get() or other helpers
>> gained a reference on the owner.
>>=20
>=20
> First of all, your driver is apparently not reacting on the close
> request that it receives in that case. This leads the the stall you see.

Huh? rmmmod triggers close of what?
*confused*
=20
> Still, we could indeed run some module_put/get on open/socket/close. I
> thought we did, but that was once RTnet [1].

Yes. Would be nice. :-)

Thanks,
//richard


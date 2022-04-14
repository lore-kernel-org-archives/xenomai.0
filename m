Date: Thu, 14 Apr 2022 13:29:40 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1698369205.253797.1649935780435.JavaMail.zimbra@nod.at>
In-Reply-To: <7d2e38dc-7386-e703-2e09-572874c5e162@siemens.com>
References: <20220413215819.22954-1-richard@nod.at>
 <7d2e38dc-7386-e703-2e09-572874c5e162@siemens.com>
Subject: Re: [PATCH v2 0/9] Revive alchemy, pSOS and VxWorks tests
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
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> Seems we need to fix those at least.

Agreed.
=20
>>=20
>>   If Xenomai was configured with --enable-lores-clock, tests mq1, mutex1=
, pip1 and
>>   sem1 fail due to:
>> =09undefined symbol: __clockobj_ticks_to_timeout
>=20
> Missing lib dependency, likely. Cannot try out myself yet as patch 2
> does not build.

Maybe, I found it quite interesting that building the tests works fine
but at runtime I get the undefined symbol error.

> So... reviving means fixing first, unfortunately. Then enable CI/CT, and

This was expected, no worries.

> then we can merge. The pattern looks scalable, but then we could also
> apply it stepwise: first alchemy, then vxworks and finally psos with
> that lores-clock topic.

Sounds like a plan.

Thanks,
//richard


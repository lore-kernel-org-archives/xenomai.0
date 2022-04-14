Date: Thu, 14 Apr 2022 16:19:41 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1113877096.254279.1649945981167.JavaMail.zimbra@nod.at>
In-Reply-To: <ecaf916590f14dbc063015e0a9b2be614609f7a4.camel@siemens.com>
References: <20220413215819.22954-1-richard@nod.at>
 <7d2e38dc-7386-e703-2e09-572874c5e162@siemens.com>
 <2065449276.254073.1649941119506.JavaMail.zimbra@nod.at>
 <ecaf916590f14dbc063015e0a9b2be614609f7a4.camel@siemens.com>
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Florian Bezdeka" <florian.bezdeka@siemens.com>
>> ...same does marking both variables as volatile.
>=20
> I don't have much context here, but volatile sounds like a valid
> solution (assuming that safety is written by a different thread)

Both variables are written by the very same thread.
The problem is that the don't get used later, so the compiler is free
to remove the loop. That's why the barrier fixes the problem.
It forces the compiler to keep the loop.

Thanks,
//richard


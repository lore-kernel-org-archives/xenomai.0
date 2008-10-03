Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 3 Oct 2008 09:20:58 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F48E4DB5D@trillian.at.omicron.at>
In-Reply-To: <48E52912.7030200@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
Subject: Re: [Adeos-main] FW: [PATCH] repost: ARM FCSE
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org, Sebastian Smolorz <ssm@domain.hid>

Gilles,

I have found that on both 2.6.21 and 2.6.26, I need to add an include
of <linux/sched.h> to fcse.h in order to get the definition of
struct mm_struct.

Richard

> -----Original Message-----
> From: Gilles Chanteperdrix=20
> Sent: Thursday, October 02, 2008 10:04 PM
> Subject: Re: [Adeos-main] FW: [PATCH] repost: ARM FCSE
>=20
>=20
> Richard Cochran wrote:
> > In any case, I found one huge error in the patch...you=20
> mangled my name
> > ;)
>=20
> Here is a better one, with this error fixed, as well as a fix in
> switch_mm which makes that now, we really do not flush the cache.
> Previous version flushed the cache at each switch due to an=20
> error in the
> register we checked.
>=20
> I have tested this version with Xenomai, and we get lower=20
> latencies (we
> gained 100us).
>=20
> --=20
> 					    Gilles.
>=20


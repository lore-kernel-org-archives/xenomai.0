Message-ID: <424BA18A.4060907@domain.hid>
Date: Thu, 31 Mar 2005 09:06:50 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] RE: RTAI/fusion 0.7
References: <1CFEB358338412458B21FAA0D78FE86D505935@domain.hid>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D505935@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: rtai@domain.hid, adeos-main@gna.org

Hi St=E9phane,

Fillod Stephane wrote:
> Hi Philippe,
>=20
> Kudos for the RTAI/fusion 0.7 release!
> You (the team) are doing an astounding work.

Thanks.

>=20
> [snip]
>=20
>>o The Adeos support used in fusion has been upgraded to final releases,
>=20
>=20
>>namely r9/x86 and r6/ppc. Upgrading is strongly recommended, especially
>=20
>=20
>>if CONFIG_PREEMPT is enabled in your kernel config, which is likely
>=20
> with=20
>=20
>>fusion. Also note that Adeos PPC is now rebased on mainline (2.6.10=20
>>actually).
>=20
>=20
> Please find attached a patch of Adeos r6/ppc against 2.6.11.
> I hope I've got it right.

Looks so. Looking at the problem Heikki pointed us at, it would somewhat=20
affect 2.6.11 usability in RTAI/fusion context, since we would need to=20
run with CONFIG_PREEMPT disabled. No problem for RT stuff in primary=20
mode, but rather hopeless for using the secondary one efficiently.=20
Either we include Paul Mackerras's fix for it in the Adeos patch, or we=20
go directly for 2.6.12-rc, using your patch as a reference.

> Please let me know if it would need=20
> the spinlock fix in i386-r10c1.
>=20

It would be better, yes. This generic bug breaks deemed non-preemptible=20
sections in printk() at least. I've committed the changes to the Adeos=20
CVS (adeos-core/include/asm-ppc/adeos.h).

> Hope to get some Fusion report to share soon.
>=20

Ack. Thanks for the patch.

--=20

Philippe.


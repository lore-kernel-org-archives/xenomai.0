Message-ID: <451CCFD1.4030001@domain.hid>
Date: Fri, 29 Sep 2006 09:48:33 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
References: <451786B3.4020506@domain.hid> <1159434450.4949.7.camel@domain.hid>	
	<451B92C8.9050802@domain.hid> <1159434997.4949.9.camel@domain.hid>	
	<451B949B.4090602@domain.hid> <1159438034.4949.25.camel@domain.hid>	
	<451BA49D.2030303@domain.hid> <1159440412.4949.33.camel@domain.hid>
In-Reply-To: <1159440412.4949.33.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF2C7300774AA39DF1B6EB746"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF2C7300774AA39DF1B6EB746
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:

> On Thu, 2006-09-28 at 12:31 +0200, Jan Kiszka wrote:
>> Does it still make sense then to optimise like I proposed?
>>
>
> If you did measure a 5% improvement on low-end x86 hw, then I guess so.=

> Moving __ipipe_unstall_root to the arch-dependent section would do, so
> that we could use the most efficient implementation on a case by case
> basis.
>

I'm not seeing 5% alone due to this change, it's a piece in the puzzle. I=
 just
benchmarked the fixed version below against the unmodified one. There is =
an improvement
of the average hackbench runtime, though it's minimal. The wrong variant =
I posted first
doesn't show noticeable benefit compared to the correct one. I guess the =
"critical"
part is switching IRQs off when they were on, and not just enabling them =
when they
weren't disabled.

So I think the one below could be applied for now, but per-arch optimisat=
ions may
remain on the to-do list for the future if we discover archs that could d=
o better with
hand-optimised code here. The x86 assembly looks quite good already.


--- linux-2.6.17.13.orig/kernel/ipipe/core.c
+++ linux-2.6.17.13/kernel/ipipe/core.c
@@ -166,6 +158,7 @@ void __ipipe_unstall_root(void)
 {
 	ipipe_declare_cpuid;
=20
+#ifdef CONFIG_SMP
 	local_irq_disable_hw();
=20
 	ipipe_load_cpuid();
@@ -174,6 +167,14 @@ void __ipipe_unstall_root(void)
=20
 	if (ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=3D 0)
 		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+#else	/* !CONFIG_SMP */
+	clear_bit(IPIPE_STALL_FLAG, &ipipe_root_domain->cpudata[cpuid].status);=

+
+	if (unlikely(ipipe_root_domain->cpudata[cpuid].irq_pending_hi !=3D 0)) =
{
+		local_irq_disable_hw();
+		__ipipe_sync_pipeline(IPIPE_IRQMASK_ANY);
+	}
+#endif	/* CONFIG_SMP */
=20
 	local_irq_enable_hw();
 }



--------------enigF2C7300774AA39DF1B6EB746
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFHM/RniDOoMHTA+kRArZnAJ9dR0R0+hAgW9OU2JWZBb+e57AiHQCcCwXD
HKtq+e0IaA1Fp7Sv0EyI3Wc=
=6OSB
-----END PGP SIGNATURE-----

--------------enigF2C7300774AA39DF1B6EB746--


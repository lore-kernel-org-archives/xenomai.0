Message-ID: <4656E396.60002@domain.hid>
Date: Fri, 25 May 2007 15:24:38 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4656C2D1.5000904@domain.hid>
In-Reply-To: <4656C2D1.5000904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH] small cleanups for rtcan_peak_dng
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hallo Jan,

Jan Kiszka wrote:
> Hi Wolfgang,
>=20
> I came across the fact that xeno_can_peak_dng is autoloaded on 2.6 due =
to
> its PnP announcement via MODULE_DEVICE_TABLE. xeno_irqbench and
> xeno_16550A used to behave similar, but both just as well as this drive=
r
> require manual parameters anyway. So let's remove the table and thus an=
y
> autoloading tendency. I also cleaned up a few driver messages at this
> chance.
>=20
> OK to apply?

Ja, sieht gut aus und bei dir funktioniert es ja auch.

Ein Kunde von uns evaluiert gerade CAN-Festival mit RT-Socket-CAN auf=20
einem MPC5200-Board. Mal sehen, was dabei rauskommt.

Die Socket-CAN-Integration hat ja jetzt auch begonnen. Da bin ich mal=20
gespannt. Sollte mal wieder die linux-netdev ML durchschauen.

Dann erstmal sch=F6ne Feiertage.

Viele Gr=FC=DFe,

Wolfgang.


> ---
>  ChangeLog                                 |    5 +++++
>  ksrc/drivers/can/sja1000/rtcan_peak_dng.c |    9 ++++-----
>  2 files changed, 9 insertions(+), 5 deletions(-)
>=20
> Index: xenomai/ChangeLog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- xenomai.orig/ChangeLog
> +++ xenomai/ChangeLog
> @@ -1,3 +1,8 @@
> +2007-05-25  Jan Kiszka  <jan.kiszka@domain.hid>
> +
> +	* ksrc/drivers/can/sja1000/rtcan_peak_dng.c: Remove PnP device
> +	table to avoid autoloading. Fix driver error messages.
> +
>  2007-05-25  Philippe Gerum  <rpm@xenomai.org>
> =20
>  	* ksrc/nucleus/shadow.c (do_sigwake_event): Replace silent sanity
> Index: xenomai/ksrc/drivers/can/sja1000/rtcan_peak_dng.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- xenomai.orig/ksrc/drivers/can/sja1000/rtcan_peak_dng.c
> +++ xenomai/ksrc/drivers/can/sja1000/rtcan_peak_dng.c
> @@ -224,7 +224,7 @@ int __init rtcan_peak_dng_init_one(int i
>      else if (strncmp(type[idx], "epp", 3) =3D=3D 0)
>  	dtype =3D DONGLE_TYPE_EPP;
>      else {
> -	printk("%s: type %s is invalid, use \"sp\" or \"sp\".",
> +	printk("%s: type %s is invalid, use \"sp\" or \"epp\".",
>  	       RTCAN_DRV_NAME, type[idx]);
>  	return -EINVAL;
>      }
> @@ -329,8 +329,6 @@ static const struct pnp_device_id rtcan_
>      { }
>  };
> =20
> -MODULE_DEVICE_TABLE(pnp, rtcan_peak_dng_pnp_tbl);
> -
>  static int rtcan_peak_dng_pnp_probe(struct pnp_dev *dev,
>  				    const struct pnp_device_id *id)
>  {
> @@ -378,7 +376,7 @@ static int __init rtcan_peak_dng_init(vo
>  	 i++) {
> =20
>  	if ((ret =3D rtcan_peak_dng_init_one(i)) !=3D 0) {
> -	    printk("Init failed with %d\n", ret);
> +	    printk(KERN_ERR "%s: Init failed with %d\n", RTCAN_DRV_NAME, ret)=
;
>  	    goto cleanup;
>  	}
>  	done++;
> @@ -386,7 +384,8 @@ static int __init rtcan_peak_dng_init(vo
>      if (done)
>  	return 0;
> =20
> -    printk("Please specify type=3Depp or type=3Dsp\n");
> +    printk(KERN_ERR "%s: Please specify type=3Depp or type=3Dsp\n",
> +	   RTCAN_DRV_NAME);
> =20
>  cleanup:
>      rtcan_peak_dng_exit();
>=20



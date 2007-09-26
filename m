Message-ID: <46FA8D23.6010203@domain.hid>
Date: Wed, 26 Sep 2007 18:47:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <353969d40709260127s1c7fb5c6necdcf3591abc90f4@domain.hid>	
	<46FA26C0.5050606@domain.hid>	
	<353969d40709260447l1b64e966hb500f8d3c0d4a0a@domain.hid>
	<353969d40709260858w3e1e30bbr58492008e8ca28ae@domain.hid>
In-Reply-To: <353969d40709260858w3e1e30bbr58492008e8ca28ae@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] new features for 16550A driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Guillaume Gaudonville <guillaume.gaudonville@domain.hid>
Cc: Xenomai-core@domain.hid

Guillaume Gaudonville wrote:
> I've attached the patch drafts. It works fine for me. it prepare the wo=
rk to
> implement the other iflag values as describe in man tcsetattr.
>=20

...

>=20
> Index: ksrc/drivers/serial/16550A.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/serial/16550A.c	(r=C3=A9vision 2765)
> +++ ksrc/drivers/serial/16550A.c	(copie de travail)
> @@ -153,7 +153,10 @@ static inline int rt_16550_rx_interrupt(
>  	do {
>  		c =3D rt_16550_reg_in(mode, base, RHR);	/* read input char */
> =20
> -		ctx->in_buf[ctx->in_tail] =3D c;
> +		if (testbits(ctx->config.iflags, RTSER_IFLAG_ISTRIP))
> +			ctx->in_buf[ctx->in_tail] =3D c & 0x7f;
> +		else
> +			ctx->in_buf[ctx->in_tail] =3D c;

OK, things become clearer.

Question: Switching parity checking on in the hardware does not work/is=20
no option for you? Shouldn't that clear the parity information as well?

>  		if (ctx->in_history)
>  			ctx->in_history[ctx->in_tail] =3D *timestamp;
>  		ctx->in_tail =3D (ctx->in_tail + 1) & (IN_BUFFER_SIZE - 1);
> @@ -426,6 +429,10 @@ static int rt_16550_set_config(struct rt
>  		rtdm_lock_put_irqrestore(&ctx->lock, lock_ctx);
>  	}
> =20
> +	if (testbits(config->config_mask, RTSER_SET_IFLAGS)) {
> +		ctx->config.iflags =3D config->iflags;
> +	}
> +
>  	return err;
>  }
> =20
> Index: include/rtdm/rtserial.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/rtdm/rtserial.h	(r=C3=A9vision 2765)
> +++ include/rtdm/rtserial.h	(copie de travail)
> @@ -184,6 +184,7 @@
>  #define RTSER_SET_TIMEOUT_EVENT		0x0400
>  #define RTSER_SET_TIMESTAMP_HISTORY	0x0800
>  #define RTSER_SET_EVENT_MASK		0x1000
> +#define RTSER_SET_IFLAGS		0x2000
>  /** @} */
> =20
> =20
> @@ -238,6 +239,15 @@
>  #define RTSER_BREAK_SET			0x01
> =20
> =20
> +/*!
> + * @anchor RTSER_IFLAG_xxx   @name RTSER_IFLAG_xxx
> + * Input behaviour (when used every bits will be set by the ioctl comm=
and)
> + * @{ */
> +#define RTSER_IFLAG_NONE		0x00
> +#define RTSER_IFLAG_ISTRIP		0x01
> +#define RTSER_IFLAG_DEFAULT		0x00
> +
> +
>  /**
>   * Serial device configuration
>   */
> @@ -280,6 +290,11 @@ typedef struct rtser_config {
>  	/** event mask to be used with @ref RTSER_RTIOC_WAIT_EVENT, see
>  	 *  @ref RTSER_EVENT_xxx */
>  	int		event_mask;
> +
> +	/** input flags, see @ref RTSER_IFLAG_xxx, RTSER_IFLAG_ISTRIP is
> +	 *  the only one supported for the moment (when used every bits
> +	 *  must be set according to the desired configuration)*/
> +	int		iflags;
>  } rtser_config_t;
> =20
>  /**

The patch looks very clean, no question! Assuming my attempt above to=20
use the hardware for this is nonsense, I then wonder if the feature is=20
worth the additional conditional branch + another potential cache miss=20
(for ctx->config.iflags) inside the critical reception path.

This is precisely that question of balance: Is the extension of some=20
broader interest? Do we need it inside the driver (I see no reason yet=20
why the application cannot do the masking, and we are not forced into=20
compatibility with termios)? And does the extension impact critical paths=
?

Jan

--=20
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


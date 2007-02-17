Message-ID: <45D741AE.9020501@domain.hid>
Date: Sat, 17 Feb 2007 18:55:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: Extended CAN frame filtering
References: <45D338C2.9030203@domain.hid> <45D5A56F.8080900@domain.hid>
	<45D711DF.8060802@domain.hid>
In-Reply-To: <45D711DF.8060802@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0ABA71A9D604C64E3C0F32A3"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0ABA71A9D604C64E3C0F32A3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
=2E..
>=20
> Attached is a patch adding the CAN_INV_FILTER feature. It also updates
> the doc. Now the filter scheme should be compatible with Socket-CAN. If=

> it's OK, I will check it in (or you can do it).
>=20
> Wolfgang.
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: include/rtdm/rtcan.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- include/rtdm/rtcan.h	(revision 2193)
> +++ include/rtdm/rtcan.h	(working copy)

Please increment the profile revision (2 spots: #define and
documentation text).

> @@ -441,28 +441,38 @@ typedef enum CAN_STATE can_state_t;
> =20
>  #define CAN_STATE_OPERATING(state) ((state) < CAN_STATE_BUS_OFF)
> =20
> +/** Invert CAN filter definition */
> +#define CAN_INV_FILTER      CAN_ERR_FLAG
> +

I would move this close to the other CAN ID flags and explain explicitly
which one is valid in which context. Both are sharing the same bit, so
confusion can arise.

>  /**
>   * Filter for reception of CAN messages.
>   *
>   * This filter works as follows:
>   * A received CAN ID is AND'ed bitwise with @c can_mask and then compa=
red to
> - * @c can_id. If this comparison is true the message will be received =
by the
> - * socket.
> + * @c can_id. This also includes the @ref CAN_EFF_FLAG and @ref CAN_RT=
R_FLAG
> + * of @ref CAN_xxx_FLAG. If this comparison is true, the message will =
be
> + * received by the socket. The logic can be inverted with the @c can_i=
d flag
> + * @ref CAN_INV_FILTER :
> + *
> + * @code
> + * if (can_id & CAN_INV_FILTER) {
> + *    if ((received_can_id & can_mask) !=3D (can_id & ~CAN_INV_FILTER)=
)
> + *       accept-message;
> + * } else {
> + *    if ((received_can_id & can_mask) =3D=3D can_id)
> + *       accept-message;
> + * }
> + * @endcode

Nice and helpful!

>   *
> - * Multiple filters can be arranged in a filter list and set with=20
> - * @ref Sockopts. If one of these filters matches a CAN ID upon recept=
ion=20
> + * Multiple filters can be arranged in a filter list and set with
> + * @ref Sockopts. If one of these filters matches a CAN ID upon recept=
ion
>   * of a CAN frame, this frame is accepted.
>   *
> - * @note Only @ref CAN_EFF_FLAG of @ref CAN_xxx_FLAG "CAN ID flags" is=

> - * valid for @c can_id and none for @c can_mask. This means that the R=
TR bit
> - * is not taken into account while filtering messages.
> - *
> - * Extended IDs are received only if @ref CAN_EFF_FLAG is set in
> - * @c can_id. If it is cleared only standard IDs are accepted.
>   */
>  typedef struct can_filter {
> =20
> -    /** CAN ID which must match with incoming IDs after passing the ma=
sk */
> +    /** CAN ID which must match with incoming IDs after passing the ma=
sk.
> +     *  The filter logic can be inverted with the flag @ref CAN_INV_FI=
LTER. */
>      uint32_t    can_id;
> =20
>      /** Mask which is applied to incoming IDs. See @ref CAN_xxx_MASK
> @@ -470,12 +480,11 @@ typedef struct can_filter {
>      uint32_t    can_mask;
>  } can_filter_t;
> =20
> -
>  /**
>   * Socket address structure for the CAN address family
>   */
>  struct sockaddr_can {
> -    /** CAN address family, must be @c AF_CAN */   =20
> +    /** CAN address family, must be @c AF_CAN */
>      sa_family_t  can_family;
>      /** Interface index of CAN controller. See @ref SIOCGIFINDEX. */
>      int          can_ifindex;
> Index: ksrc/drivers/can/rtcan_module.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/rtcan_module.c	(revision 2193)
> +++ ksrc/drivers/can/rtcan_module.c	(working copy)
> @@ -262,11 +262,11 @@ static int rtcan_read_proc_filter(char *
>      rtdm_lockctx_t lock_ctx;
>      RTCAN_PROC_PRINT_VARS(80);
> =20
> -    /*  fd __CAN_ID__ _CAN_Mask_ MatchCount
> -     *   3 0x12345678 0x12345678 1234567890
> +    /*  fd __CAN_ID__ _CAN_Mask_ Inv MatchCount
> +     *   3 0x12345678 0x12345678  no 1234567890
>       */
> -   =20
> -    if (!RTCAN_PROC_PRINT("fd __CAN_ID__ _CAN_Mask_ MatchCount\n"))
> +
> +    if (!RTCAN_PROC_PRINT("fd __CAN_ID__ _CAN_Mask_ Inv MatchCount\n")=
)
>          goto done;
> =20
>      rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
> @@ -275,10 +275,13 @@ static int rtcan_read_proc_filter(char *
>      while (recv_listener !=3D NULL) {
>  	context =3D rtcan_socket_context(recv_listener->sock);
> =20
> -	if (!RTCAN_PROC_PRINT("%2d 0x%08x 0x%08x %10d\n",
> -			      context->fd,=20
> +	if (!RTCAN_PROC_PRINT("%2d 0x%08x 0x%08x %s %10d\n",
> +			      context->fd,
>  			      recv_listener->can_filter.can_id,
> -			      recv_listener->can_filter.can_mask,
> +			      recv_listener->can_filter.can_mask &
> +			      ~CAN_INV_FILTER,
> +			      (recv_listener->can_filter.can_mask &
> +			       CAN_INV_FILTER) ? "yes" : " no",
>  			      recv_listener->match_count))
>  	    break;
>  	recv_listener =3D recv_listener->next;
> Index: ksrc/drivers/can/rtcan_raw.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/rtcan_raw.c	(revision 2193)
> +++ ksrc/drivers/can/rtcan_raw.c	(working copy)
> @@ -67,7 +67,10 @@ static struct rtdm_device rtcan_proto_ra
> =20
>  static inline int rtcan_accept_msg(uint32_t can_id, can_filter_t *filt=
er)
>  {
> -    return ((can_id & filter->can_mask) =3D=3D filter->can_id);
> +    if ((filter->can_mask & CAN_INV_FILTER))
> +	return ((can_id & filter->can_mask) !=3D filter->can_id);
> +    else
> +	return ((can_id & filter->can_mask) =3D=3D filter->can_id);
>  }
> =20
> =20
> Index: ksrc/drivers/can/rtcan_raw_filter.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ksrc/drivers/can/rtcan_raw_filter.c	(revision 2193)
> +++ ksrc/drivers/can/rtcan_raw_filter.c	(working copy)
> @@ -55,13 +55,13 @@ void rtcan_raw_print_filter(struct rtcan
>  static inline void rtcan_raw_mount_filter(can_filter_t *recv_filter,
>  					  can_filter_t *filter)
>  {
> -   if (filter->can_id & CAN_EFF_FLAG)
> -	recv_filter->can_mask =3D ((filter->can_mask & CAN_EFF_MASK) |
> -				 CAN_EFF_FLAG);
> -    else
> -	recv_filter->can_mask =3D (filter->can_mask & CAN_SFF_MASK);
> -
> -    recv_filter->can_id =3D filter->can_id & recv_filter->can_mask;
> +    if (filter->can_id & CAN_INV_FILTER) {
> +	recv_filter->can_id =3D filter->can_id & ~CAN_INV_FILTER;
> +	recv_filter->can_mask =3D filter->can_mask | CAN_INV_FILTER;
> +    } else {
> +	recv_filter->can_id =3D filter->can_id;
> +	recv_filter->can_mask =3D filter->can_mask & ~CAN_INV_FILTER;
> +    }

Why do you push CAN_INV_FILTER internally into the mask instead of
keeping it in the filter's ID - as the pseudo code above states?

Jan


--------------enig0ABA71A9D604C64E3C0F32A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF10GuniDOoMHTA+kRAqLDAJwPPqa7oaE2784Cyuw3ve3TyzKeKQCdEQGw
t9v5QqynUqNrhdc6wwdQTJs=
=PUOC
-----END PGP SIGNATURE-----

--------------enig0ABA71A9D604C64E3C0F32A3--


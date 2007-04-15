Message-ID: <4622A289.4050105@domain.hid>
Date: Mon, 16 Apr 2007 00:09:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <461D65BC.2090406@domain.hid>
	<46220DC4.9040306@domain.hid>	<46222105.90900@domain.hid>
	<46226E16.9080004@domain.hid>
	<4622729C.4080806@domain.hid> <462274A4.7040409@domain.hid>
	<46228330.603@domain.hid>
In-Reply-To: <46228330.603@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig590E538B3DC641BCF7F0FB26"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] CAN_RAW, CAN_PROTO_RAW, and Socket-CAN
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
--------------enig590E538B3DC641BCF7F0FB26
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Wolfgang Grandegger wrote:
>>>> Jan Kiszka wrote:
>>>>> Wolfgang Grandegger wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Hi Wolfgang,
>>>>>>>
>>>>>>> something is inconsistent about CAN_RAW in RT-Socket-CAN compared=
 to
>>>>>>> plain Socket-CAN. Also, the latter doesn't know any CAN_PROTO_xxx=

>>>>>>> unless
>>>>>>> I oversee something. Please have a look.
>>>>>> There is CAN_PROTO_RAW defined and I have added some time ago
>>>>>> CAN_RAW to
>>>>>> rtcan.h to be compatible with Socket-CAN:
>>>>>>
>>>>>>   /** Particular CAN protocols
>>>>>>    *
>>>>>>    *  Currently only the RAW protocol is supported.
>>>>>>    */
>>>>>>   #define CAN_RAW  0
>>>>> Yes, I know. But the question remains which way to go for rtcan:
>>>>> Socket-CAN doesn't know CAN_PROTO_*, RT-Socket-CAN comes with
>>>>> CAN_RAW as
>>>>> well now, but having a different value. That should be resolved, on=

>>>>> whatever side, IMHO.
>>>> Ah, now I understand your concern. CAN_PROTO_RAW actually serves the=

>>>> same purpose then CAN_RAW defining the particular CAN protocol. I'm
>>>> going to clean it up soon removing CAN_PROTO_RAW and updating the do=
c.
>>>> CAN_PROTO_RAW was not used by any application, IIRC.
>>> The man page for "socket" describes the protocol argument as shown
>>> below:
>>>
>>>        The  protocol specifies a particular protocol to be used with =
the
>>>        socket. Normally only a single protocol exists to support a
>>>        particular socket  type within a given protocol family, in whi=
ch
>>>        case protocol can be specified as 0. However, it is possible t=
hat
>>>        many  protocols  may exist, in which case a particular protoco=
l
>>>        must be specified in this manner.
>>>
>>> A value of 0 is valid for RT-Socket-CAN but not for Socket-CAN.
>>> Therefore we need to define CAN_RAW=3D1 for compatibility reasons.
>>
>> Agreed.
>>
>> Moreover, 0 means "unspecified default protocol" according to POSIX. O=
n
>> what does Socket-CAN map it, CAN_RAW? Anyway, we have no other option =
so
>> far with RT-Socket-CAN.
>=20
>   int rtcan_raw_socket(struct rtdm_dev_context *context,
>                        rtdm_user_info_t *user_info, int protocol)
>   {
>     /* Only CAN_PROTO_RAW is supported */
>     if (protocol !=3D CAN_PROTO_RAW && protocol !=3D 0)
>         return -EPROTONOSUPPORT;
>=20
>     rtcan_socket_init(context);
>=20
>     return 0;
>   }
>=20
> Both, protocol "0" and CAN_PROTO_RAW is OK. I just need to replace
> CAN_PROTO_RAW with CAN_RAW.

Perfect.

Jan


--------------enig590E538B3DC641BCF7F0FB26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGIqKJniDOoMHTA+kRAkfzAJ42vRYm5cwYxQLRKBFUts3rN/9tagCbBdFY
94U0n+0OyAh5KwQpQOvihmI=
=myt4
-----END PGP SIGNATURE-----

--------------enig590E538B3DC641BCF7F0FB26--


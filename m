Message-ID: <437AC5CE.50401@domain.hid>
Date: Wed, 16 Nov 2005 06:38:22 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_pipe_* usage
References: <OFDC60A907.2FB7647D-ONC12570B9.0058D97B-C12570B9.005A128D@datacon.at>
	<4378BD15.8020206@domain.hid> <4379DFC1.6020904@domain.hid>
	<437A0B62.20308@domain.hid>
In-Reply-To: <437A0B62.20308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Philippe Gerum wrote:
>=20
>=20
>>Ignacio Garc=EDa P=E9rez wrote:
>>
>>
>>>>>RT_PIPE_MSG *m =3D rt_pipe_alloc(sizeof(mystruct_t));
>>>>>mystruct_t *p =3D (mystruct_t *)P_MSGPTR(m);
>>>>>p->whatever1 =3D X;
>>>>>p->whatever2 =3D X;
>>>>>rt_pipe_send(&mypipe, m, sizeof(mystruct_t), P_NORMAL);
>>>>>
>>>>>If this is correct, why do I have to specify the size of mystruct_t
>>>>>*twice*. Can't it be initialized by rt_pipe_alloc ?.
>>>>
>>>>
>>>>It's initialized actually (*).
>>>>
>>>
>>>So, what's the sense of having to specify it again whet calling
>>>rt_pipe_send ?
>>>
>>
>>Because you may (pre-)allocate more than you really need to send
>>afterwards.
>>
>=20
> I guess this should be explained in the docs. Please consider the small
> patch I attach.
>=20

Ok, applied. Thanks.

> Nacho.
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: skins/native/pipe.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- skins/native/pipe.c	(revision 143)
> +++ skins/native/pipe.c	(working copy)
> @@ -598,7 +598,11 @@
>   *
>   * @param size The size in bytes of the message (payload data
>   * only). Zero is a valid value, in which case the service returns
> - * immediately without sending any message.
> + * immediately without sending any message. This parameter allows
> + * you to actually send less data than you reserved using the
> + * rt_pipe_alloc() service, which may be the case if you did not
> + * know how much space you needed at the time of allocation. In all
> + * other cases it may be more convenient to just pass P_MSGSIZE(msg).
>   *
>   * Additionally, rt_pipe_send() causes any data buffered by
>   * rt_pipe_stream() to be flushed prior to sending the message. For


--=20

Philippe.


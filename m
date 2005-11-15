Message-ID: <4379DFC1.6020904@domain.hid>
Date: Tue, 15 Nov 2005 14:16:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_pipe_* usage
References: <OFDC60A907.2FB7647D-ONC12570B9.0058D97B-C12570B9.005A128D@datacon.at>
	<4378BD15.8020206@domain.hid>
In-Reply-To: <4378BD15.8020206@domain.hid>
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
>>>RT_PIPE_MSG *m =3D rt_pipe_alloc(sizeof(mystruct_t));
>>>mystruct_t *p =3D (mystruct_t *)P_MSGPTR(m);
>>>p->whatever1 =3D X;
>>>p->whatever2 =3D X;
>>>rt_pipe_send(&mypipe, m, sizeof(mystruct_t), P_NORMAL);
>>>
>>>If this is correct, why do I have to specify the size of mystruct_t
>>>*twice*. Can't it be initialized by rt_pipe_alloc ?.
>>
>>It's initialized actually (*).
>>
>=20
> So, what's the sense of having to specify it again whet calling
> rt_pipe_send ?
>=20

Because you may (pre-)allocate more than you really need to send afterwar=
ds.

--=20

Philippe.


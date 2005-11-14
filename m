Message-ID: <4378BD15.8020206@domain.hid>
Date: Mon, 14 Nov 2005 17:36:37 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_pipe_* usage
References: <OFDC60A907.2FB7647D-ONC12570B9.0058D97B-C12570B9.005A128D@datacon.at>
In-Reply-To: <OFDC60A907.2FB7647D-ONC12570B9.0058D97B-C12570B9.005A128D@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org


> >
> > RT_PIPE_MSG *m = rt_pipe_alloc(sizeof(mystruct_t));
> > mystruct_t *p = (mystruct_t *)P_MSGPTR(m);
> > p->whatever1 = X;
> > p->whatever2 = X;
> > rt_pipe_send(&mypipe, m, sizeof(mystruct_t), P_NORMAL);
> >
> > If this is correct, why do I have to specify the size of mystruct_t
> > *twice*. Can't it be initialized by rt_pipe_alloc ?.
>
> It's initialized actually (*).
>
So, what's the sense of having to specify it again whet calling
rt_pipe_send ?




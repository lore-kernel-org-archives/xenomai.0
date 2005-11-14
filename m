Message-ID: <4378B391.5030306@domain.hid>
Date: Mon, 14 Nov 2005 16:56:01 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <OFBDFF2ABC.D4775297-ONC12570B9.004E7A08-C12570B9.00517F6A@datacon.at>
In-Reply-To: <OFBDFF2ABC.D4775297-ONC12570B9.004E7A08-C12570B9.00517F6A@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_pipe_* usage
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm having now my first contact with the pipe framework, an have some
comments about it that might be of interest to the core developers:

While the documentation is overall *great*, I fould it a bit lacking
regarding the pipes. Would be good to have some examples of general usage.

As far as I can tell, there is no mention of the usage of P_MSGPTR and
P_MSGSIZE. I had to learn about them in the headers.

At first sight, the rt_pipe_send call is confusing: why should I pass
the data size since it is supposed to be embedded in the RT_PIPE_MSG
structure?.

This is what I first did:

RT_PIPE_MSG *m = rt_pipe_alloc(sizeof(mystruct));
P_MSGPTR(m) = &mystruct;
P_MSGSIZE(m) = sizeof(mystruct)
rt_pipe_send(&mypipe, m, sizeof(mystruct), P_NORMAL);

Which is obviously wrong. Please correct me if I'm wrong:

P_MSGPTR and P_MSGSIZE are intended not to be used as an lvalue (is
there a way to define these macros to generate a compile error if they
are?).

So, the correct way would be something like this (again, correct me if
I'm wrong)::

RT_PIPE_MSG *m = rt_pipe_alloc(sizeof(mystruct_t));
mystruct_t *p = (mystruct_t *)P_MSGPTR(m);
p->whatever1 = X;
p->whatever2 = X;
rt_pipe_send(&mypipe, m, sizeof(mystruct_t), P_NORMAL);

If this is correct, why do I have to specify the size of mystruct_t
*twice*. Can't it be initialized by rt_pipe_alloc ?.

Nacho.











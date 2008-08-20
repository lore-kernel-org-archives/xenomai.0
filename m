Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Aug 2008 17:04:09 +0200
Message-ID: <406CC9939904F143B9D42CEEA3E56E56432116@domain.hid>
References: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
	<48AAF55E.9000206@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
	<48ABEF11.6060307@domain.hid>
From: "Filip Van Rillaer" <Filip.VanRillaer@domain.hid>
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hello,

Thank you for your work-around.
Though I have some problems with the implementation:
pipe_i_handler (Xenomai side) does not know when the xnpipe_write got
errno=3DENOMEM (the pipe_i_handler is I think even not called in case
ENOMEM is returned).  So there is I think with the current Xenomai
implementation no way for the pipe_i_handler to correctly fill in the
value of buffer_filled_up_p.  This would mean that my writer-thread
'userland' would have to set this 'variable'.
Then I was thinking about moving the <<rt_sem_p(&bsync, TM_INFINITE)>>
to the writer-thread when errno-ENOMEM is returned, but that would
require that the writer-thread has to bind the semaphore that was
created in another program.  This is probably possible via the Xenomai
registry.

Best regards,
Filip.

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: 20 August 2008 12:17
To: Filip Van Rillaer
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM

Filip Van Rillaer wrote:
> Hello,
>=20
> My current test-setup is as follows:
> 1) user-program reads test-samples from a file in non-RT and does a=20
> blocking write to the Xenomai-pipe
> 2) a RT-program that implements a V34 modem is listening to the
Xenomai-pipe and will send the data over a telephone line.
> ---> so it is the intention that at startup the Xenomai-pipe buffer
gets filled up and from than in stationary state the data should stream
at the speed of the V34 modem connection.
>

A typical work-around to emulate blocking Linux -> Xenomai pipe I/O
would be:

RT_SEM bsync;

int pipe_i_handler(RT_PIPE *pipe, int event) {
	if (event =3D=3D P_EVENT_INPUT && buffer_filled_up_p)
		/* Hold userland until buffer drains. */
		rt_sem_p(&bsync, TM_INFINITE);
	...
}

void drain_buffer(void)
{
	send_v34();
	rt_sem_v(&bsync);
}

void init_kernel_code(void)
{
	rt_sem_create(&bsync, "bsync", 0, S_PULSE); }

=3D=3D=3D

void userland(void)
{
	/* Make this regular Linux thread a non-RT Xenomai task, so it
may block on Xenomai synchronization objects. */

	rt_task_shadow(NULL, __FUNCTION__, 0, 0);

	for (;;) {
		/* This may hang in pipe_i_handler() due to flow
control. */
		write(pipefd, buf, len);
		...
	}
}

--
Philippe.


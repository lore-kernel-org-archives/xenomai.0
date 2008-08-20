Message-ID: <48ABEF11.6060307@domain.hid>
Date: Wed, 20 Aug 2008 12:16:49 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E56431F57@domain.hid>
	<48AAF55E.9000206@domain.hid>
	<406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E56431FCD@oab1mx1.oneaccess.intra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] uClinux write to pipe returning -ENOMEM
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

Filip Van Rillaer wrote:
> Hello,
> 
> My current test-setup is as follows:
> 1) user-program reads test-samples from a file in non-RT and does a blocking write to the Xenomai-pipe
> 2) a RT-program that implements a V34 modem is listening to the Xenomai-pipe and will send the data over a telephone line.
> ---> so it is the intention that at startup the Xenomai-pipe buffer gets filled up and from than in stationary state the data should stream at the speed of the V34 modem connection.
>

A typical work-around to emulate blocking Linux -> Xenomai pipe I/O would be:

RT_SEM bsync;

int pipe_i_handler(RT_PIPE *pipe, int event)
{
	if (event == P_EVENT_INPUT && buffer_filled_up_p)
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
	rt_sem_create(&bsync, "bsync", 0, S_PULSE);
}

===

void userland(void)
{
	/* Make this regular Linux thread a non-RT Xenomai task, so it may block on
Xenomai synchronization objects. */

	rt_task_shadow(NULL, __FUNCTION__, 0, 0);

	for (;;) {
		/* This may hang in pipe_i_handler() due to flow control. */
		write(pipefd, buf, len);
		...
	}
}

-- 
Philippe.


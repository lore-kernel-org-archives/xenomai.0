Message-ID: <4378D175.7010304@domain.hid>
Date: Mon, 14 Nov 2005 19:03:33 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
In-Reply-To: <OF904A8BBE.F91DE4A2-ONC12570B9.005BDDF6-C12570B9.005CB25A@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Strange pipe behaviour
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I have the following piece of code:

RT_PIPE_MSG *msg;

while ((r = rt_pipe_receive(&mypipe, &msg, TM_INFINITE)) >= 0) {
    /* whatever */
    rt_pipe_free(msg);
}

When that thread enters, it blocks, as expected, in the rt_pipe_receive
call.

Then, from user space, I do:

echo -en "\x00" > /dev/rtp0

What happens is:

1- rt_pipe_receive returns with r >= 0.
2- /* whatever */
3- Message is freed using rt_pipe_free.
4- Next call to rt_pipe_receive returns with r = -EINTR.

The only explanation I could come up with is that when the pipe is
closed by the user mode process, the rt_pipe_receive tells the rt task
by returning -EINTR. Is this right?. According to the docs, -EINTR is
only returned if rt_task_unblock() has been called...

Nacho.





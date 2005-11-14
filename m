Message-ID: <4378B824.5050708@domain.hid>
Date: Mon, 14 Nov 2005 17:15:32 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <OFBDFF2ABC.D4775297-ONC12570B9.004E7A08-C12570B9.00517F6A@datacon.at>
	<4378B391.5030306@domain.hid>
In-Reply-To: <4378B391.5030306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] More on rt pipes usage
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

Suppose I have a kernel rt task that samples data at a certain rate and
writes it as messages into a rt pipe, from which it is read by a user
space non rt program.

I want to limit the number of messages that are put into the pipe,
because otherwise if the user space program dies, it will grow endlessly
till it exausts the rt heap.

What I want to do is to have a pipe that can hold a limited number of
messages such that rt_pipe_write will fail if it is full.

Is there a way to know how many messages are there in the pipe?

Even if there is a way, to prevent a (harmless) race condition, I would
need to lock the pipe between checking the number of messages and
calling rt_pipe_write. As far as I know, pipe locking belongs to the
nucleus and I'd like to stay in the native skin as much as possible.

Another method would be to count how many messages I write, but then I'd
need some hook that notifies me when the user space program reads a
message so I can decrement the count.

Any ideas?

Nacho.


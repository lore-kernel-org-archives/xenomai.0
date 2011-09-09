From: Jeremy Friesner <jaf@domain.hid>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 9 Sep 2011 12:08:22 -0700
Message-Id: <BE5655A7-935E-4ABC-8D95-188D7D00C125@domain.hid>
Mime-Version: 1.0 (Apple Message framework v1084)
Subject: [Xenomai-help] Linux scheduling question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

In the bad old days, when I was running my software on a 233MHz PowerPC =
computer with (non-Xenomai) Linux, I could instantly hang the machine =
using the following code:

	struct sched_param schedparam;=20
	memset(&schedparam, 0, sizeof(schedparam));
	schedparam.sched_priority =3D 11;
	if (sched_setscheduler(0, SCHED_RR, &schedparam) !=3D 0) =
perror("sched_setscheduler");
	while(1) {/* spin forever, wheee! */}

To recover I would have to power-cycle, since there was no way to kill =
the spinning process.

Now my software runs on a quad-core Xeon under Xenomai, so I would =
expect that it would take four simultaneous instances of the above to =
hang the Linux layers of the machine (the Xenomai real-time bits should =
still run, of course).  However, that is not what I am seeing.... I can =
run 4, 8, or even 12 SCHED_RR (or SCHED_FIFO) spinning processes like =
the above, and my regular (SCHED_OTHER) Linux process continue to =
respond (albeit sometimes rather slowly).

Can anyone hazard a guess as to why I'm unable to spin my Linux OS to =
death?  I'm curious... :^)

Jeremy



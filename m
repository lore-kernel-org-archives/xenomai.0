Message-ID: <BAY135-W5F4633CFE181E5E1DFB22C6B20@domain.hid>
From: Thomas Schaefer <thomas_schaefer_canada@domain.hid>
Date: Wed, 18 Feb 2009 18:18:53 -0700
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] rt_task_create with mode T_CPU(1)
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


Hi=2C

I did some testing with the very latest Xenomai svn repository and kernel 2=
.6.28.2 on a quad core xeon arch X86_64.

Until a few days ago everything seemed to work just fine.
Now a task created with T_CPU( anything but 0) doesn't start after rt_task_=
start is called.
I modified the trivial-periodic example and changed the mode to T_CPU(1).
Now the example doesn't work anymore. It works unmodified or with T_CPU(0).

I was wondering if I missed a change that would explain this behavior or if=
 this is a bug?

Thomas



_________________________________________________________________



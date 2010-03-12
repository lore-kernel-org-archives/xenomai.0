From: Huan Fang <huanf@domain.hid>
Date: Fri, 12 Mar 2010 19:21:42 +0100
Message-ID: <B66DE711C138E84F96E6A2EDD078830B5F2A4D39CB@MAIL02.ug.kth.se>
Content-Language: en-GB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] RTDM rtdm_task_sleep in kernel not always wakes up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello. I am writing a driver using RTDM. Just for testing, I have a rt kern=
el thread waiting for event signal sent from nrt_ioctl. After the thread is=
 activated, it calls
 rtdm_task_busy_sleep(100000); then
 rtdm_task_sleep(100000);
 When the RT thread is really sleeping, the nrt_ioctl resumes and sleeps vi=
a wait_event_interruptible_timeout(2 jiffiles).

Normally, RT thread wakes up after 100us. But the thread seems to hang afte=
r 20-30 such loops and never wake up.=20
When I kill the process. I saw that wait_event_interruptible_timeout return=
s a -512.=20
The worse thing is I saw kernel panic sometimes during such context switche=
s.

Huan=


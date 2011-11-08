Message-ID: <51962.81.220.196.189.1320786408.squirrel@domain.hid>
Date: Tue, 8 Nov 2011 22:06:48 +0100 (CET)
From: "Olivier Reynet" <olivier.reynet@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Xenomai 2.5.6 and Round Robin
Reply-To: olivier.reynet@domain.hid
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

Hi,
Is it possible to set RR mode with the following functions ??
rt_task_set_mode(0,T_RRB ,NULL);
rt_task_slice(task_descr,quantum)
I have tried with Xenomai 2.5.6, but compiler says that T_RBB is not know=
n.
Have you got any clue ?
Olivier






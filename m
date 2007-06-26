Message-ID: <15cf230500002197@domain.hid>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Jun 2007 17:01:41 +0200
Message-ID: <81B5F1E63FF64C458F503BD1839AD784145486@domain.hid>
From: "Gsellmann Peter" <Peter.Gsellmann@domain.hid>
Subject: [Xenomai-help]  accessing context switch counter from rttask
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

Hi!

I searched for a while and found this snippet

RT_TASK *rt =3D rt_task_self();
int x =3D rt->thread_base.stat.csw;

should give the number of context switches, but:
RT_TASK in non-kernel mode is only RT_TASK_PLACEHOLDER so i have no
access to thread_base!

Is there an official way to get this info (w/o opening
"/proc/xenomai/...")?


TIA,
Peter


Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 5 Jul 2006 13:50:51 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3BD0B3@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
Subject: [Xenomai-help] delete queues "offline"; /proc/stat
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

when a xenomai-task crashs which created some queues (rt_queue_create)
and I try to restart the task the creation of the queues will fail as
the queue still exists (error EEXIST =3D=3D 17). Is there a possibility =
to
see which queues exist (I did not find a hint in the /proc/xenomai
directory) and to get rid of these queues (or geneally spoken : to get
rid of allocated resources) e.g. with a commandline tool ?

An other question, I would appreciate some help for, is :
How could I determine the CPU-load when a xenomai thread is running? Is
the data provided by /proc/stat valid with xenomai ?

Thank you in advance and best regards
Roderik




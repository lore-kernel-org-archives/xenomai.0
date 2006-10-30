Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] InterProcessCommunication between Xenomai
	taskand	Linux process
Date: Mon, 30 Oct 2006 10:02:02 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A5FFB1C@ARVMAIL1.mra.roland-man.biz>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org

> Roderik_Wildenburg@domain.hid wrote:
> > Is there a standard way for communication between nativ Linux=20
> > processes and Xenomai task which ensures that the Xenomai task does=20
> > not lose its raltime capability (e.g. can I use Xenomai=20
> (Posix)-queues=20
> > within Linux processes ?).
> > I just need a hint, where I can read about it.
>=20
> Xenomai POSIX messages queues can only be used by Xenomai=20
> tasks, but Xenomai tasks do not switch to secondary mode when=20
> using POSIX messages queues. Note that when using the POSIX=20
> skin, all tasks are Xenomai tasks, the SCHED_OTHER policy=20
> being reserved to non-realtime task.

How do I use "POSIX messages queues" and not "Xenomai POSIX messages
queues" within a Xenomai task. Do I have to use the real_-prefix (e.g.
real_mq_open()) ?
Can a Xenomai-task-queues and a Linux-process-queues use the same queue
name (Linux: mq_open("queuename",..) and Xeno:
real_mq_open("queuename",....) (or can I even use
mq_open("queuename,.)in Xenomai)) ?
Please vorgive these stupid questions, but I never worked with POSIX
queues before.
Thanks a lot.


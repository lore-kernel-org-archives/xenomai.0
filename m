Date: Mon, 30 Jan 2012 22:40:03 -0800 (PST)
From: "Doug Brunner" <dbrunner@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1327992003.514524717@domain.hid>
Subject: [Xenomai-help] =?utf-8?q?Sharing_of_access_to_RT=5FMUTEX=2C_RT=5F?=
	=?utf-8?q?QUEUE=2C_and_RT=5FTASK?=
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

I'm working on an application where it would be convenient for several task=
s within the same process to share access to single descriptors for mutexes=
, queues, and tasks, rather than each task having to separately bind to eac=
h one and keep its own RT_MUTEX/RT_QUEUE/RT_TASK.=0A=0AThe documentation do=
esn't seem to speak to this issue, and I haven't been able to find a defini=
tive answer through searches. Can anyone clarify whether or not this will l=
ead to problems, e.g. task A is in the midst of locking a mutex when task B=
 starts trying to obtain a lock itself, and bad results occur?=0A=0AThanks,=
=0A    Doug Brunner



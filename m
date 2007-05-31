content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 May 2007 15:08:35 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C6032202CB@FR0-MAILMB20.res.airbus.corp>
From: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Subject: Re: [Xenomai-help] [Newbie question] threads and task CPU affinity
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi,

I'm still blocked on a CPU affinity problem.
In order to adapt a set affinity function which is based on
posix linux lib :
- CPU_AssignPID(uint32 PID, uint32 CPU_id)
- the cpu affinity of the caller and all its child threads must be set to C=
PU_id.

Problems are:
Child PIDs must be listed, the only means I found is listing pids using `ls=
 /proc/"Parent pid"/ > temp_file`
And each listed pid is sched_setaffinity'ed.
I don't know if setting affinity of RT threads from an other thread (parent=
) using pid works with xenomai.

So, my question is :
With xenomai, is recursively cpu affinity setting from a parent thread, a g=
ood way of doing ?
I read switchtest program, and I conclude that in a xenomai and RT perspect=
ive, it seems "nicer"
to set affinity each threads separately during their init phase before the =
RT infinite loop.
Otherwise, setting affinity after child threads creation from its parent, m=
ay switch them into=20
secondary mode during their RT loop, and at an unknown moment.
Argumentation is important for my internship because I have to port on xeno=
mai a very big RT=20
posix based application. And I should justify any modifications and prevent=
 potential problems.

Sorry, I don't know if it is clear.

Thanks in advance, Niry.

This e-mail is intended only for the above addressee. It may contain privil=
eged information.
If you are not the addressee you must not copy, distribute, disclose or use=
 any of the information in it.=20
If you have received it in error please delete it and immediately notify th=
e sender.
Security Notice: all e-mail, sent to or from this address, may be accessed =
by someone other than the recipient, for system management and security rea=
sons. This access is controlled under Regulation of security reasons.
This access is controlled under Regulation of Investigatory Powers Act 2000=
, Lawful Business Practises.




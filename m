content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 May 2007 16:51:20 +0200
Message-ID: <5C40CD1E4697424ABDE3AC57CF1B22C6032202C5@domain.hid>
From: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Subject: [Xenomai-help] [Newbie question] threads and task CPU affinity
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

Hello,

I have some question about CPU affinity with Xenomai 2.3.1.
(it is to see if  xenomai support developing for a cpu manager library is f=
easible)

When using rt_task_create, CPU mask can be specified. However, when sched_s=
etaffinity is called=20
to modify main program affinity, and after, rt_task_create is called withou=
t specifying CPU mask,
did the child task inherits from the main program affinity ?

Same question for Posix skin threads ?

Can native task affinity be set other than when creating ? using sdhed_seta=
ffinity ?

Can posix skin thread affinity be set using sched_affinity ?


Thanks in advance.

Niry.

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




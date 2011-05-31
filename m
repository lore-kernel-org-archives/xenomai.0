Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 May 2011 10:34:17 +0200
Message-ID: <3FF315C710820E47A04E55C6F7D9B0AD78FA33@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: [Xenomai-help] UDP-receive-task stalls
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

We face the problem that a Xenomai task which receives UDP-packets
(secondary mode recvfrom()) on a high frequency ( every 50ms approx.
1200 Byte) stalls sporadically (few times a day). In this case the
ROOT-task permanently shows the priority of the stalled task, the
receive queue of the stalled task fills up (netstat -u) , the task never
comes to live again . Attaching gdb or strace to this task stalls these
tools also. Other tasks and Linux run as expected even other UDP-receive
tasks!
Any idea what can cause this problem or how we can debug the stalled
task? (I think we had a similar problem with select() I presented in
this list).
We use:
- Linux 2.4.25 PPC=20
- Xenomai 2.4.9

Any help appreciated!
Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933



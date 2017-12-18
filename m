From: Lange Norbert <norbert.lange@andritz.com>
Date: Mon, 18 Dec 2017 13:43:10 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB018DE50579@GRZSMS582.andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Weird behavior during debug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Hello,

I tried debugging a cobalt application, and when I hit a breakpoint most of=
 the system freezes.
If I run for example top over Serial or SSH, then the display won`t be refr=
eshed anymore,
A separate program running as RT Task, waiting for an timer-event (occurrin=
g 10 times a second) will block aswell.

So the debug session seems to block a rather big amount of events.

I am using a 4.9 kernel with ipipe at "x86/ipipe: fix detection of unhandle=
d faults over the head domain".
Looking at the logs and other threads there seems to be a bigger rework in =
progress?
I will retry with master, and report back.

Kind regards

Norbert Lange

________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=C3=A4nkter Haftung / Corpor=
ation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________


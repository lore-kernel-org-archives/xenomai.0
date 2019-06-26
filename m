From: Lange Norbert <norbert.lange@andritz.com>
Subject: Waking up threads from the other xenomai/linux domain
Date: Wed, 26 Jun 2019 11:05:02 +0000
Message-ID: <VI1PR05MB59174B1FCCC4A8B782A2EEEDF6E20@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

I have multiple threads, one of them is realtime, one other is responsible =
for controlling the service.

The controlling thread blocks on some linux sockets, the realtime one has a=
 select on a RT socket and a timeout.

I now have the problem that I need to wake up the other thread under some c=
ircumstances, not always (then I would just poll),
but potentially in regular burst (forwarding packets).
>From the docs, XDDP seems the only solution, I wonder if there are more.

1) Connect the threads with a XDDP socket, add the fd in the select calls.
2) Atleast when Linux is waking up Xenomai, I could use an IDDP/BUFP socket=
 with the linux thread then being promoted for the duration of the call.
3) Signals? Could they be used to interrupt the select (both linux and coba=
lt variant)?. The POSIX skin has no pselect so I wonder how I would make su=
re the signal
is only delivered during select

All the RTIPC sockets seem to use a global pool of ports, and I believe XDD=
P to be rather heavyweight.I am looking for an efficient way (in total CPU =
time) to unblock a thread,
It does not need to have lowest latency.

(Note that this is in the same process, so I would prefer something like so=
cketpair to open up an anonymous "pipe" not feeding from global ports).


Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE
AT-DES

ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Vienna / AUSTRIA
p: +43 50805 56684
norbert.lange@andritz.com
andritz.com
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


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________


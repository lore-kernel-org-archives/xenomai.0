From: Lange Norbert <norbert.lange@andritz.com>
Subject: Impact and use of the membarrier syscall
Date: Mon, 25 Nov 2019 09:31:52 +0000
Message-ID: <VI1PR05MB5917198E23A5251C3794E4C2F64A0@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

I looked at this sycall, as lttng makes use of it, and the last posts on th=
is ML would imply that Xenomai is using "IPI" aswell.
This raises a few questions:


-          Could an linux app (like lttng), that uses the membarrier syscal=
l create IRQs/IPIs that ultimately negative affect realtime threads?
Ie. should this be kernel config be recommended to be disabled for Xenomai.

-          Does the syscall do anything for running Xenomai threads (partic=
ularly, Lttng makes use of MEMBARRIER_CMD_PRIVATE_EXPEDITED).

Regards, Norbert
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


Rechtsform/ Legal form: Gesellschaft mit beschr?nkter Haftung / Corporation

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________

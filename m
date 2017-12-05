From: Lange Norbert <norbert.lange@andritz.com>
Date: Tue, 5 Dec 2017 14:38:08 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB018DE4C73A@GRZSMS582.andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] RTDM/RTNet - proposal to support sending/receiving
 multiple packets with one systemcall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>

Hello,

I would like to involve the RTDM Maintainers for discussing an addition to =
the RTDM drivermodel.
This work would be done by Phillipe Gerum as part of a contract, he is also=
 better suited to outline the necessary changes,
should nothing stand against the proposal itself.

- Problem description

To be compatible with existing software, Ethernet packets will be polled at=
 synchronized events.
The application ideally would give the kernel/rtnet stack the responsibilit=
y and freedom to do this in an efficient manner,
and be able to directly express the intend to poll all currently available =
packets.

Similarly, but less time-critical thus important, sending multiple packets =
in a burst would be a requirement.

Lastly Linux has this functionality in form of recvmmsg and sendmmsg,
which would be a good fit in terms of existing interface, atleast if used i=
n non-blocking mode.

- Hypothetical Proposal

Adding the necessary interfaces to RTDM and RTNet
to allow non-blocking bulk receive/send, and offering functions not unlike =
the mentioned recvmmsg and sendmmsg.

- Potential issues

Copying of multiple packets would be done in RTDM context, potentially bloc=
king resources for each packet or the whole duration.
For our usecase it would for example not matter if the involved ethernet dr=
iver instance is not able to handle IRQs during this time,
but it should not significantly affect worst-case task switch times in gene=
ral, or block reception on other physical interfaces (Ethernet or otherwise=
).

recvmmsg and timeouts (blocking) are likely to be problematic, but blocking=
 mode is not required or wanted.

- Open questions to the RTDM maintainers

What would be the requirements of adding similar functionality to recvmmsg =
to RTNet / RTDM,
and would there be any caveats that would prohibit addition from side of th=
e RTDM maintainers?

Other than that, a mmap based approach is also an option, but that's a some=
what more involved solution for both kernel and userspace as far as I under=
stood.

Kind regards

Norbert Lange


###########################################################################=
##########
This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.
Thank You.
  ANDRITZ HYDRO GmbH
  Rechtsform/ Legal form: Gesellschaft mit beschr?nkter Haftung / Corporati=
on
  Firmensitz/ Registered seat: Wien
  Firmenbuchgericht/ Court of registry: Handelsgericht Wien
  Firmenbuchnummer/ Company registration: FN 61833 g
  DVR: 0605077
  UID-Nr.: ATU14756806
###########################################################################=
##########



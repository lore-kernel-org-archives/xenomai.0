From: Lange Norbert <norbert.lange@andritz.com>
Subject: Kernel module symbol conflicts
Date: Thu, 28 Mar 2019 15:12:57 +0000
Message-ID: <0fe3471eadf34083b9de1b766c327c72@andritz.com>
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

We use a setup with multiple network controllers, and so far only one of th=
em is realtime capable.
The issue is, that there are nonRt and Rt drivers active at the same time (=
igb statically builtin and rt_igb as module).

And while it works, I got some irregular weird crashes. Is there an issue w=
ith the loaded rt_igb module having a lot symbols
that are identically named with the igb driver?

Does that mean the rt_igp module will use the exported functions/variables =
from the igb driver,
as a normal dynamic linker would?

Whats the policy of xenomai, should this even work (igp and rt_igp at the s=
ame time)?

Example of conflicting symbols:

# cat /proc/kallsyms | grep ' T igb_config'
ffffffff94f3b2e0 T igb_configure_tx_ring
ffffffff94f3b6f0 T igb_configure_rx_ring
ffffffff94f49c30 T igb_config_collision_dist
ffffffff94f49d50 T igb_config_fc_after_link_up

# nm /lib/modules/4.14.94-xeno2-static/kernel/drivers/xenomai/net/drivers/i=
gb/rt_igb.ko | grep ' T igb_config'
0000000000004db0 T igb_config_collision_dist
0000000000004eb0 T igb_config_fc_after_link_up
000000000000dd60 T igb_configure_rx_ring
000000000000d9f0 T igb_configure_tx_ring



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


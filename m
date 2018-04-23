From: Lange Norbert <norbert.lange@andritz.com>
Date: Mon, 23 Apr 2018 09:01:40 +0000
Message-ID: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0D9B1@GRZSMS582.andritz.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] [PATCH] fix out-of-bounds access
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Fix an invalid memory access in the testsuite.

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 testsuite/smokey/net_common/smokey_net_server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/net_common/smokey_net_server.c b/testsuite/sm=
okey/net_common/smokey_net_server.c
index a0ed52fd9..2e19208e7 100644
--- a/testsuite/smokey/net_common/smokey_net_server.c
+++ b/testsuite/smokey/net_common/smokey_net_server.c
@@ -89,7 +89,7 @@ rtnet_rtcfg_add_client(int fd, const char *hwaddr, const =
char *ipaddr)
        cmd.args.add.ip_addr =3D ip.s_addr;
        cmd.args.add.timeout =3D 3000;
        memcpy(cmd.args.add.mac_addr, mac.ether_addr_octet,
-               sizeof(cmd.args.add.mac_addr));
+               sizeof(mac.ether_addr_octet));

        check_unix(ioctl(fd, RTCFG_IOC_ADD, &cmd));
 }
--
2.17.0

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


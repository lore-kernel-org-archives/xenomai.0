From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Apr 2010 12:28:48 +0200
Message-Id: <5bc8a9f46c6a1b27f58f516ce789692ff5f485ab.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271672940.git.jan.kiszka@domain.hid>
References: <cover.1271672940.git.jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH v4 08/25] RTCAN: Drop support for socket
	creation/deletion in real-time
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is deprecated now, RT callers will automatically be migrated to
NRT to perform the requests.

CC: Wolfgang Grandegger <wg@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/drivers/can/rtcan_raw.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/ksrc/drivers/can/rtcan_raw.c b/ksrc/drivers/can/rtcan_raw.c
index 0cf0bb9..9ee0950 100644
--- a/ksrc/drivers/can/rtcan_raw.c
+++ b/ksrc/drivers/can/rtcan_raw.c
@@ -999,11 +999,9 @@ static struct rtdm_device rtcan_proto_raw_dev = {
     protocol_family:    PF_CAN,
     socket_type:        SOCK_RAW,
 
-    socket_rt:          rtcan_raw_socket,
     socket_nrt:         rtcan_raw_socket,
 
     ops: {
-        close_rt:       rtcan_raw_close,
         close_nrt:      rtcan_raw_close,
 
         ioctl_rt:       rtcan_raw_ioctl,
-- 
1.6.0.2



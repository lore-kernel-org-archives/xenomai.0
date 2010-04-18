From: Jan Kiszka <Jan Kiszka jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 15:12:32 +0200
Message-Id: <eb8a9c34d4e9a977ec209069e55fa965b4357692.1271596367.git.Jan
	Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
In-Reply-To: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
References: <cover.1271596366.git.Jan Kiszka jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH v3 08/24] RTCAN: Drop support for socket
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

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



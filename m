Subject: [PATCH 6/4] drivers/net/igb: Make sure CONFIG_IGB_HWMON is off
References: <cover.1618127660.git.jan.kiszka@web.de>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <e53d291e-6e20-e39b-521c-c121f7492afd@web.de>
Date: Sun, 11 Apr 2021 12:09:14 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1618127660.git.jan.kiszka@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

We better exclude this code path due to unknown impact on RT.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 kernel/drivers/net/drivers/igb/igb.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/drivers/net/drivers/igb/igb.h b/kernel/drivers/net/dri=
vers/igb/igb.h
index 16fb5e2ed4..4c65e31c35 100644
=2D-- a/kernel/drivers/net/drivers/igb/igb.h
+++ b/kernel/drivers/net/drivers/igb/igb.h
@@ -39,6 +39,8 @@

 #include <rtdev.h>

+#undef CONFIG_IGB_HWMON
+
 struct igb_adapter;

 #define E1000_PCS_CFG_IGN_SD	1
=2D-
2.26.2


From: Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v4 4/8] drivers/can: add CAN_ERR_CRTL_ACTIVE info status
Date: Sun, 12 Dec 2021 12:56:07 +0100
Message-Id: <20211212115611.3036-4-dariobin@libero.it>
In-Reply-To: <20211212115611.3036-1-dariobin@libero.it>
References: <20211212115611.3036-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Wolfgang Grandegger <wg@grandegger.com>, Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Dario Binacchi <dariobin@libero.it>, Gianluca Falavigna <gianluca.falavigna@inwind.it>

To be used in case of recovered to error active state.

Signed-off-by: Dario Binacchi <dariobin@libero.it>
---

(no changes since v1)

 include/rtdm/uapi/can.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/rtdm/uapi/can.h b/include/rtdm/uapi/can.h
index 8d0d837d5..1c35a9b9d 100644
--- a/include/rtdm/uapi/can.h
+++ b/include/rtdm/uapi/can.h
@@ -837,6 +837,7 @@ struct can_ifreq {
 #define CAN_ERR_CRTL_TX_WARNING	 0x08 /**< reached warning level for TX errors */
 #define CAN_ERR_CRTL_RX_PASSIVE	 0x10 /**< reached passive level for RX errors */
 #define CAN_ERR_CRTL_TX_PASSIVE	 0x20 /**< reached passive level for TX errors */
+#define CAN_ERR_CRTL_ACTIVE	 0x40 /**< recovered to error active state */
 /** @} */
 
 /*!
-- 
2.17.1



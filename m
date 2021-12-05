From: Dario Binacchi <dariobin@libero.it>
Subject: [PATCH v3 3/7] drivers/can: add CAN_ERR_CRTL_ACTIVE info status
Date: Sun,  5 Dec 2021 21:45:14 +0100
Message-Id: <20211205204518.13259-3-dariobin@libero.it>
In-Reply-To: <20211205204518.13259-1-dariobin@libero.it>
References: <20211205204518.13259-1-dariobin@libero.it>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: "Stephen J . Battazzo" <stephen.j.battazzo@nasa.gov>, Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, Dario Binacchi <dariobin@libero.it>, Michael Trimarchi <michael@amarulasolutions.com>, Gianluca Falavigna <gianluca.falavigna@inwind.it>, Wolfgang Grandegger <wg@grandegger.com>

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



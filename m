From: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
Subject: [PATCH][xenomai-images] start-qemu.sh: detect if DISPLAY is set
Date: Thu, 22 Nov 2018 21:43:48 +0100
Message-Id: <20181122204348.17730-1-holzmayr@rsi-elektrotechnik.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: jan.kiszka@siemens.com
Cc: xenomai@xenomai.org, Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>

If DISPLAY is not set and therefore the SDL-based
GUI of QEMU is most likely to fail, we resort to the
-nographic variant.

Signed-off-by: Josef Holzmayr <holzmayr@rsi-elektrotechnik.de>
---
 start-qemu.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index 3d1117e..0daf69c 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -63,6 +63,10 @@ IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
 KERNEL_FILE=$(ls ${IMAGE_PREFIX}.vmlinuz* | tail -1)
 INITRD_FILE=$(ls ${IMAGE_PREFIX}.initrd.img* | tail -1)
 
+if [ -z "${DISPLAY}" ]; then
+	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
+fi
+
 shift 1
 
 ${QEMU_PATH}${QEMU} \
-- 
2.19.1


-- 
_____________________________________________________________
R-S-I Elektrotechnik GmbH & Co. KG
Woelkestrasse 11
D-85301 Schweitenkirchen
Fon: +49 8444 9204-0
Fax: +49 8444 9204-50
www.rsi-elektrotechnik.de

_____________________________________________________________
Amtsgericht Ingolstadt - GmbH: HRB 191328 - KG: HRA 170363
Gesch���ftsf���hrer: Dr.-Ing. Michael Sorg, Dipl.-Ing. Franz Sorg
USt-IdNr.: DE 128592548



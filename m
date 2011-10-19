Sender: Thomas De Schampheleire <patrickdepinguin@domain.hid>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <0db9974c036abae53f74.1318861190@domain.hid>
In-Reply-To: <patchbomb.1318861189@domain.hid>
References: <patchbomb.1318861189@domain.hid>
Date: Wed, 19 Oct 2011 09:35:13 +0200
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Subject: [Xenomai-help] [PATCH 1 of 4] psos.h: add definition of ERR_OBJTFULL
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire@domain.hid>
Signed-off-by: Ronny Meeus <ronny.meeus@domain.hid>

---
 include/psos/psos.h |  1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/psos/psos.h b/include/psos/psos.h
--- a/include/psos/psos.h
+++ b/include/psos/psos.h
@@ -97,6 +97,7 @@
 #define ERR_OBJDEL   0x05
 #define ERR_OBJID    0x06
 #define ERR_OBJTYPE  0x07
+#define ERR_OBJTFULL 0x08
 #define ERR_OBJNF    0x09
 
 #define ERR_NOTCB    0x0E



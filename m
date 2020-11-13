From: "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>
Subject: [PATCH 1/3] cobalt uapi: Introducing new feature flag for settime64
 availability
Date: Fri, 13 Nov 2020 12:00:05 +0000
Message-ID: <20201113115932.276959-2-florian.bezdeka@siemens.com>
References: <1229be33-848d-ab5b-d6dd-1b7ae38d36f9@siemens.com>
 <20201113115932.276959-1-florian.bezdeka@siemens.com>
In-Reply-To: <20201113115932.276959-1-florian.bezdeka@siemens.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "chensong@tj.kylinos.cn" <chensong@tj.kylinos.cn>

From: Florian Bezdeka <florian.bezdeka@siemens.com>

Adding a new feature flag to allow the library asking for settime64
support. That will allow the library to use the new system call if it
is available / supported by the kernel.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 include/cobalt/uapi/asm-generic/features.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/cobalt/uapi/asm-generic/features.h b/include/cobalt/ua=
pi/asm-generic/features.h
index 8a4927c49..93a96670a 100644
--- a/include/cobalt/uapi/asm-generic/features.h
+++ b/include/cobalt/uapi/asm-generic/features.h
@@ -51,6 +51,7 @@ struct cobalt_featinfo {
 #define __xn_feat_nofastsynch 0x10000000
 #define __xn_feat_control     0x08000000
 #define __xn_feat_prioceiling 0x04000000
+#define __xn_feat_settime64   0x02000000
=20
 #ifdef CONFIG_SMP
 #define __xn_feat_smp_mask __xn_feat_smp
@@ -70,7 +71,8 @@ struct cobalt_featinfo {
 #define __xn_feat_generic_mask			\
 	(__xn_feat_smp_mask		|	\
 	 __xn_feat_fastsynch_mask 	|	\
-	 __xn_feat_prioceiling)
+	 __xn_feat_prioceiling		|	\
+	 __xn_feat_settime64 )
=20
 /*
  * List of features both sides have to agree on: If userland supports
@@ -101,6 +103,8 @@ const char *get_generic_feature_label(unsigned int feat=
ure)
 		return "control";
 	case __xn_feat_prioceiling:
 		return "prioceiling";
+	case __xn_feat_settime64:
+		return "settime64";
 	default:
 		return 0;
 	}
--=20
2.26.2


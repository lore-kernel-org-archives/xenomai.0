From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  8 Jul 2010 12:18:15 +0200
Message-Id: <1278584301-8064-2-git-send-email-wolfgang.mauerer@domain.hid>
In-Reply-To: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
References: <1278584301-8064-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 1/7] nucleus: Spelling fix for check-vdso.c
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: jan.kiszka@domain.hid, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 src/testsuite/unit/check-vdso.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/testsuite/unit/check-vdso.c b/src/testsuite/unit/check-vdso.c
index 8f90420..17684de 100644
--- a/src/testsuite/unit/check-vdso.c
+++ b/src/testsuite/unit/check-vdso.c
@@ -15,7 +15,7 @@ int main(int argc, char **argv)
 	unsigned long long test_features;
 
 	if (argc != 2) {
-		printf("No specific feature(s) given, using XNVDSO_FEATURE\n");
+		printf("No specific feature(s) given, using XNVDSO_FEATURES\n");
 		test_features = XNVDSO_FEATURES;
 	} else {
 		test_features = strtoull(argv[1], NULL, 0);
-- 
1.6.4



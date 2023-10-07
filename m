Received: from out198-28.us.a.mail.aliyun.com (out198-28.us.a.mail.aliyun.com [47.90.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7428473
	for <xenomai@lists.linux.dev>; Sat,  7 Oct 2023 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1016121|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00247655-8.10347e-05-0.997442;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=liyinjie@sinsegye.com.cn;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.UvEOOqO_1696677598;
Received: from localhost.localdomain(mailfrom:liyinjie@sinsegye.com.cn fp:SMTPD_---.UvEOOqO_1696677598)
          by smtp.aliyun-inc.com;
          Sat, 07 Oct 2023 19:20:10 +0800
From: liyinjie <liyinjie@sinsegye.com.cn>
To: xenomai@lists.linux.dev
Cc: liyinjie <liyinjie@sinsegye.com.cn>
Subject: [PATCH] commands/evl: improve argument of help
Date: Sat,  7 Oct 2023 19:19:15 +0800
Message-Id: <20231007111914.1351049-1-liyinjie@sinsegye.com.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enter the command `evl --help`, output

usage: evl [options] [<command> [<args>]]
-P --prefix=<path>   set command path prefix
-v -V --version      print library and required ABI versions
-h --help            this help
evl: no 'help' command. Try 'evl --help'.

This patch will fix incorrect output "evl: no 'help' command. Try 'evl --help'.".

Signed-off-by: liyinjie <liyinjie@sinsegye.com.cn>
---
 utils/evl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/utils/evl.c b/utils/evl.c
index 0254cad..79cf5ec 100644
--- a/utils/evl.c
+++ b/utils/evl.c
@@ -96,7 +96,9 @@ int main(int argc, char *const argv[])
 			exit(0);
 		case 'h':
 			cmd = "help";
-			break;
+			usage();
+
+			exit(0);
 		case '?':
 			usage();
 			return 2;
-- 
2.25.1


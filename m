Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AD7233922
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601946; cv=fail; b=ufu7Ra0gcBCez7sSJbssaEylGBgA4abaaSVO/Lt74Py1+LvtMAPOtAIsUFpk+YbTQmaGNHmqPZyGTvUkcnHb4qg4Tjm3xsDTPnESO6fuazj4gC+VBwEDtPleW1ww1IMPG5kvdVwQrCBp2LxNPHmdWw+2CVO9s1rTStp5yYa3auI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601946; c=relaxed/simple;
	bh=htmTgE/C4cD1/TNqk+1ikJTqsjNkhCld2igg68shBPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fG3j0xURZFcht2caHmyyI2PO84e4CtVW95ecSN24bfv3SknXDIOoctx5Pmdrn3ySVApeYKiOT86Zwt+zh5avKHtVZFH6ZhwNkUGxz+iP1yQMzw7FL2IsX8RX1jpO9cDvI3DsUF8aLYuO/FKTJlp66uzYAvunL+ewArzv2UTHfQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=M+5Kw+SB; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="M+5Kw+SB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5l4afsgUuJlTg4OUGSs9Z0Q+Eo1JEloIW1rakMLkjzjBuz5ZXwv4BAO2lNStwgJ+FTgL5s1mEetK024g6WiObVCCDt45wx+NxVo/s1AHbkTSbOmwWq6I6MPQf3ioyJIoLGWgALWHWf0an9JEWXbjqhBNyvXTF6WwM6BwxiOqJ6qaXblxUgLizSd+7Qo7wCXjB17t6DMtaleVfuYAoRWNwogW8lWa1DLxErWOSZMMWXiwrdXgcZDuKfwHPI4Doe0rpPC5vzs8Mh7HgWMlVkqnsOzBbMWTPGAMPDXy09OKdxZnvhzx/gGPGw56ADTU63PXOK6gla8vVVqJBOhvunCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYrQVZucnAWjCWR/owNuPkTwIiDHrrKo+qhGVPQGeNk=;
 b=qnSAXMaY+XbA+rk0CYtCYhLsweypFcI9vHvEYZTSH81I10fJqUxOWB9k79B6iJSY01CCpkAJuQrSH7wkdjgj4VPG640PF8xtxYyIOH93JvylpDMv2xR7y1bfKt2bagQ6j8isKQyjW7JEM0+/UfarbhKHoIfFTRQ3PVdeO6bMH7oLRtJk0CMH3dkh2uNvLyNUeqReuoqD1CdzX+0Ye7p3YLjQB4lIiIZIU5wIrIXX/I8b0xyvHseVkhxX+U7hhxvBTTt4k75hyz8ImO35sw1t2wTwk5b7521OQtdlQAHBItS2p3PKV5As5shSikubqJJyQhJS7U/wgtoQXi8RRSWYxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYrQVZucnAWjCWR/owNuPkTwIiDHrrKo+qhGVPQGeNk=;
 b=M+5Kw+SBd1SOpNmz0ND5OeFd6/tYC8b9ZJyAoeQclaTQyPgswwwal7gTV9B4KlYRRabsy4ZhFrgggnHGRfh+AzHVFkDwHTo78UPlwIm1TodcJEomIeR4IrlRctFE5rLWfP3UCFyBL5FpC11n4sESB7OZvSAmF2IARVJZMcxeEN5rUnvv5u7F6SsShm5xgJVHeVgLug37PiBBjW2gNanJ7nAneVd9LiQ6KlA8u1cf3V3VFjMngB5QWGlYqAwvoc3C9dWREwzMVecQiIYlJPc+SRA+WLinKXU7C/IUGqdqnDigP9ozQh+qLZEYF3CH2KHKDyX0EOt0q1kTSlU58zlfTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI0PR10MB9466.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 9 Jul
 2026 12:59:01 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:59:01 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl] tests: skip sched-tp-overrun in virtual environments
Date: Thu,  9 Jul 2026 14:58:51 +0200
Message-ID: <20260709125851.173262-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0404.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI0PR10MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf37d39-310f-4704-71a5-08deddb9d8cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|55112099003|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	W9nJz0e5CVNEI1cZr0ecwgAlZCgs0S9FCjaXsuatx+Nhzg3KYp9KpgYRaUtSBxdB0MylT5ZiexUj7x7OH+uELrDeaTCNL0H9mvu+vYalpVTEy6nkWs0rZqmyKtx//CPJnj92+gVyjl8iDPhKUvwdFQdGdtuN+eNGcsAVctyPECgjm6IIVEX726O9I7hCEE/evyyzcDPiw1RaW2xEXIV/9aTt/SjhF5QgW7fTalOYB0A4hUmx/XocTVXdi7JT61PR/jw+9TgHzjypt1h0Ck9kWvmifZ8CRGM5f42A41ZFGFXl13sU3zfOx3fM8PJklCj1PJMpB4OjMKxcC/vkzsIB/QoupbnImETzTMTeS1axUDSSnWUbCFRRX9EttB8pa7bYG33+6O3gZ+TnONC23j6675+Q9aB2+XxUEcgW6XKarPDUTRd0i82id83r8eR12fZxOpKNkN8EBeIYivrZdg85EaNBQyhf8unWpzqMp5RblhroKuCJXiAwtcCVZlkgmC+D+bcQLYfKDIAyIy/28UNbOFdFTu5p4UKlEqWeLNWynUtCj+J95Go/6+n+AorDjSzKmX3ZHy+7rQGBQdRvSHFz5GNb43xQLkgF7Q9hOde0KT4Lw4gvJ0G5OtgZEvd5IjXZKKhbOKJmmqlDsurZuA2/rOVK7JnovABYmr5KvLFsQyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(55112099003)(11063799006)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jRF3XK8504EPveGNpHBGszkcz1rtBV66qVcaAk/fuqZ722g0X6JcW3wemFte?=
 =?us-ascii?Q?YHyW9tvZuLm1AKPOkOlks+hC6DR4AeE2uy7dLbqOFqBmmnprENV/AJfbB4+x?=
 =?us-ascii?Q?wcBfICbIQqug//00YF7ZjgRClTSV/rEcGNXbfVGGfG4wF+H0A/bwEeT4h1Cd?=
 =?us-ascii?Q?THIL/xsUEkiVq+YgvGp+UetrkR+XuwP7+90pC1oPknkrS1WI40NR3NrqAbt4?=
 =?us-ascii?Q?TTXC9jlFPX1vnAYMdxpIg4hh3lUu3hdeLAPoNLYJDxTnCwraHX4V6hcdLPna?=
 =?us-ascii?Q?H9dF2BhRRfYQJh7i9NKLVx31Rp2wgFCEIncY/iQOd3t6CcM4iG0NeXPy4RvJ?=
 =?us-ascii?Q?Qjr6tzMfJsbwb17LgIhnR+TDgvE9mt/wn68vEtI2H+GRtmILzCtsoKK683kc?=
 =?us-ascii?Q?R0UjHLxKbGI9KjcN/kFPSEms96yWrmCNbKaTkn4m0P2pjljbh1PsE6QuGFT9?=
 =?us-ascii?Q?oOGz4enSNa96FAOuK395q5lsisJ2uoll6KMDbVs5lCEQMy77sI0QJQP20RXi?=
 =?us-ascii?Q?dDty4mXMtobJoMoLv7wqgwBqcq3QJKQJyHc8OQ0Jz3HLQer7vUUdXTm1TWXi?=
 =?us-ascii?Q?ESECOkFr6Q1TYPtXUuXynSs531Q7dy+WkfSpTE3oGTjDhMHcPQv4vgMHi28p?=
 =?us-ascii?Q?sY1LCcgh7VLKtHQ96evmtWKbformcL+vahs/70FIccsxi840+W3lgfEykS1u?=
 =?us-ascii?Q?nhtLL28QQkh0pfHW4X1enagawEtifrEwcAXsvcxxznlce8tAk6NQozTapsDy?=
 =?us-ascii?Q?G7VVSAC+b0VM+CVnz0g8iOeFyaYFX09seZvaDg9C/YyU4sSjxHzN1IU/zYum?=
 =?us-ascii?Q?DG1VA/Np+jmbZ76FZoMLCc/1dtDfct3PlJKJ4eE+84JcrLBmlLRiqW9qf+74?=
 =?us-ascii?Q?4T389+/XkUiXE3tUJVRPZZrtjwKdmQWXmP5gIMNBp6fAvEhDLvj9ziSSzGxS?=
 =?us-ascii?Q?cby9rBkJbgYjPBL2m5IBq4mdoc/EnU7zza5vWuzS3v5QG7YFJ50WsZp+y6KE?=
 =?us-ascii?Q?imBpfqneNfEFsX8hRXiErpNau/dZg7D+ZxRw/BG3lAWrs+OTW3ABdlqvfw+M?=
 =?us-ascii?Q?vrBZZy6jFpTDAcMu3Pa/7FG51uyAjF1ZKCD2YbI5OTKkXUwBpYh7c8ZJ5/lg?=
 =?us-ascii?Q?VDWiM0wv1bB/93P3FjqXg92g6F4FHfRkhv56r2a+vDiKJeoykHf5YrNEJaN0?=
 =?us-ascii?Q?qg1JfgvZLwrcMAHbDVlF1T5RgOTQBPLswjrZwE7VZp/byu5+vF+QLXb+jDcE?=
 =?us-ascii?Q?xAVksPqAexbK65wHfBOz0GlSxGLHcBTJKibvPQnTV3nM4Qgs78Ey28QqxSfG?=
 =?us-ascii?Q?qpNZDi9FKmzWvXkpdFJQELwa2wiMq0P9ZVK+G/RUdt/YY2mXkDk8H/lmfDiF?=
 =?us-ascii?Q?0y4k8u+UtcilaZZwCpO+7QPUHQlAVCAjjQmDUzt2CVT6arQbjz5hvBqzad4J?=
 =?us-ascii?Q?OBNpDX1lKigh/BHU5UEGzNh1b7zB1Mx5W7IrMHPegwKOm1R0CNzfwsE3gELE?=
 =?us-ascii?Q?W6ztRon8uELbDiXuWc/yROf8siRJo3s3Jfr/jsxqjPWK23Xw1wPAmU4s812J?=
 =?us-ascii?Q?bY4mXdZVzeAp5hHIWYIJL5lUuYzXZ2MClofn4aeAv4ceGrA0iJwiUDe6gC27?=
 =?us-ascii?Q?Cwm8aAnd5i9u9sI7A3Js0qpQP1smURmhUhhJq1xTl4AeUVWH37KsHQWR/s3u?=
 =?us-ascii?Q?tcDGJafSvhklAqVLY9oixJNCDrEnt1KyePkJ2t/lsVk1MrcVX/+B9RdkBDEV?=
 =?us-ascii?Q?NaFu6nu2ufMyO+Ye75rtx1e8V53su/k=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf37d39-310f-4704-71a5-08deddb9d8cd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:59:01.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2244kStgMnHRVx5o1/gFmt7oMoaLgnZiptfovsGmD6Y9MKGK0NSFpB88LHhSAzn350XzRed+HEUHgY/Tw9jZvJmio9iFXzKnZ0U2ZKyVv3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9466

Do not try to relax sched-tp-overrun on virtualized environments
but skip the whole test since the test relies on timing guarantees
that are not reliable under virtualization and further relaxations
do not make any sense.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 tests/sched-tp-overrun.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tests/sched-tp-overrun.c b/tests/sched-tp-overrun.c
index 3bb6a21..a3ef27f 100644
--- a/tests/sched-tp-overrun.c
+++ b/tests/sched-tp-overrun.c
@@ -128,16 +128,9 @@ static void *tp_thread(void *arg)
 	 */
 	__Texpr_assert(nf.event.val == part * 2);
 
-	/*
-	 * Perform the following check on real hardware only, it is
-	 * likely to be wrong in a virtualized environment for timing
-	 * accuracy reason.
-	 */
-	if (!running_on_vm()) {
-		/* Check that a single notification was sent. */
-		__Fcall_assert(ret, evl_read_observable(tfd, &nf, 1));
-		__Texpr_assert(ret == -EAGAIN);
-	}
+	/* Check that a single notification was sent. */
+	__Fcall_assert(ret, evl_read_observable(tfd, &nf, 1));
+	__Texpr_assert(ret == -EAGAIN);
 
 	return NULL;
 }
@@ -177,6 +170,15 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	/*
+	 * Skip on virtualized environments since the test relies on
+	 * timing guarantees that are not reliable under virtualization.
+	 */
+	if (running_on_vm()) {
+		emit_info("unchecked (vm)");
+		return EXIT_NO_STATUS;
+	}
+
 	param.sched_priority = HIGH_PRIO;
 	__Texpr_assert(pthread_setschedparam(pthread_self(),
 				SCHED_FIFO, &param) == 0);
-- 
2.43.0


Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CE74429
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heXOVr9ukfaH2s/DaodLqWEBPkYBG53JiY1VWy8SvQBmQI3c3O5faz7bmplWj9oa6PgbcCDR+NSUegtpvMueu8r2MEmGAyMnKEf1dsNyIgETbGmpEUNyEKM0X3Jxm/6ddNROmt8fIpYPg3zMENhdQuFJ2LYekCyJhQFn+yz2zFKYp9OSf6adCqRAH0w4Rd1DzcZTQfeAtHcvKaKQmeHfte3wsWNJRZGaiFvR7/PsdWZjZPcjMXrejp2qTWZLlNlqhJylbkXcTqorHj0XdOQ7GTgzgzlCn5IVwEf6ZvkBuu+aDlRHRTJS5JlqBWSgru2F5FfxJqqJBYfoeVELzoGJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfHvALltNOcR7v9X+RRIfno1w+ozNQTqVh83WbRLKlA=;
 b=NvRcjX4q+RUu4zbv5i0FlVikZpjBUvSZWkTpFFqYa59LYBh+f+JRssfaixVPtyXjvUdesQk00qvjPDKUKGEFAxFcPifQoAKHuS9mVUvWdH0kDyMWLaSnsARJJFFgRCNuG8nol+HZCm6zNBxo/wmRRgfyftpVgCGLowItnFX95iVQ59SRj09cG6Ikvwes4gjvR1P3wRn92Ud6+KSxtbGp+65WMQ9PN/Uk+Mczs6VIcuIPd9RchC0kcHJX6WwEAhsvrnjVZv3RcDDcdrYbDgTOq1BYalkOSNCgJgJV+f5wNTMqIDJdc06Tfiu/Q77tP0ijNVDM9JHoRNFg9G8Y2DNKZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfHvALltNOcR7v9X+RRIfno1w+ozNQTqVh83WbRLKlA=;
 b=uUkguHCUTYmkCOvxvkOzfi64W8gNmpx6NWVaCyO0Q26yPFk8r6v1P76Ecwk8BbPt6hVQRyTYQV47+uUDtwW6s7aCPgRUnRtSo1c1MrnxVGJ+o/PtRjJxzIjIsKGZD1Ud6TAmMjgOYOFuuN6Lv+R/w+MXUBB9RB7LZouuv6RU36Z5HjY/Z5etgvvHmYryswD4JyrMhzEntar2R++p4RMC5d2mPn2ZFKt+C0czyifsbPwZnTj3/pQ/dwWZZJB3FAaYr0e8bd8ohIYXJDU2GHv2qsYaQMEZVyFYeGK26sPCFdrCm/LzIbxIGxIwj7CSGB7PFlFr+KAW+i3W3K4YxVD7TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:44:03 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:03 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 15/42] testsuite/smokey/sched-quota: Allow building with gcc 12
Date: Tue,  9 Aug 2022 15:42:59 +0200
Message-Id: <20220809134326.23688-16-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::20) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f295b7-cfc6-418c-94fa-08da7a0d38ca
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+tpWRW3YZ+3khJ3Rc+LbAOeeA4r9HHGejoGn5gBUmYGKNoF7CyFgfufZcnxE9o3o1paSfwXIgE0hiduo5gX37V4UK77MAx/fCfYqoQpMLpR4AGZ8vy+PenVuHSZhDmVDrgU+BWbg31xEfthWFjUsaUt4PhsFf2OkP5MK2E2Ocm0SzEXyx31ovfvqDTh8wbEzG/XRKKPmTtRr4x2810gGPnozeHSY/RCHxWaoRR2ED2IKa082WxiBPqpwH1rVRUwQR4sy3GFU0wALHbiknji2uMiw7xtmZ5/jjFMfehI+SfoQS9LTw6Ro/aOIM3y2rSZklXpTQI0pm0WnizXYEr3tlkxqRiErzqQ+LOlDSOJK3Pgx+kZGrwI5BeHBa1m7AmSXccDzox2F+2SsWygLzlUhqEO6wR5+uwmEpOzwO61e5g+RVOIp/2T1auo5k163e01eXYFEPN3CVkcORY6FMKoiXd0Md8HdAC0WJCgcIlkMxM+mTrMwv/VrGJjKHH8vQMdP+KcgNmKTYvCk7zlhtvAN3+yAjRA+RfTSb9gtevyJDkIL4SUur/0ZztKINGcxFN8+ruhRvvvv0PT3PzfVQOBvg9wcA76doEQm4CNaSSEvxgT1YogmXzBGiQ10mA98oNjzhGHMQ0lbv7Kspdy0+m1OQdrGPSET2BpRaVOXnDZfhxV6nqjLX7kNZUCdznoZOcKsXEbLZATBz3aRpMhnoLB7MEkAVLMbl+JUFA15H5PTgBM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(44832011)(6486002)(66946007)(4326008)(8936002)(15650500001)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkJVMWxqSDloN1JKWWszYVRvWHNuV2FtejFWV1FUZ1pnc0x5bDBOTTRaZGhC?=
 =?utf-8?B?RTdUS1h6cG1OblFUMFhIb0RvcFlKOC9QYTk1SUZUV3RzaC9zLzNDOFU0UnNn?=
 =?utf-8?B?KzJTditjVnNYY1VMUmxhYmhoeS9wdHFiODVPcGkzRDZKNEpVQWh3dUUrYUdQ?=
 =?utf-8?B?TXhqS0EwRzdPTHZxaVhaUGVBTGtOMThJWDZ5aENnQzcwV2lRakJhc09LUExq?=
 =?utf-8?B?V09YY3kwbkplMFkxWnp5VnBmQlNXcnQ3ZW5ycUJPWno4S1VZc2dUek84ZlM4?=
 =?utf-8?B?YXNlWXBSMVNUM05nd3p1ZXJRR3dFTWNZSUZTNmtoVHZmV0l4TzBRdzZEcUhM?=
 =?utf-8?B?MmNZS0Z2TE12Q2lWUzN0OW83STdNdlR5YXVJN29rMHZ2SEE0cjc2cENkWlZE?=
 =?utf-8?B?LzRSWVNxYXRUem5PU25JcWNON1VQR0lSUlIvSWIzREgzaGdtS2Q4Z2F2dmd2?=
 =?utf-8?B?NUJHZExjWkZ3Z21haDhZcVNGK3prcnhFMHpjbXNLYmJEZ1lUOTNHNUxkZVdG?=
 =?utf-8?B?ZklScEpTb2huVWVnYmNrQk4vb2JCVW1Ydks2NHVNTElCZGRGMVd3RFVmSlFP?=
 =?utf-8?B?bEJ2U3hZRGtNRE1HRU4yYTVacGgwYTExL0RTRTZicGoxbm5BcXd5MElOTm5T?=
 =?utf-8?B?UGFLS25MVEVUbHBvTVpGK0lTZVhlR1h3dWQzbHlyOFRSQXZvUFRTcFEwc0Nl?=
 =?utf-8?B?OFIzOFNBTXBDL1ByVklrUXN3cytSY1JPVStPVVNwUzZwdGQ2ZWZDemlNejVC?=
 =?utf-8?B?MlhLb2hhRTRCUHVYMW5DODdPVUwwWjVJNjJqNXA0d2l4T2JTNjZ4WWQyb3Va?=
 =?utf-8?B?ajM0S3RocTFQK2gzMEVhRlNXL3EvOEoxZFR0Vk5RZkpHVGlaVzdQMlZrU3U0?=
 =?utf-8?B?eVhrQ1dkcHgvV1Q3YzBtYVBOVmlYY04vc3VwaUVoR3NxZklJSHJ4YmlIek55?=
 =?utf-8?B?bEVXN2M0KzBYMGpjdjBjVTI4WXhRMUIybTBpUlNLa29RNVMyM1V1N0VtV1pM?=
 =?utf-8?B?bG5sRTZjSmRlUGpDdHFWSGZ6UXFJeWNSZEFnTFBFeEtpMk5aYVNkVHF6Q2h1?=
 =?utf-8?B?TWg4QmUyMzNIYVZ1WGgvSDZLa3k5MGdpWnhoVHZKaEtmN2txTVM5UE5zMzFC?=
 =?utf-8?B?KzVENEs5eld6WnlCZnZFMkd0d0JBOHhYbFFqcEg4R01rc3JWdlJVZ3A3RXAz?=
 =?utf-8?B?MVM4MFNhWk9XS1VtOVZ5dlNjTWp5RkVFWUlHTzRkUTZHeHlFdzhVdHlMcm1L?=
 =?utf-8?B?ZWE3ZjBySytPVHo1WlJBMHdPS0NMMm9PaUtBUE5ON2ZoSnZRWGp1SGRwQUZQ?=
 =?utf-8?B?MEg0TlZwZzVXUEdwZGNJQWdKWElHQ3AyZkJPNENWRFkvRVBsSHMxKzNCVVRI?=
 =?utf-8?B?NUZqYVRTQmZ2UENoVzdkaUVCM3VsVk9pbnBtY1dVZm0yTWhSQUpyRnNEaUtO?=
 =?utf-8?B?VENVVncrbVhYZVNUdEVrSytkM01LeDMzd3Z0L1MzT0ZFSm5sbWxrMklheXVI?=
 =?utf-8?B?UWRJT3JCdHVlZVBmdVFyZ0VLK1A5QUk3eUZ4emR5bGN0SkN0RHJ6WmRnd0Vj?=
 =?utf-8?B?ZnZwcGNXQjRWMmFtTkhBNFVJcW9RcjVOT2VGMUlBUlNRUGpvc0Z0OTljMUQ3?=
 =?utf-8?B?ejZ1UVhsVVJCUGlPNW5tNUdDQnNmcnBIS2I5SEI4b2hidFdMbGRzczdZRnFI?=
 =?utf-8?B?UmFacFVRWWt4ZWQrOFp3ZDFFbExIWlVUcWJBVXlhMzE4ZXVKRHkrNWFlalgy?=
 =?utf-8?B?NkZSbmFoRlQ5TVFlS0cxMnRkMGNvcG9hY3NpMk9TT0RiYnRSRG1YNGRUdkNM?=
 =?utf-8?B?eXRabTVuZVVtanR2U0paaFVxdUhFVC9TWW5PLzZTYmZvZlBKVnZtQnZvRUlI?=
 =?utf-8?B?L01pU1dKYTFTT1R4cTF3TU5XbGlMSWxHUDZKbGNQQjQzU0U5ZGpTTWZBZ2hv?=
 =?utf-8?B?M1NzWWRXU2FtR3Vqc04rbmtpSTNrdUVUYjdEKzdyMTJsNWJpZWVySS9ac1VR?=
 =?utf-8?B?TisxanNncDByUUk1ZWV4MUZUVlJBNnZPRUZCMjhzemJrYVlaclowbnFoN0NJ?=
 =?utf-8?B?WHRRSWNXRWhvWVBIdDFjZWd2STE4VlM0ODB1MVp4NU8rc1N2c2dOQzNFdmVz?=
 =?utf-8?B?R2tzeklMUkpmbURqcGxLYlNHK1U3eU02UHpoM2dNcWd3MWpISjB3NWpxdmha?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f295b7-cfc6-418c-94fa-08da7a0d38ca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:03.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMQUhdcUJeWoCCSe+Wi7g1NYKJUHSRwZvVPVBT4TIN1QHmQZ9rS+ZWUbsdXb+yA9mPifIDblD64k1s/EA8/aLtlxXPyGoaQGIehj650JhIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

The build wich gcc 12 failed with two overflow warnings. gcc is more strict
in checking specifier overflows now.

In this case %d alone would require up to 10 characters but only 8 where
available.

The warning:

sched-quota.c: In function ‘calibrate’:
sched-quota.c:244:34: error: ‘%d’ directive writing between 1 and 10 bytes into a region of size 7 [-Werror=format-overflow=]
  244 |                 sprintf(label, "t%d", n);
      |                                  ^~
sched-quota.c:244:32: note: directive argument in the range [0, 2147483646]
  244 |                 sprintf(label, "t%d", n);
      |                                ^~~~~
sched-quota.c:244:17: note: ‘sprintf’ output between 3 and 12 bytes into a destination of size 8
  244 |                 sprintf(label, "t%d", n);

Fixed by migrating to snprintf and adding a limit to the actual buffer
size.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/smokey/sched-quota/sched-quota.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
index acb9055fd..093f7db43 100644
--- a/testsuite/smokey/sched-quota/sched-quota.c
+++ b/testsuite/smokey/sched-quota/sched-quota.c
@@ -184,7 +184,7 @@ static double run_quota(int quota)
 		     tgid, cf.quota.info.quota_sum);
 
 	for (n = 0; n < nrthreads; n++) {
-		sprintf(label, "t%d", n);
+		snprintf(label, sizeof(label), "t%d", n);
 		create_quota_thread(threads[n], label, tgid, counts[n]);
 		sem_wait(&ready);
 	}
@@ -241,7 +241,7 @@ static unsigned long long calibrate(void)
 	crunch_per_sec = (unsigned long long)((double)ONE_BILLION / (double)ns * crunch_loops);
 
 	for (n = 0; n < nrthreads; n++) {
-		sprintf(label, "t%d", n);
+		snprintf(label, sizeof(label), "t%d", n);
 		create_fifo_thread(threads[n], label, counts[n]);
 		sem_wait(&ready);
 	}
-- 
2.37.1


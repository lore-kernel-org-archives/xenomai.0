Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE619D2E3
	for <xenomai@lists.linux.dev>; Wed, 15 Feb 2023 23:03:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiMtuFW4pZ02I/hPCMif2syDpMISAra76J+uAmHxLJnOpYBlz8MrgLFocW+x+7GUqqLGHKnFYPTB2qmIsQbX97PS96DKVpjr/9x7+r1qTr1YFFW/OmT9lYB8vOrteVl/v0hKPW3bBfp+j+CIsMOv/u/BBq7mXplGsLMSOjVTz9yz8Q902BBmpdK6J44ljTRelRIHNZW3LoCMSdgM2COk3ZEtv2Xjw6rAnuWG7hdwGBbCPSTkEvHvGUozEY1mfU+9eehU6Jhp9FcSW3uH5dvYsNW4LNH0hqb9RoTLZsHYqkvKTopJ+JdAWdUiaWLUPP9nlaIlJj6F6sYNbeEJgzt9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s348/KkkhyQEjdUw4sN/8oYEJf7VmYNaujHnFPp2q1Y=;
 b=cBF/rbXF8wbA5LjfDOndY+vC6ZBbTkj8MF3oA5V5ocKOf7+x9ny9c8j1yM1haOi+7jlb/bQSXJO8lFT6FHpR5MmkcZGVPZGeuqOX1W4jbQDMyrgPV0h7wzVJwdZx0n1JCWKf/oiyfpu+szjDvlp5oZNIrzhaGqiixrwTBQInXExmZcr+lAoe9RchyET617cN9l3tEyBUvouQFaa4ATpMphYU3h8NimMpOef5qAhEdEOrF629j8LKV+LHqKI+sw4IgvF6tczszNMhm7U3YHHf8AfVVzPSYLgkMSg2Q89EGmlI8/TNSZypBt6ArB3nKcOXMGqAWBk4JSWI11wJN1ELWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s348/KkkhyQEjdUw4sN/8oYEJf7VmYNaujHnFPp2q1Y=;
 b=q9mYsVzmYVo3K81Qbtkh1Sh0DyRcjD3TWd6d72Y+pZIUZkVclkJdofg6c1s87j7Fd7iwqgGIM8BTvj/sI5FtolsYW9gltVzKKu2T7SzkobaPTIiXTYYwlhVojj2N5XtLun5We1fANFxeHjplM3alxdS+aHV7uaP1Zni9YEHnY3GaM5sJGcvbsnc8sDYqhzfdKtuyXjTySwGGYEaRIUCU1Xlixz8UnI9CMzOhQ3FDnEEo0Usv/z8cWJkWjjDeGpTwjOyKT0y982i1g6qjiYLekpDNQoQOzKkgHwEVS0kWLNWB9pjtkmMF3aLzlAqY/9gFR7qml3cxgeNAkuxJJOJyEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS8PR10MB6794.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 23:02:58 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2533:fec7:4a5a:fcbf]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2533:fec7:4a5a:fcbf%8]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 23:02:58 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v2] testsuite/smokey/sched-quota: Allow building with gcc 12
Date: Thu, 16 Feb 2023 00:02:54 +0100
Message-Id: <20230215230254.166268-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.39.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::8) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|AS8PR10MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: d451a9bd-b341-4ed3-395e-08db0fa8c7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0xhcUD5yRXTUN51XBDFXaJIcaD4Cu915FNqX3oJ47jqPl6kmlEfgjcYttszsQcuQEHWCX4bqmt6+TqVL5Fw5F8Uk3NtYEAVL6571lOW1Z8cOK9QMXJ+cHTswUVGb+sPTS7VjnS6is72e814uoppetQk28H9hPwclG2ybtbcSN4aHhFdnAL3AmuSFa7tr+6HUJ6UOr7Es8d4B9y2V8O6oaxaD0G6ZiH1VCfwjmIWCPyJbiT0ojWuiO5B7VtSqGCtL1FcQHts8eUuPachss5S3nf/E1loOZcCjB2IzSBjrceOIeeH6zNnJbHaRJQ/aoEcoo7T7pMbeSGh2pFFwj6bzJEABbNt87crtLzyw2QFes5JWymIQvoez8zpQESUtbiL1enocNvtuZ53VSaJl7S1BYIUbK7bNBz4e0uEiI7UpL/39V+Uce0yWHp+hjiF7WY6mSxf+J+AFbR7tOPyDcycEnh6HbQ/cQmUX+OmIebs+JmSqoA5T/PlGG/7hgXbrLTNRfj6kkaClT1nxXqF3fQp/ovGHEc6IPWhp+PG5PUMf9cidP4FROdnSBNiH5K6mgmRfUUhIPNm9fKQ1XCVqLy8Z45Vbn8BqaQmi/mmWZL0MJ9ef0rqg6/FPu/k1qOoUoPT9uTzUq+do1hlGbqfj2JYGNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199018)(2616005)(107886003)(36756003)(2906002)(86362001)(5660300002)(6916009)(44832011)(41300700001)(15650500001)(8936002)(38100700002)(66476007)(66556008)(66946007)(8676002)(478600001)(6486002)(1076003)(83380400001)(4326008)(82960400001)(316002)(6506007)(6666004)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2hQdGZnQmNGTjBBdjFOK25la1VRUzhYWWVZcnprUEVkSmV2UDZweUc3YWhM?=
 =?utf-8?B?aG0xU3I1YjNLU2JTN0FycDhNQ0swdEZEWHRLR1lESzBQeWNOWjJteEZYVWxO?=
 =?utf-8?B?dnh1UTl5MU85OGIyZ3l2dXAxQmJCS094T2lyajRITFNjMkh2cUFnNEtlMlU4?=
 =?utf-8?B?ZTE3ZkNDWnVUYjNWY2RkclpSWDlLMzFLVzd2MGZTUXJ5R3ZwdHg0UFJCeDlE?=
 =?utf-8?B?YU5Qd2NlWXpwR2daeW0rcUxYdHZRL1dhWjFBUmZ3K2hrWGZlZDdqQVpVOVcz?=
 =?utf-8?B?OG9vQTJoN0I2T3N3L3ZpVjF5dTlMUUc2b2RPRkdwaWFoL2taekYxbnJESEdG?=
 =?utf-8?B?bHhXekFPNUVGb0dNY0pHMCtuY01ia0VMUHc4QnVvUHBpSTRTS1B2V01mbll3?=
 =?utf-8?B?RDNTOStYcEdPNnkzRmJrZlJscVlML1gxRHpxckUwK2ZBMFFFRmlrRGN4RjBr?=
 =?utf-8?B?ZCt3d3htVk1yOXhZT1p0WG1rQStIUjBEVzNyQkFNVGVIQ2R4a3BLT3h6MVMz?=
 =?utf-8?B?WDBpU1Nka1hibmJ4U1lEUHBTeTV4ZzlmWU9CNEhOTXhGVG1wZHlVeWlFUHJR?=
 =?utf-8?B?NWNhZ1BMNHIwUUdZaXhKNDBzcXQ3VXVBcVJnTWdWY3AxSHk3VURxTUUyVUJM?=
 =?utf-8?B?N1hxYk5iTVl5Y1BZU3Z0bFhjYjN2NzVpVVR4VFlRNkR2eTNURU1DdCtwbldj?=
 =?utf-8?B?SmdWcS95K05LTVk1KzlKRUJLVkFnYXVEeWZIejJoazJKd01Bak11ZitGRE9j?=
 =?utf-8?B?Z1o2RVpnSWZqRmNLWkJwcEtqemhCQVU4cFc3ZzBqN1p5OXJzRFJYM3h2eVI2?=
 =?utf-8?B?WkF3aHZ3U25ZZm1OaGRLU1dJYzB4UlAvV0k1RUk0MjNvbnJmREZISzlPVHBJ?=
 =?utf-8?B?UWtScisrZFg4MmRNTEtiVGFzVXNRNHR5ekhCQVlzVnRYbGVsS3Z0VXYvck91?=
 =?utf-8?B?a2diNXBxSERhNnJMckFRQjdYaEE0ZUczbjlFTThrS1A5RktuVmxkZmI0aTVJ?=
 =?utf-8?B?TEt3VEM1UktyVFI4VzQwbFJpWEY3dTQ5VXBCZldBODEreUx5WnpNSkorekVy?=
 =?utf-8?B?cXR6YytuSWdKWVd0VEM2eXRtZXNLUHB2bmJOSHNZK2NPYlFqbkJUVEJtM2RF?=
 =?utf-8?B?ZHFTSlJjWXVwMittcW41ZklVREsrU2t3c1ZrRVdoQUNQRzEwYkZMTGY0SmZE?=
 =?utf-8?B?OGlrbXUyRlFuRkRTUHV0ODlSbFhEUmxOUUw3aWxIZnQ5R2RleGFTUTlOSXo1?=
 =?utf-8?B?QzhQU1Q4YXdJTEhhU2w0ajFwK3B0WFdIT2hMZGF6VFN3SGRZVU13ZXNlcmdh?=
 =?utf-8?B?K1d5cGNPa2R4bFptWGd6UGVPaTVXRUgzVXZoS1RZQ1Y1THNod0NhaGhzVVFm?=
 =?utf-8?B?SzR0WERWcVJESElEd3h5d0FtS1Y4bmFQc25hSEQwTlJkeDVLdE1TRTNnRU9V?=
 =?utf-8?B?SldkY1FQMmZLbXIrRE1sMzNTemVKZUJFa3FWdUlueUY2dEJaRlRmTmJvQTBp?=
 =?utf-8?B?VnRSb1JCY1ROREt0cngyK1lkbVpCNmZpRFdreGhuekxwK1luU0NKbTZOV3dU?=
 =?utf-8?B?YnZUeVB5U1ZXR0JYY1E0ckN6SWtYSnVRZ2NLM1ZFRkdvejNVdEhKOWIvMWRL?=
 =?utf-8?B?UU0rbFcvM0FyeFdISUtuLzJOV1RMYTRDS3ExYytOZXQ5N3A2QnczVFJyQk1U?=
 =?utf-8?B?WlBqN1pKVHpTTmRWQkc5WFNrRC95dmFXTC9aOHBxY3dFR0JES0ttVzkrMHVw?=
 =?utf-8?B?NVFoQnMveFRJNmRoa2pkOHUyazgzeGs1MHlZRFFRSVg0SGg2TVNER0RvaUpX?=
 =?utf-8?B?cy81TlI3Y0xDd3F6OVVHbWRGTEU3VDVnRlBJcWRrdkpZK25lWEZ1aTVVVHFh?=
 =?utf-8?B?OUpJZlpsNU9JTFRMbXFaejBSV3V3blpTckRHU0JHQ1hsVCtpUGpNYS94RXF3?=
 =?utf-8?B?TzM5MDVkUllpbmVJTUdLSXk5ZzVtZDQyZm9GMzlhUjFEVmxDd0NpWkRVVTNx?=
 =?utf-8?B?QVhIaVpMd29nOVlzUHBPQUNwdUxuS3EzcHlxZmNZRWUwanVabTViUGxFQU5a?=
 =?utf-8?B?TlgvYUY2aVpBWWlHOXQ1UDIzV3hGWmRZTkhZODlNbWc2Vnk5VElFZW1uVzZR?=
 =?utf-8?B?K0p3d2VGbGp6L1pLZjlZWE1TY0dEeFJ4QVRLTEZLZTF1MUw5dzJKY1U0a3gz?=
 =?utf-8?B?b0dOeDM3aEUrQXMyRHZCS3UxUitqY01JY25rWEd4WTRhVUdVOWx1cjluTzJQ?=
 =?utf-8?B?ZXFKQitWbzJCTkgzalpXRUdsTUZnPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d451a9bd-b341-4ed3-395e-08db0fa8c7f3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 23:02:58.8148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOUYc/JVj1VOJuxV01rtJP2Myw7oOlLWZjy35TnVvft33oiA41q2dZY+MQEQOE1u4BqiMJuFTeTaSmKopRDJynXgXLGMEBtwtdYzU/fYBjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6794

The build with gcc 12 failed with two overflow warnings. gcc is
stricter in checking specifier overflows now.

In this case "t%d" requires up to 12 characters but only 8 were
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

Fixed by extending the label/buffer space. In addition the migration to
snprintf avoids a buffer overflow.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Hi all,

this patch can be applied to the following (stable) branches:
 - next
 - stable/v3.0.x
 - stable/v3.1.x
 - stable/v3.2.x

It allows to use gcc 12 (coming with Debian 12) as compiler for the
Xenomai code base.

Best regards,
Florian

Changes since v1:
 - Rephrase commit message 
 - Extend the buffer space (detected in the stable/v3.0.x branch)

 testsuite/smokey/sched-quota/sched-quota.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
index acb9055fd..26bc15e72 100644
--- a/testsuite/smokey/sched-quota/sched-quota.c
+++ b/testsuite/smokey/sched-quota/sched-quota.c
@@ -163,7 +163,7 @@ static double run_quota(int quota)
 	struct timespec req;
 	int ret, tgid, n;
 	double percent;
-	char label[8];
+	char label[12];
 
 	cf.quota.op = sched_quota_add;
 	cf.quota.add.pshared = 0;
@@ -184,7 +184,7 @@ static double run_quota(int quota)
 		     tgid, cf.quota.info.quota_sum);
 
 	for (n = 0; n < nrthreads; n++) {
-		sprintf(label, "t%d", n);
+		snprintf(label, sizeof(label), "t%d", n);
 		create_quota_thread(threads[n], label, tgid, counts[n]);
 		sem_wait(&ready);
 	}
@@ -228,7 +228,7 @@ static unsigned long long calibrate(void)
 	unsigned long long ns, lps;
 	unsigned long count;
 	struct timespec req;
-	char label[8];
+	char label[12];
 	int n;
 
 	count = 0;
@@ -241,7 +241,7 @@ static unsigned long long calibrate(void)
 	crunch_per_sec = (unsigned long long)((double)ONE_BILLION / (double)ns * crunch_loops);
 
 	for (n = 0; n < nrthreads; n++) {
-		sprintf(label, "t%d", n);
+		snprintf(label, sizeof(label), "t%d", n);
 		create_fifo_thread(threads[n], label, counts[n]);
 		sem_wait(&ready);
 	}
-- 
2.39.1


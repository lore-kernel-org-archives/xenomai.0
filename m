Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383AB1172E
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 17:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4lixSK52PgGd5RRMr/lIEylBiuYdP3UEgLUqeneQFumXkJmRK1lp3VODmtyEDqMVArBBLqfGrKT93Q40wGlNcDRTak7gvmFnIcEtciGyhQZa+sM7gCOqG72oiZNpqhQLNKzJzP+TzI+QuoGXQf8+q4DfutXX77DxzZiF7Bbej5P2GWznUaiMdmosepoypmGSghNQY4tI/iLgyP8Ty81t1QQrfRfRfQqHin3Udpu2vundLRU3KwKpBrYDQ+usz3P6jZGCp85Lve3UL7FtPSnnRNG2hK2CAYg1dcTlMvvzX1YmfZ4UioK/CPcCBLAOGWgWjf+w1u+5oC8sAbbUGCwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AmUDmPtTZStJKhoiinL+MZTCX24UeiUH1cOylIog+8=;
 b=Yl9LYt/vQLmTQOiqCCbo8/c2FiDr+0hQCfdXJJ1eoqJxHRVEZ/1HZyUi1/So8ljH7XEYsCzobh77meGy/IShoYfUy35vAn1WZli0h6xXKQ5mdAicqeKP46Qq4CL38r43hy9QoTs6JyO84ChLhPPyaU9z77SB4lNUxZN5+5GJ3mMbq22wklyIyj5xSlgso2SnLvCu4pOf4tHK2De3rKOX0r6RN7Hj6Wvd5Z8O1Bvf8R1hMCib6beHX3PF6UGWbDQepO0jUwFcmf69lP1FvQxQxZnbk061UgVY5je14U7sPMhncxErUw8AvFheVv7Cu1nr2SS59c6gR/OAefy9WzETiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AmUDmPtTZStJKhoiinL+MZTCX24UeiUH1cOylIog+8=;
 b=kO+5AIAF1mKPsFD/xt+Ei9LZ+xjfkkYJ4ELXVxLOuchhPBwQhDYzTv1ItV3FDzd1m2/MAGi+NxAZ5sMpNqVr3vyQJjbvJgq3mqA1dPDdr/fGjFIZJ+hXkBTrKzyg/1oWQhMwKGjwtTvNsfjGFPqFtsRwqTIsRjzNjZCr2g55i8ma7TO0D4t41LFrulKD9dQuLw2GzmrlasAeVAiwHKJnPZZFkWANni97D79iRYMfy/v7rT94KruH1csBDXTs2TZ+dwVeoUqiuy2eLKz6rcDy31XB9PsfKiDc2T1Oy/9UZfMD9h3mzaa3PujEii7Oaq//SVecSDv6CaQEXlfw3Npf4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:174::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 17:33:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 17:33:10 +0000
Message-ID: <eb2fe1d7-1d0f-4797-89cc-467a72b1c6a9@siemens.com>
Date: Fri, 11 Aug 2023 19:33:10 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] vxworkstests: Fix shutdown race in task-2
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Aaron Marcher <aaron@sigma-star.at>, Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3906:EE_
X-MS-Office365-Filtering-Correlation-Id: e037f0ec-4c38-44e5-5ccf-08db9a910880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LUTjYQFGHQkdhpZBul7bjCBjJQQvFVMyxFXo4RRDM8Do08hjXLbzFTJT67UcLFDZNDmM6sLiqyECQv7Od7jbaFAA9O+Hc4P1bCA3z+9nuz9uuSm5QMVoP3RIHvaVVD4g5XxcfAeQw3RaJBWPbqrv6WlmYXcQ16GilR6XBI4YwWh1ZYIajwBfnHsyO/Zd+Zs2MCG15UbgSfViRRzZ5pGABMPSmySBMZAd/RXJLbo4ClOIoWTdH5arz9+sLsttOpVxoXQmUWC21Wzwewten0s9DEWH32ao1fHEOokiwq1Qn8dQerJFzpUqfh6OhqyStH9wr3w7R0K9rpGc2Jg43PcYXZlc8uPtTCgwrZzZ03NorHjOOE7EvDJzJT2ROPdgxa9kBoWkaLW+IwgrxRdLo1UUqF1cMjahApO5tTxg0fIjFUgmULlLRYk8iaUCV0W8W9vBaK5EUSdnQYm5YeUYyn2PiHJpBJfsdOOhUBlNpDCpgiSCgU88uylCupQQXvErOxtesJhNehGBg5iInFD2LZj/UpxxNNs9vHNMH/PWwNVHzjGNOgNTqrhTp8CYf3iPXhmLOmM3CB+Vj9xLdxBSqwMRfhraoHANCLIBDojFo6VPrnTSAdjroiQWGjTLlGbBobxcA8E7xPhUXTltgjb2E0OrRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(1800799006)(186006)(451199021)(66476007)(66556008)(66946007)(4326008)(6916009)(41300700001)(316002)(54906003)(6506007)(2616005)(26005)(31696002)(86362001)(38100700002)(82960400001)(6486002)(6512007)(83380400001)(36756003)(478600001)(2906002)(31686004)(8676002)(8936002)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFVNNGZtcmlWeWVmOXlwbmFlVWJLL1lJbUpiQndYL3k4ektpN1pJV0RpNCt4?=
 =?utf-8?B?ZnFraFNQaW5Ba1Z2bmcvcW1aZGtHd1FWYnVlWDEzSDNpSUkyN3kvblEzOURU?=
 =?utf-8?B?c2NsWW1lczI1QUZBTytFYjdzZU5jVHhybkt0SzVna0NVb0RFSmpUaTBCRXVm?=
 =?utf-8?B?SDFBTmpMdmF6aVVtdHNTUGlCOFNib3RvZCtBcEY4UzF0WjdGaDc2VzV6N1hM?=
 =?utf-8?B?bjZ0alRweXkrdG03K3c0dFJVV2M0YVZGaStYU1RzNGJRaEJSODY5bysxZENq?=
 =?utf-8?B?VVpZWWFTTDUxbldrUU9WV1JNUXNwSkY3Yzg3Nzg1RmJRaFRnd1ZwcmVZb3ZO?=
 =?utf-8?B?ei9SU0VDRUFhMTVZcW5SM09aUUtnc1JSMC9ldzVseXl5NEp0L2ZQVXpjNjNm?=
 =?utf-8?B?ejBGYWF6QlRUbm9Vc0RiMXpkRTZiQnkvcmloakhycHdSNlVFQnlNa1J2YmpR?=
 =?utf-8?B?RXZMZldvTUNmRGpJR041NUkxYTROOGtOOFVnd0ZtenJ3NmFGZlBkeXc5cTA0?=
 =?utf-8?B?OWRIbVRUREY1cjd6eGpqTFhrWUtYeHpOdDA0eFRic1llV1prZWM4ZGxmTXVD?=
 =?utf-8?B?SVhkTnJmdW9XcHlDSzdVcmRIajVmR1VvQld5TENzTXRUL2lnc3dQb2gwU0lK?=
 =?utf-8?B?S3RDUmg0SWg5b0dUVjY1NmY4YzhLWmhHQ0JjK1pZTklRTDRXKy9yQVhybVEz?=
 =?utf-8?B?WmFvb2xKNm4zKy95ZThPR2JyMzJYUUswc3lnVTNJcXlhQUt6cjhnRlhrMFd6?=
 =?utf-8?B?cnQrTVZZa1hrQnlhN09uMXQycFBIRXJUb2diSHJYMXpHRXpEQkJTYzR2NDBT?=
 =?utf-8?B?T21EL0NCV2tER1JzWGhkZkU2dGtncU9YTXpxaS9WcDBTTkJqMGd5UjNIc0Qr?=
 =?utf-8?B?RkROVVJEaFJudnRaemxQYWxEeWtFTU85VTh1SS9mN3pJUmJmZnJGc0NvMFNH?=
 =?utf-8?B?UTRUMU8zZk5HbGUrWnNvSUNrUEZXMVorWVV1V2tIZDBEeFZrWGZ1dXptQmJl?=
 =?utf-8?B?bGtXSDBQR1M0WlAwb2ZmdE9US2lLeHFvYjUwSlRYYThoWXkzQnkwelFWSWtZ?=
 =?utf-8?B?cU00WUtqdStaMEdQcXdXZGNKNjdHc213OUgvZHF5ZGlJOUQ3cmxzOFpyR0x2?=
 =?utf-8?B?UjM1eFVuamZmT3NCblBpV096RVEwTnFVTFZpeGRYSWRUUjk2aTJBS1FXSkh4?=
 =?utf-8?B?a2dFY0hCSXpEUzg3VEpEeTNZYnRVazhkYzkzRjUyNDhZWlFuSTdBRGxJUGI1?=
 =?utf-8?B?a2ZENXVMeERQQXFlOWZmWnMrUXRWRllnSmFOTGRBbVgwSzhwbnl5eCtMdXZR?=
 =?utf-8?B?M0tvczl2ZW0yeEtNOFppRkp0YTRPU2RMVHpLTXRYM1lqUmxBNzRPVzNjNEVr?=
 =?utf-8?B?Z29LQWpUeU5ET1RuTjE1eC9TZURVbC93ckdpTW56RFBsQjJVWEpmVmdlWlla?=
 =?utf-8?B?Z2JXR2NkRWgwWndTZHBOQlZQRU9UQTZVTzQ4dTZUalNndFFEem5DNW1CVnF5?=
 =?utf-8?B?Q01BdTAzNTdodnN0OEdNS0xKbnJMdVRlbnJ5MTRXTEgrTmViWjVPZ1BNdVZQ?=
 =?utf-8?B?Y0hCcEdmTStOZklIa1Q5d2toNGVtRDQrcmFZOU5qZXZ6b3pEQ2g0Sk95aTBS?=
 =?utf-8?B?WUJUQU9VdW1nY2xqNHBiREprYnkzdXV2VDZyL05uVlA0MzN6SjZtZW9rOTBm?=
 =?utf-8?B?Z1BNUlo0dTAyTFBiYlp2YVlRMi8vK0RoZjlDTGlqWHhVS1prajVSR3EvM0Rm?=
 =?utf-8?B?ckdER1FUZzh5anpsT0Y3bWtGVUtIeVlZZ0dnTDFOYncvMUxNVlVITHlLUXRr?=
 =?utf-8?B?QkZmemdBMk1BSDRvdVRlNzZmenpkbFNGUEN4SkpjUGlQOUNxRndiY1B1ZU96?=
 =?utf-8?B?RmJpYTE4NnhPTjc4c1RkZUxKemwwQjN2NjZic1RmemlLN1M3aUVORW81TFpN?=
 =?utf-8?B?QTI1bnZFU2trelhLUWlEYjM0V2dnWlhXTGJnWXBiVml2Wnk1aWRPN1d1dlM4?=
 =?utf-8?B?eGlTZHB6Mm8zTCtJd1lCYjNMeFo3M0xvVEFMeVk0R0Z1QVRHdjFjdWtkMEZl?=
 =?utf-8?B?MllrSTI3c0JnaC83Z0pORXlBWklaU1ZvNzlETmRLVzNxTHIwMDdJbXkvdnRa?=
 =?utf-8?B?Wm5PQXM2THdUYURFSVVRdjVQL2pzRzNyUmRLUnNZZ2xVbzE0cTdTTGxzbWp6?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e037f0ec-4c38-44e5-5ccf-08db9a910880
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:33:10.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQdsBI+svOBLfQf07vsExmAZuTwEbuFluadxbARiMPspgn3+ygIbZo0+xrTiKP4J1b9z69Msil81AkKcqb3e9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3906

From: Jan Kiszka <jan.kiszka@siemens.com>

The main thread was racing with foregroundTask regarding the shutdown
of the backgroundTask. Wait for the foregroundTask to complete its
taskSuspend before deleting btid.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/vxworkstests/task-2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/testsuite/smokey/vxworkstests/task-2.c b/testsuite/smokey/vxworkstests/task-2.c
index 7f9f0f0020..0c816bd793 100644
--- a/testsuite/smokey/vxworkstests/task-2.c
+++ b/testsuite/smokey/vxworkstests/task-2.c
@@ -21,7 +21,7 @@ static int tseq[] = {
 
 static TASK_ID btid, ftid;
 
-static SEM_ID sem_id;
+static SEM_ID sem_id, fdone_sem_id;
 
 static void backgroundTask(long arg, ...)
 {
@@ -71,6 +71,9 @@ static void foregroundTask(long arg, ...)
 
 	traceobj_mark(&trobj, 7);
 
+	ret = semGive(fdone_sem_id);
+	traceobj_assert(&trobj, ret == OK);
+
 	traceobj_exit(&trobj);
 }
 
@@ -83,6 +86,9 @@ int main(int argc, char *const argv[])
 	sem_id = semCCreate(SEM_Q_PRIORITY, 0);
 	traceobj_assert(&trobj, sem_id != 0);
 
+	fdone_sem_id = semCCreate(SEM_Q_PRIORITY, 0);
+	traceobj_assert(&trobj, fdone_sem_id != 0);
+
 	traceobj_mark(&trobj, 8);
 
 	btid = taskSpawn("backgroundTask", 11, 0, 0, backgroundTask,
@@ -107,6 +113,9 @@ int main(int argc, char *const argv[])
 
 	traceobj_assert(&trobj, ret == OK);
 
+	ret = semTake(fdone_sem_id, WAIT_FOREVER);
+	traceobj_assert(&trobj, ret == OK);
+
 	traceobj_mark(&trobj, 12);
 
 	ret = taskDelete(btid);
-- 
2.35.3

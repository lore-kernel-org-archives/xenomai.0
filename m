Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3397C
	for <xenomai@lists.linux.dev>; Wed, 22 Mar 2023 05:48:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuxwjxT6ma4DBBkl6UMApkVJQZoy8BdGd0GxibYwN5H7BEVy7MHjq16qoqoNsuuNUOsDRfTijUk8NLzV6kj6HmrJsHMPW7EC7eJUaZHtD2wkZrh0rIfzGhgtr37tP+J21D41ICamzSIb2DrpzcLnhix1RoOO2SwFApCJK+o/Vb2tqEhkh063YiKHoWrCXmPsETcfMFEM5xFqXKK8pTiq//x5gQ1KEn8iRPu9aaiPjnZGbTjC0p7xPdfVYFcefceEayfwSsJdxXyGSyNATvUBj6DevevJtFudSam3ESZc7EbjZewUJoQ1hg5irwKbvXrgqM1ejsMjGPJQYX5tL35quQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej/2SZIPV/+FaaV3lfADkFNpkCEUKHQWjtB9IQ8X41A=;
 b=Ois4jmbj7EMECRmBuG7M7hfSNUUSFmgC+KSkulTfpaCrp6w3HE6QaVfq0o94YjqQdAWwsBsKmco/Wks09OMx2FXApY2fMgdkhDPRIflsvDC/X1+3uhWPeYEO45b9aLpGTa8bRwQR3psvbvOGwPnLwP4Qt9urZHE5PlUwfuopMpPnSBHFaiDgbUe5RloJGd2uVNaAm2ph3uGtiIhn6QaM6lgIdWs6s6jNPrkZWqLiFFnCRZ0outp7cLfWvN87MKOIlDvp0kKoqL/Ar1GIO59mmyIs4Om0YfQfLwVsBdN7UXiHlEA9WHfSCFElCGMKpcSvtNilebQFt8ax54OAWBm8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej/2SZIPV/+FaaV3lfADkFNpkCEUKHQWjtB9IQ8X41A=;
 b=jM5i3NPMlU2xE6z+qlzC83KwNbPA39eJnL0i6ehSoBAR5XDdJ6lt50TJLKIXk3bvJJa6+CMcJssmvxYi0JDhEb2IUuqpcwyq0zR04tXxijO2lzV/z6ole2ot+sFpEASEP/K+Wqu01ei58DkeY0aHp1kDsyYUaIUylONU9dS59oldg8C39615nAVlDK0WBwri0txcK34xDjhr+mkucbk/Crn7NFAqhnOLbMaawPmkbGu72pn9AGvGiqY4j8eT25msw/3vaRavxbrc9sZMZQUdgzuflqu+9Ao26U9BVcToqmAKXsHGlgxx5rx+s+uPTxdjVw9yn1Kp8Lc9UfQSLnzFwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6986.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Wed, 22 Mar
 2023 05:48:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.026; Wed, 22 Mar 2023
 05:48:18 +0000
Message-ID: <9e5573ff-4f64-9569-bcf3-c0d157f07cb4@siemens.com>
Date: Wed, 22 Mar 2023 06:48:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] lib/copperplate: Also deregister main thread from registry
 sysgroup
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Mauro Salvini <mau.salvi@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad96468-1439-41dd-37ed-08db2a9909d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iM/4KCnRsUG7FtpZfisJdGfIg+/NzNv2hLcPsCcEHO8PU8yGUJSLHdT5u1F/l8fnRQVsfBGVrDs8V2E1wf+edmsXxYfWsjIzKiN7MwEnicYquIzNOSH0txfhsOfHVbGpU05L3VhlXdo2NGBtrR8mg+SPcvLhNP/bzK8wl0I1IxL4sIzeOGooAT7vtQPgS+bmuJIBc72iHzwUsGz7c2onNu3w1tLuMONqL19/Y1lc/T6RLhq0RnqKr2OsFwXSz4opdnxr1bsaGRNxgr/upG36I4JCI+PN9JiryutHK5T2uze2ATsmFB3JsHWNk2pDc2BnUP8eE3tx1V5ucgddoR0trGpNs+Nu7t4wh2P5Ri1xxYFNj0zoGnzm7OEvbwBFcTJCIGABRU1NqxTzzgYhfCRcCE+5WGRehOSrRz7F28Du6/h5Evr3BtUL1Z9liw/WrNFpgVek1v06/FCNrHqtdybZsFAKSKh4MQJJoDUCdBaxZeH3BGJtJPiWMyokwAiMM4vUcckfUYZyA5xkjEx5xiYOzZLpuQXDm+d8w0nkG6q/Czfx9KBxKLKuZySgeXtJDHzKObcKYEqbFIO7KI450hCe5/stKuXXxUM2f+OEUuLXplC5YtfzQR/18ZbQM2EripOTBNXux2PuNbCQqhtHtfuLtF9fQ6mh2KuRO+HDHTLFWUfoxmr9FLc58iEBkgGh7JxSUMr8CLaWt2Q8fMK9tF4vMTxlexNxeimZBIO1LZ2EWWSTjkWmCGRHBqNxRr/KTqo+cHjmqqAQM8cvDL6sNU/90oIkAxPJbcL5y++DYCFPqnI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(36756003)(38100700002)(6486002)(82960400001)(6666004)(6512007)(186003)(31696002)(8936002)(41300700001)(44832011)(86362001)(66556008)(8676002)(26005)(66946007)(66476007)(4744005)(6916009)(4326008)(2616005)(478600001)(31686004)(5660300002)(2906002)(316002)(6506007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFB6UWxKa2huVGN2NGJmeVlLbnU0c1hZN2pNZitKc0cxcGZNNkVvaW9MZm9n?=
 =?utf-8?B?T3dXQmMvaHErbExNbk9nV2FMMEtkUUtyZ0VGZUlTK3dyK0NmaXBTSjZ0K215?=
 =?utf-8?B?eHJYbjZENVltRWQzdWtsdWZwZTBmSXFrQ3JSZHRhZ1QvTUpzWFdTenh1MnFR?=
 =?utf-8?B?TGtsWUNNVUdmMG1XSllscHl1czRhbU1adXJWSXFUNkZFRmswbGpxYWVycm1R?=
 =?utf-8?B?NzFzaENqVi9UYkF1RXFKaktkWnAyVWduTkhBUFI4czlzM3htS0RsUkFhdTQ4?=
 =?utf-8?B?WC9hWWZ3YTNFcmVnNkFVQ3BkNUZORHl1ZnhGaFVkS0lDRUlodUF4QTRlb2Vw?=
 =?utf-8?B?MGE5RHlpNTV4WkdIOCtXb0Jsc1d2c2gwNWVhaUMrQ0o5c2I5cVNsbGNuTGFN?=
 =?utf-8?B?TE1jM1BWLzEyRUlVQ1VkcEFFTlNWNDJLbUExajlySTcvb3hrbGRPUkJ5NCtu?=
 =?utf-8?B?em5KVlhkOTl1L2YzWkpiNUVKeGNtb3FXWkx2ck0vV09SYjdsVW5qT1E4dUk2?=
 =?utf-8?B?SXJQQmxhd2NiUXZHNm0wVmo5dU94akEwVGpJbGtNZTl1V2Y5WmdVWFZJN3Jk?=
 =?utf-8?B?eU41dy9CdDFtMUhOSTlDOUFOeVFpVGtrek0xL1ZTdDNjS2R3b3VBSUtuNTBL?=
 =?utf-8?B?Z2ZnK0xMT0dQd3l0S2tIK0hOdnJnSTBWalNuSDdMWDE3S3NCVjFWanBUcUMy?=
 =?utf-8?B?ZEprMnNVcU9KbEhlMXhNL3VwcXYrVVZrNVJWS01KZEpIOWNZNlNTMWR0cGE4?=
 =?utf-8?B?ekRpN0hja3czTDhvbHZ6T0ZpRHJpMWhCSnZjbDdDUm9yb0Jsd1BITHRDR3h1?=
 =?utf-8?B?cGhIVjBrSlBFZmg0YXN1cmNQbWNyVXNLSTQ3MStaUGsvU25Sd1h1UGU2Ulpl?=
 =?utf-8?B?TmZIV2g0YXQ1UVJ2ZTMvV0wwd1BMQmlEUGJ5NmM2dk1XM2srY09RaDdqSS9G?=
 =?utf-8?B?S3ViZE8rL1F3dVpMNFNIN0VjcGxKbEkxL1pLdXcvT0xkM0c4NTFJejlxSGNL?=
 =?utf-8?B?V29pVUs5b2NqY0FsenZoRnVNb05WOFZ2UnB6d2dIMk84YlFrUTU0RDMxbFBV?=
 =?utf-8?B?bys4dU4yUlZMbFBFVUFiN3ltc1lESDRWcGx0VWlLMUJtRUQwU01oWHM4WWk4?=
 =?utf-8?B?ZDBSZW43dWJhZ1RxSTVtbk9vaEg2NUlLTFBCUE5HQ29ZQk44SzBnUW8xVTZj?=
 =?utf-8?B?NU85bUxJQWNPZ1praGRXelBtVmwrQzhOOXJ3K25JMTBWYmhWNnRQSCsxRk1Z?=
 =?utf-8?B?UWpSSWZMQVBVMnpiR2lOL2ltNGxnd3Y3dnpTeW9MR2tldkxPcjFXeFgwM3RT?=
 =?utf-8?B?R2VBQUI5YXhJY0hNYmVWeS8xUkhueU9POUppZ1JQeUgzdDdDZncyN1NndG1L?=
 =?utf-8?B?WUlLRGFYRGNDTUw3bmNVcmFkaHVCeDdYWlE4Sm5aNDUwMFI0QU9LSitDRXdW?=
 =?utf-8?B?TFVoZUhyc3d6WjVpRDU1YWE1dXRoQ2pSY3VNa1pjQlJQQ3ppTXJhRkNmZk51?=
 =?utf-8?B?clVLVWZwOWVDbmhxNVZMV2h2Y2k5L2RqUHoyT2dEMk51UmVQMUVwRWFva1Nj?=
 =?utf-8?B?RHVVWHNhZDQ0RWxXSGJiTnlEVUFGdjFXNEdueC94czZkZUVwblphYklxOHBs?=
 =?utf-8?B?eEFabnk5UVdZNzVUNTBlcXZJUDY5MytxME42akJJb29SUDhuMExtMFVXQi8v?=
 =?utf-8?B?N3B5eThKZlQ1VWZJUFAwYjRRR0RObU1DbkZybFcxazhhcmdmQ2FTbDJYK203?=
 =?utf-8?B?TnRLRlJFdzE3TWZZb1ZKSXV0UVMvaFhDOTlEZzE1R0VmZ09XZTdiLyszTENt?=
 =?utf-8?B?R0thelh1eTc0NjBuZEpVMjNtQTJDaWMwZU8rSXM3djZSemQ0di9KV3psb3FE?=
 =?utf-8?B?TkNyUFNlTG4xWldpUkVRdnlUd2R5TkxoeXNOK0hUUlI2eitGWW9xcWJiU3lF?=
 =?utf-8?B?VnFPc1VWdG1sdUZnYVZ6aE9MeGRzWnNiSEhuOUNrYzV1ejk3UlEydGY3QUlh?=
 =?utf-8?B?VGRGWExKbmpnUjAydUFacXR6dWJzWTBpbFUva0lvK0Nmd1ZhOFIySksrYm4r?=
 =?utf-8?B?YTFTZWswV1dhZ0x3SkhrQ1ZNOHpBd25rSjlwNmtSajc4cC9Ib3JpQms5alpP?=
 =?utf-8?B?N0dzYXgvQ281akx3UEdxN3Y2VmlwSGRzcUo0cGNScTlLZVE2UnhacmxsUkN1?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad96468-1439-41dd-37ed-08db2a9909d4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:48:18.7885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0FsTbsXX8kz7KK6eowkQJXeYWoi4BgdAhZ0Sp4DqQ9m26u7WmUqvdBgvxuV00a+q8e5k2shE9IhwHACOvmzVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6986

From: Jan Kiszka <jan.kiszka@siemens.com>

Before 6b4337fed433, we were leaking the object so that the forgotten
deregistration caused no major harm. Now that we delete it, it's easy to
crash on later accesses to the thread sysgroup.

Reported-by: Mauro Salvini <mau.salvi@yahoo.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/copperplate/threadobj.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index 6808bcf164..db18f4ffa3 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1773,7 +1773,10 @@ int threadobj_set_schedprio(struct threadobj *thobj, int priority)
 #ifdef CONFIG_XENO_PSHARED
 static void main_exit(void)
 {
-	threadobj_free(threadobj_current());
+	struct threadobj *thobj = threadobj_current();
+
+	sysgroup_remove(thread, &thobj->memspec);
+	threadobj_free(thobj);
 }
 #endif
 
-- 
2.35.3

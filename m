Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0917AAD
	for <xenomai@lists.linux.dev>; Wed,  9 Aug 2023 11:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDKZfajKBpq1ZdV0auzAnYIUtCalmJ/t4VFTcpOp+UNzaL5NmtIVlGlV9LG1qrjhucAAaoE7L18YVlX/jBSDvxBfdNNmYc3CugE1C4tbaiAEfgUwOoA/DhQ1FofpLcDum5Fq7H5C8KnL/EUcwqEJo3Q4f8unv+L3YSzEnbgTeyHGV8U2sdXwwbGAJdiqXosoxNsui3mAoaqC20Ebd0AjzO+/vqvXaoYpIrvbXy8fDojZ55QnzBd0mfQCUIh5BgvQH4ffPCLaPBUyhC7SiWz86haFZYsernPM32npLsuS3DgYzAiHn/pNlcAiC5qNPyJlni0Cp6DqNkOPFC7rgT9/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFl0h9qkOw2Qnv/ag2Tn5TqUqJWr/4JblM0u5fvoXIY=;
 b=IapwiL9mJH+2qBvNHY6CCdFN89rlxc2xIaBiSpdkYBXNQQCr8df7gbQ9Sxq0XtUBTLL+c4OXIaok1vX3qWxRx1+UaaLFIb3V1Xlqxkeudb54KZPzKbsGnaHckj2EYihDho+0BlcZVhL/eCGKTRQ0f4lU4J8e5ETMJWw2bWKpCqhrJ8hmhv7YATTm4ZGA5U0xmA16Z4cfOejcIUUYNOdBfZkpliQ8zCKRVUEF+ReE3EoLwrpm6s4vRfeqmSd85f59zFk8FXMCA7Afo5yfs6KVcNAXos1p/+bwen2sVA2iosXLwm06WJkVyImRakGm21kehq8znN2dC7NZ0IAAkxsN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFl0h9qkOw2Qnv/ag2Tn5TqUqJWr/4JblM0u5fvoXIY=;
 b=ZsdIlIbtTqcoLWbLB7eglLPwpxIYNf+EMCJ6il9sXIrMgb0C8WikBb8FCjqCR61BXB4LlfVBU4EdpSm4IFxSHvhc4gSIGGYh557FruDCWKTYB4eQpEY+rv+DxznZuRqLM5Eo7p3ZJ7BTUqMfNhKJUl+Q0NHBJyOV57ZLWPkjHu5ohyLv3gkFGSmRCGvHMUVxVAP+Ap23Qrh26TTEgW0AFW9GD1nFVecMqtWy7kS1VSkU/V81aq+abWA2j8SgaUpc2R4TmE7pq3Ai1Mr+t+7Rh6XatVDDlqi1Jvzywu/uXt0HL76dyTAeeraJ2PPSt7y3uHcCX4FKXzGAWPfe7ERAIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:581::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 11:32:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a41b:5cd6:2d52:e47a%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 11:32:47 +0000
Message-ID: <0d04631b-4183-430a-a373-70a9295d3c1b@siemens.com>
Date: Wed, 9 Aug 2023 13:32:47 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 11/10] testsuite/smokey: Hook up new tests
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
 <20230725082959.5144-1-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230725082959.5144-1-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6182f20b-bbe7-4f31-a899-08db98cc5b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pwu0m1qqeFYuYy9UcW1ifx4BKI07zdhUsGiMnrK707qmAiEtNA/lnqb83iHnn1DTWfUs2dpZ7ewgUJ+INWiux4d03YgWz64Vz5QjnAJmkdGRB1uWI4uJGEPt6izEk5FzRJaC4yd26T6WiYg7ax+RNEuf6wBcf+UQ2CbcZnXESK9rpkO+Mg3u9JIeceb7roFmVBa6lIUUHeAkrDBKrwlxVD7lKJXNqhR+rmzbWM/eEUCBrxuF6ssIeU3xWJF1FHF1+V5vvR5oPiMbWjW2aX+DjzhLODpUFLl/+4bvY5PSL1cAodod+OWnXuoix71E63so2rTHLsUE8axcytA5DEZlHlb+FPHg5p9C/4HSQ+Afu021c1MMpxDxTVa5jzy63oOTCt02jrp8B5irY36kciczXzLBeuHwFDIsGIc7g7jBhpofUtdpxm+frJzIp3nsGQ+dehkg0NWyhHiNchts+i0IWjb72WnSd0eNcV/SwqOdgtwVnuPCu/SGN6MCCONB1jaVubhRcig17/QcxWcR2vi6bAPV/CMcd3TmiM2bjRAptNuDgziQlcG8Zmw1jt2ezvbRBClIfMEaXsxw7JB1oX7VTmWxWWTvcWjKRiMxHFh/o2UPhXn+HIK76XL0OKgPRg6LG+Sf9vuacPJnjI7GccBBxZB2Tcy+4I770hwHLTOPsZWSsMDtPI1KRmbbvw3TQCyslgdnaFtDxaWkawQdR+8Dsw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(1800799006)(451199021)(186006)(44832011)(8936002)(5660300002)(8676002)(4326008)(41300700001)(316002)(83380400001)(86362001)(31696002)(4744005)(2906002)(6512007)(31686004)(6486002)(2616005)(6506007)(26005)(66556008)(66946007)(36756003)(66476007)(82960400001)(478600001)(38100700002)(52103002)(158003001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXNWcWVaa3JvOW5WSVlhaFFYM3NlbDZuYWhyUkFMWDgwbU8vMDdzaVNIZ0VC?=
 =?utf-8?B?NzRMY3BISTFONFYybUROaGc0S2hxb3F6MjJ2dWhQVDRkQWhmajhyQWNGR3JS?=
 =?utf-8?B?ZG9TeGZhc3NPVytiNXorTEtpQXlqUksyVGVFSGNrbnE4VnFKUjF2Y0RieENG?=
 =?utf-8?B?TUxrdXJldGxqZmdTY0wybVNxbDRjaXRuUHpYT2N0V0MzNHg5QTZuSmhJZmIw?=
 =?utf-8?B?dGlwZkZ4cVdPRnRNVjh5RjAzYXNaSmZCWmFxaFMyT0pIZzRqUU9YeGlvVUpN?=
 =?utf-8?B?cmFRS2ZyK3NrZGs3OExqRFNWcEpEMWNTTk0wVmtxakkxL1VhVU5WVkw0SVRD?=
 =?utf-8?B?YVc5MmJ0Q2hvS0JnRTZINm1XT2M3c1NKYnIrSTRoenpiZ1dCTGdEb3dFWTVi?=
 =?utf-8?B?Z2pLYlE5M1oxVW8wSE1rTUFnd2cxVmYrYW1KTDAvSkdRbEsrU3dsQkFJNnlO?=
 =?utf-8?B?clF0UVorNk9uOVFpQTFoUzNaaUJ0bE5ZOHlVTlZVMXVTdk9xSmwwN0ZRUFRL?=
 =?utf-8?B?L3lVMXltR2dYRTRKaHlhQ2J3bXFaeTVYdTBKYzBJWXN5NFB0MUloWEhINldk?=
 =?utf-8?B?ZlMyUTR0WmM2OWR4TnRlQjdQK0Q0M0ZpRDB3N0YyVlBoYkhvSzNEU00xRWx2?=
 =?utf-8?B?U0VIZ25ENXFxL0FmUmFKblJzWFdpNmp0eUdmWmVINzNjYjk0eGx3UCs3S013?=
 =?utf-8?B?UkFrN3F1aDZOWnZsa2M1SmZXTXYyQWhuY0IrcC9mbHRSYUdWL3BoV0NQTWh3?=
 =?utf-8?B?dFZlWVIzNXQ0TUQrT1dzV1pHaDBTUjVVdFBiaWxDZnN6cGVldW1xTVIvVElV?=
 =?utf-8?B?UHp4aVFGS1pReHAzZzZvZXZZSklhS0ZjWDJOa3daQm4yQm9xdHQyVW56RUd2?=
 =?utf-8?B?SHQ2LzdNOXY4MG93emFwNlZ3Z2c4ck9ENExGMEV5Q0ZYZ2V0U0hjQnBkRkRv?=
 =?utf-8?B?Mko1a1hBTFdVSXlJdktib2VjcnBCUjI1QXdGYm1IYzBwMjFhRXFndGVMclBT?=
 =?utf-8?B?UGxuSEJ6dC90dGF4ajFpbTZNNUxUR2JieDdwQXRMOVdFTllxVFRNZ2lFblpr?=
 =?utf-8?B?QzdXK0QwdE9PNS9Wb1RjdzBrK01CMEE4cHhPakx2dmovM2JkdDIwU2ZFcXVJ?=
 =?utf-8?B?TWk0b3JSSHcrc0ptTWE1NklEaEV5YTBnK1Z4d1luWDhFeUk2bysyQ1BoUWtB?=
 =?utf-8?B?aHRydDdVdG9zbVBwODZwdEFFVmdlNk5KbGthKzN3Q2dwSm5jaEdLbGloK2d0?=
 =?utf-8?B?TFQzcDZhNFUrU1NGUXNLQmJhSmUxemcwM1EzcmFmQXhjbFI3akhkRXYwcDRl?=
 =?utf-8?B?dnNpQWdDOURFSnBXQlFIYll4Q3QzSkNXd2JGWnh1VkZsa0hFd3ZvMUUzNEZ3?=
 =?utf-8?B?SjEvR2hTRk1wM2dBOXFoR0JqZU5NYnZYRlpETmx4U05BTDhTM01nWDdRZFQv?=
 =?utf-8?B?RHE4bGFKQkRlT0oxWFRvb3ZLb0NvYUtLYk1qdnRRNDNIYUx5NENTd2VOdkY0?=
 =?utf-8?B?Y0dSL3BCeEZaUitzcHc2SVFOYU14RGFPZ1pNT1dJTzB5ZEdWc1M0R3FvQXIr?=
 =?utf-8?B?NE85bktSSUM4ZkEwd0tHTU1aOUhRUmx3UytIYUIvOHFVZ0MzWkhnU3RPZjR6?=
 =?utf-8?B?UmVlYjQrR2N6dHpXR3I0K3JmR0wzNEE2S2ljSEdTVXJtOXUycG1nNTdDRG1z?=
 =?utf-8?B?eVcxUkZpR0pSTzFnRnBwNXNTV1RPd3lUbDVaRWR5YWdCMisrVDZkL0ErWEt4?=
 =?utf-8?B?dzIrZHlKMXFIZ1loV1VLcHorcG9rZ1Q0MTFnS25lWGxycmZQYzNFTUdoNVBX?=
 =?utf-8?B?WCswOGFIYkxDa0lsd0czb0JUcGo1Nk1MTU9RMVpTWklLOEYzREszN3BCeDhx?=
 =?utf-8?B?QjBEaHMxMVd3ZFBvYUczUVdZZkltdVJ1WHNmdVN2MitYYUhhOVZFOEdiR2pq?=
 =?utf-8?B?c0E5em54dndpM2ViWkl0U1FzdVdackpiandoRWZaQzZDa3JjWEtWNWdCWjdU?=
 =?utf-8?B?NTNLdXl2TCsrVUk2Tm5DaytTeU05cWVoaXZyVVlrenFnajZxRExYUXZIVWNr?=
 =?utf-8?B?US9RYVlydnpCRmhySFhpcjNBeWdLdE90SlgrWkxFUFpsK2dOU0RqSGdjREtj?=
 =?utf-8?B?eXJJMzhyOGtTWUxJTXBJMWx5UG9nUEcrZHR2OTh6SFJPVi9KVE4zSWNnSnVE?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6182f20b-bbe7-4f31-a899-08db98cc5b4a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 11:32:47.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjAL6+gRICBTPIPK1omo8XiyzpI/8MEFMCh6rRdBxPr+2FYnqsygYSOSlJ1kpTGDMUu5uWpBJiA/fPikX8voJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6062

From: Jan Kiszka <jan.kiszka@siemens.com>

Now that all their build and runtime issues are fixed, we can hook them
up.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/Makefile.am | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index 79dc61e9fd..b7654682d5 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -40,12 +40,18 @@ COBALT_SUBDIRS = 	\
 	tsc		\
 	vdso-access 	\
 	xddp		\
-	y2038
+	y2038		\
+	alchemytests	\
+	vxworkstests	\
+	psostests
 
 MERCURY_SUBDIRS =	\
 	memory-heapmem	\
 	memory-tlsf	\
-	memcheck
+	memcheck	\
+	alchemytests	\
+	vxworkstests	\
+	psostests
 
 DIST_SUBDIRS = 		\
 	arith 		\
@@ -80,7 +86,10 @@ DIST_SUBDIRS = 		\
 	tsc		\
 	vdso-access 	\
 	xddp		\
-	y2038
+	y2038		\
+	alchemytests	\
+	vxworkstests	\
+	psostests
 
 if XENO_X86
 DIST_SUBDIRS += x86io
-- 
2.35.3

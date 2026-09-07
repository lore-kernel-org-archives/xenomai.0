Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593C3A48CE
	for <xenomai@lists.linux.dev>; Mon,  7 Sep 2026 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791123; cv=fail; b=ON59NF6HQYi1tYhvOh8zvswCRI+jjiDFtzAkUk5oc5TWs8GZpynlSSSd51DusPmulvDmmF6qJerT3RCmb0u3esNRwEWV5XpdHFIfkVdb1DXy1sPpfryQv4w9OxsY0CQTGzQTOHGAolOu/xSPAPs/YZatZRiwkNEuTePT47bYxxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791123; c=relaxed/simple;
	bh=zxYFTp60I0j77/xyvlKamwrggmM5cRkUr2KPl8MIlRI=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=YlTFdCdGST6Xck3hO8Q0rQ4DltlY+p08YySjVS73SMfyeOoFQmVTmDv2Ca4sIVocwBv+TQWqkn1uPU26uhEhKZoUoFiHZWapoNDEcLJgrzHcVdfiD9H3l5LxX0DlVlZRz4g5eOjOiepoZeamr+fzROTReSVt029g6Ajgg6m8etI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DTazkE3Z; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DTazkE3Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZbQSrqhvKmTQT548lziJMkoiNXs9aE53HI4AlkQVeTXfP0VxNBGM0e8sWoEB8QxJuUYLs46Qn4s5f3EJPd4+AiX2Jx7J1x3Usgqz0JRN0oYrdaodFJ11cxYDXOF/llElHn5cO3LtUrbr/mriZXGrXElwp6rewpVrlpbpgpNHwLjEH1u0G8d5/5kyMlcZYVCv8BUdbpUXus7IqvDLFuas8OUiXMCrHPsF40/vuYFWFIj4wm3+pWEfMpk2ZBle76bFvtKJCVSdzrIFCC0FqGxBh+hIGFlX860zajvsRFwwVQgmoddNLV4RmMpMomuneozOaRIoo0PInseC0rENI+JUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+LT+fASihqQKyLWwyIJ4olBkdUt2Q8OSd1t9rC/mng=;
 b=gV0JXh9Zv/l3juXTSxNPyz+tiUlDcWXlO1r9lmOYHsZJMpnpcbFIdrLQz7kS77GRByufBntZWkW28LtQMdOdtaYWv99M/9rE7SomrxrfEz+TGNkNsUgxeZ4cTFx1qj8q7n6Cahyy+mAT6AAW4lY7xr+TC/llXKUF97lnIrBGhjmTzHt8leZv9KhtpglsuibtyukAbUQaueIF9zuPzB+EcHCyp2FBuqGrwqMuq29wzwAiyU4FCKNdr9AKMIM1CFbYrrSmJL/5X+b9M3R6+I0QqezpoI8dOtiDfR8p6gELiPXoCYtjFeVlbKjYpSqiFX7vo1gHwMNI9vIBpkmwujZ8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+LT+fASihqQKyLWwyIJ4olBkdUt2Q8OSd1t9rC/mng=;
 b=DTazkE3ZZhaxHPBwVTE7m1sTEw/cDt1HuhxrM/4PPSubCLZKD2/U6WrC3uUFTxnrLeuUKhLG4cxzOc7l7mXVvawADqQgwLLKJ8QL8drakLAxxBMrPseLge3oByAj4uXLzaYTKmv7EG2zXKXKUaKOdDd4cfqoyEJOm9OFX+MPq0v3nHmHknHTOtnmupugHaxVjTSEZYBeUuHcCnL4RzDuFrcjg69c84sBV80ogdGwjlzztu1I1x+LVEy4kTk8nmOeZ+Lq8zsDEeFIRoUfvuzUSMK7MvaA1X+V+AES/S0IDCQicCY+VlqSslIUVgWeHR2T1P4nBDBBb1O5MZ4+ywySmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB8038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:25:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:25:10 +0000
Message-ID: <e4e3a6ba-d736-4338-9638-445f27b4a842@siemens.com>
Date: Mon, 7 Sep 2026 16:25:09 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] ci: Switch bullseye apt sources to snapshot
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e97d22a-60b7-4425-4606-08df0cebd2ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	+nyRjIHJVfwDgb7G7hmaxYBFRUUS7y1dkSjNC7LrJOmJr9XRvOQrtQT4sRy9fRz7WpcnTFkx2UP6GRkpfKNBsMR+7I0La1d24RoOeF/vDa/ZIvVerdwAhWPySWHCWfYMKUQi6NG955/8BtASLeQna8adVe087EUTPt6Rf+cdwTf8WkYzs0HaiLKoQ3DCt7NfoJKUGS8ofjXMOdabIuhurIGfnCHLJRDgJsh3FwEDGMWvEQ3vJqNGKgXjykrOw0BPANZP4VwX0P9C0jDb6IdAE5fahVvNMXUvlsKOgA6yYQOqni3KsKtrbG4WQvTTVufkF+XbVLP94LcXws69haUQLAZGZmJpGmHdOdtEOmeFdHdKHr+HebLM49Yf8qnDjG4jtkeMmOFok4av2YmG80RNUVheT6mEQH3JPKaZsDSRl3BoHA7oCdUhmuKzUtjJ1O0dfbLorFAD3y4ideceHGjVzzLMibV1phiCxFiMSt/xpkuL7wsjWtSoWw3SuDQV57tqxtgJtFg3YqBbwEq9jRWP3ws0kMzPYOV9VHtZ7u4zz4vFrI84PyYbE1k7qg+BxSS/PVJEDi38gMYiHXaf3qdTVjJhgReY7rju33jpwxYez6IGRuNkGZxHGNEFY9AQIAcHs5VBTzK9zxbj5oANL/MilIXld5FZ2zRtC3bJax2xfMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djBGOC8xeUJIUEQ0cUFaT243MzFHb2R0bWpGZnBlUU1jR0RDU3VVQjZJNzc5?=
 =?utf-8?B?VzVXclIzd2ZEYWhrS1V2SVp3U3d6STMrWkE5dzhMaHdJdmFYeStzMHA3Mjkz?=
 =?utf-8?B?OTJTRjhJVjN3TGpnNlIrQWxoWXViMDBWM09kWU1Ga2Y3bzhRNmVoaGlPL0p3?=
 =?utf-8?B?UmgwN3BuOVlRRXRXa1VRS0lXRGtYZkhIWWJVZy9kODUrdVhaSHJGSVRhMkJ1?=
 =?utf-8?B?M20wM1NkMVZLeVIvSTErdURxaEZYVm9Qc3BxWWVieEplQUpzcEVOWklDZW1S?=
 =?utf-8?B?YjFYMEFDenlTRHVDNHUzOE1DSFA2QjB6NmkyMUhhbFdoZ1hFaHBYQ0c5cldu?=
 =?utf-8?B?STIvS3FHOFl0THRjSnVkbU1Pd0V2cUFCMHZsUXpyZFFuZklJcFg1T2dsMHUx?=
 =?utf-8?B?OGFJWHRBcVk5M2d5MVM2cUo0VzY2b3NQSmFYdjJ1ZWVNcE5hbU9GdjJZNTlT?=
 =?utf-8?B?NlFjYWpWMmlJS1RjekwzK0RrUzVaSjJ6NHpMNWZGR09WeWhOQndHRUkwM2Ey?=
 =?utf-8?B?YWo0V25FZ2h0QnU5VHhvdHh1cGY5bW81bGM4cEwzYlRpekdwWlhUa2xrM1pj?=
 =?utf-8?B?ckUrT1pld0hmMWE3Q01sWU16bFRDSURadVg1anRzM1Iwckx4dUhoZXRVUnRv?=
 =?utf-8?B?ZFJLZXJXYVVnTS80MGdmUDVmM0Ntc3JUUU92dzZ3WnlRWTkybzBaNjNmVTVL?=
 =?utf-8?B?MjRmNFg1SStSVmpPZVlRNTR4S0tuYXFSOXVLT2s3anFFay9oQ1E2VDJ3dG5i?=
 =?utf-8?B?TFlOLzJQb2l4cVVhZG5icG4wa3U1dk9kMlRPL3ZmbjFjU3hpLzlYS2tVaEhJ?=
 =?utf-8?B?QWMwcmwrTGJCbnJheC8wbEtGMGI2LzlycDhsUkJWN0toR3lnU2Z2ZmszMDhL?=
 =?utf-8?B?Uks4R3ZOSDdLWHhLMUNhYWdJTjNwMjlvaDl0U3YyT296NzVZRnVJUDhFVWxW?=
 =?utf-8?B?bGR3WDVUYmlpajJ1THltQWQyUkFjQ25hQldyVmFsb3hFejVoOWlIdk56a0RT?=
 =?utf-8?B?R1lmbklEN1lHWEU4blZ5OEIzU3Z4cWJYTWEyQmtiT1UrcXNscTczeHJSTk1C?=
 =?utf-8?B?SXNMR1BUREhpSmNLQlo1NW5pR2JJSFVtQ3hWaDhMVEk3UE5BSmdmNU9nbWVZ?=
 =?utf-8?B?bTBReTdtSStBTGVVK2REMmFTKzgwbUtsMnE1djNBWmdDK1Q1RzdOTGJ6RFVN?=
 =?utf-8?B?N2xHUEpoOXU5Mld6MkVuSVpIZElwV2FqSWlBcmNXNkJuOVl1c2ZTdGhQYVc1?=
 =?utf-8?B?QjNxRzlyMVArdktWM0tVS2tPajBWZG5uaDc2U2tXb1pWUUROa0RXd0hKSC9I?=
 =?utf-8?B?NXdiZUdCV2V2TWk4akp3YUdIQ2pVYVpQbzMvR3ZmdXBKcWliQXRQK2gwc0Vh?=
 =?utf-8?B?WHB1Zy9GNmVUWFJNOXNlMnAvbHlsTUh4eVZLMFk4c052bEVFbGpoWG9ONm1h?=
 =?utf-8?B?S0Z3dWZIdDNGd2Jwdk8zNTBSQk51b2RUVGdxMFNFSXRoblpLUmpwL2dzbXRp?=
 =?utf-8?B?MFV4RU44MVF4b0RDaU9lNDE1VWdBWlhHZkpVa290V01tamdyZVlNcURabE9P?=
 =?utf-8?B?c3BIaXVMUFAxSHNiSWpMNTdZQllKUi9TMzkwRURpbWt0Qm1vOGRtREJVbS9E?=
 =?utf-8?B?NFd1bGN3RG5kY2xubG9QVWVIYW1oQUpNQ0pNdTNNMloxRTVMWWtaMDUvZy9v?=
 =?utf-8?B?azJ2c1V5aTVvR2YxVXVqSzNRcmdjeHlzRGFWYUM5SUtpUXBqTG4yRDZ3SWNB?=
 =?utf-8?B?UFVLN2E5QUdtR3NyZlhLbGozVGRpOE9TRVpZRm53MmdIYnBiREZOaWphY0kv?=
 =?utf-8?B?anZ4MGZKVVAyYUhPOHhPSHdjK1UyeTdGWVpJV2dtVzgrRmsyalZqU3JMMU1I?=
 =?utf-8?B?R0l0ZU9PeGpJdXprQitkdG90VDRKbmUxY3ozbkg2RDdVamlQeTVybWlONy9T?=
 =?utf-8?B?aDl2clFFR2NqZjR4dCt1SmRDckg0Njl2MmdaOW9ZeExWb3FrRXlxYUhmeS9P?=
 =?utf-8?B?ZmtDendkcjNyZ0Z4K1VYMlppN3BMUVVlc2JDejBKOTMxbFZpY1NMUlJWbGxF?=
 =?utf-8?B?U0lSV3FYRW9jMTdsMHA0Q3dlNkU0OWN2ZTliL2M5Y1dVaUREcHpEL2drWml4?=
 =?utf-8?B?dzliblR0VEErTFh4bitYZDBRNk1WYmVXYmhrZGFQM2k5UGRBbDNNb00wREl3?=
 =?utf-8?B?b1JqaGtBWnI3eHZVN2toeVlTVDFBMXNSWFNYUkxvUVNudjZ5aEhlSkhpcTFm?=
 =?utf-8?B?SUxidGtieGtxakFEbzVMMzJNL0NHU2hSRVgrWUNQblk0MG01SWVZYmh3REM2?=
 =?utf-8?B?VXE1cDRtbWwxNGdWbEo4MzBDRVFjSkxUUitMeVJFNVFPQkk5ajNPQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e97d22a-60b7-4425-4606-08df0cebd2ce
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:25:10.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eg4Yq3a+5/Lt84u8iSQsaFAhmQqPkTOCrOKPU97lKcjbgsFXyq2wSojW+USsSq1jK5LNtzJi3eNaZhrd4RUNIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB8038

From: Jan Kiszka <jan.kiszka@siemens.com>

With Debian 11 having left LTS, it was also removed from the official
archives. Switch to the container snapshot URL instead.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1188222d7c..7b47306e4d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -265,6 +265,11 @@ i386-userland-y2038-unavailable:
   image: debian:bullseye
   variables:
     GCC_VERSION: "10"
+  before_script:
+    - sed -e 's|^# deb http://snapshot\.|deb http://snapshot.|g'
+          -e '/^deb http:\/\/deb\./d' -i /etc/apt/sources.list
+    - echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/use-snapshot.conf
+    - !reference [.build, before_script]
 
 trigger-xenomai-images:
   stage: test
-- 
2.47.3

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498101;
	b=uQLHKR2vmJ0VwtB0gGBOy+46QZovOHEKwOwvKoYyyxItfYXROT3L/4sO4+GQFJVfacOs
	 E6KKmrvybdk0IBjLOFuXKpL4Mz/nOwE+HvmUibzmcb0xtXc8wDpN7oz6WUdF7O+phjOlK
	 z57J0eP9xi0fE7y8z8wIVESoPtZPv6CtiDBJISzq8CASdtnxkgf7D7YXaHTUxOCPTKCDG
	 T2eoiD6QzSlMMZPLVUd1APferLb9GwtKU/ErQJD5m9n8oRiXireoTe7QPVcbOJx6sMJt8
	 490gQo+xlLQ2G72bJtc0FTTibmd0Y0NH0gXsJMCmN9PzZZlBjsM854JdizIipldvUew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498101;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:Subject:Content-Language:To:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=52a1lFlNIGCPw13FZhqNuzhHZOxHONGol+IRdxzrctk=;
	b=xUVg6hYYJwBqS39t9M/KJlP4Ftlvi5057fqHcQrd50S1ho5Gl9qlXifV2Q4kT+XNf1lM
	 jiJy6+wIt3YcbH6lQNQuZH9mI8po+p4TiiGs2vE3bmsNgs+4HvqJ+tW7W3kad3KMd/0jo
	 TfCDp7U2//7wz1lUF2cCo0gVbCEuxcoPq8CKNDOUw3GsnYFT2Llt7jzktYW2xutoNkCTw
	 wad8WiczJKEkp26ZdTxlleBmpFf13+DcmHHuNbOCI1UdL9hMpU+ASFkz3AM4Y2OM9ZI4p
	 xuWWEtP/aaMh9YM9xgZ9ZsMsukff19oEEbWh+8zAu7um7vgQsXjTRQg8oFINpzbsUEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dlXdFMXb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.37
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACC0606A327
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 15:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ACC0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=dlXdFMXb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4qrmdFVDsMbr+zeq8WM4rlOCc31KJPwqxf00+i8XuH7w4KsXVEbOPQsoVFPgaGkmZ8MJIbHcsmQsBUnwtqLkPtX+SRDifmQxAclxnJiP1MRA/JCY41JR9sZ/d0xAzsj1Yto9TZFlJEKds316ZB4yAk6l3c3DImG67NBO62WTPrjIyWRXqUpcDlNlhWzfnYNwkdNkq2FMBWhS+56MlV4k4m3jNYUiB0CkGN+2LzT8HXQcofEWJdbXyK6Cg2aFS2+MW0O4vGywdPPHgj/kJYVZ//ZKfyfke5ugItf+cngpT3ic5n9Ut+6Q34D1fyCQDAWzrk+Jj5OfWYZ3kWu3yk1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52a1lFlNIGCPw13FZhqNuzhHZOxHONGol+IRdxzrctk=;
 b=tJPxjRCavlRe6yUCZf6hIE6bYlVaEqOtF+9XpEvxS+9WQpi3909h4VgVgdENWPUn0QFOgaOQePVozYm5QjgiPXGPgf7dIZ7pC0DeIZgCfJ/sXmyhholz0brmZn2uaKE9kk9GhqEv81b03D/9c3ETePZSGXZUhlXJp9EIDwZLQ8wSUymiyGxn8+gUQt3P58WVBw9r0ZNc0AmaNyU6Kuv/8ZgYVOCZgIIj5i7eD68x7Jn+nNzB5vpjNzhkGLeSWypj605VNRGfK5nS8F/QLwPUPOJ6HhEIc04IMZk6LoQ/LDlC/vZN6uzwP25r7RaOK/a7xV1eZO6MyG89aX6jyWoAkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52a1lFlNIGCPw13FZhqNuzhHZOxHONGol+IRdxzrctk=;
 b=dlXdFMXbK/ozAKevvYHePKeFuzIZ4E3vlGENJ/zOBMHceZeunfglptqlHisLVERJwG72NvfiYx12gMPWBOehx+11ri22cXSyribICQkh+w8Es8c9IP2ZoROLJuDdSpsSeCqMhrbagcfUz4OCYMSsDDv4pAMniygh7KhWj1+gWk1PbC0qM0SWrIZU2j4FctS/aLg2VpbmZWDJJ5dltEwnnbLIublU/Dugf+7GLoA69UGuH8P/t7uAGiTH5sYlPd3+cmyejcBrCESJVWTTChSqtyNgYSjXxhF9cV16SKx0KggeRi6FIR43mzxyPIDY8WCqclihGkBnynhSKT/JGpB7wA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GV1PR10MB8345.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 12 Nov
 2026 15:41:37 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 15:41:37 +0000
Message-ID: <1bc0efbc-345d-4ba7-8670-c399a5509363@siemens.com>
Date: Thu, 12 Nov 2026 16:41:32 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] x86: dovetail: Drop bogus local_irq_disable_full from
 __bad_area_nosemaphore
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GV1PR10MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c15989a-6710-45b7-780f-08df40d37001
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|261021123027099003|11063799006|261022105027099003|56012099006|261028144727099003|261026140227099003|261026121527099003|10067099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	xwpV9MhhnDTUArh/YD/kN95HHZgNJq8v8s5uGejwcRgIYGsrLTNq0/t977lmEjoG/liBvYtBM24ApEJN/NratyJzXDxcs4mGY0AMgK/xG1b+rGQSQakBAbbHNe82W5ujhPscX1vWlXohrsGG3artX1RjYaTG3Q/57mz3q//97JRlKkPitTciOA8hM2bIz4HjGYxztxhQTpv3FGqC1Pj6d5mV31ZfnXJZXLU+ySJK0K/Pa/DYv/eqQeug5sqxIdnpLxxGO6AL2q7NSIO6OS956PDCJf9V3+L6o6fV5RD0nCmWZwSG4YQUGKWEVw2Qj6mlJlWkdu7BrRjZQ+dboCUSOasQA//1bpUHdhRXVbEHHR2zEB2VW7pYBD2i9NQguGQJBuLQ8Z+F4FFu8vk1lwtWG7jaMbJZ+3nG81ezKFIl2FM7LNxI510EqcHgk9oJ3lm54kt6FruzkcGrNrAYmK7aRmOPMxvOn6XZqnxJHMtxUFPgHeQqiz3zjYP+EtIB2V49gRbTTaP8o2XjBoIggOulaO9DM5pJwEvevsRNKEOcP8wb+UBteJylNOABk0Y2BCj6GdmG63G6vqX+AlidU8xWmosjoKL54aZ/ihI/jGzBoU9wmeMmpUM+KPz1OF7A2fwMcdSnp25iUwL2uZ7fgz2cJmChqA1eR11Zd0B0gX24SI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261021123027099003)(11063799006)(261022105027099003)(56012099006)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUpXS1Zkbk5zYlR1WUxCTUM5WmJpbTRaUkIyYXNKd09wcWZITi9LR2hidmNl?=
 =?utf-8?B?OVlpVjI5a2FmbzRoa3BqV2RXV0JxaVluM1lHdUhvSy9OalJTNVE3V0d5ZVQ4?=
 =?utf-8?B?K0x3YmJTSitmRk5taFl2QzJwaStRKytic2RackRCRTFETWhmV0ZreTFTRlF4?=
 =?utf-8?B?VkdvbVlaSlRBMElFSW9ZMVoxZmN3U2s1N0h3QXdoOFoxZ1BETVF4ZythcnR4?=
 =?utf-8?B?Wmo2Tzk1ekJwZk54ZzRNKzZ3MHpkZE5KLzB0OVFkaGNFSnZIbHVZV2dDdmxw?=
 =?utf-8?B?Vm80dnZ3aGpRaGFwUG0vaTRBL1pPSiticHo1TW9ROVZoNXdpcGl4UlRXanAx?=
 =?utf-8?B?V29jUjdZWEpCVDh0OFRkN3FzcGtPbURXZDV3d1hYSE5UeCtHT09lM3ZpcTI4?=
 =?utf-8?B?NVFXYVZ0VVBiMnNubEswVDFpeVc3bU1mTzBEMkJQdENGY2JleWg5NnVGWE9y?=
 =?utf-8?B?Y1FMTUtsb2FmTm03QmJCSW5OQ1ZzYUdvQVQzcU5XT0FnL2N0cHk1Uko5MkdF?=
 =?utf-8?B?aEs2UWt3U0FVN1lqU2YrdlRmWXFqcDJFU1duT0dDZmRpb3k3TU14anlIaE9H?=
 =?utf-8?B?d1J3MEZ3STYvblZwRVlNMktRK2xTN09hSE9yeXl2bUYrMlVmZXhnVnl4Y3BF?=
 =?utf-8?B?NzRDOHJRcVpSaThzNElvcW9qRzRQcGhlY3NKc05KZTNYSWJKZkZib0hqeGFk?=
 =?utf-8?B?T1JxMVhwWU5RdjJIbVlvRE9DeUltcnV3VlRhdkhiMkdJeEFoam9qSUI5eGNn?=
 =?utf-8?B?QVVCZG5WaGdCRnJUUXYwSk9ZWE5LQ0czaGJwV2dBZjRBQ00vK0xWSWRFVFpo?=
 =?utf-8?B?TVJSeDN2akV1Rm1SQzFtTWp2L1VHMDN3b2VaNXpXUDdja3lWWGhWcjhFQlJX?=
 =?utf-8?B?TFJ4WEY4ejRRUEM5TlY5cE0rcmx1TkJEYWlwTzcxOHJ2REd6NmE4bWZKL0k0?=
 =?utf-8?B?LzFXay9HUjRNL1h5RmFOTkhGK2JqSHR4VlI3TFp1RHpRUVFnbTA2NzlaQ1Rj?=
 =?utf-8?B?SXpUSEplUWtEanV4K1RVcEZsR3l6SWpKaFlPY1EwK3I1TEFvOW1BNVhud2t0?=
 =?utf-8?B?U1pXUmRBN1ZySWFNT0hsb3Ftb2RBOFFXY1pqMlk4b21sV2RBRWppTHJxcDlK?=
 =?utf-8?B?N3hBNE1VWFRnY2c2VnJKeGlieEZVUWVXamdiTy9QUE95RXBEUGxFYm9idzZt?=
 =?utf-8?B?K2JITjhTcG55K3ptaEM4UVAwN2pPWjhXdHJDTlZsRTFnOStLbTZPTTVYeXlO?=
 =?utf-8?B?Y3N0a25qbVBYL1hpUzdiclZIV2Y4RVRwYXVZQUxKamozbDVRcmZBUHdUMEdK?=
 =?utf-8?B?Mk5qcVhjL2FhUlBMUytWRSt0YVkwcHY4QlZhS3BuMnl1R0tDMTJTaWQrYm8w?=
 =?utf-8?B?NHhNSm1xM2pBeWRvZVRhSDdoZDlUZC9oU2l5Ylh1Zkk4bFFVSE9XTHMybDU1?=
 =?utf-8?B?dmo5U2cxanlzd0paYUlUOHliZllLU3ExNi9xU0ZHL3MreVpQWndUODRvVlBt?=
 =?utf-8?B?ZTJDMFg5WFpNSGJNczYxWEkxM2d1OUo1T0VzczFhQ2dua1BnZnpVUnhNZ1g3?=
 =?utf-8?B?eEV4S1RFY0FuN2Mybk5RTnhOdjhEOTd4ekxQd29Jd0hnZ1BnWkVpN2ZBY2Z5?=
 =?utf-8?B?S0FlbjljWC9sVVFGNVJPT1ladDd4YTZlVnRWMVROZW5IaHZnSzNxTEJIZDZJ?=
 =?utf-8?B?VlpjMmppb3RKTHVtOHMvSTVBdXh2S2tGVno1K1VLcEdGOEZVZHFRTGlkV21U?=
 =?utf-8?B?d1pPbnh5QTV0NUxybHBKTXN3Q3FQbWJ0cEpCSkRnRTRNU3lZdDZqcjNDb09J?=
 =?utf-8?B?U1JMZkVxY0k2WURiR1lqU0Y3RWtLeUdtVS90cDBPVkpvd1NnS1BzRjY0dFFS?=
 =?utf-8?B?KzhYVVBxb1RtYUE2M3E1NjJvRmcya0d0bE1oWlVRSDIrTkdwa014K1JGb0wr?=
 =?utf-8?B?Y2VpL3dzUXZmOG1LMURYWUtCSFcvWnNrTXYyYm82ckJHekdsUE9nR2ZrTFVO?=
 =?utf-8?B?K3FBQm5vVk1rZytqV1QycVlsTndWSDV3Rzgrd1pON01ibEc1bFkzL3ZRU1Ir?=
 =?utf-8?B?cmJ5QzJjemZEVXhqdWpza2hEV01KVVhkOGlmZ3k1bGpJbjE3MmhhdU8yN1pl?=
 =?utf-8?B?NjJ3UUttaWUxcklQQWpNSlFuUEpHQUdmQnRSM0hxR3VtMXMrblRUellVMGhw?=
 =?utf-8?B?c2hHU0RmOU1QZjNEVzJMZlJDOHN4RkZvNDhkZkVFT2hHMDZUZk5HbTdpY0lN?=
 =?utf-8?B?RWZVZURJRG82L0duUWo3Z1NmTU9vODJNTk5wYmFLRkI3TVIybWxMZWxEWHdh?=
 =?utf-8?B?a0tmOFgvV0ZNWVd2RU9WZU9GTE1HaDJ2SkZ2aDErLzgySzBJMGorUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c15989a-6710-45b7-780f-08df40d37001
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:41:37.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdvRBDtbdw752tLC9xp4VIwjDddEDf1e2Dfrg+X2L+3wwsbKT9dbMJwuaOJtP2tnnmgGUDzbpvzWW5tWqQ4BLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8345

From: Jan Kiszka <jan.kiszka@siemens.com>

Upstream commit 614da1d3d4cd ("x86: make page fault handling disable
interrupts properly") moved the local_irq_disable out of
__bad_area_nosemaphore into handle_page_fault. At this point, our
previous conversion of local_irq_disable to local_irq_disable_full
became stale. When commit 614da1d3d4cd was backported to stable trees,
this was noticed and resolved, but 6.19+ still kept it, incorrectly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - clarify the history of upstream and dovetail changes

 arch/x86/mm/fault.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e41ed2092730c..e9a08a5d26e60 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -886,8 +886,6 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		force_sig_pkuerr((void __user *)address, pkey);
 	else
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
-
-	local_irq_disable_full();
 out:
 	oob_trap_unwind(X86_TRAP_PF, regs);
 }
-- 
2.47.3

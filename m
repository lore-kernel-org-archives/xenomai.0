Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E017B516
	for <xenomai@lists.linux.dev>; Mon, 12 Aug 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468225; cv=fail; b=oaRs+na2DsEA/Qgsd8/BwMLexz+rCQKz9ulnlK3cR5XAdod1ooGMEQ6z8Bfo+JzVVCBjzxIQzx7V9ARLVbDDbetWXKRMS5CsPDFPGtLDv7rd6ye0c8S7kZyMcDWGmAwKBZt2CIVJjHwz7TnREEETcY/nbYTCHmbA7+GbJ84i9Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468225; c=relaxed/simple;
	bh=TcvuU0D+x566ZNRp8GAcnsdWC30NugP33mlg9QBtFEs=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=sUA11KPZCaJErQmHJMjpSCjINiUqPjeLkJBbJHc1/3vjA+ukOulgJWJwLxNbCmMi0ZGzGZOb36qxLmZpQn24aoMX7HHhRQFyO/cPEkU3LnwiupB3S/eFt4e22AKyFOgzllFf0RkQOEUhZW4Tc+uSOPLcSIV4qyqxlStLw4gxZwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Vw/lNym6; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Vw/lNym6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ3XHvNNlUNY0kYFrBdhnGKJ3ODODPfqt1+T0agkk/6UXkIloHZo2k3YPcihmnQ1y8H0DMdSae4erIxUVrWo07NR3j2rca6yoW90fWwd7krifrs2BPJwoDdeTV+mbqZkMoDs7sc7qmPSFyJGbsP6TrvVx+ibzdcisAqEEGAXimFtllDq+CcdQVm9ZCNvrHARNa+w2nz9+9mA4UWEapW+JzsU3VFzkkB3Vf1S/rsA4jHriGOcB7AbQjX0j+03DXIX90yQCFrj7rJCeS8vTRklWmaA1gtsOuURSmnA/GwHpSvbMoDrc40a/hjU3NDMVI9y9aOClAhIZgajRTBEX24E4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjx6SBRTrtPn5fdbo3cXhBFhY7zoPxuifsNuTL373sU=;
 b=ZXbk6iOWH1ZPgbDqsqwQ69eBJLcKHbTfF9ZwbVyuNyn8e92JSUgLLCtYbd13JHJVFKS2+DglSdJeM6/QatqBurAbWbPU2q18zcde5qQJdX72Mq8YXRD7RhOT/6jtkJOK4bUaNAdG/pNzVedrO6Ouyup4JNxC/39AtqeAtj30F81B06KKj05oo4ZGBTcZgQGl61IZ1mlIvjL99dO3MAvMOzIjDsz39wZ7o/OgMDiFMsGOi6vVLf5nIYGNKRsg/QLjY0QUGJjMD0jcUkmKefS9kXixQc9mA6TelbgOsiUdVru2L6u7WH1xyKMwsFOhqEM/j2W7ZvdRKBYrpZUakfWzQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjx6SBRTrtPn5fdbo3cXhBFhY7zoPxuifsNuTL373sU=;
 b=Vw/lNym6xEZ8id7lxDV7R+5ygot1oUvkBhBkGy7bTEjIQJqK3ptQmBhJHVhPE2N4T9qGpnFDcKAvd0vKlCGe8OGHnpy2+1buXZtEiZXeazBP19bbvHQlAmrhKoa34i1Y1S/brpec9KBgKXStPoPYx/LHHcrPOVt9tfxJam6a42oM+/xpyNBA7XWCAV/WHs+ibmw+BYGtk0pndYTCc7TG2UMhxI2dmEVHIK5C76hwMpCzrz/pcbPdOOwM921kZx5KFOvEvJVVatYHhH/vNnenSgc1zVLm714Ud+lE4SOXlqn85D/ke0eFUxHQrTEKIFq+hMnpd2u7HdjebMCvW5YpnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8372.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 13:10:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 13:10:18 +0000
Message-ID: <46ee8d9a-1aee-484d-bb6f-7696eb8b702a@siemens.com>
Date: Mon, 12 Aug 2024 15:10:16 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Tag test jobs to choose more appropriate
 runners
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d48f0dc-898a-49c3-4af6-08dcbad01d34
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHRFakFiYWlyTmdBbXFCN1ZpbzczSTFvVFcxSXFJdkcweXZnM1grTzZlWlUx?=
 =?utf-8?B?bjAwdjBBR2dzK09PUFROUGFDYnFjNDVwN2k1ZVhVMzN6dy9YMVB3Wk90NHM5?=
 =?utf-8?B?K0RkbW1qVnhLelNRSTlQODZGcW8zLzZjbVRkd1h1b2hxWjNKaFhCWTVzWUVZ?=
 =?utf-8?B?K0x1Mmt5OFV3cnhFZ0tKTlZ3OUlwNGdPZHlJeUNxazV0NnJwY2YyRndLUVhp?=
 =?utf-8?B?WHFIYlgzU3JJbkJxcGphMWo0d0lFUDBjNjlJS0NQc3lrSUR3eCtJdzdVYVdC?=
 =?utf-8?B?VndoMVVxU1RPZWxaemxKWHRDZjNNU0hXNXh1NnhxL3JhQjdqV2VvalhreVZ1?=
 =?utf-8?B?MWd6Zm1EOE1lRDlKcmJGZi96UFgzbUhPT1B1Z1pOMlF1eXE0S0hkZnZJTmlK?=
 =?utf-8?B?ZWlEdU1zYWVYMDhaQWJLU2MwcUVJRUxsM3E3TGI3aWtkSUpsUFI2WVJNRzZM?=
 =?utf-8?B?eVUvWmcvcVhHb2hlam4vbVdrejltZDM1UUlGVENjS21vaHJYTjNtbkxSV0I3?=
 =?utf-8?B?Z2JScVA5bTBleWxFK1JrV2VkSU5LMzhUR0ZHbkpjUnhGRU5NTk53dFdYOGpu?=
 =?utf-8?B?bTdoVXVMQUs0UTViUmwxejlQVDloY2VqQ1R2UDNVVkVxNTIra1hwZmRVTll1?=
 =?utf-8?B?OVdmN3FUVTlZV1k5dEdmWVhCWjFNT2ZGQnVxdERNQmNDaVBucml1YVg3aTB6?=
 =?utf-8?B?VlNmNFd3RzUwTWZQMEo0enc4cFJVYTlaclBsMm9FRHI1THg3ak91ekxTOE1O?=
 =?utf-8?B?SHd4eEhRRHd4YXd1dVVCYnJrZU5lK3UzUXpUL1lFWVBHWnNCNExFS0M5Q2lI?=
 =?utf-8?B?a0l3VWJxMjRzdXUzMGYwcHhsS08zeDY4U3ZPU1BFdlNFRkJSYlUzWUFoVitQ?=
 =?utf-8?B?ZVYwWFRaUUVnNHFkYjRzd215RnNNcnB3UjEyODNqTWtNV2VSMDhGc3psdnhV?=
 =?utf-8?B?c1o2TG1iTDgxcmxOaUsvZDBSUDlDOFNzdW9EbStpbFA3ajE3YWNHVHhld1Zo?=
 =?utf-8?B?dlVqUlJTZ2thY0dtamxNaEx2bTNrQmt5YXJuWWRsR3hmbit6emNMeEhaOUVW?=
 =?utf-8?B?QmFqRy84QlNHTmowR0xOSGxVbGswbnZDa0RLQ01EWkE4Uy9ESExRejZxenMw?=
 =?utf-8?B?dTEyWXVyeE9NRllxSks5TDg4cTR4MjZpdXRlQ2NIZzk3YUZuS1NBb1dFWE1w?=
 =?utf-8?B?QTcrSVF6Z203OE0vQTNKTVZsaFAxQjUzQTdTL3JxaGpCekxEbm8rNnY5bkJr?=
 =?utf-8?B?UHBJTFg0eGNUdytydUpXVEVnRFU2K1NSd3pHbTl3RHlyMU5tazBlcW5Memxn?=
 =?utf-8?B?bkM4aWdNUTFFcEZsZDBvZUdqNnFlalNVYkpGZ0l6ZlFqTXI4VElndUFwMFpJ?=
 =?utf-8?B?MXZWVk1ZTEJnOHg5VVlQWk9aVWMzZ05JMzlITE5qNkl1U25hd3g3dkdnTjNk?=
 =?utf-8?B?UjVwK0UxZGRadklSd3ZlQ2hyMURRSnk1S0pIc3YySTZycThZdlRVQWgwdUgr?=
 =?utf-8?B?S0pJRXNmNlZuWWJ6Vy9Ydm1BbXk3VFk2SzJFNXpwVDF1STlHanBlQzBkUHdY?=
 =?utf-8?B?dWRDalQxdnBhYXVnNEJUYVdyTERLYkNNWVBaVDRXWG1oOGlMa2pQZ3dFblNh?=
 =?utf-8?B?NytqMksyZHFjT2pmSEZwcVJvWHNRbG1ONGhSanZtLzl1cWZBL1oveHk3Zjhv?=
 =?utf-8?B?bm1VY1dpbTE2c2pVdmNRMWpiQTNVSHZ4SkpTZUtPSFVzeHd6bVRWeUtBbUNw?=
 =?utf-8?Q?m6VyewNRo2/+Z38agQG6KhJ9wvSivzw7cSrxKVk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dCtlM0oxUUtBK0FVb213R3lCallSUDZsQTZ2OTZuMS9RUm14dkptY1lvT25J?=
 =?utf-8?B?OTRJSEdWeWdKSDNtWVlsdXNMWWJVOUNSYWRtcXlvMUY4Y000Q0pzUmVQZW5D?=
 =?utf-8?B?R3lpdUErVnVHdEoyZnlxbXh4SVAwbjdQNEV0VW9NVEFXaXEwWE1WQzM4T0pz?=
 =?utf-8?B?WGQ4QzRXTGc3YWtpdEJ1ejBseW9rUzNnelVzdTFCNnhNMVZRc2lPQVpadkVa?=
 =?utf-8?B?ZEFKUGpCZzh2eEttSTd2UVQ4dHFKYTkwYjFwQlBpYmw3cCtGWklabHM4SWlI?=
 =?utf-8?B?UFlWdkp6WFZ3b3VIREhnWU1DU2c0ZWVoN3NhWTBzeG95UjMyUTRjakpJZ0Jw?=
 =?utf-8?B?OSt4a0IxOXZTRU8ya2xCMUFJV3EwbHZjNDc5WXJFc3NmVlI1VDl2SnVZa1Rj?=
 =?utf-8?B?dzlTeEczRnR2Y0VoZkdKeXpPb2JDbEN5aUVsY3h6VEpoeWN4OVhacHltZ0E2?=
 =?utf-8?B?MmozRlRzcW1sczd3cWU4RzUwS2plMVVNQ3VNcy9sZ2pKZ0hMZ3QrdTdTVnNo?=
 =?utf-8?B?RXB3dy9TYXRiSjhJZWE4Zmd5bkwxKy9QRC9iZ0tMczA4MHJZeURnT2JCRjhQ?=
 =?utf-8?B?S3BBUHFtMTlOMFFNc2lXNzJMeVBkYTN0bldEdXM4TFlpT3I1ZE85M1hyT2k2?=
 =?utf-8?B?Yk1oSlJ1ME15bEdZWDE5eUNLb2F1Nk5hVmxBVjFPcmIzeThEN202ZEtOMDhF?=
 =?utf-8?B?clRXaVF5L2UybE1rNjd4K2tOSmpmU1hqUWdENHRzSVEyemU1d3JlN09pZUxn?=
 =?utf-8?B?NmN3SVVkL3ZPdUo3YTIzaUg5WmxlZ2JYU05JRHNKRW5Wd1NXZlNPUGNVemw4?=
 =?utf-8?B?SDgrZzhFWCtjSFZCVFpEZnR6ZUZGRTNsTlRiS3dJanNoYUQvRURpWkJnRjNs?=
 =?utf-8?B?dFBCaHFkZExwUXAwWjZnK0YwZGtNK2Z2bVlwMFExWVY5ZXhzekFYRUZCV2gr?=
 =?utf-8?B?VzBSN25iMkhLRXRNUDh4dkZVTCtnaHpqZ0kyYUNHcy9KVkZBZHczYjRGczRt?=
 =?utf-8?B?TGIrSWZJTmNQQWFVbnlBdlFuajd2dXYxaHl5T0JlNUNid0V5a0VuMklreGlh?=
 =?utf-8?B?bTdiSVFQUHpvbHlJUWVhMzJBdlVpL3VVeGxYdGw1bHByK3g1b0plZ1UwY21y?=
 =?utf-8?B?dFJvQ3RBWURyWVdOYlhqYWx4ZDdPN2RzYXY0WEVnVGFvU3RBSWtNY3RiRnVP?=
 =?utf-8?B?c1g4MlpYM2MvU1VRUTFPVWptcmk4NENJMnFwUnpjOHRIN2NZV3E1STFXMXdR?=
 =?utf-8?B?QnZCQmR4UVIxbHN5cUZyMWc1UnF0WHhBTGxOYlJ4cG8vSkxKMjZlcFFtMDQ3?=
 =?utf-8?B?QVJNZ2xBa3FGV0d4ZnZUY0NsVEJUaEUrczZQRXhvSTZCQyt1T2V0Mmh3MmRt?=
 =?utf-8?B?cUZjTzJrcXYycTJOU1BzT0txdkVxbzFtUkxscjdlTmNRN1hzNlFFOWx6MHJi?=
 =?utf-8?B?NTcxcjZjRlVkZmhzNVVSMW1mMDhzY2NmakVoa3FhVkU3YjhWeTRGTmdXL3V0?=
 =?utf-8?B?YzZTU2pUYmZjVzhpVTdQSW5vNUlFb3lrTHN0QUtURnphMW5hbEhublNGMWg2?=
 =?utf-8?B?cEZQVHZFQVQzSzlLaGlIaHFHKy9LZVBzZ1JqQmMvYTExaVkzcXF3WHVjQksv?=
 =?utf-8?B?dnRNU0JpbXVNcnMreDI2VXhnVkQ5Z1hGLzAwVVVzWFowRGwvR3J3d2lUdFVj?=
 =?utf-8?B?TktzbXdGTW4yZFF3ZUF4Sk1DNmFUOHNBVlh3dFNDaTZ6b3FXbENYK3lvcGtx?=
 =?utf-8?B?ODdlN1U4dkJTUUFGT0pVZ1BIY2dSM0VKRStBQ3R1YXBRNXZ0Um9rVkU4UXlO?=
 =?utf-8?B?Ui9WdWlBcWtQODFJWnZJLytVelI0ZFROTUxRVjJrMDhmQmxYZHczaEhhNG5k?=
 =?utf-8?B?WmtmclAwWnNqRVhZY1VvYndES3JVdnN5U1VDNFpZUGkwRTNLaVVVQ1JxQ0xX?=
 =?utf-8?B?WWRlMFE0b3c2Y2ZGNmlaUktTV2hvQ0pTMTNtVHAyNmVLaDJpb3pCZ1Q1aFJv?=
 =?utf-8?B?MnVhZzNSbm9JWkRtaUI5dHd3UmJFRHQzVGxGcEdETnBObFJLdVpqT0cwSUd4?=
 =?utf-8?B?Mk5XMmFBRHF3NFJLc0tSY1I0TDU5NXVYRGcreDlybmhFaWptcE82YndxZkxK?=
 =?utf-8?Q?enCla8gqvDyJnF2xaXc8FcYBr?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d48f0dc-898a-49c3-4af6-08dcbad01d34
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 13:10:18.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JvW4UKEHw1ISBdmnY7puYwI3a6P7WWaMUIksRSE86nfS/JqKy8qmMco5B7+u1P+mCcDvSZUfdIvEy02C52s5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8372

From: Jan Kiszka <jan.kiszka@siemens.com>

Add the "lava" tag to test jobs so that smaller runners can be selected.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index f5009e3..bd300df 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -92,6 +92,8 @@ default:
 
 .test:
   stage: test
+  tags:
+    - lava
   before_script:
     - !reference [.common-config, script]
   script:
-- 
2.43.0

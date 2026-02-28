Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79761C3BFC
	for <xenomai@lists.linux.dev>; Sat, 28 Feb 2026 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772265086; cv=fail; b=gvZHiD6GEL0VxsObtwzN7iiWNs/gEZDam2j+OqvGUxgcjI1JjbtKj3Nskf3Km6IlDrhbtV9qAXjypOLWlxrjWM3VBqSOpZEcU0I+LW7meKZh2vGbgVAFupuojSNCsUDOMNUJP+kjyHRoB2z0qO9EM9EVAqsUJMxZIUr7/A7yipc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772265086; c=relaxed/simple;
	bh=e12hj7GqVb0pOtfwxx3vn1TfFByi7D4KtZN177yGWW0=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Cys3ngbiIApZsroBc8JMnG1MJ90SuqV2cwq0pmbYpOrOh7KkGLhuMMdV1YOSluQKzySHQfpYltqhS5TLllXbAZyqdPSa3AJtLluJh8xwf4lmO/SAo+Y/sPKpbseUA4iWWT3WqFGOeVOvF74ZWfRw386+K/MZebUnfe8XSjoqxUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EmUHisB9; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EmUHisB9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msRLjaeU4dfaPraoVBV/KN8DqdtreI19TF4gSBL2Ce6VuFC6jF129TSyivrS10fmw3QyfbtvwHAV7LK2/S3JDl4WwC4jhzpZ8Fscu9Iano8NsnTBXBBtNsLspoOG5plxaOUjpLI7mTeN/si2v3Idiq9xS8UXIXg6nAncrVZ1rosP8+8zs5z4MoqnZ6aqmVW8ChEiE1hOJ/xzjUS/C3mDJ1ZTH9hg2NO3qKZ1zpB4ruEjGu74gJhXhjnenT4sbHRv4sbtcxUQs/VdE25+JJl2vmP3WmD5tsGRDuMV0EcZSvWA9rYYZ0E8AwG7F+xMOum/eJ1xKm8jun+m/xELwYQzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1LBnJOhR2JyEPf6y1+KtSK+WqDQqa9OBqh3q5U85wA=;
 b=kpnPswDzM8/yUU8LaktqNl8NR/Rl3F9You/8AX+J4R6Cx8IVHVCkHFvXmMK+6m63xtMchBtzimPrtmut1RIB9Op2Pe25uIqrm8lH4s03Yndaf0B8q8Cd0bZEEVq8SJ9V0RwPFJGkMuslgDnloHwM7uv/3aZmCLUK6d8QIptyNC9lyR997gQ9WQme/DjxizXK7WHQE8qfV+Z34gKYhvS9yq1eiOE4rXIou8G+9+auE+ZOV4oInYMO3KNAHnURosVFzSRZU17GmLSlKepuEUKu77WMu1AIAUby4uk3sGHagFFiaoje/NMD1jdRgPWagfYWwHIoNnkEYd41o1ld07gsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1LBnJOhR2JyEPf6y1+KtSK+WqDQqa9OBqh3q5U85wA=;
 b=EmUHisB9js8HrxJqiuQ3XYc4dnliEymKuWW/GGD9ir8Deg80G9I84YzXrH2nL6bxVBATCKDNfdN14Uz0pPU8Z4oygP4VJrL11Xfi+pCextxyZ0okDL9ntdQyUen7/LifzhMIx6EZ7Nnh77JDRWwxUqHuFuAVJc/TaV4yIdb6v4jKT5bgSm2Gh7LX/bDr9Q8IlfgtY8tokOd3/DeAwSWhXdbJta7iBEsuV7804LF4/Lm3CDVc9PwLxsF7YvreBcf1kjxMLEKBuJ5V+9Co5Kzc6ulgN/etjxZEAZhMlnMx2JE19FwOhMzUmZPJssR2tGsrYXjuGYDN6WJLYPgG8PDULg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3200.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:130::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 07:51:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9654.014; Sat, 28 Feb 2026
 07:51:21 +0000
Message-ID: <355f552d-8ae9-44e4-bfee-ca1099ff9649@siemens.com>
Date: Sat, 28 Feb 2026 08:51:20 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Use Raspberry Pi 4 in favor of HiKey
 board for kernel head pipelines
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3200:EE_
X-MS-Office365-Filtering-Correlation-Id: 121c0a9e-880d-4ff3-1356-08de769e29e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	KGiYsQQnvgO2FO3HQ36EvikK2PGO1FxeSSIfubJBQZBc4hI/STasK0BIzHY6G1UpGsBDJ+fXBcm3nADAo229h7ecTQFPUu1Nez74JtKjHPMUqEZ2BzPSepQtlFbWbQ2U7Z2z6iYRcgmqM6xdBKolwXylHsrPbV2Z7780QKKcA5nSOhX5/NwzuW9zuqSc+KTu648cDAsj8vgZ9/noh1IpTiNDoRjm45a2OzOU/Dq6RoC8mlj8PNFTjEnl3Bu2DwO/WSCiKV5JZN3+fPV2iaMNyJL3KbCWZxrOjDTq3CUETLUGPivPjtLlCNWuG82sAFakS/EiroXkEJpb9+46wSVq8k2vIsolRISZmqPGaUfb8j49ijEY5WeiwViumJRDeQHpdbN1E6Csyz5xoh/ADhz/vNabx9qECJdItkhWifbkv0OpJGeI0Ar1isfjDy21pEes2h8dfQKYRvaiHXkTyPKAKSfCfzFvvr4Uefie62kcfO6BbM6QST6b3AKe8DchyAdYxIijD++a7I0SjQNyFTGcABm2i6P+EmBbkIr/5jF71Cz41aGx81edLfwEu/Dwyryy9dvFBWTW0O1x5tE8xNw12XDa1qLmuVL1DXrBe43wQ3/7B53zqUB9GYYuRXL3jIkHFnjaAMSF1+cagSCDeArjOjc0u7+Nu+JpnjRB9Bx6m4FEl22rY65kwQdIIsbfkq3UAROi1poaFthvLBi9LijFD3Z4+IQ6y65QXh9HDehTl0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NStWeGU1SjF2MS91QnlVSnMxejgvbTRCMy9WRkROUERuZGlnUVMrTHQ0bEth?=
 =?utf-8?B?bGVianBQSkM3N2xSNzc4VlVoNmpTSU9PRWc3R2hwK0VBQmJadG9XR1MyYWdY?=
 =?utf-8?B?aVlNbnhGWUNvcGtlK08wMzV0MENyUmJkaXVXUjJwZ1lLa1lVL0RhZEJQWjdj?=
 =?utf-8?B?cTFHYVJpWWtsRmlMcis1eEV3TW5XSS82ME1CUG13OXhYL2pLRWV1V0RBZi9p?=
 =?utf-8?B?Q2xUWExPbjNUUXlCU0wzRkhvSFZlajZYdzBRZmk0UW1qbjlhYmFJODZRNHNu?=
 =?utf-8?B?aDFlMEFSYzloOUJXbWRxdit3RmFmOTBIV1hXTjVUWUlaN0tyYzdOb1JlcEtt?=
 =?utf-8?B?eXFmUWdrM1lHc000bGExcDNrMUhaT0RvRWUwMnVCV0tJbkQwSzhjanNFZVYv?=
 =?utf-8?B?aStaQVhEWXRZeHAxVVRKWEVzWkEwY1B1ZDBUeGFUenBQRjhYZzNLYnV6MDNU?=
 =?utf-8?B?eHNKdTJ2czZQVzlGQTFITmFhK0JDZVFsT3JDQURDY212SVAwYnhXYzFPUTBk?=
 =?utf-8?B?RnJ1TFpWbGRCMnZJWDNjRkZoRGpEZjJaY1V5TXJuOGZ0YTRETk1YMGdzTEs3?=
 =?utf-8?B?MVd0SFZsTGhkS204KzZodVRoT0dSaVBrc0l0N3pGQmRRak1YRWlFU3Y2UlZo?=
 =?utf-8?B?dzRXc3hZT21BcFZYbUFMT0xiVHk0OG1xNjQzT3oybVFDYWJobWQyNk9aNjla?=
 =?utf-8?B?ODZOSVRyNUxnU2k2bXZqdzh3VVd3WjNUWklDcDREb3RSaDFsSlRsaGo2Y3Zz?=
 =?utf-8?B?KzNyRllpZ1NxNVhubHEyZG44ZUs1bTBjOWthWTlGbWVFZ2thUGhQNmZYVW1a?=
 =?utf-8?B?ejlnR3ludFVCeFFqcGFrV0lodUlLaC8wT0F5NTNYQk1YY3dJTjVHWXd2bUM5?=
 =?utf-8?B?MDd3SlJwbi9CaW1RRit4SWFjRHNsb1dmTUQ0bVp0R2RKY000MzNGdktmb3lG?=
 =?utf-8?B?VDRDN1NiS0lMS1pBODliQ1BYVHJYMjN6Yy9WdTFKY0VjTFlXMG1nUWtJZ2d2?=
 =?utf-8?B?eHNpcm9HT3dSNnFVcVJtL21zdjF4cFYvcElSS3V4cjRvUlI1a2pLSFVnTUVv?=
 =?utf-8?B?c1MxOG83TExCWmo2cDhzcnliUktHRGRNcjNwZkVMUjBjU2NDa2FEclhubzlo?=
 =?utf-8?B?NnZVWDNYQUxPemZxNlpsUld4N3lZampEdVNRVU9BOEMyczl3T0lVSU5GYU1T?=
 =?utf-8?B?OTNCZXpXM3l3cTNnUEh0TlRYNEY4QVRvVnk0LzNjRHRDRW1xQ1NuTHNJUDUy?=
 =?utf-8?B?ODZCVi9GUU9PR2VqK29wQ0pPY25KVjNTekFFUm9rTU1JR3lXVDJoalYxOEJh?=
 =?utf-8?B?bzZxWGNncmFYR0dSNWV3ekF6ckthVkNFUlRhaENML3ZtNDJQZUUrWnA1VEpz?=
 =?utf-8?B?WExTSkhMMXFSai9Cd0E4c2I1enhjWVRCRUIyYVBhNTdHbnZGNXQzUDhoRXRl?=
 =?utf-8?B?eG1FNTNQN092Si9haDFEaGN4V09NNFVkNGZRT2NsRHc0d09OMkZjb25FcXJX?=
 =?utf-8?B?RUZuT0p2UEtiMlhWZzdWb1RhZ1ZHQzlzbTlEVkNmUE5NWkRKaHZ3K3J2NWhX?=
 =?utf-8?B?K0VWRFc0bE9TaGxhZXFwZ1E5ZHdUUzBIUzU4TTkzQXhKRU1OcGdrb2NDWCsz?=
 =?utf-8?B?TGlWK2lwZ293VC9Paks2VEkyQnJKWVVEZHUzRWxuOUY3UFVJTmN5dG5ESmtE?=
 =?utf-8?B?M25oM1haNzM0ZFA5TzdyWGsxa0ZRaWMrTGk2c3FJWlczbUQ2MEpVcU9Rbk9i?=
 =?utf-8?B?R0dBZWtkaU51cGV3RXBKRnNUcVhmaFgyRmk1UnpBWVhnTXd4REVtcG8rTkd6?=
 =?utf-8?B?VlRDWW9BYS9RYkJPbGdhbUNNSjdTaXk5c3V0RE1BL0IrbWJlamNGWTNtanhK?=
 =?utf-8?B?QlU0VitLWTVwU1JtazluNEErVTdWSmlsT1VvVVA5czFLY0lRYndiam5WZEIr?=
 =?utf-8?B?eGdkMUFneWxoUHNCUFdaVTVlUVdocjBCZ3ZMbmZHUWtUWW9xUjRTU2lmdDlZ?=
 =?utf-8?B?WDN6M3ZUdEdOWGRxKzFCNnRxdkFSNWNMUUkwZENneisxclNqdWQydjkvV3Ry?=
 =?utf-8?B?R2ZHa0dwT2VPblFSZjBtUi9EbVRRNmROUjgrczNvK3ZDNnI4WlBBbisxQzN6?=
 =?utf-8?B?eFNWUFBub1pOa1VqUTQrbzJmSmpiSjB0aDB6NHpTUzAxVFZLVjBMZndDYTR0?=
 =?utf-8?B?ak5xS1ZIMmp2aWdDTzZYRlMvQnlSZnQ0czJrRmQ2eDhYRG9HL2Jieit6Tzll?=
 =?utf-8?B?ek5ZN0NWNDc0SmtEd1pwMk90bHd1VVdVTVZwcFlSeXdUZXZzOTAwd1poOE9C?=
 =?utf-8?B?SGFzZ0swNnNEc1VxaFQwWnNFREZXdWFUcUJGbmRzVXo4RHFpZXYrUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121c0a9e-880d-4ff3-1356-08de769e29e9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 07:51:21.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNRJo7O0LD9PUPJZvR+WqFbtLDbh1gHpKS16/6wHJIsVff4Vo4P7Qvdqm5C6bwzUXIbU4iSIxOfIfYhzhjPoLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3200

From: Jan Kiszka <jan.kiszka@siemens.com>

The HiKey is our board for older kernels that are not yet supported by
more modern hardware like the RPi4.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/lib/kernel/head.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ci/lib/kernel/head.yml b/ci/lib/kernel/head.yml
index ba9c0c4..376a002 100644
--- a/ci/lib/kernel/head.yml
+++ b/ci/lib/kernel/head.yml
@@ -48,16 +48,16 @@ lava-test-head:qemu-arm64:
   variables:
     KERNEL_VERSION: "head"
 
-build-head:hikey:
-  extends: .build:hikey
+build-head:rpi4:
+  extends: .build:rpi4
   variables:
     LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
     KERNEL_VERSION: "head"
     CACHE_KERNEL: dovetail
 
-lava-test-head:hikey:
-  needs: [ "build-head:hikey" ]
-  extends: .lava-test:hikey
+lava-test-head:rpi4:
+  needs: [ "build-head:rpi4" ]
+  extends: .lava-test:rpi4
   variables:
     KERNEL_VERSION: "head"
 
-- 
2.47.3

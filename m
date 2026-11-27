Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795787794;
	b=D0YsGxE/pHQKVKudYK8Clfq5/h0hYbKiQG8+DvcWNuclidxx4tMlU/jNl3NISgK9vZtm
	 a6juTFT49FrV5Hy9bXugXYgtUwS5D5GNa9UiGtpH+b+M4CNFcdajN+vOnEh2zr1dEh/YZ
	 w4MHqodsq6bxCGvbd/nLt53bo/XQSRn8ar8sUeL6fqJELaMptKzur6TYX6/C1ID0SLD+M
	 gPK1YLqYBC9prXDBpIz8Pnthp/zX+ptWe+MASmMRTic6zZDS5Q757zWVFDDipdijbsjMS
	 XJGtpDpux1ayB2xf3jM7q9N7bdXtWN25NzD2Jhe8o2J/+Plq5m2LYr/sjbeLeVY0LgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787794;
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
	bh=PyXRhoCMJirIXjoG4uoN8kMODfdPn5oXd4ukIyhJ1TU=;
	b=tgdi8NCJ865Fq8uiDhi7imCjCcKBfbk2W4LtkRFt5ofIo3M7QfV8fmqN9tafPM9ZeGuV
	 fIGDNhvN60hlleHHiUmBo3hiWUJbEB0qkRD42rq+22AV9/rNVJG4jIkw7TJxtwFlOpQcv
	 drCnjq1r/YpKGrAuKU9k0Ntmm5RTiA1/hEjxCmcerGXAFjD2jykcpuFSKfA7z9+rp1mRY
	 A7+b4ppxfI7+A/o0ChUgwgpNQq9RbSepTfO1SwghboiowjqITcBSpANx9fds/yjujITlV
	 BwG3xiAnwdL4Dzas9aQJQsApUAfUOBGf0SMdtBnPTfBPIKU3oTsRMHgEFSnHmwNRHXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=oXsSJzvN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.20
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011020.outbound.protection.outlook.com [52.101.70.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295D606A31E
	for <xenomai@lists.linux.dev>; Fri, 27 Nov 2026 13:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0295D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=oXsSJzvN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idtZGiXVn7+0Vi/kwhD66qE5B7Ia+cJd8AW8AB7HudMBs1lKmBl7XOJxVUTCm6iLfbpk2HcUQmXZe7TiKv4mEPaa3k4E680GhPNpmkERNC+vd9lxEJytJs/Ht6CsL57YxbKW/su2e+6dcXVct5f7VomB2+Bz6Wb+cJJlAPJJWZrG162qGSsLdnsfoPolaV0Fr2JdlmPWjAvK/yqFuq0XcU4SfP4f/ziAXqkKmyIownFUBp00PJRGWtCaDiEcjJDWusJzKIwOTzfUqfcohiSsI8ytv6RpkeVS6Oic+3AJzTN7wGqrpwViGkc5/gZvrnMsdE3VdjwZkGIvQbvgdvWzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyXRhoCMJirIXjoG4uoN8kMODfdPn5oXd4ukIyhJ1TU=;
 b=wUh0bJVh+sYAdVbKXGBf1L35fLUTE2AhBgyjkNDWmbe2BS1Di+7uOnPNNJaBuhI+1k/FbJcA4LhDJQdiOPsb7PfaYU3gLo+/wk/wrc5GhvuME/sLF6XEAEDrLFIM6j7AGu81ct4msEqIrOGn6jDevZwWoziisfzB0jky0J0Hc7lkmisn5BT43sYT6qQJLzt8Td2TX1gaR5FiQ7+BIJYJmOqM2JuCoCwzaDwcUNiltInU2fddLCsGhJseAmfTkSxmlVB+lR7tfQSdsNevP70e/98cKBAZeSdT90isCiQGtDq3xs1E0ccem7B1+MAPU8tISXEQMtn+4uo/0gaOEELsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyXRhoCMJirIXjoG4uoN8kMODfdPn5oXd4ukIyhJ1TU=;
 b=oXsSJzvNMjyVchavKE8NLGfZtL/VDnyCXiv5jcvZuDQDSjLcl7L0VfWsLFDV3DRDMkt/OSQPvDad3qqbA6zo49qsyEttIaetmHWtoG+S9OtMVO/LfR1u0AyHre8vb04UGLh868sfuAWuZeN90ndfR/NmQ8K1xb9lKfHcBwvHYPYphWBV5s0AOvlHdnfj2Ud35jYJQGzpG0uRs+e9QgLEYR0IwKC7M2vpQF9kn8ptO0o64XlCdqSP5Jtve4fcnabMsud760u6h86M5udV7yJb7Uv0k9DlDyIUZrY1fT0lsS/6y6NhKV/CISqzAU/i90yCKPkBJJXbqUxkO4bxLUZUKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB9179.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:441::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 13:56:31 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 13:56:31 +0000
Message-ID: <e66c29ef-ae08-4371-a00b-de5abeb43a0d@siemens.com>
Date: Fri, 27 Nov 2026 14:56:30 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [dovetail][PATCH] lockdep: dovetail: fix unbalanced
 hard_cond_local_irq_restore
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: c4464a1a-5ff4-41d7-bb87-08df4c8e3d73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261009223027099003|18002099003|55112099003|11063799006|261102123227099003|56012099006|261026121527099003|261026140227099003|261021121427099003|261021135927099003|261022105027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	raLCqCdlQEqzjrvvaSi/u/A60OFBk7ixANjQlwSG2t1Gpg/VmAI7UMElvxUBa8vWhsDButRy3BacQDsuN9huohiwBpvDs4iXSWj1IZ+bFPVxWmPSbQ9bTTXisSD/XI0oYppCojSCIxq+VUuRoGaYpS17eTmJ5zSiNbt54T9kLNTXnJP4/j6ac5uxJ1DEH+3EjEco2GsoQcZOkqqpipeNoYm9JtxNLDB7geUyecpWi1NycWsGYSTiSwieruSbl9ubC4u/GMRbI8GHddcrhqsmSycXtSg+7yCleWdhSNM3a7C/y8kGbmGT6gv6xaZv/mX0lmKcXVWEtgT/28H4fiTRKEboi83osMqjfgvJeR/q3TbNuPsfHGITF2sAV2iYw4gvtNiQQ+pV884Bxkbv+N5TKkAdYsmpWM9iGSVG0yaMN0vVqFSyaIS/UAZbJY41kP9zATAcWwm0SK0yDGSa+gSHei3+/NfZ0N/olhENXGhcdcpQaSbASdFU2egrItnlxjzPTOw+1/KGzAvmxqQRROl5gXjpL8pnnJYobL6bpI+7rslj6JN9LasV2UyO0SE8Amhdyv9DLYzk3MOeQglFKIZ7miLpBmE25B14el+hRbpPfnBmFZkxCS9O8anxecb7aEXoMmHgflOJl0U1GPxOkNsxpY2SCD4edWnJSPm9UySCwtg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261009223027099003)(18002099003)(55112099003)(11063799006)(261102123227099003)(56012099006)(261026121527099003)(261026140227099003)(261021121427099003)(261021135927099003)(261022105027099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0dJdmNkQ2t3b3BQekQ3dUFaSzExWGdhS1hKMVF5cmsxay95aVVwVlp6QU9j?=
 =?utf-8?B?ZnpZcVBKczlWZnQ3enMzdTNyVW1UMWRSZXNuMWpFbkdjY25pM1VqRiszcGV4?=
 =?utf-8?B?U2wvUlVOVmdNRjJEa3JoV0pPeGp2ZXVJYS93WDlDdFRPR2ZFMXA4ZEw3Zk15?=
 =?utf-8?B?QmdZUitHdW44SmhvdTRIdTNscTBWbzVrcHBaSVhGVUJmUEhYZFgwWElJNFFR?=
 =?utf-8?B?NnljRkZPZGhKSWJ3UmxHTHdQTU5PL0JNUkJteXk2VXg4bWhaZUpiMUhTeEZs?=
 =?utf-8?B?b2J4aUpMRW9aWXdEa3BoZUFuVGMvcHNVaVI3dkJQS1ZlTC96eVBKQVdCbU1Y?=
 =?utf-8?B?MTRsQzk2VGY5RGZvNjA5VjN0cnZrZGU5Q1BoWndOS1pzRjJ2T1ZTTlRSREU0?=
 =?utf-8?B?VDg4SVB3S3dpMWNQN1duSVduQkhYUmVZQlBBWjk1eHJodStoQ2NLYk5EVGF6?=
 =?utf-8?B?ZmhFdjlpUFljbUljczdOVE4rTWxUWU91dkJGVDRVTHJ0dVJPSzV2TU1SdXYx?=
 =?utf-8?B?bGFLd2RrV1paTU1SMkFnMUMrcE5SOVVlNUdkNDQ1VDc1ZVgvWmtmeU55VEp5?=
 =?utf-8?B?R1JYb3BmOTZGOGZNZUtmdzdQYlZoZ0g3bDBEajBkVzE0S2dEYkpPUWR2SE5v?=
 =?utf-8?B?WHU0Q1BlUUJ0K1dTem4vNHRET2pyVy9IR2dFRkVyaEFRcElmUlZsVXdIb2VR?=
 =?utf-8?B?TUNjZHp5STNBTDRsYnM5dGJFaU5sM2V1UXRPaFNZWmkyNExITlZGQTRkanVl?=
 =?utf-8?B?SC9idFRJT3JaQ0d1NS9PcGlZclM5YXkyQjNBaTR0ckNNRHV2S3p3VjlVSVE0?=
 =?utf-8?B?SC8zQjdpSUxOZ1YxRlI5OC9uTEtLTW16WDMxNHZ6SFRwTC9zWkdMTlJpVUtR?=
 =?utf-8?B?THZkSytnaTB6V1hYSTBhYVN5djFCWlo3MUNGRW00cWR1UG1DRDVUSnlIbzRa?=
 =?utf-8?B?K2VNd215UEtvZGx2aUk4UGJwZjI0WTBqbkhKZmF1OHc3d0tJZ1licVVwdjVP?=
 =?utf-8?B?Wks3RVZ0K3NzaTJQV1FoVjdTZ21ITEVBOXlDMnUrNVhoc2VSSDFSQkViQTBH?=
 =?utf-8?B?Nk90TFhid24vNUJyUzdMNEQ4YjVFeGUyN3pqV1RaanNDelJGOGY2R05UTGt4?=
 =?utf-8?B?OTgxbUE4cURTK3FsWDJhMXg5TzNjd3M1bmtHa0RpNVZXam9EU1BmRWJOT1cv?=
 =?utf-8?B?ZXJ2dmRlQ2M0V3BIaWRFd0dCVWFGcCtGZ2tJd3gzRmcwM2F3TjNlQ3BPMnJx?=
 =?utf-8?B?NWpMZ2g1cU9ZWWZlNjZEVmY4djZlekpIbDBGVFlMM1oyZVp3ZkVMd0xjWlE0?=
 =?utf-8?B?QmdwUGRjZUF5K1dKSjdCU01TNzh1bm85a1QyZG0ycVp1VzNrWGI2dW5oUFd5?=
 =?utf-8?B?SzB1aTI0dGk4aXNxbEJ5ZzdvTU9NWjU0blRuaFFqYzl0SWlpRmF3aUZSN0Rr?=
 =?utf-8?B?cDZTMDNDNWpEaUM3aDJDTzh6WDVGV05leTAwRVFyYTh0YnJSWlp2Z25kbDZH?=
 =?utf-8?B?ZEtab05SQkJhSDBaOHpZNXhNcHROakxIK253MDBzblBBWDdLTDJMeWJOMXZi?=
 =?utf-8?B?WkE3U3hpL3pvanBqM2VBczNCUHR2Z3B1c2hROU5iS1A0VTlNajdlOUNYN09Q?=
 =?utf-8?B?Ti9ITWRFMkVVOElRVmZmVjVkeHE5bVV5Q0V6VFNIRThBbWo5QnV1bXNtbGdh?=
 =?utf-8?B?SFMvUmQ0RDNmNUNXcWRaWDlnVWJFTGtveDIveUZBOEgwM25XaUxzZXpGZ1pD?=
 =?utf-8?B?VFpkdk54UU5yTllBYnhrOUhWYXpjanRqclV2ZVhlU2JTUjZxTHlIVTRqTU8v?=
 =?utf-8?B?UnRrT3VHWkhZbmwwVVpST002Z1hrRmU5S21SUU4zVVp6NEROODl6YlVuZ0F2?=
 =?utf-8?B?dzdvZzQ2WUIzMG80VHo3c3FHck8yNGFmam55RFkrN3dKNTNjY09GbTNUL09H?=
 =?utf-8?B?QytIdWhUek1BMDhaWXE3U0NLUmdsZGttSC9rODVVNCtQcFU4QnNjZVpSayt4?=
 =?utf-8?B?eUFYREYxWTZMVnYxc1pzQ1dST3hINEIxbUFDbldMbTVnc0lobUh0UUpIYkpT?=
 =?utf-8?B?QU50NlA1cDhvUVN6bUMyNU5OSFhEWlUwd3VZQlp0VTI4WTdoQUIvSFVvL3FF?=
 =?utf-8?B?RnVuRDNmN1A1WEFJNjlVam94bVkxdVpiYmdSREFhQW1ONFJMVEF3eFdDYytI?=
 =?utf-8?B?QkQ3L0xncWtVd2diY1pEb05XUEhONXhZZjRMTVRwMmxzQU5YUkRlZTQ0dUtU?=
 =?utf-8?B?VU0wU0pUMmVOcjg1elBqTlFUR0Vlek0zaXAvUG9BK0hNQU5sYlRya2JyUVpt?=
 =?utf-8?B?UENaaENrVkxQWS9pZHZuWFkzdTlUK3JlV0dZUzJUNlpTZ05WNC92Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4464a1a-5ff4-41d7-bb87-08df4c8e3d73
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:56:31.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpLpczWqQaN3AErSY4I2M675RSyBFwtQ0qXxJkwR/e+4uv6Gu3V2c6mNDDjvyrfT7TAjfpBQ2aqc2IRLWrNo8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9179

From: Jan Kiszka <jan.kiszka@siemens.com>

After the skip_checks block comes a hard_cond_local_irq_restore() - but
we were not initializing flags when jumping from here.

We are in NMI context here, thus IRQs disabling is technically unneeded
but a) symmetric to the hard_cond_local_irq_restore and b) truly gone
when IRQ_PIPELINE is off.

Reported-by: OpenCode:Opus-5.5
Fixes: f9acdddb8afc, 5.15 ("irq_pipeline: lockdep: fix irq state causing deadlock")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

It took backports from 7.3 down to 5.15, each reviewed by the same AI, to 
finally make it spot this.

 kernel/locking/lockdep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 08bb0173dad77..4d91327a2a6ce 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4535,6 +4535,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		 *  - hardware state check, because above;
 		 *  - chain_key check, see lockdep_hardirqs_on_prepare().
 		 */
+		flags = hard_cond_local_irq_save();
 		goto skip_checks;
 	}
 
-- 
2.47.3

Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8031DF254
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180968; cv=fail; b=UPs0TXXSvqc2KnsWL8ksMoDdIyNXEfslLbud0Mc5jH+QeTvn6fjmBBZFA2+08AKNyyq7jx3TTazQCXKZPdREMmDvTluAQh81tvCbxxhepNKmnNvR8/nNVxeiHdalVtpp13pE7xC+6HbEKRiyUVguuB59GO+eeK/3TkJypA7OrPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180968; c=relaxed/simple;
	bh=TWoJJboQomnNWzJK8L9Ld8ePUCZrE8ae3vIgwo2H++c=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=WCBQCZz6emmM2R3yW1HXGdc7KiT8++gK4dXkLrAtPUuhSXyZ2QuzQ7b7x6D0S3QxCeoACdc/P63vBJIKesB8OaQnTaei6+aV+/H5wtDLp52EkF2LTeNsksUMSMZ8xuGCADsfchuV1IufjevZAHg4IhKzvVuhmC39cl8wDCVmQLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZHNZertT; arc=fail smtp.client-ip=40.107.130.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZHNZertT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsNouSmRIhc0bUDXZ7MUs6SyhL1S8eKmeS6I5fau42Bc5oZMib9QXRsV1Iswfnj5SjvLOnaWviAuvL6SCxGRIIlsfByGMQU++/T1yKI1vROuYugrgepa0UcBYneZBwdUdf6WH+/x/xsiWyBhg3vunV2VrNwy4MSgjI++VDAVHofnGw7jIQOIQV6UFi5zjd9bQNqs6qCwku/GeuAy8aBm6wId/KTN7efg/By7Vn7EmvciDmwCJPSEefKjRL3cIvtWFFywfe8+b9Su5Su0t58OFVpwUSKbdreUg7YU3qWu0AyXHXPdgN6SOI1MIKXt4+27WEKZ1xtzqDJO7UZvRUGVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geucTVxDeB4O4xT7Z+aIWtwLyBSWAcFMKp+OLkgmSYg=;
 b=huWotcQ/17sBzuxXj3nXJC4OCGNeSrXOb3WsygV/Au4OLCcK7eDKwBiuwT2iYgIa+aGfQHX6hF6GTd8IwSbPALxXcTDxxLqc+fdOyz2cf0saoDU0IwzBQBLFkoS7S6N+eo+tO7IXc4mQBCK1tJpG5h6+fBZHUgm/jFaW3sRIMcsaLAY4ZG0DKuRwJhuzP1S3vjPwWml1yeFOIqk+cGtlfE3DqpqDMpwLlhDinvUqpNSpKRueXjZX+eNDOCOsPkw0vqQCc60YpJeXO9PPiMjdtkbYcJi8/DB9V5vp1LdxeubsQGyYPHd8v0r2cO+8pqYj8ruSFhsLVGKvNXvK9xyNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geucTVxDeB4O4xT7Z+aIWtwLyBSWAcFMKp+OLkgmSYg=;
 b=ZHNZertTmqM7WBVez47vdSPj/pvy5N9njN/NKbshFoKH0/D/K3wm6cOBsHJUh/gV2qMJ9b9ILsot4A1el1lVqer1/VA+YNTyv4ZLZzevGCLTcdubAha6kedqeS5pMz/25P77N/p8iXT98D/ymXKrm+q8NvCKL6BZkuXkAztAEMKjCKowzLgHdDjpAI31ooyvmvFRg5MNRaoLvOVEj5/NzHrVNlxlma2Jgp2BF9UwLDNlaDRN0FrJwEx4rosMyNzjK3IZrPHaaZI9SbfbPQIwbFRFxXt8Ynf3aOxynaelvXdT86TF1M6a1Z5rP0PSxd/Y0YA1KvOPitlE4s4kgj5Juw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3980.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:36:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 15:36:00 +0000
Message-ID: <e5e72210-f62e-4b42-b7b2-7e20aa8ebd05@siemens.com>
Date: Tue, 14 Apr 2026 17:35:59 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] linux-xenomai: Move latest head to kernel
 v7.x
Content-Language: en-US
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
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3980:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f53d336-b4c2-434d-ab05-08de9a3b87aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	koyuyyLx6bhaDytaP4ku9CtBXll9v0car5+J+fAB615wIOduzq4b/84rUPWiR8Y5xgTraiYRMIqCcw/IC6Aj6HuJj1+NUgojwVnngrpzW3ansK6pOPZF4VYtidSxZeKYZq50Cu+cTOQTvCZSgc9kFfDdZIzSX4winm7/lLQ/G//KNEX9CklKwGgenGFcYxoERXrR47qyf/OHAHLw5z8kt12xVqWQisGvqUxEGr+iALCQw14Ak9KrFRQSoJmyWHUj/ti6cnkfpyqKtnFMPy7l7jyPX6BXhXApD72yGJu5SYqamPoQ0939agn2t87rRUtIHclzZtNtUfiT1UNWHVrQdmNJED6zUSwBFDC+OIiIdfZRuSjCVSwg3v4lu5xtjlU7p/IJTGSX5LePzJ1JKIsUYbNoIzq0xPqi0ZVUzKSyh2OdqtjCAWbCdB8YjJpDZikBzTer8m3hO7qud80zrAi8TdP9VrsrTpSKS5IUkseG3hbFNtUHz88aj06/+2RsvnctZDG7rkFc4HA4hhqfLky+ru2XW9FWIOD65PIS3JQRJDvBT5fDEuIUEscI1+x5wekcze16QQcOsO8+2mg31kZqddO7rGXG67/ItYJyQXdYScUDCr7/QFV6dQyjDmvK4gfYo2pOFroTByCEShx0f4INjfVzcoErNKKN1MWc6uFttlQNYJ2Xt06UjKnADzZH+lE6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmRxeGhaKzYxUG92dEpOZ0NSRnhqMWdmUnZ2TFlpdW01WkZUa0JZOWZzcGI2?=
 =?utf-8?B?MUpydC8rZmgwSHdhM3ZsbEJGb2UrRnJsV0p5M2MvMTVjQTJJM3BJS0c0b0V1?=
 =?utf-8?B?emFaUUp5SjNYRndNUnJXM0N6cnZ1Q3daWDluYmx4MTZMOG5DNm1pVDRCbFhZ?=
 =?utf-8?B?VVBVczR4Z000TWVqSTBRa1lPTFczUmwxaTN4cnd4eUR4TFNCNjlpUTYyc0pK?=
 =?utf-8?B?VS9EMXhBWUkybENXS25rRC9MN1VFMmpvRDFYRkFxOTdjbmU1L29hSks2TlJR?=
 =?utf-8?B?WkJhaFVVS2VIeTJZUmVqem1ZUS9rdTI4Tmhld096KzFTNmMyUnQyQlR6dGhv?=
 =?utf-8?B?TkZITzU0TTVRY1VpRVA2Q1ZLaVFHSFNrbFcrcVIvNXhQdllNQ1plUjI5RERh?=
 =?utf-8?B?VDQ0eGFjb1BzclFWZEJUd1ZOdVI4aFVTcWdMbWw1dzZNWE5qSC96ZG9Qa3I4?=
 =?utf-8?B?bFNFVmFHMGpaTlRKQjFnZ1RONS91ZWpCNHpzM25wc0dmb0RxTnorYi9Ib3V6?=
 =?utf-8?B?d2ExSW5Hc3pYZklySkwyTWdsemJ0SkRZaUVzTC9KNUN4K2laN00yMHl5VWpW?=
 =?utf-8?B?V2VhRGNla1Y1K09peE9RcVNCcU5iNjl1YUxzUXpZaytSTVcrekM1WFdBV0Y5?=
 =?utf-8?B?MTJOakFEMC9sdmF1VWJEQVEwQy9OQTVEbHJvUFJoUlVpV242N0lzSWYxTnZP?=
 =?utf-8?B?am9xanlndlI1anMvNENZaGZMQzNtb0RSS3o0bllxVy9hUXVhYjh1ZFBOU1FD?=
 =?utf-8?B?NG44b0VVb0I0UGdEYzM5VGU2MDl0U0JVOE5zN2o0N20rSlRiRE1SR255UC9p?=
 =?utf-8?B?bVIreGNzaTZJbkl3dTlOSG9IcTROMjY1TEthZkwwWC9FLzd2NDJGazJFR3c0?=
 =?utf-8?B?L1pVOG0rMEdQVm9JSURVMHVBMGErMUlqSzlBT3ZIWFFMcW02UlJUWWZaYnF1?=
 =?utf-8?B?aEJ4blRaN25zMUFYYUw2eU5IU2hWVFVJYlJMQVJ4VkhXTThBazhxRjB1UzZR?=
 =?utf-8?B?Um5RTEk4c3lKMlI1R3VvVnBqYmpodS9Pb1RxSm53dDFVN1lBalBMdjlSVXVB?=
 =?utf-8?B?U0VDKzFlNlpYb0dnYytYTG1iRHhwM1gxWVZhY1o0c1QwVWZCeGl0TE9JVWo1?=
 =?utf-8?B?TTlNWjZ0WkdEa0NlcElwb21LVU5WeHFZSHpKeFZkdW1rYWpmMGVYYzh5UmtS?=
 =?utf-8?B?QlZzNzRnVTZOalBWVmYxYnY3cUtXaHExUUVTbWJqTkpkaXNkTVkvUlhEcTBM?=
 =?utf-8?B?ZjU5dGNia3FoakVMNzJyb3lWVkdmK0VPS1BsMk9tZWNGamJzaXVYdWh0OVNu?=
 =?utf-8?B?NDA1dUpWNEtCaGxwOC9BRW5JTUgzQmcvWElkMy85VWw5Ny9YTStTTFl3NDJM?=
 =?utf-8?B?QjFXbFB6U0I4VGpEUU5RcUNtY3kxY00xSVJmSktBYjZMMlNJVVhUcHdJZndB?=
 =?utf-8?B?WXJvbXVXNVkyT2I3dEpySi9LNGRaaXE3VWJ3UmhkNUVXUnVnT0lwY2JzZEl0?=
 =?utf-8?B?cTg0Y242dXRDSWYycFZyd0VrbWR0UjNyNHNWNDVQYVNBODVTK3diMUd0ci8x?=
 =?utf-8?B?S0JRcmtnT2FWOUdicm92RlZjSnZ5SDJ5bE9LcVM3UnZmN1R6dkRPcTNWUDR3?=
 =?utf-8?B?eFRFNGJoWFF0ei96RGFxc0pjellFSXdPUlp1bWtvVlRBMVhzcnBHdjVmVlpE?=
 =?utf-8?B?TXRWcDFaTDdoUXU1RFJSY3RQWGxtbE1wVHJTOHh5UlBuay9pTkpyOFU1Nlk5?=
 =?utf-8?B?aWJwSkRJbFp1emYrcFkvM0RLYlViVkJmcU91cVhiQ3dQN1FaS1dRREpVOGNG?=
 =?utf-8?B?UUdFRFlxc0MwK3lkaVFINmsxU3l2aWFDMTJodnVDc25GKzRGTlZvdGZ6TmxE?=
 =?utf-8?B?dWJNZENDd1ZNNjdpQkJKV2UwOWh5RTNoVGRqRFlnQ1B4c3BCQmZvaU1Qb1FF?=
 =?utf-8?B?THNuSU5WejB1OWlORHZaVzMyOWRlTzdqSVduREJQRFQ2WFpvTzNFZHM0U0dP?=
 =?utf-8?B?ZHNheTlIUDNHL096WGdpczNLNkcrZXFXZDdFL0pkcGhPUzBlYVdUSll2U0l0?=
 =?utf-8?B?RUh5Ty8ySjlIY0UvbUZWS0RFdzZxTVhiSFF6UkhrQ0JrWCswSWVJanUzcjNp?=
 =?utf-8?B?QlBTZ2diUDRVNUJVMG9qSDhwSW1nMUxpQndjY2FUbDNMVnJSZU15SGRCZVc4?=
 =?utf-8?B?OFhlT2FzenFCemZuK2tiKy9wMEE3MXdYT0x2QXUwOXd6ZnBlMkdMNFpzQlFr?=
 =?utf-8?B?Y2dJQkZKUGNQK2tndGRnbVROWUcwVUsyT0gzUGNoRW90S2tkcjdPRE5WODg3?=
 =?utf-8?B?UERiMVVsdlRFdXUreTNPbVQxNkxHWllCWS9jcW82VjJvZm1DRE1aSmdydzRT?=
 =?utf-8?Q?kbxwkNHCOWuxrWDs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f53d336-b4c2-434d-ab05-08de9a3b87aa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:36:00.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QABp7u6elRuvuvCJgvDOGJqKQ6COGXkBhYiB+CZPGNAydqElaOl4wJZEd2n48nFPMUtrndQOW2ykdghpB9VZlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3980

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_latest.bb | 2 +-
 recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index ce497d6..188b842 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -23,7 +23,7 @@ python () {
     if is_kernel(d, 'latest'):
         cmd = 'git ls-remote --tags --head --refs https://gitlab.com/xenomai/linux-dovetail.git | ' \
               'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
-              'grep "v6\.[0-9].*-dovetail-rebase" | ' \
+              'grep "v7\.[0-9].*-dovetail-rebase" | ' \
               'sort -r -n -k 1.4 | head -1'
         (ret, out) = subprocess.getstatusoutput(cmd)
         d.setVar('LATEST_KERNEL_BRANCH', out)
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index 3be54fe..e3c93fe 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -22,7 +22,7 @@ python () {
     if is_kernel(d, 'latest'):
         cmd = 'git ls-remote --tags --head --refs https://gitlab.com/Xenomai/xenomai4/linux-evl.git | ' \
               'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
-              'grep "v6\.[0-9].*-evl-rebase" | ' \
+              'grep "v7\.[0-9].*-evl-rebase" | ' \
               'sort -r -n -k 1.4 | head -1'
         (ret, out) = subprocess.getstatusoutput(cmd)
         d.setVar('LATEST_KERNEL_BRANCH', out)
-- 
2.47.3

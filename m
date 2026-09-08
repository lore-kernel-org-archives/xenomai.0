Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013014.outbound.protection.outlook.com [52.101.83.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE65650F6
	for <xenomai@lists.linux.dev>; Tue,  8 Sep 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882034; cv=fail; b=Ohfa9GXMZYrti+HZWGr1o1K9z3lAgvP/uqXS+Cl0+J7OVOx/gqRCtHDtATUlZbf5UC3esN19dvPG/jw1nGpdP0UBhKURuF08tjP+KFC7c0VVV0vFznBVTAnWzakG5ONwoEXOnhGFh2CixACFX8AV9ZMFlPCE17ejrjnye2z7HM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882034; c=relaxed/simple;
	bh=XQuCzd7WeacOFOrsSSqsNIADVwUErjNnba/hDcxMtAw=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=USQwUsdNDNZk3p4Jvibo11w2EsCBAenF+FVji8C2OLWotVxkTNKyYhlCx0i9a8wEJA/qgICrmO1qafKsAJFRxBQLZotOxobsRqcEU8jtRegNFycHPiriJL2+2LwSDAHuJ43uCI0JiIAfNxnnfLkHTK+rnoKM+TGyfk5kHwWhvkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=p0d7JdD2; arc=fail smtp.client-ip=52.101.83.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="p0d7JdD2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itVLcHp9Xj95UvM1orm82QWlUV8etvBX+rgMdp5yiQVOxNpmljtgyI0V4KUVTYTb3zBMRfnfCFK3NaiNxikX+OfVuYMUIPQELd2w8ekJtb/rnAI6MXhuI+CRWLxCTDRZALnvhGpd3zVx09G/9PBUo67qsFQYoQ3q9ipZ2TEIyDdncpM122RKRjjYICyF9NVi8Pld7NcVsUAwkEtg4fl4LL9bNvlJuMRAU/FCl5rkqHIVzUkooWvBpd51dBfQMzmEtsonQ2/h/L+SGBD3+3k7iImCPr9MYnLB1sdPh8GGS5sdYBtIA50zz0oeuj+C2j6JXhsKjs+37s4ZxjN21pX/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2I4GbXFXiXieNFU0LB7WxNsLl690E50b2Yiisygx/U=;
 b=wDHZY1N2ojsIg2N2HOrNyMZlUj+p4wFtE//S1GtUT4U3bP5VTyztbBTUV9hBZH369MXYz9CbJ/Wuq8GMHamDc/PIZsT1568XNdUvnhUirnn10D9ZhhiMydmv2CfDxZDTqSsDl14CRA9PDYVBQ6QrsYwJravVRBeiPl3AX6aJ1jxN3RNFLfiVD19lH1BvCjL4r+NJli8JRuPhzZ2SVDFuk6SmT8ACFk4bjJdQC6b+2j7RYskWkiIGnvE5CYcd07j7cm+QZa4hxytfucl964QRs5MesHmqw7bSA1Yt3GVC/eTxZzshto7uI1GKhreqZRxC1jn0KErZ7k0neh1ZXMNKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2I4GbXFXiXieNFU0LB7WxNsLl690E50b2Yiisygx/U=;
 b=p0d7JdD2O7aRoDG0W/OVdC2CwLAvrVDnlrvXFTG6q1PpOBb4kbWpuf0eFc4H+vZtGXMS8BDVIX6PVFcGOjOd2XTaS/7lNQ1TB6ogdHgqFA0GPx1oWuuh9c9o9wBnnB8KyvkSSoGpIzmSujoH8N+jtBheLj33/pPyieyE1SDSkSL8/svOgc7JhHjOGsySnw6gCcaqP6C5HcEyj8RqUMnIgo6W5ZvjuFdEQ7R0nnbtSQtiGsSBoc5H2Y/cIpTOkYZVvenjja0SQb7dFOvg9vLon55iAlmt4iKCl8Z+L7tiGJbLF/AkXlZAmhNjmtM1PgA4agbF2WUJ1yOuRDF5Wz8zTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 15:40:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 15:40:21 +0000
Message-ID: <5f751461-6a40-40a9-aeb9-45b74774f495@siemens.com>
Date: Tue, 8 Sep 2026 17:40:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH v2] testsuite: smokey: Add timeout slack to alchemy over VMs
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
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 13262ac3-fc36-4fe1-a021-08df0dbf7e27
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	46rOkLlwPiIeFVTh9FFQvZHlCkIED4sV46GJYJno+eIsKpDLQ0jZxg4T7z/stzaOXCAzEPs3FCVivaFbhIrJ8okoFlvboZnmrBk8H/AELnMxf/YpNCRAQ1hhWMWPtu3jbTD8V8IvvdWMMVipckTrers4qwScRJJgGo5MDjDfgAlnwusCGKJK7PQ/kEzhuAugC/V4yHmgGyW3tiS2Wa2G2pZ75GuavzakP06FY6N5fH3glCEkQlcBqMlz0TPTOs3TBo9XVDjBenUIluEATszR0pO1SSUDy2mHm+0Dz94CvLkGOPW6mlN9c4w5sh9Kulj2U2H2njINm+Gbqn9DF1w4VgjOpX4pUJYppeSqIaUKDuMyHvynen4+2W4L8YNVN57YyI2nn8fK/nVqryKsvAvsYjhf9kOD4B4V5ejOqjeQdJsD/Edh8+LxydViOUCmdfDLL5OrwbmBQ8sB//Wv4IMspsuYtKyBAXa1s/uASZeODvoTYMhmGsawoAwNinrsgpPz3mihrYKBlvUMiF1/zkTr/2USucBBOtNuwQhJ4of7U6YRtiGFgvky4Kr6E4aJEC9yGNf/KWoPb0SXdawxb2L7WjNRMTlJxjPsPHI6rv08pVCQwE2IEl5obQXeuhW3yTNlPZv6av3ZxscVevLtwOde1A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEQxQU5HS3BBdTZKMUplOUFNeHRHMWszRjFzK3dvVUVqVzJYcytXZWl4UzNL?=
 =?utf-8?B?b2MwVzRqN2VUY21wWGwraGRZZHBEc3o5TXRoeTMzanlleGgvbmVDV045aDVq?=
 =?utf-8?B?MGJneDd5ZXhBUCtaNHl1OTFBMU9mWnJ6NjZ6RTNnNzRVQ2xBeEcxcWpsRUNE?=
 =?utf-8?B?ZUZyRnRCaTVnL254bm15eUZRbTVrcmdtV0FTdVZjZHo3Z0FLUzZNeC9tRWtq?=
 =?utf-8?B?amxTcXAvNFNpZjZiR3Ftd1NyZ1FwczNpRUU5SnVsSG9wcjJHdEZlaHpVa2Ra?=
 =?utf-8?B?dng3eUdlZnN6N2hkR0NkdzduNTJ1ZWVQeHpRcXUwbG11cVZQdHI5SWNRclQv?=
 =?utf-8?B?eW1jNXAvdVljdjlKek1Uc0NGeGR4WTRTdEdSWmYxcnJYcTJEMDJDZWprVy9o?=
 =?utf-8?B?cC9qRHFGaXVxS3doQTQ4WERUMG4vQnhKRllla1d3WWNaZ0FaY0NGTlkxNzJo?=
 =?utf-8?B?ZSs4elFIc3RBOTVLSTNKdDNoVDZsTnBaL0NNOVF0aHZKcXNzUVh4K1ovaFNm?=
 =?utf-8?B?cUVONkIwaHNReUZLM05rUHFlUDF6V3RDekFNVk5zSSsyRThSRDJaYlF1dHNw?=
 =?utf-8?B?anNUN2sxS2dVUndKWWlaMWlqMmNoMUFvSzlSZlNPTXVKUFlCYS96WStWWHFX?=
 =?utf-8?B?OVFBeklMRzRyaFpzOVFTNUQrMDR0OTYwR3pOU0dNZFp6QkFzUlBNK0Ztblgr?=
 =?utf-8?B?bEJoblpiNG9ZNDlOMDU1a21PNHVjZDY3eG9aSzN1ZkdIZkpHcWcybW0rM1Bk?=
 =?utf-8?B?eVRMbFdtWFVsY1pvS2IvdnkreHV3YThGcEZWaGdvMzRUTHNDMFQ3dmZrdkQy?=
 =?utf-8?B?UnFESEhjUWhmcWtPYkhJaSt6djI2K0ZtbmJKVFZZcGZ3MUw0c2hPcXdranVq?=
 =?utf-8?B?Uk5yQzhQdENEWUxBUXhVVnhYRTk3NXQ5MWJURGM0VWRTenVScm1JcXpyWDY1?=
 =?utf-8?B?bTFnTGxCMW8zcCtBalJtVHRWRmZpNEFpWVFwMUxpQjl0cVhLMWt3WGcxQlhB?=
 =?utf-8?B?QjNNTEVvVEpuU0Z6RnlxWWoyQklWVW9Cc3FKSnhsSnBsMjh5QkhMeXkvb0RP?=
 =?utf-8?B?cExrMW5hVU1UNnY4T1QzYTJBcHhiQk9vR1R5bXphN3JWcGNlSEVLd1FnNHV0?=
 =?utf-8?B?QmVhYm54UDVRU3grK1dZb0hxMi8zb045cnFjUU1SNERreDlIblZuVzkyMG04?=
 =?utf-8?B?bEMzaUtlcElMWElhRjZSK2gvTk00azlpY2tVM0JmUm5OK2ViMlZyTzUzWThl?=
 =?utf-8?B?NXhYbEpEUU9HWWgwdTJMcTVXWVVKa1AzSlhrY3pnZjZmUUFBMDJLcGNUSDFz?=
 =?utf-8?B?TXlMNXBEZmhUTUVrb3I1eUkvRkE3Z2NjT2NmRnpGNWNvckNiK3FaVVdOc2pZ?=
 =?utf-8?B?MytjUDFCOVFCbFI1RnNFOXN6eFlDbmhvdm1weDFpa3BCdEdvRGdHQVpwRHRj?=
 =?utf-8?B?NXIxbHk2bExPSUlHVGVENjNkZTNzNlYzd1NTT09icUF3KzdQc3ZEQzBkN0Jo?=
 =?utf-8?B?S1F1S3RlMDQwWVU5M0g4UmlLaWY2eVJudXV4SmdrMSsvU1p2MFg3Y0FWOFBl?=
 =?utf-8?B?ZURza0xsYURhRUdFeFhWbWdNWkw5SmVCMnZvS1hrZ3FBVVZKelhCN05DVVND?=
 =?utf-8?B?QnVRam1JbitWZ1lNbDBiM1p6eHRYWWNLNi9ZS2lHT1pxcDZkWng3WFJRM3F3?=
 =?utf-8?B?K1g4VFhmNVNaNm5XVU9GcTA2WWRreUNlVGhVdnd6SUFydThYaURjeTFQNmhW?=
 =?utf-8?B?QzFNcUs0d3hmZGJ1b0d4MkxaSkkra3UzQmJTcXhHY2Jjam9rcmQ5dEs1OUhh?=
 =?utf-8?B?WHlodFR4aHRaVHd1VU91b3BNSFprZWhRQjROV3M3UXFEUWVRQ04zWUx0TWZO?=
 =?utf-8?B?dnAxbzZMTjdHa21nbE9TRnp5UTJMVjEwd2RqYzJOWndkWXhBRDViV1hWcnYr?=
 =?utf-8?B?YnQybXVYa0djTXlxSWNWclNna3A2TlpJRnpBRzZhbENSdTJ1WkZoaDBKWC9u?=
 =?utf-8?B?bEV3S0NUMFNDMVphYWhBQ1FoNU94ZVZnNGxwbGlmaEY2NTVoY01peWJ5RXdM?=
 =?utf-8?B?UURNV2JqRzRxM0tKc1VHdktxclVPYStUVmVocnh1czF2NmRnOVV0Y3hyS3lB?=
 =?utf-8?B?bW5FZFNUSzJ3YkQ1RkprTWFxNjliaGF6WjkycVltaFVsOXZQNkVYTUlXWWt3?=
 =?utf-8?B?WXR1YlEvYTY0ODdBY1JnVzg3SiszUFVHMG90WVJQNEU1cjN6NVlhWG1YMmV5?=
 =?utf-8?B?SGEybmVvS2RlNGxzV2xlVk43ZlhtUkZqZFN6WmtiMWFzakdaWm10RElkaXpO?=
 =?utf-8?B?cERPZzJDVmZiYmwybWR0Tk1xVStkYkxqRjdHckdLOVppcytnUkdDMWtYaEhy?=
 =?utf-8?Q?nC2W06duit1oiDNs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13262ac3-fc36-4fe1-a021-08df0dbf7e27
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 15:40:21.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LCI3YJ7URNGBxCQ4Ho9tMwVsVdEriLr2qqsOKBAs7c4gSix5kCj6PLMSA6pE05F76S8aRNDC8qjiI6npj1LJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7756

From: Jan Kiszka <jan.kiszka@siemens.com>

Account for sporadic slowness when running in a VM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

changes in v2:
 - wanted 100 ms for VMs, ended up with "only" 10 ms which is too little

 testsuite/smokey/alchemytests/pipe-1.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testsuite/smokey/alchemytests/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
index 8989f3a46a..176ebf3331 100644
--- a/testsuite/smokey/alchemytests/pipe-1.c
+++ b/testsuite/smokey/alchemytests/pipe-1.c
@@ -8,8 +8,12 @@
 #include <alchemy/pipe.h>
 #include <smokey/smokey.h>
 
+#define TIMEOUT_SLACK	(on_vm ? 100000000 : 5000000)
+
 static struct traceobj trobj;
 
+static bool on_vm;
+
 static RT_TASK t_real;
 
 static RT_PIPE mpipe;
@@ -83,6 +87,8 @@ int main(int argc, char *const argv[])
 	SRTIME timeout;
 	int ret;
 
+	on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+
 	traceobj_init(&trobj, argv[0], 0);
 
 	ret = rt_pipe_create(&mpipe, "pipe", P_MINOR_AUTO, 0);
@@ -120,14 +126,14 @@ int main(int argc, char *const argv[])
 	ret = rt_pipe_read(&mpipe, &m, sizeof(m), timeout);
 	end = rt_timer_read();
 	traceobj_assert(&trobj, end - start >= timeout);
-	traceobj_assert(&trobj, end - start < timeout + rt_timer_ns2ticks(5000000));
+	traceobj_assert(&trobj, end - start < timeout + rt_timer_ns2ticks(TIMEOUT_SLACK));
 
 	start = rt_timer_read();
 	timeout = start + rt_timer_ns2ticks(100000000);
 	ret = rt_pipe_read_until(&mpipe, &m, sizeof(m), timeout);
 	end = rt_timer_read();
 	traceobj_assert(&trobj, end >= timeout);
-	traceobj_assert(&trobj, end < timeout + rt_timer_ns2ticks(5000000));
+	traceobj_assert(&trobj, end < timeout + rt_timer_ns2ticks(TIMEOUT_SLACK));
 
 	clock_gettime(CLOCK_COPPERPLATE, &ts_start);
 	timespec_adds(&ts_timeout, &ts_start, 100000000);
@@ -135,7 +141,7 @@ int main(int argc, char *const argv[])
 	clock_gettime(CLOCK_COPPERPLATE, &ts_end);
 	timespec_sub(&ts_delta, &ts_end, &ts_timeout);
 	traceobj_assert(&trobj, ts_delta.tv_sec >= 0);
-	traceobj_assert(&trobj, ts_delta.tv_nsec < 5000000);
+	traceobj_assert(&trobj, ts_delta.tv_nsec < TIMEOUT_SLACK);
 
 	ret = pthread_create(&t_reg, NULL, regular_thread, NULL);
 	traceobj_check(&trobj, ret, 0);
-- 
2.47.3

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794505476;
	b=3Z7tBlsLjCINwO1wEKiVkvYUkrJuKpGYqRpPID9/ilLZ8GV763hPAK/nlMGywA2Cl41x
	 upba+WVoXWtlD4+6odQC4GQf3zk6iGFACPVcWkDH5i6LAicF7I7d0608Kh/fWDTT/kgbn
	 sKNBSiQp39708SaIiWlm4Kv1CFEURKsDCeXwR4fcBBdnNUin9buokcbboGWW2k3Q8tQEA
	 B33URgLZjjH9OlVEOOOI+g7hjWbkZfzGukbnZOFMjN5cDqEUtsqC4gdt3wRxTHcESZPjh
	 se1zIDG88CMZ1GTmBeFXCk6BwNkrIzoWh8WyaXWPi42qCDqhDLR5WVECd8fi8tl3uEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505476;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:From:To:Subject:Content-Language:Cc:Autocrypt:Content-Type:
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
	bh=XPvYCqxpR/ttEPCFPyFxXLYzbxhHnxghcJdHwePDQ5I=;
	b=5Is1JygkASDYyoKYTZLtWifHfpQULJTjiPiVLqLhMSNWxpgJhvNRm6ufiIANKQitm1Vy
	 amx8DG2zBfmxI+4DW2FDDBZV8I6igIERqB9f0DXJZAt23IwZpjUh0bLodhpyxDxnz8ml/
	 lbC4TPJ1WXjlqdD3CJfTepAy7gjMcY1w8FZv4eXFDTRLS5ffyW93xvUy1DZJ8wyp3xLBZ
	 HepTTrrxAA0U9KbE/f6k4mTfCYzz2tW2549lNIDRsydmKlB2O18B5qUEAnFx/Ygl1T+to
	 k5BV1rxY+UXNpGbp/glloeHqz7vbnz8eF4+ejJxm2cAmJmKPgx2kunjcuYuUEbNQcqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=r8B+0CuC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.13
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2B1606A31C
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 17:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A2B1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=r8B+0CuC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+cs2Yce6i34+n8eYRYOFf4DNZvpERaifLQHWqmtnfENcB7KFbEojyITrN7ltJ5jbfCnrtUYj2g5ZYzVM6XFbHeLrbotoVM/m0eK0lBjdwDe5DRlZ3P0DexjqzskQ6Vvnont5RAIkGHlfI/EZ+d0uQ78FvMLATphgpmq26ZkuanZPzTfQ6o9vhATA1rRZ9F2laGKhpIIHsHkhV7FfmLPqX/fOmEofHZdbxyZ3Es9kZh+PNYO1jMDGTRBea81Y6GZuH94hdNb1NyxskvEiOcTse08CqHKWCXJt1gHzBFxd/OLZl6vzrrAeaV+mQ7Sp/jQlNVITJs+bmZrk8rsWEaF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPvYCqxpR/ttEPCFPyFxXLYzbxhHnxghcJdHwePDQ5I=;
 b=gtamCwXe1z9ssStS2CqFL2QRVEYBKUSGOU9w7aPSB4TskeTMeTY1XCCsyBiGlC/ryfFpFhBxfKvS0g/vJW3LHaIP1xzwLwVY76Z1gSpWOHPDxaD48POeUuiZFxS27P8EClbse4yxSw9GGth/yjV1gFEqNYAbcTnW/Y79ewAidP47Tbty76QJBsjN1gjkFK1lM5+F6rYY5OlqMUqCZCG6xDYP3Jocnq9Y9xw4PYO+RmGEqRGTO1hUwElAQuo2zMmuhIh9SpsltPBGaNwTFOzXSNx3sZSwkkgBaVIrP+OsqjNxT8Z/1z3hhhz3Lz6SZLN0C2ouo4IcLR3OTmpwd50daQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPvYCqxpR/ttEPCFPyFxXLYzbxhHnxghcJdHwePDQ5I=;
 b=r8B+0CuCezMgu8kW4gifsYgmPUaEQ+oFeZoctpj2J1MpobjaaK1clx/n7YLauedn6N62MVM9qLsiI+jTKszb1661v1jHGoYrF/IVJO+yp37Q6hQJqFM1llbcMr9abGydMKd551Zm+bZmaJjjuv8Tk8oky7mpcAmN2S+D6awGhMfLJZRdeZQOOQxTjmppNtsZddJ/NM+kxOJrhX0t5XYoH11+rb09aunN6CrP8um47/oaWABTbiXlQ+NjCaUdjPBEySc3mHcve4Sn5bygEDmme4FL/HSkVJbKL45yOCKoH9i2Lw+hobyoZMc4hqV572wJwwEcSUcO0mCURWRK2VfWGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB7194.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:452::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 17:44:26 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 17:44:26 +0000
Message-ID: <31921289-e2ce-4370-bb21-97d66de8e566@siemens.com>
Date: Thu, 12 Nov 2026 18:44:23 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [RFC][PATCH] smokey: Add traps test for trap routing of primary mode
 threads
Content-Language: en-US
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
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
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0141.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::25) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bbebc7-f874-4435-d50f-08df40e49874
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|261022115727099003|261028144727099003|261102130727099003|261026121527099003|261102123227099003|261026140227099003|261026130827099003|261026135527099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261021130227099003|261022113327099003|261021133027099003|56012099006|261021135927099003|10067099003|5023799004|11063799006|260925022911599003|17002099007|260925021911599003|260925021311599003|18002099003|55112099003|261009223027099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/GV4pVBw4SUQkJa4M2EVeNCO50kvefAlFzxcLJhnTMZKFyBuRLzAPBDVdwnpxTV6XBXXZhUGZehlHAFQJOY6GCHW3dZ6638Ibi30zfr7u8DC4TUgh/3otyDpAKcIYk+M/6Ava0CyCfrp3+Kf7dssSLBglJ9lBJgkallRXGkZlkXYzU9DCniudw6jHEkOH/VVHC0PMxsHSBqxsxkW8j/8pXvorzXcleZPFAKNSeUZdZjw7kSm23HP9+gZVoMcJoxd5T6aGG5FQ/JEW2PzUs2k/eAwjvIhKS5br/sdJGneRAuerts+ks3cCfxH52OBx3HZoyQLFGQ5tnh1FacphR0ukCOMZJC4HdjGZewNqVY5peJikO3WQqJYIpGO5xNfScf37hOczXS8nzE9UNjwpsj7CDKctwHkWhOkHyMsG2cirBNulm8A6uxVmdr0Qri0UipQgbGUQptLZnRrEPtjJGReGY6n+T928qgU6gxrDtXfOI4L/r3GVXo90kBQHIkXr0IBaN24cd29MY3GL/1JLdtxnNKURlhyFrIR5whzoNZdQosSSbliBhM7vasByF0WzdrG1/LclEsXKAnXAVhE/FaI/syqVUhlTzqkZHg6h9eYWgX2opdy2fqsvS9HjSQxMi063dz7/7/Ng3Deazzs/FXymkrnZRvffePLXf/4ehjvHEo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261022115727099003)(261028144727099003)(261102130727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261026130827099003)(261026135527099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261021130227099003)(261022113327099003)(261021133027099003)(56012099006)(261021135927099003)(10067099003)(5023799004)(11063799006)(260925022911599003)(17002099007)(260925021911599003)(260925021311599003)(18002099003)(55112099003)(261009223027099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TktwbVNlekRFc0lFcTB2b0sreTZPaUI4VnU4VDlUb2ExbFBVM1MzTmRSdzZu?=
 =?utf-8?B?clRhQmtHSHdTTjVqWFB5SDU3dGdsWlAxcnhPc0luQ256RHJwYVI5eGQ0ci9w?=
 =?utf-8?B?WGZhcEI1aituTXJqbjdjK05KZW1hd3QwT3pyOUJCK2hmRjVtdnlIWUxDaklw?=
 =?utf-8?B?NmNSTHNEMjFrZFpnOS8yemtMZVlDL0x4bzI3eFBseHNiWXY2T2ZGL1I4SlFF?=
 =?utf-8?B?QXBzU0NrdWZZUFR3eGcxOFlIUEE2c1p3djdERWpsQ2dMOWZnNjQxQzZQalc2?=
 =?utf-8?B?dit5enUxNW1OYXpOazM4V04zY0hQMy9MckU2REo1dDdWQ3B1SytDNG5PcG1K?=
 =?utf-8?B?S0FJa29wSmIxeHZuR1lLdGQxWVJpOHZSWHFBajNzUEt1SDVxa2hteGNjak5H?=
 =?utf-8?B?c1RiMVcyRmlweXcyR3dKN1lNck5xTkY3MVAxZ3BMQTBWeWpkT1VXYkI4Ym96?=
 =?utf-8?B?ajB4Tk1ZWjBsY1pTdzg4SkVjaDFYR3F5dnR1SGZwaFpnNlN6Q0ExOVZDMENU?=
 =?utf-8?B?SEZIS0JBNjVIQ2hIRVV3cmhwRDF0UVloVlMxSXpJWnRrWGlML0I4WjBjdENl?=
 =?utf-8?B?R25GcHVNNkJWbGtoRXFGcFBGYU81YUJ1RW44YkNySjRPUDY5RHVYQUpIa0wv?=
 =?utf-8?B?RkErWWhpMTRYN3c1dzIrMU1RRzMwUTVzRHZ1THZJNVhJNXJSSGNLOFBlaGV5?=
 =?utf-8?B?aDUwdU9VQ0JkY1B6TC9YRkt0czh6QVJRZkcrNGwrVndYVVh5N3FDbFZ5RW5v?=
 =?utf-8?B?cEQyVFVJb2g2L1greTYxdUR0WWl0TUxxOGV2U0M1RiswQld2UWp4ckRSa3Ez?=
 =?utf-8?B?QU04MGJLRWhuRnJSaGVobDQyNVVQMUlQREZFMHYwU2d4b0dEdjVZZzc4QUgy?=
 =?utf-8?B?N29XN0RBdVpoTC82azF5VENNWXZLd3NvanBoUlFVRW00bHRLc2RCVUZpRmo5?=
 =?utf-8?B?S29DUWRpUEx6ZmZkOElmVHB0ck5sQ1lkaUxVeVNvZWRWUHc2MU9qNzIyUUZI?=
 =?utf-8?B?VlBHUERiUitNUVJoemc2Rm5DU25nRFpjeTJRV0xIa1ByL0YrSENWWXhoeEc1?=
 =?utf-8?B?b041TlRNd0t3bjUvVmovdjV2enllSWJHYnVicGJhS2psQ3FqSWtVYXFPOFE3?=
 =?utf-8?B?eUUzYTRVbDgvWXRWZ2FxUWRZejJFNVVSa3NXaGJBcTRxM3ZYQUxXczYrQWdZ?=
 =?utf-8?B?OGhYM2ZjczZsc1ZMRzFxV3pSWUtTUXBnTHpyR1g4OFZTYmNzNXUxZVg2VkFj?=
 =?utf-8?B?MnR2RmlFaEQxWElBaDVBZG5nSzhkbXg0YWtBTWMxUzFUcmZ5dGVPeVlvQWl4?=
 =?utf-8?B?YThrT1owQVpMeXhBK0h0Lyt4Qk5NellMZXgyN2ttNVFzRWZhYW9pSkp6RjZI?=
 =?utf-8?B?ZDRwejNnMVhDcGxSbG9wR0UwVG9JQzlheWVOUDBmUHNyR01kejIwUkdiOXJS?=
 =?utf-8?B?WDdOam9ibXI1OVlmcE1KWHVKOS9kMnF4Nm00NEZUaGt6WTFpZnNUTW8xV2dt?=
 =?utf-8?B?c3MxVHB1WWJLaWl2QmN2d1FCVTd2OFFpZlA2ZlZnWXIwRTBNRnhMb1hWV0lz?=
 =?utf-8?B?NFBJYy9SZldDK05hRzh0ZmprajZKemFaOG1KbDR1OVBNZWhvRVlRbmp5YW14?=
 =?utf-8?B?TSs1cGJwMFBxOGFKejBydGFXRXNFS0owSHdncHBnaUkzK0JCTE9tQnBiVUMz?=
 =?utf-8?B?L3ZVMDhrUERuaGdwYTNMdnJUOEZZWjUxeVJDNDdlRzJZalR4VVd2SVp0a29o?=
 =?utf-8?B?aENSSVRmTEVBdHJ5eVdXNGtRaG5UL1U0aEIvZ1UyaGlWZVpnYk1QckVoUU5t?=
 =?utf-8?B?ZldKRGtBREw4Q1ZIU0lqMC9jVGxhOWRQU1VvcURvWXlsMlRWaGx6UjVNV1py?=
 =?utf-8?B?dmtocFVIcGlqSTVqSC9nOE9zajRZcFhEY1RDNnR5VG5YWlhaUDkra09mcGJR?=
 =?utf-8?B?YW9nMzQwamYrSXVpeTNmQjRZdnRWaXA2UHZETE81aHJSbUp1ZDZyOWFOMHZP?=
 =?utf-8?B?aWZ6Y3JLdkNac05yYnQ0MHhYa01lRHcxajlHU1VtZ2c1K2lZMXZhY1FrTkh6?=
 =?utf-8?B?R2RMQkpnSDdzcmF4UXpEUnNXMkFKZlVTYmc0cnlreVhQVGNzNitiUk1ReUxm?=
 =?utf-8?B?VFNWQVpXUXhmYWZhajRwMnZuTU5GN1BSQytCWEw2bUxvVk9ObnBuLzUwU25n?=
 =?utf-8?B?QWNIYzduYlBCT2RQN0tyVktuUkU3YkpEa050Mk1TZzVkNjFlRDNDZlNzdW1i?=
 =?utf-8?B?QWpLK0NtWU82aFZqSFU5c1A3M2NjSW0yWHZhRzZMTENBYmsvZ2ozY2FSZWVL?=
 =?utf-8?B?Zm9YRFdKRkprWndxYmZpRGhCMGZxdmdNK2VMRThhcDhJSUlUQkZqUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bbebc7-f874-4435-d50f-08df40e49874
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 17:44:26.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/21hponEY5Js0u59pYB92OlOFIGv5dFwAz9usutRaU3j1PBjozrXPlGqeMCkZxQcyVVNJ4jFnRhumARqraxPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7194

From: Jan Kiszka <jan.kiszka@siemens.com>

A thread running in primary mode which takes a synchronous exception
must be reported to the Cobalt core by the Dovetail layer exactly once
per trap, before the in-band kernel applies its fixup. Cobalt then
relaxes the thread, accounts the trap and sends SIGDEBUG_MIGRATE_FAULT
when asked for. Only the page fault flavor of this was covered so far,
by the sigdebug test.

Add a test which triggers one specific trap per case from a primary
mode thread and checks that the expected in-band fixup happened. Most
traps for x86, arm, and arm64 are covered here. Left out are those that
are practically irrelevant: AC for unaligned accesses on x86 and VFP
exceptions on ARM. Not yet covered is RISC-V, but it should be easy to
add on top.

See extensive AI generated explanation at the top of traps.c for more
details.

This test may become useful for checking future OBB trap reporting by
extending it only slightly.

Assisted-by: opencode:Fable-5.1/Opus-5.5
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I know this is huge. Therefore, it is also something that we likely 
would not have done without LLM support - way too much effort for 
testing corner cases.

I went through it, but not in all details. The tests fail when they are 
expected to on unfixed kernels, they apparently pass on fixed one, at 
least on our CI hardware. "Should be OK"...

BTW, if we merge this, we implicitly document parts of our so far
unwritten AI policy ("yes, we take generated code"). I still need to
think about which of the templates out there to use best, then I will 
propose one.

 configure.ac                       |    1 +
 testsuite/smokey/Makefile.am       |    2 +
 testsuite/smokey/traps/Makefile.am |    8 +
 testsuite/smokey/traps/traps.c     | 2259 ++++++++++++++++++++++++++++
 4 files changed, 2270 insertions(+)
 create mode 100644 testsuite/smokey/traps/Makefile.am
 create mode 100644 testsuite/smokey/traps/traps.c

diff --git a/configure.ac b/configure.ac
index 0d6dd87b61..e679ed7de0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1086,6 +1086,7 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/bufp/Makefile \
 	testsuite/smokey/sigdebug/Makefile \
 	testsuite/smokey/timerfd/Makefile \
+	testsuite/smokey/traps/Makefile \
 	testsuite/smokey/tsc/Makefile \
 	testsuite/smokey/leaks/Makefile \
 	testsuite/smokey/memcheck/Makefile \
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index c49a5d77f0..6a8d7dc3f6 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -37,6 +37,7 @@ COBALT_SUBDIRS = 	\
 	setsched	\
 	sigdebug	\
 	timerfd		\
+	traps		\
 	tsc		\
 	xddp		\
 	y2038		\
@@ -82,6 +83,7 @@ DIST_SUBDIRS = 		\
 	setsched	\
 	sigdebug	\
 	timerfd		\
+	traps		\
 	tsc		\
 	xddp		\
 	y2038		\
diff --git a/testsuite/smokey/traps/Makefile.am b/testsuite/smokey/traps/Makefile.am
new file mode 100644
index 0000000000..6b8f2d0483
--- /dev/null
+++ b/testsuite/smokey/traps/Makefile.am
@@ -0,0 +1,8 @@
+
+noinst_LIBRARIES = libtraps.a
+
+libtraps_a_SOURCES = traps.c
+
+libtraps_a_CPPFLAGS = 		\
+	@XENO_USER_CFLAGS@	\
+	-I$(top_srcdir)/include
diff --git a/testsuite/smokey/traps/traps.c b/testsuite/smokey/traps/traps.c
new file mode 100644
index 0000000000..4f9b3bd4d2
--- /dev/null
+++ b/testsuite/smokey/traps/traps.c
@@ -0,0 +1,2259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functional testing of trap routing for primary mode threads.
+ *
+ * Copyright (c) Siemens AG, 2026
+ *
+ * A thread running in primary mode which takes a synchronous
+ * exception (page fault, breakpoint, undefined instruction, ...) must
+ * be reported to the Cobalt core by the Dovetail layer of the kernel
+ * exactly once per trap, before the in-band kernel applies its fixup
+ * (fault handling, signal injection, instruction emulation). Cobalt
+ * then relaxes the thread to secondary mode, accounts the fault in
+ * /proc/xenomai/faults and sends SIGDEBUG_MIGRATE_FAULT if the thread
+ * asked for mode switch warnings.
+ *
+ * Each test case below triggers one specific trap from primary mode
+ * and checks:
+ *
+ * - the fixup the in-band kernel is expected to apply did happen
+ *   (signal with the right si_code, emulation result),
+ * - the thread was relaxed by the trap, i.e. it runs in secondary
+ *   mode when it gets back to user space,
+ * - exactly one SIGDEBUG was received, with reason MIGRATE_FAULT,
+ * - the fault counter of the expected trap incremented by exactly
+ *   one, all other trap counters stayed put,
+ * - the thread switched to secondary mode exactly once.
+ *
+ * Some cases trigger a nested trap on purpose: the in-band fixup of
+ * the outer trap accesses a user page which is not resident, so the
+ * kernel takes a page fault while handling the first trap. Only the
+ * outer trap must be reported. On the Cobalt side, this is observable
+ * as "no additional fault accounted, no additional mode switch, and
+ * the next case is still reported", since Cobalt does not act on trap
+ * exit notifications. Such fixups are the SWP and alignment emulations
+ * on arm, the vsyscall and UMIP emulations on x86. An arm64 kernel
+ * has them for compat tasks only (SWP, alignment), which the arm
+ * build of the test covers when run on an arm64 kernel.
+ *
+ * A trap which is not reported leaves the thread on the oob stage
+ * while the in-band kernel injects a signal; the thread keeps
+ * re-executing the faulting instruction until the Cobalt watchdog
+ * kicks it (the arm exception return path does not run the mayday
+ * trap). The test therefore requires the watchdog and shortens its
+ * timeout while running, so that a broken kernel fails instead of
+ * hanging. Such a failure is reported as "trap not reported to the
+ * core"; a failure of the trailing pagefault_again case indicates
+ * that an earlier case left a pending trap notification behind.
+ *
+ * The trap numbers the core accounts are those of the kernel
+ * architecture, which may differ from the test's: an arm (32-bit)
+ * build of the test on an arm64 kernel sees arm64 traps. The test
+ * therefore identifies traps by the labels the core shows in
+ * /proc/xenomai/faults, and knows which arm64 traps the compat
+ * flavors of its arm cases end up as. An arm64 kernel also offers no
+ * runtime control over misaligned accesses of compat tasks: they are
+ * either fixed up or signaled depending on COMPAT_ALIGNMENT_FIXUPS.
+ * The test probes this, and runs the matching alignment cases only.
+ * SWP emulation is switched on via abi.swp instead.
+ *
+ * Cases whose prerequisites are not met are skipped with a note. Note
+ * that emulators may not implement all traps the test relies on:
+ * QEMU/TCG for instance ignores SCTLR.SW and executes SWP natively on
+ * ARMv7 models, and does not check SP alignment on arm64.
+ *
+ * The fault handler runs in the context of the faulting instruction,
+ * and we leave it by longjmp: whatever that context had set up to
+ * trap stays in effect afterwards. The handler therefore runs on an
+ * alternate stack and restores a sane state first thing, before any
+ * library code is executed again.
+ *
+ * Case overview (cases=<name>[,<name>...] selects a subset):
+ *
+ *   common    pagefault, kprobe, pagefault_again, fork
+ *   arm       bkpt, undef, swp_valid, swp_fresh_page, swp_badaddr,
+ *             align_fixup, align_fixup_fresh_page, align_signal
+ *   arm64     brk, udf, sp_align
+ *   x86_64    int3, ud2, div0, gp, simd_div0, vsyscall,
+ *             vsyscall_fresh_page, vsyscall_badaddr, umip,
+ *             umip_fresh_page, umip_badaddr
+ *
+ * The kprobe case places a kprobe on a current-mode Cobalt syscall
+ * handler and invokes it from primary mode, which traps from kernel
+ * mode on the oob stage. It needs root and KPROBE_EVENTS.
+ */
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <signal.h>
+#include <ucontext.h>
+#include <setjmp.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdint.h>
+#include <sys/mman.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <linux/perf_event.h>
+#include <pthread.h>
+#include <sys/cobalt.h>
+#include <smokey/smokey.h>
+
+smokey_test_plugin(traps,
+		   SMOKEY_ARGLIST(
+			   SMOKEY_STRING(cases),
+		   ),
+		   "Check trap routing of primary mode threads.\n"
+		   "\tcases=<name>[,<name>...]\trun only the listed cases\n"
+);
+
+#if defined(__arm__) || defined(__aarch64__) || defined(__x86_64__)
+
+#define NR_TRAPS		32
+#define MAX_REASONS		8
+#define MAX_CASES		32
+#define WATCHDOG_TIMEOUT	2	/* seconds, while the test runs */
+#define ALTSTACK_SIZE		(64 * 1024)	/* room for AVX-512/SVE frames */
+
+#define FAULTS_PATH		"/proc/xenomai/faults"
+#define WATCHDOG_PATH		"/sys/module/xenomai/parameters/watchdog_timeout"
+#define KPROBES_OPT_PATH	"/proc/sys/debug/kprobes-optimization"
+#define KPROBE_TARGET		"CoBaLt_thread_setname"
+#define KPROBE_EVENT		"smokey_traps"
+
+#define TRAP_LABEL_LEN		48
+
+struct snapshot {
+	unsigned int faults[NR_TRAPS];
+	struct cobalt_threadstat stat;
+};
+
+/*
+ * The kinds of traps the cases expect. Each architecture maps them to
+ * the labels the core shows in /proc/xenomai/faults, which tell us the
+ * trap numbers at runtime.
+ */
+enum trap_kind {
+	TRAP_PAGEFAULT,
+	TRAP_KPROBE,
+	TRAP_BREAKPOINT,
+	TRAP_UNDEF,
+	TRAP_ALIGNMENT,
+	TRAP_SP_ALIGNMENT,
+	TRAP_DIVIDE,
+	TRAP_GPF,
+	TRAP_SIMD,
+	TRAP_VSYSCALL,			/* x86: #PF, or #GP with LASS */
+	NR_TRAP_KINDS
+};
+
+struct trap_case {
+	const char *name;
+	int (*prepare)(void);		/* in secondary mode, optional */
+	void (*trigger)(void);		/* in primary mode */
+	int (*verify)(void);		/* check fixup results, optional */
+	void (*cleanup)(void);		/* always runs after prepare, optional */
+	enum trap_kind trap;		/* expected trap */
+	int signo;			/* expected signal, 0 for none */
+	int si_code;			/* expected si_code, -1 for any */
+	bool nested;			/* in-band fixup faults on a fresh page */
+};
+
+static char trap_labels[NR_TRAPS][TRAP_LABEL_LEN];
+static int trap_nr[NR_TRAP_KINDS];	/* resolved, -1 if unknown */
+
+static int rt_cpu;
+static int failures;
+
+static sigjmp_buf trap_env;
+static volatile int trap_signo;
+static volatile int trap_si_code;
+static volatile int trap_signals;
+static volatile int trap_in_sigdebug;	/* fault taken inside sigdebug_handler */
+static volatile unsigned long trap_ip;
+static void *volatile trap_addr;
+static volatile int in_sigdebug;
+static volatile unsigned int sigdebug_reasons[MAX_REASONS];
+static volatile int nr_sigdebug;
+
+static int kprobe_armed;
+static char kprobe_opt_saved[8];
+static char tracefs[64];
+static const char *skip_reason;	/* set by prepare handlers returning -ENOSYS */
+static char watchdog_saved[16];
+
+static unsigned char static_buf[64] __attribute__((aligned(16)));
+static unsigned int *fresh_page;
+static unsigned char *ro_page;
+
+/*
+ * Architecture specific part: trap numbers (see the dovetail.h of the
+ * respective arch), the fault signals the cases may raise, the
+ * faulting instructions and the cases built on them.
+ */
+
+static int read_file(const char *path, char *buf, size_t len);
+static int write_file(const char *path, const char *s);
+static int map_fresh_page(void);
+static void unmap_fresh_page(void);
+static int trap_by_label(const char *label);
+
+#if defined(__arm__)
+
+/* Labels of kernel/cobalt/arch/arm/machine.c */
+static const char *const arm_trap_labels[NR_TRAP_KINDS] = {
+	[TRAP_PAGEFAULT] = "Data or instruction access",
+	[TRAP_KPROBE] = "Undefined instruction",
+	[TRAP_BREAKPOINT] = "Instruction breakpoint",
+	[TRAP_UNDEF] = "Undefined instruction",
+	[TRAP_ALIGNMENT] = "Unaligned access exception",
+};
+
+/*
+ * Running on an arm64 kernel (compat): labels of
+ * kernel/cobalt/arch/arm64/machine.c. AArch32 breakpoints and SWP are
+ * undefined instructions to AArch64, kernel kprobes use BRK, and
+ * misaligned accesses are data aborts.
+ */
+static const char *const compat_trap_labels[NR_TRAP_KINDS] = {
+	[TRAP_PAGEFAULT] = "Data or instruction abort",
+	[TRAP_KPROBE] = "Debug trap",
+	[TRAP_BREAKPOINT] = "Undefined instruction",
+	[TRAP_UNDEF] = "Undefined instruction",
+	[TRAP_ALIGNMENT] = "Data or instruction abort",
+};
+
+static const char *const *arch_trap_labels(void)
+{
+	if (trap_by_label("Instruction breakpoint") < 0 &&
+	    trap_by_label("Debug trap") >= 0)
+		return compat_trap_labels;
+
+	return arm_trap_labels;
+}
+
+static const unsigned int kprobe_offsets[] = { 0 };
+
+#define ALIGNMENT_PATH		"/proc/cpu/alignment"
+#define SWP_EMULATION_PATH	"/proc/cpu/swp_emulation"
+#define ABI_SWP_PATH		"/proc/sys/abi/swp"	/* arm64 kernel */
+
+#define ALIGN_MODE_FIXUP	2
+#define ALIGN_MODE_SIGNAL	4
+
+static const int arch_sigs[] = { SIGILL, SIGBUS, SIGTRAP };
+
+/*
+ * ARM-state islands for the instructions which trigger the traps.
+ * The test might be compiled to Thumb-2 code, where some of the
+ * encodings do not exist (SWP) or behave differently. Keep the
+ * faulting instructions in leaf functions so that we can longjmp out
+ * of the signal handler without caring for the state they left.
+ */
+asm(
+"	.text\n"
+"	.arm\n"
+"	.align 2\n"
+"	.global traps_arm_bkpt\n"
+"	.type traps_arm_bkpt, %function\n"
+"traps_arm_bkpt:\n"
+"	.inst 0xe7f001f0\n"		/* gdb/ptrace ARM breakpoint */
+"	bx lr\n"
+"	.size traps_arm_bkpt, . - traps_arm_bkpt\n"
+"\n"
+"	.global traps_arm_undef\n"
+"	.type traps_arm_undef, %function\n"
+"traps_arm_undef:\n"
+"	.inst 0xe7f000f0\n"		/* udf #0 */
+"	bx lr\n"
+"	.size traps_arm_undef, . - traps_arm_undef\n"
+"\n"
+	/* unsigned int traps_arm_swp(unsigned int *addr, unsigned int val) */
+"	.global traps_arm_swp\n"
+"	.type traps_arm_swp, %function\n"
+"traps_arm_swp:\n"
+"	mov r2, r0\n"
+"	.inst 0xe1020091\n"		/* swp r0, r1, [r2] */
+"	bx lr\n"
+"	.size traps_arm_swp, . - traps_arm_swp\n"
+"\n"
+	/* void traps_arm_ldrd(void *addr, unsigned int out[2]) */
+"	.global traps_arm_ldrd\n"
+"	.type traps_arm_ldrd, %function\n"
+"traps_arm_ldrd:\n"
+"	.inst 0xe1c020d0\n"		/* ldrd r2, r3, [r0] */
+"	stm r1, {r2, r3}\n"
+"	bx lr\n"
+"	.size traps_arm_ldrd, . - traps_arm_ldrd\n"
+);
+
+void traps_arm_bkpt(void);
+void traps_arm_undef(void);
+unsigned int traps_arm_swp(unsigned int *addr, unsigned int val);
+void traps_arm_ldrd(void *addr, unsigned int out[2]);
+
+static int have_swp_emulation;
+static const char *swp_skip_reason;
+static char abi_swp_saved[8];
+static int align_fd = -1;
+static int align_mode_saved = -1;
+static int align_mode_current = -1;	/* -1: unknown yet */
+
+static void trigger_bkpt(void)
+{
+	traps_arm_bkpt();
+}
+
+static void trigger_undef(void)
+{
+	traps_arm_undef();
+}
+
+/*
+ * SWP is deprecated since ARMv7 and obsolete since ARMv8: with
+ * CONFIG_SWP_EMULATE, an arm kernel disables it (SCTLR.SW) and
+ * emulates it from the undefined instruction trap; an arm64 kernel
+ * does the same for compat tasks if abi.swp is set to emulation.
+ * Whether the hardware actually traps is another story, e.g. QEMU/TCG
+ * ignores SCTLR.SW and executes SWP natively on ARMv7 models. Probe
+ * this from secondary mode, counting emulations: both kernels account
+ * them as a perf software event, an arm kernel also exports a counter
+ * in /proc.
+ */
+static int open_emulation_counter(void)
+{
+	struct perf_event_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.size = sizeof(attr);
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_EMULATION_FAULTS;
+	attr.exclude_kernel = 1;	/* still counts traps from user mode */
+	attr.exclude_hv = 1;
+
+	return syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
+}
+
+static long long read_swp_emulated(int perf_fd)
+{
+	char buf[256], *p;
+	uint64_t count;
+
+	if (perf_fd >= 0)
+		return read(perf_fd, &count, sizeof(count)) == sizeof(count) ?
+			(long long)count : -1;
+
+	if (read_file(SWP_EMULATION_PATH, buf, sizeof(buf)))
+		return -1;
+
+	p = strstr(buf, "Emulated SWP:");
+	if (p == NULL)
+		return -1;
+
+	return strtoll(p + strlen("Emulated SWP:"), NULL, 10);
+}
+
+static int prepare_swp(void)
+{
+	long long before, after;
+	unsigned int word = 0;
+	int perf_fd;
+
+	if (!have_swp_emulation) {
+		skip_reason = swp_skip_reason;
+		return -ENOSYS;
+	}
+
+	/* The syscalls relax us if we are not in secondary mode yet. */
+	perf_fd = open_emulation_counter();
+	before = read_swp_emulated(perf_fd);
+
+	if (sigsetjmp(trap_env, 1) == 0) {
+		traps_arm_swp(&word, 1);
+	} else {
+		if (perf_fd >= 0)
+			close(perf_fd);
+		skip_reason = "SWP raises SIGILL, not emulated";
+		return -ENOSYS;
+	}
+
+	after = read_swp_emulated(perf_fd);
+	if (perf_fd >= 0)
+		close(perf_fd);
+
+	/*
+	 * Without a counter, assume it trapped: ARMv8 hardware has
+	 * no SWP in AArch32.
+	 */
+	if (before >= 0 && after == before) {
+		skip_reason = "SWP is executed natively, not trapped";
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
+static unsigned int swp_result;
+
+static void trigger_swp_valid(void)
+{
+	unsigned int *word = (unsigned int *)static_buf;
+
+	*word = 0x11223344;
+	swp_result = traps_arm_swp(word, 0x55667788);
+}
+
+static int verify_swp_valid(void)
+{
+	unsigned int *word = (unsigned int *)static_buf;
+
+	if (swp_result != 0x11223344 || *word != 0x55667788) {
+		smokey_warning("swp: bad emulation result %#x/%#x",
+			       swp_result, *word);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int prepare_swp_fresh_page(void)
+{
+	int ret;
+
+	ret = prepare_swp();
+	if (ret)
+		return ret;
+
+	return map_fresh_page();
+}
+
+static void trigger_swp_fresh_page(void)
+{
+	swp_result = traps_arm_swp(fresh_page, 0x55667788);
+}
+
+static int verify_swp_fresh_page(void)
+{
+	if (swp_result != 0 || *fresh_page != 0x55667788) {
+		smokey_warning("swp: bad emulation result %#x/%#x on fresh page",
+			       swp_result, *fresh_page);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void trigger_swp_badaddr(void)
+{
+	/* Lowest page is never mapped (vm.mmap_min_addr). */
+	traps_arm_swp((unsigned int *)0x10, 0);
+}
+
+static int read_align_mode(void)
+{
+	char line[128];
+	int mode = -1;
+	FILE *fp;
+
+	fp = fopen(ALIGNMENT_PATH, "r");
+	if (fp == NULL)
+		return -errno;
+
+	while (fgets(line, sizeof(line), fp))
+		if (sscanf(line, "User faults: %d", &mode) == 1)
+			break;
+
+	fclose(fp);
+
+	return mode;
+}
+
+static int set_align_mode(int mode)
+{
+	char c = '0' + mode;
+
+	if (align_fd < 0)
+		return -ENOSYS;
+
+	if (write(align_fd, &c, 1) != 1)
+		return -errno;
+
+	return 0;
+}
+
+static unsigned int ldrd_result[2];
+
+/*
+ * How does the kernel handle a misaligned LDRD from user mode? Probed
+ * from secondary mode, for kernels which do not tell: arm64 kernels
+ * fix up (CONFIG_COMPAT_ALIGNMENT_FIXUPS) or signal, as configured at
+ * build time.
+ */
+static int probe_align_mode(void)
+{
+	memcpy(static_buf, "\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a", 10);
+
+	if (sigsetjmp(trap_env, 1) == 0) {
+		traps_arm_ldrd(static_buf + 1, ldrd_result);
+		return memcmp(ldrd_result, static_buf + 1,
+			      sizeof(ldrd_result)) ? -1 : ALIGN_MODE_FIXUP;
+	}
+
+	return trap_signo == SIGBUS ? ALIGN_MODE_SIGNAL : -1;
+}
+
+/*
+ * Make the kernel handle misaligned user accesses the given way. We
+ * can switch the mode as root on an arm kernel, otherwise only the
+ * cases matching the current mode can run.
+ */
+static int use_align_mode(int mode)
+{
+	if (align_fd >= 0)
+		return set_align_mode(mode);
+
+	if (align_mode_current < 0)
+		align_mode_current = probe_align_mode();
+
+	if (align_mode_current >= 0 && (align_mode_current & mode))
+		return 0;
+
+	if (align_mode_current < 0)
+		skip_reason = "cannot determine the alignment fault mode";
+	else if (align_mode_current & ALIGN_MODE_FIXUP)
+		skip_reason = "kernel fixes up misaligned accesses";
+	else if (align_mode_current & ALIGN_MODE_SIGNAL)
+		skip_reason = "kernel signals misaligned accesses";
+	else
+		skip_reason = "kernel ignores misaligned accesses";
+
+	return -ENOSYS;
+}
+
+static int prepare_align_fixup(void)
+{
+	return use_align_mode(ALIGN_MODE_FIXUP);
+}
+
+static void trigger_align_fixup(void)
+{
+	memcpy(static_buf, "\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a", 10);
+	traps_arm_ldrd(static_buf + 1, ldrd_result);
+}
+
+static int verify_align_fixup(void)
+{
+	unsigned int expected[2];
+
+	memcpy(expected, static_buf + 1, sizeof(expected));
+	if (memcmp(ldrd_result, expected, sizeof(expected))) {
+		smokey_warning("ldrd: bad fixup result %#x/%#x, expected %#x/%#x",
+			       ldrd_result[0], ldrd_result[1],
+			       expected[0], expected[1]);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int prepare_align_fixup_fresh_page(void)
+{
+	int ret;
+
+	ret = use_align_mode(ALIGN_MODE_FIXUP);
+	if (ret)
+		return ret;
+
+	return map_fresh_page();
+}
+
+static void trigger_align_fixup_fresh_page(void)
+{
+	traps_arm_ldrd((unsigned char *)fresh_page + 1, ldrd_result);
+}
+
+static int verify_align_fixup_fresh_page(void)
+{
+	if (ldrd_result[0] != 0 || ldrd_result[1] != 0) {
+		smokey_warning("ldrd: bad fixup result %#x/%#x on fresh page",
+			       ldrd_result[0], ldrd_result[1]);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int prepare_align_signal(void)
+{
+	return use_align_mode(ALIGN_MODE_SIGNAL);
+}
+
+static void trigger_align_signal(void)
+{
+	traps_arm_ldrd(static_buf + 1, ldrd_result);
+}
+
+static void cleanup_align(void)
+{
+	if (align_fd >= 0)
+		set_align_mode(align_mode_saved);
+}
+
+static void cleanup_align_fresh_page(void)
+{
+	unmap_fresh_page();
+	cleanup_align();
+}
+
+static const struct trap_case arch_cases[] = {
+	{
+		.name = "bkpt",
+		.trigger = trigger_bkpt,
+		.trap = TRAP_BREAKPOINT,
+		.signo = SIGTRAP,
+		.si_code = TRAP_BRKPT,
+	}, {
+		.name = "undef",
+		.trigger = trigger_undef,
+		.trap = TRAP_UNDEF,
+		.signo = SIGILL,
+		.si_code = ILL_ILLOPC,
+	}, {
+		.name = "swp_valid",
+		.prepare = prepare_swp,
+		.trigger = trigger_swp_valid,
+		.verify = verify_swp_valid,
+		.trap = TRAP_UNDEF,
+	}, {
+		.name = "swp_fresh_page",
+		.prepare = prepare_swp_fresh_page,
+		.trigger = trigger_swp_fresh_page,
+		.verify = verify_swp_fresh_page,
+		.cleanup = unmap_fresh_page,
+		.trap = TRAP_UNDEF,
+		.nested = true,
+	}, {
+		/*
+		 * set_segfault() in the kernel picks the si_code with
+		 * find_vma(), which yields the lowest mapping above
+		 * the address, hence ACCERR rather than MAPERR. Don't
+		 * depend on this.
+		 */
+		.name = "swp_badaddr",
+		.prepare = prepare_swp,
+		.trigger = trigger_swp_badaddr,
+		.trap = TRAP_UNDEF,
+		.signo = SIGSEGV,
+		.si_code = -1,
+		.nested = true,
+	}, {
+		.name = "align_fixup",
+		.prepare = prepare_align_fixup,
+		.trigger = trigger_align_fixup,
+		.verify = verify_align_fixup,
+		.cleanup = cleanup_align,
+		.trap = TRAP_ALIGNMENT,
+	}, {
+		.name = "align_fixup_fresh_page",
+		.prepare = prepare_align_fixup_fresh_page,
+		.trigger = trigger_align_fixup_fresh_page,
+		.verify = verify_align_fixup_fresh_page,
+		.cleanup = cleanup_align_fresh_page,
+		.trap = TRAP_ALIGNMENT,
+		.nested = true,
+	}, {
+		.name = "align_signal",
+		.prepare = prepare_align_signal,
+		.trigger = trigger_align_signal,
+		.cleanup = cleanup_align,
+		.trap = TRAP_ALIGNMENT,
+		.signo = SIGBUS,
+		.si_code = BUS_ADRALN,
+	},
+};
+
+static inline void arch_sanitize_handler_context(void) { }
+
+static inline unsigned long arch_fault_ip(void *context)
+{
+	return ((ucontext_t *)context)->uc_mcontext.arm_pc;
+}
+
+static void arch_init(void)
+{
+	if (access(SWP_EMULATION_PATH, F_OK) == 0) {
+		have_swp_emulation = 1;
+	} else if (read_file(ABI_SWP_PATH, abi_swp_saved,
+			     sizeof(abi_swp_saved)) == 0) {
+		/* arm64 kernel: 0=undef, 1=emulate, 2=hw (n/a for SWP) */
+		if (atoi(abi_swp_saved) == 1) {
+			have_swp_emulation = 1;
+			abi_swp_saved[0] = '\0';	/* nothing to restore */
+		} else if (write_file(ABI_SWP_PATH, "1\n") == 0) {
+			have_swp_emulation = 1;
+		} else {
+			abi_swp_saved[0] = '\0';
+			swp_skip_reason = "SWP emulation disabled (" ABI_SWP_PATH ")";
+		}
+	} else
+		swp_skip_reason = "kernel does not emulate SWP";
+
+	/* An arm64 kernel has no such file, we probe it later on. */
+	align_mode_current = read_align_mode();
+	align_fd = open(ALIGNMENT_PATH, O_WRONLY);
+	if (align_fd >= 0) {
+		align_mode_saved = align_mode_current;
+		if (align_mode_saved < 0) {
+			close(align_fd);
+			align_fd = -1;
+		}
+	}
+}
+
+static void arch_cleanup(void)
+{
+	if (align_fd >= 0) {
+		set_align_mode(align_mode_saved);
+		close(align_fd);
+		align_fd = -1;
+	}
+
+	if (abi_swp_saved[0]) {
+		write_file(ABI_SWP_PATH, abi_swp_saved);
+		abi_swp_saved[0] = '\0';
+	}
+}
+
+#elif defined(__aarch64__)
+
+/* Labels of kernel/cobalt/arch/arm64/machine.c, kprobes use BRK */
+static const char *const arm64_trap_labels[NR_TRAP_KINDS] = {
+	[TRAP_PAGEFAULT] = "Data or instruction abort",
+	[TRAP_KPROBE] = "Debug trap",
+	[TRAP_BREAKPOINT] = "Debug trap",
+	[TRAP_UNDEF] = "Undefined instruction",
+	[TRAP_SP_ALIGNMENT] = "SP/PC alignment abort",
+};
+
+static const char *const *arch_trap_labels(void)
+{
+	return arm64_trap_labels;
+}
+
+static const unsigned int kprobe_offsets[] = { 0 };
+
+static const int arch_sigs[] = { SIGILL, SIGBUS, SIGTRAP };
+
+static void trigger_brk(void)
+{
+	asm volatile("brk #0" ::: "memory");
+}
+
+static void trigger_udf(void)
+{
+	asm volatile(".inst 0x00000000" ::: "memory");	/* udf #0 */
+}
+
+/*
+ * SCTLR_EL1.SA0 is set by Linux: a data access through a misaligned
+ * SP from EL0 raises an SP alignment fault, regardless of the
+ * alignment of the address itself. Emulators may not implement this
+ * check (QEMU/TCG does not), probe it from secondary mode first.
+ */
+static void trigger_sp_align(void)
+{
+	asm volatile(
+		"	mov	x9, sp\n"
+		"	add	x10, %0, #1\n"
+		"	mov	sp, x10\n"
+		"	ldr	x11, [sp]\n"
+		"	mov	sp, x9\n"
+		: : "r"(static_buf) : "x9", "x10", "x11", "memory");
+}
+
+static int prepare_sp_align(void)
+{
+	if (sigsetjmp(trap_env, 1) == 0) {
+		trigger_sp_align();
+		skip_reason = "SP alignment is not checked by this CPU/emulator";
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
+/* The misaligned SP of sp_align is taken care of by the altstack. */
+static inline void arch_sanitize_handler_context(void) { }
+
+static inline unsigned long arch_fault_ip(void *context)
+{
+	return ((ucontext_t *)context)->uc_mcontext.pc;
+}
+
+static const struct trap_case arch_cases[] = {
+	{
+		.name = "brk",
+		.trigger = trigger_brk,
+		.trap = TRAP_BREAKPOINT,
+		.signo = SIGTRAP,
+		.si_code = TRAP_BRKPT,
+	}, {
+		.name = "udf",
+		.trigger = trigger_udf,
+		.trap = TRAP_UNDEF,
+		.signo = SIGILL,
+		.si_code = ILL_ILLOPC,
+	}, {
+		.name = "sp_align",
+		.prepare = prepare_sp_align,
+		.trigger = trigger_sp_align,
+		.trap = TRAP_SP_ALIGNMENT,
+		.signo = SIGBUS,
+		.si_code = BUS_ADRALN,
+	},
+};
+
+static void arch_init(void) { }
+static void arch_cleanup(void) { }
+
+#elif defined(__x86_64__)
+
+/* Labels of kernel/cobalt/arch/x86/machine.c, kprobes use INT3 */
+static const char *x86_trap_labels[NR_TRAP_KINDS] = {
+	[TRAP_PAGEFAULT] = "Page fault",
+	[TRAP_KPROBE] = "Int3",
+	[TRAP_BREAKPOINT] = "Int3",
+	[TRAP_UNDEF] = "Invalid opcode",
+	[TRAP_ALIGNMENT] = "Alignment check",
+	[TRAP_DIVIDE] = "Divide error",
+	[TRAP_GPF] = "General protection",
+	[TRAP_SIMD] = "SIMD error",
+	[TRAP_VSYSCALL] = "Page fault",
+};
+
+static bool cpu_has_flag(const char *flag)
+{
+	char *line = NULL, *p, *save;
+	bool found = false;
+	size_t len = 0;
+	FILE *fp;
+
+	fp = fopen("/proc/cpuinfo", "r");
+	if (fp == NULL)
+		return false;
+
+	while (getline(&line, &len, fp) > 0) {
+		if (strncmp(line, "flags", 5))
+			continue;
+		p = strchr(line, ':');
+		for (p = p ? strtok_r(p + 1, " \n", &save) : NULL; p && !found;
+		     p = strtok_r(NULL, " \n", &save))
+			found = strcmp(p, flag) == 0;
+		break;
+	}
+
+	free(line);
+	fclose(fp);
+
+	return found;
+}
+
+static const char *const *arch_trap_labels(void)
+{
+	/*
+	 * With LASS, user mode accesses to the upper half of the
+	 * address space raise #GP, calling a vsyscall included.
+	 */
+	if (cpu_has_flag("lass"))
+		x86_trap_labels[TRAP_VSYSCALL] = "General protection";
+
+	return x86_trap_labels;
+}
+
+/*
+ * With KPROBES_ON_FTRACE, a probe on the function entry is hooked via
+ * the __fentry__ call and does not trap at all. Fall back to the
+ * first instruction after the 5-byte fentry NOP, or after
+ * ENDBR64+NOP with IBT. The kernel rejects offsets which are not an
+ * instruction boundary, so trying is safe.
+ */
+static const unsigned int kprobe_offsets[] = { 0, 5, 9 };
+
+#define MXCSR_ZE		(1 << 2)	/* divide-by-zero flag */
+#define MXCSR_ZM		(1 << 9)	/* divide-by-zero mask */
+
+static const int arch_sigs[] = { SIGILL, SIGBUS, SIGTRAP, SIGFPE };
+
+static void trigger_int3(void)
+{
+	asm volatile("int3" ::: "memory");
+}
+
+static void trigger_ud2(void)
+{
+	asm volatile("ud2" ::: "memory");
+}
+
+static void trigger_div0(void)
+{
+	unsigned int zero = 0;
+
+	asm volatile(
+		"	xor	%%edx, %%edx\n"
+		"	mov	$1, %%eax\n"
+		"	divl	%0\n"
+		: : "m"(zero) : "eax", "edx", "cc", "memory");
+}
+
+static void trigger_gp(void)
+{
+	asm volatile("hlt" ::: "memory");	/* privileged */
+}
+
+/*
+ * Divide 1.0f by 0.0f with the given MXCSR, return MXCSR afterwards.
+ * The trap is taken when the divide-by-zero exception is unmasked.
+ */
+static unsigned int simd_div(unsigned int mxcsr)
+{
+	static const float one[4] __attribute__((aligned(16))) = { 1, 1, 1, 1 };
+	static const float zero[4] __attribute__((aligned(16))) = { 0, 0, 0, 0 };
+	unsigned int out;
+
+	asm volatile(
+		"	ldmxcsr	%1\n"
+		"	movaps	%2, %%xmm0\n"
+		"	movaps	%3, %%xmm1\n"
+		"	divps	%%xmm1, %%xmm0\n"
+		"	stmxcsr	%0\n"
+		: "=m"(out)
+		: "m"(mxcsr), "m"(one), "m"(zero)
+		: "xmm0", "xmm1", "memory");
+
+	return out;
+}
+
+static unsigned int mxcsr_saved;
+
+/*
+ * Probe from secondary mode whether an unmasked divide-by-zero
+ * actually traps on this hardware/emulator (SIGFPE lands in
+ * fault_handler(), which longjmps back to us).
+ */
+static int prepare_simd_div0(void)
+{
+	asm volatile("stmxcsr %0" : "=m"(mxcsr_saved));
+
+	if (sigsetjmp(trap_env, 1) == 0) {
+		simd_div(mxcsr_saved & ~MXCSR_ZM);
+		asm volatile("ldmxcsr %0" : : "m"(mxcsr_saved));
+		skip_reason = "SIMD exceptions do not trap";
+		return -ENOSYS;
+	}
+
+	asm volatile("ldmxcsr %0" : : "m"(mxcsr_saved));
+	return 0;
+}
+
+static void trigger_simd_div0(void)
+{
+	simd_div(mxcsr_saved & ~MXCSR_ZM);
+}
+
+static void cleanup_simd_div0(void)
+{
+	/* Restore the mask bits, clear the sticky ZE flag. */
+	asm volatile("ldmxcsr %0" : : "m"(mxcsr_saved));
+}
+
+/*
+ * Mask all SIMD exceptions again.
+ */
+static inline void arch_sanitize_handler_context(void)
+{
+	static const unsigned int mxcsr_default = 0x1f80;
+
+	asm volatile("ldmxcsr %0\n" : : "m"(mxcsr_default));
+}
+
+static inline unsigned long arch_fault_ip(void *context)
+{
+	return ((ucontext_t *)context)->uc_mcontext.gregs[REG_RIP];
+}
+
+/*
+ * Legacy vsyscalls: calling into the vsyscall page traps, and the
+ * kernel emulates the call unless booted with vsyscall=none. The
+ * emulated gettimeofday() writes its result to user memory from the
+ * in-band fixup.
+ */
+#define VSYSCALL_GETTIMEOFDAY	0xffffffffff600000UL
+
+typedef long (*vgettimeofday_t)(struct timeval *tv, struct timezone *tz);
+
+static struct timeval vsyscall_tv;
+static long vsyscall_ret;
+
+static int prepare_vsyscall(void)
+{
+	bool found = false;
+	char line[256];
+	FILE *fp;
+
+	fp = fopen("/proc/self/maps", "r");
+	if (fp == NULL)
+		return -errno;
+
+	while (!found && fgets(line, sizeof(line), fp))
+		found = strstr(line, "[vsyscall]") != NULL;
+
+	fclose(fp);
+
+	if (!found) {
+		skip_reason = "no vsyscall page (vsyscall=none)";
+		return -ENOSYS;
+	}
+
+	vsyscall_ret = -1;
+	memset(&vsyscall_tv, 0, sizeof(vsyscall_tv));
+
+	return 0;
+}
+
+static void trigger_vsyscall(void)
+{
+	vsyscall_ret = ((vgettimeofday_t)VSYSCALL_GETTIMEOFDAY)(&vsyscall_tv,
+								 NULL);
+}
+
+static int check_vsyscall_result(const struct timeval *tv)
+{
+	if (vsyscall_ret != 0 || tv->tv_sec <= 0 ||
+	    tv->tv_usec < 0 || tv->tv_usec >= 1000000) {
+		smokey_warning("vsyscall gettimeofday: returned %ld, "
+			       "tv = %lld.%06ld", vsyscall_ret,
+			       (long long)tv->tv_sec, (long)tv->tv_usec);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int verify_vsyscall(void)
+{
+	return check_vsyscall_result(&vsyscall_tv);
+}
+
+static int prepare_vsyscall_fresh_page(void)
+{
+	int ret;
+
+	ret = prepare_vsyscall();
+	if (ret)
+		return ret;
+
+	return map_fresh_page();
+}
+
+static void trigger_vsyscall_fresh_page(void)
+{
+	vsyscall_ret = ((vgettimeofday_t)VSYSCALL_GETTIMEOFDAY)(
+		(struct timeval *)fresh_page, NULL);
+}
+
+static int verify_vsyscall_fresh_page(void)
+{
+	return check_vsyscall_result((struct timeval *)fresh_page);
+}
+
+/*
+ * The emulation checks the pointer against the user address range
+ * only, the kernel takes a page fault when writing the result. This
+ * logs "vsyscall fault (exploit attempt?)".
+ *
+ * The failed emulation leaves the IP on the vsyscall page, which has
+ * no unwind info. With relax tracing, libcobalt answers the SIGSHADOW
+ * request Cobalt sends upon relaxing us with a backtrace(), which
+ * unwinds into that context, and the unwinder then reads the code at
+ * the IP to look for a sigreturn trampoline. With vsyscall=xonly, this
+ * read faults, and our fault handler leaves for good before SIGDEBUG
+ * and the SIGSEGV of the emulation are delivered. Keep SIGSHADOW
+ * blocked until the case is over, so that the backtrace is taken from
+ * the cleanup handler instead.
+ */
+static sigset_t vsyscall_saved_sigmask;
+static bool vsyscall_sigshadow_blocked;
+
+static int prepare_vsyscall_badaddr(void)
+{
+	sigset_t set;
+	int ret;
+
+	ret = prepare_vsyscall();
+	if (ret)
+		return ret;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGSHADOW);
+	ret = pthread_sigmask(SIG_BLOCK, &set, &vsyscall_saved_sigmask);
+	if (ret)
+		return -ret;
+
+	vsyscall_sigshadow_blocked = true;
+
+	return 0;
+}
+
+static void trigger_vsyscall_badaddr(void)
+{
+	/* Lowest page is never mapped (vm.mmap_min_addr). */
+	((vgettimeofday_t)VSYSCALL_GETTIMEOFDAY)((struct timeval *)0x10, NULL);
+}
+
+static void cleanup_vsyscall_badaddr(void)
+{
+	if (vsyscall_sigshadow_blocked) {
+		pthread_sigmask(SIG_SETMASK, &vsyscall_saved_sigmask, NULL);
+		vsyscall_sigshadow_blocked = false;
+	}
+}
+
+/*
+ * With UMIP enabled (CR4.UMIP), SGDT, SIDT, SLDT, SMSW and STR raise
+ * #GP from user mode, and the kernel emulates them with dummy results.
+ * Probe this from secondary mode: SGDT yields the dummy GDT base only
+ * if emulated.
+ */
+#define UMIP_DUMMY_GDT_BASE	0xfffffffffffe0000ULL
+
+struct dtr {
+	uint16_t limit;
+	uint64_t base;
+} __attribute__((packed));
+
+static void sgdt(void *dst)
+{
+	asm volatile("sgdt (%0)" : : "r"(dst) : "memory");
+}
+
+static int prepare_umip(void)
+{
+	struct dtr dtr = { 0, 0 };
+
+	sgdt(&dtr);
+	if (dtr.base != UMIP_DUMMY_GDT_BASE) {
+		skip_reason = "UMIP is not enabled";
+		return -ENOSYS;
+	}
+
+	memset(static_buf, 0, sizeof(dtr));
+
+	return 0;
+}
+
+static void trigger_umip(void)
+{
+	sgdt(static_buf);
+}
+
+static int check_umip_result(const void *p)
+{
+	struct dtr dtr;
+
+	memcpy(&dtr, p, sizeof(dtr));
+	if (dtr.base != UMIP_DUMMY_GDT_BASE) {
+		smokey_warning("sgdt: base %#llx, expected the emulated %#llx",
+			       (unsigned long long)dtr.base,
+			       UMIP_DUMMY_GDT_BASE);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int verify_umip(void)
+{
+	return check_umip_result(static_buf);
+}
+
+static int prepare_umip_fresh_page(void)
+{
+	int ret;
+
+	ret = prepare_umip();
+	if (ret)
+		return ret;
+
+	return map_fresh_page();
+}
+
+static void trigger_umip_fresh_page(void)
+{
+	sgdt(fresh_page);
+}
+
+static int verify_umip_fresh_page(void)
+{
+	return check_umip_result(fresh_page);
+}
+
+/*
+ * A canonical kernel address: copy_to_user() rejects it right away,
+ * the emulation sends SIGSEGV without taking a page fault.
+ */
+static void trigger_umip_badaddr(void)
+{
+	sgdt((void *)0xffff800000000000UL);
+}
+
+static const struct trap_case arch_cases[] = {
+	{
+		/* do_int3_user() → do_trap() with sicode 0: SI_KERNEL. */
+		.name = "int3",
+		.trigger = trigger_int3,
+		.trap = TRAP_BREAKPOINT,
+		.signo = SIGTRAP,
+		.si_code = -1,
+	}, {
+		.name = "ud2",
+		.trigger = trigger_ud2,
+		.trap = TRAP_UNDEF,
+		.signo = SIGILL,
+		.si_code = ILL_ILLOPN,
+	}, {
+		.name = "div0",
+		.trigger = trigger_div0,
+		.trap = TRAP_DIVIDE,
+		.signo = SIGFPE,
+		.si_code = FPE_INTDIV,
+	}, {
+		/* gp_user_force_sig_segv() uses force_sig(): SI_KERNEL. */
+		.name = "gp",
+		.trigger = trigger_gp,
+		.trap = TRAP_GPF,
+		.signo = SIGSEGV,
+		.si_code = -1,
+	}, {
+		.name = "simd_div0",
+		.prepare = prepare_simd_div0,
+		.trigger = trigger_simd_div0,
+		.cleanup = cleanup_simd_div0,
+		.trap = TRAP_SIMD,
+		.signo = SIGFPE,
+		.si_code = FPE_FLTDIV,
+	}, {
+		.name = "vsyscall",
+		.prepare = prepare_vsyscall,
+		.trigger = trigger_vsyscall,
+		.verify = verify_vsyscall,
+		.trap = TRAP_VSYSCALL,
+	}, {
+		.name = "vsyscall_fresh_page",
+		.prepare = prepare_vsyscall_fresh_page,
+		.trigger = trigger_vsyscall_fresh_page,
+		.verify = verify_vsyscall_fresh_page,
+		.cleanup = unmap_fresh_page,
+		.trap = TRAP_VSYSCALL,
+		.nested = true,
+	}, {
+		/* The emulation uses force_sig(): SI_KERNEL. */
+		.name = "vsyscall_badaddr",
+		.prepare = prepare_vsyscall_badaddr,
+		.trigger = trigger_vsyscall_badaddr,
+		.cleanup = cleanup_vsyscall_badaddr,
+		.trap = TRAP_VSYSCALL,
+		.signo = SIGSEGV,
+		.si_code = SI_KERNEL,
+		.nested = true,
+	}, {
+		.name = "umip",
+		.prepare = prepare_umip,
+		.trigger = trigger_umip,
+		.verify = verify_umip,
+		.trap = TRAP_GPF,
+	}, {
+		.name = "umip_fresh_page",
+		.prepare = prepare_umip_fresh_page,
+		.trigger = trigger_umip_fresh_page,
+		.verify = verify_umip_fresh_page,
+		.cleanup = unmap_fresh_page,
+		.trap = TRAP_GPF,
+		.nested = true,
+	}, {
+		.name = "umip_badaddr",
+		.prepare = prepare_umip,
+		.trigger = trigger_umip_badaddr,
+		.trap = TRAP_GPF,
+		.signo = SIGSEGV,
+		.si_code = SEGV_MAPERR,
+	},
+};
+
+static void arch_init(void) { }
+static void arch_cleanup(void) { }
+
+#endif /* arch */
+
+/*
+ * Runtime state collection.
+ */
+
+static int read_faults(unsigned int faults[NR_TRAPS])
+{
+	char line[2048], *p, *q;
+	unsigned int val;
+	int trap, n;
+	FILE *fp;
+
+	memset(faults, 0, sizeof(unsigned int) * NR_TRAPS);
+
+	fp = fopen(FAULTS_PATH, "r");
+	if (fp == NULL)
+		return -errno;
+
+	/* Header: "TRAP         CPU0        CPU1 ..." */
+	if (fgets(line, sizeof(line), fp) == NULL) {
+		fclose(fp);
+		return -EIO;
+	}
+
+	/* The test runs on the first realtime CPU, we only parse its column. */
+	p = strstr(line, "CPU");
+	if (p == NULL) {
+		fclose(fp);
+		return -EIO;
+	}
+	rt_cpu = atoi(p + 3);
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (sscanf(line, " %d:%n", &trap, &n) != 1)
+			continue;
+		if (trap < 0 || trap >= NR_TRAPS)
+			continue;
+		p = line + n;
+		if (sscanf(p, " %u", &val) == 1)
+			faults[trap] = val;
+		/* Trailing label: "    (Page fault)" */
+		p = strrchr(line, '(');
+		q = strrchr(line, ')');
+		if (p && q && q > p) {
+			*q = '\0';
+			snprintf(trap_labels[trap], TRAP_LABEL_LEN, "%s", p + 1);
+		}
+	}
+
+	fclose(fp);
+
+	return 0;
+}
+
+static int trap_by_label(const char *label)
+{
+	int trap;
+
+	for (trap = 0; trap < NR_TRAPS; trap++)
+		if (strcmp(trap_labels[trap], label) == 0)
+			return trap;
+
+	return -1;
+}
+
+static void resolve_traps(void)
+{
+	const char *const *labels = arch_trap_labels();
+	int kind;
+
+	for (kind = 0; kind < NR_TRAP_KINDS; kind++)
+		trap_nr[kind] = labels[kind] ? trap_by_label(labels[kind]) : -1;
+}
+
+static int take_snapshot(struct snapshot *s)
+{
+	int ret;
+
+	ret = read_faults(s->faults);
+	if (ret)
+		return ret;
+
+	return cobalt_thread_stat(0, &s->stat);
+}
+
+static int read_file(const char *path, char *buf, size_t len)
+{
+	ssize_t n;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	n = read(fd, buf, len - 1);
+	close(fd);
+	if (n < 0)
+		return -errno;
+
+	buf[n] = '\0';
+
+	return 0;
+}
+
+static int write_file(const char *path, const char *s)
+{
+	int fd, ret = 0;
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -errno;
+
+	if (write(fd, s, strlen(s)) < 0)
+		ret = -errno;
+
+	close(fd);
+
+	return ret;
+}
+
+static const char *sigdebug_reason_name(unsigned int reason)
+{
+	static const char *const names[] = {
+		[SIGDEBUG_UNDEFINED] = "UNDEFINED",
+		[SIGDEBUG_MIGRATE_SIGNAL] = "MIGRATE_SIGNAL",
+		[SIGDEBUG_MIGRATE_SYSCALL] = "MIGRATE_SYSCALL",
+		[SIGDEBUG_MIGRATE_FAULT] = "MIGRATE_FAULT",
+		[SIGDEBUG_MIGRATE_PRIOINV] = "MIGRATE_PRIOINV",
+		[SIGDEBUG_NOMLOCK] = "NOMLOCK",
+		[SIGDEBUG_WATCHDOG] = "WATCHDOG",
+		[SIGDEBUG_RESCNT_IMBALANCE] = "RESCNT_IMBALANCE",
+		[SIGDEBUG_LOCK_BREAK] = "LOCK_BREAK",
+		[SIGDEBUG_MUTEX_SLEEP] = "MUTEX_SLEEP",
+	};
+
+	if (reason < ARRAY_SIZE(names) && names[reason])
+		return names[reason];
+
+	return "?";
+}
+
+/*
+ * The Cobalt watchdog is our safety net against a kernel which does
+ * not report a trap: the thread then spins on the faulting
+ * instruction on the oob stage until the watchdog relaxes it.
+ */
+static int setup_watchdog(void)
+{
+	char buf[16];
+	int wd, ret;
+
+	ret = cobalt_corectl(_CC_COBALT_GET_WATCHDOG, &wd, sizeof(wd));
+	if (ret || wd == 0) {
+		smokey_note("Cobalt watchdog not available, refusing to run");
+		return -ENOSYS;
+	}
+
+	ret = read_file(WATCHDOG_PATH, watchdog_saved, sizeof(watchdog_saved));
+	if (ret == 0) {
+		snprintf(buf, sizeof(buf), "%d", WATCHDOG_TIMEOUT);
+		ret = write_file(WATCHDOG_PATH, buf);
+	}
+	if (ret) {
+		watchdog_saved[0] = '\0';
+		smokey_note("cannot set the watchdog timeout (%s), "
+			    "a broken kernel takes longer to fail",
+			    strerror(-ret));
+	}
+
+	return 0;
+}
+
+static void restore_watchdog(void)
+{
+	if (watchdog_saved[0]) {
+		write_file(WATCHDOG_PATH, watchdog_saved);
+		watchdog_saved[0] = '\0';
+	}
+}
+
+/*
+ * Signal handling.
+ */
+
+/*
+ * Both signals of a case (SIGDEBUG from the relax, the fault signal
+ * from the in-band fixup) are pending on the same return to user
+ * space. The kernel dequeues the synchronous one first and stacks
+ * the SIGDEBUG frame on top of it, so this handler runs first, with
+ * the register state of the trapping instruction (minus what the
+ * kernel clears for signal delivery, x86: DF, RF, TF). Undo what our
+ * triggers enabled before touching anything else.
+ */
+static void sigdebug_handler(int sig, siginfo_t *si, void *context)
+{
+	arch_sanitize_handler_context();
+
+	in_sigdebug = 1;
+	if (nr_sigdebug < MAX_REASONS)
+		sigdebug_reasons[nr_sigdebug] = sigdebug_reason(si);
+	nr_sigdebug++;
+	in_sigdebug = 0;
+}
+
+static void fault_handler(int sig, siginfo_t *si, void *context)
+{
+	/* See above, and we never return to the interrupted code. */
+	arch_sanitize_handler_context();
+
+	trap_signals++;
+	trap_signo = sig;
+	trap_si_code = si->si_code;
+	trap_addr = si->si_addr;
+	trap_ip = arch_fault_ip(context);
+	trap_in_sigdebug = in_sigdebug;
+	in_sigdebug = 0;
+
+	if (sig == SIGSEGV && si->si_addr == ro_page) {
+		/* Page fault case: fix up and retry the access. */
+		mprotect(ro_page, 1, PROT_READ | PROT_WRITE);
+		return;
+	}
+
+	siglongjmp(trap_env, 1);
+}
+
+static void reset_trap_state(void)
+{
+	trap_signals = 0;
+	trap_signo = 0;
+	trap_si_code = 0;
+	trap_addr = NULL;
+	trap_ip = 0;
+	trap_in_sigdebug = 0;
+	nr_sigdebug = 0;
+}
+
+/*
+ * Helpers for the nested cases: a fresh anonymous page, which is
+ * guaranteed not to be resident when the in-band fixup of a trap
+ * accesses it. We run with mlockall(MCL_FUTURE), so the page is
+ * populated upon mmap() and we have to unlock and drop it explicitly.
+ * arm64 has no in-band fixups which access user memory for AArch64
+ * tasks, the helpers are unused there.
+ */
+static __maybe_unused int map_fresh_page(void)
+{
+	long psz = sysconf(_SC_PAGESIZE);
+	void *p;
+
+	p = mmap(NULL, psz, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED)
+		return -errno;
+
+	fresh_page = p;
+
+	if (munlock(p, psz) || madvise(p, psz, MADV_DONTNEED)) {
+		int ret = -errno;
+		munmap(p, psz);
+		fresh_page = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static void unmap_fresh_page(void)
+{
+	if (fresh_page) {
+		munmap(fresh_page, sysconf(_SC_PAGESIZE));
+		fresh_page = NULL;
+	}
+}
+
+/*
+ * Common test cases.
+ */
+
+static void trigger_pagefault(void)
+{
+	*ro_page ^= 0xff;
+}
+
+static int prepare_pagefault(void)
+{
+	return mprotect(ro_page, 1, PROT_READ) ? -errno : 0;
+}
+
+static int arm_kprobe(unsigned int offset)
+{
+	char path[128], buf[64];
+	int ret;
+
+	snprintf(path, sizeof(path), "%s/kprobe_events", tracefs);
+	snprintf(buf, sizeof(buf), "p:%s %s+%u\n", KPROBE_EVENT, KPROBE_TARGET,
+		 offset);
+	ret = write_file(path, buf);
+	if (ret)
+		return ret;
+
+	kprobe_armed = 1;
+
+	snprintf(path, sizeof(path), "%s/events/kprobes/%s/enable",
+		 tracefs, KPROBE_EVENT);
+	return write_file(path, "1\n");
+}
+
+static void disarm_kprobe(void)
+{
+	char path[128], buf[64];
+
+	if (!kprobe_armed)
+		return;
+
+	snprintf(path, sizeof(path), "%s/events/kprobes/%s/enable",
+		 tracefs, KPROBE_EVENT);
+	write_file(path, "0\n");
+
+	snprintf(path, sizeof(path), "%s/kprobe_events", tracefs);
+	snprintf(buf, sizeof(buf), "-:%s\n", KPROBE_EVENT);
+	write_file(path, buf);
+
+	kprobe_armed = 0;
+}
+
+/*
+ * Check how the kernel implemented our probe: only a breakpoint
+ * instruction traps, a probe hooked on ftrace or optimized into a
+ * jump does not. Returns 1 if trapping, 0 if not, -1 if unknown.
+ */
+static int kprobe_traps(void)
+{
+	char buf[4096], *line, *next;
+
+	if (read_file("/sys/kernel/debug/kprobes/list", buf, sizeof(buf)))
+		return -1;
+
+	for (line = buf; line && *line; line = next) {
+		next = strchr(line, '\n');
+		if (next)
+			*next++ = '\0';
+		if (strstr(line, KPROBE_TARGET) == NULL)
+			continue;
+		return strstr(line, "[FTRACE]") == NULL &&
+			strstr(line, "[OPTIMIZED]") == NULL;
+	}
+
+	return -1;
+}
+
+static int prepare_kprobe(void)
+{
+	bool armed = false;
+	unsigned int i;
+	int ret;
+
+	if (geteuid() != 0)
+		return -EPERM;
+
+	if (access("/sys/kernel/tracing/kprobe_events", W_OK) == 0)
+		strcpy(tracefs, "/sys/kernel/tracing");
+	else if (access("/sys/kernel/debug/tracing/kprobe_events", W_OK) == 0)
+		strcpy(tracefs, "/sys/kernel/debug/tracing");
+	else {
+		skip_reason = "kernel lacks kprobe support";
+		return -ENOSYS;
+	}
+
+	/*
+	 * An optimized kprobe is a branch, not a trap. Disable the
+	 * optimizer while we are at it (the knob only exists with
+	 * CONFIG_OPTPROBES).
+	 */
+	if (read_file(KPROBES_OPT_PATH, kprobe_opt_saved,
+		      sizeof(kprobe_opt_saved)) == 0) {
+		ret = write_file(KPROBES_OPT_PATH, "0\n");
+		if (ret) {
+			kprobe_opt_saved[0] = '\0';
+			return ret;
+		}
+	} else
+		kprobe_opt_saved[0] = '\0';
+
+	for (i = 0; i < ARRAY_SIZE(kprobe_offsets); i++) {
+		ret = arm_kprobe(kprobe_offsets[i]);
+		if (ret) {
+			disarm_kprobe();
+			continue;
+		}
+		armed = true;
+		if (kprobe_traps() != 0)
+			return 0;
+		disarm_kprobe();
+	}
+
+	skip_reason = armed ? "kprobe is hooked via ftrace, does not trap" :
+		"cannot arm a kprobe on " KPROBE_TARGET;
+	return -ENOSYS;
+}
+
+static void cleanup_kprobe(void)
+{
+	disarm_kprobe();
+
+	if (kprobe_opt_saved[0]) {
+		write_file(KPROBES_OPT_PATH, kprobe_opt_saved);
+		kprobe_opt_saved[0] = '\0';
+	}
+}
+
+static int kprobe_ret;
+
+static void trigger_kprobe(void)
+{
+	/*
+	 * A current-mode Cobalt syscall, i.e. it runs in whatever
+	 * mode the caller is in: in primary here. The kprobe fires
+	 * from kernel mode on the oob stage.
+	 */
+	kprobe_ret = pthread_setname_np(pthread_self(), "traps");
+}
+
+static int verify_kprobe(void)
+{
+	if (kprobe_ret) {
+		smokey_warning("pthread_setname_np: %s", strerror(kprobe_ret));
+		return -1;
+	}
+
+	return 0;
+}
+
+static const struct trap_case pagefault_case = {
+	.name = "pagefault",
+	.prepare = prepare_pagefault,
+	.trigger = trigger_pagefault,
+	.trap = TRAP_PAGEFAULT,
+	.signo = SIGSEGV,
+	.si_code = SEGV_ACCERR,
+};
+
+static const struct trap_case kprobe_case = {
+	.name = "kprobe",
+	.prepare = prepare_kprobe,
+	.trigger = trigger_kprobe,
+	.verify = verify_kprobe,
+	.cleanup = cleanup_kprobe,
+	.trap = TRAP_KPROBE,
+};
+
+/*
+ * Run the plain page fault case once more at the end: if any trap
+ * exit was missed before, the pending trap state suppresses this
+ * notification.
+ */
+static const struct trap_case pagefault_again_case = {
+	.name = "pagefault_again",
+	.prepare = prepare_pagefault,
+	.trigger = trigger_pagefault,
+	.trap = TRAP_PAGEFAULT,
+	.signo = SIGSEGV,
+	.si_code = SEGV_ACCERR,
+};
+
+/*
+ * Test driver.
+ */
+
+static bool name_selected(const char *name)
+{
+	const char *list, *p;
+	size_t len = strlen(name);
+
+	if (!SMOKEY_ARG_ISSET(traps, cases))
+		return true;
+
+	list = SMOKEY_ARG_STRING(traps, cases);
+	for (p = list; p; p = strchr(p, ',')) {
+		if (*p == ',')
+			p++;
+		if (strncmp(p, name, len) == 0 &&
+		    (p[len] == '\0' || p[len] == ','))
+			return true;
+	}
+
+	return false;
+}
+
+static bool case_selected(const struct trap_case *c)
+{
+	/* pagefault_again is implied by "pagefault". */
+	if (c == &pagefault_again_case)
+		return name_selected("pagefault");
+
+	return name_selected(c->name);
+}
+
+static int go_primary(void)
+{
+	struct timespec zero = { 0, 0 };
+	int ret;
+
+	ret = clock_nanosleep(CLOCK_MONOTONIC, 0, &zero, NULL);
+	if (ret) {
+		smokey_warning("clock_nanosleep: %s", strerror(ret));
+		return -1;
+	}
+
+	if (cobalt_thread_mode() & XNRELAX) {
+		smokey_warning("not in primary mode after clock_nanosleep()");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void wait_for_sigdebug(void)
+{
+	struct timespec ts = { 0, 1000000 };
+	int i;
+
+	/*
+	 * SIGDEBUG is pending at this point at the latest, but we
+	 * might have left the fault handler by longjmp, so the signal
+	 * is only delivered at the next kernel entry. We are in
+	 * secondary mode now, a plain Linux syscall does not switch
+	 * modes. If the trap was not reported, we are still in
+	 * primary mode and this syscall relaxes us, with a
+	 * SIGDEBUG_MIGRATE_SYSCALL our caller knows to ignore.
+	 */
+	for (i = 0; i < 100 && nr_sigdebug == 0; i++)
+		__STD(nanosleep(&ts, NULL));
+}
+
+/*
+ * Help diagnosing a missing SIGDEBUG: is it blocked, pending, still
+ * routed to us, and does the thread still ask for it (XNWARN)?
+ */
+static void report_sigdebug_state(const char *name)
+{
+	struct sigaction sa;
+	sigset_t mask, pend;
+
+	pthread_sigmask(SIG_BLOCK, NULL, &mask);
+	sigpending(&pend);
+	sigaction(SIGDEBUG, NULL, &sa);
+
+	smokey_warning("%s: SIGDEBUG state: blocked=%d pending=%d "
+		       "handler=%s XNWARN=%d mode=%#x", name,
+		       sigismember(&mask, SIGDEBUG),
+		       sigismember(&pend, SIGDEBUG),
+		       sa.sa_sigaction == sigdebug_handler ? "ours" :
+		       sa.sa_handler == SIG_IGN ? "SIG_IGN" :
+		       sa.sa_handler == SIG_DFL ? "SIG_DFL" : "other",
+		       !!(cobalt_thread_mode() & XNWARN),
+		       cobalt_thread_mode());
+}
+
+static int check_case(const struct trap_case *c,
+		      const struct snapshot *before,
+		      const struct snapshot *after,
+		      bool reported)
+{
+	int expected = trap_nr[c->trap], pagefault = trap_nr[TRAP_PAGEFAULT];
+	unsigned int delta;
+	int ret = 0, trap;
+
+	if (c->signo) {
+		if (trap_signals != 1 || trap_signo != c->signo ||
+		    (c->si_code >= 0 && trap_si_code != c->si_code)) {
+			smokey_warning("%s: expected signal %d/%d once, "
+				       "got signal %d/%d %d time(s)",
+				       c->name, c->signo, c->si_code,
+				       trap_signo, trap_si_code, trap_signals);
+			ret = -1;
+		}
+	} else if (trap_signals) {
+		smokey_warning("%s: unexpected signal %d/%d",
+			       c->name, trap_signo, trap_si_code);
+		ret = -1;
+	}
+
+	if (trap_in_sigdebug) {
+		smokey_warning("%s: signal %d/%d taken inside the SIGDEBUG "
+			       "handler, ip=%#lx addr=%p", c->name, trap_signo,
+			       trap_si_code, trap_ip, trap_addr);
+		ret = -1;
+	}
+
+	/*
+	 * If the trap was not reported at all, the thread was relaxed
+	 * by the watchdog or by our own syscall afterwards: SIGDEBUG
+	 * and the mode switch count carry no information in this
+	 * case, and the issue was flagged already.
+	 */
+	if (reported) {
+		if (nr_sigdebug != 1 ||
+		    sigdebug_reasons[0] != SIGDEBUG_MIGRATE_FAULT) {
+			smokey_warning("%s: expected one SIGDEBUG_MIGRATE_FAULT, "
+				       "got %d SIGDEBUG(s), first reason %u (%s)",
+				       c->name, nr_sigdebug,
+				       nr_sigdebug ? sigdebug_reasons[0] : 0,
+				       nr_sigdebug ?
+				       sigdebug_reason_name(sigdebug_reasons[0]) :
+				       "-");
+			if (nr_sigdebug == 0) {
+				report_sigdebug_state(c->name);
+				smokey_warning("%s: last fault: signal %d/%d "
+					       "ip=%#lx addr=%p", c->name,
+					       trap_signo, trap_si_code,
+					       trap_ip, trap_addr);
+			}
+			ret = -1;
+		}
+
+		delta = after->stat.msw - before->stat.msw;
+		if (delta != 1) {
+			smokey_warning("%s: %u mode switch(es), expected 1",
+				       c->name, delta);
+			ret = -1;
+		}
+	} else
+		ret = -1;
+
+	for (trap = 0; trap < NR_TRAPS; trap++) {
+		delta = after->faults[trap] - before->faults[trap];
+		if (delta != (trap == expected ? 1 : 0)) {
+			smokey_warning("%s: trap #%d (%s) accounted %u time(s), "
+				       "expected %d%s", c->name, trap,
+				       trap_labels[trap], delta,
+				       trap == expected ? 1 : 0,
+				       c->nested && trap == pagefault ?
+				       " (nested page fault leaked?)" : "");
+			ret = -1;
+		}
+	}
+
+	/*
+	 * The core accounts any trap with the number of the page fault
+	 * trap in the thread statistics.
+	 */
+	delta = after->stat.pf - before->stat.pf;
+	if (delta != (expected == pagefault)) {
+		smokey_warning("%s: %u page fault(s) accounted, expected %d",
+			       c->name, delta, expected == pagefault);
+		ret = -1;
+	}
+
+	return ret;
+}
+
+static int run_case(const struct trap_case *c, const char *prev_name)
+{
+	struct snapshot before, after;
+	bool reported;
+	int ret;
+
+	if (!case_selected(c))
+		return 0;
+
+	if (trap_nr[c->trap] < 0) {
+		smokey_note("%s: skipped (trap unknown to the core)", c->name);
+		return 0;
+	}
+
+	if (c->prepare) {
+		skip_reason = NULL;
+		ret = c->prepare();
+		switch (ret) {
+		case 0:
+			break;
+		case -EPERM:
+			smokey_note("%s: skipped (not root)", c->name);
+			ret = 0;
+			goto out;
+		case -ENOSYS:
+			smokey_note("%s: skipped (%s)", c->name,
+				    skip_reason ?: "prerequisites not met");
+			ret = 0;
+			goto out;
+		default:
+			smokey_warning("%s: preparation failed (%s)",
+				       c->name, strerror(-ret));
+			ret = -1;
+			goto out;
+		}
+	}
+
+	smokey_trace("%s", c->name);
+
+	ret = take_snapshot(&before);
+	if (ret) {
+		smokey_warning("%s: snapshot failed (%s)", c->name,
+			       strerror(-ret));
+		ret = -1;
+		goto out;
+	}
+
+	/*
+	 * No syscall may sneak in between the switch to primary mode
+	 * and the trigger, so set up the jump buffer first (saving the
+	 * signal mask is a syscall, fine at this point). Restoring the
+	 * mask on longjmp matters: the fault handler may be entered
+	 * while the SIGDEBUG handler is running, i.e. with SIGDEBUG
+	 * blocked. longjmp leaves the altstack without further ado.
+	 */
+	if (sigsetjmp(trap_env, 1) == 0) {
+		ret = go_primary();
+		if (ret)
+			goto out;
+
+		reset_trap_state();
+		c->trigger();
+	}
+
+	/*
+	 * A reported trap left us in secondary mode. Still running in
+	 * primary mode here means that either no trap was taken at
+	 * all, or the kernel handled it without telling the core.
+	 */
+	reported = !!(cobalt_thread_mode() & XNRELAX);
+
+	wait_for_sigdebug();
+
+	if (!reported) {
+		/*
+		 * The syscall above relaxed us, so a fault signal the
+		 * in-band fixup of an unreported trap queued has been
+		 * delivered by now. None at all means the instruction
+		 * did not trap in the first place.
+		 */
+		if (c->signo && trap_signals == 0) {
+			smokey_note("%s: skipped (instruction did not trap "
+				    "on this CPU/emulator)", c->name);
+			goto out;
+		}
+		smokey_warning("%s: trap not reported to the core, "
+			       "thread still in primary mode%s%s%s", c->name,
+			       prev_name ? " (notification left pending by "
+			       "the preceding case '" : "",
+			       prev_name ?: "", prev_name ? "'?)" : "");
+	}
+
+	if (take_snapshot(&after)) {
+		smokey_warning("%s: snapshot failed", c->name);
+		ret = -1;
+		goto out;
+	}
+
+	if (c->verify && c->verify())
+		ret = -1;
+
+	if (check_case(c, &before, &after, reported))
+		ret = -1;
+out:
+	if (c->cleanup)
+		c->cleanup();
+
+	return ret;
+}
+
+static int run_fork(void)
+{
+	int status;
+	pid_t pid;
+
+	if (!name_selected("fork"))
+		return 0;
+
+	/*
+	 * Fork from the thread which took all the traps above: with a
+	 * debug kernel, an unbalanced trap entry is caught by the
+	 * core at this point (inband_task_init()), check dmesg.
+	 */
+	smokey_trace("fork");
+
+	pid = do_fork();
+	if (pid < 0) {
+		smokey_warning("fork: %s", strerror(errno));
+		return -1;
+	}
+	if (pid == 0)
+		_exit(0);
+
+	if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status) ||
+	    WEXITSTATUS(status) != 0) {
+		smokey_warning("fork: child did not exit cleanly");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void *rt_thread(void *arg)
+{
+	static unsigned char altstack[ALTSTACK_SIZE] __attribute__((aligned(16)));
+	stack_t ss = {
+		.ss_sp = altstack,
+		.ss_size = sizeof(altstack),
+	};
+	const struct trap_case *cases[MAX_CASES];
+	const char *prev_name = NULL;
+	unsigned int i, n = 0;
+	int ret;
+
+	/*
+	 * The fault handler must not run on the stack of the trapping
+	 * context, which may be unusable (arm64 sp_align).
+	 */
+	if (sigaltstack(&ss, NULL)) {
+		smokey_warning("sigaltstack: %s", strerror(errno));
+		failures++;
+		return NULL;
+	}
+
+	ret = pthread_setmode_np(0, PTHREAD_WARNSW, NULL);
+	if (ret) {
+		smokey_warning("pthread_setmode_np: %s", strerror(ret));
+		failures++;
+		return NULL;
+	}
+
+	cases[n++] = &pagefault_case;
+	for (i = 0; i < ARRAY_SIZE(arch_cases) && n < MAX_CASES - 2; i++)
+		cases[n++] = &arch_cases[i];
+	cases[n++] = &kprobe_case;
+	cases[n++] = &pagefault_again_case;
+
+	/*
+	 * We are in primary mode now. The first Linux syscall below
+	 * relaxes us with a SIGDEBUG_MIGRATE_SYSCALL, which we don't
+	 * care about: the per-case accounting starts after the
+	 * explicit switch to primary mode.
+	 */
+	for (i = 0; i < n; i++) {
+		if (!case_selected(cases[i]))
+			continue;
+		if (run_case(cases[i], prev_name))
+			failures++;
+		prev_name = cases[i]->name;
+	}
+
+	if (run_fork())
+		failures++;
+
+	return NULL;
+}
+
+static void setup_sighandlers(bool install)
+{
+	static struct sigaction old_sa[NSIG];
+	struct sigaction sa;
+	unsigned int i;
+
+	if (!install) {
+		sigaction(SIGDEBUG, &old_sa[SIGDEBUG], NULL);
+		sigaction(SIGSEGV, &old_sa[SIGSEGV], NULL);
+		for (i = 0; i < ARRAY_SIZE(arch_sigs); i++)
+			sigaction(arch_sigs[i], &old_sa[arch_sigs[i]], NULL);
+		return;
+	}
+
+	memset(&sa, 0, sizeof(sa));
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = sigdebug_handler;
+	sigaction(SIGDEBUG, &sa, &old_sa[SIGDEBUG]);
+
+	sa.sa_flags = SA_SIGINFO | SA_NODEFER | SA_ONSTACK;
+	sa.sa_sigaction = fault_handler;
+	sigaction(SIGSEGV, &sa, &old_sa[SIGSEGV]);
+	for (i = 0; i < ARRAY_SIZE(arch_sigs); i++)
+		sigaction(arch_sigs[i], &sa, &old_sa[arch_sigs[i]]);
+}
+
+static int run_traps(struct smokey_test *t, int argc, char *const argv[])
+{
+	struct sched_param param = { .sched_priority = 1 };
+	unsigned int faults[NR_TRAPS];
+	pthread_attr_t attr;
+	cpu_set_t cpus;
+	pthread_t tid;
+	int ret;
+
+	smokey_parse_args(t, argc, argv);
+
+	ret = read_faults(faults);
+	if (ret) {
+		smokey_note("cannot read " FAULTS_PATH " (%s)", strerror(-ret));
+		return -ENOSYS;
+	}
+
+	resolve_traps();
+	if (trap_nr[TRAP_PAGEFAULT] < 0) {
+		smokey_note("trap labels in " FAULTS_PATH " not recognized");
+		return -ENOSYS;
+	}
+
+	ret = setup_watchdog();
+	if (ret)
+		return ret;
+
+	arch_init();
+
+	ro_page = mmap(NULL, sysconf(_SC_PAGESIZE), PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (ro_page == MAP_FAILED) {
+		ret = -errno;
+		goto out_arch;
+	}
+	*ro_page = 0;
+
+	mlockall(MCL_CURRENT | MCL_FUTURE);
+
+	setup_sighandlers(true);
+
+	CPU_ZERO(&cpus);
+	CPU_SET(rt_cpu, &cpus);
+
+	pthread_attr_init(&attr);
+	pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
+	pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
+	pthread_attr_setschedparam(&attr, &param);
+	pthread_attr_setaffinity_np(&attr, sizeof(cpus), &cpus);
+
+	ret = pthread_create(&tid, &attr, rt_thread, NULL);
+	pthread_attr_destroy(&attr);
+	if (ret) {
+		smokey_warning("pthread_create: %s", strerror(ret));
+		ret = -ret;
+		goto out_sig;
+	}
+
+	pthread_join(tid, NULL);
+
+	ret = failures ? -EFAULT : 0;
+
+out_sig:
+	setup_sighandlers(false);
+	cleanup_kprobe();
+	unmap_fresh_page();
+	munmap(ro_page, sysconf(_SC_PAGESIZE));
+out_arch:
+	arch_cleanup();
+	restore_watchdog();
+
+	return ret;
+}
+
+#else /* unsupported architecture */
+
+static int run_traps(struct smokey_test *t, int argc, char *const argv[])
+{
+	smokey_note("no trap cases implemented for this architecture");
+	return -ENOSYS;
+}
+
+#endif /* unsupported architecture */
-- 
2.47.3

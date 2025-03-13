Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29821EE028
	for <xenomai@lists.linux.dev>; Thu, 13 Mar 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860775; cv=fail; b=Gs775F59HEQd7uN/X2qkPXdM2+v2HqHf7M4h6JpuKMCPzeM8OgxZRz/m7/Mu3H8Vu5LRmNXlqleEKkClJTDgi1uqsVjp10uzLSH/6TTsX2Z/ELxE/Q0vzWrwXKiqIvLAd8pCrc1uayexlmGDH0Cqt1oSfEYbqjaF8ql7sDWXhyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860775; c=relaxed/simple;
	bh=VZVPpOUV5lMpaLqjU/diEm8zuZk3WYSC0ECO9UmBS4o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mNLmulc/BN+4etBNwaqFarmI/EJE/U9vr+46wUdGH/qZ7AksPQi8z/nZyqVnpof4sIXk/2isH3ddKT0NGmOdnZD3CRsxPEyxkZoymKetN3i3qKK39nVevQ3x1I8KsD8QKDm7M0atyIUH9dqz6BBkA8+MfrLrkH6e9JnEWs9bUj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XI1vFCFq; arc=fail smtp.client-ip=40.107.103.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XI1vFCFq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ek7eGyLLbd65lq6n/I5opQ7Abb9JXMp2FctVST2+i4RCPVxeLXxJ50gORxTL4wkrZKP8+8HFXB4u0shwWw2WSqRRdCAZzH4QsZ+YLQqZXoqj7v699ps54zz2jJI1yBAPpR1eRUIUK6kF8Lb5luZy0+4bKrk1fF47pMEo9/QTSHUq6m2oo+0QvhasqaHtkXG9iZUlaeXxEDmtXK3inQKYLSaiuWY81ujDK179XgulL6fXKwFlSMhSGO18iwtpiZYLjHZGGyKL+vkx0Zb9VVl0PfZPZetof4/8j9NUr/hGZMQbXzul6B1VepCZR5qZDO1fQVebEUUPEPKvhgfAsLyQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGMlQFYarjk0Q7uQLoHawcvETmnh18qczbAya2CAiFI=;
 b=Qtnpn+zEmJ+7lhmMYLVJH4AFksnY7ITh7lxNlzi4tCClzDCCvVLr796HrGHnnFLEc4WX7CJ7nuzJpsAuJSghrbfttKNF1miWwtkLaCUl/7/X+LIK1qIVogFtmAPt+agHsluW69nhBPIykwHj6/pKPpD7h1IW4pAcxfu3ByAh13VoExnOx4VxsXquryZPkGpqN5Q45z9pNG21mMCmFpG63Uu8QFqkKrefPAmjBXUNdC863UiBjyr0mg5Uyf8Gfd13K4xC1aIVgHfHawAhoE5Xi4lwoTFB8TEP4jwtQS/1ItHQZxsG28Se+nSCvCPnuMiw/u+NqW26H2ITuXFu5ezu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGMlQFYarjk0Q7uQLoHawcvETmnh18qczbAya2CAiFI=;
 b=XI1vFCFqp1q4DTmEm+BByk9uP4uWcsxZdc++XSgO/CW7pHmUPJzLXTAHbEFIA7jwTHBUMQGI7gJWI9mfoSiT2bryr+2xtADBhTVBaSGHqIxty2hU0tvhlClehaDPq+sJCvKVfsz2mJJVgRZgpylRiCy4Q/5BRaub7XeLsWb4XlFDSeAuMZJwzdqEizzygp1TrcKJsEHKGGVa4vQowpadgaxX9b7idvd5nzcwxscGBGWENhCQyTC9BNgQtbWMOPRjMzZVGKPRp25h5TtxhryfEqcge6qU0gkli+KIxmSivpfOeJNPaAFbb9scZKvLm8SssmRQ+Yjzx9VPl3zcKrEbMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 10:12:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 10:12:49 +0000
Message-ID: <40972b4a-6c70-4124-88fa-0ca94ee877d8@siemens.com>
Date: Thu, 13 Mar 2025 11:12:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Dovetail] arm64: fpsimd: dovetail: Allow preemption of
 in-band fpsimd kernel sections
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: powertree <powertree@163.com>, Philippe Gerum <rpm@xenomai.org>
References: <20250219141759.2455053-1-florian.bezdeka@siemens.com>
 <0bb1b226-2fab-4aa5-b461-dbe7a2dced3c@siemens.com>
 <229ffe8510fc826ff4df0aa0b183da216d2d253b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <229ffe8510fc826ff4df0aa0b183da216d2d253b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c45f50-93e3-482e-9f6e-08dd62179bc3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXlNUGtsekp4SUE3aHhXOVdOdmFPSGlDZ01laEE5OHQxQXZ3NEdsbXpFdU5y?=
 =?utf-8?B?anRGbnhXZE5QcnB6bnRwR1JtQWhIM0lidlBMcDhLb25jdWxRcmN1Z3dOM0ds?=
 =?utf-8?B?Rkt5ckh6M0gxc0d6VnlHMUlta2o4VDltb054QkZvRFJQdWREWmg4M3cxWkxO?=
 =?utf-8?B?MzUxOWtyRXI3YXpOVi94S1kyK0xHKzhVUngvODBOZFpWbHV1dlUvMG1CR2tO?=
 =?utf-8?B?WVZZNzNHUmtSOE5LanlkZ2pRYjNCcUhXeWY5VUdzczlqRWNFY09FTGZiYm5V?=
 =?utf-8?B?RjVYOFZTanZWNUFhcUFuM25nWGtQL1QxRmkvYnJEdEZpYngra3B1ZTdtSHJ4?=
 =?utf-8?B?SHh6d3pEdlhzc0NucnBuRU9qZGROSUp1dXdFdkg5Nk9nbzdPUC9Ib3J3WjBa?=
 =?utf-8?B?N2hVRUVJdWdHaUtsM3ZHWTlDay95NmJReUhRMWE0d1hSYUs1aG1OMW9JTlJQ?=
 =?utf-8?B?Ni9tWnpmRzk3SVdURXo1TEFDdnZPMUU3R2tPVDFXRHkwZi85eERGbVVDSE9K?=
 =?utf-8?B?bkgxQ2JHWGtNTmplc0wrNUJQQkl5clJmejVCVGsxaUpNNGhXUlkxNHBZRkgy?=
 =?utf-8?B?bWhlRC9qVmRLNitDT2Q2S0NoK3c5dVVBa2hSejRtRUpVYzJ6dVBMZEh1by8w?=
 =?utf-8?B?blBjNVhMY0QyMXBYR3JjaWNhZlgvWTNGS0c0WTEvTHl1T3YyZTFuV256anhY?=
 =?utf-8?B?L0Y4ZkRNOWFKQUlzSHdVRzdZREdZVzFrbTlSWU8wbDgvMkljekpibnFpQmgv?=
 =?utf-8?B?WC9WZ3BCUlhrRmhBanZqeWNJZHFTNkpMWHNOSFVFdWRkZHVRSzJsM0JYUDJX?=
 =?utf-8?B?RzlIZjFGVUJKckJ2a3IzdEgwS3Z5akFuMlRKQm94VVZJRUYybllwdWFpOG9W?=
 =?utf-8?B?eXJ6cjVTd2NBU1IxMmd5SzRvbTErb1BkcnhwSHZqVm81d3lQTDBsS2hlbmFj?=
 =?utf-8?B?c3VxVHp3RS85aXNSSVczUTZtZXo2THJhZWVORThGQWpRc1VnalJaYTVxWjM2?=
 =?utf-8?B?UUlxR1FFQXUydGlKaWRFNENUTDV1cUhRVHZzbUdyWkhOM1VPNWc5cGhDTDBR?=
 =?utf-8?B?V05yMXhjazBXU0VLY1FnY0Y5Sjdqem9oaS9QR3dhT2tYTzNZeGowaCtabmVM?=
 =?utf-8?B?ejdGenVDb0wyLzN6dFBsS1pISmlBckE4NHhXcTgvTmw0WjlwQ3BYRXdpcXAv?=
 =?utf-8?B?V1FlMTNOU2pPWmN3Mkxsd3lJVjQ2eFZPVzc0elZCeDhwVS8wb01XdGpnUmg2?=
 =?utf-8?B?UStGcktTR1NLa0U0SFJ4c0ZKVDFJcmJvQ2cxNTJTSGk0S0pSeWJrSGx3YXZz?=
 =?utf-8?B?SDE3bkdCQ3gwNHdOdW16eWwrR1JrZThXSDFHdVRFMFh1M0Ivcm11N0pmMDBi?=
 =?utf-8?B?Z1NQcjBJbVJoRUJNcURtblhrWnV0NjA4UTllQmg1WEVHeG9JaFBjV2lpY0NB?=
 =?utf-8?B?cUJZRWxTTlAvK2VzazFOaTBYUmxDeVVHSXFnUkNRajZzUEtrZ05JSUVmVnFO?=
 =?utf-8?B?S0hKS0dFd0JkSGhQam5McVdwdTVFU3MxaGlLQkJ5RUhpR3hFdDRlT0dUczMw?=
 =?utf-8?B?cG9wZ1lHZnFReFZtczBaRjI0NlRMVk9ZUlpDdy9LWGVpSStUam5DWlRMbWRJ?=
 =?utf-8?B?b2VJaHB0YUtoR3hkd3hwbVNSaU1nK0s5emFiRzN2Skt6OGtxYUpkelRna1pK?=
 =?utf-8?B?RXltUkRHTk10Q2sxYjhDN1ZKdkx2Y0Mrb3JDenN2OGNYTVN1SkM5cGM3Y0kx?=
 =?utf-8?B?WXd4cmJOMFc2eTJEZThXQUxlU1B5aXJKeG5yZW4reStCQWExNEszMHg1S1hQ?=
 =?utf-8?B?VGRsbXdRQktnSjE0NC9CWmkrU2VsWkM5L0ZqTDJLTitSWmdOcjNyTVJHVjg3?=
 =?utf-8?Q?H1Xjwokt/OJJx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUNDenlEaWIvUFh6VHNtQ1ZJaUdkb2lnbGpoLzA3c2FtMHZxVFloMTdvNW4x?=
 =?utf-8?B?ck9jRzVXZFhheDBaQTZtTi9Fa3RWM2xTSzUwbmxLNVVCUHp0UmNVbW1tK0ts?=
 =?utf-8?B?MGk4ZmNaMi9ZU1VQbnMzQnFOQnk1QU8rOUVCb2srZjdNekdRUUh4ek5Dekxr?=
 =?utf-8?B?c1FlSmNxaUJLSUJxRVJ0WFNLOUxrOGJGUXk3WEgrRXRJMk5YMVVBZ1hRZVkr?=
 =?utf-8?B?S2xhMkc0M2Z4R1o4RXZSUC9ORlFlNEcwYk5jNnJ3NTlLeW9OcVZqSXVxRFlC?=
 =?utf-8?B?WEJjRm15QnJ1cW1Tb2o0UkhKT3dPTDV3ZWFCekJvYldhUXJKRUlsV1ptbFZK?=
 =?utf-8?B?eVRGWXpEcG9JdVBnYjJBN0g0Z0I3dElXS2l2aFNFQ3VmcTFVbGRXdy9ZSFMw?=
 =?utf-8?B?d254Q09FTTZ5alhkWFE1eWtGblhwaFRTNjNrTGhkeTVLZ3Y0V2daWXFRSklF?=
 =?utf-8?B?UmpRc0srTnZiZEVPMEcvVGNVSjlWUWRXQkNuNnBNSUI2Q0x3czJ0L1hvd0JE?=
 =?utf-8?B?dFhVWU1TTjFuR3dhcDBZcjJsTVhRUURwcCtHdzVtUVZZVjZBUE9LVnRFUk1Y?=
 =?utf-8?B?VGhOakJNdUw4alhhYkw3OEJ6NkZIZWVKdFZuMlJ0MzdWMXN3WGhxTkwrWnds?=
 =?utf-8?B?WlJJNW5qd0V6TXEyc3YwR1hLWHU0Z1hvanZJcTJDdkFQQ0U1RGt6UDZjOHBZ?=
 =?utf-8?B?d3AzYzBSWU53UnRScEEvU1VvZjdCYkhla1pMMm1QN25WeHU3eDhsb1p6RHZx?=
 =?utf-8?B?VDVWeVRTbW8xT0IyNU10dnp6UXBYb0tmMTRCYkIrQ2ZMZkw5UFJlM29iTEQy?=
 =?utf-8?B?NFNrdzBlWEpNTlBvNmx0V2UrSEk4Zm5UbjlrNEZuZVhRT05wZkx3bUtLVG1V?=
 =?utf-8?B?VEpVUWxyRTZpbnk3T003aDNYRXlzc29VN05oV1d5OTFJQ1VocXhyL0ZMemoy?=
 =?utf-8?B?U2xYTWU3QllIMFIyWHNZWjdyWVNzRXVQNndtSVdaRGZweUVVZkVFTlUrNzdr?=
 =?utf-8?B?Snk0bVlwcmU4WXBGTUtKMjRWTUp6MzNNRGlQbWxRL1ZjTXR0WjRBaDdIQXR3?=
 =?utf-8?B?ckNLSjdMRkJZbmVQSWtxTjYrL1JjdFl2ZVBHTkpDWXV3bTZBcXBRTTUxUlVm?=
 =?utf-8?B?S3NKQjdna1dRdyt4NWkwT3QyWDFlRU5WYkNjbVg3RjlGRENnZUhvenpXM1NO?=
 =?utf-8?B?YitlTzhuV0lybGVTK053ZU1iS1VmeTdNa1ZOaXB5S1BEb3N4dDB4MWRMSHVI?=
 =?utf-8?B?WVZUUHhsS1ZkN09GZjZKci9kd0drT25haEQ2c29IYmNiVUExVFBVYlFYaTJ4?=
 =?utf-8?B?bzB0SUF2RVJvVURlK3BRNXhNVVdxVlE4TUJIa3pLZ0taN0RoZ1Mrenk3SHVo?=
 =?utf-8?B?V3VtckNDaWlrY3VnOG4xV1IrY3FNTUhFSkMzWXRJT2ZoZWxsejZHdUpDbHZl?=
 =?utf-8?B?a3lVMldUNDh0VEd2ckRWSmRtR3djVU1wcS9vQTRMRnpGT1VUNDFwUEE2UFZh?=
 =?utf-8?B?WHdWTHRScDBBOVZuSXc0L0QrbWZ4eXR4UFdFRGJXYkt1K3lCYThmZTJTV3Rk?=
 =?utf-8?B?V2UvNEsxWndocU0rSlZ5cEpaNks5MkxvVlRBUVQvdFNBTlREZCtKUU1RdGQy?=
 =?utf-8?B?NmxENHk3L28vTW5ybEkyTnhnWUdleXU1SXVBL2RuUGwyMFZ1R0t1cFBuVFFO?=
 =?utf-8?B?U3hhQ1hSdTdBcVpFVEEzUDVFOEYxeE9YV0FNVW0vNEp4Q3NUNDd4OExFNUJh?=
 =?utf-8?B?SEFNUGJZdlh2TmhQVGNIMTFmVjdRQzl4N1UvZ2ZHQjczN3dtZGhjcUIrRCth?=
 =?utf-8?B?KzlvcGpFNCtqMS83dTZrbktVUkFPbVU1TVYzOXo5SnRjc2JLKzlDQ2Z1SVc2?=
 =?utf-8?B?RFZBVlUrYWxNcjN5L3VWNVRESWtKaHYwdDgrR1IxSkJueUhZNmI0TjJxZlNx?=
 =?utf-8?B?dkdJNkFBSW1NcVhKZ2d0SXNCQm9odDlhT0RUMzVLTTJTYkNQZDVvakR0TXJD?=
 =?utf-8?B?VzZmZ0wxbmFRUVFnY3B2ZHVTd0lmOHdqUmpVZzdEV2N6V1FtTUtwR3AyU2xI?=
 =?utf-8?B?dkY2WGhnSE1WOHI3dXRsNDFLdkphK3ZpM1FENkFpaXFVS1NPSEZKcG9iOXZM?=
 =?utf-8?B?aEtqL2VKUHU3WVNJRTlGQ1g1dU5hTnJhWkxNWTB4V3VxcWFReWQrZFc4K2p5?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c45f50-93e3-482e-9f6e-08dd62179bc3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:12:49.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZzfhj4h/pKEcgglorFhICsA1RtWYewa0NSKCGRahWk4VzCmzWMGDea1he9GSBPD/r0aTZNxgLFm5n4cnwHiaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8906

On 13.03.25 09:55, Florian Bezdeka wrote:
> On Thu, 2025-02-20 at 12:36 +0100, Jan Kiszka wrote:
>> On 19.02.25 15:17, Florian Bezdeka wrote:
>>> Preemption of in-band in-kernel fpsimd sections was not allowed /
>>> properly implemented in Dovetail up to now.
>>>
>>> That piled up again as some crypto code was optimized for arm64 in
>>> Linux 6.14. A possible call stack that makes clear that the FPU was
>>> corrupted follows. The inband stage was using crypto/FPU code inside
>>> the kernel and got interrupted by OOB.
>>>
>>> 	[  331.703695]  task_fpsimd_load+0xd0/0x214 (P)
>>> 	[  331.703713]  fpsimd_restore_current_state+0x9c/0xb8
>>> 	[  331.703732]  fpsimd_restore_current_oob+0x1c/0x2c
>>> 	[  331.703751]  dovetail_context_switch+0x90/0x180
>>> 	[  331.703769]  pipeline_switch_to+0x10/0x1c
>>> 	[  331.703792]  ___xnsched_run+0x1bc/0x29c
>>> 	[  331.703811]  run_oob_call+0x98/0x17c
>>> 	[  331.703830]  handle_irq_pipelined_finish+0x1e0/0x1ec
>>> 	[  331.703848]  handle_irq_pipelined+0x58/0x6c
>>> 	[  331.703865]  call_on_irq_stack+0x24/0x4c
>>> 	[  331.703884]  do_interrupt_handler+0x150/0x178
>>> 	[  331.703902]  el1_interrupt+0x44/0x11c
>>> 	[  331.703921]  el1h_64_irq_handler+0x18/0x24
>>> 	[  331.703941]  el1h_64_irq+0x6c/0x70                <- oob
>>> 	[  331.703957]  crc32c_le_arm64_4way+0x4c/0xc0 (P)   <- inband
>>> 	[  331.703978]  ext4_block_bitmap_csum_set+0x38/0x60
>>> 	[  331.704002]  ext4_mb_mark_context+0x1b0/0x398
>>> 	[  331.704025]  ext4_mb_mark_diskspace_used+0xd8/0x1f8
>>>
>>> To fix that we have to hook into the task switch as we do on x86 and
>>> invoke the FPU (re)store logic.
>>>
>>> Cc: powertree <powertree@163.com>
>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>> Cc: Philippe Gerum <rpm@xenomai.org>
>>>
>>
>> Great!
>>
>> Did you already check how easily it applies to older (but maintained)
>> dovetail kernels?
> 
> Philippe already picked it into v6.1.y-cip-dovetail-rebase, so I think
> the only remaining branch would be 5.10, right?
> 

Ok, will have a look at that (and any other pending backports) later.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

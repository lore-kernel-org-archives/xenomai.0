Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570827EFE9
	for <xenomai@lists.linux.dev>; Wed, 12 Nov 2025 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935790; cv=fail; b=JVQDtNwIFKUvTP3O9ZwCNdkBRtnpQqjRXoQobgOqb29CqCi21+UJxwu4iHc37DCxGGmlQW4Gvyt515Y8DNtI+04NUS/XUSHfU3qrT6N6+yntw3ZQAS1fbbI22wX287i/XKy20l89Z9XuKDqaworXIOEPu13RXlPLpiWmrEcxLsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935790; c=relaxed/simple;
	bh=9DSEfPSVOmSO0/dB7zc1jH37s98HM8HCJFoMhigjDws=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrV2mTAa4nvRfHVtCCFyBRN/QFpxBn1OYjABnI+Kpb+esZY3ktB6kB0x4lNGT5i/BwMixsbjXygxXXmIhCKOJP4Wf625bHQt+0vt44qGUWuh9ZC8sWvxYeMjTNtomxrKA2KNZDK21tDgNuMbpZtZ8vtbU+w/XvSXx1OdHuoQduc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dhLY3Lvn; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dhLY3Lvn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrl4ZVuS/8aDqjaZ8nsZmpivy3OmCv1cO8v49MbayGfOvWStb4Z0jL3jDqHS0bUGBWZWKx+FznClwMX5cJbdNrItrQy7gqZ5HziUg1c3/A/+x0g5J8JE5vwyphEZ1tGzBZ6x+5uOj8t16bj+rFFU+ANZmBTpxiPzrlE6usyLacO1kA+s0c5Pja8Y/qsoTEh/nKrDZjhUlBT019z81LS+46TPjvkqQmH5HegonKDSLS5jiqRX/M/bnpoL7WFxaFEtUTQLUCf/FYMg1I/gUN2ts7KHvddRd4A4nLy2MVhcIVRynaMQbRwpaboOd9DoLZMnDk9lUsqjIsW6W4blU2JhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYLEBlw87TN16b0f+dl/HC8i/EKloo77WkDouKsWyXM=;
 b=ikLTiK0nBI5NgOoE20EcH4BawwHQCopac/21ZOg08xXHvTX9KPQvEWjq5BDV/n3ivWW8aRSRMTEiom7l8lUC/3Whq6eYV3vI9RWnETMqTeW8U9CcgtfvrTb893xZf5IyK79xjQWuvstfR/IPrqz/Ed7v9ezLkZ0/MgpuuwG23RBhmwn8CP2x2ytiyeePkVTmKhyBj4/5+lDKRr4G9JKlt7uviWDOnw//wBdjUQPBpVXc8wy4e94vGsUrpjy3XOtw1douVSZVJ7SO7NEYQ85Z8GN/BYissy0lYEy8rN+AckrGS5KdhMFEtpkbwRBkq2Zg9wRkvCTWYGv7GzN56RD99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYLEBlw87TN16b0f+dl/HC8i/EKloo77WkDouKsWyXM=;
 b=dhLY3LvnNUTuh2iOAq++U/mS23TdR8BsmuYe3c6YHeS46QtIjQxg15sxizFwiLp0gPAJneeqe3dmCAq1oUGyW7QY/eq99CDXJksyEA7t7El2sQEnzxHPF1VJNbtCnT8nnnqY+BVwJ7mDxCe1yyll8vdhfSV2dixGMmCNj6onidnXysG7nkH8yLqyRBiRyeb0nu5OQLkpYph/XEylnsnGa5GsVvVXVFNDSZR7l2FF3FlgVccNovOzpTQU3RBT3T/6STSMD3dlUCEW6ToIc0DHLU6s1ABV27pA9dU6pPL3BM7X9fgOpuKgSYKYbuoogKQs3ndDID4GZLBCO8MqsQu4wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 08:23:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:23:04 +0000
Message-ID: <d14c720e-021e-4fc8-8aba-340903db0fdf@siemens.com>
Date: Wed, 12 Nov 2025 09:23:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: schedule delay 15ms
To: JerryJun <jerryjun123@163.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <4c6fa8a7.4dce.19a76af1422.Coremail.jerryjun123@163.com>
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
In-Reply-To: <4c6fa8a7.4dce.19a76af1422.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb1ab71-48de-4bd4-8046-08de21c4b369
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUNHZkR5QndlTkYzR1dMRkNNa3ZpYWdzczljeWtXL2xJVWU5Rm1kNzBtYXJ2?=
 =?utf-8?B?aUtudEZWOFhtNjdpblIyWmlTRUlPeW5UeURkUDRQYUJUK1pKQTZ1MXNKMURu?=
 =?utf-8?B?cmpKTmEyUldoTWhmN01ZQ0xOSkw0QVcxYmx5RmVwUGpFQVprdGF3YTlwdThW?=
 =?utf-8?B?azQySTROdzlyVkNGRTBUQ0d4SjhnWWFLOWpnczIzOGZHSDNmeFZTaTJlUnpN?=
 =?utf-8?B?YjhsZm5WUC9UZ2Q1YW5iT1I3K2xEVEFHRjhhb2RKYWF4RkFLZ1VrNGswSXdk?=
 =?utf-8?B?VGZyZ0kwM25UTFRLVGVGZm5uQkRuYjVnc2ZPY2xCcWN2U0s3SEtzQm5NNG5H?=
 =?utf-8?B?VkhOZDE2VGdFdjlYSHNSeWJCM00zeWw3ZEp1N2o2enJOb1kvS21sM0xkNWdS?=
 =?utf-8?B?SHk4TnRPQ0c3QTJIRE02WnBoQnZEaEVxUGsvcm83b043WUoxODd5RE5CVmd4?=
 =?utf-8?B?dDNPSy9QaEtTVmZDUStZSGFveEcrekRBVVE5RU1aSmVxNVpkUjBmS1NGdW1J?=
 =?utf-8?B?U2E1RUkwbnFjMzljQUlRRml4R2syeXNSWDZHR1dVZjF5aHhSR3dCUFhFSWFX?=
 =?utf-8?B?NmRLaTB2a1pVbExRQ0xpb1lpVGxsRWdoYUMvRlU4ZmZOWXkyOEhWRmNhTWUx?=
 =?utf-8?B?aVZDeWU4b2R2clk0RnIrSkZ5WjJuRUVhTUpGVjdlQ2d5SFQvV2V1cW5NSnFW?=
 =?utf-8?B?UkhwcmgzL3FGY21Mbk9JditIbmVnYTdKdW0vanQ4MFpmNm53SlNHZ1k3WmlS?=
 =?utf-8?B?ZG5ZRG5LaDFRU2VwYVZZam42SFh4c2JrWFBHLzUrSWZkMmZhNG5WeGY2c2pT?=
 =?utf-8?B?Z0xtZTZnK1VrZk9nM0lTb2RZYjU3MlZORzRmY2xaWEYwWm9pSkU2MUlvLzBu?=
 =?utf-8?B?K1pITmJqcS9tS2JleE1xcXRYa2RLWEZQK1NlK3JYc1FJbTBId3dyaWR3NkZu?=
 =?utf-8?B?aTlPTUZra0IxMDQ3UmROVkdCNWwrYzNjK2NVb2IwNVRETkZWaTNpTGJkaHhJ?=
 =?utf-8?B?REVvUHF0USt5TGNQa2V2c3ovWm5hZWExdEtLd0VldkFCYXIzbU1rdVB3TjRB?=
 =?utf-8?B?V1ZtOWZ0UG5NOVp3cFdpQVdsbGhnM2tZaGNrNXFDRTN4b0xSU3FONnlFLzQr?=
 =?utf-8?B?TGQrSUs0NmZXT1h5SGVnUHlUdGhOa0Z5NHRwTXI1R1BGTmNPNnVhWkw4ZWVR?=
 =?utf-8?B?M0JmWmFPSTc3ZnlCOWVhUjI5NGMwYy9JV092QTNXMmdUNUdqSCtSTEoycDNt?=
 =?utf-8?B?eTZVeHgxclZPcjMwL05taVJiK09JZGpjNWhmamU3cmVhUDM4L2FwVWdremRQ?=
 =?utf-8?B?eWI0T0hneEE2R0xOYVFNRVk1dEFSTFpVY2h4VUVqTUhPVVFiQTh0QzNYdWJN?=
 =?utf-8?B?UitVL09uVUw0V2EzLzVWRUVkREpDSVJzRUwyQ1NRSkxpVGVWQUtqVFRza1BH?=
 =?utf-8?B?aC8veHE0Q21na1E5MmdkcDhQVzAydnQ3YmxlNU9kQ0Y0NGFLOUw5Vjh3SmZY?=
 =?utf-8?B?QnhaYXV4MklXUC8rV2huRXNuTXMycnhjbzhCdG1EZHRDZi9mbDBHSWxNRHV1?=
 =?utf-8?B?UlVOUWlXeVZKbE5jc1VSOHR4RGNjVVJEbWpTbmNXdHo4RUpUSWx4SVJjNk1X?=
 =?utf-8?B?ZW1VMDI3clBmMTFHWjk4dURnY3dqelFJd0x5VElZSVRobTBRd0xTWHVvOVlq?=
 =?utf-8?B?NkdYQVZXMzVDVCtVelI2bzVRZTJDRDZSemQ2a3d5UjdIZlAydERReDdGNmJK?=
 =?utf-8?B?Qkg3NlBiak9RdUhNN3JFZEpWNlBnemtIRlMzbHlHcjJ1U3RkTERHR0kyZm5N?=
 =?utf-8?B?dE1LTG1NelcrK1lYS1AzWFpWckVOZUdyYkZEem11aWVpU29HZ1VSTDE5V1Vh?=
 =?utf-8?B?VnFwVHZ0dEJ0bXdFZmh1TjE3TTNBRzFuK0cxNEFOMHBNQzZWc2dkcEsyak0r?=
 =?utf-8?Q?Hn/jCHqRHkC6uuu8Pd0vAx9Ssvqs4EKe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzUwSUY3RUJ6ZWRGRXdocXFJQjQrQnhNZWtWWGRseURQTkdPZEgrdFpHY0Vw?=
 =?utf-8?B?TlhYWnJsQTZ1RnIxbDZNckFrRTdFUncwRDZpd2JqRExJakdmNG8yNzB5K2x4?=
 =?utf-8?B?RXg4VnI3WjJJeVRqcldSVlZGSXMwczJoNXYxTDZYQzYyOXdjVi92eDBQRGww?=
 =?utf-8?B?K29IcndyeWd3RnhBV2dsRWo2WUlRS2huanVJUGtoNHZXUEFVYjEyVGJ0L3Mw?=
 =?utf-8?B?Y0pzelN2Vy96bDNIZmltRTdBZmY0ZUczVmtGRG9ma2cyS2ZCNXBmeWpWZUhj?=
 =?utf-8?B?QVpHQXo2WUFLcVB0ZkZUNGN1MW1jVjhQdEF5MGtGV21xWXJ1ampEY1NaSDJh?=
 =?utf-8?B?MHAvVi9UQ3VkNFBYRmVqL1dkNlN2dzRIUEVCVmR1MjltSG1jT0k4b1kvUnRr?=
 =?utf-8?B?ZTZZclRHUC90RDdrbzJ1ZFZzUnBzWnhMclJtWTZIdUsxdTE2ZEpIVUpFZ01W?=
 =?utf-8?B?YUhvZXJyZUNWZnB3dm1kaU9paWJuUHlSSExaOFlGdmt3U2o4MXRvcGs1SC9V?=
 =?utf-8?B?N1l0cUhDTlJVZmNwTmNoZWdRTHh4YTk1bzdIV0hKeUJJQ3lWS1hDejBNNlVy?=
 =?utf-8?B?RjI0bGFrMmY1a3I2QzZlMXlSbEZxVjJGZkJwclFxZHBMVjBzc2V3aGtIelFs?=
 =?utf-8?B?YWxzUEdUUm5QOVFsbVY3RjgzdXVzSTBzU2hadnhJbW9IYzNRY25NTUl5a1Bi?=
 =?utf-8?B?dytEQU1TbTBUNXpSeWlYNlJRZkV1T2drallGTjNpRHJ5NTJkVUtqL0szWkVa?=
 =?utf-8?B?R0Z0TXJsbUNqSVJZc1k3RmdiNVlnTmVZZWpjQTZlaFNCcHZGL2lQNUdOelZV?=
 =?utf-8?B?a3JiRDlIZmlxeGlPQTkwNEF3ZFRONFlEM3hQSFRia09HUWRBNHFpWFJFTmpE?=
 =?utf-8?B?bm40MXhGZ1pSSlRZdnh5eXNNNmxYTzQxZkNjemNGc0g2a29FUFpGaDhYU3Bh?=
 =?utf-8?B?QmtxNlBSNkpFZU1qcUdxZDBySTRQbyt1Rm92WjQ5NWxsM1ZYaDBBdkJWclVk?=
 =?utf-8?B?bW4yV1hJQzMzaU1MWkEvenAvUVFhTEZjUXV6ek1MSEk2YmdKMnZjeVVQMHdy?=
 =?utf-8?B?amlRaU5EWXVINDJBUU1yUTViSWZqZWJ0dVF6UTNTS2xnMmhzUU9ad3BsS1g3?=
 =?utf-8?B?NVB1SUs1ZnN3L294QmhUVFgvb3R1Vk5ORkFZQ3FNV2lEM01QYzJwYXYvbmti?=
 =?utf-8?B?WFZGa1ozb0t3UVVOaFBIa0xxcnVlM1k5S3BqNzg2TE5QYXhRb1ZudHdERnhw?=
 =?utf-8?B?a3lMUVlmYXpDMURHTWlPaHorZUFha1V2LzNEY29UeGo5dU9zYVdNMXhMbWhY?=
 =?utf-8?B?eEpEQ1hwSWFBL0d4MHBrS1JtVXg3VEJRUkdOVnNqMEdMcnFSWkJyVmkvbWJR?=
 =?utf-8?B?QjlBNEdyaHd6NEZ3eWUrdzJJK3JzS3ZNS01IY204Vzh4eEc3aDgvc3RjS3VD?=
 =?utf-8?B?YjBLNGZoY09tc2g1YURUSm16bXc3OVhvNmxUcmwrZmFrM0tsQ3Y5VFVJOWNX?=
 =?utf-8?B?cmVveWV6cXhPU1BZdVF1emZrZW9rWmRVdC9nb0VsVGM4U2pLeHlITFRRNWZX?=
 =?utf-8?B?K2NaWGNLdEx0cDhIZmdIaGhXSGQ1VEpRSGE3Rlg2Mmx5endVWmJVdHFaMExT?=
 =?utf-8?B?YXRCNUlOR3dZT0M4WkpqemFwcGNrdXBKY2gxODlwRGx3OFFpMXh5b2d2ZjVF?=
 =?utf-8?B?L3k4K0JtdzFFNmdOTWhNYStyRTB5Y3AwTXBSaTlWdS9TN2FzUWpsK3EyWkJT?=
 =?utf-8?B?eThaa2tOQi9zUU9DZG5IRHZ1T2l2Q0w5QU9xTGtUS2trRXNadENsVVNYbmRy?=
 =?utf-8?B?c01TeGsxM0JXaURFRlpVTWttQUdsV2hna05WWWpxUHZkNVhoTjlwY1paM1hm?=
 =?utf-8?B?OXhsSisxaVVOQXJINUpWcHErWmozN0VSWkxrNjQyNHNGMlVnWXd2L3p6VkxI?=
 =?utf-8?B?TWNjUmNNTE9VVnR5UGR3N2RuK2VuSlFDQ29UeFJNV3lkczkwY1pHZEhkOTVp?=
 =?utf-8?B?NjBZVjVXZ05FY2tqSEs2QXVZblRFNXZDK2EvU2ZoUkZ6ZnRPcGFoVGNyZk5o?=
 =?utf-8?B?Y2wzMjAxeUp5YVFxTzRTS3pGNVpPKzBnRHRHZzMyTHVUb1RxRjN4amc2VitR?=
 =?utf-8?B?cXU4TUlhOXlPVHVjNXRwbCtaTFZuOFVMQlVxRkkzMm9lVHJKZUloeXhuTm1x?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb1ab71-48de-4bd4-8046-08de21c4b369
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:23:04.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e19L78Y9D3T10FQFGMHE7yagHhrSMSOueOxWC38E+kJg7nbkUKQZ2ELQp7bjrTSzsOFgeFajDrdEmsS29YiQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7039

On 12.11.25 07:09, JerryJun wrote:
> 
>  hi：
>  We are encountering some scheduling issues. Within a 15ms time interval (99058.151147 -> 99058.167775), no real-time threads were scheduled, 
>  including the swapper idle thread. We have a 1ms-polling-rt-task running on CPU1, but it was also not scheduled during this period. 
>  Even the RTDM interrupts from peripherals were not responded to or processed. What could be the reason for this?
> 
>   Architecture： x86_64
>   linux kernel：5.10.199-dovetail1

This version is 2 years old. Did you also check if the latest release
(v5.10.245-cip65-dovetail1) has this issue?

>   cobalt：3.2.4
>   kernel cmdline: xenomai.supported_cpus=0xf idle=halt nosmap
> 
>   Thread-name   CPU   PRIO
>   main-thread	0	 26		
>   rt-task1      1    86     
>   rt-task3      1    91     
>   rt-task4      1    85     
> 1ms-polling-rt-task 1   94     
>   rt-task2      2    85     
>   rt-task5		2    92     
>   rt-task6      2    92     
>   rt-task7      2	 85		
>   rt-task8  	2	 85		
>   rt-task13		2	 90	    
>   rt-task15		2	 85		
>   kernel-drv-task11 2	 98		
>   kernel-drv-task10	3	 94		
>   kernel-drv-task12 3    98		
>   kernel-drv-task14	3	 98		
> 
>  perf record -e cobalt_core:cobalt_schedule  
> 
>   swapper     0 [001] 99058.149903: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.149905: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.149930: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.149932: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150029: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150031: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150034: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150035: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150036: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.150037: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150052: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.150055: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150073: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task5 56510 [002] 99058.150075: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150078: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task6 56507 [002] 99058.150079: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150127: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task7 56499 [002] 99058.150131: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task7 56499 [002] 99058.150147: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task7 56499 [002] 99058.150148: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150149: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task8 56496 [002] 99058.150150: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150184: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150185: cobalt_core:cobalt_schedule: status=0x10000000
>   t-task3 56485 [001] 99058.150186: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.150187: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150202: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.150205: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150246: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150248: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150334: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150335: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150336: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.150337: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150345: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150347: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150352: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.150355: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [003] 99058.150366: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150372: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task5 56510 [002] 99058.150374: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150376: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task6 56507 [002] 99058.150378: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150381: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task7 56499 [002] 99058.150383: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task10 24070 [003] 99058.150387: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150444: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150446: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150447: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task8 56496 [002] 99058.150448: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150484: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150485: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150486: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.150487: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150502: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.150504: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [003] 99058.150505: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.150505: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task10 24070 [003] 99058.150517: cobalt_core:cobalt_schedule: status=0x10000000
> main-thread 24485 [002] 99058.150543: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150544: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150564: cobalt_core:cobalt_schedule: status=0x10000000
> 1ms-polling-rt-task 56488 [001] 99058.150567: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150611: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.150613: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150630: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task7 56499 [002] 99058.150632: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150634: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150635: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150636: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.150637: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150642: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150643: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150671: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task5 56510 [002] 99058.150673: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150675: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task6 56507 [002] 99058.150677: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150740: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150742: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150745: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task8 56496 [002] 99058.150747: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150761: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.150763: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150783: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150785: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150786: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.150787: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150839: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150841: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150879: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task7 56499 [002] 99058.150881: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150911: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.150913: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.150933: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150934: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.150935: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.150936: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150938: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.150940: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150970: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task5 56510 [002] 99058.150971: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.150974: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task6 56507 [002] 99058.150975: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.151037: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.151039: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.151044: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task8 56496 [002] 99058.151046: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.151060: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.151063: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.151082: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.151084: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.151085: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.151086: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.151138: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task7 56499 [002] 99058.151143: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.151147: cobalt_core:cobalt_schedule: status=0x10000000
> (---schedule delay 15ms---)
>   swapper     0 [003] 99058.167775: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.167776: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.167777: cobalt_core:cobalt_schedule: status=0x10000000
> 1ms-polling-rt-task 56488 [001] 99058.167792: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task11 24077 [002] 99058.167794: cobalt_core:cobalt_schedule: status=0x10000000
> 1ms-polling-rt-task 56488 [001] 99058.167795: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task12 24088 [003] 99058.167797: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.167798: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task11 24077 [002] 99058.167801: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task5 56510 [002] 99058.167803: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.167804: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task6 56507 [002] 99058.167805: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.167807: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task13 56506 [002] 99058.167808: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task10 24070 [003] 99058.167809: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.167810: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task10 24070 [003] 99058.167811: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task13 56506 [002] 99058.167816: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [003] 99058.167817: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task13 56506 [002] 99058.167824: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task13 56506 [002] 99058.167826: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task10 24070 [003] 99058.167827: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task8 56496 [002] 99058.167828: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task10 24070 [003] 99058.167829: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task13 56506 [002] 99058.167833: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [003] 99058.167834: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task10 24070 [003] 99058.167843: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.167893: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task13 56506 [002] 99058.167894: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task7 56499 [002] 99058.167896: cobalt_core:cobalt_schedule: status=0x10000000
> 1ms-polling-rt-task 56488 [001] 99058.167897: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task15 56598 [002] 99058.167898: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task13 56506 [002] 99058.167906: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task13 56506 [002] 99058.167921: cobalt_core:cobalt_schedule: status=0x10000000
> rt-task15 56598 [002] 99058.167933: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task2 56508 [002] 99058.167934: cobalt_core:cobalt_schedule: status=0x10000000
>  main-thread 24483 [001] 99058.167945: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.167948: cobalt_core:cobalt_schedule: status=0x10000000
>  main-thread 56538 [003] 99058.167950: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.167950: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.167952: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.167953: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.167954: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.167955: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task10 24070 [003] 99058.167955: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task3 56485 [001] 99058.167956: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task1 56487 [001] 99058.167960: cobalt_core:cobalt_schedule: status=0x10000000
>  rt-task4 56486 [001] 99058.167962: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task11 24077 [002] 99058.167968: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task14 24083 [003] 99058.167976: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task14 24083 [003] 99058.167977: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.167977: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task12 24088 [003] 99058.167989: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task11 24077 [002] 99058.167990: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [002] 99058.167993: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task10 24070 [003] 99058.167996: cobalt_core:cobalt_schedule: status=0x10000000
>   swapper     0 [001] 99058.167997: cobalt_core:cobalt_schedule: status=0x10000000
> kernel-drv-task14 24083 [003] 99058.168000: cobalt_core:cobalt_schedule: status=0x10000000
>  

For a deeper analysis, it would be good to trace all cobalt* and all
irq* events. Those may tell us if we are not getting irqs at all or if
something is blocking their processing.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

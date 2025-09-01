Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3B2E6CA6
	for <xenomai@lists.linux.dev>; Mon,  1 Sep 2025 16:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745360; cv=fail; b=Y/zmdMmz4J49i2YkwvKW+eXhGdvxEnN42I7q6ORgMM3xCDzwOUD7iRMWQYVIqAKcDono0NeIH+WIstON+2W4tDCueQxWehwLg0fHMDkZaAzIgbmlYhEqiqG61rvsMSuDL1EBYzL/lEzo56Tv3nKbs06PMKFn0ZddhQw/ppxqyUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745360; c=relaxed/simple;
	bh=vKtAHN9WP51vDaBDWE2oNB+US0EJSm/7PW5J6zvSPFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gfi3VK6HaAfIvhQd6BIYJ4Ra38NajfdYAl70G9wGJ3kLDalaXp4SzLQMkheDsqHdsvXS9EfRgl728cQKz3hJdHrv3eb0nEkkU8PMKVb2Pd4bUcBvd/Gocy5LI6TdGxiYGMgKzv+ThdDaUpyq3fzudxpmihujrkgTRD932FOGHkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CJH04AU2; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CJH04AU2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/XTUQeo9UReeGSCZhhuU6zLz3Av5uK65ON80vaF6e3eamoAdFgUmkef2PSreLlUTS9+f2b/AHv83oNuEKE/mNgCbNBHhADv2FBQIqsvU0H+cfbMlyBSoM+wSFDvXyiQlxSpZN36vLxDSzUHx5blXnPMQ6Yx5tyKTnFDKA+DGF4m2VnvHYYD3u9jqUN9eQAv58OoS3CAJI5W9LJPsAVPDNvmw8syM9lu/f9jc1Of1lDR2nUqcJy21JOSGVzLsjBSdDtPl4sSR7CDVotBHBegVA6o6CW6c1CYDI3MsAo+JMIRA8HC3Xdmw+HaH5DGY7yk364lSiRS4yln0rGIp5SkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQfTfah03bwKz3ySoQ2lfyOzbbqGSxo3pQ5hU3uwIRU=;
 b=WO3bk9prZ1iJ3HtGep+yYQQ9S7x+CH/4pZTicPPyTCADYK3MRDp7BNEU6SEOl6zRp6gDoY8kFbQI7/xEhNMUgRcm+AWlHVDUfvDtPep9BK0EhjwaV9FAmS7+AdpnJ12QN4OLrEvZrY/LtF5s/e0MQpyZft2RM4nTqHJqPisYzlMN7PUGSsOkAyxBpeBIW7lf3WopFZt7O9Y/OKLfRsJnzpBhKMoPgD20swRPwvQHX9kox7mGpNQYSnMYi1Bv/N53zMkUkog5P9ygMxwzsLrfXKYP12vTsO333TQFMAhzHSKXhU/xM2F5QOGENr9SFHDB0sMIxPaNjiAj3bsMhqoipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQfTfah03bwKz3ySoQ2lfyOzbbqGSxo3pQ5hU3uwIRU=;
 b=CJH04AU2D6aLqqml+2UEbnmpf0KfZ5P4hugGT2QL33tGegNRz3McmzZh+6SQgpUyZUh39R/YLnpUUVl99RIrTMSXgdlWzQIqI4usRMWsk5v1EDz10BhJf13ym9YOpQJESarj12xp99ubT8e5BGG+fb9EkhFr5RHq0botyHVDgyvRwdJ9BdadD7W0ExCUN8qVO+dO/XCDZgLc/WU9HLJQG8aqquKePiiW7z5i4V8sT0KYDIjwh6/LJuoi65L2HbtFR3t5lSJvng+Ruge8hOCuhsNg44l5dRXbAAXDNaKRCfOQiROzEsNvCbGSc/+eChdn2FhBz6/Oo529nJXH00R0jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6701.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 16:49:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 16:49:14 +0000
Message-ID: <df36ef6e-7909-43a1-94ba-a0159c0eaad3@siemens.com>
Date: Mon, 1 Sep 2025 18:49:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/pipe: Fix invalid wait context in
 xnpipe_wakeup_proc()
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
 <bc5c15c2-3423-4d6e-b296-63797ef7ff31@siemens.com>
 <87zfbe19bn.fsf@xenomai.org>
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
In-Reply-To: <87zfbe19bn.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: af529315-8319-4bec-b6d5-08dde9777bdf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXAxN1pQWWE2M0hjQkppWlNnQ0RZZzY3cUl1R05WeGdpVnNHUUdJLzBYNzl1?=
 =?utf-8?B?YTNUZEpMeld2Um50bmtwYUVDQXZDMlZWcGZ2Z1crdGFRMk85elFwK1JGSW1Z?=
 =?utf-8?B?alpPVTMyblBMSWJva2hIcjNlN3l3a0Zaa1dHMEJMOEhiSDVPYjN2alIvOU1o?=
 =?utf-8?B?dXAyWXJVTExTdU9ZV3ZJYjBkc3dtY2xkTlgyR3F5VndNcUNCaGk4czFYSVpu?=
 =?utf-8?B?bEhFbkV0SmxDL0tPOUdDNEZXNTZ1VG9TNis4TG15NjJlam5KQ0pFeVpoTjRV?=
 =?utf-8?B?Mkxrb2lqbjdxSGpsQURTTU5rT21kcFJpN0lFbTdSNXhNUjJrTFpCMXJLV0xJ?=
 =?utf-8?B?M1NhdUxWSGxQZFozeXl4M25qRE1NS1FPd3NLUzhwL0g2ci9jT1piVUtGWFJG?=
 =?utf-8?B?S0p4Tng0Mjl0KzdlSktoZ0tlcmNTQ0FDS3ZWaDRZbER6blJZdVdJU0lHZDhi?=
 =?utf-8?B?ejN6aW9wK2FiRkJjRXpMZGZpOWhDSUNqQXU2blI2L1lBV0xNR215dTM5TEM0?=
 =?utf-8?B?MTBwRUxyZzdKb2lzUmJFOFdFN3B2OVN0OUF2QjdzRzJiUWRrNXF0NWs5WW0x?=
 =?utf-8?B?ZlFWQU9NRkN2OXY5M09VM1JMZ2o0V0hweVNBZ0ZOTm1SYy9nMWk0Mmx2NjVl?=
 =?utf-8?B?QVV6YkZVK1M1L1JlQTR4S3JqMHpPYXc0VUdnUy9DSml2QWVYMW04MllKaUlr?=
 =?utf-8?B?RXJUUTRvb0VjZ0p3aGhrSW5yVk1BMEJQNFFvR1dyRlNtVk16RTc2dlhMazQ1?=
 =?utf-8?B?RHYvMERLeUIzRzdkNVJyL3ROQmhCZDlaRFFtUmYyOWVmTEdVU2NyKzFXYUFZ?=
 =?utf-8?B?TGdqenlWWWVtclZ3cWJrdm5USEV1dDBxdnB6WVI0c0Z5TWdLMHAzV0hXOXZS?=
 =?utf-8?B?OG9ibStFRVhxV2pYYStZRi84dGpERGFzOFJERjh6TlhuaGpvVTVkL2VqZGp6?=
 =?utf-8?B?akRSbGxRdHNrRWx5VkliSWdQNm01Z09lY0ZSMUFMRVFDeGc0eDNGZmJveTZI?=
 =?utf-8?B?clkvajgvZitNdDNQSXQ0cFloc0krT2VTZXJ5V0xqWDBwRktVcjFnUnovdlo3?=
 =?utf-8?B?QThZdmlLNGVDWVBSMEpPbXAwdkJ5UVlhRGtTRkxoTWRXVHZmWkczSGVTYVdM?=
 =?utf-8?B?YnJZdjJZajJIV0cyakVyclJzM20wV3RlcXVxZ01sbGxKK1ZYV04va21sL3Nq?=
 =?utf-8?B?UjViMjZLZ05RQjIrbjY1NDBKbzk0NjNrbzlJQ0pzOXFmekhvNndMaUZ3Q2E1?=
 =?utf-8?B?eUZmZmRVZHF4dUFWbm9mMW50V1dPWTkxemRnZmQ2R1REWjVpdmRZL1c2S0s4?=
 =?utf-8?B?SmxkQnczZldnb2dDYTBwYldadlI3c2UxUWhwY2hXSjJUZzdsYWxkMmY0RHQx?=
 =?utf-8?B?ZXVreU54cFZKWk5LVjJlN2t6SUloZFBESTRTMFBnTXpPUmdWbmRMTkdoeXZr?=
 =?utf-8?B?dE9BMjFBZUlFZVYrSGNFZThLY29vQjVXOG81aTlVTVg5ZndENTBxUGgzenY1?=
 =?utf-8?B?K3VvTXY2akRVZ1hSMXV5Vmcyc0M5Mi9ybFIrNXZVWnRPbkJ5bW1iUGQxMlpH?=
 =?utf-8?B?bkxjdk1Rb2h5YWFRa2VEa3pmb3Y2bjhYUWVPM2JEMDE0YmlmY0lyL0VRbmYw?=
 =?utf-8?B?VURISDhFVDFtSVUvZ0lRNmFVYWZCTmI1aVo5VWhxWm5LZXkvb1AyUDlYWmFP?=
 =?utf-8?B?cy9IQWp0dkFmZEIyWGdaTkZPc1luSjNFY2kyMFlwQzZ6dkZUUy9UTjRVbkdn?=
 =?utf-8?B?SUZ5L0M0Z2pOTFBNcWR3MWczaTJCdmVUQjhnL2dxTGluQ3FCRWlVdjR1anlZ?=
 =?utf-8?B?VCt1Mnpyeis3blJDUnlBblRFdTB1WTJxTlF4a3h6SHJUT0tXcGZXWlp6Zmlw?=
 =?utf-8?B?QTJQTDltMFVQSTIxei8vRUpBZ3h1NmVLT29INUtsMnBKQzY2VE42UVlTeVdF?=
 =?utf-8?Q?A/YM5yGuwMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0FoNVhQNWExMkVZcm9PRjRYNGtKSTNqZkhTLzVSZHNvUk13N0hPZHVoajNX?=
 =?utf-8?B?NXJtQ29IMlNVenhsUjdjaXprRWRNOCtkYmlWMFJKZWdUYWNJcHQ3RzR1RWt3?=
 =?utf-8?B?dmJ5OHU2RnVKWVFzVnVJSVNSN2RoclZIS0YrKzIvUzRVRlluSWhaTlVFWURh?=
 =?utf-8?B?RUhmRmV5ellrOXAyUnNkK0czazNLZ3ZUN0RFd1RZVVcvMXlJZXRjdkxGSWlw?=
 =?utf-8?B?VU1MTitsKzFOZE5YeXRVM054STlHMVFWWmRNampSTGh3TFhVR2FsRitWSTJo?=
 =?utf-8?B?VXhoRml2ODU3WURLRjhONlZUZmUvV2pScHVrTktKVVVSQ0NFbWx6N3k4MnhS?=
 =?utf-8?B?ZkRoeWJhSEdZSzd4NnhqS01tYnlqMlhzalMzOERVOFpVNmZ0VXZjM0orS2lJ?=
 =?utf-8?B?WVY3cXpvdnVwWHloa21uK1hrSlJzZjJFcnY4TThCQU1qVW9IbVBpbUNxZ0J0?=
 =?utf-8?B?am5zSWJsc254ekNGVy8rL3dLZnNicHloai9FTldIaVduYnJheXpPaXJrVG44?=
 =?utf-8?B?alVPdS9WNGxoWVIrWDhMbDVoSDJwcUdqWUJXR0dhNEZpa2RUN0lWWDZ2aXNT?=
 =?utf-8?B?VVlaV3FKeGg2SjJ6SXlIVEFlTDdxRGRYZkJDdWhNVm0yZTdGZnVpQkM3cVpp?=
 =?utf-8?B?bUZ0RENJQXpFV2FXcnVjTkNjbnp6TkFMMUoyLys4Q2JxQTVBc1Qxd1NscXJW?=
 =?utf-8?B?cUJldEFHeTgrNFRrc2ZYbnhpU1NRSjBIWFVhU3RZQlBweE03bzc5N3R2Wjhn?=
 =?utf-8?B?MVorWlZYMDdaVHNZS3pDSU9XV2ZDdVZRV09yVC9KNzcrTDg1S1I5NUo2M05P?=
 =?utf-8?B?SFc0SnFKemJCNG9HTWk2OGRJSDM2Vy9oVkFyRGhoL1BQOGlWT1RBRjc5V0NY?=
 =?utf-8?B?MXZ5dG4xVmswKzZvZ1RPU3c5TzJrMEwrVUdVY24yczhqZWJqbVBCTlh3Z2xy?=
 =?utf-8?B?ZWJ2bFNtQnVSbXorY2R1NHJFcDUzOVJaRVBjbnZaVHpBOU0zQXVvb2EyYlI4?=
 =?utf-8?B?SUtBbG1MMmNZcUFncTJKcjczZWpYOUZXQ1hrM1I3MWF1dmhiVnRGaE1sVVhl?=
 =?utf-8?B?MUZYZ2c2Z2NKUkVlTXJ2QlYwd010QzFsYys0TDFibG1rV2syMjhuZXQ0UkJq?=
 =?utf-8?B?dURKK0psNTJRdVJPU0s3UGttR09weTFXSWRGQjBjRDZTT255VGNnY3NWcmNu?=
 =?utf-8?B?WU9rdmtCQnQ0RFVzM2NSbkkxbXpjVDFab1hUSGNPaUdNSlpVb3o5RE9lRGw1?=
 =?utf-8?B?OGJMaW1PSHUwdXNZazZFWGFvY0hINEsxdzdnQ3FySVJMZ2hodWxMSWNMVWFE?=
 =?utf-8?B?VmQraU1IcVdkMCtDWXBjdlhnT1BrVzJIRmJtcG9ra0cyR0pCSEhCbVdHaGl1?=
 =?utf-8?B?NFYyY2hWYms2aTE5K0JUVHJ0YzJzT0Q5bmpkM3JTWkpFeG42M3llbXB5QWNy?=
 =?utf-8?B?eElENGdlaDlwaktpNDJ6cms5KzZWUFVFRHF6MkRwOFpDbGxnTXBiTVIyUlJ0?=
 =?utf-8?B?WWsxcVVYZzQ2QkdST0pNK2ExZi9wd1ZSb1BhQXIyQm9CSGdTZngvT1lja05B?=
 =?utf-8?B?MWdXekg3OUl3N3B0OUR5bG9EL3lDd1F2RWxEbVhqTXE4THpSRmNtZ1pxQUNR?=
 =?utf-8?B?T25qTTVlUFF0NUpESXNRejk2SUlpWERBeW1vdkZwaG5kZEV4cC9wUDREMVF1?=
 =?utf-8?B?Q1VtRUJRL3VCNnFnT0Jsb2VhdVRiTERwWk41MWVDOVBadUV4SU9jZ0V6dU5t?=
 =?utf-8?B?bFFQMnZLelk0ZlN6eWRmUk9QeThrWDBtTHpMZCtRdzc0T3ZIcFYweng1RWRa?=
 =?utf-8?B?czBObTZodVB4QTZXUDN6bEZrRjM0cG9ZT3NWQVcxRHFodXV6bXk4L3QyUlhk?=
 =?utf-8?B?bkNCSW9ZYTB0ZTk5c1Rla01ObzNsdXptRHhxaGxyZjdsZ3FSdnhBVnZWcnc2?=
 =?utf-8?B?b1N2TmwyTVBicVlXYkxPVUExeXhHdzFBdis1ZWtLQVZ1bFZkYzFFc0lzNHhz?=
 =?utf-8?B?ZVIvQ1IxMnZJL01xOUpMcHNkSjFZLzNnVmdyZWRwdFdRdlJWaVU1R2FtL3hP?=
 =?utf-8?B?K3RpWnB6VnNUT1ljV3NIV24vWm53eXVtTko0TldKRk1lcWtXTk8zcWNJZnVR?=
 =?utf-8?B?L2FHOVdpaVQyWi9RRUY4d1dhRlV6MCtzbDNSL3RoRDZVUXV2amF4Y1J3Zm9L?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af529315-8319-4bec-b6d5-08dde9777bdf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 16:49:14.8424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xKmKsENdrm0G/uKKVp7FndZQaHO7iywvbC2cRLgWgmgFCTt1y7MEFZlSYhIePcGELN5xTxy7WEn8NXIZHihfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6701

On 01.09.25 17:28, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 29.08.25 17:59, Florian Bezdeka wrote:
>>> Recent Dovetail versions complained about an invalid wait context in
>>> xnpipe_wakeup_proc(). It turned out that this warning is correct as this
>>> function is called from the inband IRQ context (while syncing the IRQ
>>> log) with hard IRQs enabled and inband stage stalled.
>>>
>>> The call graph looks like that:
>>> xnpipe_wakeup_proc()
>>>     wake_up_interruptible()
>>>         __wake_up_common_lock()
>>> 	    spin_lock_irqsave() <-- might sleep on PREEMPT_RT
>>>
>>
>> So, the warning is issued independent of PREEMPT_RT being enabled but
>> the bug would be limited to that configuration, right?
>>
>> Since when is the kernel complaining? It is wrong since PREEMPT_RT is
>> available, officially 6.12 then. Then this should go into 3.3-stable as
>> well - noted.
>>
>>> As confirmed by Philippe in the discussion linked below, we have to
>>> migrate the wakeup code from using a synthetic IRQ to irq_work to address
>>> that issue.
>>>
>>
>> Hmm, can't we use something that is a thread when needed and an IRQ
>> otherwise?
>>
> 
> Unless PREEMPT_RT is enabled, we can't guarantee threaded handling, but
> we can always guarantee irq-based handling by setting IRQ_WORK_HARD_IRQ
> for the irq_work struct.
> 

This was not what I was thinking of. To my understanding, we need
threading here ONLY if PREEMPT_RT is enabled because only then __wake_up
can be sleepy. With the conversion to irq_work, we would go via an extra
kernel thread even when not needed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

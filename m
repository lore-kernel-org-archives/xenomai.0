Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DB43932D
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523475; cv=fail; b=NOfJqQLSxX7RKAy4h5bvRPxWRpUMYdpa6yVjj9glXdrhbie+n2bB1ANGFWHz9v8i0ZaPFmtXW906sG7J7o9HFOZ4D7GkGw61oiLTdq2h0OkVbI6Hw0ZRiDvm82Mnqtm/6/85jn0sfx2Qm5PZjPWNqYmUbOm6WKBTe8tHTEX43OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523475; c=relaxed/simple;
	bh=dT7KiVQ64vBcee3Ciqixi1lUucURSF6oKwy7VCiZbdE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=COfRc4ZIPQbbltJJ/+MzqhlQHR0knoLq+pzpp7KWWqTnsEyVvpNPwIQHyGX+a/vrde9NOfufz9tDndnykNDYe5sD9GAkr2T5WVgHso+PTt3qyuDVpzXUqQGCn3u8lEbF2Ro0DNNtiOFbUYePwFsMVmy90uVWUQ7Q7kstVU6TxQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gpT5/wxu; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gpT5/wxu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCvbXevZa/nEiAzMr/Mmsf0p/RHLaMNEKHN7m7WUzsn+opOkgqgI48Aoe8PFVuA0H0HEdBX0iPss0HSXhqmvWnQfqOnezrAsFOLDKILgSj+T5zFYqFUOQtHA3Tm0JVa1+DQSabWEUkSODo6W4JmNcVwOz9UtzS69+vwP0k4Q65x1uZ6EEs8PXSYsuZvexdmFM+il8jkUHUCFBPbe2hjFR+EDdCK1cLs7YlNweAf7sjP186ILWUSxrap2QOx7TJ1Noj7lMW6iOymyLwx7YXe0uMCJdRsVzZSzvQzK7otzubDSIBA5eSp6uXtoyxHqaM3Yptn5nBs5Epn2KkSOj5OSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE7jIVRHfaoVspLRfgZldOeD5jHnCGTQ0M0a0eZEUb8=;
 b=izXgk5JgDlOt0d4XgNqMlOV5o/hgdYGK5JkJaAe0B4I/5luIgInSP+NhFxElQZRqiXFKmkRqp6zRCGu54uEnyRH2ZMG4DYICoEp5mT7KaSQ5m3FkIpHwcZQdW5nVK0OXjZJwn3Fpmu5F5aQMMXh8F7JOXx5nd7lUL5oyJSYnXRw8dxRdTlTHmPEa6zwfAOYtJBYhWwQLpQzHQsACjKjszySFuauFCb3HPNb4XzefsejC2UhEdbFb5RW5BBaiPBO5wrF844RW19koe5qiLnZpLa6vNZbxgeqNlIqked6bxC1q39UZYwXRO0t3TU0tVG23SDdGe6qjxdpdZINPmaMd+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE7jIVRHfaoVspLRfgZldOeD5jHnCGTQ0M0a0eZEUb8=;
 b=gpT5/wxuPRwaad6p5R7sWDuT/2KBKDPff7jmZArKJKf2mem3gJdAG5tQnbcmkToCfdqelH6vgJLKqB3pP7sY7BDJP17AKxf7IH1vsS2emLeM06qRh/tzumbYBpOqTBxBOGaOUFUenRjNMSKd9T68R6uechLjuxYIZQrdD9WHh0/zXefc+muwfH9LztxSCBQmDSKazLwvXh0cuF8wQxx3cR4qalInibtCHQJzbumaciMyWMkdUC+LCxoieUys6RVGHnmV4rzJns4Rf8kX18KiDq0C7JfbbsStJmzg9oJPmf5MYmSY8FiLTnPd16MEYE7691yt4bIR8Ywf5XiEAE3jsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 15:11:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0181.010; Wed, 8 Jul 2026
 15:11:10 +0000
Message-ID: <a44af7a9-97d4-4391-897d-f4accf6fc7e9@siemens.com>
Date: Wed, 8 Jul 2026 17:11:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] tests: Drop no longer existing option for
 qemu-system-aarch64
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <06a2c0f7-8e33-4f48-9f42-8a16dc887f8d@siemens.com>
 <a0f6ecb535ea57c66cc9d75eb3c5f0a3466927cd.camel@siemens.com>
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
In-Reply-To: <a0f6ecb535ea57c66cc9d75eb3c5f0a3466927cd.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1519b7-3630-46a2-a986-08dedd03247d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|55112099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	84KTsdi1Nc1C7UZa07FYT0X2ksBn5h6iCdTZjY00HXY49d3pxKo0mYtiaREzY1/sQwA9sZpDWlpj7B1ctxpDSvdQO0BJMBlBjyU9Iu+QVIlypB74yENZ7+zyObEon028GzJeZS5QSwemyHZgyiTwfzT85opGz+VsPqL1mn64FtVti6AvRk5Dqx+L46fjp4hF4MKboTeGOT2wAjGSH16LmtzDO88sDj+AwOCp0hh1pyYciA+AHuAVzAFdkucz5iOJtV//VhIY5gdjkq3HTl+STD9FjCdr4H8PRpWBE91eHHa6WQXhJAXHygBEhpZ2sKAoUDcyOBRJMkqPpzNviX/fdiqwiR6Q6Bu3BDdoKLQ5Ln5v7oszCt+8qwGzgodJdl4NyXII2ysATk0tPINhXReiWKStrk0c9UgN4TLTOEivS8/tUJCFvBxNEq3Nhm1ktevHnC89XXaqWhucRd3vcW7PpHuZRwxRqkZp6w47AdMTq7vA4XFllzoWtjtRTl6YhQEcGcGv4hVswwuuaYfX2NiEfOWhYuUzi4hOrDbTn4eiWT3wWNA6AVUNwbyyfwo3VPUk9k7E2hMT1YOIo+/ppEz0eL4D3HB8jOOyVrnR3fwHf/587UoBDRG+/e52mNToeCvuRoCqJmr1jjOuM+QcVGVRE9OKqDmHSWn0owu8kOk1agk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(55112099003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aERjVm9VeTM5anFmZU9abDNSN2FieCt4RjhHblJFZFR0ekxjNnZOWThNdHkw?=
 =?utf-8?B?SnlkbDNVQzlqV24xS0c3YlNKd3dua1NRTFJuNytQV0ppdzMwWmNwbFJVOHhi?=
 =?utf-8?B?Y2xha3lvQTFXcUxIeXVMWHdXNkFvcTJ4cmxqM1RXUkdCQ052eDJZNUl3cU4y?=
 =?utf-8?B?dU8vVE5pVld5TFJaYnhaSXZMTVBMWXh2RFZFa0NMeUVCVUVwbWxFcEE2djlU?=
 =?utf-8?B?YXBHQVJDdlU2QlEwdGJKQ29iNW52VzFaZjdmUHkrblR3WlpQaTV0ZUVuS1cz?=
 =?utf-8?B?d2tIVWtUMHIxVElwUUdHMmpJdHk1bTVrQnJ3R3pKdlFaS29uUjRXZUh1S0Jz?=
 =?utf-8?B?RE5NTitmTXQ4S3lxU01PNStLTlFBQnZZRTI1TjJHL2ZBWGZvczRhdUpscXpJ?=
 =?utf-8?B?eGJOVWhwS2NWSWZTcnJJOVNqcHdDNjZRa2ZGQjBjbVg1UDFTMjJYdFJmRnRt?=
 =?utf-8?B?SFNvVXM2TCt3c3pQbnljMzJvSVRKbGN0eDNnaGRrZ1hjTXRmR0cvUEo1ai9v?=
 =?utf-8?B?b05LTnpPbS9QNFRXTm82UkY4SFUwSVpGUzhOYnBTTXg5RXB0eVRJNHVZS1l4?=
 =?utf-8?B?dDcwVHVXY2cwYVBIb1VTM1BZd1VnZi9KZFBRSUNLbXVKOURtazh3dG5EVms5?=
 =?utf-8?B?ZWhBbGs2MVVRQUw5N2xTSFFiOFdRVHZSOUo4WXRmaGsycWZDTDIySVFydUpN?=
 =?utf-8?B?bUR3eVpkZzlHZmphRjhIVEEyV2hlbEpLdHNSbHc2ZlFhM2RqUnBoamhVNzVD?=
 =?utf-8?B?VVNyOVVlZDZvM1lGWkFjQ2FIdDREZXlFOWVWQ201d0hBa1YwRWFpZERCU005?=
 =?utf-8?B?ek9kWk9NSEZpNm1jTDlUQjZqMlNYTjdGY0MxcERxNzNuR1RlODl4NVFVRU5X?=
 =?utf-8?B?eVpHZGFzby9vSGpVVWVlTWxxWHoycUZEUDVMNnlhSGM0dHErbnFJc1UzU0da?=
 =?utf-8?B?MkUzQ2VqTXlvM25lZXMvUjBMMHJGTzdKbWs3eG1WRkVDdmxTSkFKa3FVZ0k3?=
 =?utf-8?B?dVhXUk1nVHJZUTY3Um9vNFpsWUJpUUFNV20vVkQ4VURrUDVqVlVmbXVJa1lW?=
 =?utf-8?B?MHNzdlNqVlJMOUluU09sdHFsU1RZR01adHpvZW9VNmpRV0VsM3dMMU5yMEg4?=
 =?utf-8?B?aUcxSVIrSHNyaFFYdldsMWtPNy9BbDh6TmlCamIzVE9QRHM3YkhWWVpPMlM5?=
 =?utf-8?B?emRqbm9hVG40bGY2dUNVUHFSM05uNUQ2T2JYMHBNYTZLUHN5amxpN1Y4dlBF?=
 =?utf-8?B?dVkrbjhTOVRNQzZidW83RzJBWWlsLytFcjFUNWNjeFBXMjc0TmM1LzQzQUtD?=
 =?utf-8?B?RTB4OFBsQ1h1alRWd25KRFlqOTc0VTJEd0NzZHZXcVRZUm5MaHlxRkc3SXlv?=
 =?utf-8?B?OUJhSWo1Y2pHT21ET1lqNnRPUlBiNHlvTmJCVWFXS2JQeFFycFRSREdxSWRq?=
 =?utf-8?B?L2tlQmFHeFRNYkd5a2Q5K2I2aGFNV1lnY0VxOGdkR3Uwc29CNkdKQnNjZ1l4?=
 =?utf-8?B?ZTIxdStudDdNd3dzcld5SGpCNkN5dmJWcXNCa2FhaDZUV25YUlZwaVN5ckVX?=
 =?utf-8?B?V0lKUXVQTktUbllkOElISmdqbkZnS1pQdHZ3UCtqRDg0Y2xsSEVVYmExTUdG?=
 =?utf-8?B?a214NWVGajFhajByR0ZvR0xkWHQ0amNTNCtJWWRPanYxWm05WEtSL0FZVHpU?=
 =?utf-8?B?R1dYZ1NwZmpUSHI2MXNXMlJDTnlwOHFKVXlaRUlLY1hxS1owMmxCVnE1Vlpy?=
 =?utf-8?B?MFcvakxRV2NFUkxUUGdjY2pCazBDeXlhSG5uM05KWjFvVW85SmhKZTFTNXcv?=
 =?utf-8?B?Z0tFL0VIdWsvd25aOGJGM0FoTklFV0ovaUNlWjR3SUI3VzUyY2ZxUVNhZHEy?=
 =?utf-8?B?TllyQ0xtMWszZWlXWjRzTG5qZXJsY2FIZUQrWTcxc1RBK0RFRXNLZXZWMVZq?=
 =?utf-8?B?ZzZOdndRRUd3dWJ2TXNGeDk2R3dxVWdMeldJb3dPTHV4UVdXWWJqNUt6YUpI?=
 =?utf-8?B?VzhZeEFIbE1ZVm5CK21pc0oydFZDKzZCRkRVSlYyVUZwcnZzNmpHNHpQT09m?=
 =?utf-8?B?WjIwUk5OSTNNZVp0MEVpWUhkRlhkdkFWbDF2RCswTkdGbWVad1BuYXR2WXZt?=
 =?utf-8?B?R2FNZStjQUhFc3VOcXAyb3phdVQ5dHU4c3RNVmxQanpoRkRwcGxnMkJGUWdH?=
 =?utf-8?B?ZmVUR1dkVTdDZFA3eE1DN2FMQzJPd25wMUY5MDhUaFh5dEpFcDNmT1ZiL2du?=
 =?utf-8?B?UG4vSGdreWhBRjFTSTFoN2NCSU1OYW0xOU9BeDg4d1JsYlQzMEhJRFlYbjhh?=
 =?utf-8?B?WS9tTWkrdENDZ09WN0dTUHlSczZscGNSdkQ2WnJ0a1F1SUsyWVE3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1519b7-3630-46a2-a986-08dedd03247d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:11:10.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPRttL7ai2DUdwL1wg6mL+I5lEL0OVy3j6U0OH6Gcb0Y0v8fyE7Wa+um4B17kK32JuWiqcV6OJaQKJlnMg7oKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6320

On 08.07.26 17:08, Florian Bezdeka wrote:
> On Wed, 2026-07-08 at 15:50 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This was removed from the QEMU found in Debian trixie, the version we
>> no use in our lab for LAVA tests. But even in bookworm, it was already
>   ^^^
> /s/no/now
> 

Thanks, fixed (locally first).

Jan

>> redundant as this option was off by default.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  tests/jobs/xenomai-qemu-arm64.yml | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
>> index 2e9d1d4..50eb1ac 100644
>> --- a/tests/jobs/xenomai-qemu-arm64.yml
>> +++ b/tests/jobs/xenomai-qemu-arm64.yml
>> @@ -28,7 +28,6 @@ context:
>>    arch: arm64
>>    extra_options:
>>    - -cpu cortex-a57
>> -  - -global virtio-blk-device.scsi=off
>>    - -smp 2
>>    - -device virtio-serial-device
>>    - -device virtconsole,chardev=con
>> -- 
>> 2.47.3


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

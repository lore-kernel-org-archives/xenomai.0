Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013007.outbound.protection.outlook.com [52.101.83.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E41F4191
	for <xenomai@lists.linux.dev>; Sat, 13 Sep 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757756863; cv=fail; b=jF2xFaqu7OOeHv8vRDovMibjXdPHAIoOUIocMNWJtGmwGSAKDwFTQl2FOuXWAg+La45nZAX9yaFv3j38+9p0AuF548alIZxsI9+tsV9O5BVeTizcD/lK3PVvLlC1SFi5I5khKopj0DFkRwhm4+MKrgCkDGsR7D22n4w5GUTp4O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757756863; c=relaxed/simple;
	bh=Rc2KhzhmI6RZBzCVGICh99TEL2M9Jdp89Zyg0qT3V7E=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=iZbQ3mMopr3srsm0naavW5k9JTpArusbK1B9iHkzXFM4dXz/dkPs9EG36wyD1Yzn36RAu12G+YnIUnloVn6uYr3ybqyNq7m4FWIoeVbOFOYWyfvX6C3/41L02KMqPOEVWXLT5dgdsNYpDtF0qBign8vAY7VXN2PJW4XpSwvSUxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ABRrVunH; arc=fail smtp.client-ip=52.101.83.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ABRrVunH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwYOO6WsDG0YC5c/b321COlacB5Q4FfVVT3RWKLk+aM4QOqNOwQjByOEH5rfKgXCiGXrgas0TSiL2k3ez3Q173z+/yVP3hbKFJ511J7qmtJSMgvLqCx93yO4S5IRKRHgbxYqds3pch/ag1obOXvvEw8tI+juVfJVCk8hyYd3KIvE2fFLpl0VGafIaitnQ+pTRFVTGXmt0jxcVTzHNYEDFcp7UScYIbJNyq6aTWvoy/OgMCTAHu3gUhp9ylFSZa3I90bOfYOt3igieMT+PKrYWkdmgb7gHbsegXGTBbSSiVY+K+XVx4EwiKTP4vsLHBoBRg6uuzOX3aGePQ44aThUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZwOyibjXusvzP9BbN7BWsOGN0aCrJJVmWFy0E0fNc8=;
 b=zVtTkMuTQUBRqWRnprPHuLVkhXqWBZmK3LJxCbpUX/Lyqr8c5t0y6S5DtybyGbgSKhXygTY/bXBc8qerJwCBjRLiQQUr3MojdW424+1uyMytJ3xjBX+Eyj4IUmctonNAe4jn+2rNDhg6SBTM7nV9qQlC0QxjnsbscWeyKtxaJO0ug3OoQoKyia2CEa4ClR39uD0rQh/1xNM/qHmcZVAd0TnFjKfmhF15Rb0e/UHLHmRQCMj2SZXpDx/chSRCk9IpPrF6Goa2GRpknAGyn/tvj0BG8HiQ1VriryxiuzgyB+eu+qFFh9f2d/1JcYsvtkSMN55sCJopQ+G/Hj/aQ6doRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZwOyibjXusvzP9BbN7BWsOGN0aCrJJVmWFy0E0fNc8=;
 b=ABRrVunHVrdZKQYNubEkfztd09+FdrD0m4SLBS06PTpY4YNAwPujkJZTBJkiHAARtCX7NXJnOJbE+Qul0aUWxst/q2kfbPXecwuKLoGKjXr86qttbxbAoS5XejR0CW0eMOho7vWuz1VOsQaR0FKzpyFym4OjfMpSCwTKDKORzf2F2A6FtCQ4My++nhpiXqEstxW6iQDU5efgDRTf72QtXUrj9/igEf/bcILK3p2AXf7pC4ywlAfYT5vsry9gQL2eIYhtqp9sTPHdJW/8lAc9LCePMjBSalxywSf2JnhHPB/LepmBPgc2FXo88aNrsMsypoTCrYeR+FdiDfMr1gp9MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by VI1PR10MB3327.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sat, 13 Sep
 2025 09:47:37 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 09:47:36 +0000
Message-ID: <5d552093-0177-4d80-9c9c-58828aa05ade@siemens.com>
Date: Sat, 13 Sep 2025 11:47:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>
Subject: [libevl][PATCH] lib/vdso: Update vdso parser to latest Linux version
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
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|VI1PR10MB3327:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b7cfe0-76cf-4d17-1108-08ddf2aa91fa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm9mKzRRNGZzTlAyblVkMlBiUk5Bcys0SUM2YzdncnRjZFBVZjVXSnR2U01h?=
 =?utf-8?B?V0lndmY0SmxQNTB0dm9QL1JIYVNISVJhcEt3M2JJWXVqcElORnUxcDlHS00x?=
 =?utf-8?B?ZC9lMjFoZGdpSEk3OFJ2U2NyVXF3WTJ1NlJTYU9LdElzVWZ5cUdESHVYamxO?=
 =?utf-8?B?cHpBZWN6NFhHaWFQbWZnbVIrc2RuM1Z0ZnlLNTUyS1QyOEMra3hvRmV0WU1V?=
 =?utf-8?B?eDFGNGdNb3ZMRjgrY3lyK1FQdTdDbFNFWmFxYVZhYlg2aW40c0U2VEtHVlhN?=
 =?utf-8?B?YWNjQUNpN0V4V2E2VjdkcTJQV05PMEF3OG8wMkdsWEZJRVgxQUJXdm8vSkFU?=
 =?utf-8?B?T1k1WkVWM05sL2gwclBqeS9WWmRoc2JINElhRkM4M2EzbGxVYzFNb0JlOERU?=
 =?utf-8?B?TDU2OElCa21YUDQ5U243TS9xZUZVME9WZzgxUWp0ODdtblMrTE9XQ3h4R2Vv?=
 =?utf-8?B?TTZlbW04OUhxck1CL1FSVmcwTmdBZTFjYUlCNDVRSGRXQytCWHpkd2tIWkdP?=
 =?utf-8?B?SzFyWjVvZjNabGpZZTU0allCekw0OEV5bmpnZXU4bW0zUEp2MlhaREFCK2FI?=
 =?utf-8?B?cklFaWYzeTBheXh4a05tV05jdWdmcGgxbm9UT1NRclI3STIydGFqNENLRWhS?=
 =?utf-8?B?Y3BPV3ljTnhCSlFpUFYvTldKYTBVNStYd3lSbm9sMzh4TklObWJvTS81WWxx?=
 =?utf-8?B?ckMzTnN3V1VkRkxxeGZuZzVUYWZ3bko5Nkpiai9ZSVhjS1dSalZ4RXBCWXpr?=
 =?utf-8?B?UENCbWlpbXpiTEtRZEFUeVkvRDY5WWk3L0pheUtTKzlsVDl2T1l0amlVSS9R?=
 =?utf-8?B?NnJHNWZxd1QvVmxrcE1kUExoVjFXeUVKZi8rSVFFVVhSNkdld24xRk9LNXpj?=
 =?utf-8?B?WGEybHdqem1EcHhHMlExOEtkSWxtSGZBMy9OY0lNR1BRaWFKRHFiLzZWWkMx?=
 =?utf-8?B?UzhpcXpnOGNobHJDQTZmTTJzT0VMdUhSVzhaTEsrc2M1UDNVU1UrbGRMQTJY?=
 =?utf-8?B?VG5hTGFSdTZjZGZVUXlDT2tQOE0rTWttTE1keXBkdzgzVXIwb1lzeG9FM2JN?=
 =?utf-8?B?WXFvMjllakMvUkRDY1Qxa3YraFJxM0kxbEQ0R3Z3eUxrMHBxeXZvamJlalVF?=
 =?utf-8?B?UVpoSDJIdlkyN0ZGUmFCelBUbHdOY1NEU0N1MGs0M2J5ZjEvSVpseUpiU3da?=
 =?utf-8?B?YWFXUDhBYmI4WUYxNWs2UGJ4YjFGcXEvUFg0c1JaUkJ4VmpkZ2o0cXNRcmtL?=
 =?utf-8?B?WTFiOFR2VjJFVzZaU2pVSHM0WFQrMlQ0UlNJN0pSYU1ndENRdEdUcFA0SVR4?=
 =?utf-8?B?ZUZLc1d3ZWJwc0k1TlhnSUtYYkhSMWJrSjlvK1ZWYklZWWdKQTEzeWs2a2ov?=
 =?utf-8?B?UjVIVzl1UGx1dVV5V0ZtU3hyR3ZrM3JrOENYNXR1OXp2QWVWK2htem1IYytt?=
 =?utf-8?B?ekI0eXZHcW1OTllJQXdHM1dSbU85b05hK3BKYXFQNjdLOFRUT1Y5WlpPRGdS?=
 =?utf-8?B?TGdzcDlMSERXUU0yMW1iaHVHZTFoTFJpdTVTM0k2enhzK2w3cG5KVlUxTkpT?=
 =?utf-8?B?R2ZvdG0xV001Tlc4Mm8vMjlpbUpQVUVweDZyYW9mVVcxQTFiR1l5MDlld0hR?=
 =?utf-8?B?RE5wUmRvS2lSRklqUnM5ZHFGbTdZRWxKbEVMTmZvT3RGWUh1MURmTUpTc21C?=
 =?utf-8?B?MG9RUFc3M0tLYis2SkQ3UHBoY1YzaWZQeGdNbjREbHprRVhkWFZEQ3BnSGMy?=
 =?utf-8?B?Q0hzbWdKbXNTY3FRU2FseXVKUGxNYUxsSFlyWU81ZkQ2ZzdJaXdtT0F5OFVC?=
 =?utf-8?B?eVBEeXM4MmE4UHhRcEdkMmVwR2VXOThGMGNJdkdNMlBKYUpuYWFKZi9ncDdC?=
 =?utf-8?B?aFpCWkt6SnQ0d1VTR0JrQVQzV0IweWNjeUYrK2t0R3djYmV3VmNJSEpad01y?=
 =?utf-8?Q?mV9kOLH0HJA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm5NY2ZTUUsvem5nWUk4RnAxbjRnOS80QlRGSTRNQnhIdHFDMjNrYzRXMlE5?=
 =?utf-8?B?UE9oSnNHU3ZaTytlSitxS3hsV2tiaW9nUXl3NnRmK3ZaQzY0UlNsbnRJUmtS?=
 =?utf-8?B?b3Z2Tll2Wmt5VlZoUVhrMXIrYlkrV1hDQjd6cExYcXpZOGsxSmdHcmRBdDRJ?=
 =?utf-8?B?eWQ2amN6R3VFZTAxcjdBTkxnay9EaVFTM215aS9xMHBrL3gxSmRWbWNObjFH?=
 =?utf-8?B?V0hKcXZtMS9XbTdZSUZrWndYT1lFL2Yvc2Y1SEpzVmFNZ21QL1MrazFvZkxP?=
 =?utf-8?B?TlZyL1BqTHVENUw4UngrZVdkOWwyWG9IYmtVNjFDKzNxQzRRT2ZVVStua1Qz?=
 =?utf-8?B?c25TL3lmUVpLNkJsQjRxOEpNdDRhN2NsbHZZMjRUd0hUZUd6bUdMRThFazVk?=
 =?utf-8?B?YWxGMEw4cmM2ZWNMT3JWVmFZaHQ3ZG5BWGZEMm96R2g3UXpBSVV2YUlPSEpP?=
 =?utf-8?B?bUE2NXdFZnc2ZXZMd3RrYllzdEhvTDQ2eFJQSlRxYjJ4dXVTa1BXTnM2dkg0?=
 =?utf-8?B?clpsQ0NsOVJzR25zOUhXNGNKY2F4aVpvRFJ0UEhLcGpJellleWlCc0VQSTQ0?=
 =?utf-8?B?TDVrVm8vOG0zNXp6Z2VnMWJQSkZmQ0JlRFVwR3Vqb2FZNzFsbHY0STJSbGNs?=
 =?utf-8?B?Y1BGZmtnZkRGcWtMQ2hMektpc2RiZGNYdGMyNC95N2lwTThUVVVVd3JmWnNO?=
 =?utf-8?B?cXNDUnR6SFFvdXpkTFdGSzRaTE83cXo4S0Zub0JxcHZjbWNKazFKRWJjZEN0?=
 =?utf-8?B?ZXJhZGNBWXNwWmo1d1o1TUFzS3AyMXRBTXBHVTEzUmprd1FuVGE5Q0UrSWJa?=
 =?utf-8?B?UWI4N0RyV0dwMy9tWXRQWGNGdjl2cFJJS1JvRUtPWHdhcUNCQ1ZKV3BPOXJC?=
 =?utf-8?B?RW56dXY1TncrR2o0L09Wa1ROdnpWMjRUVVhtQXV2akVyZllHMDZYN0VxYUJY?=
 =?utf-8?B?T3Y3c0M0dk5oQ1NDOFVRTmg3Y0FDM2ZNZHFza01QRTRON2x2T1JvNmtKTUxQ?=
 =?utf-8?B?MmZ2QjFTbHdFZWZnNlF1L2hnQ0tCQXFWSDUwTXYxV2hERUFycks4TXdLUU5x?=
 =?utf-8?B?dU55WVp3K0VsREZHdXozQmdFbE5DWmNuWXUrVEtLRnRyZWhyaDFpSHBRWE9V?=
 =?utf-8?B?SmNCYWVqbitxdndGNENmMkhjMmJNcFIyM3BHMFllLy9DY2xiWU9RUDNoRE40?=
 =?utf-8?B?NlRTb3VHMUNoT05WQ1NtWXk3dkd4VjdjaDN4SjFibEYxRVFiWjhOODl6TjI3?=
 =?utf-8?B?RGJCcE5BYklFb1NUeHg5TXZ1ZUkxSzRhUjNlZUIxVDF6Z1VKZzNhUnppOGJR?=
 =?utf-8?B?ZEdMamdNMXozd1ZYaFFVME0yZ2hBWDMxWnNiN01sR0RYR0MxL1BlbjFmSFFJ?=
 =?utf-8?B?WllrS0JRSDZWQUZPeXFnUitOSWlMd3BURHlpVUdhNUtoTW9hRUFDM3NaWG5m?=
 =?utf-8?B?UHY3OXhMSS9vUjRrd3JkOFdISEh4ZlpmdXptZTdMdVZ6T1M4RVBLVlU4RXJj?=
 =?utf-8?B?c2IwRkR6d1lEa1g3L2c1aWVCeGl6aHFRK0MrdWNFNG9Cb2tndXRuU3NLdkdv?=
 =?utf-8?B?LzF2VlQwTndxcHlXYUZ6UFBVUGhCOGwvZWN5aERUYnlpbytvdWNuY0w4d3Jt?=
 =?utf-8?B?T0pHN3k2V013U3AzMzhJVDAwSndsRXhLUlBpUmw2S0kzVXd4aTFHY3QvaVE0?=
 =?utf-8?B?andqeTMxaVREV1RhWmlQY0hNQ0hLNUNWSndCTUEybkpmUU5DQ1g2bXZwcEc4?=
 =?utf-8?B?NWIzbW9COVpwQXdLUTJTWUF3VVRQWEk5SmlEZ3NLU2ZOOWQ0aEZTcHJTaHZB?=
 =?utf-8?B?Yy8wNktrdmNGMEVPeENneCtzaTFIcUtYU0VnWXVWUTd3ZlJhSjNYblA4NUxO?=
 =?utf-8?B?b1o5MUdSVXFaV29RN2xvQk15QjRlMWl3M1lQNDVWbXhiZ0Zxa3lOVEUyRll0?=
 =?utf-8?B?K3Y0eUxuQ1V5UVk2WkxlcUpMcEVOdGJacFBWVGxHdTNkQTNVbHE2bnhpNHp6?=
 =?utf-8?B?YnFYemozay96SjZXZEpPTzdsRFlHbm9MVnFWMnhZL2RMU1c2M0p0bC9uaHJH?=
 =?utf-8?B?TURVZGVJR0Jtc01oRitKNGhENUpnbkZqWVVoenRHYWI4eGJQVXZDeWJ0WE03?=
 =?utf-8?B?MHcvaXpuTUtKU0ovVlRlQXB4aUhlTWJLTG5pTnVydUhRWGFhVDB0K09LNTdi?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b7cfe0-76cf-4d17-1108-08ddf2aa91fa
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2025 09:47:36.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZGhldqGoqdRndgUdVrZhC2YbU9TTBoaBjfAUnFHYlGRMmS2eSNVZr7UMghvdIW4xJtfETVkFpuEJK861TDxQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3327

From: Jan Kiszka <jan.kiszka@siemens.com>

This widely aligns our copy of
linux/tools/testing/selftests/vDSO/parse_vdso.c with the version found
in 6.17-rc5+. We were primarily missing support for DT_GNU_HASH. This
becomes noticeable with the Debian 13 toolchain on arm64 which caused
DT_HASH to become absent from the vDSO.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/parse_vdso.c | 157 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 99 insertions(+), 58 deletions(-)

diff --git a/lib/parse_vdso.c b/lib/parse_vdso.c
index fe6c77b..d11f1ba 100644
--- a/lib/parse_vdso.c
+++ b/lib/parse_vdso.c
@@ -28,26 +28,6 @@
 #include "parse_vdso.h"
 #include "internal.h"
 
-/*
- * To use this vDSO parser, first call one of the vdso_init_* functions.
- * If you've already parsed auxv, then pass the value of AT_SYSINFO_EHDR
- * to vdso_init_from_sysinfo_ehdr.  Otherwise pass auxv to vdso_init_from_auxv.
- * Then call lookup_vdso for each symbol you want.  For example, to look up
- * gettimeofday on x86_64, use:
- *
- *     <some pointer> = lookup_vdso("LINUX_2.6", "gettimeofday");
- * or
- *     <some pointer> = lookup_vdso("LINUX_2.6", "__vdso_gettimeofday");
- *
- * lookup_vdso will return 0 if the symbol doesn't exist or if the init function
- * failed or was not called.  lookup_vdso is a little slow, so its return value
- * should be cached.
- *
- * lookup_vdso is threadsafe; the init functions are not.
- */
-
-
-/* And here's the code. */
 #ifndef ELF_BITS
 # if ULONG_MAX > 0xffffffffUL
 #  define ELF_BITS 64
@@ -60,6 +40,8 @@
 #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
 #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
 
+#define ELF_HASH_ENTRY ELF(Word)
+
 static struct vdso_info
 {
 	bool valid;
@@ -71,29 +53,46 @@ static struct vdso_info
 	/* Symbol table */
 	ELF(Sym) *symtab;
 	const char *symstrings;
-	ELF(Word) *bucket, *chain;
-	ELF(Word) nbucket, nchain;
+	ELF(Word) *gnu_hash, *gnu_bucket;
+	ELF_HASH_ENTRY *bucket, *chain;
+	ELF_HASH_ENTRY nbucket, nchain;
 
 	/* Version table */
 	ELF(Versym) *versym;
 	ELF(Verdef) *verdef;
 } vdso_info;
 
-/* Straight from the ELF specification. */
+/*
+ * Straight from the ELF specification...and then tweaked slightly, in order to
+ * avoid a few clang warnings.
+ */
 static unsigned long elf_hash(const char *name)
 {
 	unsigned long h = 0, g;
-	while (*name)
+	const unsigned char *uch_name = (const unsigned char *)name;
+
+	while (*uch_name)
 	{
-		h = (h << 4) + *name++;
-		if ((g = h & 0xf0000000))
+		h = (h << 4) + *uch_name++;
+		g = h & 0xf0000000;
+		if (g)
 			h ^= g >> 24;
 		h &= ~g;
 	}
 	return h;
 }
 
-static __attribute__((unused)) void vdso_init_from_sysinfo_ehdr(uintptr_t base)
+static uint32_t gnu_hash(const char *name)
+{
+	const unsigned char *s = (void *)name;
+	uint32_t h = 5381;
+
+	for (; *s; s++)
+		h += h * 32 + *s;
+	return h;
+}
+
+static void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 {
 	size_t i;
 	bool found_vaddr = false;
@@ -133,8 +132,9 @@ static __attribute__((unused)) void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 	/*
 	 * Fish out the useful bits of the dynamic table.
 	 */
-	ELF(Word) *hash = 0;
+	ELF_HASH_ENTRY *hash = 0;
 	vdso_info.symstrings = 0;
+	vdso_info.gnu_hash = 0;
 	vdso_info.symtab = 0;
 	vdso_info.versym = 0;
 	vdso_info.verdef = 0;
@@ -151,10 +151,15 @@ static __attribute__((unused)) void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 				 + vdso_info.load_offset);
 			break;
 		case DT_HASH:
-			hash = (ELF(Word) *)
+			hash = (ELF_HASH_ENTRY *)
 				((uintptr_t)dyn[i].d_un.d_ptr
 				 + vdso_info.load_offset);
 			break;
+		case DT_GNU_HASH:
+			vdso_info.gnu_hash =
+				(ELF(Word) *)((uintptr_t)dyn[i].d_un.d_ptr +
+					      vdso_info.load_offset);
+			break;
 		case DT_VERSYM:
 			vdso_info.versym = (ELF(Versym) *)
 				((uintptr_t)dyn[i].d_un.d_ptr
@@ -167,17 +172,27 @@ static __attribute__((unused)) void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 			break;
 		}
 	}
-	if (!vdso_info.symstrings || !vdso_info.symtab || !hash)
+	if (!vdso_info.symstrings || !vdso_info.symtab ||
+	    (!hash && !vdso_info.gnu_hash))
 		return;  /* Failed */
 
 	if (!vdso_info.verdef)
 		vdso_info.versym = 0;
 
 	/* Parse the hash table header. */
-	vdso_info.nbucket = hash[0];
-	vdso_info.nchain = hash[1];
-	vdso_info.bucket = &hash[2];
-	vdso_info.chain = &hash[vdso_info.nbucket + 2];
+	if (vdso_info.gnu_hash) {
+		vdso_info.nbucket = vdso_info.gnu_hash[0];
+		/* The bucket array is located after the header (4 uint32) and the bloom
+		 * filter (size_t array of gnu_hash[2] elements).
+		 */
+		vdso_info.gnu_bucket = vdso_info.gnu_hash + 4 +
+				       sizeof(size_t) / 4 * vdso_info.gnu_hash[2];
+	} else {
+		vdso_info.nbucket = hash[0];
+		vdso_info.nchain = hash[1];
+		vdso_info.bucket = &hash[2];
+		vdso_info.chain = &hash[vdso_info.nbucket + 2];
+	}
 
 	/* That's all we need. */
 	vdso_info.valid = true;
@@ -221,37 +236,63 @@ static bool vdso_match_version(ELF(Versym) ver,
 		&& !strcmp(name, vdso_info.symstrings + aux->vda_name);
 }
 
+static bool check_sym(ELF(Sym) *sym, ELF(Word) i, const char *name,
+		      const char *version, unsigned long ver_hash)
+{
+	/* Check for a defined global or weak function w/ right name. */
+	if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
+		return false;
+	if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
+	    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
+		return false;
+	if (strcmp(name, vdso_info.symstrings + sym->st_name))
+		return false;
+
+	/* Check symbol version. */
+	if (vdso_info.versym &&
+	    !vdso_match_version(vdso_info.versym[i], version, ver_hash))
+		return false;
+
+	return true;
+}
+
 void *evl_lookup_vdso(const char *version, const char *name)
 {
 	unsigned long ver_hash;
-
 	if (!vdso_info.valid)
 		return 0;
 
 	ver_hash = elf_hash(version);
-	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
-
-	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
-		ELF(Sym) *sym = &vdso_info.symtab[chain];
-
-		/* Check for a defined global or weak function w/ right name. */
-		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
-			continue;
-		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
-		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
-			continue;
-		if (sym->st_shndx == SHN_UNDEF)
-			continue;
-		if (strcmp(name, vdso_info.symstrings + sym->st_name))
-			continue;
-
-		/* Check symbol version. */
-		if (vdso_info.versym
-		    && !vdso_match_version(vdso_info.versym[chain],
-					   version, ver_hash))
-			continue;
-
-		return (void *)(vdso_info.load_offset + sym->st_value);
+	ELF(Word) i;
+
+	if (vdso_info.gnu_hash) {
+		uint32_t h1 = gnu_hash(name), h2, *hashval;
+
+		i = vdso_info.gnu_bucket[h1 % vdso_info.nbucket];
+		if (i == 0)
+			return 0;
+		h1 |= 1;
+		hashval = vdso_info.gnu_bucket + vdso_info.nbucket +
+			  (i - vdso_info.gnu_hash[1]);
+		for (;; i++) {
+			ELF(Sym) *sym = &vdso_info.symtab[i];
+			h2 = *hashval++;
+			if (h1 == (h2 | 1) &&
+			    check_sym(sym, i, name, version, ver_hash))
+				return (void *)(vdso_info.load_offset +
+						sym->st_value);
+			if (h2 & 1)
+				break;
+		}
+	} else {
+		i = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
+		for (; i; i = vdso_info.chain[i]) {
+			ELF(Sym) *sym = &vdso_info.symtab[i];
+			if (sym->st_shndx != SHN_UNDEF &&
+			    check_sym(sym, i, name, version, ver_hash))
+				return (void *)(vdso_info.load_offset +
+						sym->st_value);
+		}
 	}
 
 	return 0;
-- 
2.51.0

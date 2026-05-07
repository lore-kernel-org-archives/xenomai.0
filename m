Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B230BF68
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158478; cv=fail; b=iQs+5bAP3vyqFjBuz4jJ1kCpSUkotRTsuVd31AUL8e/bkHZHWu+7BmG2E751TtwPpp1nFuKK6PxpKEKUU2fk9nJZmvFAvcZ+kD6+XuMKN4f4/M2dK/ufOgU8YBIi5uGR9NWrT7M1eQjC0zeUotJyj+Sc2PgHVhcCkuC9Lx3JAwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158478; c=relaxed/simple;
	bh=HN0ACfo+9clIjSKNHD9D4SWOIJ7mqL5q5xUy5ZCYeQM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ap27I4dDiq4KMGwNM/tNQBS61sM0+uh3pY+jKKhfpQIW+5XVGR9aju5RpQ2apLPyE3Vs2L49w4kfLDSVgFMx70aVLUDgYxqRrBAVY5KNKaifz/bxTwN19VD7icFKhGvPIZ16Rogs4r2ORgA3m2pPfx6zqSq7BMc9q24hic8MSAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ODbqXRCI; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ODbqXRCI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrLXt97SAdinAuOfPcL+IzCA9/Vz2EaHnkw66E8Eps7PA+JUNH8s8BkwQJ/QElUd3nODSyf++6BtEt6/UFF5x012+Oapb55fW9Wnsa6b4q65/qBEzGlJyD4pU3+FEhbALfRdUrOKhpznlRY1vzlKMDEIgyQK5HJMrTV+hxw3tI6uLu/xUPw6JO0uhvXUFRDF6TyqYS6FnOpkB+y+wazYxhW5F1tmFynuxwkT5yL4E+qRpFJ8i2+xFH31LHH+vS/ybEUxkKaVUAXOm90A4SOOym6QefC0o5eKkHoUgmmkoRjOigpNB4EtrhzxlCqaLflaaIN2BDmUb7fgyd6b+KKkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niNcFVBj5OYdW3fRY+vKTRQfEzHik6eqnxHXLeZZHxU=;
 b=Nltx/Fm2gbDbXCQwiIiaOr70AYtRGlujNsORg8SS7rfK2PWrOzl+MhFE8DeJ5T5uVdoQuRYGM2FqYR+Qk4Hd4dw0nBAKjMTpj0sWCTqW06zHtC0/EATtZbPpaAzFQjcXoHHZWflNB90XyUEnE2u1WJZ5axW5LAnpE3nrG0Bv/BKMe3Av9DwKuWENvijbUtFpD2rOwg7EcMm8kRQMV2EYshfghK4WpopsTJz8DcAjCnD5sa3XjKKkQfrrdwg3+KtJMMksFC1kBo8dOCL423Sl+LV8wKL8WNE7QuB6GpUMKNBU3ewqMimmwRH3K3H2Y2D/FmaZUGa0JaVrOOVZf/OOZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niNcFVBj5OYdW3fRY+vKTRQfEzHik6eqnxHXLeZZHxU=;
 b=ODbqXRCIHhh3bAzHY7UWE3BLQtH+QHch117QObQv36kEy/MbE4DvakYA/L2P1OXShy0vb1ZwUamOfxyQHR57al0TZ5vdZJE7TMmgWSaMTqCn4Mppq0c5MkHp1n/0LR78p9RRdOkncfTljxJTnqv3Atg4yNmQxeYwRyS+sVrI9hpwKUnPaNxPoKycBvARUzEpCqbKL58eV1sa0gSZ72oy+UI6FHqiXPruSA7/jkXPGav7iXNNvpai7rUmWOS0g5JTNfdAGl5po2nSlXAERexmq+E+1PT3JP9ojkq6LhRBfpmmiJxDHQkabRYIpnUCwQbSl9Y40SJWv7JBDhnq6h9fDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7193.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:459::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 12:54:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 12:54:32 +0000
Message-ID: <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
Date: Thu, 7 May 2026 14:54:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>
References: <20260507122357.2463483-1-richard@nod.at>
 <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
 <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at>
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
In-Reply-To: <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: 409cb689-ad9d-4dc9-8d6c-08deac37c8a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	B2/c+CBdp5RGZbXKLE22u1uLNDVMkAu6058tHMzw7dmI2kXPeTg+DVYCI+AGbAdYHYFUPUJ5ENc/U06v/rU6dTfkKOWSRY+AgXS2ZXtfvkUkq6IoS2i0hhJwwaIz+XRKv/DvDgIaI6nQ64dr72fMHlXp0BYcBjA8+HXKDsj+AJUHQ/aqK1wYdVvBxwSXPOk2+U8J8Eo5RuTJ5M69qNKCPv7lOgolta92c/eouVEVzm7eNrp9QVeqBJkia6Oz6R2YKYb418SgFRaDadmggzbLx22VN0Kih4pCV2HEoBuc1643M4pcjf8xYpvZXUxDINFngp1euj9hcrwO5NINSVgAnOqhc+Wxlb/m2QwbIyQFn6p9XGymkTYQBD62Md/8DdEvgjv1Uk1Zm1Oxes6nVzxaNmCEpIyi85cegwcuRXJdrC/3bI8hSeccQyv7TFDvqT8o0EPheOSGG5UC8BLhjpVdbZ49B5zVL/cMy9bVGtC3wqm8oygMAd8L8QgOOQ0U+NFwBdMoUItzmT0IeDmXwERWs55n778eHOafenhZnikg/6Yv7Y8IpQ1dddJ8g5mhi4JTUouVqAi2BKPfbMFtMs+zadZ7TFISbRxqgJ0FcT6qK8GyEBQVleVMe7YPBVhBOqkWvhutgpnqreIv0qZS9abMk0gsQb8BG8xs2757b/xPmcvVky7gA6nF0ju4s3rkZcyI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckd4V0IxYzFWWDNpR2xkNGJSeFpsZi9EeEhJalMrZWplS09sdlMrZmxnTWYx?=
 =?utf-8?B?WEN1R0NJUis2UXl1S0VFYVZWNExZNDIxckx2alY3ZllMRXlka1NtRC9zV20v?=
 =?utf-8?B?OC9jUGRKZUVqbGI0cVdCRnc4QTFQajFkUWFZVEVHanEwdW1uQnVTVHlSTUE1?=
 =?utf-8?B?T3cwelpXZ2NyMk01RDNXQUhBb2lFT1RYZ0ZTNXYyNHVBdEhJQmRHaC81cnFa?=
 =?utf-8?B?eTNrZTRiMStxd0U0VFJZbFB1Vld6ZitKVTlpVElTZSs2UURmS3BlV2NJZDdn?=
 =?utf-8?B?OUdjNW9GSTZFckJWWm1wNW9seUNlRkIyckhISGRTWkM2cmp5akRQZlp2UURt?=
 =?utf-8?B?RWx2UXFXSnovbFlXN0lxbWx6OFRpRktXMkdqREhhdFhydWxSNTZTc3h2WE1i?=
 =?utf-8?B?S09nVVplaS9EYm05TVdGdDFNclJLa091dlB6UU5qSzM5elhHWTFobVZMSzJq?=
 =?utf-8?B?SFZmQkZUWVBmVkRwaFFmb2xjeTFad0hVTGlGOExmZXZZVmthSUQwTFlQUzFU?=
 =?utf-8?B?ejhxWlZlSnUzN1NWUFBkZlFrdTBJZUpmRzdUU3AyUkR6Y0l6Y3NkZTVVclVF?=
 =?utf-8?B?elpiaUJwQ3h0UnFsWk00MmR1dTRzS0RJWmh4dk5sZ2RPZWM1aVprTVBFNFdV?=
 =?utf-8?B?cGNCWUtuSXpHcWZHM1AyVGsrR0UyL3ZJdU9QakZYc1lzMzR4YXhZaTFDb1Q1?=
 =?utf-8?B?WjBvTFI2VXkzTW9ZaEUzcE91dlRScDBNZ3M5S0grMVpBS1VTYmk2azU3TTg5?=
 =?utf-8?B?cUE1NzgvRUpTckdsaUk4eXZIN2hpQWRaQjhUais2STBHSXpDSXpMTXZoaHV4?=
 =?utf-8?B?QnRidmcrcXBwbVFVd3RpdThTV1F1OGJjRUc3Zyt5U1M4YkhFSGVqOXpkQXly?=
 =?utf-8?B?bS9uejdVdW1QQjVGL1FtblRCS0QxSWdieDQ5SG9tdUxqMEJiZWtaV1FzelZR?=
 =?utf-8?B?cnFZZ0NPMXgwamZHSE5yZ2VVbERLelZSb3FXTkZUQ01UVENmS1RPUE5sTm9F?=
 =?utf-8?B?V1ZTamt6QkZDdUQva0Jxd09GS0JJdytRYlp0UFlyUlFvMzNQVUdLK3dJeFEy?=
 =?utf-8?B?S2xDMWpCWS9QZGdZUG96bUNEOGVaNmx0L2txZGMxK3RDNlA3ZUJaTlRaT0Fn?=
 =?utf-8?B?WHBHUTkrdlFUeHFWb1puV0tHQklXK3FHM3B6OGhrOFlwdHJLZEZoa2tPb25Y?=
 =?utf-8?B?L2RVUlNWZGxyN2dIa0NyUG9HSE50OWdUSVlwZHhjazVxTUtTcy9ZNVN6M3I5?=
 =?utf-8?B?Q29DaUk0VUlWNWFqU0t1WUtlN25oRkkxekxQNjJ4RHFqT1lKZnhWRnJJcUt1?=
 =?utf-8?B?bFZRRGs3bU1oVmFMWFN6K2ZsT0M3VW0zNnlHbm1ERzFhOVZPcUhteGVtRmMv?=
 =?utf-8?B?d1IyU0JzQ1dmY3A2NS9KZDdZc3N5dGNQcXQwTnFJMzF5T1BPOHhXR0pMbVhq?=
 =?utf-8?B?QkVmdnZqcXF3V25OVVB3TGNQSXVUc3Fzc1o2RGdyem1aMUJKbHdBUzRvdHV5?=
 =?utf-8?B?aEZTSkhjSXd0ZWs2YUgwZTIraWkzM3Vsd1FCV0pCUDRCYkl1RkMrR0JsNjVo?=
 =?utf-8?B?RThKbHJRLy9abUwvbk5xRjIwREZwOVd6YTMvUktnR24wUE9rUHQ5Z2RGTFFz?=
 =?utf-8?B?cEh2ajlYS0lwNU1UZzM0WmtnOEtqS0JwN2Nad0pnY29LR0ZBQVpuK01FMExO?=
 =?utf-8?B?elJVWTZGSm9JUlFkTHhqQWhhekJaNHBzN01uSE1xVVMrd3dyT1dnTVpad3Iy?=
 =?utf-8?B?T3dPNXVweXdUOWk4NEhPbnluU2pORjdVNnZWM3lQL05QOVQ0UWlBRXRlM0I1?=
 =?utf-8?B?WHlKbVVYdHNFcmQvelRKUUVjZk5sQWlEV05sb3hZUXh5b0dmN2dxdmJub1hl?=
 =?utf-8?B?aHRMSmtCSjMwcVFOOTAweFZPSDh3VDlxZklBVGZPQnczRjNDakJjWVlXUkFN?=
 =?utf-8?B?ZXUvV0lGanlYOWs3b0xMMWM3Qm1VVDBSckFJOTBOaWFVRmI4dSs5UnFZdk9r?=
 =?utf-8?B?cU5PL0dtTzNuQXN1TEJaS3IxSHpxaG5IalBEMVphODg2OU1najgvUVNadVJt?=
 =?utf-8?B?bnJHM1JOVTJNT3pjcU1HQ1paQmZOZDdhTVdyUHo0Y1hhZ3h6MzJyUUp0elk3?=
 =?utf-8?B?VWpkSDFLYnp3TjlpNnZld01xZ091WWhEY2UwSDhXSXJzUEd6TmFSNW02b1JB?=
 =?utf-8?B?R044QVlPdno0a1RSVnU2cXA0OGxYcUZBQ1Judk5jUkEvVEpIdXdQQ2F0VnJx?=
 =?utf-8?B?L21CYThpQnNUQ0hob1phM2l0U01WTVljemROQU9YYXVWN3NhNUw5OE5EMm9X?=
 =?utf-8?B?RFJwcVMvNUUvbGZ5aDhxOTVvdXJTOUVJMXJvTUJGTGxTTGdZcWtLdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409cb689-ad9d-4dc9-8d6c-08deac37c8a5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:54:32.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSUNWKVbTXzzFSQXSXm3zeRa38AKjVd3dOMaWylBL3IyEEgNdNKLKJE0S6JEk2Q+lXHMhiySC1NaufCuEScHIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7193

On 07.05.26 14:32, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> An: "richard" <richard@nod.at>, "xenomai" <xenomai@lists.linux.dev>
>> Gesendet: Donnerstag, 7. Mai 2026 14:26:37
>> Betreff: Re: [PATCH] Add build time guard to detect off_t mismatch
> 
>> On 07.05.26 14:23, Richard Weinberger wrote:
>>> When Xenomai is built without _FILE_OFFSET_BITS=64 on a 32 bit system,
>>> which is the default, but the Xenomai application itself is built later
>>> with _FILE_OFFSET_BITS=64, we get a nasty ABI mismatch. Since only very
>>> few cobalt syscalls use off_t, the mismatch goes undiscovered for a
>>> surprisingly long time. In my case it surfaced only after a realtime
>>> application which uses mmap() failed sometimes at mmap() depending on
>>> what functions it called before mmap(). In the good cases it used to
>>> work by chance since the extra bytes used for off_t on the stack were
>>> zero.
>>>
>>> To save the next person in the same situation a lot of time, compute
>>> the size of off_t at configure time and compare it against the
>>> application's sizeof(off_t) via a static assertion in a new generated
>>> header, which is included when building Xenomai applications.
>>>
>>
>> This should have been resolved (but apparently we missed most of it) by
>> 0bb6608b6fa7129de1ff4213ddf31298616cbf23. Can you name some of the
>> remaining mismatches?
> 
> In my case it was just mmap(). But wouldn't it hurt at any function
> or data structure exposed by Xenomai which uses off_t?
> 
> So, I suggest applying my change as safeguard mechanism.
> 

mmap is supposed to be fine by now. So we need to understand why it is
not and resolve the issue - or my other patch would be pointless.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

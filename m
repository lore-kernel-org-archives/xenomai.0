Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573CF1DF75A
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076816; cv=fail; b=evDz1EuHYCCM4mcJbfbvUy0bE7rvLMdblzRi5nEf8igb6xf56LGFciqMlHbhjscCVrNZ/SmAKugFIWXLR0cCF2HZQZ4KwY3R5i9BDZV6Q8Upil0BIztK0zYBxaBoawpaxhhHC8P2whvoGiDFDM7WGLK4q2eqGySLPtmWnGMaoDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076816; c=relaxed/simple;
	bh=/3nbnCFMCCUhEiUn5bGm82uwhlv3L6GehDWuRgSO11s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GPNcZ6lBCGzpHLN33VZqcQ6O6fNxBg+nsuoGqyVTCGkdU4z6P/bDThHWDLdbuvjFq1vQXXnu3qzUdsOHvzTZ65Y8MQ4i4Qf0czP3A1OZ0e18ZR53pTyN2wnampbXMxkF/ltP0DiK4E2GHyrsxeJgc1Cx4dnS8yR5ClMURGK7Ytk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FZ6dPUP0; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FZ6dPUP0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0yxAfbEoGc7XAAI34TbWDk1AYtZrF3qT30HllC0S1pNEUiaTd4QshVQH4aGRvi7VtrBdsvs2VA3sGt6vV1n4sAtYeG873fDM9IJr0IpC1vTiuiJwGhnk19oHvRIrZOdLN9Jlq9jbii/DxfLNoNmipAbVSdhBEv2+jiIYLLlXUDuG5q7bNN5BE9S5XDIufOk4Zpz5TUp65mfNxY4j2vrXwmyrv/Z60ATTyvGZmAM3E4hLSz5k3qgjTTnCecVihN+5pxGba0lyNXeTta+cS5ZE/5AaDtG/aceLOKJq9NPTD6M9KDB5yNs9MYBpM5BY0Aj3o9BlKiPhy/Di2F+N9w9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7rRriw27eGa9gx5zsH2uvx6cp5PUHwvrdxuYVBwSBg=;
 b=xWi8GFOHjZfAc7pYQ6YfmF6fsaeOsMYOWjLPC3aeTyOLuvMXHcg3k6/RBzGtP/UpMLv7ak2RTBJDjiF/3OfYnC6FExmjSuEv8XfA67XvrsXuruaA+OMB0D/S5kyRCSfDqm1ZTvCBYn48k9z6ispfD0iHRGJxTEqUeAwH8qZea+O9skiOJi+oDHacdFBvLX1lTc+uehQg7xGRgXgUb6FA+iUNYaTrvAZqZoomI7+9wsU17/Nl0Hie8qqGrsn56LSyNWhDINTQI+1dnBGZwKoyaavUShveldx92kRd/iQFeIMuRh+FxnnY8jf9ir6ekdyteLIhoubyzW16A4r3W1reOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7rRriw27eGa9gx5zsH2uvx6cp5PUHwvrdxuYVBwSBg=;
 b=FZ6dPUP0swNn/rd0I+T/xDcc/EO//gWYHqkL2vkJiq6bTjRF8FNe2bzMQOY5OlwooZhK+jzsT2UaxxF0sgWlfQ4IblNaDqPFt04u6tAW82fbniVH0969cBdhg1my+6akcLNT/qGpf1/Sp/zjYWeqo6KGFKOAW7DKAOiQBootp4oJwRMhy0Yj/r5E0qJhDJkgl4zw8WFOXP3wIlsyS68+1s2AJMWKnIPaMARspcbATJ9hOmU53aUKMJ2OOgss4bFAfMvlaT4UChpgqGKn72jnm4KgJM6Ic7OnOddGcFtZxKJX3AXb6zIpukRcq53S47n28AvaouDWVGqXRc9rMqTsNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3289.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 10:40:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 10:40:08 +0000
Message-ID: <2e6a9fb1-a0ef-466d-bb8f-04f2eccef3ec@siemens.com>
Date: Mon, 13 Apr 2026 12:40:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/net/stack: Migrate struct rt_proc_call to
 flexible array member
To: Hannes Diethelm <hannes.diethelm@gmail.com>, xenomai@lists.linux.dev
References: <20260410231830.4576-1-hannes.diethelm@gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <20260410231830.4576-1-hannes.diethelm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0411.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3289:EE_
X-MS-Office365-Filtering-Correlation-Id: 9564f956-96b7-4af3-d350-08de99490860
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	QXr4BQ659xpbKSy+3e7QUeG1vYk4W9uM1CxtH3eLntA2iftnlEWhn+owdbgKG4jzMvrLugX8cvWyfwB916OnftATqjB0TZLMbGn6Dole0GdmL+hO2b/6LHW0cjI1DEZXDLh+Y+iWI4XJ06WpV/8Y7Y//oQG+rjRgL6fFLOZk2o9hGGpJlf4t2vg9jB5jzKTo0lLa+zZCYJFfc5VkMyq7aJHjbOg92LaZr6snLjo0JYTEt7WrVqq370zjZXrgnAokspKelVqgEO18z4gNmfvjDNXh8y7XHZymZ4atJb30iLMfn24g5fzTJ+cWOzw0I4lG2WGG/nZ6Njjq8ogut/Wq5QbmBfnHhSGcXO7KipJEOHf+RgzRRyqlvZKydO1fk2sNoCAA38bjm/foJmHKrSJ/C1cwQVYcZxDmrdmrCQY+68BNFX00wp7g4+WUiZLgA4S7qbLzbNEiQCFwEc7uHIx2YnDTD8E1qQGM2JaRdHGOf8sa9lsf9lkdoMlp5grP6zmil3IkgTcDcyNHjOK0wFwSHoSPPGy3lzzvEIgca2dpcQ8866Q4KflwmqHOibx4ReBzNUGuBshKhsr/orIQyj2dWd5HGMkBUSoBAtNYWe/qOC59B1FEORVu4328mC0Pzep2KlE4kgG3TZlfR58oeZnw6nEAh3UR1BZM2m/QIN2Up4K0YTHp5qUAZPxGVvIKyQtjdy8o+LDJd52/rogTcPMPMcfS8WLNNRrj/xlnzAkksJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVpBZG10NkJPeFk4cFhvUmVicWFBaGVyZFVIRVhaMHhTM0dLV1JyU2VRNkJz?=
 =?utf-8?B?VFFJZXdmWnozanc4QmxIZEVWWk44U3ZRZGxiKzB4YUdGWEF4NE1Idys3bjJz?=
 =?utf-8?B?LzZEZ25aSjNkQ1oyaW1ReWZIcW5JQm4yUkNEZDBVY2N5VXN3R2tNcXpRMmFu?=
 =?utf-8?B?ZzQ0NUhCdXdLSVgvaFVhbk9WZUY3WllaZjZRQjBkOWlySTNOMldQQzZVR2hC?=
 =?utf-8?B?Wnl0dTlMdjdrcUNYeE9OM1cyaVFwUzNjZVlIWk05Q2Z5UVVwbTR3REdOa284?=
 =?utf-8?B?Z1VtSklWeUEyQlQxcnhqd2ZUS1VSMGUzaUhFTGxjQnZqOXhtYmhxcW5TSkUy?=
 =?utf-8?B?QXd5VGZUU2s3bWFreUJaQWJtVkhQWmRXVmRRaTZ0V1ZOaWI5RjlkcUM5bGxw?=
 =?utf-8?B?UUtEK1N0K0FhelZYbG9zTzRaSHpOQU5NSk5DeVlZWTVUZ2pJSW5aQmVXRVBa?=
 =?utf-8?B?T1drTkVvSlJBTDJNMnZ0d2o5UXVnTDM0ckxrbytFODdFOVRwSHBJUXBCaGVN?=
 =?utf-8?B?ZzVXRmlnM3k5YUZPa0g5YndWNnl5UjAwZzFVSTlFclU1N3pkWWpiM2NhRmxZ?=
 =?utf-8?B?L3ROWiticVlqbUdTNEVZNXVIczRvSFBZK0UrOGF4UmNCa2Zvc1NXNGdMQnVu?=
 =?utf-8?B?ZG9MTmJuRm8wcm03MWxWWE5FeHQ0d3BaanAwcFErSUR5Q2xJU1k2Y0FpMDhG?=
 =?utf-8?B?M1lvWHpDbHpvWmV6c0VjYjVhN2lpZEZhOW5ibVEzcVRXYTRMbmViY2p5b2E4?=
 =?utf-8?B?ZVZtMHBBL0xsV0VvRTJVZmJOOVlJNmlrdWE0dHR4YXRYUEV2MHlCWEVGZ29w?=
 =?utf-8?B?OGoxMHl0Ujg2MXQrNFp5dGxVZTRPS2ZGajlYNE1sMjU4aHh2TzlTVjZmOVBk?=
 =?utf-8?B?c000cU9pTzZOVmVQQ2MwU1NYNDYwSUZTWndIUDFVVG4wc2dYdWNUNGhmYUha?=
 =?utf-8?B?dTJTNm5BVjEzNEZ5VjVyT2RHdXR5dTQzbUluTGJpNjNEbFhnRnpOZW1MVThl?=
 =?utf-8?B?TjJFTDRDdzU0U0JSVC9KN1dUMGpiWXpaZlpNZVE5czlDTG9kN1RQbkxHU0JE?=
 =?utf-8?B?NG9MWG5BVGFVdzNwa3k2RXNJYzJiVm9FZnpOYjVWWGhjVzB2ZGlJdFpGZU8z?=
 =?utf-8?B?R3dpUFNaaWZHTk1QNHRCZG52aUxRUno4M3FjWHpCZzNFcjlpSkZUbGdWbnZK?=
 =?utf-8?B?Q0hUWFdHN1RIc0VJNTZ2RFhaVzFBWVlBbHI1b01iajRrOVA5ckluZUt1S0JP?=
 =?utf-8?B?dG5BbWdvc3J5blorVXIyS1NGd0xZcVdUTjdHWnNaT05BdkZ2R1JPcTlsRTQ0?=
 =?utf-8?B?R0xPc2FOS1l2N25ac2NFUms3UTRzZDJKY292NE81TGxTTy96MnZmTzJySXNG?=
 =?utf-8?B?cytZRFpYWWxJYTNhWmxYaFJ0dU8rNk1xc1lodmxmUmMrWDd1N29LZHVnUHF0?=
 =?utf-8?B?U0hUT004akRnbnZYVVAwRHkzWEIwd3JyRGY3TXZ6UFgxZXRUNHF5ODNWLzZ5?=
 =?utf-8?B?UGZ5WHN6QWlmWTE5di9xdEp2N2ZFZGRqT0hMcHF4TFQrZEgra3RoZCtma1B2?=
 =?utf-8?B?ZGdob21JNnBpMDFHbkZIQWZTd2Mvckh5eGk0c1hST0hHclMyeTU0dDhRd0FJ?=
 =?utf-8?B?UGdua2NmdDNIUW54aGR0WGdiZGpIT0xGWW1iWTMrZXhPRWhNU0gzbGptNDhI?=
 =?utf-8?B?OE1qU1lEaS9peVhWaWZqQjY4WmFQMVlXVm9UZWFBa0ZLS1JtUFcraTBwS3Zz?=
 =?utf-8?B?UndmcXRLTEU3SE1wTzZ2c1RKb25XNlE5QnQ1V09zMWxTdHZFWnJycXF4TVZZ?=
 =?utf-8?B?MmNVWlVjOE9mUnQvUWxQYlova001a1BGMGhWTFRacm5tRjNYejh0QmpWSTRt?=
 =?utf-8?B?ajMyT0F2eHloeEliSk9aVWJvMU1DbExteW1CZ3dkcTlsSXd3MldMdVpveTEv?=
 =?utf-8?B?S0F4SW53NGFFM2VhamgvMVBIN3pNOElUUGZldkltZDJ0Y1M4S1RiSzZHNUtO?=
 =?utf-8?B?b2NpbzVlbkQwTjI0YVZGTnFwTVJaTWxQUmVCQ2cxVUltaFhiaVAvZUt3V3FH?=
 =?utf-8?B?ZEJlUDRQZ2FkaU1WSVFmTVEzRC9Jek5OVG9xZGIwa1VOWnIwU3RYcUh0ZlRG?=
 =?utf-8?B?QUxhVytoK25zMTNTdGZreXNPNTNSaHN2UjcwTi9pbXoySml3RHpjOXd4MEdl?=
 =?utf-8?B?TUVLSG5GbHBuV2Y1Ukt5TE1tNDFLVG9Ya2xUS1l6anl2UjVGNTVBa0xyTmNu?=
 =?utf-8?B?aFNKSDBQRklhUGova0dudE5sYVBXZ0RUNHdmUXg4SVd1aEhxYTRSQnBrYjdh?=
 =?utf-8?B?cTRyRnFUakZlWWRDVE9RVENGSWdQVVM4VVJmSnRmbE5MaVRMV1UyUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9564f956-96b7-4af3-d350-08de99490860
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 10:40:08.7106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68sfyGwbyp5kggcdvh0u0/PpkjqcnELHO+QQtmvSJEm/T5VUU2adxGD+IEMcrwVARKoYgMhTf+7cb2sqcM2DyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3289

On 11.04.26 01:17, Hannes Diethelm wrote:
> This fixes the following WARNING:
> memcpy: detected field-spanning write (size 80) of single field "call->priv_data" at drivers/xenomai/net/stack/rtnet_rtpc.c:93 (size 0)
> 
> Signed-off-by: Hannes Diethelm <hannes.diethelm@gmail.com>
> ---
>  kernel/drivers/net/stack/include/rtnet_rtpc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/drivers/net/stack/include/rtnet_rtpc.h b/kernel/drivers/net/stack/include/rtnet_rtpc.h
> index 01d7ab152..f4ad47306 100644
> --- a/kernel/drivers/net/stack/include/rtnet_rtpc.h
> +++ b/kernel/drivers/net/stack/include/rtnet_rtpc.h
> @@ -43,7 +43,7 @@ struct rt_proc_call {
>  	atomic_t ref_count;
>  	wait_queue_head_t call_wq;
>  	rtpc_cleanup_proc cleanup_handler;
> -	char priv_data[0] __attribute__((aligned(8)));
> +	char priv_data[] __attribute__((aligned(8)));
>  };
>  
>  #define CALL_PENDING 1000 /* result value for blocked calls */

Thanks, applied.

There are still more spots of that kind in the Xenomai code base. Those
may not trigger the warning you see, at least so far, but if someone
wants to dig into them as well, that would be great.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

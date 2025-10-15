Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A531CA5E
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524013; cv=fail; b=AWuxNZt7FJdjGjm9bUZPL4WRPXCl2nV9+jXrN3Dtp2AirMgPGcuICqMe9xMQhUo8/rNghXRXGyRGZoSH6xwlkzsGOO68ORc1OEqUhigovVd8JcAm+TJycHjuo1iv7ASxwB8XqxA0loPcMRU/W8xs64/CLkNAe8OZtHLLEUhbhsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524013; c=relaxed/simple;
	bh=zUNHOOb04iu5DiqE7hrslNH+OyvL79B1vUbc7hGkTcY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aSgAo/5reptczUlZQolHu0I19UzHMU1bo9glPeALG8tQncoAzKiLUd8yE1Yt4xMGPG8+wnFSZKeXiwtsmCgs79iHS8xptZ0n20K6H/wupWjwAgU1IHcZsueBGK0Brms+x9zAt1LOjPbrdFcs399LB7pITghimUe6mXawiG2BLJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ux/w+e7a; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ux/w+e7a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC2wPmn8Lbh7kENVIuzX8z98gHiBukejdxqgs6XsrovY7iyOsa7zSoD4/Lb2VAl+kCFgXYTEQGhV/I+IsCMIXRSS5MDiieMhKe4SjViWXdaShqLboZXlplfd6ydVUIEu2OmotxbxDM/MQ4YymN84vM9gFBconk2GJHOeA8BhjECct48a5Ib8TJy4s8GEAXmk0lflVQXgACgx0YmZkViXUKV8+TOlWoixjAFgtrDPogS9VpaGAFcIfCQTFXF4wivd/+8/6AEdlMLgk3rENKDvDOEK6CPA5zdDoLO8xL/PyfvxfZrRnJL0NZsEjXzc1VisU2wV6RRWQ7VE9FRWN9FZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kxw0v0hzU6faaQRqXzeCCiCEJ/ivGds+ppw2hm0iVI=;
 b=FK5fTu8YwDWigP5ohOYwFzO60WOEUWgWygNi2subC4HsWhIblIyO6bHgtSqOIBNH1Smn7N6arJWNpNrx+ga3uox5nEgUCjlXjAFQE/Y/D46HoVyoDisjSnxVupj8CSp6VfXQWz2b9+7Epk3p5DWyeZQnuiG+o3xrFBt7ZksHwQ/gBopnCIPjP1fI7tyTXiMFBnSbE41CyYl+xkvkFAvt7qLWMuwTLytqHIx1BVORZirYdyGRCR4Pn9nejINab2Ml5FCkAlkt327ahnPXsmI8CBQ4KmJlo38Rv9J863aoDyzAK+WGwdDPGiyYHOhVVXwlyc7haeIsftTt0MkgvK5t/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kxw0v0hzU6faaQRqXzeCCiCEJ/ivGds+ppw2hm0iVI=;
 b=ux/w+e7a8yNQl1XlaORKUoQcvYuUAsoMWTcUqHLTOqBXumkigusoTEgxjopUWv7w245ayIBj1lT2yw923lPSeKD90TthFnvcFw/0iyKA4ePuRA48QSKTbNE30IxBUQJq/bqI0W0u/bTmNmxqugVujLwsw+OdKmCGIM8hrC0tNId8OH0ohaxlvil6s5ggsj1+OG9c3uS4h6Es0VdavAhJ5Yccv12dqYi3gb3nw79O6Xz2dZZq5V09mjrvYbLTMWy+dSmKyVz87v5Fdia9gaN/wtXjWqDCk3fpEYAspBO6PiTqGy0UY4djgxQY5+/rDAy0YZnCKM8VKJB7Y2AA0AVXuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5431.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 10:26:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 10:26:46 +0000
Message-ID: <2ab6b743-4e9f-457c-b344-9c7ded48b8a4@siemens.com>
Date: Wed, 15 Oct 2025 12:26:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm: fptest: Ensure that fp_regs_set/check functions
 are truly inline
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1760374860.git.jan.kiszka@siemens.com>
 <f601ea1438f94ac28c28d6eaca0eab2eac0de096.1760374860.git.jan.kiszka@siemens.com>
 <ab02742a9249b19717a91c33572bad16efed73a2.camel@siemens.com>
 <8a6c0009-d926-4da2-90e8-cf644579ff5e@siemens.com>
 <5bc23c9a22cc9ede19d993d0cd63991acfc8aa0e.camel@siemens.com>
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
In-Reply-To: <5bc23c9a22cc9ede19d993d0cd63991acfc8aa0e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5431:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b3e82b-1f2f-4991-790b-08de0bd557e4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU9aMjh3YVQ0WElTdnpsQ3F6KzIweURhVGdpVHlFZzBjWk95emVzYzcrUmph?=
 =?utf-8?B?aXdmMkRpUFoyY1RyNEJYOVo3aUZTaTFlc3QzUDZybWhURzN4L1piWnFoUHVi?=
 =?utf-8?B?NUFvMWtCUHdkd1AxYkNFdWRCV2tRd29nbG1wOHNROHgwekpPSkNrNDdoK05U?=
 =?utf-8?B?US9vaElVRE9VZ1BoVDlEMW9rVFF3RFBONXhJcVlOdGFHekFWY2d6N3hiYVJ0?=
 =?utf-8?B?Q3NkUWl0ZGJWQkQ2YS9DMGp2b0pRRVNJck5ZcU9qbEd6SmhMWDVDeTZ1bjlK?=
 =?utf-8?B?S0NTVWsxZWlLQ05Zb25maGo2NnNoYlJJc1h6U2dFeGYzalZBWlNKY2MzVld1?=
 =?utf-8?B?VGk1VGcyTzBmYVRrSVFGVVUwRzF6NThlQnl3b3JXWFJtZmE3UmdIaWVBVUt4?=
 =?utf-8?B?SmZxM09rejhubkFYOWllTmtZVEhFcStPTFFraEJoaDBIY1JVY0VBMkxWRnMr?=
 =?utf-8?B?UE93NkgzUTMxTmJ1ZnR3QnJXNUM5RHpCNTVSYUhLZi9Pa0xaSTc2bFZvMVE3?=
 =?utf-8?B?SEU2TDd4K0hRL1N0SzJwNHZOdkhFVUtpeWpDWmJZMHc2akdmYWxwRWxPRjZ4?=
 =?utf-8?B?d2Zza2NXM2dmWlhKWmd1QndvelZ3M2c4VjBqenU2UmpDOG83dFQzL0pkOWJO?=
 =?utf-8?B?czZ5d3hMR3F4cG0wMUVVRjZuTGFDMmlqTHppT0U2MytqZDVOWFBCakNNKzN4?=
 =?utf-8?B?UC9YUTR0REVFaDJ5aGdOby9YeVdjc05Cb0FoQlBKMVNkejVBSVNTZ0N5WnMr?=
 =?utf-8?B?d1hxdGRTQlZUVWhmcDVzOFFCMFJXTkxkMjR2aHhyblIwTjdjWlkxVGJ4UFhi?=
 =?utf-8?B?Rmd0T2dDQ1pML2krc21GZjRJamJFNHBpcXpnNm1DTEU5Wmo5MkxEMDhRcDc4?=
 =?utf-8?B?ZFlXQ1h2QlpraTB4VG5oSnlOeUhrM1kybnl1QTZmS0tzOUR4NFBCV3dmSlhs?=
 =?utf-8?B?dldLNE10N3I5ZDVxVDR6cWZQMk12Y054WnQ1VEVud2hUWnVEWTh2eHhCTFQr?=
 =?utf-8?B?WnlBei9xa2ZLYVZwcFBIU1FNYklscnhDVWc3aTkwVjZiNnBPdS9QR1NYQlAr?=
 =?utf-8?B?MzQvbTdwcGFaQXBrVHNlMFRNeGlyRU5SSXNsUlowR1gwTExHaDMyRGtZdWZS?=
 =?utf-8?B?aHZoa2xWWHVyRXo0dFkvRGhnUmVKMUp0SzQrTy9vZ3pjZ0Z6dlBTTG9MUm0w?=
 =?utf-8?B?ckw0M21hSSt1aWFpRndKdGZhRU5UdGdkUHhVRmJqQzdhb3BIWUlmbDFaTVQr?=
 =?utf-8?B?dnNFeFJDRGFsdFRONEo2NHFEK1Y0cUpCbTJEQ0swcWU3cDltQnp4dTFlKzZo?=
 =?utf-8?B?aXp6TmFscWFhRVVUWmtOL1JlaDFuMmFjbDBxMCtWWGVNRkgxc3c5VmphdVJB?=
 =?utf-8?B?RExvbE0wc0UrcTV3TWVWbWdVVmQydm0wMVgwMUVjcWFIZjhSRGFLcVBxN21i?=
 =?utf-8?B?STErOFcrcmxtZmt0Y2twblZXbHpSY3hiZ1hvWWFYdnJoSnh6RDBEUjY3Z01X?=
 =?utf-8?B?ekFXdjNpekFjU0tGbVBrMlVCc2hvODJvY1JIc1EzbnRpejZkTWdpVERnK1VP?=
 =?utf-8?B?MFQvNm1oK01nSjNGdzZTa0hsbWJpQnpxb3NQdENIQzZvTGN6SVkwWUM0WWxF?=
 =?utf-8?B?MHh3cGllNlBBeDBzSk44YjFkTlNqWUJGR0xkTTM3RE9GYitRbkVCWHZsd1F0?=
 =?utf-8?B?RGpsOHVZK1FKNFgzS3Zna2F4blFWTEVFZ1FpWnIxakhVRndVelRxTUtOR1Nv?=
 =?utf-8?B?dnpySHhCaEpCcFdQbU5jVnplWlpFRjhHMldzQjNTS0JweDVQKzhHTzZySDcy?=
 =?utf-8?B?aW5DS0J6dXBVOXR5Y25rQ20yYkFFNy9xQVA4YVZFRVloeE9MV2FERWpZa3ZE?=
 =?utf-8?B?ZDhNWnJBOEF1T2pJd05aSWwycExSaXJ1SE9WaEdBS0wzRG5PN1lOWmJpekx1?=
 =?utf-8?Q?qSkOeB4LHwNXeEkZviON8Lft+6S4ZDaF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STJZYnlkUjJ4emlqVUdVM3UvT2Q0dGJlSW1jMUxGY2huZHVGTm82Q3JHTVpG?=
 =?utf-8?B?WU1aV2lqenlWUkdJUG5rYVNmV0wvcTM4aGhZWFZONHNpQi9oN3VMc0FNb0dH?=
 =?utf-8?B?aUdUNXN3SjFZYmJVSEkxQWRlY1RyQzZhOWpiQit2NDZKSHFqRW9XajZuMjFu?=
 =?utf-8?B?S0tVdmIrVkFjdnBnNUkxQmlZd2VkTzF6WU9UamZaOHN4QVFYVVh4ZS9scXRV?=
 =?utf-8?B?WnYwSDlab0JXaDNDck9EV00yamJUT0JKeWVQU0JzQUlBSmtubGpRNTBZcGdL?=
 =?utf-8?B?bkZSZURVelFaelU4d0hCK0ZydnJ2c3pYSHlpK2VMWVVvOGFsNmMxNVpoeFcr?=
 =?utf-8?B?bnZwU0k5eWw3RGtLdDcvREVaS05QVi92M0ErV1VMcWVZQW9YcmJpZXEzWVQ3?=
 =?utf-8?B?VUJXMCtPSnpYelFzOGFWOW1BWU04SjFIQnM3QzVsaHp6TDdyOThpNVpqNXow?=
 =?utf-8?B?U0k3K2RVL1BkVGhaQnpQaGJmSlkxcVJ6TzhQOEpOZHdFaVd1UHhoMm81eWwv?=
 =?utf-8?B?d2xXbGFSVVZUall6WGg1NjM3OW8wckY4Q2VwV1d6Y3hPUXYwNlJOV2ZFbkJO?=
 =?utf-8?B?Qm50MnBLamhVZlZVUGpWWURCQzBmZGo2VElWbHV2TGxLVUhDOUFtcmRyTWVp?=
 =?utf-8?B?QWVLN0NPdStUekZqSFdaQ1ZrTDBuVzVOM1M1Q2dPTmhXNTc5OUUwVy81Y2E0?=
 =?utf-8?B?ekg1TDJ4MXAwQmV4QTJVdzhhVE1zdW1BZC9xNEdvTVA2MCtPOVE3Lzl1eEN4?=
 =?utf-8?B?SDZnd1JQWnp6VXp3QVZhWUpzWFBQTVFsY0NvWjYvWk93b2V5enpXUXVZUTgx?=
 =?utf-8?B?YkZxWmdyTG1uSUtRcG9MV0lPNWtiU0VGdHVhVEtQYUhxUVhVdnJaaHgvY2tP?=
 =?utf-8?B?VlFzNk5RUmxlY0lJY0hsa0xMWlhMQVg0M01JOXlKSDdyVWNiTFMwUkpvUUxp?=
 =?utf-8?B?SjY1d2FIUkxsMFI4clVjY3Q4aXJLUFhWNk14OE9TTmtqZ2hvaHlkNDRjK1Nq?=
 =?utf-8?B?R0FUbkVHd3BzNWNLVmRZSEYxK3FGd2hkKzJUc29RMkNxcEs3VlhpY0x4eWNQ?=
 =?utf-8?B?RHhOZXJZOEFCQ3V6aStqbG1VdE5TUnovZERQcjlia3dKTDRXWHZBaFFUM3Q5?=
 =?utf-8?B?KzMxL2t6V0IwbzM0T0w2ZTE4c1RtampYWDA5amJZckdFaitEWElVeGx2Q1Ba?=
 =?utf-8?B?ZTkrQzVTbHh3YmFiK2xYd2V3RUpOUTNXNjMzN0lWb3JuZVdINW80dE8xM0p6?=
 =?utf-8?B?RHQwNmhieWhDUU1tZXNtSVBoNVFDZXN4a1crUXNrMHFDeUxMU2Z5V05QbTN3?=
 =?utf-8?B?eDh5dmlnd1RLdXlCVUZWVHB2dGVhVzRwOWhobDBLbG1vRnMvb2o1d1FNWERw?=
 =?utf-8?B?Q0pJVE90dXdtbHE5Slp5MXhZQmNQQ3BEZjZHamJvZGVTY0o2ZEJidHJPaFNU?=
 =?utf-8?B?cU96Y1FyU3VmNUZhUmdCVXJQYlhsUlFYR0FNRnRtZzd4V000c3dqRjZwOS9a?=
 =?utf-8?B?dHE2d2dxakhNZ0NzNEJJOWlnQmM1K3JPYW1QdGlYcjdGM3F2VmtkTG9GaDFm?=
 =?utf-8?B?WW1EeFhXNXlVUlpGdVlHWGpiYUpnemp2d3BZVGJHaDBlR25Xd0U3YWRiMkxi?=
 =?utf-8?B?RTlqZ1VEb1hITmFCbmQvQjY2V1FUOU03VE1rdTRXaitLVldUc2NXOW9Kelo2?=
 =?utf-8?B?eWtyL0d0RGhBTGZxdm1IeFF1WjIvL1RLbDQ2OFk4WVJSRWN6VFIrQjg2d2pD?=
 =?utf-8?B?Y1k2RzlxN3krN3VNRHBnQU5Lb29pSFYxai9QdWZpR2NPTWJxWHo4VVdaMWlv?=
 =?utf-8?B?NXd1U1dZTFJwUE9jb04vTDBKOHYwY00rVXRlU2JGNXFvdktOaERjT0ZzVldz?=
 =?utf-8?B?QzVjNXhzWXE5Qm9VbFM3MUh4RG5IZUV3bmJUTzVlb28vaU1pN0J1N0VKR0RX?=
 =?utf-8?B?dXUrVVdwczFjVTdKVVcxQ2pjOEYvZHZxV3dVc1JLTzJGUjlQbGp1ajlSdGJP?=
 =?utf-8?B?ZzVPOSs0bmREb1FaTXloMXh0WC9hSmVKaEM3Y0E3TTNHQ0F5ODFlQm9FRWht?=
 =?utf-8?B?Vm9YM0ZRN2d0enFXeW1hZlNZOTJqdjdhVUk5c3JNMEdnbm9Ib1ZiSGhVTHpt?=
 =?utf-8?B?c2x6dyt0TUd4bUt4V3BDN2NqOWtpd2cxVXhUYnljdU8yanUrNEZ4QmVqOS9Q?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b3e82b-1f2f-4991-790b-08de0bd557e4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 10:26:46.5508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rgtSaUN70Zy9bu+RL1bLBcSkikYVJ0x6xSMdG7NuPXlBH/P7JIj4e8K5YGkOnaTyt1dPewu1rjSTlQR1AjtMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5431

On 15.10.25 12:12, Florian Bezdeka wrote:
> On Wed, 2025-10-15 at 10:04 +0200, Jan Kiszka wrote:
>> On 15.10.25 09:00, Florian Bezdeka wrote:
>>> On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> If they aren't, d8-d15 will be saved/restored, and that is ruining our
>>>> tests.
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>  kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
>>>> index d5c2c7515b..2b21bc5f55 100644
>>>> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
>>>> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
>>>> @@ -20,7 +20,8 @@
>>>>  
>>>>  #define __COBALT_HAVE_VFP  0x1
>>>>  
>>>> -static inline void fp_regs_set(int features, unsigned int val)
>>>> +static inline void __attribute__ ((always_inline))
>>>> +fp_regs_set(int features, unsigned int val)
>>>>  {
>>>>  	unsigned long long e[16];
>>>>  	unsigned int i;
>>>> @@ -41,8 +42,9 @@ static inline void fp_regs_set(int features, unsigned int val)
>>>>  	}
>>>>  }
>>>
>>> Could we use the __always_inline macro from Linux here?
>>>
>>
>> This is (also) userland code (uapi...).
> 
> That's clear. I thought __always_inline is available for both worlds,
> but that might not be the case for all kernel versions we have here.
> 

Seems like we could get it from <linux/stddef.h>. I'll rework the path.

> Btw: Which path (user or kernel) was the problem? Both or just one of
> them?
> 

I only saw the issue in the userland usage. Maybe the kernel's build
switches prevented un-inlining otherwise.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

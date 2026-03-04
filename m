Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35A3822BA
	for <xenomai@lists.linux.dev>; Wed,  4 Mar 2026 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611498; cv=fail; b=OCB0SEPJoO4HKoZpL/g9OmejdMGiNIv6Faie8889PUzlLrcB180F8egNPXfZs45YPsZK+nwUk8Wv8o9K+N2nbwnzjZI+kNYf69U+5f7pRhMdCZaqoTm/VnDGjDQyBpp7aYa/FZKGzIZY6DmhMWK4xJ1B/NIcN1hOGgCqeUiNQ0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611498; c=relaxed/simple;
	bh=n/+V1taT2Y8d4en6UyQJ5T032IOUkBPy3189+Wti4yo=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=pRtPd7TYkXEWqrq/7xU618T+i8+EtVgZROWQywS4sBRRFGb+bklBjF8fcbusZAq7b1ebxSQoMfM5rOFJsuK7kI0Udi2TaPHTkQNZ19dRpQVLtMMDu7A/Xf+07kQb3vY38hSK4oH10/pZXAZ/pkBrZpSo4Z5eshSAfMrtE0W0BjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aizaDIOJ; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aizaDIOJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EmD96JjWJJsv4ptDJ6a96qUd/47e4J6Yje9W19kS8QrTlI274oEcEzLcIWg11wD28LG3HmVuqV9HvUMktu3Xq3VDGDan+IIhlVZVM2+4fgYnTPz8n6BFO+X+Uni2iEVdbD0ySFewZavu5O9kNacS+2HCA0HkR+T9g9sL6CcMJx4LfXSCRKnQsYebPo9K9ZGxlNwvtTXmHQAhc4YGHT7p6qsT53Q5O3owpGkyPYLng+EPmkFR03R+ItWudefG7rUgtTFD4zFzMoOVPOVeKl9lNwPjkvP8OWswpq9K0rRXuBq4Zo5OHNyPdfF7Y5QJ4tp7BcNUOCslAAIB4/AUs6rZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqQ67f51BkmcLeDq9YlmUsA/8E9wF8dm0G/tQfcCmyo=;
 b=cHtNMckurviF2+VRg1zWUYcGgNtHRUrU0EieAvlEXXa/xAXC7RnCNwtc0mmQcvFOBG+Morh0H6+Vc9NaoZkP0TaG97QHcNOai+vl7whajOb/+2c+ezcKlM2oHCui4hFzAU4XcqOb+vTdLU0byR9HgptYrzwJYWB73lxfA/NCdabXwrGUaOsXws8JbNExhf4eklgWd+XRxoabVdQHB4mlqBoHQ8CzrvQoRP/5WZlgSqP8RQkJxpFtyigBlA3QpxVyYjDUDpvCb8xrXwJuB8maAOQBaqOLoEbPnRWFr/TX+DWSbFTKK7UzZzOMKB3shro5Nmqi+sNuj8prM5jeLUKFOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqQ67f51BkmcLeDq9YlmUsA/8E9wF8dm0G/tQfcCmyo=;
 b=aizaDIOJ3qfddSfj3DFk8JBC0/DKNtZh9vvsY1/YZu6Zf/OH3naoShdm5K+fDnAzx8/zPp0AcGpnab0BviKCb6zOuqqwVFZSEpTgVXfDKuiYWqx90hi+PdnErNp2sgC8sgBCWmgjrWQCASoO8IIYbNuN6GzEkrxwFMkbusp5+kvsm63p7dBg/DSa9vMN6hUwmM7LrxxmAUYnU1p6KzomKZoxaxpUf60shx4dnbEo4SRTn1QxOYJftxMmg6gc+fCOAfbVNDLlMUnx2vA//+rx+Pl9DzvNjnjM1zdOnduYrcQD3x5rSdsCd9gXJvx7yaQ0i4aa5FzRKrXu4EYniTS6uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8264.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 08:04:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 08:04:48 +0000
Message-ID: <8d5a772c-3ca9-48a6-a37c-d0cc2cf53bb6@siemens.com>
Date: Wed, 4 Mar 2026 09:04:46 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Subject: Heads up: 6.12 dovetail and evl kernels now CIP-based
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
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f1843a-256d-4c81-a13c-08de79c4b46c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	plIYhL96wIYFp6q4+JPjOB0gWeqfzM0W0czBhdJU/FAewRTnz67bVFFxv3X0H/IsrHzvgn4wYCWN3Gqxk11DyhdSAQ7byA1Xhcl3sDIsN6L80ErTm9MmiTk8EkngwptyP/k/yx6qEbMj7Z6gFQNa3ltMAnsFfUnmGqYvXfAKzgAB9yM9ZTuOcZthsUf7YMgV6+0GeVz6xXaOqU3t5VVJOH8rfmJHSwlQNQvdaz8TjFdGsB+SM57nr85F3BA8ZHk2hiOnHX11vSvdcdtsw4oLIgOFoXj45zUHyD0VwvJZyjFBZcnxgmfOLq/u5vf5OEhHIq37qlsCepglAVs2LGyVBv91LzN6/neDa4Ho9suVPbONCmSslHGBx3ITaUgVkvbn1vLxgbXpR9t5rfZUyEvFfd0bEkG4+fZ6JVL7Jm9Nfbjoj3+ULhCviMdPJ4Q0oA/IlJ5IoVkQfTakh5Jw/fBUngY7GAmEVPNMI5t6cKMTNunJu3eL5s3zOOuV7/ar1zPDDe/pBaV/dsPEb4Ast/IrVD1BWfzfbjuBw2X3mFN0t/SsUhwj8vCgBVSKVdQE8svjzfBwnCXF1GDyk/f/IaXPOK8mlMdSaEfowtaKCZ5lMXCFQA2pQLD5MZ8okzJJh3MMmi66yAL0U9g9fk4qwjV3ho2Bitb+zlue7c/WKgT0z6p+liDKPGvKX0MTqHx8q2Jzb3RepJU1uigzbkwC95vj9CTqQ+pxeKpfVmwH7q3RizE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVZ1SHlLNVl0UllIQUpqVWt0VGNNSEpoaDdyVHk0MWFLeUk1TVZmNUNJa0Z2?=
 =?utf-8?B?SUdQN2s1R0MxSkV4NE5LczNGMDVyTENncW5TUmFxTFd0QXUzNkV1cm5xelFX?=
 =?utf-8?B?QmlkVS9HQXlOYlFMQkgxYXZGcEpkN3l1YzZDbFk0Tmx5Yk1FTEVqWEFxc3BL?=
 =?utf-8?B?R1lkL014M3hReFY0SFJrTE1CM1ZDY01NYWpmRjJ1MHFON3JVUU5JN3d3YTdJ?=
 =?utf-8?B?aTh4OVNIWnAvcTlBNTZLM2JiUWxTbW1LdUdlbFA3dkl3aDZld2YwWE5yVTcr?=
 =?utf-8?B?SnorTzMyN1REUEcvN0cyOU5sWWp4RFdnOFM1Z2tIMmM4a2o1TkJ4Q1F3OEx4?=
 =?utf-8?B?dWV4eEthbUtpNnErRHdhRFBuczBnc0h4TkFmQ0ROQ3JwTFV0VDljRmR2WXhZ?=
 =?utf-8?B?TkhOc2VVNDRqREpKUXhydzk2M0FzQzkzQ0ZhV1FuWCthcUhhT1JyMkdMbVh0?=
 =?utf-8?B?MGlLMzVOQnVlQkNYUHBxbmhKTENnZ01EMDZhdUFEaW1aZlVTdW11NEo4UTZ1?=
 =?utf-8?B?dUhqZW80QkpTYXZTV01CYlpMN0NZZkhHM2RVcGlMWGhjaGNhSFRiemhVR3NG?=
 =?utf-8?B?R0Y4YzVDRWVJNFNRdGtPRDVXYS9EdGQ3TmFvaDBHbi9ZOU8zVmkxclkyaDJS?=
 =?utf-8?B?Q0ZETnlQaTNNc2FtRDJocjMzVjdFQUpVVWtiaVZzcm1CZmN3Zmt3d3dpNG1Y?=
 =?utf-8?B?bFVyMXc0alVmRHZFcFFkK1EwYjdWNVZiVXhyalBBeXlKeFRwZEhESVpvTloz?=
 =?utf-8?B?Rk9xSkxGVmNxMC9SU0JjelR2Y0VvSkZPTVJFeGlkOUwxQUp4RWZIVzByUStD?=
 =?utf-8?B?VncxbmQvRUphbDlHMUxVTlh1bGpLSzRJQzFId2p6dURKbDYrK1Ixa2ErVkZv?=
 =?utf-8?B?ajFEQUxuMEN5YWxKZHlmOUdIOXR1bmh6Y0NDMkpBTGZDNTFFaUkzbDFJWHRr?=
 =?utf-8?B?Y3o5VUNKVGtvWmdWM3BzdEtSVlB1akkveFlQL0oxaGpHN2RrNkczRFI3Yy9w?=
 =?utf-8?B?QUNyRTlBQ1BuclpzWkRNV3B2WjZxaVZ2bGJZUFRRVHg1TjVhMG5OSzVtc1Y2?=
 =?utf-8?B?ZUxBQ1B1UHdsTDFpWWpWd2dGdWREbkhwTlBSVHpTWURMMllGdjlwcDRlaStt?=
 =?utf-8?B?eU1FSlNOUDVyZDg5dmpXQ0JGSjgvbmFxL0JIR05ja2ZEVXdFYWtOTlZoanlT?=
 =?utf-8?B?SGMwM3pOOHhUcGhVZU15VUNSa2d4SWpRUEd4QW16WlRydlBkckVXM2sxRWE3?=
 =?utf-8?B?anNJU2I4alo5T2EzSXU1K0x4bU15ajVmckx0bXl6R2pZTDBDL1RaV2F3TkRp?=
 =?utf-8?B?QUgxWnVlT0lLUGlsKzFqWHo4cVNrSkdpVG5zaCt6d3kxOERlVDhCdUNkc0Jh?=
 =?utf-8?B?U1ZHZ3pHRm1lN3pJd0sramt6ZTVlTFp0WmdHeGs4UTZIZkpnUytVMGp0M3B1?=
 =?utf-8?B?MytUMW8wdkQ4czBJeFVMb3YzdjJxQ0tNZWMvSjFVMUFvNENYMVlpV2gwTW9I?=
 =?utf-8?B?NnhMRmtjSzc0Y3JTa0RVODl2YVI2MG1uc2JBWlNyZkMzMkZEN1V5NkVHcHdQ?=
 =?utf-8?B?bEQ0ai9yWlI5b0NYNEhJUXk4QklqenJjWjVNK0I1RThtVldxQnFZY2RmWGFY?=
 =?utf-8?B?bVkyV3lTcVJtcEYrWHh2RWtFVXZFUUhLeVBjNmZmWG5sTzNYdjcyRW9xbHRI?=
 =?utf-8?B?VE15K0JPTzBpWjF2c05BVGF4eTE5WTJyWlduMmxnalB2V3cySnVvTDUzemRr?=
 =?utf-8?B?TFkrTWNMT2IxbDRHRFhab25jdExOV2preGNUL3lVQ1RCdVBSRFVaUUhNSTRx?=
 =?utf-8?B?SzljU2RIK2ZXOHY5eHdqV29BTWxXUm9MTkJxTHNUSWhqYm14aVg2ZDF3dE9G?=
 =?utf-8?B?RnJJT3RJb3phMVlQbldvdmpuVkpyQW5VL2F0bHRBN1BSa0o1aEN2YncwSjdy?=
 =?utf-8?B?ajU4NEhoKzN3a2gvT2JjOUpvNlJWbEYvQXRIOHNONmhhREN5bWpVYm9iNWxT?=
 =?utf-8?B?SGc0ZzR6YU0vUVJBUm5LN2d0ZXd0SlBMU0ZkSzNEWi9XYmFmTFhuQnpveHZW?=
 =?utf-8?B?STFzaENreE5peUgrOVdUMzl6SHVLL2xBaHZMS1VZc0NyaFgydEZ3d1dNZFFP?=
 =?utf-8?B?MWRuNVFZN240WnFzVnBOcUxLSkIrRDF4bjhsdlZjYkRuZUZuOUplRDhVL1M1?=
 =?utf-8?B?eXBvbnJ6UzBRRFVPVUZwTGFDZzE3em80K3Rob3lRZ2tUQWJXZlZGczdZcTBa?=
 =?utf-8?B?RlpUQWlhMkh1amRVbDhMUVh1YnFnUVBJbStyNWlPdEtKb0NFU0NJaVdMRXhV?=
 =?utf-8?B?UXhuOGVPY3NBM1JGbzVrL2pGM3l4ckhMTGJ5cnFQYnBONnlzMS81UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f1843a-256d-4c81-a13c-08de79c4b46c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 08:04:48.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWHCGsWbSByF/bOdnbZlk1IZpf+mgv4DREfw3AameMLynwk9wsCE/jW8mPlqrMjkeLAdDSIpQaxjUq47gCN2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8264

Hi all,

just to avoid that some may once wonder why

https://gitlab.com/Xenomai/linux-dovetail/-/commits/v6.12.y-dovetail-rebase
https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commits/v6.12.y-evl-rebase

no longer receive updates: The 6.12 kernel series have been switch to a 
CIP kernel baseline. The new branches are:

https://gitlab.com/Xenomai/linux-dovetail/-/commits/v6.12.y-cip-dovetail-rebase
https://gitlab.com/Xenomai/linux-dovetail/-/commits/v6.12.y-cip-dovetail
https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commits/v6.12.y-cip-evl-rebase

The CIP kernel provides us a supported baseline until 2035 while the 
regular kernel is now promised until 2028. How long Xenomai will provide 
the maintenance of 6.12 is not defined this way, we only keep our doors 
open.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


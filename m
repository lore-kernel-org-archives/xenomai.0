Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285515885D
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577855; cv=fail; b=tcFnKeN65KiBolMPREQnTs7mEeyVvmq2rigXran1vkz10eCz2NZLNEprhijVeb5YrrYajwaTdMUUP8C40/BTZgdH7+GJ9g1ijSKOjqfUVrK0TeRBQkQyrLVoaOAyCQxIQwWbUidMitwG11T3Xi5/V4ZfWb+GtyD3ijDbUxj7+5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577855; c=relaxed/simple;
	bh=MLtgTP2bYn3ZH+f7h3WxC0sYGN4qeENMfJP9TjBjMyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mDjtmGfwu+oGLQXG/ubSz5njWfHLwR7u93DwiLfCT+BpvTo2ZPhZY1wbTHH/x4jSwz5RU4/rl7ecu09TlUiMCt77pIHRS1xcAxfDqp1Ug0PilJQnPrNOpRvX95IV3MwEOXFA53491ylPCVj5eKfW18PttiJQRteL9W/+rJDKtSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rOhrTZgX; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rOhrTZgX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+y9FPXhT+aRl7DcGYu2DqaE3VdQo5vVwphAzHXCsxNbOZ4IkCx4wI38lAx/1gqAvao+gEPXPIw5Qssu1lEa5Msj96jdcGjN5rtIcLObWDeowX0bUBWtO6I5+nf1h6sMV+FiQ7+NHbOzSxasW2AHiPx8n9+DKMDko3t5/Sojkr63+9xdvxbzgD9MPI3lpHSF0xe/AVnsLFDUh7UJdqOvZ0Fq3irFzp2hxSgOuJIbb9pE/6bCeP9xmBMZX7gB+PNcsNXOksjYylxL7QJyz0kv0tlcYocCkzyUGXeLZtyuP+B6M58sW2t5bwveIYWbVESZWnj65or1WpOmI1rlZiux6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izG8JOOPdqNdNWyyje+69su+Jf5zs/12C7N4CTYbTgI=;
 b=mKz0O/tQ+s5hWZH6w0pl4HDgGUQLtFRrXO0mHgdOLc7DPMh48MC4QYPM32ihvWGF6N5DqckoyHN4QJWftlnPIVjbWZGTmAxzUmj8NBJD25GM28VV2+ElPMEIfYjYTus6OsuCeMnusd/hd4aCy/gk6nk9f1fHKW4zvktX/pILApaxR5LJR66NeafwsoRf41QbeoNE6SM6Gk2vFD9Zbxsbi9RTbgw7xRH19Xf03S61WQOtybR7zspx7L+M7vEUTK34am2JdGq9LSvc6/biQZAR8cCfDoMGldOlsp4Q7infmm35tykqTW+7HcNT2LlGC9Wzb0jM6L8uZXH0kNdgALBgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izG8JOOPdqNdNWyyje+69su+Jf5zs/12C7N4CTYbTgI=;
 b=rOhrTZgX50WaIqJ8k9jWynYhbkWGbxLf4XQ41SHAos7n2EWeENLoS6RWxN6kK5ABjwoQGO6+t8xEIF70r9m1hmGI+BE4s9DHB4JDy1JRRUsvINMIPSfwTvGs9vZuu5JNhUXCo9Ycc36tFjyNCoNV4mHIocwKOi+5hfQwzFND0tLnO126FXfTq0BCBHkEwTTzz2vA78L2xA6/Z7qz2r8neMNd61T/ruPoMLgdGyC/CBI7LnDE6yWXLrsVuDVqid3pn9UelyWQu16Zbv5Ox11srLHaNQS8eiM3p1yaGzp/a/G0TsQp8OPkHClmPS9oYrTo+tUGPyTe20PQJWT8ArVZ6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 12:30:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 12:30:47 +0000
Message-ID: <d1d125e9-adfb-4f6f-ac82-9dfcc04057e4@siemens.com>
Date: Fri, 28 Jun 2024 14:30:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ci: specify the dtb file for rpi4 in machine conf
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com, quirin.gylstorff@siemens.com
References: <20240628122117.19059-1-yi.jiang@siemens.com>
 <20240628122117.19059-2-yi.jiang@siemens.com>
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
In-Reply-To: <20240628122117.19059-2-yi.jiang@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: f3daacd3-5812-45b8-53e3-08dc976e2336
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVYvREMwVHRjb1dqb0gzd25MTDR3OXNhdlNPcWhxMkxsTkNYdmRaZjVuNFVU?=
 =?utf-8?B?elRUWTZUUFZseC9JNkRad1F0S0dEWmxybVdqK0JTbmY0Rko3ckgzS3lyY0dw?=
 =?utf-8?B?K0E0cFQ0UmZCaXZnR3RZelVzTUhic015T2V5ekRuRXYveUp1anhRVnJUbzFk?=
 =?utf-8?B?eURaU3lydlhORmNsQUVQS1dicHNmMkR3S3pEQ3VXSzI2SW0rSlJxaElnYWUx?=
 =?utf-8?B?V252MmtaUy81RGI0bFlQeVR5TkJIS0dMZFNhZG9uTmZyTWIxclkzOHphSDZ0?=
 =?utf-8?B?RGlOQVZDTnBKNzR0V0owRnBMMUpFanFnYVFvL25pbGhhb0taeGp6OFlSdEsz?=
 =?utf-8?B?dFVFZEYzNnhSRXh5ZVRXRFJPc2lqRW9iSDFGcWZUMEZPUlpHTVZvY01DRFMz?=
 =?utf-8?B?L0JwV0tRZFp6cFRtaHlvUXlZK3NhT0UxVDdEQm9zcXRJWEZkaVlLaWJHSkVv?=
 =?utf-8?B?SGRUVGJDemdJMnpCRUhqUW12L1BWbjR6azhobnhBSUM0V1ZkdGFHRHZua3NN?=
 =?utf-8?B?dXhVMmlGZFYxOTJRMnNkbkY2Q0NoeEVrTGtHZFhlVU4vMkdKWWtYbWlSRnBG?=
 =?utf-8?B?WlY5QVBxblZodUJGa1ZpYlU5V3FHRXR4YzBoNHl6Y1hSSThRU3d6OHZWeVc4?=
 =?utf-8?B?aFZBc1c1alJyWEVoZS8wd2tFbXp3VlB3SzZKM2ZLNGRON3ovWUhZdkc4VlRY?=
 =?utf-8?B?eDdRbkVCbVlyd2J3d2lGZlo4UXpJM2dXOTJ0ampDd1lTVXVWVGZOVnU4UUln?=
 =?utf-8?B?SXVqc1BwcHF1OGxZR0xXQ0Rqb3FXb2VYcXd6WmZGWTZOZHJPUWoxRkN6TkNQ?=
 =?utf-8?B?am92LzZFekpxdEtONUhDWERuTmNyeUl5MGtOUHRSS0pOOHVESW9aeC9jc25u?=
 =?utf-8?B?Q0J5anhGcjVuL1JvYWZqRktSMGxuQ2tMZVVvMmRJRFgxSHgrdXhpSUNnbklR?=
 =?utf-8?B?U3JudHRLeVByd1R5aUtyV2h0ZlJFTzZibDlPbFAvSTBHYVRFd3J5UHcvN0ps?=
 =?utf-8?B?L0VWZlNueVRCREZhQWNnZG4rR3JQNm40NUlHZjF5N3RRRXkxRENjZjdPaGZS?=
 =?utf-8?B?Yi9vV3lUQXBROWcxRmZkY04vVC9ZaGxBVTcrR2psUGxMNVhTVkRLdXloQktY?=
 =?utf-8?B?WllESk8rVmVrTXJKZGxXSm9JOFRuSUJWMGF6c24vT1RkcHRvR0JDWndoOHdV?=
 =?utf-8?B?SW1xWjR1UHVIRlZISzVIMXJhNnprMzEwK3VQZ0Znb0xrMjQwbWZxa29mcnQv?=
 =?utf-8?B?VnRGSG1zRVBUVVhKU2xKbjdQYnNubldRNndiZy9iU1UwMUd5VkI1UzEzZGp6?=
 =?utf-8?B?em82MFNmR0o3UHZ5cUw4OTJDSzFBa1p1MEpTeXJrdWFJeExpcktLMXJ0amNs?=
 =?utf-8?B?ellGcHBKR3l0VnNNclExNGxGVHArR3pQZkhORHBNYVp6YU0yUWtpVGxZSDh1?=
 =?utf-8?B?ZnpOZTFDeFVETytlU2d5KzFvQ0MzMUxXaVlQcytmN3BnWFByVCtYaGswSUhi?=
 =?utf-8?B?ampFMHRSZU12Vkgyc1VhQ3dhSTRNZC9EM2I2ZXc1MG1zZ0l2cjd5ZEZPWEJH?=
 =?utf-8?B?OHk5eWluTzhvVGMreHpQTUQvTnh6SmQwNlVsNUlqZWxmVTZnUk5ZeW80MnpC?=
 =?utf-8?B?VkNRZnIxS2ZrdTdCNDBlR1dtcG9iY3N5cUpSNDRQZTM1SjVQZG9GOEU4SXdi?=
 =?utf-8?B?NndiY0ppSExLWDJtUEtaTm1LQjB3MGpid3FSK3E0ZThkM1U5NXp6Um5rL3BP?=
 =?utf-8?B?RVZLdUk1Yld3YmV5UHMrcDZhTklqK3Bnai9ZUTQ1VmxWZlAxcmcvVmlTNGFE?=
 =?utf-8?B?M2Z0bUNpT3drRURiUjNQdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVczUmZBVTlvL3NCdXMrZ2lpUFBHN3RnN1dQYlBqQmdmTytqZDZUV2FpZEE3?=
 =?utf-8?B?eGY3RHlod0ZoMWJBSDRqZS9LK29KbUhQVnhjR2E2MzZsNlRSYnhQbm1meDhK?=
 =?utf-8?B?VUpTMFFIa2h4UzJrZnd4bzdmcllkUUJSVXlRZjFvbVdXMEtUZHhQTjk2K1Ex?=
 =?utf-8?B?MnVacldNRHJVV0tUTjVPZFZ6cXBJc25lZ2RhSnRhR2ozcEwyMmN6UVBTRGhK?=
 =?utf-8?B?Uy9JaDhTdWNINW4yNUYydTRCSHEwSlhrZVJPNEtDOVhyeWtJTHNnY0FZS0Rt?=
 =?utf-8?B?cXVBOUZWL2t5UUJxc1lvb3hyV0RlcUVkb0paVkJEU0hTZFBIam1YMUJ4d21B?=
 =?utf-8?B?QmhWMWljaE9YbTRWOGRLSWxpTGM3dCthVm9BKzQvSlh4OXBRSFF5bFIrMURp?=
 =?utf-8?B?OW5XdWFzVTFYMGtFRlJsRmtJNGZmTmI0YVBtSktKVC9wZVZTQlFGdTNvZ1RB?=
 =?utf-8?B?RFBUdXdTdE9HRjkvc2kzS0FOeDk4YnlPdVJaSzNJaENWUVpYOWZySXdzZzZw?=
 =?utf-8?B?emNFMkI5SmpDY2FTUlFVRkluTHVBa21HZys0Tm1iM0FpUFZ1Z013dGRDTWJu?=
 =?utf-8?B?bm80K3NpRWNxVFVSMkhzMm5nU0dUdzRCNXlwTFA1dzhQMmFzaHAzZXFybUNV?=
 =?utf-8?B?ZmpEU0dDU0lLK0xOdTF4YTZZNE5IajFnZlJlSVNMVzZHQUg2elZBUW54bk5v?=
 =?utf-8?B?cVRnVExPZ1g1dVBEL0JVYmFJY20zdXhZQ2JWL2pRRUdESUlIYmdidDlncHFa?=
 =?utf-8?B?UFZPcTRNN25XR3BmRGJiUzV6ZXU3bFhtNWN3VVM0SlFXWjFPUTM2R0FUWjVE?=
 =?utf-8?B?UWM5UE1ML2JaRHA0dHBWVWd0UUU0TlBDenRzcDdIU1NlWlIwbzRNeTA0TjE1?=
 =?utf-8?B?MUJDTTAyV2tnSTBaYzFqZW9WRS9mN1dZdG1MUlc5SlZOcklHb3hkS3JaRWVN?=
 =?utf-8?B?eGV5MmZ3SC96OVhFQWtYTE5WNGExekV6cjBrVlpIZHBPb2J6WkQ2OTFHa3VX?=
 =?utf-8?B?MFRxd093TTY5bmdyUXVvOUZzR2JqbHpPZXU4TmNKWXJObXJzbjhWNFJxdUxG?=
 =?utf-8?B?RkJXbzJsQk1BczROYjNOSmg1R1pxTkZDRmh6RDlwVDVidHFSQUZZODczQWhw?=
 =?utf-8?B?NWJKVHdYMU81ekRpalAzcW1TVUNBVXYvWjhUWE5TMTlkVWxnVFpETXNWSm9W?=
 =?utf-8?B?ZWtrSXM3UGxiNHVmNlJUUUp2dUFxa0NaV2pBMExNZVZ1NUhOMUtaUXh2QmFv?=
 =?utf-8?B?dzZ3ZFNjVnlyQk4zeU5hSktpK2dyTlRzd1lqcG96Ym9VSVNVd3VFZElnazQ1?=
 =?utf-8?B?TWJaekhwcmpaM1NabmlwVm5MN2FKSXlhVk1JUkRYWU00bHFMOTNxWlFPaWF4?=
 =?utf-8?B?TXpZYVA2MGgydWFabFYwZWkrcVFpYkY5b1RDR3BZMU5yOVh6S1IyTFh1dUVk?=
 =?utf-8?B?bndFYUJld2t1dXNyL2twdEJ4SVVPSHdBWC9iTXBKZGVKczl2U2NUY3MrUFlo?=
 =?utf-8?B?LzhacUpHdU1CQ1lnT2xBejQyR21LdHNiMmJhb1VQOUVId0NaRTcvTFFrYTBU?=
 =?utf-8?B?cHh4aVh6ZXpMYnpUc09PVmNvcUpGRXkvRWhJKzhyQncvZEF0U0tkTWdLNGRF?=
 =?utf-8?B?WVJ6QkcwWkpkeno0SEZXOUhKN3RSbytaQmFrc1kxclFpUWl1MW1rYlgzOHA1?=
 =?utf-8?B?WGxYWUdscmZUa05Bc1JQUUZuTjZ0dmhKbURSQzFNVjJnZndJTkx4ck51MmVt?=
 =?utf-8?B?MGM5RkZ6eUltTHpPRVVVY2x6cDEwZFkzUk0zZWR6b3VpVENRTHBDTHdackVh?=
 =?utf-8?B?Q2d2MmJEUkdLT2ZxS0puN09abTRZQllwMDJpcFduaHpXQ0ZBTFQvd2FTaDVE?=
 =?utf-8?B?RHlkV2Zwb0lybjlOUUlkR0Z5YThFMXRsU1pFYkxmaDRKeERNaXlUSzlzSDlp?=
 =?utf-8?B?dUk2cFM4Q2ltcWc1SVIvai9VZkNxSWtOLzR5STJQSDV1WE5SU1hOSDFkSjFm?=
 =?utf-8?B?NUFLSzFJSUtXenlDQ0JHMWxEKzNEemlZOFFiYU9vdVdkc0dYUU96WGxxSDZ6?=
 =?utf-8?B?R1Y3K04xTjcwVmRmdkZlazBRdDV4OVpCN3FzNEc1WVI0SnhWeG5LSHFQRmdR?=
 =?utf-8?B?YmIyTU5YNFhqenJ1SEJzTmx5enc4ZkU1b0JkWE5CODFtZ2NOSFlod0EyTFZk?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3daacd3-5812-45b8-53e3-08dc976e2336
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 12:30:47.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7osjWV1VUwkS8Zip8FjigslhlsJZ3rAyaKG4MKavaT92Y0HCaV67MiMJ9uzoaF0Bm6ESvCKzYhh/C1zixT5zGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6630

Reasoning would be good here: This is needed because U-Boot on the board
is not providing a working DTB to the kernel, and therefore we need to
deploy one here so that patch 4 can inject that into LAVA?

On 28.06.24 14:21, Yi Jiang wrote:
> Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
> ---
>  conf/machine/rpi4.conf | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/conf/machine/rpi4.conf b/conf/machine/rpi4.conf
> index 3c0607e..c24bc4c 100644
> --- a/conf/machine/rpi4.conf
> +++ b/conf/machine/rpi4.conf
> @@ -30,3 +30,5 @@ IMAGE_BOOT_FILES = " \
>      "
>  
>  IMAGE_PREINSTALL:append = " firmware-brcm80211"
> +
> +DTB_FILES = "bcm2711-rpi-4-b.dtb"

Jan

-- 
Siemens AG, Technology
Linux Expert Center


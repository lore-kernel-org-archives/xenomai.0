Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2D3A7F7E
	for <xenomai@lists.linux.dev>; Tue, 24 Feb 2026 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951005; cv=fail; b=tHegYG4jLtvpT3dPh6lFHWaehmIfBt8bwdB42cIxwKKiKAO3kLUnlGzwYt8XIf8YAAVgHD6r5vGaENDjVW1KpkRIbZPUf/kSvObMHCCQuZLRCwo6tybRx3q0ubgVsGWSw16+ZtnUyAQSKONlPIXBBvjcA3V1m3pJS1AJIno5UI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951005; c=relaxed/simple;
	bh=fCkj0VWLp/1MZehh0EXXHKECX9cm6/K7r9rwUu9Q4Zc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PpCyQ2bxQ+OwNm4wokefu8rhhYNfAc0eGlyW6gy4wrVahk4LyudQm8u1TjTMJYsx08sQo/Rjwn/14RsyYjmHtZnBaBtcNRYB3PeVodZd2OdLWd051TusLFWe+/14beCtE/J5eUpBaUwtX+JgTbzlSa2brpjht9RSm6UEvbqgMwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OmHsUnNn; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OmHsUnNn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unfrUSTxDxQ9Q7naYS7X2TjkND7H7OEAncJbSQtZKuakHLoVdrLmZSlJ4aU6IoIj8eeC+iNiVuC3BVGTcHa0YUggapfeYixzq4xrFj42l7XOdex9vROb+KdUVr1fbLhJH1dMPqL0r6PpscrJrTx2Q1ALsToQxXpiSga6a3zaSAIuP6ipDho2NZVcEtdDYnCp4iq8XZQQ/b2TpsjLhLp0vxULY5eOYnit+MdTsuqQlWef0ZdxPVhVbcSd6j9n6aUkS6yVw7FnhU4O2EWi0xUGANj6mIjWPSRLZxR/TdQhK3fih8iNeqC6CDZQOqiE+x/7Ta1Pu+UGySBCzgVFKg6dhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIiEudquRUz2SiqHudX3JWxT7i6lWmhyXFydcL2pjbA=;
 b=VX7pQ7MKzZ+/SyabHdHYzD1VjbbgbpP5W8/96ob2Bwd+r97OBR0cbxeIa/xNoWY1vsMIvDaQOgzPiFP6vapZQtluwdktKtGMBsYyzRRfG7QjLS386fjPHOxslfH3g4PuR4TnXDR/5BPYwd6o2hkxcr0FO+iNbAxRK3Xg5r0HGrsw9gLRSqs1MTKojlirA/ABzj7WkHYst7LWek1kSMxZLCv9jPoXuOK3SEqKxfW8fnZAuD3vJS6rWjbZgcNTUtYkpW1IugxyrOAd+dDLhGDXxOiVQ94Ucf0mHr5qqHwTrn1AaIDpXPA2oLhBjhErxOEFBOsOgyRexdXtWBavtCmC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIiEudquRUz2SiqHudX3JWxT7i6lWmhyXFydcL2pjbA=;
 b=OmHsUnNn/pJH9KKFQJO85dJNkgRtxJySLAt8QGy6dhQ6cbM6LgqhiVj4ptAmh1H70ZjXlQbKQzqwHBKsQ2Xfugc5ZlZVXBWsUp8wfhZDxedCo6p2B4eabiM/75XFjcOAygceTC63oVCacfwd0P6Srcz5RC6lFz/Qiv1ukPsTCwhl+X6enPT8WDafiK7laXMdKIQ7GFBF4rMOur0cHRT6zx0s3zVgr7n57xgOgEMCLFo207NNfxAAjc4Qxksq9deVvGDXNBU0dWQWbP2kV3LasNKueoSYIS55y2XZKuAG+Qz/WWfbB0cSUfcasF39GtGcBGW4OWat7dvBcGOKTpjOTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5549.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:308::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:36:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:36:40 +0000
Message-ID: <704606e6-fbab-481a-aae6-2a3365cb7800@siemens.com>
Date: Tue, 24 Feb 2026 17:36:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cobalt/rtdm: Prepare for new signature of
 mm_get_unmapped_area() in 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
 <20260220-wip-flo-prepare-for-6-19-v2-2-222effb01976@siemens.com>
 <918f3284-3b30-40a5-9db5-19222ab74f8c@siemens.com>
 <4e89f7e28939cf5b8c699633a87c82012c43593d.camel@siemens.com>
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
In-Reply-To: <4e89f7e28939cf5b8c699633a87c82012c43593d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5549:EE_
X-MS-Office365-Filtering-Correlation-Id: ba58b5b5-c7e9-46cf-5959-08de73c2e2fd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OE05eS9jRk9Kdk1RT3Nvb2dVSk5Jb0xYcDFYaHFmOTlLY2t4NzM4OWdVYlBK?=
 =?utf-8?B?L21KUkZIcTJ6VS9iYWxPZVFBV1k2RVJJNk1zM1hiZnl3VFBQMnhuV01OZTZU?=
 =?utf-8?B?QXRZZ2FiOU5VU2hIaUtXckFYUVZvM3dmb0RyNGI1OGtNQVRsS2pSL0Zmd0VQ?=
 =?utf-8?B?Sm5WdWhKbnFhNHo5NjBWMUFWQ0w5Qy9JZzJDVGMrR0IwUWRiUXJXQTZsWUFW?=
 =?utf-8?B?bUYzU2NUWFo5T0tHTVY5aDQxWldxSDJGQVkvYjFrdEJqWVh6NWlWSllUZUZl?=
 =?utf-8?B?cy9jYzdSUStXdStFVkdQRDRWVHZtVHJnemZnTEV0TkxLRFdMNWxBbWkzRVpi?=
 =?utf-8?B?czVNcXdRWmVsSzNJSjZnbDlWWWdaYVRQMVlla2VQSmhFSXpoTHl0OXZ3M3RI?=
 =?utf-8?B?L3NZRHVTbmE1Q2NDU2J4bTVMS1RkVUc0cE5uMEw2MlZ6azQvbVRFM1RiZnh2?=
 =?utf-8?B?UWR3ellqU2pBeE9kZElSUUprRFlTQ2VyM3VMRTJmNXRQWW1qTkN2VVZVMFFi?=
 =?utf-8?B?ejd4aVBMenFRNml6QTIzeFRlMWZvMVBjYW9ST1E2MHh0SXR6UDhnS2loQmQ4?=
 =?utf-8?B?TFZodTJOREFqb0NrQWNrWlp5VUtHL3o1UDhwZUdGZSszRXRaM21hUlZKcWFZ?=
 =?utf-8?B?MEpmYzhVcHVBVVIzRnhEeG83N3Y0V0RLSkQyUGpYcXhsZWpGU1JzTkcyT3Q4?=
 =?utf-8?B?Q01SL29EM0lGamNrUWsyY1ZnMU50cElzT0tSUEhtMkZZK05YL1o1cVhaT3gz?=
 =?utf-8?B?STZEOFNoTDhGQm5uNWdaTitPRTVDdzRHQ1V4TEpaZVhqWUNMeTlhTngrTFBQ?=
 =?utf-8?B?K2dyYXZ4THE3MnllOHNvK1lvSFl1WWs4NnBBUFc1TkxxUGc3Vzg5aDUrdE9u?=
 =?utf-8?B?RTk3UEV0K281RHVpbUxTTHVPSE5CVllzU2NjQ21zaXJIWU1BaXRjSUlWakRt?=
 =?utf-8?B?MzJWc2FQRUdIc3l3dUJ3MkduTDlVaVpXQ3RIdFdYT1NwZUJSVUh0c2JleXRC?=
 =?utf-8?B?NStKZ3dZbWVsV3RMUXoyVEI0aTlwYXpiSFgxaXJaUEdyRkxCcU5BcXdORXBW?=
 =?utf-8?B?TTQ3enhTMDVEancvRjJUM0dCMmFUSUJtSW1XSmpUbi90NkdxSzVXdFp5MzBL?=
 =?utf-8?B?Y215NFBON0JjR3Zsc1hyRVVGK1lOTmI2aHpKODBCU2VOTVk5R01pT21HeVV6?=
 =?utf-8?B?Z2hYc2JwMStXb2V3Ly9zaFM4RW9xMWVoQ0ozdFR4RURoeW5ESUhQSzZuRFJS?=
 =?utf-8?B?OEEvUWV1aFk3TUVaWm1TL0ZhU2FXUHdiMUlYcUpyUmpLa0RDblEvYlZZQWpE?=
 =?utf-8?B?RnB5L1I3bkpCandnbmlpS1N1c2ZkTGh3czgySndUaHZpSFZIek8wcU9WN0lO?=
 =?utf-8?B?dkFadVNUOWVxdEpOTmxzQjJWWWRVYzVpanZYSXhMc054RkpkSzBza0VqOFNn?=
 =?utf-8?B?WkdVSXZKckt5emtKSWI2S0FkTzJncHdmaWRPM3JtNDczOVhlZEJrbXU2VUFE?=
 =?utf-8?B?TWl1QkJ6YVk1WXhla2ZoQy9wZ3UxUkNsQkVSUjRFV2EwZkk5K3RocUk3dmNj?=
 =?utf-8?B?U3NGRmlZRW9WVURzd3czUEt6dmllWG1UN0NCejk3eG5WUFROUEZNeTM0a3p3?=
 =?utf-8?B?TFhrRmE4aWkwTzhDSnZiREpUV0xDOUdQckR6WkU0dUNmZ09KWU5MY09GcVVm?=
 =?utf-8?B?aFl3cGFleVNLbm14NnVYN1ZiWXpyd0o2TWtMdnk3RWxGUkg5UFpPTGpLc29M?=
 =?utf-8?B?N0Jsb2UzSnBDVHUzT3dEdnZneWxZcngrU1BaZ3BCU3k3N2NraHNHNHNIVW9o?=
 =?utf-8?B?NGVQbGtoVGRmYlljQkdVeUdZSkk3MlU0Q3BIalFzQXlXcUhQZEdCVDJ1TXIv?=
 =?utf-8?B?Z1JjTjdFbzhYUGkzREYrOEltTnRCRVBsWnBBcWZTN1pLU2tPNWpBcGRDcVRz?=
 =?utf-8?B?OE1nTUVCTTRPUU51NFBIMVZYek1UcUJ2QU5uM1o5RGNOeThrMG5Lb1dCZjIr?=
 =?utf-8?B?dEFYTUgvUFZIL01mMXBsdFRvQkkwNDFhQk1DU09IL3BFR2x5WXBDVmZCWm11?=
 =?utf-8?B?b0dUbEdZZm9tQVNqd3FVY2VLRVByaHZpMndKcmRpU2I5c3NjTWVrV1ZaMGEr?=
 =?utf-8?Q?8RU4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjhhWGdTcFRJTFFWdUJKVTEzakRYWXRaWE43TVVNTm4rWEtZSG5ZREF1MHh3?=
 =?utf-8?B?SkdKQncvdm5jRy9LR05pK0RScWc4RzFWWTFHQkR6S3pLNFoyK2MvUG9yV3Z0?=
 =?utf-8?B?MEZUZVNYOHMrWFRGTzJjRnRSK0xUdmc0d29Va0pvMTU2RmR4RUFFYkNKR25Q?=
 =?utf-8?B?Wnk3WFhOSDBFNnZUNEsveTZwVEM2N0p5cEp6aXVYbE9lYzlPOXFrNmlOSVVk?=
 =?utf-8?B?NGp4OTVGeHY1ZU1rRWlrM25NRUpvN080V0RhMGtZaDRQelVXL2wzNmRHN24x?=
 =?utf-8?B?eUdIV0tLOTBQTEY5RkNxM0FNK1dBaEFBb01KVk5Xbmk4THBTVjgxRkdmQy9s?=
 =?utf-8?B?MzVxWEIwNTE5cnR5VFRjWTVKZDVqRi91ZmNkVEV4RlAvYTVvWTk5V1VNTFp3?=
 =?utf-8?B?VmNyQTM1MStKbVVaTnl4WThqQVcyZmI2SkNZbGFNZWhmbjcvWnNnb2FQNXYv?=
 =?utf-8?B?RUI3MlIxRlo3L1UreUhJelZOcTQ2Q1EzK2tpV3Y0eENUK25talNmNVQyZW5E?=
 =?utf-8?B?TmVUUGNjU2NobVBTRlE3eHgrOUpFcjJlWkYrNW9pV0ZQK0pieHpFMmxCQmFa?=
 =?utf-8?B?SzVLaDVkUGxIUk5HMkpTQlFhcXVlY1NMbHJMVUV0cStmZExtRWFWY05GMzd6?=
 =?utf-8?B?aGdjL1NmcmthUUdkclZZeml5TTR1WVhFRzlEMER1RUZDUk5seE9CRXdqbkNt?=
 =?utf-8?B?SmVDWXJqWXhta3k1RDI1MUR5ZkFHQzlUOXp3TEtMMzRyWDhIVG5uUXh2Q1pV?=
 =?utf-8?B?QXN4cGlGdmo5eUp6K1BlNkk3YzFEMlZ5VGhnelNjZFp3d1hxc1ZubXpOQzRI?=
 =?utf-8?B?aVFVdGRwODVFdFB6R1VEVTR5elZNME1URGlMQmVhcitBdEFWMitMa1hpbFN3?=
 =?utf-8?B?NWtuZHJHallVdEh1bzYvSmxZeW44VWdJcmpXMnlSeXdCLzNwM0hJQXVGWkZH?=
 =?utf-8?B?WlVEUHl6dGIzOEd5eExTT2gwcVBMMXgxSng3WVVkblpuTFdQVlVGbzljQklk?=
 =?utf-8?B?YWptZnZiSVdyNnRqdWpmTFZSaTducGw0TDlWOEZiLy9ieVVzMWhmWmpyaDJI?=
 =?utf-8?B?ak5sM2theDF0dTMwQTl1bk8zT2trSHNvdERrZ05IaE90VDhqSi9YODdPZk1v?=
 =?utf-8?B?SmIxZHRGUmpFdU9kUDdrZFBrSXJ4WFhnZ2piVFl3MkpQcDB1dUNLTE90TmM1?=
 =?utf-8?B?VytNYmRxUUduOWtWQzJIZVBWVm5NR3NoN0FJNkFqK3hxb0EwQjZ2MVFtcFBP?=
 =?utf-8?B?QWlmSjlVL1l4OE9URTU4ZDRrL3dFa1FvMmdMY29Ua2t5YllwV2l2bXN2TUpy?=
 =?utf-8?B?RTZPbTR2a1RtUW1HTzhRY1E5emdwdXBUZzEzcVZ3Vk9IQTZXRnhQd1M3ZjZw?=
 =?utf-8?B?aGF4WEJ5ci9HNmdiSTVCMWFqWXhxNTh0dWx6OUlOT1lOdU43NmJpZ3NRN1JI?=
 =?utf-8?B?UmdnajVTQ3gwN21OYlRWWlp1VzlTUHRVbnM2UzJsaEdpbW1FY1BhUFFJblg0?=
 =?utf-8?B?dS9CdFdQa0FDNSt5NlZYZXJnSXNtekJOYW9acUZoY09vN212ZFJDTHAxNkY0?=
 =?utf-8?B?dFVXUFAzYkVjTCtkWXE2SnRrUkNwZ21tYXRBbkgxQXU5bWpUbURYU3JGbVpm?=
 =?utf-8?B?cGk5VFk0dmdLUGlDUG9panZwbjFNRmhseEdaRElxQ054amRxTVp6RkhnbzZh?=
 =?utf-8?B?RXVSdUpQNFdIZ1dxSDRkREpyT0x2WmdiTVgzbDZLeFlEVTVrNE9ZOU45WHFD?=
 =?utf-8?B?eUdUa1VXTEtiU0JmZWZtbUFGMElMVjJrMmNabXpuN2VvVTIzVERBbkFOTmR0?=
 =?utf-8?B?OWNqYkFCRW00UlVCZ0hGL0ZhUi8rc2dyMUZ4aWpIQlhDLzdZdWZZUWZKUnpR?=
 =?utf-8?B?akxxL2FKWjBxNmVjSlc5QlRvQm5KZ1F3Ym9POXQyZjRYN29BMHdRZ05HU0hZ?=
 =?utf-8?B?N1RqUGNSeG9Xa3R5YkduSElQSVpzc0hTQit3eG9nT1lTQnFEY29WTmEzcGNG?=
 =?utf-8?B?OUVGeFRYU2ZCWTIyU05ON1Q0YzgxZGw3bTdHdGxFNGJwV0djUzJDRWVjQTRO?=
 =?utf-8?B?c3VzWEh2SG5YYk0xNW5VdmcwbkNSRGxGZU9vZjhpNTBzdFZMSldTNDB5ZmZ2?=
 =?utf-8?B?K2dYWDhqT3VRZHUveEpEczVvQmZUeWdiNkhpcTNLc3ZGbHNuY0djSWpNNi93?=
 =?utf-8?B?TkxQOVJLTjRySGtQVFVOVVQxcVNrdy9SVENLYzY1UTlxcmJIMTkwbDZpaGVs?=
 =?utf-8?B?cTRqeFZySXRNMjV2NmZUSVlIdzRZZGxqZWpvYS9yU1NXMGxtMUwrUVhubFgw?=
 =?utf-8?B?MU5VK2w1V3NUb1hLUVAzY29PYlJTeHBuZjBpWG9RdmJFM01yTU5RZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba58b5b5-c7e9-46cf-5959-08de73c2e2fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:36:40.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj9b4p7z3C0faUAs2A21gJka2KXXPUm6PDXDrD1vjwHxh6D+HvQoKTazII/ZpHFDQYIt5mBa56tHfzsfUiMakw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5549

On 24.02.26 17:02, Florian Bezdeka wrote:
> On Fri, 2026-02-20 at 16:25 +0100, Jan Kiszka wrote:
>> On 20.02.26 12:27, Florian Bezdeka wrote:
>>> Since 6.19 the signature of mm_get_unmapped_area() has one parameter
>>> less. The (previously) first struct mm_struct *mm parameter has been
>>> removed.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  kernel/cobalt/rtdm/drvlib.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/cobalt/rtdm/drvlib.c b/kernel/cobalt/rtdm/drvlib.c
>>> index 86788743fe47b228662ef16831b4281ddefd04ff..0258100db5bbcc04880ddc71632b7992e50168dc 100644
>>> --- a/kernel/cobalt/rtdm/drvlib.c
>>> +++ b/kernel/cobalt/rtdm/drvlib.c
>>> @@ -1907,8 +1907,12 @@ driver_get_unmapped_area(struct file *filp,
>>>  
>>>  #ifdef CONFIG_MMU
>>>  	/* Run default handler. */
>>> -	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff,
>>> -				    flags);
>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6,19,0)
>>> +	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
>>> +#else
>>> +	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
>>> +#endif
>>
>> -> wrappers.h, extending the existing logic there, using the latest
>> pattern here.
>>
> 
> Just realized that this function has more history in wrapping:
> 
> #if LINUX_VERSION_CODE < KERNEL_VERSION(6,10,0)
> #define mm_get_unmapped_area(__mm, __filp, __addr, __len, __pgoff, __flags) \
> 	(__mm)->get_unmapped_area(__filp, __addr, __len, __pgoff, __flags)
> #endif
> 
> Kernel versions < 6.19 will need 6 parameters, >= 6.19 will need 5. The
> callers of the wrapper macro must agree in the number of parameters.
> 
> As we cannot touch other callers (Linux code), we have to align the
> caller to the kernel version. I'm running out of ideas here...
> 

The wrapper will only affect Xenomai users, thus does not need to worry
about other code in the kernel.

I'm not quite sure I understand the problem now, why you cannot
translate the inline wrapping above into a xenomai-generic one that
expands the 5-args call to 6 (using current->mm).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013057.outbound.protection.outlook.com [52.101.83.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C76026056A
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600897; cv=fail; b=oroR42oaXqlvHTgczcBnwc+hiON+QBVzWSUP8zHNpxuQi9T0Imsg4jK/Ufw8H23J2Ox5KUBvCjVCH5QRFX1AjGXZ98n0bF12VUu3St+QPSvpJQlRRWZ/mABkUXaa2wiXIjV2DJPnU1YC9rvXZLyBqx5tOCHTRJ13Du813x/X3Vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600897; c=relaxed/simple;
	bh=0gHOOFxrrc7JtR3Ks+46aW8slVeMnn/mhett89845Xk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ugqW5YtKwQ0xTr7YDUibxTB3R/p8NYBdPNSUAIKRhPF+Xg3hAmsRPoKFxFUKP7VnxxpQtJz/VG8NAu1S8wnhxWlbCwZB7ZppUhoKvQaTuiMrMHvFwOuNRct88LTDRnt6MHrYx82KcFBb0kXKETMeYHw0edTDtLFO2HhEo+OCIrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EEac3nln; arc=fail smtp.client-ip=52.101.83.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EEac3nln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eprACwQv4VIjiY6lj16wbyKk9uGRAX4MJW5V5/rLVI7vkfUnH6t6nJRAP46T4JCiMHaxRdM3BHHcngfzeOegFmd3AmxrRVnHYZzD4XyAULi9xD77czHbrTdHCaH76sMSSRz/dNzy/aWoHpowZyOW+YQd9yTCM1Ayk5hUB/SEsTUQvrFls1LyCQ31lB4AU5tSmlfY3WTgucY6/hySexIsPTaZQKhFvNOVtw5YE+Y5z+sDkRgcGHz3SkQcChvCe4VT4px8cmPjhTwdXeKqlVcSul44xnsQ/dANr08AQdL/meAGBlTyi83ilzfA2UjLZKLEySx4URhTswMZpZOoXXqREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRgXoLSAEu9dRvdUhR8AQC8JZtxQnDIQM9TBD9UOovI=;
 b=xw1qqo5n4Gu+cdDUta1i9LFbparOQxZHUsViYEtlAi2+ktJtczdHl6w4yHyC64F8LWLtwtCM6su9M3o6WlpiBryAISK6tFocJD0dfmbQMfaj/PoOqyJy9KjSGvicJ+eyTbaJB0ykLEVjuzeaKoHizC71CuXlSCYe56y1ZtoPzbYM82rJxrJIiEi7beysgSZHRda/ehrhXqnNvjrKY0BRhDzo7cwyGLKvEKVUmOvmxwrrHBXBTEREq3WQEZ6toQkJLX8vzwvj749JTSwnbXz9XJV1LSaZ1XHa88x9Y8tvBgA03mbEWY0X1CCK46QIDD2GtCJPuk8JkclbcCy67Vg/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRgXoLSAEu9dRvdUhR8AQC8JZtxQnDIQM9TBD9UOovI=;
 b=EEac3nlnoX6k07ZxMEBGjHt17EWxUZC2uFzduSuWfRVLXTfCytqmMblDV72Ja3dktYe4NqnyMGoDzq0p/qHl2hY8+06wwW2wx4O1to4DGh3ebQNxAc5Ykzy5cZ2XHd70R+JG6dspSoROifS9DQ9DPR/Eo0ifAsHDUrEI6Qt5+//6GoiXdKGw2KIcMvBsiL+KckUqHkP1yLqr1uYYhPzY/GKU9lYHMuJkolopl0rxcY7Z8yq5+kQloQ4XBJF/GIR6vC4YdI+Edk/b3qf/Nk3437F9lhgettU5v5BghIVqa+d61YdBaS84INJMMFZkEC+NjGZMdN1DEWqE/J+8vo3Yjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3502.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Fri, 20 Feb
 2026 15:21:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 15:21:31 +0000
Message-ID: <cd55fccb-0578-4528-8609-0677c77e6e99@siemens.com>
Date: Fri, 20 Feb 2026 16:21:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cobalt: Prepare for new signature of
 __request_percpu_irq() in 6.19
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-prepare-for-6-19-v2-0-222effb01976@siemens.com>
 <20260220-wip-flo-prepare-for-6-19-v2-1-222effb01976@siemens.com>
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
In-Reply-To: <20260220-wip-flo-prepare-for-6-19-v2-1-222effb01976@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3502:EE_
X-MS-Office365-Filtering-Correlation-Id: b96fb091-0a67-467a-61be-08de7093b9c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2RDdy9QUUJ5R2hZeXRLblNKTVpJL1ppZElJMlpTN3pBM01HenBZKzV0RXpT?=
 =?utf-8?B?b0s5cXNGU1RJdm5BcWNpRy9samM1OTV0Y0NrSkI2QXZXRWQ0WXp4UDhjYUsr?=
 =?utf-8?B?MVhnZ3ZkQk54YUVGRUVSRUtUUGk1Q3laWE4vVmpteHZ1dG1pZmloYlh1TmFS?=
 =?utf-8?B?d2dyd2ljNGZFcTJEMmR4dnF6Z1llQ0RWRTlFeDE3L282bG16SlhvTjZsdDVa?=
 =?utf-8?B?b0pnLzNEbFk2UTg0VWhRbjJlL0E5OWFLZnBNcWhFSmhIVmVhdXN3REltWmwx?=
 =?utf-8?B?b1BmbEw4VUJrdmY2ZWkveTh1L3pFQmdNdko3RnZMOWRkVnpYZFFEanZSODRx?=
 =?utf-8?B?czVWajQwcWdUZlhlL1ZuYWFBYnIvODZybWU2V1l1clozTGQ3WlBsM2JMdE9a?=
 =?utf-8?B?UFpzVkJrUFdaVy93aDB6SVFkSWpUYXcwVi9ZekJsWXI5YTlmdTB6cW1qSjZS?=
 =?utf-8?B?OG1DOEVEN3JVb2pvamJ2d0tzZUpsTk4yRHVWWmV1TldPeTFLRG15Q2pqV29w?=
 =?utf-8?B?ZUlOM0t4UVdNOGhlMWw3SHlmTWVRRHN6dmdaQmIyRlJJeTVyeWJIY2N5Rk1u?=
 =?utf-8?B?UUtkdCtoZ0xucTYrZzZiSlp5Y2N2bUNHRjFzWnlsSU1BUHNkTTNFbXRtYTRN?=
 =?utf-8?B?UDF0dld0NzlIeDhFdHNodjEvQ0RFcm1kcHFwQTQ5UG9UaERaWXBsZHpCSnZ3?=
 =?utf-8?B?N2J6Z1pzSG1HSE1QQ1NiSEFoUFpTbU84ZFcxWWszaUVKWnNIZ2NNTCt3WnhR?=
 =?utf-8?B?RzF2eFFNSVFGRXZxb1BLcDZCRTZiQW5FeUxjb0dUT3FweldaNFJQSzJFTkx4?=
 =?utf-8?B?VFFKWGM5MTRGNU56ZnNkZVBRd0FiM2NDbHJSc1p1eVUwL3hpOVg0Z3JMbFBT?=
 =?utf-8?B?WGZ3RHpiZkl6WWhCRjNaUnVHUlEzeU1senU5TWhVN3p1VU1nOFgvcUgrY3NQ?=
 =?utf-8?B?TCtiV1QySy90bU93MGVZMUNlSUlhSFZ5OFFtWEFKdnAva1ZpaGRUMy9pS3Jz?=
 =?utf-8?B?am5pOVpRSVQ2b09ZbmxDZE41WVYzVnpmZGpjUjhnZWtxY0dHcDl0K2hCK2l6?=
 =?utf-8?B?UTNSSzhFWnhycnhrUThpYzY5Zjl2Vno1T0JyVmFmQldlcW5aekxvNHRiaXUz?=
 =?utf-8?B?d2llZitCN011VWJUQi9JVWdVLzNIOXBFMXdFeDQxL0Zaa3h5Ykg3MXpjaVZu?=
 =?utf-8?B?aU9GWXp5bHJNOWpZZGlXNkxha0YrTE9sQjZXZU13Z0dtcE8wSjdtWTF5MnpU?=
 =?utf-8?B?T0ZFMEJlcGVIbXk3blZTd1BvZW1XWVJ3My9mczhPWkVDMyt4bkVCY1NwYTJT?=
 =?utf-8?B?K0NwMUhrcitBSU1pSjRtOXlwL1hkYzluMGRkVDNsbUg5RmtwK25GQnJHRnVu?=
 =?utf-8?B?WlZRMEpqaStodXpwcFFVUFlwRFJCZ21RZTEzOWZiVGJjRUlVSExZbElYWDRY?=
 =?utf-8?B?UVJVNHltZDRMNDdodTFRODg5RWxyaDhVRngrbStaUzRQYUdnZThsZ0ZsZnUr?=
 =?utf-8?B?NHR5K0FZSklBUXBFR3F1ZzVoWDJVUFB2NCtXenpuL2IyK1hOVmFtVFRrbkpH?=
 =?utf-8?B?cFgxazlxd3E3c3FIU0J6cVE1NFhWdW5BVmhlUHM0ejJMd0l2bGVhcXJwY1Z3?=
 =?utf-8?B?T2svczVXV0laVEhlWU5ITUlpR1BEN05yMC92d09IT0pncVBNY3pEUUFqRkpZ?=
 =?utf-8?B?T1VyTWRlemtrSlk2RllIR3M4U0diSXhwcmJtc3RlZ1dGR2hZb2ZVeldOWEJh?=
 =?utf-8?B?T1VUWWNNWkJjeUJUSUNRemtWc2RidFJCUUszVDk4am8xYjl6ZHR4czU0QUg4?=
 =?utf-8?B?b3NXbjZIMnp2Rnl0dWV0TWZuZUNjS01sVVhyOXEwQ2UrT0FyRmFrRWo5N1Rn?=
 =?utf-8?B?dUN4dnNmaWNHNHN0U3l3aWpRRlpDZ0FxV3cwZmJRQ2QwQXV4bm9wUXZ1c1dR?=
 =?utf-8?B?U1FxOGIvSDlmK3VoV1RTVG1mMVREeGE4b244a2s0S0l1UlNwTG9vZHJFc1lx?=
 =?utf-8?B?WGhWOFhHNTY4djl6dGR3VUpnb2gwbm1GbTdqRHRyckYvUHFUWi9KRld1Q21y?=
 =?utf-8?B?d2trMUltR1Jac0RzVmNlNjcrZm4yV3BGeXU3YUMxWVFlaWVleWcwYThQOG9M?=
 =?utf-8?Q?0XuI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWxMcDdtOC9VUFBSUzNXNU9xUlJaSEp3VjJYc0xpWkZDbUZYZG90UXMwcHY2?=
 =?utf-8?B?Mll2d3g2RWhlbXBTa05WbDE4NjhrZk9UZmNITitoWWtVc005VXVXUE8xQ0w3?=
 =?utf-8?B?YWNUaFdLVlkyUytJQ1hkSUdCZ0JnSi9odHVEZ25oelRwaXA1Um5VdEl3aWlX?=
 =?utf-8?B?bXdOdW9xMkNaTnFWUkU3cmI1Yy9QU0c3N2xvN3hVYmlHUHlSRlA1K002cm9u?=
 =?utf-8?B?Sk8ySWhtazRwalBRa0p1R3N1OGY1NU5KYU9Cdjg2c1lLU2FHWDlaNjFMT3hr?=
 =?utf-8?B?L3Fnd2RzeTV4L21QdkpwOVMyaGc5emJtNzZJdi84bTB0aFNGeW1xM1FaRHVL?=
 =?utf-8?B?TWtRMlk0MXZjd0NwNTJ2WVRnS2k3cHg2OTZpaE1mVTBORTlMWFR1OG9rQjVp?=
 =?utf-8?B?N1lKRFYzNHUwelZrTGpyVWw1a0l5V05IVHJVZGswU0hKaTQ2OTlITWFNc1VH?=
 =?utf-8?B?eHBUMXd0ZEdCSU9LeG5KME1rbk1oNDlBZDNDNTg1bXZCR1VQTUFxejJGc3NR?=
 =?utf-8?B?MjROVjEzMk9tdnUrQTM3TVFuTktiMVFKN2RKSFJWQ1lmUjBSY3NyV2Y1WEx0?=
 =?utf-8?B?SnJjNlgrLzVmVXpBaW1SelNlbUw4Z2pabHNSd2MwVloyRFB5dlNNS2x1VlFH?=
 =?utf-8?B?cGwrWE9lVzF4TmxmOGJway9JbHdGV0xDWHNRUythTmFXOTY4c1pjZnhqdTlP?=
 =?utf-8?B?Q1NsZjQ0ZzczRU5WTG1HTkdNdklGTzFGUktYWTNDUHR0a243T1hEQjMxN2hU?=
 =?utf-8?B?ZWgyOUoxS01qeXdYVERWaHpTQ1V4VG1ncGtQYkdsdGlNaHh3ZjNwZG9jUHNG?=
 =?utf-8?B?ZDBJckpOMjBNcWVpRzdyQU9yQVg1OEZkdUZ2bTM1M2E1QUhvSmdvT1VaVzRE?=
 =?utf-8?B?a094akpaUnZSVm9JcEV4dEdDUmo1Rml4Z3A0SEdCREI2K0hjSW9iZWVEaUNK?=
 =?utf-8?B?MW5xTUtTYmh0VEtlaU96WEhnS1VndEx6Q01IY3VxYjVuTXhSSTg2SnljTU9U?=
 =?utf-8?B?NFNhL3J2T0xyNkZIRXBBYlY3TklWajVMc2xpY1NZbmxQWEllYWhBYWt1U0tZ?=
 =?utf-8?B?bE0zSDczZEc2NFA0Z3M0a2YyamkyaW9CYXZBWmFyR25IelhmS2h0VHBtRkJI?=
 =?utf-8?B?c29nTEF3R2x2Qy9XRjZlQzZYL3VXNHFib1hJdmkwNHBPamw1ZjFRM1dyNHBR?=
 =?utf-8?B?MXRrUlF5dTNkc0p5OUtZZ2hQYlhMMno0cThUMWx4aDQ1QS9FWGh6SCtFQnJP?=
 =?utf-8?B?dHUzbktWTktDeU5PZ2pWbjROMVZsdnZrN2xpQjU2clllajZOTTVuVXNoTkRo?=
 =?utf-8?B?TTNzWXVCSlZHRHNaVGFlNXBaYWVBNDVOZHBFb3o4Y1ZLcEMzTFFkVXF0RHZW?=
 =?utf-8?B?eTZMVlVJNGluT2VlNVdxcFZoM3FocHQvNXlSUmFGN0Z2SWVUa08rRW1ORTNj?=
 =?utf-8?B?cjBmelIwZmtIMXVpOFhoK3R5V3kwUG9oRTBmNEsvZEQxUjMzbFNsVit2eHhl?=
 =?utf-8?B?WVIwb1RhNGZlTFlFY1hSdjY5ZkwyUjZjeTJIMVR2QUFIa09BeFIrZHI4N3pi?=
 =?utf-8?B?NE5rV3dSQWhaVEQrenFnUGlLNmtaQ05IdlRzM1dPaGdRTFNiWmYzU1BQb0ht?=
 =?utf-8?B?Tjd2aGZnNGlMdEM3cy8xVmxpS3RWd3NpOGFuc2RTcGR1NUt4Y3o3eCtIS1RH?=
 =?utf-8?B?U3RaRUR1blFscHh1czUwNGdLR3NzZG16OTd4bEltbFdQYTJHWEF0UzcyRE5z?=
 =?utf-8?B?cmpHZFV4ZzAydGR2SUpFb0hvZVdvRlA4SHhYTEc3dG5wUEsvZER5ZmpaUVNU?=
 =?utf-8?B?WDhhS3F5Vm9sYlNiVGlrM1NUTEVVRHJiL1o3RGkwbm1aTjhoNXhUTEtnVlcv?=
 =?utf-8?B?Q2pwMVZXV0NIcHFRdUVURjBTbVVNWjJyNmREc2daenFxQTRzNEtsckkzY2hY?=
 =?utf-8?B?ZnFLdTB0QUFzRUt0M1ZNelVlQVl1MjNZdGhxdlVoY2VEdSsvMDRmOTZkUU5a?=
 =?utf-8?B?cFB4U25Wa3gxdWxrYnd3SVc5dlJHMko3Yk55UkVMd0R5Z2dmSU44TnJkQWxJ?=
 =?utf-8?B?QWFaSFFOall1MWNDNnN1ditGN3hKTVJSZzBITnhQakpPbEI2NDR3ekRPd21D?=
 =?utf-8?B?WTlmZ2dWTFJFdGtFVEdFRGpLUEgwSFgyUXBYY0RDRHRvSEhob09XbHE2ZC9L?=
 =?utf-8?B?dUI2RGFkOUxMa3JGNks5dU9ETVZqNlIwRklURm9xUXRGcmxsa3M1QWREYlJX?=
 =?utf-8?B?Z2VCd1JvWGgyamNnRk1IeFFwaWM2a0tvbHhxaVhZVVo1cWFjd2EyNjNZdkFq?=
 =?utf-8?B?dGtvbnpLTkl5Q2JvWk41S0NqcUlYWGZXVk5SV3FOUDJRUzhsR1VUZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96fb091-0a67-467a-61be-08de7093b9c9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 15:21:31.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCSs7+nbsETWI7vLKplB15Sbi7Os5SGIzfIbXcC74dXhqpLWDVetuqTT76elmXmOcr+nLx/c1sVPpzVsxEIlfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3502

On 20.02.26 12:27, Florian Bezdeka wrote:
> The signature of __request_percpu_irq() got one additional affinity
> parameter in 6.19 and 7.0 will remove the function entirely.
> 
> Dovetail 6.19 will introduce a new dovetail specific service called
> request_percpu_irq_affinity_flags() that allows us to set flags and
> affinity at the same time.
> 
> It might happen that older Dovetail versions get the new API via
> backports, so the re-#definement for older kernels might get
> obsolete earlier than dropping support for Dovetail < 6.19.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  include/cobalt/kernel/dovetail/pipeline/irq.h      | 6 ++++++
>  include/cobalt/kernel/dovetail/pipeline/pipeline.h | 9 ++++-----
>  include/cobalt/kernel/dovetail/pipeline/sirq.h     | 9 ++++-----
>  kernel/cobalt/dovetail/tick.c                      | 8 ++++----
>  4 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/irq.h b/include/cobalt/kernel/dovetail/pipeline/irq.h
> index 55d9b8ff17cd08e5e8c09aec393a1e23736c1b76..df0b8ceb05c25d655a331d238e7ef8ac8a6afeea 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/irq.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/irq.h
> @@ -5,6 +5,12 @@
>  #ifndef _COBALT_KERNEL_DOVETAIL_IRQ_H
>  #define _COBALT_KERNEL_DOVETAIL_IRQ_H
>  
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 19, 0)
> +#define request_percpu_irq_affinity_flags(irq, handler, flags, devname,        \
> +					  affinity, dev_id)                    \
> +	__request_percpu_irq(irq, handler, flags, devname, dev_id)
> +#endif

Why not placing this in wrappers.h?

Jan

> +
>  static inline void xnintr_init_proc(void)
>  {
>  	/* N/A */
> diff --git a/include/cobalt/kernel/dovetail/pipeline/pipeline.h b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
> index 2e6e66a2d6d4dbf407d4ce42fff8b84acc2931d0..f5ee443ada3788b8b0261f77ae7da5d5f69ef9f2 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/pipeline.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/pipeline.h
> @@ -11,6 +11,7 @@
>  #include <asm/xenomai/features.h>
>  #include <asm/xenomai/syscall.h>
>  #include <asm/syscall.h>
> +#include <pipeline/irq.h>
>  #include <pipeline/machine.h>
>  
>  typedef unsigned long spl_t;
> @@ -42,11 +43,9 @@ static inline int pipeline_request_resched_ipi(void)
>  		return 0;
>  
>  	/* Trap the out-of-band rescheduling interrupt. */
> -	return __request_percpu_irq(RESCHEDULE_OOB_IPI,
> -			pipeline_reschedule_ipi_handler,
> -			IRQF_OOB,
> -			"Xenomai reschedule",
> -			&cobalt_machine_cpudata);
> +	return request_percpu_irq_affinity_flags(
> +		RESCHEDULE_OOB_IPI, pipeline_reschedule_ipi_handler, IRQF_OOB,
> +		"Xenomai reschedule", NULL, &cobalt_machine_cpudata);
>  }
>  
>  static inline void pipeline_free_resched_ipi(void)
> diff --git a/include/cobalt/kernel/dovetail/pipeline/sirq.h b/include/cobalt/kernel/dovetail/pipeline/sirq.h
> index 1da9d13b217081ba52ef0444b60d236ddb9c8a9e..00c08af784588d5239cf399d69800c914221b210 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/sirq.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/sirq.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/irq_pipeline.h>
>  #include <cobalt/kernel/assert.h>
> +#include <pipeline/irq.h>
>  
>  /*
>   * Wrappers to create "synthetic IRQs" the Dovetail way. Those
> @@ -29,11 +30,9 @@ int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
>  	if (sirq == 0)
>  		return -EAGAIN;
>  
> -	ret = __request_percpu_irq(sirq,
> -			handler,
> -			IRQF_NO_THREAD,
> -			"Inband sirq",
> -			&cobalt_machine_cpudata);
> +	ret = request_percpu_irq_affinity_flags(sirq, handler, IRQF_NO_THREAD,
> +						"Inband sirq", NULL,
> +						&cobalt_machine_cpudata);
>  
>  	if (ret) {
>  		irq_dispose_mapping(sirq);
> diff --git a/kernel/cobalt/dovetail/tick.c b/kernel/cobalt/dovetail/tick.c
> index 873b62471eac758fba5b86fa36b8265b6284dc87..fa7ef09eaf39cdc1fca5c68f22f57da0c1320789 100644
> --- a/kernel/cobalt/dovetail/tick.c
> +++ b/kernel/cobalt/dovetail/tick.c
> @@ -8,6 +8,7 @@
>  #include <linux/tick.h>
>  #include <linux/clockchips.h>
>  #include <cobalt/kernel/intr.h>
> +#include <pipeline/irq.h>
>  #include <pipeline/tick.h>
>  #include <cobalt/kernel/sched.h>
>  #include <cobalt/kernel/timer.h>
> @@ -153,10 +154,9 @@ int pipeline_install_tick_proxy(void)
>  	 * CPUs.
>  	 */
>  	if (num_possible_cpus() > 1) {
> -		ret = __request_percpu_irq(TIMER_OOB_IPI,
> -					tick_ipi_handler,
> -					IRQF_OOB, "Xenomai timer IPI",
> -					&cobalt_machine_cpudata);
> +		ret = request_percpu_irq_affinity_flags(
> +			TIMER_OOB_IPI, tick_ipi_handler, IRQF_OOB,
> +			"Xenomai timer IPI", NULL, &cobalt_machine_cpudata);
>  		if (ret)
>  			return ret;
>  	}
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073E81BC41
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 06:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757314295; cv=fail; b=GZGpWyvf9LEreO2HIuUud56GtIGfjmHe4x1oMl770A5BKP0vXdke0w91utqopyW6qXx4E9KmPC1kRbXBomInkN7MDO0LY/WPI+Jpt0omUvmb5B38PqNmsDWCH0tk4moTPwRnIao3BqtThT8tHXhCkZ6XY4YePFHuQx1hyZMTR1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757314295; c=relaxed/simple;
	bh=K62qJpo8kWaTA+1tG09Jn8rObf8dL733qzlJESvvrfk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K+3B0Q1zb6hsLHeTxOBg5dTAdh91eDu5kqL59h3FDOFj2RWT1Nogh+5PQnWNNMxISe0weOIdz5RKHVaEk/a4UlIep+PL1FGO1FjciPRkbAj99albud9XeT/CDxnLgAT795wtL+t60dRw8DaAdgaNeEwvmsUpD8s0TbXhaaZ+xMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=s1ORfEDA; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="s1ORfEDA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuJGFUckVTZUOQr8s0Hm5gb2YSNfuXLnwYChesHSSv3Bjlf7P+r3PQkAw7k1yhcrQpPU1f14UiPdTNrmfuCZxtcMCDW7JDif2YPh3C/MOnr6y8k9g1RoMG4IWKuvI68/Vcd+6rQFmWQ8ZqTiYxY4y7t3eGNX4LlHfY2qcosFAi4Lg10gQQ/Aa9k+AOaO90YiuebIiFAdq7ablHjo0a3bDUR4fdFQg0r9/UcgCnS4Pq2J2MvZpc2fsfUH5Hp4SadPmdHI1280r3RmTD7CYvdE4VSkxFgXEKy1hYNrx7n1iTGZztBJ9mzaoG0e+1W2dNlxmBqu7zQqmSJBFAnzSDgZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHqXF5x2jRQe9o3vNU/xoeufQUfS2EYCUqrkO2nAm2k=;
 b=toPGAz+KYCtOqKE3l+h01ARE/boS6d9toDvh3u8DW5OyEy2LBUO1Kl5Cp7x6pp3i447HQ4zIaGQwNPijKWie+LtEHKm+qf1vGN5JqZMFnt/MhOIek4AlqH43NFbBEop36IprRSPfV3qka5AjLJI64q+RBohVjwev4Qzf2plVCge6A+sPARhPYpPpVuR8zNsF8Ahr3HHynMWpd+bRgjK7MqpVhYE7QpZiatNOPuy1v5914BKteXjH8RS9pwJuFbBXZ7JsYqRR58IPDeCILfR+Am7oVCwfPTgflmwklpCdHb3GB3UXIGbDM4TlQZoAsxeqMv8pXYhdRJjubkAqaScEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHqXF5x2jRQe9o3vNU/xoeufQUfS2EYCUqrkO2nAm2k=;
 b=s1ORfEDAZ5RoNSH090Y19YMkTfwIak5HIqJOglNbqjEc+rZ3IMjWahGTyotV5GrW+npw4+gCFjiZ9fwC8Hp0/r4RECineEr5/ysMiCuK8acqnLX7YaVAHx3NFeWxYp2wgdzbxfXQ35b1F1zJeXR6ABB+daecN8XzJ5+CHRvWfVXRJh4zoUKruFEx9MswKBtXEGTME+U/DOC0wfYxKmVBCTchqynBBWmwBWDxHmyoTEmCa6sTfclnmCUJiigE4ZJabpRr2g6w/YNBH19qGJeIsWo78mchHKt/sX70W6LM8YhSR4iP5uHpKb7QLPLYLasQN8OVYVUJvmu2vR/svy5SJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5583.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 06:51:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 06:51:30 +0000
Message-ID: <e0f650d2-95ce-469b-af87-25de450ef43e@siemens.com>
Date: Mon, 8 Sep 2025 08:51:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding the issue of rt_timer_read
To: Yao Yongxian <yxianyao@126.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
 <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
 <5a675ae.2fa0.19927496712.Coremail.yxianyao@126.com>
 <f293b971-906c-41e2-a966-a39b65e1e587@siemens.com>
 <267d379d.51f8.199280f6d63.Coremail.yxianyao@126.com>
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
In-Reply-To: <267d379d.51f8.199280f6d63.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f545158-3fd3-4fbc-417b-08ddeea423af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alI5UjI0eGNTcHFqZ2FxVmlhQm1pMmNwOUx2VFk3K2ZoNFJLdzdwTEdiS2wz?=
 =?utf-8?B?T0loOGtYSkQrTlZObkxRbG5SMlpHNm5iNGR4SUdMT1hrSjkrRVFVMWN6ZGNv?=
 =?utf-8?B?K3IyRWl4Z1lqd1dEVVgvd2Q0K3Z1d3YvRDhkdDBYWER1VTJmNnFPc2FFa085?=
 =?utf-8?B?TURZWHJpSDgwL1JzZ3o3dEFrYjJUbEpiRFMwdEdacWZWUW9IaFFnRVhNSCtK?=
 =?utf-8?B?Y2JaS3ZUWnM3UW9SYnVnTUM2bHlZUWJiR3hoRDdQeUxkNktXUVdYU3gyWEpB?=
 =?utf-8?B?K25mSHZvRlpxUkIyT1pudEFmQmJVSEtON3VoRHpRdjdxYzdUQmt4OW1YM1ZM?=
 =?utf-8?B?dUZjQ0ViM0RRTDZQb2hya0I5Z2VFcExuMDRCYVVrVllLcmE3TDVZZG1scjNZ?=
 =?utf-8?B?VTNkdWQ5RU10M2RtRU1sSjhaTytKNDg4TUFmQXlkYW83SzNWcjcxMFZ2YkI4?=
 =?utf-8?B?cXBYNkg2N2xyU0MvRnc0WW1jc1lFS0dwR01UVEhLWTUrZ3pjc0dvc3pqYk9k?=
 =?utf-8?B?bzN4c09tU0pBbXVFVUJ2cHVES1RvZnh4Q3hSMnpld0R3YUpRbTgxK1p5OGlV?=
 =?utf-8?B?eFVrdDEvRGVQd2pkSi80RkZjWkhJeU1zQXd2enpTUE40eHhXdWtaREhMVUQ1?=
 =?utf-8?B?VkdWWkkvckNsUEhIYkR5dTNyMk03Yk95NjhPUHBtTmx0MVVWOGZpMFZROFFD?=
 =?utf-8?B?OXhzdVB4U3RmdGlGRTFhL0EwNjk3TWdpVWtMdU9hTjhucjRNclN5UXFtaWlK?=
 =?utf-8?B?MVZ4bEVYeGxlNWZ4QnhqZmVwY1REaWg3WTZoZ0RBRVRnOHo4MHpyWExXc29u?=
 =?utf-8?B?SVo5RStOWEYrMHo3SnNzZU5HaUZrR3pTQVFNc25xdUZHM2NoeE94WXZUSnRW?=
 =?utf-8?B?QTZ2TmZ4WGlHM3pUcGdJSTZwUW1yNktlQWo0L0ZoZzZqQzlVemZPZkx1U0tk?=
 =?utf-8?B?Y1V1SVljeGx3SEM3OU1hWUxOeTFjcWNRcE44UUxsVmYrcFRIQkpVYlJFNnBV?=
 =?utf-8?B?NStGcVF0Zkk4Z1hrZ0N2K3pJVUhUMXc0b0tVRXg2bnRIL1VvNU96TGRqYzgv?=
 =?utf-8?B?dWI3cGc3YVQwaFZTcENLZWxDOFNZUDJvZG0vT1pWbUJ5RWxiZ0hYSnF1YXJQ?=
 =?utf-8?B?QWhQSDF2NVB1QjY5dUV5L3p6TE8xSXRKV3hqNGpuaVZ2UnFDWTUzOS8rN2t4?=
 =?utf-8?B?OHIvTkhWSFVoMDlKRHNldFlUa04rZ3p6azhraXJkRkp6ZlVlVlR6VzRGT1pj?=
 =?utf-8?B?RE1PVTZualBwTE9VUVM3K1k3YTRDaFJmR1YyUGtiaWVBbVZtWHkzQzFtTjhS?=
 =?utf-8?B?UGVodE9SUFpUNkwwR0RHcXZZUDNqdE9ZS0YybVJrZVBnUlZZcHQ5ZHFaSCtM?=
 =?utf-8?B?UGNpS2hvcFQ2eTJUcVZ4SzVJaTh0VFgra0RWVlNsS1lsc1Q1TjIwUE5uOFRP?=
 =?utf-8?B?RFhxemh5RzZRcFFOV3NxbkRNVVNlYkg2YWFIbHNLRFRxeHR4dnkwMzRXc2Rn?=
 =?utf-8?B?cko2bHVGYXlhTEpsbG1JU2N3YTR6UlFCMG93TXZHZUhBVWdVNS9VY0ZCREEx?=
 =?utf-8?B?WHJhOGJ4cFlkQW9mSmhhcUFjbGFOOWFLWlk5b1FDbDZDcnliL1NvMHdTckgz?=
 =?utf-8?B?UUhYWXdUeVNlM09UV3hxRG1vUnVhY3c4OTY5aXhXc0FqR3ZUM1hmV0czd3d2?=
 =?utf-8?B?WVhhemQrWTRWUWFpc0xsZGFkMnNIR3RhMm93UkZhdmhKK0hrVHlxZlRUbWRm?=
 =?utf-8?B?WEFwSS9ybFpUU3BoV09PWHN5amMzMVR2ZHNWSEgyQVlOVkZtbjJTN0g5R0k1?=
 =?utf-8?B?RFUwUHE4SjlKbjFsb3BUalQwV0d2cWJrc3U5SG5rMG1HVE5RWEx2Z1U5dkt6?=
 =?utf-8?B?MmZBZ0JnZGludTY1Z3d0RDZpRHFDb3NCaUFnTzZhYUpiZGM5NktaYlJmQ3Vm?=
 =?utf-8?Q?DvWnVRyNPdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nld0aGFjbWtiS2Mxckx3K0tXVDNBeGw1Q3RNZDBVSmh2YnA0aEFQdVV2Rnp6?=
 =?utf-8?B?bG56YUlmS2E4a0FSRHkvUkxDaWE2YjQwcTlneFg1dWdiODBwT2t0S3JjRkFa?=
 =?utf-8?B?YU9NcVpBbzNJUVlRbTFCS0puTzdyRmw2YUwxcVkrYUdzaGxEZ3lzR09sZlJ2?=
 =?utf-8?B?aXJURnZDV0IrYnRoQVlWdUM1WHNQSTBIZTJ1aXo3RWpqMDZMTFZxU1hhZ2Qx?=
 =?utf-8?B?NzZKS2U4cjFIOE1lWVZ0ZEJBUFQ3VlB3UjdmRWcvMXozMC9nZ2xLeEtFQ3Z5?=
 =?utf-8?B?ZXVxYUlWalFGTXB6V0FHNkxOTlBCOStxeDQ1RzZOYkNGL29MdkYvQXh6cmdF?=
 =?utf-8?B?aEFHd013VkRXM0dWWG5JWVhCa3JRTHc3LzV1NzZsZ3BCbmhPWHNjcmNHWXFN?=
 =?utf-8?B?a2s2ZXR6TUEvNjhrbnZETkV0OWVwYm1NaW5UZk1oQVE5dHQrZVdvbmJUM25J?=
 =?utf-8?B?OXY5cDZzYkRGQXlFNk1GbnlhMlhnUkVrTzd1cG5sSEgzVlhFTWJxOGVBSmp5?=
 =?utf-8?B?aG5ZQmQ5ZFQxMEJscEN6OXVYdnkrdUNOSDJITXl6dExIdkNIK2oxalVZd2JB?=
 =?utf-8?B?Unp0ZGl1MzRQOWpEYndpMEI2U3A3SUpVQUlSZWNmb0tiY2d0Sm90QXpZaDF5?=
 =?utf-8?B?b0RmSGptWVFpMXJOUEdjVTkwcThsOEt5bjhvZkZGdS9VTEN5eDhkRjJaL0VB?=
 =?utf-8?B?RG96QzFXbW9qOE1IeDdsN2hRTFFzUDNCclFzNUlGU1dCOGpqbEVJVU1PVFE0?=
 =?utf-8?B?Zjk3SmRra05zdGxNRS81S21lc28ydWk1Y2ZIampzSnZockhEQS95d2RxdEFk?=
 =?utf-8?B?U1RwTnk5SGx2SG1oS0Q2QWp4bmVmM3B6VVRrRjE2encyVmc2dHE3akcyNEtm?=
 =?utf-8?B?V0RSeGNVZTllckVxbTM2bG12UWlMcFdwR3VNWUg4MTNQM2ErRDRndXY1b2Fv?=
 =?utf-8?B?Y2hMazQzdDlTYmx3UldST1B5TXBETGdwYmo4QkRHbmhjNEhsT0EwZ09wb0Q3?=
 =?utf-8?B?V0NVUS9hMVd5NFdGZWVBV1BwbHJoNUphL3dEY1BsTWJ2TnNYdzFGMERnRGta?=
 =?utf-8?B?NnI3V2VTSGpSSHE5emlHbW5BUll3WlZhRGwxL0pvWWUrN3I2L0grTms2elQ0?=
 =?utf-8?B?dXpFQmoyUnlWSDY3cG9lbUU5b1V6R2lBaW1aTzZuRlNYc3FJblZjb2t5NWVJ?=
 =?utf-8?B?c3hzUnZqQ3BWQmdUNzlwM2h1M1k5WEdmU05PSmlxZFpiYXhrYXE4ZTNCRkVX?=
 =?utf-8?B?QmpKUnNsSXFOMlBjK25mWnU2bDB0VzQ0akRYSnRFZUhSOTBEdXVwWmFDZXZG?=
 =?utf-8?B?WWk3Yk5aL1pnWU1PVjVydEFQUEQ5RjRJdlU4eHd0bHFVUjMyL2wzYll2djhL?=
 =?utf-8?B?YUt0alB0dnNrMFYwdkZvZGxWS1JadUwwa0JQS0NMeVRYMHlBbkw1NzRJcmMz?=
 =?utf-8?B?QkJveENBaXBOeVZSQzFSbkljcWxDYjhhaTNFVXFEZlYyaURpeGI0alphTmJC?=
 =?utf-8?B?aEdrTlE0UW9qTzNOWU1Yc1FCejFRenltd1BzcnRncTNyWHlaZGx5cmI0dUd2?=
 =?utf-8?B?NUgzeFh5UktTVWwwS0RYak85OWlScWhFYlRGWDAvcUMyTFpvTDlucGR6MmpK?=
 =?utf-8?B?a1ZrT25OZE5qRDQ4bjMraE5NVzAyQ2xKUzVXeTFzNVRjVDE5RkFTU01rNHUr?=
 =?utf-8?B?a2RKdEpKQ2FSZHV6SEp5T3NHOFZqcU9jOGgzTUorN1dzRWp0b01tdXVGVld4?=
 =?utf-8?B?RE9GMUgyeFlySTBaSjV4eUNjYlJuV05ha29KVmo4RGxhVm1MNnc3RHhObDBC?=
 =?utf-8?B?UkM4RFl0WTdRR1JPeitQUlN0OTBJV29OSjIwNjltRUdrSUFabDRoeGtHdyto?=
 =?utf-8?B?aUNraWZIYWIwakE1TytSalZjTjV5bGpvTDd1bG83MlF6UkZmTnZyV21JUzgw?=
 =?utf-8?B?SHlXeER5aENHVmR4Y3dNNFNVRWlvVGJTUjl6akx6ZEtmYmN3clB5REVRdmx6?=
 =?utf-8?B?aVJtZGgrVDZsczBBYWRoanhURzkvUC9EYUtUUWxWeDFTdkF1NjlUU1NDazFq?=
 =?utf-8?B?MHJmKzZLbExpalZJbld5alBUTjkvQ0RwWGZ1TGpXUStEWXlickxTSzZnTnAx?=
 =?utf-8?Q?1cZCnrPm91l1P6EIlz2L0e0vo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f545158-3fd3-4fbc-417b-08ddeea423af
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 06:51:29.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3OrehalX5gCNHKDQ+TO+DIX1y1H3Rb6tYGmMRZNrMcANEhDO6OZvtS1hD9wNdJQr7qzNVTLMEWKTXf/uBpakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5583

On 08.09.25 08:42, Yao Yongxian wrote:
> 
> Hi，
> 
> At 2025-09-08 13:39:11, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>> On 08.09.25 05:05, Yao Yongxian wrote:
>>>
>>> Hi,
>>>
>>> On the same computer, immediately execute rt_timer_read() after rebooting the machine to obtain the time:
>>>
>>> a) When running Linux 4.19.89   + ipipe      + Xenomai3.1,     rt_timer_read() return 8715069990ns
> Correct : a) When running Linux 4.19.89   + ipipe      + Xenomai3.1,     rt_timer_read()/1000 return 8715069990ns
> 
>>> b) When running Linux 5.10.199 + dovetail + Xenomai 3.2.4, rt_timer_read() return     50879028ns
> Correct: b) When running Linux 5.10.199 + dovetail + Xenomai 3.2.4, rt_timer_read()/1000 return     50879028ns
> 
>>>
>>> The time read by rt_timer_read is the relative time since the system startup. Why does scenario a read time as long as over two hours, while scenario b is normal?
>>>
>>
>> I-pipe used it's own timebase that was sync'ed by Xenomai to Linux once
>> during boot-up, IIRC against CLOCK_REALTIME which might not have been
>> set yet at this point. With dovetail, we can use the Linux clocks
>> directly so that you are reading CLOCK_MONOTONIC here.
>>
>> That means that old code which used to run over i-pipe should not have
>> relied on the clock being sync'ed anything (we had CLOCK_HOST_REALTIME
>> under posix for that).
> 
> The value return by rt_timer_read is supposed to be the time elapsed since system startup.

I'm not sure if we ever guaranteed that. Anyway, I-pipe is history.

> However, the value return by I-pipe is over two hous, which is clearly incorrect, as I executed it shortly after the system started.
> 
> What does the value return by rt_timer_read represent under I-pipe?
> 

"the current time maintained by the Xenomai core clock" - I don't think
we have clearly specified what that clock is. Thus, you cannot relate it
to anything else than itself.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

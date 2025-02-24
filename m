Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B6413C3F6
	for <xenomai@lists.linux.dev>; Mon, 24 Feb 2025 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431257; cv=fail; b=cab4dFYAB7EkIMqFFhS1fqbSUOsJc4a9X5DFA0YxG0GEqIjjP6O9GnIDHnu+sFaXSXArkQ9UWjLVLSHTLYLIfueoiaQHC7p/5PSXy7BaTd30K6x0P74/XC5QFa5pOwdMn/bbKRqkuclL9n9CKvxrD/aIwWTI+981OpCkKuHWRtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431257; c=relaxed/simple;
	bh=W7bXJhwnSGVfWHEyMzgj5kkvrho3TPt22jma2s21cUg=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=H9e6X1Ni7nAZ0PvhDo9pxoN6n9RgMNCND7vE3RiQRXNVDmcdUXoHMEGmlvnZvsAnvYn6whnNrk0T03ECvSvogQZMFhEPohlzuHBMclXt5U33+lx7SSHGYsJ2ycGdDSB945ibYui+nUBplLVKJK9VDy+Qpt0208eTIrriEfoHg7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=C7WZFQ2g; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="C7WZFQ2g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fM7RDuOexenrpNS37TbomBtXJinoC1ZWZfbkECVjowB21xqwO3VwxMXSwUo5oW8JKUH7kh7qGKgT8R1mQR9R06ThRdKffzW140NixWoTe9rpR97hFXHF3hX9/F7EsFmQlzudm6lwunL47e+zpW4uUJgHzE6vJeU+FHjhtliw7xjOqPNMLw8CjDo/+dhLcsIW2eB8EC+3/bfTj0DM1DA4+2GuwujApLMVKXHKLtvh/ehwyyexVN4S9dP+bT4U3boF8VD1u021y1Cm3LWaGxxaeNemKfjFD4Lwt7xz7B8+1L5V5davCG18nXYM/P+SSyJldsSfqIZpn+6Cr+pjR2Otwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIMnfYdsKx2+258jSSCdea1EWFo2V+ivOpUtoWJtu0s=;
 b=LaodYqsyNX9gVWNL75vVsr+Q3Q6CSp8GHPQAboHWnHqU77mpY+S/FaghxILVhQ+4cEaMww/AKx+xFZCLMXV0FGfid1DAl27y2Vz71uBs4evaK0YnaL4+Sb659+kbQw4volRshdfwQEo8JCXxslSWaMNGwxjo5/AsVpN1hASFGsdI7yJkaoOe0+O3uQQVoj6wNoNjCjqsjUhT9NOzbB56pIWpErmn6t28GFcxhDfhoaAsGmhTcaaKesBMlNw3xMaX6klgSNiMqs+tV8W9kcYCMuQkG4LPFL77ByA4rbgooR26nDvSX26km5+UdqOPZ5ojsR9oAHJ4Z4jtgZjv8uo+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIMnfYdsKx2+258jSSCdea1EWFo2V+ivOpUtoWJtu0s=;
 b=C7WZFQ2gue5eZyWjePHreLgtUksUXESaVzewl3D2azmIv5gwbjIKO7hrCfkUmS3bFrRqla2U8S2jNtEtyvVfuSYXeF/czKScs9kYyXFNK4CuD0HoqZnfKuakzUwbi3I9WSH9WVvNAzCgprJK9W1Y/jPzZXyKP6qIjqGBYA3sPNb/HotuJ2+HJx7fBRv8oFvzAr1rNbc0h1zFLRMYR6TcvEPiAgpFKiOiPb+sNeeAmITkMPdXkHEoKjHKk2KGvnKDlNtF//GJV92PkiD3xiuBgL0ok+6KQBz/DHjij+yNL17DhC4hCM3HQcazDC45UjqfqTz5jg7SytYM0zuQBGZNaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5937.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.9; Mon, 24 Feb
 2025 21:07:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 21:07:32 +0000
Message-ID: <5235edf1-6689-4417-9754-52584ecdb6b8@siemens.com>
Date: Mon, 24 Feb 2025 22:07:31 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] x86: dovetail: Harden __send_ipi_mask[_ex] for KVM and
 Hyper-V guests
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
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
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7856a6-219f-441a-9c5a-08dd551740ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjRLRlVGdUlCblZTRnY2Y01WelNUN0lud3hKMXdmNVNXRkQrQUxhTzVpcVFD?=
 =?utf-8?B?UGpuVG5UUEUzZUhaSE1teFd2QVh0eFVmVUp1OFVZZzgxakJCcFdRUkp2ODc1?=
 =?utf-8?B?NXkvRE9obWR4UUJGbHRyVHhMYWFjcHFBTE5jOTJvOHBHZXIxZW9sZGZuTmda?=
 =?utf-8?B?OWo2NVRXUk1tcVdrK29uZzBtT3NYVXcrNWdLOEN1djQvbnFmNVZXeXVVd3Vq?=
 =?utf-8?B?RDYyY0RlS243RW45cW02OGhoOGJPekpjTzNZZUF0OGtmTjRsRkx3Vk1LUlhV?=
 =?utf-8?B?eGE3NmlvVG5qOFFFVWt2Yy9IVUplandpZnlGQ2NBTUM0RnEwdFlzZHpWdjVO?=
 =?utf-8?B?YmlFTkhRN3B1ZFFYN0VWdzNLWXoyc3pKdTdqQ1BTeDMzQS9MTFBEaG9DNlBL?=
 =?utf-8?B?NUU4c2tNMzJuRnFIL3ZLeEhsMEdRYjRyNkNVWHBnNjgrUE5hMFR1Wml6bm1h?=
 =?utf-8?B?M3NDck9VbGlRbEFJdVpuVTI5L1htZzZyQW1jSlVVT3FlcU1hL2VSenFXZE1j?=
 =?utf-8?B?OWRjclNoUnB5cUkxMjFkbnpCek5ZbWxhYU9Pb2NhWC9oeVlpTW9YR2ZIZHdm?=
 =?utf-8?B?Y1ZTeU9TKzd0YUQrRS9SdFlMRjhmZDY2UVM5SDkxdSs0b3R0Vm9yR1Zpc2I2?=
 =?utf-8?B?WjhudGdLcGEwZ051MzRETGhVV1dScWg5a1c2R3NNYnBIM1VwYjFWZE1ZK3dt?=
 =?utf-8?B?aTdCT0tpaTVxK3NiS2k3VTV2SlY1ckNpZU1RSmxEdGNBNU9aZHFiWnlaQ2NB?=
 =?utf-8?B?c1gwZEFEMFJpT1hDREdKZ1d2UHVJWERMaHhtUjNGQ3Z4U2MvRkNEazRoa3U3?=
 =?utf-8?B?cUQ0Y3NIOEo0cCtHYUkraEpnS1dINTJSdThSNWMvMDBEQW1zOElEaTBucXY5?=
 =?utf-8?B?a3F6N0pLWmhLTTZKMGRtTmFrQVZjUnFzVEEzSDNxbVh4eG45dFovdkRST0hT?=
 =?utf-8?B?WUszU2QxYmtVM1hXOW5QTTgya05FUk1YdERYR1BjNlhOeUtKYWZtREhLQytK?=
 =?utf-8?B?N2J0UThCdUdZVGo4UXhwZ3YvTmxCNnVzc0puell1bFc0aDVDZFc4SFdaMXR5?=
 =?utf-8?B?Yk0vQ2l6S05CK25jQ3l4aGttZFVLeG1IdnFpNG9NWDNKQzVoTzFRcnlaMnFk?=
 =?utf-8?B?MklUWXZVSmVKOWNkSVYxTWJkL2JsaUU4Y3FaTVg0TlpuU3lEN2IvNjdQU1hG?=
 =?utf-8?B?M1JGYWtmR0xQb251cmlvMC9sVHJQZHRGdDlocUQvdUtwWmtKdlZ5VDZWbG9I?=
 =?utf-8?B?Vk9KN2VjZmZBdVFqSmpaaHY3QzFzbC96UUY5SjN6SHMwSmowMWJ6VGpQQjZT?=
 =?utf-8?B?MjlFbXRFQWh2UkFaQ3ZyR3N2K1I3VUpqWUpuOW5rdU1peHFJT2t6UVBlc1lQ?=
 =?utf-8?B?YnVhT0FuZTNlVVorQTQ3ZVY1dURLSldVRmtlL2tNTUViOGZ2NzZwcW9keFZL?=
 =?utf-8?B?UWFPZHlGUytDZ01Hak9selNITmNNKytrdjg3eGZmQmtKWmpOQUUzTkdYY2Ri?=
 =?utf-8?B?Q1BaT2FxMWpVV1A3WGkyRzhXSW5BMkw2ajF2TkMzcEZrajlsWkhuc25sWmRn?=
 =?utf-8?B?MjdLN1JIWHJMaUxPVmxYRzFCaWw5TlJXZFBwQjV2cjF2ODI4SDlodmZMN3ZY?=
 =?utf-8?B?bHJKVDNUR3dRQXVhbkZVTmRwcldySVM3STVmbVhPWXpDZ2hUbkd0aEpra1Jr?=
 =?utf-8?B?U2tGbTQrbTFmNTV4N1BRZDl4UFkwWUhqWFdXbGg5M1Rwa3hlOGRaSlZlWW9a?=
 =?utf-8?B?TndhME0yVVNNUUZjRGxaNVVaNUw2d3MxMTlXT0RTQkVNWFF1dXcwdmJMZmF0?=
 =?utf-8?B?QkxtYnVvT3lnSTg0ZDkyUDdFc2ppWWdodnQwVWZzRjhKcGV5V0tNbkN2cHlU?=
 =?utf-8?Q?j3yex+bHm4Ksn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0tLT3lmN3hvZUx2QjFrdWRkcGVoYjBLRmRLamdoeUpTdWU3UE5RRGtYU1hY?=
 =?utf-8?B?eEtSVGR6bndJU3N0QUlwQnJrUmtjTHJsbzFTeldnMmhXUnVnZ29qQlN3SDBL?=
 =?utf-8?B?NGJ0SnJpYStHUHI2TVQ3cnh6VnM5a3dYWnVsb0RLdFhNOFNoKzc1SDBrUVdE?=
 =?utf-8?B?UTJnRnVMWjZCS3VpcDdYaGRJU3dDUTJWcDQ5Y2tPbFo3eklXclozd0ZieXRZ?=
 =?utf-8?B?bEtDVWtPTituRzZBQkM5SjNUdkhNVWJTTjBQellCazU2OTVqNHh0QWJGdWVx?=
 =?utf-8?B?eklNZStvaC96ckphWFlIejh5b0cxWXlIUzh0Z3FxOHdyZkoxaUw3dW8xcDZX?=
 =?utf-8?B?TERDVGhNdVBwWlVSVkRIbFpFTmhIYm83bGZCL3JDQTliMDFnaVNwd2JVcGF5?=
 =?utf-8?B?eDZYS1U0cUFrK0c3Qmk0T3QrdlhUMmIvdGhKb21qckY2aDBmV3owODllYzhv?=
 =?utf-8?B?czQ2eHdvbzdTN2RzWXMvT1I1aStFL3pjbVZjVkorckZ6S0NQditXdVdKYVlC?=
 =?utf-8?B?SjBiUDZoNFZ2WFZkYjRCb2VvbjBhdHlYc084d3JBVklNTDVQRmVyTmxzSmRI?=
 =?utf-8?B?VVg3Z0l4MnZZKzVJWXJvYlRSb3pDbHRSZ0ZWeWdicmp3NjB5ODBLMCtOcWRL?=
 =?utf-8?B?T0FmZTk0a1pOamdxQjBVNFBVOGZYVVhKdi81Lys0WjI0bU00enlQbXpaM3JD?=
 =?utf-8?B?eVlBdEhxWnI5VGFId3RnY3RKUThuMitJYnFiNTBpZHdLVExPNXptYzRUb1Mx?=
 =?utf-8?B?c1ZCU3piemxDN09RbXVTZGI5QWpRQ1VKMWVhQmdIWE9aeDdiWGoxSmxyRjIv?=
 =?utf-8?B?bjBiSnV6SnFld1ZIWmtxanB6UGZvUkZ0QjVQT1BNdEhIUjVOdjRWcnZyZ0VO?=
 =?utf-8?B?L2t0UzRXRnZicjQwOURtZU15UFdQUWg2bUVLc2gzRDFaTkhWOTMzSkJ2dWZQ?=
 =?utf-8?B?enAxdy9mbGJoL2lDNExVV1hUSW9CYThQaFYxaTZOaldaa2hXNVYxd1R4T0RK?=
 =?utf-8?B?bG5qVEs0WFl4Rnh1c0ZJSEV1Sm5SUmRCTVBLa3BwclB1OExPbE90c1kzaUhO?=
 =?utf-8?B?cUxXZ3I3Nms4YkVheWVvWjYzNWwzS1dpRFFqMnV2M1ZwOFJOVnhqSFJUUVFq?=
 =?utf-8?B?eVlYVm1lUDZpSmtGL1FOeDlsa1dKaWdIanVNdElNUjZjTTRlTFFJWjR0ajhV?=
 =?utf-8?B?ejVYNDRjWlo3N1RJZlp0ZGZpdzM5cDQyS0gxMnpYbnA0UXpuUHl5R205WlhK?=
 =?utf-8?B?aENPUmxMaHRaczBIQkZwbHAwNTZnNWFFM2dudGFaU1dRZEFBbVBkOTU5YzJZ?=
 =?utf-8?B?K0RKcFJ4ekVKVWU3REhvVS8xRCtVa0lKVUl2NXEzbjZ2RnNkQTExSDBPU25j?=
 =?utf-8?B?a2NsazdLajBBOW5CenJUNk4zUGJiL1ZJYUh4ZVVLY1Y3UVlaZUxQNS9uOXV3?=
 =?utf-8?B?VzdKekxheks0TTFLcWM0ZlpxdWF2UTQzWGhUL3h2ckN4STlaZy9yVVNDckEy?=
 =?utf-8?B?bjdhNjJ6NWxmQWFZMzNENXVJNVRuNUg3c04yNktxYktCdXltN2lHWDBPaUI3?=
 =?utf-8?B?YkcvKzc0bEluV0NhVjUzMy9KRXA5NG03Qnc5WGkwUWxQRWwyelJrTzkzdC9Z?=
 =?utf-8?B?dWpYclNKMjAvd09CMnIyRkpUWFZPTmFsRkZWZGNxNkNuNytBLzFCdlhTZWNZ?=
 =?utf-8?B?MFhpUEZkdWhwY28zSjFmaW5Pb3Z5L2h5Wm90bzM1dStMM2dGTDBuaXRBdTJo?=
 =?utf-8?B?WURydExpMEQ0clpyL0lvRW9vbmZ6RGh0TURtNnQyOUF1K3JjdHJuWVhOaGJ2?=
 =?utf-8?B?WW14dTJPd05UMXhLQWRzU0hoazY3a1ZyOERzczBEa3ZsRnd2M0Z0RC9CaEZ2?=
 =?utf-8?B?WTZmV2lrLytCaTRDRHBVbWpqRE5BK1BXeVIrV09pMGlTbW9SemJPUjRITEpr?=
 =?utf-8?B?dFd5dElIcW5XejgrSHJFaVJxRm0vVzQ1Q0RWaFYvMVA4c0Uzam9iREZ5VU9l?=
 =?utf-8?B?TXJCem9aMVpqK2p0aDdRK2MwS0wyemxYSUE5NUVoNUw2Y3JaK0J2YlRxVVhw?=
 =?utf-8?B?bWJKZGtVZHVVQlpRcmJQWjhuN0ppeTIzdUh6cnN5QlF3dDRJN0pNRWwzbEJa?=
 =?utf-8?B?ejFMMHh6K0hZTG5WUUtpdkNBdUtTb3VjRjZwK1JuYjdndEhaNTBiTm9mamhP?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7856a6-219f-441a-9c5a-08dd551740ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:07:32.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/WGsANMcqFmhN8FSp+ye715l02fnCCUvuTFV2qJWeNGyDvql27SQgc2fHHBc7JVicJbYU1ndVO/2iOFtNDezA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5937

From: Jan Kiszka <jan.kiszka@siemens.com>

These functions are called in case paravirtual IPIs are used.
Just like for hard submission handlers, we need to harden the path to
avoid splashes like these:

 IRQ pipeline: some code running in oob context 'Xenomai'
               called an in-band only routine
 CPU: 0 PID: 410 Comm: (udev-worker) Not tainted 5.10.229-cip54+ #265
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
 IRQ stage: Xenomai
 Call Trace:
  dump_stack+0x84/0x9c
  inband_irq_save+0xa/0x30
  __send_ipi_mask+0x81/0x260
  ? preempt_count_sub+0x96/0xe0
  ? _raw_spin_unlock_irq+0x33/0x50
  ? xnsched_pick_next+0xe0/0xe0
  ? ___xnsched_run+0x491/0x5b0
  ? ktime_get_mono_fast_ns+0x50/0xb0
  ___xnsched_run+0x491/0x5b0
  run_oob_call+0x97/0x170
  xnthread_start+0x23f/0x330
  ? rt_stack_deliver+0x340/0x340 [rtnet]
  rtdm_task_init.part.14+0x7e/0xc0

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/x86/hyperv/hv_apic.c | 4 ++--
 arch/x86/kernel/kvm.c     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 0569f579338b5..e7b2a57c720ed 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -115,7 +115,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
 		return false;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 	ipi_arg = *this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	if (unlikely(!ipi_arg))
@@ -150,7 +150,7 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 				     ipi_arg, NULL);
 
 ipi_mask_ex_done:
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 	return hv_result_success(status);
 }
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5df1061fc6ee1..b183caf41aa44 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -525,7 +525,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 	if (cpumask_empty(mask))
 		return;
 
-	local_irq_save(flags);
+	flags = hard_local_irq_save();
 
 	switch (vector) {
 	default:
@@ -563,7 +563,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 			  ret);
 	}
 
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 }
 
 static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
-- 
2.43.0

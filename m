Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16EB15C0
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731916965; cv=fail; b=bWF4bT2u8dzBIl0AdRtQDe8jMCnfAywadglywH3J8N2FjZZzsMKEO3wPp6PNDhBBZ2gCLe9yOIXhQg3zTzBI4An4XTYVhJw6MPimy99bu7cCYE1Qw3ndjwtrhPpdLqg6vC/F9dH5LdSWKEqb7ZFHerso24vi31oz3nBJvMWxtFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731916965; c=relaxed/simple;
	bh=WY3lOadUh9yL74+OQVbhVYAkCkscOm/mZ6adHD43bvY=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=SFhTSnfFghR+h0nPesGcg1ML4XGbnc+amxIoftrxYchsK0fQpA7RTLFMwHL52YkQjw0kDnBIB/DZ57x7CWNdbKPDiLY/FQGwMm3OJ2aSyJdQX63KKy1c/pi7FUYtxU5b5JMRfW4WzT5rahErnlZYEQ8ZLiIfd2kVWm3cMGnB8hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pVaWERMI; arc=fail smtp.client-ip=40.107.247.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pVaWERMI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P39BWL1qIc93UMlqzVv+wr21qrkJDO3i3h7k4YihNTDLl1Ycf3QBcwsRcmNpHPakhJX83Pba+80xloohy6SX4yv7ry6sEvhVYt6iira8raWd3h+fqm3U013X0p/BYBLAhsPLPzWRlS501tSeEgpua9l3Jzlmf/chpeqT56oNTBS9eLKm2fsVvu3bkHPwgI4z89gTwoNdEgOb0gLeS+2LmPHmm1mBSnOzfcowu94FqRCTTyjWxqEMJ2wy9z7c505nx5ah0xDW8bmwS0viWQSOo6OauYd/wpLr7Zah5IFe4j8vTOs7QNgJQofHcqNw6wfSMcHwKILjfzQoI3jqiPIOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg8qtBNXigcBeZjtOi8+wbPR0Z/58LSxhKynsxYhxmk=;
 b=m3qT1Wl+2kBPl9MkpMUG8YLvawxwMLc0AGn5lHi9mFFOFd0pfCWIC1MsKHNVVY+5E2cXGc9RIr3M2m8uK+jFAxQxZJp8Xr+ku8NrhMmfonIwhTA/fkIs0ktY+1lWR4dn5XPelg9NliKMOh+GUZ3JCbPp6yL2pWYX9fD5KChrts0FTz43m/yTUZCrH/a2B5wVpWLqFTluad0+CEusy1mLv0oPuiSPtNxsw3zBVTLJWhatPvg4XsMejkkQRy+S1Z51LqghJLtxipKS7rmJbHc6+zMOJ+cIY5O8m7CoUeMPjPsp3sV7tLtHK49WeH/e0mQxk5NLckphsC2EPwgsjoRGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg8qtBNXigcBeZjtOi8+wbPR0Z/58LSxhKynsxYhxmk=;
 b=pVaWERMIkddgBRTo1VI9vefEK2jNI8M6N1h/y30jgnXHjvC4W5O9CMfsv5cUs5T71H724CAPNVVPliKwmzUrITSaK95/PdqZ5OXW2AjIyEPMRkZ+rfLrBJ4Ilad4NwD9y0AMGylfCkkaYa2nvB/Oy2sI7GIqBNj6R2V6ReUx1+A1uLhl53WI7YKORaYfmIzECFKgggNZWBEfelqzMOhJxCt1vuO7FZIxcccLwTy2Y/YYtftYhObxBnIz/D5SiLU5vJ0OKkMgZIsgraGK6OKWpRXMekJMiTnlFKJ9VI+rXEjIh+HjnGV6u12k55BbogcMlsmwoe1DmycVJ/w/x9gEqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.13; Mon, 18 Nov
 2024 08:02:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 08:02:39 +0000
Message-ID: <a0d95b09-b050-48a3-a9fb-68af212ab1ba@siemens.com>
Date: Mon, 18 Nov 2024 09:02:36 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] libevl: Add build dependencies for r50 and
 above
Content-Language: en-US
Cc: Pierre FICHEUX <pierre.ficheux@smile.fr>
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
X-ClientProxiedBy: AS4P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa6e9ec-f8e6-4854-1f4c-08dd07a75e95
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THdoTGhSRitoUGluZitTMWozL0V5dE9SVGtxNDg0MG8zLzVsS3Y0UFE3Ni93?=
 =?utf-8?B?dFdoZWFUK0tySUwxZGpsRVJsSXM0WGZzQWVlNGp5TEM5SUxjSzdPdUYvd1M0?=
 =?utf-8?B?MUZ3bXA3Wnpna1dZZnM5NElteElHcDZJZGQzbGZma0lIcEZ6em9QVG5oQ1RB?=
 =?utf-8?B?SFJkQzZxWjlDZXZlc1BZYzlIVG0yNW51ZllaeDIwcUFZOWtRcWt6NkVLZjZN?=
 =?utf-8?B?VlBMUk9OR3BWSUc4TmZ4bXM0UzF2QmVwa1VuSUVKMHc1WHQrTmRneC9rTi8v?=
 =?utf-8?B?U1FnTlNrL0l3TmMrYmRFQ0FvWk4vcDZHT1p1SXV6MGxiTXVvTEhGa3VDOWxF?=
 =?utf-8?B?UmtLYzYrYkwyM25YbzhpV2JzMHQydkJLYTF5eHpZMzlCZEpmQ1gzQVdNcGpx?=
 =?utf-8?B?N2I3U2JzQlVaL0d4M3NkRWJpeTRQRmx6UXJlcEQyOXVVK1RtaEQvR0UzMHVN?=
 =?utf-8?B?WWxqeU14bkVwTVZHYVhQaXF6TVNDTDEyZEt3dTU2MXBCS09rd1dKS2tsYnlu?=
 =?utf-8?B?dGRhZEdZaWsrNUtjUHorZyt4eEtWcWFiR1VubVc1amlZcVRFWHVlMXJQQWMr?=
 =?utf-8?B?SUpUY2Y3c1NtSkdJdHVYUnh3UFJ3WTQrSkZYUjd4M0VjK0FZVmREWG5Sd3pw?=
 =?utf-8?B?S3lyaHg3SG1wWWluMk0rL2JuQ091emJqKytESVVvOXhFMVlkQ3JHRlBYVkpJ?=
 =?utf-8?B?aVV3ZTlBdG14d3Z3dml3dFZyb05NaVNaZjFHZGc5SmhMS2xOWlZCb2xoODRL?=
 =?utf-8?B?K2dUSFFyZnJuZXhwTWRwQmF6NE9aSW8xb2NQWG5uK25CVFVsWkcxNWRQR1Vs?=
 =?utf-8?B?MWNhSUZkSTB6YXUrL0RQU3lXTlZKSGVkYXFZRHNwZ2N3Q1g1TFVRaWF3N212?=
 =?utf-8?B?QSthVHNuTEFHUnF1SFdZOXFCd2tBNjlGeFBlVHFvZjVSbmMyMFNNZHJJSjVL?=
 =?utf-8?B?a0p3bjRBVTlDVlVTZXJtNjVNcUFuUGw0TVp2UGlXTHI1eEFkbEdpWEkwYU92?=
 =?utf-8?B?SnJGclkxZXU4MmYvQUZiWlpIeGlvbFVHRi9kKzNSUS9sSjdSUEVKYVR5Q2Vx?=
 =?utf-8?B?OXdPQU9Wbk5pMkFIUDFiWnVkbmF4MU40UmFMaWdjN3RBY3FvRlNtbm1hVHlx?=
 =?utf-8?B?d3d4SHJONWt0WmpDVGxLUWMrQjMwRWp6T2NTc2tBemdBN2xUR1o4MEJlQkEx?=
 =?utf-8?B?amNvSTRTa0ViaFpYcUdGTk9qTE94WkdESjdQODlmU3VaZ0NoWmtXaTlndS81?=
 =?utf-8?B?Q0d1dFkrQThIcnZ4eTJZLy9PVVkzUitDMHp2VW9zM0JOR2pWT1hVb1FxcTBp?=
 =?utf-8?B?a0dIa2ZZU3dxczI5V1dRZXRLd0d5QnBhTVYxdWVhY3pjWEw2Q3FWM25oSzY0?=
 =?utf-8?B?VHd2TGlTekNpaUl0VzhJRzk3RjZkckVRakxpY0FYai9PTVZ5YXc2SVljMGtm?=
 =?utf-8?B?NVNreGVwdVZac25XNVRmTnBMcWhUcXpOSWpaQ1dhODlOMzhnRFgxbHdvb29D?=
 =?utf-8?B?L0oxNG1CcjNCaHJDVjBaSHFXY3hUbDhBQ2VXa2ZLWCtXaUxVdHhOWVdnMkh5?=
 =?utf-8?B?djRMMlRVajhNZ0puUXRVckFiS3R3SU5yUkkwSmlhWGNwVW1HQ1RHUU1oWGN2?=
 =?utf-8?B?anExM0hJQS84Z1dmdzdFbWdGaUQxTkVnMU1vK01pZ1kvV3NMY01oWGdiaDNs?=
 =?utf-8?B?MHh2b1hReDVoNjhIcHdQMnh3ZjJPZXMvTTNMdXlFOVpGV2tXMlRybWVXaHE5?=
 =?utf-8?Q?VyvLfTQ6Lhp8IdOnOkVLJqGF/hARYbwJd/qKCXd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWxzamp5a3lZbEZ3NE9mT3VlQXlGYTMvL2dOaWpxSUsxQXVrblp4b2l5eVpB?=
 =?utf-8?B?S1o0VC9RWXBqT1V5bEJMOUh4RGpPZU01Q3B6VytwVlNvYTgzWDFTTGtEUUR1?=
 =?utf-8?B?cVRIdVl1ZitURHZQNDRIelZEemwyWFZPKzg0L25Rem1tRDJYUlpjdEtoQlpi?=
 =?utf-8?B?TE5iSlE3Y21WcVYrak82cFdDOTZzY2xxa0pWUldydm54U2xtUysxMUJ3MTNk?=
 =?utf-8?B?bTgvZGRFbUdKNHhSMmpSSm1kVnpaeWMzU0l1RHdVTFpYSzF5NUpON2NISWFk?=
 =?utf-8?B?aXZtZTMrTEFSL2k3UlVHckt1eUpJQUtYYlZRc2xJTWN4Z2E5TzNQR2Z0UnQ4?=
 =?utf-8?B?SUtoNEVDMys5Y3I1RHFRcXFDYlJURGp6ZzRvZjFzNUxQRCsrMURVSVFnUURs?=
 =?utf-8?B?UW9TZzVVRHhSVWFpQ3hWTHV4dWM1S2JLVWxIK2FWWU80K2R6ZXFJbG5QRlZJ?=
 =?utf-8?B?TlJJY2hxdmV2b3RDVVVqT252ck00RExCT3NkeGpTUUtsRklhVjNPTnlnamFz?=
 =?utf-8?B?eHZ6MFhyM0FWbE5mcCtNeVpYdXRyakVHZkoxRnJXZWxaQkxkWlNzdVhpNWll?=
 =?utf-8?B?RkhOMVc0eUFIcXVBWlpuM1hKTEpTVnl5SmMvK1lhMVoxR1lkblhaVjlYZmQ4?=
 =?utf-8?B?V3grK3FLejAxUG1uYXlzdHgwNytyRFYyb3NPS3ExV0JsTmdzUWFjaXFRM0Nn?=
 =?utf-8?B?Qlh5OUx0eHZDWFFBdmZuaGNBdUtpaWw4QzlLeHNSdHNoQmwzVkhrVm1BWWU4?=
 =?utf-8?B?dkxmY1BPenpab3hQTm9FSlh4ZHBFNENaTTd3ZWVYQXRCZlZkZ0cvSDJMMzRm?=
 =?utf-8?B?RmhXV09kc2NGd3FHUk9XWFA5ZitGVmZCYy9sdjl5ZmxUOXdJbWU0M3VSVDdi?=
 =?utf-8?B?Vld3eFZjQkg4cjFudWd0dmVDY1g0SEZjSS9ncFBYdjJjbE1Oa0hjNkc4Vy9I?=
 =?utf-8?B?SXFkK1NQOGltb3BsQ1AwMkUyNklvRlBQcUtpT1hVV3BWS0pWSVJyQjRHN0xC?=
 =?utf-8?B?elVYQ0tTWFVXRk83aVQ0SlJRNmNxS25uSi9HeTIvR3ZFc0ViZGxMc3B6aDZ0?=
 =?utf-8?B?TGpVS0pZOEFXMjk4M0hiOUNWVVBqQlpOVkwreUVWNUxCeVdEZUNKaDRwV3RG?=
 =?utf-8?B?MVIxUWJoTURYSmh2UzdyU3crYzR0cmVEellYNFlRWXl2Y3NNbS8xSW9MVEdx?=
 =?utf-8?B?OS95bGQyTVhrU3Fza2JYcEZGZVhBOTdLM3VnbWg0M3lNMlh5Z3ZDeTdzWHYz?=
 =?utf-8?B?MGY2R085L0E0ZzlLOGZLOHNJU2syOTA3UXB1bnF3RmhWakJLc3lFMnY5OVdm?=
 =?utf-8?B?MmZJRVZ4Z1h5a01LQ3UzanhNZVJjazZCbkRoL01vRWhkNDZhWW5lVmMwbTZM?=
 =?utf-8?B?dkdIVEk1SlR5MmxRQVdrallxaWNBV20wbGlDTjVoNFBiZHZ3aVNCYzFkZlZq?=
 =?utf-8?B?NnhHV1dkWVZ4UnN2Q2hkSmxSQjlWMlIxRndzZ2ZaNEFaMHNQaENkSWZkSCtY?=
 =?utf-8?B?VE9VVy9rWkcycnJxelJmMUVFOTVLQjJZeCt1TVlyRFNKeStLb2ViZTc0TTQ3?=
 =?utf-8?B?a2ppZVU1MnNHTU5SVHMvNUo2NG9scW5sQ2hlOFlHdHZaZTFnRm92bTBqK25w?=
 =?utf-8?B?WmM0RTlNaFBuRUVnZU5TTVNVanBUU1AzSzNVa2pYcjZDVE4wSnVRZ3BITURs?=
 =?utf-8?B?UFAzZWZ1YWhhVFh2c2FYMzA0WHJCY21aajBGWkUvR0xkUzRXYThVWEJFMGhU?=
 =?utf-8?B?U1ppWHgzTk81eHRWM0k3bWhRM1l6UVJBQXRrdUwrWThxa3djeHFTaWlPdnNN?=
 =?utf-8?B?QlhZSWI2dnlFWFMvR0dDUDRrNXFQUmkzWnMrNW1GSVprTGFaUTgvN2xqL0ln?=
 =?utf-8?B?eUU3Z0ZheDFpNUdlVWxybitJMEsxM0lNTE1zaGowSW9jR2UvKzVZaWNkTkNY?=
 =?utf-8?B?ZUh1VVJjYXYrWTZEeHUzVzJvNm5iL3dxNCtiR01NVWI0QVVSOWxPUG9qTlNt?=
 =?utf-8?B?Lyt1aElVcmNJT3lCUzRsZFJyalJtZDMzN3ZYMVN1YTNyQWZVZWQ4SDdZQzNI?=
 =?utf-8?B?Q1RtanRNSmVyUXlHYmhsb0ZFNGNaejI2RERLcXFUNkVCYU83VGZHM0QwYWpU?=
 =?utf-8?Q?65eGrHHe6PYhLSjOiowNVOpwt?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa6e9ec-f8e6-4854-1f4c-08dd07a75e95
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 08:02:39.4444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kp9bAtWVfm+cIL6jljfzNYXYCOOKEhwqWqiDSR6yNXp6+uXPm36nr9IEgyRf0f3KXe2Z5xSk9NkMb911ux6vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6823

From: Jan Kiszka <jan.kiszka@siemens.com>

libbpf is needed now to support the networking stack, and that is found
via pkg-config my meson.

Reported-by: Pierre FICHEUX <pierre.ficheux@smile.fr>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-xenomai/libevl/libevl.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/libevl.inc
index 405be8b..fb82d09 100644
--- a/recipes-xenomai/libevl/libevl.inc
+++ b/recipes-xenomai/libevl/libevl.inc
@@ -17,7 +17,7 @@ DESCRIPTION ?= "libevl libraries and tools"
 SRC_URI += "file://debian"
 
 DEPENDS = "linux-xenomai-4"
-DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson"
+DEBIAN_BUILD_DEPENDS ?= "debhelper (>= 10), meson, pkg-config, libbpf-dev"
 
 TEMPLATE_FILES = "debian/control.tmpl"
 TEMPLATE_VARS += "DEBIAN_BUILD_DEPENDS"
-- 
2.43.0

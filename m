Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CB224B14
	for <xenomai@lists.linux.dev>; Sun, 23 Nov 2025 08:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763885099; cv=fail; b=H+ViLFrjC/XQmEkKwh51e1Wh15ZS6+4YVz7y6ffMjHdfQvLBmpy4e7EQOGiHzd0W13nakYKNh3NG3u6Ec0UFl/7RaiqTQmN589E1aE6WmmFc4Jke34Z0sp7fTVjI2KOzyl+TGLKyKKRsmqJ8cvVsAyRkMyZFdfskj+2OD4zVBf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763885099; c=relaxed/simple;
	bh=fYJTkqAirPkWEPAPIo8ziOBO3IKp2prGx9BwuOMGX/M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CqW8fDgDJLey+NLNETDfr5HQJDpGnQkFTmFJkUg/n8uxnBrUbLWWhoTPgQzjXprExS0FOrRiXHsMo4RFvAJsbP1oMvj1q4Nqgi+DxqiBthlgkQFABz5OXrOVS6Cy8zLaq0yXKDVoZGtb3ZPrgJie19Zm7pYRbRR3v3u1PWISQ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=l5dBvVt8; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="l5dBvVt8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0rtSohfemhJFbZCJemZLIgyd5BMHTNYb2e9bPy7OEaUD8qnlrq59QXUX7gxaF4iJ+Gi9VSR4gbCPC0+21mQt5oVhrK+/maU30duw6KeQBLXZ6KLcd1l1RO1GpMgT51RFhzxtOOPW+tzio3E34vcSZZ3Tsf/nZtA5WNsvd/VRBT4Hss5hgFTpEgbleCcoPb2X27P7iOURuH7obHxf2uUutZ+j9Mu0kScUlDlAN+gc0KTZT+O5088Ps4z9cwCuaPaUtXCpuNup76lMW+ipMKqJhHMhhTmZxEHjaEqgqJ8mz5HKgkK4GV21ZIvZQqxJZke3hz9kZTdBchi2c7VkLftmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIEZEHnXJBROoXhwJYD82NyyjZvtuDO+v7W0N1CG0Go=;
 b=ptHt/82wS8rTXyjV2r9S1akQdICQqoKTQKeBSyf+XDT7Et12zlLUDixeCdDHhsdsSZbmwPPqWQCHJU1Hw+TSrDURzqExS0TyB83YOMAXoWjm5o9tYmV4MTnIn3gHFJ/v8/Y3rGvlqHrPbhTB04apVvRhANME7x0Y7C0c8cRsXlrVE8P0UZUEhe2G4pDg8wvX4GOdwTT2pThx+w8AJjQAEnTnOqrsN5WuUa4MnNmsy8i/OrKvfkbnqmMnQ7Ovw7N1aYK4v8RDTbO8rwDkX8Lv7kzJToTjtxHTZQ2bGUMZlMecJdZf9KesQLlSzaf/3V0/sKgBFmGLIPINX1f17C7Z2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIEZEHnXJBROoXhwJYD82NyyjZvtuDO+v7W0N1CG0Go=;
 b=l5dBvVt8mSTBnd8sDRQ4VZIJnGHRrUJf+rK1y2HvGNj7cmZg9bv/F6WcjDpEcJj+bdAPVEN34n3i9nbPYuUTSDNwmU1PzJPWiNKlMmVuFGnQTXKZApLJWc3flRV9uKu6gv50S8WDuQa7GDd6i4OvT9agPHIOkHuBJMir1GYXw2jGapINWEWQVt+Fjxf2u1HAX0fiwORrSdIDsolrTmkjONQyU7laV1oBnCYCoopCO6WhaLSLPe76QFrSnZQChsA3oQTUfbo0B1mr5ATE4Y4CN0mqXc0k2boF+BMIw2zA5PBW9+gHFi95O3GkGVTHR0QklwJhLfhyxvhuLpmqTsTbhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:109::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 08:04:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.011; Sun, 23 Nov 2025
 08:04:53 +0000
Message-ID: <1d41ef2c-11d9-4829-a491-80839ea02b5a@siemens.com>
Date: Sun, 23 Nov 2025 09:04:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel Porting Query: Xenomai Cobalt on CentOS Stream Kernel
 (Dovetail Patch) - Boot and Latency Issues
To: Noyal Johnson <noyaljohnson455@gmail.com>, xenomai@lists.linux.dev
References: <CAGx0mQ-_=vJh0H9mKrTBjpy9G+H8GHuSGmxJFi=s=nEAfoq=9A@mail.gmail.com>
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
In-Reply-To: <CAGx0mQ-_=vJh0H9mKrTBjpy9G+H8GHuSGmxJFi=s=nEAfoq=9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3221:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1b7697-16c3-4a4e-9853-08de2a66fbd9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDIzUi8vMG9CWW93Y1JydkpRckNuTUMvYTdMRE5ZdkU0RC9RYUVjUWdZMmJ3?=
 =?utf-8?B?NFRGM0dPbE5Kb3UySnZsTUttS2F4SHF4bXFkV3hHbU5kN2p6NEN0ZGNYSmls?=
 =?utf-8?B?anNucDRNTnJGT01qWXpiL0lHWDVmQ0pzd25BeWNFS3pkQUtxdDlyRXNxMHZy?=
 =?utf-8?B?VGFKUW5ZUG1CTXVNWEdUVEIvcWZkS0xPWjRIZXVXN0tOODE0a0MyUGNudDZs?=
 =?utf-8?B?K3JrM0w3Ujdhd3h6aGJxejRSbFFkWjI2NUZPV0FTdnNsY0Q3VGRmaERNUW96?=
 =?utf-8?B?L0tIQUFKMW1QbEFDOTAyUko5OEtXTVRJZWNtUGxEOE14dnpmQVlRRXFZNzZn?=
 =?utf-8?B?ckxrK0Y3L0RlUDc2OXZNZ1BwNGJxcmFGaGZvdURlaXVrY1VXdU94TW5TZlhZ?=
 =?utf-8?B?cW55Z2FrV01FREFoQ2JBNzMxM0NDb1V0TTVUTUZML09rUllaOEJnZmlVZ3Ew?=
 =?utf-8?B?dFVDUnFRQU94RjNUVWNXSWpNcTlvQk1GTDJjdkxoay92VXc3RzJOMmRkMmkz?=
 =?utf-8?B?YWtwaE5iN2VBTkg0Wm9uWU9rczRmOU9hS3A5d0p6OTgyRnpjMnYyYXp3Nmdq?=
 =?utf-8?B?K2NaMzlNV1VMRU1kaVpVeGpJZnBteEZDamhjWC9WcXJVVmNHcVJyY2F3am1y?=
 =?utf-8?B?TmYxWkErUjE1MGkwbnFBQTZvMFZwZm9iclp5UGgwN0RJQ1BWUGFmdVNMdTV0?=
 =?utf-8?B?b1pYaTRteDhNbzMvcjRvMCtUemliNWVaOWNlVHN6bU45QzJtTkZtR1N6bFJS?=
 =?utf-8?B?aWZqc1JycndyZHZDeVNqdXNWOXVpbzFEMmVoOFRUdFRDdU4vT0ZiSzJ6UDc1?=
 =?utf-8?B?Vm0yODd5U2U2ckdycS9ZYTNxd0FjcjFjODNMRG9Xc0FOL3Fad3VpU3JoWEl1?=
 =?utf-8?B?QVVNQ1M4eWNJclhmSWp4aVAxL1hGc01OMU1oSlhXTXhieFNKSWdQaHhpRnFa?=
 =?utf-8?B?NVZGRWFTaEF0ZllFd0U4WDM2UHNpak1CS1ZMbUJTeGJheHJWRjZydkN6ejFW?=
 =?utf-8?B?amd2UXhuWDBoM0lYc3JsOHFMZks4TktWM2VUZFU2dEoyS25KVXZwem5iL3Ro?=
 =?utf-8?B?M3c3N2N1RWJmMzd0ZHg2NTMzVS81Qnp0NnhrK0xRMDRzZ21sL3RNNXFFeU1L?=
 =?utf-8?B?ZjkwTnZaenFVR09aNjcyNGZIRGFKMEpBaWtMeXlPbTlNWlJNc3pWVkdWSFBH?=
 =?utf-8?B?YkxZRjd6TzBsOUFTYmdGVlZoR1VQV3FOSTdTTWR0eFl4emEzOTdXMTNyZ2Jy?=
 =?utf-8?B?ZW8zZGVERlpBb2Y5Z1EvSzN5cWVHRkRpbEpmbm51Q09LU01mTHdkT3FoU241?=
 =?utf-8?B?eXR5YndWT241anFZN0lVNDBWQlBpWSttMXMxelFDQ3NuMzZPRFZCUmp0dUc5?=
 =?utf-8?B?VzVlNG43ZXFmMUlBY3QzUStFU0dTZUJzenNNcUliUjJLeVVTblc4Qi95dHd5?=
 =?utf-8?B?KzNPZVZLQUxKSWUvZXE0Q0VHKzd6cThwVHVsajVld2pwZ2VyQ3czeG8wc0k1?=
 =?utf-8?B?dm9MT0Y5YXJ2ejdzbEhSWlFSaUY0U1FWMXo4a1d3MGlOY2x0NmtpMlR3Tmlt?=
 =?utf-8?B?QkpUbEVVc3pSMGQ0ak1GMnhTWUg5QjVGeFR3aG5wQWhVTytMSXdkdWdERmph?=
 =?utf-8?B?dzJwRmd2dk9RcHVpMUY5QXVIclI0QmNObWJQdkU3WlBkTnRvYXYzRVBuZXlw?=
 =?utf-8?B?Yml5RW9ES3JZd3BKb05OZ1lMSXlRckgwamljNkcvSUJKMnJSZmo5cDlvYlp0?=
 =?utf-8?B?c1lsdmVsT3VpNXpnOUtQS21ySFQ4MUZnUFlpRXVMSzM2dWpKVDlVY0ZkM1Ey?=
 =?utf-8?B?K2xTMExPczY1VjJudUYramNISmg3cjhJcGcyODRUbGtDcUYrMzN2NWM5T1Vy?=
 =?utf-8?B?L2c3b2lmY1V2Q2pTbThmZmJpNjA4YUtmdzFCTzVBM05WRzBZV1U3T0NkTlpW?=
 =?utf-8?Q?1DhqRDz+yVdHODpHj6uE9OJnAGpPz/ES?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWU0a3NBa0dlR0JqNG9wMVBCa2F1TFRRRkJoUjErVU9YbVIyNDVYMFgvaGRm?=
 =?utf-8?B?T2xnd1hSSXBoaFIxT1JuM0x2bDdjWFBUbm9Hc3B2TFhudmFTdE56VjcrVnpC?=
 =?utf-8?B?eHlGYWVORXo5UTMxZWl0M29Ca3FPVG9tN1ZKVUlPZ3ZyMDUzS3FpNzgxMStV?=
 =?utf-8?B?c3Ztam1IZ1hJaGJ3d1NKQ0R2Tlo4YXJYRndOQ0hzZ2lTRGVxbGw3aDlqVTdB?=
 =?utf-8?B?TW5EVk9RY1cxQ2R2RmhRVHBNWFNtdjFBL2w4aXVOdkhONVhGSkFNZDFJYjRm?=
 =?utf-8?B?eUNtYzcycXU0d0I1elhRL0VTK1Y3R0VEZWRkMmFpVXp6QzYxN2N6aGdKckgr?=
 =?utf-8?B?SXNCNElYcVRqUDVld0lQSVE1Vk5PTCtFV0ZZTE1OVXliOS9HR3UzODZ6eUti?=
 =?utf-8?B?M1lzVnJwUHpXcHhHV2c0SUR4eDJTa1lvOHlZTUpjYm1KaWZxWHFvZkN5M3l4?=
 =?utf-8?B?NnVIRForV2xaVnBMOFE3QkFXS3J5bW5ualBsTmpKZy9mWFp5RElTL1h6Ulda?=
 =?utf-8?B?cU9rR2ZBTDFLMnZDSjZVN21PMGNWOG4vdUJNeUkzN1hGMzlHVkwwQTJtUUhU?=
 =?utf-8?B?eUFVOXJ5OEhxSkN0N2pORFJaUEJNL1V1ZGRHRk1NeGFtVW5NOEZtTm0zMW9i?=
 =?utf-8?B?a3NMOEp2WWtEZnhLeVVJR0tnZkkrOC9TTEpxNnVSZktRWm5VTSs5Q2UxYlE1?=
 =?utf-8?B?Q0d0WG1ZR21xWS9PdkFCak85bm5McGVyMU5BY3dmN0hpRDNYOWZoMElDd093?=
 =?utf-8?B?SEtOS29VRHNZdGJCbGJCSmgxSENQNFYxT1RCVUg2c2NPalJqSjJWVGluYklS?=
 =?utf-8?B?WmRhUW5ueTFKZE51R3I1UStWY3ZFTmFOSTdBaW9iaHV4L0dPc3RhUVNYWUF4?=
 =?utf-8?B?enVaaUJHV1kzZXJPMURUR2EvM2thcWQxNTZjWXZQZGtGZUhsbXBrZStUaWJm?=
 =?utf-8?B?bXRnYTBXOE1ZS1BUOHQ5SkY1ZmNkaXBQQit4c0lBTmVwalRScGpQeE1QYy9t?=
 =?utf-8?B?T1VubXFnTDFPNmEveGRMc09FZmw1OFVOM1hFSDNUUVRzUTJvUnorRFZUT1da?=
 =?utf-8?B?M1NVVUkyODBlT0kxb2xlaXo1MFlXa2NsV1lBMDlzcm91REVjbHpmbHNJdVB1?=
 =?utf-8?B?Ym45dk4zK1pTaFFhdjdadEVEWG5xelo5VzZTQzRhSVJITHgyb1Fnb1VyeXRv?=
 =?utf-8?B?aEZaZEtoN0xtd0xGbE1uV0JaZk4wOFIwbWQvampjcis4VFJiZXB2c1hBcUcy?=
 =?utf-8?B?NUR6QjBvSXZreGgwV2NJZ1FVU3BEdmovMWFoWDQ4MmQzRklBb0hMWkR5azM1?=
 =?utf-8?B?TWt2bUJwaU9MNjlidVczbW9GWHBlRE9vNDdTbjJvUCtVNVhQakI4Lys4NUFh?=
 =?utf-8?B?SGVwOXQ3eDlxRkZOK3ZoczlZNkJZY3luUGZvWEYxTzBXOFRFZlZMOFNwZXUy?=
 =?utf-8?B?bGVIWmpmQU9leFh5S0lXL3poQUdEZlVMSXdTOE83S2VNTUFxdTUzWmJvdlhz?=
 =?utf-8?B?ZExDR0xENURpMmpzWFNpaDFQS3pJQk9lVzJpVXFhOEhrQ3FubzJkQm1HZy9U?=
 =?utf-8?B?WFYzUW1aNDczeWlDZnRvdEc4NWxadnVFSCs3OTEyOUFrZncrT1V1bmFLeEFX?=
 =?utf-8?B?dXdJVVpOaFlXa3labmhDeVVGaWl2ZExoTDZTWXVqd2xFSFRlYUM4T1F5SURI?=
 =?utf-8?B?dFNUSDZRdlA2TC8yR3M1VXdLNzRWam1oc2wzTlAxMmNscnAxVDdoU1Nlcklx?=
 =?utf-8?B?Z013YXRMUE1YOGNDTlkreVRoL21RSVpTYmprMFNvdEplUnQ3SmozV0JmWEho?=
 =?utf-8?B?QTg1cTJoVzhydG1QalFWcDhmbTVKMDJlanFwM2FRdlBhSU8rcnYrcFkxZFlL?=
 =?utf-8?B?UzJtN1FTZW5BTGY3cjM0cURNN1dPalp1R2NpRjZpOUhaZXpvaUdXQ0lUcDFM?=
 =?utf-8?B?TmY1VEtTVU15NVhJTmp3dUtJMy96RU5kcFM5d0VpTXd4MnhRVHVBK0tXdzM2?=
 =?utf-8?B?WEhaNGhKUkc2YWpYc3RFaldXdjVnYWZVY3FXS0tRRm5IKzFnRmhpL3hHdk5r?=
 =?utf-8?B?THVlMVo4TEIvZ0FiaWhYcmVoU0JXbEx6OWpVeFlxTkk3T1Y0Rjgwc3pFN3FS?=
 =?utf-8?Q?9X9hKeYUfrKOa43a9eYpsOYD2?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1b7697-16c3-4a4e-9853-08de2a66fbd9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 08:04:53.5108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs6zH0ZwGQ18Vg9dW1TqDwfclWyyA1YjUIaQ+khxEw6DPsOzrpVsB7MGXMik3gfllJacVkZeTRl9PnzAQDB+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3221

On 23.11.25 08:04, Noyal Johnson wrote:
> Dear Team,
> 
> I am currently porting the native CentOS Stream 10 Linux kernel to a
> Xenomai-patched kernel. I have successfully downloaded the CentOS
> Stream 10 kernel source and the corresponding Dovetail linux
> (v6.12-dovetail2).
> 
> I generated a patch based on the difference between the Dovetail and
> native kernels and successfully applied it to the CentOS Stream 10
> source. After integrating the Xenomai Cobalt v3.3.1 version into the
> patched kernel, I can now see the Xenomai Cobalt configuration options
> in the kernel's make menuconfig.
> 
> However, the following warning is displayed in the configuration:
> 
> "Page migration may increase latency. At least one of APM, CPU
> frequency scaling, ACPI processor or CPU idle features is enabled, Any
> of these options may cause troubles with Xenomai. You should disable
> them."
> 
> I attempted to disable the recommended options (ACPI, CPU frequency
> scaling) but the resulting kernel failed to boot. Conversely, the
> kernel booted successfully when these options were kept enabled and
> compiled.
> 
> I would appreciate your guidance in clarifying the following points:
> 
> Technical Queries-
> 
> Boot and Warning Conflict: Why are these options flagged as warnings
> for real-time latency, even though disabling them prevents the kernel
> from booting?

If you only disabled what the warning recommended
(CONFIG_ACPI_PROCESSOR, not CONFIG_ACPI), it should boot.

> 
> Low Latency Configuration: Which specific kernel configurations should
> be maintained or adjusted to achieve the lowest possible latency for
> the Xenomai Cobalt core?

Depends on the hardware, you may have to explore that. The key
contributors were already mentioned, but also general recommendations of
PREEMPT-RT apply (e.g.: disable hyper-threading).

> 
> Dovetail Patching Approach: Is creating a patch from the Dovetail
> Linux version v6.12-dovetail2 the correct approach for this kernel
> version? If not, which Dovetail Linux version would you recommend for
> better results?

Unless you have already a sound understanding how the dovetail patches
work, how they integrate into the kernel, it is not a good idea to try
porting them into a heavily modified downstream kernel like the one from
CentOS. Better stay with a tested recent vanilla dovetail kernel then.

> 
> Benchmark Results: Are there any available benchmark results for
> xeno-test runs on Intel i5 series processors that you can share? This
> would be helpful to cross-check and validate the latency figures I am
> currently achieving.
> 
> Thank you for your assistance. I look forward to your positive response.
> 

Sorry, we do not collect those numbers systematically. Rule of thumb:
any timed-task wakeup latencies between 20 and 50 µs under load are
reasonable for x86. Anything higher indicates hardware or tuning issues
(only in rare cases Xenomai bugs).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

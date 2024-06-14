Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EA147C87
	for <xenomai@lists.linux.dev>; Fri, 14 Jun 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352276; cv=fail; b=ukWltAV4BAnX7ko2Rd3b2pFDmCo+mlUgYr2/Y9ZgIl0DI04ILYX6K5NYJImVd6P1jYK65YH+3Do5B9r3dcMqfywdFiC00M4VUgE+K8QIy1fl9T2vanSc5rcUdfLZEHKvBgfPivlJB4E0NnHXNjWdpaqdug/jwJqLQmmVMTLXH0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352276; c=relaxed/simple;
	bh=m4a64w2rDIAxCRn3fOZK+1Gwj7JLK4Ho+aHq0xyJUcA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O2xSFXmmPG1iq3hVFqMk6v37ge9q/3tQarlRP5TMcmHW5e8tVN2Fhan/9s7ewkrm/+vaf8vGxwh8H+2IN9QL047k+vruGBmjBWqMw4k0RGzrYmrHJPbkw1197An/XXp4qUoM0z8WJF2TKs9nPOs/vWX6h+zoaVremOIdxV8aHCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mnvIcETt; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mnvIcETt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPrUIBr7vUjLsVkQb9bOYhFJiBzpqXG/UbKX1AzG9045Jx+K5ircrOcWrF4wu21DxwkcZ6cx/0KK/tSkq4tNY/M6DuS64S6ZR8yppkxzuHSGjUJMa/43MyS8SQarx3y5knjA4NT2WeQmdatMB6VZNGR42PzOHgTJOD7zZhTWxzsLs+AqET6+bWR2oFql9uXe67vFj7jvych33cpS0oynvRHnScQEX98YKCCCbF39RzM8BDf78mmnuwoFpnyE4iFNwVOwstPjYSxG/yuo+8nWwv0JjBR+Dq4HQ0oFrFZV7FDMY+Gji3WPOafO9sX91moGegjZZvPB9Y/Ps2DQp2yt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7JEfuYZSYX2Sg7B3Za/BU+LBlKPawxaxx6GF04bLjY=;
 b=Z9a/L6ibousMAWScW2X7vrV1D72FlvV0oqN5tCMuaVL8SqeGNQJLI+LRF1Ux8pzV+EcJirvlq/iub0NNHUGWvCBlYJS79Ocnrp1rGZVe75RfJseK81w4DIL4tqhKOJilVs9tT5TSYjcNr4Yg4u+DoW5uvlpSmPW3etU8hhIihaghrqanQGS98NW23sZjJ+aNQpUusRST6aC7Ys1RpITrnT0CorhL9vf07pihkdItu0E5irF81gjMXDLXd0i+exxYH8HGRCfH1JpqGpXG/Ci3Fp0FspOhTvOt3gfdQXQg5nRE4y1T2zWFUyObnhf2dRCUKcpo7Q8lzKg9cOl7On9xzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7JEfuYZSYX2Sg7B3Za/BU+LBlKPawxaxx6GF04bLjY=;
 b=mnvIcETtBY/WFYCB8itrqNkfMMxcoivH7/2x5EswPGM3ERuPEIj98HcLwpfzngJXMU4BmvzkZA3wiY6dS1oPhonJBiHMWj6c7BXZyt/oreo2hzJ1rBJFmMprVJ56TgVIIwdgZ7EL3IxrYH17mIk7NI9TRI4xHq7HWCI+pW7T+m4sSYtUEdRvc/FzyCrIqRNYovFca4EW4LoZRkNz3uMZroEOxZZQKMuNJSOhHP7G4goFR4iA7UF2hWooFW8/r24xLue6kQNEkrcAtWGqh1tdd4IUOHfQ4waiLGhuibGEFGtkzFaTjZPGbqcR611VNxvPaCI7OZW9U7YW9dOG0TkIzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB9162.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Fri, 14 Jun
 2024 08:04:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 08:04:27 +0000
Message-ID: <3b341ace-3af3-49b7-80a7-2343608674a1@siemens.com>
Date: Fri, 14 Jun 2024 10:04:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC dovetail 6.9 v2 2/2] KVM: x86: dovetail: Allow
 kvm_wait() to be called from any context
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20240531-flo-fix-kvm-guest-for-6-9-v2-0-5534fcae4eb5@siemens.com>
 <20240531-flo-fix-kvm-guest-for-6-9-v2-2-5534fcae4eb5@siemens.com>
 <73b55cbb-0d7d-4552-9102-cc7c16e5834c@siemens.com>
 <f57d19d9549525a94e1c22d0d9b520150afda04f.camel@siemens.com>
 <dc350628-f444-41e4-93e8-b9724046b5a0@siemens.com>
 <5c4192f8-067d-4a92-9ea2-ac5e77ff65bf@siemens.com>
 <fe10e88839a636a104fa1fedbe75e424664763e1.camel@siemens.com>
 <9c69a0a9-8307-4cf4-804b-1ba49353bb52@siemens.com>
 <79f348d6442039a74eaa2f4129d1a5af5845ffdd.camel@siemens.com>
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
In-Reply-To: <79f348d6442039a74eaa2f4129d1a5af5845ffdd.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a2ee3b-a8b7-4195-448e-08dc8c489cb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXVLSzEvdUNIaTlFTHlUdWZhbzB1cVdiYytDOFcrcyt4eUcydFY2b2ZUbFo4?=
 =?utf-8?B?R0EwSmhHcDM2dTlheGNrWG8ySEt4K0J6U0xtbFlSZkloakthQmZ1M0tUN1BF?=
 =?utf-8?B?cW4wUklKT0pjY1RlanZ0eVR0SS9iL09BYkxGYTRZMXZ5L01xYXZOVW0zRldR?=
 =?utf-8?B?bmVxTXR0NTkzUVRGTVdaWU52bVEwTm9lTTJZZjhzQUtkaWpUM0lsanpVYVR6?=
 =?utf-8?B?d3l5YUlLSnRNS0QwS1Y2UGNDUE13cVI2R1BLMkpXQkNNMitjM05GTnIyL3NR?=
 =?utf-8?B?K2pCQU5EV2p2R2JYaWtOWkdyTkhINS9BSWxZV3UyRjV6dFNJS3JRbjVVOHBJ?=
 =?utf-8?B?aXFNSllHQzRCSm5lQTU0WjVmYUI0QWF5cUVwamVwNGRHNWtOck44eUh0UlpW?=
 =?utf-8?B?WVBkZTdDd1doNkhMVGUwSlBUVGVGajZUZmVycHBYbW92U1YrcFVpLzJkc2tn?=
 =?utf-8?B?eGsyclVLVzlXUUt6d2hmejQyMTZWdDJ1eW1aN1JiYnk0YitPS2NlVU1lNGF2?=
 =?utf-8?B?NElhRUlpbmV6d2lDUnNKb1JGa0tyVHhEck9LZ0g3N1hGV0VFbU1Oa2JIL1ZV?=
 =?utf-8?B?YzM1cTVYb3cyZWx2TzgvKzdUUHY5ck1KSlcvNUkzelJmd2N6Sy8yZURobWpJ?=
 =?utf-8?B?RUx3MXlJTWxtbUYzTnY4QTFXb1FoU1ZSQ3VvU0JBQkxkQkI1YjBUbm1SOTdu?=
 =?utf-8?B?SDV0bC9DUTU2aW5RbVVDdEdhSTg2WW9oZjVZODNXckdEdFJWUEsvMlI3RjVK?=
 =?utf-8?B?ZHd3VWx2Y2w3UmpUenRMcHpJUUpQTVcxOGIzUTFZS090SERVQU5JUjBwUmgw?=
 =?utf-8?B?akhrWG5qT1hObXNROE1oZ1RDSm5rUVd6RXpvcUtyWGJGeW5mVVptYU9lRUJm?=
 =?utf-8?B?cUFHUjFwQm5aTitjd2kvSkw1SDN5L3FhVjhmaGRCclo3OWl2bzVLenlxUVY0?=
 =?utf-8?B?d1BvMHRUQ0Q2VC9xQzVXY25CU1VpMVdHaVIyK09qS2JMclZVaUJLOGNzcVF2?=
 =?utf-8?B?UCtYdkFoSlFUaXVOUXpFTmlLdTRqRm9PV0toc0FtRDF1QWNQczN0YVNmZmtV?=
 =?utf-8?B?SVVUb1lvN0NkakJhazNvandIWHJTYjVsNjBRdjk4eklPV3Z5U0ZtR0llMk5o?=
 =?utf-8?B?TS9VUEtZZk1DYWZ6RUo5Qk1CWVR6NCtvdDFvT0pzaldydmtGNXFpdHdsT0Zo?=
 =?utf-8?B?YUx4bW5kK2RLbFFmVzRJRUdRazE0UDVwbjFSc1psTWhjNnhKazVlaWtuUi9R?=
 =?utf-8?B?SjNJWDd3Y1l6NjhGMkI4QjExY1FEcTE5a0ZwYmNUdlV5OGNsMmkyYjBwRVFw?=
 =?utf-8?B?QzFETk1kVmlNT3k3d1dHdXQ1L3RnOHdJdnNnSlk2Z0NJR3U5V1V6Uy8rRnF0?=
 =?utf-8?B?RG55MHlKNlZhRlZqVFRCckYxYWNVNElVWGlIVmhnRXJmT1RnTnhyOGJLQkxB?=
 =?utf-8?B?WEFSVldMalJaOTdnblpYZGxEK0NpQ3crWlV6TG9DWGkzUjd3ek51eGJ0RTd1?=
 =?utf-8?B?TDQ1Z3IvU1BHTUpGNlB2OHF2S3JyT2I3Z0VGUDA1MHE3Qm1LblV0Rmk1T1lR?=
 =?utf-8?B?Tm5PanJ1eUdlSURXeEI3UjJ6ODVlWGpaemJvNlNHc3NOZ0laQUNhTnRwNWdk?=
 =?utf-8?B?bHRTUlN5TkNreklCbFBseE1iODV0cnBtMDE0MGN0d3NKTUN4RTNLWVZxVDZZ?=
 =?utf-8?B?ZXExbG5lSVl4Y1RnM3Y4dkwzN3RRRk1vdGNNRjdGK1FJY3BTSFVlQzkzYVNm?=
 =?utf-8?Q?a/lI4vAoRiI9waNUDUc2X8pN2+DMo4NQMM+7Hl1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUx3c3UyQmNweTZyR3FPS0pjVGR5aEN1Um9HNUFPc1BzZzhYU1JVVTUxQWZJ?=
 =?utf-8?B?b1RSUmNoaENOOVpRUlZadHJzZmphQXJtd3NldC9ROTBzMWxlZ1V5aTZ1VXdL?=
 =?utf-8?B?R045TUVYenVpS2VXM3UrNlB0N3FmQzhtbWIvOVFieVFsNTZVYzRkeGdYcHNF?=
 =?utf-8?B?WG54Vm9sY1gwOUkyWTJGQnRubUpjQW1JUXdyT2pFUEpZS0xBdUpUSFBKTkc4?=
 =?utf-8?B?M2xyT1Y3OG82d1EybWJrakFMK3pza0h6eUFOVnJVZ253OTRNYnFvWTJldzBK?=
 =?utf-8?B?SjdGc0JWVTdpRFRvWGRkQkZIam54Z0MrTTlhNVNydHQxZmxaOUcrVVdtRmxw?=
 =?utf-8?B?TEJnbWJGdzJPQmRMby81QUI0UnM2MnlrOGpKNEM2R1p6RzhQaThSdGcwS0FZ?=
 =?utf-8?B?N0h4Q2EzMmh1R0xCalA3K0xUQnRycWIreTBtUHR0OHVpNVhBNkI1MmtLYmY1?=
 =?utf-8?B?b21FZ3JQOWpHUmhiWDZaOStHSjlWUnpyRW9IakwzSlBqeWRnaktKbXdEQUxy?=
 =?utf-8?B?blQ0K0txM0FaREE4SGFUSFNyYTVCSkE3VlBnMlhMNWZULzFacWtsOEVuczV1?=
 =?utf-8?B?MnI4L0pFWU1aUTBzbWZyRzZ1cmlYK1Yvc1VEeGgvRWlaUndyWnd2bnMxbzly?=
 =?utf-8?B?T05xZWt6ZFB0QlRFVGJQQ3lJdnB6dCtPc2ZNNEltSUMyQk84Mlp2cVY3S2E0?=
 =?utf-8?B?NmJocWt5RmlHQzcyM05XOTVlMWErVnFYdEFIaWpmK1ZPR29uOVFTc29xV0NS?=
 =?utf-8?B?ZUlNUmF5WUlwekNndSt4a21pek5MSHlnOWVObXBuYVNlMXRxOWlSV3dlU0lx?=
 =?utf-8?B?emVnMHo2YXMrQngzdXRpdDYvL2hjMytVRE52OVNKcmVuZDBuK21kMk5IRXdq?=
 =?utf-8?B?TWhpNit0bHJISCtaSkE2cFpzTDZ6elQwanJ5bWZFQTZtVlkvVlFWeFp3UDg3?=
 =?utf-8?B?RlFTbFZBdGhrbE5Ob2FoZXF2K3lkRGRsK2ZYR1Z2ZityWUlVQUhxNTRFOUxw?=
 =?utf-8?B?MloxYjZNejNCWUUyYTJiN3lLalBoa29Ebjc3VUZaVm9xOXpFZmNxQjl4ZGc3?=
 =?utf-8?B?cDFGdXl4MyszSWNmd2lMRUNTUnQ0cFdKSEtBRTlPYlFYWTk0aENVUXdJOUZO?=
 =?utf-8?B?UlE2U2MrUHJVTDkvYXRNZ0RHVkQxcjVGZ0h1VjZRaWRXZ05kcEtOQWJXNFRr?=
 =?utf-8?B?aEtUTFA0a1AyU1E4TmhuOGYvQ1RxLzVSMGRNT082eFJSUTVWcDZnZytTYVlU?=
 =?utf-8?B?amdPOWYrSjBydVVHWmtjTlArQ2lWU2htdEJBdkx2VXMwRWJXZm1oV1NlM2FZ?=
 =?utf-8?B?MUEzMlVrRk8vSDJvU3hWRWl2K3FVRFlXcWVvZmlHME1MRisyQncrd01sSWR1?=
 =?utf-8?B?YXY4dEVsL1pmZkFtcnc0WnJ5dW9rb3B1QStkS0hUdEJZU0x6NFlJSXE1TzJ3?=
 =?utf-8?B?UnQxOVFHNU5XMWdqUzlFNUN1c0U5SHNxbGRERnJxUXF6T0xSYjI5dXkrWEwy?=
 =?utf-8?B?Z0dBY2FPLytNcU9mZmRjbEw3RUMzUDVKT2dQMTJ3ZW41K2pWSmlmVlU4RFBn?=
 =?utf-8?B?ZVpLTUFOaTZCWHJDaXV5RVQxU3ZaR2dQYzJMblltajhacnJvWjYwRVl2TFh2?=
 =?utf-8?B?WHpybS9WdmIvZHJOZEdHbHRTSCthelY2bDZpUTIzN05lYnB0R25KRk5SalFK?=
 =?utf-8?B?T0p2dXdtQW4vWEQ5S3drS3h4cVZvWE0zR1IvZ2tpekNUYi9XTTdjSWoxQWlU?=
 =?utf-8?B?akZzRW9BeXFVL0RqUDdhd1FVak41ckwzZ0tLdDJqNXNmQVFJemprQ2NKeGU5?=
 =?utf-8?B?eFduUU16M3VrbHUwNXdOZHFxMzNzYTBlQ3oyb1NaNmU4UVFFdmcrUDJDLzNk?=
 =?utf-8?B?OWpPNzd4ZlVXbjUwdWQvK3ZkblBPNGtrU0I4Wk9nakhFT1lUY3JNWHc2c3Zv?=
 =?utf-8?B?ZWh3MGhPanJlSG4zclpVQ0FrS1ZiVWQ4VWlaSlloRVRoTDFSV0VLR2VPZEU0?=
 =?utf-8?B?RER6MStmZUgySzJKdHNncG00bW9zQnkyK00xVzEwL1oyZDU0U29nZHFMbktS?=
 =?utf-8?B?QlNrMDNFcUgwVUcvRmJzcndTY2NvdXdsOFNHOTRNc2xlRDFSK1ZOSjVHMWs2?=
 =?utf-8?B?Nkc3U2VVckIzRC9tU3g5dHVwcnRjWndrajdkR2grTm5oTENZMG5JUXMrMjly?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a2ee3b-a8b7-4195-448e-08dc8c489cb6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 08:04:27.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4bXlc9qeN/kgBe7IYg79UkKb+HQajXmUN6Zwc5pgrZWFYlYn+AYw/OsB/+5uO1ivQKcz8tHvBdrfDf0FIKZ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9162

On 13.06.24 18:15, Florian Bezdeka wrote:
> On Mon, 2024-06-10 at 23:16 +0200, Jan Kiszka wrote:
>> On 10.06.24 09:58, Florian Bezdeka wrote:
>>> On Mon, 2024-06-10 at 07:43 +0200, Jan Kiszka wrote:
>>>> On 10.06.24 06:21, Jan Kiszka wrote:
>>>>> On 09.06.24 13:44, Florian Bezdeka wrote:
>>>>>> On Sat, 2024-06-08 at 07:31 +0200, Jan Kiszka wrote:
>>>>>>> On 08.06.24 01:04, Florian Bezdeka wrote:
>>>>>>>> kvm_wait() unconditionally enabled HW interrupts when called from
>>>>>>>> pipeline entry code. That broke the PV (paravirtualized) spinlock
>>>>>>>> implementation.
>>>>>>>>
>>>>>>>> When running with CONFIG_IRQ_PIPELINE enabled we always call
>>>>>>>> safe_halt() to allow HW IRQs to be handled.
>>>>>>>>
>>>>>>>> The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
>>>>>>>> Linux.
>>>>>>>>
>>>>>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>>>>>> ---
>>>>>>>>  arch/x86/kernel/kvm.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
>>>>>>>>  1 file changed, 53 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>>>>>>> index 655b1cf8c9ab..3180a26cdfe1 100644
>>>>>>>> --- a/arch/x86/kernel/kvm.c
>>>>>>>> +++ b/arch/x86/kernel/kvm.c
>>>>>>>> @@ -1059,22 +1059,69 @@ static void kvm_wait(u8 *ptr, u8 val)
>>>>>>>>  	 * for irq enabled case to avoid hang when lock info is overwritten
>>>>>>>>  	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
>>>>>>>>  	 */
>>>>>>>> +
>>>>>>>> +#ifdef CONFIG_IRQ_PIPELINE
>>>>>>>> +	unsigned long flags;
>>>>>>>> +
>>>>>>>> +	/*
>>>>>>>> +	 * We always use safe_halt() to be interruptable by HW IRQs.
>>>>>>>
>>>>>>> Nope, see below.
>>>>>>>
>>>>>>>> +	 *
>>>>>>>> +	 * HW IRQs off:
>>>>>>>
>>>>>>> Let's stick with the nomenclature "hard" instead of "hw".
>>>>>>>
>>>>>>>> +	 *
>>>>>>>> +	 * Wake up on next HW IRQ or by a vCPU kick triggered by the current
>>>>>>>> +	 * lock owner.
>>>>>>>> +	 */
>>>>>>>> +	if (hard_irqs_disabled()) {
>>>>>>>> +		if (READ_ONCE(*ptr) == val) {
>>>>>>>> +			safe_halt(); // enables HW IRQs
>>>>>>>> +			hard_local_irq_disable();
>>>>>>>
>>>>>>> Just halt() - if we entered this with hard irqs off, we cannot assume
>>>>>>> that it is fine to take an IRQ before returning. The kernel doesn't do
>>>>>>> that either for Linux IRQs.
>>>>>>
>>>>>> ACK.
>>>>>>
>>>>>>>
>>>>>>>> +		}
>>>>>>>> +		return;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	/*
>>>>>>>> +	 * HW IRQs on:
>>>>>>>> +	 *
>>>>>>>> +	 * If inband IRQs are disabled the LOCKDEP state is already correct.
>>>>>>>> +	 * We can disable/enable HW IRQs without further bookkeeping.
>>>>>>>> +	 * = Linux IRQ context
>>>>>>>> +	 *
>>>>>>>> +	 * If inband IRQs are enabled we have to inform tracing / LOCKDEP
>>>>>>>> +	 * infrastructure about the HW IRQ disable/enable event.
>>>>>>>> +	 * = Task context
>>>>>>>> +	 */
>>>>>>>>  	if (irqs_disabled()) {
>>>>>>>> -		hard_local_irq_disable();
>>>>>>>> +		flags = hard_local_irq_save();
>>>>>>>
>>>>>>> Why this? We have tested that state above and know it for sure. Just
>>>>>>> keep hard_local_irq_disable().
>>>>>>
>>>>>> Paranoia and to clearly express that we try to restore the state to the
>>>>>> state that was observed on function entry. As hard IRQs are/were on the
>>>>>> result of irqs_disabled() might be outdated. (I think that would be a
>>>>>> Dovetail BUG(), but paranoia...)
>>>>>>
>>>>>> No strong feelings here. I can change this if this is preferred on
>>>>>> other ends.
>>>>>>
>>>>>>>
>>>>>>>>  
>>>>>>>>  		if (READ_ONCE(*ptr) == val)
>>>>>>>> -			halt();
>>>>>>>> +			safe_halt(); // enables HW IRQs
>>>>>>>
>>>>>>> Yep, this is needed to avoid delaying hard irqs while waiting for the
>>>>>>> Linux lock-holder.
>>>>>>>
>>>>>>>>  
>>>>>>>> -		hard_local_irq_enable();
>>>>>>>> +		hard_local_irq_restore(flags);
>>>>>>>>  	} else {
>>>>>>>> -		local_irq_disable_full();
>>>>>>>> +		local_irq_save_full(flags);
>>>>>>>
>>>>>>> See above.
>>>>>>>
>>>>>>>> +
>>>>>>>> +		if (READ_ONCE(*ptr) == val) {
>>>>>>>> +			safe_halt(); // enables HW IRQs
>>>>>>>> +			hard_local_irq_disable(); // fix HW state for LOCKDEP
>>>>>>>> +		}
>>>>>>>> +
>>>>>>>> +		local_irq_restore_full(flags);
>>>>>>>
>>>>>>> How about this instead?
>>>>>>>
>>>>>>> if (READ_ONCE(*ptr) == val) {
>>>>>>> 	safe_halt(); /* enables hard irqs */
>>>>>>> 	local_irq_disable();
>>>>>>
>>>>>> Confused. I think you mean local_irq_enable(), right? Otherwise we
>>>>>> would jump back with hard IRQs on (again), but inband IRQs disabled.
>>>>>>
>>>>>
>>>>> Yes, enable. The goal is to avoid that hard-irq back and forth.
>>>>>
>>>>
>>>> Actually, there is no need for this dance at all. Just translate the
>>>> Linux version of the "irqs on" branch to dovetail:
>>>>
>>>> 	hard_local_irq_disable();
>>>>
>>>> 	/* safe_halt() will enable IRQ */
>>>> 	if (READ_ONCE(*ptr) == val)
>>>> 		native_safe_halt();
>>>> 	else
>>>> 		hard_local_irq_enable();
>>>>
>>>> There is no reason to touch the Linux IRQ mask. It's open on entry, and
>>>> we can take any type of IRQ while waiting.
>>>
>>> Correct, but we would miss this hard IRQ disable event in the tracing
>>> infrastructure. Is that OK?
>>
>> Not sure if hard irqs are actually traced. I thought they aren't with
>> the given functions. If they are, you are right.
> 
> hard_local_irq_disable() simply turns hard IRQs off. See
> native_irq_disable().
> 
> The replacement of local_irq_disable_full() is:
> 
> do {
> 	native_irq_disable();
> 	do {
> 		bool was_disabled = (arch_irqs_disabled());
> 		arch_local_irq_disable();
> 		if (!was_disabled)
> 			trace_hardirqs_off();
> 	} while (0);
> } while (0)
> 
> 
> It's basically hard_local_irq_disable() + tracing when the inband IRQs
> were enabled. That would be the case here. Do you agree?
> 

Yes, and as we have no need to fiddle with the latter, I wanted to
reduce all this to the hard irqs.

> I think it's worth to keep / get a trace event here. The underlying
> hypervisor might be the source of some latency. Would be good to see
> that in the trace.

What business does the hypervisor have with the virtual IRQ mask for
Linux that Dovetail maintains?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


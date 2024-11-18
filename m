Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A052B2110E
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920503; cv=fail; b=i3gQuqGBAiVxP5GkBS7ejZFyddlfMTfR8SEBkFUzBaLQrMXFzojvhSQLlx4LcVRDGRRreCFN4RtOWS+EtaGYj1i9djh3XpZTkGTCyZoLJG1wlGIG7T3GKDSGgqpvlCNstBz18+Jxyod7vh9GExGjyRbdJK/FrMrJtP7Nbmpd7Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920503; c=relaxed/simple;
	bh=ad2pAFIZIJBmpJ/XUuyOJw07oZ1X5at3r5vscjTRF2A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kjU9PihK2FcyCIi8o34vD30eJaIEEQ+y/vnT7PkMX8MPhocw+eNRWi6rpc8JbhD8ecRSwrqbFyJHShldrmRvPLmlE0TJXK4yRyrYB6jTIKPsq9u6TVIDSr0uF3Yi8JMMHaMMwBbUFU9jo0GOy0pXeYtATa/O+9v7JM6Vk9sqikA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IMlENEMd; arc=fail smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IMlENEMd"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id CF9BA8000B
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 09:01:39 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 0EB3A941393
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 09:01:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gzc3mk/zv4jlFMogWpcKjSmViToNdGHtg7B0qEAWm0L4O8ug9zQT4Ld0oVF4SKjh8ggVQaUoKLuUVtIxOy1bE8MiqZrj4DkzUbM8cpUAk3jLaO5jcfP32ByUUZutFxx+5nK01xSpZLjEn/GEu8E0XciOvfDUjSO01ouD0CC5Nn4GvD01UUWnrYide2jzEYcPHftN7Oj0cXTBJqG7MsAd5ejiiHxMug5dnTV6TkON0+MKt9Kki9UX8lvVgaPfYHDxl7t3WYMzl/bubNggUTOBpLr+P+/0CLgqTNSWEtOI6s4IflHbfkIEQm74BIZKf/MugfFQ1ZysB7FsVduVEDqADw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpqEAt49xcMpJmObIGDgPMd4DKGdN2FWsmzVRvfuHAQ=;
 b=eKyBxfiGYkN2qqYYMa9nUrsAQxQOvBgaojF6HtYcRQ7FTQPVwbKzVW730WGe/D0K+hPmyDJ/3aWnM9tUZu5OvKBQYiLFRoaVrWAHT12ffJGNXZcnXKIxYm0/JZ0mvaa3fjK+cokKRqVG/B1K37b/hCySyQAWZJCPQI3qOy4/KzcYS6mazodqsv9Kw9MDppzYgM1Jw7xFlknY9KTF7y227Lai+oaWZOyOk/KHwDmfRanGM0SQmuQOe+jy4q8lug7fvQKnF/U0lhPgMwJaJzdU+jky5kEOfoSHCEZEhDMoeAomzIM9nuHrgwZIHGOZYGsgmPVL4n0tDhDtdJf6SO0Wzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpqEAt49xcMpJmObIGDgPMd4DKGdN2FWsmzVRvfuHAQ=;
 b=IMlENEMdpZlfSp9eiQ9EU9Ay1XPYxjgxfiugA2MqR/zjl7Ii+9LerGhP+78NacUpC2kFsl7JCQooTMxyXGSVcWSsLybtLMBIsjHyVzhnmXjCkEiH0BYJPGW3sKohA+QM7vt8VDLbaD4RmRV1e0Fzzfa+O0e9R9yb27saxq1IG8thfwC3bo+O8sODNDyHGnNpFmWzR/cYeg0iwCxYRCSlIlilo6G06Ompn8yFfKdB74sX2bhod0M/cUb1FjuT1odK0mj3x0M2qF9COxZCCuNk9DHQgYxddRBO3I5kxLsmRQrBN49gxbnf3sNjpKN6nmvQK6Z4pl2PmuyrvheovBvzSg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.11; Mon, 18 Nov
 2024 09:01:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 09:01:37 +0000
Message-ID: <95cf1a42-58f9-4319-b2a6-45400bad4c15@siemens.com>
Date: Mon, 18 Nov 2024 10:01:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Switching from xenomai 3.2 IPIPE to xenomai 3.3 Dovetail
To: =?UTF-8?Q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>,
 xenomai@xenomai.org
References: <1017-673b0000-25-2c5d8800@223319875>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <1017-673b0000-25-2c5d8800@223319875>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bda504d-e809-4a2e-8d94-08dd07af9bef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tys3K25KVjF3aUIxN3hMbzhwc05NODJwOHdnamFpRUp5TGVKQnRaUXlwS29k?=
 =?utf-8?B?NDJlcy9jblNINWsxdTRyN016empFbit0WWxDbkJiZ0dpcWs5K3c4cWZMdUp4?=
 =?utf-8?B?VGFTcDZnMmxOdUhSakhLaHVhUWRWRXJXMHJEallOdDgxbGhKN0N1T3VCSTNO?=
 =?utf-8?B?QnpDK2RVa1Bna0FyQWJRcEtoaTd4QldUcHh3WnB4aDBlWlhRdHdFNzlxTzE2?=
 =?utf-8?B?d014ZzczbysrU2dUZ2J4aHlEWGdXZG5BdTZNSlV0Wk5GOEVZaU9odUNFQ2hs?=
 =?utf-8?B?dXBEcjYrNUxOZHlZZ040Nks3MjJXVzdVcXd2MWZiUUtvRDNwWUMwTWZZWVVW?=
 =?utf-8?B?NHBKNThXWmxXOW9IU3BnOUovUmRMeFplR1BieElqQ1FkRjQrVWlkOStpWG5Y?=
 =?utf-8?B?RjVmaG9CeDVlUkZ6cHk2RldDZGxiK3MwdE5BWkhVYm10UXZlSURrRW1abE9n?=
 =?utf-8?B?OWVaclF6MzBWYXBjU1hUTytmWjNvVkNzSGw1OWpsUkNjeHVHcnhWZnNVejVO?=
 =?utf-8?B?SmpLT28wcWp4dzV4cmN5cVRzM3J5RnRnM241dzJVemV1RlpQcnJQcGNjaU13?=
 =?utf-8?B?SXV5aGNHK2pQUjh0MkdqZDZWTU1GZno2OVR2bFI2QnJ2c2RaV0wvRE81VTZu?=
 =?utf-8?B?T09TNGJPSHVVQWVBM25RcG95ZGU4TEc4aUYvOFRjODhMQ3ZLem95ZENxZkM3?=
 =?utf-8?B?RFFsZUJvZXJ2WlIwWG1mSVc0TmRuR1l0ck0rOEtHZ2lrcDJvc3JqWXFQYkhS?=
 =?utf-8?B?QjByZk9CbWxoekllSy85VzNib0ppZGYraTN3YXhtcmJHZk9IcUpXRDdXalJN?=
 =?utf-8?B?TzE3OXhFSHp0Q0ZRaDhiZmRJQ1hJSSt4U1k3UE1KYm5PR1M0MWt3aUQrV1Fz?=
 =?utf-8?B?cnhjQ1VDbDJoOTliQ1NWcnhDQ0tud2g1TWNwMWlBTlQwRmhvMlhoL3BnK3RI?=
 =?utf-8?B?c09Sb1owUmUxa3hOTFpSTTVrRVVSYUFUNnMvQjArLzExZytNWThlVWJDTWt4?=
 =?utf-8?B?Zks4c0RNWVRmem1jcmttVHAvZjNIVlBjOEUwMTQ0ZWNTSVROVDAxcEdoVFBn?=
 =?utf-8?B?M3hlZXRSVUhna2Qzd0Q2L2wrOS8vakdGZVlsbWJYMk5KL1hkdjYvVzVBNzM3?=
 =?utf-8?B?cDNENTlMUkVlVUxVTGFOSFFweUtpa2pYalhFbTJsb0ttVk44aWZlQ28xWC84?=
 =?utf-8?B?bFhsZEJmNVJUdndFKzVnN1A0Q3VTZzRwVHBIMnRYN0o2ZmlRdlhMMTFaSTd2?=
 =?utf-8?B?MGNWeVBUejkyT3NwYmRjRTNBSjQyNWJCbVZDN0NjdmxmZ1JUbWNCQWNxWWo3?=
 =?utf-8?B?T0FyNzcrcGtyVGJ5MDZxeDFSQjRZdTZKeXY5QlRmOEtRL3ZLMlp5b0dJMldW?=
 =?utf-8?B?VVFzZ0ZrTWtyL0hORXBOdkw5Q3R4OTAwMlBmK0NBdUVQUjIzL1d4TjRUZEMy?=
 =?utf-8?B?eVpCYUJ6ZGRyU3ZkbWVHOFo4QkIrQlltVTdXeTFtZHZDWjA4RitrSEI2UWtx?=
 =?utf-8?B?eHl4b0FKc0QzMWxmWFNCRTBBYTNiVjJMTjE0WGdFeFFQRjFTaUNSOCtBQTlx?=
 =?utf-8?B?OGxmdEpscnJ2WWR4VWpJaGhNd3M3YmM5eDQvNTBFdHl0eHZPNzh0T214b3FW?=
 =?utf-8?B?c2twb3FMOEpPREt6VnNYTXhmVTI0clIxbHUrTThqVGx6RXVHOUVrb1J4Wlo0?=
 =?utf-8?B?M1Ftc0MyRVVFTVM0cXYxdTRGN2h1eDhIaThKSEcwNXBNUGttR3FJL2g3c21x?=
 =?utf-8?Q?gqmlZ6rPyRRDXq4OMtOP1InuGu3E7UewUmkhot2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnVMc1NNT1RKZXRJQktubHJRemp1OUVGcEdDclh1ZHU5YUNTb2hQT0FhS0F2?=
 =?utf-8?B?NWVZZjhNTnNaZmVBMHBzQjBPN1Yvc0w3aU5Fd1l0RnhnMnlTMlFaYnRONElT?=
 =?utf-8?B?Y0lXbExqTHRpTjhDSlVZWXZTL0VIdk1RR2FHczg3cXlxdzAyY1pQZVpOOE4r?=
 =?utf-8?B?UmNHSjZpTDFtZk81eVMzU1YzbG90aWxRWXErSDc1SFdFWDJIQTBSTWpFSjgx?=
 =?utf-8?B?a2dqY1ExRkpBcHh0UUhrKzJJWFgwalRIcUtySE9OY2l0cHNJVXNIUDJuY3lV?=
 =?utf-8?B?RDFVa25mcXNiZjBOa3R0Y1dFVEN2SjhxcVJuTXNmYjIxSk9QblJ6MnVtYXJ5?=
 =?utf-8?B?WmJ6Q1NYSkVSWGJvR0FYT0R3b1Z6NTBNb3NuR3dZY0pad3kxN2xlSG1LSzNo?=
 =?utf-8?B?WFBFaklhTjluOXJ3MXZyM3piUjJES0tRVTRwc0ljTnFsU210WU8rLzEzUHEz?=
 =?utf-8?B?V3dSRUZIeW5venBtV0FWM0dDdDgyb2c2dGUwcEZZUjVlbklDR1lCcmJhZFVH?=
 =?utf-8?B?TWxXdDY0dnpZS3VDT3pDQms1c2FaMU5NMFZNclVhdFN0THp5TFBTbXZobm5j?=
 =?utf-8?B?VUdDSDNQVnZTbEREYUsvQXJyRDlSWnpGVTU2V1pWZ293WEEzQTRxaDVZNDho?=
 =?utf-8?B?RkVaZ3REODg4bDErZUVMSzM0SFZRZyt5b09nSisvY1ppTjNpOGJGQ0ZRYUU4?=
 =?utf-8?B?WnNGRFBlQ1RDVVd3bDI3QXNTQTdXeWJha0tOb2JlUUNkdk1rWXlCKzRvOENR?=
 =?utf-8?B?c2pJKzJYdUkzak9lUzdPSzQ4MzVTNys4WE93R1piSmdzSlhjZ3ZIa0xmZWc3?=
 =?utf-8?B?MFR3eEFoYkhEWURjNUJVcGwxaHFvYVl1OUdnWGxJYkdQUVpGSTZsQ3lXejBi?=
 =?utf-8?B?MncwZE5uOGF6SGNpTUpwMXRYMXV0WXlQQnNIVTFyd25Zem5NK0lLQWlYMy9r?=
 =?utf-8?B?UlJaUzNHbnRQR2xnWXp3N3E2cVdiaThneXI1ZnB3cHBnMml0ZkczUytpNE0w?=
 =?utf-8?B?MmhUc1hjKzJkOTVSSVJmRS9BN0Vla2RPL0MrUHoyTGd0Y1lZb0Q5Znh4YVVR?=
 =?utf-8?B?NDU2YVBJTzNSb1FDbEdEUmR5ZUUvalZuMGNRYWl1dnR1VHppRFRFNzdxQVA2?=
 =?utf-8?B?enhpVDdhYzB3SEREQkRKeTFaUk54blN4R05SYXB6MUpBTU1Ock5ib2QwMjlL?=
 =?utf-8?B?Qy9QUUlVZW51enRnNEFWNVJYTGJCUDZWS1BhK0x5OE5zTzZjdWFFRSs0ejFz?=
 =?utf-8?B?cnljKytsQ2pzWnhrMHRlazJYbllYZkkzcjhsb01mamR5NnBjZzFRcW5Nb1Zi?=
 =?utf-8?B?dko0WmZjejBldjJsak5vK2FuNGova1NFbmVhTVVtRUpyRFdKWU9BNmZ0d2Zo?=
 =?utf-8?B?TjhZbU9sb3pPbHI2YXc4T0FCVldHeUw5M0dHaU5QeWNwclR3dCs5ZHRZeFVU?=
 =?utf-8?B?N2tjdkdKelVMRzVJaFZYeUs2cytpVGZxbWhmLytyS29HL1ZwSHU3QjdqeCtV?=
 =?utf-8?B?WkJaZ2NBQzQ3YmpLY0FDc3h1cUQ4REN2aWgrdHlJSmV3QjlYdWsvSW9Pa3RJ?=
 =?utf-8?B?K29nTVNSUEJnWVF2MjUrQlhNVnZWUWdlSHhzc1RudHhCZHB6SG9nNzJtVjNC?=
 =?utf-8?B?V2Z5WlhsL3NJVGFxWG9VUThZdi84N0ZVS3REbUcwZ0lzSWxnbDRRbWFEcE9Q?=
 =?utf-8?B?L2lpYTIrT1drdW1pSFkyNk9ycWU2U2I4bjh6NFhJbXoyK0pjaDViaFJMNGlT?=
 =?utf-8?B?ZDN2c0MvcEVBMGlQR1oxSElVNmlhV2hzKzAwQzc0UnE2SnU4ai92b0xBMDBa?=
 =?utf-8?B?WWNtRU1zcncwRUZiaEYzNUdsUEdZcFFrRS85SVU4UVpKRTFzV04ydlBaaDVq?=
 =?utf-8?B?S0hHZEV6R2RROGdDWGdFU3NaNWhmbTVHOGRBaHBza0hxcmE2aW4ydmh0dzZu?=
 =?utf-8?B?dGtiMlF0ZlFjZWlQcUVNTSs0aDV4M3NYdDdZbUFhcjBmNGZ1cGJTaVIwWDlN?=
 =?utf-8?B?dGMvNFdOM0dOT25rQzZ1bklIbUhHZDdFbXA0TVhGU1pSRFozZktkdjQwYUZY?=
 =?utf-8?B?d0MzRzQySEkyeVNnSy9IYThTNXN4QzVaY3pXbzlFQk9WZUVlVWV4ZWFXWG1p?=
 =?utf-8?B?d2djc2xmQVg2YWgzMmhxalhhRjBNZVM2ejdlSlI4Q3BkTDMyR2FNMGNFL0pt?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bda504d-e809-4a2e-8d94-08dd07af9bef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 09:01:37.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQVQ9ZmW6PF2sd2jt9d+zyFc07jzPW653qj7XooBRELFc+PeWZCa7nWFeGyu/U3RHE/EdI4Drgyr3Jj4WiQefA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7365
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=IMlENEMd;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:c201::3) smtp.mailfrom=jan.kiszka@siemens.com

On 18.11.24 09:50, François Legal wrote:
> Hello,
> 
> running on an Arm v7 cortex A9 platform, I'm trying to switch from xenomai 3.2 (linux 5.4 IPIPE) to xenomai 3.3 (linux 5.15 Dovetail).
> 
> I can successfully boot my system with linux 5.15 + CONFIG_DOVETAIL, but as soon as I enable Xenomai (CONFIG_XENOMAI), I got stuck at boot in a do_idle loop. Did I miss anything ?
> 
> Attached is my config.

Can you factor out from it what the SoC is, if you patched the kernel
for it (in the past and now), if you had to adopt Dovetail etc.?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

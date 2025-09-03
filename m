Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98E302756
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920349; cv=fail; b=DwtpBfMGcPFOViOT1Li9MEekHTYYrCg5qe8/i+uI3z1AoQfdhyPFS/UGmR/UFqHiS4jQyB6B6QZChbKVnUiZ/tz6i5tXwJa4oTTfluGGuW1+uEXE2CsTzLKeTMFUhH7W/kry4MU8DT/Q35+dmXFsELf9l7ou7UF4KxgGWSxiPu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920349; c=relaxed/simple;
	bh=adFWtc/zaQhKy0N6ChvBEoJNc3yjHZiZKwZQhMYPmZM=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=rMbNfntK9XCZH7PrRU/VdRa2XFcTP2EsR/fluaVdt7qUMDciRYmdzeTgykmJgvgSiBk+m5aMVyAqOLAdO13tj7SRkQfCYhBH3ULAVmpvfImq6uHNIR/BLXV6bKvH0ygnveBUb5Qh4VLQAmKCM8GokZ0w/I4JUaNOT176FQYG4GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KVGOlrnr; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KVGOlrnr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JR/lGYt5CdCaMVBproFa9xxbOTZJsWvp5sKMiHArVHqY+RUl6BJhHxeo55v814Z35IY6EiLGmfZ+DHnETc1b88/2lrYXbEwwlVUPCsBWbc9SnvEBMBiXQorJTSENveii+60nKvsQZt2HWiCychl9tTJDK0iYwYvjgf0OLdzdm1Zj0N+lnko7RLdFRuj63jmk0BVa9sWOjgFp+irjxqqn6R1CS8ewQ8HnnYz2xFzYitYbV+nhTlAq7PqxjkNb1qASsfe9ygdEwJc4Wo6Rc2dPN1fZLLGgI2Qb7pfnPOLlThQVdNxjm1SS5VjkkYiOt7TmUsw0nQEiI4FvZn3+FmvUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyKg26u1zKz4+bZLtaCfjDwv3yvtMNafIM6k04y0rnc=;
 b=uGpAhTWNMW/5u3zoB4VxK84INBR9nm9Hj/KBe7LW/G/LcRV4/szs9vGWjKW9Z34IfgWWdk6KskNa3B7UUmN6536mHlqwCSl6mD/KYSiJxiuv0ezonj0BwGXGIFalPi5wWgFsEJ6UDOm4CIB+2HmY5XZlS7gu5KT49WImtiy4DZqA81VyzQmg0NtQC/PF2fiXcY9jhA6tpQuhjvqYWpdyKLci8rnymxcuHFVVYy0a/UmD7E0hPlefv5j7rN4IXWICnnfy0AzmWsFYHV8oE62RehqQyM/8p1TkpzsdZ4HSBpa6WCoWHAMdQ/bIye16n2BZ4bEN657eKg6nHFURw1X0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyKg26u1zKz4+bZLtaCfjDwv3yvtMNafIM6k04y0rnc=;
 b=KVGOlrnr6aie9SuG0P0yP0iyW438EyuuhVydTAzL2Ay2Kj9pwz4TvM4mnuujoI/Em17g+LiVX7OkkCMg7ZVHeDG/8VeQ727Hr+JqhI8TKUEmQ3H4fzRjKigKFvWVX36gBynscbGvhH1Yzw8jON71U2R2WtfDSKubSdLpQPLIeQWo8s9HX6+tBLwLpqoAXIj89pd+itN/HyLuz2WqBL/M7io15CQHhBCc0dVQYtotb5yEeEB4jyBc3jzVW7mgjYsqcdM6tF7w7qysQDSpjX486JEYlpJ3jJZmbUn4wAWz1aylHT0G+4cCdrruvgwCI/+LOUGXpVF6n3ldkRIzCxIcPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB7402.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:25:43 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:25:42 +0000
Message-ID: <9b3b2ff3-da74-46e1-92bd-ecdbfcdd3fc8@siemens.com>
Date: Wed, 3 Sep 2025 19:25:41 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH v2] Switch remaining github.com/xenomai-ci
 sources to upstream gitlab.com
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 71724711-2949-434b-24da-08ddeb0ee8ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWlZSnBXVmQxd2dMRE9VKzVyNkRZVmkzanhLSDdyTlQ5YnpUUGUwekRFUUE5?=
 =?utf-8?B?YzZRN2ZES0tSbzdPTk92M2JCVjQ1WnE4MmFnZ3o5UFpocXNHTnQ1OCtRU0Rw?=
 =?utf-8?B?WWlXNFRDWU9TWXBjMFBncWJOdUlRL2V3NisvTWxXMzlIcldhMmIxTTV0WWtu?=
 =?utf-8?B?VGcrbXpvUGE1OUl4VVlGdk0yeUFGSzkxVmVJS3M1c2VFcWpQbkxkSHVTVlpJ?=
 =?utf-8?B?Vmxyb20vWFBMZTJHdlJnMHBOVk5HZkFwY0w3V3ozY24wQkZ5U0xMRzFSVFgr?=
 =?utf-8?B?UzBoUVhvVkhwSXNHSldQMExsUXR6Qm5nSjh1a0orenQrWGZ2ZW90dmVHaFQ5?=
 =?utf-8?B?YTVzZWt1L3BJajR1QllQRGxVVTdzZ1plR0RrRVlnTCtmdlR1TVdhb0hweGo5?=
 =?utf-8?B?VStMK1N3M2Fsc1pDVTgrbmZoYStxaFRteTdBelVvTDUwSzZodXExU1pMbVFK?=
 =?utf-8?B?N09ucWtNajRSRU93OXVnbG5pZ3F0Z0tJcjFhaldPMFBjb1ZyekgxWGdXTFVh?=
 =?utf-8?B?SzZSRGJNRmRDRys1QVYyQ01LOWt3eitlV05XM1VuMEI1LzZqVU5OdUl5aVlI?=
 =?utf-8?B?S1BBWEUxLzZmL2d4RW1GeTB4NFhpdmkxNkNPSWpTVXU0YnBBMnpIZ3NLOThU?=
 =?utf-8?B?dDVLa2JSaldpSURvQ3JPYWRtNmxCSDNoR0J5ejhNYmg5RGM4KzVhblJVbTlx?=
 =?utf-8?B?LzM4d2NtNjlrT0ZWUkNaYXM5bzc2b044aHRJbWRBMHZ3MG9IRTlNaGhFZ1pu?=
 =?utf-8?B?bktQVDZOVTQ4NHdkQUpySTM4a29UNVhwRWRHNjJpN25aRW1oOUhjdEQ3MzBN?=
 =?utf-8?B?eUtybk9YSHJ5MDBweWVsaXNqWEwvUmpJMkQrSGhnd2xIbUdUc1dOTXY3YjUv?=
 =?utf-8?B?cmJRNEUvZXZ4cEJFWm5ITVkyQzFpcm5MejlsVUdVYkpIcnN5RzZFdDBKelFv?=
 =?utf-8?B?ZHR2eFlLcDdwUGwrTWpjdHhSWnlIMEVHeWlFVzZnZ3Jqd1JqMFpWZUVnNGNN?=
 =?utf-8?B?ejk2QkRWcnZzZkpIYVd5anNtYktqeGd5ZGYzOVljYWgzZDJYaHpreXovTmZk?=
 =?utf-8?B?N3AzZ0FoVDRSQmxjY1BkNDBZb29lWGRXQUJ3dmVwVXlSNkxUZVEvQkEranUx?=
 =?utf-8?B?T1V1cGcwTFMzUERYdHlGSUttUEVzVzdXVlk1ZjdOVzAvTDVmbm8zYXNUR0h0?=
 =?utf-8?B?NUd6U0NqMmlmQ0lsNDVmdEMrMEJhZVpTNTAzMUtNbkh4YXh0Snp1ZXVhblFF?=
 =?utf-8?B?aEQ0SzRXa1lMV2tBMVd0UE9FRGxKdFBOZldyNVYvY2lLRlNUbHlyajJDMlM2?=
 =?utf-8?B?ai80MXNQeVFUZGYxL1RTOUxJWExTL0piSzZYMXF3dWs5YVcvQ0UzQ2E1VTBJ?=
 =?utf-8?B?U0ErSlZhc0VmSG8xSFB0SUprKzRjaWY2SEFMK2dUdi9kMlFIMElWbFBkV01R?=
 =?utf-8?B?N3ZmVFdJeEtEaGFKb0tIVnRSUjR1R1U5cW9XRHdNVGFET0Q1SHBIMFR3UGJY?=
 =?utf-8?B?bjc0U2Y4L05QMmFtMFU2WERBYW12cUdxbXp0STd0RjNpUno5MkVzNXphVXBo?=
 =?utf-8?B?bzZ3WU9BaHl1ODRQVVZvZ2E0d1dQZm1zTWJFM3Rlb3Y3Y2dUdEx5bnorcVdY?=
 =?utf-8?B?dTgyNkt4N2o5Z2dvc3VuYUpHQmlFRCt3VDhadTVLYWw3NEY5ckZCMEh0eERQ?=
 =?utf-8?B?MnFCQlFXd3N6WkJJbEdLdlNNUVF0MWFIQjJJMGFwNjdsYTlDRjQ5S3YyVzRU?=
 =?utf-8?B?anZXOWNkb0hNbDNUNUx1QTBscUJTMlBlVXVycHBvcURRUFoyYi9rRThla1VD?=
 =?utf-8?B?WkpFelA1eVlwZytkYmxIOWNRS3N4cUZuTjJkRlRNS1gwR1o2ZnJpUHU0OVpj?=
 =?utf-8?B?RUJuNjlabldSb2dVdXFBOVlQSkF4WEo1Uld6YmhlN2ZZc0g4TXY0QVZFbHdn?=
 =?utf-8?Q?e7gvlgzhT8w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azJ4bW5sSDJVZzUrS2U0YVdhK0NrSWVNLzRFUlZNZ0FENkdwNzJMeTMreDhm?=
 =?utf-8?B?S0RHbEgvMW9ZaExodDVyRzdlVVgzd0RkKzhjS1VmdlJrSWtFbkhFVEpUYitC?=
 =?utf-8?B?SDFyMHdZYXZJQ0RmZkg2M2MyRHdtY0RrNWZlenJpVlhCa01GY0ltS1BaME9p?=
 =?utf-8?B?cVdhakpvcG5hYnNpdHBQZi9qa09CbHU2elRYbTFRcUZLWnZNTjErL3BDOGhs?=
 =?utf-8?B?MzNCTG5pcDMvcTNzeFU3Q0pXU2UyT0tEbmdqN2dOSTZIWlZFTi9HRkJWZklV?=
 =?utf-8?B?Q0hoQk94TnpFSWpoVTdIM0t0aTdCV3JwRjZVNTk4RVUyUUdNZDlaN0lrZ1BT?=
 =?utf-8?B?bU1MNTA1Yk5Gb1ptVE1UeHdkVDEyUzN6ZStJb0MwZndIUFprY2lERHBSUDNG?=
 =?utf-8?B?d3piQ0ZBeXZEWG5id2FPdmRsM2dEcmg1am9QMVA3SkdtT3ZLU3h3L2x1RHpl?=
 =?utf-8?B?REN1M2dUSkw3SzhQS3hpcmpxOEp1MDBqYXRiTURSV2Jod1NOQ2lxRks2Q05q?=
 =?utf-8?B?RmxaUkQ4Qkx5Nm5CLzBCbTNKUTZFR2YzZ0xIUWNUTnJONDVJdkYwbXhsekt5?=
 =?utf-8?B?UW9UTHBndE44RCt1YTJPdUNXWjRKeDA5UTRpeFRQaHRqdjlVOVIwbkJIbVVF?=
 =?utf-8?B?bDFGYWZ0NzhqSENjR3g2ZFRsanU0VjN0dUd0M1dpa2tQTjBDY1RzUzZKQUZD?=
 =?utf-8?B?SWFUL1RMTDlwMlFwakdCN2F1ZDRTVGFpVGZUVjdEZ210c2E3U01jNDhYVm95?=
 =?utf-8?B?TFdGSzFYNVRUYlV4bzZPdm1FOGhTUDZDelZNbDh6TUtQRVZFSDh2VWtjK3hj?=
 =?utf-8?B?NlRTT1RFUFU0ZzE5SExrdEY2Vis0RHFXZHhMSmppMnQvd1lhNGFuSGhMWVlZ?=
 =?utf-8?B?UEI2M2gxaElxUzI4V2J6ZmNraGpoMnJvdjJuSTFZTFZsd01xdGZ6S2RMZVJE?=
 =?utf-8?B?VlpPRHFFWkludGg0OEV1UUhMNTVsTU5GRkd3b3BFaGo1T0JoZjlmcGFNUXp6?=
 =?utf-8?B?ZllRdlNjYlM0Tlp2Wk1LTXpvcW1QVXYyUHIxRWtsRWNncFIvWlNwekRNeFFn?=
 =?utf-8?B?dEFpcnNxNXNlY1A0MkxtTkhGZERhNVhXZmsxMDcxUUFqemc5UE1LZFNTcUtQ?=
 =?utf-8?B?bXdyUENIdFkvZTR4bVc3UnVUSFhxTHBHYmFVeEgrM1o5aitCeDQ3OG5TQmtR?=
 =?utf-8?B?Qy9pTlpmV1E5NWJvTnJ3WXBTS2JUeU1FZjl5eVR4RVFrL1pYV0ZuWmY4KzZD?=
 =?utf-8?B?RzY2ZnAveUpab2xvUEltclh0cHNUcXlpT2hMaDc1VzlIM3dLbERvak9rZ1M1?=
 =?utf-8?B?WnIwVDN2Ujd4RlF3M1NBOVVlY05UUHI2VjVUd0VBbHFnNGhlQmRWdTlYOHBx?=
 =?utf-8?B?dTR0QkQ5TzlJcEpQZSt4VHo4WVZPblkwRHlBczhOczI0YTB2a0xCNzFjeVlv?=
 =?utf-8?B?RXQ4K28yQ0F1VE1wM25kTUwxbEpaRHVnNllyYi9mZDc4L04wNHoreUZreUN4?=
 =?utf-8?B?OHpFN3FLdlM4ZndaNTFYUUViWHJVckR5TXdYckpIbjIydkUwRGRwcHlzZTV6?=
 =?utf-8?B?ckUzQW9nWWJDV244U2dsZHYyMDlmR1VLYmlkKzhCZ3dQU0tjUXhDOHVKUGIw?=
 =?utf-8?B?YUk5Vk02VmJtMWxUVHhrOU5pajFUZjBDWitNRGg5MzJTV0oyRFRhL1BZcld1?=
 =?utf-8?B?OGQ2aEVqQ3NYQ0RIdE9kRGdUTHhqdExxbjdkemJmSGtYQnBqeWcyNThJTzgr?=
 =?utf-8?B?UkNiUEF4OHBjQ0ZTRFRlNDJYbVJvdEF3VnRaSHFZN2FKeDBTWU9MQmxKVjd2?=
 =?utf-8?B?NWZnTHozNjZEcDlXY2pPby9RaEl4YlNjUWlxSFpKb1NvZTQ5TFhUMm9zeDJE?=
 =?utf-8?B?M3ZwN0l0eUhuK3JSSFJLbU02NUFoZlg5ZXJrMVdsMy81SjBUMHV0YUllNllR?=
 =?utf-8?B?U1JabXhxQkI0bjBWZVlvajBSWHkyRzVHdytRUFRaV1hVMW9MSGFHd1Q1Y1JR?=
 =?utf-8?B?RnkrbnpqSWp1M2dINStNVm9xQndoVzZHVVYvTWlxL3BiS1NpWGEzSnQvMDJR?=
 =?utf-8?B?UkpKVFVQbmpUZk5iZ3I1V3BQRld5anQ3Y0tMb3V1dHAyZGd2c3FEMndjZFE3?=
 =?utf-8?B?My83eWRpWFR2ZHRSYllkNDNkN0tVa0pQaEh0MXdUQ3pkM2ZkZlU4cHBDRm1V?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71724711-2949-434b-24da-08ddeb0ee8ed
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:25:42.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Olbnw+BGmxfekyVfN8139Ch10pe6R3KVAanaqxEMNEq9YMGcovP23FCsuqO8qRocRAWZTC0bEyl4tvgO+JgS7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7402

From: Jan Kiszka <jan.kiszka@siemens.com>

Those were once used to compensate limitations of the source.denx.de
server. With the relocation to gitlab.com, we are on scaling host and
can avoid the indirection.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - also switch xenomai_stable-3.3.x.bb

 recipes-kernel/linux/linux-xenomai-3_4.19.bb    | 6 +++---
 recipes-kernel/linux/linux-xenomai-3_5.4.bb     | 6 +++---
 recipes-kernel/linux/linux-xenomai-3_latest.bb  | 6 +++---
 recipes-xenomai/xenomai/xenomai_3.1.5.bb        | 4 ++--
 recipes-xenomai/xenomai/xenomai_3.2.6.bb        | 4 ++--
 recipes-xenomai/xenomai/xenomai_3.3.bb          | 4 ++--
 recipes-xenomai/xenomai/xenomai_master.bb       | 4 ++--
 recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb | 2 +-
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai-3_4.19.bb b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
index a4b6dfb..d906dd0 100644
--- a/recipes-kernel/linux/linux-xenomai-3_4.19.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_4.19.bb
@@ -11,13 +11,13 @@
 
 require recipes-kernel/linux/linux-xenomai-3.inc
 
-SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
+SRC_URI:append:amd64 = " git://gitlab.com/Xenomai/legacy/ipipe-x86.git;protocol=https;nobranch=1"
 SRCREV:amd64 ?= "ipipe-core-4.19.322-cip113-x86-30"
 
-SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
+SRC_URI:append:arm64 = " git://gitlab.com/Xenomai/legacy/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-4.19.229-cip67-arm64-13"
 
-SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
+SRC_URI:append:armhf = " git://gitlab.com/Xenomai/legacy/ipipe-arm.git;protocol=https;nobranch=1"
 SRCREV:armhf ?= "ipipe-core-4.19.271-cip90-arm-19"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.4.bb b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
index 71e0066..b2acad6 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.4.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.4.bb
@@ -11,13 +11,13 @@
 
 require recipes-kernel/linux/linux-xenomai-3.inc
 
-SRC_URI:append:amd64 = " git://github.com/xenomai-ci/ipipe-x86.git;protocol=https;nobranch=1"
+SRC_URI:append:amd64 = " git://gitlab.com/Xenomai/legacy/ipipe-x86.git;protocol=https;nobranch=1"
 SRCREV:amd64 ?= "ipipe-core-5.4.284-x86-17"
 
-SRC_URI:append:arm64 = " git://github.com/xenomai-ci/ipipe-arm64.git;protocol=https;nobranch=1"
+SRC_URI:append:arm64 = " git://gitlab.com/Xenomai/legacy/ipipe-arm64.git;protocol=https;nobranch=1"
 SRCREV:arm64 ?= "ipipe-core-5.4.180-arm64-5"
 
-SRC_URI:append:armhf = " git://github.com/xenomai-ci/ipipe-arm.git;protocol=https;nobranch=1"
+SRC_URI:append:armhf = " git://gitlab.com/Xenomai/legacy/ipipe-arm.git;protocol=https;nobranch=1"
 SRCREV:armhf ?= "ipipe-core-5.4.231-arm-6"
 
 PV ?= "${@d.getVar('SRCREV').split('-')[2]}+"
diff --git a/recipes-kernel/linux/linux-xenomai-3_latest.bb b/recipes-kernel/linux/linux-xenomai-3_latest.bb
index 52fcf1e..7939583 100644
--- a/recipes-kernel/linux/linux-xenomai-3_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_latest.bb
@@ -33,7 +33,7 @@ python () {
 
 # default: amd64 or i386
 GIT_REPO = "${@ \
-    'git://github.com/xenomai-ci/ipipe-x86.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://gitlab.com/Xenomai/legacy/ipipe-x86.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH = "${@ \
     'ipipe-x86-4.19.y-cip' if is_kernel(d, '4.19') \
@@ -45,7 +45,7 @@ GIT_BRANCH = "${@ \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:armhf = "${@ \
-    'git://github.com/xenomai-ci/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://gitlab.com/Xenomai/legacy/ipipe-arm.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH:armhf = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
@@ -57,7 +57,7 @@ GIT_BRANCH:armhf = "${@ \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
 GIT_REPO:arm64 = "${@ \
-    'git://github.com/xenomai-ci/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
+    'git://gitlab.com/Xenomai/legacy/ipipe-arm64.git' if is_kernel(d, '4.19') or is_kernel(d, '5.4') \
     else 'git://gitlab.com/xenomai/linux-dovetail.git' }"
 GIT_BRANCH:arm64 = "${@ \
     'ipipe/4.19.y-cip' if is_kernel(d, '4.19') \
diff --git a/recipes-xenomai/xenomai/xenomai_3.1.5.bb b/recipes-xenomai/xenomai/xenomai_3.1.5.bb
index 8cfe184..ed77ada 100644
--- a/recipes-xenomai/xenomai/xenomai_3.1.5.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.1.5.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2021
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,4 +14,4 @@ require xenomai.inc
 # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.1.x;tag=v${PV}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=stable/v3.1.x;tag=v${PV}"
diff --git a/recipes-xenomai/xenomai/xenomai_3.2.6.bb b/recipes-xenomai/xenomai/xenomai_3.2.6.bb
index 0bd7007..a8985ac 100644
--- a/recipes-xenomai/xenomai/xenomai_3.2.6.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.2.6.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2023
+# Copyright (c) Siemens AG, 2020-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,4 +14,4 @@ require xenomai.inc
 # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.2.x;tag=v${PV}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=stable/v3.2.x;tag=v${PV}"
diff --git a/recipes-xenomai/xenomai/xenomai_3.3.bb b/recipes-xenomai/xenomai/xenomai_3.3.bb
index c2babdb..5ccd8e2 100644
--- a/recipes-xenomai/xenomai/xenomai_3.3.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.3.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2024
+# Copyright (c) Siemens AG, 2024-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -14,4 +14,4 @@ require xenomai.inc
 # Note: When updating PV, also update conf/distro/include/xenomai-version.inc!
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=master;tag=v${PV}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=master;tag=v${PV}"
diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
index 708ddb3..7438f63 100644
--- a/recipes-xenomai/xenomai/xenomai_master.bb
+++ b/recipes-xenomai/xenomai/xenomai_master.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2018-2020
+# Copyright (c) Siemens AG, 2018-2025
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -15,5 +15,5 @@ require xenomai.inc
 CHANGELOG_V = "9999-${PV}"
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=${PV}"
 SRCREV = "${AUTOREV}"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb
index 9184391..132d1ce 100644
--- a/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.3.x.bb
@@ -16,5 +16,5 @@ XENOMAI_VERSION = "${@d.getVar('PV').split('-')[1]}"
 CHANGELOG_V = "${XENOMAI_VERSION}-head"
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v${XENOMAI_VERSION}"
+    git://gitlab.com/Xenomai/xenomai3/xenomai.git;protocol=https;branch=stable/v${XENOMAI_VERSION}"
 SRCREV = "${AUTOREV}"
-- 
2.43.0

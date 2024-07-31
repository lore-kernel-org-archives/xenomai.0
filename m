Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E6219E1
	for <xenomai@lists.linux.dev>; Wed, 31 Jul 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456268; cv=fail; b=NHBeF3TdOsTFRbMMY8YxvXjBdX2VM60E9GspNmn+EKwFFQd9uCFjpVjqppaEsTcgjFdr7ikTtZ3L+V0oyx1K+3gRgKKPF3oaQXEOovHF8nmav4YV0M1awMDbxGjJS+7Na21mMsod+gvzFqYOzra4djcxbcJz2sIm5eADZbrVP5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456268; c=relaxed/simple;
	bh=MgWq3nX0zUyAKhiD2BiHLw+B5FEA9gU09X1HyWO7hc0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=luOKujvYSMEKRH7qbGclhlAgTFpASscv3FXtlsQhD3FQ12ym/jfy8CNp4Ni+myNLPd7D2Et+o5HPtZeae4g/BpWbuFwrg3WLE1u+FujA+DQXucbn9rOD2sWNd0TWV/gGisqxs1utSjoJLVNf29xJ6GnjKq4c54+R9V+x/dMbm+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=B6krx74w; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="B6krx74w"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id F05F3200003
	for <xenomai@lists.linux.dev>; Wed, 31 Jul 2024 20:04:17 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::60b])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 2C2B3D80047
	for <xenomai@xenomai.org>; Wed, 31 Jul 2024 20:04:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tspAUpv2bP/qo5dZPtdnmwfk9GNSX10mybdNxDUZhvYGQAzr/6Q5dl4u22ffkkL2OEaH4mUaWh3cm9Mdi5t7O3Iz+fwmmPU0B4R1/e12uJUwhehu+6lZg+e8vLVo8YhFX3YwT8tTNNtgHEjvffZnENNy92O39rZd3ZPFvvYLDkOtIufqO0+VCAz/gyc1YbDfKoVJeIBYIQ9AIXc1FapJRJFLimCpl3cIlNWNxe8rRU067hfXGxiZV1TQOEWE0RH1QRGorjI34eKOf9et8MqyvtZQN6iAaZv+DNuaGfgsU3A4Q48dWiu8DY0LsfqaCIvRuJlUZ2nbFJfKNBz1bSXAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmypsb5zVAHfOjEPHmDQVAHuL+I/wiHM8Bs+N83n+qU=;
 b=mHF75rY4z6eIb9lIsDKmHoprpxprTvdklOGHtLmZQjMw3zWjniWP/Jsl1ZS1S+dhFGTyGUmN6UNzK9oWU/zhbjTm7XmRv6O8PFz0kuFvvu2PbGj1p/Pvy5LiAQplAZuERKllpnTwe3kQ57rTUS90wfxuUjBXGQgI4CH07CLaqHO3LUif2qX0roJT33qhtdd6RnKtQtIIdqguKeMLrtwI+gaUHhgf56HXNHTAqSlTlpy9/7YQtaOPjyQPFWYtuFvhD1WdbdolcnZDHLrYOt5IMAt55TxawadIx16wjvLtpQMDWrPSo9fc2odaQZ0NPU22dFo1tE1EXc+QG9QteKasaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmypsb5zVAHfOjEPHmDQVAHuL+I/wiHM8Bs+N83n+qU=;
 b=B6krx74wTcJf40LSiqcs7JZsY8TWbVMZRv40lPTnez+IbXD7hGBgN4nIWloFNB32iYRLoCcalDdkmRh8PE883nuO+KDc0j5N3vyfbr5uQd7VfME5DlHsOpPPtZcndW6DKAJeCvwkyoqTg+Zw4fJvpntQ8NSg7sMT0LU2RprPxj+2yBY7uae+COIHsI/fiM42Azvo5f0R/LeXLNfN1U6lsmUYMeSkBCUSKq5dUG9Dw+Vz5bh3QoooTDvfbbTR92WgRVO8cYIeunivnBfLS+AZsL+GYG+iALBZJcwWaH8yC0dkeGaqhoZDnwg8iIXqlyBRmW/tcOUL+0swIjFyzBiWOQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8163.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:381::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 20:04:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 20:04:16 +0000
Message-ID: <4117fe6c-cdf5-46b5-a76f-f0af09bf64f5@siemens.com>
Date: Wed, 31 Jul 2024 22:04:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] kernel/drivers/net/stack/packet/af_packet.c: 32-bit
 compat support
To: kon <ksmola51@gmail.com>, xenomai@xenomai.org
References: <20240725235347.115933-1-ksmola51@gmail.com>
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
In-Reply-To: <20240725235347.115933-1-ksmola51@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0415.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ed191c-1324-478d-0c42-08dcb19bf47f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjdEbjhrTDlZREVDOTNrczlOTlJObE9UVkJNcHlFYkNHdlhXWm9LQUNJZDQ5?=
 =?utf-8?B?Rkp0TDI5RmM4SGpSeERlZy9YdElaWDkwVlZBTCtJdTlaeWhMVUNWd2VLbVho?=
 =?utf-8?B?dWk0ME5ZZENYQWtUQUF4cVJ4d29tS2UvUU1FQUdjR3JGeVZ5TW1RR0xpVFNs?=
 =?utf-8?B?WFhJUVhhRGk5T1VMV1RRWi9hMlF2d29NemxpNXBYT2ErWUMyYnkzaHpFZ2Jw?=
 =?utf-8?B?SUdLNUFlQ2VvNGNCeXU0SHVKQWFyUUk2ME5paW1heU41MmNoNVZEOVVjejhn?=
 =?utf-8?B?djRTelp3RGU2SFdyZXQ5a1ByeUpxNlNPcXhzWE9DRExLblFjUWxrdkE4TWVX?=
 =?utf-8?B?RGtxL2dNVU1YeGtvR21Fb2lGaGNkU0xXYkdDYWhLRW90SStWSklJT2JrVEwr?=
 =?utf-8?B?c1lneEl5TEFYV2FVZmI4Mk5tc1JpMmppbFFJYkpxWkY0dmVuQWFDUjI2eWJG?=
 =?utf-8?B?U1Fac1ZNcmhyNzQ3TlJveWpqMVUyVnh0VERYUmxzdXEwWEUzaUdUeXpBQ2Jk?=
 =?utf-8?B?aTBTYWVYYUFBa2tKZEc0TEdrYTMrN1g0V0x0Zy9IUUFTMW9XYm14eUhnNEJ3?=
 =?utf-8?B?N3VpU2J1ODBJR3pYcUpPVVY2eVRubnFOQnFQdmswY2ZvSjMvd2hJdFppdmpB?=
 =?utf-8?B?bUFrOEdhbThLYnlZZW9aMU9tSDcrSGt4TUpNcWZqNEtIbyt1YU5pM1MzL1dP?=
 =?utf-8?B?aWM2TGR2ODBUOWVBNDhGYjVpWTdKeU1sU0MzM2lOREFHc2NFVVFCUWdUUXlt?=
 =?utf-8?B?azNvbzFWaGZnS2hobW1hK2xZTStrSGtRWG93Tll3NjRsOHZCNjNZRkFRNTl3?=
 =?utf-8?B?c3p2NXpKbTcxcmhtcktGSzlQdFZURk96cVNhd0gwUkk1QnVvR21XM3pLZ3Qr?=
 =?utf-8?B?THRPRHc0VXZObWRXRCt6dGN1N1dBSHpJa3ZleVI3RGtYOU1kUE10NkNlVzVR?=
 =?utf-8?B?WmtBbFduQzFKQTJ5UUo4dmFaeWtvczZGM282RU04dnlxUWNPdkxYazFmWVhL?=
 =?utf-8?B?R3JPbG40S05Hb1lqTSsrOG5NaTQ1bm45Wk8vWXRSeG9jMUJaYXFMblRTaExV?=
 =?utf-8?B?WXhrekdZN2dDSXJZeHBPSGo4MEQyNGhLVWc3L1R5S0pHV044TjIzUXlwR1Jn?=
 =?utf-8?B?M2NLdEdROWREM3hiTnZhTmZDdkJ2c0NFY3ZBbU1rU3NMbmJoTityajN3OEtw?=
 =?utf-8?B?dmpGd2dpOUNpRGE2OGNMSDVneXNPRkZnRkI0VWNBdHBYakhmTkRKSkRVYTRP?=
 =?utf-8?B?Zk5CVmpHMkRTVTlhaTRXLzVUQVhxdzQxd0U1bG53YTEyeUU5enNCNzNsekU3?=
 =?utf-8?B?b0lWT1JSbHRkRTVMVmFtZ3BoYkttWW1laVVQNEM2WE15d0M4aC9KMTljeS9S?=
 =?utf-8?B?d0xtQXRDRVowVnIveFlwdCtidDFWSnRlbysyNEhZTU81b2FYc0xFdXptNCs1?=
 =?utf-8?B?dGVvVFVjZXJVYm5qTHI5U2lzbzh1T3dmWlhVK3RVSUUyc3JuRTAyajN6YStY?=
 =?utf-8?B?VjBKREVzbXIxWHJzMGtaZnhFOXJ4cnZjdVNTV0Joc1Yzck9VZWRwY0htejMy?=
 =?utf-8?B?ZXhsZHQ1SnZoWGx2VlVRZWE4ckNneDZRTjJrOVJhVlhUd3BwWkJOTDJDd3oz?=
 =?utf-8?B?RzQ5WjFEaHQxVk5RRlNDQS91bzRPdmdwa2pIVzFEcGJWMG4yU2ZoWXd4emg0?=
 =?utf-8?B?Mk1TTmtJNVR2R21tVk1mOVNyUmExUStEeU53aDdSdkZNcU9BaXcxT0VhQyt6?=
 =?utf-8?B?T2UvaFRDb2c1elZ1UVBRR0tua1pmNUlaYVM5bmZsbkFGbXp0dndycHNVcXFN?=
 =?utf-8?B?L0tLUEkvZURaUW1MbUU3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDcxaUIxK2tWVkdQUEYxTGlvQStKQ05OMU9oTDZjRll6SkZ0UCt0T1NEU0xw?=
 =?utf-8?B?M1hhY2twcGR4STJtZUl1S05jWHpDSWtHRU9xNlJMS1Zhb1lBVlp3QXZsU2JK?=
 =?utf-8?B?T3VkY3NuK25kS1oyQ0pKcEYwd0cwVlVnWHFuWW9za3cydytZbVM4TzNqOSs2?=
 =?utf-8?B?YUdKNS9mYmQ1bXlscGJCbGFpdFVrNmNSaUR6a0gvOVVxblMyRU1oUDcwT3Ay?=
 =?utf-8?B?QTU3NVFMTUFyamptWjNGNmxZNEpxYmhCTnBTK1ZhS2VmbWhMaWlaUmRaM3pv?=
 =?utf-8?B?d0xrWXkwSTBmMDZEMW5CRXpMQ25ZQVNtSzEzVFhLNW04MG1MUnlLekF4UVVK?=
 =?utf-8?B?T2J1amhvb2NiK00zUnNRNXdvTHFEejYzTG9ZazdxVzkyK1hOSFE1emhxcVAy?=
 =?utf-8?B?aStGM3FPeFNrUnBEVXdqUkwxTjFLOWZNMDhITjVQeHJjbWsvaTNGLzBnTDJE?=
 =?utf-8?B?anBCekYyVlV6OUhKNUlhQmVmbVJGMHRlbEpjOFRxcGNTdHJsVlFKNldJSmNj?=
 =?utf-8?B?Ym5ldXk0ZkFNbE8zUDlualVjZzdZTytqYjk3Umx1SGlVdDlIOGIzelZVQmZk?=
 =?utf-8?B?d3lqSFBxV01wT3E3UmRaZEtxUnFBV21XYURUM2N0dzJoZXE1RWM1NUlMZTVs?=
 =?utf-8?B?bWJFcDg0ZUJYT21rUHNGT0k0VDVFeS8vejczaGkyRnZRbWtsMkE0S0pNaUJ2?=
 =?utf-8?B?dVkvRm1uaWNhOUx3OWdnbjBzaWlnbXdQK0h6eXJlRkdXam5ENWRubFpzUURU?=
 =?utf-8?B?NEZhM2VETlQ2N3hEVWtQWHlmUVJKdUxMSWltWTFOVGM0TE9hRW0zS0I5cElH?=
 =?utf-8?B?TjNVQyszOWxNTUQ2ZzFlY3ZGTk5BNlBqRnRQaTZwOWJsT0pRS1Vta0VoOHNY?=
 =?utf-8?B?MUpHYVpnWksxQlVJcTBna3RpdTUrcUpTdjhNMXVPYmRDc21vdnhDakdlakhP?=
 =?utf-8?B?QkZabjN5RWVNN0gvdGd2ajRuNHRGdkhmUEZzSE5YUWlqQXVyREthZHEvZ2c5?=
 =?utf-8?B?OGRQSzVIUjJSNXAvMVdsQnlFU01MbTVrZnBIRlc4cTFEOWVZWFFFWkt4OXRw?=
 =?utf-8?B?L2VHVlpzVEJzTEdaRlg0QXg2WGFaUGxFUCs5TTVRd1VMODhoODl0Q2lVK0Rp?=
 =?utf-8?B?OFp3Tis0UmJrY0dPOWpodWpKaXJOcFVNcTIzdUFtbjFzaXdLK2tmUyt3QWRX?=
 =?utf-8?B?b1VzNm9xbnBTOUp2V2pYU3BWNlZVVngzT2hhemJiRzM0dTBKdFh3ZStxeE9o?=
 =?utf-8?B?c0NPOHRuaVVBMkpsUTF5YW1DTlJWUExhclpsNjVSNHY0WlI5NHVmL2RvcVRj?=
 =?utf-8?B?SFozbm5mY1M0SzZiSTk0STdzRFhES21zaW0rVFlpSnlIcHBHK2dwR1M2ckRa?=
 =?utf-8?B?Q09JT0h3YnFhVTdySEhrWXpxOGk2WWxMY2RUVlFZSTRKWno4UDg1TzZDaXNS?=
 =?utf-8?B?QUw4TlVDTG9FdjM1ZGF4OUs2T1pUOVBKT25vZU5xR3BpUWhRbkhlZXRkT2J4?=
 =?utf-8?B?eHpvWTY5MUxYWE1hNElTaTY4RUV3R1Z2cFQxZmx6bUhxMUo0U3hQRlJxd0VS?=
 =?utf-8?B?RjV2YlVOSUJMMVFtRHZSeGY1cE5iNWtVN1ozWUZSY1A4OFBUcC9GUnN6SFRJ?=
 =?utf-8?B?K3ZDZVFicVlpMGFEeU16WFZyQnhVZ2RKWURwK2p3WmdiM2YyS3V5YlFMOG1F?=
 =?utf-8?B?UFZuQmY2cnd0cEZnejJLblZzQWVyRm5VNnBPMEN4L2ZlY3FnUGdoaGt3ajNt?=
 =?utf-8?B?TUV5VUdnanBiVnhwaERCVVpVZlBFREw4RDBwR2IyTmlJeW9BMUZlanBSQlVk?=
 =?utf-8?B?ZDlOaktJTERscEEwOW9DekMvUlIwL21oSUluUmlubkZOM2tKMzZnWFlaSXNL?=
 =?utf-8?B?eklwSU1zdXpESm9BSXVxSVQ2NjVVV0k0U0RDZUZ6MDR6c2pYOEJpV1ozWnVX?=
 =?utf-8?B?cGRleXJOeVJNcjhYcm1YcjlTNlpxVlJHaVRyRmFjWStscDdsTU5OZVNlNFdV?=
 =?utf-8?B?THFRRU5SUDdDSnF2TW1WWGY4LzJ1cEVYU0RLS3QyN3NncGtnL2hJbDVaaWkr?=
 =?utf-8?B?ZUpMbmNQRzZuMkFrRDZKZEwxa2M3d1dwUlBIaG04SlREL3N3dk5LSCs1WmVX?=
 =?utf-8?Q?/MRvMQZzYl5qq17A0Sa9FlJbk?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ed191c-1324-478d-0c42-08dcb19bf47f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 20:04:16.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPyOKEzfbP3PA3nMnLfZ9JfMgzcsN4v8mJjV/lBXg9W345LwBRwLrm4UdYPAF6b85o36O+cd4ErSKMrUCP7jYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8163
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=B6krx74w;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2612::60b) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")

On 26.07.24 01:53, kon wrote:
> From: Konstantin Smola <ksmola51@gmail.com>
> 
> kernel/drivers/net/stack/packet/af_packet.c: 32-bit compat support
> Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
> ---
>  kernel/drivers/net/stack/packet/af_packet.c | 62 +++++++++++++++------
>  1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
> index 6013ff9e7..3ac5f5f13 100644
> --- a/kernel/drivers/net/stack/packet/af_packet.c
> +++ b/kernel/drivers/net/stack/packet/af_packet.c
> @@ -29,6 +29,7 @@
>  #include <rtnet_iovec.h>
>  #include <rtnet_socket.h>
>  #include <stack_mgr.h>
> +#include <rtdm/compat.h>
>  
>  MODULE_LICENSE("GPL");
>  
> @@ -107,10 +108,10 @@ static int rt_packet_bind(struct rtdm_fd *fd, struct rtsocket *sock,
>  	int new_type;
>  	int ret;
>  	rtdm_lockctx_t context;
> -
> +#ifndef CONFIG_XENO_ARCH_SYS3264
>  	if (addrlen < sizeof(struct sockaddr_ll))
>  		return -EINVAL;
> -
> +#endif
>  	sll = rtnet_get_arg(fd, &_sll, addr, sizeof(_sll));
>  	if (IS_ERR(sll))
>  		return PTR_ERR(sll);
> @@ -266,26 +267,53 @@ static int rt_packet_ioctl(struct rtdm_fd *fd, unsigned int request,
>  	struct _rtdm_setsockaddr_args _setaddr;
>  	const struct _rtdm_getsockaddr_args *getaddr;
>  	struct _rtdm_getsockaddr_args _getaddr;
> -
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +	const struct compat_rtdm_setsockaddr_args *compat_setaddr;
> +	struct compat_rtdm_setsockaddr_args _compat_setaddr;        
> +	const struct compat_rtdm_getsockaddr_args *compat_getaddr;
> +	struct compat_rtdm_getsockaddr_args _compat_getaddr;
> +#endif
>  	/* fast path for common socket IOCTLs */
>  	if (_IOC_TYPE(request) == RTIOC_TYPE_NETWORK)
>  		return rt_socket_common_ioctl(fd, request, arg);
>  
>  	switch (request) {
> -	case _RTIOC_BIND:
> -		setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
> -		if (IS_ERR(setaddr))
> -			return PTR_ERR(setaddr);
> -		return rt_packet_bind(fd, sock, setaddr->addr,
> -				      setaddr->addrlen);
> -
> -	case _RTIOC_GETSOCKNAME:
> -		getaddr = rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
> -		if (IS_ERR(getaddr))
> -			return PTR_ERR(getaddr);
> -		return rt_packet_getsockname(fd, sock, getaddr->addr,
> -					     getaddr->addrlen);
> -
> +	COMPAT_CASE(_RTIOC_BIND):
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +		if (rtdm_fd_is_compat(fd)) {
> +			compat_setaddr = rtnet_get_arg(fd, &_compat_setaddr, arg, sizeof(_compat_setaddr));
> +			if (IS_ERR(compat_setaddr))
> +				return PTR_ERR(compat_setaddr);
> +			return rt_packet_bind(fd, sock, (const struct sockaddr *)(uintptr_t)compat_setaddr->addr,
> +						compat_setaddr->addrlen);
> +		} else {
> +#endif
> +			setaddr = rtnet_get_arg(fd, &_setaddr, arg, sizeof(_setaddr));
> +			if (IS_ERR(setaddr))
> +				return PTR_ERR(setaddr);
> +			return rt_packet_bind(fd, sock, setaddr->addr,
> +						setaddr->addrlen);
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +		}
> +#endif
> +	COMPAT_CASE(_RTIOC_GETSOCKNAME):
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +		if (rtdm_fd_is_compat(fd)) {
> +			compat_getaddr = rtnet_get_arg(fd, &_compat_getaddr, arg, sizeof(_compat_getaddr));
> +			if (IS_ERR(compat_getaddr))
> +				return PTR_ERR(compat_getaddr);
> +			return rt_packet_getsockname(fd, sock, (struct sockaddr *)(uintptr_t)compat_getaddr->addr,
> +						(socklen_t *)(uintptr_t)compat_getaddr->addrlen);
> +		} else {
> +#endif
> +			getaddr = rtnet_get_arg(fd, &_getaddr, arg, sizeof(_getaddr));
> +			if (IS_ERR(getaddr))
> +				return PTR_ERR(getaddr);
> +			return rt_packet_getsockname(fd, sock, getaddr->addr,
> +						getaddr->addrlen);
> +#ifdef CONFIG_XENO_ARCH_SYS3264
> +		}
> +#endif
>  	default:
>  		return rt_socket_if_ioctl(fd, request, arg);
>  	}

Thanks for the patch! I will have a closer look next week.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28A12F5B6
	for <xenomai@lists.linux.dev>; Mon, 10 Jun 2024 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054656; cv=fail; b=IMpHAACujIewNS0Dpw+9xppgrmTdaCnCckihEACqmO2EWxzr08ttseuDY9x/eRiv8D1j4OAWMLO85JYBAHjwZjz0FHKtEdDPe2LrlrHhJ01oZUotwhYYKNe/hZSIohjSfnp3WCcFzRlXzRaotCpFvB/ChDz5XHjEgjPoMkPKAws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054656; c=relaxed/simple;
	bh=AjhTAJIKrVoHNqOKZTHEBz1WLHYBYJn2EBNt5w4teHg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WmEgoAT4eqBs+Ld+n55teq27oWH6Mi+0qX0lohn5D4TpPp7ftMJ/xFsgB+/KZGrToTbHYWez//qHKbfnIuQ5JRi61iPc78XTHkUcdH11c7vAkrQTVsQPUlW3+J7t5HuHHcQ1SYS0FD19LbwBMyA9cwqbjetM+9oeRGGYCXp4jhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=G+kwIN1x; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="G+kwIN1x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5cEatDHWFR9lvK7EGhV/iYvhKrJfVa7UUA8lGTckSPwJWxxAY+soeSsgARMVzoYq7p0WxBHqh4a7zZ6qj8Q7J3bhhYVtHxecijKn0Yipy822Qvm31f2GvG1YI9eCjPJLobcYHKhlwO5LxOvIphXzYV902Lzo1SWDLd6wssbS0EmzxqKLUoIUJUOxYBsAVthoohmlCa0mSBIHwAIoGMI9Jxjs3oRVv46EDxj4hTcp3Eq4IZSVA7oKIB34DYCNjdFeTHRzWFWp23yQmaxj3VjWAQE4DkLghhERBDXe6nAwRBanyyV2EcX3mO+7L/xfktQNrW210cYM3dCDJHtbcnssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nqu0f/tJvw6JLGmJK/WoxOTGx0xKhLm8zjZziYLZT4g=;
 b=VTXD7TeQmDwd88aWVBdgtm23I9XQRyWTGf6cZLSbxy56hrB80+T0ruv8i1ihTljy2u6Z1u3W+DdHSiGeutYM1lAQZSqJDIymuEDsoHTISUh9yHLqv0S7qoFMQX+bbTU3/UptXxeCp95CsmvCL6H6vv+EMNnXMN6jNFOgVE5u+GfYEi+ketAvCR4G+u2UL4n6iQ/P3X8MdumBVHMYrpOuKfSgqaup8+SVy34JRQUFg7CdY258+rQ+tjVoLW9HM0Plr/ee2Z9HYK+LAR2p4gZga166rbRhJrtoHF9L/dKD/cvH20WufpFi4pMeySIufidDKkSYDHxX2ED+36gvdne8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nqu0f/tJvw6JLGmJK/WoxOTGx0xKhLm8zjZziYLZT4g=;
 b=G+kwIN1xWtRwmJzuWKakdyUHIuPCwq7OJ/6+KZ/I/NnpfBWLm2alk9kL6XsfJLAhC4eJalANsie8J6mNko+k8SRxSnIyaP23j1E57TRgIyGeTsYeSMc+GyHv8zfxYSCh/vAOPSpVvSrzIRFomQlTKBD+nod5E6CbvND0gUiG3CncucgVbjO/8yfiRnRgQqK6BYl1f0ZNEvkn2Y8Lqel0lyKlxL6dJaPcyBb5iHMLjDUFIVHVi5ne8FF7iL1KWykLMAaGxK16BKxWoZXHhvvV0hk52769QT0uT6zf2Cu9XI1+CoO91zz9U2UMOois0okmf8tgYOwaeyJ8s4hiNJ0N6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 21:24:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 21:24:04 +0000
Message-ID: <1902b2c8-57d0-4e5e-ab6e-b34a5ab4723d@siemens.com>
Date: Mon, 10 Jun 2024 23:23:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] xnthread_set_periodic: Improve period adjusting
 support
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240608195337.11137-1-david.oberhollenzer@sigma-star.at>
 <20240608195337.11137-2-david.oberhollenzer@sigma-star.at>
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
In-Reply-To: <20240608195337.11137-2-david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: fecadcb8-ade4-4e53-b90a-08dc8993a78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGJiN3lzNndrZW51VjNZQjRLc2Z2SWtCTmlsREhtaEVvQmVDUW05L1gyMkJw?=
 =?utf-8?B?R2ZBNjNQa0FpNTZlK29qY3Y1bk9jakFwTEEvT0U1Ujd4VERtRytodnRMR0pC?=
 =?utf-8?B?TFM5M2pLd3Z4aTdMU2crWnFYNVI4d0s5bHpaUTMrYWNJQmRabkNPM0RBN3NH?=
 =?utf-8?B?eFlmMnhOaEJUQ0RsTU92K2FrYTBJbHlSbmFrQlFVaTJsQ3ZpZy9laS8rblVI?=
 =?utf-8?B?VWF5SWczUnFxbXpndEY3eS9ld3J5MFpJNUhmVXI3aFhZSDVMOGc0K25idWpU?=
 =?utf-8?B?VWh5aE9BUUNEZWx2UmhBOUU0ZE9lbnJkazdWU1RreWVOS1lyQXZISHFOcEJT?=
 =?utf-8?B?VjB6cjhDaWJNTnBDVWxwZGorVnladTluM2RiREZtWWdPMHVLK25MemZFbFVI?=
 =?utf-8?B?Z0pINUxISG1HbnVyUUJEZ05wZDVmR3ZCS2pwOE9qWTVINzVOaTQ4U0FQUU9j?=
 =?utf-8?B?Mlo2KzVlT2VGWWU1TnRNSElMRW94NTBFclR0aVh2N2pCeGJqNEhMOWtvaXV2?=
 =?utf-8?B?Y3F3SThwcTJ1THJELzljVE00b0hFanNTZmV2ZFpYaStYRHFXTURGQXB1QlNm?=
 =?utf-8?B?M1B4MVRTdUttVWlxL3BDUG41OXFNSTQraEc3YzJFY1dhaVd4SkFKRG5INmdZ?=
 =?utf-8?B?Q2dEQUtEZVFTQlZubzdnTkFwSnFzMjJQZUZ0bTNyZ0MvVG9QWjlKMmRtTXhY?=
 =?utf-8?B?VmtEWW1EblI4WlpqYlZtaEhoNlk1QmFOQWdERkc2dGFLN2dtbGlCUUtIN3Ja?=
 =?utf-8?B?K3FxOVdhbnhJK3RHN3RvY0dITDRGTERzUDhHN0RXdzQzZHp4NXZZVnB1NTZl?=
 =?utf-8?B?UG03WXJTYjFTOCt6Szd6VitpclZhblhIYnl2UEQrVVpGRDBxbkZIZ0dNRVlq?=
 =?utf-8?B?UFhjUStPWjBjL3NsZGRvL3Z4Wk1uNlhGS3E1VytFVDBLaHpla3RMT01lR004?=
 =?utf-8?B?RkhHTUh4TkMveG1tem9xK2E4L2ZRaHRDcDRZeUh4ZjgxM2pvVlpIZ3JSMkRq?=
 =?utf-8?B?SHA5ZU9tT1plYkJTQVRrL1pIbzlNYjhacjJldnI0cVlRUFJGVEJrazFuWk8y?=
 =?utf-8?B?UEdCeFFMR3ZFRnlHQlN2VTJMbTJRa1BRWENyemZBZEk2VjQvdU9CdkNlaHE3?=
 =?utf-8?B?T3dTYW16Q3pzNVRwZFdNbldWOVAyUkx5L3EvdmxsaGNpSnlNQVIyWExGRlJn?=
 =?utf-8?B?RCs4MTdadCtQTEdSUmRjRlpYN2hiaThvNVl6TnZEbzZIU0Rzanh4OG5weW1t?=
 =?utf-8?B?blRKYUJqODJFOW1UOC9zSUVrWUwvbnZLRHNsSmhqdG50UUpBNWhvazJpQkwr?=
 =?utf-8?B?a3lTUVZKTVJ3NnBwMUIwVW82QXlydjVSaUdnYTNBQU9rOGV2NXErcGc0S2I5?=
 =?utf-8?B?UlA5LzBCTFVWVUNOS1VYZHhpeEdNZ3VWRVVXaHovZG9TSndVSzhIaEJKaDRF?=
 =?utf-8?B?UGN4TmE0MHZ6bU0xdzh1RzllZ1F4Z3N2UDJ6RWxLamR3YVhBMTlJQkR2cXpp?=
 =?utf-8?B?Q001WisyeWFyUG03bUhvRjVaS29JWWdTcTlvSjM4aWxKY09FZkpRbGZaa2Ev?=
 =?utf-8?B?YVB1N2N6OEF5OWpoRHlWaDJKKzQxOW5yQ0todVRhRE93cUhCdUdtTW01dmJq?=
 =?utf-8?B?VXBiZ0RxenVjU0QyVTREOUo1YVZUM3BQTElvbmFHRFlReHIxeDM5eTVvNUdR?=
 =?utf-8?B?cVd0NkN2T1k5dnJudDAxV0hMczd5YUkxaUNYYU84dURVYmVzMEMrazVTVGFR?=
 =?utf-8?Q?0Eot6u5BRkiq9cF8Oc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri9UaGhZejgrRGJ3QUY3bDRRVmxkdmZXbGdUaElIRHZ1ZzJpVkRBOTRyRmpC?=
 =?utf-8?B?K3ZucVg3dGRCem1rV0JqRmo2RGhkd1VJYzZ3RnNnZjIySm9GVWNHc2RWZWFN?=
 =?utf-8?B?R1R1MkljR2RsMUpmM2kyNDZOWVJKRHlYamJlWVZvS1BkY2gvTUNORzJ4OUda?=
 =?utf-8?B?Y0JEdG93NERFZ3VZL2VxeGRoVmxSYU5JaWcrZzNKNWd3ZGtuWWZpUkJrdVJn?=
 =?utf-8?B?NWxGVEtwK1FWWGxuSlZ3ZzhhQk1MblZUT1ppRjNVNjJIVE40Q3dmU3l6dXYv?=
 =?utf-8?B?aVVJaDVRRWlxLzNDczN2VzcyMC85dXREWEdtclhOay9FWlBrTXRoaDlUeE1E?=
 =?utf-8?B?OXNaUFQ5cGgzVlZTcEd4ajdwM0Z4OTIrazlSN3NIbEpObzdMWGFsbHljQ0VZ?=
 =?utf-8?B?NW03MUxOYmdnL2FMN2xXN000cU50ZkF6YWxnN0ZnMU51RUs1OW5KUHIvMWJU?=
 =?utf-8?B?ZFpwVWU4OCtwaW82QVdrNzUrbC9CQlVoQ2QxbEtnczBiVGN2WS9EakY3VnBQ?=
 =?utf-8?B?QjRiQ2lSdDhJU0FVSjRVT0p4c3VrVTVWNHU3MWZjK0ZlZ0pCQTRmbFgxS3hq?=
 =?utf-8?B?OWRFdWVWTXFIWlhXNnFpN2M2dGVWSXdBT0YydGZXUWJKeFNFbUlmT25yS2hU?=
 =?utf-8?B?aFdiR21DUCs0RHJpQngyWFRXRGtVOCtXUytXUStnOGErVW12TSs4TkhBWG5E?=
 =?utf-8?B?NENPVFE0VXhnVXkzeS9TS3plVHF2V1BRNVdZNWpmNjhUVkpMOUNYRjNJbXVk?=
 =?utf-8?B?ZHJWMjlwNE5ITXlZeC8rUUhpSUJGT0lVU1UvbitYbVdnb3BRQWpmcGtkd2ov?=
 =?utf-8?B?VGluYjNmWjdQMGp4Y0Q2enEyNW1OQkxrL013TGQycnRYZUhCb0ZqeUQ5SjdJ?=
 =?utf-8?B?Z01iL1dqcFdhN1FjQngzWXorQkZINVJDejRPM3VHRktzQnJCNGl1dW9keFBp?=
 =?utf-8?B?UDdKbHRXaVJGNnk4WTdaVlk5TmdrbWhlengydGU4UWxBeFhQK3VCZzZ0SXdK?=
 =?utf-8?B?bW00K09Qa3JTTjgyRHB0VU9LWFRQUk1XY0VjTmt1Ym1ENm9IcHdKVEJybElK?=
 =?utf-8?B?ZndRT2Vsd3hYZUZQc2piNFY4T3B3WG5ZbVhrdmZkN08yeHVCUGlkVTBpdkt6?=
 =?utf-8?B?MjFFNTREeHRlREJtM3k4N2tOQlpORkhsdlFLaGt0Tm5NMm1pU2NFRVV1VVZo?=
 =?utf-8?B?eHJKSVhwaHF2Yysvbm1ta1JqalpTS2prNzhVMEsyVTU3bXlNNTk2Z3pTanEr?=
 =?utf-8?B?c28yTFdYcnkwQmgwVlNJRXlWdXlQU0U4YTZ6dlBVREt5aUVvRy9CYStiZ3pC?=
 =?utf-8?B?a0x4OFVIcFdCVnBObHpZZ2tZdEV5U2crdTFWOHdIMEw1V2lFejcxZzBoSzhP?=
 =?utf-8?B?eEF5cE85RDNLazVnWGh3TmI2dDMrS0ZQbndHcXRRT1dWKzg4dW16SzJTTTZX?=
 =?utf-8?B?TlYrcW4wK0FvTm8zWU1sbnRva1BOZ3NBbWZvNGZ6ZXc4QlpoY0VGQ21kNUw5?=
 =?utf-8?B?UC9JU2hIajM1bVB5MndiY2tzSytOWU1ENU5QOFVaMmhnSGI1QVJpaS9kTnMz?=
 =?utf-8?B?Wk5hK28wYjBmK1kwUURNYlZNc25DNzZZeTlFZ2F3Qjdqek1CTldTNFpObkxk?=
 =?utf-8?B?bThqVmRqV3lKREc5Z1ArSU9YSmZvVVZIWnJkNUhLb2c4Znl1VFZJam5mSXpG?=
 =?utf-8?B?ZTU2TzZjZTd3SXpSeHVZRUR6Rm53aG14R3p5QS9hZWV1YW1IUnRidURIbkhK?=
 =?utf-8?B?THpmWEozbkZKWVNJME9zbDN3M3hoMnZJcVVsY0lnYTJGKzZka252R3V6T0g4?=
 =?utf-8?B?aktLMnM3a0paQjFKSDh5T0dpWEhhS1V0SVVmM3lZczVHUE5XSWYzendsN1Bv?=
 =?utf-8?B?MGswUGZJV3ZiWjkzc0dNSzgrb3VBT29sR01vckY5TlhOZkFPMVd1eEdtRlZ5?=
 =?utf-8?B?cUl0cDVNajZmSlRRN210ODRib3hBN2M5YzZ5bmZUMEhZMStBRUQ3QmNSVDds?=
 =?utf-8?B?WmorQklaNlpRK1RvWnVJN0ZHcTFRcUtBMnJiZ3pjazYzU0xsQURQaVM1bHh1?=
 =?utf-8?B?MjZIVUhNcHVyMGJaZVR5T3hXeEhzWjMrVWhLa2JWZFEyejF3TmRLMTEzQTNI?=
 =?utf-8?B?VWVLMlZJOHBIY2JPS3dmYzNxOTMyTTdXYi9mUmxacFkwbkFocVcrNUZTY1BL?=
 =?utf-8?Q?4p1+EgCzu6aK16ixC92sB+ENWDT9wLTkNpbKKdYEqMoQ?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecadcb8-ade4-4e53-b90a-08dc8993a78c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 21:24:04.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/imoo92DCwM7kFotEX6hGAnWCN9LphMln0ufbS2hMJqXM54Veo96KOmJfRHF1kSkZGzVPZwQy8L41ddWXMs4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5698

On 08.06.24 21:52, David Oberhollenzer wrote:
> Currently, when a periodic task invokes xnthread_set_periodic() multiple
> times, the timer is reset each time. Consequently, the period drifts
> because the elapsed time is not taken into consideration.
> 
> To improve the situation, this patch alters the behavior when idate
> is XN_INFINITE, to keep the current timeout value and alter the period
> only after the current period expires.
> 
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> ---
>  doc/asciidoc/MIGRATION.adoc |  3 ++-
>  kernel/cobalt/thread.c      | 18 ++++++++++++------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
> index 7a32b9921..2a46b43fe 100644
> --- a/doc/asciidoc/MIGRATION.adoc
> +++ b/doc/asciidoc/MIGRATION.adoc
> @@ -756,7 +756,8 @@ upon notification, which therefore applies to RTDM tasks as well.
>  - +rtdm_task_set_period()+ now accepts a start date for the periodic
>  timeline. Zero can be passed to emulate the previous call form,
>  setting the first release point when the first period after the
> -current date elapses.
> +current date elapses. If the thread is already periodic, the end of
> +the current period is used for the first release point.
>  

Err, rtdm_task_set_period is primarily documented in
kernel/cobalt/rtdm/drvlib.c, but I don't see changes to that file yet.

Jan

>  - +rtdm_task_wait_period()+ now copies back the count of overruns into
>  a user-provided variable if -ETIMEDOUT is returned. NULL can be passed
> diff --git a/kernel/cobalt/thread.c b/kernel/cobalt/thread.c
> index cf3b4dbb0..8738fadfc 100644
> --- a/kernel/cobalt/thread.c
> +++ b/kernel/cobalt/thread.c
> @@ -1273,9 +1273,10 @@ EXPORT_SYMBOL_GPL(xnthread_unblock);
>   * point, expressed in nanoseconds. The affected thread will be
>   * delayed by the first call to xnthread_wait_period() until this
>   * point is reached. If @a idate is equal to XN_INFINITE, the first
> - * release point is set to @a period nanoseconds after the current
> - * date. In the latter case, @a timeout_mode is not considered and can
> - * have any valid value.
> + * release point is set to the end of the current period, or to
> + * @a period nanoseconds after the current date, if thread was not
> + * periodic before. For XN_INFINITE, @a timeout_mode is not considered
> + * and can have any valid value.
>   *
>   * @param timeout_mode The mode of the @a idate parameter. It can
>   * either be set to XN_ABSOLUTE or XN_REALTIME with @a idate different
> @@ -1336,9 +1337,14 @@ int xnthread_set_periodic(struct xnthread *thread, xnticks_t idate,
>  
>  	xntimer_set_affinity(&thread->ptimer, thread->sched);
>  
> -	if (idate == XN_INFINITE)
> -		xntimer_start(&thread->ptimer, period, period, XN_RELATIVE);
> -	else {
> +	if (idate == XN_INFINITE) {
> +		idate = period;
> +
> +		if (xntimer_running_p(&thread->ptimer))
> +			idate = __xntimer_get_timeout(&thread->ptimer);
> +
> +		xntimer_start(&thread->ptimer, idate, period, XN_RELATIVE);
> +	} else {
>  		if (timeout_mode == XN_REALTIME)
>  			idate -= xnclock_get_offset(xntimer_clock(&thread->ptimer));
>  		else if (timeout_mode != XN_ABSOLUTE) {

-- 
Siemens AG, Technology
Linux Expert Center


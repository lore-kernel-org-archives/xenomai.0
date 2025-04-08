Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E84191F79
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132018; cv=fail; b=Io12zMI9RibbkF58RSd75H06ghZw1200V+mSfyj+GXLiLjdxN12g0ApeZ95apt2DCsQCzbuMHi+8wycS1hhFIhnqSVerRIT7oUkNjld2FPzADqM1zzR4R9hyTgnSZPIXwsizAw+Rio+s9SxRvBFtWHcMpIpoTQC4i0xBbSlQieE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132018; c=relaxed/simple;
	bh=an3IfXO2Db5owIy6qC3lu17Y6SfeKrYe98kIBloTVt0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AFYgNJ4d5bkltGB8T0lJ82XCvBlqdtIWz+Ms3Xtwh5EJLNgdrEHeWy+WzJnVggTyokVhTJ4QXqTdmCRPnvRZbhV5TLozyQylW80fHz8OdF1C2h4a/n0JRFi7TKW0Cvrq5poMg2jHhfxsz/dnjdg7Pkk3hOS8WMqhqLyfvOzE9fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iOdOR3eq; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iOdOR3eq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKQf34+tTBoEG4GmANapI3FHhW49mbEV3jTa4AkcT9YtESfkF6xNAkKV5ZHHgD8Lr8XpHR9cfc5o+cuu6yX105olspBpJv4a1jUIYadi7zzwXCsaKhScO9Ofhtv7NXvDS/4ig9MQiKC2qLokgLoX4ev860unqsLk0LjCNibF4pBcqZ1BETHa6WwDwkNIYoUSBi7XmshvhX91eXUmNo0WJnwN1xjxDwML1nI4LXRNCG8ex89gUwUFR9cFt9W2ZlZhFwAGsrQXO2Sfa4kUPAeHYgucfy/uxAspKj8yECcCmmT2mASPzoErlQz+V3bW2jaUeQ4JTs0sQwumEogMYI6cfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws69L6LsnI7mz5HpPMrzrqV2u0bp17S587FSoMBaFjM=;
 b=X3ddSdq7iVehUqvkr9re2LT3X9GxrXYKXx0jtf8X63iLq2eP5wk7FQtN8O77SJAP29KzxvtADPguH2fqYGkH/ddziogqSscTKzv67MPPmusBbQF4AttvWG2Dza9T7EelZG3Cgfkkc1EvRsJffPKd1cYhbCChtx7c1NxI7b5nU1kFN3ikJ+vv+AEK5HlJYw4sdUuT92QMfTfQddq2r77d8ofytVrxa+PjCMghXOGf+Tp+AAQrbojzXCG4G2paojpdflNrboKpGUrF8XhkAadurWDd0CFqBIS1EvUnIc/xeeJf4FkyzAO5qa5CqskRmx1E5Z29//ZhZiCU9FYr+asmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws69L6LsnI7mz5HpPMrzrqV2u0bp17S587FSoMBaFjM=;
 b=iOdOR3eqlgBa8phoQ3uGLri+9hx/rw32ITwus1XMykcVXrXouNozni8WOtmebYA896IU1xD2bs34YVuAtDp3unV2aL43EjUqoeOEGxnl4TdAJev7NBGDMqlGnOOpuytOd8o/w/NqSDGTP0zT4fPLO1hSEGy4MJ9/kLDYLBKLJzBasU7ZzzTMzQT3ovXcemk+2Ee4j32iArEHb253T+G+xjkkDbpk3XTpkbmp3WIAMyscxKCqp3+IRnI1LCNth+U01d04NjZdrON2nCfaFONnAd+W6RZihqlifnfJUEint8s5BUw5RPpPaU2kCLmqbHoyQ6kEhayM03Uef3hx8TpFYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Tue, 8 Apr
 2025 17:06:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 17:06:52 +0000
Message-ID: <a28841a2-cb96-4356-93c1-ba08eb954210@siemens.com>
Date: Tue, 8 Apr 2025 19:06:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dovetail: Allow early return from traps
To: Nikolaus Funk <nikolaus.funk@sigmatek.at>, xenomai@lists.linux.dev
Cc: richard@sigma-star.at, Richard Weinberger <richard@nod.at>,
 Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
 Lorenz Kofler <lorenz@sigma-star.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
 <20250408123423.627477-4-nikolaus.funk@sigmatek.at>
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
In-Reply-To: <20250408123423.627477-4-nikolaus.funk@sigmatek.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0140.namprd02.prod.outlook.com
 (2603:10b6:208:35::45) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3940:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb194ad-c403-4c8c-d98f-08dd76bfc21d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXVraWZCNlJLdXl4ZndMSjNmbjF2N1ErY0JqMFBCdDNKNFlnR0hMUFZEUFJV?=
 =?utf-8?B?QzJtV2QzNU1wYU5UY005WnZ5bkNsTUkvbHJpbU1OR0JudjZSaE1VVWs0Wk1Z?=
 =?utf-8?B?dGo3Y01XZk9LcC9WUlBPd0F6R2xtanlMankvSksvZkE0blBBK2ZNMXV4M3dO?=
 =?utf-8?B?SkV2SnpUaWhrS1RBTlR5dWxFL001UVRrQTY0RmJZaUxERTRwcE5CcFRvM0dP?=
 =?utf-8?B?b0crUEVPakxINncvSTZHeEJyVUppSWVZV2FyZ1dZYWhvcy9oNk5lemNqUUcr?=
 =?utf-8?B?RlBjRnNlaVl4NysvaVZQQVZpSk0zLzV3STlNaXh6U3BpU1MyaHUranhKQ3JZ?=
 =?utf-8?B?QzlBOTBIOTlCWDJqcWhZbStWMnhuUnQybFFkcHNtT2ZpaklnV1lDVDVvVE90?=
 =?utf-8?B?c3MvblExWkhTUHoxamc4ZFZWWWM5UFIvNmlIQnd6cTFOckhWc3IzZUZ0Zm1t?=
 =?utf-8?B?b0xoUm9LZmQ5Zit5akpoNmdiaU1YOWFsdlZZMHVuQnFuS0IyNnlKMnVhR2hX?=
 =?utf-8?B?TGxMNG4rcDhVVUw0alVhZzl4aFZDVnFVM2w2RHlIVzc1TWxJYnZhQnlVOWpB?=
 =?utf-8?B?M2xDNXNiSDRVT3ovWkRFMDlLYWtBMEdHR3RuK1hWdE1nMHFFd2RsSHMvc3pZ?=
 =?utf-8?B?T2tSTnpPUTk3d2JjcWNoK2R5TTJvN2FPMmlpaHZlckJwekVhV0J2cGJHemZ4?=
 =?utf-8?B?dVZYNWhUMi9hK2F6bXVQcmw3WTU5NVhuRUJ6NFlmM3Eyc0VLcVhxMkNsRW9T?=
 =?utf-8?B?UVdFR1J5WGw4ZURhRDVmSUpHNFMrajNJZW12a0diaTBjVFhvTHZFTStWZGlP?=
 =?utf-8?B?aUdjUXZBQnZRc0Nhajl4OSs1cGdRV1dlRnpublBXSEphK3BGdGU5cEpxZHZk?=
 =?utf-8?B?QTlxUTZNcE5qRm5LNW5sdXQycFZRV000VzRBdzgyV25XZklVSzJiU055WDIy?=
 =?utf-8?B?bUZ0dnR3KzhjRWZyLzc5UDVZV0E3bUM4MWZqNWlQU3VUWXBaRVpLcVVJRHFn?=
 =?utf-8?B?VkdlcTlHbk12TUQxaWZudEJySkJFZzJCc2hSam1UMVUvYWNsMjVlVk1RcE1U?=
 =?utf-8?B?ZEFXL2Fhemt5NEZJM0NzQTU4Q3RpSm91ckhNbDBRd2UyeVl6enVnUUdGVzFT?=
 =?utf-8?B?b3ZXTVBOeS9pdEZpdGhmSkloZGs3Mmp3TUowc3MyMVhaWk5leW95RFYwVjEr?=
 =?utf-8?B?Q1psczZKdzFweXIzVWE4RXBnZGE0T210bWtHc2twSWpna3hNN3hjQnE1eTJh?=
 =?utf-8?B?TUdGaUpZVEszcm1ReG5PR1ZrTDU1Q3pBK3lsUWpyUW5iMVVSelBGQUdwYlIv?=
 =?utf-8?B?NDJ5NDNidlFGbXdhV292bUYwS3k4YUY1bis0ODNvM1NwOVU1bm92UlkyRkxq?=
 =?utf-8?B?cGFoK1E1R1d3TDdKNzNUTVRPalBFSC9RdkZMUEtRR1l4TWlIYzlWREZ1RkhC?=
 =?utf-8?B?Mlh3NTBWN3NPUXRtdVhjQ1I0MTgyL3o3NzlVU3ROL0dab2V5RmphWVBPdDlI?=
 =?utf-8?B?SmVQUmN6bTlvcVdMNXlkYXh3MWh5N1dmSlFEZUVCZ05QZjhkUHIyaktaaVNC?=
 =?utf-8?B?Wi9Yb3F3eEh3SFVJWm9ZWnJUclJ0U3ovRVJoamRQbGx1UEpnWEducDdxbjVS?=
 =?utf-8?B?WWt2K0NjQmNQVThyRHVydUJpVjZpVnZycTRWR2J2Mi9xNU1BNlNDOE15S01v?=
 =?utf-8?B?bjJVSFFJTjJsTURvalVzNG9kWkpIMWVVWUhXTmpkZ3pFQml5cVlnSVNpSWtY?=
 =?utf-8?B?Y2dISlE1WkUwZWM0ck9TQWU3a09MUDVSUmVIMStwbkc2MzJTalhOMk52eTQ2?=
 =?utf-8?B?R2lRaG94UUdsR2FYM1pxWmhTRDcxOVFwWTRhVXZRZVQvODVETXQ0RmpUQTM2?=
 =?utf-8?Q?cbyJPlV0T8+lU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFdhY3FjNUFWSExwRDBNRURjOUJyNlhTM2FVRnYzdjBzaVNEeUJhbERUNzZ0?=
 =?utf-8?B?QUh6ZHlRTmFLZTN4RHNrUXJOb0M2MkdFZXV4d3JRLzl6MmZib0hwVmZLYUFv?=
 =?utf-8?B?Z0FDVFRSaTRuTmJadUR3dk1NTXBONjJMSWxwVE9JVmYwcjd2dHh1VUVRTnJ2?=
 =?utf-8?B?SkNmYVV3M2dRdWRHMjZEY3BYYlR3aW9uOWd3eXQ5TmhLUFM4TXV6YWhBajVQ?=
 =?utf-8?B?azVQN3lTZnFJbnhmcFdaazNtRi9sL2xGK1dHTzJLV0FLcC9JL3N2OW5iK2dW?=
 =?utf-8?B?VmU3RXQ1NGNkUC9YSHQ3a2JpS0wwYTBFK2dnaEl0ZFdmVEN3NElpMzRraXBM?=
 =?utf-8?B?WVU2OFZwbjFsU2dqcVFLbEx1azNFVFVMQTA1M3dHamtIUHFIT1BoeitTVUVG?=
 =?utf-8?B?akFWVysydG5BMU5Ecm00Y3ZhN0JGZXNSYktjMDZRTDM0bk9xMTlnZm50dGNR?=
 =?utf-8?B?RkQyNUIzaTdqU1pINmN1ajNjbTVjU0kyZzR1U3BjaTRZbkxCMHQ2OWZQUGN4?=
 =?utf-8?B?ZzgwWHlVN1JGV1dMdnFxZjJsbE12VFpnMUV6M2lMTkRIVmJ0L3huUkNJUzRE?=
 =?utf-8?B?WnkvZDBWaVR5YUR5WjVBZzg1ci9SK1NBcHh0VXBSeWUwQndFY3lmVEdPQVMz?=
 =?utf-8?B?eDJtd2xxS3JYa3JsL2xKc0FLbzhSWiswWGFlcWkxdVJtZlZEeDJjU1IvMW5j?=
 =?utf-8?B?Q1lMQ3dpczdjWk5jVzFHbVRyQnRLZWVPZFFER1JWYzRaSzI4QTdsbXhsVHZu?=
 =?utf-8?B?a1BlTk9LN203ZUhrZVBKQU1ib3lKS2dERWFGQXRvTC9ZWlBrVHprSGY2TEhz?=
 =?utf-8?B?Z0lETjV1eXpWem5wRDkrUlY0WEpDWTZFYk1lcUdSY1hQa2RqbFZYRWdpSG13?=
 =?utf-8?B?cXpwVzJEWUpGNFgrdFEyczRpQ2g0SjFOZmFZWmRPaWIvUmZGQ1JsdEQ0VHNU?=
 =?utf-8?B?eWJETmVyd0dYR2RPVHo5Y3pGbERkZDNNRysvaU1zbWhOajBLbU5vbmVvaTFy?=
 =?utf-8?B?YUlzcVZZZFhwdVRPRWp0RkpkR1M2c3JUSHBnVXZaWHR3TmxkZGd2cFBzeTFy?=
 =?utf-8?B?em5DMk52ZWZwNlMvTmxQa2FscjF0WnhHM3NWRVlHWThVNWNIWkNtcGlHR09L?=
 =?utf-8?B?bWlRK1UvdjlyZ1JWWjF1NURaR3hxSDJId3B2cU51OUVGYmxiMUZYTjlaTENO?=
 =?utf-8?B?SHhwcG43ZUZxSlFidVc3STlTZDhOYnhqeEhQQWtFY1BEWFI1Q3FGSXRhSTlp?=
 =?utf-8?B?K2JyVDhqTGNiK0IzWlZ6RGRwcEV6cjRYOEZyUkVaTTJpOWJzZm9qcElqMlVm?=
 =?utf-8?B?L0JCWU4ybnIyaHVMSHlpUS9MSXd3eVE0d25PazA0YXZjRHozTjlDRnFGSFNh?=
 =?utf-8?B?d093c1dYSkxVVjdmdmhFSGdGRHhYZWN6cVdJczRaelVlaFRrS2YyZ09mZ1RI?=
 =?utf-8?B?RkVqdEhaQll5a1N2R2h3eHNEMUwyYThrZGE4amRXaGc3UUZJekJWQzYrMkxq?=
 =?utf-8?B?My9nc3R3Q05YRnZPYjU5WklZbzRiTEtZNFAyc21kNVZ2Q0wrMTFWVXZhZFlL?=
 =?utf-8?B?OG41b2VnbkVpMFdYa2JVUy9YemdOcXZLcStYb2o5VU1QOTd0Z1JkMnczWTZz?=
 =?utf-8?B?YW5XZkEzelZCMVM1bTRIKzhMY052MU1UQTFWODZMQmYyWGVEZFYyZTFEN3px?=
 =?utf-8?B?MGo2REt3MU8xZ2ZjSkJ3U3RGWk00N1JsOURpU1FBRVdnSlc1UXRXaWpQSWV6?=
 =?utf-8?B?WXBFNnVJQll2ajZ0OU1BcG9JcW02aHlCeElVeVpXQkEvWFFoTGQxN2xZZFFV?=
 =?utf-8?B?ZXEwVTRzWVl2RmFwQVRTakJzbTdwSFJCa0lWN2xEaGhMRkVWOWFvS0xidk80?=
 =?utf-8?B?dDZqZnJaZTFTS3B5NERhRURRcDNnaUdITk93NUpQRDhQSCtsdEROc3BQYU5v?=
 =?utf-8?B?OW91STRQMDREbjB0TStkMjlJOGdkUU4vSFBIcHV3M3VMM3NpZHMrYXd0ZXV1?=
 =?utf-8?B?YWtxMmthRWJyQzFaV1d3VmhLQmR4aVRTSDg4ZDRhaGdZM2NyM3ZQaVkyYTR5?=
 =?utf-8?B?ME1ZVm9DT1YrWW5sRWxlbFl6b01IRjlFU29nV2xTT0NGeEV1UWhNcEIzajhT?=
 =?utf-8?B?ZzNQU1lHMTFWS005WGFRdnJPOEs3aThjSU5aa0U0cFQ2cVEvTEpFS3ViZXAz?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb194ad-c403-4c8c-d98f-08dd76bfc21d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 17:06:52.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOVHgn9wr1lcxheZxE9R2VhDzkKOEGCOVeiPTOaUtiNoVVg3mKCjRWltjoR52LAZGF31AyXy0fXUPgkq94foNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3940

On 08.04.25 14:34, Nikolaus Funk wrote:
> From: Richard Weinberger <richard@nod.at>
> 
> Like on the x86 side, allow early return such that
> handling the exception on the Linux can get avoided.
> 

Which traps can be caught and fully handled in oob this way? From my
past experiments, that list was not very long - and when I look at your
Xenomai 3 changes, it still isn't. What was particularly hard: DABT and
memory access faults.

Point is that we need to have some kind of consistency, between the
archs and between the reporting information (Linux vs. OOB signals). Or
we extensively need to document where all we are deviating (and ideally
why).

Jan

> Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Co-developed-by: Lorenz Kofler <lorenz@sigma-star.at>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/arm64/kernel/traps.c | 18 ++++++++++--------
>  arch/arm64/mm/fault.c     | 15 ++++++++++-----
>  2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 0f3dcd34be87..fb135f886486 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -462,14 +462,12 @@ void do_el0_undef(struct pt_regs *regs, unsigned long esr)
>  {
>  	u32 insn;
>  
> -	mark_trap_entry(ARM64_TRAP_UNDI, regs);
> -
>  	/*
>  	 * If the companion core did not switched us to in-band
>  	 * context, we may assume that it has handled the trap.
>  	 */
> -	if (running_oob())
> -		goto out_exit;
> +	if (!mark_cond_trap_entry(ARM64_TRAP_UNDI, regs))
> +		return;
>  
>  	/* check for AArch32 breakpoint instructions */
>  	if (!aarch32_break_handler(regs))
> @@ -507,7 +505,8 @@ void do_el1_undef(struct pt_regs *regs, unsigned long esr)
>  
>  void do_el0_bti(struct pt_regs *regs)
>  {
> -	mark_trap_entry(ARM64_TRAP_BTI, regs);
> +	if (!mark_cond_trap_entry(ARM64_TRAP_BTI, regs))
> +		return;
>  	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
>  	mark_trap_exit(ARM64_TRAP_BTI, regs);
>  }
> @@ -613,7 +612,8 @@ static void user_cache_maint_handler(unsigned long esr, struct pt_regs *regs)
>  	}
>  
>  	if (ret) {
> -		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
> +		if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
> +			return;
>  		arm64_notify_segfault(tagged_address);
>  		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
>  	} else {
> @@ -672,7 +672,8 @@ static void mrs_handler(unsigned long esr, struct pt_regs *regs)
>  	sysreg = esr_sys64_to_sysreg(esr);
>  
>  	if (do_emulate_mrs(regs, sysreg, rt) != 0) {
> -		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
> +		if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
> +			return;
>  		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc, 0);
>  		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
>  	}
> @@ -916,7 +917,8 @@ void bad_el0_sync(struct pt_regs *regs, int reason, unsigned long esr)
>  {
>  	unsigned long pc = instruction_pointer(regs);
>  
> -	mark_trap_entry(ARM64_TRAP_ACCESS, regs);
> +	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
> +		return;
>  	current->thread.fault_address = 0;
>  	current->thread.fault_code = esr;
>  
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 00159c38911e..514382742118 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -486,7 +486,8 @@ static void do_bad_area(unsigned long far, unsigned long esr,
>  	if (user_mode(regs)) {
>  		const struct fault_info *inf = esr_to_fault_info(esr);
>  
> -		mark_trap_entry(ARM64_TRAP_ACCESS, regs);
> +		if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
> +			return;
>  		set_thread_esr(addr, esr);
>  		arm64_force_sig_fault(inf->sig, inf->code, far, inf->name);
>  		mark_trap_exit(ARM64_TRAP_ACCESS, regs);
> @@ -567,7 +568,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	if (kprobe_page_fault(regs, esr))
>  		return 0;
>  
> -	mark_trap_entry(ARM64_TRAP_ACCESS, regs);
> +	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
> +		return 0;
>  
>  	/*
>  	 * If we're in an interrupt or have no user context, we must not take
> @@ -818,7 +820,8 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
>  	const struct fault_info *inf;
>  	unsigned long siaddr;
>  
> -	mark_trap_entry(ARM64_TRAP_SEA, regs);
> +	if (!mark_cond_trap_entry(ARM64_TRAP_SEA, regs))
> +		return 0;
>  
>  	inf = esr_to_fault_info(esr);
>  
> @@ -935,7 +938,8 @@ void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs)
>  	if (!inf->fn(far, esr, regs))
>  		return;
>  
> -	mark_trap_entry(ARM64_TRAP_ACCESS, regs);
> +	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
> +		return;
>  
>  	if (!user_mode(regs))
>  		die_kernel_fault(inf->name, addr, esr, regs);
> @@ -953,7 +957,8 @@ NOKPROBE_SYMBOL(do_mem_abort);
>  
>  void do_sp_pc_abort(unsigned long addr, unsigned long esr, struct pt_regs *regs)
>  {
> -	mark_trap_entry(ARM64_TRAP_ALIGN, regs);
> +	if (!mark_cond_trap_entry(ARM64_TRAP_ACCESS, regs))
> +		return;
>  
>  	arm64_notify_die("SP/PC alignment exception", regs, SIGBUS, BUS_ADRALN,
>  			 addr, esr);


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

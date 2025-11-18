Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967EA36998B
	for <xenomai@lists.linux.dev>; Tue, 18 Nov 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481621; cv=fail; b=P8mcpvcnhz2tWXqQUP75eNvtAHmluFK3vTWL35y9Q56+WfN+oEJly08uLdzw8EzZ4Iu3TJ1xZ6vqp8zkoCIpy0X8Q+0Kp2WmVuOoSs4DsxyWyPmsp4l22NJVaDDjzWyC/JXwISw91REekFj7a4kNjJ1ht1Qni/qWl369i8iDiks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481621; c=relaxed/simple;
	bh=HU+g/U2rb7M/igmu/hPUDMSmQza+srFuEilm2O2Hzsg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KU2jvqoC/eoU82db55TXqFK4mM4QFnOYz6KWXEfLnS/eoOG0/P3kkQSjDdPoN7GvFjI87NKF/YU9OpFRblpM1aKBfaVUsPKkHY6leCcjFXHb+NtSwAxmr1UBSysm4w71IaGP8fbShMeWk74jLeOmqmuESCeclcz/4vLBwEmsCYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OqvggEXp; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OqvggEXp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td18uxoH3o8cY/TU9keRHXQwVdVJjbliX26jhMgGqkwsQ1P+pGgVfPKYna8ObRb5JsIb+avrfacqYXyFOz+Tj0mK1ieIRphUQWtuDs1PWGusa0X1KnKaFdDsf7/rRQazIITlCxoCJ87pnnjuCDl/cjeiqkFROeHAVO8gFg02jFAXP6viardJ12RrqLXYhXH4gezEipVaV4TZ0bJAPkTvv+b/39UpiDNuldB1yw8KDcdfbXY36h3IoZelkFWkAekBaHb97oWZ5QYaC8zk3ucxtTrbbMeHRLfqX/Gk7gxR6ntDzcVAxA+bxTuL/wUS/yaZ1KM386zl0PmzM//SQa5/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPaBYg06WusHPFL7OvOAGs2z+Q78nfWjEHLwQXCkmv0=;
 b=XzszSpQYHKXqd6lK5lbQFr1TNf7G+JZAXk4LHD37Hvxc8d5UIEfHbFRRMy1c+AUHEE8S3agncSCNSyj4uI6JZTCQd/dg3JzeR0NEqerF6noRZoec+T/yYTP7qglv3xn0iV5Tavf5g5tDf5irAq7+1cqAOPK3lLY77o8hl0mdj2aTZqpwa13qK+RgrXLO74oqEGKYw7S43Q1i7ApPtRWcTk/xA5PwkWJgCK+o3mjMe75Pi3ID1w+o3nONzxNgez3gbSEeKZ+xuNE+gexeDF2QVxFofIcD8cSTCnNdeGS61QSjCeUg5ZqXFyh0mngk8wOr3wD6CaUBOD06FbITPK5ENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPaBYg06WusHPFL7OvOAGs2z+Q78nfWjEHLwQXCkmv0=;
 b=OqvggEXpqt0kRpGJrl6HvMgknnPoiXovq2IHvV48FHlUAZCxiHxqIUhOeMlN8Reg+hCs00+rMPpoHvysMjYJH/RuzGFRsJXg108sDtrRRLRemYRn/reAZrednfpJ19pIh37TCgOmemf/07BAh2xBP0Sym49/toYq1fcUTLO4DPcT3I9sUJOdTW/MFcZhAbNBjE8Tzgr1wkSQtztF38T+3fGthN7L4BxaH3Mn+D1ICXIs2ODteh/MB0H7M2ksk8VmD23ybtdA94aIsjUDLKRFAoXJiB3k8K2SuUyLSj78sIlkO77aBGh7m0GPSGVBaZ0Ui/YExSJjgKuqmrEoILkUNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6951.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:579::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 16:00:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 16:00:14 +0000
Message-ID: <90075e27-a5ee-4e84-a621-eb8a69198590@siemens.com>
Date: Tue, 18 Nov 2025 17:00:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: schedule delay 15ms
To: JerryJun <jerryjun123@163.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <4c6fa8a7.4dce.19a76af1422.Coremail.jerryjun123@163.com>
 <d14c720e-021e-4fc8-8aba-340903db0fdf@siemens.com>
 <25a5a707.3daf.19a7b5f1c16.Coremail.jerryjun123@163.com>
 <077351d6-f855-4034-ba1c-3c9f2b713743@siemens.com>
 <17aa2896.2b1e.19a8043a959.Coremail.jerryjun123@163.com>
 <78da3e59-a848-4019-aa53-639f2ef22f33@siemens.com>
 <7fd14fcf.a9b1.19a97976af9.Coremail.jerryjun123@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7fd14fcf.a9b1.19a97976af9.Coremail.jerryjun123@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: 8733d25d-a7a1-4355-e547-08de26bb8fb8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YklrR2JRVm5zZzNnQ1g3c0RVc09TdlRFVlRlR0FlZ2JPM05RTXpEVFFYVmhW?=
 =?utf-8?B?SXkxUEs5cEYvZlNZOE9OMHNMYVYxczVJdGs4ZmxWck9IMnNueUdqaUxvKzNx?=
 =?utf-8?B?MGZxMDQzaHZuaU91ZUVXRm5BUUJNTmNOVXNKbThxSzFjVVFaakUzOFUya1Zq?=
 =?utf-8?B?T0N2OVpXU2dLL1NuS0cwOGt2azBrWWV2OGdPUUtmKzlhMDlSNXZFVG95UkZL?=
 =?utf-8?B?WXlObStWSkVYQVNmMll6SGxIaE9lZ0JUajFOTWxpMmFta3Y1THREU3NPSUp2?=
 =?utf-8?B?OXhKN1ovUGZUUDk5VTJzaWlpd2M4OWhSNDQvSUlFWVJVb3k1c0hhVXkwZ1lY?=
 =?utf-8?B?U2hXWjRxazhsWW1hNzlBTWFpRVYzTVJFOUtNUGhvUVcrUW9DL3orcXhBczFJ?=
 =?utf-8?B?WVJCaFIzeCtxbFJpVDNLTXFNN3htckRLYS9LeEFKUnZkeWhqaE1TYmVhb3Fh?=
 =?utf-8?B?YXduKy9qeVZZWlcyODU5YlBSQUE2V1ViWVI4akJEejk2ekNHWUtvNXBnbW81?=
 =?utf-8?B?dTdJUTZWd0RsTVZ0NnNBTll5eUtLV1p1TWs2Z3M5d2JnREttKzk3TVpEZXFN?=
 =?utf-8?B?TVJkZjZzYnNpZHNISDFRVFhUSm1lSFlCUG9vUjJIVDBRUm4rUmk1NmZnVk5T?=
 =?utf-8?B?U3JDb1N4N0Uxd0l5Vk5FSkg3ZnJiUllWdWpnVjFBYU1FQ1JIOFY4NDVGUmlk?=
 =?utf-8?B?czZBc1p4VDhWRDloR0FYa1ZMZW5iek1vRVRXL000eU1QaEpsTEFkMnRpSVdk?=
 =?utf-8?B?cGkwcWJuNmVNbVBuL0Zsemttd29tbDlMUEdSeXZTSnlTSUM4NXRhZVFOYW5J?=
 =?utf-8?B?ckVQWUxvZTkvVTNsS3liYk9TUTFCV3E3VzBQYWF4N21LREthYk51cmVyci9r?=
 =?utf-8?B?MWJpb255eE1pNG9acEkxTlphdFNJUGh1N0RZL3ZETmtkUVZMRCtLR2F5T2lx?=
 =?utf-8?B?Ykl5dTh3Mkdha0pwVVhHQnhMdlNHQkptMStPY1ZDeTR0bVpyRmpVaWZRQWRW?=
 =?utf-8?B?V0JQUVBVZzFTdE4zR0JGUitFVythUkVHOGVkdyswY25lV2ZPNFFSWTJNQ044?=
 =?utf-8?B?TmdpKzNMdE1YY1N4TENqL2dWZUswUkZ6NjU1UHFhMmVZWDlZcnRucTVteTk3?=
 =?utf-8?B?RUN1WVg3dkhkZkJwRUlsVDEraGdvTVdXaEJEOUJGVjhDaHNHUTlHQXhENnk1?=
 =?utf-8?B?S2VoMU1zblkzYTdYeWs5aG8yb2U3VVBjZ0M2RGlwdEFmczhseGZFZlVXNkdt?=
 =?utf-8?B?NEJ0ZDVCaUNDMFp6NWE4OUhkbCs3NjVwR0FJWVJvVWsvUlZHQXJieHRKY291?=
 =?utf-8?B?TlB4MHJLaDVJN0FRcHQwNjVibHlUQmlFcVhTRy9RdnZrd092dlFqZ0Yyb3J3?=
 =?utf-8?B?cU5WZCtWTWEvZkVrb0xxaEpwOG9GWEg4YUNsTFpUNWtJVGpTUXUwZGpwQjVr?=
 =?utf-8?B?Q01hdFpORVRLSlRXNi8raWkzVHFsdDk4SXg3ZXlDWjJlSFNzcm93cnMwM3Yz?=
 =?utf-8?B?RXpPWTl5YnZtSFgzQnVtVXNSdjVMaGxVNHZ6dXpYY3U5VWg4VUpabTF5L0ww?=
 =?utf-8?B?R0NlT2tydDZVQnJhQmxKemt2QWNBY2NxU2l3YWhGalo3aUluQ21BWGZwMGhW?=
 =?utf-8?B?dnBtUkNXa3Y2WlVIemxqd2lYOVJFS3h6dzlZZ01VVmRxNld5V2VtU1lqL01U?=
 =?utf-8?B?ejlUMVJNUTI2d2k0bVpxdGxyVTUzN3BhZ1VDd3FlZjZaelVpMGlvbmpYZGYy?=
 =?utf-8?B?anBHVktONnVCZFA0TWJpOXZMWUZpQzlIUkF3SWJmb0VSUXN0cGVxZnBMamJh?=
 =?utf-8?B?Q0VMSGR1Sis3dnMzTGtpZVdqRFNYQXY5dWl6NitCdUxDVURmSE1mZmhwYStO?=
 =?utf-8?B?VTQyVzlndTdIMkxJMTMxRHhUZExmWThHc3JDOE02TW5iY2JYSTZwRUt3OWV3?=
 =?utf-8?B?WThPbDJGV0crTFU3elBTakI4YnRsYjhYNHd4eDlTRmY2aXl5enBYc1F5V2pF?=
 =?utf-8?B?YUgxUC94bFdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2pvUERFQnAzODV2UkVwN2VXUWR1YWMvczlsOEhvK1Z6STNXbVc0bnUxcVlS?=
 =?utf-8?B?dm9IeGNpTEpIYXRRL2kvRk1RSFhPVkY4TE1NU1E5ejJjSnR5NGhONUFkTjdq?=
 =?utf-8?B?Qk52NzFGMTBQMGU3bFk0d21henBXQUEwRkZNOFczempVTVZyNms4NDFMOC81?=
 =?utf-8?B?Yk5CTDJhZjBRakh0d2hNMkhtNXA1c2JsOGNQVlZlV2pIampzUm91QTFDK1M1?=
 =?utf-8?B?QVJSSGFyalpkOEN0R0cxcE84UnBVZDVzT0JCVTJmVTQ3NmJVNURQOTdmMEZv?=
 =?utf-8?B?NWRMNno0Y0lkcm1kRVpTRmowRmFrdlZQTzRIZXpJWEU4YWRSQlN5U3h5R0sw?=
 =?utf-8?B?ZWZVQkZ0TGtXcHd2QXRrRGVJVzZwL2puUndYR05jRG5KZUg4RzBYT0szRnhh?=
 =?utf-8?B?K1YrM2RLSHcxZkd1SWZVWHBMd3V4d1M5T0dhU0Y2TXhhWVB5RlloNUxNWGU3?=
 =?utf-8?B?ZFZFeUUwdG5WZXBYM01HVHo5bWV0NGdrelRMeHYxSzNTTjZLU3lRa1p1d2Vl?=
 =?utf-8?B?VzBoWTlhbGNUSjhxeUpzVE9JTE5VUHJPWFhlZXJqQ0VmWStXT3d6RGZoS1pv?=
 =?utf-8?B?WEpYaFI0dm4zemg4eU01bG1BNVZVNzhFMEw5YUdyK0VSYy9jcHRnY3RNcVVG?=
 =?utf-8?B?VkhKS2JzTTJnMmNsV21GQXlKMU1vZkhnbGxyY0R2dUF3bHVTYkJrZURJNFQw?=
 =?utf-8?B?T1ZuV1duMURWcEFLdDYyMkZhZ1d2TlFITElhTk1KajJ5SVZsWHpUVGxtV2dx?=
 =?utf-8?B?VlJtSW1pWUFGZmhmU2JkUU5yTkdwdTIyYURKVnBCR1QzTmlURGdtaXhyam9W?=
 =?utf-8?B?cUVTK2I2VVREUzUvUXljWWpHUTFqRjkwZldDR2t4MWR0aUY4UHI0YjZUL0xn?=
 =?utf-8?B?ZDdmcGNWMG1OOWNxMnpDVng5Z2cwVGg5Mng2MFV5a3ROb0lwUjdjSk4rZklm?=
 =?utf-8?B?cDBtanYvc2h3dUlObWpzUW8xQWVxMG9kRFV3cVp2dzJhVjQ4ZXVQOGRlQlZJ?=
 =?utf-8?B?dllSV3prZ1hDTkNiSDRQQ0k0OXlyeXV1ckQ4bXFSYVBGaEtoNzdncktLdUE3?=
 =?utf-8?B?KzFHZmw5TEdzWjM1cFRTMnlrWFpsb1d0U0U1cE1xalZ2MktFZW9saEVvY3pN?=
 =?utf-8?B?UWx6VThGcXRia0FPRkQwc1ZPMHF3T2E1SlF2WGRGVk53QXRPUi9ZbE1BVjRB?=
 =?utf-8?B?bjIvVUpJbWtTb1Fkc1JlcC93R2x0dXpRWWQxYU9EeFN0YW1UNDJuKzl5NzE1?=
 =?utf-8?B?VGwycWFGQUtNNWRWTXFJN0V5d1JRUDlZOWUvaXFQU0FPOTUxakk4VG5SYnhh?=
 =?utf-8?B?MUdBdnZMZnlqd1JsekEvVWd3Qjl0NUFhN0dKUC9nM3hPVlRqdjYxTFlnRDZ1?=
 =?utf-8?B?b2dydW9hWEZ6MC82anhzNXY2cjVCS1VRRUNQcEUrZEN6WFJ4U2NkSHNwSC9w?=
 =?utf-8?B?TEsvWGNuWnBEQy9HblA2WThQaDZwUnY5ZVJRYkMvcTgrMXgrV2Q4RnpSNmRH?=
 =?utf-8?B?T1BpK2MyVDVCWnNNcUYwOUc0bS9xYndTd2U3U3RUK1FzVUdxcmVsS0lEWjUz?=
 =?utf-8?B?ZllHVGp1SHBFNkdiTlVMenQxVzV0SFYyd2FtVkJJR1g0YnFwLzNrQmhob1Rx?=
 =?utf-8?B?cjBtNW95RXhDeWNnVTFBQWxvZ25JN0JDZHRwMm5OaEYzOENwM2NEYm8vU0Y1?=
 =?utf-8?B?M3ZYZ2RlSC9jZDhQM09Ucnd2RnAveWxjRFdRR204ZVlOdXdWKzVQRXBtS0JI?=
 =?utf-8?B?Q21rcWUxVERLeUN5MVd0bnRxenZuYWZvODNKQ05mdGlsR2VDSVJ3T3ZHa0tp?=
 =?utf-8?B?RXBqbUc3aGxzVlphVklxN3NHQmdXOFNmQWZ1SVZnZGtMTWcwa0JuRUw4UlJO?=
 =?utf-8?B?dFpOOFo1SjNSaENuSW92aDNpZnNPTk96UVNnYWh6YTRZN3Z4alBuZHdvQlBT?=
 =?utf-8?B?OFJqRU9BSUhxVUp6WTd3azF3QW1FMURQQmFqbWpMM2dkKzNMSGY0djlvd0NX?=
 =?utf-8?B?V1YvbE42ckNDdzhickM1UjdtYnQ3ZlFDMW1ZY0taSnlUbE1tWXJzQ0hjNUJP?=
 =?utf-8?B?M1FrOURUT0tOWVo3Z3ZqbmtOMmhxQThjbk9FdC9HOG9TTHNKVk4rNVdEdnZr?=
 =?utf-8?B?dVNITU9VWFJCVHR2NDRuQlVuL1RKcGtvRVFsMlVnYlNJdnJBS1dRTDZobmho?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8733d25d-a7a1-4355-e547-08de26bb8fb8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:00:14.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MepwJQFE7IvaC/81L6PuH3s2OrdmNJxl4HwWJnSXuYvKEJSkwpXD/It+aXHb/82A+CZ/MlWfMzNNjVGzEUwbXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6951

On 18.11.25 16:31, JerryJun wrote:
> 
> Strangely enough, this delay wasn't present on the 4.19.89-ipip kernel - it only emerged after upgrading to 5.10.199-dovetail, despite no changes being made to the power management policy or thermal throttling settings during the update. Could this be related to potential instability in the HPET or TSC clock sources? And does upgrading to a new kernel version also necessitate a BIOS update?
> 

Generally spoken, a newer kernel could always have changed something
regarding how power tuning is done. Simple scenario: a kernel config
switch was renaming or gained a new dependency that is not fulfill ->
tuning feature is silently lost.

Another reason for different behavior could be the enabling (maybe even
by default) of a new feature that has unexpected side effects. You may
check if there are new drivers active, new devices available.

Jan

> At 2025-11-14 13:38:36, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
>> On 14.11.25 03:48, JerryJun wrote:
>>>
>>>   We added some trace event information, but from this gap point (6208.695948-> 6208.708726), it appears that the Cobalt kernel was frozen and no interrupt handling occurred.
>>>    include trace point events :
>>>     irq_vectors:call_function_entry                    
>>>     irq_vectors:call_function_exit                     
>>>     irq_vectors:call_function_single_entry             
>>>     irq_vectors:call_function_single_exit   
>>>
>>
>> If there are no interrupt in that phase while, e.g., some timer
>> interrupt should have occurred, then you should definitely check for
>> hardware/firmware related delays that the OS cannot influence. Or for
>> power-saving / thermal-throttling causes.
>>
>> Jan
>>
>>> 在 2025-11-13 13:31:54，"Jan Kiszka" <jan.kiszka@siemens.com> 写道：
>>>> On 13.11.25 05:00, JerryJun wrote:
>>>>>
>>>>> We conducted tests on the kernel version v5.10.245-cip65-dovetail1. The test results are attached. During this period, we also performed latency tests, which showed a 10ms delay at 7174.313414 -> 7174.323086.  irq 114 is net driver interrupt 。
>>>>>
>>>>
>>>>         swapper     0 [003]  7174.313414:                     irq:irq_pipeline_entry: irq=114
>>>>         swapper     0 [003]  7174.323086:                     irq:irq_pipeline_entry: irq=33027
>>>>
>>>> So, that is the gap. Did you also turn on irq_pipeline_exit? I'm not 
>>>> seeing that event in the trace. Furthermore, I always for get about 
>>>> that, it is useful to have irq_vectors events because those include 
>>>> timer irqs. But it is unlikely that we missed any in that gap because 
>>>> they tend to trigger activities like cobalt_core:cobalt_timer_expire.
>>>>
>>>> What is more likely here is that your hardware or firmware is not 
>>>> letting IRQs through. We could confirm that if the issue is reproducible 
>>>> while have function tracing enabled. That comes with high overhead, but 
>>>> the detailed result can tell us what the kernel did while there were no 
>>>> interrupts.
>>>>
>>>> There is also native tooling by the kernel to detect "hardware noise",
>>>> see https://docs.kernel.org/tools/rtla/rtla-hwnoise.html. Due to its 
>>>> nature, this noise would affect Xenomai equally.
>>>>
>>>> Jan
>>>>
>>>> -- 
>>>> Siemens AG, Foundational Technologies
>>>> Linux Expert Center
>>
>>
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

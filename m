Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDD1E32D3
	for <xenomai@lists.linux.dev>; Fri, 11 Jul 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217859; cv=fail; b=XUnQBOOPCLGNyil7K6r8m1Op6PpTogLS3n61nCwMvLjxOrZ0ReRI7Y6kgtI+5k9Se36VeRQvpVUxq0haR4kKXtayN9goDjZoa++ObnuqS11783wCZbTgvWkisaXbxmGSKoBekcXugQziEo8IrzIAdwo/C5RAssycgBHEeS6Iwp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217859; c=relaxed/simple;
	bh=tnEdPtZDtYH2fKchwSNoXeFPg4uprfofMgNq/heo2aw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wd7iUMWFp+eT+RiUfQRHqN/oAWJD1p1PUB+qjlRpwuLuyR/U4JLcus3cAYAeRo6WDRat6uqipCYJ5nQYQEQebu65go5N0bCILcSc9WAIc23E8nzANuvAFND5oIsFzHLRn/nOUqkLKCERk96DyhbCGpax5VhOSl6qWk7GaKHxC9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NdZZZn6Y; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NdZZZn6Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVv/RikQkW+wSSAcalF14Aoa2piPSbjC+T9PZaqqCJ0aOVz411ZE8464cKPaB0KWGHiPzB46kDbdoAD2Z2wMTdcXwW1/EA9iB5JpRu58J4powg+xH8MViOaAd9biuAQoN//kZhh46wYxvF32IEqtuZW38bRMVNi6ffLByPtZMtLz9fP89Gha/0vYgR819qtDMqj71pED0J+Z4LvOlTGSjv9inq7hK0zHRKpQWZ+RO0ReZIz3qOdL1VNpyRNCGqR0pJ+xqmcae8POd8wUNPo5Ol4wnFx6iW8ShsM5OH+xqyhJPTYpQ4ijx1XoLDyRNlFme2NEXuc9lfLWKX6yCewI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gue3cMCoWngeyzaj6ErDvxD0pKHw80vnrWV7ZhmcS70=;
 b=jU3ZTEMiubpmKeXRscKAgF1nDqUpLhuCf6dZAwVJMkEKySp0iffwAWvYO6NuYu0c6ngwITTvvYyJclL9uFtsrxICrZPCYO5/61ztv2wNsu0x5B+Bjmef6rP/Wp/B8cfVPs+JBCR1wWKxKaAbiyP37PH/Oaf4R1h2uYg1aWeZeoTclIOpo5B6yai/WImx6+/Ubt/COUZ+7l0gOypV5n4Jk974B6GTZlNs37GnYqU+OaZQyYy1aBwWFa/1kQ5MKw0GWZcfvldHrXREqdUdMkMMGDLklqBZ+Q1xWSjVdpNzQNdfMihhDrjSXajEXtrQFhzm6xKqxkmQuStaWi0dMH1nhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gue3cMCoWngeyzaj6ErDvxD0pKHw80vnrWV7ZhmcS70=;
 b=NdZZZn6YP8LoPWyvZuoOBtcOZ7vhjr3tqUdyp5Ocy5WyfytLyJp/bZ18sfqpQVtQGz2QGk2inxJvIZTJZZAI91OcJqrilaBr53CV5yXl8SMmX4T4a13K7Ra/ybazFYqpxtCG733C5X06d4y8uYUwCYZ3mRqORrJIOnpzBBHdfm+RVKlPi5BCGfoUdk7Y4un1axM8uE5hNt1YM/bWAO8RfpAcChQNKAoIF+sB4O6DqMnM+qLisxSfI+MCxQ/u8oUjBV2L8fOTWM3B8BJKdnCMYzsb/bR7rINRP5pbeQx7guqwMc36i65r0rqKPwtDNsd1XjpE0GjZlHwyqyIgexeckg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by AS8PR10MB6627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:563::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 07:10:53 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43%4]) with mapi id 15.20.8857.026; Fri, 11 Jul 2025
 07:10:53 +0000
Message-ID: <9d3a82e2-118e-4bb3-962b-9b11bb7ddb71@siemens.com>
Date: Fri, 11 Jul 2025 09:10:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Meetup at OSS Amsterdam in August
To: Steve Rosenbluth <stever8@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
 <343ed054-2d25-4e30-92ea-ff355bfc2556@siemens.com>
 <CAExw09CzR9UXe9y2a+YGtQ5Of-g2wP6hmNh4Y4HvyGgwHQ55TQ@mail.gmail.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <CAExw09CzR9UXe9y2a+YGtQ5Of-g2wP6hmNh4Y4HvyGgwHQ55TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0379.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::11) To AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:672::17)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8173:EE_|AS8PR10MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b1ce77-214a-4df0-2327-08ddc04a1296
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXBTcFdLdGNXUmNIRFBJT0ZIQjQ4VHE3cHgzdGd3bDh5R0wzNlJ1MHZvMGl6?=
 =?utf-8?B?YS9yNnRJeUtEQ0dRVDlYV2ZRU0U4QTJKcWRXbEdYL0dSQytmbWpqUFVGUVZ0?=
 =?utf-8?B?QW1tT3BWc2Z4K05zcGxSQ1ZLczVYNVJDWUUwTHVJN0t2Rm80V1FRS3RpaTJD?=
 =?utf-8?B?MGN0SEtVME52MHA1NEEwQlN0M3VoRlMxL3VDdVkrRy9YK05jWVJoRTRSeHVH?=
 =?utf-8?B?dUVtZElJckg4Znc3TnlxRFUzVHJpc0t0c09peXFQbUZVcENQdW5TWjdVZkRF?=
 =?utf-8?B?YzdCVVgvaUlLQ3VZVXNsQ0tkY3creXdnZ0Z1Z2o5cmh4T1Mvbm1BeGJXT2gz?=
 =?utf-8?B?MHcxMk5jWXozWUFQQkFGNGVLekQyelBTMUkwcHlKeis5NEhXeGcvWjVXNjY2?=
 =?utf-8?B?aHA3TTFUZXdTVkpBMXU3aXpMTkFRYTZkTmNYYjhiYTMxMWhySytoeDZ2YzBk?=
 =?utf-8?B?eEhxcERJbmxSZzBxR2ZCdmFTS25pdDdnTVhTTjZRSlV6b05oUHBCWTZWSEJk?=
 =?utf-8?B?V095bFRJRzV6YkhReW16QUpaczZkaTBBL3dEK0R2bDFjRFAwQnRTUWhyN09u?=
 =?utf-8?B?QStINGgvaDlBVjlPSGpGLzZNT3dEcG1oV24rK09ndjVzWFMrNElNNjluVHpp?=
 =?utf-8?B?YlJVcFQwaXdtSmExSWRCQnRJTDQ5cGNzbjRjNmtDaXFlbzZMRUkzRWE0Z00y?=
 =?utf-8?B?b0w2Um5VOEpCb2Y4UW1uSkwwQ1hMMEFnZ0U1K012NjB0U2xIN1IwaGc0QjN5?=
 =?utf-8?B?cjJ0dkF2NEg5L0krNDhQbjB2R3FZZDFCekE5SDUxR21QQ082RzQ0c1FOcUJz?=
 =?utf-8?B?cUtySHN4bzQvZTMwakRnR1NwTzMvZ1V2WFBYTWZqS3VSSFBCeU5uWGZ6b0dn?=
 =?utf-8?B?Q0pvT0h5Q1drbGlFQ2c2WERPNVJNUU1kT3BaQjV3NlpxUCt4SWRRdG1kcHZp?=
 =?utf-8?B?NndESVJadU0xTlAxc2c1N2NPMkxkdDVMdFE4MlBuRUNWWHJRRHpnWlJXVHZz?=
 =?utf-8?B?RGtZaWRKWElza1F1Uzg3VkFySUdRUGhPN2pVbHZVZjd6Qno3NUlCUFJrdThi?=
 =?utf-8?B?MDRkUEduci8vV1VOdHYveGJUOWJUZE16UTlqeldYbDE2MWJ4R21XSEdSZTRn?=
 =?utf-8?B?aW5SVXFWTmlYTGM1NnRwUDZJbEFxQlJMajRYdXVCZklrMFV2V2dIQ1M0VEkx?=
 =?utf-8?B?R2FwRUxLR2VRTzdaZnl1N3FhRmFKRm1MSnMvb2Y4UG5HMjQ0cVhlLzFqYWJC?=
 =?utf-8?B?TGpoOFZwT2lTUTlJMDZmeTYxR0lVQ3ZMNzAxbFEvREtidjRRbkRHR0daMUVY?=
 =?utf-8?B?MnkxRzVRd2RaWlNsU0hKaURaQ0ptVGlhUTNPbU9mc2dMVGk0V0hUOXBucXhM?=
 =?utf-8?B?d0I5T0Q1TmI3bCszRHk4UDZrSXFWMndPMng1UVpzZk80S3NwM3dZNFE3SXJz?=
 =?utf-8?B?cnRzLzdLNEJGMFlhbnhkT1VaVnM4bjZHUU0zK2JYeXBUVXlyMHR3c25FZ3V3?=
 =?utf-8?B?Mit4UjJzeGtWYXkrVWpWeXdBVnhnNTNDSUZ2dTRjY0tBTXdkcW9nZzQ5dGRD?=
 =?utf-8?B?bC9RTUFkY0g3UDd6WTVoa085T1FqdmdTSUtObDdHb3JHVTkvTVEvSEpZT3U2?=
 =?utf-8?B?U1JqSHFtSkdKSW5Sc1U0OVU3eGsxdDZZakxrT3ZMWm5XaGphanpsZm44REhC?=
 =?utf-8?B?NzhjbUdWN3BLdnZzR3JoMTVtWFhibHltdU9JV1JvVHorQUlVeHVrNnFucXpS?=
 =?utf-8?B?RVI2SHY0SU5zdmZ3VFduVW0xYXZHK0VPNmpLOTdzb05UcEFad1hvY1BpQVNs?=
 =?utf-8?B?QnBnZjhvNkF3VXRhaGYvSXk5Vms4L3R1N3o0U2tTM2Q4R01NdWo3eHBGYU1s?=
 =?utf-8?B?bUdtTFgrR1ZFQU9ib1kyTThkdWhieGZLSGlnZlhlaDlUamlGWVcrc0FrcEk1?=
 =?utf-8?Q?FIz9+fpp/+w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHRhK3hsMkJwZ3VlSVZKbWtmQVhaVDdmdVY2Nm1MWkNlcHNUam5TNTZmVGRQ?=
 =?utf-8?B?dUlKNFNiZEJPZDRibU8rcDlYQlpWWGJPYTFoSW5TMm5BajhJVGYvYzlMN293?=
 =?utf-8?B?NEtQb2JJbjQ3QW93dVphbW1qajBCUithdnZDcmI5bkdVSzloVENFTWd5TDNu?=
 =?utf-8?B?cm9SUGJnWWtpeVJSZ3N5S01YbER5T3F5T2FlM3hjNUNkRVdZbWFReHZDVWJ1?=
 =?utf-8?B?NDZqaVM2TDNYR0J4WFoxcXBzdWt0b3ovcTAzbG9jbDF0NnhueVpkUjlveCty?=
 =?utf-8?B?M2hBcTlXOFRJMnp0K3N4K1pKV3Q1TU1acld3djkwa2k5bzdTMy82RlBqSkRM?=
 =?utf-8?B?TGZxblFSaWFETzhtelFLamF2NzJBbUFNZjA3SGVhdTNCVW5tcVBGY1dURHZG?=
 =?utf-8?B?ZVpYWG5kTmhOZGNPZGowbmY5Y2pWaENoQ25NN2d2RWMwVERDeitwWEh0NVFQ?=
 =?utf-8?B?d3FrMzJSQTdDYVJSRkxOcVZhclhoeVpyaDl0OEh4V3VCelQyODhjZlY5NzJC?=
 =?utf-8?B?ZWpCWmJXbGJRaWpVRE1SaEZBWlFoUnhNNUpwMU9GSk9ZWmJXbzM5ODdJV3JD?=
 =?utf-8?B?SmZQTTJEd0tDdGJJVjI0eGVyTXpadEIrU2JScXVyclJqNDlMbG9lYi95M1Mr?=
 =?utf-8?B?L0gwNHNnVmxoZm9MQVdkRmsxRHNMaTdpcFpkb0tWWndJb3NHRm5qU3d0Mlp1?=
 =?utf-8?B?T3NncndTRkZxRU51YlRYVEtlZTZGcVBONDNJc1ZlWXJ1elpyTWhORERVbVY5?=
 =?utf-8?B?YmxaUklVV1JNeTA2bC9Ud0crWStUYWlodEFURTB1KzE4QjRLcnZST1pqQzcv?=
 =?utf-8?B?VkFOQnFQQTVYUmJGVzgvb2o4RDI2QjhpTlMrNjNaMWIzbXhHQmZ5cStXM3oy?=
 =?utf-8?B?MkhxQ01MZ2tBQnVWQVFsTy82STZvdC9QZFB2bkdhUXVhWFE4M2pXbkxFOFRR?=
 =?utf-8?B?UFQ0dmtzLytZWTErWUVOYTdQMk9XSk5ERU9HNk91MEFhQWdaZmZVZDRlWXZT?=
 =?utf-8?B?cnZkSk5RQytwbkJhVXorVWxETmxqc3o0NGVBeHZJdENVZERwY2QxWjVGUm1B?=
 =?utf-8?B?NER1VTZpZ2o2SE5OUE0xOXhZcEUrSE15cWR3NEpxYVZuekRQTDYxTC9YcnNH?=
 =?utf-8?B?TzBzSEp1eHpVQkNNbGp0bzRhYVh1OHR5MkZ3Ukw5MVdwV0x5Q1AyVWtzRFNo?=
 =?utf-8?B?VnFvZytKbGFSb0dzUkl5STFzb0J5SGRVZ3p3YW5Vc2NFOG9yUEZNSlNqbEZG?=
 =?utf-8?B?cmZpU05pUFhUMWFDaHRpREhRamptK3pnQjllQmZhOFRFYkw0MW9JYkoxNjIw?=
 =?utf-8?B?dmUxcitvb2YvSWtmU0NDZDFQUE5TQXBWeENJUDFSeG1HTnhaR0JKUEdQWjdp?=
 =?utf-8?B?NUhncFYzVGJmVHZOWHp4NjZTT0tFNjNHNi93K01Da1J0WTJzUjIxUEhIQlND?=
 =?utf-8?B?NUdIdXFTd3JQQWNZUkp4bmJNYmhLZ1doOGE4RlpQc0pmcTd3UEJmaDJKd0FJ?=
 =?utf-8?B?NXV4T0ZCMVVhVkEvQ1puT0lQYWJOY0tDYk8rT200aEs4ZVgxMmlZbC85WUZr?=
 =?utf-8?B?NStzcnVsb3RPZy9qaWJINlVCNUxIcFlGT3NFbnNMTTlGQjdtOFZmSXN0UE5j?=
 =?utf-8?B?ZGtzc3AwRUVHNmE4R0lCOUR4WmtjVDE3QjIvZTMzRGNqTjB4TWRvaHZOeVZm?=
 =?utf-8?B?MlYvdTd0L3ZFWXdjLzdEYjh1dXJScXVqSjdncElxQzlvejQybnUzdVd3OW5r?=
 =?utf-8?B?bWdxVzVURFhrb3pMcVRFVUZWczQ4MElmTitySUlZZ3dRM05nb0NBbGpSTGJJ?=
 =?utf-8?B?eC9lamwwMFgrcGJNZjlRYUZIenJWQWlmcG1NcTREd2V0SnZWNGpFdnJrQ0Jz?=
 =?utf-8?B?M0c3QTVISjRxdXlocVJRcFFaKytNZlJOYTJlaEtCK1Zha0hHMUZTTUh5elJo?=
 =?utf-8?B?Y3lWK0tXb3VrSE96OHhjUU9sTHhUcmhwMWxUdSsvTGZ3THllRFBHc3pWNDJa?=
 =?utf-8?B?N2laMDgvOHZiek5IYjNVN2FIa3RiekkyRTNiMm5idy9TbVdCYmpyVWRLTmJr?=
 =?utf-8?B?RTQyZS9NOTJ5bzMzdE1CRWdNS3NWVWtrcFdwd1dxWUtEc3BzU0xucDgwSndh?=
 =?utf-8?B?Si92RjJaU254dE1ZeVlJbWRxOEgzR1YwWGRtTUVweFJEVkc4VGhjdHZva2hn?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b1ce77-214a-4df0-2327-08ddc04a1296
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:10:53.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93uYQRs3Bvgj2SuNhaZCKgdexR8H95pUFFB5fj33sWqW+tQjqVU0gwH57jSVnZZNd75f+aeW8SWkKgmqAQtAM4PYJnh+TduYLDedbNIM/mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6627



On 10.07.25 21:29, Steve Rosenbluth wrote:
> On Wed, Jul 9, 2025 at 8:21 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 09.07.25 16:55, Richard Weinberger wrote:
>>> Like last year, I expect that some members of the Xenomai community
>>> will be attending
>>> the upcoming Open Source Summit in Amsterdam. If there's enough interest,
>>> we could arrange an in-person community meeting at a local beer
>>> garden?
>>>
>>
>> I will be around.
>>
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
> 
> 'Wish I could be there.
> 
> -Steve
> 
I'll be there too.
Clara

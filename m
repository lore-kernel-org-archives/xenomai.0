Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22F233715
	for <xenomai@lists.linux.dev>; Wed, 21 May 2025 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747812798; cv=fail; b=dbvVOAF5MFuHU3TgPAA+Yh6GF8WOy4B/hRx0w9zKuDg1hX8TLrxUniT+L5m2rML1iIYzDEMh1FR+lVK8qsbMibhzOy43eGIGveXrBzALeIBVcxHb+26ZqIfMk018UaTvFFqME0Qex2UwWxLdPlAupHk12PanjGrTZxepHloVJms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747812798; c=relaxed/simple;
	bh=XliEjvov6RCZtsSOu6HkBQpbtmZWbisPpHrwGw572RM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o1L04YS3msXURyQYvdgt27z32gOT1NA+xCl78SazsFZutkidZWTmpbJaq9lD0ujLZmXTcjEeHKw7th3nZuv50ngVXb2xSdEIf7LPHlINZS15lQrrvT8BpUeL2ma+QKe2LQ0f7txd9Jj/0eeeVrQlcKXPx3RR4CwgWT+D/lQCmnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lJpZfDGL; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lJpZfDGL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUNSgJTgsuGlTee/Ej4ki7SnSbWJmb1cX80Ly4bArJUO/0gh+tr/cOx7ezgsIUQxbr8puDQL/CKr+rypa2rrqrfXa1+YWZchj3Cvw3FXQ+s3mjNhagomrS6i93QQFeqH/T/NN4wpmATsaPVOWI7aSNnBJ3Z5evdVBW/GIxoVlhThWeT/1IgI8oBunKyZyzNu9jzprO88g8SdbaG68WPscy+hUm9MegoVe846lJK4Z7fgbZH8Hno3j4NKQjeXfvfMPoCi2jMcL5CJLBVejukQZyhP8Kx4XCR+YfBwHMsZ/WrjulyR2A7W3TjrhBZ72X6Xmui44zdANb6eFi4zxuy2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mar68agn8+xKN7uAApHHZD8OcZ0Siykjq86Jy+65O10=;
 b=PebKkFozlcdkCNOI7MjoYTuDcq7g848ib+AOZD/KaOMpU3OMy/T9EH8RtaePbzUbSJmRLXa9sl3yycHYvAz04+8/LjdA15VbmT+fLP1nwMfn7Mn2r2P9BdeJ28O872Ly7zwEYX7d6GoooTfac3lOnf3uGfvmpwS+A5gd6Bd+/Ui7d+WaK0aG6ALlIfkV//N9w3nHk1kL1Vj1MpnlObBTGZt3a9hyv1wuFoNn0GXS4oS+jbIPFfT/2dslwYJ85sx9zztWcYIFRG3VWEyHzQXAwaRGFUD/KRYq4NPbKgXr/EAX0fY0THQyk+whbD6MsdV/ploJZJJ4gp8HRZCUSQcw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mar68agn8+xKN7uAApHHZD8OcZ0Siykjq86Jy+65O10=;
 b=lJpZfDGLlawfuKqOOt2zmbV7uX95W3qUeA9fFrCni41UcTS7RBA06uFqIr1Hw33mNdt1Y3fQJSyhOej2AMD87ev2hohIaZ9JLutG46brePEXJOCCMnwkNEmhcmdkX/Gh89o9Iwlel5WpDy5/UPNIOEIxf7ARh/dfrg3cXpQcAU/6H74XegEimf0CX8RgkxErPb7tgiNScP4tPVmJX4GzZvdWC+vtZRqLFDvH7HuSvMW6vgV0lquY+0TyW0QfIqTF3ZL4Ge+Kc0xvCreSZ77kLMlTKoBlsG/5MmEKyXbYqjGAxDcLpppo6Efko4F4NrQGuTOvXAzf/av5CTx/YAtqjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 07:33:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 07:33:12 +0000
Message-ID: <f7a3e56a-8ccb-40ab-b3ad-65095a46fb5b@siemens.com>
Date: Wed, 21 May 2025 09:33:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Problem during Building EVL
To: "Xie, Nick" <nick.xie@festo.com>, Xenomai <xenomai@lists.linux.dev>
References: <1747773370-2401-mlmmj-02a615cf@lists.linux.dev>
 <DB6PR03MB2888B94A5AF1E5A82DD985368B9FA@DB6PR03MB2888.eurprd03.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DB6PR03MB2888B94A5AF1E5A82DD985368B9FA@DB6PR03MB2888.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3226:EE_
X-MS-Office365-Filtering-Correlation-Id: 649a32e9-5e6d-4e91-a4b1-08dd9839bdf9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmhFYmo2Sjd5RktKMmc3UWlxUjcyYnZyQ0RQSXhrMWwwNG5TemZGSTl3bWxV?=
 =?utf-8?B?YmplZFUydS83SGZRM2t4RmdmNTk2R240bHZDc2ZiMkZ3ckpGdVdSNTFSbmlO?=
 =?utf-8?B?cnpiNEJFRzFLdVZUbjJlUXhraWdPK0tvVkFIVFV1ak5oTjczakw0aEwrbEFR?=
 =?utf-8?B?ekFpbGVEZ2wxSE1UOStMaS9wWFJtQU5neWh4RUtMOVpqL1R0STlxb0ltSVZt?=
 =?utf-8?B?eFI4eThtR2RyRHp2Q0loNFc0dVN4ZHRpbnR4d3FJVkZMeXdrbjRFR2lqSWhB?=
 =?utf-8?B?bHk0K2F5aTVyUm9uRGpNSXFKa1JsdjFMSlZDWUo1WEVURTV3MDNVczV0d2ZS?=
 =?utf-8?B?anIyUXRsdUZxdzRMQUY5RHROUU03bTZLa0JPU2FvWC9OZm44YkxtbUQ2V3dj?=
 =?utf-8?B?dzdmYlhqU1lYT1ZnZVJiY2Y1OFBuVWUzcXoxZ3FLcnNBa0ZPNWhNTU5VQWpr?=
 =?utf-8?B?RW4zK2p2d1hNSURmTWJncXNlck5mSU1GS1RhdUdJeC9QVmVHWmo4dUl1QmRr?=
 =?utf-8?B?VGRzWDhEOW5MUjJHMWJwZUFtUUtUd1RHWi9GWDhYWkptdXpsb3R1eGZxWjRF?=
 =?utf-8?B?cDJIeTFvV2ZhbkNBOGVPK1dLUmdiRExlR1NFV0N2SnZTTGowRXkrdStINGVq?=
 =?utf-8?B?b3hEMzdOd29DY1REYWdaeDNpdmJvUVJTRlY3djc0bWZnOXY5a0VveFlLdE0v?=
 =?utf-8?B?NG9oZk1xS2VEQnJjN05Xc1BhMjJJSDYzNEhkWjI2MDBUdUZneTNwVDY0UFdu?=
 =?utf-8?B?bmJhYjU4V2hzTm1UOVo4YWZZb3VydXZNakdQelErMjJVem5aOHFPR0xCaGJ4?=
 =?utf-8?B?cklJbDliWTA0MWxzL2l2LzlPbElxb1dJOXZLSDh1c0ZoM1R2aWFmQ1ZDdkVx?=
 =?utf-8?B?YWZCVzF4ajREMzMrZkFrdEJmdDUyRzJkVDJwdWh6Ny84VTZETzRVeCtHVHJN?=
 =?utf-8?B?bElHb2pOWEt2VVFoVkdnWWZBRDlmQUt3eG1TeXBieGozR21QQXVIN2syNGVV?=
 =?utf-8?B?aWxuc2JRZ3VKdzE1czZ3V0VIdlhwTWEreFV0UDk1RHZ2dE0vS1UyVUphcnpT?=
 =?utf-8?B?TDJqQTJYYkdjbFR1eE02T2c2S3J3K3hLQ0RjcEhaRGRuN3dnUWlJa1lOSHI5?=
 =?utf-8?B?dVVDZVNSMGJkTDY2NENkZ0d1SnVpeWRPNzQwam1YWExiZ1hMK2ZHbFhoMEJu?=
 =?utf-8?B?ZFg1SjdMaHF5VHM5SlU3VS9zbnlJdFdvNmIyTUdNVENZNUtxQWZzd3A4TmVi?=
 =?utf-8?B?ZGJaSWx1WWJ4QS83V2xLTXZUVEovOTdiekp1c2VNVlBkTVlZbzE4V0hkSGdv?=
 =?utf-8?B?RnpyTDVqSHVYMG1xVVNSZStYZXV2Um1rTVVuMmN6MDJZWjd5N1ZreFFPRUJt?=
 =?utf-8?B?VnY2L3RFcjJOQXI2TUhtYnRVVzBMMHhhQWU3NGk4bW8rQmhmdC9yR1gwYzNH?=
 =?utf-8?B?Z0xCdGFXdnhnVlpxTWFjY1o5YnQxNmdPZ0xHRUdFMkNYQzduWHpNQkRUNkRq?=
 =?utf-8?B?TnJ5RHJ4QytUd1BRWENPcnRUbTBNTVJaTnFJd1BKbElCRVlMUG4rQk9BOFhQ?=
 =?utf-8?B?M0JUejBtL0VZOHordkZQbHJGNmhiUWpCbTZoN1drSHRSWmlkTXRSRjJ3cGpw?=
 =?utf-8?B?T0ZlRlRvRTRldnUybGpaWDFpWDkrZFduRmVid3kySDVMK1R0RVRvWFI5ZVVF?=
 =?utf-8?B?R1JoVkNsd3I4MEVPQXlOc21MS3gwbDhpbGRwZnVNNWxjaDYxMUpUMTNQS0lH?=
 =?utf-8?B?L0QxRi9ISWUyWFBZcUNTd1Z4UFpvSlBiSVI3ODlEMVk0dnNoKzhxeTRtWUJ6?=
 =?utf-8?Q?igA4RUNznvdjih6nvY543AjlJ9J9GQ0xhqUfg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEI3MzdkVzNiVTVLWXRQQ25wT3VEcjF0aVAvWGtRN0tuUXNyQ0dXaXBONyt3?=
 =?utf-8?B?VjFZS2d5UzNJcldQdDcxWFlrc1M3OFZjSFN0UnFQNFJjR0Z5bVRCMFY4Y1J2?=
 =?utf-8?B?ZTBFa2ttdFhWbUZ3MVl6Smh4cWVYcVlGRCsvcWcxd2VleXZpbWpHbEdIWHh1?=
 =?utf-8?B?bTlNelJ5MUk3UlFHL3ZVdmJrM0s4NEtiSzkvcU5tTSs4bXJLTkVVM0sxVHJP?=
 =?utf-8?B?bXpIZVVNdjZUOWpvZXlTQ2J4ZnZXWEVJcURxWjcxaFNQcDUzMy9nQzJibVgz?=
 =?utf-8?B?ZDhVb1hzUi9vVUpvZ2JyQStVSmVWckNma2tESUs1aEVMZVR0TXdhMENsYmdy?=
 =?utf-8?B?WkE3TDVKdDZPZThGU2JCanJzcGhXTkFsNlJUUHVMMHIvbUxyakxlY2RmcXRa?=
 =?utf-8?B?cEpLV0ExUkp4MWJrdTJzbUFKUVpBVENmMjFyTkxvSEpmWWlHZWw3TlNzSE82?=
 =?utf-8?B?YTZad3dEOUtZekNDanBtQVVUdVE5QjdYd2svNjZ6ZFhOMVJBcEd1R1N0ZE9p?=
 =?utf-8?B?TUJjeUQxYW8xbkJFbDhrS0RvQVVDaWZLVFM0L24vRmdYWUpEQ2wrOWU2VmNH?=
 =?utf-8?B?dmRjek4vMWdXaG1DaVdqU1B1YkRrbUIrRURYNE85QUFxUnZhZFFwNlIyOVJB?=
 =?utf-8?B?bDdNVUZDalg2aVo3T050RU9DT3Jub3E0bHcxYmR5Q2gyMXdEbGpYRUhwREVy?=
 =?utf-8?B?bTFCeUMxR0lRZVdrLytyRHAwdEdjNjVCSGpwZnF0bzZ3K3Y5UHNyRURFVnNN?=
 =?utf-8?B?YW9oai9VL2kxWFl5Um0xd2o5Q1M5NDkrVENpdTl6am9QZjN2aHhmNnZ6WkMz?=
 =?utf-8?B?Uk1vVkRZc0FsK0RrRDd2cXVBNFU1UkYvUFRHaXo4MWFLTmVZZ040SjFkYXlL?=
 =?utf-8?B?d0syK0Z2WTFvOWdZdVE1dXErendZT2o2N200eERHNVROeDF2Rmg5bWJnVXpz?=
 =?utf-8?B?b1M4OVZmTU9sRG4xVnJPZzBJSmJhd3ErcFB0OHdzM05ETVkzNU5PNjJzMFli?=
 =?utf-8?B?Zkt0ZFA2Tm1JUzdZTWMxOURVRzliNG1kTVFOc01hSkNxajRYbk42QjYyMUYz?=
 =?utf-8?B?dG9JcDJ1eXBtSERPcWdpa29hMTU0ckI0RURzaThvUGNadFYxNmEyT0dJVGVq?=
 =?utf-8?B?VnAwZUVRSjlqR1c1Z29YZzNQWUF5VmdUeTQ2TDBXQnRlN3hpZUppRDhtZjlv?=
 =?utf-8?B?NWJ5Y1EwalpQTmpyTVh2MjVuRERxK0JDc2d3NlQ5OElRM3lvek1WbmNsUFp1?=
 =?utf-8?B?WGZRVXZKTGszRDYwRmdRWHBKWDZPNzVZN1BaallyR1IvYzlPOHlnbVR6SDdl?=
 =?utf-8?B?UFd5SkV6YlQ3UVV5czdRbk4yVVl1dFV4RnMyOC9rREdCSjFjRlVjRkJPYlUw?=
 =?utf-8?B?MGZGQk8rSTdKT0s1cFZ3ZWpTcVpmNXFHQzA3Wk8rNUNPSUxpVHgyN2RoYVF4?=
 =?utf-8?B?WFdKcEZFcElCUEdpY0p0T1B0dHJzSVFHNkhvNmgxQ28zdG1SK1dKQWowWHNW?=
 =?utf-8?B?QTJvbGhWUjI1WlYvT3hObGFRVnJDZk00Z2tqUkNPT1BVSjNVZVIyQVJkYUJK?=
 =?utf-8?B?ZnJ2ZGFjbUptdGZoamdPUkRtSkdFUFJUQWxYeGFtZkE0elF0ZTUrN0xwdytr?=
 =?utf-8?B?VTAzc01SOFp5RmEzanFLMFpFdGVPdG5LZ3JDaHBPenlpNW9LNnlma0ptdnBu?=
 =?utf-8?B?Z25sRUhScFhvVGFYZjVQcEZKNlVGTXhxbWFzQ2Erb3ozMWxSWHlyM083SVpN?=
 =?utf-8?B?NWthNTJ4UnBDdGF5amJYN0dSZ1R1RWMrSStIWjNRYkxaQVVYVzZHSnc3OEZY?=
 =?utf-8?B?WVRwN0h5dFk4NWRqZy9OZTNHQzllM1ZHbS9ML1F4cUs2Y3NtSHhDN1o0Zysr?=
 =?utf-8?B?Vjk2cGtWSW5MWCtMbEhjMEpxeVFhWE9CUXNnWEdCVFhSVnpQSzh5Qk9KZFYv?=
 =?utf-8?B?UzN0S0V5OStacHVsb2hxKytpbHNCRHl4Nk0xQWV5MkVIdS9YdUNMZnRVQWF1?=
 =?utf-8?B?M0ViODU1Rm5yQlJBSXlUV1RDWG1YeEZNSXA5TUxMQlVsYXRHYnFmMFljNjlz?=
 =?utf-8?B?QVRGVFNFNXFRdVE0cnUyOEhnZzlOZVNuNVZwbXRQMFhjWUZyamdxM1p4Qk0y?=
 =?utf-8?B?c0dQWDRFdEppcHN6YUN3RmhwT2UxV3VJbUZRUHdhSDZZWWxCUnRtK1pycnpp?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649a32e9-5e6d-4e91-a4b1-08dd9839bdf9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 07:33:12.6195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5Lzrw8scCUrxhL4kzdUWclyUG9r/3m7S7zN/GRWMtn7gKqP+TbkQ080iM5Dm9TZBM73Uk6s2YaJpykjXs9VeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3226

Hi Nick,

please do not post questions to the xenomai+owner list and also avoid
the legacy list address. Just use the one linked from our homepage ().

On 20.05.25 22:57, Xie, Nick wrote:
> Dear developers,
> I am working on a project which control our motor driver using Linux system. This will require a real time system, so I decide to use Xenomai4. I can't find the "Enable the EVL core" option on configuration. I can't find the CONFIG_EVL_LATMUS and CONFIG_EVL_HECTIC enabled either.I am using a ubuntu 22.04 system with 6.6.0-060600-generic kernel. I downloaded v6.6.y-evl-rebase for this process. What is the new prerequisites? Please advise. 

If all the description on the homepage
(https://v4.xenomai.org/core/build-steps/) do not work for you, there
are also reference images you can generate via
https://source.denx.de/Xenomai/xenomai-images. Those are based on recent
Debian 12 and provide access to all recent stable kernels (6.12 is what
you want when starting today).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ADB186E46
	for <xenomai@lists.linux.dev>; Tue,  3 Sep 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378634; cv=fail; b=F2wQBXtN1RGoIfI+IjXkD6rCaGSrAQxMVYuQvsDatRXOUdBQ8VJGpJBTIfR9zyh3ebMFdrCAHaBGzB+p9mWu5UuheOHHYgARFASFvBuNpAu3MZ5Scpm+b+tHmFpyio69ZnhQGUOavYlDuJCNRtRGD4oEBuvrULxPUAWCRTAbqLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378634; c=relaxed/simple;
	bh=b5O56KrVoWsrow8vlCgWD7UCFxV6Xa9E9KcF6UZ3sEU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=od5Pg2cgFxCJowIBE5+Q61laGZNV4obqUdKLpTBDt8jSrwd5xy+vh7lqUKFHf+yaxwirSyTwpmoi3KNz/0fTYpBozLgpZ1hohO6WrcRgkMupMegMlPgHXKeskkrV8T4FPtRPOhQJNYWTHWRzWnplFjB2PlXKY43pw7dxTc1Rh/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=th0EueJ2; arc=fail smtp.client-ip=40.107.20.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="th0EueJ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CInuGKKqv5PKPLd1UN1orDlyh3XH3nEy1gSVHxtqHebGazEzEmVxxPoAtUk53Yt9pDRxbkU80q9SsDbkFVC/NGtHrPLnjOFErICmjmI0QAb491B0RWpKYDTWqWc8dGzBoOLSi2VbGAiUIwVOFvx+Hot5qtikrdvZt8UnLJT4OzhuRlFO4anAH+j/aShvI7/h0VYa0WGheYST31u+H17KncP/JFzBmd+yS93QkDwFijR68A1ll8aHh7L7Tw2xePZi+Z8F30iUY/Ablq+qNp6waUsH5ky1ynOPdYEHE0z3IIX2alZDDOvq8UD1TtL1MfP+FmxFZmQ69vqFKpM+1W95BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScDNLpxIWoOaFWf9Bkxq2bMgdmDV+8plCHEYGgZH6Hg=;
 b=UEVcOkQJhrkLw7DtZFhgy7mOR0m7ma+veKrjTbPHSckOq07+6s0uXfwrZiG41MQsV+SK3uom8iAt58R1iOfq8YgsS3gvP2VsORXRdQdVpbWkTN7hlL+M0ewWEfrvyv8c9v6nM6KwvLLN66/v+xPnsZ642dwZl1rDIVUPrWtkmOB/wwGkEI21ENi1M41h7CGcbkKY/K67zswn7heHt1S5xH1KSbiAOQ2OcOCny3hLOeekSnfn3/VW1e/h42MnT2AS52/54uWykJ7v/8E9nepMDPA73eAVzM+MULZPYhP6JYEeCj1uTO3AjMXO7uK4rGm9uqCapVsv0ivnCzaQTQtqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScDNLpxIWoOaFWf9Bkxq2bMgdmDV+8plCHEYGgZH6Hg=;
 b=th0EueJ2ZB+6iIh3l+c2+25PUhfjljPgCoCmqxrQNFXaQpQQ29Lgagw0BF4Wzr+fmPJpEUjmnMzQjlrz9bSQjzwK0rc2LumMfkfBarhOvquH9RUvt019Y3S8IJP4Aj8SV0/yCDuk8JiD/wOlQtqMPGqACZZ8otaktJuwzqSUDT6TfQ7iqZpIDyx/13XBJQtKkUuY+E7tE2r44Yyb9iIEnbd7l0ULMRvDQb67nRHvf7+8FXJo4GdaozdgzO8zaydGV7WtAK8TW2qwQIQbD7i31euk4cX40/HiDGsO7yQb57kC3SyK3yHU0fuwHRafXnCZbWw+E0HreT+z/9M2vxU5/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 15:50:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 15:50:27 +0000
Message-ID: <d80fde5d-b6b5-4c72-ad9e-ce20f2538a38@siemens.com>
Date: Tue, 3 Sep 2024 17:50:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dovetail: Account for invalid syscall number
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <24868b62-2aa9-4f06-a20a-c1c0dc2ba164@siemens.com>
 <87h6ax9kwa.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87h6ax9kwa.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ece6ff9-3a87-48fd-1b99-08dccc302148
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXgzR3Flc0x3MlpGVmR0Uy9FQ09jMHhwWXQrSDJlOThCcHcwRTF6VGw1bUpj?=
 =?utf-8?B?dU9qNmp5cmpvYW42UjRNUGx3bkZ5UWlkRVdYRjZQMzVIaTFBcHJiOVVDZnJ2?=
 =?utf-8?B?S2dDNlVObHlqa1lZNTAvUTUvQ1I4RjRSWHlScllOL2xVM2VOaFpxTjRkaHBj?=
 =?utf-8?B?d2dlc21ackprRmxlYjIrMkVmdGIwampYVk1HdStyYmJwcHN0dks2UXB3NFZU?=
 =?utf-8?B?eDgvMnVjcGl2ZkhwRFRYRGNRcDRNdXFGaURBaStJQTFSYVdxV1htK0xXdUdk?=
 =?utf-8?B?elN6cGg3VjlqSEtRQm1kcDVPRzByVnREYTJpZHlNaS9XdGphZWY5cVpZYU5j?=
 =?utf-8?B?eExKWUd6eXNmTGQ1RGw5TlpxYXJnME9mK3VYYzU4dGlnODN1eG50QlJwZTBR?=
 =?utf-8?B?STk2UEs1YTVyM0tzNVduYlJKbm1rN1RVR3EvbDg4R0RBdzlhRGhrRXBpeFYy?=
 =?utf-8?B?eEJUNTYva1dkeFNQZnhXTFJMaERlRCs4ZnBxOUhFQTI0Qmw1TkNQVm13SzNY?=
 =?utf-8?B?Zlc2ZEUrNlZrU2htcXBZRFdDMm1wRnF2NHVBZkdCSTFMQk91bEFlQzd0ZmZC?=
 =?utf-8?B?Q2JCNS81ZDBtSzk5elhIdW9RanM2UE1DdENYUXhVT1lpQTFXVU9oM29laDc3?=
 =?utf-8?B?R09MSnBlYldCcm96SFZMbXFia2ZrbHFxVVpiMERtbktZMGU4bFBBMXFkYXNV?=
 =?utf-8?B?VWlPaEExUXhydlR5SGhSZUhlb3ZCN1F1cGlTTW1NeTNqTGd5dEFWWDB5NFY3?=
 =?utf-8?B?K0JYQkk3Q1pESlVZK0lDU3YrOTYyWVI5eHhvSWFvTTFtc2dFY3d3Qy9SckV6?=
 =?utf-8?B?NG1tREJtSGNtQmg1TEVxS3YyejN6NktvK2tXV29NZzgvZ2c5SVZiVTBmODky?=
 =?utf-8?B?RHNGV05VZHc4eGNHQnpKb3JObXJzaFErWVdiT3JDbkZpcVdyWHMrUnU5T1E2?=
 =?utf-8?B?aHg2VElkb29EaXd3bnZ5ejJpa0VRZWc0U0V6bHdwTmVlYjhZUFFTSFlLc1Z1?=
 =?utf-8?B?V3B3TXQ4TWk1bjFWei9ITUswYkl5anozVlRsOCtRNlhWM3puajZtSDgya2dX?=
 =?utf-8?B?dHJTaDA1TEsvbjNHaGZuOW0yTDNzeDVuMy9CUGFXd01WWXhoOFZUd3NRSEFq?=
 =?utf-8?B?UkZGZGVKU0I0VWNaQ0hLTjJQaHE5NENpWjF1K2F1NzA0aG52aHN3eWVsRWVt?=
 =?utf-8?B?VHBsWmpEUEJ2OVZqV0UwVFBVbzF5ZG1OandlZ1V1ZnFRQXd6U2xjOVBPaXht?=
 =?utf-8?B?My96ZHBRaHFrckJIaFlsVCtHMmRpQTVFRzBSMnFwdjJldzZLOXp6d1ZhSUJs?=
 =?utf-8?B?TXY1cFA4b1UydnFGbmhwOVVHcjI2cjZrWHYxN0w0azJPaDRvMHNEODNiQnFS?=
 =?utf-8?B?aHNFa29yWWFsdjZSYTFCbE5GR2syc255Ly8vTjRYdzUxQVE0ZnpRQ242aWEy?=
 =?utf-8?B?NUdrKzVSNDFhc2lqK1JLc2huUDVCaG1SSVRZNjlUYnFOZU5VQm5Dbk56Q2Ew?=
 =?utf-8?B?Yjh5WE1Hc2g1dHVIN20zUmlKOVZFQVNRQWg4aU9VYjRhcUUveTBMMVBJMmNB?=
 =?utf-8?B?dnFpTmh5cEsrdXkxeFd1Y2N4Y2FXOXNrUnZvYnRCRDNhMWZtTGNUbEhQa2R5?=
 =?utf-8?B?TkRyMjNpUjJ1NFZjVDBwd2hDZFE1NFM5KzJmOEN6SDU3ODRGc2xsbktSZGRB?=
 =?utf-8?B?TnNZM0JvSisxUEJtTHJ5TDl4aTd5UGFHSVhEYXZTeDBHdEFxUWgwZmNTZWsx?=
 =?utf-8?B?b2dUNkRYeWwwb000RU9Kdk9LYVJ2NHdGVERRdjhHYWRsTTRuUVVvVjcrYXBH?=
 =?utf-8?B?dG8xa3ZsSXdZb2txRXdidz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blRyOWEyakdENzVkQWxhRDJkVk5abWJLeU9RdjlwcUZMOXd0L0hmT1BsYStk?=
 =?utf-8?B?VGEzK0pyVGVJTWV6UW1HelVaUitnK2wwd2UrUS9xMXkybUZLT1J0emhhUXlI?=
 =?utf-8?B?QzhtYjNQZEx3UVlqRG5uMG0wSmludS9PNkxteXRQTHlXZHZPODNhN3E0V0U5?=
 =?utf-8?B?OUt5VXZsbWg5RG9sU21LRk1pczRRTUtFZ202eWQ1NnlkQ2RGdFA4TXUram43?=
 =?utf-8?B?WmU4dUlPMEdyY3lXazZ5L2M2b1FVVlE2TnBLWGV4bTQ5QXkrNXpzcG9Vbmtj?=
 =?utf-8?B?WTVKbHBia3Y0RzI5SG9pT3hZVGJNalkxQnQzTWEyMW83TVYyQ1JqdDhjUUxo?=
 =?utf-8?B?bkFhU2FOWThSYnU1N0V4Z3dTNTFiZENQY1E4V25IeUhPR0lZT3UyUnBwcmls?=
 =?utf-8?B?YzQ1VzJuR3ZwYU1wSkVsb0V3ZEVndlpLTXJNbG5EbWpRa3oyc1pzektYdHFh?=
 =?utf-8?B?bUQ3a1N1T285Wk9LY2FLVzBtTm5ZNEJ2cms4N0tFTk1hMEdLSmw5NDNlVGRY?=
 =?utf-8?B?R0VtVXdja3VLeWV1cFg1Y2liMGtkTFNQZktyS2hnTHFmYmlhR2RldHltaUNH?=
 =?utf-8?B?RUg4QmpXRkJrenR6WGd0dkd0QU4zZnhnOHJZc3hpK25rUGFFQ0lnZGRmcGlX?=
 =?utf-8?B?dndyeGdCT1JCeUZzMmtvNy9FQjFWempkV0FQcjEwSytCdjYwZlYzOU90MkRV?=
 =?utf-8?B?TUp6ZVRSUFFZQmdZY3FnZjFwMWh0bGJMUUxQU1dhZkpRRE13U2ZrUG1ycy9I?=
 =?utf-8?B?YVFJTGEwaE1MNm0veEo3OEN4NldDWWtrUHBjb0x4eExxSlVTTzNHZVNVR0VM?=
 =?utf-8?B?VVQ5M3R6M1h3N2h2eVcvRWh0ZzhuaTZLZ1dMVGlOdUpLY3NWK2RubzkzSnU0?=
 =?utf-8?B?L0g2cmpuVnV4YVpMOVBaby9tdWZ3QS8ra20rNGFlT1BEREZEMjhoWWhxWTZq?=
 =?utf-8?B?WkRPOUNtREdkMVU2dWJxRHlYNHVVQlF5ZUl0TC9nWmlIcC9weU5uWkkwZE9U?=
 =?utf-8?B?TS9nYldQN1kvN0N1bkVpeXVwZmk2MmJiU01XU2RWMTNTUVNQektjRmlEQnk1?=
 =?utf-8?B?eWpKeUVDSEp0RmI5d1p3bCtOMTFaU1dua1dEQTJkNnFVNnYzTnZGbm82M3dj?=
 =?utf-8?B?NktyWVh2ekdIb2VHcEE3aEZ4dGNFMWxCOEVoMjBuVnpYUzYwRzZNK3lRQWJ4?=
 =?utf-8?B?RXlwcThRRDFOVWJOTEIzZjY4VkJLQTdUTTdpR041bFc1cjRLYlR6UGVLTExQ?=
 =?utf-8?B?R2tPQjY1bEt6NVM5bTg1eEt0ZXlVeFFmOEowK1IwU2NoUVdzU0kweEpBbFB5?=
 =?utf-8?B?bWFybFFOa1JLQlhhdXJjdENGaEdxWi9wRnBDdU9aWU9NQU1QMlM0SG9pSUli?=
 =?utf-8?B?ZzlZcjQrZDRmUzhXRERVUEE5M0kreU9RUG13dStEOEcrSllNWnVVSTY2dmN1?=
 =?utf-8?B?NWZGZCthdDBHWVRuTitOTnRsNzJZNHF3blJYbXlKNUNiendRMkJHMVg5UUl5?=
 =?utf-8?B?SW5XdDc1THQvSTdhaU5vZGMxbHkyTWQ4dHM4RHhFV1hMUW1XQ292c3greTR0?=
 =?utf-8?B?c2xLV0JqbjFQY3ZTMVdLV2FScm1mYXJTVkU0MGo4SzF6cWxCRmtQZnQrS29q?=
 =?utf-8?B?N3JsWjRscVMvalFqcTJBUUVMR3FkKzBPZmpoNnc4aFpZUGtkci9QM29yWnBN?=
 =?utf-8?B?QmM1TnpwUzZURDBTczdycU44eXFpWFBmVTRFS1RjVnR3ZnNoZEk5OWVYaTlk?=
 =?utf-8?B?b2RMOW5jMzM1bmNkRWg0NVdGamdVaXEwS3p5L2xTaVN4Z0pra0JWSUVnNGtT?=
 =?utf-8?B?RVVrZ09OQ3c2cGxrRkhXOE5DUW1iWVc4VU1qdzAvaVoyZUk3cWRjZ1psUm1X?=
 =?utf-8?B?VzlpSkhBZ0hmeWgvUGxRRkZYdlFuWFJFSmpsYi9YQUJuZ0FaamRMTUN4MXN2?=
 =?utf-8?B?RVpaQzh1aWNIRXJtUk5Kbm5iM2w1M0pYdkQ5dE5ydXhXeEk1NDRFUW9BTG54?=
 =?utf-8?B?ZXk4cTlFSEFVanllbGNUUnFHRUVyOFdCdkhpYTJ6Q3l3ZDBMZEVnL05YUi83?=
 =?utf-8?B?QmE1ZThHRTZFVURjTXdPNGRHYVVVb1QwTUpYTUZmN0VOWU96cFRWZE4zQWFS?=
 =?utf-8?B?ZmVPdFFHTjlxWVdJYVVJR3pTMno0YlZPcll1MTB5bGFLbkhxdG04MzR4c0F0?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ece6ff9-3a87-48fd-1b99-08dccc302148
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 15:50:26.9706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tk5IMUI2ORmlZVy01YBd2Fj5mDU2iny3PkvkrWAU41HS6AzeKSVa6xlZYPU0DRu3L3XL8UoZYIyPdddGTfYesg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5737

On 03.09.24 10:55, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> At least on x86, the kernel may have decided to invalidate the syscall
>> number while processing it. Avoid that we process this -1 as legacy
>> syscall.
>>
>> This was a long-pending issue in the whole dovetail series, now revealed
>> by running auditd on one of the test systems. Syscall auditing was
>> eventually catching an unbalanced tracing, caused by a premature syscall
>> exit due to this bug.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  kernel/dovetail.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/dovetail.c b/kernel/dovetail.c
>> index 08c649d6e9d9..bcd49183f8eb 100644
>> --- a/kernel/dovetail.c
>> +++ b/kernel/dovetail.c
>> @@ -119,7 +119,7 @@ static bool __in_oob_syscall(struct task_struct *tsk,
>>  	 * a PR_OOB_SYSCALL command (new/current call form).
>>  	 */
>>  	if (IS_ENABLED(CONFIG_DOVETAIL_LEGACY_SYSCALL_RANGE)) {
>> -		if (nr & __OOB_SYSCALL_BIT)
>> +		if (nr != -1 && nr & __OOB_SYSCALL_BIT)
>>  			return true;
>>  	}
> 
> Merged into v6.1.y-dovetail-rebase, v6.6.y-dovetail-rebase,
> v6.10-dovetail-rebase and the upcoming v6.11-dovetail-rebase.
> 

Thanks - but not yet pushed, I suppose.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


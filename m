Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643A8446831
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784112372; cv=fail; b=Koxb6y5H26g/I2xwpnsaYQi8ayhZ6MWhI0pZQCAwIk1yfdADlqct2wBS7GcfNKraRYz7YgigT9Qj+IzI+q2jcEUP0P29wbnK1EZonkJr1VhGpnJYNKraucl+rIe1lzvXbXGgXLQqzAEFm5Ws78/PgRbANEyO0I2wSbCg36oEkbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784112372; c=relaxed/simple;
	bh=O+EngMZfIl+xjkI3UmkzJJHew+NaQ+5aXdr72l005qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qx7VONdAdClrvRWYkP5KL5RZabG+NPnm5GUsjocRdku+BFxBBnFqD5b7aRMheucDgaiz1TNyc4Ks97oD57QNS0grUpXAFCHN54Ztv/H4r51vQ6bUH2ne7jm9su2PMXikct9vFrhv2HjIJIFsLQmeDuIsE5Y0mnKG+Mpz6dVI32w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NzlFWxJQ; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NzlFWxJQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MC9gLwIIAze4qheusn7cBA3mYAhWT/46mXHn/GHiO2QfzRwp6PV7u2wWVjPMOQfMzl2oKhiBidzCvwpX4rarADUFbh0qmaZwHxsWclyjiNYzrnQA6PK6WF8hnB4I85nq4sGqD3kRtbw9AMnjvqIjz1VQU+obxk0pWyzk4WPtYDCXN7CmVC+gJIeA+PdMW/cUTJv87yZJv+98tvhW2X5R7/wY8GMBtzQkJK1cJsrdim1RKyiDsmTLQAZV9p0LY/xFHkK6oLaUDSYhe40DBrYs6viA0TX4deIRrDQtJ6q18ZH1mDx7c+GYXDGiCvu4UnpTW82dT/kMZ97Fc03wI3TpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED2tp/virmo5ojjSPkYjcpxALiVw93ngppcNsQrnC0Y=;
 b=yRKnAOYN3E+Qjly3RFEtF8ib3U+bdwCgEn52qaQkYhJGLSa0zEC7QSvIAPDsG2V5Hw6ZTrrGijARe7MrE0n9WXddde2ghfYLaP3kgKsUchSKdwUS+6VdNoYtqn/H9j0FQWG3/Ie+vxqLBH/Vaa2z6WBGb9zngwOf/t3dOPnF/oDuFRew6tOR+/yq9/RSCcCRJPRjX45m+DYqBTJOGHfbQDBaAABm8OHcBpmfHn0mo4eMhqTIxi6s+GUN/+VNatPrOwegpFF00E9mI5vgARl8iCdPTUh94pSHTKYv+farWuAnWLsm37H8GPkDuLp1f4DyI2EkBu3/VFgGJRXacxy12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED2tp/virmo5ojjSPkYjcpxALiVw93ngppcNsQrnC0Y=;
 b=NzlFWxJQJvgJoFOUzulgHMSfRlXYsme94urwzdTj/G2ibsyoPpu4wVFV4iknYyJ767y6ZQYa/Vpd0QViAMs/851MwCNSwU8uLdu1IIQciZ7jtvOkmJvwjy37FGp2+6Tew4uBewNq7tPsRtniF5cWRgtidvK+M6AJsrb+SeYnom8uM9mAuvAdi9qzaLGrbvUObASyxD/EHX7A9me+8WNU96k2imP5v39LaY77uuui3K4YMPWhntcwE+TXD8fjCvUdwnaGfJ1L0VQ80BNLcFhuRm/dwukDRKmxItjosyGkc+UyvZOPl1Noe+R/6TzgPOpCNjXafRwDCMiltcCdSiWnYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM0PR10MB3330.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 10:46:06 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 10:46:06 +0000
Message-ID: <e90a7bb3-c467-413f-ab7a-7266079808c9@siemens.com>
Date: Wed, 15 Jul 2026 12:46:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images 0/3] longterm EVL testing under load
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260715092822.223712-1-tobias.schaffner@siemens.com>
 <f8050b7f-6866-4075-bb2f-b752446a6971@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <f8050b7f-6866-4075-bb2f-b752446a6971@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM0PR10MB3330:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f74ecc7-d024-4ada-606f-08dee25e45bc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|376014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	zvG7mPqL0f5siOLREMqBiX6mh6XQrl4lZLYDbZ4A6t8Hwm+5hU4/zjV8wWg6k63zJzQEaEpZqDyNVYTZhKIxbLnRsSrJoCmW47KMMpnc+VRoMx+XLPzuItC0VPD/NA3E9tHLRRgO0QnAIczFJygtebL11NSwTFvUeG/FTOTFFqolxqfRec0VnkrpoY1OoqOTXX8Z5AvRIXePQth3a1G+kxGPuAH+OxYFxXhazvM3lkOhGO1YYz3zrwWUbG5MBVK1pOAflQEPSP890S34+7TvTXPnbuqwRbR+Wa4FbpH/bA49h6i8umQjlrNmn36MvQkq5NINy0HlO4AJSY0Umph5mfdLSRet3591HQ9abMraUjZLQjK66Cc/xzILM4CYfNyqoXqoKPxjqZjzwpsQ8WH5TejhlnZuSIxGl3KLxG8e7jEpzWS8eh3/gCJo9jJE0NBv5YLOAcKJydzIk/k2H8aueVskxU8hY8FP4tcIGZNG2HuH4QLO7ExMCkHGIdLC9X7FzvtVS0RE7ne1BltTnxmRhOFS/GmVZkcWJ/axje31HWFiZyPxx5D49rp6KjRMOU6pgU0Zgm+MrO6esuZpW64P9V3bra7uirE5CJEVGOdJOqQmoPv3AdDlew7D2iIbkg3SUWCMddxyUxHpLzH/d+/xMJlcE0EQ2ttVXi2qtw09MBE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHZ5anlDL1BYSEV5MDBuRVFBOU1ZS0RFUHl5NlMzUFZNNFd2VWptUHRkWUVj?=
 =?utf-8?B?Sll2RXFyYzl1N2E1VXpFZW9FUCtPR3Z2eEhlQ2t4S2czcXVORHpMR2RWL21H?=
 =?utf-8?B?RXZkeEhPMXpNUkg4c0FmUDFienphc0krL2Y3RTBrVExveVZuc3lVcWl1K1Zr?=
 =?utf-8?B?a2NoTTdodUs1NU9TTUJwdHplTm1idTloRXo3aEVSdnNlV0t1ZW5oVWxqTkRL?=
 =?utf-8?B?OGdUTkFMVmh1alV5YzBaTVNaQnBzWE41Um5wN2l0NHY4THN1V0RoMFB3WjVo?=
 =?utf-8?B?WmJEZmpQSkZBTUl1Rnh0UWI4eGU2SmNsTE9tdm9uRjIvL3JsTytwWDRpV0lE?=
 =?utf-8?B?WnRKSU9iYU16cURTYWhndGZIYXNHMFROMUVKTkxMSWQ2Z3FYWGYwRi83T3Jw?=
 =?utf-8?B?VUNHejVKQzdvbXZhUm1RYlk0VjFjeTJOM0FCYXFmeGM5Z3NOS3hubmNQOXJi?=
 =?utf-8?B?SlZUaFhOdWQ1MEJYbjhmbXhDdmdJeCtNeG1qT0xqMU9pTUJyQzBLeWErUEVV?=
 =?utf-8?B?SmsrN3ZMVjIvdTdNdVNreEdEWHlHZVMyU3FSVkxkSnpialdVWHB2cjlHc3hs?=
 =?utf-8?B?QlJFNElNZ296TXdVeTkycmE2eHdFdFFkMXZjMi9lTVpxS1FjdUJBMUZxeGM5?=
 =?utf-8?B?UG9IMlgybC9wWktZcVU0QlZWSHRPb0I3YnZoY3RqU0pQOEN5dkxWR1kwYkRR?=
 =?utf-8?B?Zi9PV1YzM1dMTStlSDdDZVU2anVJUnVtTll4THlPclJXRlUwNHA0eHczNjRT?=
 =?utf-8?B?OVVnU0U1STQrcHBpRFk5NkVhcHVHK3FtZHpNeDMxcm83UEZsbnQvVGxHWm9E?=
 =?utf-8?B?bUhxNWJrQnVlOXcvcVIvSndXZzZiYTRJZ1RRRVROdGRpZEVibzl1R1YzT3dL?=
 =?utf-8?B?OUEzVGZpcENRaS9iQnpWTWJUa091bWFwQ24ydVRMaEJnU1VYUnI4eDhxdkNz?=
 =?utf-8?B?Q2NnME1kaDhKOGlnZjZqRjBkTEtpWTA5OHRLS3FiVUU2Z05zeHcvSkxsOTRD?=
 =?utf-8?B?eThTcmNlRC9PUklTeSt2N1pxSWlHYnljanFSTitiSVpQeFdQd0Q0ZnpJeXZi?=
 =?utf-8?B?L3VNeVB1bldFejE5VWJSUTFLV0Z2d2kxcmlnZG03R3JPWVN5d2RONHZhMlRO?=
 =?utf-8?B?RjB6MW9jWTlDdEhPRUVJWnlNVU00TDBrM1RzSWdYU3I0d1BScjNVa3FBdk1N?=
 =?utf-8?B?YllVUzBMY3pvOEo4Mm9lVUZNZjVHSUpxQXQzK3dpQ3d0N2IzUGMzdDFyOE5a?=
 =?utf-8?B?OHJzQVV2dk5HZmNoRFJuR09qdmpvNmFPY3pqTmlHSHRNN3hMV2JCY0p0N1Z4?=
 =?utf-8?B?bnRGYXAyS0NtMnk3Z0p0Nzg2amNoL2VtRG13WE5DZjMyNW5abUticko3WDlZ?=
 =?utf-8?B?K3pVWFQrcm90ZWZnaHVHWFBlQUtJNE41VzVOTmJ2WlAxYUhWcHhhNnh4OWhm?=
 =?utf-8?B?UnBIMW13Nnd4ZjZ2RTAvUENURUNOaCtDVmxoeHNVRm9UdUh4elFJLzZTZVR1?=
 =?utf-8?B?bm1qVWkwYVAyRnU3ME9EbldxQS91Ti9CZXVQUCtXMStUaE5zaXg0VEZ3ZGFG?=
 =?utf-8?B?amxjNkRpYzE5K2hCOU5YckxMN2FUTFVWK0VNYXBHTEJJZ2FSVW9aZEYxTSsv?=
 =?utf-8?B?cis0V3B4YzhjcFJ6dE9OYzZocHE0enVDSmpMQ0RVWGswSVR2MnpDdS91MjV1?=
 =?utf-8?B?eEhhNnlTSnE1WWNEd1lSZE1WaVZyWTZ4UEExMFhCOTNNTXo5dmk0U3hrV1pk?=
 =?utf-8?B?cnZCY0RrU3gzekw5NVoxRTBwV1RaRXo3ek56Z1UvRWZSR2V4ZEJUNW1ySnZ3?=
 =?utf-8?B?d3QvaGppOG5kSk95aGQ5SGFXLzhpMHYvQVlUTENzVkRnaGE1WmJPTnF6RzMv?=
 =?utf-8?B?aFZtUW9UQVJaMGd4UUVBMXpKb1JjMFZjZzdHSWh4ZUpLa1NEeG9CRk1rNjlI?=
 =?utf-8?B?eTkzZGJHMkZjWDF3a1dKTzNMcWJ2MGRjOHJsQ1Yra3BJbFVBZFZIZWd4WmF4?=
 =?utf-8?B?MjNVZzBWd01FZUxSZzJFbGlnckJOUy95VyticEF5RStwNkFkTGx4TlVDUnRN?=
 =?utf-8?B?dU15M0lKZUFmbHBOUC81WUFVSEc3by8rNUh5bWhqQzA2RDUycjAyNGtBc2tJ?=
 =?utf-8?B?RDVXKy81UVlPc2Zrb0I1RG0yUWhjRzNUTHpTTmNkMkNJd09SZExmODVnWHV3?=
 =?utf-8?B?M0tPMHkvRlFmZGJwZWN2TElxK0FYQVVoOEphQ0tCR3R1UXorc2g3R3NVZG4z?=
 =?utf-8?B?S1BFK1BhN1IvU2ErWE91RVlRMHp3TWdHUCtUWWxIamN6SEs1cDR4a1ppODBv?=
 =?utf-8?B?S1U4ekF2bWZySjFaTTNjSzRkM21jblhHT2dtU0h4MzllMjgxZ2E5di9HY3NI?=
 =?utf-8?Q?YUGyfQTbfVhCSN9NdNuOd7lq4xTiYGhgbcE7KRqoCevfo?=
X-MS-Exchange-AntiSpam-MessageData-1: NX1CUsrFwhKeYGcffvhZk6TYIWB4IxWaBsI=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f74ecc7-d024-4ada-606f-08dee25e45bc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 10:46:05.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHbY2USmd+Z446mI9xiy6wJWAO4KI9FNZH+fCCj0dQz7SeoS3786ZW/kLgov0cdj6P/pfQI9y6XQtrUg6oKWlzHiphBqwS1j4XV7qB3r4Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3330



On 7/15/26 12:19, Jan Kiszka wrote:
> On 15.07.26 11:28, Tobias Schaffner wrote:
>> Hi all,
>>
>> This series introduces EVL test runs with additional stress applied via
>> stress-ng, as well as long-term testing. Along the way, I also updated the
>> long-term kernel under test from 6.12 to 6.18.
>>
>> Please note:
>>   * The clock-timer-periodic test currently fails as soon as stress is
>>     applied. I proposed "tests: skip clock-timer-periodic on virtual targets"
>>     to address this.
>>   * On the Raspberry Pi 4, even the 3-minute test exceeds the latency
>>     threshold with debugging disabled:
>>     latency threshold is exceeded (150000 >= 163.951), aborting.
>>     https://gitlab.com/Xenomai/xenomai-images/-/jobs/15353275174
> 
> That is 150 ms?! Sounds like a real bug - unless we enforce some thermal
> throttling on the hardware. But we haven't seen that with xenomai 3 so far.

Also looks bad to me.

We seem to be a bit worse than the Xenomai 3 results. But the results 
are not great on Xenomai 3 either.

Xenomai3 Kernel 6.18:
https://gitlab.com/Xenomai/xenomai-images/-/jobs/15351736635
WCL: 123.148

Xenomai3 Kernel 6.12 (last weekly running long term run):
https://gitlab.com/Xenomai/xenomai-images/-/jobs/15308563317
WCL 137.195

The oldest Pipeline I was able to find is 11 Month old:
https://gitlab.com/Xenomai/xenomai-images/-/jobs/11042799343
WCL: 124.430

Best,
Tobias

> Jan
> 


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794419650;
	b=jDkmcbO/fjTPVyufGBBBlDTgz0ki7WfS/44MTzncAhfFXMm6SXwE1SlwM2bMoyiqqzK7
	 pdKIhXpXmcHSr+iB37OHO4ss4AFslgZ0gq/ixaUz/Kk21l5eLSMmuPDMkb2i8D01O1qBH
	 mnkDukaPLUNzVzKfz4lGarR01/FFARsk5l5BDSXszpkyjgJf/hAIVZH4VepAoQAXFZSbW
	 AFxOoUeF4cYZ+al1edj802KF4Wt//pt+rH+PstWrkNN18sUlo12EYvWoi39OBYVOGTt5K
	 rn+Vr3Vt+kLORuOvfWSXUV8MZUyx8sKOhPUpXkAIoKfwZ8SGNgU42V7uVINiwfgX9PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419650;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3FGC3EPSxTfr2btYVeAlSNZ7D2asNUUVKNnHLfthGzk=;
	b=l0kjNKgBaP+QC+WoBzJUfQv6HRP9RACKtJRb784Ed2pVsMGBy/0Z2ssHm97uL6ssjWVb
	 rJd6lOnG3ScCJAZEr1hkex9IZb6C4BwtmgpRdSJ2aGxAMW6kgZrtZ2F708hHGkMdtBA8T
	 fABMRUCHRbME1Y/fXdhbFX5DqWkMJHxuxGpfYR5PE1Lqov5K4OldrcFvLeh9b+Jl2loin
	 dNgVm3XK7ngbURG0LgT+E4mun/IOmdhDuRIkfhkdiIKxMm3Hv0q02WYy0+/EYG6cQCH5M
	 lBVqat5og9OdN8Ds+0a8k/oNdw2iASj6EJx4diOL9e6Dp5XExBp4Pdcbhx7a1Pmfffw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=uvq1B4oZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.70
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D09606A326
	for <xenomai@lists.linux.dev>; Wed, 11 Nov 2026 17:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84D09606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=uvq1B4oZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzBq6DG5kru3xIH85vPq7elCFAwk4wXq0C9jCAy4uSlDR7VKMhh0ylwAdy90oVc5urq9rNU+0MkwmkFEhDapetX3OO6cQafsj0Wm7aXqX4iQnGKNV41jjOVNTGuuNj1gVfdw66FLW4qrlOVfWRgyekFJ6H/3Ue75nztP5xhXv4xcCnoh7xPIPQGUqnYIicpHPR2dkCEnABh7D1WETjf8o5dYeArdT96ZbdrTwvtzue1BC/4JrQ81qhjjMdRCnjAnzLwGzLj66FlRgThgyhGL9G8jvQHhQh1lDWiZ6MsNIwmSY9nVsvxdJccFkoEJjLrk5LaG6ILqMwU3Uwm89wrXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FGC3EPSxTfr2btYVeAlSNZ7D2asNUUVKNnHLfthGzk=;
 b=N5hF5zr73eJTrRBTFRtSxtqOrhaph4fcui6AyOnOXqlmltbKGmxy4y0rphQbv6j+kdIeMHwQgVNLJ+vfn8CB1H7KWaPkNRMYXYnSmsg0JhnQUyQ8z7k9HFDOV1XmRwEDSL2ff4pwbxi4Ot0KRS0U+IAY2v0TOXImsG49iqfw2FNyZsJwfAl8KmkrfN71ClqWb6ovUhj2T9dzV3UovR20pVcAlOPKCUXaqD2oTrvDE4hlyUAfHungx4V97ApVboUvV4MiE/3NRuB0J4kxE025KUd+5gjt/b7f3MvQWcXjWH1bx2x+iRoTb3huD7qe2qCVrYw3GCjdqSb0DzSB/YWKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FGC3EPSxTfr2btYVeAlSNZ7D2asNUUVKNnHLfthGzk=;
 b=uvq1B4oZFbeOwveSudYLjh63GAoRJ/dVdrPIn0Z7X/Bz2cKk3IFqtrW5dKFmbBbbngD0lEDaEi6p0nJNdTkgA/s79lvuuI/SUjkTFL0ZQcv6+Ekx7/W8ckrHxbM4QvZWDGeFMC22Mg8HsbmAYP/nAVMRxkR3ALmTVsAcuctC+fdQtBHROVXf5PSyLRPHZJzaA/T6XlSCmHJIzv+XBVy4Q+C7S8llbBxdUdrM2YNtowt+rFYqKdrapGFivi2GGsrsKPaYcafLhl2qGQIj4dkfC4eT5EB6lk4VniOXZbUyyoNrLucFEd+7ms8g5mWBFskBqxm/E/LFY9ndSQslrLeeSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GVXPR10MB8455.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:1e2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Wed, 11 Nov
 2026 17:54:06 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 17:54:06 +0000
Message-ID: <0af6bab9-15b0-4422-b9f9-0b0df4433ce5@siemens.com>
Date: Wed, 11 Nov 2026 18:54:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: pinctrl-sunxi dovetail changes
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <c5adedb6-0aa8-4a8b-b6b6-5047240bf58f@siemens.com>
 <87pkwb45v7.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87pkwb45v7.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GVXPR10MB8455:EE_
X-MS-Office365-Filtering-Correlation-Id: e38af94e-3abe-4003-ed65-08df401cc79c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261009223027099003|261102123227099003|261021121427099003|56012099006|4143699003|261026121527099003|11063799006|6133799003|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	UiwHd+9Rx+8Of/fU6+dpzZfgIN5qellFuVOZWIaVwzvGdOdMwpWXHP+jeE06c1wisoSrQTrVPoArrDJw4p2cYz/dc9NnbTgigW21QQjFXKXZmmp0Ed03fArTnE5LbhihzCYKDCU+DXT7hYRGnVi01IWmyBUwpJOu/zVU0QA1iBDG57JQu9tXl89aVQsMZfjSnL/TpdW9dFZmnhCW+WZKEzClpfOppI7FbvG/1b2gfx/Xdp+z0OIGTpczIOulcCcG2JYIegvTV+FUOCjOLDlDvPGq4dQFb84IsHOfNHfW0QQJc+RtA4U1df+kp7U08Uq5cAJr14/aMCRjUHoM8V0UHDwEPB2ePgbUb+7hbIdb5Rf0mzRZi87dN8ErctvQ+n51KbRmvTT4KpAu3D0Vc+DBQSvXUAg3kQyFenOHAyGhLVwXvCWUPBKNnFK3vhrub9v+l2SidppzUsuRZPyAUQet6LaJnC+T664M21FbSITso62wiQSx8wvu34xXWNaAPcwQx/EG9t5AJezGP+Wu6mRs1CNXEqbHRs+CWX7J2GYNe0aQRMAEB63mRRlThns3Epd+R0YvCJOy5Whvrn/IJeomLGGM0PyfORUrEA2W9V3dB/Sb1RyjiVeC0RdJwjDX1q/gOPdDso0VsAj/ooHUYJ7Gicr7vwfdj2VYxPu8zHL+f0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261009223027099003)(261102123227099003)(261021121427099003)(56012099006)(4143699003)(261026121527099003)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUdYTnFkQ3B4UExwcmpaeHQzb0I5NzYvd0FORkpXQjlSK3E0S0g3ampWcytt?=
 =?utf-8?B?b1o2cDdKcEYxakdDNGxQZWhPVy9SYU1VY0NpSXVYTkE0eWVucElsS3dCQVRR?=
 =?utf-8?B?VXNjV05neE1sUVZ4NFBCRFovUmFEY1Vka3FIWnVlaThPZGtSOXI1dEZhS3lu?=
 =?utf-8?B?bDc3b2lPU2ZLRlpuUWtDcjFIUk5wVW5XY3g4SWRNaUJWNzJrRmkxK2tMcXBH?=
 =?utf-8?B?ZFMyQXdCeG81Vm55S21kWGMrczlrZ3dOakNEYUNIUTcyN1dNTGdBR080SmU2?=
 =?utf-8?B?Z0VOSXNYbG9KcjRRV2tpaFIzazV0em5aTk5NN3RRdk12SHo3QnUvTTMxN2pn?=
 =?utf-8?B?aVllQTZEbm8vT3Q0Tk5xQms1YjZtQXJTbGFiMTVaQzRtWm1pejBnL1BiYVZ2?=
 =?utf-8?B?VWgyKys2bjA5NkE3MlZnVEhpbVdXVUs5aklwYW9PVzZLRVE0SzFmaE1aSWx4?=
 =?utf-8?B?cnc5TEJsZHlHUlY1cEZZNXRuc2xEUVZBSE1TYXZOUDcrdkRHcDlOblVTUnM4?=
 =?utf-8?B?Mks0SEU2bDFKZnVNdDJKQlZDQnhYNWlrSXhKVnF1OGs3UHRpaDY3Y3I5dHdR?=
 =?utf-8?B?eDBZandGTk9QS1hjZ3dHS2J1RDNGdG9CclY1K0l1aFhnTU1BRmM0bHRjUmk3?=
 =?utf-8?B?VExUYUpLNkRkaDJyQVVFQ2dBQ295QXkyenREdWZiM0prczNmbDkxam43a2cr?=
 =?utf-8?B?YWg3aVRRSlpZVTNHc3VEU0IrdlQvc01oMXNaYkQ4em95Z1N4OHVtbEpDZngx?=
 =?utf-8?B?OTJsbHNFeFordjVYY2FqVUt2V2kwN3dKb0dETWtCcCt3dnNXcS9VOW9Md2dx?=
 =?utf-8?B?bVhYbzNCMC8ycFpGaHdRQUZkc1ZMSTRjOWJYcFg5YlMvMkVQVTNZUFJvK3Q0?=
 =?utf-8?B?d1E5VWtIQjFPZnU1aWY0cU9iK2NFVmhFTmUwdXJWQjJoM215eXBoTjUxM0tC?=
 =?utf-8?B?NVk2Mm1IZDdiMUtlMU9sYmFOblV5bkVYMWpBdm90dnN3b0Y2TGh3Yy82OHJJ?=
 =?utf-8?B?OEhjZ1JCdGtTMEZ4N3V3NWRtYk81YlY2aWs4MGpZZjREZVVuTnYvYUlaM1NQ?=
 =?utf-8?B?NEc0VjVSbWlpa1J1OWpxQWpkV1gxU2QvMWJTSmZxSC9oMWpjTDZBUDQ5a1dO?=
 =?utf-8?B?UWUvYlVOd2FrdStZMWdlMXM3K1duS3FpdUtMLzZHelc1K1lud1Nlalp1Q0dH?=
 =?utf-8?B?NWZ1eDZSS1dJbEF5d3haa0ErcnFPNFFXT0txRXFlQmlrNGlBb1U2QVpOMmRM?=
 =?utf-8?B?aDFrV0V6QVRRaWdqM0w4K2VmenJ0U21hVDJRUlZvN21UK0FybisxNHkrVnFZ?=
 =?utf-8?B?NUdabEE0eVJ2MUF4RWxoZ3BUUGRJMmdtZ2w3dmhKSktmejVwY1c0djYvcmVr?=
 =?utf-8?B?WGMvZlE4N09wQy9jbXp3SDJuZWVGbithOVVYKzZ6R2dvRFlHSzNsY2Y1NFdG?=
 =?utf-8?B?a2I3QUoxRm1jSjU3NWVzVFl0WDJDb0lzeEJ6bUM1SGRLbWg4T3dvdXBMbXdN?=
 =?utf-8?B?a0ZHTWQ5T01VVmZ2Z1pKTzBhSEd0NG9LV0tTbGtCdTNFZjJ1Z0VDK2ZoS056?=
 =?utf-8?B?MUFCbTJPVXl5TWRuMERFSGlFR2lSUUNuM1JrRnNSYlNqWERwZnh5M0JHOENj?=
 =?utf-8?B?bTZ6cmpSQTI1Q0Fmb0pJRC9wNnpjS0toekRkK2hoWlczY3ZXdGZkU1dyZFp2?=
 =?utf-8?B?T1dqNWdkNDQxVHQweUlqbkYxalZOVTB4R01sUG1CbHFLYzdkZDdqVllRU1Fk?=
 =?utf-8?B?aktlbVF5cXVPK0FObXJXQXJoOVNaa2NXZithdnFrTlc5UVA5MGNDZ2N4ejkv?=
 =?utf-8?B?L1JEdnQxSjBFZzhZSys1YnFIRzZIZDNVWjQzaGZ3TkpxaHoySUZiZVkyK2Fw?=
 =?utf-8?B?QlJuZUlvR0dyRHQvU0swVENvWTVLcjBjcTVUbzExYzEwRDg4YlRSWnpTdDBI?=
 =?utf-8?B?c3dZYWZrVVhJRHNPR3llMVFNdXl6RzY4MTA1OHpObFBmekdKUEtaYUh5VDB2?=
 =?utf-8?B?RmtZZVFOSjJxMmsvYXVGTWNNL2pJek1wRFFjdWhoc2MvUUZNVjBGTDIyWUFW?=
 =?utf-8?B?d2w0MXczRXZRSC9EY1Y1bTRwYVFGWTFFbVFoNGlGRW9lOExON3pUVGxIcHBL?=
 =?utf-8?B?SU84MC93SkpicGE2cGl6cXJPZG1GejUvcmZja2xpWlZOUURVWFNUOWVVc2NZ?=
 =?utf-8?B?VUhuZWJVaCs5S21lZ3dRTjl4YUU0SWg1RFVFYnc4VEdoZzJqWFZ3Mnd1OWNu?=
 =?utf-8?B?aisvL3hxSko0ZWdmek9WS3BKaGJWVlI1bnAwbHg4TWVNTnRGR1NMTGZCRjFR?=
 =?utf-8?B?RENiU3Z3NjlFZ1NORDU4SjhZdkJCZ2FuTzA0bFp2d21hLzR5bjM0Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38af94e-3abe-4003-ed65-08df401cc79c
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:54:06.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1rARXz86h2xtanvxpWeGLMIpNCFLlAUAffsnK+2RERfve+fGhvl7JhEHY6f0oM7yBnuty51gBu0C1VnivSBsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8455

On 11.11.26 18:47, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> the LLM considers this pattern unusual:
>>
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> index 31cd142ce0f79..fb73cdaa30ca4 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -1280,7 +1280,7 @@ static struct irq_chip sunxi_pinctrl_edge_irq_chip = {
>>         .irq_release_resources = sunxi_pinctrl_irq_release_resources,
>>         .irq_set_type   = sunxi_pinctrl_irq_set_type,
>>         .irq_set_wake   = sunxi_pinctrl_irq_set_wake,
>> -       .flags          = IRQCHIP_MASK_ON_SUSPEND,
>> +       .flags          = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_PIPELINE_SAFE,
>>  };
>>  
>>  static struct irq_chip sunxi_pinctrl_level_irq_chip = {
>>
>> Since day #1 of the patch, we are dropping IRQCHIP_MASK_ON_SUSPEND and 
>> setting IRQCHIP_SKIP_SET_WAKE instead. Do we need the latter? And do we 
>> have to drop the former?
>>
> 
> This looks suspicious, indeed. I don't see the reasoning here.
> 

OK, patch follows.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

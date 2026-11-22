Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795371463;
	b=HqP9HRihZTBSEuTflPH45Fb0ZfuhaCCwQrKbDcgqoj6Z2KQTAa+a059fSy5u2BWKc68z
	 rkgUBRRu4njspUQEdwg8swJaaEAiiD9Fb076W47fGbZTicQKhIGDurehI7hs3Fc4CYiB8
	 ZfEjhezNUFAOqhCncjLkCqpuhm5Lruu/+85Uw+hNC7b9r/9X07O4gau3Mue9b4bWTKkXI
	 Is7scMMko3b0jFjukGU/+eHBCD3xtDgGojNassJX6aDla+1+T5uTBztEETyuW2QvgMKyK
	 ZA9bYMCqyv1FE2MWkrUfkFR7pgSeEQGaJMO9AT3F17vQxnNQPITOfoUvzLtwoxrOxjg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371463;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=d2p7e9dI5ASUqZ5MvchrZnqsJknl267sgZfBKz8NV7o=;
	b=Sw8njfV/p+OBFfab8ioBTyk2EfV4qz3Wz+jT4hAoq1WPGYiHjqDSkTNqKiZQsqY19KNs
	 3XXfeHtDx3ShB5ZvQSCMZywYd+JF77ganEj+fApTMHVxeHOsTT5D7GvOIiOYGku91bG82
	 sNGCvGbzWSKpJqpZPiaPA7s02BEE0AZVIHxRm8rbMiN3JjyphlC+VEicSDpvOFYD8LLgn
	 sI3uiinECvsI6pf+PT8Pij/kAwXGaEw6JrgM4Rld+Orq91a54Q2qm/RP3sMJb0IWEOs0p
	 rKu1G8PjCs6wJTF7wKSzm2aQxZH5vhYDiKIL750QhBthlU19AwWwJ8namvWbJS8fnTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pD7iRzIl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.46
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CA606A32A
	for <xenomai@lists.linux.dev>; Sun, 22 Nov 2026 18:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 291CA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=pD7iRzIl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5PJwZEZ+DktU1vIF1XRH4vO+1q3gTsPWuLI0fHwdrplt+7XtrhIwFeP+JKX176Zzads2nBh1wy68cWccpFN4yTEe/mk1JeSdzYu9UMGDs//A+ZGvxkFiCMLKIGWhiype4tezvSOJd4gdgyaCihjIeieU+d7ewjm2TgcTEkjJ1H4IZvXnr1DakEq6OI3/l1FKm0vDsckP2EGBiQ+gQm1yCTyOVN+Y7oaWtH6gwuxVoiKZmsJdj62C9UqeVfmLPCDZNr5F8YX1FFv6mro9595aQNOcaZ19gSUW678GD3RuO8gMuwSmgFFvdk7Y8fPqJWtHFEQTLOo8hjAVledR89HfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2p7e9dI5ASUqZ5MvchrZnqsJknl267sgZfBKz8NV7o=;
 b=pbRh2lPFgEN3UNfirSpXgQVi+8PU9NHy+th8PiJgjEXBQGxy5S75MKoGoonLDO4jxlOos/7UQ2WRDNtiW0+kmC+pbpuRAJCTB3NZJRGdNwVyuZ+OgXLbRhUL4LaMLeiLaWMsG7NCGIFsWr70GIM9E3o3AdF0AcI6d/MxVZQEyUCotDgTJ3KYuLMNNuH3KitTsR4IpJTF6qPkgwpnZv+5nxEUtcPBArPO9Q8knlEdPE/mFbUO668B91Cv6+4cZzFaQSF3VVB/f491TIsSW9ZgOE2ZX1PX9xCziXWDh1ZwgJrrbAc45yCXM6T47FQRVAPAsBTWyaiNoZ32ZGTTbrF2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2p7e9dI5ASUqZ5MvchrZnqsJknl267sgZfBKz8NV7o=;
 b=pD7iRzIl2YpGm6cKz8JFR2M+raIMKp0DaQ1/KIlNS4u+dE1XP6yzzRc/D/fX1+ZtakDvNa4oYYIePzW/F5vrUS/2kLA3XxZqP69UyiZS++87/YZI9HB/Tvf0qMzPBG7eer2UlZb+UVbuK94iE6mqIykSoTwJKyFnfZ0a0+P2d3xnVcPwRDwaI9oKqGyoR9wKUTJlBhuweXVvwR9o6VoLEXjLMqIG+9WjkKP3NMSExqoJ92Yty+NJWYEyibHJ0HvFnRNFywVcvcxnmUwiQbRhQscrGOJ7HrQhC0zkVE2fXzb/HI4vONuMsYprBwuiOuJ74juT9UJgTZGhuDmul/DfmQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PRAPR10MB5348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Sun, 22 Nov
 2026 18:17:38 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Sun, 22 Nov 2026
 18:17:38 +0000
Message-ID: <ba91a81f-a52a-4742-b4f9-4c9c3437ef8c@siemens.com>
Date: Sun, 22 Nov 2026 19:17:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] smokey: Add traps test for trap routing of primary
 mode threads
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Philippe Gerum <rpm@xenomai.org>
References: <31921289-e2ce-4370-bb21-97d66de8e566@siemens.com>
 <37fbdf8e-9116-4b36-840a-612d49fc7f55@siemens.com>
 <e78f2129-6875-4b5e-87c7-088950b69785@siemens.com>
 <4f118759-234c-4ed1-afe2-fbefe849e369@siemens.com>
 <b533b6ad250bf960948765d5829fea34f26b99c3.camel@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <b533b6ad250bf960948765d5829fea34f26b99c3.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::18) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PRAPR10MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: e48cc5fa-dd72-4b76-defb-08df48c4e3ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|366016|1800799024|10067099003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261021130227099003|261022115727099003|261022105027099003|261026121527099003|261026140227099003|261021123027099003|261022075727099003|261022113327099003|261028144727099003|261102123227099003|55112099003|22082099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	sNOC9cvlUguxMcwxC9oIrZVnuX3YHNCYtn5egrZP93imdnSruyW9YevOGuEz7zvvuIVv6TQfwlW5vO0jMC83mVlrMcnPEw6TwKc26vrXM3Ff0M3XHvA30GwNEbmBgZ47Tbs/teMKYAmbTuTKJNtTUgwbvTRXu1CH84lfO07gFndcPcF7VhIVLl6T0BjMk9GMMh3PDIMvfj5RxRm1v5/1vF+btVLU5SPAqJcpBRdCrxb3kvlEw1URI7Hwr9FyUvUYkM3AVR06LvXN/gBH91uj+zQCY4eOC+K+Fs0otcIXWvOoKuH9gBHuVnchPQBaWzNPLMoIRJmma+VhU61PYdv8NNIvLeBsHDR6GChaBeVPwyf4t0FhFXyP85f4ZuMpoXvwCyaFi7kReQFXLrE0WPKFRHkpJRYPnYBVBC5lVU2fSoiWCpg+4hwrFXOCJp/g0Q6dyHR8p5OkC+EfXuV0UsBKeeLbQQnz+30D6v8sBCe0tp9vB9bJarbm8SYN2KpAGb37k37JbC1V2k4KNdiL+ASo8/VZXT8X+4aDNxB4t09kPmETMYMWzvVlZRAycv7Z9OyGjboafzgklP2oP0ojVhXPGsFzznkxfpo1lurqmo4iwjWAl0WSAckIsl9hDgl+CJInQe+blyDN+PmoeKi10z6ISrOjrTpsaS1y5Pe2hjMIv6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(366016)(1800799024)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261021130227099003)(261022115727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022075727099003)(261022113327099003)(261028144727099003)(261102123227099003)(55112099003)(22082099003)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NksvRUhkNGk1blFrT0FNbHRtNGUzTmFZSStjZHlFTFNoZTJyZy9UVmhOUHRs?=
 =?utf-8?B?RFlZeS8zTGYwbld6Q2NjZEZLaGxrY3JxZzRBbXE2TDk1SWZvSUkraDZhdFRR?=
 =?utf-8?B?elM5NGs0WjdTNnNvYWswbjIwMFk3bzRQSVVEMDVvdkdmYnNMUEZNZXpsNUJQ?=
 =?utf-8?B?Z1EzbktLM0VKbVhMVlNpcjhrWFNna2o2Y1FpcmdUN2NzSVJnSm1kS0dLSE5k?=
 =?utf-8?B?WHFxbVZtNEVLNzA4ajBDdXduVy9HSkltNnVmeDlWRmxxMzIxaEhjTDNzQVpj?=
 =?utf-8?B?eTFITk45bUV5Rml6aDhySmZ4V01NdFQ3dWtvYkZoejQwWGx2UzJJWHRHK1ZN?=
 =?utf-8?B?YWk2MXZwV3pUY1BNRm43bHcxdlVrT2UyeXo5QlRDVTVMQ0RyVFBEVHpPV2hh?=
 =?utf-8?B?cUVaOFZZTXNRbHlkdXNYZExJOStiWkErMDFZWW45cm9PV2dDT0p0L0hVSjBz?=
 =?utf-8?B?RCtGR1JLUTJCWk9XNkMrU2ZxUGh3Z09SWFFNTzJaR0QyYnBkMzV1dlFxR2FY?=
 =?utf-8?B?T2dZOW4xbTFxYnZmTlZQcVZ4ZDNqbkN5QnU5aDJRb21mTDlvVGVWaWpjVTlB?=
 =?utf-8?B?ajhjMDRxMERrWTRXbjhGQjVCVnF2OUNQeFdDOTJ4YTd0QjQ3Q2c1cUxxYm9u?=
 =?utf-8?B?aTNEcmtvR1ZDbjhSdExlNGNJeVNFTGRGNWhtWElFRy9CSVVrR3YxSnBiYWVy?=
 =?utf-8?B?S2V6bmVzTXpXeDBBdXpQUGdUQnJ0MFEwNFljeGV1RnlqemIzZUVVYTh2S3hP?=
 =?utf-8?B?cGFYWWJncG9LSSs5M04vcVdmUExvbHMrMXErNjN2UEFxYzgrUllSK2dCSlIx?=
 =?utf-8?B?b1RtY1VJTE40WTdvV1pHMmExMGU0ZmxkWndsT1BRRit3QytyQk1XalNXZWNr?=
 =?utf-8?B?LzRGNnFKSHJXc0ZyWlg5MHZxYU04THZRSFNya1lOUGlrazVuOEUzTTZwc0g5?=
 =?utf-8?B?c3NNOGJLbElxNGczRStpbExLRHd5Nk1VZVpQRkY1WTBxL2VhbzF3WFZScGx5?=
 =?utf-8?B?LzNJNHRvV3NUU0swSTFtYVVMeXkwU25UU0lmdGhCN1BodExtQm1UaHJmU2RT?=
 =?utf-8?B?Z2JGYndGV3lZWjE0aXRwakRmVHFyU1ZPUnF2SkJXZmdLT0ZpMVA4T3B2OUZO?=
 =?utf-8?B?dGFxaTExS1h0NzY5blhuVm1SMmhlMFI3ZFR3aUFjdDh1b1NKbnFDRGg1NEhD?=
 =?utf-8?B?eVpkd2NHK3BjZGQ4WGtLVTg5eURTYURBanVlTFlYdnlUYWl0SGJMamd6Y251?=
 =?utf-8?B?dldBVXN2REZkZ2kwdzkwblJFaERON3hYdndFOUg4Ny9sdEVSRysrbzdUZlQ3?=
 =?utf-8?B?UWxTSS9XUFVtZUY4VnBES05xY1RQdU9XdFc4dkZJY2tlcFNKUHFxTjJPc3NF?=
 =?utf-8?B?UEc2MnJVWm5TcDR0YThTZFAvc2sweEpseWZHckxIeklEcFlqVFpJbGJSRjZW?=
 =?utf-8?B?TUpQL3FjQ0JsdlVjT1VYM0Z0WFZacnphZnRDbm16cTZCaDdXWkovd2xIZ1Mz?=
 =?utf-8?B?SEVvWmNiTmV6SWhaZlVpNDJLeUxuMGszcmQ3dkorM1hmMkdzc2xWV3dEUHFs?=
 =?utf-8?B?NEpiTkUzcjNTK0RTQkpqZ3AwdGI1NTRjcTZyM3QxczVNWTZuNExDT1BXb3Rj?=
 =?utf-8?B?QkNiU0p0OUR0Sm5EZ0Fsa0N3ckpGR2g5bjQyUlVWYU1EQ3hkK0htMW9pSnNy?=
 =?utf-8?B?USthajZUWXVMMnZKMlNLKy82aEtJdXFlWERlQ0VMNFc2SlhXRjVBZDI0b3Ft?=
 =?utf-8?B?UHhGQzdFMHBkcytKMVVWZ1dISEhpWlVwRTN1YWliOE1lei9KWk5aWWFVWEha?=
 =?utf-8?B?aTE3cDJMY3FrTllITW9TTGIvU1YrNElTd0lZSjVEV2hod2FsRUplMnVZRUNL?=
 =?utf-8?B?dEVEL0RHbVRwNlo0WE9VRE1uSkhpSC85dllZc09BbmQrZGJmejVqUlcyYU81?=
 =?utf-8?B?WDRNblYzeS9MMUpzTFZtTTJjSXhseENLakthNnYvQXp6UFQ5SmtSekQrOGFh?=
 =?utf-8?B?a3lyc005T1JlVjZ6Vjd5ZzZicnV3SmpNNk40RW9wT2M1d0JwMEZCQlY0L0dB?=
 =?utf-8?B?Mm9BMGYxTHFRdE4ydzJLcHU3R3AvL29iYWZIYnBBRktnWVVCejdmMVZvUEtm?=
 =?utf-8?B?MmRva1drZGRYZVVGQlNhRGhjVWxzZzRvUHJCVmp3VENUMUtUZGRzUVNka1lE?=
 =?utf-8?B?YVRLYVBhNVpkbGhYQjhJK3RndDRkWmdCcXk1ZUFHbmd5MWlzOC9ITXd2Slkr?=
 =?utf-8?B?eUxBeHFWOW55TFFyK1ZKNUlGblllTGltNk0yKzA4T3I2dDdpUGJGSzMxdEEx?=
 =?utf-8?B?NmhiV09DSGxjUElpUXlxNkw1cHhDZXdWUFpoVDVjdE5UeDcwRm02dmVXQlNx?=
 =?utf-8?Q?jr4JepBVFR1BlnPCGHTPd/zgEKTZkYxV0kruTgPPNk+tX?=
X-MS-Exchange-AntiSpam-MessageData-1: lAXKXeDg9tm7AZOlnUw/PVNbxP39n6zg6g8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48cc5fa-dd72-4b76-defb-08df48c4e3ce
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 18:17:38.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GuR4G8MKPolC/21x3NBGid1vUpMirMQrJYUzSy6hnX7ztwyItGnOZhjpTPdvipwlToJz5YgxByjTO7l6RPNr3WOmY8yFAGL750QKBYQY60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5348

On 11/22/26 15:52, Florian Bezdeka wrote:
> On Sat, 2026-11-21 at 18:04 +0100, Tobias Schaffner wrote:
>> On 11/17/26 18:28, Jan Kiszka wrote:
>>> On 17.11.26 10:27, Tobias Schaffner wrote:
>>>> On 11/12/26 18:44, Jan Kiszka wrote:
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> A thread running in primary mode which takes a synchronous exception must
>>>>> be reported to the Cobalt core by the Dovetail layer exactly once per
>>>>> trap, before the in-band kernel applies its fixup. Cobalt then relaxes
>>>>> the thread, accounts the trap and sends SIGDEBUG_MIGRATE_FAULT when
>>>>> asked for. Only the page fault flavor of this was covered so far, by
>>>>> the sigdebug test.
>>>>>
>>>>> Add a test which triggers one specific trap per case from a primary mode
>>>>> thread and checks that the expected in-band fixup happened. Most traps
>>>>> for x86, arm, and arm64 are covered here. Left out are those that are
>>>>> practically irrelevant: AC for unaligned accesses on x86 and VFP
>>>>> exceptions
>>>>> on ARM. Not yet covered is RISC-V, but it should be easy to add on
>>>>> top.
>>>>>
>>>>> See extensive AI generated explanation at the top of traps.c for more
>>>>> details.
>>>>>
>>>>> This test may become useful for checking future OBB trap reporting by
>>>>> extending it only slightly.
>>>>>
>>>>> Assisted-by: opencode:Fable-5.1/Opus-5.5 Signed-off-by: Jan Kiszka
>>>>> <jan.kiszka@siemens.com> ---
>>>>>
>>>>> I know this is huge. Therefore, it is also something that we likely would
>>>>> not have done without LLM support - way too much effort for testing
>>>>> corner cases.
>>>>>
>>>>> I went through it, but not in all details. The tests fail when they
>>>>> are expected to on unfixed kernels, they apparently pass on fixed
>>>>> one, at least on our CI hardware. "Should be OK"...
>>>>>
>>>>> BTW, if we merge this, we implicitly document parts of our so far
>>>>> unwritten
>>>>> AI policy ("yes, we take generated code"). I still need to think
>>>>> about which of the templates out there to use best, then I will propose
>>>>> one.
>>>>
>>>> Hi Jan,
>>>>
>>>> Following your input, I spent some time last week on RISC-V trap
>>>> handling in EVL. To verify the proposed patches, I ended up with a
>>>> similar trap matrix test generated for EVL.
>>>>
>>>> With the number of fixes we can now produce with AI support, I think it
>>>> is right, and important, to put more time into test infrastructure.
>>>> I think it makes sense to pin down in more detail how Dovetail and the
>>>> co-kernels built on top are supposed to behave to make sure this is not
>>>> changed by AI without us noticing when these tools are trusted more and
>>>> more.
>>>>
>>>> I am asking myself if we want to keep some kind of human readable
>>>> source of truth that tells us how this is supposed to work. If we start
>>>> generating both sides and both sides are hard to understand (at least
>>>> for me, the kernel side still is) I feel like it will be hard to notice
>>>> if the tools start to slowly change the design.
>>>>
>>>
>>> Good point. I'm currently fairly impressed how much the models
>>> understood about the current dovetail architecture by just reading the
>>> kernel patches. Maybe they consumed some documents upfront, but
>>> definitely not while answering prompts.
>>>
>>> That said, we more guardrails, also for models that might be cheaper,
>>> more sovereign (local open-weight...), but also less smart could be
>>> useful. Question remains how to encode things best to have both side
>>> understand the same.
>>>
>>>> In addition, I feel like most of the tests are Dovetail functionality
>>>> tests and not specific to cobalt/EVL. I think we should at least try to
>>>> find a way to tackle this with joined forces for cobalt, EVL and what
>>>> ever other co-kernel using the infrastructure.
>>>
>>> Yeah, valid point. Maybe the availability of a POSIX interface for EVL
>>> will once allow to write more portable test cases or even share the same
>>> code base.
>>>
>>>>
>>>> I think that RV can maybe help here. It would allow us to decouple some
>>>> of the checks from the triggering of the test cases. Triggering could be
>>>> in the co-kernel projects while most of the verification lives in
>>>> Dovetail.
>>>>
>>>> I created a POC of a more detailed trap monitor paired with a matrix
>>>> test that solely triggers the traps from the different contexts in
>>>> cobalt here:
>>>> https://github.com/TobiasSchaffner/linux/commits/tobsch/trap-monitor-
>>>> rfc-proposal-nofixes/
>>>>
>>>> Asking Opus 5.5 about a comparison to your proposed RFC it tells me:
>>>> ```
>>>> Not covered:
>>>> - SIGDEBUG with SIGDEBUG_MIGRATE_FAULT, exactly once. That's Cobalt's
>>>>     notification to the application, and we don't check it.
>>>> - The counters in /proc/xenomai/faults: the right trap +1, all others
>>>>     unchanged. That's Cobalt's accounting.
>>>> - The exact mode-switch count (Cobalt's msw statistics).
>>>>
>>>> On top of the RFC, it covers (checks no user-space test can see):
>>>> - the handler level of the unwind, through the stack frame;
>>>> - irqs off on trap exit;
>>>> - demotion only from task context;
>>>> - no IRQ in NMI context;
>>>> - no sched-out during a kprobe;
>>>> - the time limit.
>>>> - more fault cases: read-null, write-ro, write-retry, exec-nx, bus-eof,
>>>> fresh, fork-write, kernel-fault, kernel-fresh, misaligned.
>>>> ```
>>>>
>>>> The output makes sense cause the POC has no cobalt API specific checks
>>>> anymore while the monitor adds more kernel internal checks.
>>>>
>>>> The hole approach Monitor + Triggering matrix is smaller than your test
>>>> while the monitor part could be reused. A rendering of the monitor is
>>>> attached.
>>>>
>>>> Maybe you want to consider it or spend some tokens for further analysis
>>>> if this can be valuable.
>>>>
>>>
>>> "Smaller" triggers me for sure! Would be worth to see the outcome in
>>> code. And we may still consider addressing potential gaps on top in the
>>> userland. Key is that the userland test orchestrator and stimulus
>>> generator and also read back the result of the RV monitor run.
>>>
>>> But what might be more challenging: we would have to backport your
>>> infrastructure to all kernels we are maintaining. Is that realistic? At
>>> least down to 5.10?
>>
>> Hmm... I did not have this on my radar... The RV subsystem was merged in
>> 6.0 and the Hybrid Automata that I build on was introduced in 7.1. I
>> think that back porting the whole subsystem as well as all the needed
>> tracepoints would be a huge lift.
>>
>>
> 
> The Linux RV monitor is usable since 7.3, before that it simply had to
> much overhead when compiled in, even if not being used. With 7.3 you can
> build enable it without any impact unless you start using it.

Do you have any source or measurement results that show this? This
statement does not fit to what I know about RV and contradicts my
measurement results. RV has always been very cheap when running and 
close to free when it's not.

> That said, I don't think that we should backport that at all. If someone
> is interested in validation => use a modern kernel.


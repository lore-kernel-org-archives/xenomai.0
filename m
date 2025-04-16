Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1053D994
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744810402; cv=fail; b=eYW6CCCjAgMrSG+abGhIDMLnV7WWt9HoYV55EFjk0tzTBvjdT9tE58KtwYfxP7Aq1Yc38pQyuRl2/7SQkcSj58EiwQEaCTlFVyskdu5cGgrsZl8UYUdfdxfRY4evq3hghq6vuKx10wmlaSLgyc8orpUyvOFvX2hITJ1Y5Vzh8Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744810402; c=relaxed/simple;
	bh=P6Q+ZgZT+KFy9W6aDOVi/ucKupT/u62ocKKC2ghYrgA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WZEQJ9ykk97UmDYcUNZR2q61sCurWezRu9thucTnuSpnOUA4UW7HdYxRLEoEtpxjB/AW+KBWMKIbv7XUQYw/1J4Xft5foMtfHQSNEAWl+P1AJ5nFzmLpBolsjBmeBBpu76/Gzhgv6BJt/DML3UlFnpEnd9veyronKuEODr6dioM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nJjj0Ec3; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nJjj0Ec3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1/OeNy8Q1IwpFAM/qAuwoDJk9w8GsmxJOMUBj7Wfi5wr4Vrr9LeCNGeTFVQa54TOArGz5ZVUPMQ1ABrXLakfM3+AQvs4y1tba8pFF8Q7L8o8lc3usuRr1kgRZWlL8BuwrSX+2/Wx+05kJ9MlwwGR5G/UuCZ5SEVWvNc7qH6eunTf9IxcWg15TdvO6rbrder5OrOHJIw+GJoHjHtDHuOzKek1PnlaOiWavhsPQKdFiIu1zv7j7Ek1sYzvqgJnHt24Yd+25QPPIrr8cNap/usqkJeh4O4fLKQqkZEV8JAnT0RqTckt/PwRkv57C/t1ej/E781SBPAyHghAmxgSjrdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMtCdyzs+tQc/U6X5NgNWm+/6sBwUpXo50PcdyiRVeY=;
 b=bPUyvh/+oL253SAyvK0PF7g6UHUjKf84KhFiwCaNQKdDjqsI54u/xF75OWswTIteEhatGhtySrjmjhQuYjwPXgchny1D8iz8Il8dNa5mQFey/+bhP38G0T+VmU9pv7r7n9Fj7Y2a2j72ThFwQos4a57ahIzUCdpuBAfUGmCDqSYDYcFWZY+c0mHEXb3nE8TFBjMk1N0qBcTqNvEmonZ4V9ENZJc8aHulhGoRjBayGYLTEVC6awfjYk/YoETn9p69E0rgaxJat9Na8hYPV1SM1RKRD5mFDaMMyDDMch1uiK4WYpsHMtxUwBnTHGIV6Suxy8RCnf2kOOGqYkk3f9iuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMtCdyzs+tQc/U6X5NgNWm+/6sBwUpXo50PcdyiRVeY=;
 b=nJjj0Ec3bodcjTixMuUUacVJcznkOPIzaPd8cJJqoT0DNIrx8ATkHFaBjLXcOi7xeJfK2tB8v9GaLoJMB/WlaEGruJJZTc+gagfWVg77xKxw48URdys/qVdMOau9FmrZ66p6Vn8CYM1f1kHCqTx4M1o6K05wrF4fdvGMMaICmVMRhpXbw1lTe9AgPC0vGZSQE6ddefcsX5posFGzhGLLXVGMIuRCIQMzHPW93iJOhSEQKb+jASg+Jt33y4eVE4tivj+O1iJAoizthnDzz6cxjMQw0ygVaBwbS2om48ao3ltPeJUvVJrG3oahNIQSudIak0lFczQ6PM1Gt2Mo9zsO5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7341.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Wed, 16 Apr
 2025 13:33:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 13:33:17 +0000
Message-ID: <8bc51145-3e99-4b78-87d2-7859f9c35a4b@siemens.com>
Date: Wed, 16 Apr 2025 15:33:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [EVL_XENOMAI-4] Consistent Latency Spike at 4s on Isolated CPU
 with EVL (Raspberry Pi 4)
To: Zoran KRIVOKUCA <zoran.krivokuca@smile.fr>, xenomai@lists.linux.dev
References: <CADjXCUdi2vswJNN8n2BWtPgtXu_ZXDrAD5qTcNNh=ovBmw=-yg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CADjXCUdi2vswJNN8n2BWtPgtXu_ZXDrAD5qTcNNh=ovBmw=-yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: d699fc7e-eb5d-4981-17a3-08dd7ceb3f41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzhhaWVvOVBRWGNuTDhPRExNWU9STG5BRWpSS3lMUHNSN2t1QURyQ1lvYVpz?=
 =?utf-8?B?Y0lPMW9jK3FET2ZMT1pPNzRuVWp5Vmc3d2hOaVVxNkJHTjZLT1Y0RzFBbnYr?=
 =?utf-8?B?ZUdleFdsblU2K2xGeXQ3UHhON2tzQ29PcFFqank5UWZDUFZOcXc5Vng0Y09B?=
 =?utf-8?B?NzhMTHNLT2JMNGh5cTBwalBKK2Era01TRXRTZ3JPMlBrY3BRY0VTWHhvM1NK?=
 =?utf-8?B?bFZ0cXVCTWdlLzJrUmVNUkRJVVVSVHdMVGs1RUxhY2lCaG96amw1aUhyTld5?=
 =?utf-8?B?QkxoSk51VVRmd1RXbDVOeUJmYkNUelY4UlhNVEh5NHdYUmpEY2p4WmZHSjZL?=
 =?utf-8?B?OGtBdUNsWktRcDNTQU9QdTQwZFUvc3dEMnZzUHhyMmxabkdlS1NWTmV3U2Jr?=
 =?utf-8?B?bWZBeHAxSnFXSEMrU3NWNHRCbWJDR2RrNmtvZkJrZFEvblFEd0VyTDlxTU4y?=
 =?utf-8?B?c0NFQUNXaFJYR2FaZVdMSTh1MExBcnZKTFAxSkN0MEhIVnBQTEFjck5ranVi?=
 =?utf-8?B?WFp4OXNPMHN3OVZQMjBjVHQ2TUZYV210dWxGMnRhU2gzaklOU0VWT3VBSFZL?=
 =?utf-8?B?T0VvWk1veWZabUVQeFZNamNvTnNtcy9vZ2pjNEFSbWhhbjJRQjZnSTlPRmRr?=
 =?utf-8?B?VWR4MmdrSnZxeTZXL2hIQUtmeml1dTNqdmw3dWl4M00wZzkxaVQxSlRKNDY0?=
 =?utf-8?B?bnFwaEVZWnNZdXM0dGRTSmNwL2E1anNHM0RMcHI5aDFoY3NRNkZDVTlVcXAx?=
 =?utf-8?B?eUpGWHBnTktCQVlmQlhaaWxyVG1lUEIvaG8wT08zeXE2N1Mzck9TUDBzN0Uy?=
 =?utf-8?B?RUJycm5NaTQrejhyK1FEVi92aG9CRWZCZDVjemNZdVZ5dDhKUzFZazZLN2Vh?=
 =?utf-8?B?bkptenM3RWVNWFMwSlVQejg4RzN1YXRxTkpTRE5yaG5oYnpsaEFrZjBxNU1I?=
 =?utf-8?B?OEt4aHZML2U1UkpkZUpmYzBxMVkwaTFYS3FkaVB3SnYxY3hLZEZGcVFvWmlF?=
 =?utf-8?B?MjJkOWlhZ25DNmhkTURYZjhld25WZ1QvMEpKeWI5UWZNb0NaTytlMmJPN0RE?=
 =?utf-8?B?TDJmRCs2TjRSRkxZZnV2NEthOFlKWldITGFUL0puSUFCOWc1NWFWR2pUb0lu?=
 =?utf-8?B?bitvRXhpSWFSbzNRQWNhSk85bjlEZnExZU9zOWZZbW53TDNMV0hLZlhWZDRs?=
 =?utf-8?B?YWZmM3I2SlRwTXVOQlJ2RXc2LzF2L2ZRT2tLTXdZZTFDZStKNWdMb2ZZTWpC?=
 =?utf-8?B?OVhhSXJBMnJRZkNUbU8yL1ZjM0ZsOTJ2T0dBcmQzTjBxWUQzTnFoM2lVeVgw?=
 =?utf-8?B?SjgyWG1zQ1hOOEU1UGVUdDR4TENzZUluMlBNc1ZCNFk1R0dMejV5d2g5WWZH?=
 =?utf-8?B?dmV2WlRibGhlOVYrellQQys0cGFOT21nU2p5YkhrU1ZwbzIwUnVJclQzNHI4?=
 =?utf-8?B?R2hxOGlTaGcxSnh5QnJyMlZhRzhscHgxbnR1VUVNdk9NTVl0UEpoa3lTRXgx?=
 =?utf-8?B?UmVCb2lIRlpKbXVJYXAzYnQ2M1hHTkJtSzVYdXhhQjA3M084Y2I4VXBBYXlB?=
 =?utf-8?B?blNZY3BadktRS2FIYXA0N21acWp1M3h3K3J6NzN4ek5wVFVlOTdKWFZzWnVQ?=
 =?utf-8?B?QlI4L0ZrWDFXWENFc3lOM3JHejY3MlJ5OWZoYlBEVUZiNzZUVFgyc0lUcXNa?=
 =?utf-8?B?WElxVERHd21CVDBQQlRlNU5xZ1AzNzJieHBLb01BN1hNZGxwdzJTcElwVXhK?=
 =?utf-8?B?WTFDbTBwR1hoc2xoNFc4QW8rQ3g3Z0J6dVpwMWRNdzNzUXhQYXNjcGxFK2pF?=
 =?utf-8?B?WUhrbWFiNDBadGZZMHgyZVVxSW5yZk9PcXNJK0o3UWtDejBmSE1CbXFvVmha?=
 =?utf-8?B?dUxnRUVVVzUzUUlmUHVteXVoQW04OFIrSkVZTVZpbHFxZ0lUaTZVR0Q3Ykdp?=
 =?utf-8?Q?agv5064R92I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yko0UllOZXhFRUdESU4vL3JSdUwwTGZtWHF5cDNmTDh1NjNDZVJpK1JlcDV1?=
 =?utf-8?B?VEhGTlRSM2czY2MxNlFFUStMU1JDRmE4a05qck5kZzRMMTRQVzBMU3lKUVlw?=
 =?utf-8?B?eXZ5VVVjeEdid1RtUGNFb3phRnNkR0lRS1JnQWZGaC92WCs3eU1mcGw4amhv?=
 =?utf-8?B?L2d5VnZYL2NsVU1NTktpYTBOYWVlaVNBSTVKZEx0U2VTaUdzL3BtVmpCOExR?=
 =?utf-8?B?VHpvcWNkMGRhSWdPVVF1YVB2SW9tS1dnNVhiVnZVT2V2Z1oyek82WE1ucHMx?=
 =?utf-8?B?bDZ6eXIwdlZZQW03blh5aTcwQ3habG14cGttM0VzTFk5Q0kwR0h5RzBPclJ5?=
 =?utf-8?B?K0RveU5KY0dObTZWQTV1VGg3WThwY2Q0cFpyWTAzc0xINzdTS3ZjaWprc0d0?=
 =?utf-8?B?cWwxT0FaN3dpR0VRdWh1ZXBMRWdDOGgxVFBPVDdJTzFGbFQyNGZNeWxtbEFM?=
 =?utf-8?B?OFVrM05vZFpnQzNhanU2RzN0R1RDM3JNM2dIYWE3T1A3bWh5UmNQaGFvdTNR?=
 =?utf-8?B?QTNKZEpKVWRmQVMvbkRMc2hIbzdYQXNPK1JGS0g4QmlCQ3VkMmhLakFFYnFK?=
 =?utf-8?B?TW9XNk1OZzBSTzA4cytSR1lEbGhCcHlzYlhPZWNNanNiUDVuMEUyV2MxWExq?=
 =?utf-8?B?UUphYWtZY2lwNmV4emR2MDJQTWdjd21oU0VkU1J5NUpNUWVwN0krYXdMRzMr?=
 =?utf-8?B?cGhQdGFMSXhjK2JiOW1rOGhUMmJoMVp2SjFxTVpUNzdXL0NVK2lDZVRFUnFQ?=
 =?utf-8?B?cHB5TlpxSzBuMXF2NzE3dm5NdlJxclQrRjFHU0oyc3lOZXFBREM2Nmd0WUgz?=
 =?utf-8?B?WG9NeE9FNjZvajAvZDdqekJQM0hGdWRlL091MkxqWFFoTmgvVTdudzFoVC9E?=
 =?utf-8?B?aEp5RFpkVE1qL1d3QlQxLzY0cFBxSDRpL1ZjL25JYWNQZVNWUHl6L0dZdU80?=
 =?utf-8?B?NFBUQmFYUElWL0RGb2QydnArazlUNVdQQkNXbXhwU2c3OEw3cWFkQ2VtYnJR?=
 =?utf-8?B?aWVaUmtFdWFmbnI2V3lCWXlQZXk1ZHRKVHRtNVBmTmErOVVRaHkzMnN4OFZN?=
 =?utf-8?B?cy9UcjE0bGs2NnhtME55eUkyZjVCZlEwekNJbzZ2ZmtqenN2MlpzU3JWUmQ2?=
 =?utf-8?B?WUx0RU01bzBlajFmZ0ZMOWZWVUJMMnpjaUJGNGRES0tsSVZoanZrYTk3VVhr?=
 =?utf-8?B?ZHNqQ3RlcEZ2SjVIbDZnQm02MVloRHBZK2VYTFc2QlhGc1lkcGUyZ0trT2Zo?=
 =?utf-8?B?eVZDbEQrN3pzWmY0M04wdnlzc3JHZno4RnZsTHBtMW1rZ2ZIRXRoZnZCdFFp?=
 =?utf-8?B?K0dqMzFQL2tselc3VCtycGNQbHkzcUpzRHBKK09aRDZramhIMUViN2NzZEh6?=
 =?utf-8?B?aGhxeE5nMjBNVnhhNFRCbk96QkxudkxnbWpTR04vVnNSU1JRWm9yR0g3S29X?=
 =?utf-8?B?NmZjS3RESllrWEl2Rks5OGErZkc0dm4ya2lodkdqKzRHcTlsMDZFaG90bDRH?=
 =?utf-8?B?clZoMlR4Zk1HenZVd2RXKzBLVVZIMjc2WUFlUHZibnR0dCtsaUs4T2xXQ3ly?=
 =?utf-8?B?RDFoUHZvVEFlVUlNZGV1ZGYzU2Zpbzg4dFMydm9ISDV1L2dsUVVqL29IK2I4?=
 =?utf-8?B?OUd1eFhRTDBHV1VIQmhwYk5tMTJ1c1orRW1MUTd6L0JybXlsNFBGM1loSUYv?=
 =?utf-8?B?NVRrMkswbGhpeFM0TU0wQ3ZxbDVGejd3bVYvZ1duZ20za05PZzZjVEx6OUE2?=
 =?utf-8?B?a3dnVWx6L2craThuM00yUXl4Q0FaZ0lTMitLUGpBTGNhcG45ZFdvNkoybkQz?=
 =?utf-8?B?UllBbXdHeTJWL2FIMzJtZzJYc2lqV20vVmNPWVV4M3NZK1JuTzhwSzMzcDYy?=
 =?utf-8?B?ejhUM0NnR2NkTmJCOHZxZDNxTGVLd1BSYjA0VDNpYWZkc3JUckxZNEJmbVJT?=
 =?utf-8?B?R3B3aEEvMUI1eDNwMlIydHk1RTk4SXdqS2I0dDhvSkkwaEtlZFVwNy9hSzhn?=
 =?utf-8?B?R0FrWlFMb0FIekdvbm50TjdiTGZCK1F0M1I2OVUySTc2TG9iemhDTlJsUXJ1?=
 =?utf-8?B?akllSzVmNEViZWFtbDR0WmQreVI4YWcwQThpMmtGalR6N3dFeGQwTVlTUGh5?=
 =?utf-8?Q?t05k3RA83qYnelUUhfD+fXBvy?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d699fc7e-eb5d-4981-17a3-08dd7ceb3f41
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 13:33:17.7729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rt5guGCoiMggIHfgY0Xts2i152/xL7us75iG/i5OLSIztQK3K+19WrlaFbpPzJa6+xppV41uH6wvCKFvBZiNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7341

On 16.04.25 14:38, Zoran KRIVOKUCA wrote:
> Hello,
> 
> I’m working on a real-time application using EVL (Xenomai 4) on a
> Raspberry Pi 4. My application consists of a single EVL thread that
> toggles a GPIO pin periodically using an EVL timer (evl_new_timer) and
> logs jitter values. I'm using mmap() for direct GPIO access and
> evl_read_clock() to measure timing.
> 
> The thread is configured with SCHED_FIFO at priority 99, locked in
> memory via mlockall(), and pinned to CPU 3 using sched_setaffinity().
> 
> Overall, the jitter is low and consistent, which is great. However,
> I’m observing a recurring and reproducible latency spike exactly
> around 4 seconds after starting the test. This spike only happens once
> and does not repeat afterward. Once past that point, jitter returns to
> normal and remains stable.
> 
> Could this be related to a misuse or oversight in my application, or
> perhaps some in-band task that is scheduled to run at that moment
> despite CPU isolation?
> 

4 seconds... you have been kicked out of RT by the EVL watchdog. And
that means you are trying to create a 100%-RT task which will starve the
Linux on your system to death. Will not work this way. Schedule your
work based on time or external events and make sure it completes
eventually. 4 s is already way longer than what a task should take.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

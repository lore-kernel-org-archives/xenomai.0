Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28A616C69C
	for <xenomai@lists.linux.dev>; Fri, 21 Jun 2024 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950304; cv=fail; b=h3Az//fwrvnav6uRW9F0NQXbQldaMd+v4rY6uR1UHEwkBPoBc5nmDmut1gCOybDT2ANP3AF3Vi9R0ScxWAoCyMeQ/bywrCs/ZQMh6ayi6XpeBne23C085vP454m1mLyi/DoOEQKVGpZ5x1xF6jMVJgqite+bCTf3FZRC8uVNF4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950304; c=relaxed/simple;
	bh=SlLn7oqlFfg/ZV/wxSEbbTWsdvT5Ie/lVO+iHhEF2ko=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZWbVF7m0dWAV06q/FpCo2HdMYGbSTX0kIEimF+I8+Mo1yUcyf8OaUXv8Qco97YOEy9WQBSFHIMpvk/UYFUWIgc/Av+DjOZzZ+jPTAGEpJKmQeN927IYmNkd4bPunKksE+cXYSaZrF9kyWiPDuL1dTKNY56VG7J5+F9LBopZBq/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QuzbKpMg; arc=fail smtp.client-ip=40.107.241.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QuzbKpMg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHWE/S9nj4yI/pHZiDuNG7c3hV38EwgLAzF4SN18Lo2SeZTSO80p1I/XCQrzr83njrL/zH9V135E/NuszLvRCnkvbCeKipSNd1m5oPz2LK+oGiWv4OyXL5sApBf/GVl33kOGZAZakryLidYkSXc2MRzlUko5Vte7QUXEfcavOwnEs1X4dLLyN4OwekPBgDxLK1jiNogNId5qBYpjhS/SxpjjP4RD8k6gw2JAmppUXDUawncFDy8l8HWRe/XcmNLFu1le+lOpwexBZr5hllE7sN2yNvZsGiASllQtj1Nh/R284cd6MS5EZ9EfjdfZSqY8Qeu32nG+MZf9jXWQkOsRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZCDj5ovia4Mnkq7kg6bdDKIZC3Csf4j0V5vcOKU8wk=;
 b=Rk7GHFgqJX4/OHoCdQNLLETy1esJ1tq+H1e5P0j4TSCWvnpIM2UYCvqi/kbnPvhXp9imjJXPVEceBd+IU5SmQq9cve53HCGTQ//FUaWXVPeT7LsdwKA86HWhsxRrYX1TZUIZIM7mtUF0oisv8FwjJJBd5syWsGcu60CGEInCyN5FzSAwpcRn2ZNcAqC+QqK4moPOGfvSkAQZ1XqejGOsXrgPXB/OE22f5FIR0hMxIdODcxc6FRBey9nM0JQKXUZhpNUSOXo4LiYWOs56Fp/ZNHKrvfRVn+2KvetadqKpcGDD35efoEis3QEamw2KtBvpOPMioK5KCLVg6f9xQtGqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZCDj5ovia4Mnkq7kg6bdDKIZC3Csf4j0V5vcOKU8wk=;
 b=QuzbKpMgpIFm+DEhg8jyu4D97lD408Xfni8o7aL9r1CvGd+DLz3RxHXTyA3SM1MWLCMi2WTIFNp1Q5UlHN9E72wA4mxUgqBU55vD66SL4l1QwGujFwhBbqIyeLIj+xQD9GdyqFGhcMCqF4eist4kSAtSMXGS5AIHsoj2PsyMpDBdmCOIzzNwVoAgmQ9RlmxesJfEqN5g5wibwm97fNF4L5aS0URGMQLWvQ4S9LLhNFdvEWprHxPCph50CCDukgvJZpmYC/AO8UDZ7FLUYiuWCJfd9cQpov/cXh4Is3TFPuOrhE+XnFcic07fCPgbK0xO0iYEgGhL9Rw0ejtPRjo96A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3610.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 06:11:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:11:30 +0000
Message-ID: <d9cabca0-2d0d-45e1-8c50-18c4a0c02ecf@siemens.com>
Date: Fri, 21 Jun 2024 08:11:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v4 2/2] KVM: x86: dovetail: Allow kvm_wait() to
 be called from any context
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20240531-flo-fix-kvm-guest-for-6-9-v4-0-77471c9473d8@siemens.com>
 <20240531-flo-fix-kvm-guest-for-6-9-v4-2-77471c9473d8@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v4-2-77471c9473d8@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3610:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4c54d2-45a5-4ffd-b5ff-08dc91b8fe64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXIwSzZhdDVaeE03SmtTM3E4a1h1aCtmOFdwR0xqa3ZvSUNZWmJiUkFRZjRY?=
 =?utf-8?B?dGpMbXR0bkZFRkpZMDc5SmZiV3lEdTVGMC8zRURuNGJkOWErNy9MWjJCNHdP?=
 =?utf-8?B?WDNodEE5Z29vVnphQnFYYjBnaGQ0N2tQRGplVTdVZWRDZkNDeWpudFVJVzZ3?=
 =?utf-8?B?dDlCVGRScFNDMnhoM2JMZXg3RmcwaU0xcTdueitOTGxZUWF0VUNqRzZmRlBB?=
 =?utf-8?B?OHpWTEJ3M3RjSnJiS05IZjgwNTFMbVVWTUxvZTNsempwRzJHeXcyU2hIRXg1?=
 =?utf-8?B?aVZQZGRTUlcyZGdLZmJuUXFQUTJaQkg4R0dHVENrdWF0WDdLV241SVEwUkl5?=
 =?utf-8?B?K21xNEtMallUcUJ1RlNWa1IvbHlLWkZUcGlGdHYyWGkzcVM4SnlKMnN1dWlo?=
 =?utf-8?B?UHRiampLS0Z6TVNTbTg5RC92amJvRldSb1ZuVTZaOFM0ZWxkR3RSWmxCcmdU?=
 =?utf-8?B?ZGZBUkhtR1YvdytUdWhWd1hKbnFVWDNUV2xna0dFSTBtV2VpdUM4RDlQTkI2?=
 =?utf-8?B?NWVQWklKVFI2SDI1Y2tkS0JwSTlNWXlQL2M1LzRKMGlVbUNtQzRndlNEUFB2?=
 =?utf-8?B?cG15K3VQbWJjbnUxL3p0NFhSdG9leWhURC91TENEK1dLckthOHF2SXF2STZO?=
 =?utf-8?B?VEFCRlpHclZqbS9OTlZlVjJvZVJDYXhacVpBaDRVdXZvaExQOS9pL09XeW5Q?=
 =?utf-8?B?T2FVSkRKVURvLzM4Y3MybWhNZWNXNkp3bGttV1FraUV5NzhmRmdkUUhhRTcx?=
 =?utf-8?B?WHZsd2xHbGYxY2RwdTVheGxySFBrSVF0V3ZjcUg5U0ZTbHVUaldkcmVNaXJu?=
 =?utf-8?B?OXY1enF5bHZYcVRQQkFrWk4vVVVjRURPc0drdlBmYnVLQW1DeUxmaVA5QkNm?=
 =?utf-8?B?bHdaVERQSHZ2dkJSTTM3QUZYRlFBbVo4UVZlTGtQR3hTZk5KYlE1N2h0Wk5B?=
 =?utf-8?B?SDJMblBvMGgwK0lKQkZhN3lvbTVhamo3TlRIYmZobnJSNS82c2xqTGdmZUlu?=
 =?utf-8?B?SDBBd25SL2xhbmZSYk5QSjJLL2x4MHdFR3BsOW0zZTZVUlBJaU1Cdjlwc2xS?=
 =?utf-8?B?YXoyRjY5UUNlaGI2Z3lRaDd3VWJneUpSOEZzOUd2UVQ4Uyt5N3NiaHBrQTVV?=
 =?utf-8?B?T05oaDF4N3FzM1pIQ2RjdTZNQktaR2tiWnUza1VzOVpJd0dCUHV0clJnTzhD?=
 =?utf-8?B?VitHT1dEYW4wTzNTNXR2dzhPcTgzN1ZxMmlWcVRQNUJmQWRSWmlnc245SUhm?=
 =?utf-8?B?QSs3RXVuSUxta2RkdFRzNmRYTEpJUmxiaHh2Y0xkMW93TVBrekpyQUM5UnN0?=
 =?utf-8?B?clRhcm95OHN4R2EzekdlRHRXZ2VnZGQzYzJyNDV1OWZBNE9mZGtRS2xQUzRR?=
 =?utf-8?B?dWUvb0Q0Y2ZUL1pYQ3IzdFFORk9IMFp6cDlzTHROK3dFSHE5QTN6d2tISzJj?=
 =?utf-8?B?RnRFWW15c29rQXNkNThWc04wZ1QyTVh1eGxvd1FDMGRKMmVLWXhtelAwMk5Y?=
 =?utf-8?B?cDFBcUx6YkRnNVppRlM3dUFLRFNDS0ROTDYzSCtadEJMTGFBMHozUDJaL1Nn?=
 =?utf-8?B?MWdjUGxVK0tUSk9rQWxSR2tYREdPSGY2TnFDNWpQdjJXRlVyeDdGVGtxSDhH?=
 =?utf-8?B?c09NaHNKdFpITVlJQXFwd2tGUExRNGFaRnBwN0EvVFFrZTEyM0VwK0o3NWl3?=
 =?utf-8?B?VnRaWlRwSXJOb1RZTjBBeTU4QlRJclZFT3RYSW41M1BZK0R6ZTJ1NmxBcG02?=
 =?utf-8?Q?ird93d74pNg0E/urtLUaqXq4vPuHhQXjm1IR4Hu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDZSckVnZzZBUjFuVVhLVTV4ay9hMEQvNnBvVHpjWThxVW93dmg0czhYS3FL?=
 =?utf-8?B?OXJaUzJjUE1JVGp4SlJoUVRLbVhKR2E1NGhNYnRtZTFGblU4bmRlOWJmNUN2?=
 =?utf-8?B?WnV3QUVsbjBtZEtmdmlCRzZLWG5MYVkwQlduQXNhMTBMZUg5aTRRQmNZY0pR?=
 =?utf-8?B?N1pzTlRudEJWalprNUVXbnFBSjZ0R21LSHljMWozRDVkMi9RQ2tRdE1IdkpY?=
 =?utf-8?B?b0xxdDVVWFVhSnhoNXBMVEx5RGh3V3dFR0plSDE4b2I2em1JOHJ5MTVyNVhR?=
 =?utf-8?B?UGUrK2FHd01iUXdUUERwOSsxRXhiRkh2TUQvcmVadVFsUkNhaFlDRHU2b2Fw?=
 =?utf-8?B?REVFL2hIOFdDL0ZKOEozNlRnRm5jUmlhUzRaRWRCbXkyeVV1T1Nmb3Q5ZG5z?=
 =?utf-8?B?bFJLSTJTWjJLcDIrRnVJdWtwRUlWL3pJa2ptb1U0aGRHSFY4N2FDZWNwU0U2?=
 =?utf-8?B?N29PTis3eE1iRWJrTHp3V2Zab2wxbE93VGVJSjZETUkzeFJOTkQ2ampEODY0?=
 =?utf-8?B?ZHg2eXR5R2dVRUw3SjFrV0l1SURDUTJiRkNublY3L1ZBZTk2WFpSdTFzVzVI?=
 =?utf-8?B?N1orSFpJRFdBQWxYOU9zQkJZNHNPUS94ZVM2ZUtMUko4dVlpNmRTWkJYTmow?=
 =?utf-8?B?M2lGd2k2TDk4RGNndlB5MUw2Rld4OGYvU3VZQW9NR3VtOHF1dTJOYkVJMXlr?=
 =?utf-8?B?SXBrMy8xdERaT0RHLzZTcnEvekQwbXZ4aWVNMTdDSDJHdFRjQkV2d2hSR25J?=
 =?utf-8?B?NytOblpDcno3eFFGY01JVHgvc0FyU0hMQ0g1S0IyOWxQKzRPS1Vwbmx3ZU02?=
 =?utf-8?B?QVE4QVJGMWZNMTg2NStHUXdlRU14VkRvd05IQXlsWTR3WG1leHYrNjljUTRw?=
 =?utf-8?B?ZjBKeS9POWlvL00rNUpHZnhmNVNaVmZySU50NG5tSVNwaWxyYVFqMndBQWwy?=
 =?utf-8?B?Q2o2L1p3VzZmbjVBOUlrS3gzY0RSNU9NbjFjTXhWN3cwVzdMUnNuOCtocGhh?=
 =?utf-8?B?WlFHYTNnbUx0OW9GT1MyZEZjby9NRVBHM3dYL0tWV1RjWlg1U0E1OHk0NklL?=
 =?utf-8?B?UnBlMmp2Um1abFZPZnBJUGl5eFdJRmlRdlhGV3hQK0dDMmF3TDJZT3F4czhl?=
 =?utf-8?B?cW8vYVR2bVhuWXp2WWFMS3FEcmtEeXo5eHY1d0g3NSt0b0JQMEU5K01sRUpk?=
 =?utf-8?B?Y2lnY1BsZ0M0NEFHZVB1ejg2S3RoY2Z0Zk5kbWV6OEhHNlJhSDZqd0ZYemJH?=
 =?utf-8?B?RUsrbk44V0tFTDNuVXA0c3FUTVpQVnRZL1JwVVd2bDcrWmtqNXVpQTArbjk5?=
 =?utf-8?B?NVljVmhjTlVCTnd1MXdZZkZ2SVBoK0J6bGF5K2lIemExdS9NUnlPTUZCOFlL?=
 =?utf-8?B?dndJOVJPMkczaEx1ZUtlTDEvcjlDZ2J1aGQzL08rY2N0OWlPTVI3d09KY2l1?=
 =?utf-8?B?ZUgwVEMxRXNNSkVwb3NkeFg2Wnc4ZGprRnFaTHJhRmFiVnp0bEdXalNOWE1h?=
 =?utf-8?B?MWhCalRkMXlsSmxoRllTbndIZzB3bmFnN0Vzc05pNE9PeFRtc1lFK25uODV3?=
 =?utf-8?B?K1FvaWNIZkkrQmFiR0FIVDQyS2h2dERwdjBBUFVCTCtZSWZITTZxZngvcXBv?=
 =?utf-8?B?b1VPNUxsMHo2SS9FWTBhdmVRN0REOEk1ejBLREZ4WW1kNisvN3VJM0hQQThG?=
 =?utf-8?B?VmR2ZWFac2RoSERRNE1QcTh6d1F0OW52QU5iRlMxd0N0RXhLN2pESmNEY3B6?=
 =?utf-8?B?MVlrU2dqd25EYXlJOVl5aytTbFlvdVY1bjFSN2x1T0pZSkRDbjQ3NTdDalQ1?=
 =?utf-8?B?b1Q4OERiSHdDU1djemNsOWZRQko3dXNaekxydUMva2wwODR2SkdyamV2WmpC?=
 =?utf-8?B?ZEUzbzFQWnhNbWdIM1J6LzlVSGx0UXdJcmhQMG02OEFRRGRvdkJzcDlzMHdx?=
 =?utf-8?B?VzdlcHJTYUdOMi80UmZPQmc4RnN5bk9vM0tEUG41TnVRbmN0Z1V0a3VrYmxk?=
 =?utf-8?B?VEVwTUh2YlByODhsUG9oYzNGWXAxaWNpSnR3bDVGRW5QcE5DM09SQTdCL1hX?=
 =?utf-8?B?WlBuOWg0Y3ZpQkx4eVZYQno4dGNsRWo4Zk8yL0o1VUtRQ2tVTmRZcEUzVEpv?=
 =?utf-8?B?eXM2dHNEK1poWXU2SmgzcVVsWStCcVVrZ0o0YUVydkdJN3N5cndvdlE4TmQw?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4c54d2-45a5-4ffd-b5ff-08dc91b8fe64
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 06:11:30.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuKLV5BFxYMfkRaOh+glw8pzKfTB/uWNcpC2HDE6hscjI3fyNEn9K4DY285hsPMgevzjLsnoutsWhuTj9T4DIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3610

On 20.06.24 12:36, Florian Bezdeka wrote:
> kvm_wait() unconditionally enabled HW interrupts when called from
> pipeline entry code. That broke the PV (paravirtualized) spinlock
> implementation.
> 
> The following calling contexts are supported now:
>   - pipeline entry, hard IRQs off:
>     Wakeup on vCPU kicks only, triggered by the current lock owner via
>     hypercall. Using halt().
> 
>   - Linux IRQ context, hard IRQs on, in-band IRQs off:
>     Wakeup on the next hard IRQ, or by a vCPU kick.
>     Using safe_halt().
> 
>   - Task context, hard IRQs on, in-band IRQs on:
>     Same as Linux IRQ context.
> 
> The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
> Linux to keep trace events.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/kernel/kvm.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 655b1cf8c9ab..90387564d06c 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -1059,22 +1059,36 @@ static void kvm_wait(u8 *ptr, u8 val)
>  	 * for irq enabled case to avoid hang when lock info is overwritten
>  	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
>  	 */
> -	if (irqs_disabled()) {
> -		hard_local_irq_disable();
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +	if (hard_irqs_disabled()) {
>  		if (READ_ONCE(*ptr) == val)
>  			halt();
> +	} else {
> +		hard_local_irq_disable();
> +
> +		if (READ_ONCE(*ptr) == val)
> +			safe_halt(); /* enables hard IRQs */

native_safe_halt(), or you get trace_hardirqs_on() and confuse lockdep.

Jan

> +		else
> +			hard_local_irq_enable();
> +	}
>  
> -		hard_local_irq_enable();
> +#else /* !CONFIG_IRQ_PIPELINE */
> +
> +	if (irqs_disabled()) {
> +		if (READ_ONCE(*ptr) == val)
> +			halt();
>  	} else {
> -		local_irq_disable_full();
> +		local_irq_disable();
>  
>  		/* safe_halt() will enable IRQ */
>  		if (READ_ONCE(*ptr) == val)
>  			safe_halt();
> -
> -		local_irq_enable_full();
> +		else
> +			local_irq_enable();
>  	}
> +#endif
>  }
>  
>  /*
> 

-- 
Siemens AG, Technology
Linux Expert Center


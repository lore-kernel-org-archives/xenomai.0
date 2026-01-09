Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290253612C0
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969528; cv=fail; b=HyJtgHExV0rbuLlgOrk7tyLgpje/29pTLfW7RLyQcKLwavcbHbUcRIE+9S3JApFOmLLt6smCCEWUlVdo1g+YmtOmB4X6tptQKXVbdNjvX0IavnNT1hAjVlaqAbmpLeTbujUBmw89YGAjCxTLbJuLGtFyV2FYLIqmd6rRl4er6nY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969528; c=relaxed/simple;
	bh=kvzwG71Z69swZTgyFUm1T1CSjcKhbvbt8WZ/XCuSBqI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q+CUwu2c4TenjV/YRxW5bm/zo3j3ZFvBQ5F+uqG9wp3jI/d5QK7QQio3s11CsB3HFXyKT18YoodIb+DoHdm2TIDcPvFjmEgLVpwjCURlEPnxmKQ0oFsUc7pLXKGLwFjJVEFxfsD0RE1SVe+00UbaRL5CQVfyhdRU1aSiOiNuZ+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=G0w6WNUW; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="G0w6WNUW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIpV7S4OQH5Ar5VR7S3mhluI6XFLiHDonAR9aeSGhBW95EKlPe1DMwHnFMSSr1M11HbKxHeQ1TjxplRwsAMoLlgm+nH6UW2S4X+vzUXDGq2YklxmSXj8XzELQMDCkTQ1BGsOCpOKVNCHXiZ2zNG6hJ+1TGwAVcIqwafEsOEvfW8shVrt4vnZ4Jc2fpBSpvZBsY3c1fev/mRygVLcr4yODAP6ZG1HgYbegfya/w3+8d2NdeeSL8J90khjemKiXTEpezE6nVKf4Ql4BgaWelyvUwWWTwKu4Xr7CMjiz6CM2jCRohPXor38bWDKNpvcITwg9HjJmeUCxGvRGG2rAS992Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxj+rE2yut5JljAlnF/NtRPe5eTESL3u95AAxW4VMX4=;
 b=PUHbKbEzfsbnG6MACiKHVnqcPSiu89ZiIwg6WXiKH0fUd1qzv/RnmYTvkvFae9WU66IROjznltXTyEKtViNJmEuWjhHAXxmWSBOEuOv07giW3tyHHwgcwa9N7BnCNYa3jSE7MN9QhjnxUoEJz75mghcKwvx6LLTjDlejcOBDUY7gV+D7u3iuAcNj9MeyAhFwv1AUAIIqtXinOGQKHpXdHUOlTsl/5qVd+3Kd8m7oouaV6PGL/VCZm9auCoSpfFBQGHDWz++7OzT2sNX60qceuKEZb/im7KvYcq+eS3ThO3LTip2LuRoqtcE05R41gbV7aAsH3pUDIFItIQ1ZI1oaVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxj+rE2yut5JljAlnF/NtRPe5eTESL3u95AAxW4VMX4=;
 b=G0w6WNUWRerTRIrDvHASSDMfhB8aDpXlBC5K2CwiRxjqY0sVSuSf7uf9ztY9fZuYUZmJ+j/MLFqQEuWvzin0NF+IFKcubeofwkYQGXie7+aL66swoSRUDcueN7pXYmcQDihbam41ZCDGbx/IDU4S9EG8dqEoOhh5S6UuRRzyLh0sBz+dDSGD8VVGZv0tU3unoDWRSVOj3ABmOGMPCBCbmjmNA5sbEsOOOmzmne5ywylr8udNOlUdRoMNHNCkvazT36ifKs42qPqUHJxYFy7yXyX8ffop3uh++YZszBdebYp6FIfohU6A3YxIybK6w1Zz6SuoRRiyeYBP/v4XCPzrYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:559::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 14:38:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 14:38:41 +0000
Message-ID: <6192c2c4-be00-497e-b41d-a7d1e9e344a7@siemens.com>
Date: Fri, 9 Jan 2026 15:38:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/2] ci: Add CI for linux-dovetail
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
 <20260109142001.2548128-2-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260109142001.2548128-2-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 91749d27-cc50-4aaa-edd8-08de4f8cc8c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekoxOGZKcHQ0Z1VGbVNVV09LUU11WGphTStPVkRoODQ1RytaL05oMGxRSk43?=
 =?utf-8?B?Qzh5NFJ2Ym5GNW9Dd1hJcUgySnBJdW5qSGZEeVQxQzBGZ0oya0NNeVgzZXlw?=
 =?utf-8?B?SXBBRFYzelpJVktiOHZsUWpOQ0d3WStrQ2FWd0kyLzhQSXNLN3F1b2Z1OXBr?=
 =?utf-8?B?ZVZ4T1lWRnFrSWN3Ylc3WWN3aG1tSUFMUklUR05jT0RQTHRkTmNmV2pKZW9O?=
 =?utf-8?B?Y3BBNDZkOGFpcTgwNmVvbnRrS2w5Mm1NZUhSdXhMT3BPc2hFL1kxdHdodWRm?=
 =?utf-8?B?UURnQzZkVU11Zzlia1hHb0RJZVZkUW90Y2xNRTVBbW5mTUg1TEQxWUh1cnNi?=
 =?utf-8?B?WUVVd3JGclk0MXA3TVVYQ3ZYVXhnRmVXeHhNZDFEN3Q4Z2RBcHFEL1M0RlA2?=
 =?utf-8?B?OGtQbTVmS3FLZ0d3NGNXblVNRjBqeVF0MmM3dUdxeVlpdU4vVktDMXVoRmJH?=
 =?utf-8?B?aFBpZDVBTGdnNE50QWtneWlmaXMrWGdQd0tJZXo2TmxuNFY3TFBGZHlUSjRX?=
 =?utf-8?B?UWQyMjl5M0t2VDdiVHkyNDhHRDh4MnRiR0lLWHNPRGc2bVNxSzBLSlRJOGxG?=
 =?utf-8?B?aFh5aDN2Rmh5bVJ6d25BSnllRlNaU2VTZlphcVphbUhEeUJwUDFvWXJMQ0FP?=
 =?utf-8?B?VXlDYzFORzhIZkd1SzBBRnZQYm9URWdXWnJkNitoazVIQzk2VmVoSTYyVWhp?=
 =?utf-8?B?bVFPR1dRUXd4cmt4RWNqYmhURVE2V21IVFZLWnJ2S0ZpZGJkY0ROMWVyTE5v?=
 =?utf-8?B?Y3QzbW55UFRNWGVhazhjR0pCN3BqTnk4QWdKKzhmek9EWDNXL0R3UGFXRFQ3?=
 =?utf-8?B?cElHYXBJT0k3U2hzV0wvRkJuNzBDREdOMTFhNmZseHEycGk4a1dQaEdkU1Fs?=
 =?utf-8?B?OHFKN0w3dyszN2hLQ3RUanRCWktJTDFHaGVPM3FZc21BNXhwWTlCWHdNdnVK?=
 =?utf-8?B?V2hWRjBrd3BnaDR3VzdnNHJMYW55bjVsd1dSYlJOZlE0ZjQrdG5FMWdiZnRL?=
 =?utf-8?B?dTZJR3hyVWF2TFUxM1k4OUdnV1hWUVo1QUlZVUVjdEN6Z0RqeGR3aEt3ZTdP?=
 =?utf-8?B?U29jMldKaTZsY3JyRm5qSFI4SWNLdVFQbWdqcTlqOHRSdFpER3FKbXFuZ2Zo?=
 =?utf-8?B?Y0plN0RnYnFpa05JaDZwcjRuQUZETTI1U0hYYTRyR1dtNWJCOS80WUxYYUg4?=
 =?utf-8?B?MFBxUFZLN3BQT3dvT1AzNnU2N3NoaUpZa2ZWWVFOT2xkMkVqRWhHNTFNYkVS?=
 =?utf-8?B?c216SURxNWRiNVA5MEJobmNyeXFXalRZdTd3Sk5xbDdrZ0UyNTYwVldxL1Ra?=
 =?utf-8?B?d0pJWngrREhrN1E3OXdrakk1eXJ2Z013N3FLWWJrbXB5dUQ5MFNYd3lBTmIv?=
 =?utf-8?B?RzFmQkFGY0Q0MzJYcVo5emVEWWNuODVkZUo2RlB4Y3djMDAzNTBsajU4VXh1?=
 =?utf-8?B?YVYxQjZmc0M5SVQwY0xYRFFxR3NncEhWa0pMalZIRW9lTEhVZ3EwaUw0aG9P?=
 =?utf-8?B?Qjd5bG8wbEExcU1WNlFpVDdDMnZzWVJCcHYrUFIzek5HQmhOVW5OUXIzVDVE?=
 =?utf-8?B?OGdhejhqZ1ZoeWhBdFJnOTRlRU1TRW82S1RSOVJldjdJc2o1YU02ZXk2Y01m?=
 =?utf-8?B?TUlPaVFwNnQ4c0lwdC9wWWRveGs0QUZxTVVuVnZsMTdiTm00Z282OXdzWE9u?=
 =?utf-8?B?RWxOYTNqLzhITCs0S3B0RHduUGJvVGpSb2l3ckNnL2luaVlKK2xsR281L25q?=
 =?utf-8?B?MVMyZW1PTVdPNmk4S1lJSHNrWHhtK3B4NWM3dlYzMlJrdFVLSTZ4SUg4ejFo?=
 =?utf-8?B?ZFh5R2dzeVFTQkU3ZWdWY3NGMHVLUU1tYytVWFVCRFRqK2xONHhXeVBHaWVX?=
 =?utf-8?B?QzF5ZFNLc0t0cWFaczRYMWFQalN4STJLM3JUdmt6Y0hDUU1BZkhnTGdFeWxa?=
 =?utf-8?Q?LBZkTgbkev6/f8cOHh909Cn6F3Bdu9nG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWJISDFWTjU2eE90TUZGOFZKTEtkeTVLTzhjTDR5Qi9LOC9hSmZnSGxIMXdP?=
 =?utf-8?B?UkUzRS9vYXcwZmhFcWF3eTd4R3RMSmk2VWNoNkZGZUp5Q1l0MGRxZ2dxNFdm?=
 =?utf-8?B?T2hZaEpIckZsVmdyZy9IZVBlaXVpU1IrUTcxYWpXOTZ4eGFPUFZwYzRERjZ4?=
 =?utf-8?B?OGxMQ0Z2TGxuY0d5cEo4MzRUM2FwTzhyVjRxQ3kwbXZ0aUJkOVo4QStuK2NM?=
 =?utf-8?B?bGNEVWVmNkZ2eHcrOUVRWDUwT2d5MGxGa1YwcHZram53L1NXTStzb291OUJ4?=
 =?utf-8?B?aUhaL0ltblFFQWdKWUdVaUpXcHZNY0wyK2grMmZKT2VpNkJCeUxSeWI4a1BF?=
 =?utf-8?B?a1Npb0xiMUJFVFZEVUkvOEFjRExrYmFITU5HTCt0Tzl3clJiN3FmUlhSekN1?=
 =?utf-8?B?RE5naXY2R2pNbnd6UTVia2sxUWhpNldpRU1CeThWMzB4VUxSTE1pbGxxZ3VW?=
 =?utf-8?B?VC9lUGxsRkNpNVVnRTNYQWVDczVzZ3IwdlA4MEhva3BlZEJLYjl3ZjdZcFFW?=
 =?utf-8?B?TjZXbkpwRlM4MjB3Vm9QQldvcnlOYWdrQ2NUOUlvbVBZV2lDYmZzWFpvcUUz?=
 =?utf-8?B?cU5XczBmL1hLZnFyM3RQMmtLWVVzQzZ4Rzd5eXpyODcrNDRYcDRrc1cvM0Z5?=
 =?utf-8?B?ZGdHRDdOTXZjS2MwY09xUUUwaVJVZjRIaVZTSGtEdzdYbHNjdUQ0L29yN3ZC?=
 =?utf-8?B?eEF2U0NDRFhGNWhTUkRjM0ZQVnFxSUE5WXFjb2ZXMkVUVkc4YmEvMDB3NWh5?=
 =?utf-8?B?MGxOYURGbUVKd0FNMzRscDdFUlc4cS9XMXY4ODQvMnFvQWJzc0ozVjM5SjJS?=
 =?utf-8?B?TjhzQ05zOWNYOVlhZk5PdUlvZzFnWUV2QzZrYVhhaWpVMGsvK2hxQStUMVRR?=
 =?utf-8?B?NmdsbWg3RVIrdTB2eSs3WEd4U1UwSndhQXRkZTFjd0tIY24xMnB2RlFmSmhG?=
 =?utf-8?B?NWRUMWRpV0NUbFB1M0oyVk43aStzQStIdXNLOGlnRXg5Z3FFZitvakhwYUNT?=
 =?utf-8?B?UDV5RUt0alpaZE9tRlFKNTIrRGt1cHZHcU9XYmg3a2w1bm9LUzl1b1ltMzA3?=
 =?utf-8?B?dEVsSmtFZzBZSnRJNUo0YVY5UHFaRFlULzczdDRFU3B5NjlnZ3FCb0pLckZj?=
 =?utf-8?B?dzdZeDhCczVEakM2ZTNtdGRVZUxERHJRQjJVNXI5dmRzTU9sTWNtbkRyejdB?=
 =?utf-8?B?dnRuWEZZOU1IM0I5emFVSldXOHRFY2huOGorSWVrR0dwTTFGVHpMeGtNZ3hv?=
 =?utf-8?B?YU04Q2dHOThnbi9Lb2dLb1Z0OTdZZXRYMWpCQjZDSWxOdGtBa3M5R2xXUDY2?=
 =?utf-8?B?VDY2SU9IcXd0S0lPZGNGZ1hock9icUNTWVYxMURzMDdxTWYzdEdIL0tMamNn?=
 =?utf-8?B?Y2t0QUpnUWlkZXJMK2hoWGZENXppQVYvWGlUMVZaa3hLUVhaWDBJY3FYcjBy?=
 =?utf-8?B?QTdDOHZEd3h0M2FWRXJ3Z3FqenNaYlhQZS9KNFphZmR1K2o0R2FEYXZ1QklU?=
 =?utf-8?B?alZQd09KMk1MbWQySVA2U01ZWU1ZRWVqenQ3cTMvaXMzWkpsWDNPYmdkNTVl?=
 =?utf-8?B?eFQrc3FwN2dEaXpDRlZxN3BTT2JhdHYzblpSTkU3K2ZaemMvQU9kZmJ0QStK?=
 =?utf-8?B?M1NZWDcxVXZ3ZGd4UGhDT0JzclAzM0dVN3hZRGt6NFRJMUVTeks2OXAvSnBq?=
 =?utf-8?B?TUQxTGgzcTFwYS8vczllSnFBOGVqR2djT0xHclNJYjlSTDlpYlBHS2YrQURp?=
 =?utf-8?B?LzZKamQzaU94OUlXajBNNWlxS0ZmdzdFQ29kWi8vT0p2amdHMldWNk5vNm50?=
 =?utf-8?B?VWVsMU51TlpaZkVDMWZnV0FNV0J2UTgvc0VZdHlrRUxOZGx5b1JxQ0tqQUF6?=
 =?utf-8?B?MWFhamZNV1pUKzBXK3h5UU9Fc08rSHVGNWNUVDFSQlNxcnRKVXRJZjlLR2FQ?=
 =?utf-8?B?bTh5cHZsT3IycXBLZjJsbVVXeGFDaWlDelA2cytDKzhvc2czVVZEZ0IzQnNG?=
 =?utf-8?B?SHNqb255amxCa1JKZ09WK3BkUSszWVlaR1hTVmo3cEo1elZkZUhubjJZc1ZS?=
 =?utf-8?B?dmh4MUNJT0h0Z3kwRmlDZ1RpQ0I5TmY1QkdIREpOUXA3Yk0rS1pSZlhmaVVl?=
 =?utf-8?B?THhGdFlPOGNwVWhTS0QzL1RKMWppZVJ4S29SSzBkaGE5aHZ2THNoT29nQ2h2?=
 =?utf-8?B?eG5CSmFraU00TXhFRC9MZmljdkxTTkNTOGN4ODVHcVloQkFiZHRSSk5ZdUlR?=
 =?utf-8?B?SGFEbHdBZERVTXB2MVp0NkVFSDJKcGRuZU1sOGdpbVJPWTVIdWViMVROditC?=
 =?utf-8?B?NllTT3k3VjVFeE5JVTlnNngvVDFueTVRVFFqanl3bjhBaVRuU1NHZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91749d27-cc50-4aaa-edd8-08de4f8cc8c6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:38:41.6850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3559fBl9mXc4JGemERqxWqITP4vQYCKN7sZtLCWpUVjkgKuMa2uCiYtsba402CwFApCwVvUQJiFEdvwI2Cypag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7981

On 09.01.26 15:20, Clara Kowalsky wrote:
> The linux-dovetail repo is configured in the CI/CD settings to use as
> configuration file this file in xenomai-images.
> This adds a CI job for triggering the xenomai-images CI if new commits
> are pushed to a supported dovetail branch.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  ci/ci-dovetail.yml | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 ci/ci-dovetail.yml
> 
> diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
> new file mode 100644
> index 0000000..52685e6
> --- /dev/null
> +++ b/ci/ci-dovetail.yml

4.19 is not dovetail. You will need a separate ci file for that one, I
guess (different branch names).

> @@ -0,0 +1,43 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +stages:
> +  - set_vars
> +  - trigger_xenomai_images
> +
> +default:
> +  image: debian:bookworm

trixie-slim?

> +
> +set-vars:
> +  stage: set_vars
> +  script:
> +    - |
> +      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")

This transformation is not expressible with gitlab-ci means alone, is
it? If it were, we would not need to run this in a container image.

> +      echo "KERNEL_VERSION: $KERNEL_VERSION"
> +      { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
> +  artifacts:
> +    reports:
> +      dotenv: vars.env
> +  rules:
> +    - if: '$CI_COMMIT_BRANCH =~ /^v(6\.(1|12)|5\.(10|15)|4\.19)(\.y)?-dovetail-rebase$/'
> +
> +trigger-xenomai-images:
> +  stage: trigger_xenomai_images
> +  needs:
> +    - set-vars
> +  trigger:
> +    project: xenomai/xenomai-images
> +    branch: next
> +    forward:
> +      pipeline_variables: true
> +  variables:
> +    KERNEL_VERSION: $KERNEL_VERSION
> +    ONLY_RUN: xenomai-3/dovetail

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

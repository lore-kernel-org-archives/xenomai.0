Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36BEC2
	for <xenomai@lists.linux.dev>; Wed, 30 Apr 2025 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745989696; cv=fail; b=LHVrosAOPGOfrHPXASwIT9WpfrIbmTj6KHAEGhDf3DNUevfoWN1dkOBt8G+8oUJG6j0o045i7Sl0rIQPOzDGV9MpM8TSHCae4KRv8KP58Blf0S6w8Jt/rneNUKlaOYqvoFsrqovnnO7q9kafx3YGO3Mv6b/iEMVypyMCoUOh3TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745989696; c=relaxed/simple;
	bh=htqfCG9R0UCrw1JTvGXfu4DP3uWbG0KQqC++jQj7esE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=raN3rD7yFP3h1YGGj9ukhReaDRksgQ2HALRbVCQ34mM7HFo5vnpnoGKp3iKKhfJ8zJ/Sz0EdaD4LPQVPItGEcXfrzAVAyL3/JzPvdcDsLtTh5uPOlGJ+W9FRf9r/EGFIH9ClKJp+grvwR5qWcRBcejI06G1Cs8jE4dn48GbbViM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=neCYhsbK; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="neCYhsbK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6dyCzwF2VvUlOw5Q/r4Rc3c/erfRPoMzEf3wM0044EbIMuyRjkl7mgWBnofsE3Ej/Xzep3ciJhMLZOfJgk9ohdWIDRtjU85SRmvtsOeF8jKQ3L/hpksH6k4hD+s7Lk8gK0e7mAb49l6b/QyH42EAfXjWRue1NLxr8nwou+6iLgec3foWqjEK0avowHgQf4WLQVd7g6tm3dahBfJL6FWxnw7nRbX4WeVT0726sPO94teE2x9iGecf3hioTAVksaEpuOGYDEkGfZEoLMOqAx/ekdVBTHglCyx1W2lfJaKN/vNPIhQ6nqXrcxDOfCMycWViEsSt98Y76oVCA7m1AA6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTZg6YdAE+mPniDjKHT/0WVdmCkfRrrfI4qi7LcK9Mc=;
 b=RmZMtXUWqHX/SwcG+J/S5kTocEBHK1jTa2W0xU9/uHSIMMsZdOmCAeWHcl6oLDKDX4V0zbYQFQMcBSmgBbePoKBbru8AlD87hVUgnmA1umIAbc7lVmLax+KARqs+mbRtV4Vl8+QjljpVEY71zS0Tgv2Dd/31/U/XQFcCy1o5ODFdJAQyV8WGU/8QWSgf9+laVZYZXhQCenj1OHMUdTE/N6fdUxoCfdKiQ5VapHpFweqZUvBkyAqMIOJrLsBgWofiZaydwIuG/cvys2D4Gkj1FNgoQpeVzL21ieC4DjBygvc+dKnUvyjIoQa3KzaG9QLjx59L8QYVb4TqCmc83aaUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTZg6YdAE+mPniDjKHT/0WVdmCkfRrrfI4qi7LcK9Mc=;
 b=neCYhsbKz8KECjEMX7m6/++f2cYUZWGaazvL/BcJxMdLSLo2D0sbuuVkhVR67HHh8OVkuK1BBUW0LQnWxq9+K7EAgipxqAVTJgx7aLs8i2VIUs69wbde1nIeAVD4PRIGmgtbHGaKTMkeUZGN0PSDPdsznY/eOKoDgiHEqXYGPoKqWzr6fDip3xqwi17luAPrjY8EOuYT91XD8iqZXNFJ/k09HW1LcGxJ1UjBV0rqFe2TyzXYqz6ws0+y7Cgf25+vEq1CqMOysMK6AT6A0fsyu8BsAwNhfrVQe1lmlkZzBtIQ2q/gaFeLhbmqj7O9Ctsf5PzdiTtTw64azKgl7nmWtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 05:08:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 05:08:10 +0000
Message-ID: <1fe7aedd-21a2-400e-b4b8-54720308530b@siemens.com>
Date: Wed, 30 Apr 2025 07:08:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai community call on Wednesday, Apr 30 , 2025, UTC 7:30 AM
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <PH7PR11MB7499F7DDE006A3A7291F61FAF27B2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993258CAA8CDDA598B287DF2542@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E32BB1968236810DF6B3F25A2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74993347DB8F72364025EFEBF2282@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499E7C229D3943554AE31B6F23E2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74997A20364527E81370A33FF2122@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998618D1F5B701C8C07330F2F72@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB749901F0793C63043273F166F2C52@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499534189182B1B56FDC426F2CB2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB7499D5045E7CD5CC207EADB5F2D92@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74997D0A2A025EBDE30826D6F2BD2@PH7PR11MB7499.namprd11.prod.outlook.com>
 <PH7PR11MB74998FCA330C96F94503AF18F2832@PH7PR11MB7499.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR11MB74998FCA330C96F94503AF18F2832@PH7PR11MB7499.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fe5318-be96-4b88-8dc0-08dd87a50042
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWZ2TnlvVStRaHNOY0ZYNmtVRlgrUVplN0VkaGZkTnRHdHYwQjN3RWUzZlJk?=
 =?utf-8?B?SGRvcjgvS3ZRNDJXNnZOakRLZnF3eVV1aDRtR0xwcnZEaGx1Z1cvT3podmVp?=
 =?utf-8?B?U2N5a25oZW96dzY1dytnSlVLaHpDVlljTFJEUWd2WENQV3JzVXdjcnlBZS9y?=
 =?utf-8?B?dGtGdUFEMnVwbjd4TUI2WlMrRjZ6d01ueGVBTlNBQURPMk5tQ2Rod3JwMWU4?=
 =?utf-8?B?dmtxWlNWWDU2N1NCTFQ3eFg4dUY0amNZRFphMm0yZWNDbjVHM24vREJLRlI1?=
 =?utf-8?B?RkhFeUkvSzhneTBxM0hmZUlTMTdPd2NvODFvd2c0c0F1NTNnUjFGZ3BxeFZI?=
 =?utf-8?B?Z3ZrRG8xb1VJVTNFNjFibzM3QkFGcmtLVEZGYjNHMGlqM1ltWFZhZTNQbjVX?=
 =?utf-8?B?a3h3MFlQaVVXNHhxZEE2OUI1R2lCdzdIV0tQSk5vaTV2MlRIdjk2a2xHbXVx?=
 =?utf-8?B?UkpUcnd4SDBKTlFqdUxkeGgyR0Y5Q0lwUmlkSGxjQWRjQ0ZiZWpVbk55d3JN?=
 =?utf-8?B?blBYMEo1U3VYRFIxTkxMZUFMLzQ3enFOYU1rVzR1bzZYNTQ2Y1BMcUFKVVpE?=
 =?utf-8?B?MW92VzIrNDUyWVo3WjAyMnZ4UW9McldDT0xsUFdubUNMUHFiNDk4aWRLc0FL?=
 =?utf-8?B?aDU4cVFhZ3B4Q0lMdE9MTExaNnlYMDNjMGhMdE0vTk15TU1ObFBOWjl0Z2tm?=
 =?utf-8?B?MEFQc21lSDJoSGgwRFdJKzdITXZ5TlBjRWVkS01LbHVCWmpXeGU3UEJOSkw3?=
 =?utf-8?B?Z0JRR0ZLR0o2Zk5ucHhsU1hlZFN5TjMxeTdSNEhhbXk4dnFtMlpvOVNycno5?=
 =?utf-8?B?WGtGZ3dFSnR5aTVPMWFGWE4yWURVYndNUEFnZVFXTTVWWURUQnkwWWM0OEp1?=
 =?utf-8?B?Z1lqYzFVRlVqYmc1NFJicXYxT2ExVkVCZkRDNzJRV29lQ1pDMVFLNE05Zm1V?=
 =?utf-8?B?aW5jaVRDNjU3b1U4bmlKa0VlUlR3RkFjdWhXRkdVQ1NuYTk3MS90RnZmRk4w?=
 =?utf-8?B?bE9YczJaWjBtdmx5cDVpS0QrZGdxOXpqcE82UmVnNVVaMlRCU0FvN3pNajFa?=
 =?utf-8?B?SGg2UFZCYkY1LzRqQ3BlTlFiQ1ZoeTJqbXZzRHA0UjVnY0E3UWJ5Z3lPcERn?=
 =?utf-8?B?NHJQcDRTWmE4cXY5VkVVTTdmamI2WGs4b0xCV0tVeDJ1b1pic05hTEZQRkc5?=
 =?utf-8?B?aTlOWEV0WEVEMWl0Vm53cFNUSlhjbHpiZjBweTF4OVBUV0JVMHJrWjNwaExF?=
 =?utf-8?B?Ti9oS2xEbFAyeGQ5cFhEUFU2SDJHSm5ZMXlvNnk2THhBa0lIS00zY3R4M3lp?=
 =?utf-8?B?Rm9KOHF5L213NmNydW44VGw0UWJxWHpiSSs5azd3NkFOVmhWSDgrR21xVmNJ?=
 =?utf-8?B?cU04U2xoNVNXQWtUcWRkMko2WXVkRU1pOWhlbGZ0M1p6VkxCTkVnZE1wNDZG?=
 =?utf-8?B?bkJ0V3B3TWI3c2VyaUcyWkZqQTViNUhaZzN6NHplRjZjdU5ZWGYvSjI5V0Zw?=
 =?utf-8?B?MFBmOExNS1RNbzRUelZtZnk3OGxkbjBJTFpldmZ3ajA2SXNONXhtRVRjNGti?=
 =?utf-8?B?a0ZjcXFjUUlHeDk0MGM3MGIycWk5L1h3SjJISUNsNjBsMnVaYzhMNHMrKzEw?=
 =?utf-8?B?NFVtemJUTHhxdGxndERwekVNRFl2WUlCcGRTZkptWTI5bDVuOFJWRW9sQ1JW?=
 =?utf-8?B?emlQOC9ycmlCVUNmRUFzS2ZlZGNEUEZlUm1RQUQxTU9la1IyK3N6Y3lmK3hn?=
 =?utf-8?B?WnFPVTQvMjkrOStzazNDQVQ0a3FmRGtvSU1VMVcrYk05eWNiUzMyRjZoN2E5?=
 =?utf-8?Q?RdVLOTVnWnqOGeNVmPNqarfUtnV9zrOlbn2DY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXJCbmllZE1VS3huQ3ZkS3ZVMCtvUzZxZFY5Q0QvVk1wYlJtQk42NjhBM3VW?=
 =?utf-8?B?M2dOUWhZU08yWHFBRzJqeUlXNlFWVHhCYzZiOExMR1VhMXpmU3Rmb2RyVlNm?=
 =?utf-8?B?RTB4NmQ5cmRIZXBoaXhjc09JQmtZcFVhRHdBTk95cWw1cm1jVnVLU2NaNi9N?=
 =?utf-8?B?VjI3Mk9XUkFZWExseFVuVUtCSDR0MEE0WTZaSk50R1RnNENGMlI1djk4UkVH?=
 =?utf-8?B?Y2t3U3lxOUhoTC9LbWgwL1BxbTVtWTdFZFhFSDRvd1VxLzRlalZnK2llS1pJ?=
 =?utf-8?B?TXNWakw1WjNsaW83SjJ0V242ckhZTUwwZDdaZzJXZ1N6SVIvVmR4cDZ3TUFM?=
 =?utf-8?B?di9aRzJpVVJ2cEVYejZsZHBib2Zoc3VoVTJEaSt5NUxtcVJVb1VOTElWbGlQ?=
 =?utf-8?B?dHdqOTFMWWRHL2JnNVFpQyttRFlDN0lpcEhpNjd3YzZOZDI5bTlMOEdTQ0F3?=
 =?utf-8?B?d01WK2NyV1dwNXhoamZxSUljcGNGTGczWkt3NTl5dnZxZXNSMDUyV0djYmlR?=
 =?utf-8?B?aTB1UFhSTU5KRERmRWNYTHFaNG9BREt4dlJLQUliYWlQVy91VDh2ME9QYzRw?=
 =?utf-8?B?R0J0bXRnQ09HOGN1ejNZeEJWL0QvT0JOeWpoeUxxbHhYTEtpek5KMStmeGhn?=
 =?utf-8?B?ZUZVNFBoaWgvUDNlbGF3aHQyeWFENGU0cmxmWjBMNnBpVnNSL1dZU2ZPYTFN?=
 =?utf-8?B?cThlS01vQjBzR2xIRHNyVjVRVEt3VFBJWHpJLzJNNXo1YzcxbXV0RWI4dHYx?=
 =?utf-8?B?SGxEYWpoWFY4WitsZFpaWkpTbm1YU0Zxc2JFQVFIWFJ3aFljWlIrSWRNNWs1?=
 =?utf-8?B?M3lDekMraWdKS0c2WFFxRm1LR0NPRVVNc3dUZ1Z6S09PRjB4a3JyT1oyVjVj?=
 =?utf-8?B?dVM5ZXJ4MWpYS29nVFBMNDA3czFwcXhCZ2UzYTN3QU0yTFdXVnhod2ZuRllD?=
 =?utf-8?B?MWdmd0ROd1pvQVlmQ3pFOTlPQS9TZ0t5dUtHelhUY2RFZXpaU2ZtWTEwNUsz?=
 =?utf-8?B?UXpaWWNoR3hGZ0RtUWdlN1lJZ2FrcFRCckxjby9KWGt4QTlEK1J4ZVV6OE5o?=
 =?utf-8?B?cndmZUdRdEcrZ1hxMzFGcFEvdVJxeXgvc0E1VUtxd3NQdm1VK3RTVWFRL1Ra?=
 =?utf-8?B?eitPTTVTd3B5bmZUbEZIRnlEYjN1VTVTaWdzd3F5MEswSnhwNWlqNklHdFFN?=
 =?utf-8?B?bzBVeWJGeGZqQ2cwZ2F5YnFDNDJ1dnpLVkxVSkdaNWRIbit1dVR5Yms3NG4r?=
 =?utf-8?B?QmdaNWtZY0xFZGwyYjd4ckx0SlAvTi84Nzcyb0F0NDFJKzc1MndVdVcxblFm?=
 =?utf-8?B?SWorbkZRNWZPSlI4QzcrWGdOM3JFZUd0SGo5bW1CdG9hdEdtZERHdjRFRG8r?=
 =?utf-8?B?V04yZ0pYNDVsWUtkWnpDQXlYVm9nbkg5cFYrRlVUWWpyQkhiclhVcjQ0RWlD?=
 =?utf-8?B?NFZaVDExQUhIVWdLalMvUTcvYkU3Y2xCY0drS2gzSmt6eFNPYUtRYWwxdTIy?=
 =?utf-8?B?Q0JvcndHWW15OVc4RHBLZTVJWm9UMHJjdmdpYi9OajNkTTFqVEFxYXZ0VFlk?=
 =?utf-8?B?M0JENVczU0tlRGR6VkVSNmUzbEZkck9jREtHemlaSVI5VGN1VlhHWng5LzBJ?=
 =?utf-8?B?VTYxRXduVVJreEdOWjFDdUFZbVNtUUpyK1Fnd3JubnVWTnl4akNkVUJhYzNF?=
 =?utf-8?B?SXNOM2p3dXNzQVhZcGFsOHJDQWh1ZE4vaGZEb01UcnJoUlJBaUdUemhhaW5o?=
 =?utf-8?B?bUtFY0FZbkRET2RaVmlkbldiejYwbUlMK1lkR3RqWjczQ1BjTTBQR2N1SVd6?=
 =?utf-8?B?d1RhR3FYRDZDSk5GWnRJMDdmQ1JYYjIzTGxIVmwvUmluT2RMR1creVZHa2xI?=
 =?utf-8?B?T1NJQlVGd3JCNCtrMXIvbVgyckVZMW4zTXRWaWpGbUVvbTBrZHNmTVYyVnFJ?=
 =?utf-8?B?SUphQ1FmQlRGNXVNdlFtTWE4dlRjR2hFTFAyWXM1OXJFYjZMdFJpQ2xQa1Iz?=
 =?utf-8?B?RnZ2RHVBZTVPOHBURlhZbEtKM3hSalJwcEQzRnJ3UXAxeW9qSzUza0x1MVVy?=
 =?utf-8?B?Y29tQW1kSWQ4cUYyWmtqalJFanl3YWlqTEpsdmRHNHFPMVhCbmRqZXpqVFVN?=
 =?utf-8?Q?BKUAIthzP62qZ0yaQO7UgAUH/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fe5318-be96-4b88-8dc0-08dd87a50042
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 05:08:10.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZWH8eqS8HAH6iEBvrZCx2W7W1hP5dBtpmPB3EoOO2CVWgTuug94AOBE6pYsqamZkFtUYuJUeKAC5js2RhMWbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

On 30.04.25 05:00, Chen, Hongzhan wrote:
> 
> Topics may include but are not limited to upstream/downstream project 
> plans, status updates, and technical discussions. It's an open online 
> meeting that anyone can join and ask questions.
> 
> Time:
> Wednesday, Apr 30, 2025, UTC 7:30 AM
> Paris, France CEST 9:30 AM
> China CST 3:30 PM
> 
> Join Zoom Meeting 
> https://intel.zoom.us/j/91297279269?pwd=WmdwS0pDODRNMS9tQk54Y1dvbFlqUT09
> Or
> https://intel.zoom.us/wc/join/91297279269?wpk=wcpk52a9f96d989e7e20b628c2c36e48b68e
> 
> Meeting ID: 912 9727 9269
> Passcode: 367528
> 

Sorry for the late notice: I might be a few minutes late and I won't
have much time today - but I will try to join.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7C2F90EB
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981013; cv=fail; b=HUxYG13cfBzdKXz6+7AQQfXPaSF0ACxprurQjPXsCfud58e5/JtVTi9vwnf6IS3xpFdjlZKidzoo9CwBy7KqvRJXgzG6oe30nuJq4MTTbpTuxBhFgURuwUxRqiVAPh21Bf+I0s03XRNZAAvvWkJWPMlAIU4U0T1BoUDncYG+wAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981013; c=relaxed/simple;
	bh=PeTRu7DR/MMDJTW0Jp0DT0DSlIARqKBbKnbmoIJMcrU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KiFNvNEhB9ilXxHEOWqLyTZzIcJ2OoM+0O8XG3eg9CG4NH870GFBOLt7I+igMagUa3M6euM7uDmsPAKv/C6kHEjSSckToxM/++dI4Tm61wOpFJIcru0a83RgtJ0cCphwJI0B1JrBWrYmMM5QweIvyIt+DBEC9vDX8TVCHSVLHig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NyrSly/l; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NyrSly/l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdZYsJiJ+fdez7N95HjmM3NWdHkDDf5gCRczzrmtGpwjO7PHppVOoVHffYV/JqA2rEQmg9KtMGjxgPMzJJc+Cx5DERc5rlxUJgB+egvyuA/OtBJaHOMMnJapZrcPsRMcA8Or94AYIr00QfLhxHOSX/BL2z2PPNUdqqBTCuxMAk/MLp+ue4aulvm+qbQMLVB0YAunNPuAjKlFu1UmYZH9iHi3yGhn2e6rpa2B3Kw/Qb+XwnwcLcqSvEPt96R8upNcFwLkZvoDrW2klIYz+tIj9pkwkeNhEWR6w/lfbomwtib3hajc9la306shForzJ/0r8Nw/76NlQkt3bSfcaKmDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMc8MR3Lp+qseopKim99qBmsSpQXIqnxEeQUTUoiofQ=;
 b=EELRFbLptsXBL7gUyx/wuzYPcz02OWTGqqUaa06lyQ8EJ7WpxWEW7HaZMPY4HRKfdkZis0LrHy+1F6P3TWJz/Y+Glvv7B6s514rVB4mJsrlfv0WO7axIk+Op50P/kMr4no0hquxNewswEc4pFfhbK3i6QO6yrG1+xLm0ix8EIUzT/8KjSDegYm+me1oaCwc8aStuCIR1V7QjTiLwAbMxB2m0c/cgcS4vFx6MQWEAV+Q+dUCMLIMFa986mGC3s8C5VEJYz1+VUAWXLYqR+NI8AXi1QVgRzl9MIebfOi/soSC9nvMo7DQenHFZlBEeTdoV55fSJzYIeXRnlyCYtQTWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMc8MR3Lp+qseopKim99qBmsSpQXIqnxEeQUTUoiofQ=;
 b=NyrSly/lchcEg/W/4QYnPDGC9cCm9gq5uxOV2uJJstCjxFQrjKJLrCVz62ScULNj3vxVv3jnFJvqQ/KrEigGqReA0AgLzXD9HL1BkcGdo1b3d2DxEz0348rhszPlK7NbonT+pX/1iQq1wYr7Izt9TRaoK3E/53eyYblwVlkFQq4iy04I8oFmL6jUPmvJpTnO0yYD/Rv8L1ElbnKtyOPfFlNNs2Ifjz8wtrk887CO2zzC/eBzxd5uDR4WRziUHa3klAGe6yjNL6AazzcPSaF65BGAVMGoJ69KpV2+MOTy9bzDC2ffLKkxsuBnjSRYAm4TFL68uA05qz45otjhV5DQXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS4PR10MB5646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 10:16:42 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 10:16:42 +0000
Message-ID: <def91a5f-1642-4374-8498-9863468f115c@siemens.com>
Date: Thu, 4 Sep 2025 12:16:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v2] ci: Retry LAVA boot action up to three
 times
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: quirin.gylstorff@siemens.com
References: <20250904100307.1096684-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250904100307.1096684-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS4PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 453ca673-c4ce-46c1-fbfb-08ddeb9c2494
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STR5UUVNbjNMdmwzNHgzZHZrTlVjYU9JdjBOWE9LU2FyRWZqb1gyUmVIbVZS?=
 =?utf-8?B?cDEwVXhSaXhBUytHUGJnMU8vemdibUpwTVlqdTZIa2lCOUlDSGVlKytMc1VW?=
 =?utf-8?B?Y20xZnZVWGJwREhzbXZWMFJFaEQ1L2J6WkNGUmtYajFGeGtnQ1VQcmdiSktr?=
 =?utf-8?B?SnhLSldsQ1BPb3RCd2sxaFpCZWtBVHN3VVl6aXlLNlg4M1ZtVTdBNGVGVm9O?=
 =?utf-8?B?aE41R3Z4MHYrWDFJdytVYkZCcmVLL2lNRWNzcG5lbSs1N2RmUmVka1VVK3k2?=
 =?utf-8?B?V3gySGxpaEd5VWlnYkg2dUw4dEJxdzVXSjg0YTV4bnV1aUNYREd4eGNIUlFs?=
 =?utf-8?B?QWgzUzgxWE1icFJzaUVyRjdrMkRGMDlMLzRtd1k4R2lwckN1Wi9JQzFRa052?=
 =?utf-8?B?Z0tOeFl1dEVhc2pmNWJjcmxNMy96RGo1UzZsVUxWaWpudFlzWUVXWnQrR2VC?=
 =?utf-8?B?bmNGOHcrVjFIdTB1K05JTmpoNDIyOURsMXZGa3BNZStMWmdPNElGM2NDTUpT?=
 =?utf-8?B?RlQzU2I1bk4yblZVaTBPT3owbExJZnE4WWEwQ3l6TFo2ZVlWeWRQM2pMckh2?=
 =?utf-8?B?ZmVSV1VrVXZMRUh0S2dibUdHVVJxMGlDNWJycUsvQUhHcTZKdm01RkZOM2ow?=
 =?utf-8?B?WHRLc0lqQzdsNkRqb2pBVEVubkdESlMxSVR5SVJLR2hJMlRFMzRvODNERlMr?=
 =?utf-8?B?TitGU2xDUlNydmt5TkRGMmNXalA3K29pTmpIbDBKNHBEaW9OOGlwTlY2OGM3?=
 =?utf-8?B?Y0dCZnJjZWRoZXNMTHRUM1VjZmNCNWZ1WGJ0TlRXZDRDaURnRkFYQ3FRYVE0?=
 =?utf-8?B?bEdmNFA0YWhaby9zd1paV0JYamQzc1dGY0t6ZHRlczBJellxanhSTFdKZXl5?=
 =?utf-8?B?dDY1NW9LM0VyUDJlaURrcVFYYmRtY1Bsb2RtUjl0R3RYRWdQam56MkRybTIr?=
 =?utf-8?B?ckRZdUxseFFEM0huWEUzT3BJUWdCdnFndzFGaXQ4MjhOeTJ1Ti9LRzBNWkZw?=
 =?utf-8?B?d0tUOHJCTFVWbXFVODBCVXRDNDFqOXEyQVh6b0tXY21NU3dJRWtGb0E1SmZl?=
 =?utf-8?B?MWUzRTh3cCtjblFQTTE2SUF2MXVIQzBCVzFvbCt2cXBlVnVYQWFENHhNYzBi?=
 =?utf-8?B?c0QrMVBFVSt0N3dRSVN1bjUyZXhvTDArTXVzY1NoM2hXUjBORWNDQWUwck5p?=
 =?utf-8?B?dTBZMVcxRDFZVDJLMUMySmJDcDBlbWM1ZkpCdm1nUkRWZzNRWFZmMldvOU5W?=
 =?utf-8?B?aExBRWdxeGhld2svS1Z3OC9mTE5tcGhMMEFrQ3VmU0kzQlpOZ3VTN2Rpamp4?=
 =?utf-8?B?aFd5Yko1dVYzSDlmV3c2ZmlCNlJtZHY3NEErTktlY0ZTbzNrVG9ueXhhbzg2?=
 =?utf-8?B?S1JmdGlWc1pVRS9NQXQydzhaRk1LMjFjaU5LL05WVWZ4QlYxaHJVemhVbFZD?=
 =?utf-8?B?Nk0xMkNzaEVyWGN5UnhLd2tGQjJ0V3lNQzdwZ0QydG1OdENIVFhGc3BucXgv?=
 =?utf-8?B?UVBaZE5BMmVjcUNlVXphOHZ0ZXo1QkZNWXdqNjZRZ0t1Yks4UmI0clV0cVBJ?=
 =?utf-8?B?RUNGWG9tNzY0T1gyU1kzRkgvZTJqSEJrQjNTeHNaSGF4Y2pUVEFUcTRGdFJM?=
 =?utf-8?B?NGd5R0x5Zy8xUzRHNzVTbFU4ZmhNT2g0Q1JSRW82bWJXcGFwV1lzYVZOTzhT?=
 =?utf-8?B?ODd0eGZtUHpHazFvTjJ6d28yUm51eHVENGVUSkV5ZkR1WUl6TkR3YThvRndX?=
 =?utf-8?B?VDlCcEtwQldGeHBIUjZMZGpQdGszYmRXcG0xYXIySjVBdzR6ZFBVd0RaQUhp?=
 =?utf-8?B?YkI4RDVhMDN0Mno4WS9pUllvZU83aXdjRkdLN2dxUFM4b3Q5bERjbEtvaXRo?=
 =?utf-8?B?ajRqalgybmJ5SGkzbWJQeDRUU0labm8xdHdLVzBKQkN3dkVWNXZSRmRCQXRi?=
 =?utf-8?Q?g0D+AAB4ZJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDBPWVEydnNsUkFnSDI2dkJyajNGeFdEdnpsSFh0N0VqVCsxYXZOTHYzL09z?=
 =?utf-8?B?QVVybGRiZEFXUmJjUzZMZ2dpU3YvMWNFbVdJUVhmRU1iZlpxSUpCM2tKMkF1?=
 =?utf-8?B?Z0psU3FlRWR1c3VmbkVHY0MxNGhuSDhSMlhDWGJlbWl4Z1dxV2tiVFpoMzZN?=
 =?utf-8?B?TU9LVzQ4ZklINDhlWkNUWXY0a2IvK2xRVjAzd05JSC9aV3F3RCtFdkFqTlNt?=
 =?utf-8?B?bEZVT092QlRRek84L25FaWEydVdiV3hCMFVzd3ZHYXlJZ2RHeHBlcTRhS1ZC?=
 =?utf-8?B?WmUzYnV6VW56K29uUTFMSEMwelNtdVBSOEdWd1NYUDhQaWtIWitqSlFvQlR0?=
 =?utf-8?B?WFVhcGRHVFAxS1pMYUxQVmpaS3ZsZnROT2hSMllKamVVVHhzNk5oUHlvSmpj?=
 =?utf-8?B?OWtYcytLRHdMQmhjS3hSeGxCM1hDUHNiMDFWcVc4Z3FBbFdzYU90c0w3ME01?=
 =?utf-8?B?QmxITWRoc3JjSGpBdHhsS2lCWEdKdUl4SEVkeGFORmlRZXpLdW1LVmhzaDVP?=
 =?utf-8?B?cE5qcThpVXZtQWx3aFJSRzZ6VHNDZmJYNmtnTDRCU2lZZllURVJJMlBXUmR0?=
 =?utf-8?B?clErSDY4ZG9iMVBwL05hdFV5QmVjbWVIV1I1cGE5b29jM3FMQVlTSHFQNFB4?=
 =?utf-8?B?VGFVR09jNlZ3OU1OdXl6TEtHRm5oWVhZcjlRWm5Qa2Y0T210azZabThidWZS?=
 =?utf-8?B?VVZyTkRobjRmNHBmaldGVlpaQzNvVXI2TDVCMUQvQjZRTkJPUDZHUXJJTzNY?=
 =?utf-8?B?TFpTeG1DTmpwaXpWVHZjek5iVzJFdzhZbEdTTk9mdkI3dmlHUEVLREltRzBL?=
 =?utf-8?B?a1pucHQwbUdiM3BTSUh2bFpiTzlFQWdFUVgwekhGRytGand5NWJtdjk0YkdD?=
 =?utf-8?B?NW1pUmVRSVZPR2Z5Z1hqbG0zUFJMM0hxT3lQZzZWVFJhbWdIUUdjS2tRYWhZ?=
 =?utf-8?B?SkpMZFJvTnBxQmUzUzc0czEwVFg0ODJkbFJEL04rdkN5TXk5YnZhUUdXdWZX?=
 =?utf-8?B?ZnUwRDFlUG5nVU1yRmpQSDc3bHEwTzJSbXRjTlhBeXJQR0FpUFN6UnNzVzY3?=
 =?utf-8?B?b090Vm9PV0IxWHJndGVIZlF4SjVFOVBjMFJlTEZUU2JUVEU2aDNyNHdFaTFz?=
 =?utf-8?B?ZTd1QnFPNkVjckp3WlI5MlZ2ajZueEpsV1h5cWFuWmJzVFFTZ081OFRhZ3lP?=
 =?utf-8?B?b1JQelIzckNWNmw1amk2am1ZUklNaXpGVmRIS21jMTM5Z2Q2V1hLVDJ2N0Zx?=
 =?utf-8?B?V1lUQ0UxRVh0ZmNNOGk2YndMaVlCbGpFOTZCdmdoSVFDaW5jb1FOaTBoeEdv?=
 =?utf-8?B?RlFBbFNlcmNkSHMyTUdxZStybmgwQXIwQ1VYQlJUQ3pRL3k5VTZjeEFtZ3Fl?=
 =?utf-8?B?K3FIN2lSUUxFTEdOYWN6SGoxalBEa3BTRGZVQlhMTDczVVNMVWlaQ09yaFgy?=
 =?utf-8?B?cDgveE55dW84aGNFOExCSmRXd21QZm1PZkEybjJ0eTIzbS9EVjRrd2VZczJD?=
 =?utf-8?B?STdFemJnRngxTFh6dkVYVXEyVVlTY0tldmVWcHBIVEIvc3FuWWRmQ2ErekMy?=
 =?utf-8?B?OGNrWlpqeG5UaUdpMk1ZTlQ2Q1k2cTNLdC82T2gyRm10MVVaK2lSTHF3Smxz?=
 =?utf-8?B?Y243WkZvUXBwQTgxSTVRZUlJSjBxNlljRDFMK2dmci9vam5ORmU1Q093M2kx?=
 =?utf-8?B?OXgzRTB1MUxCTE5NTmliT3JLOWZxRkMzNlMxNTBWclA2emtVbTVFc3poRGU4?=
 =?utf-8?B?OFVvMG5WQ1ZZQXpxSEZnR0ZuNlJDMUgrcy84d0FhcWxDUitMR0RtTWtScXNL?=
 =?utf-8?B?Y0JOMndkS1Z2WUQ4Mlp4bWtHTHZ0dDlyeVY4djBnelhKY3FBRnF6VzNyWDdl?=
 =?utf-8?B?SkE3MWlWbW5SYUIyVHpnTEpCZUJXbGZQTnJYbTlVNTd6THNsTUNHSExDNWV3?=
 =?utf-8?B?d1g5K0hVdDdmWElQMUtEakpSNk1lcllkQ0RtTHhYZWFJRUV3dHBROExXT3N5?=
 =?utf-8?B?QWdTOFZvamZMdTZ3UENzYVJDUHZWaTUyOHduTkE0bWxZVjArVHRTL1hRVUdn?=
 =?utf-8?B?NVoyS25mZXBwNEVQbGtxNFV5dktTSnRzOHRPQTB5L0NHZTN4eGVPWTY3cEpp?=
 =?utf-8?B?eTZVdk5yaXl5dDNsTENOWVJEWmxScnhST3Joc1hQMlRBclZpbFplSkgrb2Q0?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453ca673-c4ce-46c1-fbfb-08ddeb9c2494
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:16:42.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVzBDHl49HmEDz2AzPtsNb1/0/yAOUp1bCQS5WuMBeLeglpjWbhdqch1X+UE7WRH2DSH/ITIPiG16afzNjOqvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5646

On 04.09.25 12:03, Tobias Schaffner wrote:
> Increase test robustness by retrying the LAVA boot action up to three
> times on failure. Failures are detected via server-side error message
> matching. This logic will be refined in the designated repository.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  tests/jobs/xenomai-beagle-bone-black.yml | 1 +
>  tests/jobs/xenomai-hikey.yml             | 1 +
>  tests/jobs/xenomai-rpi4.yml              | 1 +
>  tests/jobs/xenomai-x86-64-efi.yml        | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
> index 8e47dd6..b7a95bc 100644
> --- a/tests/jobs/xenomai-beagle-bone-black.yml
> +++ b/tests/jobs/xenomai-beagle-bone-black.yml
> @@ -41,6 +41,7 @@ actions:
>        compression: gz
>  # BOOT_BLOCK
>  - boot:
> +    failure_retry: 3
>      timeout:
>        minutes: 5
>      method: u-boot
> diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
> index aaf8949..27beb07 100644
> --- a/tests/jobs/xenomai-hikey.yml
> +++ b/tests/jobs/xenomai-hikey.yml
> @@ -40,6 +40,7 @@ actions:
>        compression: gz
>  #  BOOT_BLOCK
>  - boot:
> +    failure_retry: 3
>      timeout:
>        minutes: 5
>      method: u-boot
> diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
> index 50ff9ee..4074825 100644
> --- a/tests/jobs/xenomai-rpi4.yml
> +++ b/tests/jobs/xenomai-rpi4.yml
> @@ -40,6 +40,7 @@ actions:
>        compression: gz
>  #  BOOT_BLOCK
>  - boot:
> +    failure_retry: 3
>      timeout:
>        minutes: 5
>      method: u-boot
> diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
> index 4f1a7d8..0014429 100644
> --- a/tests/jobs/xenomai-x86-64-efi.yml
> +++ b/tests/jobs/xenomai-x86-64-efi.yml
> @@ -41,6 +41,7 @@ actions:
>        compression: gz
>  # BOOT_BLOCK
>  - boot:
> +    failure_retry: 3
>      timeout:
>        minutes: 5
>      method: ipxe

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

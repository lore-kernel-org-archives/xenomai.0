Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2067.outbound.protection.outlook.com [40.107.247.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3031D1312
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017071; cv=fail; b=jqWVxl3mXffzSIlYskUFgkIJyrW4vHV4vo59V77EJ9+lGjB73XwluYK0fmoL7zuw2GgmQlRDwVzw3BPa5gw3LJYc3ts83KKpwE8IY04/Z/DERWkWlvppIDWTESVr/nuCH4gINllimcB6iHdcEgsmJe6qp7I9U2Cd+U4sSOqSZD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017071; c=relaxed/simple;
	bh=70Pts2eK5o2tRZpX0Gx3DWZm1oXSAGZul9ODunwmik8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wog8v/qCD/ZiRT8txu0r0r290iIxv8d3vrFuTGhkW7WkCsNVWQRgQKh+hfFzbRKWVacjyMaDI481XqplhXJZp6pBZRHOl1fP0QlXb17PIVb1BU/cu85SJvtJBCYY8yxg86EOYgYgAu9R4ttebENrjh/NWwBlJqJFKI3ztlyYKjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pUJoX2JS; arc=fail smtp.client-ip=40.107.247.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pUJoX2JS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWoVl3mGzGONkCYkIITHk4ymRGqCCuPTOsJQVHFwtnjbGIdoeqsFDuKwAERyLR02RV4N+HEsJOn/fPooQxluIuiCO0DMYKJiODX67C82KIwigjQcyEMNLxxsgykOduhybX6bWxuBt8ZI4zWLLGrYh8efueJIHgP7WWgCYNpR1BXSxBhPJw1gJQdm8OavO81K2kkAk89jEB+x93q9p9xTYykwhGEzv8U36d5EcIUIbcze1DJl18zSGEa9eO9QXoHePcf3fLgpXzJ6DwosazUpcD//db0Avf7zBUqmq2PhLv0FjgE9EHi5mg5erGMsB0uuHicBZFTdfQaN49JoFDtNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA3hL8seOu5LqVUGtITlmoXUJpBppODIHpmQO48LUPw=;
 b=dswvewYweJxmmrapiC7ZK/m5vySPMN+MzQZ2L+QT2Rls4/S+BT6g7dKadflWDdLp1Wkci77COFX8shYq9GdWwKRo9kXdqiPmwiSRzuyOgP/cOGwx0fzdgTmEGF8SW8brHTcFUFI84aXUAV+8ZyMn2dwk8gDsFJtW3sxEzcB79Lavh/ucGwm2Q4rHnCerAmmS8kvjD9GcuTaUk2A41qi7bp8C3Qh7FYN8jNVEEILkONMUvdL4Z2p0PhreLtDFw199MFROLnrCtSFj7e9MUg3ENKhxny8IIV5oGN4h1au02PMvoDUMBjjngd6PXvCiMUssycesURBa3WhpQWUwMtflOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA3hL8seOu5LqVUGtITlmoXUJpBppODIHpmQO48LUPw=;
 b=pUJoX2JSszI78yxNU8NsgytGI22o9Z1JckG1zaBDMqEg2c8lu44SoHNFlClD4eTpKpb/JYAab1SzesTRiCv9k0CgDe8UTXZAXMCIrWc0Wce3Qp1rpEC8bNI0oMuC/rus83AcB8PycDwZIra6FSu5umbAMm6e/bvkFfcMyTTVou24zCkbAlGxH37IqiveyjXuHUhByaIiUhmN8usqkubYFLcDjtiLVtl/mvBbC3q496nZDm9954BOfIPOUlqFntVKaQGBuHsQ8lj+SbYp38LDQzlDqc9zP8yEhBJNeB5kr78yzR4X7PgvtR2gWCZVwl/BP2qjNWpGHmXErv/A+CdhaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 11:24:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 11:24:24 +0000
Message-ID: <4c253f1d-7a32-4113-b016-400cf1f7e045@siemens.com>
Date: Fri, 30 Aug 2024 13:24:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] testsuite/smokey/posix-mutex: Fix race-condition
To: Fabian.Scheler@siemens.com, xenomai@lists.linux.dev
References: <20240830111952.26651-1-Fabian.Scheler@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240830111952.26651-1-Fabian.Scheler@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4001:EE_
X-MS-Office365-Filtering-Correlation-Id: 453845da-a091-4e1a-49b6-08dcc8e64d43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0J1M2xzd2ZNWE1sNzM3Yi9xMTRwSW5xcW51N1c2OHlTSEc2eHRjVWc5Mzl2?=
 =?utf-8?B?Znl1VStSdkZRcDdVQ0FNZDUrQTVYQ2tWbGFMemhmVGtHdWFrblRlOGtDZGZE?=
 =?utf-8?B?VHRhRjdLUEtNbVRYZ2hLcmFKeTI0Sm03VzZjclVXTit0Nm9IRWdJTXVJdHNh?=
 =?utf-8?B?NDUxWHR3QzJPemNsUlZZaDdUdTkwYnl0QXRzRmEyUHhjcDNiY0wrbkk3bnd4?=
 =?utf-8?B?MXh5RE90T3VsNWJ5MWVScHZ0eW1Damk0R1gwd3ZZVmpOb3RIZ0RDOERFMWM3?=
 =?utf-8?B?NTVHU2RTVTBDc2thZ3FmOU5xVy8yUGh0bzYyK1IwSEJud1grbXR1bjZjR0Ny?=
 =?utf-8?B?MjhmTEZZME9HK3ovVU00TlNNUlBMZUw0cUJLb1p0WlNzU2V0V3ZGRHBNMDRx?=
 =?utf-8?B?U0F6UFNWNnJNU2Rac2tWRWk2Y3UzOE1qZE54d004cWY2N2dDZSt3L2I3NVNy?=
 =?utf-8?B?cktLWVVjYm9zY29YWktCcnI2QXhUQjRRa3IvOVh1dHUyZ3pMRDg3N0JMRmZC?=
 =?utf-8?B?cmE2THZTVmhiM0twZU9UdkhKalZhMWxoVFFDK3BZbWkvL09vNDhBNUVLNUR3?=
 =?utf-8?B?N2oyT0hYNDZTN25Td0ZDWDhlRlJYYjI4VDBENWx0M3l0bTg0allkMGp4T1V6?=
 =?utf-8?B?WTZCVmZKUHJ0YXFvSGo2dW4wenRvN1pZVkJYYjJIRkc1WHpyTDdVTXMzZ0ov?=
 =?utf-8?B?RDlaV3JQQVovaUE2Q01hOUpRZU41MVFGMXpmWWlpTWhqWVk2OHEyVHpTOTM5?=
 =?utf-8?B?V3VjWEVlK0JsTU01UGVTMHBKS0s3Wnh1ZVNPRWFzcmUxMTFWT3YwR0Y1aEpT?=
 =?utf-8?B?ZWZ3Z3pwcUVNZ3p5cDVERkMxVHJzanFEN1huK29KR0FTclRFMHM2b0R2Qm1a?=
 =?utf-8?B?QlNUUjNMVXlIbVpYbkNiWDY4dVBMU1VMbjJpWkM1UGhnaldKRnJxNExCNDhY?=
 =?utf-8?B?dHdKdzNuSWVYS2RkY0dDNElCV3dPMUxLRFN0NTlNVGJyMG0wdGhMbEZyYUVP?=
 =?utf-8?B?L1AyaEJWY242ZVJ2ZnRZSUV5anM2SW5QNWhzelVFTWFwVDAvTVhsMy9wdURT?=
 =?utf-8?B?NnNENTZlN0FxSVhEclBXMXNGdWZGSm5ieE03L3RUc3dQMXFqa0hhQ2thS0o1?=
 =?utf-8?B?T250a1hDNiszREg0aTFESE16cUN6RzBrS3poQVV3Q2lKSG90V2Nha3pTY0h2?=
 =?utf-8?B?enBvYzRvTE1Dc0Y0aFJ6SmEwZWtWVEVvVldqUVJ5c0lVTG1DMTZxeXhPb0d2?=
 =?utf-8?B?ZkQ1akZnS0VmaGtObVJzMVhTc1ZUcGg2eWlZaE4xaENNSUlBdVFTdnFvNGtQ?=
 =?utf-8?B?dnZqcXFwZ0F3bDd3bFU3QjhRd2c2eFl1TjJnS0pDQ2N1aUhCSXVDdWZzUXJ1?=
 =?utf-8?B?WlRmeFB5SmsvRExEZG9xV09pSVhSV0szVTI3eFVObmVsUUJ0MW9DaTdvYjJP?=
 =?utf-8?B?bk1GMmpWTEtoSzNCd2poYXhqMDhjdkRiY0dkRkk4aFFRKzJmcER6YmREa3gz?=
 =?utf-8?B?eVNUbG1XUWYyQjdaMDZNQW8yUnhobmZMVnNrL1c3RzJzWGRIcWdDSGlHWDUw?=
 =?utf-8?B?czhxVy93cER1WGxTaXkrbWNQZXd6U2c4SHExeGVuRE1ZVW94SFFvdUgxTWVW?=
 =?utf-8?B?cjFER1IwUUgrN3MwbGp2R3VWS1dORm9JUFlndzBjMFQ1RDM4a2VZbjNoNkda?=
 =?utf-8?B?YzRzTHVsbjBOMHZVZEx0N3JnVmdGUlJhZlAzTVo4OFRlUlY4enZwTHM0MTQr?=
 =?utf-8?Q?xzjKtzcsXidSUGg660=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEorNlZiZ2JndG1oSkd1RVVXOEZYelhaT1BISGtZenVKbHhjMTdob3U3TEVi?=
 =?utf-8?B?eGNxbmYvaVYycUdIZGsvLzFzRlZSSmUzcE5WN20yQ1Z5dE9RZ1BhYkM2Wi9J?=
 =?utf-8?B?UW5QQkw2UjFGTGJNMFoyeTdNTFM4bGhJTzgwalhFSm1iK1RvTUN2Z2NwcmNz?=
 =?utf-8?B?bjFHaWQ5aDVZeUNHZXlycjBxZVRBeW9KSWVFVDYwaWJvTFRpSDR3dkxjNEZE?=
 =?utf-8?B?eHMrSWljbzRlM2hiTUNTeHIweVFGZFR0RlNLc2JZZmtvOXEzc09ZbVBNejdZ?=
 =?utf-8?B?eDBSajhaUlRRVDVsUWVrenpPb29UcVRNRmc4UmhuZkJIT1kxYzVTYlRJeVJR?=
 =?utf-8?B?VmtjcSt0eHVFeXp6RUZPT3c5SVJ0aVB5V2ZBSGl3THVRVFUvVXd6U1F6Qitz?=
 =?utf-8?B?ZzlrdWxTLzdnVVNCOHR0Ymt5SDJyUXU1K08ydHVWVVlmdnRpQkRidlgrY2V0?=
 =?utf-8?B?NWt0ZDF6aFdsVUE4Z2xGM2hEanc5V3ZsR1dZdG9MdktZeW05NDB5VXRKdUFO?=
 =?utf-8?B?VmZ2RlFVVEFCZmVwcEFrUHZwQ3BKVmdCNVl4c3ZrNy9BVkxPMW9rTXIrc2ZL?=
 =?utf-8?B?WkZkanptWnZVczg3ZjFzM1BYQWx6NXJCWHNXYmJ2dFlHS3A5NDN0QVZYMDJP?=
 =?utf-8?B?V1kvUDBwejMwV2lnWFVqWXJsZHpvR3Vnd294NnVxNUxIa2praFBTZTdWRE9K?=
 =?utf-8?B?RW0vakRvY1F3TWp1OW9nYUF4ei9vV3BISGVyeTlOMFdBcmZGSHRpSnNDa3JH?=
 =?utf-8?B?ME9uWVFZLyt5MlRoTEJEMTdvT0J3OE1YUEJKYm1KNGNxdlNxY2cvRjluaVFN?=
 =?utf-8?B?YU1zS0phYmtxbVN3RHVISEJkK1Z5ZVo4NUQrN2xJczBFM0xYb3hJcGVVMk5X?=
 =?utf-8?B?YUo1bnBwbGxzdWZ0NDQ0TkxTbEdzYktIdzBmajBRZ0NCVGNHQWN5aGNKb0lG?=
 =?utf-8?B?ei92cHpLeWFsbTRGMlp6MnFGb2FTVFFxNGZvWmJQMGx3N2JrdUMzemJCUnE1?=
 =?utf-8?B?dEtPZWpFZithZXJKMDBkSzMwTUMrOFpXbitJamNjMzNodmVuY0ZkczVXZWh2?=
 =?utf-8?B?V3hNWGFYN2ppUjJyQm5EWVJBNjJaOE8yM2g5Wk5CYzZ0U1hVQUE4VFFPZlkr?=
 =?utf-8?B?Z0Q5WmJWQUZrTUR1QnlyVWpYN1V1cmtyd0tkeXd4UG40MWpGakRrTG43UUgy?=
 =?utf-8?B?VkZId1l4bWxWU2MzV2N4S3JhV0JLaTFxT0xiNlpEdVZxNEVxNGRGREEydDVG?=
 =?utf-8?B?VmFBKzY4amRjME10VWxkaEs0dFJyZS96ejBOdVkvWmlOdXQxMnlHK09YUHFB?=
 =?utf-8?B?TVpiZHNwRGtCMC95TzVQNHljM0RTc1Z6VGhTMmc4ZDZzQ015bjJWelhzcng0?=
 =?utf-8?B?bGd3c3RkNnJsTmo5eWVMVlZoYzlvT0s4KzJUdm95SEVwV1p4bFF4Rm5SL3F6?=
 =?utf-8?B?dzNRcUM2OEovM2pJTDN1Z2k4VGJMK0YvUllKZDdvc2pIUEVEQlNqemNtMEVI?=
 =?utf-8?B?WHFvQ21BRVhlY21SdHBLZTVydTNla1lyNi81VWZySk9OTzA0UWY3bHFQcUVs?=
 =?utf-8?B?QTlEMU83MHhHRjRtT3pZUWkxZnJxcUhRTTF5VUNJUXRvZVpDVG9mSnZGb0lE?=
 =?utf-8?B?TTNDTGtVT0srWmJ1alNtajkvTlFFSVhMNkdPdXNGUVJUSjkrTHJ6T1dMbDU5?=
 =?utf-8?B?U3puT0JrcHBMd1pJZXpQb1U0UXE4bURVSkNTQTQ0cVp0c0taeGdOa3RkY2l6?=
 =?utf-8?B?QjI0RDJXMDQzbENvc0x3Qjk5cUl1U3dzak9aYjAxZ21ldFNMUStNaE9EdTNE?=
 =?utf-8?B?eGgzd2wzRDdCZ29RYXpieWE1SkttSGxrbEU0d2R2Y25EV1pxMllXODdxN3NI?=
 =?utf-8?B?RS9GZURBSVo1NGZrbkYzMlVpbjB0Q1dUVkJsdzBaL3FJeHNuaG5CTm1aQ1JF?=
 =?utf-8?B?MXp6eEFOdm16NFAzMktlekNkc2JsMnhXMG00TlArNEFKRjNad3FyVURIR1A0?=
 =?utf-8?B?N1ZacG85UUtRbDRTM0hSa1lzTEpoTzZ2TSs2aGZ4YTU4UmdHSDIrTm4yUUtY?=
 =?utf-8?B?eUNGZHNMMVdOckVraVlFVjZkam1GcVVaNjdRd1ozeXdwLzJMRElkdDBqbDZB?=
 =?utf-8?Q?UvGC3lnsBMNctf2riCo2tzCnw?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453845da-a091-4e1a-49b6-08dcc8e64d43
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:24:24.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mm3SePVZjqfIRgso0PCgFV0VkZWQWHD3EbQnU10apyooUtglZsic+bqE/lYi8rJd19d9UDHhT1GatTNd7MCJ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4001

On 30.08.24 13:19, Fabian.Scheler@siemens.com wrote:
> From: Fabian Scheler <Fabian.Scheler@siemens.com>
> 
> In the testcase pi_nesting_contend_multicore the thread low may be unblocked to
> early preventing the thread medium from running until the end of the testcase,
> making the testcase fail, as the thread medium is expected to run before the
> thread low exits.
> 
> This is fixed by ensuring that all threads are properly setup within the
> init-phase of the testcase, by additional instances of smokey_barrier used to
> signal that a particular thread has been started during the init-phase of the
> testcase.
> 
> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
> ---
>  testsuite/smokey/posix-mutex/posix-mutex.c | 54 ++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
> index 5cca0d2a1..249fc6c06 100644
> --- a/testsuite/smokey/posix-mutex/posix-mutex.c
> +++ b/testsuite/smokey/posix-mutex/posix-mutex.c
> @@ -551,17 +551,20 @@ struct multicore_low_context {
>  	struct smokey_barrier *locker1_barrier;
>  	struct smokey_barrier *locker2_barrier;
>  	struct smokey_barrier *medium_barrier;
> +	struct smokey_barrier *ready_barrier;
>  	int *medium_flag;
>  };
>  
>  struct multicore_mutex_locker_context {
>  	pthread_mutex_t *mutex;
>  	struct smokey_barrier *barrier;
> +	struct smokey_barrier *ready_barrier;
>  };
>  
>  struct multicore_medium_context {
>  	int *flag;
>  	struct smokey_barrier *barrier;
> +	struct smokey_barrier *ready_barrier;
>  };
>  
>  static void *pi_nesting_contend_multicore_low(void *arg)
> @@ -570,6 +573,8 @@ static void *pi_nesting_contend_multicore_low(void *arg)
>  		(struct multicore_low_context *)arg;
>  	int ret;
>  
> +	smokey_barrier_release(context->ready_barrier);
> +
>  	if (!__T(ret, smokey_barrier_wait(context->low_barrier)))
>  		return (void *)(long)ret;
>  
> @@ -604,6 +609,8 @@ static void *pi_nesting_contend_multicore_mutex_locker(void *arg)
>  		(struct multicore_mutex_locker_context *)arg;
>  	int ret;
>  
> +	smokey_barrier_release(context->ready_barrier);
> +
>  	if (!__T(ret, smokey_barrier_wait(context->barrier)))
>  		return (void *)(long)ret;
>  
> @@ -622,6 +629,8 @@ static void *pi_nesting_contend_multicore_medium(void *arg)
>  		(struct multicore_medium_context *)arg;
>  	int ret;
>  
> +	smokey_barrier_release(context->ready_barrier);
> +
>  	if (!__T(ret, smokey_barrier_wait(context->barrier)))
>  		return (void *)(long)ret;
>  
> @@ -687,9 +696,11 @@ static int pi_nesting_contend_multicore_getcpu(cpu_set_t *rt_cpus,
>  static int pi_nesting_contend_multicore(void)
>  {
>  	struct multicore_mutex_locker_context locker1_args, locker2_args;
> -	int cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
> -	struct smokey_barrier locker1_barrier, locker2_barrier;
> -	struct smokey_barrier low_barrier, medium_barrier;
> +	int ret, cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
> +	struct smokey_barrier locker1_barrier, locker1_ready_barrier;
> +	struct smokey_barrier locker2_barrier, locker2_ready_barrier;
> +	struct smokey_barrier medium_barrier, medium_ready_barrier;
> +	struct smokey_barrier low_barrier, low_ready_barrier;
>  	struct multicore_medium_context medium_args;
>  	pthread_t low, locker1, locker2, medium;
>  	struct multicore_low_context low_args;
> @@ -697,7 +708,6 @@ static int pi_nesting_contend_multicore(void)
>  	cpu_set_t rt_cpus, online_cpus;
>  	int medium_flag = 0;
>  	void *status;
> -	int ret;
>  
>  	/* setup test */
>  
> @@ -718,18 +728,33 @@ static int pi_nesting_contend_multicore(void)
>  	locker2_cpu = pi_nesting_contend_multicore_getcpu(
>  		&rt_cpus, &online_cpus, num_cpus, locker1_cpu);
>  
> +	smokey_trace("low_medium_cpu: %d, locker1_cpu: %d, locker2_cpu: %d\n",
> +		low_medium_cpu, locker1_cpu, locker2_cpu);
> +
>  	if (!__T(ret, smokey_barrier_init(&low_barrier)))
>  		return ret;
>  
> +	if (!__T(ret, smokey_barrier_init(&low_ready_barrier)))
> +		return ret;
> +
>  	if (!__T(ret, smokey_barrier_init(&locker1_barrier)))
>  		return ret;
>  
> +	if (!__T(ret, smokey_barrier_init(&locker1_ready_barrier)))
> +		return ret;
> +
>  	if (!__T(ret, smokey_barrier_init(&locker2_barrier)))
>  		return ret;
>  
> +	if (!__T(ret, smokey_barrier_init(&locker2_ready_barrier)))
> +		return ret;
> +
>  	if (!__T(ret, smokey_barrier_init(&medium_barrier)))
>  		return ret;
>  
> +	if (!__T(ret, smokey_barrier_init(&medium_ready_barrier)))
> +		return ret;
> +
>  	ret = do_init_mutex(&mutex1, PTHREAD_MUTEX_NORMAL,
>  			    PTHREAD_PRIO_INHERIT);
>  	if (ret)
> @@ -746,40 +771,56 @@ static int pi_nesting_contend_multicore(void)
>  	low_args.locker1_barrier = &locker1_barrier;
>  	low_args.locker2_barrier = &locker2_barrier;
>  	low_args.medium_barrier = &medium_barrier;
> +	low_args.ready_barrier = &low_ready_barrier;
>  	low_args.medium_flag = &medium_flag;
>  
>  	locker1_args.mutex = &mutex1;
>  	locker1_args.barrier = &locker1_barrier;
> +	locker1_args.ready_barrier = &locker1_ready_barrier;
>  
>  	locker2_args.mutex = &mutex2;
>  	locker2_args.barrier = &locker2_barrier;
> +	locker2_args.ready_barrier = &locker2_ready_barrier;
>  
>  	medium_args.barrier = &medium_barrier;
>  	medium_args.flag = &medium_flag;
> +	medium_args.ready_barrier = &medium_ready_barrier;
>  
>  	if (!__T(ret, create_thread(
>  			      &low, SCHED_FIFO, THREAD_PRIO_LOW, low_medium_cpu,
>  			      pi_nesting_contend_multicore_low, &low_args)))
>  		return ret;
>  
> +	if (!__T(ret, smokey_barrier_wait(&low_ready_barrier)))
> +		return ret;
> +
>  	if (!__T(ret, create_thread(&locker1, SCHED_FIFO, THREAD_PRIO_HIGH,
>  				    locker1_cpu,
>  				    pi_nesting_contend_multicore_mutex_locker,
>  				    &locker1_args)))
>  		return ret;
>  
> +	if (!__T(ret, smokey_barrier_wait(&locker1_ready_barrier)))
> +		return ret;
> +
>  	if (!__T(ret, create_thread(&locker2, SCHED_FIFO, THREAD_PRIO_VERY_HIGH,
>  				    locker2_cpu,
>  				    pi_nesting_contend_multicore_mutex_locker,
>  				    &locker2_args)))
>  		return ret;
>  
> +	if (!__T(ret, smokey_barrier_wait(&locker2_ready_barrier)))
> +		return ret;
> +
>  	if (!__T(ret, create_thread(&medium, SCHED_FIFO, THREAD_PRIO_MEDIUM,
>  				    low_medium_cpu,
>  				    pi_nesting_contend_multicore_medium,
>  				    &medium_args)))
>  		return ret;
>  
> +	if (!__T(ret, smokey_barrier_wait(&medium_ready_barrier)))
> +		return ret;
> +
>  	/* start test */
>  
>  	smokey_barrier_release(&low_barrier);
> @@ -813,6 +854,11 @@ static int pi_nesting_contend_multicore(void)
>  	smokey_barrier_destroy(&locker2_barrier);
>  	smokey_barrier_destroy(&medium_barrier);
>  
> +	smokey_barrier_destroy(&low_ready_barrier);
> +	smokey_barrier_destroy(&locker1_ready_barrier);
> +	smokey_barrier_destroy(&locker2_ready_barrier);
> +	smokey_barrier_destroy(&medium_ready_barrier);
> +
>  	if (!__T(ret, pthread_mutex_destroy(&mutex1)))
>  		return ret;
>  	if (!__T(ret, pthread_mutex_destroy(&mutex2)))

This was seen at least once in
https://source.denx.de/Xenomai/xenomai-images/-/jobs/890675

Were you able to enforce this issue locally (artificial delay etc) and
then validate the this patch?

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center


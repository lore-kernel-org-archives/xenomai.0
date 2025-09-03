Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF952D24A4
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 05:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756876920; cv=fail; b=G6FDQi2QZR+ULafov75hTfpW7q75LgAYpIn5L9jXpwy4wT7M8skZ0Z4EOAiME5qdpG2/cf1L5synOCewQ/1d3jsGcWwObUPDoro1NGuC3G+Dq38Es605eP5MQqi+xQnFrju+cJscDLuHcJYF//mcY2Pq6lR7deZxprE/IENVOBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756876920; c=relaxed/simple;
	bh=sgOLa27dBXOz1kwYlDpuMpwpiDeCJUX5XN62i7X84Z0=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=h5S6WYm4u8/C9zU8XUy7dX5D/eQmzwaFSjCU89ueu3wwBP5FFgzsGJdMHfRGvZiOaIFIKKPnufCgrFB1lStCMhO6duzcd3g+klrYFXXJRoz1ed+L8jjkuVTr1VFEC1Je58J6FmoSz9T15TDu9pZL7wzAy2dKtv6+9izn1mEuhco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Yk/92OjV; arc=fail smtp.client-ip=52.101.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Yk/92OjV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEqWu8VaguL7ETAfguGhnfSY+TbGck0WDoakIxyhbVTuAdSb2Epy3wmGlBYDx3XT0J5yKAsNP28TaHJaNfk5EXY2959u7TcrzK7uW7gd4P6gFMPNArGgzSQHOILAS3x2hGEJqjrvq2i9fawxpU77N7wXZ8edix1vFUhGkgNThy0FmQZWZfSPmctF74f/BqLqSG8TQC1FdfhMz9jBdEcXRoDT80zDcaVkZI3yaESQG2BuArEyj8xNlvIoEj7jYrkXWS1zNJF0q+zVmpg3kn8oltSTZIxeTokLGpyqVAP2+QP9OSe40w71CJxoG+48XwX+oMpbmLWKEM90DSp+3SrzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irzyPdbtdkZi2ZD5ObW4Y+AJa4bsgz7jjWaiE49RYjE=;
 b=JgA8WdRFykPjvXKPnPdPlm8pdNMOVS6Fc9RUdOnxRZVLFYqUilNHAcAyZCC4f3X4+wGbY+rXdJ1ClBfrT6r1joX3oYSN3G2Q30YnCDNKl0VJnyDWfe0kNxQxnCzVUJX3nTXbN8QGrBt2AOD+rp0X+vLNH2bEr3+S/hF9ZfBjRWmgQxqOIj8gHOTCPehKx85sKLbEMsaMpmbjHl+kCiZMP74aaF9G/c/v4EtWoXMLZWK6SIITxWiRkhqTCNYfIEfxrwIAA6a3poKZrqGS6IfHBjtP9y31LLBPQSVMpuKBU+BOkyY/rKZf49dD7u9O4peHcC0YvhYjphQfqV/0dJcQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irzyPdbtdkZi2ZD5ObW4Y+AJa4bsgz7jjWaiE49RYjE=;
 b=Yk/92OjVOcSljZv528Mk+Zjb2yFMixsFfc3GNiqN9tiGU00IPlP2heqdmM/esad0hMENa8lQdBY1B696EJpBul1X8XU/yL04LdujXBaqbEWKgSZXbBTzJIEzf1QGsb3TldxR1ka6fgdimPP1iLXnsjnnZUw9JSzMdrRulT313iKpMJIyLeMDX59BnuJgzkV95rbGHWigxff3m4jlFZB/gEFdOjiVvJ9f5UeaZl1bMKsAgbsRYbMptvxa4JII9DuDICFF0VAwfn+UPavBAP7X5ZGiy14z6NKWCMoJoXRGWb3X7XzTnMu4SaYkSO2Z8nFRCOfj92QM3OpwPnIzc5w5NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV2PR10MB6528.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 05:21:55 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 05:21:54 +0000
Message-ID: <7938c7ac-e523-47f6-853b-c436c435fe1d@siemens.com>
Date: Wed, 3 Sep 2025 07:21:53 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, September 3, 2025, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV2PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 316c8530-bc97-42d1-9846-08ddeaa9cbae
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NS9zU3kvbmwrWWNBaGRVUHFRVEVaN3JBV2hoZENsZzRFRThRRUhFd2xoVXN6?=
 =?utf-8?B?R2N1YThqZXI4c3I3dytsYTJYN2xTNGl3VEh5M1AxRlhwUWxvY0hDd29wcWdz?=
 =?utf-8?B?bGJ6RGJFbGFqL3BRVmZQQ2pWZ1ZmLytFMkQ3aHMrMEV2UG1tUWZXRGxXU3NI?=
 =?utf-8?B?WmpXWW5MbXR2V3JuWmM0SkRMaGt0MnptUWx2WnBsaUYwaDBWSnc1TlBld21p?=
 =?utf-8?B?UzZyNk5iTEUrQ2xKSGJLUUJaSHBSY3RCUHhZTlJLT3cvdnduQk53b1FvMUtN?=
 =?utf-8?B?Y3hmaUN2ZHlxODI4NDlLUnZYcE55K0IveGxNSUYzWkQxMUlzMStyNHcxRVZv?=
 =?utf-8?B?VUlyUkc2dUJxeDZaeXVrR1U0TnZVRlphR0JGTHdxVW5xYitZcGZFb2ttcURl?=
 =?utf-8?B?RlN6RHFsUXd4RzgybTdCWlhqS1BnbDcvUXoyU1A2WDFXZFJSMXJyN3BKdmo2?=
 =?utf-8?B?eSswWFdTcGZLaGN3cG9FZWtNd3lma0F3NkRoZjlMNjFUREFsaUVPQjdONzVO?=
 =?utf-8?B?VGlJV1ZZTnV4VDJFY1cwWStSb3EzWTZoZnhMUldLVURnblFwUnVKeUUzK2dz?=
 =?utf-8?B?NFhmQnZqemMvaFpWaHlGNFpYeVUvclhYVXU2K0h3ajFOQkFFblhJaWJzc0V4?=
 =?utf-8?B?R0oxQ0JrQlRHVE1TSFJOSklJajBsbDBYYkcxWGpjdXJKNVpJMHJCWGFCN1RG?=
 =?utf-8?B?dFBzZStVNmZXdXMzL0duSXJoNW9ONUVyTnlJSk0rWFVCenNVUDVCcVdpa1VY?=
 =?utf-8?B?NUcyT1hZR2dIekZBQWx2alM5M0lRSjNsK0ZuNEQ1eHQzaEh1R2MvOFMwZGR2?=
 =?utf-8?B?S1NkNXBUZmRiRE5EekcwSWorNGd0MGZIV0RBcmQ4ajVUdUl3OGN6UXBJekpL?=
 =?utf-8?B?aEtSanlsdzF1L25EOHdVU2NuMHJWcEtxbXprTUl3MDRXaDFFQVRTSldKNnU0?=
 =?utf-8?B?YTcyZ2VmL29HcGRRMFRqNllxcW1qRVRaaVRzWWo0bFZnVUJ5RXpoMVV6UUVq?=
 =?utf-8?B?aE9RbkMyWWZsb3EybmQxU2VLamVOcTlMcGkvS212d0ZlRjl3QnRaYlpRN3Bk?=
 =?utf-8?B?RHVTV3loamtFTXNFaDlTTGF0M3YwWEJWN0Z3c3ZDMzBSTUVLS1RDZVQ3aEZT?=
 =?utf-8?B?bkY2WTRJc2pvQTE4ZVdXUGlJdmEwaUpBcW14eHRhZ3dVUVl4anFxa3FzNWdT?=
 =?utf-8?B?bWRVSzVyY2ZES1l3d1piT0x1dldVVFJWb2x6ay9tVG1KU1U4YlpUZEpLcURz?=
 =?utf-8?B?NUhMZjZMdERVdytLSnpZM1c5cld2Z1N1VFQ2ZDkyZnRIVXFYZk16RkRwSFpO?=
 =?utf-8?B?cFMvajJ3SDNzKzgrL1Rtb2F3Y0pNbzBVWVljL0hpWHQrRmhsMzZ1QVJJODZl?=
 =?utf-8?B?MDlYL1g0cklGMTNSS2VmeVUxK0pBUElEMlNWK0JVdDB3OG9FL0tNTFJBeDdU?=
 =?utf-8?B?ejhLQ0t6WkQzZXZ5UzV2Qm04QnhQUDJXQVFpemc2MVd0VzVmQ3lXQURBMEhm?=
 =?utf-8?B?MGtDRW1JT0YvN0ZUVmpGTTU3S2F1b1gwMWNLWTBDYU9sNXFBZDVPVTRkYXlm?=
 =?utf-8?B?ejJmUHlSQ2hMZzFUd1VjMHFzejJHazh6UmQ5RnNCWVNJcFM5b2NFUkdEL2RL?=
 =?utf-8?B?dDUrQ0RlOUdWV3JHTExoekxLSVBIZmNwUG5jU1MrL0ROa0JYVUIwZEg3OVFK?=
 =?utf-8?B?c2VycDVUU1N3WUZ5UTVmWDBMWWJZSmlUa2R2NEd6bFdHR1dBbWh6cVRTbGN0?=
 =?utf-8?B?WmpDZGdveW9MdjU2WGQ0SjFQZzhUWVhvNFdPNU1zOUQ3SEVMU1BkQnB1RVhJ?=
 =?utf-8?B?MlV1Q0xRNUhYZzVvTi94bDRvYzBXQi96T0p5VmwwbUJsWEYvMnF4bjRaRjJR?=
 =?utf-8?B?dytDZlNsUmdHdzVpVkxJMDBNOTFvVWRFdnR5aXVKNUtmSGhTcWpHZ0ZvOWtr?=
 =?utf-8?Q?lMJUpvzySNs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UThNb1hQVm5MbzAzOVZ5SmppWWJuYktSVGVWeGZGSngvZFIyV3Z2dGpKQjVO?=
 =?utf-8?B?NjJtQkVQN0JQRmpBQzQzU3Z3WTlpSzZDS0d2OXpWditCRWpwYkJ1K0Y1UmdE?=
 =?utf-8?B?QUhKSlM4aUx0OEJIdTRySTVWN3F4a0QwWDRkeGJpTjBXYzQ4NW9Yb1NVN1Nk?=
 =?utf-8?B?VVk0eW1BMlkvQnJ3UkRBREgwUnRqTCtFTEJiZXgyK0N0UDY3bzNFMmpoRFM5?=
 =?utf-8?B?djRndm5kSlM0VEZReGxIMVgwb2M2T1RZMWRJR3lyeFkzKzF1RGE4bFZlQkJP?=
 =?utf-8?B?Yjg2L0M2Q2txUEUwNVNaQ1dpbkpLVHRPOXlsTjVEd2VZQU9WVmZUaFBIWk1y?=
 =?utf-8?B?dTc3eCtoSzFBNkZvOUlCcnVYMzhaT3BoTFZoMjdLb1g3aTMzOWlRRTZpMy9G?=
 =?utf-8?B?M29Hb240Um9vVk4vNStRUTVRankyT09nU25ZK2tlZVBJc3JZMmZncm5GK1py?=
 =?utf-8?B?eWkyU1lFYllqUGh6ZW5WZUdLbENVOFFpZ0dyRVNyak9ERS9sT1V4NE0xNmJH?=
 =?utf-8?B?L084OUhqVVl0cmx1YSt1VnBLTU4vNjRlZ2hHRThOR2Q5VUF4K21lck4zYjBS?=
 =?utf-8?B?bjluOVAvdkcwejI1cVhMQXZCczZDbWhVU2lMVFRQWUZwczQ0bTcwS1cwL2Jv?=
 =?utf-8?B?TThtM3hlUGR3SWlYMDFjZlMrbGljWkpRMVE1WnhLelkxcW9RbGNDRVlLQ1lD?=
 =?utf-8?B?L20rakNIRFM1d0tKUExPZ2xOeGVDMGxuVlBkVXNELzlmTWdGdFhkODlTOHRB?=
 =?utf-8?B?eG5jeXh0VzU1TURXNURKNVRibFp5aVhsTUp3VlUyUTJrLzJWWERjOGZyMnJ6?=
 =?utf-8?B?bTVVRU1vRndrdlh5WFpHeDlsREpjUDVLWVM3bjdmYTJsUk5LMDNjRXZacFBn?=
 =?utf-8?B?WUVJbjAxNXJDVlAxdDR0cjJpblNheC9meFdzYUNDbDdsY2piREM5Z2d4UjZF?=
 =?utf-8?B?bnZCdHZGOGpvc3pkdElVdDVVNnZsOGY2SDk2NDNqckdPUHljQ2JRMU5rd3A2?=
 =?utf-8?B?aE02U2xCT2E3S25yYlpRUEFENUM2L3hpa1Z6OU43N0llRjRFVmxydVkyNU9Y?=
 =?utf-8?B?LzlOM2RMS3hDWU8vSDdjdDIwRnZSSlZHUTRFNWRTRVZBUWFEaXRpalMwUDNh?=
 =?utf-8?B?TTBHSjQwUzNib1k1bHFSMTk3YjdWMjU2cEZtdC9Hc0R1bjZpcDZmeHR5OTMy?=
 =?utf-8?B?S1IyUzRwQUhubElMV2M3Ym8xMldQQVhmanAxbnJVR3pkeE1scFhTbGxzNzJR?=
 =?utf-8?B?V1piTVdiR2ZwbjkrRTdhYUtXK1FtOTJXRzlRbzBkc2xDdEl2TEExb2s5YTNX?=
 =?utf-8?B?UkNpSUdvVmhoWkwyT0ZZSDg2NGlZNHF2YUI3amRkU0Q5dHhualh6cE1uUG5F?=
 =?utf-8?B?NWRBTHI4Q0EwcDd1VFoxc2RLTVpVWVVXVC91U2lmeHFZWTZFNTNOejU4V1lP?=
 =?utf-8?B?WmV5Q2h6NmxkRnpzRkE1UGtHekxRdkR4dG5nWE1kbXFDQWJNbkZ1U3pCU3p2?=
 =?utf-8?B?dEpzemZYNElzdHQrM3pqOGpIZUViaXhHZVFteTJYV0hwUkhsTGM2dDF5d2tL?=
 =?utf-8?B?SFhvd2JLOEY5bGZzdnFFSU44VzFLeVR0Qy9iSDg4MEpIOXNxQ0dqc2w1ZERs?=
 =?utf-8?B?eStUSktSTjRoN2Nab2FHaTlwRkdvRzVKbnNvZFJtRUZQVkxmeVFjK1F5aS9C?=
 =?utf-8?B?R0d3Q3dsV1c2dEVWOUJXY2Vmd0l6bGNRQnBGaG41cHhGRTVTV09rRlNSdzdR?=
 =?utf-8?B?OWd5Q1FWVG5wRU9NZTRxc3pGcXlJcEdDaFBodW40YjNGam9PUzdmK1o1S1lL?=
 =?utf-8?B?Y3UxWlYwbmwycmoxN2VlZG9RcytBWUw2U0JrTG5YZEZjRXhaNUhDaUpxRFh0?=
 =?utf-8?B?YkE3UXBtZHVMRXd6RldnR2Z1V1ErUHBzallPbFZkZzhXQ1gvNFpHeENNVVRI?=
 =?utf-8?B?TGF4LzlPMlR6VDJNb2V5Q09UemtWeXJlTkh3alhSVUoyQlBBbER3Q2hCaXN0?=
 =?utf-8?B?NUx6bHZqVVRIWHVvcUpnQWwzRFNHVjBWUjdxWEx2M0dCZTFKc01wMWl6aHNV?=
 =?utf-8?B?YTA0cndaZWt0a2lTa0llV2p2THNyQzlmeW4zU0tJVTRGVU02MStvbThtckZH?=
 =?utf-8?B?bC9DazZDT2pUdHFzcjFlUDROMmUrVFNxdGc4eHE4Zlk0ZEtMZDJ1d0hpbjl1?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316c8530-bc97-42d1-9846-08ddeaa9cbae
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 05:21:54.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FOXsa7V48gPS7B4zctkQE+QFwbf3nyS9QMBF4ehk7niShX9GW/KvXKeLmyBHTYHJjuGuCuc+eWIyCt84jfYfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6528

Topics may include but are not limited to upstream/downstream project 
plans, status updates, and technical discussions. It's an open online 
meeting that anyone can join and ask questions (you may have to wait for 
the organizer to let you in).

Time:
Wednesday, September 3, 2025, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

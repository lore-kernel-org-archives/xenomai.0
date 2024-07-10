Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848F4EB45
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 04:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586762; cv=fail; b=AGQJGr6iL61DZqdXJx1a5T1jxIE/c0hkEad6pWWxpYvwQUTpW0Gz5oExtizN3q6y24A028BFRxlWrskB0jV+5nDBXYIGY+u5qReZeZFYDLFvTMhfW+iZgRd++oVwKl6oMb8+Vq2zrWjMR+uxflTV1m7aV2ekUqcVGs964T1EglY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586762; c=relaxed/simple;
	bh=pRg/twcfO4t9ca6K3QcIOYpEWxvDHylZsKfJHI88KCI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H0OqhrrZtJwrFgiKiW4vtZ1aITjC0Ch+Ncs74Mc0WGa8YFX4Em/cQOJqB/ptEQGRCZMqNXo2aX8STy5+C4aFdB+L1y3YHA8LGqQlVySdADNTWZA2lquhQYMJwiwcE/3xNLws77IuYR7aH6cRSBD23Zvo5ef8pzh83r8Aw8XyslA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Eeo/7gNM; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Eeo/7gNM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfQkuStS/c3ZG2JOA2GHpXUpB1GdINu+KdYMIigrkXSG74c9QIAPBx4ucsW4Nqk1Ggv3FwOn+yruT+v/yUaAAVnVaGyPjFoj4jkfAiwbjpDLEJ+iFv3Ecfc3Q1oE7/TRZPO9gGjEmSIvneQv2vyLpy1+ZcCu3C1tagDteF0gAsgYaJyONGsrGkVAakme7wWfcO1Jj4t2ypAXS1r04RvLc053iSX1trfc2Zu0xv2nPYBnCMF4jCTiWipm2OHaYuhZ9mcv74x3Q5Ayc4sWNg39F/5ABGz7KtLTvvDf4Y1Pq8/Ki2hE711jyPPsdIXk5cWuyIT2XVVSno9B8MjC36Iv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGlcLew1Y73MhtNY0h4mmq7CI1qi1Kp+T2AZB9E2BZY=;
 b=UVwCPs71rqWHKBJOrIolKxPcAbCGRjxeq0ouF0+67Ak++X+/4FZ+DgJbq6c6pvH8u3dP8nj0X2gN+d7o1Far6qs2nfppBy1V+Mk4fD5UEt49esFFpxPb/V3KX7VOY6yn+9nDLrOjVlvcz1OkBP62q2hxNBvOaXpahAz1Xj28HwBOf3w1qHGutzkeLyjsDgadJ2VpfAXJ1KB34bRCyUTmN12Tc9/Eiz8jYlUTrdaXTEY0w318ncbaCen74upiG9h6lNsawXw6cOKcTUhf1cOLjRH3bdPAn2HuQhP2LVp5Edn/MVbIESVyRWIe7/DEDGvnBV0uZyaCQbxd89r0LJC7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGlcLew1Y73MhtNY0h4mmq7CI1qi1Kp+T2AZB9E2BZY=;
 b=Eeo/7gNM2z/q2F2YP7onNGiX42wYSbPlXx5cV1BmyDtPurXllL1cDUxuMieUR51WL6rYMxfJ/E89wktBhxf3y8rhxxDJQy5nezmlOUELdLcPgKmh/b4qKw6Ds13IZXVBIHLAabscMP/BcXy0I+Fbcq1dMOBHPKN/xXZRKy7DO8P7NuOYbgQTnXiwA/jru1guTwEETR5IBNbJQwwgFQNVMKQyF/8LZbWv9Wgxt9yvQG2KsLkORQdF91auz39NBPkfp658TGhoJUKKT05JY/8D/C1T75/zjfL+MoyYjsEOCo9ky2rpXyjMl/mXmofD4F3HPx0RV6O2UMXfmO4PC8n4Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 04:45:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 04:45:57 +0000
Message-ID: <f472b29e-d3f3-474f-9f16-cf4ad034db64@siemens.com>
Date: Wed, 10 Jul 2024 06:45:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 0/5] ci: add long-term latency test for
 next
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240709083524.739194-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb3b2c6-4d48-40bb-60ea-08dca09b307c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VU9FU3NmL1l2ekFUck5OSWZzajFVTjdzcVNLUDZ3Wjl0YThPRjdNSTJOUHI5?=
 =?utf-8?B?UUFVUDVEVTE1aDJ0OUZaQU9QSWxuS1JaeDg5NUkxaUxVODJQZjRIMXFBMmhQ?=
 =?utf-8?B?M3RnUGI5SkxWdXU0NUUrdHFNUXR5WWdWK1pDcFRaWndHUDRwOFp4aEFyQWVo?=
 =?utf-8?B?SXdMNmduejFnbXFjWCtONHNWVGVlYmp2K2l1ZS9KVGhieE92REdLWnkwZjlz?=
 =?utf-8?B?T0F0Zkk3SWZoYzYvSG90eGpTYTVSTVlMOFpTZE9nUG1heDI3VVlocndUanFx?=
 =?utf-8?B?RmJnOWdDVEtUWmc2LytiYkdYSjlTditEenBRNEw0OWM3dGZqUmlGNjBtRGdq?=
 =?utf-8?B?S3lPVHBTNkt6VFJ5eFMzTFlGck90bUt1cEN5TGhza3RzVjRPdVRTVjBZNjVk?=
 =?utf-8?B?WFFGVnkyUmlUSVYrdXZJK1BoQXVwQTNldEppd1Jwd0kwYU13NUYxMEFoQ2pn?=
 =?utf-8?B?b05VWTB6bUtKb3pINUtHUDhjVUNsUlJhU1duSW1qenhiV3BreW5VTlpWUVN4?=
 =?utf-8?B?QXRwNnZXVjB3T2xBQTFJMTBWaSs3Z2NXV3NLcWdxMHo0RkNvWkpYbkMySHRa?=
 =?utf-8?B?TnNkOTczVzNwQkJma1k4RFVqYW9wTFVjQ2V5ODRNSlhwekFwRExpaGZNUkg4?=
 =?utf-8?B?aHlxQWwwSnpRb1lsRWVHYTdROS9rcFJDbTlhMzRKMVpROGNaNGVpY0NLL0pm?=
 =?utf-8?B?VENGWngyV2xrVnF4STZuNS84Z2QzK2h3d21jRmx3UytMQlptdFNwMlVQYk54?=
 =?utf-8?B?Q0RNWUFuZWdwcVBMN3pPYnZXRk5CYTFqWWJSTE0yNlIxUElyMlBYeVE3QWxJ?=
 =?utf-8?B?Vk1YRXFyZ3RXRVFsM3lLMlQ3VVhVVE5qTzNlb2Q2dWNZVEZxNDZJNXZ2eEZL?=
 =?utf-8?B?Z2ZEcWx6SkZiWW9uWGUzQUo3OW5KQlVsODNwam5Pd2QwRGdUY1VkbjkzUVhI?=
 =?utf-8?B?cnNsdUJQWWJYSStMb2RORmxvTnFRb3hpRVE0Q09YNm4rZVcxZGJhd0FtWDFD?=
 =?utf-8?B?TGZ2L2dYcUloQ2lTeHUyUUoxSllBb2QxTkhzYm1pTlZscDVEc0lIRjdoYnlm?=
 =?utf-8?B?L1lzdjJvZ3dQUjJyeVE3ay9wQ1hGQVJ5Ylg2Q0pFYlg4ckp5Qmg3bGxVWnk4?=
 =?utf-8?B?RzVVQnk3Y24zN0hZQmNEbE8xM1ZxbmRrVE1qL2paTUVpelRkUXFDMnV1Rk8r?=
 =?utf-8?B?V2pqazFucTV3Q1hobzg1UHBnME5oV0dTMjJOMFNJMkJHbzVFcHpjUVlMR3hK?=
 =?utf-8?B?dWR2KytrckJMb1VuQytYMCtBeFo0R3hTVGxhOFluQksxckJwVnEzWjV4ckJR?=
 =?utf-8?B?TWphamNkMC8rbzA1RHBBQzBVd0t0VDJWTWtTZTZYSXE4NEJLWk90eFNlNkVK?=
 =?utf-8?B?RHRqc2plSG9pODhnQXUxN2IxZm9oNEpLb2FPZnhlMnNQeHp2QkdHdGZqQlla?=
 =?utf-8?B?dVJ5cURQVUlJNGQzTGoyY0p5cGRJTDhuOGU5Q3QvbGNWaHE4RUVYQzRnQ3JY?=
 =?utf-8?B?MWdBaVloSVE5VVQ3V0xwcUhwTEVSS0lBTW10MCtIYWd2U1RmV21ISEs4K3FS?=
 =?utf-8?B?bEJRdmE5ZUV6MGVxL0dZajFNYk9FdnFsZHB5MXoxN09FeG85bWJNTGY1V2R2?=
 =?utf-8?B?TzEwaDJGUU4wTCszbFZabzA1citRcm5OdjFjTERtNnZyTjJsNWFmcHBMY0hl?=
 =?utf-8?B?RW5nZjVrS2FIalE2WUMrT3RTM1NBRFl0WTArelRXQytTVmR4cjVydllGdGEy?=
 =?utf-8?B?QnhSb0F0MDVFL2ozWVIwWHVrU2xzRGI0dUJEWDVEM0IzRkVTVGFqQzh1TTNP?=
 =?utf-8?B?ZE1KOVNuT0tsWTBzUExzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elJVdEtkYW5ELzNNNGQvVjRncVArVU44dW45OXNyRklNN1czZ2hhNWZiUVJi?=
 =?utf-8?B?MXlTMkg2Wm9WNTBsTk5raVNneHRhUG1yemJWMGUwakZ4c29VeEU1MlNPS3ls?=
 =?utf-8?B?VUdOaDgyTDNSSzFEZXpPclg2V0FYRUcwYXJRK3NvOHEvdEZxcHRpWC92MTM4?=
 =?utf-8?B?L3JrL1FyV2JTWkExUndBWnNLMElxSzBYanJZRWVUcGhIb2lkRURlbjRmcXJG?=
 =?utf-8?B?UmJMK3k1SytHemZ4WTUrK2JHMnUyNjJ0VlNtZVJBVWhUdDQvVjNMdjlwYXJW?=
 =?utf-8?B?cEREQmEydG5lVXpnQUw2RUlYOTFNTTY2Nm5Hajh5ODNvUlE3eUJmT0Nwbmdk?=
 =?utf-8?B?YjNTaVE5T3RFNi80bXkzMzV3SzkveTk1djNnejlKdkV5Y2I4djdDNmk4ZmNS?=
 =?utf-8?B?WTI5MVA5VFZIa0ZTbDB3dGZ4ZzBIMURpUUQvbEFhTUovcTJwV1UweGxUeEJw?=
 =?utf-8?B?SzgrVEI5NThLUUxuL2R0MFBXamRCTmJVTWZCWjRodnlIcmZvZDhnemxJOU91?=
 =?utf-8?B?OGc1NXEzT2Z4eTRvYTc5SFpVczFOaDhKVnFNd0o1Z0NyRllndHZiWWdOZExn?=
 =?utf-8?B?RVdaekVvSDNqNUZXTGtBNkhVS25zN0Y3dmVEOWgzWnhIK2I0TDdDa2wxeXVC?=
 =?utf-8?B?bGlyZHE2N2xKWVd0Sk5VUzg0NUJMRDlob2VHcEd1VUdJUFcxNmZYZFVjK0tH?=
 =?utf-8?B?eXErcHNzTmdUcEd3NFlsaGpSWk9nQ3FRdnlXc00rWDQrc0IvYlJPL0hYL1NZ?=
 =?utf-8?B?dCs3Wm5XQnYzc0hnSkdNVklQeGZCUXVMVXdKdHdYNWlVRTVCRUpuN3lNdkRN?=
 =?utf-8?B?MmRYY2pxU3Y2Qjk5cEw2ZzlmNjR0V0xHYXhSRkd3R0p4MWNqMzZrTkYzZmFB?=
 =?utf-8?B?dncyU0pYbGx4NmVBQVc5OWhWUWJDay9ibzZJOE14ZUVjNVd6LzlLLzBiUWRy?=
 =?utf-8?B?UFliWDRtQXM1Q1YrbkZOSTZmdlpVZDg1TjM2TWtqTE5HUEhZMGdsK2lLRGdN?=
 =?utf-8?B?NEdUUUZJM3VBajRjQXIwOFloK1pOTnQ0QlhCc0xuSEZtemF6RXhJcE1ySUxS?=
 =?utf-8?B?T1NlVXFuN1h2QXdqOElwVHVnV0t4alg2UGpEbnpmQ01XUUR4M1NMUzNQazgw?=
 =?utf-8?B?cUluOHhOYXF5NklWRG9DUVpKUGRBKzN0N3JyeTk0TWRXbXZJT2x5dU84d1Ri?=
 =?utf-8?B?bWVDWnFQUTBqYTJqbkZtNWFaY3hYZUpEY3o4azNPU2dEZXdCSVhhY3JCaENP?=
 =?utf-8?B?VVQ3OFlTSi9JVFExSVRKK0hDS2o1ZmdXcGVjam9BYWJuVnYyY2tUQjZhYXlr?=
 =?utf-8?B?WUN0Qy9yanQ3L25FZWVCZ1YxRGdrMGZGcHdEU1lzdElueTRHMjJCWStnK1M0?=
 =?utf-8?B?ZDN1VnI3Ty9Bc3ZhdDU2Sm5DblNiampvVXpqQ1kvREpVUmp2QmFKK09EUU1Z?=
 =?utf-8?B?VVVkMGJ0STc0aXJOUUJSc2d6VVZFR0pEVGpUdHB1b08vOXZXTlVTTnEwbVJY?=
 =?utf-8?B?QWI1M1VDcVVwYnJicUZsdlpQamJRY3BzQ05FZ1BLT2FKeXM0SXNsTVZCZW1I?=
 =?utf-8?B?eHlIYjZTUVpvREtRK0lYb2lBbXVuRXFYbnhQMHpjaGZmUjRXZ3hTQkM3L3M5?=
 =?utf-8?B?NFIraXUrOFlDV0RrTENpQWFmdjZ3R3ZCUHpKVEovckV4OWtPNlo4NHk2V0ZE?=
 =?utf-8?B?ajhwT0FtMEpabnEyVEFYSHlETmhldC8za005NnE2RVQzZ0NqYVdIV3llUkhp?=
 =?utf-8?B?UzA3ZEZHSjNkKzM1emxYU09QOTc2M1ZYYVZuYzZENFVrTUNlOU5xWTcyY3lu?=
 =?utf-8?B?ODAxODNySitFWHpxYWNiT2FsS0VjVG83cnlMUkdvU1BubTNGV0VuSFVGdFhN?=
 =?utf-8?B?aVAvQ1NJR2NnR2g5WXh4NlFpSXpuenlXWjVxYzdJbzhoODJtdVhsZ2hGOGNq?=
 =?utf-8?B?WGRwYnBCOUlXSXZuK0ZvMlJPR2x1TTlraThMSGg2Tkk1dzdOTjZBQnBROEVC?=
 =?utf-8?B?T2tpcmZ5VG0rV1BoYzhFL3pZMUVhdUJFYlA4dEJKQ2RnYngra1ZKaTIzdERR?=
 =?utf-8?B?bU0xa2xObWx3VVBBYm5WZVVlR3FRWGRhNG94clJRampBc2F2LzZ6SkNVckFH?=
 =?utf-8?B?YTBnWDFWYk5TY20xY3BGZGltd0pNRjRJY2t0K2JIS3hVd3F4bWJwZEFwV2Fl?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb3b2c6-4d48-40bb-60ea-08dca09b307c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 04:45:57.4283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOwzYFF7lGfRCmve9AjFb/tnqEZ8Baxf3PjCs8GDvoHwW4CBS9JEGiUcn2aeNuxw2+/RfUv5BWh8j2dzcjiQJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3178

On 09.07.24 10:35, Tobias Schaffner wrote:
> Add a long-term latency test that on physical targets namely the rpi4
> and the beagle bone black. The test will run for 60 minutes and fail if
> a worst-case latency of 100us is exceeded.
> 
> The long-term tests are only run on scheduled pipelines. Therefore a
> scheduled pipeline has to be created in the xenomai-images project to
> enable the tests. Running the tests at night is recommended as the run
> will block the hardware targets for the test duration.
> 
> This series was testet in our internal CI.
> 
> The custom xenomai patch can be dropped as soon as it is merged into
> next.
> 
> Tobias Schaffner (5):
>   ci: only use opt-debug.yml if explicitly needed
>   ci: Split kernel 6.6 config into physical and virtual targets
>   ci: Parameterize test command and timeout
>   ci: Add a long term latency test
>   ci: Add latency treshold to longterm tests
> 
>  .gitlab-ci.yml                                | 10 ++-
>  ci/gitlab-ci-base.yml                         |  2 +
>  ci/kernel_6_6.yml                             | 29 +------
>  ci/kernel_6_6_physical.yml                    | 36 +++++++++
>  ci/xenomai_3_0_x.yml                          |  2 +-
>  ci/xenomai_3_1_x.yml                          |  2 +-
>  ci/xenomai_3_2_x.yml                          |  2 +-
>  ci/xenomai_3_2_x_compat.yml                   |  2 +-
>  ci/xenomai_3_next.yml                         |  2 +-
>  ci/xenomai_3_next_compat.yml                  |  2 +-
>  ci/xenomai_3_next_long_term.yml               | 21 +++++
>  ci/xenomai_4_next.yml                         |  2 +-
>  opt-ci.yml                                    |  2 -
>  ...tency-treshold-option-to-latency-tes.patch | 76 +++++++++++++++++++
>  recipes-xenomai/xenomai/xenomai_master.bb     |  3 +-
>  tests/jobs/xenomai-beagle-bone-black.yml      |  4 +-
>  tests/jobs/xenomai-hikey.yml                  |  4 +-
>  tests/jobs/xenomai-qemu-amd64.yml             |  4 +-
>  tests/jobs/xenomai-qemu-arm64.yml             |  4 +-
>  tests/jobs/xenomai-qemu-armhf.yml             |  4 +-
>  tests/jobs/xenomai-rpi4.yml                   |  4 +-
>  tests/jobs/xenomai-x86-64-efi.yml             |  4 +-
>  22 files changed, 170 insertions(+), 51 deletions(-)
>  create mode 100644 ci/kernel_6_6_physical.yml
>  create mode 100644 ci/xenomai_3_next_long_term.yml
>  create mode 100644 recipes-xenomai/xenomai/files/0001-testsuite-add-latency-treshold-option-to-latency-tes.patch
> 

Thanks applying patch 1-3 already to give them some exposure in the
pipeline.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


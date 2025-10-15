Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94427302749
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 05:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506741; cv=fail; b=Q2V9+nI6GGIgGu2MroWvHe+vTZaITJOiTDUD5Ev/9Rx/MxZYNxntMzO9L0uc750xjelspE2wKmEF/h9UXQmaDCOd7JXb9CtFCJBux6OYLxr2ifu+Hho3qZYaBpj+xUWCmoguyHFWXRyuWvWrUKL8Gfsv7gR1ALOK5MqBkpzrsHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506741; c=relaxed/simple;
	bh=/0TKcxRMKEKMqciOJvm9nkI03LLhtO7EaKXp7AaIPGk=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=oy2EbAXSuBANtBc2Vej/7jnfE0mAWT7uASy7YXuFYt59tInWROL2iAHwNunA1nxNEgx4j08IMYvV5doljWGmFVVOz1/SCRNm44b6VG66hvokwMXs6bdPqkdEeYW4lR5SmbFs5ijFVRi5EhF8obvaeHNWKkviCpJshxmJxWoIhn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kBW3Lc3E; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kBW3Lc3E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFCoTMArLsCXMbhR2KDcwIyAfrXfwsUuydMm7PlM7l5whhLnP0afwX+/EryJC6P9jrNe+ZPFExfQNQM9Mp4jZdDigV7l57IMdKPsOprq5qjNwv3gHXepfAd6FtJaC0/DlUZ+YUUD2Sbz8CdXS5gjmsxP4zLrlV3jS52pt+pQIX7wKcELff/HMalISiZY/Cs0TGn/4kTpul8FF1+BH12hI0O6d2tetG/dXHAtSy6mLeRDo6FqEN3pLPkqDz2KTjYzfgz3CU4uO7+jNlkwTWdJDXs9QlfUlfJat8YwKGbYEsHZZOrPiSSGydgpy8JJnqJ8dFms7KA6fsC7Ywtjp/QnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do6uG13pjx7QfHXvtOBP2sxuwOs6ZqgDmtH7y27bMfQ=;
 b=a8NcPX/BveAafTNaOHRC6RNNORdJXSi9LEVpoWSIr9G5vmO8b3X3g83BS/zWsiroSpNuiijT9zjPU+gQHA1JZcz7thLDKpxHUmHGllNadvb043UTl7bjzarQdf7tDE+YMMNqi24LbfSCXYyYRS8CJ+Ko1UFfg4t/Bf/oooJb0uW6MZxG/tZhkF3fTlGTERmN1cdfJYSRmL5hR02b6/EbXsp3N3NUHe5v883hHfJASa4AHq3oUBFCnHLSmu/vmW3jlMdZaczwt45BAil3VgXtM6rID34tCsiczqrY+L46Fv1O+BCabIMnqcKLj1M8RE9gE/Uzkh0A8Y8yFopVUBBpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do6uG13pjx7QfHXvtOBP2sxuwOs6ZqgDmtH7y27bMfQ=;
 b=kBW3Lc3ETdq+TUD46l67hHVUkOxwLUSx4+b2EVDjfgWC9avBFuZk9lKbuS+AhfSG8xTEH4Pwoy+UeDIs4ZPCnASCYVr8wP99IYJmwoHn6Ebo0+hp1utfJYYZth8kzxiuMmkVemTBrVR/DQR6NOmIltYa+kfzpc00pw5AEo/9DlvUAnx10E4qUkIHiJ+r+CIScLio6+ABVOdT1TrlaP3M9Tm5T0QAwMKI7Ul9gCVGTr7CDERnHz6t+Qwe+vn6r2lbfrpJHcdxp68oDQo3zKqK3Vwr/X0bfSPgPRiOhJxxBSqOJ/MZ88ZDJ3ZmB/LG7btv1Vxw2+JeEXfln5vzxkiGUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM4PR10MB9403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 05:38:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 05:38:57 +0000
Message-ID: <5a0c551c-3aad-41b0-a07b-eddaf8837faf@siemens.com>
Date: Wed, 15 Oct 2025 07:38:55 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, October 15, 2025, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0350.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM4PR10MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: e92870de-2720-494a-0393-08de0bad225e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjZrKy90OHBxN1A1aktKby83aWpqQ3JqemhNZG90NWRSL1dqRzhYVTcwdXRm?=
 =?utf-8?B?dk1Cbjk4NFhTekg5L2JMUGJ2S0U4NFBmeGF4bHJDNXVoUUpzaUI5cUZPYlYy?=
 =?utf-8?B?RTMxMVlNd3JTaFhpdzN4UmpzRjhRVHFnS2tmREd0bU4zaEszZVdCbDVnR01W?=
 =?utf-8?B?Y3k1ZDl6Y0gwaDVxdGhlZkMzcmI1aWgveFltdmVlbmdjTlptUk9JU3V5OG5F?=
 =?utf-8?B?TTBFUHpLWDFlNXJxMVREYW5kcXlESGNPeEtmNnJpMGpOOGJSQUkzb21WOFcz?=
 =?utf-8?B?SktnVGF3dGtaMEVnSUNNWm5QaFN4V2tnZTBmZVBBTCtVOGFZOTZtQXAxZnVx?=
 =?utf-8?B?WENKRjU2KzRReVhyRmVXYmJJd29qSnNpaVdIcWdvakRMZzJlRnBGbzJ2dkhx?=
 =?utf-8?B?OFp5QXF4Y3ZUMTZUQ1ZPQndoc3FhOW55Q0g3dmd4L3pWWmRSMjBFeWhoaXZp?=
 =?utf-8?B?bmU3c3RpdnloWnJ6LzZSamhmbXVPN3BCWm5hSW9YRXN3dUJzOEtFTHBuWXFq?=
 =?utf-8?B?YVh0dUF0c2hZeG4vUTN0V1VUVVJERm00REgvbE96eWltZk04enNDUFVSY09w?=
 =?utf-8?B?NHpZaEhYZDNBWkRKMWRtcnJWdW1lNWJNTHZsTFdWN0JxeEk4aU1SeEVaOU5R?=
 =?utf-8?B?ZmM1MEFvZTBWUEcrSFduNUtTaThmdEd5TjVFSUxXTzRVYlp1cjZLWjlpQWRV?=
 =?utf-8?B?UG1UNVJPQ1VGR3M3M3lNNGhoeWZxQW0xOXY4MEFvQnhheDMzTUZKWUVSWGFS?=
 =?utf-8?B?Rkp3OUZBeVd4WlZwcEd4VHA0eXVobWxPejlmYlg2WnEwck9aNWtIMEVOTFVi?=
 =?utf-8?B?L08rT3h3SHU4akM0b2pyT285OFIzVW42UWU0RlF6MEE5ZmhpV2xvQmcyRXNI?=
 =?utf-8?B?MHBrZm5WQWVGTFNveFRLU1YvN1B1VFpWYTBWZk9zeDgrSFhCcE5SNUJBa3Bu?=
 =?utf-8?B?Tmp1a2JwdVRPM202RmRJMUd0cnlPUE9hS0s1RjV1WGh0ZytVOE9mTWNXdVdK?=
 =?utf-8?B?MCtjWWxmenV1TDVvMk5aSS9EYUorU282V2tDaExJMGRuaGdHMkpoWkxrQ01m?=
 =?utf-8?B?bjBudUJhdk9EWnJLMlZFUkVHOUxNNTZSZ0pWZ1daSXpPTW15NjlGY2RwQm5m?=
 =?utf-8?B?V0pId3B6ZEdEMFhMekNYV1d1T3U3eFd3SzdmQTZmdTA0bktqdEgwWmttUk1T?=
 =?utf-8?B?WlIzSDlzaG05dDNLeThaaGw0NkpqVFZaZ2pkQjdldXZaM3hpWG9rQzZZMzNs?=
 =?utf-8?B?Sy9VOFI3T2VBK1F5UC9WUEpld0pWcTZ4RjBYVU9pQ2FlR1ByNGRaVyt5NUtC?=
 =?utf-8?B?Y2JOZXBFRmxwNTRsb29ta3NDTXNlMW1uK2U0K0hKSVMveDhLOGxUWnBhb0wz?=
 =?utf-8?B?c3VuR0VYa29VVnRvV2F1bVRkVDNmRlJ0NWR4VDluZDJqS0JxTkpqZjFlRFFG?=
 =?utf-8?B?N25OUUpiYVFsTUR3Z0x6Nzc3TFRxVU9yUVpZVmVKYzJzeVpvRGN5dnBSTlBq?=
 =?utf-8?B?V2RmUHhLRVJQcFBzRDNCbHdHMU12YWU0REFlemd0SWhialpjRjNsMTJqWERN?=
 =?utf-8?B?M2NOYXUyU3dhbHVPbXpVZnBKd2MxdEFhZHlCci83UzJPNUxpaXV1SCsvVklu?=
 =?utf-8?B?S3dFTWxvT1MyaGdhcFU2WnB6OVY3RnVjUzFFOStuTGJSS1pGcFhQYzBSdlEv?=
 =?utf-8?B?cWovN3hrbGRRQjJzMXpuL2dWZVhJT2dFTENSc2hKeTdXSWEycHU4SmtKRGl6?=
 =?utf-8?B?SEo5T3JVNlplNXV5anZFL3pNT3hwWGZZSFZWR3lab3oyWDl5SERraEVvM2JP?=
 =?utf-8?B?NEIxREVrU0x3b1RydXlTeWFlbU1NU2MrMVFnRkI4clFUeDk2bW9YcmNoNjBs?=
 =?utf-8?B?cFlOTkk4RzNsOVM3NU9aMU0wN09ZM01kZjFMZ1ZyckpMU0FEMWlXZE5UN3lM?=
 =?utf-8?Q?5apPNJTO1Nxvy5duKxSMZqKNsIlnzvoX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3ZmMEF3SVhKL3Q5MGVRUy90aS93cGhUMEp6eGd6TWxYdllXUXUwQzI4UnlL?=
 =?utf-8?B?ci85OWw3TmRKdU41Z0tKWFYveG5xeUFiY09xejlUSUEzK0UvSHJmUzAzbkRo?=
 =?utf-8?B?VERMdk5lMnpDUmhKWktvTGNqeGJlNjQ0emw3cWpDWVdmcW1mbXh4bUdDeEdG?=
 =?utf-8?B?MXFROGUwTWFBTTVobGZOQS9ES01oeDhpUHJRTGwwd3BIODBrejdqWEhBSDJQ?=
 =?utf-8?B?a05vQ1JxOWp2RVZZZE9HZFg5SjQvRDJPV1AyZkNWNFNBVkl6V2NwK0RHdUQw?=
 =?utf-8?B?RllMUER0eHBaWXhmSEN5OWFQcDl0MXhMT1hoN1c0aTV0NWRCR1FHYlJKblJB?=
 =?utf-8?B?eVhuSXlUUEtHTUsvMGdRZFpIYVdpTUR5OW4rMjZhK0VPSTVSaVZHenM1VW9W?=
 =?utf-8?B?bXhtWjMvekRWZnArZnI4VGRqamxocEFWaUJOSmdMUDR0TGF0OEFsaVU4V0Jn?=
 =?utf-8?B?UWw0a0FNZjFBUG9KSjFYbXRIOTlEVy9pVGs0R1BJOFAyYXFCVVJaTGxhR1h5?=
 =?utf-8?B?RXZlMDFjaTZFSlZSdFdzeWoycDl2UHFkdDQvOGYxdW91dHd2aWZ6eGpDMFlo?=
 =?utf-8?B?UlZpRXhZRmNqV0I5K0luTnZ6MkxwelVKRUE2SnlYbHhHRWlzRzZIS3VUQitC?=
 =?utf-8?B?Y3dkUFRFNTFDMU5BV0pFV0hmYSs0SkZQNXd1Vmt0UVJCS011RUswZldxck9D?=
 =?utf-8?B?dm1pL3Zhd1VSOFQ3MVNIY2xXTFVnZGUxTzQxKzlFZlJJNThCd3pLdDZSWXlM?=
 =?utf-8?B?allHNnZMdHhHcU9xMW9xM0t5c2p3T3pmaHVmU2JqNjhSV0pNemFXTTRFVlZU?=
 =?utf-8?B?QjNURlJCYlpWYzNnZ2I4RjhyS08xbnNYbzlEbzhiaHlxVkFoRjI1d0xLMytw?=
 =?utf-8?B?dW5YdnhZVU8zbEhweERRRHo0MGtLNEEwK1FCZzVZbjZYWWJOakpQUk9NY3pQ?=
 =?utf-8?B?Q1NUMlhwZFk4UzMvQ1F2UVdUdEtXNmhFSTR4TkxNVlBPY21CMVkrSm4yZ0NS?=
 =?utf-8?B?M3NiMFVoRVNrWEVQbGtEVFVoazRuc2pvRlJpaktORGJTTWVwYWxkWkozejMw?=
 =?utf-8?B?M1RubyticWphNzlkZVU5akMxbFRLSzNrSTZiRHRJVHFyZ21BL0hxTWFaVXlz?=
 =?utf-8?B?aHpDcDhGOUNqR2RUSUZkQzFZbUxhSHRqMkNzbHJmWktXVjFjVVpLaUZPcm5i?=
 =?utf-8?B?eGxhTXBkZUFJN0dGeVVZcTd0TmZuU1ZGMUtPNHpGQ1RGTUU4VGc3SSt4Rjkw?=
 =?utf-8?B?ekdWaDBkY0ZHV01nSTg5WXMzcVlTa210YUd0Y0xLRjg5S2JPVUhmMExnQmZO?=
 =?utf-8?B?T3gzYndvSFd5OUFmaGhTWThLeXVGSHprejcycGhvNk50YVZhbHZIRnZ2cVlw?=
 =?utf-8?B?aStuOXVBdWo2bkNBWlMwdDBUVUhLY3ZZWUZqKzk2eS9FMkZ4UGtnSHZYSENT?=
 =?utf-8?B?aytxZ2xRSThoWGhWS3pjc2o5ZVpocmtHMDZRaGRCT3YwbmJrRGZRaFprWGtW?=
 =?utf-8?B?TndHOXU2elpmZEpTZCtBaGppN3V1YWR5NDdqdDEyU2pmcFhNS2pvY1VVcm12?=
 =?utf-8?B?alh5S3RSODRJekZ6ZkM0VFBHNVlYdUhTYVFqbjVMT2lDamZ5RVJjemJOS1Jn?=
 =?utf-8?B?Qk9Vby9RNkdCK1JMSkMyM1RSVFMweU5Pc2xiNE1sRUZnaHNINTA4UmV6Y2Nt?=
 =?utf-8?B?VVpnRVVkTEp6eDIvcXRWSHFmellDdmE4MURqK0hObVNDay91TUN2bEw2MklD?=
 =?utf-8?B?SWt3MHVCQ2h6Yk4xQlV2S3oxaWFjaWErdHpQTkpPK3doL252QXFDZGVpNEVx?=
 =?utf-8?B?eURlKzVvLzIrNkVub2dsWUlQVXF1Y2VuVHEwc3JuTSs3Q21ZcDFNSVFQeFUz?=
 =?utf-8?B?bW9wT25UYU5ReFhGZVlFdzVaMU9yanl6SFFaODNoSTNKNm54MDJiV2RTR3VH?=
 =?utf-8?B?dDRMYm40amNHL21tcHBSUFZiQUtUR3BXdENWTUNwVUQxVjVlN0g1M3Q5ODhC?=
 =?utf-8?B?THVubmFOOEVhUVlGL3hLNlZzbndSN2ZWZENjZS9PdkwrblNIaFRXNTRHMzF4?=
 =?utf-8?B?aTRSdlBUNDhxK05wb2QwNnRKTVJBMTFHMmhKMkdvZUhuRlc4enMvemRMMXZy?=
 =?utf-8?Q?l5v4CokHS0PUPp8qmldpumXx8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e92870de-2720-494a-0393-08de0bad225e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 05:38:56.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmCzFyoPm+vfK0jLkv5jJmQvEeqoPsH1H2lUkdOY9ymSRfGyIGMA8j7oSSopaqDKejmsUTBd/ODAYKk9Flm5eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9403

Topics may include but are not limited to upstream/downstream project 
plans, status updates, and technical discussions. It's an open online 
meeting that anyone can join and ask questions (you may have to wait for 
the organizer to let you in).

Time:
Wednesday, October 15, 2025, UTC 7:30 AM
Paris, France CEST 9:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

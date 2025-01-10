Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B0212F89
	for <xenomai@lists.linux.dev>; Fri, 10 Jan 2025 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526073; cv=fail; b=fDWkWmwQEQYVx/A1S/EE+WhXHpXJ1fsS2ApwLOLGeRwJogdqZ3XJoabARN2K/g/Jz3Sw+43T5h40ch+z2k6OO1OKOvFmqfauwNg/r0dH7Of/BvUQN1wctyDFSFTRxRdILsK/cr++cdsB6cb5bMR52hreMw8N7xg6whtvBlCSJxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526073; c=relaxed/simple;
	bh=wc6MBs9wYRFnuKg300wEKGeZqnwA+TXuVdgawsINLec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CO+6gqgtSIQX+WrAH61m8/KB69DWdpwMWPM7UwJsBe6Ksb6N1gFjBmAZMNYcyknT5i+VXghoD1kBsUgb7H41jH/DfZ8QPce7mYp5IK5n9PK4cdU75vKSxtatcOoGdcBi9uCqBvp5WQyLN1m3FmX2uMjubmjvRZOi21mWequWQ9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bbnroEfJ; arc=fail smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bbnroEfJ"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 3D896100006;
	Fri, 10 Jan 2025 16:21:08 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20627.outbound.protection.outlook.com [IPv6:2a01:111:f403:2607::627])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 70E6CD8030C;
	Fri, 10 Jan 2025 16:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHRclz1FE0Q04IJe8eKHaH6FXpWLmT+jwp53C7wAVAJSerTwR328cFAGq+kBRzs5A1EJJv3lGIufP0goWcIn7skD7KqU16kk+VF5Yf0bZwNBnih0jlSYFO8oV1g/r+gMdhkEzkyUh0akaQ1aPY/+90KwMy2UnLAjdJCPdpKl180D/bqPf5xg24JSadyZIHIIgHcTofDEQyVTpe+eT3bPjWiydjlfPN5eIygVWrfzjdlTu4oCmipPwnpNxy66ca2QefdZ7CAnzHHItjXhdLgbu6qrhqUhqHK4YjTbfqDhjwQvS/VsOXrU7Ug+C7lxqM5JHRMcfVeCMna1bV6L+m9WBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUWmzjHqv3/n0aNrKb9fOEFNzcPmTjg4KO4nmMgXHLk=;
 b=xu9CiPIRyQlqHhVcZX0dr9w2VLb6kXetVVehulidlHeZV+bpDuMH53A3k8g3zuUTLkX4sHswVygWqBaW1Irse63mXU5Jh+UAf4d+bEMghT2eJvT0LLGu0nRkgL6sKB3cB+XNyiTxS9u9M+FeAwcD1jBRQ/3FR8Uz4f2k0fvEVhvmXH+AmmalwEdr4UD/5AgaeKV6FgiArDQ6Z1q4VxoIxnU+4q41huQcgQReoQ1XhidegazLEHkHdzc8fsplnJbo+8IOGewa8y6q8jEk3DGm3U1qmarzEo6ZvREOUmba1uRJGzwr0nHyvjgZl1peioOdusH2F780cAQuTYWxq2/g9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUWmzjHqv3/n0aNrKb9fOEFNzcPmTjg4KO4nmMgXHLk=;
 b=bbnroEfJrZ18MZ+sm9eYJJHLJXMQPk4ED1FXix/5j6RcAaTmM2ZEBCQO64OODxjJ5TUcC+NyjPEEuETxVqrAC+n+NfW82UQ5P0uRvOt4nlnvKtGsv45G8pSAAN+JsfRkgRbK6wOcQHei8b/r6kbvYTgVJYfbuPpwVG6ZuFq3YWHcH9hDfjGGxY1TTe/ZHWyzF7JEbdIfVROBLHYk+9v4WPhu74+maaFD4KvvLHncutKTmovlAk1c32XVD/kIVL0jEBgYwb4jeJUJ3qBxaS5VWTQbROz0mh+idl448bI0YnWfM5o+ZZicr7qzf7RMiMEdMnk53Vi0HLCaD5h6pekf9w==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAXPR10MB5662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:245::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 16:21:06 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8356.003; Fri, 10 Jan 2025
 16:21:06 +0000
Message-ID: <25336e91-c3e2-41bd-88c1-90822fea4d46@siemens.com>
Date: Fri, 10 Jan 2025 17:21:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
To: linz <powertree@163.com>, Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, "xenomai@xenomai.org"
 <xenomai@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
 <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
 <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de> <87ttmwo7by.fsf@xenomai.org>
 <8dbe101.93d4.1944a9bae5f.Coremail.powertree@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8dbe101.93d4.1944a9bae5f.Coremail.powertree@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0045.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::25) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAXPR10MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: e6923628-ec26-4d2d-a448-08dd3192c8c3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1drOXBlS3pyWlRVMWVmSEdjUWlwK1FhNkFKVTRic0hZRG11eWNTQUh6MVVT?=
 =?utf-8?B?YU00dWlDKzJaelJGU0U1UEMvUFVXSmIrZENWVkhMOXAwSjJaZmYzS3lGQ3dF?=
 =?utf-8?B?VTJFdWlMRmt1UnVzVUN6QVY2UjlDTWZMME5SaVA5Ty9aRThxSElOZVhNcXVC?=
 =?utf-8?B?U0VJWXN1S3FOWXFRSkljRDI0aENaM3JUQ2IxOHg0YkhFQ3NTTXFrN24xQjFE?=
 =?utf-8?B?NjV1Q2xCQzhyOWE2eDlxSUx5RVpBOWc3QUVQU2M2WFU2SENpRno1K3loUHMv?=
 =?utf-8?B?SFBDSXVveE9GWW05WFdZejVPM09HZGxQdlRjY1RoZHc0UmpXVWpEQ2tkSDNF?=
 =?utf-8?B?R1NRMzI1Wnd1bVFEaGlIeUt1Tm8yeUp0UTg4N3RGaG1SOWJlcUlEbEk4TWhW?=
 =?utf-8?B?V05QeUhCdXFIOVZocG1ZalYzN1pkd2dabkM1cTVvdTNRVmpHNm1WWWgwQ3Ez?=
 =?utf-8?B?WFpCejYxTWQ1R0h5WkpsYy9JMWU5YlZNSTJMc0d0RGZ4T0NmRjNDMzBUeXZn?=
 =?utf-8?B?blV2bUJtZ0pRVER2UXNidmdKWWcyaTRrY0xvdEdPNm9jRVY4eU41K2cwZWFO?=
 =?utf-8?B?clQrWmY0UmNWSVk5Y3RWNXRLTk1Yc1NVQW9wRHFNdFF4TXR4THpndFdTUnk5?=
 =?utf-8?B?RGVta0QrOTMzTGNnL2U2TldCNFVvemZoVW5KM2d4ZVBTdDFWQ1RWR3JnaUFM?=
 =?utf-8?B?RTBaMDNuOERqV2F2SDNlMDJZT21tZDcrak4rRXBKeWtYd1ZFY3dBOFZQZ1pn?=
 =?utf-8?B?YTNtQW5Qa3dnVU11L2FNTzhsTUdvRDNmQm53dHZsMFVBbFZudGhML2xsNlBU?=
 =?utf-8?B?bEhkTEpkaTBqb1B0NTlwTkIwOHlXNHBXOUphUG52R0RHRnVrMDR1N0xhOUpS?=
 =?utf-8?B?Lzg0VjJiTmFsMFA1L2xmKzFuNGFyb3l0eDFESExvdFlVRjVNd3lhR1hxeWdL?=
 =?utf-8?B?OGpQVmRRRVVzYzl0WVlSK0J1VDFENVdqZDBwWFhOYlVwZEJjUTBBRzlqOXNR?=
 =?utf-8?B?R0xGRWFNOVZ3dGxmSUtIMU4xSnVnMEk5aTg5clF6M1FnUmdJcDFaakp5VEVS?=
 =?utf-8?B?aVE0TjROOXo5TEdxbmNCSXAzQTJkYXQzWkoySFdqTlRjRUZRRDlmUWQ0SC9z?=
 =?utf-8?B?K3J6UHJrWjNjcDdWaDE0RTFwUWg0Y1B0SGgyTmJ3cFpoZ3dHcXlGaUtxMWM1?=
 =?utf-8?B?ZjFnblNha1VUcXdJTTlhK1pkcFFqd1R2WXEvQVlJQk9mZzk4RjFCOU9HbGNh?=
 =?utf-8?B?dUV1TWQyRmdDZlFKd0pVTDBUalVHUHQ5MGlKcldpTWNmVlQ0NS9zOVBoK0pZ?=
 =?utf-8?B?OHlZeWI3Q0hZTmNxR1ZJdmpUWXJzSHc3cy8rS1FQTHY1U0hQaTNqejBiUTRa?=
 =?utf-8?B?UU00cFFVeXVvYmFWbGY3ZnFDR2o2V0xCb29WN2RYaG9zWW9XZ0xyME1Ba0xK?=
 =?utf-8?B?b0l0a1E3Tk5RcTBPUTJFVHVpdFh4OGQ1K1lKYks5bGZkSWlPcytLRUF3SldR?=
 =?utf-8?B?N2dmTmZCOWlrSXhTQWVrZG85MUJmNWZWTmhoMm9TY1R6RlIxTXpRdldPMCsx?=
 =?utf-8?B?WVdlR1BNWmx1VFB0UWpTKzJwM2YxUkU2NGxwWEUra1pybjZnVjJneTVzSy8x?=
 =?utf-8?B?V2tEdEJNalErSVlNazBXanhpMUFHdE1ZUVNERWpFWTBsS1N3czdVTThUUTVq?=
 =?utf-8?B?THBidHdSUjU3L1NmRlpRTnZjSmZuWlRiOG16eEUvYUE3N1dORUI5TDl2MEpz?=
 =?utf-8?B?TmRkdjJZdHpoTENLZkxaMWY4a3lOTEl2SmdkTUVvTmQxaUhEU1pBaEU2UVVW?=
 =?utf-8?B?WkxLeE5tRngrZEU5MHlYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmNuT3BiWUtHVng3MnJUVER5TWJ0aXA0RjhyVkxmaHFRMUI1VThmYzhaSDJV?=
 =?utf-8?B?VXF1Yk5XZDhkc3ZLSm9DTUFLT1RYSVdBcWxXQzZMZUVUTmhjbXRSak5kYjBn?=
 =?utf-8?B?UUJZd1U0amtFTm9CTU5QMk9obUMzNWFrdEJtd1ZkUVpmS2dOa29FWURESU5o?=
 =?utf-8?B?NllzMnBDK1l6Qmdwc2Fkc2RWakpVYjlNeEFsRVhpeWo3SWhONWVqeHhQYWpE?=
 =?utf-8?B?anRYQTZLTk12QWhTUUVLK2VFWDdRNllxTHYrQ2VXZnNJdEp0bjRVM3AvVFdt?=
 =?utf-8?B?b3pLMGhZY29lTGw4eGtDeHRoMkJDaGhGZkJGbzQ5eVFFcGVQRDdJWHlVNzI0?=
 =?utf-8?B?S3kxV3J5azlES2NBYzRzZXBwZkJ2SWRPTkhQYjZpK2FGU3BmVUlzbkhvV2dy?=
 =?utf-8?B?QTlTdzJBQ2FrQkhMaDl3N29PZUdXa1hvK3hOc1VuTHZkdXlkVkliNXJtbExj?=
 =?utf-8?B?OXRWdGY5Y21WNHN4U1dwandCVEIvN2hqZEdvVyt0UzArZXgwZnh4SE9RSldD?=
 =?utf-8?B?VHZNeFJIT2V6Q0VWdnN3N1ZuT0ttWXNxUkh4VEJoRDU5c2dQMWI2bzJXTDQz?=
 =?utf-8?B?WnBGaUVQVDlzZFoxR3ZxRi9rK1Y1blBWdjVNRk9abndzdTI1MFR3L0lZZGFN?=
 =?utf-8?B?TElKVGFqMGZhRlU1UmR2SVZOL3ExbmVLUXlFRnFNM2hSZEV0TCs1ejFSaGty?=
 =?utf-8?B?V3hVU3RYY0M3THBYaFBEMVAyc0VSL3JpUUNuWXJIT2Yvc2p5Y1pUVTYzaXVn?=
 =?utf-8?B?SmNJdWlDRzJIaThvYjlMMkd5U1pJRzJFaFRWcjhPWVZ3Nmd4TnJZc2hRMHIw?=
 =?utf-8?B?QWZYT2pUcTZ2OFhuRXFpVXA0VDE4eVZNTTYzU3M5NzdSb0JWcFMrYnpCeE1M?=
 =?utf-8?B?TnBUT200bGE4YkdiR3FMSngraTYyS2NFQ0F0MEphSDBya1NOd3RkN1luQkQx?=
 =?utf-8?B?V3krcDNWbjNHbVhyeHIwVksyYm5Rdk9XMEoxQVNTbDFQTWtNamlwNWhaemlD?=
 =?utf-8?B?VHJ2cHN0OXNhTlZVd0FBV1BqanJNS1hyNUdMSml5bWdTRnd2c1JENlByQnhD?=
 =?utf-8?B?M0RTUUJTT2cxbW5RdFJIZmFWdXBaSC9rOUV3NGRFeG9YL2tMbDNFeGlIbmNU?=
 =?utf-8?B?K0xTVmRnRnU2aisvZVVaVWFWVnhnV1hGTExZRmFnRE9SUDFiTitBa1drRDBF?=
 =?utf-8?B?bEFXdTRMbUNIV2swQzZ1WmhEWmEzT0loaUdlRVFGam1aNUN1QTdzU2ozSG8r?=
 =?utf-8?B?d3pacjN0U3FKNmxZTmtZOHpjeG95WWkvaXNYa0tPTkJBWS9hZnpUNVV0ZWtL?=
 =?utf-8?B?SkZmZXlQeDExNmJXbEd4R3pocDJtcHM3QmdtUm1JTDdUWmRHdS9YTnE5bWRV?=
 =?utf-8?B?ZHNPZ2QxVHRoQnVyN2VkeFIwTFdMZmxTbkVTUExWWjFLUk1nbmMrYzhaVkFG?=
 =?utf-8?B?TW9sSEpFa0JWUXYyMGN2S0xQd3pFbzBJSkZVaUV5VEpXUnlPSHA1ZHZVMkhj?=
 =?utf-8?B?NHgyQi8wTDUzSC94RHVUcVp5dkczS09OVFk2eTQ0UGx4bm9IMEpNYTdnVHBx?=
 =?utf-8?B?cUViWXdzRjQ4a2wvSVNTM3pIY3doelpxdUVvVjQxcmhyOVkrWnZqalpudGlH?=
 =?utf-8?B?SmlvWWI5M1Q0NnQ0VVFRS3BRb3RoSW02VnFTUElaZmxvRlp5VjJ4b0hGSXVD?=
 =?utf-8?B?VTZmLzAvZGFHaEhyL0FKUWh4WDRkZ2xyYStBcDZTNGVkQjFFNmNpY1RkKyt3?=
 =?utf-8?B?Mk4zem9oN0pHcUJkWTAyK1d2QWwzb0tGb1VDZTQzajBKRElaR1Y1TDQ5c29J?=
 =?utf-8?B?NzY0M3VDNUY0UWFLVTN6cjhDQkJtQXovSW1JdTdzdTBsLzYvR24wem16NENj?=
 =?utf-8?B?QWQwYTAzWW5qbzZoaHZXYS9uYjk0U2dkbG93WW53UnFFR1A3NnVSc3pEMDd1?=
 =?utf-8?B?LzU2cUptSkFsNkU4T2FSTFZINWlBTURPRjdFVEt6cTFmcVlYbWlrWEY1MVBl?=
 =?utf-8?B?WFJyc3hyQ2h3VEhQS2RaRHlZZkFtTHE2V3NLUWQrL2JaNmZwRDVadjJkQnFY?=
 =?utf-8?B?U0wwL3V6aFJ6c1RpMzlBRitUWk9EbzNkcFBYT0lxS2lralA2VlZOYWx2dkQ0?=
 =?utf-8?B?d0szWFhCU2lHREt2c2NONkpkc1pKaUNqMnc0enhLZW5VdE02bEtLQ2thUm1i?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6923628-ec26-4d2d-a448-08dd3192c8c3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:21:06.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8iRY5IM4FbZ1Dt55F2PcGNVgmWBCe6mivihSpdqr6dzT700Y9DBPNNP0Ok44IZ7Di+wLYLA+cWa35YB8Qq5Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5662
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=bbnroEfJ;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2607::627) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")

On 09.01.25 11:28, linz wrote:
> Hi,  all
> I think the following patch can resolve the bug,  it allows oob threads to safely preempt kernel_neon_begin() / kernel_neon_end sections.
> https://source.denx.de/Xenomai/linux-dovetail/-/commit/9b19700e623f96222c69ecb2adecb1a3e3664cc0
> 
> But this patch has been merged into the Linux kernel version 6.8. At present, I have no plan to upgrade to version 6.8.
> I'm not sure if I understand correctly, but if so, is there a plan to backport this patch to a lower version, such as 5.10?
> 

Have you tried to backport it to your kernel already to confirm that it
helps?

Unfortunately, it looks like a cleanup to upstream, so we may not get it
in via normal LTS. But if it help, picking it into dovetail LTS trees is
imaginable.

Jan

> 
> At 2024-01-29 16:42:38, "Philippe Gerum" <rpm@xenomai.org> wrote:
>>
>> Jan Kiszka <jan.kiszka@web.de> writes:
>>
>>> On 25.01.24 04:18, linz wrote:
>>>> I think my patch is not suitable after listening to your suggestions.
>>>> And I don't have any other good solutions.
>>>>
>>>> I think x86 is ok because there is no operation of writing global
>>>> variables in the critical zone.
>>>>
>>>> kernel_fpu_begin
>>>>     =>kernel_fpu_begin_mask
>>>> =>preempt_disable // enter the critical zone
>>>>         =>WARN_ON_FPU(!irq_fpu_usable());
>>>>         =>WARN_ON_FPU(this_cpu_read(in_kernel_fpu));
>>>>         =>flags = hard_cond_local_irq_save(); // leave the critcal zone
>>>>
>>>>
>>>> But in arm64, there is operation of writing global variables in the
>>>> critical zone, unfortunernaly.
>>>> efi_call_rts
>>>>   =>__efi_fpsimd_begin
>>>>     =>kernel_neon_begin
>>>>       =>get_cpu_fpsimd_context
>>>> =>hard_preempt_disable // disable interrupt, enter the critical zone
>>>> =>__get_cpu_fpsimd_context //  first call, modify global variable
>>>> fpsimd_context_busy
>>>> =>hard_cond_local_irq_restore // enable interrupt, leave the critcal zone
>>>>
>>>> handle_arch_irq_pipelined // Latency timer interrupt triggered
>>>> =>handle_irq_pipelined_finish
>>>>   =>irq_exit_pipeline
>>>>     =>xnsched_run
>>>>       =>__xnsched_run
>>>>         =>pipeline_schedule
>>>>           =>run_oob_call
>>>>             =>___xnsched_run
>>>>               =>pipeline_switch_to
>>>>                 =>dovetail_context_switch
>>>>                   =>__switch_to
>>>>                     =>fpsimd_thread_switch
>>>>                       =>__get_cpu_fpsimd_context // second call
>>>>
>>>> So, I think there are more todos on arm64. Do you have any other good
>>>> suggestions?
>>>>
>>>
>>> Philippe, some input on this issue would be helpful to know what the
>>> next step needs to be. It's still unclear to me how fundemental this
>>> issue is (false positive warning or real state corruption?).
>>>
>>
>> This is a current limitation on arm64 which amounts to a bug
>> actually. x86 has the proper implementation, which allows oob threads to
>> safely preempt kernel_fpu_begin() / kernel_fpu_end sections.  Since
>> kernel_neon_begin() re-enables hard irqs before leaving, it is creating
>> the opportunity for a mess.
>>
>> The way to fix this is to implement the x86 logic to arm64 when it comes
>> to in-kernel fpu usage.
>>
>> -- 
>> Philippe.


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633A1B29AB
	for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946178; cv=fail; b=XuLWBfA5gyVXK3MAN/XgY4T06HLYVg0SEC/yVmtm2403V36h2JESQRdrIdfcOf1yrVeMc81KNz0fBOgvTUd5y7cZe6MDkB0YmfUWszaG4Su3w/5/Y/MXZQOqjQZFmz6DgVixsagSKvl4Q5W5da7eQaU3j2VT9ma0N9zfkZdr7rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946178; c=relaxed/simple;
	bh=8mFgzFqFxd7lx2c2sBrdhVF3YVMUkz/9SeeHv6jIzH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pZZPhr5z3RWOG0YO/FujxMONuNuxTB323ouKZjjFx1AkA4B21oAjP0Nr0E67/YaWAFHlxEDyRvs8brWHmSkChX0ACtkijoAWkONBvDEaoeIZ7ANNPi5hfgIidAjWiLLqxlFZp7aQK4TAlgEnYlYz+tMMbAFwKaeXae610hpEVr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tSe2MCHa; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tSe2MCHa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsOnnitW21VuEjCOYhhHy8lIjJ12zXp7U6fq2ZAljXOEMlvsLeVE/u2hcstJkjzypysfQaZY5vn439s9iqr9ZVcafPZsK60NTqeAXyJiel800tVg7JymFPM/O2a9mwpyqzGfsu+Mq2A/PtM9PpKaHU4ne06+s7q4wB6Snqc+qLAGc26eQy9fO7/Koehlr3OAXQquxfA7Fxp/9zm1IUc2Dydo2VgXTCN9IdXs2IW+NuGtievrfMwJdXl96UMwJoKN/LUqHat7ezoz5i5TwU8uzwEKWTdjPU2jU+U/JP1XYzOoDoeehxO/c/JbM1AYDxu1iOiETJjk7yEJdD+jM5IjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOQdE5nfFLsO4gDYEwgkUZzY1Zi2CmvID08s7PZ7ziY=;
 b=fr3RjwQbuRF6APex5OKUFGNFdDu27zF9aEH/WEGrMHp7mZoioJIW0P03nhVEr4XLwkcVnUvK4akCJJA+vww6e/cYOeVfmnpMqJdrPLporMIKxNF67w8guPdBB9P2iTH7AX6kLMvaCJ7jEJptWktVpDUwLTCrBVwX/G3pQAW28gA1CLy+4nZhC5AcH57SmIW+RuqsAITYJ3/6FjhtOEEqn+bnkyae4jn96k7Xkcp8Ba47cmiF0RR+ANZoz1MkpkyBFh4l42gVj4s1oA3yNtN9q/bDVHQgz2edjrIpSkXQ33Vn1G3luFWlDapLSatFYG9ch4aGqU9lyhy+8x3HFv0V4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOQdE5nfFLsO4gDYEwgkUZzY1Zi2CmvID08s7PZ7ziY=;
 b=tSe2MCHaWA4z/DItUrCo1BSA/FJ7qZu6rFJpzPlMcchuxZX8RzBnmp9O5wShgJKmX1OGSUeJJQBuB1DhPDX4fM40UMSZkrLNtOwoGvhDwmUvFogfJylqCFiZj+rxk6FqVlMTUPYIUPBWRm51p+JbFRc7raLDiEIIYSBdQM0G7RZtXilXo/N8rcE/x6FnyOS56s72MFk5NDo7T9huBWWEwxLa3j0pP1Rq3zPr4Y4nysx2CwnqzS0G73D0wHk7ENrd2WO7VoM4duR6tbftwfkiNdANsc0ZhgFIAUuMcsaotih3vR94lH92hXfS2AIi0v4DyGDZiX2gTKE5faQ3Qq1/cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB5815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 15:42:52 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 15:42:52 +0000
Message-ID: <a8b899ec-c5e1-4263-98b0-7fc4f7760613@siemens.com>
Date: Thu, 29 Aug 2024 17:42:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add env vars for session and cpu-affinity
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240829083526.24536-1-simon.graber@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240829083526.24536-1-simon.graber@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:907:1::44) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1900cc-d347-40e4-8499-08dcc8413e06
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlVzWkYwb1RLVWYySFZ1aFhCL3k5MytsUzJKUkVML0g5Y0MraE5NMm9WZW1M?=
 =?utf-8?B?dUxuTjdoc3pqbHRaVW92QjJNYUllSk54eXNCb3g1bkN5emx3aTY0aUc2eWV5?=
 =?utf-8?B?REZNZlptVHorMk1RWGtmQzdsLzNFR3ZLWnIvQUlNZnhMN3hwNlRZSEtYRk5O?=
 =?utf-8?B?bll4d216UVVvR1pIKzVPRVRmTktWRWFmSDhkZ2k5WjJ6WitRRlZWdjZ0OFZm?=
 =?utf-8?B?dmZVK09UaU9lWFVDeTVHNGRKaVZtWXlhS3JEbDZUVi9vV0l4Rk40WE5DR2l3?=
 =?utf-8?B?WGU1YkUveVlJWUpweW5zdGlyNUVDZnpJT1VYallQMzYwRXFmamd5L0ZLVnFw?=
 =?utf-8?B?NnVqdG5zbEs3dTE3K1A1SXFWdXRhRXVBMHB1dE9UaXBDbE96eGNSbGRyQkZR?=
 =?utf-8?B?cUY5eEhMcGRZZnR1QlM0ajUzcWZ0NUFiQ1pXNG9nOEJvTElKeVNBcFNjU0VZ?=
 =?utf-8?B?TXEwcG9yU1J2dlpmeXgvZWpIS0JkbWh0a1dGTUJTQnR5WHdlQWIwQ0E2eUha?=
 =?utf-8?B?MmRTZ2czaWkrU2xOR1RRNDFoZm00aCtSWWtGM0Z6TG5VaWszeUVkZVdXc1oy?=
 =?utf-8?B?K3ZmOTdRaDZDaGlDM3RudEIyRkV3bXpkakhCeVZBL3BPdnFHZityOXEwV0Qr?=
 =?utf-8?B?UFlXdUppYllndFI5N2ZoclhaSlRsT0JYcld5aHJWeFpzQ0taQUQ5QVFDVkRM?=
 =?utf-8?B?SDFVRFdoeWxBdGJ6U2N4RnVsSENiSVdwdGZRL05vTXEyK292bmNRaHE0UXJC?=
 =?utf-8?B?ZVZQUm5qQUYxbVBWWnRFSnNoT3JCYmdkU0luOWZadWZvQUkybVFEcUNhU0Fn?=
 =?utf-8?B?L1NGVWg4eXRrNVFlcGdVMVExeXVPNmlxVzNpQldJaW1lWDR3R0ZSL2p5cG5F?=
 =?utf-8?B?WXdKY21vYzZvRkZ0UmpyOXdPaWEyaHo0bTZDRmc0SzJnUnZkNTJ5WXRxU2hY?=
 =?utf-8?B?MmZnaUtJMWdYRE9Ya2k1aTJzQXhJVGNNeW1wQTJYYmRObENFdGNXVVA5OUhP?=
 =?utf-8?B?TzFWeWtoelRxM1RLRUNjVVAxZHQyajZBaUpCdm9aWTVuT1ZVQ2o0R3NNakp5?=
 =?utf-8?B?Z1VaVXliT0l5V3JpODV2ZGxaaDBQTDFnWS96NHlmUEFqWHQzeHV2OWd5TVdO?=
 =?utf-8?B?Ti9XeUlwZnZBZy8vdXRvNExUOEQ4TnU5czE4MFNhZUdVc1R5U1ZubjA2QXNP?=
 =?utf-8?B?Y1AwdldIOTlwbUxFKzZ1a2c1bk1CNTZMZkluZnVPMDluaUZOZjBPeXNFaHBp?=
 =?utf-8?B?N2E0RXVERDRXdytmaUtXRGxSMHlTbWU1S0E0UlEwa0NJdmU0TWc1b0xydTFp?=
 =?utf-8?B?VjdMSHdtTExQQmpvakhXcmtEN2l2MUxBWklWZHpxN0F5R0ZlOEVaL1BMeUk3?=
 =?utf-8?B?bE5UcWJSQUlGMUJkTXkwZi9DZ0hOdUN1akxmN1F3WW1LZ1g2ZG42ZmIwbjJV?=
 =?utf-8?B?cG85UlJqZ1dRdXFzdmlhd1hmWU9nZGswT2dBcUhnYnkvOVU5bWF0UXh3WU1i?=
 =?utf-8?B?b3JqVVVxb1czTnNEN2pUUVRHNkRHdFpSQzQ5T3NJNS9zNjMrYkNWUVlMeTJm?=
 =?utf-8?B?V2VYKzJ1VUxSVmFvVFVDaVhQRlMxZVViTE5aVFdxMTFKOVdPMy9NaG8rZFcy?=
 =?utf-8?B?YzBYeFNGMkJiRGxlTXh1dW9vcWtycmM4VENwMnhUbkYwdnVNQmVzbzIxZVF6?=
 =?utf-8?B?ODQ2Z1pvNjFPeXk0eVhDRkdyMTJxdXpGdTIxSGxEWmtjeTBQUTViV3VHZUcw?=
 =?utf-8?B?aWZkMnhyYVRuTXlLc1NlRERQQmc1T2h2cG05UEhKRTMxTG4xUGpEU2huVEts?=
 =?utf-8?B?dHd3aE05TDY1TEZVN3lkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDQ1VXlOeG9NZmlRT2hsbmxUbElJNW9XQk1JUmdTaXE4eW5taEJsT0ZRQ2x3?=
 =?utf-8?B?TTVrOVdaWEpKRzdJUFU1Y08wbFB2b0pKZWsyY2hQSUY4bldjazA3aXBEemVP?=
 =?utf-8?B?bVE2dTFCQVNJSEQ0elBRS2ZFdEFqdGQxM3duaTEzaGtEQ1hCOGZyMjFWTjlv?=
 =?utf-8?B?enc2d1doT2hhTm1ZZXUyaytTa0U5aVpJQUxsZnM0cVE2MlpVWnZtOXBlWTZP?=
 =?utf-8?B?eHZUcVg1OUtEWDA0TDREbTFFQWpDeHovT3JQT0psVzBlOENSc09nNDRWdlhN?=
 =?utf-8?B?QVpGYWNsVFl6aTgwd1NGVWRaVmxMK0VIZFlmb1l3U2lCYXUxRk5weDcvUXZz?=
 =?utf-8?B?bjArZnYweGJmUXVDc1VIRTJqUitaemxTVVliczdodGl2RGpBaTRCY05reTRx?=
 =?utf-8?B?NW5GMklUcUNCSlU4di9KbkhFTHdXSGYrZ0VZTGlBQ0EwU2dpaUt1a0hjdE5W?=
 =?utf-8?B?SkVETm9qMEhQOVB1YTlmcnRVS1RvaHZSM1E5L3diZEI3Z24vS2g2WU1oN0o0?=
 =?utf-8?B?MkU4MHlhRGxwRzFhWWV0dGFiRzFMcDhBYkZKZWtRbjFDai9IQ2F1REZJNWRG?=
 =?utf-8?B?Zll5MWkxRWFHaHFxa3pjNWRwYU5lQm1yM09ReFYrSFQxR1pnajNEZkdhQmVq?=
 =?utf-8?B?NHBJWGcwbUwzVzBUWjZFK2lGdG8renJVNHNDWlg0aHBrM3RKQklSQVhiUFZm?=
 =?utf-8?B?eVVjNHU3YS81R1ZYbjhWb0RSVHlFSkVOaVBhdzVaNTdjVzRibFBBM2Q3M2t4?=
 =?utf-8?B?RDRHOU1IdU9qeDl6bnNFaURVaHRpNm95WHczOHgxbUJPQlVvSnJwNlB4bjlP?=
 =?utf-8?B?VmRza2tsdE9RWStVb2ZQNmNBMEVqKzhZZmc5TjRsR29ndW9LVlZqWTFjdm1I?=
 =?utf-8?B?UWRHK2NsUWtMM0dld0N3Vy8wN1hpUEJ2RXNwNkRWTlN1YkgxRUorNkg4REcr?=
 =?utf-8?B?a0NHNzJTaUpoU1duYTBjSHpqT1dlOUF0UVFUMU9VNnM0V3M2TjJ2N2NUeU1R?=
 =?utf-8?B?V2pnSHF6UHo1SDBvcW5iQnYzUmNDV3dZQW1iTVVBUkVURUtXcnVTQ2hVY3dF?=
 =?utf-8?B?QUNuUEl6Qkxqd1p4SklPVHVNbjFCTUw5WWFNdDFQUFZ2OXhQQTllMVhTeHA4?=
 =?utf-8?B?bmNvY2xWRVN0YUk5R3lUSUtNY1RtaHJrQ2J2QUNxS21qc0huWFVtbjk1TzhE?=
 =?utf-8?B?NEsza01vRys3UDhCMGh3N0VvcFVJQjFpMGgxVytqdkVIeHFPUFpLdHlEMkRH?=
 =?utf-8?B?Y1kxSjd5aFFlaXhRcGdMdUpIamUwL3FTdUtjdU54Z2xxektrUVNjbTY3TGV0?=
 =?utf-8?B?ajBoT2JOQUpDYU83NmhldmdrODFHY25TalF4b2gyMlNMYXcrbXg2M05jbnZD?=
 =?utf-8?B?V1pvOWpjVUIzZ2E3TG9rN3M4MHJXZDlLalZqNzNYVGVKN01YZG55aTRvYlc1?=
 =?utf-8?B?cllnREVlUkNtT0wva3MxdUZMc3l2Nkk3Z2srYnVWdEJzSEJCd21rMzk0UFpW?=
 =?utf-8?B?ZjJCcUZhRHdLaXl4bWZkZTEwQTJ2L0s3YTZvTnFWL2tQUDE5SHZob0lnSjJl?=
 =?utf-8?B?ZGZTL3ZHTkZSS3RpOExidmIvb1UySXF3S2NuQS84WGlDTFd2LzdyVXJuQ3ND?=
 =?utf-8?B?SlZNMTdIZHlJK3I5ajZWV003TjhFd2xZQUsvSUN1ZjA2cTY2WXZ2dVdxWlN2?=
 =?utf-8?B?RjJkRXIxOTlUVUJBRkZieGllSHZ2Uk9KRHdocDZZUkE5R1dNL09rUnhKKzZ0?=
 =?utf-8?B?eW8va1h6ZmFiUmxqNHVnYlVBNFp2M0RnREJiOFRSVGNldXFzVEZqZkk1YXpu?=
 =?utf-8?B?czJobS9XT1B0ekU0VWNhVEtSWit1VTNiUFVWcmhhek9xUStHS0xPeHdRTjFv?=
 =?utf-8?B?QVdBVnNRcm51dmVNeDBNV21ZdE52OFpiWEdReWg4ZUtTYkNYbjZPblJOQmR4?=
 =?utf-8?B?dmdHLzBONnFCMTFJcGwrR3B2QitFYWlQcCtldThxRklkYUpEYUdlWXIxYVA5?=
 =?utf-8?B?M2pyMjRjWmZtWGlFV2xMTFdhQVJhalVxWStZWlFaWVJNdU42d2FzSGs2WUhE?=
 =?utf-8?B?N0FYUmpxdTZOSThYME5CWjhLdmlXVDNJVGVMWGlhQm5rM0ZzczVROENTaGFK?=
 =?utf-8?B?UW5zZFRBV0w2cXltTk8zM1lZcEJnKytwNlZmWHVPM1l6QXdFb0E4WkVrU0hK?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1900cc-d347-40e4-8499-08dcc8413e06
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:42:52.1297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYGKJu5/A74m6S7JHqK3fU23PTPNgB+U6TBC93b0MOdZ/bch/yQWq8evUVFMd3DmewsMorXqaOe32H3J7BqEIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5815

On 29.08.24 10:35, Simon Graber wrote:
> Hello,
> 
> Revision 3 of this patch adds documentation for the new
> environment variables.
> 
> Changes since v1:
>  * Usage of environment variables is documented
>  * lib/copperplate/init.c: Conditionally query XENO_SESSION_NAME
>  * Reformat patch 2 to adhere to code style
> 
> Simon Graber (4):
>   lib/copperplate: Get session name from env var
>   lib/boilerplate: Get cpu-affinity from env var
>   alchemytests: Set cpu-affinity by env var
>   Add documentation for env vars
> 
>  doc/asciidoc/README.INSTALL.adoc             |  7 ++--
>  lib/boilerplate/setup.c                      | 39 +++++++++++++++-----
>  lib/copperplate/init.c                       | 21 ++++++++---
>  testsuite/smokey/alchemytests/alchemytests.c | 10 ++++-
>  4 files changed, 58 insertions(+), 19 deletions(-)
> 

Looks good in general. Maybe we can sort out my comment on patch 3
without version 4.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012018.outbound.protection.outlook.com [52.101.71.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007311D5ADE
	for <xenomai@lists.linux.dev>; Sat, 31 May 2025 05:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748669708; cv=fail; b=BbmpfMXZx23vEAjp67Aw2AGWAegm9EgKil1Y77+lk9U9prWgzqIH5ubnsSoZuGAFAj8nLqtxk8n3arXflVwqppthrL9IYAh9ufgptzEkaZLoCY2yUUBlJqVcxx2fG5Rvvmy+3NV98rBOjn/AzSzTgH11D/XJAQncPWvpzFxyOzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748669708; c=relaxed/simple;
	bh=rcSbvHlMFwhR4FMSwWy9J9nxSX6Ei9BQOsyHmmv2CEA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZU0498k8ZR+Jgq9dd57GsHHYi2mYke3zEZUJKynHer1OOr0tM/0/DHXy1lsRP0egywos7vcY5PTwey2Ke8/sSTlxIgbtQqCRfsBBkLUQjcM44kSwDgsYwdWhFPIxt/Ic5vPz0BJJmD83F9r4HdiDWC03hquubmlhF2XrDtXwnmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uotiYRMl; arc=fail smtp.client-ip=52.101.71.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uotiYRMl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG+qH8AxMhgko2s3n7/gJpb6oQy96UjDqlM/bL7HpgIFPjBWscPv8Q/lb6C/YIbhffvt9ncLzFS7tBbptzvvpoQF0XvkWIFEpkCmIBnAKPNTOkrJ5pRehfRQ2Dc18wAHubTLpWuiOGXg5z+8ojzlJ5ma5xBkakkrmcCtcIqJf64k7L/ElXIjVjljuixUevj5iU93f8rq0zDws5w3+cz0Nb9JQMux1OaqyT9soXb6EbaTKmmlw58E7zoNFuhuYE8jjfFvQgWF9Pk0p6nXvCiTubb011y9DMruILnGpZZS0ZR7RJ0a1BoCaEt41bKmp692FdhJw0es8+ir8NYV3fbiKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7YVYFxt9RQpiqaIGorVQcZnf/ULfIGVBRSfzE2Eg7o=;
 b=o7g10mNV0RG8SJAPsmTozaCS0f6Rj8x5PKpqQ5y4VIGYUrFypIVLQ0/KHwLFUjwoOrcI/UFVWvCry6YNf9brIQ+DOBpvqBsgqT6QZLHVEtrc0uWKdQz1nTXo3FjR9uClhBj519pvBjFrNdwO9TWkFSiH6OZK4oSqgR7wLQmDJ06snFaD0XcaQt81nfldWVSp5dUdBabdK8GkjHOBrLpVeY5G8plRFWxb39nKTdPE+8+VcfhMsBJScns2I0GpRHO3Va+Wp19PvP2DOCAF9mWNjK469zUbCoUKHkfu6R66DZUcmPUMOfuUKYzaCBbk+NDuATeHcckQba6Q8Tmn8FRqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7YVYFxt9RQpiqaIGorVQcZnf/ULfIGVBRSfzE2Eg7o=;
 b=uotiYRMlU085eekVbmS3JhD/LuWLn0NwkFgotK8F0GLq/rfYOkX92N7mEV8M/6yC2ErAgzC+HX2u5/U7VOnrJDkTAD0N5TZW2TeqiMbKnEQJQp/K3Q9zkey7dsG40AaDkWF05DQXpsl3Ceb9db4m3CrSdFwmMn/IAh+9JvJO0yg9pp4mEUP2SBcnG6RUs6kXe+v8gGxPSekclbveieBYn71wtatpEJEr2Ub5wbtLpLPnZl+qaGHK8JjiqZKCurix6hzHw94WftDfj/oRnzXmlrqljce6CjnN2j0UZmaKZTgwNLoV3TplyJCC5YhjD2UTZFKvQN0jGY7FuwdVo50V3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8183.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Sat, 31 May
 2025 05:35:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Sat, 31 May 2025
 05:35:03 +0000
Message-ID: <f750c64f-0914-4b5a-831f-5353ddd0eb8d@siemens.com>
Date: Sat, 31 May 2025 07:35:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Inquiry about float-point calculation in RTDM task
To: Eigen Zhu <yinpo.zhu@gmail.com>, xenomai@lists.linux.dev
References: <CAHVFwiXNua2WnMZ4qCxmG2cPfMBiv2ptTjO6tPpfSPNSjX+5Ag@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAHVFwiXNua2WnMZ4qCxmG2cPfMBiv2ptTjO6tPpfSPNSjX+5Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: f158f127-ab72-4220-9ef4-08dda004e4c7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3BMQldlVm5US01MUjZxU3JyV2tpdHgwQXRETmZvNDk2elF6Q0Y4TGVKUXlL?=
 =?utf-8?B?VEZEUkhTb05nT1d3WnJ2RnBmMXlyK0ZUV1hTNWxtMmhrNkFzenJzWVJvbzU5?=
 =?utf-8?B?aWp0MlZSUis2MTlWV3NKbzVhS3RKME5mT0lNTmwwYUpINHBvZExoNjllc0tz?=
 =?utf-8?B?NC9iRDNnODk1SkJ2clRoN0VzdmpiVXRyVlhwcmZKekZ1aHNNaEV0cjlFR0c1?=
 =?utf-8?B?WlNLNFlnak5PQ3dzV2hJUkc3QVBadlJSRWh1V015WGxUamJQbkRZRTlKRjd4?=
 =?utf-8?B?QkJHcTB2a0xPTEQ5QWVRSVBqUHVrR1NuMUxncUJ0Wm9oc0hYZ1pOT0huTVBL?=
 =?utf-8?B?UkorT1o0WExRZ0ZXS0N4dXU0dFhiUnBxdHhMOHpFb1AyelA4czdTTDlrUnpp?=
 =?utf-8?B?OVFBU3orSnpmcUZWb3RaQncxZnROUzBWNFNobHN5amNKdmNjWmk2ditpb1Nr?=
 =?utf-8?B?L2N2WElsZU90bndFc1VwSFR5NmNVZWY2cVlpSTYrL0FiK0FTQUp5OTY2RXF5?=
 =?utf-8?B?a3hVaGdJSEFTK2M3RXo3NTJ5V0tyazZRbHF0ejlrK0tPeWFtZXp1Vm5BY2Ns?=
 =?utf-8?B?VFV4NEVkNm5DZnZIblpOU3pXN0g3NUdxTUxHdlNGUGhOOGVXTFJpcmtoSkdL?=
 =?utf-8?B?dGdMOGZ5UGZ2a3U3MlQ5YjNTQkhkKzZ5MmY5SFBMWFY2SVpzbHFRcFBhdVA5?=
 =?utf-8?B?K1ZFUnd1cUE5Z1grZkVsREZtVjZLN2RuSVp1eUNlcndTUUIxSmlvMGZRZnBY?=
 =?utf-8?B?ckdWbEZhQnhVRlNUOVo3QkdwYUU1SVhqenFlSlpLdmxJa3FrQkpMQlJNRUFU?=
 =?utf-8?B?ZUhXRll0S3VDS2pNUWlRamdYYTVpVkw4RWt5VFpldEc1aUl2NDJoTXRSTDZZ?=
 =?utf-8?B?d0pzTUQvYXhrQ1pCOHowRDhENEdFNzdvMUtoZG5nOXRUc1huUlUyRWNUYU1z?=
 =?utf-8?B?L1Q5cGhWOWhOVVpLMGt0SVRXcUdyNmdvR0V0cFVYbU5vRjBmZHVHbGtET0tJ?=
 =?utf-8?B?S1ZoREQ4ZmJpVGVvVzRydWhtNnk1eXc0YmFFSWM2bGNtdFBENlRSeTJpR2N3?=
 =?utf-8?B?OW91bDdqYnBUR3k4eU92dGlRTE9DaEYxaUpEN21lZ1BpYllrUS9Ic0pubnEw?=
 =?utf-8?B?d3lBSmpmT2ZMbWZnR2VjSkJaOGhTWHZiUTdZVnVxazJON3NDYmh3WmhmR1J5?=
 =?utf-8?B?ODNyUDJNOWxOeG1vL2FuUEFGMUFuYlBOZzQyK2kyK1loQmpzZ2FhL2dsMnVw?=
 =?utf-8?B?em1xOFlXRVB5eVFKallveDFzSTJ6dGU2RjlzK1o1b0hyblRZMDl2dENMV1hr?=
 =?utf-8?B?UUd0UEtsZS9YaWhTUlBldjIrRW5hOHp0RFRoZUJKQkxzOWlvSTlDclMvRUF2?=
 =?utf-8?B?RDN4Z2htUnRXWXF2eFpQbWFteHhBVFRHWkVNRVVIdGU2QUQ3YWR1TTF6dUF3?=
 =?utf-8?B?cWRYMHhGQWFNemYyc3cvd2dFVnkvdXJ0Y3NiRk92R0EyMFFpZjBvYzY3NEhN?=
 =?utf-8?B?bzVjaUJXSm15TU5Xc2t0czNDR1VpWTVxYW1qZzlmMlpNWmxSRmpWOGU4bnNi?=
 =?utf-8?B?eGQ0eUZWT0Y1b0k1Q2dFWkt5SDZNeHNObjFiODNLY3JaNlg5eGpjdU9tNnZP?=
 =?utf-8?B?QWxTTFc1RFJCWnM4cytmOWducS82WmZ3bURxa2NLc2VjWWNyRm45b2FFSlV6?=
 =?utf-8?B?S3RzcWRYYlNWYXZuKzZZSnpnT2gvdGc0QVRiRjBiMDVYY0F6Ui92WWxlb095?=
 =?utf-8?B?b3Uvb01TdDFrblJvRXhVSTEvMVBhWjNra1lvUXBXVU1KTnBZeDZ6d05MWmdS?=
 =?utf-8?B?eHhXbERkaFM4aHNYd25GaWtsMzBoTXJzeGU1VWJiSXhSOE1tYWs5cmlmaGlu?=
 =?utf-8?B?blRzbG9nN3MxcmhEV1R5Uk5Zd3N5ME1mZVI3K05ZNmMvdlhuOG1EUE9vME9q?=
 =?utf-8?B?VktRL0FqdExZNGJOYmZ0bVBza3U5WnJ5UjJYQWx1UmZOMnJNY2lobTVKcG9S?=
 =?utf-8?B?MDkxY200YkJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGZaR2EvRzRXc3ZFZUxEeHVxSlVETkNqKzJaMEYxcklZY2FmYlJMVmVWcUZy?=
 =?utf-8?B?SFRFNHFLYTI2NEpwa1JtaVM2ZzRpaW1oMHprU1dWNDZGWTBLbXlPQmg2QlN5?=
 =?utf-8?B?SmZFekZXbS84MWhRN2JFaGlXSEZzZWEybUw5WkduTGlmbERuR0J0cmFVSnA3?=
 =?utf-8?B?aXhxUzR6MEdzblIrRWdoQi95YlFHdzFWRXdKZStBM1VrM3MzQms5aXl3Y3N0?=
 =?utf-8?B?Rmt2MXgrOXhNU3A0dzRvczFwSHplYm1mdXFVZys0S0dnS20vdnVHSXYxdTB3?=
 =?utf-8?B?OXQxaEt5VDBkdmU2bDVmcVhZN2h4cFlyOEp1TGNIanRWZjRSMmxNTDZvc0tx?=
 =?utf-8?B?YmdjMmVkUzliNStrQ0N4NWRZYmZDOURIQmk1ME5GSzVlYUJDNStuN05rdFR6?=
 =?utf-8?B?Wjh2RHBna1pnMTRhWmFJZzI5M2x3RkZEQkJPYWlaQndkQnBRNUJwcEFWaHZq?=
 =?utf-8?B?RWh0NWx3SUdneGcvU3FhTEx1V2VESGpyZTRLaWtzVmNEekVPLzY5ejlDbmNh?=
 =?utf-8?B?RXZWaFNsMG5iS040TmxYMkVNQUNMbms2ZjJXOXlMUEtadXI2V016UjlhY1dM?=
 =?utf-8?B?a2RpRlRkWENybFFmNmhkdjFpQ3J6OXZXNlI1Mm5zQXM5NDh4RlhNSjhqS01Z?=
 =?utf-8?B?MjcydHVsZHdXRjBxZTZzNHR0YUMyMklMZlduRnYxODhZWFNQWS9USWYxOXh5?=
 =?utf-8?B?S3VEbVl0Umh1eXFSZUsxVGVvbWVyNUZMSnpzeGVCTmFtQVM3NUtHQ1V2SkJM?=
 =?utf-8?B?S0dKU0kyNXRMTm9KdDY5djduWno1YzJpbGt6UVBiWldOTTRhcW1aVm9RazI2?=
 =?utf-8?B?bGFob095TmVvZjdSdW1BcXB6M0ZSaTVmZzVoVElJcU5iM2wxa2FUVlJDc011?=
 =?utf-8?B?bVJMWkh6NWdBMU1ZcUxzRTkwWitMSS9KUFRtdFJiclZUeFZjYjc4L1g4SW52?=
 =?utf-8?B?c2huWHZsY29ROVp4ZzZJWEdwSGlWOHA0S2FqdEdSZFBBanJ2dDUxZUhtcElC?=
 =?utf-8?B?bklXQ0pRUXB0TkRKQTc3SVZvbzJ4M1dpdEhRajBGUFFyeUJHbEVOUkgvV3ox?=
 =?utf-8?B?RjhnTTdpU3RYK0M3akRsWW0vRmJvSFN5KzRZUUw1UjdtNGo3ZWwzbFZtYmpC?=
 =?utf-8?B?SmRoL09pVUlUQmpKRm1FZ2lwaXdpZDh2WUNHUHJSZUZQWDFvSjRNNkltUS9m?=
 =?utf-8?B?T1l3NTB4TVVpZGxoc093TTdseEloc0trUTB2SjBXZVdVT2NwME5aQkZ5U0V2?=
 =?utf-8?B?R3dvbi9PT0hUcHNuZjZhZUtmamNDdnI4T1gvazlzbFg4WkY1ZDFvZkkyaGt5?=
 =?utf-8?B?bTVGV1FudHZLVlRiUnpyeGExMFBpajJlZkE4T3ArWG9aU01FSFlNbHJBYU1H?=
 =?utf-8?B?dnFkSmlHYzJLYWpwYkx3cUNRcFQrV203azRUSzdDNUR2QzV1S0tmYVBQUFlh?=
 =?utf-8?B?NFE0NUdQVHJmRzkvU2xCcVc0RDBUY25vaG0wT0VtUndzWDB2SDZhbk1EU3lD?=
 =?utf-8?B?MW53Z3pqamRvMHkvS2dyaUYzdjJsTjAyTWVnSWNWSGFLWnBiVkJKSGVmRTh5?=
 =?utf-8?B?Zno2T1BqLzFDNGdLSk1hSzlKajByVmJDRmV5MVExaVNjdmtJWkZJRU9YbGJ6?=
 =?utf-8?B?OEpyK0J3T2FMQzJvN1FsV3dlVXNraHIzdHFJSVJnaXBUbGFTMm9qRXZNOUFD?=
 =?utf-8?B?RktUNXpGK1phTkVmVDRsaHhWblFZNko4ZDlhaFdKY29USlUraW5iMVJmZ0Q0?=
 =?utf-8?B?VXFmOUZqMUZNeEFXMEkzZDJ4elk2M0RUSVFIN09jazd3eUc0dHIxbUJ3SFMw?=
 =?utf-8?B?OTJUY3VKMityazcvcm81cHY4OEdTQVgrRVloZUYzRTBrQ3l2YklFVk53OHho?=
 =?utf-8?B?dS9mengzaFZYRGFnQWN5dzM0amxVUjZ2RTRzeWpPazNOUm5kd2R4d2htM1p2?=
 =?utf-8?B?R3RIbnZ5TzlwMjZtVEZ2ZmVXcUd0NVY0ajRwU2ZpdnM1d2szbkR5UTkxZ3N6?=
 =?utf-8?B?TzNrb1lsditoS3hiRHRpYi9JSVZCTlRNaFR1QmRGVHhWY2FzN2o1aG5LdmQx?=
 =?utf-8?B?UXZDdWRqQkF4eGVjeHR1QTRWdTkxQWlWN29JSkJOQnYyeGFsTC95OUxnWXAw?=
 =?utf-8?B?djg4YjlLSkFqVHJnczlXaUF3ekk3TGNROWxybko0bVk5NSsxcFZralhkcCtx?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f158f127-ab72-4220-9ef4-08dda004e4c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2025 05:35:03.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: seq1QlaxJUJpGoehHljbdRHe/GnBfTJCx+QT923AL7bek1hL6xOeYMu2hCrdimGhZncRCTvxZvDHkb1iUzuR1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8183

On 31.05.25 07:16, Eigen Zhu wrote:
> Hi support team,
> 
> We encountered a problem relating to the handling of kernel FPU. The

While technically possible (see switchtest driver), this is officially
unsupported for RTDM tasks. FPU work belongs into userspace, not a
kernel driver.

In general, you should avoid such extensive kernel threading. It's
typical a sign for trying to implement an in-kernel application - rather
than a proper split between I/O kernel driver and RT userspace
application(s).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

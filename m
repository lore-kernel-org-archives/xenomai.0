Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35C211A29
	for <xenomai@lists.linux.dev>; Fri, 10 Jan 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523906; cv=fail; b=ONPm7oiVoEyy55WVHs6B+yd/HYWa/KT61+UJOgzWiGy1bDhygmExB84pL3bm21myIn8nQJXIVm1n0IoOaAQ7u0Dg+You0xyikB/Wrk9vueHp4AjgsT11CQvXT5ygjixfN9rtJBJbPIcy6KievWOT/zys1X/fVWOXdf0L2XXV13o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523906; c=relaxed/simple;
	bh=pX71/Rvn8rCf2znGmv9UMajs4q3kFhZPrVXhr6GAiYY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cb/uNHlcidJB4xFghTBLddD/0eQZgZ30Pqso8hCRFo3IErd4shZAomkvuZaM5YH5SfTR5QuEjX4hkk7YwcY2ImefruRyR+BmtLI+vvT6hQ9Zekm/1xkV1hIZLp1qLAsJiK1tdFRJbmozMgyvXW6svcWfoCunoBSYT8LFH6octbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hFheyFLR; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hFheyFLR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr9ogCPJgRQLnaBxvwprNAnGYe8WjJtvdm8i7XMgvd0hyMiVt2kj4dFi/5SxRYQKbpqi/J1RhAymmA7qiK5wMz2AsO9c5UQHGpOufNjxsCgmCFFBKbsgmlwaZZV631Dih8WqWsuFF1wfWs9YmrJgqkMtgFEPy0FmewNnmXunMc8KQ2hyu9XhBLehwAeh3tXjNw1GJjfPF5hsC2g6xOs4CgWNqTlzpnvZr1XE4KAt0joz1Ut0kI+Gy1U5WOwEebxJ1CmyOItP32A6W4G3tW1qv8thMffVXag7sgDG1DSTZ3xKIDvM5tfrWe6DXLL3fI3f2T+UB0if8BOv7wTvUj74vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEWuCjCs4s/h+dD5DrO3HBfqjAiqOUYpzksrydlID94=;
 b=t9wesAW8WPV75dMb1vFeU2NjAVZXzIGef7NZk5mzRgmbAYCWLdANKzg8iMJbao73zCPcGaSJBCD1w61EFtyYa+bu+vtg/Jmgq107CmhGvLjbU+4p7azWRGGsBioD0TEcvqMxzJ87M/1MdczEyPH2aB8neTem4ENhcqxbVvl1TKU4uzfu82WHp4OBiBn1iFCfWHLkQL6YGwp4AKJntqXs8gSEHdLShfpgnixvJkjMsYCEdZHAMk84APZZIPE8r6Ob262tROzxbi5C/aL7mUbDGFIEpc+eIeFelyvTYYYeWYABNyj5O5cgem2oTpCf/C4P4OLP+vWPIRXoY2FmJ4uoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEWuCjCs4s/h+dD5DrO3HBfqjAiqOUYpzksrydlID94=;
 b=hFheyFLR7Xgh6oiFbzrbt342KOqJxNXljqr88h6oOQeznW0OEV0iFaODHwH6HglemN+aUIPw2zQyELQVgKDcfNsRc7v1bk95PULMrdxisbJBkQ5A9aJT2YKosjx2iqyXffUReFTUifDwV4mppeMrU9/sSuBQUEHKnrofCDJpIpO2cDblrvFdeyala/G7NIPiZwlUOyskKP1iqGn+nnzbN4ZFdm/w17wuNBDekiu4J+cbj1CgjK/hzAZI29YgFOVoxekjRdscTKbatRJDXqo8+zMLxjtT0RznMTlE5rEJolZ8Woc0doE4EqyNLcmoXFatbgrWB0ndXiFMg0Gw+YR2Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB5776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:323::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Fri, 10 Jan
 2025 15:45:00 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8356.003; Fri, 10 Jan 2025
 15:44:59 +0000
Message-ID: <d6d9ae3f-d8cf-4eb9-9b1b-794970c78939@siemens.com>
Date: Fri, 10 Jan 2025 16:44:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Paolo Mantegazza is gone
To: Philippe Gerum <philippe.gerum@gmail.com>, xenomai@lists.linux.dev
References: <87ikqnuiqb.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87ikqnuiqb.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0069.eurprd03.prod.outlook.com (2603:10a6:208::46)
 To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: f09f6ec2-1d3e-4741-b487-08dd318dbd7b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk1tSW92NFhKc0ZlNlNUNjFqNWN4SWI4bm1DVnpFa3ZzclVIYXd6S2hTem15?=
 =?utf-8?B?dTVTZ0NFb3Nnb1pmdTZ0dUZ2K1Z3ZW5mUUdKbExhb0RsMFpFa2grcjNmQnlh?=
 =?utf-8?B?Wk5COVZsOW1MaHRzTVhNTXpFUEJTSjV6T0VPR1ltMEFYN2NiTDdvVm83d0V3?=
 =?utf-8?B?N0J2cVNTcXR5MGVaZkthUE5ndUluYWQ5c1l5Y2NzQVR3ZmNuTURvQkNJTHUz?=
 =?utf-8?B?WjgwV2RlL1ZqYzFCdGRoUWhrTSs1b1ZmL0VyWThwYlNLNE92dzFFMElSeTJq?=
 =?utf-8?B?Mjg5S0xIeW9YWUFoYlFWWkw2NWxjQVptVGg1OUY1YkNxMjdMVlBMem9RQVNZ?=
 =?utf-8?B?QkhRMW5GSEdOM05jS0N1TW8yUFhMcHRwNjlQcDMzTnRhekJobEwrTGNRaTM4?=
 =?utf-8?B?TGF6R29MZElsbGJiV2lpZlRkZjRqTGpIbWMreXpHc0VQRkRPdlNoSXpRYVd0?=
 =?utf-8?B?RHJKMnVWaWFxQkt4TWsxUXhiY2FRRUg1R3JrTnFFdTl4aVFaOFluYXJpbDFV?=
 =?utf-8?B?aTRDUjRwQTFiQ01BVlRlbXZ4aTBoUEJ2b0FKWjQ0QTBURElaajhqZGxHcUky?=
 =?utf-8?B?dDdXK2pERXhVa3BJd1BkYnIwOVFwcjRBci9sOU1tRE1LNzcwb0JxQi9XbUNa?=
 =?utf-8?B?SkxIb1hCQjBub2xGcTE1Zisxb3grcjZtcWhvQm14dmt3ODZWaW52V3orbHVJ?=
 =?utf-8?B?SE1XdEI3Y1V5YjZxQ1FYbWRHdDdmQkczMFJZckNzcGNSbU8xdTYxeWpQNmJk?=
 =?utf-8?B?Vnh3U0ZWY2k4a0VMYXAyYjMvb29UYjlqb1VBYkVsVS9tTUdmaTB0cnFIdFpo?=
 =?utf-8?B?ZFMrSUlKMjY1ckxSdUtWWTV5QkhBRWducSt2KzU4QUdZbWRxL1JuWnhyelRy?=
 =?utf-8?B?NzdiNFdnd3diNUw5OHNCaFJEY1lPQ3VLeExOYWs4S0g3WlQ4THdQQmVDK2Zs?=
 =?utf-8?B?d1NzdnFpSkozNmJNU2VOeGdrQzBKVkdQTWIyUDZuczkwMkJ4NDBkQmo2am5W?=
 =?utf-8?B?R0xrd1BhckRGOGl1b28zSE9BL2VUZzRpRjYvSC9CWk9xd2pCTW5ZRGhXYWRS?=
 =?utf-8?B?L1VldU9vUFczTUFBYmU3SmhJdjYyb0owcVJkNXN4Qy9UZTdqVThBNWhHdWlu?=
 =?utf-8?B?bVBOSVZzbjNLSmpicjZSdEd3a242dUVzanNibkRuNWhJSmhYQmFHOUozTmhu?=
 =?utf-8?B?cmpzNzRXSmlzN05acHBlY3pBMTBIRUFUL1VoNlIwbjJvR2dTREdOamhXZFdR?=
 =?utf-8?B?OElJZHUvd3F2UU5hcm5oSkZhVWpxZExkUjVxWHd2dU9Mb3dzQjBOZHJzUERL?=
 =?utf-8?B?cnRGcE9EZmN2NW15UHFIWS83YUI3bnd5TUo1N0RzMDR6dHNZS1VlelhRaGxG?=
 =?utf-8?B?cVpNWW8xM1QwTkgrQXI2eERoQ0FOMytjaDI5Q1d5ckhITVhpZ3lMeDZmV0Jp?=
 =?utf-8?B?azlaWTBFN2NTMWVLSW5aeGswbXVHYlBVWExFMEN0N1QrbW5oNGs4T2lpMTJL?=
 =?utf-8?B?V21SeE5jL1UxYUErZUVOSk8wL3E1RElSZXVWdU1wWlVJcXJGMzVhdE1oQjFC?=
 =?utf-8?B?ZTlKZ0grOWlHb2xCWjdGTWR3YnVZczZVVEhUak5SOW1RbW9uVW9wZEdpV3NU?=
 =?utf-8?B?ZEMxVEJCMjhKSmcxVUJ3UWk4ZU9BQk1Hd2VQOUNjQlQ5ZWM1UVFPQU5NSHlS?=
 =?utf-8?B?RmFGZHc2bmtNOVpRUGpWU01BcmpEQTl0aHNSVE9panNnKzZreDgyV3Jncmdy?=
 =?utf-8?B?aGpONUpudEcvb2toU2tSSUhLZnA5Q2NPYkFvNzY0MUE1ZmY2bzBkUDl4UTFv?=
 =?utf-8?B?VWdnUVNvMGZoYWpTNkIvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlNNM05BYzB2SVZVSGI1eHFZU1VvSlZQQlNPdEZFZXNpYTZ6YnlqazdON3Zt?=
 =?utf-8?B?RHc3UUNtdFV6UUNkSUhxN0tGRGJFaXBEY29qeFBmM0FLT04yVWVjQWc4c0Nx?=
 =?utf-8?B?U3NyRU9qbk00NWEwUitnVktqWktVOTlzNGljZGwvTFMrYldUb05vaDgwVUNO?=
 =?utf-8?B?dHFpTkt0TUk5cHBieGlncTZMVUd1Qi82ZThCa1B6R1hsN2Q2cEt6MEZXOVdH?=
 =?utf-8?B?MUR2QVhMODV5OU9EOWJtUUVOamF4QURpaHFqNysyUllQd2VnS2hkeWVZcjJE?=
 =?utf-8?B?YTBRemdlcm5qdmdTdURscWhZNXl0QlJoNlBpR214QWlIOXRFdWErd3o5YjNv?=
 =?utf-8?B?L3ZHSXR3Qm1ERmxpSlIycjg4N2R2LzMyd0VpYU1odElvY1VaNGJHc2dVUXhk?=
 =?utf-8?B?Y0drTzhFdFVINWhwbmkwVm5VS3dhdU1qZEc2b2s3Z0thSGZaWUF6WjdKMUho?=
 =?utf-8?B?ZTV2RENUQzVJWXU4UmVaWTYwbXZoMmlNMG5YaHl1bTY4aW9JTjQzTHlqS2Jr?=
 =?utf-8?B?Tk9YSkNWb2FYd01Ed3ZJdjZWY2VyZU5Dcm5ZMXV1c0lXV2pBVUZUU0tRakJT?=
 =?utf-8?B?QWpkNk5zVTk3eElPL1FqK05kd0NuZi9Sc2h2MjB1TUVCSTVvN0N4ajNrMzFX?=
 =?utf-8?B?R2dsMFVyNm03U3AwdjZUNkd1MFZpVitGTEhCY3cyTkJnL2hTdFNObUx5aS8v?=
 =?utf-8?B?eTJnWUVsdjNuTXUxblQ0RTJjS3paYXZXMEFBVWhHdGFqMU9GbFNnTUFhTUtM?=
 =?utf-8?B?Q3oyNW1zNDhaUk8xZ0ZBOWxEcHJkeWFlVWJieVIzYzRESndoTlF4d1d1WFRM?=
 =?utf-8?B?ZWVDeVFaVWthZ3dRcHFwTVNGdkJuVnVtTmQ5U3V1K2NENTQ0UVJrZE9BQ2FI?=
 =?utf-8?B?UnQvRDBpWjJ3WUNpaVZQcWl3bFBpUVBxcnRWTEtyR3R4em0yRFE1dmtEZENh?=
 =?utf-8?B?cVQ1b3pBNnpkelpvS0Z2T2xEL25JcE0vOW9scXd1YThyYm1VMFRlK2FYaEZZ?=
 =?utf-8?B?Vnl0Z2loVUc0TnZIekVEcS9GRXVRWDJDR1JBdEhSM2JLNTA3cHByT09Rdm1R?=
 =?utf-8?B?MWdFd2RpT1N1UGRKZXBZZVF5SUxqTG16d01wWVkxc3VMTG9mSGprcTVtaDZL?=
 =?utf-8?B?bk9CdTlzQXArSWJweXkzRGJwRWlxTzV3aVh6aTdGUzMyOUx2NkZaYUdGbDlw?=
 =?utf-8?B?Y3NzeDZlYWo1U3VaT0tOMEk4QjVPcDJsaTJYeUJjbFNoTzZic0UrVUltSjdy?=
 =?utf-8?B?aTg4bGpnTHRRYjBQWkZTRUZMZFdHRzVXL3NBSUQ1ak9BNEt5alAvY3dKcVU1?=
 =?utf-8?B?Uk5INE4xY2RwcHJvRTFRSVQ2ejQ1eVVieVFEU2hRaWR1ZFNyTWMvWnpXYTNs?=
 =?utf-8?B?UUZOV21KOXdNS3NsWHJvSFRvYWY0U3Nsc2dJeXc2ckx2ekp2MWp3akdQakpL?=
 =?utf-8?B?akREVklxSDE0KzNiTEZyMEp2OWpWRVVaQUJ1MDBHa1Z0NEdFUW9Na2k3RjVW?=
 =?utf-8?B?dUtMLzZMeG5jTmVvUVJxcTJBMURnVTFNKzRjQWxSQ21pbm44dklNbHZuR1F6?=
 =?utf-8?B?MzMyV3NIUnV2OXRJNmJMR1FXRmlFaXBWUVFxT0hLSFhITzFzV20wb3l1RUtO?=
 =?utf-8?B?UjJ3MTJMUXJKZWw5c041RUk4VDZHSDYwcm41Mk1oaVdNTHFrQkFPKzVmRXVH?=
 =?utf-8?B?R3VFbHkrc0VTWVVuTzFrMmFFeXcvYTdJeXZBWlVubEFUWjlJNUJreHdxM3NC?=
 =?utf-8?B?VlFTUklGT20zV3FqckExbU45WWNsWGxvYUdtRHpQdXhrMHhWWUJJWm5NZlVP?=
 =?utf-8?B?NGpIR3pLNHI4MUJRcEdsL2dIb3RjcUwySnUxd3RoTDBGTGFDeTdBdU5oc09a?=
 =?utf-8?B?MVFFYVZnNXV4Rk8xUWtRMUdoR3dIK2dMbXBnZXdnV1g2TURFa05xQkdJMzFl?=
 =?utf-8?B?b0RkYXI4bnpZUUtuWW0vcXhuRnMxN1VGek1GTFR6SG9PWENTRXFJR01RLzZi?=
 =?utf-8?B?SklxUlFvUG1mamQ3Wkk0Z1RndkVwUUlMMktIRGRwNWpQTkdpQUFHeTl1MlJ3?=
 =?utf-8?B?T1pFWjNRTHFhRXB1bVAvUENkZlpSTlExcVVQenY2d214NTBORExPMEZoeDZV?=
 =?utf-8?B?eG94TWFvOHRVM1VnZXNmQkFlNHlUVGRuUi9QNXdudGFSNUlxSE1JWkRySmNr?=
 =?utf-8?B?RHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09f6ec2-1d3e-4741-b487-08dd318dbd7b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 15:44:59.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dyh1nfS8Uc0X0ohcudxHiUUdQUXhRHe3boCkMLuDXVb7p+FBkMHS5Vql+sP8CboOh9ZoJNYi8ewLZiiR/kA99w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5776

On 10.01.25 10:21, Philippe Gerum wrote:
> 
> A month ago, Prof. Paolo Mantegazza, the founder of the RTAI project
> passed away [1].
> 
> Paolo and I met for the first time in 2002. Back then, together we
> went through a period of intense creativity, standing side by side in
> the battle for a patent-free real-time Linux.  Though our paths as
> contributors have taken different directions, we have always known
> that our friendship would endure.
> 
> We got into the habit of sending each other pings of life, where
> Italian and French jokes punctuated our conversations. Last December,
> it was my turn to put on a smile in his mailbox. But Paolo didn't
> answer me. He left before, on tiptoe, mischievous as he often was in
> our discussions. This time I have to admit that you didn't make me
> laugh, my friend.
> 
> Paolo used to describe himself as a simple practitioner of software
> development, one of whose missions was to contribute a free real-time
> system his students could use, study and improve for their research
> work at the university, welcoming others to join. Many Linux users and
> businesses owe him a lot, because under his leadership, the RTAI
> project has always defended the freedom of developers to implement
> real-time systems, particularly at times when it was threatened. His
> fierce will for RTAI served the Xenomai project, as well as others.
> 
> Paolo was a brilliant mind driven by a great sense of humor, his
> culture was vast, and his friendship was unwavering when he granted it
> to you. He was often in a hurry like anyone with many ideas but no
> time, always plain-speaking. One of those generous individuals who
> embodied humility and that will leave us with an everlasting sense of
> loss.
> 
> 
> Ciao, Paolo.
> 
> 
> [1] https://www.freelists.org/post/rtai/In-Memoriam-Prof-Paolo-Mantegazza,5
> 

Thanks for sharing this.

Indeed a great loss. I only had the change to met him once in person,
2004 at his institute in Milano. He had kindly invited me as young OSS
enthusiast to join the RTAI workshop there. His energy was amazing, and
I'm sure it inspired and influenced me a lot in contributing to and
creating free software projects.

Rest in peace, Paolo.


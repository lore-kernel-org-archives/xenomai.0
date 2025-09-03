Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996182BD030
	for <xenomai@lists.linux.dev>; Wed,  3 Sep 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915934; cv=fail; b=FUgulygJHn4MwyEDVP8ddPSw+TTlkMydskbP8V5+SeyBmg/37SNz6AvKxTE0mhx5VBmbIAfIj2poWjGujdW5jMBKlJsVIbr/94lyeIm/m4VKS7BjypL0fLAi0LXvQd4idPwoiDbcSWIjLnrYjEQF1y5wv31wGSTZSeolX9O3R3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915934; c=relaxed/simple;
	bh=sjmEp1uuyvU2U6l3BXDxmANKWmXQ1VvZZ0bjWtkydyY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F5Xar7u9dYo29F0dRhC3A1ygEd3lqkKWM1mHRFU8bCUPJS5Dl1svTHYM4ls3UzQPd9s30oOZqeCQaBllZzZsJQWx0AGAZnZapnW0ENtXIEcTsMLVllc5Iy+0mqK+dsZa9+R2r3djL4g8Eq1WQJXYVVTy6KxhmLbUCUr8jSYNNXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=PoLSjWzt; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="PoLSjWzt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQNK8Oa7iOapTevjisEyWEBCpszM+0K6tRP1dlB05K6VYIdlOKlxq7Ef691M0XIYmhcfLG8+S7RTKLfzVGpFQzreuofAkBM2SH1+n8L0Dp9YSPWpsbBJtISMJqQqDSMsB/K4VV8AiMBcSNTpqnhgGIFB0okjfG17zxVyEcWQanLJE1mmmMHdc3ph0FHZ8gqga1sI1ZO5UsOTmxaSdhf3ojKTPiFSEzgK7+Jijgs3jAMEthNb4mjbU37MO7ZZ8jyY+Q0f0yqd63zjFdoSW7BP5qZln7Ino6Crfx4mDSzNpn/isWJYIE6vXpBBOQBTtVP030if0eWQ8jQyCOMS02YeKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH/Jbf3edjkJRr241Y0JOeV4syduyRnn2zRSjS3Pfd8=;
 b=mPPMkMVZD3Z1rxYVXOD319w49IDhoF3PR+srnv+tLO0Ey7eHT8xpHP9lJmOTKO+mXVkNvSR6mTFZjl0uURv0mPcdQi7rGKOoHEekH9GbMwrPtYTw1RHcu3fVeVbRW7lPKlpBC+11QUydryaLFl+MmWG3XOlt4uRx51BVWGjYTcYAIytJrTjsbgCmrxw/U4C4RDTu0ClyMcf3vv9aLMAmhq3WweJmursIjPRYBzX9LJ6Z6X/2H1eRTNstKePUZ5grOKwHZsD2JEs5GfvcuykJndinvY3Ttotg61xIJMQarY/mRXoiGHLgxN+X/0SDI2xrUNdgQQnPzWjXncYt6QLibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH/Jbf3edjkJRr241Y0JOeV4syduyRnn2zRSjS3Pfd8=;
 b=PoLSjWzt7V0aRFuWS9jWZIS/hNmXzkKF5dWMp5rkA8zt9NJt9mhJJdfBYcqColkz5Nv6K1oo11reC1KuWUrsyZBw0SlfzNXwfLKdnYE9EE68dwbrm+gh9ReXDEgubzYkFDDs/XAL0PKKbyI1rBMu28PdxY6G0PCX8nXGfrPCDQpqYZzs+tin/fQVAUqdpF697LiTUWy3rq88npmPe/VTOASUz4aE+kU2y9Vyx57X+rpUxNo2RK5UonXkDv4tf9DggbdBFUfO0dZ/KzgkSVF+aNRJgFuUGJAZsVu9ph5o84gXQ5qJBggsA5sHHnoNEbwS7+G1PK4skw80MWqI2VXPwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAVPR10MB7307.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 16:12:10 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 16:12:09 +0000
Message-ID: <c99efcee-2479-4e3e-b29d-e3769e9e1117@siemens.com>
Date: Wed, 3 Sep 2025 18:12:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 1/2] ci: check the device health
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, xenomai@lists.linux.dev
References: <20250903122513.1072751-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250903122513.1072751-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0432.namprd03.prod.outlook.com
 (2603:10b6:610:10e::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAVPR10MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: ba492e7e-98cd-4888-72b3-08ddeb04a24b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEhpNzRoUFJsQ3FpY0Vld2l3NlU1N1lRa212UnpHSVBPL3hFK05PZmtRbzZw?=
 =?utf-8?B?cVpWMStkbEFqZ25rM3VWcWZwQk16Nlg3S1hkakFJRHRXWU9kRUdWTHRacW1K?=
 =?utf-8?B?c05wR1RRWTYvLzQxWTk1ZmIyMVdWd0thejRyNi9mTDNCZHFQQXNlaC9RRlJI?=
 =?utf-8?B?TDU5eVE4bW9DdE4xKzJWc3BvbVhkaGdWSTZpUjVtcG9McjZjMjBqWFdCZ09Q?=
 =?utf-8?B?cExUY0QwdjFETWpMQVZoY09qa250SGR1dzhrcS9pUmJLc2Y3c2tKdzMwMmtO?=
 =?utf-8?B?YzRENk1BS29oZ25lVXNxWmFudHJ2M2FOS3FvSVNJSjVaR2UzWmZBdnV0Y1Uv?=
 =?utf-8?B?VnNON2ZYZUNNQ0g5ZFpHUE1nNWJzZ0NQM216cHF5a0llZlc5YlpYOUx1b3NP?=
 =?utf-8?B?eHRKRldoTVN5ZzhOeEtmSjBld3lmTzNLTk9uRXIyT3U2OEI2WVIxRkE3Z2ZG?=
 =?utf-8?B?dEF1eDVuWTRncDhuMDMxRXkzdkxBNVBjeDlmMVVlOVZSbVlLK0tQbW1vYXRB?=
 =?utf-8?B?b3BpT3ZreEdzYm9hazB5ZEYyZ2lDalFMY2tVaDFMWFozZWNEdTlPWXNrL21q?=
 =?utf-8?B?d05lMlptV3BQUER3bEgySFV1K01wc0ZNK0dUK3FmTGVpd2xub09MS2QwdVQw?=
 =?utf-8?B?R0pISVg0NUZ1cEx2dUo2cUovd1dqWDFmUXZOenZWVmwrN25rNTQzTlRRMDly?=
 =?utf-8?B?Vk8yV0Y0YWlPNFdSc1poOVBhTVRrK2VocU52VlVNVDk2UVpic2F2SnBoOGVy?=
 =?utf-8?B?VDBRLy9hUzVISTJxS0VFNFVjaUEvbmJnZlNGcWovSS9wNEpleHRvNGlCTGJO?=
 =?utf-8?B?TDgxMm1WdnRiMHk1MnEvMDBZYWVIZk80SkNSVUYvSkg0S3J0ZHZ3VEpjM3Vo?=
 =?utf-8?B?UWtId09IRFp2VGszU0I2aHhISzBGL2VpZHl6VmJpNEx4ZkhVUC9BSjFqekk2?=
 =?utf-8?B?Qjl1ZmxmMTJVcEN4NzlTTFhKeDNXR1p6MDBJbW9sVzFUcG9XOEQxdnovLzU0?=
 =?utf-8?B?V215cmIzUkFwYlZZNXc5UTM1TytCelVwUGV3QzdFL2xTNW9LdWQ3MU1OQWNM?=
 =?utf-8?B?b0ZWYnhlS1ljZjFWd0xhT1B2VGsydVE4Qmt3QWQ5eGJka1RwZngzMnRyN0Ix?=
 =?utf-8?B?QzBHbWVadnhnaThjb1R0WFB6RDVIRTZYRlVFVEo2TFBVbklsY3A4eUVUQkVv?=
 =?utf-8?B?S1lTZGd2aG0xdWl2cTgzZlBTdldCOGxtcW9KVFVwYitPWmdINVh4WWp0MWtQ?=
 =?utf-8?B?YnQ4bFRnZ3R6QklITnJNOWRnclBkTldidWN3WkNlRzhrOHdrQzV5ZVdvcjRC?=
 =?utf-8?B?QlNsZ0J6WW4xdUVRUVRQT3JYNDRMbkVVQjlsalQ4cVEwNEpQcmh4MnFaeHBo?=
 =?utf-8?B?L1ViOGUzUm04V2xlR0tTYXV0Q1krYlJYV2ZTclNOQTJ1OEE2cWJtUWxHZVYz?=
 =?utf-8?B?cEhtbVpJTVk1eWp4MGFmZmdrTjdCSzJEZVdrUFJCQnJVeWpETnd5bDNVaFZB?=
 =?utf-8?B?d0ZrNEw2K0VWdHlHbzRPS2ZEdUZMa29TY3VDcndMVXlVZlVXVnFmYzNTMnFG?=
 =?utf-8?B?eloyTHNPTFJmNU8zVnZwUWMyKzZKalpDOXFVb0VVUVdDcnpBUWlyc0VTd0lY?=
 =?utf-8?B?bnY0NE1KbEZFaVVUanoydzUyRHRrWmkyNnNlN002TmtXdWRLZ1VjZE12bkpP?=
 =?utf-8?B?RjYra0NLLytYRHRzaERTY3ZncGplVE53cklmNzdEYzY3ZkhCV1lkNWxJV3h3?=
 =?utf-8?B?NUVMN3Aya1hWbWRNSHFyb3haWkhkdlVRUGRoN09tMlROQzFYeSttaWFaQ1p4?=
 =?utf-8?Q?QepsZ8p13G2ROmthzg/qmZ+MG8JZZGtL5AzHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlRWN2YzSzVWMEYzVjd1aVVhRlJhMjdEc3YvbDJLditKUngvc20reEhYVVpp?=
 =?utf-8?B?L1NOaGIrUDBjMDdJcllDaWVCWDQ5eXpnbHlLZXJxOHVGK0tNeWtzWE92VTcz?=
 =?utf-8?B?Ykx6a21kVkFMRkV5YWZ5WHdJcGlyYWkwbzZ3eGV1V2xiWXlSa2pHYlF6b0Fw?=
 =?utf-8?B?QlYrY0ZwSHpKVnpWcU5iMGgxUkw1c1dnQnl1VS84Mk5ESCtSNGMyaStaTW8z?=
 =?utf-8?B?b3JzWVI2OHc4dDJManU5RmIwbjAxZ08rZ1BJZTZ1UTJBbVhodVpxbm5zakNN?=
 =?utf-8?B?MHlhc2EyaXRrSWpyY1h5V2xnWUo3ZTZ6RHBPaTA1Qm9USE1GdnZSZGdFa01Z?=
 =?utf-8?B?WXRtQjc0SlJaL0RhdlYzZHE4eUlYNWpFaWF6UVRnS3FYL3dDTFMwZnNod1p1?=
 =?utf-8?B?TkpRenN4ZGNZaXU2WVJ0dWZ5NmN6dHlLSVFTK1NqdEZxSHBVUko4SmlJMlE2?=
 =?utf-8?B?ME10YklBQzBpdGVQTjc3eTVFNVRnSFYveS9hL29sSlVyQ0lTWG9uNWJJZnlK?=
 =?utf-8?B?ZE80ZktwS3k5V0pSM3BnTEd5WitOaG1YVHI0UTByYlY1QlovemNrY1pMb3Bz?=
 =?utf-8?B?NGlmdXliT242YmovRnAwNzkwQnlZNjhaQkd1aFJvczVFWDYydWJLbVl2RWlp?=
 =?utf-8?B?a3B1KzU5ekJXdUtxNCtOQ0VCaVpFem5IK2dBcFVGNkRjMUtnbkZraVBuWDlP?=
 =?utf-8?B?SHpIKzFTMjFodWY4dTJwWDhCNjdtVG9NeWpJV3BRR1J1N2RueTVJYWhsVHRh?=
 =?utf-8?B?TkNNNHpGVjlSbEdtNldidkRrWVNsaGhmcVp0bnhQN2RRaU9PZTBlRThoZ1VG?=
 =?utf-8?B?YWhRYjFDN2tEbzVJbldjS2VhcTBUVitJaC9sS0ptN1lRUStmbFRZa2IrbkJR?=
 =?utf-8?B?OEVidFlRdHZ0UWJ3c05LWGJ3QW9qT280RG53L01XSkQwMlpDUXFqU2dkc05r?=
 =?utf-8?B?R0k0cnFlc0hia21FcFg5blhsTi9oS0xZbENHM2lSUjRhSHBSRUtFbTlUWW84?=
 =?utf-8?B?Wk4wWFFjVWZmYlkyWlUzb3BoYVhjNmxjaThLNGFwOXozL1Y3UEFoYWZTMlV6?=
 =?utf-8?B?YnNsVk1kUnVPWDdKQVhJckhXclBkeXhjZUtLUGFpQWx3WkdwOTJmYlQ1dU9K?=
 =?utf-8?B?d1VUWHpZSFFBaUxSb1BLYmM2MWFrclR5OHBqZ0Y0ajIwTEFnRkhaUG81cnNR?=
 =?utf-8?B?UGpiNm1QcXJYaEEyOWlIMnZhMWgwa1ZxYU95cnIzV1M4aEFVUERsRkorS1VW?=
 =?utf-8?B?U0VuaWVCWnZCc2wwRUEzN1E2aG1xODU2cVdUaHFYMW5wMTU0bkN2NGNsZGNT?=
 =?utf-8?B?c0dQaTFOWExlTi9jMjZDcnFvdjUrdFQ3L1M4bVBHb3hrY205R0V1cU9vU3hn?=
 =?utf-8?B?Z2tYb3BsQjk5N2FacDYzaDZQbmpyZEtveUw3UlQwMTJiNzIzNllrT3IwdjFU?=
 =?utf-8?B?WFBzdytvOVNVL0RrcEFlSzlaSkdzN1NtQVJ4ei9kRlBmMFhRazdRNko1enJK?=
 =?utf-8?B?TElXd0FRNU1IU3lDSmJXRlRMNXZ6d3p1Ty9JVFlkQ09Nby9TY0UwRWdFUC9N?=
 =?utf-8?B?STlvaFU4TG84eE9EV2FKalNaM0tCVEx4eE1VTXNmYy9nM0N1THUwUVJpZHI5?=
 =?utf-8?B?UmwxMEgvaEpQQTdjUUZkQU5XNkdOTTlYMFdWakgxM0oyZ2IvNC85OGhqOFZn?=
 =?utf-8?B?a0VMU2RDVGlqME1QUTRRaTdVbjQwa2NPeG4vcjVCSFdOSWd5TU5HK01sejg3?=
 =?utf-8?B?RnZySFZDYXBTWmd1TjdEeUw4dk80cFl2S1V4clFMZVVKdnVxRGRIeXg1Z2Nn?=
 =?utf-8?B?dVpRYUo2TFp1WkF0NzR5ZEUzNUQ5WE1PSUFuS0tBTTBsZnoxVHNoNVVrUHds?=
 =?utf-8?B?c1ZxVjhSTkNMQVdtb04vNnB2MG9pR3p3bkE0OWhkeEs2Q3FGVDhjeXlaTHlJ?=
 =?utf-8?B?WlhacldHd1dPTU4rb1J0enBGa3B5UXdBblQyNWhnNExtU21zMWppSllBSko3?=
 =?utf-8?B?ZG9FdjFSSjRmTmFhQkhWYXhlbXpTU3lmRHpmRU11OSt0c3FybU1meW80bEhw?=
 =?utf-8?B?MVYrYlp6cEFQdkNRT1NaTVNEWUYrNnpzR0d6dTc1WlIvbHpiUWt6NFlndkR3?=
 =?utf-8?B?TmdVc285MzdybWdsWFVIQzlYOG0vcldwTGZrVVpxbDFLTFloMWJTREdSVkZ2?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba492e7e-98cd-4888-72b3-08ddeb04a24b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:12:09.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ws5pjCDs6xfSLkB9CngtbkZHFrPdRtEJW/IQW1wHu5c1xEx/OOZw4ASVf6NtQmYeah4oAx/6meJiR4l5mzu52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7307

On 03.09.25 14:24, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Check the device health and the device state. If the device is not
> healthy or the state is not idle try for "WAIT_FOR_DEVICE_TIMEOUT"
> minutes until aborting the test.
> 
> The default of the variable WAIT_FOR_DEVICE_TIMEOUT is 10.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/run-lava-tests.sh | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
> index 0971385..e97dd2a 100755
> --- a/scripts/run-lava-tests.sh
> +++ b/scripts/run-lava-tests.sh
> @@ -24,6 +24,23 @@ get_first_xml_attr_value()
>  	grep -m 1 -o "${tag}=\".*\"" ${file} | cut -d\" -f2
>  }
>  
> +get_device_state()
> +{
> +	device_type=$(grep -oP 'device_type: \K.*' "$1")
> +	devices=$(lavacli device-types show "$device_type" --json | jq .devices[] --raw-output)
> +	for device in $devices; do
> +		device_json=$(lavacli devices show "$device" --json)
> +		state="$(echo "$device_json" | jq -c 'select(.health == "Good" or .health == "Unknown") .state' --raw-output)"
> +		if [ "$state" = "Idle" ]; then
> +			break

Why not return 0 from here?

> +		fi
> +	done

Then you could simply return 1 from here and drop the rest.

> +	if [ "$state" != "Idle" ]; then
> +		return 1
> +	fi
> +	return 0
> +}
> +
>  # S3 artifacts
>  artifact_url="${LAVA_ARTIFACTS_URL:-https://d1a54g2tyy2hl.cloudfront.net/artifacts}"
>  # public master
> @@ -42,12 +59,27 @@ TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + ADDITIONAL_TEST_TIMEOUT_MINU
>  export TEST_TIMEOUT_MINUTES
>  
>  echo "Deploy artifacts from '${artifact_url}'"
> +test_definition="tests/jobs/xenomai-${TARGET}.yml"
>  
>  tmp_dir=$(mktemp -d)
>  template="${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml"
>  
> -cat "tests/jobs/xenomai-${TARGET}.yml" | envsubst > "$template"
> -
> +cat "$test_definition" | envsubst > "$template"
> +
> +echo "check for device"
> +time_elapsed=0
> +while true; do
> +	if get_device_state "$test_definition" ;then

..."; then

> +		break
> +	fi
> +	time_elapsed="$((time_elapsed+1))"
> +	if [ "$time_elapsed" -gt "${WAIT_FOR_DEVICE_TIMEOUT:-10}" ]; then

Will this variable automatically be a CI variable as well then? Should
we document that? Or what is the envisioned usage?

> +		echo "An test device for '$TARGET' is not available"
> +		exit 1
> +	fi
> +	echo "Wait for test device '$TARGET'"
> +	sleep 60
> +done
>  echo "Submit lava job"
>  
>  test_id=$(lavacli jobs submit "${template}")

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2058.outbound.protection.outlook.com [40.107.241.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50A7D098
	for <xenomai@lists.linux.dev>; Thu, 22 May 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918523; cv=fail; b=cFaBM6KA3ui2KGHrJVhhkNKhQKu7AzP+xcA0ypM/bKV6zBDiuEdO7ntvzVRHZwlBqlYj3sfZyR68OEBi+jy1+nRKOH+5lCIs0ptTKnFwSj+T4xPvIjP2A/fgkPMEYuTMVh+Ar0NWO+jZLYR6gsRBaMTi1ROt7O/fonAZj8rkqac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918523; c=relaxed/simple;
	bh=GxkxzKOhXQdf6xdNBFnxkqYFi3aX3i24c5eJCZ4yT6I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mfnVtr4AOWQ5DkYwSuJb75VCoaQLe9RxVBOW7dBUQ8RXkZEmoXUgM9pqih3VklpibRyeOz8d3+m/sXRl5eISz+pNraXTeI2lrAUcgUH8cN/BprdGvbkIWAKJHaSJdMjsJ8ZuzgD9xc3lQEt+mJgU2GOrOpGub946G6vSuriQL+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=u65exYj0; arc=fail smtp.client-ip=40.107.241.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="u65exYj0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoEDj6OTciwRCKvgVBGzym5Q+1uRbVFNqfBn4VePsvx4b/jbCrcfFKnLNHiahWHHf0H1E7+jvFj0OSd4q3dm9qzi5keHM+cwTtl6De3v0F3TRgMIvvL9azE/141NLVEifHzDDPYIq1i6wYPUdmzOewqOJUWK7bfeU+p5gUUukETUaq7H15Lg7jdnXuRGRcv0z/0qvW0ONCyKyS6p/Tjs0rDfLfhCxLv8VVOBR1jvYQDgF7nIYR71k8SARPQdBQCtqK1bPOmhVvYgg8JjZc+8HP8PgCco554nItvbFIbbknpZvW100iwqqAK8KyaG6oBntUz55a9Mob38gRNZ5edVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xH2lsQai0C++Fm3n5wsRvZIsVKGDua5iIhCjamjGHlg=;
 b=NT+ZB1HmdPsp4FvA8GvkbZJyAWER+sI5uqVlV3KvtTDdOLf6/UHiOnmi2GpI2U1FXC+huJR1nmxzf0krtOdiA/UPWGT/iEWS+c8YXBT5JyAUolKxs1JQgweDpEW8V/yBfGrE+HBCAIpEVmqWfzV6IB+dordW4R85COBhsEBMf0Zi+rP6mY3dKcb8ZC8pW50J8bWAiDfarrLAdacnINBGB3Er0YW4MedkkU5W1HSDIH+0rkREl7GdgmKbml5tiHJIdE8b2qKFyWB1i3qpSeNaJypWVDH4nMMufQmG8n1NFR7JlUqtUd+FPf4IKWCBkIgdTKhcI6IVgxsIq8j8LUwXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xH2lsQai0C++Fm3n5wsRvZIsVKGDua5iIhCjamjGHlg=;
 b=u65exYj0D5BTOWYSFaYs0u52yOyeXoVXobEAf+ANnE5PsYiRwWUW/MibDFPDO/hkTBQZ/MC6knwO0UdAtgnMDf+075owWruODxhilfYGbZ2zMScdNA6t33AuNHPyKKwxC9M0N7Z/5DiQEmwXg+Dsta0Vsp2NbHrWgkHlNOVWjq4Jgiq4bXAYz1udV9r+Ac+OJLcSppJeBytFsdICGsZsyb/DCvqAdoSTLTVyYsmkZMlQe9NdObYqvsvLCgJ0q+lrZ6px1u0LNuiySHBG8jScwlOdqgMlQTVeOPANN++ekdwK+p0TucCPSz3eO1upvfMtFDS9dBBEXdRzZZPnHa0ExQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 22 May
 2025 12:55:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 12:55:18 +0000
Message-ID: <5fc76c7e-7512-4151-8bf9-43d20603895e@siemens.com>
Date: Thu, 22 May 2025 14:55:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: schedule_work() from primary domain
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvxhk27ps98JL0afZx1+iecouV2NFsDHv6Ccp=zpn-yESg@mail.gmail.com>
 <f011dc68-e0ba-4fee-b3e8-00d135f2e6b2@siemens.com>
 <CAFLxGvz9cpMCFCxbqAvSUsYuDJKbcnLBFX_XfR1QjpCxZMVw0Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvz9cpMCFCxbqAvSUsYuDJKbcnLBFX_XfR1QjpCxZMVw0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc4b2a1-ecb2-4fb9-1e1f-08dd992fe720
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWdHM3c0OWhUQktnRU1TOStJL01yZGovZVFPNGFSYW5ITTBHeGpYa2JUT3VC?=
 =?utf-8?B?QWxNR3huTXNrb2JYQ2VuYVJ2bXRpRTVTVjhpQ1lRcGpmcEprd0pXZS9tTTNz?=
 =?utf-8?B?aTRFYzhlVG00OFpGdkttZG41SzRwRkkxaDBZZlhpQ0gvVjhxUERuZUZIRlBr?=
 =?utf-8?B?WjFzYTIwWWFXdVFLeXdoVXB0ZDZrZmlCeWd6anE4dHRSYk03bGkwc25OV2Q2?=
 =?utf-8?B?VnMranNWMXpTT2Vua0dzeEcxZFhlSnVDNFFkdmtaY0loakcxcGRIendzQWpD?=
 =?utf-8?B?M3dzUlJENWpIdjJTYVQ3K3NpYTlmVXg2VEE0YVpLRWJsb3ZiNEQrelFWeXN0?=
 =?utf-8?B?OGdETHVtWFhtZ3lLdkYrakFXdmhsMjdlRVBPTzEyWUhXVEJqNTRJYzJDTzJN?=
 =?utf-8?B?YVBkdHlya0RZU3BxMHpEN1NadlFYM0ZwcDdNS3BCNVRNRklRY1dRM25EWUdZ?=
 =?utf-8?B?aUxkSEE3Y0NMcWhINzVYRW9oY2grSXg2UHM2RmpmNlpreEdKZkNpNXBaWnp6?=
 =?utf-8?B?MzJLSnBNNGdxaWZiNzBQZnVqSEYyaWsxNitBU2g4VlNRL21DWmZ2NWJPTXpE?=
 =?utf-8?B?WERyN1c4eUpUWHIwQnBBNW55SjZyVnk4MVFnRC9mVXk3eUtZUHBMWWNCQ2Zn?=
 =?utf-8?B?Q1J0Q2tNWlVydHhXSnNNWFQ0aWxmdFBYeCtueGpHTnhNR0JsZ2E1aENWRHB0?=
 =?utf-8?B?VG53N1BRbHdBNVV3cFczN29yZDlvUzJMY21zN2pEb3o0T1ZKTEpxaHc4KzBS?=
 =?utf-8?B?aWcxT2dCK0t6TitQSHRJUFBQaTBFK001ZTh5M1N1cmQvd2RGODgxYytTc2pZ?=
 =?utf-8?B?VjZJNGpHQ0gwdlhLbVN0TGZPWDRxR3I0eTV5ZmsrdDRVcm1BT2g3eUtnWTdC?=
 =?utf-8?B?eGd0RUQ1THc4VkhMSnRlT00vNDA2TnZRQkFIOWF2NlFmMWRCSnJHcmZRVGY0?=
 =?utf-8?B?bGw1M3NoczZ2ckxMRGx3R1ZpZU1ZVzZiL0V4cGtLMEtYdjNFcUNBTDcvRlJL?=
 =?utf-8?B?bHBHalZMMkdYUldqeXB5VDgzYk5tNUFtTFlqUmZYdEF5T0xzcm1pYVdnOEhS?=
 =?utf-8?B?V3ZhWUw5VUk2b2Z1NU5uZjhjS0VyVUwwUmhscU1sQTRnY0dkQ0hybFc2SGZ2?=
 =?utf-8?B?U0FWaWpBRzdSa1BzenVaRkNrYW5xUmlONDhCa0RQdjNWMlFNWmNtdVlyQVQy?=
 =?utf-8?B?RW9aMUZrMVUrUDBHVDMwQ1dDcHRvd0FJUXB1OVdMZ2pYQ3d2UkFYVGN3T2hu?=
 =?utf-8?B?U0VjVEd3dXQ3YlJvUlFTSnNYUWpyMlB6cVhrL1BWWkFiTVpTTTZETEhvL0Jy?=
 =?utf-8?B?SVIwenJ3cE9jTE5rSHd1SkFFSnV2TkhnenJIUHpuUUdjK0VnZWQ4YTdFWXlV?=
 =?utf-8?B?UWRCYnNrMFdVRU1mV1g4L0dxVEwzZnJCSThRVHJhZjg5K1ltaVlacXM3U1JW?=
 =?utf-8?B?Vk5LaUJSTE16U3VNYzEwV1h4ZnJ6YzlkZDJWK05QVnZWUHBZVXlrc2dOSmk3?=
 =?utf-8?B?T0NsWEtCQ0tld21pQUJtb1AvR0VRSTExejdTUSs2MHpNMlBrVHRaak9BOHJu?=
 =?utf-8?B?S1JjTUVibElSQTZQRExpaHlCSGtZMjZKZFJTaCtMUS82bE5sclZ6RUR1THhK?=
 =?utf-8?B?TFNUSFAwaEJ5aHYvNmUyYlh2OHZseDgvWnJ1T2JGZjJZa1RvQjBGV0FZRFRD?=
 =?utf-8?B?YmF0RXBkbXp2dTZlUXJiajV5TjlROElQSVYxYTNGV1JWY3htSHMvYS9nVjFC?=
 =?utf-8?B?eU9CRXNub2F0ZUFYdmFFbUNZTS9IOTNwZE9GQzhOaWZrSjhFaXhFUHdKSkl4?=
 =?utf-8?B?U1N5Yy85SE1BTWhMMlFSTjluMnlPWWNJVmx4NnBMOGlISHdFVDJXZzNDaksr?=
 =?utf-8?B?TnZhUlZ6dmpyQzBXTVorYzZOOHdwOTIrcGZRdEplVVFkN3ZLQitSSktvMEVG?=
 =?utf-8?Q?izdpGiZHj5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rjh1cnZpaG5NWFNYVHB3QXU2eDk4MXVSUmJ2MnVpY0lsczk2TE82Z3h4dnhX?=
 =?utf-8?B?Z3Q4OUJnOEczcDRBSHF4UFJsMVlZZ05QcXZvcUFLVzVqTDRXVkk4SFBqQ0tj?=
 =?utf-8?B?ME1OQWdmUHhYd0RLRVhCYjlLazE0TlFsNVV2MGtTT1ZYTkFTU2xWaVRjanVj?=
 =?utf-8?B?cTM5UlZnMzN2enZSMFdUUFFvTWpDTkpNK3NFMkRuU1duMUJzeFNYeTlqWFRL?=
 =?utf-8?B?ZGVyNFpHanVaNzErNlU4bWJmUU13M0xLSHErV1FTYVdwK21Qb2JNUHV1dmJn?=
 =?utf-8?B?WU1zSEozc29WcGhuQW42R05XTk94QUdBN2lYdXR2US9yd2g1SkVyQm02TFBh?=
 =?utf-8?B?VUU4S3dJQTNJaWNVdTFtWUxlMWxJTEN1cjY1V21DdytGeXhUdmpsNHBQbnNQ?=
 =?utf-8?B?VnpteEk1c1BBT1prS21LYTJacU43a3l5em5odjJ6NlRFT2FhSnN2UitjMHFm?=
 =?utf-8?B?ZlJ3clFydlErdzVzOEdsRTM2QTdhbjkyZk5BMFpwM3pYSXE5QUhiZ1pDRzMw?=
 =?utf-8?B?ZXdlaHBzNXpBUVhCOHY3ZllNRHhLekt3Mmk1M1ZWM01wZG9BUGJTek1nZHVQ?=
 =?utf-8?B?ejRHTlZJY3YzdHJXRDRvUjdJUFB5TDlGMStrNWZDeHhjak5OVXplc2tORXJu?=
 =?utf-8?B?T0Z6alZOcjJUUitTVmQrbW1qUnpMRXdCampkQ0hiRDF5Y011NnptQjFXWHZB?=
 =?utf-8?B?dWFvQXVzYTZEbFpTUG15aUxLWE5ZL1l1bG9pZEhoMkRvbFMwUEhaYVpaQlMx?=
 =?utf-8?B?WHNsSmFOMTIvWTNtbVJtN0syUFhqQWlIcXpiVFlYbUMwM2tYNTVKazFQdk1Z?=
 =?utf-8?B?Q0NETkhndUcweUNlSHlpTEJxSVhGUHdQaGpDWERrZkpvanN4Q3drU3dkQjVp?=
 =?utf-8?B?SkwyWDZmNWpvZ1MzYW5VSmlySjdNVUdZWngreHJCbWFubUgveVYwcWRRd0Uw?=
 =?utf-8?B?Qng2QnpRVTYzZ1MrSE5FK3ZoKzV6RkNjZU1qWU9haXNUMGVTZldCcVBXcHB3?=
 =?utf-8?B?WXlwY2xRSUtmVUU5KzBQbThPcjdUbFo0MExrVjB5c25oeGJjVjBpbnUvUXR2?=
 =?utf-8?B?alo2Y0EzSFA2Zk53dU16OHlQSG53d0JWNG93b2VGLzRrckhOSlBQaEFFL1JV?=
 =?utf-8?B?MGZkeTBoc3hUSUZIcGU3aVNaaWpyeHhqdnBNdGtZMk4rTXZxdjdmU0F2N2xE?=
 =?utf-8?B?akxZWURCckNCR3kzT1QyekUxL0t3UVkwdWxQeG9ualVYUUUwUnkzMEhmWm9y?=
 =?utf-8?B?a00rb0VyV2l2VHY5TVRWa1llU1dDV05CTDdFYmhhclpkNFBoZ0ljSmNFOEpa?=
 =?utf-8?B?SktIVkhHTXJQYkJXSG40VkVyNHNDZ1dYRmYxMGdLRnVjMmp1QmNkMkxsdmEw?=
 =?utf-8?B?TURaYnJqNVlMR2t0UlcxQzdhM3ljYUFJQW9MbHp0UmdpVUJuWEZTc1U4RlVx?=
 =?utf-8?B?TkRheW1VdlBhbFJ5MWtZRGhkcUNmaGdENU0zTWhpSVduS2UxbzBrb2I4NTBD?=
 =?utf-8?B?RVR1L01BNWRRaTVpd3N5R1E1Mm1QWEZpVnJDWFVETHpxZERZZ1p2NDlpME14?=
 =?utf-8?B?YXNHeTF2T1RIaXJBbVNKMWJraEZkYlc5VkEzSmV2cHpabC9qZE55anRPckkx?=
 =?utf-8?B?K29iQm8wcXJURmNMeVJ4S2I2QytlelJNb1NjS0FBMy84WGh2ZTQxTUtnWWxa?=
 =?utf-8?B?NnhPMGxKNExmOGJhM21PSmwzQUNMdEZSVzJjWUg3Z3ozSjUzUnFRUGhmZVBu?=
 =?utf-8?B?bnZaaHhFcjFXbnV3L2xqeVdLN21BeWhoVHFqeTBza1p6Vm1LcldkZFU5Tm03?=
 =?utf-8?B?RGVUMTlOQm9pUmZDUmovcURtcXJCWll4Q2N2bGJoVGhmUUo0YzUrcC9sTXMw?=
 =?utf-8?B?SyttQ3VzMGxqd3NreEI3cEJhVktzSU9TSkNId0hrOHkrZHljcjdyeW1XeExz?=
 =?utf-8?B?czFJR1NCTCt0dEd1cWY0WitaN25iNUpWOVlUR3BpeWs4ZElkZHVCTUxCaUFn?=
 =?utf-8?B?NW9NSUcvMkRJWVd3b3JPRG1hTVNYOUUwbzZMQVVZcDJ1SXkraWhVNVFXeDVO?=
 =?utf-8?B?anEwSW16WjBkL2RUUFdkYm9wVEM3aUVYUTNMT3V4S09aQmlUdVhDOStvRnlU?=
 =?utf-8?B?cXUwWVlRQlorQy93RnhtTmRwMFRONVVFemQ1eDNuWWQ5SUxWVlh4U3J3QmEy?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc4b2a1-ecb2-4fb9-1e1f-08dd992fe720
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 12:55:17.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FclqVMjdmXZffepeyuVoP/Pszf0XPYGQM280PlOfZwxdvdPoUnuT3E0PEeAyUe6N/8rVSO/tpf9m70qmAKDwzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7026

On 22.05.25 09:48, Richard Weinberger wrote:
> On Wed, May 21, 2025 at 6:32 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 21.05.25 15:40, Richard Weinberger wrote:
>>> Hello,
>>>
>>> While debugging a crash, I realized that calling schedule_work() from
>>> the primary domain is not allowed.
>>> That's why we have rtdm_schedule_nrt_work(). So far, so good.
>>>
>>> However, it still puzzles me why exactly schedule_work() does not work
>>> from the primary domain.
>>> I always thought this function more or less just appends to list.
>>> Is it because __queue_work() makes certain assumptions about the
>>> interrupt state?
>>
>> It makes assumptions about being able to trigger in-band rescheduling
>> when lifting the preempt_disable while releasing a spinlock. What you
>> need is an NMI-safe (from in-band perspective) trigger of work. That is
>> what irq_work_queue->irq_local_work_raise can provide via the dovetail
>> changes.
> 
> Hm, I'm still chewing on that.
> So, the problem is that schedule_work() makes use of spin_unlock_irqrestore()
> which can cause rescheduling?

In fact, the issue already stars in queue_work_on: There is
local_irq_restore, and that assumes to run in inband context. Even if we
changed that, next would be the pool spinlock in __queue_work which
would have to be hardened so that no one holding it anywhere could be
preempted by the out-of-band stage. And that may pull more stuff into
out-of-band than we want there.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

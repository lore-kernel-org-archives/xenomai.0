Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E732D23B6
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768219640; cv=fail; b=uYWv2HZTCLxk6q7qvPEqevcnKxLQ6uWNDON3Wq8Q3nP3jpKZubgXxOQhHg80Eg1BiU0GAHvifmEtif4VaIYYnWeFrRTdZvbxA7SlgvjQDUjRDoBsEmjvSb6Raz6XGHObMoEZ3ap8rc3NuKLhMqUDRbyriSg+ll/pd5L3xOVTyfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768219640; c=relaxed/simple;
	bh=ipO+tSs9q9dCuuC5icR2YkcCYDmcV4vcSdvhcCN/Id8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ofT0IkxXgBo99EiER1Ew3jzN5mWinfRmlVmNpzoUfi+MCMqMqi+ArTvkkNLZtn+eFOKcu5VehrbPkaA7Kb6jwadLblzAi1lGoiAREdDZKSi/q1kqlfmVC0NuOeHqa3qKqWSuBRlYbOZ7XLR0+wWhi/PY+osxYp/h/JowyCU7e9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pDcaUUHL; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pDcaUUHL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geRxG4yFL/yU9AqAyQLrtps6qCL2bjYNpF1aaIvQ41ZjhW68LCq76GcQVbXFSh7qOFeMDx/N5vbhHYMb9YBfk9/uy3kroexbUa2co4RIlT8oaiJ1rNOUr8NFSKm9UNTKVrH/pc99Qtho45x6XcWMRQ1js7pyyjfsZjA8DGvhXndOaK0Wpm5Ir9wCw9puMlyJLtKpeZwqmyLSbbwQUQFbWJSuyX3hR2dyX7O2KF0GlMFYKWXOc7cNUrPhhI+MTGu/qxS7tk/A1bddbueXIHOwom5pSn+6Gp858V8S5JRfMHR3FQRcwk635iXqXUYAFwMBNBnUReV++ypH9U/kQpQqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivktNoP8MzPvavOIpNVjtxnb4ou2S8XKEYxijUVi7dE=;
 b=fEQoajs1p/MQPRahsljU7I8jxSyqi+Z8DpXC4amnCgrPoTsIRaKvUgfhc+X2v82yTkiHBCe82NJkCeq5Rsqn1vfDYRwBdQJM5Y2h6kj+fCd3/ij2Oi/Kn1yZ3HKnMWGM9A+TToLFe5hprodyjkgkQVpa3gYVG746JVzc0lT76pzGixL8y4gvd7Ki8JAK4QZ6+acSE2vWgzQEWI3xd1S+ee3CTI1oCDxjrADVpOESnh+o+3SQ1kYgnGtXm0w+A7JH8GbKeqhQ3XHEM2UmwcQ9qmAtJqbfQNoJ/4xO9ECLTJZSEuvYT7GeSN6DGkLGJ7wUGipy/y/jyw6PBe9f0S+rVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivktNoP8MzPvavOIpNVjtxnb4ou2S8XKEYxijUVi7dE=;
 b=pDcaUUHLCBvk988cpC43e6gREbpzTj0zRmj+5cZe0n/z8+LJjTMrmGYrcuBiqNrGO+cslSo9vICpCtaUW9UIAo2RZstF5qa+MfeXNkOtHuQKxFb8OG5DhwqVJItE8n90Fx3OCdi7O5+YMe8uDr5i2TME3/lkJ+i7j6N5KoxIijuJ68R3MJN3a3BEf5nmmQnnrLY1i/Wt+avSQL1LsNe4TgcJjZkBi/rbc3Oq+xtTxMhQ1LHhuEqVIZE9/GMZaeq7TqVCNtvpRQUOpq+90fw2+Y0Ygf8pJRzEbZaF8D/S0lqoT4fZCCMYcGtoG0YXklWIGOQ8nRM4lH+byOP6E5YSfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::12)
 by AS4PR10MB5646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 12:07:14 +0000
Received: from AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cdc1:d862:a1a8:5a11]) by AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::cdc1:d862:a1a8:5a11%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 12:07:14 +0000
Message-ID: <fca483ae-4f34-4ed7-a92a-314c0ce9849d@siemens.com>
Date: Mon, 12 Jan 2026 13:07:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/2] ci: Add CI for linux-dovetail
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
 <20260109142001.2548128-2-clara.kowalsky@siemens.com>
 <6192c2c4-be00-497e-b41d-a7d1e9e344a7@siemens.com>
Content-Language: en-US
From: Clara Kowalsky <clara.kowalsky@siemens.com>
In-Reply-To: <6192c2c4-be00-497e-b41d-a7d1e9e344a7@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0023.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::28) To AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:740::12)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB9645:EE_|AS4PR10MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8b1479-30d1-44d5-972c-08de51d31fc4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFpiV0k0NkFRY3Y5VXhpS0hvME9JWThhNUppZjJZaW55dVVLOTEvT1Z3VmM0?=
 =?utf-8?B?SXZnV0JNcHo5bHVBdTg2L0FXSTFOR2R3bmdhL2lZQzBKNVczQ0tkVUNkU1FZ?=
 =?utf-8?B?WEg1LzJPZFFKSjhGNzhJa244eDI1Vzl5WFRiR1g0aEtrbWsxSncwVERxZVpv?=
 =?utf-8?B?TGRPWm9xQ1FXOUR1WSs5UnFGd2tzZmRMMjhzTm85NWhieHA3MHdjb05nVGcz?=
 =?utf-8?B?aHZLdEloZXdBeU93TFVqZENRdjdOMHgxR01uclJyQ2txeUJKWkZ6a0F1WXlG?=
 =?utf-8?B?bmYvQm95blZDOWFoUCtHdTdMVGdublphYng0QzZQYjhMRmJKQlJGaWVXMnBw?=
 =?utf-8?B?QjRSc2k4UzU3VWZNTkkrMkxSZUNQakl0amFMZGN2SzkyYWRoZ2JWblhBNGxG?=
 =?utf-8?B?RC9GS3ZwdlVEamYwRFE2VHZKUkFGeGt4TkordDcvaUdQKzFOdktwYmU0NGNl?=
 =?utf-8?B?SGQ2bzgranJDLzJIZkZsWlRIMnVUNExyT25hQ3l1b29qQWF0aFhGczB4OGRE?=
 =?utf-8?B?aXppZU5xVGxkZEFYcGt6RURHQmFqdGxQL0RWcTFxTHNPWUdDREN3N0ZEWEhs?=
 =?utf-8?B?cVEzU21kV1ZkMmd3UTlEc2dXK1FhT0FnandUd1hSRjgrd1RYQlgveHNhOEVS?=
 =?utf-8?B?b0grWUV5MS84TzNZMHRKdUZmNVhodDRVOXdta2VjSEpUUDYxMkJPOHFPUGhS?=
 =?utf-8?B?K2t2NHI1cjhLZ25lUjBvbmRuaDRmZFVtRVlZS0ZYMGtXN0ZXemtCamRGSm1J?=
 =?utf-8?B?cXBQNXMvUEtxVVIzOHJmdmZ6ZEtld3czVGZmdUpjUzFCVEVBcm5QbmUyNWJ6?=
 =?utf-8?B?WDd1TjJjMWo0eldSdnBDSUtpWEE1dFBFbU1TVHpidlU1NGpaclBtb0cxeDBq?=
 =?utf-8?B?NlZMcEZkUkpjWU1qbEd2VDM0ZUVUaEQyYmUwdGJLT28zK1ZkZnUxNmNHMkM4?=
 =?utf-8?B?czBVWmFXWU5CMVlyUFpRNlRYeFNCWUJWVmVIN1BISUZwYnJtQS93VzF2RGQz?=
 =?utf-8?B?TGRraGRvaXdpYUJVOU5CVi9UeGl6NDJrVXM0YkFFM3RSeE4xcjBreU5BWFJk?=
 =?utf-8?B?REhjdU5JZkJnanpYV0hma2pCZC9HUG93SUVEa0RPek5zcDFodDRraHhPWXRX?=
 =?utf-8?B?WG05dmlkUzRFN1VaNk1NeHpOYURxODBUTjl5Z1kwcW5SLzBTMW1mSmg4OE5V?=
 =?utf-8?B?QWxBbk1HbTEvbjhhTno4Y3l4RWtPcE9XdGtCdVBFZHJURExPOVhUYlYxeDEy?=
 =?utf-8?B?Z3hvczVlUTVBNFVxVFZyODNoNkYwYnZGZHk4Um8vSFp3UDBKMVYxY1p4b2No?=
 =?utf-8?B?clo3SkVvUWlNcHNWU1M1NzU4aWE4QmhoUFplQU9rbW8vLzU3WThIT0VNdUJ1?=
 =?utf-8?B?REdCekljaVY3Y3NsUTVTS0k4M254ZFpBTUdHVGRaZDlkWitvay9Wd3ltMzIx?=
 =?utf-8?B?SzBza3M5alhwbFM3RFlMSWFRT0t2YzFCczhWNlNRSWdQTlJrYmh5cVJuSWlI?=
 =?utf-8?B?aUc3ZzlvNHpHQVJCakp5V2o2bmc2bVlsZXVWUmU4TjVtZytYQlFmcDhSMkdW?=
 =?utf-8?B?blU2ZzVoRW9XQkV1ejQ5ZkZrc0o2NmljZEt6cm02YU13TVAzaGk1c1hGc1hD?=
 =?utf-8?B?cmV4dU9kalpDN01pNm5yZG04eGxyaVFwMG9tV2JWaTF0R1ZLQVNMQitiMXky?=
 =?utf-8?B?RTZxdUlpOFRIUUMxWjJneHlBcG9haXl0ek5KODlnZzJUSndFU1JlNHVoaTlS?=
 =?utf-8?B?UXZZMVRPcjlya1FGSFdLK3FUYTMzSnhYWUR2Q1VEbHBHK0pIOFJlbWNxcmNx?=
 =?utf-8?B?NzJ4N2gxUFByeG5vbHdIbGtnNVROTmxnQ0d5bXByWlJmVlB5ZFFwbmV5RWV0?=
 =?utf-8?B?QjlkNHZhU2VPdzFZZmF0U0Y2aUtrdXV3c0xOS1hoUlhaRWJ6V2tkb0RVaUxP?=
 =?utf-8?Q?2WUvZpEqBNaKOtBlIdi2s8LGsPGf6ep1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnhBQlNxSXFoa3JhYXc1SUY3aWdudko0NGhCNHZFcnp0ZjFPWGdVajNzemFM?=
 =?utf-8?B?YThMcE12TVY4S3g3ZGFxWEdYR2NUQ0hVT2laSzJYZXM0VXMvc3NSZURGSm4r?=
 =?utf-8?B?MHVCL3g5SllISDh1TnFycWJSZVZuNXFUWGRhanFWRnYzb1MvT1Z1WENCMW8x?=
 =?utf-8?B?STZoWGQ5L0lMU1lWWkZLRUcyS050NUt5R3pPSmppUnZMaWlucFF3Wm9wQ0g2?=
 =?utf-8?B?ZWNmRkhleEl3RWJLNEtMRmMrNHozUXlGWnBSNzZGMGl5V01zeThlblQwUlFz?=
 =?utf-8?B?WUtkUmd4MVBtNU1XQkdLbVEyT3pZa213cFFrM3V3NE42M3F2YjBidWpNSUx3?=
 =?utf-8?B?c2g2QlNaNWVzaWQrbWhLTW1lV2ZHRmhpWkRQZkk0YmU4UHJXM2hsVmt2QklH?=
 =?utf-8?B?Y2xFaEJXRzVESkZ6UDcxTUtBY1N5SW0xMW1uYzVEOEhMQi9rcGNCc2NQbVN5?=
 =?utf-8?B?SE5BUUZYQmc2cis3S00xRnJCMjlKMEFJcTU1L3JaQyt1SC9tZHM4enJTME1h?=
 =?utf-8?B?UkpkaitFQ1F0UzB0QWQ4UE0rZllzQVdSN042SlZXd05uaVdncytJeEFtcWtT?=
 =?utf-8?B?c2J2OVJkaE5DMzFISmxzNGREZDE0bVFITFE1SVE4dWNUTExlaTNuNisrQTZq?=
 =?utf-8?B?NHBydHkyZC9rN2dRLzFNdkJYbWVZeW1LUnduMVpCa1pWZnREYVQ2dmdvRU5O?=
 =?utf-8?B?U0lySTd2RHlWSlphdEI2eTIwMzBtTkxScUpQK0J1dFFadkptd21FVExRSTho?=
 =?utf-8?B?cjQ2bjZ2VlZnRGZValBVY08vaE8xdWNlSzVnSHR3VmtNa2xkWTNFclMwdGNa?=
 =?utf-8?B?RzBMZWRjV2FTTTBoVlR3TXg0WFdaU0RRa3hWRUd2dy9uQXNhUWpUR3MxNHBW?=
 =?utf-8?B?SXlPeFo2ei8wZzdBd2IxdmVEZWpDaWI4TXJZdXJweENNNTlZTDFtQURwamE0?=
 =?utf-8?B?WE9MZmVWNXpIeGJHYlZRRVkwU2F0a3BEUXQ3WUNOVGFIMFNUNlFxNW40T0Z3?=
 =?utf-8?B?a2hmWWM1VzFUdTk2WVIzcmFNblR0WHFIRVhGbE1ZWTU5UTIrUzlFR1JRSTk1?=
 =?utf-8?B?cklMMklYZHNPNmhQWHp1RjdRTTFwcTdnWnQxSngxZEl3ZkZnSnE3dWs0NGx2?=
 =?utf-8?B?dWh4cGRMWlptQXBWUlZCUldFK0NZUzAvck5QZnJpTW5FSDQ4UWlxRTk1OEhR?=
 =?utf-8?B?MnFQWmF3Zi95dHF6eDYxSmhkWjJDdXF2SUN5V0xNRE5QQkRlQXFGZndKWkZn?=
 =?utf-8?B?QjVIMGhmY0xrWERBbzQ1MW13S0czdFV2bVpqRnhrVG9aazVKeDJwbE1TTkJp?=
 =?utf-8?B?VFhMSmJsRTdYSjJZRXFQQWhPdjVVMmQ4UTdkUnFsVTZRVmhWVVA5Nm5VYnhY?=
 =?utf-8?B?cldLUTY4RDNUcE5kdXJQa3phM0plZTRtaW00eDRydjRndEN0LzU5RitjRjJF?=
 =?utf-8?B?RnVOTDlzQTdsL2p2U2VQN2JWNWtXVVVhc1I0QW5CcTBEZ29Kay9WakNQejla?=
 =?utf-8?B?Q3dEcFBzeGwvSGN2VlpwYkpHZnYxTkFBQWpqa2M3LzkzL1VxQXU2SWhhOHQz?=
 =?utf-8?B?ZlM4ekE5OVVCbmhqbElVZUdjdzFWYzFZdnNPdktoSmVNREpLVHNHdUN6Y084?=
 =?utf-8?B?TzhqVndQbFZUa0tTSnpzVUozOGJXTmQxVzVraGY1U1ZiZ0JUZFhyekdlWEJL?=
 =?utf-8?B?cXhrN1Uwb0lQQ1RMMnhMWGc0c29Hek1mekhOTGNnOWFTRllCUXE4SkgwRXl6?=
 =?utf-8?B?dUlUMjljQlRiRDR2elhWNGZ1eUgzdWRJcGFORFVkQ09YVW1kTVZhTVpNYkg5?=
 =?utf-8?B?b1ZzeHJ1UmZxb080NFRRU2IxdHB5TkdQQkt4eGhIQjZtaHlJT2ovTnYyR21K?=
 =?utf-8?B?NU16NUJsUEFRM05BZUZ4TENnV29pV2xURnBnSmR5TjlYaUhSRm0wbmJMeExY?=
 =?utf-8?B?VEMvSkFXUEUvcmNSeXdHd2hEYjZtWUdYVHcwR25zYUhjdFYvRjQ2TlorYk5z?=
 =?utf-8?B?UzBKUCsraEdRbHFlT0dtSitPMkhNS0ZrWjBoQTJkZUpwVUE0cXdQTlBOYVVK?=
 =?utf-8?B?VGJLcW4zWjFxTjErRFJnaC9xTHZQTDRqUnh2YzB5T2FRcTExUEV6OXYzd01Y?=
 =?utf-8?B?MkFleTdCM3FpM1VCYXBFT2JaT2FoRTdwVithdit2WE54TG5JOER6OTU0Q295?=
 =?utf-8?B?dlVZWEpYS3Y3S3U2Z2o5YkhWMjM3RnhQS3c4VnU3aE1ZNnRWeEV5UCt5UW1E?=
 =?utf-8?B?L1VKT1I1K0RqNml5TG1TVGF6RlRzY0NtTFZkV1MzaGVsaStUVk5nTmxuQ0lY?=
 =?utf-8?B?VGpJZzBuWDkwaTAxWnBUQUZTS2VIU1lKZlFIRUp1eDFsZ21QQzQvbVlyQ3VC?=
 =?utf-8?Q?pe++TzSRJUs0XOAY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8b1479-30d1-44d5-972c-08de51d31fc4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB9645.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 12:07:14.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34baXbUvindd8Q4gLtCh0UzBOBnwEVTxlZ+wIcyGJxzuii4LyFGoLlfMvwtzz7dIgGZtVDnL0EqOMhBprfaD/D5NawGmSLc5dNde3suARfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5646



On 1/9/26 15:38, Jan Kiszka wrote:
> On 09.01.26 15:20, Clara Kowalsky wrote:
>> The linux-dovetail repo is configured in the CI/CD settings to use as
>> configuration file this file in xenomai-images.
>> This adds a CI job for triggering the xenomai-images CI if new commits
>> are pushed to a supported dovetail branch.
>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>   ci/ci-dovetail.yml | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>   create mode 100644 ci/ci-dovetail.yml
>>
>> diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
>> new file mode 100644
>> index 0000000..52685e6
>> --- /dev/null
>> +++ b/ci/ci-dovetail.yml
> 
> 4.19 is not dovetail. You will need a separate ci file for that one, I
> guess (different branch names).
> 
>> @@ -0,0 +1,43 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Clara Kowalsky <clara.kowalsky@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +stages:
>> +  - set_vars
>> +  - trigger_xenomai_images
>> +
>> +default:
>> +  image: debian:bookworm
> 
> trixie-slim?
> 
>> +
>> +set-vars:
>> +  stage: set_vars
>> +  script:
>> +    - |
>> +      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")
> 
> This transformation is not expressible with gitlab-ci means alone, is
> it? If it were, we would not need to run this in a container image.
> 
Unfortunately not. It needs to be in the script part, as shell parameter 
expansion cannot be done in the GitLab CI's variables section.

>> +      echo "KERNEL_VERSION: $KERNEL_VERSION"
>> +      { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
>> +  artifacts:
>> +    reports:
>> +      dotenv: vars.env
>> +  rules:
>> +    - if: '$CI_COMMIT_BRANCH =~ /^v(6\.(1|12)|5\.(10|15)|4\.19)(\.y)?-dovetail-rebase$/'
>> +
>> +trigger-xenomai-images:
>> +  stage: trigger_xenomai_images
>> +  needs:
>> +    - set-vars
>> +  trigger:
>> +    project: xenomai/xenomai-images
>> +    branch: next
>> +    forward:
>> +      pipeline_variables: true
>> +  variables:
>> +    KERNEL_VERSION: $KERNEL_VERSION
>> +    ONLY_RUN: xenomai-3/dovetail
> 
> Jan
> 


Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010013.outbound.protection.outlook.com [52.101.69.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA953236454
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970334; cv=fail; b=VI12k2gurXYW9OTG4QkLBnmUDOFhVISPR26APeHkLBH3Z3HsaTXyyZCd9rAcXC+oyO42nKhXHIyBJXLVkBW1X54udIUJwkPGvbSQOwIsorwDVLGBSZ4kAUGJLOwF0OBfl0lPM0qP8Q5mvvgB7cUk0YgWaVUbN7PPJpGRGwGzXbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970334; c=relaxed/simple;
	bh=+jzY30q1Niurhugvqv+2VWBKAteopCyvSpr7m6JxZM4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eXgQs8f3XR4MSi8/YyKEkPQQbEOInNEBJI76Gq31Q+Fr/BvLhb2Gg3f6T0o3vGqPHQsKAeoqwVCQwhs2BsoFAiwRDggjzs2+7hIw53VpB5UieBNAMZ4HuPRhC+4fyQCR7EGoJwjTx33fXrBPriVJb/hk026aT9DcO4QSStKTEPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KRGNS+1l; arc=fail smtp.client-ip=52.101.69.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KRGNS+1l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDMMnWqOLXZ1Y7jCVXvtr6cg17FJlMoE4IEefpLcCXAZ0vI0lbg4T6RKhRuwyb5060CTm5M0oqktuEXQ5FZtJapc7Zd2T8dzdUGjKEaXFcOWAuB0PEzrANWsNlO6oQfAVnUfpscFKOWzpiO6rZiFUIut2JTg7tFXPWrymjvVKOS5cyYvBN7f164NC6KS9XJ+l6BbWvXrQmwTs/xNeSVWMaxoifSlaLn8jPLaDOFl2YbQAWEvJE2nMWYG7Euq3LVrrgYUe0eyerLFqEuofr9THGJPeAGNsI7dwjJzCn5ByLBAPOHPzXCGXeClQYwYhhXErFqjvF7/mD4WpVDoxjFRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2B2mnvpdh51j2cmfziGkNApXfcthvKGXjRahY7XxJhI=;
 b=pDijV3rCEjEiS1eBz4p8UkWzscwCjTisbo4X5SMxVdp9hYrWFfyeTJMfvhjb52XNwXJ2eR4LBgAutY0g3Yt6lG7NNWjnvp0UlFcxg7XmOIUzDSaXh/UgwBRVzg5lpvC3L6OFq5wcwk0Akyfky7n0FBWCfRP5URXJG5RXNtKGN+/IkD/5yH8QEmOSco0MnmFaeoCLeDbyU3LgFoFVgKvRfkSQN9/rEaHxGZCV7JKpa3OG/mXgVAp9npiHVroajAM0dCgCP7vqlvXwx6CIMZcyMqJwxdO5WgoE02Y/BH6lYCk7ZxN2TvCzUYxVdQh+BAySHhMuWRkggdt/WvYnPfLxLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2B2mnvpdh51j2cmfziGkNApXfcthvKGXjRahY7XxJhI=;
 b=KRGNS+1lwvexK6CUDCTp7YY4X8F0xeFi1bb59pB2btk6r3IDek8F8mgFyOwr0viWJS82z/GcxcEU+AnW58MznlPcULzPicwS0DvPxnSzf+c08OnB7PRFIeGcnXEAQRhmakzy2GqknJTsN1DWcXRVBPHkvD0at3v14TLL6qVQ72g+cj2OPoD0/NIimL2FBewR4q3H2bY9T01WumjZIdVrqh3I6DXFTfEkbxWJgRGDU3A4K8bUm8XNYX1pF4OiLTnWL9szQB4co6qKei0Lp80etOQlXLaDhpVRWqhXm7RaIZ0jUMHbXNNuOqcRsvPdLnwMZQ2oymmzYGrJgpsM/oB0Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5540.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 14:52:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 14:52:10 +0000
Message-ID: <993b8ab6-6dd6-4a24-92e4-928fb03fd26c@siemens.com>
Date: Fri, 9 Jan 2026 15:52:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/2] ci: Add CI for linux-dovetail
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260109142001.2548128-1-clara.kowalsky@siemens.com>
 <20260109142001.2548128-2-clara.kowalsky@siemens.com>
 <8671583f7cf796643263dde1d4e6b8640b3821c9.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8671583f7cf796643263dde1d4e6b8640b3821c9.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5540:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2c218a-a633-4d0c-e2ff-08de4f8eaaa9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXdqS2ZHdFVIdFBCOEJZaWx0VFRiZGxkdzdRQnhRRmFsZVlpUmhPMThUUnB0?=
 =?utf-8?B?b3pyaHlLSDRPRzczMlJGV1ZyY1RrbW16eWRXd0V2WGpwb05WZXpkTkgrZzJx?=
 =?utf-8?B?d1hmSkRJR0lPOUVra1ZYSy9WR3MvTmJNY0hjbVJiN2d3Q0I1WW00ZFBqU2Z6?=
 =?utf-8?B?TXpwMTdWTWlWaHJYa1pZdjFYY0xONW94cjR3dDh5MDFIV2VDeGNKd3pYZ1JD?=
 =?utf-8?B?VXNEL3VCcEFmeE03UitaWkxseEcvSDZYNE40VVRKUmZYbVh4QWpJSjJVVWhK?=
 =?utf-8?B?R0dqMFFUOEVsK0d3QXg2WTcxU0p3M1BhSC9KOEpZZjRZMDNBcHQyR2lDY2NY?=
 =?utf-8?B?N21xTkF1eEdxVnlaYlpCMDNVejNocUw4WWtPdVNwcTZldFJwMHBueUVPNitN?=
 =?utf-8?B?MTZVZzJYYWFFQnozM3kwVkZIaUx6ZHhMVHFwQWxnY2o0WUdvZENXTTcvenJV?=
 =?utf-8?B?RFdFZVBubEhRNC96N2tleXhud2lQZVdaZVJqZDBsZzl5OTk2ejZ1dFlhOUg2?=
 =?utf-8?B?REVBbDB4bU9wVmVyeHN2cDVJMHpQVkFOcVJyTlZYbTFhOHRxU3JCbjdvejQw?=
 =?utf-8?B?SGV1RXUzaVZHRW5RKzg4aktxZUt3WmxPdkpWTndEZm5FWTdTWVI3SlI0b3U5?=
 =?utf-8?B?Z2dDWExSZlpVME55OFlKK1ZEZmJoVUZLVUg2cG83T1lYK2grVFM3N3I0QTJh?=
 =?utf-8?B?UDY3TG9uQnlyWWpSMGkzeEdyamgyT1JhcVd6Q3cxM1V4alRXUWdDdFkwaDUz?=
 =?utf-8?B?UDZ0VmptZFBUWUZLekJ1S2ZMRzBhTklCRko3elZLT3YrVTRPa0JkUXl1UmYr?=
 =?utf-8?B?aUkvcXZkR1hZeDRMOEkvMnlNVmVFRkE0YXl3eFBHVlRJYkVHS3NCVXY0bXhV?=
 =?utf-8?B?djFQcWh2cmZFeXJ6UUNkVGV6aFpObElqeGZyMzhzdzk0THhhbVlaTkpYTzY4?=
 =?utf-8?B?dXVoVnJiSlM0UlZqTVhSRUUxZERObURIZy9jb1R3TDdhcjdzZE5scWhpSXAv?=
 =?utf-8?B?R3dzRDZHTE16OVZabWV0emhDUnVGVytFZU5SKzVSRi9LT3JxV1N1QnZzYkY5?=
 =?utf-8?B?NWNWLy9BcU5PZThRMVlBazhJbmRsNWRuU2Q3MHNOaW9jdjQzSmtzYkYwNmth?=
 =?utf-8?B?emNDMFBrQytLcnVMbjRKaUtQdVhoRlpld2hkYS9xQ0NFbVhIMFlRd2RFdFpT?=
 =?utf-8?B?WjFvZXZTYWU1bURzL3VhRmxIcDcrZmUwU2NiUUh2cEY0QjE2WVJrcXpVWW5U?=
 =?utf-8?B?d1UxbXFMdndPVTNPYzl3VHdpUEordUZvSHFkVnIrK1VwNTkzMEFRdERoR2sv?=
 =?utf-8?B?cEo5Rng4MDBCNFhpWHlBY2dzdFh2aXNpRXBvc2puV29CV3Awc2FjdXd3TXdT?=
 =?utf-8?B?TWlIWGd6TGx6WFh4bUpWMERxeFlTQy9hamdxU245Y3hNMVBSL0R6UFVpZjN2?=
 =?utf-8?B?SkNSUm9wREVLdHhiak1lS3I2U2ZFcCtlRXAwTjJ4akxnRGhST2NSQkZvbUpG?=
 =?utf-8?B?SzZKSlFKWHBMeTlIYkhqOWtNWmdySzFKTURuS3R1Z3FXV0xma3BqaVV5QnZM?=
 =?utf-8?B?V1o4OVlXbGtDTzFpSDNKRXlNYUlmb0dmdkRpWlQxRVl4NVFCUUFTOXdIZEM4?=
 =?utf-8?B?YWRPdERDME9EcG1iS1hLWG1HSDd6ZzVHWmpqb3hwQXpZZnlJaFF1cXAwRFRy?=
 =?utf-8?B?dlMxTGRXMjQxdExSczM0a0JrQnM1b1NVL2hEaHFiWktZNWJIbXJja0hTNThD?=
 =?utf-8?B?OGpiUUhvV2FrQ2dIMmR4TWZoeHp3Z2l4WHFlMGcxWTdBcUlYTXYrMFJXYWxo?=
 =?utf-8?B?QWd4bGUvTXVjOW0zNUFnWU45a08ySGtub1BWWk1xOGV5azhNbGMzTDlGdnMv?=
 =?utf-8?B?SUpleGpjMkFEY2lDMm90THVMdlFuYjhLdWN4UlpqeGxSZURTNHJaU3VzWW96?=
 =?utf-8?Q?PA5dQXVNhaQ+hP6f/RtFO7502YbT81Nm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDVUckN3OFBTQldqbW0xeHVIeEY2cWt5VXZxWGhIZjhYemx0QnRRZlZlK3Rq?=
 =?utf-8?B?TmhZS25PaW9reU1xMUJ5N3BSdVJLWEorWU4vSnozS1Zwa1Fmb3JlOVZKcG0w?=
 =?utf-8?B?NUo2M3hISGVlVkNiWWRlbXN5Y2NiRldUdkp5Zm1qTngvOXduVjRoSTZhWlhp?=
 =?utf-8?B?cVZMNW1CazdiaURKUDdqNDgyWTVRVms0ODdKTlNYMlNtQ2tKaWRCdmNUQXFH?=
 =?utf-8?B?aWpuYlJMVVJ0cld6VkdsN1pKZU9MeExyZVl6RWZMVWJSVitTdklzR0Q3Zm54?=
 =?utf-8?B?RWFmemM2QXhrWW9qVGJXTTRzNTZFdzU3ckE1Y2Z4cVdYTC92V0ljQlpoK010?=
 =?utf-8?B?dDlYdUh0RjI1b3pub05rWG8wOHk0ZHc3YXYzdElyeWVkenhJVTU4cGR6aGgy?=
 =?utf-8?B?TU9tZ0EzeU0rNVdoRFJYUmRicEl5OUljcUowT1pkT1FHcmNKMmZmc2UxbWNs?=
 =?utf-8?B?ZzZSVkVWQ2VqbTNudEhUQzgrbTdzMHhMcW9vUXF5aHo2MTh6NWhBN1dqOE8v?=
 =?utf-8?B?TTBrVURuS094NjJXR01vOUNORklPYTVIOWJkMGZLMkdyTE4zemVaN0JtRVJr?=
 =?utf-8?B?NkhUSk9aSm5NSFBtd2U0V3VtK1Zic3JXMjJzalV3d1NMMmZyWUo2RlBLenZ1?=
 =?utf-8?B?OVpibFVkbUpvVW8yVjhrZ3doM1FXK3FGd1JyeTl6RHoxL0w2aFNpdy93bXBH?=
 =?utf-8?B?VWVydldnZm5TNnNhTHpXLzVQZmtPM25mS1VXMExHSzE3MlBpK21VTXFQYmxq?=
 =?utf-8?B?YU9KbFhsTXJDRHFQVXpBWHdieG9Vd3VMS3VTejhVT0NVL29DTjY0bnVjaDdk?=
 =?utf-8?B?Qk9SWFFuL2trTkVSdW9sUEV3eTVLSStnSCsyNU9LZ1FLNi91dW9uVDZicXVR?=
 =?utf-8?B?VngrdGpKQzh2RktSem1xemtnbkk1dmZ5dm8yR09Kc0t5QWhRZDJkTEVma3dT?=
 =?utf-8?B?N2JadWVRdnFVSmFQSUQxUmxIUGo2c2Q2WUcyVjVWVVlhaklQUHFiczNuanhq?=
 =?utf-8?B?ZHF2VGIxNmVBWTBibWdVa0ozdXhGQlAvcHM0bGtteTcyVEVHU3JoRjJWOEhK?=
 =?utf-8?B?L2lnQkZYS3lYU3Q4V0VhSys1YUVGb2J5L0llcENvMzgzQjRMSlUvOFpNREd1?=
 =?utf-8?B?aUVIcFZpWHJmWGx2L0tIcDZPSk1EOFZQZExubks3SGZWSnJjMkloQlNmajZR?=
 =?utf-8?B?L3BOU1M4SWxyRDk4ZWx5YVN1anJJZUlKMWE1RkFXNDZCNnp0cEN3bnVVenBF?=
 =?utf-8?B?L3M4U2FUVXNkdnAvWUpLZUxBSjNQNzBpZ1Q1c0UzZi9mVjBsaUEyZCsyV0lj?=
 =?utf-8?B?ckwyS0dHb1M5eG1mdWoxM2NNS0RUNTl3NUgzWExWaFhqV0RmM2Z6S0pSUjZZ?=
 =?utf-8?B?RXRYL0dHWW82QXQ1WjRrM2NVc1ZqMWVZWlVNM0tEZnlld3RxRC9Jc3V6dzRK?=
 =?utf-8?B?N3JNK0JFVWFJQjQyVnJQMEY3Nk1MZ3YwZ2EyUE1DMzNlUThWcWdtSERFNUw1?=
 =?utf-8?B?ZHJVK1VUSmRnbTdBNW5TbXBMRTk4OFMxODBiUUpDZkZOb0wzbWdSb3VjTHFv?=
 =?utf-8?B?MmdNMnZVdlhTWVNZT01tZTJmNFJDalMranM4dXhaSWlXZFZGUGZ0VmE4NWJm?=
 =?utf-8?B?dWpaQWNCS1NEWUE2T0FVaGwrZnFpNTFUV1JlS3hhNzB1di9PYTdCRGwzTHd1?=
 =?utf-8?B?MUVvM3lVYjBaNWlRb0NyVDBnbFlvUlVoWVJ3UmVlYzI4NWVhQ1g1d1QvOHN0?=
 =?utf-8?B?RTBjWUcvMldVRlpNNk40L0NVK3RVdkFIOTJWeVFidGVTQmxGb09ISjdNZU1K?=
 =?utf-8?B?WWRlQmphcVVDSGlaQUk3YVVMQktUTmt3Q25IaHlXanpBZXByN2xaeDQxQ09s?=
 =?utf-8?B?MzEySk5PblJBTjlmVHJxeFE5Zjl0SHluWTV1alowdnZoV2EySUs5Nm5pSzA0?=
 =?utf-8?B?dVEvN1puSmtNanF4RWQ2Y1hPSWFaMGVpQlplTjZJOUIvVVVGOUNsQ2lKOUw4?=
 =?utf-8?B?eGcwaHUrZ0dZZWlVdFArMmgwc1dhVjdvb3lLdEF5ckp6akxFcndaMm14U3gr?=
 =?utf-8?B?aTN5UDZUd3RJZ2Y1bEcvL3EwcDdadEJ6dVo1N3NsTW1HcC9mRE5LSmxpU3N1?=
 =?utf-8?B?cHZkSzl6VTZxVDh3U2dJK0E3cDhlakFtcVVWQnA2djNqNnZEZGhTb243YW4y?=
 =?utf-8?B?elBnaU9rVGQ1RCszajNPUzcyOU9PaWFhRVdKS1p6aXgrL3RXb1Nkb2RsajhG?=
 =?utf-8?B?bGZEamZhcEpid0NIVHNSbWhpWU9DZjVKNVR3ajNRcDJrYXdza1dvTjhYOWhB?=
 =?utf-8?B?TjRlR3FabVdPTnR1eEVnWXZHb0dvVDZCVFFHRVpqMlhpdEdsSTZVZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2c218a-a633-4d0c-e2ff-08de4f8eaaa9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:52:10.1180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdDvy4dqgKQWDTzqRP70Cnv33b8OU0yE/ehC+L37lHQXGI6903gwwmbqsVp50rJ8LQ5wlvPJa/PO+U0tvZhEDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5540

On 09.01.26 15:42, Florian Bezdeka wrote:
> On Fri, 2026-01-09 at 15:20 +0100, Clara Kowalsky wrote:
>> The linux-dovetail repo is configured in the CI/CD settings to use as
>> configuration file this file in xenomai-images.
>> This adds a CI job for triggering the xenomai-images CI if new commits
>> are pushed to a supported dovetail branch.
> 
> What is the overall goal of this series? To trigger a CI run if one of
> the LTS branches moved forward?
> 
> If so, is there a plan to clean up all the branch specific recipes?
> Keeping them in lockstep should not be necessary anymore, no?
> 

I can't follow here. What exactly would you do differently?

> In addition the gitlab magic (uncommon project configuration to point a
> project to a CI configuration from a different project) is completely
> hidden. The file seems unused und might easily get removed. There should
> be a comment somewhere explaining that.

Good point, can be done in the file as well as in the README.

> 
> I'm also unsure if we should really move that logic into the xenomai-
> images project. Seems a bit overloaded already. Maybe it's time for a
> xenomai-ci project?
> 

xenomai-image is so far the project driving the main pipeline that also
does on-device testing. But there is also CI in xenomai3, e.g. A
separate "xenomai-ci" project would sound to me like all CI is handled
there - would that be your vision?

>>
>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>> ---
>>  ci/ci-dovetail.yml | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>  create mode 100644 ci/ci-dovetail.yml
>>
>> diff --git a/ci/ci-dovetail.yml b/ci/ci-dovetail.yml
>> new file mode 100644
>> index 0000000..52685e6
>> --- /dev/null
>> +++ b/ci/ci-dovetail.yml
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
>> +
>> +set-vars:
>> +  stage: set_vars
>> +  script:
>> +    - |
>> +      KERNEL_VERSION=$(echo "$CI_COMMIT_BRANCH" | sed -nE 's/^v([0-9]+\.[0-9]+)(\.y)?-dovetail-rebase$/\1/p' || echo "unknown")
>> +      echo "KERNEL_VERSION: $KERNEL_VERSION"
>> +      { echo "KERNEL_VERSION=$KERNEL_VERSION"; } > vars.env
>> +  artifacts:
>> +    reports:
>> +      dotenv: vars.env
>> +  rules:
>> +    - if: '$CI_COMMIT_BRANCH =~ /^v(6\.(1|12)|5\.(10|15)|4\.19)(\.y)?-dovetail-rebase$/'
> 
> There is no 4.19 branch in dovetail, good old ipipe times are (nearly)
> over.

Yeah, we may also skip 4.19 for now - or forever. The exact EOL date has
not been set, but I already warned about it in different threads that
all users on our end migrated away by now.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

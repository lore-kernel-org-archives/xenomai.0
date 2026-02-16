Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3635965
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242586; cv=fail; b=BRnmn3ze46AtUC3Ke6yki+ByLq6nUgsCXdx0JywYaZLuy+KNtCP3Z21dR0P8eP290Cq1PbY730JH0wWCZuVWOBd2gMgIAzaIhMdjoEZUdoBRGZAskFfGFmD8dC4gd6TpqPdSd7t5kUiJKP74E1XS9+4fbCo/ti/xr88S2WVljek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242586; c=relaxed/simple;
	bh=Y0xqI0k719RwCLcyATqtFTia78jTDdqyX97Uc/EChOs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tfszmUeb8Z4VXwBH+V/pByLz1pqyU9hI/xwSFb1c7vZATplcfSJ1i0IVsibU1jXPyMRloemgKLqJaJmRmwD0Vc96nA9HpnX9UWZfU/t9aAfT0Lf2gqolZczNL0oadTuDt7VwSsJhSTa6aimTGldCw4N/+rOfLiEinTmQum6YCvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=T0VVIOAm; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="T0VVIOAm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8nOsaRmvd8O2JC3eyzbpEfUCH6+K0tsAzE3Eq7xdz7SwfGRpsPzE0qbwx9AIJj3y8eFnzNvUWsM0tJLPVnziDLTii/cMKux6qLBL3o/7ldm9LsOCkMyU0fD6nSGlEALvofBeZNOJGiNUF1qrBkcD1TysLnMBOuO+HbZTAbxC+VNK63xaU3v+CSEs9Ij7Q6OhEPXKEx9lkav8/h4aCAkpWZ+U/KkNwE+Qi5d0U5Tc8ylwf/SLErbxbrG3foKCZsUU/o8TyDcwDODhF8hJemyBTmbOSm6oHId04vdt33W9Acvp0IDt6djuV5znvJz5HKpvkxRk8CnL6ckySKPI9lYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mT5QjkWj1pq+3W9q+tnrL5S0QqvNFP9L5+COFohW+QQ=;
 b=i+fwkZQGb9DWTDD+mRReVRRN1KVIz8YfrV0ETRH7aLT8+EgbKv/VV6M5Oreb+3UzO/LWbmboXpXYAHvTNYAe1Fh5yWPhVlOg84kYsG5LGhyelpjXNHiygUTXqvjZ70p6yzaYZ2A77DF8pWewvjP2nBouKNEaEgv+9eDMZljHLoJz7sDYP37nxm+rTRDhhoTUg0sZqKsQisSWtxebjNWBc5otb62Ixcf5BmUkuLzXf8CEiz0RkLJT0jpTb48Ys1gOhKPk/XxpZFwd+sd9LRDPMOextaSX6JJYw7auCVD5wYRt4aHPdhoLEOxaIuvU1KoCSe9eTgVXkHTGFystuPc24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mT5QjkWj1pq+3W9q+tnrL5S0QqvNFP9L5+COFohW+QQ=;
 b=T0VVIOAmT9B+fr4UPXekWd7GgAl1jI2Vh9kXWtYRyxDiTjBald5ygOHN+bBI4IYUegAmAMVbESRqOCZjUt+X9EtJwZB84Sa0yntnnhg0697QpTiD3U9jJo3G2D/YEGbDKkz/mLWjL2gsYw9w4Jb02FodXKJ4wq+pVGfMA3PKZj2+NUaOBm3Fm+fcnw11ZEgGU8HQsWbPd+Yg0TfajKOmIU78GJREQdwYjOaqfbaePWKNIKX/d95SlCZH0z0oVjpQSYyh3P3uZNC/vFf9wKHCE4DDokroGj1HVpTx533XxpGZuvPeWnAJNfis7Mh5sSayL+muqnYjawxSmC7G2XntnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB7936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 11:49:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 11:49:42 +0000
Message-ID: <41ef78e1-5de4-4106-8fea-f5a424d68a39@siemens.com>
Date: Mon, 16 Feb 2026 12:49:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 2/2] ci(libevl): Trigger more kernel
 combinations
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260216081629.3163713-1-clara.kowalsky@siemens.com>
 <20260216081629.3163713-2-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260216081629.3163713-2-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3e5ca9-9274-433f-f43a-08de6d517904
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGY4VUkxUEJpU0Vua0Jld0hxM21qUjlJRnE2cno4YVJCTnp4RkhHekxYbTdq?=
 =?utf-8?B?eDd1bW9kQ2wvbkpXY2ExdUxmZ0g3ZkxpSzBuMzBEanhEL0llemlwYnhoUm9s?=
 =?utf-8?B?TjcyZzhBN2M5aEZFQXFja3pEeUJpNEI5WUVtN2lyZGtrZGhaQ2VEQ2UybUNY?=
 =?utf-8?B?ZnJ5SHlwQ3hsak9kdmtBZ1UvS1IvOU5KYlZ2VkZLN0dHbStFSldGdWt6M3p6?=
 =?utf-8?B?T2c0VDVld2VvZ0RuUDNBWXptenpVRVBhaXpEblp6NVJqQW5MUDRicjkrTmxP?=
 =?utf-8?B?eG5xWnIyNThXQzlndUUydUFMMjczUFBzcnVPVno3RGMvcS9NaGFJVXJtYkNK?=
 =?utf-8?B?ckpWM0xoRWlNbFcvTkNpNmtaeWZPQUg4TTlSYmVGdHI0bjJBeEw2Wno5ZmZD?=
 =?utf-8?B?RFRJNFRUSmNFQS9hVXVLekhLck50SzZkVk5KZDY0MWJWVlN5cFlzYi94bDk2?=
 =?utf-8?B?UW5wajhDa1FXaDhmUEhVWVRBWDNnVm9NRythTTVyQXZMaU02Q1RkazVBL2Ux?=
 =?utf-8?B?ejdLcG5LMjhYcnhTRGxZNGZtWUE3S0FUT2IwUHVzSndGTW9EM2wzbE8rWmw5?=
 =?utf-8?B?WGw2ck5vWXh3ZWFMSUJWQWdIcEFtWjBRQUYyT1JIKzRmMzArNXp6eVo1RVQ3?=
 =?utf-8?B?SkZUZlJNQVVPcDBpYlM1dmxzQ2M1Y1JQN0NQZEkrL3NtK21DVUcwK1FGK3BD?=
 =?utf-8?B?RDZkaDZGeHJ0TTNBTkN6eVQwbnQzS1pTemdEcUt2d29JNnpacE40MXUrZzdI?=
 =?utf-8?B?S3RFMGhGaVVvczJRNlFzSWpZV2JyQzZxRVFqMEU0cm5UUStFMThDYi9PcnhX?=
 =?utf-8?B?YWZJcjU3S2RkRVpHd0hLaWxwb2tHbHFpclJlY1l3YmNPZmsrMy9KMngranBl?=
 =?utf-8?B?SkdSbzFSSG5CVnVzZnpQMVQ1VmlWK2JyVCtvUFFyOHVmZm5sRUJZWXJ1VVB5?=
 =?utf-8?B?OWE4WmxQeUtwcDducWRxNHdPVi94cVZzYUF6dURBekx3c1A2dndYWk90dURI?=
 =?utf-8?B?OHZiY2xlVTVuU00wbEp0clZUWVUzR0F4Wkdqenk2MFl6QWw1ODd2N1d2V0dX?=
 =?utf-8?B?M1pVQ0pjeXpSbGRyRGNvN2dsMWRveHNUMnoyUWFSVEJRMEpRN0w1bmZ3WWY5?=
 =?utf-8?B?SHJPaUNFaEQvcGRjS3hMT1RyUnlheEo1enZzOWJyc2x2akNBR0V5Y0kyY0hr?=
 =?utf-8?B?aUlvalJwU3ZjSC8wcUZOcGNjZHdrS0J4cWZZYlYrVXljT09ZdytKZENSeVVT?=
 =?utf-8?B?T1RzL2JkeDl4eEFQemY3dGR4c3dOMHo5OVJ5bDdTT2VOK0U4eXFPRndZTjZN?=
 =?utf-8?B?OUFOTmtTTjhqYW92VklzOElwTVhSMWNOeG9xeldObndUR0NRVFcxNGVPWFJa?=
 =?utf-8?B?UVVzRXpPWGRFbXp1MlJaUTM1U0UxSUtLd2NwK2xyVFFROWhKWkRhaEIwbzZI?=
 =?utf-8?B?LzRqWHFFbWNlaC96d25kUU5uRWhDVWY2bG9XelFGVDN0bnFlY3JGcW9reXpG?=
 =?utf-8?B?MXBhdGpkTTBMU0wwbmlSdjlUNnZQYVZEWHJoOWlYcW1iczdoYVB3dEhvNDZG?=
 =?utf-8?B?aGU2eHpsZHRYK2plM013cnNMdzlmYTZPQlNiOEY1T3lwdG15RGwybHNjVDBK?=
 =?utf-8?B?QXZwdnFTQWdRakNvbEs1bHI0Qm1RTmdDaHlKOU9uUHpCVHZVRjRmODRSaHEr?=
 =?utf-8?B?S1RqNy9RbzVOdmkrTEVGQXJnR21XeFBUL0dySGVJRDAvY3BodFRQR21kSVZy?=
 =?utf-8?B?Q1ZSZk9wVTlid3Jzb0lyZlNNWGFBMUhmRnhrN2ZuM3UwaUxob2diSW9tTTVN?=
 =?utf-8?B?U0FBSWpTZVJoeGJaNkJwSWdkQXAwU0pDZVo3Z1JjYzgyZ2I3SnA2S1hlVVNZ?=
 =?utf-8?B?WUFDZFppOHQzMHlLRWVMK1dQdXdZWTFSWVVrOHNXaXB0Sy81c01GanJFZFpj?=
 =?utf-8?B?NnpvS0FTelh5WjQyQnh0UG9RSkZUcXpXUnA1eVNNK281bWxRdFY2dWoya2NN?=
 =?utf-8?B?amtHd3p3cmE3NFhreDZRVVpVcTcyaGdlcjk1eFVHSzQyaTkxNEdmNDVGVThH?=
 =?utf-8?B?YTZGOFBDWVVYdlh5MGhzR1lRenFWNG42OHYwT3FpdFh1SVFKVU0zeWFxSGNG?=
 =?utf-8?Q?qyhM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGtJanBzSm4wc0NoQjhSaW5Fa1c5eEtJR0ZOSkNYajZzNVR0VmFtUXIybnlx?=
 =?utf-8?B?MnFlN1lZeHkyL1lMTXY2Z1hiK09uMHhHdXp1MnhpdXJmMER2WlFJd1YzQUsv?=
 =?utf-8?B?NVdwR2Yya241bEFadzdRai9BWk9ZL0hESmxBL2RHWFN5QU1KeGlGWWM0cGt3?=
 =?utf-8?B?ODZsZHBvSUV2RXlLVEpnb3RaeUZGMkt2dlZHa0E1aDRZSmxhZFhRZEc0QW95?=
 =?utf-8?B?MEpsdnFoRVlveE9yWENKdStPR2k2N0ZrRHJXSWZ2MnlDVldEUHRucTI0R2Vp?=
 =?utf-8?B?VGNDWm1QL2FhY25XVGR0Q3Y1eFVzd2kzVkg4V0puamxEM2ZRNVhzdHhnNGM2?=
 =?utf-8?B?bExuV0FlNUs1N1R1dGVUZzVMdk0xV0o0UmNsc2hsc1NrZjMwRmI1WkdIZlhp?=
 =?utf-8?B?Smx4WlRBWThsMWpEeXhJVGtlNzVWdHJzN0hIa1dmam5panhMZGpPbDZtQVJs?=
 =?utf-8?B?RmdCUkVJcXV3ZVlvVE1rdXM3TVFOQzI1a2ZGYisxakk0bTlQTnRxV2RxeENH?=
 =?utf-8?B?VHF1clg3WGJrQmFBUm9BWXpEbGlpVFJJVWtDazRIemNCdEdVbDRSakZJMXpy?=
 =?utf-8?B?alJFeFg3SWJOZGdzcEJ6V0hVeXhwd2dNZ3BIMVVJcStQNW40eHVOckRoeGlh?=
 =?utf-8?B?czNWM0d3V0hkeWplMVFjWFp1dmJYT28xMmswNGJpTVNIcHpYd1hqNVVWamx1?=
 =?utf-8?B?ZENadWkvdkZTdmlBdEpiWFBESVl4K0RRbkkreHNVWjJNQ0xzRnRwVWxRMXFv?=
 =?utf-8?B?K0hSWVFvcEMzTXcyTlppRTJNcDNSNisyYS9zSEV1ZGR1NTBBaGwrckcyM2tI?=
 =?utf-8?B?aExEMDlZaHlWS1JZczNHTVJFdlc1bFI5MXF6WmF5S3BtVXhSZmd3Qm1nTE0y?=
 =?utf-8?B?cm5uaURGVHZsSURIZ2FDKzFXSkluY3I5ek9nRG90ODUra1ozNDI5RXhUL1Z2?=
 =?utf-8?B?dVdTdnhST0pHZk5QaFc0MmVWcy9yZWk2aEZlUGRvOERiREcrU3creTUxcjRO?=
 =?utf-8?B?VW80TW9lU1pySUhnR25jdVhOK21oZHdReTRCdm92TGJTK0JxeVRkTUgxRk1r?=
 =?utf-8?B?Y0tiL0x4blhiT2NJYW1YbzdQaC9zUFZ6d2pCbEFWeTBPSDdrZ25EaU4xNm5v?=
 =?utf-8?B?Q0F4VmNSd0ZlekE2NWNEUzdpRkduaUR3UnlyTitpRlk2enE4ZlEyWm96MTEz?=
 =?utf-8?B?VVNmWW1XdS8wS21MMThQNlZnaHF2TXZ6K0NVVlVOWHJ6OEpQVXZ1SnloQmJC?=
 =?utf-8?B?SUFVUXpXZFBodjR5OHMzR3NHUzRvS3BOTnBtS3A0dCtTbmVQcGlpNzVRUEFD?=
 =?utf-8?B?UUNRUmpHSHRzU2xnRjhUbEdmOFYwaXoxVlNmWmdibE9GMU5mOG5zTGdIWjRr?=
 =?utf-8?B?TXZxYmRSMkluRzl2bFkvRkNjeG1GbFpUeXl2YnNQMWtyOXo3c09pa2xlWE80?=
 =?utf-8?B?R1B6SzUxZFVwSmJYSVVpTWVzZjlGamhOdVZ6OFR1ckJHcGFmcjJuSEhBV09w?=
 =?utf-8?B?M0pVeFN4elpEUkxoSnZGSHJ0VXhhcVBEMWJZYnBOWlUrUlZJajA5bzR5VmFL?=
 =?utf-8?B?SE5KS2R1Y2x4OEhIWUN3QjBkQjJ1RzhhSjFaYkpCVGZVc09lZFdqeXd4dmda?=
 =?utf-8?B?bVFnbXpkMSs5eTF3U0FrYVpScitPYVIyZHREUlV1ZTkvOGJ1K0RybUlCWndr?=
 =?utf-8?B?bGJyZkxlM2lZejlwaXBOL1V0WmRNK0xjTEc2ZVNUdUlLZCt0RXpmUitkWlZH?=
 =?utf-8?B?aS80MFh5alNVSnFSd3RodkpYUkUzaFFrR1pqNnZGd3NvRGJSQVpRWVE3dENh?=
 =?utf-8?B?WW12cVdsNUsyVGpTTTFISm1hcUM3c3llcFJncHBMWEg1Vk95S0ttMVJNYkhh?=
 =?utf-8?B?aEd4dDhXQ3I1YWdwaWdLK21GdUs0aEhaYzMzTGJkVTU0UW1jZmFiVCtsTm93?=
 =?utf-8?B?V0JPVUZoV2RXRmlpRUdFRHlidVZoSzh0Z3A0b0NpWVBDUTAzQkN2aGZIUmtO?=
 =?utf-8?B?Mlh1UTBkanpBa0lZOVMzdFptOXFpZzZYTXVZVE95aEFlU2JRVUpFMEpWNHJi?=
 =?utf-8?B?VHNKSjFxRmVJaWc2cUdJazV5K0UrUW54c2Y1ZzRNcUcvNlNLSGgxMjk5NGw0?=
 =?utf-8?B?SG1qTDVKc1BwT0k0RzF1SkM0d291ditVcjd5SGc1MDQyK1JEU3NETnN5R3JU?=
 =?utf-8?B?RnBjcDV3dHdDK0E5L2VHa3RyRXgreVRSWTBDODF3akJwamRHS3A0OGE0OExY?=
 =?utf-8?B?QlhTSWRQK2FhdTZDUXd3VEVNcm9sYVhPelVDc1BtVjFTSDVzejIxVmdHOVow?=
 =?utf-8?B?Sm0vekowMkZKeC9Ib0p4VVloS0U1YWFvazBnVlJLRlYzVnh2cS8wZnV5dGpX?=
 =?utf-8?Q?Op2l2mlKoHjExl9I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3e5ca9-9274-433f-f43a-08de6d517904
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 11:49:42.4591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iJ7pcuwmfkXkeXzoOZNnRT+lsMjnS1CvOhz/CHgnUJ3XRUXJxDEUfj2gywRsShGFqYjrzZWrNZ1BdCn0yrMOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7936

On 16.02.26 09:16, Clara Kowalsky wrote:
> The libevl next branch triggers a pipeline in xenomai-images in
> combination with all available kernels (6.1, 6.12 and head). The
> physical targets are built for all kernels, the QEMU targets just for
> the head.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  ci/trigger/libevl.yml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
> index bbd4e13..ece5f06 100644
> --- a/ci/trigger/libevl.yml
> +++ b/ci/trigger/libevl.yml
> @@ -18,9 +18,7 @@ stages:
>  trigger-xenomai-images:
>    stage: trigger_xenomai_images
>    variables:
> -    ONLY_RUN: xenomai-4/evl
> -    KERNEL_VERSION: head
> -    KERNEL_VERSION_WITH_QEMU: head
> +    ONLY_RUN: xenomai-4/${CI_COMMIT_BRANCH}
>    trigger:
>      project: xenomai/xenomai-images
>      branch: next

Thanks, both applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

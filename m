Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CB61CAB3
	for <xenomai@lists.linux.dev>; Fri,  9 Jan 2026 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962510; cv=fail; b=OaF3ozcaHccYOCBLAsCdMoERiI9VkyPrbfWf0KNw7Nr1bYl5wBr+uZ/BMZfyBm1FPz1YpWaaqv35Nb7xfP7l0qBEvjdiHPMfDVCHc3g7+nllzHDGC+wDV1vbFyTLHbtlXkhVk9gahsF8Ui4cKGdOm1mcZIcEgvrM75ZPhO0EhiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962510; c=relaxed/simple;
	bh=AZ7eir5kVn8uaqTWXDs6dfcpp3lKFxzavx2b8TmKxGY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AhC36PLhrAhbeUl1q7jv+iJHDK8eK7A0pDN2420AMMF7R0BdmY2RwJnPWBZKIfaZRfGIyNJq+DEEzH/6teH5U50HiFENq/bA0MZbrksIakPWYyfiNpeAIzoWWEu6WGizZq+GRIDc8jRGL0gurFGNmE+Fj6ivpymIBsfDubmcqks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lQHKv6rj; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lQHKv6rj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxf8AxshAVeYgAlXeMPPDzCk0mLpjiolwAC/KnhF3Ctc0Y2v6kTxArg8cjQXyLwQITVhoobhIHqPIjvl9Mtsuq3qH2iyxdYq+NzujdhqaI1BikU9346YyuVA/L3W8iqFa/oirhsYyWuuS2fbNNI4f4nmUGBEr6+RKRrerXr0S11bKW+7fEgJoBTju2MyqCfW9+CX+nA/x4mrOz2gVIgFCYaZGKRjUXWepzSliMvXlS7PVo/UFh+N775oMI29JPfXeQy7QN+E2d9b4LMw4SAet9iXAgoBLKv1WtUmr2EPooNZTAXx7LDVA+PSUGt+eJ+sVBh12pCE3LGZu2Z4x1yEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Wv5M35CBZsqASwDeHPk3IYeHPY2UFNM66uO5orBq0I=;
 b=UCBtycaOgkErhstyflt8pKFljSROoNzQr6OG+8FV9asPy3227Pnvxzw01BvSSwfHOnmyqY6nRO7o2v0BQYvjy0j012YHCCKh4zkVMuAiWaHAtBKETbfPFaduuCmNXexIJKt7YAwjAKsZVktkYm1/4JWPSsOS9IdOrA/ucOtxAmFvEPTaAgiU3pXIVG0AE14q82Qgq4PgyFH7NiTgI2OKj+Ec+X8YVrwRfemoQZeGwF/EWwhFP+FiywmexeePp4PEu5bVQjOVY7bIXfVfkt2ti6yjHZ528Ei0HXgn6RFConnzRE5Kn6GQNqKK9QAyR+xQ2qJ3g4RgYkNHW6Cei3m/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Wv5M35CBZsqASwDeHPk3IYeHPY2UFNM66uO5orBq0I=;
 b=lQHKv6rjY1a9EIumjG6RWr5QCP3rPuSXxDJMDJtgUYpGZP80o6s7X94AuXeQ7IRcL/5C09/wCSqmafzs+0fhFA0tQRzEB4E4K22qzVEfIG+0mpy+YxpSKYDwqyPMStFIztpGqDUTZJfyUPf7rL02XxtEWCNhVti68sSY/kwqp90y2XUpEWcA9bEVuBPksYNvx5o+LH9RL5MUcgiT3lb+vUx2uSsaYxzAdMRbkBYLlnD7pUcLXQvxQgcNrx62QE6E2SEdKrXN3SeSsQgO1iWegpWGAA3PCIZxthX2R+yoJnM0zWL7pyRM2jbttUllrv54XK/nRZWE0xBUmUUv3dr6KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6450.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 12:41:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 12:41:46 +0000
Message-ID: <60abbb7f-6f56-4ba9-9830-e492a9ae109c@siemens.com>
Date: Fri, 9 Jan 2026 13:41:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images] libevl: Don't install UAPI headers
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20260109122511.778599-1-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260109122511.778599-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c205365-a076-44fb-f291-08de4f7c731e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZERTY0d6S0E3UUs2NEdqMUpwRkZnQmtmVGRydjNhQ3puNkEwYVczazhHdjhV?=
 =?utf-8?B?NXVHREhpRzdUWTdXQVBTc0hNNGZPTWdLL21XS1dGbVdPTDZnUElvVDlOQ0pX?=
 =?utf-8?B?MUdxRjVETEc5M2pNb2RkMGhRcjlnNDJycUc0ZW12Q2FnUlE4K3FjQUJ6bXh1?=
 =?utf-8?B?WXBhMlg4bjAvYldTaFBVQkE1ZmY2UnFseU85akNxVVVrUXRRTnhvYWNvYitH?=
 =?utf-8?B?dDROZ3lydGkvb1BWQWVEYUNxSE83bzBkUml2Q2lmU3R0UCtjTjUwbWRyYjJk?=
 =?utf-8?B?dG4zT3BNelJKYjVqTW85bEhyUlAwQi9aUlFhUHNIZ3Y2S1JORzBRTW9TNG1j?=
 =?utf-8?B?K1EvTlRNaUZoMDlQdGFhQ0QzSEdmSzg5Q1NUSFVPSmx2Q0lwMkJSVVo1dFQv?=
 =?utf-8?B?T0NPc0NOY3ZwUUlvM2p4RjU4QlNIZ1FZak80eXhSTFE3NFNEVXpSVTVSNm9Q?=
 =?utf-8?B?dDZQdDVNZlhXR2RzeHBZVzYwbWU0RktDcTJPQk1jQVNuRnNGdDhvSmxweXFp?=
 =?utf-8?B?QTNrcVl0ZkhVOFJ4d29RVGVCN1gxeEZxT254MkcrbnRGaUNiZEpoaVRjeXJm?=
 =?utf-8?B?Z1psai9hK1psMzFQU2F1WmVkczEwWGZtQnJEdTVyUVg1RUN1OUM4QkZ3VWhz?=
 =?utf-8?B?elk3cC9tbk1vYUorRHduTURaYWxTYVM4TzhxUDlEOFRFUFE3YmpHYjE0K1g0?=
 =?utf-8?B?Wmx5SFR3YlJFNGp5ZENpSG1EOWpJaG95VHVBQ2F3OHM0WENmcFBLWUw0ZXpF?=
 =?utf-8?B?TlpkMS9DUmp0WkRwQWgwY2wrMWtuRzVza0l3Ti9OTVJCV085S3VaU0MrSTNE?=
 =?utf-8?B?Z2VtbkRMR1JyZ0tsamZLTEpLeXZWZ1JwS1ZBTlJNUTRxOTFmdnh1bUhuT0ZL?=
 =?utf-8?B?L1pQQkxMQTFWNzEvMk5aKzdZOVgxaERyRytjaldTOGxIWVFMcXR6UGpLenlG?=
 =?utf-8?B?Q1orMzI1dURHNDBXZStrcnBxOHNKSHZ3d0NlZm5NV3MzMmtnRkg3SHpVT016?=
 =?utf-8?B?NncyOEZTSDNRak15S2VmQ0N1aTR4Tlg1MFhXTWJlTVNGZEtGR09QZnIzK3d6?=
 =?utf-8?B?anU1UWovMU51UG5TUG55TFV0TlFDRXczNkNERm9DWit1WnByTndISG5IRk9l?=
 =?utf-8?B?WUpaRzA2Zk5wb1lJeWhsSEplN0JHZUJvZ3pSWmkzeGM1MnRUREdsMU9nYWtQ?=
 =?utf-8?B?eHNDbXJZRUpXYUl6bDhlRDdGQVJSOEtFOWNlSjE2ZFp5MW1lY2puU2ozL3RF?=
 =?utf-8?B?cmt0QysrdUx4dnUwVE0vZmVxSVQ1UUZLN3JIbExnTmczUVhnVnVKNnkxTFFx?=
 =?utf-8?B?L0xOaGdzbnZLWC9yTndLUWwxLzg4ZlRRQ0ZneGp2T0tmN1NKN1JJaEZXaWFG?=
 =?utf-8?B?ZDM2Q05DQW9RZmdjVzJHTWxiaEJkOWRSMTE5Q3NQOHhDbjVUYWFLOEtSVmIx?=
 =?utf-8?B?cThOemUvQkJmVlFpZk1ZZHJ4ZTFrV3JDRDV6QXk4WkNHbUxnM1ZsWlltMWFL?=
 =?utf-8?B?WFRXVDdJajVDUmJTSk1TS2hpREhPN3FVOXF0WTE0ZC9FdE05ZW1KWGh6V1Nt?=
 =?utf-8?B?Mkh4TGZidEJZU0hlMkNqSGdGbXFlU0pLamxOSlBSemJNbSs3YjJ3UnRHd1h2?=
 =?utf-8?B?V1AvYkNNWUdOSE0rWlFBcVkrUld3TEZUd2pQY2tOSkdNemFOb0NiUmFsQm1j?=
 =?utf-8?B?MDQvOEJXSnF4ZVRaWmJJazJBUkgwQ3VJWHE0YS8xL3RndmtINGo0ZmwycW5z?=
 =?utf-8?B?eEpBdVhVRFU3a3FJYVcrSW13dlZScXUzOElEZzhvOXVSS2FvK2p4d1hRK2Q1?=
 =?utf-8?B?M2tnNVNiS3ltb29LWDVYZ2ZxSjgwRjhlVFN0T05WSU5DYWpsb3c0ZUhHcGt4?=
 =?utf-8?B?N01qSmxkYTUyeGNZYUdYR0RERWJiUVNaMjZtSDh1cGpjekxkWHNXL1JCekc2?=
 =?utf-8?Q?hCBYr3w3zVY65H9ecxQATz866rNIiRax?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnd6Sy83eGxEbEVWalBKeXpqV0d0VzJDelIyVW1RM0dFNGNFSmc0aE5JWkhZ?=
 =?utf-8?B?VHIvK25UM3ZYN01LUUw3WnlCd0sxUVluRnNWWmN6QUJKdTdoL1V3WndqUHNq?=
 =?utf-8?B?MS8ydEw0ckJxRWpiNU1meVB5eFlKTmxnbjY3OU02WGlSMEtxMXAxWUVZSnNJ?=
 =?utf-8?B?THN2NFpJT0VUL2VDVFhaYjFNc1VvMi8zaE1WZUpqakpnQjdzNHllMm1BU1Rv?=
 =?utf-8?B?VlVzWm1JdlhQT1J1OUYzVFRZVHljTmdKaW1QaE5Ka1U0Q1U2UUEzOGJvV09Q?=
 =?utf-8?B?SDVyRnZ0cU51alVJcjY2WlM4Ri9nemlZNkVmUkROVWYvOForMElnb2c4cnhw?=
 =?utf-8?B?cmNCUkhIRWYrMDdwelczZjd2alF2Zkg2V3crRDVxSFVMbkhIQk9GTS9aMVlk?=
 =?utf-8?B?N1V0VXBGSW5RbldxMHY2T1FyelF3UjZnTDR0dDVEZHF3TFNxbGl5SEtLTTNW?=
 =?utf-8?B?QmY5RHF2MEVrR0lJSGNjTWRNK0N1a0FXclRteWM3Sm8rYW9mNUlweWRWb3V5?=
 =?utf-8?B?VWd4R21vMXllZFRQb25weUhWOGxWTnU4eStoM0RNRVZYcmJkVnI5a1JGWWNL?=
 =?utf-8?B?WE5UZUVRU0pXWDNtWUMrcTgzTTlNN0JZMytBZ3F1VE9iQkwyMWJoS3lQQWJy?=
 =?utf-8?B?TkVpVVM2ajRQSENQaTRnUTh4b01BbVlxRnNqUjBqLytIY2RGVkxkVjJPS1Ju?=
 =?utf-8?B?YndnSnRFZHdSZDdiV1RTbHV0VlEzd2FTd3dRTHhSYitNeFlxaEhQSG95THdE?=
 =?utf-8?B?RGIyTzJ6L3FTTFV1UUpjRzROOU5ldDlYWjZudWM3c0tLcTVETkNYMEdhWWpm?=
 =?utf-8?B?aEFyc1QxOTIwalRWMGFYdjJZdG14UTdkaXhPMXhLNEZOc3BDKytrOVY1V1ZF?=
 =?utf-8?B?YkhxVXpKdjFMZGF4Mkx4ZWdNb3crV3BGZk1mbzJOU3M4bERDeW5tMlY2RDly?=
 =?utf-8?B?UlJKMDFnTlpocXlieXl5bmlGcnMvc0dEK0RLZHR3MWNRVFFSY2dmT0IxOVRz?=
 =?utf-8?B?UVpiMENNOTdnSEJyZ1FLblZBK3ZhWkV6ck9ESVpMTXlSenllc0tad0R6SU9F?=
 =?utf-8?B?TUlyRHQ4c1R0ZDNxbVVUdXBEekpuOVQzZzNwanFvTWlybktDUzZMcGRobDh3?=
 =?utf-8?B?T3Ezdk01L1RIQ3U2c1RaRzROR082bk9abGtDTG0rN2N2cHFMQzBSRi9wdERI?=
 =?utf-8?B?emJNVEV3RkNIVXZvOHJxbDdoWmxqdlA3bXBtR2M0ejVoak9HSjlkTm5OcTJo?=
 =?utf-8?B?K2k5WWI2RUpCUVhSbG1ac2srNkZIUGwrY3hyOXZPa2N2RUtMN2ZFMkhtY0VD?=
 =?utf-8?B?YzJoMkFEMURSRE0wUFp4U0R1blNhOS9jRlB5Z1lQRGM1d0VaZWR6bjVjWnVk?=
 =?utf-8?B?cU54N3hLL2FvMnd3d29nQ3NnNDBTQU9EOFJDaTNNdElHTlovbkxJS1ZyNzRN?=
 =?utf-8?B?VEYrME9aaU9EdW5odUdaQm95QXRiTTFDelozUWdXTllEMXhvVlMwTFgxV3BC?=
 =?utf-8?B?ZHZaOG15NjVXeTlKRFR5VHhKeFk0TTI3K2gyZVFxNlh5QzEybzhPbmxrdkR0?=
 =?utf-8?B?ZlNaRkpZeFMvODE5Rm93bmQrZ1JCU1p2SjA2bUdvMXliblBOaG5uSUVwM3BR?=
 =?utf-8?B?UG51TFdOOXh6RSsyejN3LzNqNWtCS1pqeFh4akozazAwU29seGY5N1ZZblVZ?=
 =?utf-8?B?TUZ5NDF4ZFRYQ1JENmMyY2k1QWhyWFVYYjhPU3FLczB2ZXRiT1k2Y1pYQksr?=
 =?utf-8?B?dVNHd0cyOG8vc2MyY01hOExrS2MvN3NrMzFCUGxrNEYzRlJvL0hZUmlPZmZV?=
 =?utf-8?B?RE1MSHlxRDliTzduNFROZWI2R0dxRGpGMmViSVBKdlhtZ2JWcVYvMFlvMm5s?=
 =?utf-8?B?RCtUTmpUUjRNaXo5ajBiT2JwdGNwNnBzU1UrRVBrUHIxRnVvZ2V1MTJUNi9m?=
 =?utf-8?B?bmN3eTVtMktPYlc1LzZLKzNOTi83VURDbGdLWnNjSlZGZlpSVHZqWE9ZU3p3?=
 =?utf-8?B?czlMMzRBdG12VXNXRng3czZ5S3ZnZkw4NGFOMCtTWnpvOStxdFNmWGZxRXVT?=
 =?utf-8?B?VVN6NGNWWGZOTGZWRm5lNGlIZTErUWQ5aGVtVDBncnlyVWE4WmJkeExuVW1Z?=
 =?utf-8?B?blllSGVhRHZJeWxsU3g3ZjRUeW1FZmF0U0tGZWt1ZlhVcFVvNzRGNmt2Nkdr?=
 =?utf-8?B?WU85TXNOU041TjhGMCtGcldYWnZIYVVzWXZhMEh2dEwrN2xiZ3BESXUxM2x3?=
 =?utf-8?B?S1ZncVVpcFBXSHNZckk2RUowenZRZHNFZ0M2UnltZ3BRK2xoUEtwVHVjbUhx?=
 =?utf-8?B?bEdycnJwR0dGUEV1dllkVjRkK1QyY2pkM215ZFQ1bEY5c3ZTWDVSdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c205365-a076-44fb-f291-08de4f7c731e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:41:46.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t85KxtgB7T9KoMw6unqU6PRYXznyP28Lgn3Cq/lG3kx+937Dw5QV/uqmIqT2PfcyPALaoYdswSPQ5V+w/DT7DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6450

On 09.01.26 13:25, Tobias Schaffner wrote:
> Commit 084c3253d741fc9022a0169ab9ad95f7f943add8 changed the default for
> libevl UAPI header installation to true.
> 
> linux-xenomai-4 already provides the EVL UAPI headers via
> KERNEL_LIBC_DEV_DEPLOY. Installing them from libevl as well causes
> conflicts.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  recipes-xenomai/libevl/files/debian/rules | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
> index 9c9148f..07c28b9 100755
> --- a/recipes-xenomai/libevl/files/debian/rules
> +++ b/recipes-xenomai/libevl/files/debian/rules
> @@ -13,7 +13,7 @@ override_dh_fixperms:
>  	dh_fixperms
>  
>  override_dh_auto_configure:
> -	dh_auto_configure -- -Duapi=$(UAPI)
> +	dh_auto_configure -- -Duapi=$(UAPI) -Dinstall-uapi=false
>  
>  %:
>  	dh $@ --buildsystem=meson

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

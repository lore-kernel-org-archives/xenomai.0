Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013015.outbound.protection.outlook.com [40.107.162.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE33587DE
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223506; cv=fail; b=cmsr94OdpW+whXEw4aMQTE5LoqHlzgTf4Yfsyhm7KqTAhqrgnbjBhYVgb/XFBoBqrTkoTt70lmcVyEMmvTKU8eHfomQ/5AmZXBeUtQB87KoDXpGodGOrBIc7UibmMyipvNIDkQe5FtGtaXYDGxeT7UHfIsBb7mETc+GSrVmIWa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223506; c=relaxed/simple;
	bh=dLbkAoOdoDxXmAXTn62y3sg1FSIlmXfioOJbZnLdllM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U8vTW4i9vKRESOupeqVNQEabMuFBawpDhm94uaNkbMkeikBZ0z2JqpMqbG+RGD1Gr9HhAZNJ2CrFxCp15YyrXgNa/yHEm9SIlD2anzeHgIZ3muzy5gZEzvT//CHhS92ogLKFDPbCl2ANtOk4jok67/nH5AGUQFEXwjXek6kzXtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MddpvOB/; arc=fail smtp.client-ip=40.107.162.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MddpvOB/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEb8oNADNkJe+LThcx/6AiIljr1nOj4Brai4+kthr7gHTn6cR2Rv98VslaiNjtKFvehLhYrxYoI7gz4Ob/itKp/pkL6WOWss+pEqqduQpcv2lhSZE2usslF3yQR+i00zq9Ys0J/mMpnsG+GIdQbii/rKKzmL6a40QE5wC2GpI0uprToY/8g6iwk2+LIszNx5O25wCDZHpSuhMZAaMvXbTGV3OwUZaa4iSGO42o2k31ob418OeWguoWbvV3a2xy21VisE+dp2QEKlEQTKrZlImq5AWyGmzlet28miRg8BDolih2X4bRSsb2RTVN+IOllcdiS3UaSZRaLfkg01pteguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDGYYFnI8/KnQuKgUdG1DYJAg+jRfsMdcWrfLvbTO2M=;
 b=nB63LW9JFEMnr55HWWH1S7VzS9dSJjLYkSvCmKSmN9Dx3wA9s3boF3IM5qsW8OMdvNbOg2Ca5R54jQmyifsj+XXK3GS81gNY8b2/AnARs0QYf6Nn49PBib08b8C6m7SqAfU9FQShDnzYXaKMLo2YAsXSfHFTNwXh6eIKOhiqUR5I6Pz5xxF1bfZXL0Ci94M7pWdVwAfFQd4UXgF4Zw7Uc/il5yb01hGJyIzRMEML4hUzU7Ai1Q5MFZdTVj+a1R8vu81GmdxfxEjql0XQ4gCTfkGYi7TFiYipMcdT6/qK4p5IjojUhvvHrzgR3dK46Nudovr8iZA6GBEeccXjv5AVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDGYYFnI8/KnQuKgUdG1DYJAg+jRfsMdcWrfLvbTO2M=;
 b=MddpvOB/VcUP1BTjds/1QxrF39An+MnKXqPfJQQRSrrM+3nbKFQJosuRh1rumIV7ZlTy6Frp9mGmGlxwaWWEu0WVRh+UZdyzK19s99n68ggWjpzRpshKE6WlMUxCwwiOHhAJ55Q/hwTInQkEBp/m4ZXQ5offCpEXhA5jZyQzgr4gnNyUH+xfFnbIPfOsM1Ji8/ZAIqnyD6hXWOVM66HHnZ5WyYIE1h5txLuSHV873J7y/lq5nm+k0I687el8le+K0c2/Bh6IaRDTkkRHFe4HNR0tErHolkBppFNBuxSKxsZQaOf2x+GhIaBczkYNXjPF9fW9Q0Ba3PYqEOcX6DGUtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 13:11:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 13:11:39 +0000
Message-ID: <6648e0df-6b8f-4cac-b050-90e961d1cc49@siemens.com>
Date: Mon, 12 Jan 2026 14:11:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 0/3] Trigger CI job for dovetail
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3947:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ef5073-450a-4b0e-9254-08de51dc1f69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3F4N3F6QTR3amNQT3lzYks4YXRNQ2hOODlFc3BhVG5JdlVZbDE4ZDNLR0lj?=
 =?utf-8?B?Y0F3aFhVTXZQMFJQNjJLbWFOVnh6ZXUycUtLa1ozNytoeHcyeXRDTDcrQjZp?=
 =?utf-8?B?Zml0ZHNIQ0ljMlFuUHpYNHBQSnlzTGZMQWo4YklmWktJYVRuTkVqOFdTeTVN?=
 =?utf-8?B?NjQrbDVXOVVSTkFiWDN0dGE1UTUvYkU4a0hmZzU1VHY1TzUya0xST2NTc0F2?=
 =?utf-8?B?SE1pU0FvQ21LVUJIUnRuV1A0UzQ1OEkxblFJMWJiUmlBT3ZpSGlTNG8wNUlj?=
 =?utf-8?B?dktqcmFpK0l5M0REcUYxODFnQVp0TnhkQTBnRWRoaEhab0prSy9oUWNnajh3?=
 =?utf-8?B?OWMxUGNoamlvalNtWVQ0ak5icERmWVYwVHRGVFN6T1ptVTlHak5GeTNFWUFG?=
 =?utf-8?B?c3lJUisvMWxaSksvVjBwMlNDQno3MURNL2w0VzAwcytDS1hJZjVTL3RINFN2?=
 =?utf-8?B?bGYvVjIyVXlIckcrbGZrNWIrQWRyaGdDS2htQVRxNzg0ZmxsMFJCU1BkMXh4?=
 =?utf-8?B?SDNiNnl3TFJVTTlTdlBiV29TVU9JMG9uTHVDckVYcy9WaC9zalN2YjNpUmRa?=
 =?utf-8?B?YWRPVDNtR3B6WFl6clhuY3RlSEIwOGdFTjlac1JLRlF3THNwcGI3WXVSZTA2?=
 =?utf-8?B?c2xGM056RTIzWUx1T3pYdTkwUjNaTlNTcVJMeWtPU0JKdEdVUzI2REtXM2h6?=
 =?utf-8?B?dlMvUmlrWmxkUmdNUUlYR1VJczlVb3NPOWJUUUg0YjByMDV2TjI1bmRFWmhC?=
 =?utf-8?B?WFBQeThxSG9mL1hnait1ZVlnWVplNzJQREcxM1dpMEZjZmVvS3NDMStvVUlD?=
 =?utf-8?B?bTUxUTRKMnAvRmY0YnVLczFDbFQ0MzRqdzU2NG9zK01ZQ2hIOVZMWjZkVDVL?=
 =?utf-8?B?MCt3NWRUMFVpNUVndXA3NDBQR1Fvd0p6enUvdXZsM2JhcGtVMGVUMkYwQVRF?=
 =?utf-8?B?b1o4UXFCYmNZUm5qWXBQZlpPS1pYa3Y1TENVWWM3NzlzUGlDQklYbFVucmI4?=
 =?utf-8?B?cndkdlJFQTZ0VFprTGs0Y2wvSFhTTUp4bmJ4UXduc0pYUDhTWm91b0FYcllJ?=
 =?utf-8?B?cEpyS1htSEJNUU90Nktsd0U4Y1ZIeUljeXN6VTg3S3owSFk1K29ETlJPRW04?=
 =?utf-8?B?ZUVvL2lSbk05QURkQWY1Q1JUZXNJUnprMHljM0hLUDVxdkRCZFVLT2FwWmtJ?=
 =?utf-8?B?bytGcytVSE5uaFFtTFhBcTQxeE1YN3E0WGRmYXl0c3VDUGdQZ1dUL2lTeCsy?=
 =?utf-8?B?N012L2dSOEtTTjc4R1Y4ZE8zSTd2ZjZZSENYSDRlVHptd3h2WDEwclJ4NU0z?=
 =?utf-8?B?TGdoQ3NEZmZ3dEcyZVhZS1o4OEdSQktIM2k2bzlySzFSYW9RTUVRWVV4eHVG?=
 =?utf-8?B?L3JBUlRVbk1yWFc1ajR3dzYyeTR5Qi82ejg4em1sbWZNcHp1RWN0ZHltM3FP?=
 =?utf-8?B?aVRyai9mOWsvTk9jRklGMmlzbEloTkFndWJRSmJJdFVUUHFLdnYyR0NFNTRT?=
 =?utf-8?B?S3BReEJLaElLTU9ua3RYdFNJMnFMSFZ5R0IveXEwb2xWMGhOT2t5YkhSOHZu?=
 =?utf-8?B?Y3VWaWIzT0YzVGFZN3gvRGZNNmV0RXBsZ0d4TW1YMmdkTDBlZ212ZVptYklu?=
 =?utf-8?B?VDJCNXIxMHg5M0ZLdGNvS0Irc3hoa2pEY0tXakV6ekZRRmxRNGVudTlvSUtH?=
 =?utf-8?B?UStLbEgwNzkzRnhqZUtuZkljSURlVlYvQUYvYUpNSFNUaDNQblZkbURWa1pL?=
 =?utf-8?B?bjdFUmowbFpIc256N1ZHNWNSMExOZGVtRU5DZTdTN1BYYWpxM0dHQ09Zb0oy?=
 =?utf-8?B?YmJOdVFrVGxxdWY3VWc4SUZPWVpXYTNiOTE4KzBwcFBkY25hbFhLKzFMSGxx?=
 =?utf-8?B?c0lOdXUvbkdWUVh3ZkFjQ3FibXZxVTlSSTc4eXp3THJhOTE5Y2w0cjdiNFMz?=
 =?utf-8?Q?8M0953DCOEqJ6tBMnyq6mCSzyN3McKz8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ri9qNU04MmUyemtCd241aUtMZ2t1dEhqbFJPMVl4Rm9OYkQwWUJhYmpxT1ZG?=
 =?utf-8?B?ZXduNWJDeEdxa3R1MHlFd3RtMzdyNWRZYitkL3JpSnZLdTlSWUw1UHZGSUFq?=
 =?utf-8?B?d2JSd2taWGY4ZHBubjZ1eHBmYVBEcVZ0b2F3aTJNb21zWlBBczUxNXJJdXpK?=
 =?utf-8?B?NXB2VFVMV1E0Q0JEOUpIcS9naWsva25NdHhoZW1BYzFvc1R0NlNSQlJ4YllO?=
 =?utf-8?B?bVdGNzJldlZMN1Rib1h0anVJemdQUjZkRXpwTllFLzRubEt6OTFJZFd4Yzlm?=
 =?utf-8?B?dXZaMGtXWW8vWHdPb2w1R3hKZlVlSTdPZXRBc00rcjlPQkFWQ3FNMjMyUzZw?=
 =?utf-8?B?Sm5vWllQS0UwMVRaSTZMMzZRYzBpVDU3eEU0RUxIaEkxdzBJaURnWE43V2p1?=
 =?utf-8?B?ZjMwWkExOVNXK3pQcVc1RnNxdGxrcU1ON002eGhCL3VsdXVPUHBYaDRwTy9I?=
 =?utf-8?B?M2c2RWJpR2d1TXE0dHV1akNiNDEybENTcGdEQ1p0cGI0T2hSOCtYNzBpbzAx?=
 =?utf-8?B?c0RkWEw4RnFEL1pqRjlNcmdycmpJOEl4KzhxclBVd200aStTUDlzQWNzVGtv?=
 =?utf-8?B?MHB6VjYyVnlWVDh4MWJoM2lHOURWRjFQWDJsVSt4TXMwZDNveU1SNUtRamlF?=
 =?utf-8?B?eWh6aE1qTjRHL0VINHhvM0FBSTRhQ2l5cVV5YUMzVzg1YWl4amh1bFdSTVJI?=
 =?utf-8?B?RllBdXBKWU15cGdMVHo4cHNvM1l4OXROWTNWSU5zWlpoVjkvWlVHK1Fsakc5?=
 =?utf-8?B?ZFZpemZzT3hMNFVmMXgxTUFDT1ZQTDB3Z0hWMTh1UXVsRGh4WXFaMDk3bFJs?=
 =?utf-8?B?R2hjMlJwaVhVdUp4WGtDRXkvQjZDcXhqOFpsQkZKaTV1SGxSYVJyUk5idTZz?=
 =?utf-8?B?RkRpM2NJeit4ZnQwdTB5L3J2Z0d1aERqWC9KWVY0bVEvWU8yV0FmNXk2OW84?=
 =?utf-8?B?djBGTmx1YlRCTE1DUjJxdTVBUHVUdVlKeHVDVTUxVk9uM2l2Q0Foc0xmWHl2?=
 =?utf-8?B?Z05SdWZDRS9qcVBMMk0rcXVBckJFTDE1MWsyOFA4N0FVNjJyWjBEbXFNMGFD?=
 =?utf-8?B?NjB3Mmt0ZWdWUEdtVXdpdTNFdTJteVB0NkRrenExbGRlbkF4VlJ6RXdMSDJs?=
 =?utf-8?B?MjRjWVBGdnNRejFUU2d6VmtPeDBlbDl1Tzc3VXdJZUVBK1Z3S043UmdBc2ll?=
 =?utf-8?B?VUpsblhlSk9CdU1ySERSZlhCSE54WnRtTTVGdnc3NEhHL1VIV3ljM2IrNHhr?=
 =?utf-8?B?TUxiN3UzZHd6SDlSMmI5WHUwNzVtMWFrcHQrVU9NMExRRWlBNUxlU1Q4R2dw?=
 =?utf-8?B?TTRjWWFqV3JPNDV3L2l5djNVVGplMEFabCtlUmduYkg3Q1BLMmQ0ZHZQZlM2?=
 =?utf-8?B?ZHpRUzVWOVpKRnlCZzhDVFJrYjdLYXZUYXVTSThsWkgxaVR6M05xbXRvSnZZ?=
 =?utf-8?B?R1VlTWtVZFFiUHE5Zi9QeFpnaGwySUpEc29nZ3dLbm8rY2VGcFFzY1hvTVhH?=
 =?utf-8?B?QnBTalNGd3R6dElWRzN1ZFQ3UVYwWEI1WHc4dmFyNTZWZCtydk9DOWthVk03?=
 =?utf-8?B?YmcyOTdrOFJoNTRmakFPWkkvRUxtL3A5RnNoNDBKMVFHbEJITXJ1NDhxUHB3?=
 =?utf-8?B?aXdrVVNDaFdlTXc2UTJ0ZnZMaTZIQjEwc3ZGbVp4LzJDYnpmWCtJNGtTVzZB?=
 =?utf-8?B?L29jeVR5OXpseVF0YmhXaG9wNFNIRHAxL1FWZXhSaHljNXg0dHFRNWplb1cy?=
 =?utf-8?B?bnBrM1hUUGZBSmR6QWpRekpSdGY1b29id0lYN1Uvbk8xeUU4dXZSck1iR0hy?=
 =?utf-8?B?NGxCUmwza0pIWHJvbkhSMnR1TFI5cHJTL2hBRVBXU09kTCtuM3NmT2VWTnI1?=
 =?utf-8?B?eHd1WkhaSnVQdVI4Q0dGOXFWS1psUktmZ1BGOXhhQTk3M0JmRDJIdVk5bnl6?=
 =?utf-8?B?dXovYVFwY3Z5QXBRa0NkTWZsU056aXRjTEVjMDAxR1BUUGFvN0ZMMzBxcW9t?=
 =?utf-8?B?czZOandWYnV5cHlZZ2pnY3VNOXFmdHloZXZ5Ny81S0FMMThlRmdMa2R1VENZ?=
 =?utf-8?B?eFc5UnhHd1lkZ0RtSWVvRDRPS0l0OUV5bkExRmY1NTFPNC9sV2QxOUNNWWxB?=
 =?utf-8?B?a1dTNkZ4bzg2RGNGc0w2dGhZZlpWQ09zd0FTdzJFTW5Eai8zQVgvbHBMUk1Y?=
 =?utf-8?B?Y2VQSlNvWFByNlIrTnBFcW9BSVNyK2RtemdUZ2hXc1FtSFNDNEZ5SnQ3cnUz?=
 =?utf-8?B?NHppdlNzU0FvZHRUYVFCdWFBNE9Mc2JtY2d1YjBWVGdZck1MVy8rOFpxUFEy?=
 =?utf-8?B?eE9tSzRHdEVMY05UQTA1YUdMc1czQy9VdUg2YTBHZFV2cjRvaFJhdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ef5073-450a-4b0e-9254-08de51dc1f69
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 13:11:39.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfItoCGIQZSlrEeNgWVf4VjtEWX5XhNqBkH000Vj4FJfPxoBR0CafCsRvZnW46gDZIvKs9mhTWligbJRJyB68w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3947

On 12.01.26 13:33, Clara Kowalsky wrote:
> Hi,
> 
> this adds the functionality that if new commits are pushed to dovetail,
> the corresponding kernel builds in xenomai-images are triggered.
> I tested this for dovetail/v6.12.y-dovetail-rebase and
> xenomai-images/next.
> Thanks Jan and Florian for your comments in v1.
> 
> Changes in v2:
> - removed 4.19 handling for now, as suggested
> - in ci/ci-dovetail.yml, add a comment that this file is configured as
>   CI/CD configuration file of the linux-dovetail repo
> - in ci/ci-dovetail.yml, use a debian:trixie-slim image
> - add commit to rename LATEST_KERNEL_VERSION to KERNEL_VERSION_WITH_QEMU
> - in ci/xenomai_3_dovetail.yml, sort kernel versions and rename
>   templates
> 
> There was also an issue that the QEMU jobs were not triggered in v1. 
> KERNEL_VERSION_WITH_QEMU is now set as pipeline variable, in order to
> make sure that the rules in the .build-qemu job are evaluated when
> having the variable info available (by setting KERNEL_VERSION_WITH_QEMU
> in a template previously, KERNEL_VERSION_WITH_QEMU in the .build-qemu
> job was still empty and the QEMU jobs were not triggered).
> 
> Changes in v3:
> - the v2 had my test branch in ci/ci-dovetail.yml
> 
> Best regards,
> Clara
> 
> Clara Kowalsky (3):
>   ci: replace LATEST_KERNEL_VERSION by KERNEL_VERSION_WITH_QEMU
>   ci: Add build job for pipeline triggered by linux-dovetail
>   ci: Add CI for linux-dovetail
> 
>  .gitlab-ci.yml                  |  8 ++++++
>  ci/ci-dovetail.yml              | 47 +++++++++++++++++++++++++++++++++
>  ci/gitlab-ci-base.yml           |  4 +--
>  ci/xenomai_3_3_x.yml            |  2 +-
>  ci/xenomai_3_dovetail.yml       | 39 +++++++++++++++++++++++++++
>  ci/xenomai_3_next.yml           |  2 +-
>  ci/xenomai_3_next_long_term.yml |  2 +-
>  ci/xenomai_4_next.yml           |  2 +-
>  8 files changed, 100 insertions(+), 6 deletions(-)
>  create mode 100644 ci/ci-dovetail.yml
>  create mode 100644 ci/xenomai_3_dovetail.yml
> 

Thanks, applied to next, and I will soon also configure linux-dovetail
accordingly. Let's give this some practical exposure.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

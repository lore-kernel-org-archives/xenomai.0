Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE25221FB8
	for <xenomai@lists.linux.dev>; Fri, 19 Dec 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135730; cv=fail; b=nd/NOGZzjad8o8+jxx7vQHW8idYuURC7faHvTIDU6tVqVj7p5jGAsBba5NWI/SOZPUqMmtU9BgfHJybYg2hKeM7oryC/m64g9jBpsNIa+WpFWQ2FqeeypfCtO+Ac/GsDXatCBYpOLEz0pLvCknJtaqRPVmlzFT0xJJi/zotCEBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135730; c=relaxed/simple;
	bh=k3+S6pTtWz6t+0mt/PS/fPrl0ohgfKT+58kkhTEnpwM=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=nJe3fF3mAeSwRAJUh407beBIc21ijEP6o0Cd73s58uaMEm4Tkg29i8NR36XFjFonL3iQ/UvW/XXqD1Zx2vc8FuYeuL2opuc2Z34t0Vg4457hZTLq6BWJL5BoL/hW/140Czhet+lMOe4mNQl/7nVQlLpofPbZZu3MCsINQ+VutqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yP/7JvX+; arc=fail smtp.client-ip=40.107.130.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yP/7JvX+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSvQ2AdUGhQCpG7JJZlMRJnECAja7Zg8KkXq8iS4u0czszrxBjQ30Wso3o3i6l8deJ0CLZTHE6rNHdWw2mNK5FtUB0Uh9kLUxbDaaOkX6l4dWqT/u/vN4RdoLBEaavGtNnIdQ5d1P1urIVg6IOZfhjgUqCK2J22sr9ul4EyMQbjSt96HqNd6g+EORRiEYjOn7h6H5yhi9y4vlmL4XYCoxw2b4e/XbjqgPpkMGWoYnrzMXZfFbizR30v+LFu3ci5xM8ISt8Rs34V3mdJ0mPQ1Hv8w5Mu9UCyuAy37HWYO0sueR645MtZn0zy6J+TNLGbH4E4DGuusg5T+Zdzq7q/YHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqAyINNg7zRh1B32ZHEd1q/DruwgQSiCN/QyoCQvcZQ=;
 b=L2tgCqsMzec/TTDTy94Xq80+7F8RuhbO+biat2ZdRaKT8/7se1JykVmcOmLN5SskdBpJ4xeD61ZewfID8U+kkkBc7rUr+OEZcDhbQyde5CGDlo9G1lpseCaj1vGj3U5Gnmyq3dMtd1pTDLuzpHuUEyIbJ+1omZvarpWFZzbbLeTTdUeH5Q9paHLlz54SP0b03II+SybOea7LkfX3NPSwGoK1jF0024ZVYW3lAy1WyS+QmaQHABkFUqkaaobK9j3t58TaROaM6jaF73XbWwbW+O20a2I7X3FTtI+d+caLYfruLy2Kh/a+UnwdUD2BAvCi1WT7m0egtvSA+qxLDhfABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqAyINNg7zRh1B32ZHEd1q/DruwgQSiCN/QyoCQvcZQ=;
 b=yP/7JvX+HFiQGNReSVWrrFXxl0NjjPfQE+zBDZ6rNau/MWArBfure8Ex+tvb6rKHezz8UstodEwXeFl0pKYPkL+SqanO8SLXJFOa0deYL+FAPF9nKlqja+C5iq9Jbp/t9iPoTfzkwHrSF+aWmPzJfWFaAnOCZS34EfHBk/xHBcaBt/HpHzNb1FyYfahhE3578THllT6HEdQvHxAPky0leI1q+gwT52G4gmLtYNvrSv8HJTWFbM/3gbi0d+C9dbMIIzi2hcicP76wrGJSbXbEAHWsJZXTYSb/0jooDM69G+moonCB01Ac83eZ5uzz69Gj6WCg9Q7FR9Qe2WgjQPjJmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Fri, 19 Dec
 2025 09:15:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9434.001; Fri, 19 Dec 2025
 09:15:25 +0000
Message-ID: <eff0a5e1-76b5-4037-a703-b42e214065f6@siemens.com>
Date: Fri, 19 Dec 2025 10:15:21 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] README: Drop reference to no longer existing arch READMEs
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0034.namprd18.prod.outlook.com
 (2603:10b6:610:55::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: f67d6567-574e-4ce4-f958-08de3edf24ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXZnOXpkdHZXQnRMbW1NMHAyM0VXMEpkeEx2MGdlTENPTENYeFVVYmVyZDVy?=
 =?utf-8?B?U2dydlpXa2pPZyt6Q2xTMWRmaXV4WkNZS1Rmb04zMDdIZnQxczdUTUhWb3hN?=
 =?utf-8?B?a29lcnJFQmxwRlR6UXRIaGZVdE5qOE5PcXFSSERUTHB5NDBiQ05wRExSdU52?=
 =?utf-8?B?OGlTSFlRT3RrNTVIbURFWTFJTjNFNWNrRE1rTlMvbEFadnJtRHVTRkxJOFdM?=
 =?utf-8?B?MzNTTWNZY3lOVTJnTlFqTXV6SFI0VVpFUm9LYzdGckFMRkZhYjZLVFduVGl2?=
 =?utf-8?B?d1hqb1dTVXk2bFhHc2xZM2tGUk50cmpQQmlPeWxXUkRIcS9pV2hDY3ozUXV5?=
 =?utf-8?B?RVVBQnRRUDh4M21BelhTOW1aYkpad243MFBOTzYwUitEQjVuMkN0N2M4Q0wr?=
 =?utf-8?B?aXVXWG9uL1c0RTM5OXJ0c0V4Q0VUUmxMbXF0WSs2dXdNUUljREVJQTE5VkFU?=
 =?utf-8?B?NVJTTm5ZWlBpRDRKbnAwb2JsKzdFa0lUcXEzb25GdHdXYzFIb1V6QmJQZVor?=
 =?utf-8?B?ZkF3VmE1aDF6TW5yWEQwUjJDRjVMdzhsWnNSc2tqWlo0ZFRBUUxaOW43VUZB?=
 =?utf-8?B?d0x3aE9QclROZXZySlVmQmsvU21BamZQT0Q5eC9wWHlFWFkyR1JrT0RSNUNC?=
 =?utf-8?B?ck5FV1BWOXR0V1JrWEpiREVMc0o1cFR6TzFQNXhVanJHUDlna043bjVwUDdi?=
 =?utf-8?B?NjlZZ0Njd3VRWGxvdDJKM2lFUnhDMjRsZXRVZERGaGlOVjhISk1iRjJqV1Va?=
 =?utf-8?B?RFlXODVOWXorRzFBWUkwamlXa0o4Ymo0YjRubVE5ZHZWTGxOaUh5UzlZTFIw?=
 =?utf-8?B?TWl4UWI4d2sybDAxazlmNHRhZVl0UWQ0YjFBVUtpWEJsYnpmdXZVZThyQkFv?=
 =?utf-8?B?RCtjM0poSGx5UklBWVJKc01qcGhFa0ljdXZBUG54eVBYMXJhUm1HK1VpSEVL?=
 =?utf-8?B?Smx6L2dhbDJxd2tFQUprZ0FWVFlNaHJWTmhsRGVIOWdTamdzMjBLcWM3QnlE?=
 =?utf-8?B?TllUZGtSUzJiU2IrSGtFV21qRTc1Nkk3b1VTalg2dEYyNG83VTQ2ZnZUYmtF?=
 =?utf-8?B?aTlYVUV1T0NYM3QveVY2VWh3aXpJWTMxVFJjNXIzS2Z1a2xWc04yUyt0clMy?=
 =?utf-8?B?R2ZXWlpPKzEwWkZhNFl1ZlNhYzhKdTJzckVMT25VRmdvUE1sTmVWZzFaNm1V?=
 =?utf-8?B?bU4yM0wrQjZjQytacVZpaFpNa3VDaVUrT3BnNjZOMzhkOTl2RWlqM242aWl0?=
 =?utf-8?B?WGxzb1prNldncnJFSktMYWNQSFBxQ0hvUDRUdk1MSlZaSjVqZVdKRUV2K28z?=
 =?utf-8?B?aENKYzIxbUFpM0ljcG5ETnFiQlhtNVJkUC9Qa0V1OTVGQzNuMTFIWUZLV2pz?=
 =?utf-8?B?ZTQ0RjNJVlYxVTNkZkJwNyt1RWM2TmkyVC9wSmpSVVYvTElCZXF0NnlVODA5?=
 =?utf-8?B?U29KSzRRTFlqRGFpTTh6M3Z6YXFicVp1N3hXQ0FPcTl3MkNHdWlsNWplaElB?=
 =?utf-8?B?TmdqcDlMOHgyeDcrUWpvOHdKNk9jTk5NSFFoRXNxQkJLMzRkOE8vQ1RMSjJo?=
 =?utf-8?B?dFRXYkJyRmJiMmh3bUxJRzMwM0ZYQWI3d1IvY29EakE1SDhNSUdCR0NoTndY?=
 =?utf-8?B?TW1IMTVnam5WUTRBVzE2c2E5Mmx6bG96YXVtOEdvaWU0ODlPT3JuWXYyNEJT?=
 =?utf-8?B?czlBL1FCY3Bocm9Fekdyd000OWg3aTZ6Vk1zdzlRSVU2ck9FZFl0TlZmRUt0?=
 =?utf-8?B?UU1nN0FWNDUwNnl0ODRkbTIwMEY1dTVoTlc1YXNacTFCbW5vZ3pLQ2lIcjV3?=
 =?utf-8?B?eXIxY3BFaUJHYzQrOWNkcXozQU5tV1l5NkxkMVZtNVJNWDB1Ujg2SFF4YkxT?=
 =?utf-8?B?MlNSSGlyRkNjVytXanJWZEVKeE5KZVBYSFpaQmRpc2RCVHkrQ2h6YUhKVmxZ?=
 =?utf-8?Q?Xnt8uZWoGoMmwV4VdRMVp6AZxUXU17F0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnpTUFpad3VYdWdpaEdxQjlkK1VRSjBZcUxiTVcwSGZIQnl2RjFTMjQ2U0hk?=
 =?utf-8?B?QVNrT2ZmYVZHTzMwQ3FJZXdIbllJem4yYnYvUVVicWZHaTZFUVhUMkRlcm52?=
 =?utf-8?B?eWp1YUZKZHRDeElzNnQrTDFVcGVzZU53aEQvTzRSZkJib3ZYQzFFT0lWdklo?=
 =?utf-8?B?S09CTHZuZlRCVS9GR1k0ZjNQOUhpcjFDbGpoMnRqR2FtUyttc3FwYXdlNEZk?=
 =?utf-8?B?Snl6bmswMFlsMW01cTlPVFIzR2VYSC9udzFKZ01TVFlwVUszWG9aR1dQWTJk?=
 =?utf-8?B?b3JkTWthRHVoYk9mZ1hMTzQ1T29ocFp3TlptclQ5SjhFck1NK3VVMFpGY1NO?=
 =?utf-8?B?YXVRUmxPb3VKQU5ibG1zWFZraFcvZFdDY1gxM0pTcmk3Q0JaeUVNMUFIY3dx?=
 =?utf-8?B?YWhSZFYrR1RZS3Q0NDY1Z01iWFpNeElYU1VRNEtFZW1PWEpHNkZyRnVDQ3VN?=
 =?utf-8?B?RGtRa0FhNW5aditITXdaQm5mLzN4Tm00aTVTUGFhelFXRUM5cDB3VkV4N0g1?=
 =?utf-8?B?dXdDTkVlWHlBcGxXVk9vZEl6T3p1RS8vZktiVU1yZjZGVnlIV1NpWFJHOUd4?=
 =?utf-8?B?dHR0bU9OYyt6bWkyY0tiVExYak5ncUxTTnpHUytQTUJjT0k1M2ZVNFdYbHN1?=
 =?utf-8?B?bFRNSDZoSy95cWF3NlYvdWV5VDRMOHdaRlIzNTVDejU3KzJkYm5ZOTVkdHFn?=
 =?utf-8?B?RTZ3Wjc1YUJsdVZ0TU9jd0lFM09RSXdSN2dseGMxY3VJdmlLbzg0TUZqcFJQ?=
 =?utf-8?B?OWk5d0xHR0ZLZGtkZk9uc1c0U3ordFdNNk1CLzNVU0l5cDZUNUp0NHl4dWtm?=
 =?utf-8?B?cXVHbDc4aXl5NWhRWVZlNi9rQThHakNMd3hqS0NXejN4UUpJNS9PK1gzUFIr?=
 =?utf-8?B?TEhmNWI4TXloaXNxQ0VYSnVpR2dqaGVIMHdYNjhiTlZrR2ZlR1lNSFBpUE1z?=
 =?utf-8?B?aUY0Y3BrQTY2YUZWc2xMTlozek5NbHZnazJPS3c5N2o0cGNhSEp6VnJRL2E1?=
 =?utf-8?B?UlllM2l4WVUrOGpDdVFIK25GM1kyamZ6OHdVNEd3UFI1NGtRZUZKNmpRZDRU?=
 =?utf-8?B?czB3RGNhWFhhWnM4K2swZmU2ZGFycGMwUU1pUWtFZjFhYngzYU0yQVp6d2Rw?=
 =?utf-8?B?SUdoL01DdnhMdU9SK284Q3hSaFhYYStNTjZEeFViOEZJamxPZFlFMGcvN3Jz?=
 =?utf-8?B?cDFnK2pwNHBEWTNLejVEMU5hQ2RkNE8yZXg0NDU1RkRyVEtYMUdIT21ZQWhR?=
 =?utf-8?B?UlBXNy9CNUljY2pGbEVsenNyMnpHbW52bnQ4RFBpTjFMRWh0QUtwQW5JdjVJ?=
 =?utf-8?B?czJab1N4YndhWHFYTFU4MmNWdXNBTWZOMCtWdFUrbHRYSU1zVjB0Z20yMGJu?=
 =?utf-8?B?eWwrN3l1aFFzeHhVc2dHUHBSZnNkeENFNU1SREMzcmtkUGRGTDY1M2VSLzhs?=
 =?utf-8?B?QUtJQnk2TzBRanVkeTdSK05vZk5ZNnUvaXUwVzVheE9Nd1g3YlQxUVJzczdn?=
 =?utf-8?B?TlBTTms5am41Qy9sSS9MVFBVVGhxQnQ2U01oODNSRFV0ODJWSG9kVENBQkhZ?=
 =?utf-8?B?VUVrTjR5TFVPalgwZXdMUld6aStFOTJSckN0bXZ0YzEyQzYvV2NGQW0xTlVr?=
 =?utf-8?B?NnI2TTlpTWZCZWdST0wybEpRVDd5aUIzQXh6Y3JuRFN6QXdHd0tzd3dWaUc2?=
 =?utf-8?B?K2hCSzNyK2Z5dHUyOTgxWkxXdVdJbHYzZTNSSFN6WEMzczYyYXZ4bTBJUFlX?=
 =?utf-8?B?SWxrQVBqMDlVYVV1WEdyNDlScnQwSDMxTU5mbmQ2cGNpd25lNTZkQXZmQzNF?=
 =?utf-8?B?Um9SbmFTV3EwLzZSWVk0SGdNcVFleW1sMExEL3Z3dWhoWlU0L0d0aUNpcGYy?=
 =?utf-8?B?MDZ2ZHlBUUtteDVtNzFFQ1RXZU10TFBwMUFtWDROVnREZ3BpKzJocklVbFFs?=
 =?utf-8?B?czZGQWplVkpLSWxyMllKa2txNWx3QU5FL0xPMDZoNmVyODdoaFdubFZjd0tD?=
 =?utf-8?B?dFhtNEdob1JSU0hyaUplTXZSVytseXlwQnh5MmpsbDdZMzJmSVBCN1QyU2V4?=
 =?utf-8?B?QVd3TXZxNUpoSmtUWDQreHhTZGFKMlMxOE1RdjZwY1RoMExHMjZlRkNQUnR3?=
 =?utf-8?B?cnBreFIyTzBnc053N210L3VUbS9jOFc2c0M1cW15SXdUa0N5S1JpU0dzNjFz?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67d6567-574e-4ce4-f958-08de3edf24ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 09:15:25.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yZ6NMcrTeMPoRR6CAb7C7e1kIBC2YvnThI6rc5YQ+sEExnNQnDiTQhg5OX6CUzlxllSluvm2I8Kj3CWV7U7OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4089

From: Jan Kiszka <jan.kiszka@siemens.com>

Those were I-pipe specific, and that patch is no longer supported.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 README | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/README b/README
index d974dfbac4..f3bb08724f 100644
--- a/README
+++ b/README
@@ -5,9 +5,6 @@ Where to start from?
 https://v3.xenomai.org/overview/ is the best place to start learning
 about Xenomai 3.
 
-Also, make sure to read the per-architecture README files, i.e.:
-kernel/cobalt/arch/*/README
-
 Documentation
 =============
 
-- 
2.51.0

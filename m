Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243822422B
	for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759250556; cv=fail; b=RvVvG6fLPhjK4iEUcLm3zijLrMy6ycwrE6kXT+K4tSrRxq+cO39LLuxiJMs8amAeW3n//U0id+0mXVjtCWgNBF1lMxZHOtCgEh1cShpVIMRbRCloNazt98eHtyxtWJZDtFe/NWAzB3IBDfez/XXdECxzq9vWnrnUV4M3DTKSWw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759250556; c=relaxed/simple;
	bh=v5h31G+FpDRe2frN+8Y2zdBGptkfG2nVKzNR/ex5VfI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bPJKHCEraZFTLy10uZZHBMuoruIwwcWYvJEVHRlwGpnkeuRIZmYwjEZ6YkY7mHlWOo2yWxUrKUyroDPlPjeJGlMwYl3mOh8ZbU7sjDpaOSdAvmz6eOgyCLZicPfSltZAp4T9YxTnETvIdIc6nKo5Qpj5YBEcA4Z1GMVIuO/hwtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XqutTlT6; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XqutTlT6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPcHs6OA0HUDURoobWfkZMXyA9ShJC2oW/dDRak5OvtvsD6HuihekubLxnMLU9S8R/5Fy+BMFJ7P45h8lQZLOzK1pv2RuayfT8n66tLcHrRnCRwiVAI29CkGT+cBBfZVGWENU2OJMjlGpLd46IyCJnEQuZdcxF9vXZ//R5RocnWgt9MgA8gcwVqzHRmXCvbreHsLgVILOvvQDviSgVC3NcDdj8fY5hhhZi2l7yAs3VGBB6cF0UVVj9l/2EPIzm4qSralNAQOyiDht7Nd9NmO5O7MkIOayAgZccrX/o9DDmPedbNKXyS62vonxkjnlg3EcNDG8cdw7PFVpfkIG1vu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=io48vXtd6EpJxSXsN8aDPMHVk1EYHui5xe1TNiWhmlg=;
 b=zTRQjdsukNsLraawiWvnhm0ZNqOcKDz/+Hpq+f6l7Hk/WpyyttUEC+iPmgpNJqK9+mhgc9f3B9d04G6tSIdgnDIgY9QtPOOiQ0uo/0twVdPfWFNPwb04aNjC8hhNI67l3VUS8/SqQvM4G3OWsMuPf1WMXeE/jR/istfweENBZsBfGMC7UimJWiRPYP2GdIm9OTUcUKEqcc+GU4jefZHhAXn/t7BY5sR/41+7PMK+u37OXpsuHC7cxkJlc2NVM7o2Vo0hkS+SfvEWFCZ/sYqp7xABpQwLC9sbwTjOrK4ah2orPXVCYw+4C1yHAPSCjB0SEjDjCNOM8clUTsbtJoPJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=io48vXtd6EpJxSXsN8aDPMHVk1EYHui5xe1TNiWhmlg=;
 b=XqutTlT6gX38TSZzP8Uuh+5PljBS/46PvMeJ4EXwkIkMIMhHILgKMKMS0MqwT5vIghi8OlmMHGKJ2U9fuF8Pr6yqC6pOxGVgWJATDTPOxJOfrbX5GxFMjHMOurOrLc3Ivy/k8fKd1zk1Zi2zzrcC9cv9ESaCO8f8N7YUOvVRdW1YeALtJH5i4aySpdk3VubXXZXRFlC1Mi7dq+E3lzm/jO5ua6iuY6E5X4Q8S0ZGzvwL60iZwTIjOJAfWr2P7heHKReH266VSGdh51NWwPX8WnhuHA+OomcsBS0QgO8a+J8M19cs6mhkNvTY9P2SyS5I73SAwCXSG0FD6MreqHnhyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 16:42:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 16:42:30 +0000
Message-ID: <591cc54d-3aa6-41cb-acbe-0a3998927909@siemens.com>
Date: Tue, 30 Sep 2025 18:42:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Used memory by a Xenomai 3 application
To: Pierre FICHEUX <pierre.ficheux@smile.fr>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFc1U0tVxe4sYCkmjyUxTBZDphUm71V8wfpjj9CbyeDwe9gVNA@mail.gmail.com>
 <CAFc1U0tbuuttzNjBZLX9ftrwAyFkG7zu4MhGK-TTTB=mqa=6AA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0tbuuttzNjBZLX9ftrwAyFkG7zu4MhGK-TTTB=mqa=6AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 44f5213b-5c8f-4efe-f987-08de0040589c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckFZcTROSlZsM1pQWmt2STZYcXJrVFhHbXAyKzhqdWlvM2hDN3dET1NQYmtw?=
 =?utf-8?B?LzBzcDEvTUFkQ1FqdG9mNnhyMmZ3ZEZybUxYNjczbldvbXE4bE9QYXFwck9G?=
 =?utf-8?B?d3EvazFtMGpVWnUzTWhjVGFTZmt4cy93M1RVemdxM0l2SmZZYU5NYzdLbk9Q?=
 =?utf-8?B?VWFaVi9rQ3hzdk9LM2c0Z3crWk9VMElySk5BbVY0eXJ0YUVzd29GR3ovREZG?=
 =?utf-8?B?NWlKRGlYTUl2V0xrazRUdDIySFlVcUpnZTMzd2dGYzZodmdRNFgzREhhSUZS?=
 =?utf-8?B?bGFvNEJ4ZkZES0R4TXYvMExpMDdkd2Qrb1VVUFVyb08vazVwMWhUZXVTM0RG?=
 =?utf-8?B?eHhOQVo5UUMxbjlBSnR4WEQybGZRK2dMNkprbm8yRWZjcDE2WnhudDVkV3BH?=
 =?utf-8?B?TUc5WldaS0dXUW0zblFham1lRk91TFpmZ2FqUVFBUEY0VEQ2eE9OSTZMR3VE?=
 =?utf-8?B?UTB5Um4rbVVOVi9lY0VMcGllOWIyQ05QeXd3K1NrTk14bUJ5REhyMkJwU2xN?=
 =?utf-8?B?K0RmREJXakZENzNSaC80K0JKc0FMRytGTVpGYWE5UTFxbzZpZ25zdjN0czhy?=
 =?utf-8?B?YmE5dWh1RjRzYmEyZW1lR01NVTl3MUx1U29ZVmRNaDYzdzJ0MTFzRmtUQ0V4?=
 =?utf-8?B?SDBYN3FxOGpRaFZHdGdrcGhZeVJjaTN6V2dwSjQ5Yldlc2RSNFQzQ09leG0x?=
 =?utf-8?B?by9jUWVwcWxXaUk0VkFwQ0NJTEFLUDBBWFdFVVNkdDNqR3A5L0dnOE01Qktk?=
 =?utf-8?B?cCtrNXJvM3FYVFVQUDN5c25iY24wQldiTVk0QUNIOVRJUGgzSjlkb0xJWkFl?=
 =?utf-8?B?T3hKelA2NTFkTEV5K3ZkMUN4Sm4xM1IxUEVZemxyK1JpSzBIWjZCdXVCbVp6?=
 =?utf-8?B?YmorMWdFR0xYVWtNVUVQYXE0WU54K1BMVlRNYTVvcHdSeEprZTFyQUprejQr?=
 =?utf-8?B?NXNSdXovUUlaUStPME5jUnA2L1Z3WTRKOEVpY3hLd0gwWWdTdy9tTGxqRWVu?=
 =?utf-8?B?Y3QxYkNOYjRIVUsyS09zVEZxMmJFOHVzNkdQS1NlNExCczJ4d1pab2VZUERv?=
 =?utf-8?B?UXlpTjQ2UURjKytwekxOUVNXNmo4RTU2bG9RMUxwdkhCT3doOHgvdm1zbmhD?=
 =?utf-8?B?R0txSlZHaC96aEVTdTNrVWtDZk5BbjFYNDMzV2RMSTRUU2VEK2ZTT3phSDBR?=
 =?utf-8?B?a2czbWVFelB5UFVFTGhpWkxhUG1wYVhLSTRWdzNSaGpyd2p4ek13SnczUE14?=
 =?utf-8?B?aWNYb3VYNTk4c2hXMTRiUUJ2Rk5ON3llWWp5QVM3RzJkcG5tRzYwcEcvdXZC?=
 =?utf-8?B?MW4xZ3QyaGtjWTQxR3NVSGdQY2ZyK0dVOVYwczl0VlhRUUFjcmMrNVFlR2Nx?=
 =?utf-8?B?ZzUyU1diSkxZZkFRQzVOTDNKRDZhUisyUjVSK3BsWURRKzBqek83dEdoempB?=
 =?utf-8?B?bzJhT2l1QVVRYzYyMTF1ZXdzRVR2ODVqZnkySjllaFFseUJxSis5WlYvVGZi?=
 =?utf-8?B?YUNybUlaOXVSaW9Kc1pPLzV3clFxRFFuTXFOd2I1SUV4MzB4cHB3Tk9QRzZS?=
 =?utf-8?B?TG1EM1hSV0krOHlQRlJrU0F3NTlXYWRZUU9KTzFoTjVuYjlPY1dib1dwTUl5?=
 =?utf-8?B?RXZkeGo4QW9NSU1SWklVRExmUnlsOXFvd1lXd1hOYU9Dc0MyR0tFUkEzNW10?=
 =?utf-8?B?WXhKTDFiNDdSTFhrbUczMkxlM0xOR3M2KzNkV2tsZHFaT0s4bi9BQjVPZ3dW?=
 =?utf-8?B?aXo0ZmI2VS83SkJtRjRpMG1EMTk2OEFUL2VQeERnQXRHMHZ3c3NaOVQ2R1h0?=
 =?utf-8?B?bStMR0JiU0dUMXluRWYxcmQ5NFRORFZ2SzBLVUx1K09Qd3pQYm95RDNwNkN2?=
 =?utf-8?B?a0hTbGlMa1JsNGloWlVlOUhvOWdyV0M5ODJwYWFqNnk4UUI5VHhsWmQyYlMv?=
 =?utf-8?Q?oMRpcYRXmSEZKCz96hgOZuV0HAR1SWu4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDdYRUIzemRUQjNQWDRQMG1pVFZtWXdVemIyQUxPLy94dlFTV0EreSt1a3pE?=
 =?utf-8?B?TkZ2NXBlSG5CUlJ3Y3FIekp1TzBVdlRRT3Y0aVg4UDNrdFdydGxoQW9qallo?=
 =?utf-8?B?NlF5UlAyU2g4TEZybm9hVllZbHlXUkhnWEMwZjh3blVxZlBxRVRvYVVWSmdN?=
 =?utf-8?B?aCtpNG9vWG1lVDBQa1VqSlpZcWsxZUpQMHRDNVIrWm9mY1JIQTVySGVoR2FF?=
 =?utf-8?B?MzdMdDkrT0E2dmZTbk1RczdOOS9BOCtJYVFTTnNYSHBIdWhmV3FTRzdrRWd2?=
 =?utf-8?B?UVRlQWpFbkNZZGtsaFBSUUZkMWxPZjBrTEJiMkgwRm5QNlp4ZVBBSzAwS2VF?=
 =?utf-8?B?TVkzV0JmNUNwZFl4Q25uUTQ3aTI4K0ZiS05HVlpjNjZnMzZKR0RjbGY4Uno1?=
 =?utf-8?B?Z3lZN05BQ2gxQTVVYk92bXZCd1QwNmtVbFlQM3hGaXNNSnk3ZmpaaUV3V012?=
 =?utf-8?B?WUpwbkRkVU5IR2gvemoxMkJOa0JOV1padkNvSmZXTEZHZFd3Q0Q4VmVGT0V3?=
 =?utf-8?B?eU1HdmhxQThyUDZ4V1J5bkN5N1REbDQ1MWxxZ3dndllnczk5L3lJQllHeHY1?=
 =?utf-8?B?emhZTXVZUTlsd2Z1bWM3VnExSTBlMVQ4T2JFNGN1QVZ3cGhVaXBkL1JHNUhJ?=
 =?utf-8?B?MzVrcWVZQ05hTWFUNHh2RC9TQ2hWdE1HakhjbE01YjVGajBzVGlWZG8yaWJq?=
 =?utf-8?B?ZjJRU2UxcENqdFFwQ1grbkwxelVjamJDdDJUZ1FDLzlQS29FSS81ZGNTd3ZZ?=
 =?utf-8?B?WDFDWitQaDJaeFhrTjhaSTc0WXp5WnVpM1JrZUppRnp4ME5vcm5RU0F5UUps?=
 =?utf-8?B?UGFSbXg0MzI0eXlPRDM5SkVTTWtYbWwvcTZnK2MvM0JWZmk0ODlScGN2V2V5?=
 =?utf-8?B?ZHpzVVU4dVVNUUFVSjZaV2VjSUFEdGwvK0JuYTh6RktoUEpla3dBckxkbm5W?=
 =?utf-8?B?NHpRME4vUmxQNlllM1BUclFadDg0TnNLRGYrNVI0cU90WlVhUlAvVk9mYkpM?=
 =?utf-8?B?Ty9FWXZIZ1Q3NWk1VFlGZHpmQ1FhSnNHQ2pjT0gzNjl2Q01tN1YzZlhyK05s?=
 =?utf-8?B?NThRNDRMWUlRcUhPa3ViNDNSdUtLRm5pNEcxcUs3U21wN2dGbjF1WUl3Wkhw?=
 =?utf-8?B?L2l3dFBwWHNodnk5bXhNR2NVR2M0SUE1ZGE2bmx6ZnZaU1JYYXNNK3ZFSDN2?=
 =?utf-8?B?eVhvRVUwMjdZQlJhYk5TcDVSNlN4cERqalppTm1RM2c3d3gwU2tueG9xYUYw?=
 =?utf-8?B?VUZucEVSV0lZdTdmUTJuR3dpWWswVEFiQ2J3bXhnZXJWUUFTNWRaeHFYVmN6?=
 =?utf-8?B?RGU0Mi9Qd2ZUK2VGeDAzU1E0SzJXaGo3NytpNlNlVnByZHpqV2tzTTIvbWxP?=
 =?utf-8?B?VjJTMWM5b2t4NjJvWW1ZZlBjbUZoc3pqOFhtZ0RuVEpaeGxLemQvcFNJMEE1?=
 =?utf-8?B?MUNKbC9JN1RQaE9sT1ZzRmJMTWRnbFk5ZU0zTWhiV24yZUxTSnRLVjIxYisw?=
 =?utf-8?B?VS9JREg0ODViUWg2MktZOVoxUWNZeEJpekk1ZFJjSzlMOEpjU2xqNlpQTkh0?=
 =?utf-8?B?YWw2akRGSlU5RHNUNFNCZENEZzRFcFdtbkkxM0dOQkswU1dJN0V4ckpjQ2g2?=
 =?utf-8?B?VGVwY1RrYUFOUHU1NGVNREttVDJGM2t0VCtOT0FJNWpxQkZYYXp0WjFSdUw5?=
 =?utf-8?B?a2hVZEJvOEhyMFh0cHJJOEtmQW50Q0EwZm1STlY0U2J0d0t2enZhNDBncXNt?=
 =?utf-8?B?czBYWTZzTWcrKzF2YjBaQ0h5QTMzQ2c1dmRzM1hKQ0UxUlpkNkNpYWlQdXlr?=
 =?utf-8?B?MEtrQXJIT3EwbW5WK1ZSTnc1SVFzL1dYSHNYMUJPb0xHQnZIcHVuQy9hMFdr?=
 =?utf-8?B?d2l4MmJsejFxdnlrL3VEQUdVcHczVFRsaUdiN3JibFNGdEZNaHU3Y3FzUkNy?=
 =?utf-8?B?blo4VU5NK29kRy9OS2I4UFRBNUFNaXU3SUs3UTllaC9GY0lNN05WM2c2d0sw?=
 =?utf-8?B?SENET0ZZQnh3VTBrQmJhd0prQkcvUmNqb0FIeTVXOWRQODlWUEdQOVh0TzNE?=
 =?utf-8?B?YTdRTGN5bCtRclYyN3J1RXZ3ei9Fc1o4TjJYMHBvMnVkRnl1MW55MlcwK1J5?=
 =?utf-8?B?NlhVVlo2Nm9yQWxlYmpPWFYvVy9PSEg2TWxJdTBxaTJMZHRleG91cVY2ODNQ?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f5213b-5c8f-4efe-f987-08de0040589c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 16:42:29.9391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuU0SCBXUdZzn84H7iMOF7qfXJgJ/LFVf3JiEuyobZDWNNcMOHLPzEQB+0oIiWzcrdMXT6He7JtATXQKLdMZZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7100

On 30.09.25 16:48, Pierre FICHEUX wrote:
> Maybe /proc/xenomai/sched/acct (how to decode the  matrix ?)
> 
> 2 18470 1 1 4 0 000680c0 142909332360 0 4840 hello_thread rt 0 0
> 2 18472 1 64474024 64474025 0 00048044 142909332360 66962026760
> 430302553600 hello_thread rt 99 0
> 

You found a documentation gap - though this pseudo file is primarily for
rtps. In its code, you will find the structure:

sscanf(acctbuf, ACCT_FMT_2,
       &cpu, &pid, &ssw, &csw, &xsc, &pf, &state,
       &account_period, &exectime_period,
       &exectime_total, name)

ssw - domain switches
csw - scheduling switches
xsc - Xenomai syscall
pf  - page faults
state - thread state flags (include/cobalt/uapi/kernel/thread.h)
account_period - length of last accounting period
exectime_period - execution time of task in that period
exectime_total - total execution time of task since its start

Rest of the field should be clear. Please cross-check if my explanation
fits (only quickly derived from code and memory). And I would be happy
to receive doc enhancement patches.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F0C34C136
	for <xenomai@lists.linux.dev>; Fri, 31 Oct 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932099; cv=fail; b=svm7bhTfREnY1NkbAk1pq6n0HlUbwAdxWsOXAiGNFViIuEQO9tUlMuVQNz/RohuZru/Nn/Vvet4TwrsReihCvCqL4tw815QMTU8SyiR47KQPfjsw3oQ3HdZvRUW/4pKPE2qLKZiIacoTFZsaHbTFqv/VeDRrneneYkUY9Y2OrnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932099; c=relaxed/simple;
	bh=lmsGqPZohO04XFvTdc+zYWZUUvDrMmc7RhpO8wLidmI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tYiOFgyhNn21VZtr2LpdUjfxgzIhxvuIQKKOp1adl/5f4wxRnN92q+6BiDJqKSp5d/o90UNLaTYktFWb1EaYi16EYCwFgkJO+uuPalgPHtu24tLuSiv63sTnptAJ0uhOoWgtVelM1c1K6Lb2eD0OQ+mbVBtGM3ij9OCo1bEelbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RvH7VJIN; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RvH7VJIN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRxdEbe4FSvuF9QzbP9g4kmaikHtuxhEfHntZA9DxPK6dsSwckRFHBSblOKE3CS9/FW82k2rqPH0bMBIkKjOxef2M4pyt+kzU6Uav3UYIsqDw8sySWpuBUICBS2yIbEISzG91/jNvkahBC9g8hls/JXk274eRNEaMNt6EAT60jFIc22Yx9YmI31E8HsKFBozB8mOrjCixGp3gVc4bpbWPyZyd/1iobY/gY7wh02HsF16+z8kG1vCr5WQzFYcY8Ge3TRdD6pHV2IEj6sUUz9Ba538OqtTsS9oCN53VZg23HTgnLYFN7evla8LOtkRpsMqWB4SAyhPJ+aX1pX0E9YWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynMM+57ZgTKM3geGWwJ153udj+8H/VF0/u99kNUHzek=;
 b=ZVDr5pRSFJm1/p5eSt2z1V58K8LFN7aKELD2OsUTQQ8sR4Ax+Xz5zxEUL2jpLjthkSd869GGbji2DiHvvlMWE5bRRoFzI0X7cabKPIw3n/0HF14AfGDUZ1DUeyYDUA98IRL3zzeFMkA37QvtfW0a0k1CQZ79z6O9nn3CHPa0iEWhiRSoyc/hdyT+68OxyR/2fkxMAzMQ/xPWIZmjeU5HR/sp56TK2Z+iMnsQWYmJsvuevK3OH+ZWFznjEp3OaCw4qZ67B//YrJDxfNGR9176ftaAZfv+H6UoQRlPaZKxouy09aIFiijNtOw8dvb5ZbhRDOfsvS3BAgGK5N03OZ8Szw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynMM+57ZgTKM3geGWwJ153udj+8H/VF0/u99kNUHzek=;
 b=RvH7VJINsbDUCm139CPIe1P2/Yw0t4w5JM8LGODYs7Puv0DSE6SrMTRCX9aIqmUxHnBilraCVs2siD9XKivRnuzzEGzhM/ODXlDxGsDgO5ypdD8W9QbJ8UQfZ3gyM2UdAFJO/YcSHQaZdQX383646exK/p/FBEdsC9ZIxbyJ9avZ+Qw8uzL62C0gzBhm1R37ksh3GLtpLrnAtUiZ4+NlCOgq/ZBWlzY032dG+8ugIf1TcgfDaHhG62a2oMWpG45fMZGEHbKS2KiIj8+UWP7rMwEbtCoH2bM47q5WIXKxnry9uiu0E3+1O1DNK8OOKrhY5YiJ8CMOiMj/dl0KNLf8Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 17:34:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 17:34:53 +0000
Message-ID: <5c69758f-876b-4a56-99b7-09eb22537680@siemens.com>
Date: Fri, 31 Oct 2025 18:34:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Unexpected switches to in-band
To: Philippe Gerum <rpm@xenomai.org>, =?UTF-8?Q?=C5=81ukasz_Majewski?=
 <lukma@nabladev.com>
Cc: Giulio Moro <giulio@bela.io>, Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk> <20676160-4572-d92d-4b33-ff4255946345@bela.io>
 <87qzv9sa9c.fsf@xenomai.org> <87ikgls9kh.fsf@xenomai.org>
 <f916d01d-2bd0-cdfd-2e9e-562968a9934f@bela.io> <20251020094705.2ac256f2@wsk>
 <9d2bacac-8d70-f083-e926-21beee2207c2@bela.io> <87o6q1ad07.fsf@xenomai.org>
 <20251023155439.0170f987@wsk> <87a51djuor.fsf@xenomai.org>
 <20251027120535.7933c720@wsk> <20251027172505.29eecfb2@wsk>
 <875xbyawx7.fsf@xenomai.org> <20251029145125.71debaab@wsk>
 <20251030132602.2d1ccfcc@wsk> <87qzukuzy5.fsf@xenomai.org>
 <20251031165615.2c9f72f5@wsk> <87bjlnc9u5.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87bjlnc9u5.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 8681d935-db02-42ae-e1a6-08de18a3ccf7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1lBMzhLSjRNRUcvQTZWVVpWclNnZVJ1OGdCVi9HTHlTTldObTJVbU44eGN6?=
 =?utf-8?B?WSsxdElJV25lTEFHd1JoT0VhTUdMUHArb1lUOEZJWDdhNlBubkZ2TmFyYllH?=
 =?utf-8?B?UHhxckxYSWd1UC8vd3pCclFnUy8zUWdLM2JXTmFodTJrNkN4TGRia3ZwN0tu?=
 =?utf-8?B?dld2YTlVUHY5OWNLVE9YNUN2MUw5b3pjSFhlcmhmQkZSL0M4UUF6S0Zzd0Zv?=
 =?utf-8?B?SlNtQ1oyd1B0dFJ1Z2MydmdqelZSNXZ6UmxWMXBLL1ZySzJVNE15WVRXT2du?=
 =?utf-8?B?SDZDVHlzOTJ5UUdCYU5SdWMrU1FaQkxrc3hwWTVoVFp0UzJVUkpZQ21haHJF?=
 =?utf-8?B?ME5JQ2tFdjNwTHZBSWEzMHZHQVFhV1FtNDVIaGExWWxvTHQvZ1cvUG1pcVda?=
 =?utf-8?B?anpjS1dPOUxDWHUrNm1ra090RlRFQm1zV2FOV0pBYXVnTnA4eVliWDZhTmpW?=
 =?utf-8?B?RXR5QXZiN090d2hXZEZYcGd5WDF1Y05aQUdhaGgzaWFwZzlCZCt3WnhINVcz?=
 =?utf-8?B?aFZGbGp3RzBGWldCU2RCWVZNNmlOT0M2WSsvNjJqOWZLb0pTdEwwSXY3aFg3?=
 =?utf-8?B?NFVuRWl2RGtBd1Fvb0s0MWtNS3ROekFka2dmQndleE81bm5KTTdzVUdib3pC?=
 =?utf-8?B?b0pSbVZrVFVoSllDcVRoaC9WNGgzMnV6b29lV0NDb3dvSHUzMFQxV1BDM0hC?=
 =?utf-8?B?aU1ZNFAyRUZiT0EzRjNDcGUwOXozWVNkajNLd0Q1UHZ1dGZlZTNZQ2dTKzVL?=
 =?utf-8?B?OFozRnUrYTFrRHFnRmJ0OStOTTJBeEJLU1FnOVQ0SDNhR2lxd2J1MW1YK0pJ?=
 =?utf-8?B?dkYxN21POTE5Sm1zSStjN2ZPZHF6bnZRbFJ3WUlFZGxpUGh1R09VdmVhd2lL?=
 =?utf-8?B?U0dqTzBWd29pc0p2ZU40SVZwNGFkc0VQWG45TVhJdHJiZHE2aTM5QTNOWk15?=
 =?utf-8?B?RTNoaHVVYTRRVEEvODJFbWdvTWs5Qy9xNzBSM3N5WmJnQ1hiUEpmazhRK0N6?=
 =?utf-8?B?cG9Ub2laSDNWeDNPZmJvSFVFRTdOWWhIeWVuQXF6bjVRV256RzY1ZzR1YVZZ?=
 =?utf-8?B?OFRpdFJXYUJWd2JxcGJvZ0g1ckd6K1ViNkpkNzVOMTZqQnc4M2xqb3JrTVgz?=
 =?utf-8?B?TXVtazVXOEpMemFuQmROV1BlQ1MwN05HYXBaQmhOQ2EycDlVeTRGMHV3QjFV?=
 =?utf-8?B?OGV3b1k5bGFjc2d6bE11ZGF5S1hhZW9VazlOMEswWFlNblBla1NIWXZJUXVN?=
 =?utf-8?B?eGZZZkU4bG5WSnVZTk1BTkNBR2ttb3gyZ3pwV3YwNmg5TFhtcGQxeisweEoz?=
 =?utf-8?B?SE80dXFvMUpLRjZyZkxhM2xaeUwyUkMvWDdjdEFxWTZkUUtuVTBFdWlmYjdV?=
 =?utf-8?B?K3VWdUowRUw4UFhkYUZCMmZubDdlYjdTa0FtQmxiWXVhODUrN041RDhtVnRG?=
 =?utf-8?B?U1hhK00zWTV3eWFuN0ptQzhqOVJGb0REVXBYbHNJKzI3OThBN29jbzFQMENC?=
 =?utf-8?B?WDhMclprR01LY3pkenF6YjJZS2NCbnBpQmVaaXhaQ1l3S2FPU1h0MmJiWjhy?=
 =?utf-8?B?am9wVHFqOHhxYVlVZTZ6dmJ0MVNKalVJV2xiNktCTnVoZGk2RUNaVWtEb25U?=
 =?utf-8?B?dmhBOGFtS0F3dVZ6WGhnY2hkbVAzWDNaMCt2QU5WWjJ2ZUNEQVVJZExQMkNq?=
 =?utf-8?B?cFNVaTJyWjFObkFubG9QTVB2QjlJRDgvRmI2MklRVTlLcVFWeExjN2lNS0RS?=
 =?utf-8?B?Vk1MaGpvNzRPOXhoZGt4OGI3ZnRLcjFqNmZIdFlWQndvZmJ3TVpEdzduOUhU?=
 =?utf-8?B?RElOWlhtV2JXRmx0SElTRU1acTN4ODZqcTVuV1RIaHUvZDVkK1NWUE84T2du?=
 =?utf-8?B?UXREZUxkb2llV1MrTytKU1VPN0Q1azhVelpBdkxMaDNMdWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGVDcXNwb1ZhWGM2dkt4dVA1anhnNEZlREcwbVFkZUZVUFdHWG5mTUUwbTBu?=
 =?utf-8?B?OStObVh3UEh0T01JT1NFSk9CMVVwUk1pN0RSRzArTm1oaWFKREhHUHVBWVYz?=
 =?utf-8?B?T0pJQW5hOTI5QzZaeHVrT1VhY1ZnUmNVbjB5T04xQmVnNk9nVk03TGdEWTR5?=
 =?utf-8?B?K1h6bzV5YkV6SE5JNy9KRXdEREJJTldpeHUzSWx1Szl0aW9DbTAxQ1Z6endh?=
 =?utf-8?B?NWRlcE84V2srSGo5M21DV3lQYUx3MU55L0RJK0w1dmwyOHBwVVo4ZThvSWIv?=
 =?utf-8?B?WHVvWWpEdnpPNEJ4OExDQW1TT3NZU1VsZHpCS0VMMWVsU2F4RTRzQ0h5enBr?=
 =?utf-8?B?OElMdHEvSFFrWVVCdURoY3ZhMkZlSlBTS3NIRTlUL3M5bS9KaDJGQmdpL1R1?=
 =?utf-8?B?M2N2NC8xNXhZMWs1WHdaQ3UyZkJWdzlDM1JPUVFaSHphcGdWN3NVOHVYU1hX?=
 =?utf-8?B?QldETGRZVStFc3AxbHRzdk1CZmF1ZHkrWmpPR0d5WFJOMkw1MzcxbHhyTGpo?=
 =?utf-8?B?elIvUk4vWGxNaUtaV3piVW1TM0EraHUzZStPN0lFUWt5NFVSN0JKemV4MXBL?=
 =?utf-8?B?ckQwZmYxWWZPNGlrRWVFdlpOUExTM3NydllobmpwNUpiZFk3bVJpUTFiVkZy?=
 =?utf-8?B?S2V0N2hFWURERE5Bd21rdVE4OXdod3NrTUdVVStVd3BKTVhZN2VCTllFK2cz?=
 =?utf-8?B?SjhKQnE2eE1McysvaUZiTE5GaERsZTF4S0ptUkpuWHg3U0NUZFVqTWVZZ1VU?=
 =?utf-8?B?U0hSWXc5anlnMXgwOW1UNXg0TyttczBkVDIwWEZtMC9sc3VrYlMwZGFseCtH?=
 =?utf-8?B?ak5lNGp4WnJPTzBDUW9YcXhHbDQ2UWhhaThOb2pOWVVZSnpBOG9KY2pscFVL?=
 =?utf-8?B?U0N4dFRvN3hIckUvR0huT2hiZ2RYZm4wSFNJYmVQejZQazd6SDNlTUZVSmJW?=
 =?utf-8?B?QzY4TFVPd1NXTFlmVVdDcm8rQ2tUeFh0WU9pMEluWFpzN3ZiSVBUck9yVWtK?=
 =?utf-8?B?V2k3akdEdldJOVhRRS9obDhqTXFBM0k2Y2VZVmkzN243YzZtYU9jalNwQTEx?=
 =?utf-8?B?clpKWkZ4V0hzcGUxeTBCZVViSG0vdWxUWXc5SXBUc2VqVzJQL0xwakRwYUJ4?=
 =?utf-8?B?cCtHMjlsVkJob2wyM2hyYmtTanc3dlltLzlGb0Y5SldMd2pZZ2xScGZrbnBS?=
 =?utf-8?B?VjNrcjhBdUlTWDVZZmhYbmFiQ0V4OGs3M2dzUlVNYjZkZHhnZTFlVVV3NmlF?=
 =?utf-8?B?Uy9TYnNkVmI3NjVWTTV5YmhGVFY4Umc0OXJIZGpROFFFN0RobnRjZk9BV1hX?=
 =?utf-8?B?M0dvN3gzRmN3TTdDNW4rbmI0b0tpMDZjRkpwVnVDOG9RZGRDOUV5NDJFZUxE?=
 =?utf-8?B?dUtGbFZPVmZYeVNrUlhrMTVsbi80clNhTWwraS9hWEVHbEdEUVJUTnVaUG1q?=
 =?utf-8?B?ZVNPaXk2b3Mzekc0T3NaVk9kUmhYa2s5aVd6b3N2aTQxcVN4cmJQRTJCVGZi?=
 =?utf-8?B?cllhMHVYRmJWSUw3a2hvaS9kOXJSclhGa2xnZTE1YnRBendKbDJKdzFYUVpC?=
 =?utf-8?B?T2NzWXZIQnN4Q0gyOGNWK05uUWRpanN5UHpzcFUzRXk1OTdUNW9LM2Fva1Jh?=
 =?utf-8?B?QWwzQnFRQ0M3aExKZXh1SjFnY0hVblBOT3hRbmhJck9DZjBBTDQvTnpPRDZT?=
 =?utf-8?B?NnhKSFhHaEhleTlYNDl1RE1PM2Y2Ulc1Z3dQbGU4eWxLOVBCTVRjZkRvZVE3?=
 =?utf-8?B?MGdVUUJsVERkZW1KclZqbDlDOHpWY2k5U3VaNGhaRTBQbk9oTTVFVldNa2hz?=
 =?utf-8?B?a1k0TFZoYUQwZ21aRjRiTkRzeTU3Z0RWRUFwRU5aMlJNZU4zcFdFd1ZESjNr?=
 =?utf-8?B?Nk1JVDN0ZXpSbUZRL0M0bEUwb25iNjlXQkpkTk5kVU00aWZ2TmRzRFo5RklH?=
 =?utf-8?B?Qm90dW5KclhydnloRStSUUVHdWdPUldsakpXemRLbzErQzdRK2VJZGllZkFm?=
 =?utf-8?B?SlI5RkdyTmdjTGtNUlg5K0hrNFhEbUV3bTVNODVxeURLSjhSU3dYQ3ZGTWZJ?=
 =?utf-8?B?MlpOblZNVkFYRnplUUxhRVhLdkp6UWVxTEdhNmtoYWpCNm10ajA0ckhQd0hO?=
 =?utf-8?B?Vy94VUs3RnhCRnRNOEovQjI1N1FCRDN4anhyZ1pDZ2JIRER3TFBNcmg0VFVT?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8681d935-db02-42ae-e1a6-08de18a3ccf7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 17:34:53.2931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjzBeC/SK40FWWhDyU4YYMXfEfNkXBZqX9Vt/tukiJxbaSsY/uJnaRYlqOyIApew43uLKYWdCWB3lzrVdfvvjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6072

On 31.10.25 17:30, Philippe Gerum wrote:
> Łukasz Majewski <lukma@nabladev.com> writes:
> 
>> Hi Philippe,
>>
>>> Hi Łukasz,
>>>
>>> Łukasz Majewski <lukma@nabladev.com> writes:
>>>
>>>>>> Could you get me a trace which goes back up to two secs before
>>>>>> the time reported by evl about the inband switch of the timer
>>>>>> responder? e.g.  
>>>>
>>>> Why is it 2 seconds? Is it related to latmus "refresh time"? (which
>>>> is 1s)
>>>>  
>>>
>>> Picking this delay is purely heuristical. Such a long backlog is
>>> likely going to include the smoking gun, if any.
>>>
>>>>>>
>>>>>> [   75.214527] EVL: timer-responder:743 switching in-band
>>>>>> [pid=745, excpt=14, user_pc=0x77d08492a5fe]
>>>>>>
>>>>>> In the above case, I would need a trace going back to 73.214527
>>>>>> or so.   
>>>>>
>>>>> Apparently the ftrace buffer was too small. I will adjust it to
>>>>> store more data and share results.  
>>>>
>>>> It is also interesting, that:
>>>>
>>>> bash-5.2# echo 16384 > /sys/kernel/debug/tracing/buffer_size_kb
>>>> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
>>>> 16387
>>>> bash-5.2# evl trace -eirq -f
>>>> tracing enabled
>>>> bash-5.2# cat /sys/kernel/debug/tracing/buffer_size_kb
>>>> 131
>>>>
>>>> Reduces the buffer size...
>>>>  
>>>
>>> Yeah, the evl-trace script is not that smart. I can see the issue
>>> causing this, will fix.
>>>
>>>> Hence, I've used the "normal" ftrace with enabled evl functions -
>>>> the  
>>>
>>> FWIW, EVL relies on the normal ftrace. However, evl-trace fiddles with
>>> the sysfs entries manually, and may be a bit naive at times. As Jan
>>> pointed out long ago, relying on the trace-cmd front-end would be a
>>> better approach than tweaking ftrace's sysfs-based controls manually
>>> at the very least. evl-trace adds EVL semantics to the tracing
>>> configuration which is handy, but the way it is done today may
>>> deserve a revamping, or maybe drop it entirely in favor of trace-cmd
>>> if we have enough flexibility there in order to introduce some EVL
>>> specifics.
>>>
>>>> detailed information about the ftrace config is with log files:
>>>> https://nextcloud.swupdate.org/index.php/s/czBd3Ydq9B9noZ7
>>>>
>>>>
>>>> To extract the cpu2 specific data:
>>>> bash-5.2# grep -rnE '\[002\]' Xenomai4-ISW-trace-6.6-logs.txt >
>>>> cpu2.txt
>>>>
>>>> Here again the ISW happens in the cpu2 execution "hole":
>>>> [  128.466459] EVL: timer-responder:736 switching in-band [pid=738,
>>>> excpt=14, user_pc=0x7588e71985fe]
>>>>
>>>> Happens for cpu2 between:
>>>>
>>>> 11832546:          <idle>-0     [002] *..2.   128.466438:
>>>> 	sched_idle_set_state <-cpuidle_enter_state
>>>> 11832547:          <idle>-0     [002] *..2.   128.466468:
>>>> 	handle_irq_pipelined_prepare <-arch_pipeline_entry
>>>>
>>>> However, now the log is large enough to inspect what has happened in
>>>> the system for ~4s before.
>>>>
>>>>
>>>> With the logs:
>>>> timer-responder-738     [002] *.~2.   128.466214: evl_timer_shot:
>>>> [proxy-timer/2] at 128.466467 (delay: 253 us, 66918 cycles)
>>>>
>>>> and after ISW:
>>>>
>>>> <idle>-0       [002] *.~1.   128.466469: evl_timer_shot:
>>>> latmus_pulse_handler at 128.467208 (delay: 739 us, 195206 cycles)
>>>>
>>>> Why there is such increase in "delay" (253 vs 739 us) ? 
>>>>
>>>> It looks like we have only 2us delay as the timer has fired on
>>>> 128.466469 vs. expected 128.466467.
>>>>  
>>>
>>> Ok, so the issue is still the same: for some reason, the
>>> timer-responder thread is taking a (minor) fault when accessing some
>>> memory, on its way back from the ioctl(EVL_LATIOC_PULSE) syscall, or
>>> right after. This seems to be valid memory though, just not
>>> immediately accessible, otherwise we'd have received SEGV, which we
>>> did not.
>>
>> Yes, I also think so - like some "deferred allocation" despite of
>> mlockall.
>>
>> Please find the logs with the below patch applied:
>> https://nextcloud.swupdate.org/index.php/s/JXNW5bJrB3fQo5E
>>
> 
> Thanks. I need to analyze the fault flags next week to see if I can make
> something of these, but I just stumbled on an obviously significant fact
> when looking at the multi-CPU view: the memory compaction daemon is
> running asynchronously on other cores while the responder is taking the
> fault. Compaction is all about moving memory around to free larger
> physical regions, so updating PTEs will happen as a result.
> 
> Moreover, I could not reproduce the issue at hand, but I did not have
> CONFIG_COMPACTION enabled. In the meantime, could you try disabling this
> on your end, to see if the fault still appears?

CONFIG_COMPACTION selects CONFIG_MIGRATION, and that is well-known to be
incompatible with RT. Xenomai 3 is warning about that that, EVL does not?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

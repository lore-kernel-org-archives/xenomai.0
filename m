Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7751F396B7F
	for <xenomai@lists.linux.dev>; Thu, 15 Jan 2026 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483783; cv=fail; b=Ideh9BQfqzTrMe2mbak0UVQGQj7oVfDFdx9o0Wp4HKboBYgv+j0WcK7YIhILdMmBx7vw6lVIuzkcOQmNKFjtrwdR6kG3sAauGnHOBajnYXNIIMjk5XIu7ywOd58Zclj+wSdSTVmJ5dJ3R8zAsNMw3P/zplkFnQ5dFbq8/gYgPSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483783; c=relaxed/simple;
	bh=fr3pdd1IxRfm8vfBR6+BEc3uAVrKEnClgbPqxzybt4Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mBRVYErQ9Ynl07714YdvEVVrmj9QFIZdbw1FzedkBuohs22ba87kQu+AINBsUouKfdpa4N7Jb0RLJv2qdroJXhzEuGRpVwDI9XxH461o4NYFOe7zje+nx8st4OoDCSlx0/enSQfcATJ4sDvXQBV3qpHXHIYt+BfaAEpaUJrauKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wYeFpWSL; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wYeFpWSL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTSphjr1FPhB1glONjf38Kxn6Fi8zLv4XlRqIo2htFoCzq91ImtYI6zpqt47bWZgXeJiJvvobA2pw8/E/HBIXgdSnvn+cJ3eAZqfbwnjlWIhAbBXMOnVMGf2MaJYLF4gJKsrz6uThgTNZL/t3crgj8XT/CP9QQwS+5Dp+2k538EfJJEqON+mu6bwKzMV1RroKQLaoRnE7SIkpk1l9mF9k1PMvtTsA/Tm7l8awWvCoioiSizukFVB8zILv0kHSOW7K7Oor2ngwb13kpj33W942jC7wXi4KmyqdyDwi0BLT9F36MB5AMvoJdU84jToM3b93V4AsHMqpntgeBQi4e5cyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8S2tT5DEDCobtLfgk1a1CF3Z+9LiPu9Y/L4RRnrat0=;
 b=FJZlcVKSg7ZCJ6Ok/LEAlkf9PtrAOQYEqm7xMBLpu+cpeXhqaOy/ArWH2jukZkfjpchS0JDldDrE7AQjZItkKI8zItXsZ7prtItuMEHDdJj3DSvsLg2fEqTONOD8V2+SpTM56lP3WvJRlZqN3SQ8+hMzyzJkQGNb6NBxdxbBeH/+pksmLCF17utRcFJe2+8N8UK1PFYZU1eIzMlRXdlHUXBqFjC1lWc6fvr4Ib18jpoHDK76iSwBPEnlbNZlUzK98H0Yuls7+OlVhzYUS0mQxz49VVYjO+998KiIYd3gEcw4bKeOhOxhMFHgyhKaBTR8t+FR3PCL9Id2f31S2nNIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8S2tT5DEDCobtLfgk1a1CF3Z+9LiPu9Y/L4RRnrat0=;
 b=wYeFpWSL30p0IxqLOpAda2daKXeS1yISZd3JU8xbabvOa2MLbKE6kNoWS6upqroapvACrrAVd6lfk2DV0h+fjgSE7nbhc3CC8dKIfCvhILe0qCf/+Eg8mE27HLe4t7hVFrgwZ2Qn/qnQdm/kvdHzoY1QQEkYRbE2nu3Pl8Yt6XhupvTT78t5kd2rMZbwVtNbVB8R8CzGIZc8jxFQ+bLycwqTH1rjhj8iyJ7/pTVr6cdwIDs4SLXht+99jrPLWMNejpkx50eStXxOWy+ThExAhgiNLt0KyeMNOvZpwTAo2DBX/3+GyVFUkKkT/kHpjMT+jwtHjHFS62/9N1nR1Z5Z5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB8918.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 13:29:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 13:29:38 +0000
Message-ID: <5b5e06e8-aadd-4b1f-9caf-109ab67ce257@siemens.com>
Date: Thu, 15 Jan 2026 14:29:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH 2/3] README: describe CI trigger structure
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260114095657.2440127-1-clara.kowalsky@siemens.com>
 <20260114095657.2440127-2-clara.kowalsky@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260114095657.2440127-2-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ae1f63-921b-4d6d-8395-08de543a2195
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkZ4WmFkVGdZdzdZYjdWaTJaaHhSN0ZoRytmUFFXZ3hqUkE4dWc5Yk1DZnlH?=
 =?utf-8?B?bGQxaVRjZjRMVkQ3VFpJeWJQcjhLNVgrRFFNMm1HTE5kLytZUm1rQXE3aG5K?=
 =?utf-8?B?cHpIcWFpZDBsT0NVNWROUjVicmJ0V2REU1hMM2RROUlyU29JeGVrRDd3Z0ZU?=
 =?utf-8?B?bVllVVk5dTQ4ZmJEYW0rYkYzb2JucTc1RERWZStZeG5HMHFXcjEyUEtrVHZh?=
 =?utf-8?B?ZjY5K0MzNFhoZThaTWdQVVVyMTBHdW9lOGV6QklrcEs1UUNCZWpaOWlQalNj?=
 =?utf-8?B?RDdWS3R4ZFJqS2V6V2FKeUxUQTlUMGZOUFEweXZiSTlrTStYNUhqOEIrb1VN?=
 =?utf-8?B?cUZqUzJNck55U3A1cUxuelEzbTI1ZTE2TGJmb3RuamxWK0pyRWc3ZStzNW56?=
 =?utf-8?B?V1Q4QlNpeDkzb3JoTk5RV05pbTJGQXcrZjZ4M1Q2THdkZWhMVFpNWWZtZ0Ry?=
 =?utf-8?B?UlAzYitmYmxpTlhyaklTenZxRVZNdXIzWlFyL21hMmNkRUp3eUdlOFRTZGJL?=
 =?utf-8?B?cDhUNmxCejFqZjZCZmdEL1I1Sm5pelhDb1h3OHVZZFk3aW1qbU5pUUZoMU9K?=
 =?utf-8?B?V0JJeU8yZFdqd1JaeFNqbTZTaGFuODcvbUo1dU1Hd3pIK3BHVVNROXlCMFFp?=
 =?utf-8?B?dWRSaXU4R0RQWmhHU0J3c0pHWW9mUDV6a3UydFJKVU1YdlMzbkV4cU9PNHll?=
 =?utf-8?B?Z1ZVdXloS0Z3MTZjSGhPNDdMeFJTZ01ualRlU2lhcU1BWkRyV0lqQjNPNTRN?=
 =?utf-8?B?TGlJNDVlUFhIN05aOXN6V2lzM2lMNjhNNms4dTFSWllIN0xDRmNGNElwSGc2?=
 =?utf-8?B?azNidkYvYXFjL2pzUlEwcjE2bXZFalBJQ2xwd2V0OFRUZmp2SXc3cTRTclY4?=
 =?utf-8?B?UDZ2VlVscFNObm1SQlY3djVzaEVyTTNxNGMwVzNtczBYN09RVlFMTUpTZ0R5?=
 =?utf-8?B?THBXWFM5R2VzVTFPZDR4L0FvUUhjMmlSVFlpbGtGelpuWlpIQWZyV2VsaUw1?=
 =?utf-8?B?eVZIVi9GM0hseDIzWncvWDFPUDZFMFB2N3NCcmJudjk5M0tTYTVmYlJCMm1I?=
 =?utf-8?B?Z084OVpnYkZTNG93R2d5RTRlVlo4b2NPWHlxdS9BVnlsWlJONE1pZkZxMW9B?=
 =?utf-8?B?K1p0b1A2KzFFVnJvdXB4S01ZcWEraEoxU3dmbzRPaWhGbm96VDFob2xBKzN0?=
 =?utf-8?B?SzNVbjFqeUxUNnkxTkNKMS9BN21DTVNuL1lpSldKbFpWbjVLNGNQdXVRTEZ4?=
 =?utf-8?B?MU5ZRFhRM0lDZ0V3UFB0Vyt1ZW9MejJMaGJlcTdJZC9pQlNWNGk2eVFsTGtE?=
 =?utf-8?B?YlJ2OHJBcG9HMFZTN0NJUHIybHFNWEVlVzR4eTJnSE9SMm9XTnlxREFVVVZR?=
 =?utf-8?B?OGpUdVFiQUtGb29xbGtMMVNEUERFSElxbWx1Zlk2N3dSeTVQeTVNS2JVMDY5?=
 =?utf-8?B?Ni9DUU5CMXhVbEQ3R0lNM2Z3OHU4MGJIYy9KeXdrTTVOeWp4cldtcTVDNHY1?=
 =?utf-8?B?ZSs5MlpOMjN3ZldzNDdSUE00WVpaK0IyN2J5cld3SkNzMEFRNzBvcHNiaWoz?=
 =?utf-8?B?SHdnblppNXJpV00ySUN0Tk5OR0VGOWhOa0JZSFVyczdtazRyZzJBWWJRYXY4?=
 =?utf-8?B?Q0F1WVEyelBlalBoOUUzaFYvRkhTSXJCcUlGR2V4S242SmtDbWZPVWdpVjR1?=
 =?utf-8?B?VmpEMzMzeXpuemNIU3ZpbnlPc1VoeXZUTXllamtoN25lWXVGNDRNdzltNUFt?=
 =?utf-8?B?OG9GUEo3N2JiY29NU0I1VFA1L3pBVTc3Q1RpZS81RjlCYzhKU1htN1pNRE9V?=
 =?utf-8?B?R1d1U0NqMGxQdGRLMXJGWUZOUEFrc3BsVFlnUzRMdzZPQmhiTUNMZENueGtK?=
 =?utf-8?B?WldZcXloUzdOcFZWMlZHUGp2WHp1V3h1M0NMNG01NVdSVnd4Ym9JOWtCK3Vw?=
 =?utf-8?B?UjVMTEdwYWZ2RU9JVzhid20xMTB5cy9EOSt2V3BDdG9TWTRva2VvWHJpS1VT?=
 =?utf-8?B?NnFWVGJlL0Q2NjR4RUpUYXhQTG9BaDJZWFJWVU1aK1RNU2FHVFJNWCtjaEY0?=
 =?utf-8?B?NUxSd2dZTzhjYytja3JlZURZbU5PU2hzZlNKNTdWbXBEc3RPalVyeHpkaW5j?=
 =?utf-8?Q?KVpc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFBEM1c0aHdRZ0ZqWTdXdjZYaXFFbEdNaVVYTDM1SWlxaFNEOWx0bm5vU1JL?=
 =?utf-8?B?VWQyVVAwT0NtbkVieFEvb1pFQVBUMjFpcXYzdWZyWTlIQWk3M3VldktuQTZ0?=
 =?utf-8?B?RnBNTU16cW5vNCtndzRScUZpWGZxR0hGV2Jmb01PSThXbXJMc01lSXltWCtx?=
 =?utf-8?B?dGsrSjZwWThmVzJETnFGRVdkV0VkZExSR05VUmxhZEJoVGxVNW10VXI2bGta?=
 =?utf-8?B?WEN4Ym9YL3ZldXNyeFJBNTN4RFVWUnRvWUFhT1Rja2tIeXk4MU9xcjBSVFl2?=
 =?utf-8?B?SURndWcvcWFROGVjQnFwc2NCc204cUJwSG5rUzdrSzI0cXVlTU5nUW1EcGZJ?=
 =?utf-8?B?RitrUG4wSm84ZHV0T3ZqZmFNaWtUZElIQnErdm93RWsxVlVkcmZsNTBDK3VU?=
 =?utf-8?B?TzNpUklLQ0ZQcng4bUxPSWVCQXl5T1JkNWxEUjZ4RlczcElFL0xGM2M3VVRt?=
 =?utf-8?B?Q1Q1WVpZdlVzMnYrbU9LQkxvYlpuL1JlUFVFWXdOa2FETTdVME8vWkwrUVBY?=
 =?utf-8?B?UjNxdEN4RXdiMTNaeXV5Z0RqNjFtY0t1aWthQnV3VHc0NnlOSFJjWUVLNGxl?=
 =?utf-8?B?R3hhZ3oycXdZdHFudy83R2tXWVVBMFZPZUF3MHNXeXFDZnp1N2FNU0JWdVdZ?=
 =?utf-8?B?NmFpbTRUNGpBeE1hVlVxYlBvbEJndTlDeFBWZVMvdUhsQnpTVktCZUdpTHdr?=
 =?utf-8?B?NjRoa3RHc05jU2lvam9wUFk4QUpUVUNlZmpCQXJZZ2REaU45dzZJdjhNZ2tX?=
 =?utf-8?B?N1NJNW5TL2xGU1VSanpTMkdicVlnZGFGb1lGRktBMFNrUkxPYk03U04zMGFu?=
 =?utf-8?B?R2JHbjVlRjFTekZLY3NJNGRlZW9ocm81VTVSSnlaUFRpdGRWSzBuRC9rNHJw?=
 =?utf-8?B?bDFMUFlWUitVaktGbnpGM2MyTGVXQ3o3VnVkdG9wWldhN1JCTlJHWlJQK1h0?=
 =?utf-8?B?cTBUOENrVE9FRUF6aHYvWjNhaHRlcnZMSFA5RFBnMmdCN2UxYitiY2JNMytL?=
 =?utf-8?B?TEVSOHpwSDdjOUFnTXpUYUp3c2phVEFOZkhyRWRNUDgrZFBySmlnT0lqc2tY?=
 =?utf-8?B?OWROcjFpOTJwUldpMHBXSHlEeWIyczFKUWZMVTlGcjFHQVRWSThoVzl2Q1Zi?=
 =?utf-8?B?WWFLOXAwL2RSU1Z4bGdTcVBOTndyK0ZDUytzYlMzSElOUXc5WEhNQUNuN1FC?=
 =?utf-8?B?VTVXTVhzR245bWlEb0h3bWwzeGhkMjk3UVV1UDNIWjhaZnlPbmlYbytXUEZO?=
 =?utf-8?B?Vm9qYW81YTY3SlNvbVlVRkNUbnMzUEJxOXNPWHY3YnNMZGZ6THZ5V0d3NkFV?=
 =?utf-8?B?U0R5aTFHQWc4TWpJaFhsUm9uSk9xdGFVMTFwZklrU3NIUkJyeklreUlqb040?=
 =?utf-8?B?ZThFamxQY1NvaWFpWDZPZkpPMGtiekxGekd2cWNIUkJhRVFrajF0OThNcjd3?=
 =?utf-8?B?Z3FLUC9oM0FJcFQ3cGdadXVFdEhvWVV3S2pUajJBa2ZHbWZYTGx3ZjRJdnVx?=
 =?utf-8?B?a2orWU9oZkVtODIrN1p3S1pEV0xycm1GVkpqdk9rbjdwdW1sbkZVSnBNanJH?=
 =?utf-8?B?MmR6RzhvUnVta1BuMTlONVViSmx3M1dHVkVVZlUvN1B2NlVpR3BYaGl1a3Ry?=
 =?utf-8?B?bTM2bGR5R2g3ZmlOZ1JZd2l4WWF2aUpmSGNOYURZYTY5UU1sejJlTnpOb2dZ?=
 =?utf-8?B?VEYyayszbXNMN29Xa3FtbkNmMG9maVBuOGZteENvZTNRelJDMjVPOGRvZGxU?=
 =?utf-8?B?dTBWSDFTdmFxUmhLQ1pvSnltVWJxSFZlalluamNqZXJTZzZaRDJXak5WdnJV?=
 =?utf-8?B?TEZPTnhYUXdlRlVLNDJrdFdtaFRILzVSNlM3MGNFN2lkUVZOOFlNblFaUDRI?=
 =?utf-8?B?U0dKOXdOZFg0V0NVQ3JZMlRkZnFRY0xjRDNsSWZ2RUF4d1c3d1dNYS94d2tK?=
 =?utf-8?B?L1hrbXg3K01Cdm5WSkpMTlBVNXBPdGFSekVTLzYzMmFXM3hKMURCSW5wOU5S?=
 =?utf-8?B?Um1lTHgvWGdtLy9IL2VuMlAxNEM5ZVZSWUlZenNwOGZ0ai9wblZWRnNyWEhv?=
 =?utf-8?B?dG1rVHBrYkdRZ1NSTVg3bEZleU11MFV3ay9wWjJhQW51QVhyMnZxVTRNVW4x?=
 =?utf-8?B?Y1VKK1N4SksxcHlkNll0M08wRkxxM2ZwRFIvaFBRWGtjdDE0WEg1U3RFcFV0?=
 =?utf-8?B?NVJ2VTFRTkVmRWlYK01mUFF0aS9pa2dTemlqQi8yNDBFNFRhTmFBUFdaV29X?=
 =?utf-8?B?cTFJTUx2cWxYSEM4bUo1ZUtOQkFjeVN2SGJXSTl5OXdVdnl6TEZVN1FwSmNX?=
 =?utf-8?B?K082ODhqQUdKYm40MTFkWDl6eVdXR0poL25NTU50OGJZVHlEbnZpdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ae1f63-921b-4d6d-8395-08de543a2195
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:29:38.3605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSY8pLIP6sB0xFk/Ka4mOtnRJ8VDZ6iLCF5Z7myZ6lpFC7SlJ0i23Wq50suV0fHSW424PWzT9/raHhPLr9FoEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8918

On 14.01.26 10:56, Clara Kowalsky wrote:
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  README.md | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/README.md b/README.md
> index 95350cc..ca602d4 100644
> --- a/README.md
> +++ b/README.md
> @@ -49,6 +49,22 @@ Unpack it and follow its `README.sdk`.
>  
>  ## CI Build
>  
> +This repository utilizes GitLab CI for automated building and testing of Xenomai images.
> +
> +### Xenomai 3 CI
> +
> +Pushes to the [Xenomai 3](https://gitlab.com/Xenomai/xenomai3/xenomai) repository on the `next` branch or any branch starting with `stable/` trigger a pipeline in this repository.
> +Have a look at the `trigger-xenomai-images` job in the Xenomai 3 repository's [`.gitlab-ci.yml`](https://gitlab.com/Xenomai/xenomai3/xenomai/-/blob/master/.gitlab-ci.yml).
> +The pipeline triggered will then build and test images for the corresponding Xenomai 3 branch.
> +
> +### Linux-dovetail CI
> +
> +For the [linux-dovetail](https://gitlab.com/Xenomai/linux-dovetail) repository, pushes to branches that have a corresponding kernel file in [`ci`](ci) trigger a pipeline in this repository.
> +The GitLab CI configuration for linux-dovetail is located in this repository under [ci/ci-dovetail.yml](ci/ci-dovetail.yml).

...and need to be set as external gitlab-ci configuration, e.g.
`ci/ci-dovetail.yml@Xenomai/xenomai-images:next`.

I've added this.

Jan

> +In the triggered pipeline, images for the corresponding linux-dovetail branch are built and tested.
> +
> +### Local CI Execution
> +
>  The CI build can be executed locally by
>  [installing the GitLab Runner](https://docs.gitlab.com/runner/install/).
>  

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

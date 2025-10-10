Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724B36124
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105334; cv=fail; b=l/3zcpThWqZn/pl24UUn630E3/MAlu8XI4l52ssGbDZsf7T5MIMgQfz1CcxXH4qLFrALCssbwq9hCm7GPkfW6TPHtF15W72DtEz1Wr61HB0JQJ7znyvfZljy6Xk9U8qA45tmjTA5ZGQD7PBjPChsZW/unbpWnA6+4t6vjXn3oLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105334; c=relaxed/simple;
	bh=DGo8HR+a4Q6IyVG5XVJe+2M6HLBoQpjU6Yi8dkwWBH0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TbJncNPRLn8MFrfty/QTmp+k2m+3Au9uqX/oYBj4EP33TrgQLd2i6TcmUqSVe91vQNutncOxWwD2wNFzpPBFZ4QEr/RTNI3XbmVcs1v7rHnoJcYjz403eEsrmTpdww+cvT5YUts8NCvfQkIgGdniq25gfAikjCce4fTOcF+BE8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XasQNldC; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XasQNldC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKrRfFJhFIHyR657mcw8BmmPgBVxl+t64j3+MOhETaONMxKSc3fY6mvJTJ34MxHuAi2N+NJVCJoSz4b8V7HmLdv23RumYEhhVfooI3a1MPw8iMxg9uu6Bchjq+TYBuqZiL8S7hjOAiCYo59amWdIjd5u/B620d9rF87x7vtS5mrHQH+hL/YaPP8ZtGrqPyVsboUpdUV/3C5FStjEO06YAc2m6wNTnSLwt4G/SVYRVEpDGVW/E5EUGlPXsaPTSwHNvOVmOwnBs7CZ0xoxUpZI/u/ca9T2gGcDzpRH/TK9ZieACeB6ZDuODYYQyNk+0wVmtfmQDAuDh/zOlY6WInIDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlBHkLyaH1T0sv6AsTz0jEdTi9t7bJ3hlB6E2455RMM=;
 b=DR36bep9ZrCln7vzdCzz0AVzeu1lIpVxZ3DmMIrLJqqKCRZlhqoAa6Z0opbALynWf8eoL2j26M9YYaUi6MZOj6y5l0SIZs6tl0OxHMEUGhbEXVqdDwUWhY3vfoCwRu5h/eDWAP1Ucw4j5xa6qrxRrhsy2aTnkp65+UXqcTDyZfWK7y9BptJZTW9dhNd1zjgU4EyapfT3mmkZaoA+Np1LLpX1uAeuF8hW0InuJKAlh5ZZ9AzFRjH4rv0bkj3BvUNH7OPuZRMh7sel59Fo3VQVMfkZvejTXOyUjKiToVyXOEMgFiOCiR60BfTOTcgIIduI91HRu8omKoFIKmNLPRt5kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlBHkLyaH1T0sv6AsTz0jEdTi9t7bJ3hlB6E2455RMM=;
 b=XasQNldC+p48+8W6FMxzSxKcd8y5YPBiCUMBan/BFqe/I7qCF6812CrWsZg+/qg0wN0zq+MK/ARUtsWJTNeb17E6P0LD+rspu9hwcqkukSlTL72gUaAk2DhKTvyUDBfYHbrXpGvQByyitN0T7FXbMssSVdcrOzRrmSS+FdHA+3o/H7EUK5VGcPNbb8Fno1O1d2VXAKfimtn82TVMRnHSCUv18FoMfdUyOPM7YFp4q0fOk+YxJ85r8KcrFyOaCMCIFXuKak+ovcdn0vB/XWYs1of574HfCCGdnkAKUhF1W4MQeSNKToQ3Gjbc7IhwlRRmEQSPmEqCla3KhixwAjWe0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS4PR10MB5272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 14:08:49 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 14:08:49 +0000
Message-ID: <73e0d573-6e0c-4e73-a62e-d80f811dac52@siemens.com>
Date: Fri, 10 Oct 2025 16:08:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-xenomai: Add arch specific debug kernel
 configuration snippets
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20251009111228.3504354-1-tobias.schaffner@siemens.com>
 <20251009111228.3504354-2-tobias.schaffner@siemens.com>
 <0e60ea350929090e70354a5ff705348f441ea15a.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <0e60ea350929090e70354a5ff705348f441ea15a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0389.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::7) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS4PR10MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: 876c58d0-acb5-4907-3c74-08de080688d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K054ZVZYRHdQN1Q4VW1ORWdUUUhtSlU0a1p6L1RndkkzMUhtSUQvek12WHF4?=
 =?utf-8?B?VTd3SWhRYnB0MWRkRDA1OE5CNkk2WUlHOVBLZzhCNTNVcE42NWsvcnFBZmZ3?=
 =?utf-8?B?YU5sak5QRTVEV1lDV0RtS245K2JEdEdRcnlYU2tyQ3VkSC9MeHREWlhVMFUw?=
 =?utf-8?B?WXl0YjlQNnArcGRxcmoxV2FYYno0YmJybk5hQW5TSHZMQVJJYzA0R2gwaXNL?=
 =?utf-8?B?bStNZ1JUTU9YenRpN1FJWVNyb3A0TFJkcVY0bG5veGFEdWRvekVBQUxpMlVq?=
 =?utf-8?B?ZXcxVmFwc3U0S0VNOHFTVXo1UFlOTURndHQ5bGVkUjVDTWd5eXA1NWNTUHpi?=
 =?utf-8?B?T3ZURmhFaVo0SGM1STRWU2FuNW9IU2R5clRpQlBUYUZLckN1a1NyMFU0YlVq?=
 =?utf-8?B?a0hrTUFzZ2t1bElrM1FrU3MzZURZTVZqejlhUE9nZ1A5YVE0YzZmN3lNMUla?=
 =?utf-8?B?aXNlY0RwUm5ETnZoaTRRcmZNTlRkZ2YzMXF1NVU4dnR5WGs3b25RSWJ6UExp?=
 =?utf-8?B?SUtGSmd2bHZrVlk2TDVzOG8zcVhOd0hKcTBqa0VTcTBjUjlLUVBIcW9wR2Yw?=
 =?utf-8?B?N0tSYlJKTkRnN3FQK0J6MlBrSXFpaUNCdDAydytXNjdLdlZFbld4dkN5bks4?=
 =?utf-8?B?VnAvV3NPMG93RVVFWXRYbWUyWHNaelpXSDRPQkdRMkhqQWlBMnNId25rV1ZZ?=
 =?utf-8?B?VUhnUk02RWp0Q2JTWW9hQ3RMVVI4UC80aWtuY0pkdmtuUzRqNE1DWGtDQXFw?=
 =?utf-8?B?Qm9WeUlmbGhsN0pBRXN1bHJzT0VRTHU4TzNJTm9PMDFEUmJ4a3BoeXFsOXVx?=
 =?utf-8?B?dklKcEFSWkdGSm92MXFhd0p4SjFhSTNRVDhyUXhLVzdMVXdNQ2F0YUxOVnJ5?=
 =?utf-8?B?RDM1OHVvSVUrcVpjcUgrUDByY2RUV3ZJUnk1aWdlRVQyd3ZBSFdmMGwzSWpv?=
 =?utf-8?B?Q290Tm1pS2ZyS3Jrb05TZ1JLdzQwU01CNm41VFNtN0U3QWd4VDJOMzNGa1dO?=
 =?utf-8?B?cHJaN3BjSmRtSms5SUdsS0RkcTg3K2hiN3pMR0d1YXRJMXA4RUd1VmxUL2tB?=
 =?utf-8?B?NGtwN3ljUUJPZmRJblNzd3dPWml3eTBvRlN2S0E1OGhSamtNOEY4ZFNMbFpY?=
 =?utf-8?B?VjNhcEVDbG1XZko5TGpNTVpCV3c5YmhDb1FlSDJITUVSc0IwNUh1bW9MWWs2?=
 =?utf-8?B?UzQwS25TU0pVYUxFSFZDVzhiMEZuZm4wL2R5V0FpMm1oTXdqM1o3SlJ0QUtJ?=
 =?utf-8?B?RStDdnpFemppdlprOVhYVDNmZWd1WG5pSWdVM0E2alhsWEMvOERzU2NkUG9L?=
 =?utf-8?B?TmZLSGF6WG1ESWZBWGFxY1FZVmMvdS9sZjZJc0hmYnhjcXRPZjJHSkxnZkFv?=
 =?utf-8?B?cEN0dGd2R2tjMkZRY3JuWG9vV0FhWXBwSHlEVjRlSWNkanFEWXVXcTk1MzVI?=
 =?utf-8?B?OVJhSi9YZWQycWZmUjJNVGJoRVBLYkFMQkdUaDU1OGJ5bE1sZGd3MWtrUG52?=
 =?utf-8?B?NEp5L0hkMklPSlVPWjVucGkxbkZzc2pBb3pvNDNYZXE4QWlVK3VMTnoxNU5i?=
 =?utf-8?B?VmdUY1FaNWN1Z2drVnk0WUxHK1U1Z3haVDU1RzBQRUh2K3dwZXd6V2tQaDF2?=
 =?utf-8?B?UzRwYnZNY0kxSnp2VkE2Y0E4Rng4NmFlRlUxaXJLMHVMLzlWRndmZjVzRWVN?=
 =?utf-8?B?Q0t6QnROLzgyZnlqRXl5bVRaMFAxMGUrUGdzSjZVVnFVYWtBOGJYbVQzMlNB?=
 =?utf-8?B?TkdET2lrak9uL0hFWnphcWxkUC9OR1ZXa1NvMEF2SU9FSzJqaWwvSGliejZs?=
 =?utf-8?B?TzlLVHJHck82eDd2NUlOc1ZUMEs5UEJnWmJXeGxKbWhET2NQMWQzblVNbTV4?=
 =?utf-8?B?SFoyNjA0OUpmV1VTWi9BN0pMWEZCSzBQbUluVkFyenczdUpIakRVdGFCejJp?=
 =?utf-8?Q?Fe7woX0MNQd4b7MNGnYvBxV1N42ez5UP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2lXOUt1dWdWQy82bmhJcnIwR296THJhWStYMzZtbk5KTFpNNkNGWUd4ejd6?=
 =?utf-8?B?bkpFSWZOWUdKK0N0ZkZ2R2huQWJtTnNmaDZjV0JzWDM3S1ZEaUNXdzJod1U2?=
 =?utf-8?B?djlLQ0pSNnRKTW9vOGUwaGMrTERldGMyQ0tKWmZWSmFLV2I2aGV3ZExvWGZK?=
 =?utf-8?B?RzFNWjVoQTJNNmhrOVo2SU1YV2lVT3lVMnlvUmtDVnBxMDdDUHVRSHlReTNB?=
 =?utf-8?B?dXRwOWsrODRLS0hoWEpwU3g3QkwrVFVXcVhGVzNZS0JEYzZZbVBUR3diSFJy?=
 =?utf-8?B?U01sUDIrdDRKaFdkeXF2ZVpJTDdwYVRrRyt4eDJwN2d1cXZiOC9IVjI4WWZW?=
 =?utf-8?B?WitRNXJqMXJta1pFTitvUmVKMFIrTXB4U0hqU1Zud3hSMTgwOFdFNUNWeGZ5?=
 =?utf-8?B?V0dBSGhZRjhLRnNLSWNIUTJuUjlIM1FlM0tsNitpYnQxcnFncWx3ZUY2U3RK?=
 =?utf-8?B?aUU4QjZwNmlrVUF4b2FVdlFuMFVUSTdzNW9nVy9abTIrZmlUa1E4ZzZXRFJQ?=
 =?utf-8?B?L1ZEUjNiTVJIMnR6UVFzdWhEajN4UkVoWnc4MTlEZmtJbk43QWVLNVdRbXlD?=
 =?utf-8?B?RktET3J2RXZFWFA5MjdJR0ppUE9aR2RidWh6R3MxZXR4WFVwd0lST2J1czB0?=
 =?utf-8?B?dkRXV2R5YnZBTVh6UFlERUxRazlEeFJWd0lWN3VCdGozYW9WSTFLTjZHeVk0?=
 =?utf-8?B?bFF4dy9UdHpod05iaFprdy9BWEJDVUNWS1pHU0JNNmdTYmMwYzJ1Z2ZCR1pz?=
 =?utf-8?B?WjZGRzAzL0xBRVovcFFuZG1tK2FVdzZHeGFsa3NqRmhwUWRzek96N0diUEk2?=
 =?utf-8?B?WEU2U2pmVTZjYmJLY2U0VlJub25mcWFiQTFtRjhtcDBhRG5aOGZQWm1OTFF1?=
 =?utf-8?B?M1lRaGowUjJZYmcxTk4xdUIzaUpiOTRvQktKTTVibzdpMkR3MEFNdW9lTnFZ?=
 =?utf-8?B?UWhHd3dQWlZ0bHNLMStJNXZaQzU3L1FoZm9lMVUwYTJBZWtldm1SV0ZhS0ZE?=
 =?utf-8?B?QzVvR0duSExRNEFycDd6YWMwZ3NIZjNyRjRleFI0cmVyWEp5VEpvN05VOG5Y?=
 =?utf-8?B?NktOVFE3d2dOenI4VlFuaVNyQkRaRm42dkhsVDhTZ0J5WWZkR1NWZjNPRU1N?=
 =?utf-8?B?VGI2T2tKK3JneXJ3VXVnT2tqaVBtNUtmdkNDTTdOODV6cmc5bmhzQ2hPR254?=
 =?utf-8?B?MU1TM3lxWGt3Rkpia0ZzaEdYVEpXODRsWUlQdjlLTE9BeWRBTk51M0gya1Bl?=
 =?utf-8?B?SFE4RTdHUWI4TzArRHpxalJhRDRsZjQwMkJhM3QyTXBzaDJXRjJvamZidFRk?=
 =?utf-8?B?Vmppa01pOExJenFoTlZGMWNuanFaUGs1aEMySjhCdHJTMU5SNjhDN0hUUlgz?=
 =?utf-8?B?K1paeXB5Nkc5YVZxcU5sRmlEelVBUnoxYW5MNUc4ci9zRCs2cUdicSs3WC8y?=
 =?utf-8?B?R1FiZFk0VVZUZFRkZlBIWlRoL1ViZ2ZSVkZ0UDZ0L0dNaFl0OGFWTHFxUnRm?=
 =?utf-8?B?c3hEdG1uSkhTOXlSdGV0bnV5VlRyaDI2RzBxdVI5eWdMVE1GUUZQSUZpRmtZ?=
 =?utf-8?B?ejhpWWtucWdyaFhDMU1keWxxOGZqeTVtazRiMlpnVkcwTVk0dC9YY0JQY1pj?=
 =?utf-8?B?ODU4b0g1bXJrWEM2Vi9rb2sxN0RWUFJQYnlYaVVnT0w4OXJYVTE0QVE5YWtq?=
 =?utf-8?B?dEg2bDI4STM0YmoyQzBBQk5ta25CV1FONGRnK3RDOG5ydVZyQTBxdDNCZTVS?=
 =?utf-8?B?aEJCU3o4blZ3NWJDalRDSXZHZGlpR1BtRGw3eFdIVDBpbFd6cklFNmdkUGxD?=
 =?utf-8?B?bVhKYkEvQlR6dTAzTmpqdW9nWW13QzJDSVZENlRqWWlEQzF5azVFYTE3Y1g2?=
 =?utf-8?B?Yk5jTm5oQ00zQzg3Z0twVnlSakl5WHNNamY3clF0RWdhVnFld0NsTDVLdnFD?=
 =?utf-8?B?U2VGUGdscXMxUGhIaXdmb09qdTdreURBZE5oUm12bjVZNVpLY3hmK0dRc3Ru?=
 =?utf-8?B?QklqY0taU3ROeHZDdkRGUkpOaGtiRVNYbmwzVnh3L2FzMkRyeGJ5M09yTFdD?=
 =?utf-8?B?Z3hvZS8rcVYxZUwxSjRpK2Uyam5IZkZtTHJyVm1XcHVZM1JNQ3JMNXR6UUFs?=
 =?utf-8?B?c1UxSUZlamMvckk0Zy91ZEROQjBrQ1NSeXdPdit0K0xPVWx6ekdMTDdqRVdp?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876c58d0-acb5-4907-3c74-08de080688d9
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 14:08:49.3962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOeI8YeeHFmw7hqnN4+5jt641yOo8q7dzgIbpzHYnYs2XgdnpNywVgYs11Vj5VnBbFlOn0x0HfUmncSKqrZcYq2+GdNY8IKeofbXRmfJb+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5272



On 10.10.25 15:16, Florian Bezdeka wrote:
> On Thu, 2025-10-09 at 13:12 +0200, Tobias Schaffner wrote:
>> [snip]
> 
>> diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
>> index 8c7df40..501c212 100644
>> --- a/recipes-kernel/linux/linux-xenomai.inc
>> +++ b/recipes-kernel/linux/linux-xenomai.inc
>> @@ -16,9 +16,10 @@ FILESPATH =. "${LAYERDIR_xenomai}/recipes-kernel/linux/files:"
>>   
>>   XENOMAI_DEFCONFIG = "${DISTRO_ARCH}_defconfig"
>>   KERNEL_DEFCONFIG ?= "${XENOMAI_DEFCONFIG}"
>> +KERNEL_DEBUGCONFIG = "${DISTRO_ARCH}_debugconfig"
>>   XENOMAI_DEBUG ?= "0"
>>   
>>   SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
>> -SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
>> +SRC_URI += "${@'file://${KERNEL_DEBUGCONFIG}' if d.getVar('XENOMAI_DEBUG') == '1' else ''}"
> 
> NACK. This switches all the CI builds to no-debug.

No it doesn't. XENOMAI_DEBUG is set to 1 in ci builds by kas/opt/debug.yaml.

> We need all the debug flags enabled for CI builds.
> Otherwise, we risk to loose really important debug information.
> 
> no-debug builds, for example for performance measurement purposes need
> to disable the debug settings, not the other way around.
> 
>>   
>>   S = "${WORKDIR}/git"
>> -- 
>> 2.43.0


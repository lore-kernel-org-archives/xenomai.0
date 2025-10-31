Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5465434D385
	for <xenomai@lists.linux.dev>; Fri, 31 Oct 2025 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761922660; cv=fail; b=aL2d9e6NaU+jYTBK8sz/ohy05ER1LJZ3HtrzsAIwEAV58hB7+TKlYCF/AYjtxa1xQZsQSagxT98J4yKOWvJ6YIMOiyCZgbrnwuGLomxZBBD36B7o90cFsg5kmY6sORQTnleMvKz2HKLTMmz1iJlbB8uOyUldVOv/sLxm6JpoYlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761922660; c=relaxed/simple;
	bh=J6jI1FafBE9HhH/Mvav6DGRXhyH3rrzcHfgDCORkZE8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cxjRUeAFFcAH2jcLJpcAFocPseG2moxOGKLP2jzljtiC1D+UMY0yE/fGUGbyOZnLs8tW0ib3TyQMqwTKRoIcQAWvlrLeL0VREmipBpKf84h1IbBXv/XGS7O1QhHsd1AGb6Je6vMTrL8359aFaL6WzQO3hSSj7p3rTRUuPrUY8rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Q2fLrVca; arc=fail smtp.client-ip=52.101.72.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Q2fLrVca"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/fcPbyqPrBQCq7O01xhhCbNRjOt+KJH4Fl6+QUh3QOjsI/8hz1ZLjo2WZNlhq9ZN/yqGV/gRO/DYBB9CfVzhfdo77LFdE+FUaTahP3txghsbWSauyU6x9SWuGG6xVo2caxsNuRmkiE//bonZpXhLUElIOm39bExJq6YVwcceMsklnv+jyfJfQA9sTFi00CEzO3XNAE11O2ACwbSOP5yBuz7NVl3hcirv0kEoXz0wsM4xzyMngwYzeCHMUbp7sxvW9YTmahglLVJ6ArxdEaIJjkpwEe6PMCPS1u9SWnWxMyhTb+4mQyKmw+2w1V1WCJCAwODibF1vy9MY7IoxhGBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMApHQblo0U8hkChC1Z+NBWK/9fJvVPxqge9CYber6w=;
 b=KryOy4ATmFxsVn2m3lP2eWO5iOkNUBMOF291mdAlhW33Li/6LoQaVUlUFMcvtQT6wDn4lgaMq+PDCgAdLJQXQcnXQlYZ3Hyr9vRsVc5fyn8BvWGjuVG986cVOT33HHv85pQMayzeRrsEEfHZt0B4z6oU1xIDycRPud5PdUU9kyIv6EFz93HQJeNihkRqdHQ2oQHeKoKMMU8ko2iRw83Z9vpyJ6yGUaTI2ITPoml4Q5KO06jDgx8g1FiyhXzOZXpspX/t70iI9OzDMkdHAedcJAxfcrCp36P5axuxDMqGPc02ksSVbMFyKuF3ID1FKxmw8TTHUeFsHD0SFkJmLP6SVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMApHQblo0U8hkChC1Z+NBWK/9fJvVPxqge9CYber6w=;
 b=Q2fLrVcaSBk2NoAnnv3cz/Obc8KieLneTSCiZLm1aQS9YGuzUu3m36nBKIzXAo0X+vT0hxC6Jv6ijauWRM2WHq+yInKKR92LCha4yrbptIkmwqF+VHZye1amUkYO0DhSaKqRzxlObV7UYYVnfj1N7XjFv8305W9vasdkkPYZ6PEaC4ce3y+GULI5QUD6VRs/sIUTUUrm0y2syDwQW4rdWDgOKrlcDeHMcsqWaFAAFOp797TDMXgfEaAgGT6cPrmadQlyyn3s2eke8rZvyGtaNtgx94DEGLowa4l1OstQGtFvcXa8xcT2wyLkqXxxHac50sPuZ5GoW3RS7nt8verQ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:57:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:57:35 +0000
Message-ID: <d2879030-e235-40b3-8d59-959fd96980df@siemens.com>
Date: Fri, 31 Oct 2025 15:57:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] docs(xeno3): adjust the size of the search bar
To: m.kurz92@gmail.com, xenomai@lists.linux.dev
References: <20251030155329.1337840-1-m.kurz92@gmail.com>
 <20251030155329.1337840-2-m.kurz92@gmail.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251030155329.1337840-2-m.kurz92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab2f539-4f59-4713-5c53-08de188dd35d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWdFb1k3STdNbWQ4MS9ySSt4S0JsODFaQmhRNkp3OHlzeVRjUnpUV2ZYdm0v?=
 =?utf-8?B?dlJyb2RiR29kQmphVmUxUGM5Q3YyU0NsQng5emhvRFdhNnN2aEJUQ0phWjI4?=
 =?utf-8?B?WnFIOFN5Lzhla1VCWEZKaTRwUmxJSFJNN3dFL2hlS3dmVi9mdjJPdkh0SGRN?=
 =?utf-8?B?allvakdPMWw1NzNSeU5xQ3dZMnF0cndaVWxveUZIU2pSN0JiNWNOVXZnYm1n?=
 =?utf-8?B?UjJPQXJNeG5HV2xiZFBsVnBUVlFWcTk0VzRWcVRZSW5rcGJNd1BGOHV5a2R1?=
 =?utf-8?B?N1luTnBQYzFUczBKb0FNdnNQRCtpa3lQTDdUem1GRDNtRzNvNXRyL1UzenFz?=
 =?utf-8?B?dVJkbndnNnE3ZDkrNXVBQmRCTitud1d0U1FUekVUVjZ4NGZabWNWWUVzM0VH?=
 =?utf-8?B?bk9NMHE3TTFyN2QrRzNFK1ltY1Q4Sk83L0hvWVFkaUFSQzQ1UkxlOHBLQ0la?=
 =?utf-8?B?Y1lhUHp4RXBVODJiRG9wVzV2OW1UNWZTMk1QeDR0b05YTFp1OEtiYUpFSkRK?=
 =?utf-8?B?UXcwZWZ2bXE2YkR0bWZrUEU5LzM0Y1Z3S2N4aGRocUg0UHRlQ2ttNU0yR1Z6?=
 =?utf-8?B?Y2trUVg3Zy9KYnJGaUVpNmZpRmtKQlIrLzJta2pNRmlsUnN5N0l6ZFJyYmZs?=
 =?utf-8?B?TDZ0OXZieE91emxKNXJiSHdYWW80endsWkpDd0EvYWtBSWRUYzkwK3hHVkM0?=
 =?utf-8?B?emJ4bkdLRy91eG9ONkZ1OGdtWEIwU0s0MUF2ZzhoZlJWQUFYRk9nWEU0ZWlT?=
 =?utf-8?B?eVgyRW9sSHVOWVlGMU1OejVXdE05SEhtZ290U3J3UDNWbEE5SmZZQXJ6SWds?=
 =?utf-8?B?OXBrUGsrTDZURXhVTzhzcGZSaGozRWlmc3ZPK05VRWlza29PVVM5cTIrT243?=
 =?utf-8?B?VE5xVTRLUEFzRWc4Z0M4OTJlYkZiZU01YnVVWTZVRW5CdnVXc3BGVjlVdysv?=
 =?utf-8?B?OXduM3RDRzNEQitqL0hnRFcyNHJzS2s5eTQ1TEsrMFVCWC94dXYxdjZMQmRv?=
 =?utf-8?B?NjREaUJOakVOSVZIKzUyT0s0MWMrdHFlSWpVY0FJKy9SLy9sa25RL1A0QUFr?=
 =?utf-8?B?RVB6eFZWWUdOOVdWWUNxNTRDUVMvTnpLWG5WK043QWN5cnFyYVBhOUJLUXBR?=
 =?utf-8?B?TmhGSUsvTmRsbnZJU1MyYkFadkMvN1RaZlNSM1IzTVpDWDVsYWpJbXVGcjRo?=
 =?utf-8?B?RWs1alhnTTZlcDRSQlEvbWUrU0dlSVZLWDlaeWtwOXNWNTIzNWlWREhyT1dJ?=
 =?utf-8?B?NUw0Rll2d0hadVVLMXR5U2hWWndkbVpVbm1KMFNaNmh4RlFSeHZBemsrekRv?=
 =?utf-8?B?WEJybU83eTVuMFY3OFRvWGxKVWpSNEthTmdFZ0l5UFQrQmptZGwyS0FaV3ZJ?=
 =?utf-8?B?R2RtR0FwN1JwVzgwY3BQUjR6RkRqQ1dqaHVTdzhvdXVnTEVKNmxaMzFNeHpB?=
 =?utf-8?B?cmRIK2VwejFKVWw0U0dtZlhpNXg0TTlYaVdoQlJaaStjWkdzRkNSMjBRYTdP?=
 =?utf-8?B?bHczeGNuL2w5bENDQUt5K2tiRUt3L0Q1WkJ1eFpMOEcrV2VaaXlsWjR2SURQ?=
 =?utf-8?B?Szd2RTBlL1F3WHkrVENPMUV0YUMrOWJKWklEYzZLeTFyWTczcjRCanJ1ZDFL?=
 =?utf-8?B?ZEJMOXczZXJ1cTAxbnNnYmpCcmV6TEpsYlc4dFRYNlhwUk5aeTJyc2h1ajZD?=
 =?utf-8?B?NnJaV2lKYVhzdjkycXhQN0VkVHM5ZjNkblVvN1g4R2JKOHZKQmV5LzZFQjQ2?=
 =?utf-8?B?YmVvOVhvQ2hLR2VzS2tkOUVEeHJvVzhVcFdrTGRqYjA5ODkwQ2srVzRTa2R2?=
 =?utf-8?B?TFFxRkJNMVFhRHpyWWZaNkwyekRZTWVISEk4ZTBiNHJwdkNFZmhLNWtlMTVk?=
 =?utf-8?B?UzVDc2cvc2dmS0o2ODJTQWZtV284Z2NQSXdwRFh4Sjl5WUFrN0VrOEhvRmlu?=
 =?utf-8?Q?r6EEaMVkxqtx1AzocGzp4JHRDDhgfRna?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2NaT0IzTkJPbmorT0dqTEFrN2pIVGFHK1VIYTN1dFNxeFRTWGZUZHMxY0x0?=
 =?utf-8?B?Rk44ZGNpQVdPZXVlYmd6YzAySDNqMUNLUFBaNjQ1OWtlTkFPUDMxQjJEazMz?=
 =?utf-8?B?N1hLSUt3b2FiM0xXUUhRbWl1amJ1SmFhMysxYW5YWGRGSEhabW0zZy9PY3ZU?=
 =?utf-8?B?RmFtK0RzR3pEVmdqM3lZREhlUzduYkZmelcyZkFjMjdoNGlHN1JuVzFBNjJ0?=
 =?utf-8?B?a2lIVWZkOGd0d08wY0ZFdUsyOTRUZ2J1QTUxbkRaYXBlcjJxamVKWGNJZ1RU?=
 =?utf-8?B?Y2pUNkNCOXBRUEFTVTVPRnhDVC9sYy80cGFmKzc0TWFoR2x0MUpmaWNhN0wv?=
 =?utf-8?B?dkpFeFMyQ1lzZVpZTy9ITGVmdW1Iekg5RFlpSmczUWd1SjMwZWZaY1ZSWVpv?=
 =?utf-8?B?UmREWVRGb2hnY0x6Y3ZFV3lNaHNLVEhBV1NZbGIvNGJrWGtjZ2k0cWxZSFpH?=
 =?utf-8?B?azZ0RWFtbjN3M0tubjBUUGhtbTcvZmxxSlZHNG1RMVNDQ0pqUjZFNHVEdEZ6?=
 =?utf-8?B?SkhZVXRIM2g4TUdjdXVsRlF3THZnMU1iWFV4WXZTQzFXaHlVaXlMQUgydWZQ?=
 =?utf-8?B?bERqdXB6Q3hncHZWUTBodzJIVW9iTjdxVUxRbENlcmoyZUhZZWVJQVE1bVlD?=
 =?utf-8?B?aFRDaUxndFJsd3NTdU02aTFlWTA0V05kaDJnMlFLWWh2aDcxeFBKQzV4Ynhv?=
 =?utf-8?B?bCt3Z2hmSFNLWTlFR1A0MlVjYXFkRlpCRW5LOE12SkdycFJ4TUFhbFF6U2Y5?=
 =?utf-8?B?eXdWcWpiT0JEc21DeVBLT0tYYUJTK1dpQUU4d3hpYkpKeURxOUxxNXFpUVUy?=
 =?utf-8?B?NXhqSDdYMzdUa3NvVjRGbmMrcENGdWVuaGlLMnkzcUp4TXBjZm5CRzRsdHov?=
 =?utf-8?B?OUpsenZlSW1Bc1A5QmlOV1IyaWhmUllacFZCTE03N3l1cHJzMytlSWE1R1Ax?=
 =?utf-8?B?TmJPdDA4SXJlVzVwMVdYNFB6cUlDWitFSlJ0SDRIdk5pakVOVVFReWdaV095?=
 =?utf-8?B?KzlmbklYbW5QeDZ5eFFQTnZXOHNFbHBjOVV5d0U0QnNxa2NmQ1Ircy8yeGpE?=
 =?utf-8?B?TlRKSlF6eDRLaW9LQjlCbFBVWkZpYkZFUFlzUkdKckRPNXVQZ2gzbXFkZHNu?=
 =?utf-8?B?cWZmQnpROGJnanJDNU43S1B3THV5RVE3YWdlNDhQcEk3VTlIVEZvVHQ4Zm1l?=
 =?utf-8?B?WXljMTI4enNuWnVmR01WUHptZDVycEc4bjZkc05UdmlUNC9HOWlNa2JQdnBH?=
 =?utf-8?B?V3NNZHRVYUR4cERNT3FEUkFwajRLcGFtMmh0ajZZdExCV1pvRFRJVCttdW1S?=
 =?utf-8?B?SS9WeVppMTJVZUJsTzRTSW9vMTl2QVRwc0R0b3NYamJVVUZGOEN4dm9iODFO?=
 =?utf-8?B?anpkdEJlZUl3SGxxcHlGNkJuY3pkelJhdFV3MG9RUkZuUmJYcnRIVVZKeVJP?=
 =?utf-8?B?RVE2aEZVVEh6d0N1bTI0OTlobHVDN0F3UHJSeU1BTFZCVTBKbStRSW5oNjJL?=
 =?utf-8?B?dXo1NjBqcnBzaVdPQzdOTHhZdVpPNlpZMFFsWE1rNTNhR3JBdklVUURmY2lh?=
 =?utf-8?B?czc3eHV6eWRnNGxaSXN2OTdOUHl5SzVtcEgyNk9WUnlWNTM0UEdZM3NmNk8w?=
 =?utf-8?B?dkQyQUk3d2dVYk10djUwbVJ1TWhzSm1oRUpyb2hzcHVCbVlPelRIT2dTSG9v?=
 =?utf-8?B?MU1YdWtNUDYrUSt2UHl1amRoU05VZWtPdEFKS1p2RXVYVzlQMHhBWmJOeFFL?=
 =?utf-8?B?N2RlZzAyTHRVQzFFWmp5ZG9RaHE2UmJRTEdEelpPeG5BYXRsRjVSNGUvWHBh?=
 =?utf-8?B?VUJESXh6ckpkWFQyRXRtSVp6a29RTndiZUl4TEVmVUoxY3gxbkJKTHY0Zmx1?=
 =?utf-8?B?T1hxYXpOUy94RmlOTjlocGRPajJhTjd5S2N3ZDRHSHk5QWlsWlQrTkJoUWxH?=
 =?utf-8?B?aEVjVTFJdzJIcHk5THV4NTRIbzVNSVc2aFpLaTc0NEZTVnVZV0RoT2J3VW91?=
 =?utf-8?B?b3Z5dXJySmNpYWlRdzA1V0NIeGxzc1Zkd0tOUzNwbDA1aXVJYWxac1NtQzR1?=
 =?utf-8?B?N01lTUJaZGlJL0NkOVQ3dnJzWFRhaXJ5NTBpbndSQ3VOSG5ZVFo2MFBYZ09x?=
 =?utf-8?B?TEZOeE12RkNXL0cxVnF0QStyVWs1SGFuQ1ExMXM5OXNoNmVaZVhyUG1NWlV5?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab2f539-4f59-4713-5c53-08de188dd35d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:57:35.1216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zisa0onnwqQpSyjmKLCnlxz0c2HY65514cldbtD4hQjPA1sV1tYRoqDLs8Iv2YZrbgBHxAvrn/LyTEVeoK/Nyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6720

On 30.10.25 16:53, m.kurz92@gmail.com wrote:
> From: Markus Kurz <m.kurz92@gmail.com>
> 
> The search bar used to search through the API documentation had a
> font-size of 8px, which was barely visible. Therefore, this commit
> adjusts the font-size of the search bar, the drop down menu of the
> search, and also the livepreview to 1.2em of the base font-size of the
> documentation which is 14px.
> 
> Changes to the xeno3prm-html.conf.in had to be made in order for doxygen
> to use the extra stylesheet.
> 
> Signed-off-by: Markus Kurz <m.kurz92@gmail.com>
> ---
>  doc/doxygen/search-style.css      | 25 +++++++++++++++++++++++++
>  doc/doxygen/xeno3prm-html.conf.in | 14 ++++++++------
>  2 files changed, 33 insertions(+), 6 deletions(-)
>  create mode 100644 doc/doxygen/search-style.css
> 
> diff --git a/doc/doxygen/search-style.css b/doc/doxygen/search-style.css
> new file mode 100644
> index 000000000..b08c0a865
> --- /dev/null
> +++ b/doc/doxygen/search-style.css
> @@ -0,0 +1,25 @@
> +#MSearchSelect {
> +    font-size: 1.2em !important;
> +}
> +
> +#MSearchBox {
> +    height: 1.4em !important;
> +}
> +
> +#MSearchField {
> +    font-size: 1.2em !important;
> +    width: 14em !important;
> +}
> +
> +#MSearchSelectWindow {
> +    font-size: 1.2em !important;
> +}
> +
> +.SelectItem {
> +    font: 1.2em var(--font-family-search) !important;
> +}
> +
> +.SRPage .SREntry {
> +    font-size: 1.2em !important;
> +}
> +

".git/rebase-apply/patch:37: new blank line at EOF."

Fixed up on merge.

Jan

> diff --git a/doc/doxygen/xeno3prm-html.conf.in b/doc/doxygen/xeno3prm-html.conf.in
> index d8f8fc397..e62df4d70 100644
> --- a/doc/doxygen/xeno3prm-html.conf.in
> +++ b/doc/doxygen/xeno3prm-html.conf.in
> @@ -29,12 +29,14 @@ HTML_HEADER            =
>  
>  HTML_FOOTER            =
>  
> -# The HTML_STYLESHEET tag can be used to specify a user-defined cascading
> -# style sheet that is used by each HTML page. It can be used to
> -# fine-tune the look of the HTML output. If the tag is left blank doxygen
> -# will generate a default style sheet
> -
> -HTML_STYLESHEET        =
> +# The HTML_EXTRA_STYLESHEET tag can be used to specify additional user-defined
> +# cascading style sheets that are included after the standard style sheets
> +# created by Doxygen. Using this option one can overrule certain style aspects.
> +# This is preferred over using HTML_STYLESHEET since it does not replace the
> +# standard style sheet and is therefore more robust against future updates.
> +# Doxygen will copy the style sheet files to the output directory.
> +
> +HTML_EXTRA_STYLESHEET = @top_srcdir@/doc/doxygen/search-style.css
>  
>  # If the GENERATE_HTMLHELP tag is set to YES, additional index files
>  # will be generated that can be used as input for tools like the
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

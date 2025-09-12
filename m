Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FBA3203A4
	for <xenomai@lists.linux.dev>; Fri, 12 Sep 2025 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689832; cv=fail; b=XIJ8yI4fEpEGmZv0Cll5nKYxSNNQ21EwQXW2C3oaE3XwZl7og6cLlxTpsoXKS3KenoZE/YynyiYNX4U9okPuOuKMIDVQ6noxYgOSDioZe5WBdMMhghdliiUpjhiMNQM4ZANNe+i14HoNZkSsIieH9V2TKWYOOaiPEhAisBx0qvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689832; c=relaxed/simple;
	bh=L1uBxJIcZwI6epjbbmClWbTc1EbcyC+IbPAExeTf2/4=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=TTD64hLmK2eds/i7yn8ML8Vabq6JLCmRz/2jcfn6oGUttnMGxNvJlCAhSlqYFwrYL01f9SpnV67eZQKObuM8S3/E68nsVoFCtwpPWiZoCaTWXA0VQUYjonG9+Uw3pOvN8Cb8nITy/CWifl4tZPo87dlrBsWlFpqOmC4sHvP1BOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=y6JdK4uD; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="y6JdK4uD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFys90NYRoSCUQlOFSYxe+22ZaalFanlN3EZAfGVgvfeGma1sYdmhkv1OLMJLcioSMWtnD+qRB8hpIXV59X3Y34ZExnbuPNdFy857ohH6dm6zHvCWtp/CkvIkCd+yBsJdwuivx/H8CzorJUeyix5r5yjQXHxVCLlLYB6KZMouUbLhF96yLPoUL8b9AVPzi1qdhCOzWsGXO/8c3HysALtFFKrSwvuKhc8frcpgtJdp1OOK+kN2uTUDOdFKj5dwFw1xMHWVvU5QBHRlRlSMwjaoBFhZ+XMXnH6mXoFDzL6keuPxSPvk4obH1Df+YApY7lskOftYPT0p3jJa3I4SOrCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JuhGRz0QqaOu6cA+dEGyf1V+UgxCv+Efru3eYkW12k=;
 b=Z+p4IyAdWx4ND2kL4Lfgu8+RLWQv/JZpzyzG6n7ibN20FSKh/Xs0igXEgKmuxazKqyW2ToWT3s+5XbYtAj+Sk5Qq0q7lMm/xANE/wm2ktUhvAIt0/2KZQh03kNeE8egr/x6LxEOQuw+YjmMtuL7MmPmEsBLCXK6Y6VIMCdp4K70ozK6MXKb1/FRDt9OAss0dJuBnLfnFc8ke/Y/NmHg92CZoTjyrdUXxXcOC3IEHssmThbAAruRhJQ5/VezsHGob4tgICxAr4GseGghgn1l8sQsfYrn7taeHh2DdwNlpcbBWhQH3Pq23+LHHldgLlxb9nEyBb/JKoDJa02OLn/5BaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JuhGRz0QqaOu6cA+dEGyf1V+UgxCv+Efru3eYkW12k=;
 b=y6JdK4uDv0Sz/WN9HZdpu7SmqdHswrgFpw649Q27Oa/2SCCaTKSqBJ92QpkQ2sT0dEyoaXefk7gSEXT5x1Zhi7+x+9nc0JOTWvjudyqaf7WK9eN7QOOqeMwU9xp1hwZhqBDqp21c8m4/IiiOdQNm+nf5L81YhkKtQDgSwpFqC2TDPU4lfW1tnzQ+nXRN7X8SxKcyYoZ/UBMlgG+nTrFyPHtsKFkep2Mvi+3rofF6VC6Z69fEYBzSxZ1tczBR9JMmy2MWIaN6Wf+2Yub0fuwRkNggd96OJdyd1yeWfiurJkwKch76ecDgnjS85VMqSyRJM2V1eVh0NGBi7UPjagFlLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM0PR10MB3218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:10:26 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 15:10:26 +0000
Message-ID: <c62a5bad-f2f8-4fd7-b9a4-01e51e23d605@siemens.com>
Date: Fri, 12 Sep 2025 17:10:25 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] lib/cobalt: Update vdso parser to latest Linux version
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM0PR10MB3218:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcec6ea-ec53-45be-ba0c-08ddf20e80dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VStNVkZnRTZvZHV0V3B5OEdvVkwybyt5WnRQL0J1UmgyditJaG8rRUFlS0N3?=
 =?utf-8?B?Wm0xbklqdDJhZWJndlYzOU9pU3R6cjV5UzA4TllXMXpxV0JTYUhMWW5vQWJS?=
 =?utf-8?B?VHQ1UDFhWlNBMHNjZzJodHhXbUw1cnFSNUp5Vm1YU29oMVN6ajhRU0xObU1z?=
 =?utf-8?B?YWpOUW5pZ2M2RHQxbmxzalZFaXplOTMyNjNoTENkaUxPbTNzanpvR2VibHBQ?=
 =?utf-8?B?NVhFcmZSNGxxYWY4aHBTN1RIT2xKMHpIcnM2T2VFU0w4NTVXS2xSRVIyWGll?=
 =?utf-8?B?QXVCUnJheFBzcUM3Tll3ZkV0TjRqb2kvczltTE1HcmZ3KzdMZkcrMkUvSmsx?=
 =?utf-8?B?c0J4Sm5CMnBZZlRwdjBiaEdMa2FyUlY5N040TTdJb0xZaitqaE91TUhGL2ZW?=
 =?utf-8?B?QS9pYTdCOGJkZnh1ck01d2hjZkhxUUg0Mmd4d0xHVGNoSmdoN3NxV1dhSVli?=
 =?utf-8?B?b3l6LzN1QjVnVlhFVDl5bHhaQzdWclFxNkc1K2lzYTlPQW1BcnJwUTIvZlBw?=
 =?utf-8?B?RDAxVkV3eFJzcmxWWVM0bGtwWjlvYlFtelhnWXM2aXMzVU1KWGRpeEVFaUk2?=
 =?utf-8?B?bXB4aFBvK09qV053cm5rbXB0THVRaTBMSldNOTEveU9PTG5jcWlabVFLTE8z?=
 =?utf-8?B?eElxNEFpZmNvc3pXeEovZEw0S2YxUW9Ua3hjeEw1QWxrRmg4UWhzc1h0QzJt?=
 =?utf-8?B?NFBsNEttOHMwaS8xU1Y3VDNvTC9vbE9yQlhTUGwySlhlOGExSEdJemllamtj?=
 =?utf-8?B?Zm1zZzJSNzV6WGs4aTZZVzcvYTFMMEM5ZDM1aWZVRkQ0MDhnS3lxTzFpWGdW?=
 =?utf-8?B?U2l3cVRuZWw4M04zTm51amNpd2p6SXgyRXpjQ1l6K2VtbkJvUnJCVi9oaDFF?=
 =?utf-8?B?Qk9iOGRTMGdIVWdtWFNqUTBOaFRsZHhaT1laTXRCeVN5QlpWNU0xSTQ3aG1m?=
 =?utf-8?B?OHNyTURzdzRPNklMMlh0dlVkVFllbDVGMWwrQmxqMEhLbHJyaDFtUzJ4WVhx?=
 =?utf-8?B?Nm1UNEhkL2ZEb1JEVGhhb2hHamJDdWZMODZRN3JIY3AwUTUreWY4c0J4YnNB?=
 =?utf-8?B?dERRMnVjU3BGRzZlWC9DblhxY280T3NSYm80L0UvbDhpWGxPcmp5T0JTOXhH?=
 =?utf-8?B?VElFWEhnU2ZMcnNxRUllcE1BZVNaRjAxK0VRQjRIbDJ3eE1SeWVzQXFUZ3Jn?=
 =?utf-8?B?R2pGQ1kvWTQ4QUc5WldBZjNuQk96VGpxcnFvTlUxQ0dMTkk5YXF5MkdvL1hk?=
 =?utf-8?B?aWdFN1QvOGJRbVE3aEoyNDFpSytQREdYT3RoUXJQZjVQaHNSV3JjU2pic3Bq?=
 =?utf-8?B?UUVBL2FkRmMxS3hocDFHelowMmt5aEFTQ0duUm5ieDZTWVJUQ1YzUUdrNnpB?=
 =?utf-8?B?ZkxhSmoyTG1BblRTeDFOK3dyMWlqdFhQQWVlTzFkcE0rUlVLWUd5OXhrclg1?=
 =?utf-8?B?NVBYOWF0L29Fb0lOQWZ0SUx1M2Qvb1o1c1lFMitacGxTUTM4Y1VpYTdUaC9Z?=
 =?utf-8?B?RVpJKzJLa0JERmRtQWl5ZjNPeUJ2T2pNWUR3MjJQQStpbXJSQVBOaCtERTRO?=
 =?utf-8?B?Mk5oWTNGY3NXOSs3NTV0cVdMcjBhZWhTTGY5dmtjQVRiQ1dZTFZHMUVDalN1?=
 =?utf-8?B?bFpnQTliY0FUSnN5NitpZFdNaXBjMkhvMHhIN3J0UEg1dWFvRUJzL2oxdWlP?=
 =?utf-8?B?WGVmeXpudjh4OGdrU3ZVQWFhVHVkVkxVN2t5WXdXd0hFcWM1RnJ6dW5DM3o2?=
 =?utf-8?B?ZWlPRkltZURBOExpZkhNVkhocFo5aHROYnlzWmZyS0tWVGNxNExCOGFObjFB?=
 =?utf-8?B?WnU1cXUrOVRFaVIrUVNZQ2NKZzBXdzZBYUdFMWs4cmdsMGlLOGlhaG1hdnVu?=
 =?utf-8?B?dGV3SlZvYmtXalZZT2ovUnhxOFBmamUwUW14L20yblFROVF3eWF4QVlYckNO?=
 =?utf-8?Q?zJiolPpcBLg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzM2eG5lZDRmK2ZPWk1VbS84eEVGckJpTWZBSVBrbG9NSXVONDZoNUtoMEt5?=
 =?utf-8?B?WlNhRU1tSW5VTFJaR1dHWkhvMDIwQzI5Y3B1WlVlT2JzUDFpOUZaS0pqMmVa?=
 =?utf-8?B?TjZlT3VtTG5BK3BuTHdFZSszUnB0cDcyd0RwUWgrOXFWL05Fb0xZSWZDN21n?=
 =?utf-8?B?Y3RWdUZabHp2UGozYTgrVGY2dlEwTk5ibGVFSGIzVlA0TzE0MmRQQVlxOGkw?=
 =?utf-8?B?M0JRUkt4UjluU1JIOTNTR1ZXVWk4cnVaK0htVDRaQzVHWFQ0cFYyaWJ3RDNK?=
 =?utf-8?B?NnBROWE2M203aUkzOW5XRll5aVlDc0xMNnlQSkE0cFZaY09Wdms2SXZsdmt2?=
 =?utf-8?B?a3Jub1ltcUNMYUtjdGVQbzQxVVJkcm9wSTdJdmY5VXEvdm1TNnNNVXZscjVX?=
 =?utf-8?B?VHJraWxSSUs5WU1CKzc3SUlscG5wTER0ZmM5NnpKKzF4bGwzQmk4NG9VUlFZ?=
 =?utf-8?B?Y3hSRldCSHQ5SmQvZWYxSG9yZDg3RWpuM3o1amNWdzROaTF1WVBsSnd0WHFY?=
 =?utf-8?B?RWxGOUZCK25jVVg4T29PUGZZbjlBNGg0RW4rQTZSdTFNSzJJQW1vMVQ0U2Y1?=
 =?utf-8?B?V2Iwd1ZoWFFRdTlXZHJncmswTVBGMWhDVnhPaVE5UTg5ci9SNWhKeEhhV1h1?=
 =?utf-8?B?NkpuVEZXRU4yYTZQUEJUcXNTZWdKckROM05pYW50aHVRUkt3dDFCVno5VmdV?=
 =?utf-8?B?M2pCNWppYVBIK28xREZ2OCtXU1NjcDVUUGVCR1hxL3Vydm15RHcwdUdrYTB1?=
 =?utf-8?B?VWwxOHpUV0RuQXNJeXRwWmxyaDNxNDNCTUd4aCtRV0Q5blZjRUZ1Z0lIcmM1?=
 =?utf-8?B?b3VQemtEanljLzNoN0xjSEczUG9qNHh2T2REVitHNWNFNFZpaXZsUlF3UFQz?=
 =?utf-8?B?T2xadkNmTmljVXQxdDE2RHZtWVZFUGxYYzFzaHpVTzBySzducFFFU2lxNmwy?=
 =?utf-8?B?OGdZTXE4YUxYSkhWZnZDRW1VWmlhMldpVHRjaFhEa1RJNlBFWWVHdVVyMXdi?=
 =?utf-8?B?MEY3OWRnODRZazFldFVCSkNwQjhsUlVBZnJtSVRnTzJZWlZTS0c3NkRMaGV0?=
 =?utf-8?B?Mm1neVB0WkQ2MVBWd0tDdk9CbGlwRzFtTGpxamorcnFoR1VHSkw2U3NLRGQ2?=
 =?utf-8?B?V0wwL2pEeXJKZVliV2MwTjdodkFWQlhIbHZ0YjE1ZkxKL1NUcWl1ZFE3UzdK?=
 =?utf-8?B?dlU4UUdPRE9QaVFpbm92RkR5N3l3eUNaeXJ0QndNMEQwYXFxUXVWb01iMFp1?=
 =?utf-8?B?eFVLeFlxWVRHWVBSUS8ySHlienk4MnArOW5JWG0rT0N4cU93QlFxcWVqOWxn?=
 =?utf-8?B?SFB3QXd6UVJnVnJrdlBGRWVBa0lEMlFTQmpBcHV5Z3NSZU5SY2dqT2NLbm9M?=
 =?utf-8?B?Njl3V2dOUGRONTRVQmFhdk9pU3prNWpHZ0RHZ0ErbWZNanNlcU1tQWtQdHdN?=
 =?utf-8?B?UlVkM0VKRUF2VWhoR2MrZW95bisrR0dIYkVOVHlSYTVGY28zNkF0Q0dvYmE0?=
 =?utf-8?B?cUVLWklMV21hcjAwb1JRODAyYTltNWRDTVgzMEE1UmF2V0hWK29aZnc4WXY2?=
 =?utf-8?B?UkNRckJyQmlNVmZoMHlZVE5meVNjZmF6VHJQQWg4a3RpazdUcjI0S2hRQTR0?=
 =?utf-8?B?S3RKZE5EZUdYRkUxWi9CUjZaUENmRnoxOHM4bXgzdzNYdDFhVDVXY0pVS2V4?=
 =?utf-8?B?REJ5OFBUekdGL3BMdk01aVpibnk2WERNQkpvTGdPeDJuSzRleDZkSGhkM0dC?=
 =?utf-8?B?RXdqb0VSZmZFZFhVcFZUL1VTbHB2ek1RcmlOcklkTVZJeThOamNDMmF1QWtx?=
 =?utf-8?B?alY3UWd3UjZVOXBsTk5FNVZUNFVFS2NaeVJqWWN2dWd2NEJYV3hlcmlSdjg0?=
 =?utf-8?B?SUVYWVRld1ErYXBjbk9tWGxNQ0E2WUdyaUwrclQ1ejBZam5xbzRVb2luZ3Rq?=
 =?utf-8?B?OWhacko4ZDlhZFI2Tk50SVhhYlRCeFZiQ0VibmJubFN2N0QrM25hbW16MnhF?=
 =?utf-8?B?ekFuMk5FbmNQbmIzdHExdE40YjIwdFh0SnFCVmNpMU43a0dwc0RPMW55SVh2?=
 =?utf-8?B?WE1YRzh6bEc1TUdNeHBHZW9HQ1NHb1FRQ2wzbU5FQTczQ0lqNXQ0WUs3cFdm?=
 =?utf-8?B?QTVjSnZvelZuNFZSODlUTkdXN3BhRTQ0a3ErQ3BZQS92b3BwMHNHc1lNODJn?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcec6ea-ec53-45be-ba0c-08ddf20e80dd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:10:26.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4l2izflaNE9W3xqN+yYNgwSAjI5023OcQncRQy6rTfch1k51OvLabuyb1A98WimM2Ql5ymk+CaooctDC32CylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3218

From: Jan Kiszka <jan.kiszka@siemens.com>

This widely aligns our copy of
linux/tools/testing/selftests/vDSO/parse_vdso.c with the version found
in 6.17-rc5+. We were primarily missing support for DT_GNU_HASH. This
becomes noticeable with the Debian 13 toolchain on arm64 which caused
DT_HASH to become absent from the vDSO.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Will go into 3.3.x as well. Older ones do not need that because they do 
not support affected kernels.

 lib/cobalt/parse_vdso.c | 159 +++++++++++++++++++++++++---------------
 1 file changed, 100 insertions(+), 59 deletions(-)

diff --git a/lib/cobalt/parse_vdso.c b/lib/cobalt/parse_vdso.c
index 766f90fad7..37b997b78f 100644
--- a/lib/cobalt/parse_vdso.c
+++ b/lib/cobalt/parse_vdso.c
@@ -25,26 +25,6 @@
 #include <elf.h>
 #include "internal.h"
 
-/*
- * To use this vDSO parser, first call one of the vdso_init_* functions.
- * If you've already parsed auxv, then pass the value of AT_SYSINFO_EHDR
- * to vdso_init_from_sysinfo_ehdr.  Otherwise pass auxv to vdso_init_from_auxv.
- * Then call lookup_vdso for each symbol you want.  For example, to look up
- * gettimeofday on x86_64, use:
- *
- *     <some pointer> = lookup_vdso("LINUX_2.6", "gettimeofday");
- * or
- *     <some pointer> = lookup_vdso("LINUX_2.6", "__vdso_gettimeofday");
- *
- * lookup_vdso will return 0 if the symbol doesn't exist or if the init function
- * failed or was not called.  lookup_vdso is a little slow, so its return value
- * should be cached.
- *
- * lookup_vdso is threadsafe; the init functions are not.
- */
-
-
-/* And here's the code. */
 #ifndef ELF_BITS
 # if ULONG_MAX > 0xffffffffUL
 #  define ELF_BITS 64
@@ -57,6 +37,8 @@
 #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
 #define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
 
+#define ELF_HASH_ENTRY ELF(Word)
+
 static struct vdso_info
 {
 	bool valid;
@@ -68,28 +50,45 @@ static struct vdso_info
 	/* Symbol table */
 	ELF(Sym) *symtab;
 	const char *symstrings;
-	ELF(Word) *bucket, *chain;
-	ELF(Word) nbucket, nchain;
+	ELF(Word) *gnu_hash, *gnu_bucket;
+	ELF_HASH_ENTRY *bucket, *chain;
+	ELF_HASH_ENTRY nbucket, nchain;
 
 	/* Version table */
 	ELF(Versym) *versym;
 	ELF(Verdef) *verdef;
 } vdso_info;
 
-/* Straight from the ELF specification. */
+/*
+ * Straight from the ELF specification...and then tweaked slightly, in order to
+ * avoid a few clang warnings.
+ */
 static unsigned long elf_hash(const char *name)
 {
 	unsigned long h = 0, g;
-	while (*name)
+	const unsigned char *uch_name = (const unsigned char *)name;
+
+	while (*uch_name)
 	{
-		h = (h << 4) + *name++;
-		if ((g = h & 0xf0000000))
+		h = (h << 4) + *uch_name++;
+		g = h & 0xf0000000;
+		if (g)
 			h ^= g >> 24;
 		h &= ~g;
 	}
 	return h;
 }
 
+static uint32_t gnu_hash(const char *name)
+{
+	const unsigned char *s = (void *)name;
+	uint32_t h = 5381;
+
+	for (; *s; s++)
+		h += h * 32 + *s;
+	return h;
+}
+
 static void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 {
 	size_t i;
@@ -130,8 +129,9 @@ static void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 	/*
 	 * Fish out the useful bits of the dynamic table.
 	 */
-	ELF(Word) *hash = 0;
+	ELF_HASH_ENTRY *hash = 0;
 	vdso_info.symstrings = 0;
+	vdso_info.gnu_hash = 0;
 	vdso_info.symtab = 0;
 	vdso_info.versym = 0;
 	vdso_info.verdef = 0;
@@ -148,10 +148,15 @@ static void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 				 + vdso_info.load_offset);
 			break;
 		case DT_HASH:
-			hash = (ELF(Word) *)
+			hash = (ELF_HASH_ENTRY *)
 				((uintptr_t)dyn[i].d_un.d_ptr
 				 + vdso_info.load_offset);
 			break;
+		case DT_GNU_HASH:
+			vdso_info.gnu_hash =
+				(ELF(Word) *)((uintptr_t)dyn[i].d_un.d_ptr +
+					      vdso_info.load_offset);
+			break;
 		case DT_VERSYM:
 			vdso_info.versym = (ELF(Versym) *)
 				((uintptr_t)dyn[i].d_un.d_ptr
@@ -164,17 +169,27 @@ static void vdso_init_from_sysinfo_ehdr(uintptr_t base)
 			break;
 		}
 	}
-	if (!vdso_info.symstrings || !vdso_info.symtab || !hash)
+	if (!vdso_info.symstrings || !vdso_info.symtab ||
+	    (!hash && !vdso_info.gnu_hash))
 		return;  /* Failed */
 
 	if (!vdso_info.verdef)
 		vdso_info.versym = 0;
 
 	/* Parse the hash table header. */
-	vdso_info.nbucket = hash[0];
-	vdso_info.nchain = hash[1];
-	vdso_info.bucket = &hash[2];
-	vdso_info.chain = &hash[vdso_info.nbucket + 2];
+	if (vdso_info.gnu_hash) {
+		vdso_info.nbucket = vdso_info.gnu_hash[0];
+		/* The bucket array is located after the header (4 uint32) and the bloom
+		 * filter (size_t array of gnu_hash[2] elements).
+		 */
+		vdso_info.gnu_bucket = vdso_info.gnu_hash + 4 +
+				       sizeof(size_t) / 4 * vdso_info.gnu_hash[2];
+	} else {
+		vdso_info.nbucket = hash[0];
+		vdso_info.nchain = hash[1];
+		vdso_info.bucket = &hash[2];
+		vdso_info.chain = &hash[vdso_info.nbucket + 2];
+	}
 
 	/* That's all we need. */
 	vdso_info.valid = true;
@@ -218,37 +233,63 @@ static bool vdso_match_version(ELF(Versym) ver,
 		&& !strcmp(name, vdso_info.symstrings + aux->vda_name);
 }
 
-static void *lookup_vdso(const char *version, const char *name)
+static bool check_sym(ELF(Sym) *sym, ELF(Word) i, const char *name,
+		      const char *version, unsigned long ver_hash)
 {
-	unsigned long ver_hash;
+	/* Check for a defined global or weak function w/ right name. */
+	if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
+		return false;
+	if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
+	    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
+		return false;
+	if (strcmp(name, vdso_info.symstrings + sym->st_name))
+		return false;
+
+	/* Check symbol version. */
+	if (vdso_info.versym &&
+	    !vdso_match_version(vdso_info.versym[i], version, ver_hash))
+		return false;
+
+	return true;
+}
 
+static void *vdso_sym(const char *version, const char *name)
+{
+	unsigned long ver_hash;
 	if (!vdso_info.valid)
 		return 0;
 
 	ver_hash = elf_hash(version);
-	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
-
-	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
-		ELF(Sym) *sym = &vdso_info.symtab[chain];
-
-		/* Check for a defined global or weak function w/ right name. */
-		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
-			continue;
-		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
-		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
-			continue;
-		if (sym->st_shndx == SHN_UNDEF)
-			continue;
-		if (strcmp(name, vdso_info.symstrings + sym->st_name))
-			continue;
-
-		/* Check symbol version. */
-		if (vdso_info.versym
-		    && !vdso_match_version(vdso_info.versym[chain],
-					   version, ver_hash))
-			continue;
-
-		return (void *)(vdso_info.load_offset + sym->st_value);
+	ELF(Word) i;
+
+	if (vdso_info.gnu_hash) {
+		uint32_t h1 = gnu_hash(name), h2, *hashval;
+
+		i = vdso_info.gnu_bucket[h1 % vdso_info.nbucket];
+		if (i == 0)
+			return 0;
+		h1 |= 1;
+		hashval = vdso_info.gnu_bucket + vdso_info.nbucket +
+			  (i - vdso_info.gnu_hash[1]);
+		for (;; i++) {
+			ELF(Sym) *sym = &vdso_info.symtab[i];
+			h2 = *hashval++;
+			if (h1 == (h2 | 1) &&
+			    check_sym(sym, i, name, version, ver_hash))
+				return (void *)(vdso_info.load_offset +
+						sym->st_value);
+			if (h2 & 1)
+				break;
+		}
+	} else {
+		i = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
+		for (; i; i = vdso_info.chain[i]) {
+			ELF(Sym) *sym = &vdso_info.symtab[i];
+			if (sym->st_shndx != SHN_UNDEF &&
+			    check_sym(sym, i, name, version, ver_hash))
+				return (void *)(vdso_info.load_offset +
+						sym->st_value);
+		}
 	}
 
 	return 0;
@@ -271,7 +312,7 @@ void *cobalt_lookup_vdso(const char *version, const char *name)
 
 	pthread_once(&parse_vdso_once, parse_vdso);
 
-	sym = lookup_vdso(version, name);
+	sym = vdso_sym(version, name);
 	if (!sym)
 		error(1, ENOENT, "%s not found in vDSO", name);
 
-- 
2.51.0

Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD151B18F
	for <xenomai@lists.linux.dev>; Tue, 29 Sep 2026 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790698966; cv=fail; b=ms3L/alCJFBpOujrjvyRq+TnP42OR24s9VcgptvlUGZ1xPsx20cq7O28PIvhqshnIm3t3caR2ZNFJ99tuc7JXVd07t8E1O/VOJNp/sSXoB/a8FPEh4nDmhudVdsVF2xgtJBtIS0sijMOqHOoy+nhG/aAYaRINywnJEXTYOHs4TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790698966; c=relaxed/simple;
	bh=wPK9TVFhd2QVlNQux1MKpqV0HR6o6AJfQJpLf4/GrXQ=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=DfO1JUOFpo9GuFryy75oVNAolfG8kSAxtUrULZgql1v9ORqAEnE9FJzpa6Es0ATmhk3CM9pULJ1Kva7gW3I/plmDgvpjiBncaQImXcLLVIKmG0dB8yhC9j4WKQoKWd5hY3R7uIGUZ6bYu/NRNQXKZlCNpsycSnITY/cCILSBZjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bnF/77uN; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bnF/77uN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXgthERElXbF10uulUXDC7M57Fe3Itr3FWAY4ZI+FiWyxmjIkqVJbo5eL7kQw1QInL3xTSQfq+a9flZAbuYS5pXB9GIABMMJoqUPcxPcx3TVBswjmf3Jo2oXBALPxss/mQ/5Do/fZX2vmR5nVIf68NQdccxf2blIJaLr4rMj1OPm1HJ+LDMX6DAz5A73NCU7euUyAlloNBeCgxVIWo+KFCYprEkc56bSO9T6nl05WFp/29QW/mOzZhKEawaBY5pI0Pf3jf3g30oKDSJ/1IV0pX+T+HznwI+5BZPyGnjLkvQ2aOa27P5K+veMDCxVsQX4W77dG8Q978g09vqtDMj9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwWdm5LCJKdXCHps8Dkx4zCfgYaKPoP0jOcK/5ez3vU=;
 b=lbJ2QK/cSn6rRZIssIwB9VLL4Jnbe2562iginRjwE8QYDl4YkwCN05wMJkfdYDs1dOsvKb0RMvu9iXSNdYmPoDRxyisFK5Zve5lQpyHk/e6cbO1cNTOvUJ2lpPtprS1wKSeCMx6JVdzLQaLxy2/ya826UYVNrOy1BD2W5RtiYZ9TeQ2f8hnnO2zeK40+33DfeX1dxJ+s1BDQp/PY+iOKZwv3Z+SoEEPvDMC2Zhsgjt7ocAMqxNLgssnC9nNz5AnHE4j1VIy+aL8IMcPWlIckQhTXUy/uELXUNxOr7Hr60cZQWcUi/iE6feFBBanCkGJn5X40yI5iT2tyi5/uVP6X2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwWdm5LCJKdXCHps8Dkx4zCfgYaKPoP0jOcK/5ez3vU=;
 b=bnF/77uN7Rt6tLrmr4/rDLVdQgor00r/8TurpmXCuPoYoyP9kktbYysUQ49JiFh6L+NlSfKMGiW/E6RJyYCVJBwFmrZjqCJ0vlMcwhAZ24sTHOMAAkck/2//58kQF2tOuZGeXKyfgHk7VQaXJboLVfIfT6xNuerMzmhJIo7YkY1yuFaQCHyYgcdubjOmp8Gjz5vNREpUd4eQlrc3ZXv+lewj5QRDd8c5fRF7mUYkmr3DE2aNpw6uPePzbbWY1uYhYKeGho3pMSsbT1QONUwNcM7BXrodabzrUa9buHgyd/SNx3ygh5uP7eukV4NSXAwiB7xIKXVqznDi5BKs6j47pw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS4PR10MB6088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:583::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 16:22:41 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 16:22:39 +0000
Message-ID: <9509551e-b9e2-4bf0-8669-fecce9ce6403@siemens.com>
Date: Tue, 29 Sep 2026 18:22:37 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
 "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: No call tomorrow / Meet-up in Prague
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS4PR10MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: b406941d-3f01-4bea-0371-08df1e45e1aa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|6133799003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cwrm7xyPtVKqjj/hjzsS873uLUirfeNzuXycE+t0JCYkAxDmYBOb/D2oEB0e+8wHvzUJ10ukMNGFihRe3J/RX9NyBoac28bREn3/UWOFhKTGNLKoU3IM71/N84GqFmPkG3OArRSoDyinXwD/v8V7RQjcPVv+pqwgzUuiS5LW0CH5ofLSrrxu4Ya4p+NTzkkU7USkJEc58/gpWrU38HVIRbf44DXCh22s5tzu7EnBrG8SZdYfZIf+dXr42KxbcwxNGTZYfYsFwk1XtLS6mgk0R0fFNDz2/MCNKepI1GhwJ4GHmgPZ6oqFi4gobpRaTZuiEVkWFaeppLhKRVe7z5iMYclqj2LlKMqU1ZceUuN4dwXL69dAHb+1e7hsX5nRAf1xF/XeWCGeJ696ynpO+ouXbsxi5l3WDfdEbCHgOgkVL5fb6OU7llzmsYTsZ4m+Q7rgahWC+pq6BymJWB5WzmGswmK4n3ObToLKj3JiOj8r8jgXjcf4aYIqO+GK5wz5amEkj4HZq0hrRV/47i01qUY4wqkxQPuPEHjHUKTpQlGJ7XRqYXz5KfLaiGgwT5eoN3/bni1tgu1LCELCXbDOcPwBZ/p6IsoViGSj+ZGrUW7QuSMpBqJicy4+vQfGqCu+u6ThxnOK/OYkfBKUc6cA63/hqaLXsSW0ZOpgckKjOfgy4Us=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1pBdzJQRXM2S2xqT25MVlpNM2hiZzVRWThSc1k1RU4rejBXM2V0N1VHQy81?=
 =?utf-8?B?YlpqZXZuNnNFNmUvN0tqUDE4U0ZuUThSeHFLYTJnQ2xiL1BOZ3NvWEV6SW1I?=
 =?utf-8?B?Z1dFMXVIMzlXeUw5cmJEWjgralVScjBRaWxVOGpYR0NhSytPeGJ1L0ZMaWo1?=
 =?utf-8?B?K1dIcWFYN0d4SnNZejg1Tk1uRHNwdHFlU0JOeVRIV1M4UmdibDFGQWNPZW9L?=
 =?utf-8?B?dlF2b0xLeHNQQ1ROVktzRWdNMjN5aFRhS2dUNlNpZmhlMy8wWTJ1M0RYSzRR?=
 =?utf-8?B?dTBYdENoWXQ1bG5wZ0hYZkFQYlNEUTlvOVpTckl5OVd5RU5oTHVBVmhXaVhS?=
 =?utf-8?B?M1AxcVd3WlZxZE5vZG85Z3drejN6MFU3aWpNQjJPTEprMHdFK0J0LzRPSDds?=
 =?utf-8?B?UFdhWkNGOCt5a1UvajhsS3V4eGVVRnMzUUdJK2hVN1hyRlhta2JKS3dYVjhk?=
 =?utf-8?B?dGdCZTJPaGJYaS9Nd01qY0NSaXRCd0JyNm9CSFFjS095bWVDWHN4UFRkaFRk?=
 =?utf-8?B?dEhXaUxJQ2FEZjRTczFKWUQ2ZVdYZjN3cFgwWHdtQzFjN2MyM0dSZ2NHeTJv?=
 =?utf-8?B?OHh2WDY3WWdEMjZQczBFNEQzUUZLOFBXaDdlZU82WkVRZi9VZmFEeTllRG0r?=
 =?utf-8?B?eEcxaWZmakhxSXBMTmdjSXhJVzBoSW9haWZRYUxRSm1wU2F5TStHYTFaME1E?=
 =?utf-8?B?Q0x6T1lDcUhZNlNFVGJNZ3NsUy9vU0kvbFZIODNVSmxWY3EzOVl2WHB6TE1R?=
 =?utf-8?B?a1ZZTWVIcVFvMktZWFpKbmx5YVBNcVpEajk4aGlzSzlDUTNWdEJnMEVHaVpv?=
 =?utf-8?B?NUprOU1hZ0t4RTVMdmFjT3Q4V2tzdEVYdXNDZVl3Vm5BUEJlWmFld2hPQnlG?=
 =?utf-8?B?eGsxNHVITnlJMnUxdWhGSHptV3ZWMjg4RWtKRmhFc0dSQUk5bmxFUzgxSVpm?=
 =?utf-8?B?eVhiZE1kQjdRNzZHaWFyUlMzcE9XdmYySzVqc0NmN3FVRGMzamhuUVBxWTlx?=
 =?utf-8?B?cEhvVlhXT05sZEtiT2lTK0FGQjZjbUgwbEs4dEtMdTFURkI3c0EvK1phT2ln?=
 =?utf-8?B?OWh0TTVpdDF0M21kU0NvRXZwUnZndWk5YVNDSzl1UExzdXN1Q3dQdmVzenFu?=
 =?utf-8?B?aXErTU1mbDdBQnhsR1dNelMzNU01QncvUUFyczJuQUUyY3lWM1E2TmFtS0FK?=
 =?utf-8?B?ditucHJTWGhZUG1lYmFxMGhXWTkzQzg4YkNoMk9oM0VjRTJEYXVXRllieUlV?=
 =?utf-8?B?THR5RW9xN2Q4c01xWHkrLzNTNGZHcytQenhkcjhESEt3b3F5blduZGtUNDJC?=
 =?utf-8?B?ZFFXM0hNNmhUTVM3clhBUHAwWTc3ZkFTV010TUJiT2VLVTVtTldBSytSL00r?=
 =?utf-8?B?QmlVR3ppQ0x1SUJjeHl4dG9kYkcrZUd4OWErR3o0RHRLVVJLN2tnUkVGYm00?=
 =?utf-8?B?STVuY1ZnODBaQTA1c01tbDhpMGtYT1d1cndBdEpNc1JXYWFyd3NWcld1Zkdr?=
 =?utf-8?B?V2p4M05tNlYxNFpwbzdZSVB4Z21MTWhJNFNycDl3Y2wwWG9LZm5HOWttR1Fs?=
 =?utf-8?B?MlBTa3BUS21uZERsN1p3Q1RWdUpXMElSaGdvcTZvenBvcW5nb0lIbGZxWndF?=
 =?utf-8?B?VWZIU2Zla3hRZU5ueUk2YkdLWVRVY2gxRFcwZVFyUEhOQWJsVHVBV09vSWdk?=
 =?utf-8?B?QlErWVBuMTY4VGVtNDlrQVZwR3JPZWhmV09nWWxpMzVHeFhYZVc0T2RaTWw2?=
 =?utf-8?B?a3h3MEtlb21Nem9iVE4veTRJWW05TUlramJHeFhwU2NrQklLeW9tZkoyOFBJ?=
 =?utf-8?B?L1Q5V0NPWGhzUm9kcG5DZm85ZFZFaUhBUzZFMXJNQ2QyRUk0c3F5VEgrbGN4?=
 =?utf-8?B?aWxhSFlrT09IR1hhTHFGWkVQbmg0RUVUNFVFdm9zTTdLeWw2RUUrU05leDkx?=
 =?utf-8?B?d2NIMk5WVkJkTk95UmlSMElmL01wMjI1MTRwQ0NyZkk5Vzh5THZISy93VXdL?=
 =?utf-8?B?ZHpMMnliWGIwV0ROellMbkMvZmlXV014WDFNalpMSDZ6NGdRQnVsdXU5c1Jn?=
 =?utf-8?B?MzNUOEFzb2ZUQ3krQUtKVWFaNkJQQ1pJKzI1Y2dNMVBCOWZ3RWs3KzRKZVZ4?=
 =?utf-8?B?bnJoMzhQOGRMUDRQcHlpdU0rL1Ava3ZCYVR6UkZqR1FleDZWcVBVU1hhdmRC?=
 =?utf-8?B?SzhVVTk4V3l1R0taWFd0bC9Wb1JSNVVSMFFYTEpJZG5lemNQWnNzVHJ3ZWow?=
 =?utf-8?B?Ry9qaG93Uk1mY3pNeHI3ZVBNNEFNTkFkbHlnazVjclNMdk9CaEZZOFBXSDho?=
 =?utf-8?B?cEZJZTlBaW1uZ0pMaWt1VFc1L1lDTUl3TXljYmNuSFpxVHlXYWpvdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b406941d-3f01-4bea-0371-08df1e45e1aa
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:22:39.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URGpBby8sVDceYIf05YeTPS+r61705UH/OBSJrwE+o5eCwNFabkLF1s8ZW0Zi970OpaEQfvECNSfoegWFP6QhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6088

Hi all,

quick note: there won't a community call tomorrow.

However, if you happen to be in Prague for the OSS EU next week as well,
we could use that to meet in person. How about gathering after the booth
crawl on Thursday evening?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


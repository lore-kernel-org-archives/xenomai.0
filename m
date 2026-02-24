Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B903A9DA4
	for <xenomai@lists.linux.dev>; Tue, 24 Feb 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958249; cv=fail; b=tPhUocmRp6/bjV3JATwFUcU7O63UTBcgE/0ARQPw6HQ6jSXU6YpROdt+DncIkjl1ZaaRehS1/qyMI/Zh9K8v7hpMavLNo60eXCsgEKZBG+a7ggSJHbRKBg8Pnbfev18SgLGAfLzeODqM6nhrwz/8WBXt5HynLzydb5ygjaGNJwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958249; c=relaxed/simple;
	bh=4L+2zouPOzYCUhx4x88PiQtbZvW2hs34B0fqq8VIuq8=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Tcy83V1h9cUwC2tV3AIgyGTqR/+QMB7GLO6Jx4FRoCANGwC9TTIu58S4DC9jGP4TCc42nFKnvRUmw9pLIZV1p1x0wJ2fun/PoTd0Ybl32JkmSeAPsFttRN0NDpD51QQoCK1L2WejVOvL9JYRFLQshRZd93aeo9lsH/8m90ewkII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=j5VDWGkm; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="j5VDWGkm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Px8semfBhtoxdl8zWEaiUedQHSAa9K5au/hRUZ0MHq5LwPIA7BPItnks6fyMPX/5oGWiP0igMw1myxgH4ugoOH+P6a1uLhtSn8PwrxDCVS7EWEYZvhN7+bZsp6Ak70sNMi1QlSVzRwaHlTJ5WSi+FwMvMFQgq4amUJaX44zDZ60ZTragjtJnGhcmJetdsW5rysETkoWcFI0tsLOzA/aZF5mrQ8QcAYoqnUKF07MhfZYNftfkpYKbAnnkvqsu/FTnqMRnkbWTXT28r6cHneJTaRjH+ZnrtZUPdVaPnvgQpR+wPRKMOXiVIG5mx7WjSR4wDZJTwc1APZzr2Wz6p3K1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQrH5zIHkbofIrmwmRTTNFn4O5m1ZBzTdfnuaZcuIwA=;
 b=VKw5kriC2ej432vaPqtqBhfwOyYgPAUjfa9H7b/1UrWOcPdl05CXRnIBbiitBVckuCwPZeTsF1n40yuYw+3frWflZJQL8E0J2gDCw/88iopDvmN3hcp+rQlBcs5l2juA6CowJiDX3Gne5S+JRXoZm0XXPnqEl1cff7mZPbjGTST8KIiMUp4x/U0spjcJkxV1QdqrOHB616ZhO6j+NnUE00DCVXnlZNSZQjYGoejJotcixQS5m/dlnq/cAzFvsUjAbhCGajH3bFjRRICBRia4UUENyQr5MxLfrBGZyZ8PNnt5kAKWTI4XgGEPhnlkwXYze8qzUjnnu2Y9xP1Viys5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQrH5zIHkbofIrmwmRTTNFn4O5m1ZBzTdfnuaZcuIwA=;
 b=j5VDWGkmtv28rpKeYV9WW4GzPlfKS7wtguikUeyQw3K8Vddl7mxu+B0oDULRt0jiAAtnaPX/DLTgO2k/2rOqrKigDHVOUSho9cOFW4ZlKNIabR2BkLixfJelpHVu44I5mAuspo4sHxGVBBtodJVa+f4ycyIq40nwnuhYhuMlJqY4NoQrMro20qYULdgtBxzGB/mHp9vTCoJABXS5BqkMhjrU/WIJYdz3AjlqzLijWB4yZC+tg5CQuYwLHCP8/swMSLH1yI/Nc2YAtD+7rpBjU/xp6a1mcfAGUgiSvzpvnV9t2vDll4DbHVjw0Fju6z6GOFPZE+nVSbSrK2yuoIYMPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 18:37:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 18:37:24 +0000
Message-ID: <21782436-df95-45ef-890f-c46d943ccd5b@siemens.com>
Date: Tue, 24 Feb 2026 19:37:20 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] ci: Give pipelines a name
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:610:57::37) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 9049089a-3ed7-4ee3-30fe-08de73d3c0a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yjg3R2VUTnVPR3ZOQ0dmemJET1VOUTVFRjcvTCtTYS9ZZURNVzR2UkZXUGdY?=
 =?utf-8?B?eitpbTlhc2RSM2l3QU5lSENVZEJrYmNQOTN4M3ZPVE5WcXpWQWRZL2UwSFZ0?=
 =?utf-8?B?eE8yQTZjZWxTd21qaUhUdHRxRVlkZW1hZGVRTUcrV0VBWi9BMUFvTmtNa1F4?=
 =?utf-8?B?UzFhcnBIOFkyT3RmY2JYd3prV0l5aVhVUVhoWmZ1VC9RVTN4MUFBV1VNNUJs?=
 =?utf-8?B?Z0Y3azZXUEFJbVJUMU80VGFqSk9XZEZiUEkzSitVa0ZyQStHYk5pRDJic2pR?=
 =?utf-8?B?NWMycTB3L3JiRi9JRDh5VHNTTHdqQjRhdVhkWW5aRVhXSHlHM21jQnpZVENt?=
 =?utf-8?B?MEhJUkdNUDZYZS9zbGVUaEFjSlJnNkVXcXJjeDYxVzdWSmRjbkVTODZiK0hr?=
 =?utf-8?B?WHFEYjV1OXhGcXNpVk1zREY2TTcrcnJlT2dER3NsYm5tS1FET2p3VGkrUGZr?=
 =?utf-8?B?UitaUktBZ0lNaks0T0Izc2ErMHUzNitid2h1Zk1PTGZ4K1dtSzBvY1F6SDNE?=
 =?utf-8?B?UlRBa000c2pTZEs3VG9FQjh5dENKMFdibGtGa0l0UmhtN2d4eEdQTzg0b205?=
 =?utf-8?B?OVA0QmJ6bmUxOFNMU2pobzByUzdRb095L1puTWU4N3NpMXpuTm52VFR2UHNR?=
 =?utf-8?B?V3ZTbjZnMGxxMmVXS0VZZkt3M3NPYythZ2J5UFM2dm1vUjNYRXcwZUVkNHpL?=
 =?utf-8?B?eVFUWHJRQWlXallEOVhMQU1Oc0ZXaXFyYkErV3RWUDJwa21RQmlCSXRCMGVj?=
 =?utf-8?B?dVdhMC8vNTkxYlpQRkZwYjNVeFFhN1NHV1dTYXlhQm14Um14RllnbXNOVTB4?=
 =?utf-8?B?dWpOV000UGY1VzNoTHBoeGJ3R3JaNWUxZ0JUc1VvbDhVZTdJREdsU0J4akl5?=
 =?utf-8?B?WjZFV0Z3Smt4NmtDN2RkWGl4UnViTkdqVjluSXVxZGc0cFZTMnluWHZzeEY5?=
 =?utf-8?B?eW1wUWRPSDJnN094TmxDWGdHWVdocHRBUWpuamlXRWdpRHV6K3lKT2J3SFhp?=
 =?utf-8?B?V1k5dno5ZlVid3BBT0xRVDB1NEZZcm93d01obU9sdlJpV1dhZnRRT3lZa3RC?=
 =?utf-8?B?N3J1SGJUN0JoYUhFNW1ZVFJielZEbXBsbHFiejVwMU0yNWM3eC9sOTYzUFVh?=
 =?utf-8?B?TFlRY290aDNPWktNSHBwRDNKWWhoV2lxYkh2OHhsSi9oMXFZZVNhdW43N0lk?=
 =?utf-8?B?QWJESHFZUk1NR0xzWk1tOGVQTllNcEllc3FDT25Tc0JXemJVRUk2NEpvMi94?=
 =?utf-8?B?VFJjcDZXT292dVVwdnU5OTI0dlhFU1B1RXc3RXBMREdCZnIxM0F2RWVPNmFs?=
 =?utf-8?B?YVE0L3ZEeHBpWHNQMDJ1WXhKL3QrdWVKd1pubU44TXdoWVFnQkVwWTdTYm9X?=
 =?utf-8?B?a0xoRndVU0dyeXpkRkdEVzdwWUdxTXJMc1h0UE1DWVJzOXlCMUYvMU1rZ2RP?=
 =?utf-8?B?SGVvWE9GSkFkN1pmYkh4cmJiMDNSVmJPV1JzWlVXQ2F1Y3RROS9LQXppQnk5?=
 =?utf-8?B?em5PazZQTkg3aDVNbzI2RXd5NnBEV0MzREg4RlppWFFJZzlxVlB3eWdKWDF4?=
 =?utf-8?B?dVgrK2luVVNrY1dUSDdhWDhPVXZrZUpVQU1NVzhTcXVtY1R3ZjgvWFdlNkIy?=
 =?utf-8?B?MTRBeW5aUFRIZUlocWZ0clpGbE1CeFdpN0Q3dnFmS0tFUUViMm1UYVZlakVN?=
 =?utf-8?B?QUtvSDh6aFI5RDdycG9WNHFLSVZvdktaWTN1VXJFU1U4b2VQQ3piR1B1c1Vo?=
 =?utf-8?B?QTNKK0R0WSt0TU1zbVpwQUxBcmxWQVI1a3QvT3dqRFdOVUtVdEFscFpBWGdz?=
 =?utf-8?B?NERKTEZ3MmlBUVdBZUJVUlp1dGx3Vk12MW5uYXhoQmdxT05XS1FVUi9Xa2F6?=
 =?utf-8?B?L1haREQ1L1EvWk5OSkwxcWhweW9UcS91NS83SU1pOUc3MC9MNEdSbnFka0Fl?=
 =?utf-8?B?SXoxUnAyYVV3RXNYelV6bE5mVWlEazRQVUVYbkNMNFBBQzRXRFZqamtoenFq?=
 =?utf-8?B?Tk1DSDBJdU5zRHo1K3FKWCtQQXh6MGJZR3A2VzlvRXBOeUlWeFJsVDZ5T0c0?=
 =?utf-8?B?VWNTVFJ5QlBqVDFRcFc4YnJFZ2o5U3JpYWJFWnRJK2NROU04N0dEaGtOUHZi?=
 =?utf-8?Q?hkyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXhBaXFPZ3VWMDFaTGhoWnR1bkJpdUc3L1ZIa0dtTDNvb1lDVDd2MFloc1hy?=
 =?utf-8?B?NUN3OHBLdkFVaGJVWkZucDNOcDVQZmI5cEJHUGZwdkJ1RlZOMFdzeVhOYmFI?=
 =?utf-8?B?ekJtYVA2VVg1YTRHUDRBSFdhNGsxY0dKVHY2U2hvRExSc3pQd1BITXZDWmhO?=
 =?utf-8?B?S0h1bGo0OGJQQzA5TTZyN3ZwcHljeURzMXFkT2ZNL3Nud2xVaHNteEJiMC8w?=
 =?utf-8?B?ZkhoT1Fka2ZJVWloRmdCMFNBVzlrbmtJNkJrc0ozeVVIWHdlQ2hTYnRHYmtp?=
 =?utf-8?B?Q3ZYWHgrSTFQbnVDMkJ6Wk5nRERnR2lDTWVGeHRvMSt0Z1BrRHoyNXRaWEJj?=
 =?utf-8?B?NmtISnA5bDE1anEvVmJEckMzelh6QnlmZkVaMTl6OUMxMjdxMUFuU0tMbTd4?=
 =?utf-8?B?NHFKYk1JOGFoajlUVjJCb2xtL09RMDBGVExjc3FQV0tVNEtrU0VEaXVUa3ox?=
 =?utf-8?B?TUs3Q3E4YWpSMzF4N3ZCeG1tNGg4ZXBtSXJJY0pidVc2cTNRcDJ3QU5xQ25J?=
 =?utf-8?B?bCtKVEhXZ3JCWFN6YTBQMTBzeEViTElIeXFKYWNjSHlzbU9qRGw2NE9BTEVl?=
 =?utf-8?B?bmVFU2ZGUlhXZ1pzUEhINWxic0NhU2ErMFIweTQvWm44UWx5NGJTRSs2Witn?=
 =?utf-8?B?UDc4czk1YkRHRys4QmV2NjgyVjhES0RBeCtpeEN3eUI5MTE1cDQrVGp4cWZ2?=
 =?utf-8?B?V3dPQTd1aE9McDRabm1mdWlBbGpsUDVFeUJxcmtYK3lqWnpwU0tMTVRTOVRo?=
 =?utf-8?B?UjJIaVJWS0toUEFLY1czYjJKaHJ3NWJUbzYyRTVJNGhzZEVsaFcxY1VDNjZm?=
 =?utf-8?B?ZlhobVBDQUpBWkkrNWl6OVhsYnI5QjRSSlJUdW5FajNuQTVDd1NueVBURWp4?=
 =?utf-8?B?a1ppWUhGeDJpLzR5ZjkxWkJnUjA5V2JCVGphWnpDTlZxZzZYVDE5M2tTMDYz?=
 =?utf-8?B?cTU0YWw0NGxTMmtDNWowbU16aFJ2WHAvcHYrSG1iOXd4S1N0ZkVvaE16VmZw?=
 =?utf-8?B?VFo3NXFtWE96c2t5VEdnMGQreGY2NkpIclA0U2l5K0gweFgwV3dnanBpejJk?=
 =?utf-8?B?Q09aVU5qd0QxNEJhbVJlUzFqTEs5K2dkMGVxUkwvNnlVbVFDc3JjMHJGTWZK?=
 =?utf-8?B?TWNNVGN2WVdCNHRxeWI0Z1dsaWZIMHZzYjdqZklISXFsVWRGWVY4YklGT0w2?=
 =?utf-8?B?MEFaVzRYcUkxbnZTYzEvcVVPUG9aUFRsTzh0bkRpZ2k5bG1IYXZ1bTZJRGcr?=
 =?utf-8?B?alQrVFdzZzlPcDdPbmlhTFhwYXlJUW1PS0pQcDg5ajNOVFdNSkZYbXRoMVh2?=
 =?utf-8?B?UE5pVFl0YithVi9uU0hWTEZYOHR2V3BFeGRsUWRHV3lYemRUcW1naHFKZGE1?=
 =?utf-8?B?NXplVTZhTDZFNityZG9vOHN2cHFOS1JGaTV3MWp2WFRISnh1ZVlLdXQzczc4?=
 =?utf-8?B?eWd1WjlsVUlSenQ5eWFMNXlUamdQS0ErK25DK0hOU2ZNTHJxS2FZRUI5YmY4?=
 =?utf-8?B?b2trdWR2R00rSnRnLzhKazBnMVhIZW9TRk44aFlsMjl5d3pxcXFENE81MmRU?=
 =?utf-8?B?V1BTWVVheDNnQXNSalA2WXJrZkNFQlBZZ3ZWUHNsWjA0L3d6cUE1eERJRmhT?=
 =?utf-8?B?UjlQT3lIWmpFNnIxTnVKcjNtbThhK1Z4Sy9ZamJvVlZVVjl1TkdZNE9OT1R1?=
 =?utf-8?B?NXNnazdZdE9ZUVhyTFp6aXpJNllFd1g4c1FwWGRXSEFWc2d4V01zV2JqREJs?=
 =?utf-8?B?L1ZrZEFoci9NVzZXdDRwRDFCdk9KSU1NQzhYMHc0ZllFeXZZOWI0bEorOE5h?=
 =?utf-8?B?QjBlY1BpQzNONVZiVjNHVVVzVU9qNTNDa2RlZm0wNlZtQW1wZitVY0tQelNI?=
 =?utf-8?B?TTRkaDVqZVBGOWpUbzlhNitORmdiYWFsL0R1YUx2NjR2dmJwQ3RBYnFBZVJq?=
 =?utf-8?B?NlJLNTU4SWRXcnNUTlpOM2JCTEtoL1JTRWtLaEZGYlo4dTkvVGg3NWxtN2pI?=
 =?utf-8?B?ekNDd2dSdExGbmVUTHM1aENKOHVZRFBhWjk0TXFoam9Rb0sxQzVkK29abkV4?=
 =?utf-8?B?OXJ4SkxKcTZhcWJ3Mk00RFlDSEc1dEE3bm16cmhodTFVWHY5cVFmNUtuZmdJ?=
 =?utf-8?B?ZWk3QXdEbWZMbldNUVZSZ0w3ZEdLakpUWU04T1Rpa29iVCtUanA1S2pKV0lD?=
 =?utf-8?B?UC9KUlgycGZSZVdFWG90UVlqdEJCMnQwdE1SQXZmZVNiU2tVakMzTDNYZ1VY?=
 =?utf-8?B?bjJkVVhTbW5NQlB6eWRvNzZzYTRnSmc5aE04WVdtenR1MkZoV1BDSWQ1RzZy?=
 =?utf-8?B?Ykp3Q2FpUWRhL3lObTZRcFh5UFU5OXk1NENnbkNocnpsK3E3QS91bTV2bXNz?=
 =?utf-8?Q?iMnvzF+z3CWKJ8g4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9049089a-3ed7-4ee3-30fe-08de73d3c0a1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:37:24.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbFnszInr0SjPq3ok5xMsQIzy1dAeRcAQMTTf7FNyXgBxbl3lIF386W7pzXAN6373eUxcgWfuyAlKCK7gDKrxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7652

From: Jan Kiszka <jan.kiszka@siemens.com>

This should help to identify why a pipeline was started here, regular
push, external repo trigger, schedule.

Requires that the xenomai 3 CI sets the TRIGGER_SOURCE variable before
issuing the trigger.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml          | 20 +++++++++++++++++++-
 ci/trigger/dovetail.yml |  1 +
 ci/trigger/evl.yml      |  1 +
 ci/trigger/libevl.yml   |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f810dd7..ffda862 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2019 - 2025
+# Copyright (c) Siemens AG, 2019 - 2026
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,6 +13,24 @@ variables:
   LAVA_TESTS_ENABLED: "true"
   ALL_QEMU_JOBS: "false"
   CONTAINER_REGISTRY: "registry.gitlab.com"
+  PIPELINE_NAME: "Branch changed: $CI_COMMIT_BRANCH"
+
+workflow:
+  name: "$PIPELINE_NAME"
+  rules:
+    - if: '$CI_PIPELINE_SOURCE == "pipeline"'
+      variables:
+        PIPELINE_NAME: "Trigger: $TRIGGER_SOURCE"
+    - if: '$CI_PIPELINE_SOURCE == "schedule"'
+      variables:
+        PIPELINE_NAME: "Schedule: '$ONLY_RUN'"
+    - if: '$CI_PIPELINE_SOURCE == "web" && $ONLY_RUN != ""'
+      variables:
+        PIPELINE_NAME: "Manual: $ONLY_RUN"
+    - if: '$CI_PIPELINE_SOURCE == "web"'
+      variables:
+        PIPELINE_NAME: "Manual run"
+    - when: always
 
 stages:
   - parent
diff --git a/ci/trigger/dovetail.yml b/ci/trigger/dovetail.yml
index 633ebc4..b904c1a 100644
--- a/ci/trigger/dovetail.yml
+++ b/ci/trigger/dovetail.yml
@@ -59,5 +59,6 @@ trigger-xenomai-images:
     KERNEL_VERSION: $KERNEL_VERSION
     KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
     ONLY_RUN: xenomai-3/dovetail
+    TRIGGER_SOURCE: linux-dovetail/$KERNEL_VERSION
   rules:
     - if: '$KERNEL_VERSION != ""'
diff --git a/ci/trigger/evl.yml b/ci/trigger/evl.yml
index fdbd15d..fe87bcb 100644
--- a/ci/trigger/evl.yml
+++ b/ci/trigger/evl.yml
@@ -59,5 +59,6 @@ trigger-xenomai-images:
     KERNEL_VERSION: $KERNEL_VERSION
     KERNEL_VERSION_WITH_QEMU: $KERNEL_VERSION
     ONLY_RUN: xenomai-4/evl
+    TRIGGER_SOURCE: linux-evl/$KERNEL_VERSION
   rules:
     - if: '$KERNEL_VERSION != ""'
diff --git a/ci/trigger/libevl.yml b/ci/trigger/libevl.yml
index ece5f06..bb996b4 100644
--- a/ci/trigger/libevl.yml
+++ b/ci/trigger/libevl.yml
@@ -19,6 +19,7 @@ trigger-xenomai-images:
   stage: trigger_xenomai_images
   variables:
     ONLY_RUN: xenomai-4/${CI_COMMIT_BRANCH}
+    TRIGGER_SOURCE: libevl/next
   trigger:
     project: xenomai/xenomai-images
     branch: next
-- 
2.47.3

Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104320298B
	for <xenomai@lists.linux.dev>; Mon,  7 Apr 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040549; cv=fail; b=sOJ1iXXAfFgQ9AvURMaSnpV4h+mS28XPpNzeVn2d5y/9gz+g5IMh9BGdmbqqA0KMLfqr9ogF8YLNGUH5iUjuU9Wmf9llNwjbnRL7+UFXtrDRoI/yQKK2abNp3IlfDV+iqr2zApbt6awthh03tOtKOmRltcpXYwMa1FIWS2LguQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040549; c=relaxed/simple;
	bh=PSB/pPe7B/wpHUg+WOxFBW4SGA8vzS7UqlJwQhKfrPE=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=IszJq+rE7rEWyWzOFXB8DaRyz7nKNgNlrMIEv0f3z/yEgk7bqGOUTYSh9TkW+WqztlQ1lD+wDZd1fTGVEWt/SRQCrjL5LFBCzAF4rgsWOxfgoPMjzyxtG4YJO3Spw6D4Aivgma1dpehF+iVXBSPh3sbLnbiaS6QNslYbSweyM88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=U2vXxhcN; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U2vXxhcN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5uwToK9xvrQ+shuhFODCfT2bOAKsDc3eVlow0y/eyOXCRY4XzWjegKVc3U/HZDeU7vwkzqviTyBAnqY1IgICW94ceGZ4MbIJu9IR144gFsJjH9bgk3KQfBOv4xX4FvPIluS5KAWbOyIulCNLiJ5eqQgLk1aDdkH28qer8vcpowCaVxh0mEP13kgGG/UZ4tEgP2ZFF2pttwtcWu5ebKbLIdwiEYIMjh9QmpjRQt6KpOMojRqvIkdUHDvo/ysy1vObWsgLgLeqz6y+86IcGtcVn0zra1U4Ea9D8p3l5v+ZDw6JakQSS8V2tRIFnjxAVXm1VcN8K7SJZzorT2dVGRYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+98IItwSffOrqD6dgCNeq4nAyKr9VlXlFklbJ35MX3I=;
 b=Y7riB7OC8ccU2tzDQUyvky4awgMRc2qXTF8gF/3Si1fHod4fuWstfBmnctfas3SUwr1tGEH+6+Hok6IbE/jHnll7Fo0/PNsHVeQUvDvSgvpgLEkqGWkmTgj24UCsf478PjS/k9UEaWU3YRZaOdmAh5drADrOcRvoURwTupasZy6I0XMXxP5LEh92GiyRat3wnB94r2PO5saTMOPm33QltfyOQdweoA+fxX6L4TVDBVllrH2tTpB3ZAKr/fYIos1kdychWOP+EiVzLHrheMtTRsOeN9wfmMR6mMfkHg/jht8N+DCjzeumz8HqbOrMqqwcAQnuQayHvpmEp4w7ZgtjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+98IItwSffOrqD6dgCNeq4nAyKr9VlXlFklbJ35MX3I=;
 b=U2vXxhcNxsf8zgjVDx33LY1KLKhpNDNAlPyxqwcQSuhGp7+iY+Nl4LHgIczcWrI5wRo8mNt1ny+acMr86EmHyEgaAfI0yXjpVKvdOmBWJ3MHTS23Q89C+u3RY91e9cD9WYsgRnR2dt1iuhiBoDWzKUrb6XjW3vS39IP9hzmBwKD0AfQtCiJLrTLGsK3X3xgYeYbRnFOwkpsP482HUpKStrcCP6kCoq52OsFL6mdavCNOhNAXlgomEWoOyc3DGXLLq4qvXcO7XyxHV/urU0fdiO15QSPlbnuXMxMc13tywNGkfDY6zVbzJ3nL3X/JZwNgBlYQyLjVzDOp2ogTOnkvzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5222.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 15:42:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 15:42:23 +0000
Message-ID: <78dbe3b5-55d5-440e-9b62-45db1f2add5c@siemens.com>
Date: Mon, 7 Apr 2025 17:42:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/smokey/y2038: Fix error propagation
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 94bc75fe-b04f-4473-f8bb-08dd75eaca15
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2E1RzRaT0pwT2ZWZWYrQUY1ZEhteUtYZ3VWalRQZWkvempoRW5XbTF1M3VR?=
 =?utf-8?B?SWVhMDVjOVkvUUtzWTBLb05oQUJ3ME9SQ0pIVE5zZ3dORndXYTJrQzdGMFdH?=
 =?utf-8?B?MTgvTHprMElxTFJXMjVZQVk4dEZEblVZNHNSYlJjendadnIyM0FsandVRTRR?=
 =?utf-8?B?cXNTb1k2VnYxS1RYZTlNaHdSSWw4Mzl4emNMc3dMa3ZFN2MwR1luMkhiTUE2?=
 =?utf-8?B?cTlzcWdaZTlSZG5TeHdVdzZDbU9hd0NsS0NxTmZLUmVKUVlMZzlsektYWkgr?=
 =?utf-8?B?UUU1ZlNJU3kwOFVhZWtrNGoxdGVIUldiYkFsWU1VWVgybUREMGZ3elNDSWlt?=
 =?utf-8?B?STl0eHhJTTNyeFpzbG56L2RVUURvZGwrcWdkelZTTUxHR1dxZXh1OXNNWnJp?=
 =?utf-8?B?MThGckVRSVNTcFVlTytuTjZBY00xRlUrQkZQU1h5UmxzeHFoWVZDQm1SdmFo?=
 =?utf-8?B?SHF6bER4enk2WnJTODNCNlNBNk1Fakw3UFltK1Y2d0FJdTYvTy9lT1NBWmVv?=
 =?utf-8?B?azJjNkExOTNPNWFSVG1HQUhNTk00WkMwM1o3ZlFneXB6cVJVaTllSkpIMHhH?=
 =?utf-8?B?OTE3M1J5WTNWOGFGODhqQnN1T1U1bXJvWWF3TFpEanpKRFR0T0VXVlpiTjhF?=
 =?utf-8?B?M0JPcjFwbWpVZldzamhVcEgvL0g3RkR2UlNDTUpqUkpiNzdobjJXQzVaVStZ?=
 =?utf-8?B?UkQ2VUhEcjR2MUp5cFZmM3o0TTdzZUNmbVZTV0F3Q1J0a2xTMFhaa0ZmNkJK?=
 =?utf-8?B?MG5uSHhqZGoxZXFpZ2MvYS9kZ1dORkxIZ3ZpNVRhZXRYUWc5YU01UXdDdldj?=
 =?utf-8?B?WnFlUWxkSTJqS3RMV1VKSjNPbVU5VEY0c2t5dFZ3VENzbThibjRrSk9vZFRr?=
 =?utf-8?B?aXRSZFpHWjFTMUhiRDlsSWJQQjEwZ0NYSEwvVy9PZkdRemlQVlV0MHFpNkFE?=
 =?utf-8?B?STFqeTdnYkltSGpRYTlVOUJMVExiTEFHNWFHYUc3dVNvVTlUTStNRC9YSXRY?=
 =?utf-8?B?M0Fka01WSUNqZFd0YUFjVmpoNUdFRlBoekhJaGlwWE0zMWtjTnNUejkwRXZw?=
 =?utf-8?B?cVhBdmx2Ui9UZ25rRmNVeXQ0MUxMSDFzdzltL1JqVTViMkdJWGxPM2wyakFn?=
 =?utf-8?B?Tm42QUpicGpualJxdUluRmxUc3dPN3RDM2UwdzRFQkFsMjRMYmRKY3A5YlZD?=
 =?utf-8?B?Y3ZFY1hHeDZSZHNEZHBqR3QzMlU1ZkpibEt3VmljVmZJMXorNjg1TkVZNzB5?=
 =?utf-8?B?OEE5bkV3YWdaV3FaWVhaclNMbzYyL2VXRnlDZkF4QmNXeUV6VG5abkp2T0Z4?=
 =?utf-8?B?UWxiZWEyc0ptcm1wZGVFaVBZSFI2U3Zwb1NJSjlUZWVtbHpkSEJwU0JlOGNF?=
 =?utf-8?B?UDlIbjJEQnBuL3lqVmluaUxtNmJkZFlRWGx6Z3VPZTUyeXZtUzB6VlFybld3?=
 =?utf-8?B?NW5uR3M1NFVIYUJRaGxIWWcrcklWV29VbFFSeEc5NGVjTVp1K2o4Z2N4VEZF?=
 =?utf-8?B?MDJjRy9SaHl1WTNRZXNHMzUwUjlKWDRheGVwMEN2dzduUEhuQTlXWXRNVFdD?=
 =?utf-8?B?VE9KM2paOW4vd2dBalRFYWdYbnB1MldMUFRwYUtxWEplNWNoMzdTKytsNXpX?=
 =?utf-8?B?ZFNjTE5kYkJOSGZ2VGo0dytuQlRtZTcvakhFMW90UEtBUnVtZnhBcjI2M3RM?=
 =?utf-8?B?ZFNtTEtZQVdwekRseXU4RWZlNmkyWXovVkQyNFdiOEIzYm5WK0hxeEl1Zmgv?=
 =?utf-8?B?S0ZHdGJHcG1Eb1ZCaFFHdUg0bUkzMWFtc1JYVGdRRkY3ZmNJNnlFamRRWC9i?=
 =?utf-8?B?NUJ1dVhGQkM1VDEwK3VFb2RBdEtvM2swREsySk9VRVd3UUgvSTU2OVM3YVlN?=
 =?utf-8?Q?kGEmujzAw3J1Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGg0MnBxeUxoOWhLbFJNK2tKUExXZFVMSWl2ZGJWTCttZ251bjV3UGJNb3Nn?=
 =?utf-8?B?NGFubWZIaGVHdkNYRTNpczNkaEFRenhUVWpxU1lNMHFNVmw1R05aeXBNd2th?=
 =?utf-8?B?eWJVbjNocUdFdE1EVGxic1pHNU01SVNiRHlwaFdWRVpXUUdOZ3hXQkNTa0JM?=
 =?utf-8?B?UUpBUTVLZFY4YmtZTC84am9Mam4zT095TDJCZ2RHQmJTZVZYaEJmU21nbURv?=
 =?utf-8?B?WUx3T3hrdDFFVGRUV1dDcjB6V1hZM2dzS3VkSmY3MkF2aWVFeWtyWkhXV1RO?=
 =?utf-8?B?anN1REZGaWRBeWR5QzVoZTZ2NmtmK3h0bkR5Ujd4SlVjUEsxRFNBTFVBWm9G?=
 =?utf-8?B?a0NqZDJJN1AwN3EvL1IwL1ZCZFJlZ3o2UXF2QVJWbjA0UTQ4a05OeFhuaEM3?=
 =?utf-8?B?ZE1lUGQ2dllhZHhjWEpTMExQTjhXN0Z6Q2Jmd2JqaUt0b0hQVmlMZWQ1aHpp?=
 =?utf-8?B?anYyWkdadDd6MUJEVS9wUE4zTlpuMlJ1QmI0cEdMOUE0OXZNS3RlWkZuODFs?=
 =?utf-8?B?dTRhRzlsZFFQMlBlQ3ZRTG9najFBUVYzTjFrbDJFeWhRYWpZWEpld2dPVnAv?=
 =?utf-8?B?TWxtdkJzbWsvM1Q0YzVHNGZPYkZXbjFsYTFJRlUrRWFmWGdHR2RwMmRCOXhH?=
 =?utf-8?B?TG9BN1lEc2lQUVFpOGJ2YitiT2k1eU15bTdZeUdnOFE3N0ZzZEFuczJ4eHMy?=
 =?utf-8?B?OG5aQmR6dTZTMVlWTjJ3RGZaL0RidWQxRjMrNzdSakJNTjlTVmFRd1pqbkw1?=
 =?utf-8?B?UjBqM0xXcnBXR2k0czVhT2EzNmJLaGVBcDJJR05hOTN6amZEVWJra21iNC9E?=
 =?utf-8?B?Z2ZUUElqTFZ2M1VRL1NDd3k0aEJhNjltY3VoK2Z4YkZRN1ZjQk5aTHVSM2Nn?=
 =?utf-8?B?TEFCQWZha0k4ektYcXpnVytqT3VWZm1HL25xMTZ6OGxERTRCd3hZcG9LOVk0?=
 =?utf-8?B?cWVONjJzb25OVFM2bjJDNkE4VjYyWngxVnR0M1FIMk8vSWxVMXRYRk5NbUNE?=
 =?utf-8?B?OGVBUVByVFQ2ampDUGVrdVRIZ3VudkNmeEY0QkFoK3pvUHRoZE5GRUxYaFhR?=
 =?utf-8?B?RnZaUFlMUU9mS0dRdVFXbGlqOStXTWI2dFNqTGVjdUw4SWRldVAvY004RUNH?=
 =?utf-8?B?dWdLa1grRm5rcXdPWXREdVFCZ3lGc3JlT3dOUHYzR2xFbUVlUUpNaWdxMlhE?=
 =?utf-8?B?RTQwMnlsQitXSkNnUXd3Um92MXZnUHJJZmdSTGs5R0VZYnRMU2FTaldZSTIy?=
 =?utf-8?B?WVlkT1BkMTJsbkdrNWxpTDdFeFFGNEwwelIxN01CZUVvNnlCSnhmRUpOekl4?=
 =?utf-8?B?QUhON1FwRmgxQkZaTUF4UlEyUHFTOUlENDU4YVFINnlaYk5TQjVGcFB4bmRq?=
 =?utf-8?B?UExyeFNwU1BDdjYxYk0rWjRESkZEWnlTOFpxWjRzR2pRNkNSdGlLcUhWeDdJ?=
 =?utf-8?B?amFYTE04UzFmZmU4KzI0aUdkOGorckdRYk4rUGJsRy9kUjFLSDhVVms4MEtT?=
 =?utf-8?B?V3E1QmpKQy9Sb2ZYbzlxUjN5OTFQSlZSa2lqMUplVGZjL3RPakM1dFlDWWVC?=
 =?utf-8?B?T1Fjd1dUc1lDU0szSG9pTmpXbWxvd2JWVVJjRjl1SXYyQU5yYWxFekRTUklJ?=
 =?utf-8?B?c0F5TWZUVDVMNzQ0dWFkQ0ZRTXU5WVcrV3J0ZURqYTVaMkt5UG9IY2hQem40?=
 =?utf-8?B?eXpHKyt6WWhTN2tKbURNdmdzRXJSZGtuS2JCa0l1ZERNVzgxWHZ2M3VqT1Bw?=
 =?utf-8?B?WnBValBFQnZTdm05alZ5SExBaWpkYThxdTlGTmpkS2NsaEgxK1VFcmQ2SHRj?=
 =?utf-8?B?VXlSZmFDK3h4aWhZV1NJOWZyMlBwOXQvWFRtck5tbEluS3NmYVRqbGQzMDhN?=
 =?utf-8?B?L1NUd1BuN2FtRFJ2ZlRvUjAwVDZEaElOTFpaajYwSktudnNDcG9jQkRkakQ0?=
 =?utf-8?B?Ty9RWk1hNVFLNnN3cmpTS3BxMXh1dGwzTk44dkZoMXNRUTlFQUVwQ2NnMXA3?=
 =?utf-8?B?MytmUmo2UkdjenRtcmVjaGtUZlBMUytBeUFiSUtEQUFCMFI5UjJXMzNsb21j?=
 =?utf-8?B?aE8rVllYNnFhK3dHKzgyNmxaTUlpZStXL2w3UVBFYUNCS2dPZVpWWVVmRUVE?=
 =?utf-8?B?TWFjN1llaEhBcnMrbjN1d3RMOGZZOWVNU3F5U0ZIVm5LN1U4NXRhT1RxQ3I2?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bc75fe-b04f-4473-f8bb-08dd75eaca15
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 15:42:23.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/5jM6Q025VE8h7slRBPYUROA+pBVll1NXEgWvK2GP0l0QhRW6bx+OPGc2CjhGcXZga/jKCW+eyjOsl50Uu74w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5222

From: Jan Kiszka <jan.kiszka@siemens.com>

If the last test for cobalt_recvmmsg64 failed, we didn't propagate this
anymore to the caller.

Fixes: 3d6121a5f5dc ("kernel/cobalt/posix: Stop supporting timeout parameter in recvmmsg")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 49b347df1f..7b56d281a6 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -1054,6 +1054,7 @@ static int test_sc_cobalt_recvmmsg64(void)
 	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
 	if (!smokey_assert(ret == -EWOULDBLOCK)) {
 		ret = ret ? ret : -EINVAL;
+		goto out;
 	}
 
 	ret = 0;
-- 
2.43.0

Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E742A8B
	for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575726; cv=fail; b=bOn4gmMGPbwbyWJJKUUcEgscuHEYp7AMY3ZinA07M8IVhZJ3+iN8bZbrNqbaOnV1hncyJu0r5ElRWyxaP0TMuDvEb0QQEToS5LNOU7qt0ayb3rRrx/qNp6uGep7tf2v1RZjMigfR9N8ZAND2wEdjsAcWM06Xv8/6gopIQhHSVC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575726; c=relaxed/simple;
	bh=4ODMu8/akBbKZNJgWtsR4UICJWTsW4TRFd3i/kigMdo=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=hoO1+zi3fpVRpY283yOk+rGWRvDwzmelGvfSXne/9EXE1AIz3LrPdxxgDHoOOZkGqJ1FkA1XFl5eQORFDJe4DncZ5PVCTNqAWNQaEFCrvY16sO7tE1fofjg/YUVIQpYBmWsK3vhQ54xzo43PRzWW9t5d6IgVmnnmrbJVLowokls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cDo6Lozq; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cDo6Lozq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GmBtlqew7pSh6FClv8hDQM6GWMyA91LnDeQE3ii8VxZ4caaCUHK57aJFibsz5O0/VSiQOFOXitx8fSc8y/xEEon1xfifnVePgNEME7tg7T3wei+yBJK+BcPyyqtaRZLoNu3NCp1vFo4xAyMtM8ids4G7FIJ7eHbMOAxoeiMOY9p9GcADWknPRSyrQpPKHtQCR9TEmNHLvKXIAiaLnoq1A9rnzCoAOrDkQGHtTrFB4G4XPobUoZf4MU+Nk3xePm4acEvwDeIBY/C6CYWeJjm4XrnbtUuzjtril9rD2k7Dnkh6YKsnhbSSUyBqf3U9d6DeJ4qslbeypBlxJD4UrG5jTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gJzILPMtxqfvvJnWDyIhahaUp3BIX2TsoPAp6/NB5s=;
 b=VUD5gEVFtzUQd1zLfyBXpLQ2HYni8i1AM9kOMoIqy65l7lB1jYFP9QwMFg9wCj4XZNK5eOiw2irLA43Q6TbojO9efDc8JegY9omwCKJFvy2C0uWDlIDvGASfv+H9Skf7QEvi8YkxIRRFFE18V/NNjFBxMWaXiiO817AslokEUa7+BOTObfJm1XPcD3ZKf1R8mwzIqjsiirXNuduPSGD86hnRpWIacrMbVvFqjfbdBylUHPAuoXlGYPyQs2GOcQdm8SAckENT8Qbx8OtHy6YZS8rUu9zlBp4wCa6oThb87tJ+n4UNd2h6oVqLW6nxHOfFMTN5zkjeTl0umlUdhs+Xow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gJzILPMtxqfvvJnWDyIhahaUp3BIX2TsoPAp6/NB5s=;
 b=cDo6Lozqj068HWzez+yEMqHqIDxjj3QCMylwbsj7aKJsLz6wfpJLDWh51nFXRz+AzRCZjzFXIDDkmZTiUAydXH3GyRgxmDmk/gVO18ipHbYBMI3Pq2gWVLIqtzpD1EAOHtaXiJi1CHoeVrMBO68aOKo5EDe4uRrF2dmLoIj8+gGz+cyKnAgGIUSu/S1jpzhHD79Zq1e2k5vxpd/YMB+fZmYw/UaYlCbRJ9NYUpjkM2CUJwB/P8ARpoJtU3z4IcFujGqmEDOWXrBVQKzBc06JqqOpeLJa/FlG7QqiVS9iWIjJIHOtaxKYrFqdjGtHds28xO1oXWEM7MZbEOay3hPnZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 13:15:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 13:15:21 +0000
Message-ID: <927cf7ac-678b-4a54-ad5a-4e09f07086dd@siemens.com>
Date: Wed, 26 Feb 2025 14:15:17 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] cobalt/intr: Restore support for IRQ sharing
Content-Language: en-US
Cc: Johann Obermayr <johann@fam-obermayr.at>,
 Richard Weinberger <richard.weinberger@gmail.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:52::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff6f2de-0833-4200-302e-08dd56679fa2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qy81SVdUNSsrNzhJZFYxYmlaK3BXZTliQWt4Zk5pMWVZcnFBNkt1R0JTbUp3?=
 =?utf-8?B?Q0FMN1ZiOWdjQmZCUnhnYWh1YTF5SHVDWVd1TzQwQi9OSjk4MHZ1TGc1cEJn?=
 =?utf-8?B?dUV4RWdWUFNhWVFPOUVZanZjLzJxamF2TURwNnA0NjdRMGhOMi95OUpiN2Jk?=
 =?utf-8?B?NmZBdU5UeERGZitFVUdpNjhjRTZrNG40V0FwNjJFK0FLdTlCVnBUSVhFeitW?=
 =?utf-8?B?dVU4aHEvTnZoTEoySVBsM0xOejcwSlQvQkVUU3JvN2dzTjV6TTZZMzl1YVll?=
 =?utf-8?B?ZlZuTWxwd1A3VmdWSi9uVXRTWlVVNllycVI0VGZRcTFSRXd1M2tzbzlwNXhS?=
 =?utf-8?B?cGtmT3RKbTFwK1dXQjRJWllaZ1diNU9vSGtIK0tmUHRHMEt6VHA2Y3M5aVM4?=
 =?utf-8?B?a0NmSHFoYVBSWUQ4cVN1ejVTS0FxN3RQODZCZTZZMkY1Y1JIandqK1p0THho?=
 =?utf-8?B?OG0rQW55SEV4dDVLNmhRMWJvSm10T1JhSkV4NHRqQm51NzZjakNUNlRTcEND?=
 =?utf-8?B?c1JFMUVOellwWjM3N3lZTi9FbTdOc2VFZlJvcFNoT3FjNENlK0FvRkpxOHQv?=
 =?utf-8?B?SUtzbVJ1Z0w2QWgwMjR3TmkzVjJBWXExYi8wOXV2ZTJBREpLbkM2UE8xOHBy?=
 =?utf-8?B?dnNUTG1NTjZaNjVWekM3cFdySzU2SHd2STdBR0Q3NHkxVU40TGlzQ2FnTmE0?=
 =?utf-8?B?NUF3TUNhUW5tUGpKQUpTUU1BRVZEVXhsdENxS2xPaEZiVW5kZklTWVBCK2lj?=
 =?utf-8?B?c0t4WElTVkxDOTBxRGJlMFRtZURCZlIzN0xPN2dPY2w0STRxK1ZDOTJUeVJK?=
 =?utf-8?B?M3llWFpEb08zS0hWUXUxMVpaMWtDTDRMN0JHNDA2b1oxQTVVTWkvUldYTWdt?=
 =?utf-8?B?Wk9VWGljRWdxRU8vSGdNdlZLdzN2RkluZ3dpWXhGUzdIdHhzZXo5cnNSOTdC?=
 =?utf-8?B?MDgxemJhYnRDM0hIeUFHNmM5V1dWRmFEclk5MmQzRHdmUkRJSUZUcWJQRldP?=
 =?utf-8?B?MVJXRzgwUU9nMGtXeDZEQVBTOGVCUkhrTmY2OEpSQlFkZzNEYnRpZmRoMnkw?=
 =?utf-8?B?RGJYZE5iMVhOVWZEeFVTMi9lRGVrMDdNb3NDS05xZDdmbElXSHJ6ZXh4dWMy?=
 =?utf-8?B?eVZ1bUswWnhxa2FURFBuK0NESEpHTXd1QTVWNXhuTklDQVRhWHdvWkQyRU5P?=
 =?utf-8?B?MkpYTjRaMWd0c2F0ajRBYW9qS2lxd3pHZytHcnZZUHd6bjBxQVJLcmwzU0ho?=
 =?utf-8?B?RXRNaG56alhJRmxVaTlxcVRNRDcvTWFYOFZrMjVUN0tWbzMwaTRrMEx2NVUw?=
 =?utf-8?B?UWs4clRVdndFc3E2QTZPazVUVnl0UWRFNUVpUm83QThBbkx6NmRJS2pLdTln?=
 =?utf-8?B?OVliOW9VVTF5S2txVHBVZ2NXL2IrbkJiRGRydUd4YlVqKyt1M3psYUsxSm1z?=
 =?utf-8?B?SC9QdUJCVFV2RzF6NzRCVTlCejNaQm50WVp6cDZ0cnJ6OFBlbEg2Mk9WZ3VP?=
 =?utf-8?B?NCtTQjl2b1N1Smg3cTJKWVZPOXgzcWFTQW1BakF4QXJwL1dSNzJPUlhIQ0Iz?=
 =?utf-8?B?dVBFSm43R0IzUW0xcmJlZUgxUTVYbEk5N0VMc1hSMEdESzRVbkRKMVFPQTNL?=
 =?utf-8?B?RXB4cWtoZVZ6VWorNzJQNDQ4TThDS2poQ21Ld0MxU1BxV05NZ05xaG9WZTkr?=
 =?utf-8?B?VXY4WitCVVVPY0F5ZlhlZGUxazBHTG1OekFzY2JtNEROUk9jbTJIazJWUzlF?=
 =?utf-8?B?WmVQSENWWTRnTUt0UkE5WlZxU1AyV0loM3luU0prcUtkNFZDS01HNUYxVUFP?=
 =?utf-8?B?SGpkamdYZUpJZnpIMEpmMDhGOEZyZldlN1hiZGlRZW8zZkx3U0E5L2JnSU1Y?=
 =?utf-8?Q?+hUhLEBc4Z/X3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODFlZEwvR3o3WmVSczhwaWlSLzA4MHBlRys2TVdVYnpVZ2lzb1owejVqRE1u?=
 =?utf-8?B?ZVdjbEpZTGNpUVpYRjhNTGVWL1JYaVoyNVFoUXQ0ZGVQME5XREhtSk9FTHJD?=
 =?utf-8?B?SkFzaGdRSElIWHVrOXUyVVYvS2gweGhYcWkzMC9wRktCMklldzdCMzZwbCtH?=
 =?utf-8?B?dk1IcmJHWW16OEsrd0ZnZ3FVY044bVluWjMzL0E4eldCSUJZL2NkT21qcnBK?=
 =?utf-8?B?Z1IySG10QVNSZkxLRTV0ZTkyK3dKVDBraTBMRCtFdncxWWRva3ZTMVBYUmNP?=
 =?utf-8?B?UEIrUjZxMDB5QUFVUHlkcFpFWlhUT2FSNVA0MlQ5U215SnRQMUNzR2hzTWw4?=
 =?utf-8?B?bTVxbkxBVXAwMXB1aUlDSDYzTmNDaVFXaHhEZTdwdk5icFNMRHJYdzhtRUow?=
 =?utf-8?B?Z0ZMSDZMVHJrS1UzVzAwYkRuaWNXbXFRTVE0ZlY1d2JGUlpHTzBGSXhBVGM1?=
 =?utf-8?B?TExBRHAxWXF1YWVma1RDYWQxT25yT1dteERwNVVXckRrSzk1YWR3bnNWcXE5?=
 =?utf-8?B?Ly9IakgrYzE1TFpxN2M4S0xXZkk4Wlc4MDRpL0ZxMkVtK3R0M0FwVG1EUDhi?=
 =?utf-8?B?SzdUTHp2d1NyY0wvR3Z4VTdiS2pNUHd2TTljejBIdXAwc2d3eEprMVhWM0ll?=
 =?utf-8?B?UjlkY1Y3cVJYR2o1WXJra1EwK2ErckVlREdPeFVPbk5Zc2xjMU1ocERnMkUw?=
 =?utf-8?B?ejg2SEhuZnQrOTEwWkJWL2pCcWFOMk10ZW90NHhqaC83NWs2Q1NLbUFnOTNE?=
 =?utf-8?B?dERONVZ6UFkwcXNwMWgrNU0zWHJqeEZWbkZvcXk3bVVxR3hOM0lUYTJtSU9y?=
 =?utf-8?B?OGxOdGN3dCtoWUg4ZnM4YTB4eEtxQ3FjQnl6R1R2R3UyQUg0SEp3cXQ4Wk5Y?=
 =?utf-8?B?clZSLytKeFhQd3o5Z1JXbFNoYy9PckZUMWZJR3lQRmdnUVFMSVh1VHNMaUpN?=
 =?utf-8?B?UG1oSlRrajltempZc3hwUDNyMWg5Wm1rMFYwVnpLa2JYa09hYmVadWo3dEdW?=
 =?utf-8?B?aEh3Q1RKaXJEWUNMTDJxWjFZTFVvVjlyUWFQODBvZlpBNDh5UDV1OGMxejZ4?=
 =?utf-8?B?NWhQVVlvdEUrRWllZmN1K0ZKYVFrcjNKS2xCdlFYVzZNelAvRGRVWU5HUEZN?=
 =?utf-8?B?bWRZZy9nV0dyWUhYTFFLVUFxV0IxQlgzU1N6NkdqM3prNGRiUFNNUGhaa0FU?=
 =?utf-8?B?TVNCVkhPZVUvMkYyYi9WeXVNNWIrYUhSVTRpaWkwUCt6aHArYWlLNmhNUDRh?=
 =?utf-8?B?U3lKWlJBbVpCWXFJN1IzRnVqVzNvS045SVZhRWpNNEQvVEx1b0MyRm95cWtH?=
 =?utf-8?B?UWFTTVhkYTYxVldyVEFIbE9Ba09LV1kydjdSVW5BRG55SC9EN092VWVVaWdv?=
 =?utf-8?B?TmdwdzhMbmRhdFVIWHJQQncvU3l1NXVVNGY0MzRhZm10NUhYVjdVcldrOWN2?=
 =?utf-8?B?NkEvc3RUUllzb1R3RUFhZHpvcnhzdUZjOG1ja290bWNNM0txM2t3Yk84a29B?=
 =?utf-8?B?ZWIzUjV0UVBRQ0ozUXU0MVE3QzBERThqUS9aclFGczVxbS9UNEtpbFhtZWpk?=
 =?utf-8?B?allxbmFSZG83Z0U3aS9qdkpWYmgzWlJkdmg4Z1RyOEVsUGtIdjUyMlljT0lX?=
 =?utf-8?B?aEVONVdWU3RSa3NLRzdwNGdjMmRoK20xWGpKejBWbHcwWGVNVGJTREdVYzQ5?=
 =?utf-8?B?bGVUSmlPMnZYZXpyVWZ5dU9IbnlSU0d4TmtyK2hmQVhQU2NjWWRhYnljVW41?=
 =?utf-8?B?Ynd2RmpSWmZoeUNxam5wVVpxOGJWQlNkUGkxTWxNMEtVWndHeDl2aE13dWp2?=
 =?utf-8?B?cjBWMmxVcjZkVU9laHZ0UHNLUjA3TDNCdVRHWG5ORTRJby9pWjJ4cS9BeHRH?=
 =?utf-8?B?SjVrdXdFd1pubGdHUWFWL201RXJKNWVTdDdzOGVqbEZEeUlTc09GZGk4RnJX?=
 =?utf-8?B?SVp2VXNSWUpKRHF1eFNuRlZLQ3I4UVk1V0JPc3AxZDJqSC9KS1lOQ0N1KzFZ?=
 =?utf-8?B?RURCTkUzL0FBRHk0dEozSmhqY3dndmFmMTNqWnNHcHRJTmxxZnkxWC92OVVX?=
 =?utf-8?B?MzZKUDJ1M1JpOVhvRXcxdFA3OEozanNOSWtMMVRCUUVjM1V3aTRqVzZ6SkFX?=
 =?utf-8?B?SVYzVEo4TVVwY3RBTktDck50Y1RJV2NSQnZVM3RRb00xYUxSYStNY3ZQckxC?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff6f2de-0833-4200-302e-08dd56679fa2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:15:21.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbG8qjmi2ZKwjMao0niOBL0sLV6N6BmHyh0zTisb9HpBbSTJ8LY7cENuQ36A0Ks28Qx4aZhO3b9Bp3NvCy0J4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6364

From: Jan Kiszka <jan.kiszka@siemens.com>

This was lost while porting to dovetail: Sharing between OOB interrupts
is also with dovetail still possible, we only need to request the right
type from the interrupt core.

Fixes: b1daf55bdfef ("cobalt/intr: dovetail: implement interrupt management, handling")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use IRQF_SHARED rather than IRQF_PROBE_SHARED

 kernel/cobalt/dovetail/intr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
index 88116c7c89..caa0bd60f6 100644
--- a/kernel/cobalt/dovetail/intr.c
+++ b/kernel/cobalt/dovetail/intr.c
@@ -86,6 +86,7 @@ EXPORT_SYMBOL_GPL(xnintr_destroy);
 int xnintr_attach(struct xnintr *intr, void *cookie, const cpumask_t *cpumask)
 {
 	cpumask_t tmp_mask, *effective_mask;
+	unsigned long flags = IRQF_OOB;
 	int ret;
 
 	secondary_mode_only();
@@ -105,9 +106,11 @@ int xnintr_attach(struct xnintr *intr, void *cookie, const cpumask_t *cpumask)
 	if (ret)
 		return ret;
 #endif
+	if (intr->flags & XN_IRQTYPE_SHARED)
+		flags |= IRQF_SHARED;
 
-	return request_irq(intr->irq, xnintr_irq_handler, IRQF_OOB,
-			intr->name, intr);
+	return request_irq(intr->irq, xnintr_irq_handler, flags,
+			   intr->name, intr);
 }
 EXPORT_SYMBOL_GPL(xnintr_attach);
 
-- 
2.43.0

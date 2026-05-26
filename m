Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDF21256C
	for <xenomai@lists.linux.dev>; Tue, 26 May 2026 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800705; cv=fail; b=thCPfse1sJHUgA6S6PhLFGS7Xh+jhYqe+O8giuw4r5t8XHPSArrzM0WL94v7sx5mFVXJ5fgu+XpgkBMPM+DMU6aOk75G5ipObBY3+nX5P5sZzzjtwWKWOhsohQGzBfY9NHnZNXZYDMQrCpk9u4ZD0hxrXhOWDTpVS47Fg6CKGmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800705; c=relaxed/simple;
	bh=GUZarY3sutgcNbRy1au11SHeTd7Y7PZ4LERrs/IH4zE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pmYyYaFq7pWYusqEIed+krVCC6MAkyIvHPMTrKrVk6cYnFWPohI4sYgY2OU3GJ8ia5PP/VWGc3mKOScplxSNM1Ef4F/FobF1MUxv7mgAz65qT0uhmRDx3flMzKZYqGVz4KyO2kMU/Sj9aHdakgraF88mV09RsB1xp69P5YtE0SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rnMpwfB+; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rnMpwfB+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLpXetSYodrOx2hSQoKfVvsEBTNRHsg4p2Yzv0eevJNeJS0fwUFE28xraN+LP/rl0aAWb6fQSLAOEQASK4YKlJRwrR73h4tUzhBzGnO8CFcX1UUmi2xrxhLe/oxO9S7S+JzEvpsLBEh9IUCKKENYdI3bbhDvrCfRd2Uj8dARe8V+AqSBiqrCYaciA+nViVjYw/y76npbR0pkwFt1Bj0+Oth+I1ueN2qoX8nGfs4DO+DBfPXOg+CUiOoIsPp7/x4Je/FIBH6yNRtUcSbR8XZ2QxS13edeheRzZgSqifK+jUroS++8y3fXM0KKrC2e7Gy6xZK08HKXSgcbPs+lHWQQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJXKQGyJyN2cbkkS0u7xX7Hn5sOK7eWEzIBEGRAok2g=;
 b=S9p7kUX/vhFpcb8IZgCd6SV22EKsVYXSrZ/qLn+L5RzGwgaHwIzVVcTk4usszrog/UB41TyUC4Ern2tyzUhpL0Oo9PtQDuQWJD1L1N1UfQD0cqa1vkfUmZ3DbsNwmfiwFSHUn9y+Divagg4TvaCCJ+dWyztYj3uoXsKtCh5wYmV9MoNME1OlxiFlkzc99YjZcD/Jw8kJquQL3nUEPXg/s/67jKjpNy9KT8SIfxN7Q1Y4HzqXrGfeZHepj70tmKtw2CstUJ3ATtAaU9wtywRsuhunjUo+89MyDGGPMmrdnpye/86ltLyVHQDKeQv6Eq5RAp3IXdS2SShgEvID46h4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJXKQGyJyN2cbkkS0u7xX7Hn5sOK7eWEzIBEGRAok2g=;
 b=rnMpwfB+oBfbZ0XI85yM9ee7mQKPdfduNsE9x2RxlFPjQQ4SbQ0ud4ruluZjZ4UoVb0VhmfkJA9YI9arUb8Qf4hh5BYYcc/TNckb9Sg6v2AsrJXZ+nNucxlMkmgrPYcf7UHrxXE4ZaUMxjrzpqC785DqLz3hX0Va6nkoZU6G9dNvIB6kJg0HpkTYuy/dME7IUtuAXsKulwXNdTHnXO8Ioomc1PhTS5zfK6gaa3tztitJ+Gibi11zKPA5FGMLNf+YvIpBE/qyTSz3DV0kX/LK1Y+HbFnoS/Tciu2MlFtEjvh1UJSbuH9VG+9rhhEep2/bMc3YXkbwx1jiQCUz5ovNJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5370.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 13:04:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 13:04:59 +0000
Message-ID: <0438132a-7997-4acf-82fa-6861838cc4b1@siemens.com>
Date: Tue, 26 May 2026 15:04:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai3 network issues
To: Hannes Diethelm <hannes.diethelm@gmail.com>, xenomai@lists.linux.dev
References: <c0c13f34-8645-4269-9bb5-70c8b6fb658e@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c0c13f34-8645-4269-9bb5-70c8b6fb658e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5370:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db9398d-85da-463b-0b85-08debb276470
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|11063799006|6133799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q/4uThX4FMgdoM2bFiOQQ9Pir1Tzc/Q8dYOKEAow4lMsJXc+ixDLgR8GQ7yvvy4xmIgIZJ1tv3tY+Lw/eJee4ntQScvSESXYxLwgxO9eVydhnny4mAKVHvGVcFu1MBOF3ckncWI7ScEN9i14Cor++Km2Sp82yea5gO1TvTrxdYm8Bq7HsGO24YJlC8XZy7kBOsYNPEV0gZ+ro9STj3yAiAwWU/WU3qc/wEkZoIMDxyU94O5QlW10Gz3uovrWVGesjTS6oxZ19LbPt/HKUml75vPBwl0aDfrctFEsuCsjjs6NXQ1SKJx6bZq/JO2XjdJCB+AVqtyA00ZB3RaxTRZek1GCkB0Ff63buvaeTuczJlfL53OTaQ1iaSS657oDrjNGNZt05Mb0QbikhQfwwyGx3JVen8QqMv5/+wTTLG1WW2T7MdnSjEv0SDSe+ONdbiop/MPv0q4TP10SZb/0CjA6LSNde0WfPjBGRcPh73OQDTLRxH9KgDUSkk12HQB/CSgeZsWNP8XnrPRksPHZFe+dWPuHi+H7so2Omc3/LgnhGjLZgsNmVNhQas3UQ4BXglspVDR0fEBXie2St+O1whBIHY9/IwaXhaD/v9P747/O63D+/14w8QlwwLA5f0TaSYfbwN/RzNhaa08G/ranzmkaof6B+0wly7hCd57HElKy/7AT9vdLxZUZnKyjDuGOF0jx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(11063799006)(6133799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVY5ZDNjVzhHL3dNMWRoMDBRbnNnNWhQSVBCb2NkcGlvWForWUlnVm1Uay9R?=
 =?utf-8?B?Ny9sODFYbzk4VzFSOWJiUjhya0l3TWpSSVFRRVpMR0NRNFl2TmxGKytNVTJk?=
 =?utf-8?B?TURWRXNMUW51cDM5RWtPcGUxa1hXNWxLNWVpdTM2NkJBVFJ0cU9ITXg1a05D?=
 =?utf-8?B?L1NzL0JqQ1dORE9sUWhFeWRXNTgwWjZOYlJSY0hGaVhMNGw0NHo1U2xUNXJs?=
 =?utf-8?B?YnE1angyQUlZVFpSUVVJanFHeTJnbHIxRjA1cm95a2htTTdwaXJBVnlvWXJ6?=
 =?utf-8?B?WEdTaW40MFowTVFTMVF1K043am10UVlZL2JGRUVyckM3Y2pqZ0xGYmE5SXVl?=
 =?utf-8?B?UnNkL21WaFY4WncxbTd6ZDNjbHpybk5DTFBuZ3Z6MWFkSnJlOEEzc2RJRWFP?=
 =?utf-8?B?UGRmajJMemg5ekN5T3BtV0Vrbnp3eWU3VEcvS2xLb2M3eTBnK0NwUDJjK1Ux?=
 =?utf-8?B?MEpTcVdGZXlhRnQyWHpmc0hISmlIc3dLeXhqc1krOE1jRm5aOFhPRGNOKzlt?=
 =?utf-8?B?UTZBVndiRmJhdis4NWVOOFZENXdZNkxlSGJBVU1abHNUOG1DMXZrbStFOTZV?=
 =?utf-8?B?UEFKRWlHbkpFbXlzUHpFZHdBU2E2TnN0VXFEUlBxRU95ZTlQVzFrK0tuQnlq?=
 =?utf-8?B?NVlRYTFEYmYwcEcxUGJxeS9jR1hDYjREc0hyODRaZUlOZUpYaEVvVnp0alFB?=
 =?utf-8?B?Zm1oblVqZFkwRVM0dU1zakpibXJ4UkxaejhoVGFaamowU2V6YWkreWNkKzlj?=
 =?utf-8?B?M3phdDYvZFQ1WVVZVHRNb3NFeW8xeDhQSkViR20xMW9JbXhJZUVHYmQrS1Fl?=
 =?utf-8?B?Vm4xV3RWWnczaUEvcWFtejJhelozQnQxU2dRRkl1SllXY1ZSOVNKNElMY01I?=
 =?utf-8?B?T3pad3E3VnZKdHZyelZheHkyQUpiK1NsK0Z2RFpmVzZSU1E5ejA3UXE1Nnow?=
 =?utf-8?B?OUE0KzlyNWFJUkZzWWk2OW9JZEZhamhGRnJkOGlWS05hZGFiY28rRzFSYmk4?=
 =?utf-8?B?K2NWcWVvc0tkVmV2UWpzUUpyT3Y1ZkdDQ293aG53T295YUkvbVJ0Q2k2N0Nt?=
 =?utf-8?B?OWh5UzJHdG5tMUc0ZnY1N0ptY21vWmx5VjIzRnlHTHNWTU1hN2VFb2JrUXMr?=
 =?utf-8?B?SXNDTElyYTZORWFzRyt1bloyR0hIdWU3SG94SWFsa09IaUVzUHJ1dDd6U0ZS?=
 =?utf-8?B?RmM1VU04OWhCOUVCQnlkbjBZZUdBajhUWTBYTGpwbnpYWlRVdDJGL2hEQmlu?=
 =?utf-8?B?VUlQS1V2NHp2VHAvei9jbDFSTVhNUnllZlBNYXByQlhJVElqY1FTdFUzeUpQ?=
 =?utf-8?B?RzBOcVRIMy9VMnpqSWsyTEVobHNaRjhGdHpEUk5JY05KTldUMEZUODgzQzhh?=
 =?utf-8?B?dUROd2Y3SGZIdzV1Ym0xVFFIMVVJbkFPeEp4NFM5bEdXMDFOSzFxUEdkNVhw?=
 =?utf-8?B?ckR2L0tvSVg5RkRpWmlKcVVNbFdSbm41ay94L0tpNE5USHc4OW1FQzZVclJT?=
 =?utf-8?B?R1pGdk00Y0xTMkhFVkUraUlkaHlZbWNISEx6UG10blo5K2M0RFVOVmV1Wk40?=
 =?utf-8?B?OStqVkNINFpYbmVnMW5nYXdzOHdSQlFNazV4MDVxT05HWktGQnhEQXY0bC9C?=
 =?utf-8?B?Nm42KytRM3hpR2VTbHh0dTk2S3R1anMxN0Q2YVNKSkRjVU91aVBpclpEYndE?=
 =?utf-8?B?VEdzc3RmNGd4bnRPS2IvWGtqYVRtYjErMGcxcmNqb3l4TklXbi9pSVFEdUxL?=
 =?utf-8?B?ZU9KSy9Feng2SWtjaThOMEttS0NXMVNnTWhTOFEvRXUrdFFOMmQvaGxrVTg3?=
 =?utf-8?B?dUlZU2VPUTlFRUJ4RW54L092ZGp1eVV0OVJGcjFWWW5aNExtSkhmbU1KcXVT?=
 =?utf-8?B?TlNVVW54Q3p5cGxxbDh4MGE5NU5OR3dNN1lwOUswc0I2cWNhRnlkbS84alQx?=
 =?utf-8?B?ZW81Z3l0VDBIY1YyY1ZPbE4vcFlDWisrVVRyV000QktlNDN1OGE1OWhJdlZU?=
 =?utf-8?B?ZmtsQ0pDMzVIVjd4MVpCTE05dmIvb3gzWHdKVFZhV2JLdUFFNWRKOXQ1eE8w?=
 =?utf-8?B?QlAvZHVPZktlYUN0SDdIZi90Mkg2dDQ2U01zTmhvNnBDa2RER1BvUTZ2UEVh?=
 =?utf-8?B?QzJjbDAvaUE1dm0vMFBLSG1jTHA0d0lYSWl4SFQvQmhhN1BPd0JmWmc1TU4x?=
 =?utf-8?B?ZUxmUFg0b2svWXRZKzJRU1llNTN6d2pLc0l5dVJrbmZvT25xOUcyWld6a1FM?=
 =?utf-8?B?V05ORXdEYWdFeDVGQlByS01DdEJpaFlxbFg0VzNrWUFBdm5GWE5yWlA3M2po?=
 =?utf-8?B?bWtNNW5naXhaRyt2NGtKblgzRDk4b3R1MzA0cnp2RVJOaEFkZ1dGQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db9398d-85da-463b-0b85-08debb276470
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 13:04:59.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fjhEBLOYDzC8pU5JOOzYPWF4vgZvRtoMJWvgCN8bQ9KHSSOJRoP2aS+jWD9aNhieSqv+PnlVfk/exfoeRJbzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5370

On 20.05.26 01:26, Hannes Diethelm wrote:
> Hello
> 
> I don't know if I do something wrong or if there is a bug. However, I
> can not get any network connectivity from user space over rt_e1000e.
> 
> Config:
> Debian Trixie
> Xenomai3 master d4929cf
> linux-dovetail v6.12.y-cip-dovetail-rebase e2fc451
> 
> Setup:
> modprobe rt_e1000e

So, you also unbound the device from a e1000e that Linux likely
provides? Or unloaded that other driver?

> modprobe rt_loopback
> with/without modprobe rtpacket
> modprobe rtudp
> modprobe rtipv4
> rtifconfig rtlo up 127.0.0.1
> rtifconfig rteth0 up 192.168.122.45
> 

I suppose you also ran ARP (rtroute solicit) for the targets you want to
reach, right?

> I don't need the full RTnet stack, I only need a point to point UDP
> connection. This
> is why I manually load the kernel modules and set up the interface.
> rtnet start
> blocks while trying to reach a TDMA slave but my device doesn't has this
> functionality.
> 
> rtping to any network address works fine, but looking at the rtping
> code, an ioctl is
> used, so the data is sent and received in kernel space.
> 
> I had an issue with my code, so I tried the demo:
> 
> Without module rtpacket:
> ./demo/posix/cobalt/eth_p_all
> There are no packages from the real time driver only from the other
> network cards
> 
> ./demo/posix/cobalt/eth_p_all rteth0
> cannot get interface index: No such device
> 
> With module rtpacket:
> ./demo/posix/cobalt/eth_p_all
> socket cannot be created: Invalid argument
> 
> ./demo/posix/cobalt/eth_p_all rteth0
> socket cannot be created: Invalid argument

Cannot confirm that second experiment yet. Did you compile with
CONFIG_XENO_DRIVERS_NET_ETH_P_ALL?

> 
> rtifconfig
> rteth0    Medium: Ethernet  Hardware address: 52:54:00:5A:79:C5
>           IP address: 192.168.122.45  Broadcast address: 192.168.122.255
>           UP BROADCAST RUNNING  MTU: 1500
> 
> rtlo      Medium: Local Loopback
>           IP address: 127.0.0.1
>           UP LOOPBACK RUNNING  MTU: 1500
> 
> Regards
> Hannes

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

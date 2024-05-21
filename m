Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D899142E97
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303957; cv=fail; b=FCFxyz3lGWxHnkuiqb0Q4WLSPxnsbJhZ5sThlLTsu5I/kR1RRMbiouKTkxn7kJ8WuxasRpqEjqYeJB1YDRO08QVUNlQ9P/UzWOoAuedN2C7nhJfNjottekEZC+7Ih4QhVaGjsBO5qbUQaGjfqEichRyzGMQTynbiCQ6piHk7r08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303957; c=relaxed/simple;
	bh=VwgRKS1LEmOqlZcfUR/dD6LGjZRrI61nPggbdwArYDo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D77UQdAtOQ5vzNSFC+75YAToxTRu4sgrDcNhEUazCmcPvkMgsTcN9vIMAfd+YHZe4G110iCokHkg5i7Won/PiHEpAvh2N7+e+hp7PZhcKGLgMLtRiOWXcw+ZwDyO8dsaouYtbV2LBD4qCnqlCt40urESLDmzF4is0BYP+Ksis5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CYAy3jW0; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CYAy3jW0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLz9iXZKiQamy9jBZjcS1BFg6UefRj6D2qNtwVjn4XwiRbW2xHGJeb+i45S4vl/9dDXWMCsgLI+fijwkAtQM1eodav8LatVBCPDkjL/0L1NUbsbb7x1jKTXbK2YmeCWHDSOBb5zAnJzmhTeP5i3llTKx2378fyXZGiQLXcm+pNO7eHe+YOpzQNtXYBySYPzHQ3VvfdCoDfQftC6CYwksHA8WyFIZozX7vg/AtZZv661j9HCkwNi4tAWFLZTf2mOWoAjonAPnZzs6qYg/OndBWxkJmE1G/J5pE1/iKzx8V3EgS4ZkAxfgZg6VgsDl/yyTh0rJLGySreqGR2ZW9JK8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ/Ug3mDscmpfLnPlJ5mjgUGa8CIyyftNlXEH/AYUys=;
 b=hGQv8pG2E7qV5tGWelLy3ky4xPJ7gEc3QYSmHTkGxEUsTJbemFDbM9FFxWMnOAgrfalWdKmcEMc3c0OFQ/xd8ZdFpdNdR70vCtCCWfUV9vyS0V4Cv0K+k1ptrY/Aq6FC0OShS7/5iZpzySe/Gd8gdTvr5xKHgPlHXAMoBb0Kt6FFOLIfn081KuxqojNY9R/vaG2Uevv8GAgmMK/n4DCF8mnSiObB5znkG4xaVbBUGUUmKy5/zx9SlgRliv4y/d7JdKsdr7fejrjc+LyWyzh7Px8sgE5AR4SF6WnivlAPwq2dNCp6VB2xlmMO+mynDy+y+Tp4c3qPemu1VKBArs3Klg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ/Ug3mDscmpfLnPlJ5mjgUGa8CIyyftNlXEH/AYUys=;
 b=CYAy3jW0nl7lthfym3icX37fLhjl3pGrnZmiGf3jM1qs6GGCOwszEuSOt4YB3GBB//vuITdhEPuXH46wgHccuwz1kPGCRO/Sl7lB/96X9TPSSCEGPS0xeA6Qz83jyC4IydBixARwgjPMYO12VOJSIk7NcJpLx+vQb9VpqwLkP+xjVgIpgFZ9q41e3tz2J+tIq2yzcGBniRBw1TLbcJRnSenuzIi4gDr8iGcQXEFlMBrkAGmBgel4J+kNvW5zIFql6AOIeYxG5mNl3DJuyd2gMZ5uZD2xv8Glvsa/JuLukCSEP6ZZutEtRYgrmVCY7Ac7Yu8LOgjswcp7e0HAxfG+/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:521::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 15:05:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 15:05:50 +0000
Message-ID: <ba5e0fc8-e2fa-4495-9cf2-69f0ed2d1621@siemens.com>
Date: Tue, 21 May 2024 17:05:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] prepare-kernel.sh: Add reverse mode
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
References: <20240518112703.30713-1-richard@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240518112703.30713-1-richard@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da96667-ea18-4ed3-eeb8-08dc79a7805c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3B4eTB6VUgycWFyanBKU2lkVVkzcGluNmpZZFV4bW1DY1ExT05tQVVWQVVi?=
 =?utf-8?B?SEJTR3U1NmQrcVRMTFVOZGhxU3Q2OWQ0ZjJEeFRjSjlaNTZxVGloTCswRFc3?=
 =?utf-8?B?WjBzTVZha0RNdkU3ZGNPMDJ1WlF2S3FzMDZka3g3UlhLcExKajczODRWZUxW?=
 =?utf-8?B?Sk9mcjNTNkRNa3czeGZQSm92cHY4NTMrTXpDb1V6S1dEL1A1Nm1GYkxGY29k?=
 =?utf-8?B?N2RrblRmV01WZG5pV1RpemVrOEVLbFdoZ1lxSjYvY0FDQXF6OFIyOUJoRVJh?=
 =?utf-8?B?K1FqTEI4RGFRMkVYZ3NUT0lOU2p1eEdUM2hTOGthNnQ3WG5zQ3oySXI2Y3JD?=
 =?utf-8?B?VmR6S1hzTWJRWnkxanEvUjk1djNBZWRyek9VMXIzUzJDems4VW9LVENOYm0w?=
 =?utf-8?B?UHpNVVVpVHpMZTlEZ0hJWVBENUZsMkYyc1l5amFmWkl1S2JnTmNLQlVudUE5?=
 =?utf-8?B?ZnlxNXBBMy9yMkl1c0tlYVVnSlpMZG4vRFE5QkVUZzZweXNWVUUzMnhUS1Fn?=
 =?utf-8?B?WU93Q2cyNStnU2dnKzNadTNidE9wUmtqR0lrWlltWS9Qb0N1WTExajMvZDZG?=
 =?utf-8?B?UVFPdjQ5RE1udlNwYUo1SzhBN0phNnNMSFJzckJOSDJ2QUJBUWxucUxLNnlq?=
 =?utf-8?B?M1Mra2FRaFd5Q2hBTDkrem54TmQzWG56Y0FISzRvQ2RMNm9Sb3IwZnBJMkxG?=
 =?utf-8?B?NGJOeG04b2dXTzRtbFIzZ0NSQlMvdmJLaFRaUlhhUXYyYmhXM2NYZFJKcHIz?=
 =?utf-8?B?SEFiczdUOGtDaUR5eG1RandrcHZCK2krc0F1VXJtNnpHbVNYTy85UnM5MEpK?=
 =?utf-8?B?bzljWDRTSGxVSWRwdnV3WlcvbGpiYVBrMFJ1aGxXckpXR3U4YlV5UVM5ay8x?=
 =?utf-8?B?b2ZlSE4wdFViZVlodzNJYTN2Si8ranFXeVZUNFlWWlluYVFVMmNRREs5VG9i?=
 =?utf-8?B?UFUzQTd6eHpCUFNJZFc2cVExZ0Fvb3Bnaysyb3NRNGlNNFhFN0x0V2VPdEJ3?=
 =?utf-8?B?ZHJ1VEVodzRMVlcvZjAzMjlDUndkZDVyNmRkR0dwKzV6Z2s0TkUyZ3EyU3Ay?=
 =?utf-8?B?ZEZub1V5aUtsM3hmbDBmMW1naXFQeFMwdGFSWS96OGkwbktQcTVjQ3Vsdnln?=
 =?utf-8?B?dVE5S2lkeU9vUUhKWVc0RWZ1emV6UWRMdzZ0WFhab2dQYXNiMXRjRFlXVmJ0?=
 =?utf-8?B?S2x1amJHUUxRRHloS3BldEVIbS9yTGRNNSt6SE42dmhXZHYwTnpLckFYcnB6?=
 =?utf-8?B?T2FNMXpEUTgrUFJuR3psdzhKZmFuaUlyd2J5ZzdGOGcxT0UveEJqaEpFTjBW?=
 =?utf-8?B?MXp5dm5va0Y3bldwdERWVFlqMnBOU3FZbjVhb01MbGI4SEVhY1hMZUhlanRJ?=
 =?utf-8?B?YWhyZHNMQUtaN012MXc1ejI5UGE4Z3JWZkZZY1hGdVRuOStoUFNLQlJybzRY?=
 =?utf-8?B?UVRBMS9FY0p1R3ViZnZybGZqREx6ZjRHVjdmSVN2cmU3WkNvZlRmMWN6M0Vz?=
 =?utf-8?B?RW5QL3BVVmN6QTV6L0FaL1ZkNzVoYjlySERuejBMMDRyNGtmTGxLVU03U2Zr?=
 =?utf-8?B?NXdacHJ0MFRhOHVJTER3T0dKNHVtQzRTVjVZNEZUait3dlVmZUJsRDEzMmYz?=
 =?utf-8?B?WTdHMVhORVNsamZlK2hmRHhZdHpjem0yaEJXSzhwY2Vvbm9wZnRCNnpRWDMw?=
 =?utf-8?B?VndLbW02czdXRFVBS2c4WTA5UTJ2QW9hQ0M4VWJFbGhFUk95RnhXdnBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1FuSUVVZWd3ZjdIbkdaWGljZGVZUjQ1NXdhYWU0V0h5K0Z4WnZuRVpISHlO?=
 =?utf-8?B?YUt3QmZ6eTlxQU9ocUdxckxvbWF0U3oxWWkyQnAwU1g1ajM5SmFGNW15ZEZz?=
 =?utf-8?B?Y3djcnlKSFlHZDdCcm9jUHg4bXRJbTBXbENVMVA3M1d4OWpYTDRBRzkrQ3Bv?=
 =?utf-8?B?QUwybW0yb3ViRmQxZ0g2RUp0Z0c1ZWR0QjB1SlBFdTEyaEE0RU5kN3c1bDl3?=
 =?utf-8?B?QTdmL0NQbm1sVnNMT3JocWZzSVh1azNoRmIxTlpTTVVzbXJOangwbkdCMml6?=
 =?utf-8?B?TlFteWxqL2VJdkRJYmJIQU85Rmw1T2NGWDY5RW9tajROVVVmd2hta0MveHBY?=
 =?utf-8?B?YXVrQ0Nka3h4S1FrbjFwUGpMSnYxNUpGNEpORU1IOE1yK0ZhRitTd3h5Q3B2?=
 =?utf-8?B?c016UVF0c0ZPaGNVSVJxMElIbkp5cWltUnh4cyt0Vm9KNlA0Z2hHcXNvQ3M4?=
 =?utf-8?B?SUlnNXh3eHdDZHlPN0N3Y1JjY3F2bFpkWFNsQnNsbm5vV05JM1g3UFRuSDhJ?=
 =?utf-8?B?azFUTlZRODdCd1Q1QldQOFNsUUhod2xWdzFkUXlTaS9uZE9vQTB2a01uMXNP?=
 =?utf-8?B?WjBLTlVKT1JLODVZbFYvNm1pclJRbUU3Q3krcjE2c0tOS0p4V1NvM3ZXbTZF?=
 =?utf-8?B?YUFidW5MckRTNnVRK2l1U3Vza0toM09aTWYwc2lmbmxlOVp0blY0UkwxSkw4?=
 =?utf-8?B?bHlVdGVBRTgycTVZUE1sbFVmTllZSzZVd1lXZEVIWVBmYktkRCsvSHpYdkl3?=
 =?utf-8?B?SC9oVXFPWVRJLzg0K3FEalM4OTYxWVBvaE1zeFBUdWVwSzRJR2dYd0J1MlU1?=
 =?utf-8?B?VldITmk3Q0VuNGowaU9sOVB6bFUwckptNVh5b0dOeDFWRXVDdVJ4OGxuRmZs?=
 =?utf-8?B?bXBjclZnbGM5N2taK0lYc1k1QjZibHNNbFhpcGhBS1ltUFFKdTdXSkFjc0Zp?=
 =?utf-8?B?UWJIY0RWK0FCODJLVnU1ZnpPcnNzaGpKOHVURkFXZjNaS2pyVmpOd1FBcm1u?=
 =?utf-8?B?M1lLeEVXbE10MHdiWlQ1SXMxcXdjZ1RXMW5YUWJxNWFheEQwQ0o1blRxYXhp?=
 =?utf-8?B?UzJOSGlkQUhTeGRSdzR1R1c3cXZ4VlAweEdWNzdSK0UrR1d1VzRpZzNicWhp?=
 =?utf-8?B?bmpKR1JmeWg0WVdQQ3JnMWdLbWZCQlovcXJNTERRdk0zVGcrSEQ1NDFlY0Rp?=
 =?utf-8?B?N2pqTkUrRGlUY2tqUm1tMFIwUUVSTEFSQ25xc1pFeGh5OU8vZXo4eGtZYm5z?=
 =?utf-8?B?WW9WZTQ3TkF3NDM4N0FxS09tWWNIZnZ0OEVueHRjam1oNkRZdlA0TDJGN1hN?=
 =?utf-8?B?NHBxVkluVXBOZGV6Wlp4SmdkYkJjZU04dmV3cGhlbVdxQXBFZ1NMTmtVZThv?=
 =?utf-8?B?Nko1S09ER1Q4bmJpclk5THA4MmVqVFFiZE43S2lRVXk5TTMzSmU4a2hIQ3Qz?=
 =?utf-8?B?SWpXQ0t6Qmtqd2NaRU5pNm1PMDBwTWt2d3dlTkkrTDFVWWNzZnJOWE44NTcy?=
 =?utf-8?B?M0VNNjNBVGRQR3lUWmcyQUJTb2dvbEk3dHpraGVDNWwwU0tQbUNwNkp0ODda?=
 =?utf-8?B?c21nZVdEUXRJcmVOWTkxOTNlRUpNYndWbWUvRlR4L01pbHF2aHVjaVZsM2M2?=
 =?utf-8?B?VFIrZGlBUVFqd1plRGVDK1NlOWR4cVZIMHVFNDN1NVVic3BLa1lJOXNlRHRY?=
 =?utf-8?B?c0w2Qm4vSzNVM2V5MmVaeTd5S1FRdjZ4a3AzZ3NIUXV4Y0tsaDA2eERYMUxr?=
 =?utf-8?B?Vm9ONXV6SkE5MTNiMnpnK1BaZXhTTk01MSszTk05V3ozZzdSWUNvaW0yS0M5?=
 =?utf-8?B?N2wrMnJlM3F2ZkNHYklXeVhMRXAyREhWYmhXZ3dydVpVZUlCbGh4RmhiWlht?=
 =?utf-8?B?a29US2kxcDlLdm1OeWRzRmEvVDU1VzZlT1FvTkE4SkorY3JBeFJodWlGNmxr?=
 =?utf-8?B?U0dXVUw5eU5nanFzd3ZJNkFHd2d4YkZGWGx1OUJjbnFpcWVpY2lPa0I1SG1j?=
 =?utf-8?B?QkNTTEo1MTRaMVJwc3BWc3ErNy9FNUl2ZE10bTlzZWQ3RnU4c2U5UmJnQW0z?=
 =?utf-8?B?RFdPK1YzZHNmZlQwY1JUM1lOaXhpZjBLTUxMUFpzVkNLbnArTCtQTXpJeUs4?=
 =?utf-8?Q?DQYKzvG2HfOSPaitJlEJi2dP4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da96667-ea18-4ed3-eeb8-08dc79a7805c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 15:05:50.0825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/NPgtVC418/XnK0pbE0Dmm9hnvonQuB/SGaEAyWR+xE9WRnqbeOq2gI9BYAhwvvAtrDWfvEU8DdSHXyO61V1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5877

On 18.05.24 13:27, Richard Weinberger wrote:
> There is currently no way to undo preparing of a kernel, except using
> --outpatch and reverting the resulting patch later.
> But in link mode the kernel tree needs manual cleaning,
> which can be tedious if a git clean -f -d -x is not possible.
> 

I had this here locally:

rm -rf kernel/xenomai drivers/xenomai arch/*/include/asm/xenomai arch/*/xenomai include/xenomai include/linux/xenomai include/asm-generic/xenomai 2>/dev/null
rm -rf drivers/xenomai 2>/dev/null
rm -rf include/trace/events/xn_*.h include/trace/events/cobalt-*.h 2>/dev/null
rm -rf arch/*/include/dovetail 2>/dev/null
git checkout -- arch/x86/Makefile arch/arm/Makefile arch/arm64/Makefile drivers/Makefile init/Kconfig kernel/Makefile

> The new --reverse flag offers this feature, it removes all previously
> created symlinks and directories.
> To be able to undo effects by patch_append(), keep a .orig file link
> the script already does for symlinks in the linux tree.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  scripts/prepare-kernel.sh | 73 +++++++++++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 14 deletions(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 183a59576..9079faf91 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -55,7 +55,9 @@ patch_append() {
>  	if test -L "$linux_tree/$file" ; then
>  	    mv "$linux_tree/$file" "$linux_tree/$file.orig"
>  	    cp "$linux_tree/$file.orig" "$linux_tree/$file"
> -	fi
> +        else
> +            cp "$linux_tree/$file" "$linux_tree/$file.orig"
> +        fi

Indention is inconsistent - to the degree the existing one of 
tabs+spaces in the script is considered consistent.

>  	chmod +w "$linux_tree/$file"
>          cat >> "$linux_tree/$file"
>      else
> @@ -66,6 +68,16 @@ patch_append() {
>      fi
>  }
>  
> +patch_reverse() {
> +    file="$1"
> +    if test "x$output_patch" = "x"; then
> +        if test -L "$linux_tree/$file" ; then
> +            rm "$linux_tree/$file"
> +        fi
> +        mv "$linux_tree/$file.orig" "$linux_tree/$file"
> +    fi
> +}
> +
>  patch_link() {
>      recursive="$1"         # "r" or "n"
>      link_file="$2"         # "m", "n" or some file (basename) from $target_dir
> @@ -106,11 +118,15 @@ patch_link() {
>              f=`echo $f | cut -d/ -f2-`
>              d=`dirname $f`
>              if test "x$output_patch" = "x"; then
> -                mkdir -p $linux_tree/$link_dir/$d
> -                if test x$forcelink = x1 -o \
> -		   ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> -		then
> -                    ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +                if test x$reverse = x1; then
> +                    rm -f $linux_tree/$link_dir/$f
> +                else
> +                    mkdir -p $linux_tree/$link_dir/$d
> +                    if test x$forcelink = x1 -o \
> +		       ! $xenomai_root/$target_dir/$f -ef $linux_tree/$link_dir/$f;
> +		    then
> +                        ln -sf $xenomai_root/$target_dir/$f $linux_tree/$link_dir/$f
> +                    fi
>                  fi
>              else
>                  if test `check_filter $link_dir/$f` = "ok"; then
> @@ -119,6 +135,11 @@ patch_link() {
>                  fi
>              fi
>          done
> +        if test x$reverse = x1; then
> +            if ! find $linux_tree/$link_dir -not -type d | grep -q . ; then
> +                rm -rf $linux_tree/$link_dir
> +            fi
> +        fi
>      )
>  }
>  
> @@ -135,7 +156,7 @@ generate_patch() {
>  }
>  
>  
> -usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose]'
> +usage='usage: prepare-kernel --linux=<linux-tree> [--dovetail=<dovetail-patch>] [--arch=<arch>] [--outpatch=<file> [--filterkvers=y|n] [--filterarch=y|n]] [--forcelink] [--default] [--verbose] [--reverse]'
>  me=`basename $0`
>  
>  while test $# -gt 0; do
> @@ -171,6 +192,9 @@ while test $# -gt 0; do
>      --verbose)
>  	verbose=1
>  	;;
> +    --reverse)
> +	reverse=1
> +	;;
>      --help)
>  	echo "$usage"
>  	exit 0
> @@ -220,8 +244,19 @@ if test \! -r $linux_tree/Makefile; then
>     exit 2
>  fi
>  
> +if test x$reverse = x1; then
> +    if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then

Won't linux_arch soon be a list of archs?

> +        echo "$me: $linux_tree is not prepared with Xenomai" >&2
> +	exit 2
> +    fi
> +fi
> +
>  # Create an empty output patch file, and initialize the temporary tree.
>  if test "x$output_patch" != "x"; then
> +    if test x$reverse = x1; then
> +	echo "$me: --reverse and --outpatch are not compatible"
> +	exit 1
> +    fi
>  
>      temp_tree=`mktemp -d prepare-kernel-XXX --tmpdir`
>      if [ $? -ne 0 ]; then
> @@ -359,15 +394,18 @@ case $linux_VERSION.$linux_PATCHLEVEL in
>  	    -e "s,@SRCARCH@,$linux_arch,g" \
>  	    $xenomai_root/scripts/Kconfig.frag |
>              patch_append init/Kconfig
> +    elif test x$reverse = x1; then
> +        patch_reverse init/Kconfig
>      fi
>  
>  test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>  
>      if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> -	p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> -	(echo; echo $p) | patch_append arch/$linux_arch/Makefile
> -	p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> -	echo $p | patch_append arch/$linux_arch/Makefile
> +	p1="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
> +	p2="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
> +	(echo; echo $p1; echo $p2) | patch_append arch/$linux_arch/Makefile
> +    elif test x$reverse = x1; then
> +        patch_reverse arch/$linux_arch/Makefile
>      fi
>  
>      patch_architecture_specific="n"
> @@ -375,11 +413,15 @@ test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>      if ! grep -q CONFIG_XENOMAI $linux_tree/drivers/Makefile; then
>  	p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
>  	( echo ; echo $p ) | patch_append drivers/Makefile
> +    elif test x$reverse = x1; then
> +        patch_reverse drivers/Makefile
>      fi
>  
>      if ! grep -q CONFIG_XENOMAI $linux_tree/kernel/Makefile; then
>  	p="obj-\$(CONFIG_XENOMAI)		+= xenomai/"
>  	( echo ; echo $p ) | patch_append kernel/Makefile
> +    elif test x$reverse = x1; then
> +        patch_reverse kernel/Makefile
>      fi
>      ;;
>  
> @@ -388,13 +430,15 @@ esac
>  # Create local directories then symlink to the source files from
>  # there, so that we don't pollute the Xenomai source tree with
>  # compilation files.
> +#
> +# Keep link dirs (4th parameter) descending, otherwise --reverse
> +# is not able to cleanup these directories!
>  
>  patch_kernelversion_specific="n"
>  patch_architecture_specific="y"
>  patch_link r m kernel/cobalt/arch/$linux_arch arch/$linux_arch/xenomai
>  patch_link n n kernel/cobalt/include/dovetail arch/$linux_arch/include/dovetail
>  patch_architecture_specific="n"
> -patch_link n m kernel/cobalt kernel/xenomai
>  patch_link n cobalt-core.h kernel/cobalt/trace include/trace/events
>  patch_link n cobalt-rtdm.h kernel/cobalt/trace include/trace/events
>  patch_link n cobalt-posix.h kernel/cobalt/trace include/trace/events
> @@ -402,14 +446,15 @@ patch_link r n kernel/cobalt/include/asm-generic/xenomai include/asm-generic/xen
>  patch_link n m kernel/cobalt/posix kernel/xenomai/posix
>  patch_link n m kernel/cobalt/rtdm kernel/xenomai/rtdm
>  patch_link n m kernel/cobalt/dovetail kernel/xenomai/pipeline
> +patch_link n m kernel/cobalt kernel/xenomai
>  patch_link r m kernel/drivers drivers/xenomai
>  patch_link n n include/cobalt/kernel include/xenomai/cobalt/kernel
> -patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
>  patch_link r n include/cobalt/kernel/dovetail/pipeline include/xenomai/pipeline
>  patch_link r n include/cobalt/uapi include/xenomai/cobalt/uapi
>  patch_link r n include/rtdm/uapi include/xenomai/rtdm/uapi
> -patch_link n version.h include/xenomai include/xenomai
> +patch_link r n include/cobalt/kernel/rtdm include/xenomai/rtdm
>  patch_link n stdarg.h kernel/cobalt/include/linux include/xenomai/linux
> +patch_link n version.h include/xenomai include/xenomai
>  
>  if test "x$output_patch" != "x"; then
>      if test x$verbose = x1; then

I like this as it obsoletes my local script :). Just minor notes, and 
please make sure it goes will with the any-arch patching extension.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


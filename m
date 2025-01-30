Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2093.outbound.protection.outlook.com [40.107.21.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF292BB15
	for <xenomai@lists.linux.dev>; Thu, 30 Jan 2025 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738245352; cv=fail; b=RDNMpU+2zA4iNdKOwCqFv6GxYRVFJEnmy9YxLhN5yr6Mrl1cImWpDi0s+srwI+ZnuTbWONlvZomoxCve/5QarUoakwlUKYXAdtto+H79boksGsCoN8poYdw0j4GQCdg2v/DMZWGpRgLeDRanB24yOPAf0SQkqw15DCS6KwtB4MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738245352; c=relaxed/simple;
	bh=+urId+vdNZ1vSISGC9scFdDVBIwztWqOhO0cy14WDi0=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=JMK+bjXgGj5zGKo/9ddFiPf5GqyA8s1TyV1WL8xrEDG2SL4IPn+CRgS0hNbVYnuFkcKNtWQGvF0rjWsSrJ9OyedpX0f7UInx6mhiekN+PkzlAl4D86IcAZ00poXl6Spr/dD2xGk6hfWY6eGQs+M02hBX2XXpVWWUF/7SQ4I59qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=utwente.nl; spf=pass smtp.mailfrom=utwente.nl; dkim=pass (2048-bit key) header.d=utwente.nl header.i=@utwente.nl header.b=n5g+RZjX; arc=fail smtp.client-ip=40.107.21.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=utwente.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utwente.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utwente.nl header.i=@utwente.nl header.b="n5g+RZjX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCtFTWGMmKSkwgTf22d4RvW7YbZC+FHLVO7VxWInvOBvwSMMih+yZPjBSgAhFvo/EuuDIXMZ5Wp2mI65ydgfU8nNrCYdNcEVQT2u+Czmhzb05HXWCoXr3byqw89RUnrNakNbshd5j7XVDq/n+fjUVXmIa7fu35fyv5OY9f/F7usD2eJVY2qcV0Rc1SELxHDYTmDhgk1SZwnIdpOc2NmAjdo7s4B57Y9ZWiRXa7sKBk5GhxnuX8uyG8Q7Falc/Y/FaV2Waphf+hqd7WDVkpdLulPjrLJLQhuaxFGa9HaH+6Evrx17XrnpgbxByQdJiHNi/7v098wGTb/r5tgrg96ysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLVoUIEMhwMlcgIjoGowjgoapBbBYjj9jIb1V1nkmiU=;
 b=vLeQyNNYX5eUq5HIG5leukUe3jtoIfnGhZ8YJiOyey73YqdPAKCnst2qdZ4rpdryBUq1rzMBQVDVA/ETKOiZM5j+K5Z34u1HqCPqkMyR43vfKSyjRYRdHt7St+AFWePVlxuRLFyq/SiJL6jRIoTqBE2tgr5XkmnNzBNXZa8uSfoxfKrIykc9M5oIzkdgiVyH5nFy1svdAEo5lotWJyw+oGbYLNVhT3KJh4Pbfmq/8QKZ9OPPL+099FLbxXkKn2oZ3rz2iD3szuYgz8yrh175Gn/3xN7DbDtRFCQoiRiyflF64dBf0/49Hm5q7WVaZ9H/DYxgYkM6M1H0hyYcg1wW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=utwente.nl; dmarc=pass action=none header.from=utwente.nl;
 dkim=pass header.d=utwente.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=utwente.nl;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLVoUIEMhwMlcgIjoGowjgoapBbBYjj9jIb1V1nkmiU=;
 b=n5g+RZjXbTgFq90SNYnXGEs15l4pL+N/5KzPvhESsuiMbU24I+CoEJcBARw7YYjZiA/kuDT6sS33ovog+8RNk4+29aStizy1iB6pMzbah/te45b7qWEsJ23Y8zCzENnY6S9q/C/gAfbfPZ4tXJmKmVGflJFnRDHcg+gCnQ7BytinRo6sY88te+Bx7r1gm+6S5wa3ifRlrVanYkTmn7Tc9YSQD9A91JlnNEceJDMWwcqK1+sG5SMYTdts7gWcUKXOLzvtZklOWtQLfOr3M0kdl7UGihDwqiA6oW0W+DHcz1lbX7TB3koat3ZYa7z/fOrQtIU+YlZyPOqZA5KT6LNfkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=utwente.nl;
Received: from DB9P195MB1513.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:33a::14)
 by DBAP195MB1050.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 13:55:46 +0000
Received: from DB9P195MB1513.EURP195.PROD.OUTLOOK.COM
 ([fe80::af83:d491:1d30:788d]) by DB9P195MB1513.EURP195.PROD.OUTLOOK.COM
 ([fe80::af83:d491:1d30:788d%5]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 13:55:46 +0000
Message-ID: <f1fd1edd-6d09-4e59-a85a-f00cf3b19727@utwente.nl>
Date: Thu, 30 Jan 2025 14:55:44 +0100
User-Agent: Mozilla Thunderbird
To: xenomai@lists.linux.dev
From: Gijs van Oort <g.vanoort@utwente.nl>
Content-Language: en-US
Subject: SPI on Raspberry Pi (RPi) 4 + Ubuntu24.04 + EVL does not work
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0080.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::21) To DB9P195MB1513.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33a::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P195MB1513:EE_|DBAP195MB1050:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f074b8e-6a03-483a-87af-08dd4135cb67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDcxTnBTMUF0ZFhvdEhlRVFEQTFqd28wUnBxRE8wZjJQdnFKNDdKVnRqdkdF?=
 =?utf-8?B?SmEzRUJNK1dUS01GTit3elFHSjRNK1hTL1QvaXJQb3UzeDV2L1FzN3NURVJS?=
 =?utf-8?B?MDFGNTJaN2h5b1NzYXQzd212OUlZQ1F6WDZHUStTVkJLbldYZG0yckhCTWFs?=
 =?utf-8?B?ZEZNVEhiL1VNNldqK0VFbXRkZ0RDM1BmbGx2aldGZXpaemRjVU8rd2ZmdzVP?=
 =?utf-8?B?cEdUeUVTd1ExbW5oZFN2T1p6M3QzcGtmbkVrMUNNV3FZVGdzYkhkalA5SzFv?=
 =?utf-8?B?S0pudVUzb3pRZWNSVzRNZDAxUnBmdGVNTmFEM3lKR01VL0Jsdml1K1lzNk1h?=
 =?utf-8?B?d2VRTUd0TE1mMFVYYUp6REZXNC9FclBOTWlpTlBURjhINXhlbmFKVXNrOHNa?=
 =?utf-8?B?UkNrT1JlZzdPSFo4Zzd2NVFVaDdFWlBaZmd5Vm9QeEJib2Z5b1FtL2hEOFda?=
 =?utf-8?B?NmxxMWZFTExSL2wrRit2WVRzbkU1VzU4NHkrSy9aM29MMFhodTJyWmQyNTl5?=
 =?utf-8?B?RWNsZ29uaUtoUmFNL3NhakZlRExRTUNKam5XMHcvRlpDWEg1TlRZclRReTA4?=
 =?utf-8?B?SEpQRWF6R0FRdENFYkpBVlFZTlJmZGF0TkJOV25XNmZXTm1ZMDZ1M05kZVVP?=
 =?utf-8?B?YVhXdGFFSkQxSCtmdXh5dy9PemNmeWM1MDVtSWg1a1Z0ekd5VmhRSkpVTUkv?=
 =?utf-8?B?MVdFU3BrR00rMC9ZcW1URGc5ci85MHFNSUVwV3NYZHMxMWZISmhDcmF5NWs5?=
 =?utf-8?B?dDRGZFQ0YnVRc2pieUZid0hyRWhyYnNvUTZTckxqdDJpK0ZlYjdUdDgydFdH?=
 =?utf-8?B?NTJQUXg5T2VndmJiN0dPUno2cTZoc29UNUt4cUQrKzN0TW12TVRQQk02Z3Fk?=
 =?utf-8?B?aGNJZFJ6WTEwYWNScnJYbFJEKzRYMERrb0NqYjJoa2paRmFoVnJMbXgwTVl0?=
 =?utf-8?B?QVlTQTlZR0hvYVRoOHFlWWh5K2RETitIK3lxUk1ETzRURTdTS3JBQjBJRm9O?=
 =?utf-8?B?RlFqYmRBZE5mMkh5VlJmanZ2SXh3MjNxUk9Zbk1lN2hGSXJkT0dlRE90K3NK?=
 =?utf-8?B?QzJRS3k3T0d2bVQxdDZlNlB3YU1Gd1JHenNMdGF3WGxSNC9JR0dmVzE5Nzgw?=
 =?utf-8?B?K3hjK080VTdCNlRweEtDUlM2dlZPeDNHTDAzUFFNTGNLOEcyMVJNMFA2aDk2?=
 =?utf-8?B?N0llNVJmdzFsZHdlQ0R6eGpscW9VeTlibm02YWl6L3NNR3dDTUl3WDM5aFhK?=
 =?utf-8?B?S0pmNHFOaDl1a1lJanlUU2tVVEZJbXZ6S25LOGlvakpYZkdHWjFOa252TW5B?=
 =?utf-8?B?ZUQvckRVdHF1S1JIK2JPcmRPN0RMUUFTeWxLM29HUjRMWU9Vb0R1UTVWZTVq?=
 =?utf-8?B?NFRNNnZsZTMxWktpeC9CdEI4MkhVTHZsdHBQd3BoL0VMelFKRTlTMTk5Tjcv?=
 =?utf-8?B?MWhMdHVVT3Y5TXJQVThRdS84YVBlTU1EMC9PV2VzSXdyQUtGbnJHd1FTbGRy?=
 =?utf-8?B?eE00cTJuVWw1WXRmQ3AvSWFIVFFkNGQzYmZZelh4QkMwYWhoM2ZUa0h4Uno1?=
 =?utf-8?B?aFc1NFBFbWFtQ2ZKU09OT2wyeHNRYTFzckViWWdYaXJPaWlsZ0VNUFNxRE9Y?=
 =?utf-8?B?UWdTeU1qY1NkS0dWdk9lckNaTjFxQUsvdTdkaGw0eTA5Znc3cFUvQWdId0hp?=
 =?utf-8?B?aTg5a2pod1ZkeVM0UGFuOTUrN1BkTXBWc3ExZnlySkt4dDdGRnBtMFlJRGZy?=
 =?utf-8?Q?nTXVy9kvAHOQQebKiPjagqJflRYuarJDwThLJTI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P195MB1513.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW5veWZIenRpWWJEdzhmbmdsU05ya3RNRVZUOTBqVXRMYit3M09EQU9majFt?=
 =?utf-8?B?Vk5BUXRvZndGK2t5UENEL2lmTVhxZHVFVDBpV09ISnVvUHlkSkhjSkR5TmNR?=
 =?utf-8?B?S2cvOHBXQ0hGSkY2ZlFPd1lkN29PaEVkdmxVcmdvTURxT3kzbVd5eXlBeXZp?=
 =?utf-8?B?S2hYczZjOGVsK3lxakV0Ri9oRGdOeFdKSm1seUNRY1o4MkE4djVXY1ZTYnZS?=
 =?utf-8?B?ZWxyWHFwMGQvTzV4eTA1Vk5HSm9vbHVya0ZBY0crd1pyNVFuTHpzTTJhdWk4?=
 =?utf-8?B?UitlNk93dEhYS2tKZ0l4VzBIVU5QMkkySUZKNkdrbHp4NXlRa3dRZFhGS2Zm?=
 =?utf-8?B?cUpZenllOFlYdXFkelM4dUY3cDhtY05xYVZYcDZyZ2ZwZlRNWGp2RDZzM1FQ?=
 =?utf-8?B?bS85blRhSHpyQmRTdWZOZllmUWpvTjRYelV4L0JMVkJzUDdWTjVHWjRtWU9n?=
 =?utf-8?B?ZTRlSlA3L3VxZVY5d0FzNU1PYUpUaWlpV3R5cUM5V3NnSE9xUU51TVNtM3pU?=
 =?utf-8?B?QTJram5sOEZLa0ZEWVd0RWlZbVl2MDVtTkgzVldONTZRbFdoeEFBVjRteVNG?=
 =?utf-8?B?cXZ5UHBzRVdLQzQ5ZDBoSHYwNTYvQTlyeEZNMGhOa2xxbUlVd2tsbDlFNjM2?=
 =?utf-8?B?Qk90aU55ejV2bndTOGY5S3pReXIwK0o5Q3NUVmVlWkdXN1pJNHJpYkVPbTYz?=
 =?utf-8?B?bnEzMmhmdXhmZE1QTXR0TkViSnZFWC92ZVB2WXZKQUNqU0w5cUtJOFN0Tnlj?=
 =?utf-8?B?SU50Uy9hQ0VNRWQ5b0xFajdHUElYb3VuanVMUTRQUmtGV3R6Y0x0d2V1WnRw?=
 =?utf-8?B?S0hXd2hBMzNoYkVtUmZnZVZMQXFIajNRTWhwVmt5SUhBemoxdWZyaTNkZlJN?=
 =?utf-8?B?bk03R3cvZVpOZ1J1WWpBNENURmFvSE1xSUNiWUppaEFGMXlxUkx6bEdMYnc2?=
 =?utf-8?B?amNmU2pDU1EyTHNmaEhDM1BkbzdJMnpxQUpHYlBVeGQ3MG8yUnMreFBPUGdG?=
 =?utf-8?B?OEdSS1lRaUU5OUpubnY3RlpQSHVQOVVkSnRRL25Ra1lZeDJlNzJUY2czSGtH?=
 =?utf-8?B?M0tvTlFkSHN0UlloSzZKQStEd2NNcTA4b0JjakxCamg5SXNRNWZBRXZtRmZj?=
 =?utf-8?B?WlVHWkJxcFVIQVpIQlJSSnFXdzhkRk8wTXBGaXVSN1p1ODYzTWdpcU8xWmhT?=
 =?utf-8?B?a3JJQmYyVVhFeFVuNHVla0lzQitRTzNoQWs3TjNXUjRua2w4WE0rUVZneEVy?=
 =?utf-8?B?VkJSMUZCRENJSHVpR2lOdVZjNzlKODdjYzF6M3dWUlVVMm9Bc3RaK0RTcWgr?=
 =?utf-8?B?OGpuZjdoRTFMc3VlZnhheTA2TFJIYzFtS0EzTTl4TktxbGlGNjBaU2FxUlp4?=
 =?utf-8?B?dTkvdlRkNXJXTG9PUnh1QlZSYlRxOFFGTlNKU1lzZFpWNG5ZbE10dEhObCta?=
 =?utf-8?B?VjRPeTBXdk54Z2JZenpWdmRGMDdydVBCN1Rac1NxN01FL2hGd3c4UTh5OFAz?=
 =?utf-8?B?MHlnV0N2TW1JTDJUS0JlZTBWTWY2N0w0UHdSSkRxTTZBZEpuSWhib2dFZVI5?=
 =?utf-8?B?Y0ZHTXhpNStGNjRUVnhjSXlNMWIzREZGNFVxd3NFUnp2T0NuekhoZm9wRXM1?=
 =?utf-8?B?ZjFYc3lYNXo3OTkwdy9FaWg1L0l0UUtYUmpDazBtWGhINEhZVTMrWnJnd0ww?=
 =?utf-8?B?aVlkb2hxb1VsWDlXMHVRaVN6RHFWcy8rTmcxRW5ZR1NTTWRaRXBKaVpVWWd5?=
 =?utf-8?B?eXluRUFhOGRDZlI4a3N6RWZ1NGRhNnA3bStGTU94OVZpS3hWbk96TlhtN25P?=
 =?utf-8?B?WlNpb25hdE5MbkJKaCttRi9JZFFvWElmN09FZ2tFcDFYY1FIL2QvbzNpZVZH?=
 =?utf-8?B?WjV0M0hjSGpzem9Odm5BNFFLSytOTFFTamxUOXZjSTQwOU5qNFZRRit5SUFQ?=
 =?utf-8?B?VTVJU2xkM3FIeFA0c1JoODFyNTdZcmpESXRPc0F6NTVIeG1ueFJMaGNMeVhp?=
 =?utf-8?B?bWxYc1JGNzh1dzBQVDFJS3VWSTFHa00vOU5ndWFuc1Y5RFNWdVd1YUhNY3FX?=
 =?utf-8?B?T0syVnFBS2gvOHhmZ3JOQmxqd1dtL05QYjdLQTQ3aGV3ZEpkUDJDU2RwdnVV?=
 =?utf-8?Q?AWcAdS/rsBywz3Tyh0grZTCnZ?=
X-OriginatorOrg: utwente.nl
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f074b8e-6a03-483a-87af-08dd4135cb67
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1513.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 13:55:45.9220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723246a1-c3f5-43c5-acdc-43adb404ac4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kauw+gol/sfOFVHos1GzzM62Y0Dtxg/MMZgGl3fQKRKeD2Eo8JdWZPLv27Vj+OrMLLIiBNiV4AWqZ9QSmTSAcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1050

I am trying to get SPI working on the EVL kernel on a Raspberry Pi 4 
with Ubuntu 24.04 Sever 64 bits. And I fail. Can anyone shine a light on 
the problem?

Basically what I tried is the following: straightforward 
cloning-configuring-building-installing (a little different though 
because I compiled inside an LXC container running Ubuntu 24 on my 
laptop since my main install is Ubuntu 22 and I don't want to mix up 
versions):

1. Get sources:
    `git clone --depth=1 --branch=v6.6.y-evl-rebase 
https://source.denx.de/Xenomai/xenomai4/linux-evl`
2. Create .config file:
    `make O=../linux-evl-build ARCH=arm64 
CROSS_COMPILE=aarch64-linux-gnu- defconfig`
3. Update .config file to make sure EVL is on (CONFIG_EVL=y) and all 
relevant SPI modules are included as module (CONFIG_SPI=y; 
CONFIG_SPI_SPIDEV=m; CONFIG_SPI_BCM2835=m; CONfIG_SPI_BCM28356AUX=m; I 
don't bother about SPI_OOB for the moment) with command line scripts 
(`scripts/config --module SPI_SPIDEV`)
4. Resolve dependencies in .config:
    `make O=../linux-evl-build ARCH=arm64 
CROSS_COMPILE=aarch64-linux-gnu- olddefconfig`
5. Compile:
    `make -j$(nproc) O=../linux-evl-build ARCH=arm64 
CROSS_COMPILE=aarch64-linux-gnu- Image modules dtbs`
6. Create Ubuntu24-Server-64-bits SD card for the Raspberry Pi with 
Raspberry Pi Imager
7. Install new kernel:
    `sudo env PATH=$PATH make O=../linux-evl-build ARCH=arm64 
CROSS_COMPILE=aarch64-linux-gnu- INSTALL_PATH=$FSBOOT install`
    `sudo env PATH=$PATH make O=../linux-evl-build ARCH=arm64 
CROSS_COMPILE=aarch64-linux-gnu- INSTALL_MOD_PATH=$FSROOT modules_install`
8. Copy the new device tree file and make sure that it is used:
    `cp 
../linux-evl-build/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dtb 
$FSBOOT/bcm2711-rpi-4-b-evl.dtb`
    `echo "device_tree=bcm2711-rpi-4-b-evl.dtb" >> 
/media/$USER/$SD_BOOT/config.txt`
9. Boot the Raspberry Pi with the created Ubuntu image plus new kernel

I don't bother about evl-lib at this moment (installing that will be 
trivial once SPI is running).

What I get is a booting and working system (`uname -a` shows that I 
indeed run the created EVL kernel) but without working SPI. Some 
observations (all observed in the system with the new installed kernel, 
unless otherwise specified):
* When I just run a fresh Ubuntu 24 Server install on the Raspberry Pi 
(no EVL kernel), spi works as expected (e.g., `echo "hello" > 
/dev/spidev0.0` as root works and gives the expected signals on the SPI 
pins).
* In config.txt, SPI is enabled (`dtparam=spi=on`)
* No SPI-related entries in /dev (`ls -al /dev/sp* -d` gives no hits)
* SPI modules are loaded (`lsmod | grep spi` shows both spidev and 
spi_bcm3835)
* I do see SPI related items in /proc/device_tree : `cat 
/proc/device-tree/soc/spi@7e204000/status` yields 'okay', suggesting 
that at least something SPI related should be enabled (also, the address 
7e204000 is indeed related to the default SPI port).
* `cat /proc/devices | grep spi` shows "153 spi", indicating that there 
is indeed some SPI driver active with 153 as major device number.
* All in all everything seems to be okay, except the fact that there is 
no spi related entry in /dev. Using `sudo mknod /dev/spidev0.0 c 153 0` 
does create an entry but it is not working (`echo "hello" > 
/dev/spidev0.0` as root gives the error message "bash: /dev/spidev0.0: 
No such device or address").
* Contrary to a fresh Ubuntu24 install, the commands `dtparam` and 
`dtoverlay` do not work. (on a fresh Ubuntu24 they do work and I am able 
to enable and disable spi at runtime with both `dtparam spi=on`/`dtparam 
spi=off` and `dtoverlay spi0-2cs` as root. The spi entries in /dev 
appear and disappear accordingly). On the version with the EVL kernel I 
get the error message "mount: /config/device-tree: mount point does not 
exist." when I try either function. Could this be a hint that 
dtparam/dtoverlay could not work at boot time (i.e., when parsing 
config.txt) either?

Other things I tried (none of them had any noticeable effect; all showed 
the behavior listed above):
* Last year I had a similar struggle in getting SPI to work on an Ubuntu 
22.04 Server for Raspberry Pi. I ended up using the work of Deniz Ugur 
(https://github.com/DenizUgur/RPi4-EVL-4xSPI), which gave a working 
setup (with 4 SPI's even, if only I could borrow one of those for this 
year...). That setup used kernel 5.15.119. Apart from a small patch to 
tweak the bcm2711-rpi-4-b.dts device tree file, and a customized .config 
there was nothing much to it. Unfortunately, trying to do the same 
patches (tried both literally with `patch` and conceptually by applying 
similar changes to the .dts file manually) to the 6.6 kernel did not 
have any effect. Note that on this system, `dtparam` and `dtoverlay` did 
not work either; apparently it is possible to get SPI working without 
that having to work.
* Tried many different .config files. Always made sure that the SPI 
related modules were included as module (also tried once or twice to 
include them built-into the kernel (CONFIG_SPI_SPIDEV=y etc) without any 
positive effect). All .config files gave the same behavior (SPI-wise).
* Kept the bcm2711-rpi-4-b.dtb file from the fresh Ubuntu 24 image 
instead of replacing it by the newly generated .dtb file (i.e., skipped 
step 8). I could not spot any difference in behavior.
* Cloned the Raspberry Pi Linux kernel (`git clone --depth=1 
https://github.com/raspberrypi/linux linux-rpi`) next to the EVL kernel 
and copied all relevant device tree files from the Raspberry Pi kernel 
into the EVL kernel directory; then used that for the device tree 
generation (specifically: arch/arm*/boot/dts/broadcom, 
arch/arm*/boot/dts/overlays, arch/arm64/configs and two .h files that ar 
required for the dts files).
* Copied a (known working, for Ubuntu22-kernel 5.15.119) 
bcm2711-rpi-r-b.dtb device tree file to the new image and used that.
* Tried EVL kernel 6.12.y

Now I'm officially out of ideas, so hopefully someone can help me...

Kind regards,

Gijs van Oort
University of Twente
The Netherlands

Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B613AA5D
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829532; cv=fail; b=U1CeqOnP6V49rnbpdJZ7WbcfdDuasiyikcPEp9UwboCJ0WF/GPN1A2fO1+qwcB4ikPNZGjiyhcmN6JneBBYjYzuZkkoo+bDpku0yNI+kYKlBVqxj8ziJBs38W1+VfvN+pocs+HK04WnwDbPmJgvJpuDz5MPnrUEbZzgvvlqjJPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829532; c=relaxed/simple;
	bh=e1QGdVt/zTaHYGVpVv9V+pv/xnNdQzVfIXQcOg0DXLc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SZenDvGk3UhlcElq9dbALleek7I2T67j7w8/O1I1ZHyMgFyCBeQRasQBXQSsPxIImkjc0Hht8XlpOo9wNBthbyENw+7XhbbQpk4FAP6cabRKQwUJ/iiOnJVco+ZidgHOMA7xSF9lHoJhwzy1al4uIPnNDzQGFyqYaDeJHOGSiPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lS/BNTqy; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lS/BNTqy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHCBJaX4NmNSfEP4LcgrOZ7EdsGvf9GvqLudA2dRgBx4CWcKQ7MOwEIVMlEm5qD3HL4juAmJS3Qb2uVB2iDPU0U4JC1y+DaVTG4XgfEetZsaY+vlTz3nDhCo4sFS0D/V1aVw/Tbx3dSC0suNGjGQMTxmdjPraTxeM+Y4OTyoQC09IuuzhJ6jIwyk3sdamn8l9HD5JA9pxe++o05Bjq85uCV3NYBpIfeq6lV+WoOFih8zOm6SDAN9BCfcO2XIpgqI1DkmW+jrQyuUskwFXFV/lOc2NouVhbGfUVdfkiJwjRwYY58xMK59W4eoQceOJTDakN748GIhrBPorwnss+rdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCIfyMam0RI97k9pWmrWhvJjzYIN7awyRFtJNVIM+rw=;
 b=jQU7gyHuF3IJVP0AVC/Be0TjZ+ygnv40kpF5F3cg8sK0k6N1vI6RLR0jU6CfLLGVR6hsPTk9lu5oJWtA0ySbHQX8XUPuLm+bkfjJF4YH1Th2OcyCdJli/GQyE/0I0pK+PYZAi5fjFxGXwgiz7OtUMdRspCINCscChMiz1bWAZBZdE56Lq9DxVDjHMiLecMgAYiOClvcDKL8dtqDTYp0mHCGs7ayQ+9+8G62Svw2lQ5oLtH/sFBMrtxtF9+LkAwAwQZEVpYV+ZQ8kTJTll3ToNvejGAit5zbGYklsPeqR2eP0ZKig1oOtkgHh8OvXjUGX4yNviaZ3yMYm7pwi9wdNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCIfyMam0RI97k9pWmrWhvJjzYIN7awyRFtJNVIM+rw=;
 b=lS/BNTqywJcO57DTuBZTBzwX2D1UxouqybjEsV69/1TuS+SV1d1kWgO6yH25iDCvx44ogty1xKD5PTz3MMciyRmvCpMZw8vlRKtMEsEhtBu70Fr2/NpzRspzH+kJ6jknz5cUDF1wiyUXS6yK6sP3dKY+MyR+fFvhGubu+97vWNwWat5MBYSyESLfOCsSG7zTbbyJqhzQH4K6ggQjE9ptnMjGBCgDoXqZC/S307PyvQBdDKFx/cws3dXphzyfb1biuH2Guyq56J4WSksglH7sqOzF368RLfAHm6NrGitgziDFgeRJi0XFE5MeIdydcluWufFSOlef/IYRyXWLYwKokQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 17:05:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 17:05:23 +0000
Message-ID: <30d21261-9bf9-4732-ad01-1c96494763f0@siemens.com>
Date: Mon, 27 May 2024 19:05:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] rpi4: add Xenomai building support for RPi4
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240524150335.23090-1-yi.jiang@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240524150335.23090-1-yi.jiang@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:610:75::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9cad2f-3cd9-41fb-409b-08dc7e6f329d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V29tdzE3cW85dk1EVllidDFKNHNabGpISFhUZzVqUk12bDZObm9Qclc4Ykpq?=
 =?utf-8?B?RUNHRVRsY3FQSFlSRmRDVVBvOWF4ZHVwVFcrOTVUc1VWbnpZeDIrNEhsb2d5?=
 =?utf-8?B?RjhuQWtPWXNsMllKR2pucktldGZ0bzE3TVdVUWRBa2NFNWFYaDlhV2NVVndF?=
 =?utf-8?B?Z2VVajJ3K1VVQjVnaHJqV3BicmlYVUV5V2ZKT0s0bVFCeWhhTTA0V01OYmFM?=
 =?utf-8?B?TDZaVEI3R2FJYTFKaXF5ODJ2OWEyM1d2QU1HRUNLQ01MWnp5RW01UWVTc1JW?=
 =?utf-8?B?M29kdEpTRlZqQXlScXRMY2hqaFp6TTNoRVVheDU4YmZycnl6VDc5SUFiWXp2?=
 =?utf-8?B?NVJ6bWl4c0ZieWRGVUpXeC9zNEFXWjVEa1Z4TzhpSVFyVkVvUjBVVkhYNXdU?=
 =?utf-8?B?bi9HcW92NG96enhWVVdPL1A2K1l1ekpLa1k0Z0VLZWl6MHF1WXJEdXdjellh?=
 =?utf-8?B?Vk5LN0xQRTJoMEZoVitHZjJFQXgybzI4RGQ0WGxxUW5pS2RBSW91cDh3a2hD?=
 =?utf-8?B?NVFUS3pMMkJQdk9YU0Q4N3Y2M0V0Y2crU1hxSStYR01yZElmd3Z6b2NtQlJi?=
 =?utf-8?B?UXVFU1ZxdUN1eml1NTYyUUJnRFdCY2VvNEQvUzhHcUR4eDhGRGx4ZU8wY3gw?=
 =?utf-8?B?TUFBVkg5Qk1Ld24zTHpxa2x1cTZxOWhaaCtJcngvN0ZnYkdVcUJPdnVVcldU?=
 =?utf-8?B?b3RuQmlickJEMFZZazlKZ3FZcUJaU2NtV3FFUlkwNG5IN2VhWTlkVDd6K2ZZ?=
 =?utf-8?B?Vk03a3B2UXl1aVdZVHUvQTRMd2l4T1MvdGRoK0w5Nk1nVThyRXZuMTRLWGpM?=
 =?utf-8?B?RVUrQXNSQ3FnYXlPemRuTzhOWjJ4TWpndy9XYlowUUprL3lDRkRmUmY0d1M2?=
 =?utf-8?B?Sk5hOERBcTExM2NKM3dYaW1qSEduQzJjZ2k0ZU5BTjdVRW5waDB3OE5RdVBh?=
 =?utf-8?B?aTQ1Z2lvUFIwZ1VxeE1nTnV2ajg0T1lEVWg4MUFoUnhqVmFBaTJ3Y0lVZlp1?=
 =?utf-8?B?a282S0I0UFFpNWJURU5mam54d1Z6OUs4UkoxeDI0NUgxSFNwNy8rN2sxYXJq?=
 =?utf-8?B?a3NQNVRKUlg2OW5VdkY0S2hWandsMXB6ekxocFB3Y2lwb1F2cG4yTHdIa0Fw?=
 =?utf-8?B?L2JZYmJmcUVRSDlaWTMrOFdrajNnc21naVh3M1NrVklrZUJGN0Z3NnpqZXJI?=
 =?utf-8?B?azk2eURVb01ZbVVJa08wNUxvSkxpdzVxWVZPaENlUzhiRUJ3dVlTL0l6MmRT?=
 =?utf-8?B?cFVuNzVmd01xdE1OMjJsMTVPbVFTc01Ld3EyR2RDOEhQQnFkdmhSWmcwZTQ5?=
 =?utf-8?B?RW5QVmtzY0huWHF3SDZadFg5eXdkQ0VGbWo1bGhYdWo2eU1RMWRuMUxmYWJV?=
 =?utf-8?B?N0RmNnBYL1VhT1ZwWXN4MDNwTjFSQWM3N01VcUVFeGxjd3JNUE5MVDRRZjBz?=
 =?utf-8?B?WnZhSkZLZkYxaHlWQTZ4SDZERnlYcUpPaDFlem9KbkRpSnVraVd6RjVkbGhv?=
 =?utf-8?B?U202Vi9yNUg5SmwzcHU2dENiUUI5Qi82YmtuRlZRaks3eEZ3SUdlbHhPbjE0?=
 =?utf-8?B?WHNkK2l1YlZMUmZiMjFqckZOcktLbkhrZUdpQkFuK3l1T0hBY0NXYVJXTk1C?=
 =?utf-8?B?M0N0di9McStMcWtNVlh2MEFZUTlveVdFN2lqL2FQZEk5K3EySm1CbFlna0JS?=
 =?utf-8?B?UWc2Rll0aGpXeUZkcDdFSDVmcjdOL0ZvcUhZSUxERG4zQmg3N2ptWXVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVdUL3Q0QVhqS3dHcXp3V1doOWJtNWVKekYyMUVJellPZEY1WFZRS093MDdi?=
 =?utf-8?B?Y0g0ZG5DQ3Ruc1oxNDVQam1sL1ZkYUZ4c1hUQUtuWjk0aGp2NTczdTZNNGxW?=
 =?utf-8?B?Z2ZMNmtGcGVFWGNUVUEyWFcxOU5CeVlDMjRGSXpPRllISmdrQ2FwT3B5KzJ3?=
 =?utf-8?B?dlgxNW5WTGtUNWpvcXV1YlloVkVZUUI0VzFuczhMdXlPSDNEN0dwRGcxaXhG?=
 =?utf-8?B?T1FiVHh3dmd5Vzh4UHVHYUY3SFVEaFNIRDhXSFpiRm1WWUpJV1U4L1BkNjdP?=
 =?utf-8?B?RWRUQVQ2RXUrTDZKY0JwbmtvNXdnTnFCUW5GVlZpRmV0WExmOHF3dDY3TWE2?=
 =?utf-8?B?RzZrYnJaZkEvNTZKczFkR3A4UC95b0N2V2N5QkRQczZSUDVqc3RwMHcrc0k1?=
 =?utf-8?B?Z2NuVkdqeVVpZ0UrTFdYTUs0d1VjSmxwOVhGbUVuYzIzc0MwZ01ORmUybDVw?=
 =?utf-8?B?VTlUZjdUY0pjVVlWaXFNSU9sSGF0ZVNLTkhHVDdDRUU5WkxHSXVKWWNSQVlj?=
 =?utf-8?B?SGp5eUZuMnBOTzcwaGQ4RW52UzF0NUp5RW5iZ0VkNzV4SDR4R2pucGE5c0tX?=
 =?utf-8?B?ZnJRbFZMYVRTOGMrcHRCbDFTRjVVcWZYMmFIRXh4V0JmTnB0L1pBT2E0ZVVR?=
 =?utf-8?B?MlVHcjhSQUVObU8vTnV4bVArUGNrWDd6S3BndERwczRLYjFNajNvUnBlWU50?=
 =?utf-8?B?QytPUTBMS3ZIVjd6V0NCa1FhUWVoV3VzNkU0RmlpL1F5UGtnMFNzeWMxanRy?=
 =?utf-8?B?cituOFdycHBibHAxdmIrb2lFdjVKQnhQMU9zV2krdGpBaVVzdms4QU5PY0hH?=
 =?utf-8?B?YjA4T2p2OTJZS0Z3WmtCTENLaUdhcTRHRmFpQTJJRVU5NFdGMEVjZGROcTdF?=
 =?utf-8?B?U3RFdXFTTE9Bbkl1TUtDbkpSRmZGMGhIWWtTWnpSM3NvVldkMVZCS1hVWHA3?=
 =?utf-8?B?M21KV3ovVlQwSVBsYkdPMXRzUDJVWC9lbW0yS3lydkRNeUxPL0NWOEU3cURt?=
 =?utf-8?B?VHhTK0w5b2lUK2t3WmhlVExweHpiYnFzMjJZbENGc3ArWlUySjF2MkJQM29o?=
 =?utf-8?B?TnNZTlYzTEl1R3F6T2kva2FmUFpSc2xidXVZUjVxMW01RWJ1QzN4RGw3RXVj?=
 =?utf-8?B?VnlHaUdTcVBBZURhZWVQdDVKdklOVDUwOG9SWW82WTJCdHBtYlNBVkNFRkRQ?=
 =?utf-8?B?cEhuaFRYRE5QbnVxMWRNVHlkYlBaRW8wVFFMNGl6QkU0Z1pBNmdBNW1MUUhP?=
 =?utf-8?B?MXJUM3M2ZmFjZThlcTdaL1dCNHcrWkpzVUZhVGFFb3Y2Mys3dWZHK0dOMHR1?=
 =?utf-8?B?QWpsbGxCdGZBZkhsYXNCQi8wRkRlVjZHMmszL2NqYXdJN3BYUm1RZjF2QUdL?=
 =?utf-8?B?bWdZaFFmS1JGQ3dLR3UwQ0RONEdyM3BETUVIcjNvK3hITGU0cStEblRRZ1Uw?=
 =?utf-8?B?Y0tFK3M4YVlmVDYvMjRITm04bVUxdm5yUUR3azV0bnZyQjVlaitXNmNHWmpX?=
 =?utf-8?B?eGFNcEdZY2tjdUx5Tk1IdGtFdFNIcGxiVnZOSUQ5NDJaR2QvUVplUWRtcDBn?=
 =?utf-8?B?Z0lsNW1pekR2UjRmUFUxb0xLeWdJS3FyTXlQdTJmT0xZTmg1ZTZNdTUxRUpn?=
 =?utf-8?B?azBFS2FYN2hxVWIya0lXREsxNERxdVpsWVJ1dzhOTjlQK1FPMS9mWlZseVVj?=
 =?utf-8?B?MmYweUdleCs3MThNbWhHa2ZlbitiYnNXdThXVVc3UXBQS1BtUU5IU05ERW1X?=
 =?utf-8?B?OWxwK2ppWjBjL2YybjQzU1JRemttN3g1L3pkQVo4QVhtUkFoQ2RMM1lwTTBm?=
 =?utf-8?B?VW8zSFRFOUVwOTlRV2dxRkp4ZkNnS3FPTjhpcnpDVlQ4bTZvUE8zeXNvcGpE?=
 =?utf-8?B?YW0zNXRaT1hiK3pHWXlTUkx5bWprS3pGRFhLYVh6bVZBRTl6b2hJQk1LWnlO?=
 =?utf-8?B?K1REd04yYVdqdjE1QjZCbFVJVFdId2lxS0RyZ2NrbkpTeVhqTUROdUhsQlVW?=
 =?utf-8?B?QkJMTXpCYURjSEk0NWV2NkJlaHNDODVNTytxUVVNaWpPNHljak5aQno0NzVr?=
 =?utf-8?B?L3g5WHFES1R4MDRiQlVMbWFXSTVzNTIrR2NiRTZUYVFZWHVlTHdBZUNINVNj?=
 =?utf-8?B?NCtFWE5yUWVoTXpVc0xIaGVoOW0zcHRUa25XY1NqaWRraFI2Sm9QVC93YXpz?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9cad2f-3cd9-41fb-409b-08dc7e6f329d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 17:05:23.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZK+EkDT7heUtSIA5ErzCquc/6NmuqXPym3l0cD/G5RNgLa4CMrYPlS3a54OPO6GDNR8BbPfzZlaQfdnd1G2NEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5757

On 24.05.24 17:03, Yi Jiang wrote:
> Hi, all,
> 
> this is the third version of the series for adding Xenomai building support for RPi4.
> 
> Thanks Florian for your comments on v2.
> 
> Changelog:
> v2 -> v3:
> - [PATCH v2 2/3]: Remove rpi4.cfg.
> 
> Best regards,
> Yi Jiang
> 
> 
> Florian Bezdeka (2):
>   rpi-firmware: Add recipe for building version 20230405
>   rpi4: Add rpi4 (Raspberry Pi 4) as target platform
> 
> Yi Jiang (1):
>   rpi4: add building options for rpi4; remove build options of old
>     kernel and Xenomai versions in kas menu for rpi4.
> 
>  Kconfig                                       | 14 +++++---
>  board-rpi4.yml                                | 15 +++++++++
>  conf/machine/rpi4.conf                        | 32 +++++++++++++++++++
>  .../rpi-firmware/files/debian/aliases.dts     | 18 +++++++++++
>  .../rpi-firmware/files/debian/cmdline.txt     |  1 +
>  .../rpi-firmware/files/debian/config.txt      | 12 +++++++
>  .../files/debian/rpi-firmware.install         |  9 ++++++
>  recipes-bsp/rpi-firmware/files/rules          |  7 ++++
>  .../rpi-firmware/rpi-firmware_1.20230405.bb   | 30 +++++++++++++++++
>  .../customizations/files/primary.network      |  2 +-
>  recipes-kernel/linux/files/arm64_defconfig    | 10 ++++--
>  wic/rpi4.wks                                  | 17 ++++++++++
>  12 files changed, 159 insertions(+), 8 deletions(-)
>  create mode 100644 board-rpi4.yml
>  create mode 100644 conf/machine/rpi4.conf
>  create mode 100644 recipes-bsp/rpi-firmware/files/debian/aliases.dts
>  create mode 100644 recipes-bsp/rpi-firmware/files/debian/cmdline.txt
>  create mode 100644 recipes-bsp/rpi-firmware/files/debian/config.txt
>  create mode 100644 recipes-bsp/rpi-firmware/files/debian/rpi-firmware.install
>  create mode 100644 recipes-bsp/rpi-firmware/files/rules
>  create mode 100644 recipes-bsp/rpi-firmware/rpi-firmware_1.20230405.bb
>  create mode 100644 wic/rpi4.wks
> 

Thanks, applied.

I've massaged the subject and commit message of patch 3 to the point
what I prefer in this case: On the point, explaining why the extra rules
are needed in kconfig.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


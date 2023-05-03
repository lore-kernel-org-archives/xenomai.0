Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590964A11
	for <xenomai@lists.linux.dev>; Wed,  3 May 2023 14:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL20UqmQU20VYPWFBPKGE8NggdFiCJ0FUhbi+Z1vpDYuYyFsTNsXazCKOo5Ns1UgtGvREd9Efmx77F8Ql9ETquejHhpT6jFVkI1Yt01MDdUZcRZxS9zWqSEcLCBJ2UZ0rU/ct2vPcdK3ZTZ2K6P1272vask/mSJudamXVqtPpDOnf0jmPRupQ1LTuHgp9g8OcQ9AKLy3WDJTbIB5Gqgq1CldVnGOaP1TxS17M/7k0xrfXfICS6ShMeBy6CawhgXXfuzZdrBwqaP/ck6RMceVaS2SNIC//L14kxwbj+xz9i6uDziF5yUXvXA1Ez8NpsQNsySiYgjq06nTQiQ7G0R79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2/OoM1h/rNy7FLeAfycxRqcOPNAuzz12GLY2/W84F0=;
 b=lnWaWdZVpeq3a0bbg/jY6N1MaUZhBuzosjl5q18qxAa2JgPOm9evkIMK7AqUhqG/9bvBON87/TQDuoZxLd067bG75wjJs1rsNARanBKlNzkTM4w75MnEqSRwccZcZXd5W13XFjpXdRiU11ABNWqeG6wl8n9W+apyFXtJCZjmGLYGuRdqYpRVlZ2jZR23agTXZZEoX34d3TW3/hU2dHY+PyxSov/pnpM1LE4h3LQkqwBAN7jrddPcGT/YPJ1uzPXZV19eZgX3HWh5wopS5X0JC/vMsmjCWbB+ZcB7K7uPs81PX1A7IjIVGK9jBORUsfjEAqDp39bCBMvrf/n8inzNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2/OoM1h/rNy7FLeAfycxRqcOPNAuzz12GLY2/W84F0=;
 b=vY84KgoonvXGtkxx19VB2Csb+OZrLXvTlOb4xAdyZ9hgBSmXPTVyrudUJC+ZLOFNmiKPKLwL3ZceZiNTRKu0iShtkFaYjVeWROEWfHu2W452P5TfDt8t58RO9tFPhn+Vz0+/V6H+hxAUael8bedAthuPWaeWwqgtSPsw4FzUDb5Co4cp2FjSAE/5D+iGmP8nmg3wKgIpDFdoVrWZw7ptAXNtZ+kLJdOFXUxVF6mufpgCU5flsVJ2vaX+z4Q1sMEUdA0fObOicgDd+FfHQ34X3nQH3srRMCvgvotMFU8CNBFQoMyMhP4z8ZCaDRJcBvN8yY69YABm+4nOPXLfRt8wsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7489.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 14:57:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 14:57:13 +0000
Message-ID: <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
Date: Wed, 3 May 2023 16:57:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Question about a freeze under Xenomai 3.2.1
Content-Language: en-US
To: Julien Aube <julien.aube@smile.fr>, xenomai@lists.linux.dev
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0130.eurprd07.prod.outlook.com
 (2603:10a6:207:8::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0fc5b0-12c6-4083-5ef0-08db4be6addb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aPX9r8psDdBEMwvadt/Xd+5wgfDnX1cFwTcAFvsem3cyM8k4mWTXjyChTtQzWSytxpylf+mEyDeX//WpkiCOYmXSfb32x6YOCwtrKY0gLbAHmeHhKxz5E1Z4guagPEfNrlSjpTmeeoyps7/fHyCOdDeFDHUXNsGJWugrF6GYkqQHp3w+J1YC9yliCxqC93SoEpcxQKy/07InqMVcH3Dx4ZcILWrgN6qQxySE9NwsOu1HvbP+BSKH9P5zjcm6VmzkBwVQdhri0HM3MsKMFIvIY/IDfyp/qy+smf9om2AGMTHgTVWCYaL2STIF902CRROrm3xN+pfGyR3rgmNV4hLjwrsSyRQyqUXQnAAWE1eq6lguneQkaecwzkbVDhdi9G7c8bb2CqDjQjjlYMbnU+R+yFIi/y6NPogs3kEh2+7pfCR3NVz+5cnh8aDEplhteoIwe36vR4L4phUgtLByNWAYpgVYGISCZlIcjnegPgJRF7F+RgC3EldVxpWpssJaTu8CghbrWylpPB0XKAZhjrvnOOxSXXc/icr48P+YGmFKwPV1I52Gj8/EvdxZPaz0h+BxLFtzzqS59IEte0Zo2k4fYRuCXEqEh0wTxEZcEdYysuzrlBJZsM9emlQRmRrjtzrQVTnFKRzFEP0yC6QZ1vZuSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(36756003)(86362001)(31696002)(316002)(66946007)(66556008)(66476007)(6486002)(478600001)(2906002)(8676002)(41300700001)(44832011)(8936002)(82960400001)(2616005)(186003)(38100700002)(53546011)(6512007)(26005)(6506007)(5660300002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkVrdzRvWXBwSFRVOXR2VlpwZlYyaHU5QUF4eGo0RE1TakFPUUVUelhRbHY3?=
 =?utf-8?B?aWNUN0x3YlhtbHEya1BSSnFvLzVZejkvUkpDcGNVZzJrazVFSlF2VmlOQVc2?=
 =?utf-8?B?ckM0VWlJbTZPWlk2QWhuUlE5cG5PMUNVNGtNZWk3cFdla2F6cCtwUTk2YnlL?=
 =?utf-8?B?cTg4ci9aNG5lOHB1cmdWL25uUnhMeElQSVcyaHc4dStRVHZkKzFBYVRiN051?=
 =?utf-8?B?alhFeEZmSVJyaHo0NnY2Rkl2NXBLWUZBNW5ORXFnTTJRQWtpWGFGb3RvQXRj?=
 =?utf-8?B?MXU0YkUwaUFLK1dvQ2lOenV2eXkvUjdhWUM1UzA2cWdFZThmSDVVR0JwUlE4?=
 =?utf-8?B?NUtOWlFUb2VxSmQrTWtsMGJoZFNCTWNTUjd1ZHdzYTNrZnE2TEUvc3Y5SW16?=
 =?utf-8?B?dWdLNkJkcWpVRlJLZk16eTB4OVR6NmEzOVN5RHRsZ3k5L1ZhcmlBVk50UXJN?=
 =?utf-8?B?TCtvTFpzQmY2UmFCcGNPS3o3NVczdXhhNVlBU3B1SU5ocW5iRXpVREJxTjI4?=
 =?utf-8?B?MjlQcm9URUgxOHFrTjRMRlZzaDNDdTlkWTJYakduKy90ZThybnQ3OU1GcjM1?=
 =?utf-8?B?UHloMkZRWmJLSDlXMDhsUjNReThCaDNSaldBdkVJU3JoNE1oU0NjZUVCaXRI?=
 =?utf-8?B?RVBXUVBxQUdmUGx4KzBTWi94RDZHWXJ5YlE0L0JPaCtySHlSeFdxVUYyMndr?=
 =?utf-8?B?cTUrT3NkMi9MbUJ4SFVRektOV3NmUzNHQmJVeTc4VkQ2dmxKdUZKZ0pZTkpt?=
 =?utf-8?B?ajFWOGgwR1NVUkpOQ0hTYXR0U3lDVVA1dlNrTSsxNjNNdnY5NFZlY0tYcDc3?=
 =?utf-8?B?Njdzb2MvRWc1QU9VYjdwdldHejNENlVHZHhoTnA1MXRuR05NMk8xclZ6cVdF?=
 =?utf-8?B?QkJnVlA4TTFvRVVoKzd4TVdpcXNicTE1RHI0NnhJZUU0Y0lEbU5ucjRUVG9N?=
 =?utf-8?B?aVAzaFdZNlA1enlqZkFWVFladmZJRmRYbGRLVlBodldHUUVVRHQ3OGJxdDcr?=
 =?utf-8?B?RVd3NFRORlY4T2ZHMjhEaW1nd09WSkdXQUhkSW1ya3c0bitoRG5pVHZsMksy?=
 =?utf-8?B?andZZzJXcGZwOTJIeFk2OXJpbGVtTkRrMklHaWRWZzBJbXJpWjd4STlTVERR?=
 =?utf-8?B?Ym5hOUxKaU5UbWJMOE1rNUZmODZmNm1qWVZxNjN2dU9jRjFocnhOdWFHM2ZL?=
 =?utf-8?B?R3hheE9XQVFUSjBMMTdmaG5QZFpWemRwaWU2K3Uwc3NPMHNIT0JIQmRUbG4v?=
 =?utf-8?B?dDFNdHhHNU9idmNIWVprQ2NJU2VxcE4vS1VIK0N1aXkwQmhKTkF6d2FOdzdv?=
 =?utf-8?B?TXFOeFVSaWoxQ2J6blJWVk1kb29YNzlKZ09LWlJKSmg2UlVQd1huVDV4Kyta?=
 =?utf-8?B?Z0hoRmRLdVMrTEpCZ2VodjFNeWxYQnRFV0RTZmFhUzJFY1Q5N3RzTDlGTStT?=
 =?utf-8?B?dnNUWDJqSGl6d0MyRFlBRXY2TmQvUktlVitldVJkbEVvRlV2VlRPMXVsY0tV?=
 =?utf-8?B?WkxVelVuVGpveHlTRkFSZ0k0alc0RFRCejBCQVZnV0VqU3JXemRxaHM5Q2Js?=
 =?utf-8?B?eGkwSllPNkJDUVVzbW5RVU5iOWV5NTVWeEc5OVNkV2ZBa1VEdDdIRFZTd0ln?=
 =?utf-8?B?SUhRUGhGTmNVNTdndHRISEZ0MHBIMHE2dzZzaFU1UFh6SldYV1E2bkwrNDQ3?=
 =?utf-8?B?bUxESUdDWksyRlF5U2ZaeFo2T21hTjViVFB2VFdhNEdsaDhJQk5Ha1VQcy93?=
 =?utf-8?B?Y2VkaXF5UkdQUnEwZlJ2OUdTMlRuK3NDdXFHSlduS2hmK3g2ZXAxd0JSRmdE?=
 =?utf-8?B?aFBXS0g3elMxampZZGx3Ymd3c0htNHhNYXpuWENxUU5vVFB0NFVRN0VRK0Zt?=
 =?utf-8?B?OGx4cm5ER3ZhVVk1V3EwVVFxdVU1ZVRJc3BwSi84VzhBWVROSDBpMGtLci81?=
 =?utf-8?B?T3RIdkZEb1p1OEM3WXJMdUw1YWlkSzRvQWlDdThVbEtJUWdOaS9hbENMQ1Jx?=
 =?utf-8?B?cCtoTFhmK1IveEJFL0UzQmtuMmpvazF5YVM0QU1nUUw3bmorcXlSaVhOK1VI?=
 =?utf-8?B?eHdzYXNsZUhJMnZ4NXVBUUV0aTRqbTF1TzB1VTA2SXdOclpJN3JyL1pLcXNu?=
 =?utf-8?Q?VjCGmHO+Licz79Mv566aW7WSY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0fc5b0-12c6-4083-5ef0-08db4be6addb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 14:57:13.5657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qE7vnbuOyZB652Oc+ASPrQ9fA/fxazNcGveC1NL7mf9HARjld4x91dIkedqlQkJPa6k2C8qfK8rzAWpBVOIi8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7489

On 03.05.23 15:43, Julien Aube wrote:
> Hello,
> 
> 
> I'm currently porting an old code from Xenomai 2 to Xenomai 3/Dovetail.
> 
> I'm using kernel 5.10.177-dovetail1 as this is the latest version I
> could work with xenomai 3.2.1.

Well, 3.2.3 would also work with 5.15.y.

> The driver I'm porting makes heavy use of RTDM.
> 
> The platform is a Zynq 7030 (dual cortex-9).
> 
> I uses buildroot 2022.11 to build.
> 
> I hit a strange issue and ask for an advice before having to setup JTAG
> / opencd , as you may have seen
> the same issue before.
> 
> On the aforementioned platform , everything goes well as long as I do
> not enable SMP.
> If I do, what happens is that Ethernet's phy detection hangup forever :
> 
>> Registering platform device 'Fixed MDIO bus.0'. Parent at platform
>> device: 'Fixed MDIO bus.0': device_add
>> bus: 'platform': add device Fixed MDIO bus.0
>> device: 'fixed-0': device_add
>> bus: 'mdio_bus': add driver Micrel KS8737
>> [...]
>> bus: 'mdio_bus': add driver Microchip KSZ9477
>> bus: 'platform': add driver macb
>> bus: 'platform': driver_probe_device: matched device e000c000.ethernet
>> with driver macb
>> bus: 'platform': really_probe: probing driver macb with device
>> e000c000.ethernet
>> macb e000c000.ethernet: no pinctrl handle
>> device: 'e000c000.ethernet-ffffffff': device_add
> 
> If I disable SMP in the linux config kernel , here is what I have :
> 
>> Registering platform device 'Fixed MDIO bus.0'. Parent at platform
>> device: 'Fixed MDIO bus.0': device_add
>> bus: 'platform': add device Fixed MDIO bus.0
>> device: 'fixed-0': device_add
>> bus: 'mdio_bus': add driver Micrel KS8737
>> [...]
>> bus: 'mdio_bus': add driver Microchip KSZ9477
>> bus: 'platform': add driver macb
>> bus: 'platform': driver_probe_device: matched device e000c000.ethernet
>> with driver macb
>> bus: 'platform': really_probe: probing driver macb with device
>> e000c000.ethernet
>> macb e000c000.ethernet: no pinctrl handle
>> device: 'e000c000.ethernet-ffffffff': device_add
>> device: 'e000c000.ethernet-ffffffff:01': device_add
>> bus: 'mdio_bus': add device e000c000.ethernet-ffffffff:01
>> bus: 'mdio_bus': driver_probe_device: matched device
>> e000c000.ethernet-ffffffff:01 with driver Micrel KSZ9031 Gigabit PHY
>> bus: 'mdio_bus': really_probe: probing driver Micrel KSZ9031 Gigabit
>> PHY with device e000c000.ethernet-ffffffff:01
>> Micrel KSZ9031 Gigabit PHY e000c000.ethernet-ffffffff:01: no pinctrl
>> handle
>> driver: 'Micrel KSZ9031 Gigabit PHY': driver_bound: bound to device
>> 'e000c000.ethernet-ffffffff:01'
>> bus: 'mdio_bus': really_probe: bound device
>> e000c000.ethernet-ffffffff:01 to driver Micrel KSZ9031 Gigabit PHY
>> device: 'eth0': device_add
>> macb e000c000.ethernet eth0: Cadence GEM rev 0x00020118 at 0xe000c000
>> irq 24 (xx:xx:xx:xx:xx:xx)
> 
> Kernel command line is rather simple :
> 
>> console=ttyPS0,115200 earlyprintk root=/dev/nfs rw
> nfsroot=192.168.101.56:/home/rootfs/rootfs_2022,vers=4,tcp ip=dhcp
> 
> 
> => Is this something you already faced ?
> If not , do you have any insight on debugging method besides JTAG ?

First of all, can you reproduce the issue when disabling Xenomai? And
when also disabling dovetail? And when using the corresponding LTS
kernel as is?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


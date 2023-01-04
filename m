Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD411AD4A
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 16:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+9/onUAyO5Y2byaAKjqV9qxFg0tfZNAKVo9d6GfKoYDtTIxVCxxU3oT5Ph8ljYZggh8WU2Tk0QqfO8X5Qrajy2omX/v3A+gRXElyaC+Xik/5pNLReNNotLbwPgxnvMQHw0XUn/LrtYwXR+lxn1YGIhAZ+3bL+uKRaL5UHrwiI9tmGMU/Z6GGgP98INuTCD7C+KiElTB/HS72XbKCa+k8Mm4bxyHOKPEplCbK4JNw1ZzR6aj2rGWnlwGqRjawkCg++yeCHUtjxF+tuQmZWL+lT4dM6CE0hp1yX2qIaDyLynBppVbQUDuVs1/jjSUUIJQZFoXK521AyO+PsB7zuAQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI1dyNkrAEW92oDM9PIcfqSpC/xqhw0gaKYjBKc5Un8=;
 b=QnwzuqF52SXWSn+GHtJ+EYHo/ZbBOjVsyubwcCFpANzpm7Fb+Zb4pmZh8sNbrf1tq8slpwCM48QbKX9bOL5CRsTrvRvLkJXISmZuimzyiAHmE07fuSF816weMKqgT3LBB7964b/FwcOtK93mmQNHYwMvlcd7hImIsCTmO/48mKibXvWNGG1MyREksLow7YguwL0ff4MKlC8zagJZEk+Krh2Ow9e2V/eOM9G2o5DxVG4zK0zQdo2dTMCS3maQlCuanRJZWP+U98RZX/Gb/swdseqLaI+Go5Z13o8037I9C/T/Olo6CztM5WIh/JteMQ6aifeIX33GXdnaki+e+1JdCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jI1dyNkrAEW92oDM9PIcfqSpC/xqhw0gaKYjBKc5Un8=;
 b=phy05prbJpUf6I3kyDTQTq2h5h8MQ9kqq1EgvgpiO+hjNrEAOk5i2Vxi1tDZreJmJfdXrfscQp1bvuo2THb4eZi+G3tZlLhLsLQkJFy3ZRLaXF7mGpo0UJiCNfPWjy9xIR4aHUGdxZ9bouKVhFsHiuGV5L86wfh1UUf8JMiyeORpQ46q+lYLk+ukSEwWEXoJfB0989C9H4Z9g7NhmIJcqNGcbZCX+jadhJGGSdq4mwKc1Er+X/Y7hVpMS1PQgtW0CuF5S+Gf9Bhyp81OPO/ZmaCYmPe8pISuNliVya43JNyOqLf7M96/EHW0k6cHdDJZ8va2Eke4YiPcoGlXW6G5NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:25:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 16:25:41 +0000
Message-ID: <d53d4600-1bed-1c2f-4e63-e4bae00afbec@siemens.com>
Date: Wed, 4 Jan 2023 17:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [xenomai-images][PATCH 3/3] start-qemu: Start with read-writable
 rootfs
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1672845695.git.jan.kiszka@siemens.com>
 <18e4ca3b65ab3881493b4e6a8d019cd62fe5efc8.1672845695.git.jan.kiszka@siemens.com>
 <87d836c68358798cf64dfd1264974bd67cb6498b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <87d836c68358798cf64dfd1264974bd67cb6498b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3835:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b0ea62-80ab-4e03-abcc-08daee70526b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SXHG2IhcdbSomDi6dxXiAcPt5tmxe0usdfVeuZwH4Hi3AYORWaW/sIaMn8K1bEiL8scoLv2P1SdOYNeoRpfs+3JWC89sJKXyefa6LWBX0AUwK+s2er+QwIRIF1Tkl6Zcn1j8OYNrUcmlvyspZg+dzB+Ct46TEEkyblhK76Y6geMqKBh0whHNvJWrgt1zVeJtWQx9e9JkgU06h/XIGEjb9iqFofHBYIUnR9zJk85YxCpcL64derChXC3Xpkwr2PC/UMn6mSCGgiIY7w/iIadd3aHOwoAXvxST7UFESSiGCp1bXOqSVB5BLLlDqHNKhV0qYuHdMGiMy5M0vK1EKY2yfdvA3wqEblUz32/FKii1VVoP/Hu8Kvhwd/UjsM4K4BeP9Is0Gkl5wZKR/Scfjlo4SIiCESyUVUVuZto8t9IYxO2fBottRbaxm6bkofxxxbJ1FLfdYpEsUTZsN85mM5l4/9OwXpMBABE3MVagnD9gbteP69MxWNKJsw2iOKiojkmIEnJvvgnOnEgYICTnor3qx42qYjaZNmX2kWN4zUDCP9sdbzBELhm8ikffGog10xOGPXea0jK/haXy19s98gYFwJXf1dQO586rQ+sh969XzmNAw+77Kb76eINWCKqjWf5VEYxd2y5NuHkTKwXxs2+90Fhqn7sYYjkwNFAxVfPPNj8OwiouOVwQC6roC/hRW59Nvszao/0Nedhnxo2LcPbPvGcYdj/5iLMWSxtsKLntdCHutdGcrvn392zvE6EbVprzBitRBcBs8CmcBTAmMuMbPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199015)(83380400001)(2616005)(31696002)(86362001)(38100700002)(82960400001)(36756003)(66476007)(316002)(66899015)(2906002)(41300700001)(44832011)(66946007)(66556008)(8936002)(8676002)(53546011)(26005)(186003)(31686004)(6486002)(6512007)(478600001)(6666004)(84970400001)(5660300002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnZPcEQzSWxabVNRb0hGQVMxQ3o5a2xENTZtMVFRVGhHV2toRGQxZG4yN05P?=
 =?utf-8?B?eDlnc092dFllNENlWHNUZy9VVXFvOXNQaVVEVXNQUUppWU9TMlFPbFY1TVZj?=
 =?utf-8?B?NHcxbWdha1lhVjZhYnJPQ3JiNzhQTGwwSVdjeldoSG84cFZKT0wzSE9wRHQ5?=
 =?utf-8?B?ajFob1JkN0QvR1M2SjBZbk9vUDBmY3FtRmJKVnVIY1l1Rmtoa2hnNVVyTHVB?=
 =?utf-8?B?akU2UklkdTQ0VFk0MktsSlFYc1FSenhPUlJEWjY1ZmQ0QTA3c2pkSTFPV1Bo?=
 =?utf-8?B?dUpKZ0xhQUJ5OW42WkdWNzJFR1gvSXZ1cWNlaU5mbm15dGJZZFJGdWlGcVhS?=
 =?utf-8?B?UDNhQVdmSWFhZlZ1eVArMTZGQUpRZEVudGNzaGxwWWFsS21ER2FVdGFNaW8x?=
 =?utf-8?B?SXJaVndwdEhzdGl2ajdPYTV2YkhyRkhmOGpoMjFIejc1NDR0Si9zK3hhMzdP?=
 =?utf-8?B?N3p6aHNwK1lpV1J4cXNHdDk4TEk5SUphRDlQSHg3TEhqd3laTldNQlpHSFdt?=
 =?utf-8?B?bERIVGRsSXlWS3NicEV4Uis2amMwaW00M2JKeU5OYU5OOThqallvZWJHTEdt?=
 =?utf-8?B?U0Z2YnNFTHJJQzZtM3pCSXFodVplc2VTbktKZ01RNHdnN1g1THhyeG8zRjBr?=
 =?utf-8?B?Q0dFZEJqYURjWkhCRWNkZ3FpL0REMHFPbEJLQlZiUER5NHFtQU1LTmRuVFFo?=
 =?utf-8?B?MVkwcWwvUllrOEp2dzJBclBHVW9RNVlPM3Y1YUluRXg1MGYvWG9BbXVDdURP?=
 =?utf-8?B?RXJmTm9za3NseXpGWnFGM3JOVG52RU5xTzFua3dEMmgzSFFsVEtEbWNyK1l5?=
 =?utf-8?B?T3hoaENndjBtd0tYSExvR2l0Q2Ric1BhakFEbjFPOWF1aUJXUFBHTjNoRHNG?=
 =?utf-8?B?YlZiYXpZMU5QT1daTUVvek1WaGNKb1Y5MG1ZWEF6bmZOcHRGSzRKTXlWaGcw?=
 =?utf-8?B?YUJDTm5vWmxFWnhmWUl0ek5jWVFRKzMvZ1pseldzUzJoSld1Yk1xRWZ0TTdR?=
 =?utf-8?B?dXVGTnY2RjJoWHJ0TFVaMEhCa1BMR21QWGZndVRTWC9kWjkyd1dQYmwvdDU1?=
 =?utf-8?B?d1Y2QXZZS2piTHNxQldodVZtVVRHUU1rbVdzcDlRaU8vRTJieGgwVGNwa2dx?=
 =?utf-8?B?NWxmSVMzVTBkeUZSMEVuRGIwOUJ0WnBuSm84d0xXRmtLdlNkYmxvUnlIVzZK?=
 =?utf-8?B?TDBkb3EzRXhLM1NnandyY3pHeVkrMWVkWk9NbHAyWDAvd2xQWTFmY2NmY1pn?=
 =?utf-8?B?SWdhYnNvWmVNdE5neHhvanJTUkllZFVOOTRmT2hJdTUwR0VNK0txZSt1RytY?=
 =?utf-8?B?N1diejlIYll4QXZOQ0hUZHNwSUEzdHNNaUhvdlpwMk54NGMxRTVvTFhVVWpN?=
 =?utf-8?B?R3M2ZVRIam9WR2Z4MmxHcUdFTFREdlVNNWRCRXZyVXQ5anMvRWNrN2Exb0N6?=
 =?utf-8?B?ZjlNVG9xNVdBbHBMTlJ0VFFYdGZxcGRla0lUWFVaTjNHd0sxeS9EbTdQcDI0?=
 =?utf-8?B?QnZHbzRXUnB4czZKTXNaMzNIM1RXSVZBYWEwWjRzTkFXcEozSFlBaUxXVnVY?=
 =?utf-8?B?elVUN2I3RDFWbFI3UzVraDdkcE11WlBSZWtxaW9aY1FwaFpmbERKNjZuSTJ4?=
 =?utf-8?B?MmxWK3ZLZkFGZzZrRFZzbkN5Q1p5Q1Y3MzhMOUgydlVLRUQ4YmZqNWVESEZH?=
 =?utf-8?B?bXdIUkp5L3VGTWtUNXdqdUo4WUU2NWQ3U2FhN0FVTUxNVkcrSTZIckROcHdQ?=
 =?utf-8?B?eHU4eUJWZTcxczRwRFRESllTdXU3SmNpK3VUS2oveDFXMjZ6SUk1WFp6QTIx?=
 =?utf-8?B?ZG1xc0VneXJzRnRoR3lPaHlpY0lVaGJvN3JVQVBTRDZVT3Bremd5VDJWRVZG?=
 =?utf-8?B?Qi84MGt1dHBiZC8xcmZRcE5rM0FZcStxbnNTSnRwWHNsNnFKWTZqWFpROUY0?=
 =?utf-8?B?Z1g5YjNVZDdXK3RpbUhjWnBjUEdUa3lUdnErU2lzSzZNemwwMGZVMlBIR1NC?=
 =?utf-8?B?djhuSFB6TEFrb1pUbUF0bUNHRXF5R0pOczRzbUp4cThIaHZpeHNmbmhTeDlq?=
 =?utf-8?B?WFgrUzRYMUpJOFREc3RRaUFHekxxVjBwTUxJT3JWZzl4eHFTdFJSb1FSTTV1?=
 =?utf-8?B?VXFBSC9MNlJxVkVpZGZNTzRGKzVFaEZuTHFpcWY4c3F3MFVRbE03SkhCRmJE?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b0ea62-80ab-4e03-abcc-08daee70526b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:25:41.4444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nuYUF/Ig4tYG+9q1TcWYTtaJ+66SQ+CWal4IAUL+bTL5Hs2dxboi81G6wQ8mEYRfxDGhLsvzPk4KZw/ogp1pyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3835

On 04.01.23 16:57, Florian Bezdeka wrote:
> On Wed, 2023-01-04 at 16:21 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This is needed by systemd to initialize the machine ID on first boot.
> 
> I'm not facing any problem regarding the machine-ID here, but the LAVA
> tests are failing like this:
> 

I got

Welcome to Debian GNU/Linux 11 (bullseye)!

[   12.650423] systemd[1]: Set hostname to <demo>.
[   12.651334] systemd[1]: System cannot boot: Missing /etc/machine-id and /etc is mounted read-only.
[   12.651709] systemd[1]: Booting up is supported only when:
[   12.651992] systemd[1]: 1) /etc/machine-id exists and is populated.
[   12.652296] systemd[1]: 2) /etc/machine-id exists and is empty.
[   12.652595] systemd[1]: 3) /etc/machine-id is missing and /etc is writable.
[   21.224091] systemd[1]: Invalid unit wpa_supplicant-nl80211@.service symlink multi-user.target.wants/wpa_supplicant-nl80211@.service.
[   21.224776] systemd[1]: Invalid unit wpa_supplicant-wired@.service symlink multi-user.target.wants/wpa_supplicant-wired@.service.
[   21.226480] systemd[1]: Invalid unit wpa_supplicant@.service symlink multi-user.target.wants/wpa_supplicant@.service.
[   21.228235] systemd[1]: Failed to populate /etc with preset unit settings, ignoring: Read-only file system

with a qemu-arm image before this change.

> 2023-01-04T15:10:03 [?2004lmkdir: cannot create directory ‘/lava-6952’: Read-only file system
> 
> So, in addition to the qemu-script we might have to update the job
> templates for the qemu tests as well.
> 
> I already added "rw" to the qemu kernel cmdline in my local branch, but
> I updated to Debian 12 here and up to now was sure that this is
> something Debian 12 specific. I have no glue what changed in the test
> setup / LAVA installation that "rw" is necessary now. Any ideas?

That's more a question for Quirin, I do not even know when that mkdir 
comes from.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


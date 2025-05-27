Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFB1BD9D0
	for <xenomai@lists.linux.dev>; Tue, 27 May 2025 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330027; cv=fail; b=G/GbWLJdi2zuLbaqpFC5B7VR/oyV9lWDEHBLspesvRohnL1+rXg/oIr/hKW4icT+/068aSpw7m5dCozHHci6b8IeNDmYNJPQr6iM3r+vtdRN03NU4Afy7cLECv7ImvRZygAkQnYiCh+MbJIbfSXw3lO6T2qF4oSPW8D3EvisVts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330027; c=relaxed/simple;
	bh=FPkKULtGsoN3hUoJjvWshOD1PSpGJExiWrZV5f41DWs=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=UTLEE+/ofWRssV+aIA+jXExxKksUklL+7yyYe0QdJ+frwpX3pnbaeB6vBi3+K481UR9xSWymlyfBq55vLB9Tjdqd6DNRKxSp0J8ffrRaotdkg83+/bOVQ7guLGz7YpEJok7tCIEHehHLVJYQo9+TqixcoGS1nwuszGtar9CvtNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QAYIdhms; arc=fail smtp.client-ip=40.107.241.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QAYIdhms"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQmQqM6tkcxm11u2WeUY2C4a+5zPf0ZjwKQRBILw+YCOHmEuoX9fnlMYalGdlBSHju8IqAZMDmCsHP2ENJ0OriDWUD7dt/EUryOP/mf0g1lerQ4l68jUrsH+2XQ/aeB1DJiOjd06DuxmDpUuR7wxxyQWGTYBLL7PusSR5IoodSLNrdkPUYIegwaB38Mg2IIjkvFRf/rNC6hI1OnrX3cwFphKTKHhp4eGqYOZK9KqS2w5d9DLH3jnXo/DskHLuU62DcKKGHh9R3R/UwpaxDLVDwuqbBoQjo7SSXCasPqol10R/Z294xU8C6LVaAHgUusH266VMFRb0CDhcxZEPPeadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtZjM+rXsyjsRgTpDm2LSmTEWSxaG14G1mIpM+5rLK4=;
 b=opA2+E9x1nus1YVw8RgiykuXnfdz1ZghmEY+7xfOEOok/MClBpeiN6njVfzURQX8W5nOz1Z3dQc8LD5xzOpOwrQ9S2oHlKNzocKfyQnaItXBk3q7A8UKeF0TxjeiJQcQWNDD5HBoC2+rdGXFLmpkGduJyRqQn729RT0xW2hD3LRYSa0DRJGnDoVnLyemoG7Or8GSuHPsO21/bqgSTwCcUyzE58r2ffvh84q4AktT8Zhz/9dRtzZqifjBgyUa77B//qAMFI0DwwrkWc4gzqFsgkFJKRH9qaxl6i9Wtt7V1PE2ZiFnWUh9gvnt52WeWjNozR+4+8crFi3o5E3agLZx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtZjM+rXsyjsRgTpDm2LSmTEWSxaG14G1mIpM+5rLK4=;
 b=QAYIdhmsTeTCO5350EmfCP8Lj9A3hNCUsFyy821vHAloI+aLJJ8H+ijt2Uso1Au/8J3ouuk+ZHEXTJw8MBHoKmeDavE4RKtzpcL2VNmYTVoUswDz1oh06GMazJwFxkjtzQvFxpwBGsRFYzEbL7xJMFL/dc/Ot0E6BXIHmxsYwEwHbF3gG1N0NMSx3NSXg+pd8AmJ0xwouPLNx/D9Q0PoGjsyPd33cOrp04wQSPpAPDIkAFQhHZNiawmn9my/zBYutaqRVj/Hh4+Op51RSjk3Z/hDN1MkPGPY8NrXTFCBw+uBF2LZiA6Ng/IQAOb+V4kD0mJ/atvt4fgWYa5AkOBbbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6979.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:417::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 07:13:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 07:13:40 +0000
Message-ID: <8f519aa0-871a-4698-9905-4434604a7f3c@siemens.com>
Date: Tue, 27 May 2025 09:13:39 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] cobalt/posix/clock: Allow NULL resolution on clock_getres64
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 chensong <chensong@tj.kylinos.cn>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0390.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae3999d-e341-42cb-0481-08dd9cee01bc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2VlN1hQWHkreUZzZG1QSEU1SHdLMHVvZkV6NXkzU1ZPQjBLd3M0SmZUWUNN?=
 =?utf-8?B?UzI5cGN0K3lQRTVnZE5wVDNuQ3FIY05PcUZFQ09RZVJQVXAvc2c2OHQxdjVP?=
 =?utf-8?B?cU1FdUp5TlBQa1RUdmluV1pia083ZnhEZGtDQkhoODY4SlVGdUtpNTFRV3Bo?=
 =?utf-8?B?dG9WQjB3QSs5dU9VRmYvWXZxRFJ4ejJjR25CbHlLUmFCcG4rODNvR1dZS01P?=
 =?utf-8?B?TWJocUUxK254QUI1WStYeXYxek1XL1pHTTZTOGJHUWFQai9nOEEzNjBVNklL?=
 =?utf-8?B?U3dBMFdGdFB6WFp2MzBUbHExUnEyYnZ1Mko1VjJSNWxrL0M3aGRiejdOSzJY?=
 =?utf-8?B?U0RPcDM5RDVSMWlHdHpGQ2xubFMrRmhFMWJzcUNINGhKZWlkUkNaTk1qbzNu?=
 =?utf-8?B?NTcxVVJiUklSeDZDUXc4alp2aFlHWUFWMUM1RDV2L244MGhoY0RmMjV1RThu?=
 =?utf-8?B?NmJheXdnWU9ITmVOUmg0cWhNK2xTdS8raCtKRThVNm9MTTZSQXFJZkQzZlh2?=
 =?utf-8?B?a2tjMnpNTFFhekhISmF5NXEzWmQ4YzBOc1pOeXQ5OVNLdXVYRkV2TE1lMzNq?=
 =?utf-8?B?OXpCRVgrRUZaZ09VVU9aVkE2NENQUmRBSzFXYTVtM3hrbjNOT1MwekQvZkhB?=
 =?utf-8?B?UzBzWXY5M2FBYjhwTnM5NU9pV2NudElqU2VCSk16TTVLQnh5TlJWcjNsSVZj?=
 =?utf-8?B?d3A5Q1NSK0gzc0x1TlA2NDZFOVdlKzFyeVBHcm9sUDlOeFNsSkc5NVlEa0VD?=
 =?utf-8?B?R1F3Zy9IYnVKL0wyNzZZQXg5VElrQ0ZYOFNUNUtkVmNIK2JjRVhtbVVidGt6?=
 =?utf-8?B?YXdiMGxweTRoL3lkNjVmbHgyUlAvU0ZwOSszTThQR1c4SlRkVC93WGhmajRM?=
 =?utf-8?B?bWorQjZCT2xYTE4zTmlyQlNOWlQ0OU5XcEtXZXA1MWg1YUFMWmhlcHd0Zlpt?=
 =?utf-8?B?dEc5eTNtaENjcFRkaVEzQ1dkMUpnRzROaVZ4TnlxTXA3d0pQZGdmL0N3TXVO?=
 =?utf-8?B?MDZzbFVUaTVKWEVQUmxtTDVPV2RVb2NpWXFobGd0dFJ2MEVkU2kzY0JLSmsv?=
 =?utf-8?B?OXdtMzk0SVZJdnVUTTVLRzVOb24rV29BT0ZnTkl4R2tVVHdjYTFKVGVGMmpN?=
 =?utf-8?B?VjFBQ0FQUXpFeUdHcDFPeEFML2VXYnhIWGNUdU5IUE1PSXBtTHJrbjJOc1c5?=
 =?utf-8?B?aCs2eWJFSnAyZmFaV1NnU1BzNmYxcGFLQ0hISTRySk9xUmU1R0pxK2xCdWIx?=
 =?utf-8?B?Yzl5SldacWVVQVYvU01CSkx1TFBKOVJYcjkvVVRlYXZWNHRFbWFybEtjTzU0?=
 =?utf-8?B?MDB0MGJZTTRXSnpHeTJTRXdBNThsMTZiYlZwNzJzNTRIRTdoL1ExbXN5TTNy?=
 =?utf-8?B?aHRxYmM5MUNqNUhSTk9NUi9PNzZ6R21YZ1V0Y09IZWN4Mk5uZ3QxK1A3YVJu?=
 =?utf-8?B?UUpmREgySVg2Z1FYakI0RFJmL2dSenpNRnJxejZ4ZGtqY3BPTVVRUVZoM0xh?=
 =?utf-8?B?TVpzSFhlanpyMnlvVkdBMWdHZUtCMEZnRUJ5QTVtN2NvN0lodW0yNDZ6NGFO?=
 =?utf-8?B?eVpNMDRnNk1NMUtoK1ZvMmQ0MCtEbjdhNXdwaW5XNWxWZHhXSjVMK1NidFRR?=
 =?utf-8?B?ZDJmUXhhMUpNRXlmSlVRdUY3SERRVGVSWmxEU2pGWERiYjhhakRvZjZoWHpm?=
 =?utf-8?B?eDExc2poeVU1YkczU2FsMHVwenI1NmE0SmxidVE4L2dlSThYeHhnTW1TR09G?=
 =?utf-8?B?YUhLRFhjeTQ1SUVPQ2ZaOVFxWHFEeHdwQWtWZExSNFVDT3orclN2ZzVtc0dY?=
 =?utf-8?B?MmRIWHFwN1ppeE9MbjV3QzhqY1dic3A5K2taejN1bDVFSFpINWdYczFhSndZ?=
 =?utf-8?B?QWtSRlJZUkNwZ2gvaURPK2pmellTMENpM3lTa29yeFdSZE9oc1BzVTZ4cFd6?=
 =?utf-8?Q?UzxnzmTtOUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0NHMUJaK3dIWlRzWGl4Skc1MVl6K2c0R1IzSUdjZjRPWWI2dmlKdFJ5bmhv?=
 =?utf-8?B?MW02L051ZDJnb2NVRExFMDlRMEJRdEllYzhvS2NNMkUxOEN6QTBXMVdYVm4x?=
 =?utf-8?B?cFc2YXhJSUNZUmt0VUNWUzZ3NjRRK1JXTTRkSFVNWElqLzgxVG5ScWk4NmJo?=
 =?utf-8?B?K1N2R09oVFhlVnhNdUQ4QThGeGlCSTlmZStuSm1HV0dQamJsODZoRnRVUTNs?=
 =?utf-8?B?YUhKS2hPMHhidjdHNHNsL3BpdEkrY3VrTVV1YkdpM1BRaVlzRG1iS0pMZ1FV?=
 =?utf-8?B?Uy84clRpdUd3YzJ2cmt1MXZ2YkpqNFhRb0xFUEtMOWI0ajc1SnBEbXd5TjBT?=
 =?utf-8?B?U1Rpek1hWXdhWEJHMW91ODZ0cGFYMExRM2VQbmZjVVdqS1Z4M3BwOTNHbVBW?=
 =?utf-8?B?czAvL2tZSXQ0ZlNTVE53UVA5RlFFSDZaWXlaV012ZXpHMGZaMHNxWWE3T2xp?=
 =?utf-8?B?M0xab2M4MDJWZjhLaE9YSXZFMHRseDE1MkRvSzJjSFpwa1JpVzZ5bmpXUVEx?=
 =?utf-8?B?SzNGcFZjeTVMMG1TR3N2cUpCZjcrOVp0MnJGQnh6aUsvempzdUhwUExyVU4v?=
 =?utf-8?B?QnFpRDE0TGZTQzl3dVc4RmF5WDIvQTVOQjVqS2V2azJOejZGcUkrVlk4OVF6?=
 =?utf-8?B?SjZyQ0grakRLWFlQR2pKREVzR0F1RHRwK3dudXdMMjhrUUUvaC9uQk52ekda?=
 =?utf-8?B?c1JMeW03djBUNHBiTys3RnlZcTJCL2lBOWhwT3hFLythd2Q3SmVuQjYxanhG?=
 =?utf-8?B?OFRjVFUrOU5ldFROeHIxWW9jY1VrV2ZpZzFrbytIeFREUkNjZ20vc3J3VGl1?=
 =?utf-8?B?NlBycXRvcmhrNm50T1dJZFZ5b0MvRDlxV2h0RHV6NGdHZEN2cFRFS2xQSnk2?=
 =?utf-8?B?djhWOGR0d3MvdXIvUlRNaUNQWFNSVHhSdTBGTjJVV1prZ3ZYU0ZxUFQyWnNG?=
 =?utf-8?B?Y0VONXR5blhoL3BkVkhocHBpei9mUVIvNkFSYjR0ZHdJT25ZMHI1VHNNdTNr?=
 =?utf-8?B?TkxaYlRlVWlncUJwRnMxUXhiS08rcjJuOWtCOU9naVZDWVJYb2lBM3ZkakRo?=
 =?utf-8?B?MWZOYi8rb1l6bGhjWmpBWnZrdkJDS3VJbHcrblJHSWJEZnNLQi9kVDhhaWRr?=
 =?utf-8?B?QUNEd21vTzNEbE9sQml3ZFFkOUY4OVQ4eWtPeWlrWlphN0d5MGdmWHU0bGlB?=
 =?utf-8?B?dmJFczZPckxjeGJtT2p2NzFmUEFZUjgyK0tVOElUODlOL0haOGJyVFo5bCtn?=
 =?utf-8?B?MkxIWjNoYk96cXp4ZVNQY0FIVlZyV09RNUNldk1STS9NeUNyV1pRNDB6U2VK?=
 =?utf-8?B?enpWamIzSFFheCtRUWpYdUhxOUxPK0J0MVlRaVhWVmhFc2p4dWptSFpxWFUx?=
 =?utf-8?B?MlFMVWJFNEZEQk9lWnh6YkZucE5PRi9zbVUwcHZId25xbHFSSS9EQ1Fqc2Z3?=
 =?utf-8?B?Vk11V1pvNjNKYTRCM2tvUWJqUlF2VlBTWXRHSDlQRWFVcHAwYjJIQmg4ckdZ?=
 =?utf-8?B?UFJkYnUrem0yaGdmR0duSFVlZyttbGNiSjFsQkM2aEJNbERDdk03cDVWQ0hk?=
 =?utf-8?B?NzliSkx1VURmS2V5aTRyZVYwa1FHa2VBUC84b0lBbXprd2dCOXI1Zy9aYXFq?=
 =?utf-8?B?RC9IbFdDU0NLdldDVVJLaGhSOVRDbVRnVTI4MDdrZFhmdnlPMlZWYUJ0ODFo?=
 =?utf-8?B?R0RyWU9RdDZGRE1lM2hhOFNwcDdUWm9GSG1xTzVoNk9VTE94YjZsdFdzczBQ?=
 =?utf-8?B?WUF2SW04S2loT3gwVWhTb25Ya01zcW1EZXpLQjJPdHlyTVhEWEVZSkVqek54?=
 =?utf-8?B?aUE2cXJLdk9xWGdWNS9NaTZFRFY2azVqbm9RMGV1QWlDMVRtLyttUURqR3JV?=
 =?utf-8?B?ODBIRXlDSC9uamJkcW9OSFRpc3RYeHRGZXNFY1o5NG85K1gxY2tiK0hXUmFr?=
 =?utf-8?B?czdmREl6TW1oQ2hYSVlOZjJXeWxWUUxqeW1KQy9kMDl2SWVGRkdiTVZRQTNu?=
 =?utf-8?B?RnRNT1dCMmJtQXVEdTlXa2U2ZDZaQ2YzUFMrVWFCZU15NkJXUlJmOTJGYW83?=
 =?utf-8?B?elVXbXFiQVQxVmVjYXFZNlBNaVdjV2E5WDJMREpjTVV1SldCQkhVd25OeUND?=
 =?utf-8?B?MlROOEo5R3ZwTEdaWUl6VFVCL1VTbWtZRTNuVVhOTDNZYWlZOVNERzZJMkR3?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae3999d-e341-42cb-0481-08dd9cee01bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 07:13:40.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAviWo0Jteg7AfMs1D5gIZ4H7Lrc4QyBZXJQtrKSllCnKDWrXWtuVq87SRRy7hoD9t3qIKj/ZAwoPdP70zaJ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6979

From: Jan Kiszka <jan.kiszka@siemens.com>

Permitted according to POSIX spec.

Fixes: 633022801750 ("y2038: cobalt/posix/clock: Adding clock_getres64")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
index 845918a4a1..e6c187ca40 100644
--- a/kernel/cobalt/posix/clock.c
+++ b/kernel/cobalt/posix/clock.c
@@ -103,7 +103,7 @@ COBALT_SYSCALL(clock_getres64, current,
 	if (ret)
 		return ret;
 
-	if (cobalt_put_timespec64(&ts, u_ts))
+	if (u_ts && cobalt_put_timespec64(&ts, u_ts))
 		return -EFAULT;
 
 	trace_cobalt_clock_getres(clock_id, &ts);
-- 
2.43.0

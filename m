Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678F3214
	for <xenomai@lists.linux.dev>; Mon, 28 Nov 2022 12:27:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2yQPs1uiimELrEGem0Lxe4xws8ChydsDE0WHj2NFTxYdgL3XJ3Ua+BMBXLax4Rf3hy2ZwqVmkP4JBeI4g9zC4braJ76j784zjJSVyq5MQQmIACJF72RYUNobiqwZk39w0BObWqvkRY5VR5gEAcN3aREWMPHY3kOZ7RLHB1FxHgk6O4020XBObEl9RmN5AnZcCwDqE/seVD+veRV3O5IRbQez1UgNgulpDTqIGO6lxP43UxpVpFwDpAgJxURq2aF6U4vQ9L2e07kp+vVzwbfR5yLtixAwzFeiB+BsCypD3USwlWPzhdVak6EiuxTXXjTofniK0477jWzvQyStgMG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLoU7qqoBE0pcyQagxmCkpDgDSA5MOsiT4BJVjKYgXk=;
 b=HKFH5SvB6im37/AoL3wvjJ5FNMs80D2EVLix2qU6xXJ0h6yqd4seA+at2bGzdDSIdlLOPYHpjfB271OuI5zcyZDq1geRavxHD3AmY8bw0ctIA2zz9gThyx/YlinC6x1OQ3UOeE/MbpoeFAaPSM7gS1svdK6CU3LPHT9He1jcJHYqPWP0vPSpjVe9ENgY84Uu8L0NblwPEkWE933QcMEODRM7O8VDJ2U165ONNNN/DZ+q9u5na1HCtH97Y428nEaT+AATvZVSs/rS3kw85YnniN1VwPSmD5hFVbsqb6oyIQW6BVuYqEWNwlU8/Jvm1NrZIfYu8Du4KsqHSlah7WEOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLoU7qqoBE0pcyQagxmCkpDgDSA5MOsiT4BJVjKYgXk=;
 b=c3MdyclM/ZEawLQ8F/w3C+41uaZzfbq+D61MmAk6tfclpctKkP6AtTlIB9mdE5NED3/AKvOqrTa2vyUEp5HFoXFQ9wLEpmjN29dev1nHPJRCxOmuGWkWwVfYHzwwfeUYozssjhofox5Iu6fTKcOQmMisyzZDdqxuFmg6YJu9gyv7oNzdJjpxLEahZc1H0Qdvz2asTqiFAilTEcB9UDRjU32/DlUQauSwHaUUHKd5xInNxaZJulycJwq8EDm++mTJvF524fza1ifbVzvizLJBU+i1UM5K8W95q6/YeYC/EXxGxrCRgwtAvm5lUXMtNvKjmowT3QUhUAMRqdZ/3Vqo9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS8PR10MB7757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:630::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Mon, 28 Nov
 2022 12:27:04 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::13db:8a1:709a:4671%6]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 12:27:04 +0000
Message-ID: <22b5656a-ce6a-0b51-87a0-1cf0e6e4a283@siemens.com>
Date: Mon, 28 Nov 2022 13:27:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [ipipe 4.19 5.4][PATCH] ipipe: Fix handling of level triggered
 IRQs
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Greg Gallagher <greg@embeddedgreg.com>, Gunter Grau <gunter.grau@philips.com>
References: <20221128120908.1136136-1-florian.bezdeka@siemens.com>
Content-Language: en-US
From: Florian Bezdeka <florian.bezdeka@siemens.com>
In-Reply-To: <20221128120908.1136136-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|AS8PR10MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 307d2d63-e3e5-45db-b55d-08dad13bdbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vt3/LKa55GH1932Ta5oF7MWx3j2AZlnQL8wWrbG1f9EDpQ+Juqhaz8G7N4qDQuDjzK2XeoXSGaeu0xz2EbtpHJeRPLzlE+lZbGjnEJP3Adn2DQ1ho2FA0diXGJP3XZcEAsKnBCLhHCud0TqaAxn4aYQJPbTDdpbxV0yDcuC10WnyR5Osxlps7B/Y44YJ8GR2iDSL0l6XsKLR/W2nGlerB9hTxL1jSDzcOdU0ZRufDZZu0WTXsqjcM7rubQgqQO+8rLU4mE2GWeu47M4QTl23M4+HavJWWrS2sOcpttDSB8bV0AqCb0l2mIN6hx1vIEzRt0bjxYogJ1Fr+eiwoPMwuEMTUtdhEwnAtD12DK5VboV2+7fPZyloSMmXLNLi0Orq0/xJO3ywykzi1Mu0xk6BvFdgjv+a5da60urYflW/3nIMSDN+GbieRi2MZP+ZOh1EtvtTu89OndphsjnOsP+d7YAU/XcFpenVjxV8kHOmRblY/9dQozDpFsFqjl83/8uudpQa997+NN44lSUaFUq9V4ZMdBkR2ghiB3/l2Sa8eBI+zLqDBBh/+8hGa3r3Z3NLYqSQCvTUlCDQotXlXCO2fChQUppAp3M4udX57PvcUd+ByIZj37Ds4WOOg/tLjevcssFCETBi9OZzG8Wk7ZFW9lmv117cgAMApohsc/GAoY9WEnYlaN2uaI8bUttip/NLMHNSlf8+4EnzJg6adr/PWNjd21qfXZOWvN/U6i5ZsO8SiGxpDr1aYugBWFqYggvi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(36756003)(66899015)(31686004)(316002)(6512007)(31696002)(8936002)(2616005)(66476007)(8676002)(82960400001)(4326008)(6506007)(66556008)(41300700001)(86362001)(66946007)(54906003)(2906002)(186003)(6916009)(966005)(83380400001)(38100700002)(44832011)(6486002)(478600001)(5660300002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TldydlZGMUhiSHdjQ1Y4VlM3eExFUy9RSTJjd3BZN1MrbVR6MHdJOGN4UHFt?=
 =?utf-8?B?dmNEQVFXbzhkRzJSMWx2NjYxUWFxMThkSXJBWU1XdUNXR3NsK1poL0ZRR1Jl?=
 =?utf-8?B?bm5kZHUzZXV0dkFncXVCQW9SbTBiMXRXbitaZ0JTODQxMTdkMTdHV3p2dEIy?=
 =?utf-8?B?Y1ordVl6RDJ4YzJsd0FZd2RCWTFZVk5FcVVWMnJ5UlBkdU5ybjlxRG5oaXFs?=
 =?utf-8?B?Uy9OMWVka00yTFJ6MDJuV0tNZlNveG5aUkgrNjlDSWlKSnZpcnk0UTBsSnly?=
 =?utf-8?B?dkZWT29BZGY3MW1Vc0U1WFpBQXNkWGRLQVRoK0VTVHNYbm8wMGg1bU5LR0h4?=
 =?utf-8?B?TVgvbFZqVHJhdC9JNU9vYkRNT3NidUZQNXRrU3BXNzdpaDNjQlpHUXViUmNp?=
 =?utf-8?B?WkdlNjVtbUpFN29EcDA2cngzY0dkUUs2ZEQyK2hNYjl3YlRsdy9FbE10dTJ3?=
 =?utf-8?B?MTBWRjJ5c3kwc0ZPOENUekdXY2NQcXBPZXNSUCtNYlV3RURvcG1jclkzZjcy?=
 =?utf-8?B?bnpWR21oQWVJSVZLUVZXWkNCWXRtNWRRTmQxc09LTTVKR25iSVE3N3MycnJp?=
 =?utf-8?B?R0k3SGFCdFVOWVdPT1piWGlGbFFhNEIxdTJjYXd2cmgzRktlcURUVzhEZ3NY?=
 =?utf-8?B?YmZCSnB0MlFtdTFZV2ZBU1B2MHpac1RkbGg3VVlqSVdQM1FEWm90dFQ1alZC?=
 =?utf-8?B?SUlQZnRxUGQyMXV2MEc3ZVNLblQvQjRQRnJQVFp1SDFsaXJmdVlpWEd5T2c4?=
 =?utf-8?B?S0ZTSmwwYlIyVHZxOGpxUGJYR3BRTkRSRHpWN0luNTB0cnlPQitEa0dpVTJI?=
 =?utf-8?B?RjNWamFuSktvK3pzTytHZlRqZU94RXJmZGN6djljL2plWXN4M1hGK09vS3Ru?=
 =?utf-8?B?STBDaTllT3FzNzJMdW1GS3dVUU5pR3Jyb3VyQ2llOUIxZFJ0MTFGNHNKZkR3?=
 =?utf-8?B?RjRXNHVGNTBtdzNmNUFyMzFnbExBekJwYjBFZ1lsZG9GLzhFeU5oRDhucFVK?=
 =?utf-8?B?dzVBekdmbDVERVhtWmk3ZkFoOTVjTlA0SW9YM0RoUHJuaGlKc095WFVLY2x3?=
 =?utf-8?B?dHFsZXdlUUhlQ3RmcExxUCsyNVBGLzVIMDNwODVscXl5Q1YrWGhjWTR6NGZL?=
 =?utf-8?B?aTFVUmRxVVluSHpYQVM5bVdYNWJWUmFhMFNBUXVrdHd1a3FGU0tVSW1RL3l6?=
 =?utf-8?B?VXRVK0ovU0dzcGIrYVFiYmkxRW5wY0IrZTc2U3J2Sjg0b1FWMXhEbFJQNnYr?=
 =?utf-8?B?V251cHZSR1FlTUtVSURodURTRk90KzdLbks5M0NYRE9BclB5WUd1NGdLL0dk?=
 =?utf-8?B?YkduNzVhM1RIakU5dkxndWZMVk1ZOUVoZVorcXA3V3BsK09iTGhQVnFnRmFD?=
 =?utf-8?B?ZWlTNGQ5aUJDNldGNmZmWndFNHQ2SVF6UUp2UG9PUWRZRFBOL1p1eXBBL3N4?=
 =?utf-8?B?K2pwTzZHcEZwYUx3TnhTSGVWMVFHMnR1NnhRd3BFZHN0MXE1T1lCbTBmWDkx?=
 =?utf-8?B?Uk1xRmY5blRZamdkZyttVWUvQVV2a2pTV0tIS3lmYkNZSVgxMitWcDFQRW9S?=
 =?utf-8?B?WjZ2Y0s5R3pwSTdtaXpJQUc5TjZqb29GQThIZ3NUajdzUUYvZ1czMGFmV3pv?=
 =?utf-8?B?WnhGYitTZE9XSFVPV1dqcHNaYng5NXZpcFlCMWFzdCtCWCtRZkJsZUlIa3lF?=
 =?utf-8?B?bUVsWjBwaHNUWWdRWHI3UmlXY3pFOFVXNWY3RnZ0YjVUUnVQZmdDUmt6VUdX?=
 =?utf-8?B?SHBUKzkyYjVHWitWcVNGL01zOWZFUVJiNnlzNk9KcWhQRGhNYlMyK1k5a2Nz?=
 =?utf-8?B?WEVmYlZIT2JWUlBqVGhpOGMwQ2NpY05WUURMN005TjZjdm9hSkJmUTFrYVd1?=
 =?utf-8?B?aVVHblZMNldkWTlxbThRcHdXa2N1ZU92TlNVaWFyVnRZYmlFUHQxOUQ1dlEz?=
 =?utf-8?B?WnVZVHdCRWxXWmhieEtZNDRtdFlNOC9vRVM3SFFreDdWUUJCTFcySStobEVG?=
 =?utf-8?B?aXBFVjN0em5NNWdmaEtUZGEvTnNDcjBwOTFIU1doU2ZRWmw3SWtLanRocVho?=
 =?utf-8?B?bHpJcHBUMS9YZkxIWFVWSStwYjdlaXNSVUxCWDFZVjIrNjYvUVhIZjh5Z3g4?=
 =?utf-8?B?aTV4Rjd5dkxmSUdHRlNvNlN1ZmJQeldic2hGa3VuYzUwOWJPRTRsNmJmd3VU?=
 =?utf-8?B?VXRXdjd1UVlnK3R3dXZLTmRmdmloVWRyL214d0ZSSUJpQy93UFlUSkpiL1RI?=
 =?utf-8?B?WGJFVG9zQVVKQzhsUG1ub0puWDd3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307d2d63-e3e5-45db-b55d-08dad13bdbaf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 12:27:04.7222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Nt/MJ/JpSw6/QvBpgP7z8Vg1fyLFblmqxHCwrsUxUcSLZc0nWrTt0fNc0A+u/7DfASZN0ju+LNHDgz/V/r5hPVmfj4k5g4zPUmtTCSV3VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7757

On 28.11.22 13:09, Florian Bezdeka wrote:
> Hardware IRQs are enabled here! It might happen that right after
> enabling the IRQ at hardware level the IRQ comes in again, even before
> we could fix the software IRQ state flag.
> 
> The result was a IRQ storm and system freeze because the same IRQ was
> not properly masked at hw level during next IRQ arrival. The software
> IRQ flag is checked before going down to the HW level.
> 
> Switching to unmask_irq() has two effects:
>   - We do not have to care about the software IRQ state flag anymore
>   - IRQ state is updated in a hwirq off section together with the hw
>     state, so the software state flag and hw state should no longer
>     diverge.
> 
> Link: https://lore.kernel.org/xenomai/20220210153313.2229625-1-gunter.grau@philips.com/
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---

Just to be clear: The issue with reporting spurious interrupts with
printk() persists. This is step 1 for fixing level triggered IRQs again.
I have no good idea for step 2 (spurious interrupts) yet. Maybe the
solution is "do not call printk()" in HW irq context.

Step 3 (already on my list): Dealing with UART throttling that has been
backported to recent stable trees. So I'm facing different "ipipe does
not boot" problems at the same time...


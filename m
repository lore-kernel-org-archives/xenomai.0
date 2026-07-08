Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C3409280
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526326; cv=fail; b=d9aLPfMxx1vSbUYd/HdemMQMSqYsbh/KeRH1q0DKO3SuPOJl3KS3knS8NuYYsZ580/KVfxvDvANthiRNH7MZtfE7EjUrFlGaT0xLxknXCB060vmp8+N43kud2G3wUF7sfiJOAbu+XlXyeYlf2YwiiKFghyENKp3N0Vzg44c6E3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526326; c=relaxed/simple;
	bh=cDNMandRkL1WGw+GAZa6GpPZYYZWFwJun1bkD8MTkdk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjOHFJ/FUDFwjjXxy+ysCoTz0RDVh5LY8Zf43/LIrft//jAsTs2Gyv3GY/ej7AVeDCfmZv+1Oe/dL2GCN8IwPDeS6qPrNwfjaHgJqxTUB4acS6GEF2SURaPVkO4EYsFL0nPIt38Qklm08s9VB4ZtwEufOzOrN5UnhtOb+WjXjxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wOpMUvAm; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wOpMUvAm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2erhK+9/VpIgf58ql2neTHCjCl/dLdTdR7GQZK1r2Knh8R/k903/LppOc/WlvfRM4qhcU4MTkZEFSUPz9fB5XYBO5eeanUXtociO7Ya+wTc/gQFO1rjRnvDcBQUrSpF/EdJUGH7EGVzl97EFH151zkxOwCHNOEy13h8eSlaKhR+KgQF5Z/9bFJwovugBA6Od2OfTcawh+Gcxh3MAGJyoYlfXT7LLq2DWIn76NhdLNn1tNT6E91UZGm3yaMqC2NE5Bkbd1K/LQWTQrwZfOk158l9CnuB8H1dn/Dp4A1xU34yqTXj7WsqnvuJl6Ym2I16vUIcmzaSHEuRDxQat8UvPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CCk/d06f/T9GrwyEpQqObCXae49qn2WJ+hrScP8SiA=;
 b=FJeLmXxPycN9bKLX07FTjDc8VeKc7JJ56ghlbFV6rxuGjpvsUPjkdRV87giHij06hG8N9dWN3nU42hcRORiEVOIksL63NIgUDDcQQkxAbUNYYMvLii09Eo7YQNMZnVkgIin3dAD1A1ORo3/0FyPooaVO1ac7+YBIYQVBBbv6zq1/GNGdBBewJhuF/TrQrpLWF7l9Nosi4tG+yKCgxY5siI63RW06ha2raA2Tp6vbB24jZXsnNbzQtGVqFPCcqz0JFoYZzXhfy0pZ8koe46NLPu8mM7k+tV/o+s4jZ1q+Qy5YexELsPjTRWe4GH8E6cqoVgUqTySL4g3lupACpbc3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CCk/d06f/T9GrwyEpQqObCXae49qn2WJ+hrScP8SiA=;
 b=wOpMUvAmU7u5hNcpeJCBaanBg7dgAGSHfuLLGmeT7IAoJw/3cuiTx6zOC5kCeRAP38IQQ97JQMomPSEqgxXkJjmTnj2A88Ou/qbgbziyirEccY8LQ8jZtfE1WYzjeAhF8RuM9nMIcb0Q2bFNOisEGZwDT/SZveBxIgW4hVxjps7YNBsFg18fYQ4b4ydrAHbgKMg/BefjqUOMIYbFVPm2oc5MJ2hthua4sKku6IJX5571p3+UQXYLY471J4KTqjKnm7Coq4qyq9kd3R4/VWr3TyDJZY7uoCZ1elopabAhM3mqrpSXWJkPn4E5UwAxzzzt4ZyxOf13Y3SKPmFGX0PjaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB5198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 15:58:42 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 15:58:42 +0000
Message-ID: <3846e30a-d5ab-4e3c-80c8-127481431c3e@siemens.com>
Date: Wed, 8 Jul 2026 17:58:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-evl 0/2] Add RISC-V support to EVL
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20251010101130.3758633-1-tobias.schaffner@siemens.com>
 <837969b0d849fb716bc712df566bde246c5ffc41.camel@siemens.com>
 <40c1b8c7-ffb9-4f13-801f-cdcaeeda5ce2@siemens.com>
 <e27b6011-a7f8-4be2-995c-2515f74e87b9@siemens.com>
 <4906b6de-86bf-4c44-8f7a-4486aebf3c58@siemens.com>
 <bd2c18af-c93e-43fb-81ef-14cdd31a8bba@siemens.com>
 <87zf01lv1z.fsf@xenomai.org>
 <a72d61e20ebd3c5279b1f80f2a7d5225eb8fdb08.camel@siemens.com>
 <bd695b7d-fb94-4f2a-8ed2-d02d87ac9217@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <bd695b7d-fb94-4f2a-8ed2-d02d87ac9217@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS4PR10MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: 818dc7f2-a414-406e-0f1e-08dedd09c850
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|23010399003|366016|18002099003|55112099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CL4LQLD6gnVvJtKCYEu7eCx9s8fTNJetBLADiVv7JFy/7eoC8Wwr+YVwyCytzrzfBuC/NkoNk++AaqkZ4UWYFal+VmVz9hG3UsFuQhsYzNeWYisqZru3RM+SBojIamu9zaB6NqBqc1OV/bHDSs3YtbA6swLdwyFrh8WI8wroqzLUyZuDjax1sFzt/pZqefqKgDZhQ1S5ZATN4b+vstwsXAzQYFhNeEUykUVjKlA9vdJVFcJYeCk8jSGjBw8RdI6eXzkhEgzYqSjEKyKBzVp8cuLzyTDSUqFgTDFDRn8q4wpTdV2XRj3Sn7BZF9+cteoz8Of56HSlfFnagzwZKCREfu15ALL9F4iVVp9KcI6ZPTQZ5nYxgXGLO58Vy0yd76vy/+stG/AZosGoFNC26EBWZRQBC0i3KM+41H5OH/cAOA+FURfLWdJKfY+yo3CNhVaGGFusqY6iQXjTZWJkimNKTjrxX9OX2DkZr1M/vxy09Mr/24fM10qZ9S8jI4ytkUx7SziNp6Oc20MFg99kfR0wFmSOLXfje/5iuw0YSXfxYzuCxrvBMGhAkMPiZAGgH9PwlHTlySso1rvLzugKdPWMWdFlfzEdwXZi1Yxb15pQSdrLeCX86sPgfGZOldLNojG6lepTuSp+FITqzsfT2P2rWfJPGfseKuvkAx2SQ1Tc+fw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(23010399003)(366016)(18002099003)(55112099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHNXVVRBZ1BJMkpwcDJ5N2cra05xK1RER1JOREl0WXlzemFJbGxRMVdqYTQ1?=
 =?utf-8?B?Zk03VjFGQ3pEc2gvUlFmMVdCd1dSVTNuNHo2K3QvR0tlUGZjVCtIUElLNjhW?=
 =?utf-8?B?SFFUV0RUQ3RmbVo4Yy9ncWdXZ0FseWRvTmdnLzFmaUNISVdUTUlUVEplY2Ex?=
 =?utf-8?B?WlBBOWNlS2Y0d0NyQUx1cFJtc2pJcnRNV1k3V3NtdzhXcmVmTzl6VEZadCtB?=
 =?utf-8?B?V3h5bU03V0R2NTdlOFQrejk3UHF0Qy9zQ2NUZ2RmM0cydEFVUlR1d2owVTdB?=
 =?utf-8?B?QlZQZXRPTFlaZUNHVWVYbGRob25QWGlFeVlsaXc0Nng0MS9OVGNJeWxJbWxL?=
 =?utf-8?B?R1JqTkNsSFFSeUFFTktLSWVWeXFuTERKWG9xOXc5M2FuWklleHNJUStRY1JL?=
 =?utf-8?B?OTM2Q0ZUNEEveW1vTi84bFFPVmtuTFB2MnNhTjJrNUw5WktWQTVmNng3TG8v?=
 =?utf-8?B?dE1TNFcyMXRabkY1cHR2YmlLZmk2bVNsTlNhTWVUV2dTZURHQ0YycXJ5RFds?=
 =?utf-8?B?dE5OWFIwTTRiN0dZSkpOY2dMWURoRGJGZ2tyNUNtUlM3djh6NmdnbjByaVAv?=
 =?utf-8?B?WGFmc3cxNmpMeUx4cGQ2dG5xalF0b3Q4WjdEZTdQaXZzUjV6cXgzNVhsa2Ri?=
 =?utf-8?B?Ujl5SGo4MHp4UWlPeGI4ZDU5c0sxSmZnUE1SeFZHQjJyQiswc0s5aWNWYzRx?=
 =?utf-8?B?cEhpMVUwMGxVdStwN1ZqOTlYMTFsRlVZVEZZbEltb0VaVHhhVjU5RHpSNEpZ?=
 =?utf-8?B?NXl2RlJ2dlgvR1FJL0ZzVGc0T1plek1WZmY2ZzArTXhIbjlKeWZQazJ4c0t4?=
 =?utf-8?B?SnkwbzczQjRmZmQwdEF2ZjUzNUNmK25PUTBXaDJIdU0wVVFYOUVDdkxqS1lQ?=
 =?utf-8?B?d1BFd2NCcXFFcTk5ZkVVdE9zNDNnU0dSQ3RaNXI0ajVPSHhTVWxvbk1ZZXl1?=
 =?utf-8?B?UzRveTRmcE83dU9iankwdnc5Yk1SZUt3MXVTTGVYUlhSYjJGTzZ6NVNVUlBF?=
 =?utf-8?B?UVpGbWFLczNnbHJzY1puWVRPWVluZWdYQVhldVRMQVpVM2ZWQVNIVGZuaTF6?=
 =?utf-8?B?WmZ3dVVwaXhQL0hNclkvRldlNExhQkFENEt5RkdDSGRCb2R6WTBvWkgvb1Yx?=
 =?utf-8?B?VGxDUW5ldWNwM3FmNzJVc3orV21vdStxcmdJZ1JHbHVuWTUxY3lCeEMwdkdi?=
 =?utf-8?B?Q0Ezd28ybFJxVDR2M2l0K0VjZjhNY1p4enl3MXdEeHh4eEs5WXZFdUM4cVFk?=
 =?utf-8?B?TDVzTjdIVGJydmxRWE14MzBEc1pxRU12aGNaOUxDSjNFTXh5N0JOWnd1L2NG?=
 =?utf-8?B?eXF1VDNtK0VOanoyRmpvZjJHbFVpdVI0VlBrd3pqZmhiV2Fud0U0UjZlTG1M?=
 =?utf-8?B?eHB0MzBTekVFMkg3aElzOHl2YWt4QW45elZ6SXpLSVdqeEFQTjlobExWSlpp?=
 =?utf-8?B?T2tvdnZXc2gwWjlZRm14YVUyTFF1M1FwSmNyQVEyc2dTNTA4enBIRCt0M1pW?=
 =?utf-8?B?aThjajR0Wm5Ec1E2UElyb3VDMEZNY1l2QWJLRVBHM0ZvMkNKRjVWR3pwSnVx?=
 =?utf-8?B?YktDSnByVTdxczJpVHdBY3dHVERyVGs2S05hQ2IrV0MzeVZWcDEyTjA2SlAw?=
 =?utf-8?B?czgrZE9iWkZDMHQ3b3hOKzhLZjZ3Q1hveGpsOXd6OC9YSm9XZ2lLeTFiNURu?=
 =?utf-8?B?M09lZ3RGWko4S2MwV211SDF4UHhXUzRxTjEvS29CL3liR3NUdU10YjRKWmt1?=
 =?utf-8?B?d3ZoS1I5MklkZlMzRVhpSWhFN25xWmpMRU1HMENwWkwwM1piem1DWUphQmlN?=
 =?utf-8?B?Zy9SZEFoRXJ5anVnWHVlRFVWRGF2WWxOTEhVdE1rZndPZHFOMFljY3R1Y1ZN?=
 =?utf-8?B?eXE1YWJ3T3ZRcGFaVXpiNEJHTWJ0K1Zzdnp4MTFxWk96WjYwSXR6QWdBdUxY?=
 =?utf-8?B?OEs3TVkxZmdNQ3BkODIzUTJ0OVlEQTdwNkFXdTA4ME80R0hubHNEVDlhVUZF?=
 =?utf-8?B?SzUyZ0dNQWlFQk1BQ3owdThrRFMyMFQ3Zi9DdDBCRWhzdnZuM3IrcXU0RjJL?=
 =?utf-8?B?WDBndFBHeXhGWFFtU1NMcTZmMTNkVVVSWDJxS3doQSs2WGcxSHpsRGFUdDBO?=
 =?utf-8?B?VEVxcDlMaWZLZEMrdmNNM1pwMlRFQkRnRTV2U05RMklQdnE4S2tTaWYvQklJ?=
 =?utf-8?B?ZnZDaFYwWk1zNm9nVmRXU2I1Z05CelR6dysxSkp1UE55U2lqb1BDT0ZKVWVt?=
 =?utf-8?B?cWo4M3hSSFNIUnRMbWZMcmlMYnNnaDI0Z3MzQllVUkVEdDdZbldBTGIwaDhR?=
 =?utf-8?B?OTJJSzhLTjFKU05qN3dYbkl2Z0h1R1ZuYUpzbEg0M0RnREhlUnJXTlBDSlc2?=
 =?utf-8?Q?SGWTtFsteR+u/JPoFZx1cRRdwHcdwFfD9AlEnPGZ6icD+?=
X-MS-Exchange-AntiSpam-MessageData-1: PFBZ+BH+mPAQ7+9hF+v48h47/I91B9eVGG0=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 818dc7f2-a414-406e-0f1e-08dedd09c850
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:58:41.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObHXm//LQ3eGhg76vyXnW3UrzOANDPpd0n75JcyZnmyRg6JLP4tBkrin+WfJp4/Ea5pYZ7WhNkdup2g2+JBfVsgEaHyr9X8QcS0g1Dj+qHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5198

Hi Jan,

On 7/8/26 17:32, Jan Kiszka wrote:
> On 08.07.26 11:51, Florian Bezdeka wrote:
>> On Wed, 2026-07-08 at 10:55 +0200, Philippe Gerum wrote:
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 08.07.26 08:26, Tobias Schaffner wrote:
>>>>>
>>>>>
>>>>> On 7/8/26 08:07, Jan Kiszka wrote:
>>>>>> On 08.07.26 07:17, Tobias Schaffner wrote:
>>>>>>> On 7/8/26 00:30, Florian Bezdeka wrote:
>>>>>>>> On Fri, 2025-10-10 at 12:10 +0200, Tobias Schaffner wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> this series introduces an initial EVL port for RISC-V.
>>>>>>>>>
>>>>>>>>> While some tests are still failing, I’d like to share this early
>>>>>>>>> version with the community to gather feedback, reviews, and hopefully
>>>>>>>>> some assistance in refining the port.
>>>>>>>>>
>>>>>>>>> The patches have been tested in combination with the Dovetail RISC-V
>>>>>>>>> port on top of v6.12-evl1-rebase.
>>>>>>>>>
>>>>>>>>> Looking forward to your feedback and suggestions.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I tried to apply this series today, and run into the following issues
>>>>>>>> reported by my tooling.
>>>>>>>>
>>>>>>>> Patch 1 is fine, patch 2 has some checkpatch findings.
>>>>>>>>
>>>>>>>> A couple of debatable warnings like:
>>>>>>>>
>>>>>>>> WARNING: Misplaced SPDX-License-Identifier tag - use line 1 instead
>>>>>>>> #58: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:2:
>>>>>>>> + * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>>>>>>>>
>>>>>>>> WARNING: unnecessary whitespace before a quoted newline
>>>>>>>> #95: FILE: arch/riscv/include/uapi/asm/evl/fptest.h:34:
>>>>>>>> +
>>>>>>>>
>>>>>>>> In addition to a serious one:
>>>>>>>>
>>>>>>>> ERROR: Missing Signed-off-by: line by nominal patch author 'shannmu
>>>>>>>> <shanmu1901@gmail.com>'
>>>>>>>
>>>>>>> I did not get any responses from this email anymore. I can try to reach
>>>>>>> out to him one last time, but what do we do about it if he will not
>>>>>>> reply?
>>>>>>>
>>>>>>
>>>>>> If I read that patch correctly, it's majority is taken from the
>>>>>> corresponding Xenomai 3 logic. How much is unique contribution, how much
>>>>>> was your work, Tobias?
>>>>>
>>>>> I added the evl_set_fpregs/evl_check_fpregs content which is a
>>>>> translation from what Gilles Chanteperdrix
>>>>> <gilles.chanteperdrix@xenomai.org> did for the x86 and arm architectures
>>>>> with some isa enablement bits added.
>>>>>
>>>>> This should be the initial version by shanmu where I added this on top:
>>>>> https://github.com/shannmu/linux/blob/xenomai4/wip/dovetail-riscv/
>>>>> evl_port/arch/riscv/include/asm/evl/fptest.h
>>>>>
>>>>
>>>> At least for this patch, I think it would be fair to claim authorship
>>>> for the final one and only refer to shanmu as provider of a baseline.
>>>>
>>>
>>> Agreed.  This is a trivial adaptation of the pre-existing
>>> arch/arm*/include/asm/evl/fptest.h, which is in and of itself
>>> boilerplate code.
>>>
>>
>> We had a short chat about this topic in the Xenomai community call
>> today. To avoid further delay of the dovetail 7.1 release we decided
>> that we will move out the risc-v series again.
>>
> 
> As you already removed wip/flo/v7.1-evl-rebase+riscv (which broke
> xenomai-images CI, unfortunately), where will be the new transitional
> branch in the meantime?

This should still stay at wip/evl-riscv imo. That's where I push new 
versions as soon as I rebased the evl branch. I will send a patch.

Best,
Tobias

> Jan
> 
>> Tobias will use the time to clarify a couple of those co-author and
>> signed-off topics. Each series (dovetail, evl, libevl) seems to have
>> those issues.
>>
>> We will have to wait for a reply for some time, but we hope to address
>> those issues within the 7.2 cycle.
>>
>> Evl and Dovetail v7.1-rebase branches should be up to date now.
>>
>> Florian
> 


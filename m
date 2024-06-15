Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD9A524C
	for <xenomai@lists.linux.dev>; Sat, 15 Jun 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718436936; cv=fail; b=VcvlnjYsDNlwof2JwOqbl+L34hZZNNQzwkAMwdA1KmS9hxvumJi+ZIPJLrOX23Hl7H23BOskS+JuIi/Wl0DRn2E3shcp4vNrYhRuzITRHCNHcw78qL105elYau8YRGqsztGnd62CEibldeDowM7Wjy7nTSAWfcj97wRCYKrlQP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718436936; c=relaxed/simple;
	bh=FvncGi88VhK0rAeYSMtx8cj0kZY6AfUul579jqo3j+I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pegrNxykKVvAog/XY7P/HqZ5cP25CW68jY6DGBM3LhkUuv/9kGOqR+gnppEuoQUOBfkn1d7+2X1eHISJuDlyROcCD7OYmcSbW2ZnCpGZYiwJKDCNKjYt/cnztANWnmB8gfoltGg4JKecJF4DKS66sGwoaWf7fCZB2PcOZo9f0vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ijVeCfh4; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ijVeCfh4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/FD67FTFK20tvedYzrI/yIkXGxMlWCbnjFAzQeJCIVXr8mC1ZwfPPbcg2FdDVwdmjnMMybSBo26c9WIpfWTXEjISVylJPkWe5m6+0Agqx/8PoryquONEl8Tp41kyINHZbXc3WxP2qiNWKLszbBS5XfEubFXVivl8FFEdslD5mTYiupiUYAiOtlQbpk6woFv/tOB52ZrwmP5aNdfZxu/qbCtlKq/CCor7XZRGCDpti5xdQ38lA86clgZKV9/+jmG2WUTWyN71Kmqj2sMgr6WD7B4ZadOaaj7ZIPUr3ynuC36OB5IkF7rTZoGYagie1CEtiOcqckR/WfXCfaiBlOv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4Rym3x3HW6bhNrT4uLjIEbPZLW13xKUnKykz9WrGK8=;
 b=T1S+W1yTGFGxBD4bcqgfwXZdpnZdxB8CImKdd28iYM5VxkYTCouySVwBbIdqzn7a+e1H9fMoKfXY3XiDRa+wseZ1HcxSAJlGo7T2quyfrTnJckZPE85qeGkZDo2JXkAzzEJjdKiPrCHgRFAYkhY5j/OnEUBIpoOKErosG6u6UOZ9QaMiGTuTi7rezSu0q3bkaGZ0F5GCWinRJJSDJ5XO+7oO6KX+l3gNaiGL13qc8+DqklBR/SIhgKBCkY3bVZIo8WzuduJNldtt42Dsr1AhCjZkHzk/JGcUAnwzHg4jw2asLm/PXzJZn53y1hnse/9umfMEVdfJvT9UkfJ6+N5e1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4Rym3x3HW6bhNrT4uLjIEbPZLW13xKUnKykz9WrGK8=;
 b=ijVeCfh4Zi6+edopmP2Gp5ZdPjPAuJ9ImFAobXXN4IxnhogxSY3+1/S0pAGs/t0lSATfsK1V2fVwVFXAa6aYIbEfEtaXyQSNJ1FnSUoYBQ1BwMQfRnZyQraxeS1dp27ai3HGRdkydwMEetlVzfx2v2YuRghbNRrDls8LUyeCQfQ3+m57cL8WTcl3nMzaXsWWd3OrYvnYNFzGviiU3M1vXNMnkbPy9wdmbp7aoezm3yJ5tSmpwA7oAv5aClnO6RjhHXVlkG5r+Y9rFgtB465BKZ+DTzmnC2q2vZbVBzjNeT8TqRh6yIQF3HOBX3BJq1wjk9OAjCHUiRyH87NZLElPMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:635::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.27; Sat, 15 Jun
 2024 07:35:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.027; Sat, 15 Jun 2024
 07:35:30 +0000
Message-ID: <3213cc86-82ae-40ef-8793-811b9bb4e3e1@siemens.com>
Date: Sat, 15 Jun 2024 09:35:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v3 2/2] KVM: x86: dovetail: Allow kvm_wait() to
 be called from any context
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20240531-flo-fix-kvm-guest-for-6-9-v3-0-ebcf517500a3@siemens.com>
 <20240531-flo-fix-kvm-guest-for-6-9-v3-2-ebcf517500a3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240531-flo-fix-kvm-guest-for-6-9-v3-2-ebcf517500a3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fbb4d6-f295-4de4-8a5d-08dc8d0dbbf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG5FK3krL3JUYUZ2anpRdU1aZHg5azhjblFNdi9qbjlvWWVTbVdpNDkyQTlq?=
 =?utf-8?B?RDRkd0ZhbWdMR3NydTE1U3lqL2s1RFdsRG80MHVxajJBK0d4d0F1dVNtZGd6?=
 =?utf-8?B?TitRSXUwc1RWV2NDVStmS3E0YTN4YW9ZYVBOWXJJcHdBSlJHUWFCTksrYWJF?=
 =?utf-8?B?ZjhLNElTa05IeDZuY3paQmZsMlNJQmR2dFhnRngvOGhBVmhMSHZGdXBHdUR5?=
 =?utf-8?B?ZEFiWTdkVHB1VGdnVldlbGFlOXdzdFdKeE8xVEoxUzZpNEc1WmdiNXlMUTR6?=
 =?utf-8?B?RW1FQklweUg5akQwbmhHOXUra0tlMlRXMWFYenlYalpPZFJ2WWZHeG9EZ0gw?=
 =?utf-8?B?VTlsRThVZGhCM2d6b1RPK09EYklWK3AvWVp4SlErdUdJQ0RhKzRXa1RLL2JL?=
 =?utf-8?B?a1VvQ0llOE5qZGRCN2VBbVRyRHB3RVBGc0h2ZmlneFRua0xFeXRkQ2poaDNN?=
 =?utf-8?B?MDJNNGN3N3dwckFDbDJ3NkRCRFJzS1l6NWhWeTJISE9meDBrRHM3V1hPWGpK?=
 =?utf-8?B?cGVlMEpKckR6Sm1xa0hYZThOUHoxaDdGaFpsb1oyeVlVMk1DVEFXYUp3ZklZ?=
 =?utf-8?B?VjBSQTlaNkI0ZXlGS2t2bStTOG9GSHo4RXBJSU0xcTdKeDczRnNkYU00K20z?=
 =?utf-8?B?cDFnNDFUL3dqdWVJcjVLWldYLzArTXcwbUZzeEZBcVBYcTYzelhLbXo2YmFT?=
 =?utf-8?B?dU1xVndEWGxwaXFaRkhhZ3pnTnJGSHAxUExudUMrUi9BbGIwMlFDd0x2eU9s?=
 =?utf-8?B?ejd2czhucXhmOUVCZDN2QlpQeFJUZkNocm5UWXlOeU5JaVZvczE0NmdEczhq?=
 =?utf-8?B?N09GSEFPRTRDcU12NWtJQTNCRElaMTFLMXhXcW5JMDgxRnREcjdDNUZpRmNx?=
 =?utf-8?B?d2hpYkNQeTRuTEw1RVhQWXA2WUZiWDdKL3NXWU1CcksrUzVvdVVUcGtxM0Z4?=
 =?utf-8?B?RjNWd3NlN0xLcm1nTGE2K3FrNlRjT3BZZjM1dTNVTnNCSHcrYmVCM3ZmTFJu?=
 =?utf-8?B?ZEllVDd4akJPYTVOQko1bEUvQTdJQXZuR2xXMHZpNmdhanc4OTNFRmRtbWdl?=
 =?utf-8?B?VmhGNjhmOTdpUElQNExPSWEzQ3E0VW5zK0hqSDBZWkRHQms1OXROeTdKN3Jy?=
 =?utf-8?B?STN5dWkwdCtJQTd0UTVOQnR6S3NMSUNJbnhhUWN5a2tFakp4czhqRUNJbGlJ?=
 =?utf-8?B?Wlo2WXlJdzgvZER3T2lYckIwbkI4eThESnh2YWc3K09QOTQzdEUrYk95WVdB?=
 =?utf-8?B?My9wL3laZ05CZlZ2a2l4Zm5JQThjalpXd2tvUDJUSm1oeDF5bjZ6UnhGakNN?=
 =?utf-8?B?VnI5YnEvaUlmYTN1MTUvOTZRWWRMTjBSZnB4WUs2TzgrQ3FmWjZSUEo3bDVj?=
 =?utf-8?B?RzluMk9oVUtLYkJjalJyb2NNbCsrMkpBZHFqVm4wdUZLWlV5Tm9OMzBKMXBx?=
 =?utf-8?B?eUEwUDI0WlNOYStlN0JMbUk4V3V6OXVtSzdRK2JscU5wa3JQYzRNL210Q2lT?=
 =?utf-8?B?MFhkRHc3T0phbWhPcFZnT1NRZEVDQnkwZEo2TzU5d2gyb2h2Rk8xK1ZIbDJq?=
 =?utf-8?B?Rnh3cnZKaFlTajVyUVJJU05EcVA0alQ0Zm1qTVdqdEloY1hwWExrcEI3TUtw?=
 =?utf-8?B?aUtSZnZsZkNRVG5VbEd6cUFwanhZcWpPbVRtU2ZlcVdkMjNXbHVpNXhPd0NS?=
 =?utf-8?B?TlRHWjlzbEZRaHNYVk1kMk9VYThTTmNDUE5PNWxFQlMrNjdtMFFnaUlVZXI3?=
 =?utf-8?Q?7jzbhjmSYjiCW/LjBGrXtSffXYsuWWr2ERnvrYo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWZlRHk1R0UyME1kL2lQeUg3YXpOZENsNlNja0tWdU5Mb1BDN1BzTmpnZEE5?=
 =?utf-8?B?MDlJblNTNDljZWNkbGFZZWlqZGlhaGU3SFNtVjZ6cEpka01pTVpseTdOV3J1?=
 =?utf-8?B?U2pWWjNpd29EK2t1VmVvVWlydnFsaFVhLzFLZXExZCtTaTdhZHV1THJYblYz?=
 =?utf-8?B?YVI4UGx6L3BHRk40YnlJYmxZNkxQU3Y5UlFhTDVoMjFrbjV5T1BPdDhJMS9I?=
 =?utf-8?B?cmF5MG9OVWJFQzM1b3UzSlNSQXBqdFo4ckorVDcrU2phRXA2TW9KY0EreG5C?=
 =?utf-8?B?Z0NoWkJrSVBRa3FObG1iWklRSDlNWnpBbVZlTFE4T1NMNWgrU3ZUTDBXbUhD?=
 =?utf-8?B?RDByUEg3RzRmdWt0V2lTVXJhMnIvNGhSbkRpY2hLZGtMOFdPWDV3UFh1WEpW?=
 =?utf-8?B?ZEJDTWYwN2RaTnc1NC96MG9tcGR5STZBN0s1YVAvcTRQaCtudVU4cWJwRExm?=
 =?utf-8?B?M3preTI3REZWSWp3RjFvRTlTWTVCRnRsVHhFOGErVUtoaEM1eG1tdWdoT0Vh?=
 =?utf-8?B?N1djV2RHWUZTdUNpSG9KN0lYSGRXaHBuZmYrTy83SHQ5cFZlNVlkN1VVZGxZ?=
 =?utf-8?B?bWV2RUtuTDdUSnZMQUF6L3dSY3kxNDQrNTVyWnp0UzcvcGJjZnRUSEt2SFVI?=
 =?utf-8?B?TU9nRkh4STRCMEUrbndrMnJOcGVKYmtlOS9oTFZROU4reUNncjZLU2FkcWZS?=
 =?utf-8?B?cTV2dCsrRWNlTkdhZENUNUZrdDNrcWxIU0hTdFFXbEh6dE1VeUovQjI1R2Ix?=
 =?utf-8?B?NGhpL1Evaks4TjZkbXZMWEdncXlVVE10YWsvL0EzWkQ2OHFNbHpoeTEwY0Qy?=
 =?utf-8?B?QmJLOFRCTHFTWk92TlkxNnczdVVJNDFkMUx1RzgyMEZweXlua3dtY0tBZlBQ?=
 =?utf-8?B?eEN4LzB1L2VCd09QRURWUkQ3U3ZsdVlPWUFpdGNZYnVocExnZDUvUUJOak5I?=
 =?utf-8?B?Rk5GZitOT0RMbVNhNWhOM1l1Mnl4bnNxL0FiSWdSdm5oN1dlOGNvWmFGS3Aw?=
 =?utf-8?B?eklhNlVFaERqS29CWlppaGxSSDdEOGk2OGtZY1E1c1Z2T1ZBZWZhbnFhMDlZ?=
 =?utf-8?B?cDM2dzBVb2ZCbkdHWnZPMmNqbUh4YWdaTGVra1BsVDYzRE0vNEN1dzg5RUZT?=
 =?utf-8?B?NXJlVEdiZElsK0hrU0NDQkwrTFRFem9QcFhIRWpTQ21FQnFMZHluTTB6NUVD?=
 =?utf-8?B?TElhb3VuNlRCaU1pZnBtdklnKzJ1UldkY1hReFZXZFBuOElzMldtSk5XbW41?=
 =?utf-8?B?SytuMjc4c2NqZ3NEU0lHSFgzMk9JRHdkK2pyU0o3K29JYmk4VEdtL29LM2ZQ?=
 =?utf-8?B?OUFkdjRtU1MzWEdoQUZKekw2Rm5vSDM3NjJEdTFWU2h2ZCs2NDNZdGw0c0t5?=
 =?utf-8?B?WGtZUk54UnhpQTdQTHNYTGNZdlFVT1M0N0srZmpIQmVNSXRNbTF5cERyMUIv?=
 =?utf-8?B?ak5Fa2RmL2QyYStzbEdWL0ZvOTJXbnJCYktTZW54TzJuNUlJWmFJa1hRVTlo?=
 =?utf-8?B?d09IcC8xNTlpaTBoN045T2pwTG9odTluRzVBMDRXK25vcC9EY1EvSHJZd1I3?=
 =?utf-8?B?bDJUdjJDaFR4RkE2YjhGTmF4ZDBsQ25ub3JhZ2hpTlhWTDNHbVBCM0huQXRK?=
 =?utf-8?B?MTFMM2tBU0xKeHB1L01xV1FobkxZbUFncUZUVXZmWGZqZkNDeWwzcjViZy9N?=
 =?utf-8?B?WDVnSUlqbFNwKzdnLzlnWFcwS3g0M2plbnZ4OXhYdThxaUFLUGlmdFEzeUF3?=
 =?utf-8?B?bWt4TE9IV3g1cTFQY25Vd3ZScWg4WVBTdTNOV2dHdzJzaGJobmd3d3paSm9Y?=
 =?utf-8?B?NWVxbERYbWFoOUd3UXJBNGg5ZzA0akFITUJUVVJObEt3cFF3cm5YbUwxdlNY?=
 =?utf-8?B?NFoySmZuWFpibUZ0Q2Q0bjJNWGNuUlNuWFl0THJxRFpJTnNCM01yaHY3Rm9I?=
 =?utf-8?B?WDVXY0hmS3poTlJFQWN6QkhPSnV5Q2JPK1lxaWRMQTY5N2szdE1mZnZNQjR3?=
 =?utf-8?B?NFZXZFp6SmtmcGd5ckNpL0pZbWk5WUU2VVMvdGR2OHJ3cmRpeVE5c1FxSWJB?=
 =?utf-8?B?dmdIMEYzd2hsU0JrZWNlOFh6S2VmNzlwVjBuZXgrNlZ5YXFaQWJCN3lIT044?=
 =?utf-8?Q?4rgKNNBYCpvsGMyBWAJHzwRuM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fbb4d6-f295-4de4-8a5d-08dc8d0dbbf9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 07:35:30.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fe6hQg74AH91qJdr2CJfgwlDZaP9VtDwHsSJurVcLEUSCAASshUyGwCOxt6uiazFxr035lvbDIIO2vEg4cOXnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7662

On 14.06.24 13:53, Florian Bezdeka wrote:
> kvm_wait() unconditionally enabled HW interrupts when called from
> pipeline entry code. That broke the PV (paravirtualized) spinlock
> implementation.
> 
> The following calling contexts are supported now:
>   - pipeline entry, hard IRQs off:
>     Wakeup on vCPU kicks only, triggered by the current lock owner via
>     hypercall. Using halt().
> 
>   - Linux IRQ context, hard IRQs on, inband IRQs off:
>     Wakeup on the next hard IRQ, or by a vCPU kick.
>     Using safe_halt().
> 
>   - Task context, hard IRQs on, inband IRQs on:
>     Same as Linux IRQ context. We stall the inband stage before calling
>     safe_halt().
> 
> The !CONFIG_IRQ_PIPELINE part is now re-synced with the version of
> Linux.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  arch/x86/kernel/kvm.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 655b1cf8c9ab..76bd881e1137 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -1059,22 +1059,59 @@ static void kvm_wait(u8 *ptr, u8 val)
>  	 * for irq enabled case to avoid hang when lock info is overwritten
>  	 * in irq spinlock slowpath and no spurious interrupt occur to save us.
>  	 */
> -	if (irqs_disabled()) {
> -		hard_local_irq_disable();
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +	/*
> +	 * Hard IRQs off:
> +	 * Only wake up on a vCPU kick triggered by the current lock owner.
> +	 */
> +	if (hard_irqs_disabled()) {
>  		if (READ_ONCE(*ptr) == val)
>  			halt();
> +		return;
> +	}
>  
> -		hard_local_irq_enable();
> +	/*
> +	 * Hard IRQs on:
> +	 *
> +	 * We always use safe_halt() to be interruptable by hard IRQs.
> +	 *
> +	 * Inband IRQs disabled: Linux IRQ context
> +	 * Inband IRQs enabled: Task context
> +	 */
> +	if (irqs_disabled()) {
> +		hard_local_irq_disable();
> +
> +		if (READ_ONCE(*ptr) == val)
> +			safe_halt(); /* enables hard IRQs */
> +		else
> +			hard_local_irq_enable();
>  	} else {
>  		local_irq_disable_full();
>  
> +		if (READ_ONCE(*ptr) == val) {
> +			safe_halt(); /* enables hard irqs */
> +			local_irq_enable();
> +		} else {
> +			local_irq_enable_full();
> +		}
> +	}
> +

	if (hard_irqs_disabled()) {
 		if (READ_ONCE(*ptr) == val)
 			halt();
	} else {
		hard_local_irq_disable();

		if (READ_ONCE(*ptr) == val)
			native_safe_halt(); /* enables hard IRQs */
		else
			hard_local_irq_enable();
	}

I don't think it takes more than that for CONFIG_IRQ_PIPELINE. And the 
only reason to have the ifdef here is that it preserves trace_hardirqs 
for !CONFIG_IRQ_PIPELINE. The actual functionality would work as-is 
there, too.

Jan

> +#else /* !CONFIG_IRQ_PIPELINE */
> +	if (irqs_disabled()) {
> +		if (READ_ONCE(*ptr) == val)
> +			halt();
> +	} else {
> +		local_irq_disable();
> +
>  		/* safe_halt() will enable IRQ */
>  		if (READ_ONCE(*ptr) == val)
>  			safe_halt();
> -
> -		local_irq_enable_full();
> +		else
> +			local_irq_enable();
>  	}
> +#endif
>  }
>  
>  /*
> 

-- 
Siemens AG, Technology
Linux Expert Center


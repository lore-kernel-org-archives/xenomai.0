Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E4B19884D
	for <xenomai@lists.linux.dev>; Thu,  6 Jun 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684307; cv=fail; b=TiGH9pIksgWL8QQY7+c89ZxamDZh9Vl+dRmtroIIPA/LGGQ9iduLQzlH7WkFcpOu52J+2LYL9RjJXg3n3q6LOeFXJe1pKrbuC+vUTVME9LTuBQdu/rggQlRKRauEuPo9gwjTzGuxaMhHbdqC1SxiIfAJq/zoQSMAFTLN/R/Mr8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684307; c=relaxed/simple;
	bh=Evh3vKyyBuZxPhPzC8Bmj+2uFdEHfwsHVPiy1+5cOeM=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=H8um6p03Q7mv+fGvYsfck0sMPNqJ+ISwGKinW7tK2/XVsBrYn79T1rCEry2kBtvPeNfFjMaE6EbNtXUAlCv+Vu03baNi5qbFvwGamciGKPWE97r9gRM/CR0bHH4f4LM8uCWYTWCP4jwtqsu2dSIO5G8scxeEzNwA5CasQ9Lskvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SwiKbhr2; arc=fail smtp.client-ip=40.107.14.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SwiKbhr2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odVbW70/wDezlQqkvfj+iz2Fz97twixbdtoBYNzcZyn9BPiX8QRUMZu2ZkAplMm/JNLRbCvucv2zMFK/I586gIlJlJLmTgYrNwl+YA2hxAz2Ts08TnpXotJYtgSYu1SRa6CQHTpxKd33PATKj/6czkuiSRP6jNXHamf/03sN+fIwnlEiK1WiJchqaECIaG2IHd3PSOP1D1MT91A4jog/03eG2+6+B400cosAjB84yrwP2Mi8zTvBSOuLoLSu/5Wngk1V1z8Poo2aMX72Yk393NxU2awf7OReHJcC0wIeLd9NB+m4UiUfricn9homdHPzQGkWnd8nbPCYpe8doZ3CDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdJblr38RHrluafdJVkPoTccR/ce+LpO9+gEbOXBXKc=;
 b=F3chMurt45bsop9MMIh3M7PduY64ITgH7j5B6sY4hg39OzmTpTEoomC+TUuiREMCDo0NgBHK9oR7HO+Si4LxQXpOAgXoqJmopwMMo4fExVT34TNgQkG/iLruzX3eiIqIbc/OBlKr9T8z4XWWqF15J4FufV/11a92HdzXqoj8dipeHtLuGvVU/AxTtsjqgIVfuEHYzpqueklhlOqYgNEj5q4Wrtzz3/GepI9t2jcRvF16/EQWK+eppYiMrLdNoYzHuVM3ngSnFnGOXV4h/e0VobrieE9uMRrDy3dMsn0qvafKcLiwL8KE8GeOqRSfS2SQry5FInUmjSMrHqXH8vizWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdJblr38RHrluafdJVkPoTccR/ce+LpO9+gEbOXBXKc=;
 b=SwiKbhr2k+w8o8QNxumHtz8WFn15874SY1LiyATJ84RcLc43rHpn7+FH5RmCi5VcNmyFe2gnzJ7+UgPyNXU+ZuEar04mL7MSl6xdzQxZ8LhBfTB3inGWOHkzUqhKuemTF3Li3CdljvoLE62X/WPl3GtYoGRT44yPembbx1ta6EpTZIKlqJEw4hae9NFyHjZem5GuO1SBp7+OdCb0O0qNLspaWVF7W77LBEmXUNGzqezKHds0NmDzBVECe5/6PzryE0xtRnyq5ulMSgvQOkBSgpr5m7GSqx0IIstGmpZNC5r+7Jz5C9VYFuURo8qe7C5qJtY3EwzAQdxQYIl5ZpKVAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8853.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:564::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 14:31:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 14:31:38 +0000
Message-ID: <d24c6d05-cef6-4375-8d4c-423726282e76@siemens.com>
Date: Thu, 6 Jun 2024 16:31:36 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: Planning 3.3
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 45326630-d57e-4ef8-8471-08dc8635602d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTdJQld5MjFEdG1vR0pya2NyZjZ5V3pMemdCL3ZpWGlCbkdIeHFlbHVzUGFl?=
 =?utf-8?B?Vk8zTnAzS3A0Wmd6SXVlWWZQRzVUQmVNQ1RidEtJUlRvaWF6c003WUhPaWNO?=
 =?utf-8?B?RlhxVjhEbm9aUWx5VU52YVJqbUpOUGh1a2dpdU1pR01wMXJmZlZsWEwvWDI4?=
 =?utf-8?B?aHFsTnR1SlBGWExWTXBqNk1SK0UvWlVLdVpZVU1EZTBjRFdjOTY4b1JPa0pm?=
 =?utf-8?B?Y2puUlArTnJLWEYyQVh6Wm5HUUsxKzJYanZnTk5qTXgxYVArSWdzbjY4Mkwx?=
 =?utf-8?B?R2xmQmJyZldVWkdnMlFVbkZqclFsYU9QZTFtODZSaGxvQmpHcDNCL2gwaitt?=
 =?utf-8?B?K3RSdFp6Smw4R3pxeW5VRmhhZ1hCb2tmMWpoaFNlaWNzalROUHAvN0FySUN6?=
 =?utf-8?B?Vm91NFE3Z1JXRWVCS1FkSkRwR29UTG85Y0dpMGh1WU9qcXBwTEZVQUU1KzlL?=
 =?utf-8?B?KzMxaW5aamh6ZUNicEVpU2JGWTBGL2NNMmVaS0FKY0hhMXBRaFAyVExnbVR6?=
 =?utf-8?B?cm43aTBVbk16eWxlanhZSHd4a1o1UzZCSFZSMEhGb1VuNG9YSkIwQzYxbGx0?=
 =?utf-8?B?Z2VvMnVJV0dwaDFIaHBiL1R1cFJwS2FwYXlBWGtlMnl0SENPdUNFNGdodjVL?=
 =?utf-8?B?THhLR09pSThnd0hvV1FuRk1aTkhDc3hnWiszSG1NWTNYdXdyUU96TlNoeXpu?=
 =?utf-8?B?TFFLWDRleDZYTzhKM3YvS1hlcXgzc1dKTFIzWHJhWkJkR1Q4bzhnYmFJVnNK?=
 =?utf-8?B?V3FkSm02c3lUTjdCazc3Y0hKTFFwZDJtUTgxQXFZYmw5RWowbVJuT05Sb2Qw?=
 =?utf-8?B?UHhqZ3EvOWI2ajM3dnovWXgvWitxbTBSSlhzYnJtd2phQ2szK1lFZzl0TEFr?=
 =?utf-8?B?Vm55YmpQamxBajg1MzdUWVpXY05GRWpDT00xU2xneUNoTXB3M1pjTEozVWJh?=
 =?utf-8?B?OWJTVXEyQjQzSzE5QUpYS0lLcTlsdERUcUpwa0IyT1dMeHZrenRRUjE5Tkxs?=
 =?utf-8?B?KzNMRWdlVUtTcEc0bzZMOWNvQndmQmJ2TGNXbzY4ZVR0UjM2QnZxNGl0dEw3?=
 =?utf-8?B?KzZEQXZoOFlHNXlWRTVKOUh4Y2l4Z2dZTGpta3N0QzVUR040RWp4a2NoQ0M2?=
 =?utf-8?B?eFJicGR5WVpwOTNlV3RKY1lNQzRhaEg3OEVzYWpGV1g3NHRPcHNoc0pGckt2?=
 =?utf-8?B?SEx4VTl5UlVLS2xyQkFqdWg4bDYxM21QSytVbFlpNjFuamttMXk4aUJOd0Zw?=
 =?utf-8?B?eDQvR05ldDU3KytuU1VaNDc0cDFYY2dXN1oxVFc2L0RYMWY5Q3JUbEFyYjhr?=
 =?utf-8?B?VndIVEI1VFZackU1d1BuYUdEU08vT3NUaWp3K3RzMFIrRy9ZQWNkckgzZUpw?=
 =?utf-8?B?RFpRUGovTENzeUM4Z0lIZFFhK29lQ2U5bnRLa1BRWTdDZnZUQjRQck1zNzlI?=
 =?utf-8?B?cDZ2Q2dsSzdQTHU5cFloODMrWkQ4SnNKWEMvYnNST0ptQ05JSTJlZ3h2U0NC?=
 =?utf-8?B?ZUtGdnk3VlFjeWhVWHEvc0xCS1lWQjZucndFc1dZRmNteWpLZXYrNkNOQllh?=
 =?utf-8?B?TU0wUno4dUQvQmhxNTUxcEFuL1pzTENNZURvZVo2b1V6RDkwYVhFV0szaHdP?=
 =?utf-8?B?SGZkdGx6T1duTnZDWU1VQjNRZzU0UTJVVC9YckZ6c290Q3NRSmtNa3g5eFl0?=
 =?utf-8?B?ejhGWmdmQXgwSTNRcThJWEl0MXNkd3k2bHQvYU04eEFrNVVLeFlNNW9XdHp0?=
 =?utf-8?Q?JWGMFEZModO/XABKbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bENJK3F4STJlOWZ4UDNpWElvSmRPcVRvdUtIeFhGZjJ3cXk3T1YxZmFFNjJm?=
 =?utf-8?B?Z1RRTVVVTmIwQWY1WGR0SDNMQkRoMXpkWXlFTWNtMnpOSGhHczBmb3N2Zzl4?=
 =?utf-8?B?NXZBcndaZ3VIRXFzcUhoRm4zQjFnbEV6SkpsOVU4bnNNUkpNU0tXamQ5NE1N?=
 =?utf-8?B?ZXNWMFhnWWN4a2lrWnZBUUlkbU5HYjIrcGZxbXFkTE1rdXQrcDk4Qyt0clFM?=
 =?utf-8?B?VFZ0YlhMT29Wb2FUWkxJK2hEVzFlcmp4dzZkSXFwT1dGTG12ZXVXanF0Yjhx?=
 =?utf-8?B?S2l5Um9hUmFhTmx6eFBRamhGZVY1dWRTcCs5elZUUzlwOTVhUktCcmlvQzB6?=
 =?utf-8?B?Yk9aV0VZcnhXaE9Ka1lvOWtQS0hJN3c0a2dmMHdlWloxcVlzT0tSSFJBUXB1?=
 =?utf-8?B?RTZtUDhYd1Zsb0VWZG5VdGVWd3ZFU2xrc3F3dEVOdEdWSmdmby9yMTE4Sktv?=
 =?utf-8?B?bnluZ1BmTkpJYlVaMUJFQ2c4dzBiOVVDM0lPdHBIUE50Y1BycGxHUnROWTFq?=
 =?utf-8?B?L2xWMXh4MnkzK3ppQVFqOElZVHRicTZvZ0puNkpLeEdCK2N4bDVsWGNpV0lh?=
 =?utf-8?B?RGZIMWNkTmVOWVRMemZYZ082S1gyVUFKRmdPbnQ3OGtWOTRPamlKMzdhdlpR?=
 =?utf-8?B?akx1MjhCRkZXWFAzRUMwY2NmVHBuRUcxM3BPZC9XdlJNaU45bk5rWTY1WWVj?=
 =?utf-8?B?MnpjOWlKSTFSeU9MbE1ZVkpydTIxM2FsSk5HMHk2MWdFSHg4dFIrV1JleHh6?=
 =?utf-8?B?QkdVeHpQaTVYUmdVa3hjdU5Qc21CMGU1ZlpoSGFlZmE2MEpZQTdzUkJaVnJN?=
 =?utf-8?B?YjgzdnJpOEdxdHVwTkxnRGFNK1ZTSXJUS1Q1ZWhnR0RheE13a3VzWmd5cG8r?=
 =?utf-8?B?YXRjWFNTRVI5OEFiaWxLSHZ3aHM4VHpGL1R5aFEyOHAvQUZGRDFZRGVIOVd1?=
 =?utf-8?B?RUhXb2tFVmtUTzBkZVN1ZGN6TlgxSzRWQVlQVFVIcFdGUEtpU3pIZGpMRyto?=
 =?utf-8?B?U01CL2hpd2c1Y3RsWFFwNWZoam1tK0JJeWlLY3U4dlV5L0JNS1RkMGo5RW81?=
 =?utf-8?B?K044QXBkZHE5UTRnRXdza0JyNy83ZUlyQ25GOXVQMGJMckd1ZENKVDU1TmQ2?=
 =?utf-8?B?a3d1bkc5L0I5VFNORGxuUUFiUHFDMzcyblIzZFU5QXdGQ1BOS2hFMUVINFJp?=
 =?utf-8?B?S1pvdjNEUlpYYWdIOWZTWWFCWVZTbC92UWF0VHFaTGNweHlnRXF1bnNuYVll?=
 =?utf-8?B?MzE3WmNPVlhxTE82R05idGNTNXJIYWVlOHRNMjBIQ0pXS1FPRjFUcFZXN0ln?=
 =?utf-8?B?U0EzZmVtVndqOCs2UlZZSFlxLzd2OHdEMzMvbVJJeVRGWUVHT3QvZzdmN1o4?=
 =?utf-8?B?U3hldlpqWGVGYWpWRlE2em9DckRramFMMmw4NGlENTFlT1pkTjU1UFZpUG01?=
 =?utf-8?B?VU11amc2TERYbDZjRWNyUHNYL1h1eEhoZjVWZ0UzdHhWS3RObTdkNXVZQWRU?=
 =?utf-8?B?S3E2ZWg1dExlS0hzc00xZlR5UVozY0xYRndNMUx5cFhCMjgyUEIvZVhSdzkr?=
 =?utf-8?B?MmZ1THY2OU5BZFd6eXBqVzk4MEZPTmVSdlpLSEJhb0EwaUlTL2hCaks4cFls?=
 =?utf-8?B?K0xsclJBdjAyYTFoRVBWMk00VkdqYUUrd1Q3Q2lDam1mV3ZnTHB5VFZhSk5m?=
 =?utf-8?B?UTdWb3hDeWo3OVowTVNLZ1NPUkhzQWIrUlozZnEvOHlyRURkQ1VTT3F4eW05?=
 =?utf-8?B?QjJaNjNMNVc5MU8vMy81UDJ1V0RoT0NkTzhKSDJiTW8rOWgwcmdlQi9ocndj?=
 =?utf-8?B?TnZoSWE2eUN4RDRJZVo4WGJlcWNucUJQeFJrcmhGUjNzd0lYNjlaUnFNYXh2?=
 =?utf-8?B?SVEyUFRzbm1FZTJ5UVYwT2ttdzJqTjlUbTZxOWhvUERjazg3R3BXcm4vY3dF?=
 =?utf-8?B?aDlrbUhnL1RKR1Rab1h5a1BZK2lGUGZyLzVkcGE1bWpMSnpPVGhSYkJvTHB6?=
 =?utf-8?B?OUpzZ1l0K2xPcjJsdElEY1RWV0x0RWxpVTNPandJRitHdllhZzhiV2lsMzlB?=
 =?utf-8?B?dEdQVFUxOGdDVVFudjFWWjdXUG8zUGJra3JJWXd4dVdQVHJMQUdpNWNxUFhS?=
 =?utf-8?B?UDNxT2FsbitieEdKQVhQbzNyY0R0NGNqV2lnM29jaXlRaUMyR1VKUVBwa2lL?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45326630-d57e-4ef8-8471-08dc8635602d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:31:38.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8Vk6clWpQzF99Zv50h46f1U54xjICmFeN85EbpqBqVz/7TVt2GK924v4RnUZS3sOcvHHvOvOneggl0tXMcLkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8853

Hi all,

the release of the next major Xenomai 3 version has been postponed too
long now. The original plan to also include a sane real-time signal API
for exceptions blocked things, and so I decided to no longer couple
that. That extension would be a topic for some 3.4 then.

Now, before tagging 3.3-rc1, I'd like to give everyone with pending
patches the chance to bring them forward in the upcoming week. If this
causes major issues but you would still like to see your features
included (fixes are always welcome), please raise your voice so that we
can check options regarding schedule or support.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

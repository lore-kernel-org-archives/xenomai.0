Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9B3328F5
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036778; cv=fail; b=P2UkdveJbtQJcmsFKtPoynlI+ihvZv9Dm19JBSSH79O9wZjJpjl0lY4P82sV3SBvYjTRjEhnwJsBKrQ5ciSbxqBoe1WUiT6VAo+dV4R42feMPxmlcMWOOrMICopbAdCwfUxE/xAqov1XiB2n7fTDITanjM2VQvouT+Rb07Wwhfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036778; c=relaxed/simple;
	bh=py2lVo1zpiJNm58tu3UmVmbCwvqVjEBzzXdVbditoH4=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=u5mZ/CF3bF9BPsYM4qqveFcXOWc6Jxvouuvjya20Z5rlK+XD1/clE0rv2pC6Uhxm0wrOb+6iQpLB5iJAM8IuhYthWrqUBozXr6TnQNRyNU9H3VO1OQ4Yl0Fi707mLyl2iYsR+zjmAutly5hhT4rKSKfWazcW4DOD0p2nuBXbglM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uVDvsfRk; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uVDvsfRk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdWmjeU8XIFzoLLIXIdC8QwUxdnhNg1uTlSQCososOO9vPDLeG0RAKX0sN2huYopdRv9nmaklLC6sFDzNzM7iE6hEXKerjd3T5I3KQuNktu6cAaZz05UMwHCuVR4CkXvgq0WxyIIiBIWipvxp31YKzgh8aODni17NOJ+uS2SC1lJWP4ETFJiFIWSIJAPqTF1wxSDAVrefGEXfPoyZWAAsS4q7OHQC7jqMx/1xb/6QHwf9M9PsLoXOauPwLhHjM86QEOPrnvpyPaLO+6/1ZALyr/GMxwruMuFl+nnRjqXWVtGhOTXAE2RyWvwO5fUiypHOQ16vP7HcPd6u7yYLkDJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6toELyXCT6HfdkvgOmxSZnkYDXeKHTwcnb/LGp1phM=;
 b=t+DL4xHX0dzwLoThLTqgj3RONG8q5NudNzPxenOFL456Giwkf0MLhBPYW9gh43FsmG22h9ZY2zW3US2GG/r9HwDFnNTCIo36bMU79XcvZ4R1dmMp5wvckXFbVAX7v8H7wTaMPaftEVDZjnuszUdsITslygduTdCJnuoGwP5dHRsqV+QAXhHdGiB0kf1/6aCYsEtZ5FDns5SpyrzROfynf4WZZgMAGfo8qCVf2amXT4MsKOy5JNG8qCDbJwKhx5vkYezKUEFA/CqQfFVhGo8EQQzhLENy7L8dbmuXex3aBWiWGHiRUB8rAV06VayngNBiYq6rvY2fA3c9m9E4r25rYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6toELyXCT6HfdkvgOmxSZnkYDXeKHTwcnb/LGp1phM=;
 b=uVDvsfRkoyDjtXgs1j3O80a+aVM+WVGg36VwyeHT+J9TOTC2crD8SiyejfteIN6C6DqdTowY0tJuvSVB0Z1jlUbWB0IoKTLrlF6E1gDQ3tQcbw1fcJR4QxOLn7v8if11h1rpJh+Dq+/NoUAzowybU6WKpxHZHKygTiXGwxg44f5wt0NCNVzmTpas9hnVHMRIL860shyEtmV1Gf/hGcZMQ20nWHgWINHZDt7T5lpISVoArAXfjOAFnsCjvn/5pvYi/MmTf2RipRb6c+5VkkSoEzyX08qHctvp65KSGIz/xeTiNrSE+FvC6pESQc3NPyibFKjR4yH7DtSJm0XW4O/W8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV1PR10MB6660.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 12:26:12 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:26:12 +0000
Message-ID: <76574cc0-c85c-4d71-beb6-1233799799d6@siemens.com>
Date: Thu, 13 Nov 2025 13:26:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v3 0/8] riscv: Add Dovetail support
To: xenomai@lists.linux.dev, rpm@xenomai.org
References: <20251113121003.416012-1-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20251113121003.416012-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::20) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV1PR10MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: bdcc1363-8819-450a-1e5e-08de22afd531
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXVuVGZLbll5TDAyY3BJZERtd2ZDUmliZDFJZ1BGR1hMY3NJb21qU2h6eXlR?=
 =?utf-8?B?Z2R2R2M4bXkrd2M1WVd3dnBNVFVpWFhHS3BCK0pKbzFDNVVOdFluVXNIZjQr?=
 =?utf-8?B?dldHc1h6bUZDSUtKMkxQdDVHMUpRbWk4Z0x3YzcyaXd0TThFRXRxY2swYTVS?=
 =?utf-8?B?TlhFWlJUc28vcWVnUEVWMnpaaDZ4SDNjaSs0UXpVd0wyMUQySDdlQUhqUy9B?=
 =?utf-8?B?UjVLZ2pkaGdESjBHcC9RSjJkSlRYQ0hsbTdQeGNSNnNtMHZzU0d5ZGsvUnZL?=
 =?utf-8?B?RXdaMkRyZlZpR2Zqd3p3U1M1eXo3NzdMd2ZPcThEWEhkdjFxdHNIdDJpOEdn?=
 =?utf-8?B?amlwZmxKNUZNeXIrZkN3ZkRaWDdpSmJMTXgxblo2OUdxRjZGZ1JzRHlrVHEy?=
 =?utf-8?B?cWZEVnN1L0cxR2xiZ2FUVXJuQkpUYjM4c2xuVmVlVyt0RFBPT2h2L2g4NU9Y?=
 =?utf-8?B?Q2FPeDMzcEZnZC9LOFhjRUNGZjJZcUdPQ1JaOGZCYVJ2dFpvUWQxV2FhZ3dX?=
 =?utf-8?B?LzQ3cko4WGdERlVHd2NERis0ZDQ3cGZ4azY3NmdjMDZpdXBYV25QMzRubjBU?=
 =?utf-8?B?WHZ1TmNCV05UTmVIUWlPdS9hVnppNzM3QjBiK0JhMkhyRENJSVVmK0lNa2VX?=
 =?utf-8?B?Y25VNithZWhiSTBGLzNtRU1pNTVzei85Wit4RXlScnhCQUxVYWZ6RWFhVUZk?=
 =?utf-8?B?RHowdGwrckxodnFla0U5djRqSlhFUXVpOEJHMnI2RmRTdVBRdk5pOUgwWWJS?=
 =?utf-8?B?ZFF5a28yRXg2ZDF5ZzN0QmFWM3JNMStma1RqNWJSZXlTcjE4L0ZNblZ0dHJk?=
 =?utf-8?B?My9yZTJLeUE3a0hpQk5IODlzV3JteE40N0dGV0FkbmhGQmRabzZ6UnZ6djNi?=
 =?utf-8?B?M1BlenZkL0F0UU5ZSktuQUdmL2NrWXVYbkRSTW1PdWp3cWpGa2V2U3JKbjky?=
 =?utf-8?B?QTJGZ3JLMUUzRXV5bzJDZ3BlQmRLNDgwWStnYk5WMGxlUEVHV28zKzlWc3Br?=
 =?utf-8?B?L0hUTWN4Vm9HTWdzUW5oSzFlOGw4ZC90S0xGRmFzZU4zM05GSWovaDhWK3Y1?=
 =?utf-8?B?ZU1kY1lDTFJrcWJUbExvTGl4dmZTREJ1czBGTFVFcWVCTG5aNlZDSnlnWUVC?=
 =?utf-8?B?VVBBSmRSV2MvYUVJTUgzaFp1K0Z5MGlTV2FvQkd2RmsyTUs3YkttOENRNDk3?=
 =?utf-8?B?Qi85cXB3eDRQaGRnbzQweG9KSlNnLyt2WU9qbUREVkRLN0dlMi9makRDZVBK?=
 =?utf-8?B?VFUzdFdPeVJ1Y1NaMzdiL0RlOTg5WUh6QVIzTVMvTFJEb09CREFsV05hM3Vt?=
 =?utf-8?B?ektjQS9tUXhDUlJaT2dWcDN6MXEza2lzRklwSnQzY1ZZOWVrYTI3M3pJZ2M2?=
 =?utf-8?B?QkJlbkRrb0YyUXdOejJId2hBSWZnRnhoOHpPaUhNQm9uUndSZlU3aEhGeGdQ?=
 =?utf-8?B?OWZLUWtoa1VhQ3JXZHV6bm5xSXFNUWlmdU5jUFpVTHhXSHM1YjNHUU1oZW1w?=
 =?utf-8?B?VkMyZlZzTmpMbDVYN0R2T24zMEtGY2d4SUNUOTFmekhBS016eHlERER5MWZi?=
 =?utf-8?B?VUFtbUZJd3o1M05YS1dlU0FidmEvekw4RUZoKzdkUzVUNk5OTVlLSzluaThj?=
 =?utf-8?B?ZjdERWlLNVgrYTE0Q3c1MEhPZlh2UTBzTVBhNWw0QVlPOERxNXIyazdNT1VQ?=
 =?utf-8?B?WXJLdmlKOTRoZzlFRFRCY25iWmIwRHZwaUJHZDBTejE5VDZtTnVTeFFCelhC?=
 =?utf-8?B?TUY1OVNwM1VveDdHanhra3ZwWlEyZzdGN25rTDNPVUdNWnhXeGl2QjBLTHhH?=
 =?utf-8?B?eEJLc3lTdW95bTRSUU9WWkQ5UzlaYkJSVndwdDAwV2xmWk9KckRjOUZ1SC91?=
 =?utf-8?B?cTVkZElSZk5ic3Y2TmNmNi9OVGs0NitvZFh6K0JieWpRSnpkQmR4WTdWQzJH?=
 =?utf-8?B?RDFkQmpuWVFQbDZjNlh4MkxyZ05DM2poWTcwWkdZWnhYa3lKMU5QRnV3NFI2?=
 =?utf-8?B?Q0lnV1psMjBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVpLSmlHcUtrQ2U4Z1RRSitsME1tSmgwTWlOaWJiczhXcmNVMjlSK1diOHVK?=
 =?utf-8?B?SHgvcUQ2Y1ZvdE1xTytKMVU0cjc5VFBnSDdBaXE3QnRubU1BSkEwR0V5QUtn?=
 =?utf-8?B?NDFyWVNLUFFmYTdVY2pMR0J0QmYxU21sVGJ1c0FOcjZuUlIrM2ZWb291WUhR?=
 =?utf-8?B?ZUJ5a2c1Q2E0S3ZoeDVpaUwyT0VlQXp0dVdhWW5lNnRhL2NBb3IrUWdGVkJz?=
 =?utf-8?B?S2t4NEt5cGxLN1g5S25Idm5QMHdFV2JFQjZabU9UTjl0LzUzNzlobWI2a3BI?=
 =?utf-8?B?NW9XRkFiN3c4R3JEcitwa3JIY294TEo5MEFkKzVSYWowZFFFMjJJZGdSVUd2?=
 =?utf-8?B?UFJMdytXVUxCTVNzdWo1bEhFMTJTeEcvYlVXbWFyS2xMZ1FzWFJpUnhDNTNV?=
 =?utf-8?B?TEVIc0lFeFZEWVg0TTZiQXJwYi9QMnQ5MThkVThYbWdKdzdoV0YvMHRuT244?=
 =?utf-8?B?MlhsdHFTQlNzMGlmNXo2WTZhNW9BdnhYQjU3Z2dCZlZwZHdkRzg3MEpZaW1Y?=
 =?utf-8?B?WTh6cHRVUldQMnNZQVAyVDd1N1dVNGxlOXYralJ6YUJyMkJXMVV1ZDdnNW81?=
 =?utf-8?B?U1BQK2xNTEI5eHZrWjNIblB6R0tmczhTLzVrS1NDMHJvQUhjc3h1ZDcrYjlO?=
 =?utf-8?B?bGxCdDd1TU1ucDhUb2t2VCtUODc0YXIxY0ZqdWN4TldkUkZVQnVBNlJLU3RB?=
 =?utf-8?B?T0hJcGVnMC9oellpdlNqZzh6cll2Nmo2YlZEaWhoWGM4QTFGOEhwMWJPcEYw?=
 =?utf-8?B?eFRtOFlpcDdnNHE4NFV6REVhRWJGSHFqYWd5c0JadVV1dEpZMzUrWmc0cmcr?=
 =?utf-8?B?eHVUbllOUVAwZTY0R2FVdXdoUmNmNDVxUkdIS1R4VWFsbHpjcVVtaTM0STdN?=
 =?utf-8?B?WW5xQnVVREduMU1wM2E2MUo0bmhQRUI3VXhoNk9XTU80bHpNNE8wQXNwNWtp?=
 =?utf-8?B?eHFDQVJSLzU1djFleDBQWGZTNmczL0E4aXl1SmhTK1h3dmpjMEUrT2NPVmN5?=
 =?utf-8?B?cDJGSkVYdk44OXBTK0NwNWxCbk9udWhHU0pvWjFOek00MGQzdzNJWGFJa0Qv?=
 =?utf-8?B?N2VFY3FQNC9XSlJGOU1yVGttMUVZUXBEaE90T3k3Rnk3dXdneC90L2ZLd3k0?=
 =?utf-8?B?bnRpMVlLSmF5TmdGRDV2dk8yQVBLc0c4V2R6SFFBWm1RV2lTNlJydUNoUzZP?=
 =?utf-8?B?Tml5VTB6TVRjRnlIam5iMGJqME1FaDFjdElRQStVNSt4Uk0xN2dSRXZlR3Nu?=
 =?utf-8?B?WEk2cTNRVnVWdm0yNGJIbXdhN0VQM2pFUk9xck1TU3NjU3hzT2k4ckp4ck0y?=
 =?utf-8?B?aWtNMExmQVlPUWQ2QUNkL0g1TEZRVTlVRUhZbGpRaHhhSHpHeFJMcnRsMzc5?=
 =?utf-8?B?MU1MMjdlVHdtU0pGZW9PR3l1SXJ6aVprdFR1YW9heGRXSUpyS0ZNWDk1MSs3?=
 =?utf-8?B?MG5ydUkvcFZqUE1vdGEwNmMybVl1bE5NdkptU0ZjSFpFYTBZQ2hPMTkrSEZO?=
 =?utf-8?B?NzJFMStWYU5XMGdheGZBTlljejF6UGlhaXI0VmQyd014d1pLZlJ1Vm1lMklD?=
 =?utf-8?B?Y25XS1J4eTJDSjAzV0dNR29aZW9lakNjY3haTEtWS0E0WUhyYjZiVTVXSWt1?=
 =?utf-8?B?QVRKVU1Eem9SeHZ6b0RIYndjc08xai9mbkJwN0JQaVJHRGNRcTZqZU90Rmlz?=
 =?utf-8?B?eXJYdk1aS3Z5aVo3akFQTjNKRlM3OFU3WmNGbldKZ0c5MWFFcUZWaitCbTRq?=
 =?utf-8?B?NGRpV0tJWmFWTkhzMUNVd1BNRGZoZmNNQTlVVTNNQkR2Z09mSWNYQmFicmNH?=
 =?utf-8?B?ekZ3YUNXSmFTd0pPQi90WnRNUGNpNURkUENST0ZjRW1ITDZROUNXeWJsWU1u?=
 =?utf-8?B?RUozcU02Yy92V25zajBhd053SW1OMjFnd0pzOEM1cVQrM0pJUkFVYURsWHZE?=
 =?utf-8?B?R09LMWwxbHZSRVhmdGdTU1dTYXUzQWowNVFTbXFraFhLZWhsVlRDK0o0ZDhs?=
 =?utf-8?B?bTRyTWMxZHFhK2tWU0tBcE1Kc0VZWGpSWUI4RHdvTXFmbXc2RmY2czlCZ0Yw?=
 =?utf-8?B?djNUQk9XcXhyajRhMkU5emtYTlJuMUdTSVN3VHBoR01uNW9qMnFXWEdlVld1?=
 =?utf-8?B?d1phdmN3SUg0RXhKd1pUUjRYd1kwM0NEbkE5SkprbTFaZDZOOGYzcDl1Rzds?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcc1363-8819-450a-1e5e-08de22afd531
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:26:12.5742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDd0Kn/hhog/WP336XnJ+w0Ejdnp4/YfT723Doinw18EILOEckx00q8+pPN6BTj5/T1j7P5/MJDT5a6esx7fysqEProey5YIMnmww73ghEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6660

Hi Philippe,

The EVL testsuite is running successfully on QEMU with this set of patches.

I’d like to ask how we should proceed from here.

If possible, I’d like to merge the RISC-V components for xenomai-images 
so that we can set up an initial testing pipeline. To do that, we’ll 
need a development branch that integrates the Dovetail and EVL 
components, which can be referenced.

My private testing branch[1] is currently based on v6.12-evl1-rebase, 
but I’m happy to port it to whichever version you’d prefer to continue with.

Best,
Tobias

[1] https://github.com/TobiasSchaffner/linux/tree/tobsch/evl-riscv

On 11/13/25 13:09, Tobias Schaffner wrote:
> Hi all,
> 
> this series introduces initial support for Dovetail on RISC-V and
> adds some fixes to the current IQR Pipeline implementation.
> 
> It is based on the current tip of the wip/dovetail-riscv branch.
> 
> Feedback, suggestions, and especially reviews are very welcome.
> 
> Changes since v1:
>   * Disable independent irq/softirq stack usage when pipelining
>   * Drop KVM changes as long as they can not be properly tested
> 
> Changes since v2:
>   * Rework trap handling
> 
> Best,
> Tobias
> 
> Tobias Schaffner (6):
>    riscv: only store interrupt enable flag in native_save_flags()
>    riscv: restore exact interrupt state in native_irq_restore()
>    riscv: save program counter in arch_save_timer_regs()
>    riscv: add initial dovetail co-kernel skeleton
>    riscv: add out-of-band aware trap handling
>    riscv: no inpependent irq/softirq stacks when pipelining
> 
> shannmu (2):
>    riscv: fix interrupt enable/disable order in native_irq_sync()
>    riscv: add dovetail-aware memory management
> 
>   arch/riscv/Kconfig                    |  3 +
>   arch/riscv/include/asm/dovetail.h     | 23 +++++++
>   arch/riscv/include/asm/irq_pipeline.h |  1 +
>   arch/riscv/include/asm/irqflags.h     | 11 ++--
>   arch/riscv/include/asm/mmu_context.h  |  2 +
>   arch/riscv/include/asm/syscall.h      |  6 ++
>   arch/riscv/include/asm/thread_info.h  |  9 +++
>   arch/riscv/kernel/traps.c             | 92 +++++++++++++++++++++++----
>   arch/riscv/mm/cacheflush.c            |  5 +-
>   arch/riscv/mm/context.c               | 18 +++++-
>   arch/riscv/mm/fault.c                 | 24 ++++---
>   arch/riscv/mm/tlbflush.c              |  5 +-
>   12 files changed, 167 insertions(+), 32 deletions(-)
>   create mode 100644 arch/riscv/include/asm/dovetail.h
> 


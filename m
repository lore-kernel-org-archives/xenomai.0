Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011015.outbound.protection.outlook.com [52.101.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2823A562
	for <xenomai@lists.linux.dev>; Wed, 21 Jan 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003011; cv=fail; b=V105Eokm2AHfRbItUJdcKXix7IOFPfwLEzoS0yw5uzCWYSenViGyk5ZXlkw/63/1MBqTM6OMTlijy7UR6yPy671fmcqTlagTXjsh8Mu6W48PVb1db4TF3+r48FWkSdQjuRc061zciej1K51BNpi/Qcw/f9t3inhsZ3+YGlg+UKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003011; c=relaxed/simple;
	bh=O0tNLuArmiTuWbTi6y4r7eMuSPMTIKUuXeKZTwwEwKg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PT9gPBVCz5XxTC1KBqRKIDVTZSnBY43rgVG50lZp3m1nLbDNQSY7QGsOgkrLJ2Hsu1VQbSjHsVnq60NV9bdKZtS/umqUW6TFyekEGoMwDgAR4pkYznvhCAxEY7dyp+D2Uohwa9xzOrvUsgRjdGgRMc+QpwIRKJ84fjE2xP0Civo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pIvQm3E6; arc=fail smtp.client-ip=52.101.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pIvQm3E6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObMHr3aw3bZdkg9UiZm94cVnqtpog/cHFhQ2Oqd/1t8BZL6S0RkBkzChqsi0O6fRR2tGv+ZxUkntl0YtkOXfxbRnnvtI1PYUwUE+fQC3dhKmOR2StlQj1pW0qpid6eLGBpP48CWPVYEB9o2Vv0lUxmiLkihlTE5Ooi7RFxZeGrn4c0LroPMrAELhcn2TCsoWDySX1KMyos2RI9XF3LNZk0s+XC5cWRPUhnS8ol1ZYcsPxk/SBf+Dl+3LBCyR5Sj6g/RaS9vGb/I34ZIGa8DMMio0mvTnX2V4J3GozkCktrFMPbcbm0+raJX8rHevqnOVvm9ubaQ4/sK9MGNiKimlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0k+r3wn/miO0XO8HzN+DWDJMFUuT4Lx5gKqt8zaNq0=;
 b=L6oKSGZzZMvQ9u4rYF5L/JN/Q2la6duu1ly72+EBhicFJYlJY5HYMTdnblGrX900vw25qp3HnfMtgcf3PKMIXiVGvj1Ug27CWXQkzjrSXiwSQfkEst2OPO5p39QOQifNV+bsZZFmCOv5ZVs/000bGEaM0/dGeUyYZsyQsb/zAQOx+vr+hVO3+Ur61FWEMX74c9MXcYXs5EiluVcz37vgQehqu+qEIucTauFlMFUHsY1fFW9vNGqKL+hFSm4r5Cx1WnIHjr0g7fm4aS5rYZIzx/xyt1K1t+e/1WAP36U18TRuSDuPPn+JCXcbmICGWPXcRfUONvU7l3r1AeNK22v1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0k+r3wn/miO0XO8HzN+DWDJMFUuT4Lx5gKqt8zaNq0=;
 b=pIvQm3E6qMSANdMX6fFf0emORl0Do88b8bancfoDCD4+LlKkTHW2EoZtk0bI6E9cIVl/ndIEeHwiHIf2BnJyAN7Db0xWpJr5xbjBxPVP0+hrzZBt1M8oibmfpuAS8niffRxo3nY/HQlTeBTwBxeTaFYZSliVTZsC3WMO+rrI9od/v8Xx13/YgOSUlXA3OE21jZJ+AwBK3jR20zFFej7lGUTsosTn+7zNWqZJo+lSrWatLlwWce3QFQczYI+3ozHkb9hfW8MY9M3YbY+nXHjM+I4xkSPXfssouTTfae4z09EJw+VrwDX/7zxu+ELbMDaKpNvUsJ4z+0qEbd5/MP4HAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 13:43:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 13:43:23 +0000
Message-ID: <bf3e7a23-0b43-4974-9037-a49438aaad06@siemens.com>
Date: Wed, 21 Jan 2026 14:43:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Meet & greet at FOSDEM
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <dce6da1a-7ebc-4d5e-af4a-bf55142a95cd@siemens.com>
 <CAFc1U0vYDM0sS_BvNh7VHH=j9aFkfteabawTctkae6wwQmx+CA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0vYDM0sS_BvNh7VHH=j9aFkfteabawTctkae6wwQmx+CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:610:cc::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 31132edc-2ba3-4471-a06d-08de58f30b4f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzNBdlNlMVRPMGx2L1VlbjRpOTNVeFlWT2JHSkdtRm5HZFlwNXN6UTlqWjFs?=
 =?utf-8?B?M0FFT2RoSVczVmdiYkNaOGcraCtDekw1eThKZklHekg5ZVN4d0ZJbHFKbTV2?=
 =?utf-8?B?NUIwaml4bEpFUFJqdHI2Y2o5Z0kyZlBjK0pQOE9HbFhyeDlFMGJuS3JoeEt6?=
 =?utf-8?B?Z1E0dklKU2lGSlhqYmxHYUhnTmsydnhlSEJLd2liU3h4TGZpMDFUSHZnak5I?=
 =?utf-8?B?SnA1a2lKVWY1bllRajZlS0VnWHpmZENJUkJTekFlelJrVE5BVHhhR0xaNHZk?=
 =?utf-8?B?T1JxVFZlQlU2WTkwZ0R0S3VpWHVMd1ByUTFLZzI1RnVtV2x6dUs0NkhyampI?=
 =?utf-8?B?MTNhemdsWW1hcVl5TXVodk9KWUNNMkRReXFxQmtqUEJ5eXJqWWsrbC9QclRP?=
 =?utf-8?B?M21sWUFxZTBEYzFBVGg3TXhHdmMvMDlUTGN5QXZ4VWgwLzRobkw3d3pPVE5B?=
 =?utf-8?B?RWJxRmVwWkFaVVRVTHVvTVF0endGS0Y4UDZrWklqWnJoVkNxeTA3M0R4dkZP?=
 =?utf-8?B?MSs5czltWGliRkFhRkRqZGJ0dUpuUWVTU1pRdTlGR01SQ1RXekhvSFlFeCtw?=
 =?utf-8?B?S0tFN3lSM085RDFBNEw3MnNmSVBvL2VKdklxUUtlNmpMYWhEOUo1UWFISlBE?=
 =?utf-8?B?d0RMK09zejZrcEtmcnJiYjlRWDhhQ0NzUllkV3lpY0tMa01qbFRBYnZ5Nkdw?=
 =?utf-8?B?Wnlva25iRDR0RmhpbmZ2V3d3eDR4NWdpUFRydUVpTDZZY1pzVFFvRGlWcDVG?=
 =?utf-8?B?bnhZOG51cXFBNTZrd3Q1T3BrYzNMeTdhelpFaHdNQXB0SDU2OXpBSENkWVBh?=
 =?utf-8?B?WHcvZDY3U0NyVHI2d0tLaUN5K3liNjFMWXV0eU9ZUlBkejhoV1hOWk52N1Iy?=
 =?utf-8?B?ZFduM3MvelRWbGZTWXB2a0FPcnA1Y1R2cUpENmpVT0k1cTdvU0FOYXJFdWsv?=
 =?utf-8?B?NCtjcXhncy9vWGMvZjRNRkRUWlVEQ05VRTNnSEFBN3ViemdBMnpVVjJVYnVE?=
 =?utf-8?B?VldWckVrL1ZOcGFuZCtNT1RMd0hpYWpxazlNWDlPaFBoVUk0QWIybzlUaWd6?=
 =?utf-8?B?UmdMVVV4RU9lSzFPbzhlS1J5NlREQk5VZmVtcVYyRjdXa1pZZ1Q0S2JIREw5?=
 =?utf-8?B?RkZNRzRNTHdiaVkxS3JmWmVZZlhTNFh0andoN01EVklieGkwd25kMFBremRO?=
 =?utf-8?B?UEVxTlE0eWlJTjdkd3VDbXJRd25ZTjROL0JqUGNndEJzTHVHV1Vsb1JrRnFN?=
 =?utf-8?B?WVorc3EyL2RoQW4vTit2SE4vYXBJc1pCMjE5REVLWi9DbGMrVktxTmE3VDFW?=
 =?utf-8?B?Mis1b3ZGWmNaN3c3SHQ5MGlBaDl6ZXlUZE9UTmhJWWthdFdQUW1OK0JtYkZW?=
 =?utf-8?B?b2N3Q0NJK2dGRXVoWXJmTGJlZ01UYXlSWndHZjBhcXNIemhvTDJJdWxTSGFJ?=
 =?utf-8?B?b0FqYjE5Sk1HOHpRYWQwTURaTkdDemxtcHA4NVRIbzl5MWR1WUtvMXBPbmZT?=
 =?utf-8?B?cjJBNFVFRDNyVjN1TGxwc0VCWVIwTjE3Y2pCZWtveUNMOHByZ3FYK3BPOG4r?=
 =?utf-8?B?OGh5WFI2UFpzdkNYNk0rcGRHNVQrVjlQZE5LNUdQeTE3cEF5YnlRTE4zQ3g4?=
 =?utf-8?B?cE1mUjNmUFdBMW1zck1CY1RGVDJFbW1PQU1GQXBUVW1XTktPTHJPdnJmSm5l?=
 =?utf-8?B?RStMUEg4MUNTd2tTdmJCanlhR0lkUkVPdGxQMWt1QnBwTDloRTkxekFjM0Qz?=
 =?utf-8?B?Ri9zMFZ5cEZkSW5mdExVTmxkR3lJRTFXVGdCN21WWUZEZXp5L0xSOCtEb3ha?=
 =?utf-8?B?NWFKSEU3dVo3ZCtEeFNXMXVyanNFMGVadkIxQjl6ZHhqV3crVy9sek5lWHFO?=
 =?utf-8?B?L1VLbXV2aGg3SktmYXMwVVY1SXJ2WWcwRkNVSk5QeVNia2FiYzlTaGNCbmtK?=
 =?utf-8?B?T29WbFlZQXZsVjZYWThJY3JrVUVLNlIvM1IrSElyK3o5RjI5K3I4MzBBcXZ4?=
 =?utf-8?B?MTVRTk9GYXp2dUFKNmR3bXFpRnNNc2lHSVpvbElqT0R3TnZjQ0xjaUpidllR?=
 =?utf-8?Q?S1+0DF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REp1QVgyUEUzMGliRnAxcTRiOGxuaElRV3RIRDZkNmpRbzY4N29kR3I4VWdn?=
 =?utf-8?B?TVZhMktBcjdHNDVneTBFUDZJZTJYekthNldvLzV0Mm5mUWdJeVZINHlZeHVm?=
 =?utf-8?B?bHRaOE9SdzE3MElnVytVMEVlR0hrc0R0SitSN2FUcUpEemc5QjM3dGpUQndM?=
 =?utf-8?B?aVRpc2lPWU5sQlN5ZlMrcGt0aGtXME55a3FNOW1XWko3cDVwV0VZZEhYTU8v?=
 =?utf-8?B?dVhwOUREZ1ovbEtkWmJGYkQwWTczbVJKaFdKSUdrNkdaSHo4WHFjVHVzY1I4?=
 =?utf-8?B?ektGOGFUbFVaVWFVNWhibkczR0hQSWFPbXR6UnZITUVYRGRHazhNVitJUHlz?=
 =?utf-8?B?WHZoUlE3cjh5cG1RTnNsWDR0RUo4N25mZ09CN1lSVUhrVVFNTDRlWjJJZjRZ?=
 =?utf-8?B?cWhma3QzMHFENVpZLy9VTGNCMzhlNzhhOG1XNFhwQjVlY2V6UGY4NEtHaUFQ?=
 =?utf-8?B?Q1l0Uk5TU3pOeUIvZEdLQUc4VWp1L0RwMjMxdmZ1UnZndkFoV1FnSXhLb3Y3?=
 =?utf-8?B?dTI2b3ExcDVrV0I0cURtM0lXMHlGbzYwRHRvUG01ZHVRZ1F1bkhVSGl2eHYw?=
 =?utf-8?B?bEM0T0ljMERqbWRHazJCZXR6cU9TU3B0Q1lCMWRxSUJuYjVnMVRTbHFhQk1S?=
 =?utf-8?B?bWhJRFd1T09TNVZLWHFkeUFVRHdVNlN6UjA2cVNVdk5BeW9ZQS9CTWdqTU5s?=
 =?utf-8?B?eWJLRHFLTWFRZjM2M0l5MlJVMDN0emVBVVBDN0R6aVZyM0J3ckI0WFZrUGhK?=
 =?utf-8?B?WWlETC9UUHhiRXFGTkcvVGJXdG5xQjhxNUpMYWkzd2pGS1dLWVNYQTFQYW0z?=
 =?utf-8?B?a3JlS1BSVDlRTkg5eFRoSDIxTFovQ0ZXVnJDWmx1SWZpUHpWZzA3aGZtekJp?=
 =?utf-8?B?akwrd0lwUHloYTlkT0pnZlkvSUt6ejVvdEJOODU1SkxkalpEZ0dQTXljeG9V?=
 =?utf-8?B?Um1tN254RmFrVkdjbFJSNGVxVVBjVGp6aGZwcC81MmRockZiK1FNRU1HbVRB?=
 =?utf-8?B?QkxwZ0wrRHh6UmRwbW5EcEoveWlXaXRGNzFxV09aQ2JtTDFZOThYSzFyejlz?=
 =?utf-8?B?dEYvbnk2NzdwQWhyVEpOQ0VSTTBGUFk2TzZCWGxBcWdVMTBmOEVmSXZrTHdC?=
 =?utf-8?B?b2wxN3pKbDNjSDJSUExRT3U0M3RBc29ORDhZdVljUjl5c2cvb2l0ajZwMEkr?=
 =?utf-8?B?ei9ERm5KU2ZkVWlmakNBSzliMDhBYjYybjNQK05mTjZuUitldUI1ZmpVMUMy?=
 =?utf-8?B?c0xHc2FQSnA2QXhLZHIrSmIwTjRvczViYVZndGtSL3Y1YlMxcTVtd0dyZjJN?=
 =?utf-8?B?dUUzNlhoSlNzT2pMZ0RTSUJaYjJzcmNtZzliekYwTmhVSzBzNkNPUGZJS3NP?=
 =?utf-8?B?VC9HeWN0dk42bnNwNlhkbVNITHprVnZDRUFMblUvZHh4SWluZ2F1ckZtdWY3?=
 =?utf-8?B?bnljMkpWRzZobmkyL3BGYnZoS1E1VlV3aTE4dWR2bUFDNnowaTdIMmhFOHdT?=
 =?utf-8?B?dC8xK1B4Y1RwMEZXMkNCVTBETHN5M0hWWm96YXFqeTZuU3JZaFZTZi93UnpQ?=
 =?utf-8?B?RVk2SHJ0NGNPd1ZZMEtGdTZKN0M2S1RsQmdKbnhNUzJCd0ljbFQ4Rmpuc3dI?=
 =?utf-8?B?ZDJINU13T1RVeElMYm00SXRnWlJtbTd1a25GN21yWHo5NW1VTzlNc00wdlF6?=
 =?utf-8?B?NCtpcFZlVkxQSzZWUVhKbHNrL3U1NVU1RS91MjZUMWxOb25rd3ZTT0pYbnlj?=
 =?utf-8?B?aSsxSkZKRWFmZ0dYalpEMmNOWGF6dXpRV3VSeWYza1ozdXB0YktteDN4NUFx?=
 =?utf-8?B?SXcraEthdTZvSkI4d2tlMGlmMWI4dkhudzhZenorbUYwcHdWeWhyaFV5bVNz?=
 =?utf-8?B?WVBpUDJNblBtV20wYlRnUkp2WlhJYitJOWZXVy9BcnVXSjJjZjR2aGdqMTc3?=
 =?utf-8?B?eFdjdjQ5d3pRNGdUdm5VNmhmcGRJcUZRVHZxL2JFR3RkRXVoU1YzNWt5c3pJ?=
 =?utf-8?B?M2lDNG5YMGpuT08zdzZCeGxaTWRQMG5UajUrM016Z1c0aXF4d3R1NW9iRDc1?=
 =?utf-8?B?RlZYL2txVEExYys5R2orL1NqOCswOEUwNWRkakxJb0VSeTRza0FxRGxLdXhR?=
 =?utf-8?B?MHNmZ3Zma1AwSnZjeU82NndYakdobHFxemE2NzNPSk5vRjhMYnVoWk12UitG?=
 =?utf-8?B?TXJFQWluelM0bHkyaStkeFVQaG5YRm5Zd3NTaXRrKy9XZjVSVjQyMEZESWdi?=
 =?utf-8?B?SCtHeDhaeEM4dXUxMkVzWnIyc3pXOTc3cXNYaGoySk5HNWNLcHQwTzBtU0FJ?=
 =?utf-8?B?NFBxZExkWktHeGJuQjVicHN0TFlJQ0JHU1dqQXhJdGpHc1NsQ0ZPWjVyMmRq?=
 =?utf-8?Q?qAAw8iUQj+6oT7Os=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31132edc-2ba3-4471-a06d-08de58f30b4f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 13:43:22.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWtblt99ubjxLilnw7Jm0OhYEoZLP7TaolgC7d9YDZLWL5oDgYObP6TIBjv40ndTp26ljsANKoQRbQEWG8LeBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6244

On 21.01.26 13:40, Pierre FICHEUX wrote:
> Hi Jan,
> 
> Did you plan a time for an (informal) meeting ?
> 

Depends a bit on the amount of feedback. But we could also just define a
slot to meet e.g. on Saturday, 14:00. I just do not have a good idea for
a local yet, one that is easy to describe and find.

Jan

> Le mer. 21 janv. 2026 à 08:48, Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> a écrit :
> 
>     Hi all,
> 
>     in case you run around at FOSDEM next-but-one weekend and feel like
>     chatting about Xenomai a bit, just drop a note, I will be there as well.
>     I'm always curious to learn about use cases I haven't heard before, just
>     like I'm happy to exchange thoughts on how to evolve the project
>     further.
> 
>     Jan
> 
>     -- 
>     Siemens AG, Foundational Technologies
>     Linux Expert Center
> 
> 
> 
> 
> -- 
> 
> Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr <mailto:pierre.ficheux@smile.fr>
>                              http://www.smile.fr <http://www.smile.fr/>
>                              https://smile.eu/fr/offres/embarque-iot <https://smile.eu/fr/offres/embarque-iot>
> I would love to change the world, but they won't give me the source code
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

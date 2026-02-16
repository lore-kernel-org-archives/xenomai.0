Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D621D599
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771246293; cv=fail; b=oo7c3DkGhc4qlZS2Cd+RoQ3Fosj+VcIEMdtp/UnM6IyFTFUxlHRliyrChqL/eW4h3samB3uQYBJmCecHwP63E9B4VZsJA1vuVj6v4Z+VPaP1/VBX/Hj/h47LmcZcPxstIl9cKwnm6db+gaOzSuQzRmJ8Ng2mH81OZ45dWLciQo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771246293; c=relaxed/simple;
	bh=AQnHAnU4ZDqrvyZFNlQLKNZNKpVKWrv2fKrFI0ycOaM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=efuV5kWBgkoZoJcM3Lv2VwT/1DF2u5YnxUPGpyHBFUidXplhWkGW52XJRyxw4QzAKU65rn8DowexKdSeP0a5vOhNAB67aPjB2w2X6i6ZowCvu9YeJHvR0kX3tRdRB2nwDucRQU7BIA20t42JsAdyENg42Df9OolhaUW3a4fjj78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=rIePFv9C; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="rIePFv9C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKQimi0Mn8tbXzDqxc2H8ZEfBW3qjkqe+9wogGcQCg4lYYn4Cn1AhXVDoaWlklTThofEn9QWcTevZGo2cgLOpsidxpiXTPwj1z57Yr6BBvsD4kgxCUNDW8M4lg5gm8u//Fro9+38jRIKqMwVjB2wN9kVniG6hqydL3lAO/6xD7SERBXwWKW8XMU0EnPb1WVFVS3LqQ4S6NVCZO1xBAFBIdaHPoqjHFMhVDXi9DLx07FNXUeOZJe6fWEXfQqF+TVhUMrwlYjmyUDmWYPbQAcT8Hib8IdCrrQa5nvNWm3XynJbyacAko9DmCV4CLnV3aktrrI5RiWZHMC99+kNOV2YSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+b8Xd/inQF+TuUoq8ycZdowbbwKA+1P2D67hXF/X1U=;
 b=NuSM+Qt74NPngp5vdYlvRhhTOFhs4AFHZp6NuiXfaouvS+B6lvVZlf72p57YnQioYMveonc4jtMC79G7aEGzPU0Yl+MXXTTcBD1IasZc49XbTHRedpaptRAsa0ozr4CGQIBXlnJCZiFTm33BjrU3zYMB8fI0Lyu2WubGAIyKKfRpwo+WoRQn7wnJyHVE7JsLRi8Z+/zofvyOBZK3ujlKLXNxxvMzYNGuO/kyksGMAYixiTg1TppFR3JDX8t+IW1+wpqpgzElsF8lFnsnpaWJjm21sxyLHhgHFtiXS9g5jJ8NnnDurgyC3eBt4X1eP0sDUHhsZMxnSVYxuESE10cpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+b8Xd/inQF+TuUoq8ycZdowbbwKA+1P2D67hXF/X1U=;
 b=rIePFv9CpvWVwzE/a1ADsbzIKGdLtZjvTYA8Pp0zDCI3h3PSgL9i1VI12zmdmgtc58Kow2VC3rqog/PEVZk4oAFQJLOjMRQmwxEvjZxi9JmFYv2Msyn2YocmhmX6w6FcPAo/B+y3qYNRQLx9e8Rot1wQQ/zkqTBeRsBOC5tKxzrWY4Lfsl7nupKXI2rWO2YcxX8zjmr+MZc8bAO3wMyz4i2nsGfmDXzA08Swq8W0qIcOQUUM2gyw81wiiSTKuZ2hK17lsGLju4Wl6Urqfa+5Od+H8ifgVbCNY/aRZR796N22hxRCT0xFiAR6/elda5Ez1Na3COqz5p75VvvVJQ/1TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5613.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Mon, 16 Feb
 2026 12:51:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 12:51:28 +0000
Message-ID: <edce8462-588e-4068-bfdc-fcc4f6819b52@siemens.com>
Date: Mon, 16 Feb 2026 13:51:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: irq_pipeline: likely/unlikely macro usage
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <ce7ec09c-1db8-4ee0-921b-34fde4c0f59c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ce7ec09c-1db8-4ee0-921b-34fde4c0f59c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dc4e84-b8f2-421c-65ea-08de6d5a1a08
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVF0OC81bXBWbU1aNTExNk1VN1pvc0I5WGJhbE1qUWI4VFFiRGVhR1dEV1hR?=
 =?utf-8?B?S1liZlZJbml6VHdPQy85L201aFdiNTV3ekVUU0QvL2Vta2puaGJSa014WEtx?=
 =?utf-8?B?YzlieVNTSkE0aDY3OTdwR0RWZUdNaHZDV0RMODQyN2gxL0dLR2tSamk0REpj?=
 =?utf-8?B?REh5OTlEd2pOMndxdThCRkFqM2ZNeU8yZDhGQlkyeEdFRVdleno1SXZEeFBi?=
 =?utf-8?B?M3U2dXdKZXVVMkxJWU02Y0dQcVIzUGVTbURHeUpWbk1lZ2llTFJHdGV1bFll?=
 =?utf-8?B?ZkFTeTJhK29jWXJpeTZVSjZORVpjTncrL0dwNkxlZWI2U20xelpDa0l1a043?=
 =?utf-8?B?UXNDMXVyZXU1QU1ETnlWemtZeGNQMnVYOWV3OWN1MThLM3VISTA2dW03dlZu?=
 =?utf-8?B?SGV1citIaUJqa1BxWFNPZkJUMkxmUU5TQnJZRlhTZFZEMm52SGxyVXA4YVBx?=
 =?utf-8?B?b3hWWmFmNkFheFNNeXlYL2FtdjF0bGowNEFPR1hNVEliYmdGZDBFNFNlRjlT?=
 =?utf-8?B?WUdiNFdSYWwyUEpwV3diNEIvZk52MzdhbWhncEV6aUZ3a0RPK2R2OWlmcHN3?=
 =?utf-8?B?eHVNMmlXcjkvbnl1UTBHK0tmamNqNWUvVzluank4aWhoRmVYSWZmQ2FGK3Ax?=
 =?utf-8?B?TVpRbmk5b3lnS0tqek51NkZZWTgxT2dpZnJweG5Eb09YVmJlUXBCd01XaGIv?=
 =?utf-8?B?bWxqaTZFdE55aDBmNVUwYWEvQVNzZjlQUEFNMWFqUlVwUnBySUhwajhBZGw0?=
 =?utf-8?B?UkJ3aFNzL054NE9lNGIxZU9jN2huZ29td1JFVzd2ZkZNaEFPRVM5clp4Tk1y?=
 =?utf-8?B?TDhjQjlIRkZlMnJBL21aS1dBMFlKTW8rdnZaZjB0ejJlRFMzSUZjWU44ZWZP?=
 =?utf-8?B?cllmNkxrZnZhK3paRU52WVNoNndFbDlvOUhFWnlmVDB6K3ZUcnZBYTloalNS?=
 =?utf-8?B?SXBjTFpBN3U4ZTBEcmhWMVJQeWkrVUphQWhIck5NZmlpaGRSRE1VTkQvVFBx?=
 =?utf-8?B?cGVUeG44YUlLdVJNKzU5bDRFY3JVd0J3WE1kaTBsU1QxQWc1VDRmb1VmVURv?=
 =?utf-8?B?dkZwelA1STFXWERuV1ZHWHI2UTdNMjE2bHdSdisycDB3YTlUdndjWWFLV3di?=
 =?utf-8?B?ZGJiTWJRczVPWFRHemdMUlRuT1lqYnFaY3VFdjNWS3N1WGNHSUpUdXlpS0gz?=
 =?utf-8?B?V0pjZVR5d1FQTDMxZjg5SUtMR0Q5UmswOE1IanBxMFNHSWxiQVJkeVRDRHhW?=
 =?utf-8?B?ZzI3N2p1bnkwNVZIK2thb1FvZGRZVUZBNjJkTkJvM1Vtb21wdG4rdm9WL2RG?=
 =?utf-8?B?UWZYQ2YvT0VCVUh6U09hNlRtb3RVcU1aUjJwT0laemUzT0JmZU9TcWFYcTZ3?=
 =?utf-8?B?QUg5OFRrTXV0Uk8zaHR0TTA2dGtNb2xvb21tV0NOUTdHMzIzaTdJSkxuc0U0?=
 =?utf-8?B?K3N1YnJhTUdQTFAxSzJoVlFhejRsYnpoU3I3cWliTUt6eDlvS3NrSlpvek1S?=
 =?utf-8?B?Q3JiQWphYy9Za0ZwRUtkaVpkdkNDaW15eEtORWxFSlM4ektNYXo0YVpRZXFC?=
 =?utf-8?B?ZDM2RDQxRWdhLzFGZFlVdXRHN0JaUTFrekRvbFFPQy9TdEcvbC9VTDJtaEw0?=
 =?utf-8?B?TlRPbFJic0RkczNhOEdCbUhZcG1HMzljYkRBaHVldU05cWRaRG5aUlRJbWZY?=
 =?utf-8?B?RDU4UXNZYmtiRmZ0ZmRGd1pwMUx4cXZodnQvUkc3SHhyeTRpSDdJQWNVdk1E?=
 =?utf-8?B?RldjK2Mra2NZdEQ0M2VZOERNR3FGODU1K1NBNUl5dmVKZXdpcHpSOFQ5c2Vh?=
 =?utf-8?B?TVJPSXVvaUsvOXFSV3VUQnYwMWpSRlVQQnRDN2V4REtoSXdyQUJ6WVl1UWhM?=
 =?utf-8?B?WlljZzFBRlJhbkZuRllWWGdUeEZRRmpRRHMrQ1FiaWY3NDNMT2hpdTBTUFRP?=
 =?utf-8?B?dDlJR2hvNjlBeFZPWFVVR2hLOHZtdkRPMTdkYldSL1Nnb3RYVTV6ejlSRXoz?=
 =?utf-8?B?ME83SHJwOWpvS2FnTEpYd0RINmthaStMVW5rMFlMTmI3RjRrM0NlZ25idUFP?=
 =?utf-8?B?SjBTTXlHTTBDVFdxalBFVDN4ZkdYbTRPTW9iUXBUczFVa2V6Qksydng5NjRH?=
 =?utf-8?Q?kAYY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUk2amNCSmxnQVV5VVNLeGV2Vmx2QlBCT2hCWnZQRmVyN2JhaTBjckw0NGhR?=
 =?utf-8?B?SE5jUWJLSUpuREZDbjdwYUhNY3ZKNnVDdHVpNHJhRmF4NWtMbXFQdFlEU09I?=
 =?utf-8?B?MGZEY2ZFeVFSRjJ2cTJPdUllNkhQTHNrQVJUeE5GcHk4WHlValFVRWo5ejRB?=
 =?utf-8?B?TmdnUWpXalFvZ3RBY0pYWEZQVEg3Skc5M0lEdWNZb3lpeDBReEFodUNLeFBN?=
 =?utf-8?B?MDg4NU40T0trWlEzR05wVzBVdy80eDVyRjd2OEM3a3loMkpoWXlkbXd5L3VQ?=
 =?utf-8?B?clA0N0YwTGk1bEU5S3dRVDAxRnhLV3ZteDJURXFYcDdUOHIzZWRqL0wwbmtZ?=
 =?utf-8?B?dkxxeDVPMzY1OTN4a0N4T0FQbU8wRWpIK1YxdFYydlF2aTVENURIa1FJU1hV?=
 =?utf-8?B?QUhmSmE5MGwxYlhwS3dRK1puQmNYSjdtVG1TVzQ1eFVncW8rR1k0RVlrZGU3?=
 =?utf-8?B?NEhILy9RVGZTZTRXN214NjRMRW5Jb2g3SkxLZWsrLzFKNXhSZXI5UGNHRlVX?=
 =?utf-8?B?TUNHZEdQVGZaR1lVMldqZjJsWFBzT0lXT3N2aHhQZmZnTHZqQVNvUUVjT0xC?=
 =?utf-8?B?aExiRG1iT3c2MElCYjBtNE5JOHRMcHk5Z3RWVG52cEpPbWp6Q0JrNGxUVEdU?=
 =?utf-8?B?VTF3eXVUbnR6eDV2bElUd2xmQlQvY2FzYTlLM1k4ZlZ4aWYrOWFHVDEzTDQx?=
 =?utf-8?B?b29vTEVFdjFlQ1lsSmdtYXFVeFNoYnRnS2R2aFZKaHk1QkFxZCt1Zlg1RUl5?=
 =?utf-8?B?UWxIR0h3c1pobzJXejRmZU5la0tTNkVyVGdtcE8rZExDYkE3L2N5eDNIYXFF?=
 =?utf-8?B?clNLK2wwNkJPNGJzakJTNFp6WW9jWmxCRVU2RWprV3RTN3FtcGVwazl2QzhO?=
 =?utf-8?B?VHhWZzQ2dkFva2JXOWI3R1ozSm5pVUlkTFNsUjRqZU9Ed1Uwak1SbGg1aUlC?=
 =?utf-8?B?cTQ3YldMWVA4akRlUmtZWHpuMEM0aGsrc0hzNVNqOTlMMnBkVnF6MDJUNUZK?=
 =?utf-8?B?Vy9XZGpHcEpxMnFDN0FVMHVJOC91UG5qWGszazZKOUU4MnRLSnVzQlRqTkxu?=
 =?utf-8?B?d1F3LzB4alBMV3BpbDZKNndMSTQzMDNRZnJob0Y4T2xNdXRlR2s2RUl5TXVS?=
 =?utf-8?B?SUwxMXhHZXhSM3Y0R1JtRWl0WUh1YTdEa3NsbHZZZDBXVU4zbEpkZUZkZ25J?=
 =?utf-8?B?NTV6R0k5SVpWRWtDcW95Yk1Vd000V0Q0ZjhxOGYxcWdHRTdUUVpXdDBHNTV1?=
 =?utf-8?B?emk5TTF1S2hQMVorZWc4UGtpTEdmUnNpMlc1bk1wbG1odEF6S0lIZ0cydDl2?=
 =?utf-8?B?VUZFMjJmb3VmeThaZkVIVWdhVDRCZ2d6U2ltUFBXTXpiME5JblBvVDJ1VFMr?=
 =?utf-8?B?a3RUcys3RjBZUEJ5MzluVmIwZlk5VHpnM25LZVVzTW4zdjN1NlhYdjBOb2xL?=
 =?utf-8?B?dUJNakp1SEFON0xkcXVqakd5TkxON3gycXpnT2d4aWsvRS92MXg5andWenVO?=
 =?utf-8?B?bVFTbFY0dFZkeG1IS2k5L29YV2dwRjM0WnJJZWpPb2VDQyt3WTBva3ZNMmph?=
 =?utf-8?B?bVB0YU1wTStwV0tiSHV5YzhOdERNQnE3MGEwTzBMNGRwQ01BMFB5WUxjQ010?=
 =?utf-8?B?WlZGd0lzSm5NZUU1T3g3Qk1HVXRjNUttWTNBREhzcUxCR3h0RlVScFhsdDEv?=
 =?utf-8?B?M0NhTlF3WG13eUpNeTJFaFluekNXcktZc3hpMXdwTTlKcG9qTmR4ZThKbFFl?=
 =?utf-8?B?WitQYVJVYUlPeStxVmNyQVpRZFhuVVExcUUveVBPUWlFd3RScUxWSE44WnQ5?=
 =?utf-8?B?MFo2eG1BQmwzaFBRbWI4ZnNHdWF2ZTRoMFY2K1N4V2t6RzAxd0ljQTVtNVdq?=
 =?utf-8?B?WnVXVHcrRzhHKzh5cGxZaTYyMndnYVVmVUdXcXVoWVp3RGdUY1dQdjZPZHp4?=
 =?utf-8?B?UE1CZjZTSUw0dFFEeDEzelJvV2RrOXpuSkR2Z29VekhWTmoyUzE4dWdFcnRk?=
 =?utf-8?B?UVk2eVFrdkJHWmNLdXNGcjFBbkJ6RUdvelRwajNWa3hpbW4rTkN6YndZbU1N?=
 =?utf-8?B?TmIzYWlHbU9ZaGUwYjFQd2E3WXUwUk5RbjU1MmI5bmpqVzN2OFBKb21USWUw?=
 =?utf-8?B?SXZiZWw4dGZ5d0Rld3ZXUy9EQWVIbmNweCtGMWdPbTlsdXkzWlFySXU2ckhq?=
 =?utf-8?B?QzhmL1RueUFkbFFla0Z5N1lYSkV6V2IxSm0xSmJEeDUxVkdCbko3QXV4M3lL?=
 =?utf-8?B?NlZwN0c3OWVjTlhXOEFqYmhCQkl6dHRzUlNkVzV4dldrSUxrY2RPNXpvZFRk?=
 =?utf-8?B?aThRTVJiUlFDd2FWeVJoa3FUdzFOYmFEVVpmRXpHVDV1TjNMOTB0eDBPR3ZT?=
 =?utf-8?Q?f92RSYAx3ALfUJRo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dc4e84-b8f2-421c-65ea-08de6d5a1a08
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:51:28.5271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdbfWFQgzEbdBsNFKB1z7gR0ido88GOlL0rWJU8nmG+G+sX7qsEtLiixgNYoHiFAceJSXpXPEeTJMVwv9sIFCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5613

On 16.02.26 13:26, Tobias Schaffner wrote:
> Hi all,
> 
> while staring at the irq_pipelining implementation, I noticed that there
> are some locations that use the unlikely macro for the OOB fast path,
> e.g., [1].
> 
> Could someone explain why we are optimizing for the in-band path here?
> Although the in-band path is indeed more likely, I would have expected
> that we would want to optimize for the OOB path anyway, since this is
> where the saved cycles really matter.
> 

Likely/unlikely optimizations are generally tricky. They are hints which
might even be ignored by concrete archs or in concrete situations.

If they lead to consistently higher latency for oob, I would agree that
we should lean to that path instead. However, if they reduce the average
latency for inband and practically do not increase the worst-case for
oob, it might be a better decision to take that performance optimization
because the worst-case latency is what matters for oob more.

But it remains a fair question whether we can answer that question
whenever we added [un]likely... Did you find inconsistencies in their
usage as well?

Jan

> Best,
> Tobias
> 
> [1] https://gitlab.com/Xenomai/linux-dovetail/-/blob/v5.10.y-dovetail/
> arch/x86/kernel/irq_pipeline.c?ref_type=heads#L260
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

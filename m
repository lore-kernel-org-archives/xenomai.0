Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171311CA0
	for <xenomai@lists.linux.dev>; Mon, 19 Aug 2024 06:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724047781; cv=fail; b=dCG8rge0gS0UQyI+z+xq+0D42YicKEP5g1yAJP1Efgb08d0pUy6DfLxX+9nL1pKvxjIEQzEuvz0HX+9d36NIe0ld02R3mUmzGpF27hNkJQunzqeD6jxaRni5wmIlApaoH1Pk8Rf85vSgT1I4zMihXFIWwPAUtP0+PJXiMRnJu8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724047781; c=relaxed/simple;
	bh=JADC2js5lfblYa9sbQdcbAs9Skr4MplIbBb+OZwwv18=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JuUfmDB+nijEev5OeJjIWWwsYUVWlRN2Xb328LV+BDNxkNjijzPZGRBGYEaZcIEzXY+juNtVLdH6f2Iw4RX5ukHkXWNBo2ebqAP+SjXcbm6UdQME+DawX4n5P0We+rRM/yHeqq2EyWDvG3rslHElNbikf4lYPiH4Xp6lxUJ5j7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tsfK3oIC; arc=fail smtp.client-ip=40.107.241.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tsfK3oIC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcpeTJWdK0Q9Kf8rX9Z0SNd2kGgo2/+WZYNnC0Ra9WKShl85VtNu/ntG0eFrQVyfa3cyLsjsYfmNvercpt25SCK7XW83R1sVZuvlzasW7g+3C8q3d+BOvqDV0Ap/XzsrQh/hBVAWp+2tPZQyGjkFmzI6QtPHXMPOucqudm05sutmm3XfwRTtqxkHp6HGCA/tOYmTJUGQhfOi6KOPgt3kzCZAq2e6iT5I0j+Y0QB3yeF+gHcK/ln6e84D8YmlVTi/hD5KVRHfB/ioslyFjTAn7MZm0h0fnzvWgFE+jkT9Yzm9HcDknYMuCOMtFkCv/0OtyNuQNXhw3sXkyGXLHcy8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGhq0D/SzMPwuXAuvoDWm84Dg9PXBq0Qp+nhKLVIv/I=;
 b=JPawKpfJHdRPyG1wofBveYdkIoiI9S2eHcxAWHG7G6mRFlOdbXMWa/ZsRjhDzOui5/h5P93MTc6lE1pd88J4grdf4BbCk8NsJp01LbfTaTtiUE/+WUqDH78FjXnwITLbUljHs9rw2dFKRVirgLizoDLrruYsHeJeajDKSfYaTr4Q+SVs8Q1fKa47Q5EI0CWqKqdvRe2kELTWpRsvgWKUxqLNt6nJA8K6Ghk80GvhkCPqPiByzeHy1nabX8AzkjUfyud7BcPJGFDE2+UFy5bqcRQ4sfCLTgFibMYcJm5kaEW4D334IovkOiEMrxAWZf0KuMxm/gR4OLP/1hQjL2a72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGhq0D/SzMPwuXAuvoDWm84Dg9PXBq0Qp+nhKLVIv/I=;
 b=tsfK3oIC7kUN9Jqk4EvLzM/v6otOPw2wdvEl6iyqku0wnv0v+VPTG03xLUE2B7nksCU0QoRI11g+VcEy512qMOXJuPaqbEhR+pBeOSfGo52gFZ25P5Lpu6FmmgIWco5Pk+fwyrpi2EjpgEGjOvIz7eb56jEZ6xsMQaSWr+P/WwiMFSBzj0TgUG0SqetAE0Ib9gMgye+ENqytkkBMMIP1vkPoG6u0ZN5xDyjsuWeETWeCU4bDcXL0f2tasMZGO94Dft54uRzJpbcD7Dru1ih9gdiOQMd5LrnnYKTR/8EUbMw6CXulJ/JdAFdgxkWpTHpw0z2eGTewA+mhVVO9ZSGFRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6758.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:332::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Mon, 19 Aug
 2024 06:09:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 06:09:34 +0000
Message-ID: <20a24332-f53e-4b98-a3ed-fff30d711fb1@siemens.com>
Date: Mon, 19 Aug 2024 08:09:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Xenomai Meetup at OSS Vienna in September
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <CAFLxGvzFcqXintq5U6tCZaSp=8quTpB03hsgkmteonnvX8Bpkw@mail.gmail.com>
 <5cca17c1513b8e978e17f2bd5a9812dd5c08baae.camel@siemens.com>
 <5e35103a-afc1-41de-9103-791380ce21b1@siemens.com>
 <CAFLxGvw35sdp9EKh2-puaqNXW0hTaBAJ+vL1owv+o3-PJNj67A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvw35sdp9EKh2-puaqNXW0hTaBAJ+vL1owv+o3-PJNj67A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ac56af-0959-4f46-d20b-08dcc0157f55
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1JheVJISVlaQXNOL2RnTVJ1Z2RwL1NWRmRxRmRkUE9QV25GUHQrNEE5ZFFt?=
 =?utf-8?B?em5UR25DbGpqdUV6RGJWbkN1d3lPM1NnZkdCUzdzNGhWMFpJQmRLdkNVU2tE?=
 =?utf-8?B?S2lZenVtdUZFNVQzbGFhV3ptY3ZRQ1ZNWmhWWmJUSGM0M20wazBML2Z5RGRq?=
 =?utf-8?B?MXFvNHdXR2RPWHdnbkhCNTlYY2hJY2Nzc0JwQUtEa3lIYXpUQnFmaW9yNXZt?=
 =?utf-8?B?Vk9HRk8yeU45ZmlsUzRRMDNIYVlrK0hSUVJqZ2JKUHQ4UHFrV1NlWEREeDFU?=
 =?utf-8?B?S0dJeExSc0k2bjBDaWFsNlRhM2VlekhlUEZnUktaTlZuNHFFWHFsTEVWNTg0?=
 =?utf-8?B?ZHJrbWx3cThtQ0hzSHlST3FYU2xJSUg1a3ZFOXhwL25tM1dDczgzTWc5cDBR?=
 =?utf-8?B?Nmk3R2RYRnBrcmhwbHV1S3o0ZWpiUGJvb2hpS1owQklNcktJTGZCd29UYkRn?=
 =?utf-8?B?Nk1lb3YrUzdTYVJYRGF2WGsyeExvbWVWNENsbDBkZThWQ1hPSG50U1NpNGxt?=
 =?utf-8?B?M3R4bDNOQjd5T3BTRlhTZUhxeTh0RTVWM0R5OWpweHBwQWRoeWVqaWZvYjdS?=
 =?utf-8?B?eVJEYVFtaSs2ZndSN3NsOWZOMnZuOHAvWjJ0VWRXaWFFUFFjUE8xTjdCWGFq?=
 =?utf-8?B?aHkrUTl2aldmT1pnNitXam83R0o3R2NUVDFyYVVzRmpWY2gxL01sZ0pMWHJ5?=
 =?utf-8?B?QjRVT1ZubWx3QldIZDRuWk9KUkV3UkptSUNmVkNjN3FMSGlTcTM2OEkyZ05I?=
 =?utf-8?B?UzJkY2lTdzFyWk9SUE1pZVd4VmwxRGlXNWJ3aGJoZEhObkNnZCttM3F5Ry9m?=
 =?utf-8?B?MmxkUDRldWtGcHVLM2tpNU1lY2VuWVAwa3lLVG1DRDZLRlU1THJsNFpvTHVY?=
 =?utf-8?B?SHc1T1dxNTJwTmxxQUUvQnVTdUhwVzZSN2xjMmd0cmJkUm5MMGFJdGxGNEVJ?=
 =?utf-8?B?NU5qZEVmRHowczVDWko2YW5zUEpURFROWHpXMUduQzhBcXlsa2Y2M0lTaStj?=
 =?utf-8?B?OU1YaXdIUzJJZkQvRlc0aFhlTXBEdkMyTFdPWFNuTk1zeVBuS1hkeUw1NnR5?=
 =?utf-8?B?Ly9qQnhUL3FGVFk4QVduMlVkclo3d1hPQVhiblFBTk9maDdkT0kxanVjL0dF?=
 =?utf-8?B?VXUwemVNYjBrc1RxUWVCR1F4SFdWa2U0QmgyZklMNStuOU9zdTBDL1VvU2RO?=
 =?utf-8?B?aWpMN29GbElEWU15ajE5UVdzM0FGL3RNQk5zeURObXdzOVdXUUFVN0xyZWJN?=
 =?utf-8?B?dVhSV0hhYytKbWN5bE5HL2tPbHlUL3NiS2ZlQkQ0T1FNNXhvU0Zrb3Fvd3dO?=
 =?utf-8?B?NWFSOWtOZVhoMENSV2xQblpUMXFDall2aXVkQklncVl2ajZwUFJQbkk2aGFa?=
 =?utf-8?B?OVF2K2lBcmpvUE5vN2tpMTZVeFBYY2FZYWRqYlhMc3k5YjZidTVQdzRtODZl?=
 =?utf-8?B?MDczd3hLQlZQdHRML2VHNHJyVzE5WC9sZ3BvamZYOXIyTHE5a1RrZzRWZEhi?=
 =?utf-8?B?YzRSUXVoSWJiSjhINHlualV5eDNjYThIVEE0akdkTDZLS1ZBVW1YV3VxZnoz?=
 =?utf-8?B?bWQ5ai9NV2lHTGdZMWNESXFCaTZLTHZNSzBoeWhmc05lQlNjTXJCUU55bTJp?=
 =?utf-8?B?ZUpkVkhmSHZvTVM2UWEwRm5jRDJBelJyOEJQRWt4Vzh1djhrRStUbis0NHJt?=
 =?utf-8?B?VnhEdlBORkRQOCtoWDVBMEZxL0J4aTlwK0hPdmgyT1NMRTUwR3RLV0daUmxU?=
 =?utf-8?Q?M523JJVJBGlWNZRrAA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZStWUnl6Q0FvQWRNVU85V3liNTRXVkRFck4weDFEN05kbWtHanZEZ3FvL1hE?=
 =?utf-8?B?Z3daWTRoZlhDYnNOY2VxbDFIQnJzUmtnMlNJNlZUc0RrNkh5SEkxU243eUlO?=
 =?utf-8?B?RXlUR3VaNCtTTjZydkFRU1U4ZTNJOGtocm0wWUh3alJaWG1wQ3BOODB6WHF5?=
 =?utf-8?B?VWtXSlUrRXBnaUxNMXQ3MXIybjd3aGx2dlR2Q1JkWndoWEpEV2M3MG1rZTBh?=
 =?utf-8?B?akd3WEZJdjZlN2VxVEV0UG45VlA2L3JOREZSK3JtdWJ5QUoxYUdGR2dmdFNX?=
 =?utf-8?B?L1BobEJ0d1J4SlBFSS9BeTNiN0s4UEtiNEovbmsvNERqc1VmVjJQcGthUDYy?=
 =?utf-8?B?ZGdndGN6YkdpNnJyRjdPUk1VVGVCRGthZndFa3FPbEMwdlk1cytLTkV5djJX?=
 =?utf-8?B?czhGR0wxZ2Q0ZU5TNmMxcktGYVJWK3FXdHJzcWEvYkU4bEFVK25Dbm5zNVlP?=
 =?utf-8?B?QU9KK3NBbzlIRlkxOXZaVG05c3U5Z3Zpdk02RlpLNy9hS2Jnbm0zSkRXalV5?=
 =?utf-8?B?aCtJU3J3YW44ZUFCazdVUlVxbjJXb0ZBSUo3QzNsdm9FYktjQUFPbWs2dXFQ?=
 =?utf-8?B?WUl6Q3htTDl3Zjc0bVZtR1M3RXlMSkRGVTA2QWRMQ0ZmRmphaWJsRDNZdkRH?=
 =?utf-8?B?TitCSWZ1OUtlUjN5YnUvbm9tS3BoVzBSRDRySXdXaHJXQk1jVmRyekFiL0d3?=
 =?utf-8?B?a0ZxV3pERlBLb25DRE1nQmpnajg1TklLNFBkUkU3ZVZTQTRRRVZwcjJ1T1lR?=
 =?utf-8?B?YVF5S3AxV2dIdWJqQTNmd1RZc3pvTzJOUUJqU2hxbW1jVTdaVDJnTjdXT25n?=
 =?utf-8?B?V3MrNkZBRDlpcjFURncwejIzdU8xZk1xRnloeVNNVzI1OEFpUnVlbVFUcFYv?=
 =?utf-8?B?RmlRS2lpQVVPMXlia0ZPaHgrdW1CbTlySXlrOTNsUFRPWWJUMVIwWG82TVNu?=
 =?utf-8?B?ZERjSGljSnVyU3RiZGVIVVNwYTZhTXVKT3NJTDFDS3pDVTlQTjNrMkhsVWJ4?=
 =?utf-8?B?Tmk4ZzBYcTBPYVhvaW85Wk5HeXBkOFpMZERwMTU1MkhGbFRZK09DaUdvbStk?=
 =?utf-8?B?RXpPOXczY2ZGblA3eThiZzNPMWlqSnkzeXhvWDlVVURBVkRWblpBQlJjVDdB?=
 =?utf-8?B?ZzJobFVqbC9ldklDOGpkUVZiNmxUUWo2bnJpWFVCcDJRQW9XTDNsNGpSb2hL?=
 =?utf-8?B?dkN4bTZIL3ZhWndUZVZhczM4dEN0Z0dicVNQQjF1S24vU2l1L1V4T1NhWGVw?=
 =?utf-8?B?LzJSSFVpSXM4aHFiekcxQjN4TjREL0lLWDhrcEZWMFAyeXNLM2FnVEhhYTF4?=
 =?utf-8?B?Q1Z1YVdkK0pSL0FHVFl0NDdOTEhlQlJyZlJRN081MXo3TUh4Zkc3K1BUajk2?=
 =?utf-8?B?RnNDVXVZU0pJSk9WNUl1bW1DSTNSbklseTBnQmI4VXZkNFFJVVBRTWQwVDFT?=
 =?utf-8?B?UnBLZzFpOHNyWmhTam5waTJhSnRQZGJEWEZkQTRrcG9QdVVickxQUzhrd1ZX?=
 =?utf-8?B?RjFUUnh4S2RCMk5PWTNKMUVzNzUrU1padkZ5S3lsTkFNQUJtVTdvRFgyM2hq?=
 =?utf-8?B?NE4zZWVvRGxRTDB3V1ZDQ204ek9CNjVFTjc0cEdkdXlxb0FzZzYrVGZyQ1la?=
 =?utf-8?B?dERwc20wbjczM2lUWGJjMnBROE9hdGs0Zm9YVXFDOUJvUE03UW13MWFCREdP?=
 =?utf-8?B?WFhWdVhUcW1aaWRrelJoSUZ0RC81SXgwKzNpQkZVK3k2MG90TlB2YmlsN0x5?=
 =?utf-8?B?OGd5YytGa0FyYjlRMWJQS3JaTE1IV1lFbDFwM0Z2WXZVaDkyZW1ZT21wUjV4?=
 =?utf-8?B?M3p3N2puYk5ocWpEYkFzdzN1TitxeG0xVTNERElnTjRCMDEwbDdIbnZUK0Ri?=
 =?utf-8?B?TlpOcjZSZml3dVkzd1JvaS9zNktnVmNSKzhtR2pwN3F4M28wTTN0SENSZU1H?=
 =?utf-8?B?YWh6Y0ZPdC9LbE9TUGl5QkF1b0V6U3VkN2NIVURqbHI1UjRNOXdVK3Fkb2M1?=
 =?utf-8?B?b3NLeXcwYktlc0hHSUd0N2orZjFjMDErSE5uZi96TFU5MHVlOE44WFVuZGwx?=
 =?utf-8?B?cVBuL0VUZ1gzNWxDZ3E0MnEyeFZMVkpHOHlDTk1lbmZ1ZDl4S0JzWkM1UTMy?=
 =?utf-8?Q?6oezn57IUMlfntCMZ5e1VoVqY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ac56af-0959-4f46-d20b-08dcc0157f55
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 06:09:34.4716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGcc5uQY0yP6UThZMl2hylkdNVlwh07QyACBI5tRW7qw6qmjNPkFfmyS+P39VfLKyH39yR7iAmYoBX44swNTuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6758

On 17.08.24 21:14, Richard Weinberger wrote:
> On Thu, Aug 15, 2024 at 3:36 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 15.08.24 12:08, Florian Bezdeka wrote:
>>> Hi Richard,
>>>
>>> On Thu, 2024-08-15 at 10:46 +0200, Richard Weinberger wrote:
>>>> I expect that some members of the Xenomai community will be attending
>>>> the upcoming Open Source Summit in Vienna. If there's enough interest,
>>>> we could arrange an in-person community meeting at a local beer
>>>> garden?
>>>
>>> Nice idea! I will be there and yes, there is interest to meet.
>>>
>>> I can already tell that Jan and me can not join on Thursday of the
>>> conference week, 19th of September. Every other day should work on my
>>> end (- can't speak for Jan though).
>>>
>>
>> Hehe, just realized that I have a double-appointment on that Thursday
>> now (RT and CIP). Definitely no space for Xenomai.
> 
> I'm also blocked on Thursday (RT party).
> 
>> Wednesday might be an option.
> 
> Do you know when the OSS related events will be? (Speaker party, etc..)
> Maybe Monday is safe...
> 

VIP reception is dropped a whole ago (cost savings, IIUC).

Monday is reception at the sponsors (https://sched.co/1eYej), but only
till 18:30. Tuesday is all-attendee reception.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


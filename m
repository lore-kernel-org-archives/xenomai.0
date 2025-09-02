Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3732A825
	for <xenomai@lists.linux.dev>; Tue,  2 Sep 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827663; cv=fail; b=VDwtvzkbbLpPPO8ok7nOR+omC8cahBa7E5l7g42l9iMiAJNxpnUjhRaNxC2r4lGYkQBQaD0sgNvGnVdlanUMr+hg830HFEU2JPQukbdAAHLoIUS1ZVBoZ7lMirtAJcERS2AHxtJLM8K2Bo7KX1X1hf5WpBtBc1xvpZl36E1duAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827663; c=relaxed/simple;
	bh=9PgBhUuQrJtTXB0hq5YEJ0nxHaohuxm0bCMDx7EHbk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n3zGcDCRx1Eel/RCi8weM2LeQPKaTfc6FiNfkqcppHoDV44nlTu+Re8Yyi34H30LtofmZHZ1tXp8e0TYC6lbZUoGcJGKMDgQX5gK5D0b54e1LkdaLja+RWkwiZ+b/ueNh1X1joARF2XvkNjIWpmfCTl+ZsSx1BMtDy8VnmZuoy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bBIZ8N4B; arc=fail smtp.client-ip=40.107.130.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bBIZ8N4B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scaC/OhCYakLaLUlw30JGufDLKZSMzWaP6hqgqU9+ZMPInQPwQyfLOqPlsl5H8DKLKgAG4IznINl7NTI1gFSsrSjABLJcN7JbTdhtQiScf2WrFwfQHIh7rAWkae3KhW8RPCEQpljH2FbTsSxXV3aasAb8MrBt5Wro6QgCMxrQroJQ7m0knM1L8wgbnQ9RdrAgeXifygJ0YS7TeR2tzBZ+eJ2HljZtvY1kY8F9j/sKswmeps5Ij513kvuw/203DJ0nMQVhLUc9Q2EAdHtTpxMAn6v2AdnMRsltVUFDwVM/rpk95k6YhT+HN4XV94mjq6nDgBjtYcV9WFqy5XUCZeiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+jLPMmC2YMd5F+wuQ/ahsbmuLz4hBoIVRtC49eMV2s=;
 b=UNquWy7d7w/qB7QWTcnDaOJfS5PnTws1kkGU3YdRQQRitbh+1vhE7bXzVK/3QZS9HyisUtjaUQ7wUDL2rJZ0vwNYUx0j/YBpBMXWLYiP819oCmHJXbRwTtiyKIG0vke1dzdzPRC5TZ4vBRDZN1kgz7HUNlESbuTD4iV6cpkA8pNR1lFt56u6WeawP+T0tLqO1v3Mm5NmS2QlaWk6kAc+qJ659RtU1WrxvEiJiNxm14MAYP+1qCVvnExMJ9PBPqQD/gGoIEFcl/a7b097OACHJB0TXRuJvTDFRTo6+9CDFnYYY4yBVwQ5UPk+LN2JBrQjn+Py8Aa0Odoo4jMNWpZanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+jLPMmC2YMd5F+wuQ/ahsbmuLz4hBoIVRtC49eMV2s=;
 b=bBIZ8N4BzHKmk7T0YbcVzX9l1WzKKXPNULRaKBe5WT2/xMDoGfivPRmQDBbQ3XccKnhu0KMr4zR3X+BqsjfCPbor5n6J9izKqcnVgoN4z0Qh6sfwrAbH9ie6jq0AmVjOvtODpYxHhtKpvlAmAZny9Uj6B9T5hOm71t7qlwNTTwxeoA3OdJW/whnuI+QyoHCc+9b96QCkOP0tLPyq2om+MC8mEBYzjatPLnVKNILycdLrkUVrnIiSBzMcAHVkd4YqGjIfOKXtuEx1sN30LLqUzc0CelvnHnfKLgIrssYuD/vjDtFn3Cz/NiylpWyXnKXqWrJKgjcmCn0r6OHl7lKyww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB9078.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 15:40:57 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:40:57 +0000
Message-ID: <d882e33f-7193-467d-8604-39fe8bc7f753@siemens.com>
Date: Tue, 2 Sep 2025 17:40:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/pipe: Fix invalid wait context in
 xnpipe_wakeup_proc()
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Philippe Gerum <rpm@xenomai.org>
References: <20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-v1-1-43a7c06e676e@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:610:b3::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 1787ea41-187d-4b6a-a041-08ddea371c35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXpuOU8vb0ZZMlREUDcwZHFSTzZKTmZWYTlGSEFrQ2xZWmU3aFpjMHZpcCtm?=
 =?utf-8?B?ckhOTlREZlJnV3QwSUl4N3ZrdDNENEJaTEQrOXd3MVFmMTQ4TUVCRmViQW8v?=
 =?utf-8?B?VGRscDhBQ0dDNjNSb1JMcW56NzJBUkh4QXJPaVdlOEk2TG5uTzZXQk1XMnFE?=
 =?utf-8?B?bzdoYTJmRTRLTEhVTHhqTFpmSzYyZUI0SCsyN3phZXJPVWd3L083UmtFcjhB?=
 =?utf-8?B?c1VGdjRZSHFJeVpVVm9nODg1TnFkRVdmQkE2RmY4SjJEOVRxeE9jUm82SUc5?=
 =?utf-8?B?akt3SDJkNE9uMmcwTjRWbDNyQ0ZZUVVDeGJibzRaREc4OXFDMlluZ01FcXNU?=
 =?utf-8?B?Zm1JM3k2V2twSnV6aTduWVpTdXA4VWpPT2JHbExJUDlBY0x2dXNVMXhxYWlx?=
 =?utf-8?B?RXRSZDR4YjBNdThxdWhTWFY5eWF1dEVkMzZ0eFFJQkVJa3JaOXZrUEdTYzQx?=
 =?utf-8?B?M0ZHMXl2SEdtWVJKVXNCMmVTNmozOSszL2cvSlVtRm45cFdGMU5reDBJaENN?=
 =?utf-8?B?cGRjNHJFR2ZBTkFRK3VCT0pobmJEdG9pQUNkaHNJSUZzcjdONjBvdC9GeDNP?=
 =?utf-8?B?ZGo4cC91SHlMVWF6aTA0NnpEd3NzcHZDQ1dPYm1DaXVqRmNZaFBrRU5mZFVl?=
 =?utf-8?B?ZW13Q0c4aFJkeUxueHdmMEIyR201R3BpVGUyUmhKUXRvcXFwWXRSV2hrRVZt?=
 =?utf-8?B?UDJTenhmTXRVQWJQcWVzckpIWW9ZS1duU1g3Z0dXQjQvRlRIZFhkK0g2a2Rq?=
 =?utf-8?B?Wkc3Um5XZTE1VDJ4S0l4dTBtdWZDSG9oWFdCZG45NTczQmVpeE5PWWhBQzRC?=
 =?utf-8?B?SWtaS2E2YmRrcEZPWGJZVkhtMERwQTIrY0U2TlNRelEzQ3FudUZRVG4wZlJI?=
 =?utf-8?B?TFpEbXFzU2ZUL3hwU2d1WlhKYnUrUy80eks0aGpFUmd1N2V0SzV1ZjRkUDFT?=
 =?utf-8?B?cW1ucDN0allqTU16d25kYmJsenRIRzU1NTBQVm4yemRNQ0FGN2xQa3ZWRVow?=
 =?utf-8?B?Rm5Wai8xWDg4VThyNXU3b2kzVWhyeDNiOWw5THFjbjhkU3JHTDlFQmgyZCtX?=
 =?utf-8?B?aHFwSld0UmpwNWhQdEVsOC9sVjRQQThVWWFXR2lFOENqUXFjUGlHTDkwWTZa?=
 =?utf-8?B?MUp1c3IyUDMrVmozV2lRdnBBSGYxaS93S3lWS2ZYRHRPeHBkd0lpTVZ4L3ps?=
 =?utf-8?B?VUJhZ055bHhaaEtoTWI4ZVlzQ1JpU3l3TFVZaGVndkVwZUI5eE9nOEVQLzNO?=
 =?utf-8?B?bWtReEtENzF6V1JXRDNDd2NmczJ1S2NPaHJEOVBMMmFUN24yTnBLbWtOU2E5?=
 =?utf-8?B?bmdtM0NVcDlqZjVPR0QvQ0ovdjhUQWhKUzlKbmg1aWsra00yV0RqTG1ETTI3?=
 =?utf-8?B?ZXdFVnhvaWhPM2x5WTA2RDNLTFd5bFV2UkthaS9Pb3N3QmtOWkR2T0FxZnFI?=
 =?utf-8?B?Y2FiNjFZNUQ5ZjZtSXF0bURYOHEwSlFFNnRmd09RaG1TMmg5c3dnRXpsSHQv?=
 =?utf-8?B?aEFpVlFERWVlVVpjVFREYmxtSHVuaWtHdkQ2bGJNSGpvTWwrajVQUG05Z3ZS?=
 =?utf-8?B?RndzL1NpejlvaTB6MFdhd0RhNktFbGpybzRzcU14dnlGdmRLbk5rMGxFU1NW?=
 =?utf-8?B?NFByWVhZMTVEbkh6K1VFT0xvMzFXSUtRSjM4TE8vdzJxQmQzM1R3RldxM1Jj?=
 =?utf-8?B?Tnc4Q094N3FzVEdLY1laR2IwS3JwK2lVR21Rak5acHFQZDQ0cTY3dS9OeXRW?=
 =?utf-8?B?dEc0NUNTMEI4VmFSd1dFSFliRDE1TGZEZGV6SzVTcGZrL0xxM0hLcEQvamlC?=
 =?utf-8?Q?gTfxSCjPpAfMoEu2Obruz73zgeet+RxL35w0c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTB4L1ZMSGVpSTJObFNwYUlDRFZHQlFNQWlUT0xYYVcrc1Z6WXg3V2VFbWIx?=
 =?utf-8?B?NzFBSGp0emdmOCsxZE9mTGxBcndMVjFhL3BxL2o5bmxUY0ZjUmd3TTB6d2hw?=
 =?utf-8?B?TklYblNIdnB1TlJvSHpBTjFjY25UeWlETlNiZVRZUFdaeStCZ3lZSk9xN01N?=
 =?utf-8?B?NC9ydzM1cFRJNWhkWHh2WWVJUG5VMnhxTDVVL2Y0d1U0VGYvdE1RWWpWZTA0?=
 =?utf-8?B?ZHorZ1g0Sk5iUTRIb2p2OEUzZE9PSjJMMnk2TGNkbWc0TUZJa2pLSTFhUkVt?=
 =?utf-8?B?NFY5cWdJZzBwRGcwWlZDeG90RmkyNFJhVkFiTHpnU2s1a3dsZ0FJR3ZkSlNS?=
 =?utf-8?B?WG43TXU5NU9iTWdaUzljRHNlNDRpK25oQ0dpRFkrS0NKWlRXNDg3ZEh4Z0Zy?=
 =?utf-8?B?WXU4STljdk5jUWlqUE1hTjRraklWdVBVN3V6WVVCSHluWkNiYVVFNVNIeTE2?=
 =?utf-8?B?ekc1N2d4U2hPZ2piS1ZORzM5Vjd5OTljWmlhbTY1T2MzVjQxcFZtTGIzQ1cz?=
 =?utf-8?B?R3dQR1lTenQwdnRkVlRTeXVrZE4rVjdvLzUwZGJQU09rTjR3R3hEYk9KWjJu?=
 =?utf-8?B?RjFiMnpBZ3RvZWFCell5RlJJV2RFQ2I1WjQ3ak9ZMU81MS9Jc2V3eks2NURt?=
 =?utf-8?B?aFJkUjNrQzB3NHlPekw5SVdWaVJ6Y0s4a0wyZTIvdVFDRDhCb1lDWVNMQjJv?=
 =?utf-8?B?ZHZFWmxxSGFuM3hWVVhwMVBrZ3k2R1ZJOExUcXRaMlJSd1A1ckpHNzdLamY5?=
 =?utf-8?B?N2F0TnlPMmVwSVpwWFBYZEMwei9OQUxYN3I1SHloWDc5QnFIeHJubVhPbkM5?=
 =?utf-8?B?QUtmUklOdkxaSnNrVnY2Y0JocFU1MjRtbW1GRHJZVjh1dG1JTWwvRXdLSUxI?=
 =?utf-8?B?USszMnVhLzZ2bEMxbzVLdGl5N21YNHI3ZmdLeFpoeEtNSGFibU5NMk1VMnBt?=
 =?utf-8?B?bVN0UFpvTXVxaUg4d2RTdVBiWW5GWnVIcHFzTGVTRkg4NDdxVTkzeHdCelZL?=
 =?utf-8?B?ejFrZXJYWG5SZVhBc0xpL0tMZTBFT3F2MkZ5RDQ4dnE3MFYwN1Axd1ZGVGxw?=
 =?utf-8?B?WDJoeWU2TTB3NExvb3VSZGxoWXFoVWVTR2kxV0Vwbitqb2MwcXByZThVZGx5?=
 =?utf-8?B?N2dYNWphdWx6NjNDeGwxVTI5SWxXMDVaMHc5TmdPRHl4NEJtMWozb21uaTJv?=
 =?utf-8?B?bTNmcUY2RTJxZWFDL2gzaXNIWlpHL2tPSGpGc1VvYkxZRk1UQmFuVlNwZkhw?=
 =?utf-8?B?UGlDSnd4SmZiSWNLT1p6cjZQUE0rTWkrL09DRVdwVGlWT2tQQytTRVdXSlZm?=
 =?utf-8?B?MWEyZXlJUGRPcnlxeTZmV2k5Y0NxYmUzaXE2aHk1MzdXWUJyTGNvN0MrM2gw?=
 =?utf-8?B?ZVpFQWZTK25BRzVrYjM1aFgrSjgvNWFIZk92cXNSK1dlVHJ4a3h2dldsdkJL?=
 =?utf-8?B?bWxzaGVWT09KL0pnSmM3eEFKU1g3WWxBWVlNeTErcU1wS2hNNEZNQ3dyczlZ?=
 =?utf-8?B?OW9wQTltUEtreHZSaXFwUHFIUStPbFBGYlBpdmtGbmYxblVtL2J4TnhBKzlq?=
 =?utf-8?B?UDcrVWgrYnRKbHcwcjF5clVHNXNxRlNLeWVtU1RUaFFCYzZCNmRXSDFWZzYv?=
 =?utf-8?B?eHMydkovbFllcEFMclFiRnZMSnpWYmlZcGdYS2pnQmtXMitmVWphSXV3L3Bt?=
 =?utf-8?B?Z2dZM3NKOFQxdWFvTm42YXBLUzNuOEpmNDIxT1BGeCs4R2JjQjYxcDVUVXVZ?=
 =?utf-8?B?eXJlZ0Y4L0I3NjdGUUNxcW9CQTdEQkFTa3M2dTRWTFVZalRqTmtQTStvNE1u?=
 =?utf-8?B?WWh3ZGtiMWZPaWd1c3VOazQvd1Jsa0ZtazRVcHVGU3FPTFduS2F3dWE2c1p3?=
 =?utf-8?B?THZ6enZ5ZWRtUmZTZkhTM3owU3c4aUdCRC9XTUpWV3cvaFNYNUdEbnlPWDZL?=
 =?utf-8?B?bVdUV0IwSEFDZXU1Yk81Sjd5RFBBeWdEbGcxQlNKckRrVm9LZGNlWE01am1l?=
 =?utf-8?B?ZThqNVA0bHV2QzREeE90L3l1L0tsSk5JT2Y4RVdCb29jcjFzZjAvTTlGNzlS?=
 =?utf-8?B?WlBWbE9wYTM3bWd0c2w2dU9CZ3dKZ09SNDhlbWpjcjE0MU9tVzhrM1lEb1FG?=
 =?utf-8?Q?SFca+6OpVOCnpo8ggI9+R4iiG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1787ea41-187d-4b6a-a041-08ddea371c35
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:40:57.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rNbQqJMr5G28bHdCry73s+uPiZ1Tsqzx3uWXqUClDCo0LyBhVujMjuG9Qw+6cwGTEhF2usXCUnubcAqXHm+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9078

On 29.08.25 17:59, Florian Bezdeka wrote:
> Recent Dovetail versions complained about an invalid wait context in
> xnpipe_wakeup_proc(). It turned out that this warning is correct as this
> function is called from the inband IRQ context (while syncing the IRQ
> log) with hard IRQs enabled and inband stage stalled.
> 
> The call graph looks like that:
> xnpipe_wakeup_proc()
>     wake_up_interruptible()
>         __wake_up_common_lock()
> 	    spin_lock_irqsave() <-- might sleep on PREEMPT_RT
> 
> As confirmed by Philippe in the discussion linked below, we have to
> migrate the wakeup code from using a synthetic IRQ to irq_work to address
> that issue.
> 
> The log splat report:
> [  151.574032]
> [  151.574039] =============================
> [  151.574043] [ BUG: Invalid wait context ]
> [  151.574046] 6.15.0 #1 Not tainted
> [  151.574048] -----------------------------
> [  151.574048] swapper/0/0 is trying to lock:
> [  151.574050] ffffffff841174c0 (&state->readq){....}-{3:3}, at: __wake_up+0x21/0x60
> [  151.574063] other info that might help us debug this:
> [  151.574064] context-{2:2}
> [  151.574065] no locks held by swapper/0/0.
> [  151.574066] stack backtrace:
> [  151.574073] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.15.0 #1 PREEMPT(full)
> [  151.574078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> [  151.574079] IRQ stage: Linux
> [  151.574083] Call Trace:
> [  151.574086]  <IRQ>
> [  151.574088]  dump_stack_lvl+0x79/0xe0
> [  151.574095]  __lock_acquire+0x942/0xbf0
> [  151.574104]  lock_acquire+0xe2/0x2f0
> [  151.574107]  ? __wake_up+0x21/0x60
> [  151.574111]  ? find_held_lock+0x2b/0x80
> [  151.574115]  _raw_spin_lock_irqsave+0x49/0x60
> [  151.574120]  ? __wake_up+0x21/0x60
> [  151.574122]  __wake_up+0x21/0x60
> [  151.574125]  xnpipe_wakeup_proc+0x152/0x590
> [  151.574132]  handle_synthetic_irq+0xc2/0x250
> [  151.574137]  arch_do_IRQ_pipelined+0xca/0x180
> [  151.574141]  </IRQ>
> [  151.574142]  <TASK>
> [  151.574144]  sync_current_irq_stage+0xaa/0x110
> [  151.574147]  inband_irq_enable+0x42/0x60
> [  151.574151]  cpuidle_idle_call+0x17d/0x200
> [  151.574155]  do_idle+0x89/0xd0
> [  151.574158]  cpu_startup_entry+0x29/0x30
> [  151.574160]  rest_init+0xf0/0x190
> [  151.574164]  start_kernel+0x632/0x700
> [  151.574179]  x86_64_start_reservations+0x18/0x30
> [  151.574185]  x86_64_start_kernel+0x78/0x80
> [  151.574188]  common_startup_64+0x13e/0x148
> [  151.574198]  </TASK>
> 
> Link: https://lore.kernel.org/xenomai/87349may4v.fsf@xenomai.org/T/#t
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Philippe Gerum <rpm@xenomai.org>
> ---
>  kernel/cobalt/pipe.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/cobalt/pipe.c b/kernel/cobalt/pipe.c
> index 7519f3165..5ab561384 100644
> --- a/kernel/cobalt/pipe.c
> +++ b/kernel/cobalt/pipe.c
> @@ -48,7 +48,7 @@ static LIST_HEAD(xnpipe_sleepq);
>  
>  static LIST_HEAD(xnpipe_asyncq);
>  
> -static int xnpipe_wakeup_virq;
> +static struct irq_work xnpipe_wakeup_work;
>  
>  static struct class *xnpipe_class;
>  
> @@ -147,7 +147,7 @@ static inline void xnpipe_dequeue_all(struct xnpipe_state *state, int mask)
>  	__sigpending;							\
>  })
>  
> -static irqreturn_t xnpipe_wakeup_proc(int sirq, void *dev_id)
> +static void xnpipe_wakeup_proc(struct irq_work *work)
>  {
>  	struct xnpipe_state *state;
>  	unsigned long rbits;
> @@ -221,13 +221,11 @@ check_async:
>  	}
>  out:
>  	xnlock_put_irqrestore(&nklock, s);
> -
> -	return IRQ_HANDLED;
>  }
>  
>  static inline void xnpipe_schedule_request(void) /* hw IRQs off */
>  {
> -	pipeline_post_sirq(xnpipe_wakeup_virq);
> +	irq_work_queue(&xnpipe_wakeup_work);
>  }
>  
>  static inline ssize_t xnpipe_flush_bufq(void (*fn)(void *buf, void *xstate),
> @@ -1149,6 +1147,8 @@ int xnpipe_mount(void)
>  		state->nroutq = 0;
>  	}
>  
> +	init_irq_work(&xnpipe_wakeup_work, xnpipe_wakeup_proc);
> +
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(6,4,0)
>  	xnpipe_class = class_create("rtpipe");
>  #else
> @@ -1180,13 +1180,6 @@ int xnpipe_mount(void)
>  		return -EBUSY;
>  	}
>  
> -	xnpipe_wakeup_virq = pipeline_create_inband_sirq(xnpipe_wakeup_proc);
> -	if (xnpipe_wakeup_virq < 0) {
> -		printk(XENO_ERR
> -		       "unable to reserve synthetic IRQ for message pipes\n");
> -		return xnpipe_wakeup_virq;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -1194,8 +1187,6 @@ void xnpipe_umount(void)
>  {
>  	int i;
>  
> -	pipeline_delete_inband_sirq(xnpipe_wakeup_virq);
> -
>  	unregister_chrdev(XNPIPE_DEV_MAJOR, "rtpipe");
>  
>  	for (i = 0; i < XNPIPE_NDEVS; i++)
> 
> ---
> base-commit: ccdceccd2508596ebd114981890b5b47b650058a
> change-id: 20250829-wip-flo-migrate-cobalt-pipe-to-irq-work-359bc1f0a8de
> 
> Best regards,

Thanks, applied to next.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

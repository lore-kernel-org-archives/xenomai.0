Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDC3DABFF
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858169; cv=fail; b=bX3nt3b29lb90Yqru9z3b59IRkwmWUOby+7iTEQtnDXMSc/QhYMlxXv/FrtpXUjl8k8nUQz3/sSoX4BB4xD/DfUt3dS1l1Wbf7Z775s5YRxE4k92pis52PF9w6Pyk55IyRuWItwz9UIVpnNY1SSaCcWmcK1kNGSVCqin1Hrmtu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858169; c=relaxed/simple;
	bh=uFyzrmPijVCvDZ9mY9XszExG/Y7pzAzxUokM0Cw1WGk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uajW2DWhNZ4JVGXFdnSQzuZ+oQXq7QIuxCm4z+LkwzTRv/8Lu338CfILzfCNvBVHt7PPpWSQ+AR4ghwrLHU0UF7Mk2KZlPlpHT3ftI2WzdAcFZaGsBNPk6N+TJFEK79vJjxkx2oLetpjjTHnpzWdhnUiPHfRHGlYbpNBhZTeCcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kDHggnso; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kDHggnso"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8+6xXdJ5kotac24lNqUWyvLafs+po0OSfcGW7xlenAWYDFqOe+jS59BKplS88f1DKEOB75dyhj92C3MuH8oR7MQqP/UBIITJuCWoGghgn6zl7BeW58hAJ9RB9l6FGKmbl+PwuwJXz56yJKoNetrEwOyPql6/rz6iSptU2DZfpcq2H7C3hqIyogdfJ95uIT6mCpkL33397oDqYwwWLIXxQfNiyFH9Hqitm8K+6JmJXms4O03DlUb+tsQxhs8HtIN4dVLukmh62n4oVXW5c2GTWLCVwO5zspEm5uOONx4bByx8rBtEsUk1EwLHOl6YkIvjKsX0su1EkcZkzcXBYbqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC18dN7AtbP0CxIZ2mBumPV7U9jGaab49yCeCNLw+Q8=;
 b=MVLHMSeJwQeqLB15d7ugSjFcYoDsRQX36URnC7zXTYyuZ4igHi8jTKhwUKgrW/XMK/Bk08P4fzQzmScaY8w0mORqh8+1eIlJbE+uCqE8NTs7oku5Zm81EOvFvcP+HbtrEh/ZAVJMLKRgzwb+cdRtSqvYMq+H2wCdITYJu16AAmOkYJGf6lFf5TM9ikZFnsoBK9PJj2wGtGZnifY62Xs8+QhEHIsfgyHexc6FHwNT6C6nCr/hd0vAZ1zw0iYOx+1KiIIoS6ueaglAmTMv5ibV5MI8uwuYyzzi+id5FhWA8UkPb/wYQfT6nfiFM1hbgDSLTvLktApUOZwucLaJPgMQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC18dN7AtbP0CxIZ2mBumPV7U9jGaab49yCeCNLw+Q8=;
 b=kDHggnsovSdRp8cem6a58VAtg/sSqJVe3S2gu2mTpyCYOvXnRQucwC6ojMwjlBiJ9YEruZaY50ZGNY1NHR30iLFhfkd3jkgU9hUy3Bu8qYX5/PsHLibgbS4GzHXJ5Y0C6hCuuAHfVQK9uMKFgcE9fE0QOFHmWInykaGe1fd1rFXEWciwZi2Ls4HRkNvc2UVtnTZd7d62ZLXoraWRa4uw7MZ0MoSnNX31P16hzHWIrvePCJJ1Ofd1VWrJNEgng+gCQSYaDi98pEpMGKj72VGnsPhVmiECmhfRnG5ER8rGGIGRJk3kcMycCeADP/TqHt2uBtMAtHIH2AwfmznmZ6zwxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8470.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:235::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 12:36:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.010; Tue, 14 Jan 2025
 12:36:04 +0000
Message-ID: <89577261-dab1-4327-8c1e-b3cc4889b7f3@siemens.com>
Date: Tue, 14 Jan 2025 13:36:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] y2038: lib/cobalt: vdso: Fix runtime error detected on
 arm/arm64
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 =?UTF-8?Q?L=C3=A9o_BRIAND?= <leo.briand@smile.fr>, xenomai@lists.linux.dev
References: <20250113141003.3146947-1-leo.briand@smile.fr>
 <f9635d3a-6831-436e-bc01-b5d033318b04@siemens.com>
 <525144fb4682062710c34cae20a8bbc39e31db8c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <525144fb4682062710c34cae20a8bbc39e31db8c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:610:5b::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: a7028d33-2239-4df0-7dc2-08dd349802d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1N6TTlPNnAxZVNkVzU4NytWSG9DYlVxandNK3BFRDhjYmg3c3BsUTd0VWd6?=
 =?utf-8?B?cmd0KzA2RkVncjZSM08vRFYrRmZ3QXVjcmZJcEZZbG9uNE9uZms2T09xYTF4?=
 =?utf-8?B?WnQ2aUU1MzM3di9YcnQvUHNqT2lKNGhWbnRtc2dnVVB2K3ZvK2grc282a1px?=
 =?utf-8?B?MGxqNjdkMGpDaVBmZTVGOTVjUnhUVE1Ma2lZMFYrU1B5VnZaamRvL3VPWlBk?=
 =?utf-8?B?MERqQWhqSXlZWWk5S2ozcDBkVW0wVW00aVRoWTNmM2lEYldXMmFRUG52Z2Zs?=
 =?utf-8?B?c25lVFJYQXoyS0NMNzhyTDJ1b04xUkYyWkpNVWRNY1MvZDd3T0htNzArV3hy?=
 =?utf-8?B?OHJCODl0RkFpdlVIajhQaWlSVVV5Q3pXek5pdVNBVEFDREdtYUcyNDFyeGN4?=
 =?utf-8?B?NDFVdFFvdGNxS3kzU1hETjV1QTB1bXpYZG4va0RmZXVvcWdld1V2ZTIxQkli?=
 =?utf-8?B?RDlMd01OZWlERk8yK25Xb0EvZmI4dFVRcVErZ2t2Nks3RXZrRW1NNEVacnNu?=
 =?utf-8?B?YzdRaUdmeGNoT0hQeUJ0UGpJVlV1NTlYSFdPOEZXSlJwNnZEMnFBdHV5SWNB?=
 =?utf-8?B?MjZFT1NyYUloNUw1NFA2UzY2Mlg5OE5ndXljME1TNFg3bnVWbjJ5Y3M3Wmxx?=
 =?utf-8?B?ZXdGejdUaDV4aW55dElYMnJwd05nUEIrZk8rRU84SVVRU1RaZ2R5dTVYcXcz?=
 =?utf-8?B?SFBXQ2tjTXVEV0doYWFmZWhXN0JqQ3JWUTEvUjI2d3kzOWFmeWxrb1A0TE8x?=
 =?utf-8?B?UE9kL1VEUkxmZ0t6N05JTWZrVmNHMXIzMlRrTGJzWnZhaHRLWlF1QTdyTzhD?=
 =?utf-8?B?YU0wT2ZHbnNMRkdRY0pyNTR3dW1uWnlabDBmUUJGaGI1eFpJM1hzdU5sQ3RB?=
 =?utf-8?B?eU9uZlNwZ3N4RlZ4MVp4ZDVaUVRqM2dxSWlLcTZPUnhrb21sWDBaSkF4L2NV?=
 =?utf-8?B?aEJXN3cwY2ZsNFd6Q0w4R1IzVkpPMjRnaTBuYU4yTWxuN0RUaGxmSEFLSE4y?=
 =?utf-8?B?L21OZjlVcHd4c0psb2ZZc244c0t3RHlXcEVyQmkxVm1jQno1YW1KcmtIdHY3?=
 =?utf-8?B?VFFEZ0VaaE0wSXlPUElKVlBoY3VIczhlRFdtRzAyQkF4WDQ4TWdaR09QVlRU?=
 =?utf-8?B?NHZRWW5uQWZRbFV3OHhLUjlTT04xUXR3NDh0Z0JwZXVrb3JTNXZuZ3pmdi9a?=
 =?utf-8?B?b1I3U01ieWxUV2ZabUtTb3FWbGdCZWwwandjWVJwRFd3K3E1b2hsaG9KMWND?=
 =?utf-8?B?enVzeTc1L1F2NXZVbDl3NFI1RFBaQmhVTUMvUVp0bFlnNDd1Tk40Z1hjdTBS?=
 =?utf-8?B?aXNNdGhyYTM1N1Fyb0tHSUJBSi9TRnNRbnQzMXFHblJqMnF6T0dNeDE3RE1V?=
 =?utf-8?B?Z05xUDRZa05PendMdGp5aFQzMmUvSmFjalptR20xTU5tOHVZTVZ3UlFUYWhY?=
 =?utf-8?B?NlpvTmtCRVgwcWRRT2t2VkNKb3JuN3NjTE05SFZoQm5MNjYzNjNFekgxa0V5?=
 =?utf-8?B?b0J6Z0hNZUk2SzJEL3F6dWo1NkZUSk1CREE4VE5yTDdnK0F3TEhZWG9ocEEy?=
 =?utf-8?B?SnZWWS9xVWhqN2RIM3FwMnpoQVFyUFFZcCtXUUZ0S2xUeHlJYk82VERFcDVW?=
 =?utf-8?B?SGZOS2ZVN1RiOXRBbXViY0t4cUtIR3N3cEFkcTlIbFh2RVFhSURzenBudm8z?=
 =?utf-8?B?OGVWd2JRZ0lSSXJkYTN3Ym5GOGhrSzAyaFpSTW5UODMrVnlBRWgxcjF5cjBz?=
 =?utf-8?B?RkFXNEU4andYbHk0VVUwdjlUbFdOUWdsakxRekFIckRTU25jZm9QQkV5dzZo?=
 =?utf-8?B?dXVPbEZlbElDMUJTSlBydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUozQkNCc0xTc2FRN2tlMjJyUDYzMnhnOVQ0TFhGOFdTdFZxK0ZTY3FSU0h2?=
 =?utf-8?B?YXc3NGhlMWlERi9qakRXamNYSkFDTnpRdE5qOE81Y1JySUIrbXo0Q0RTcGcy?=
 =?utf-8?B?dDUrWDNLb040RjdDN1kxU3BoYmxLMEtCSUt6Si9kR2xIQTdrQkJqVHJEODls?=
 =?utf-8?B?NDR6QWh1cUZlN0IxcnJiMUdKRzdTcUs4alhzYkc3b2Z2b2UrS3NhUHUrM0Zx?=
 =?utf-8?B?QmtIeFIvSHlsTXpKYzM3QUNubEFWNHN6cWp2dExoTVpMMDhDUGNMVWNNUUxE?=
 =?utf-8?B?cGRQU2F1SWdQVitkSEYvVXdQTjU0aUNQNFd4d0RsZzJRQkhkdzhGbXlSMFJl?=
 =?utf-8?B?dEw5R0h4WjdNOWluU3RIdnZxNFdidGRLVkdNSzE0RUpoVXlKdEJzQWN0d0dJ?=
 =?utf-8?B?WnV4R25PZTVzNU8yMm56NHZJSmJ2UFJsRzhrNUZ3bENubGFzSzU1RHNhNHhv?=
 =?utf-8?B?OEFVTjRmODc0UGlkY2dtQkI4cHNyWU5ibTMyOVdIdU1DdUJwVDFjN1ZUcDFE?=
 =?utf-8?B?N1pxa0QwM3YzSHBha2t1S1dwQkdPWm94bGQ1UEtFRTFZWHA5cUZreG1hejUx?=
 =?utf-8?B?YytXU3ArMEQrUy93eWtJN1l0NmFuTmtQTi8yYjM3MWU0bHpSZ0NxUFVLOS8z?=
 =?utf-8?B?cDFpTVIxSythUGFGSVNtbXpzTEVmaHdvZ3JQdWFlVlR6Wk8xM0VUZnUvb2VX?=
 =?utf-8?B?dzA2Um0xUTArQkowRHVJNlFLaDY1OENJOHlWdzhaYkxuSHFreXNzTGZnTkZN?=
 =?utf-8?B?VUI3MXdleDc2Y3JSVHlReXVnWWpGWHRRY1piWXZMUk1ISk5QYVdlNjZMbS9y?=
 =?utf-8?B?QlczYlJpd3ZxcWdyVmRRTzIrOGRvSkNOdENvOVplRGZ4RENVRjd1V3RRQ3lF?=
 =?utf-8?B?MENQMjM2R3V3U08xVjNrQW51dDEramNkc2NtbGg2N05kRmM4Zm5zL0ZPUGNB?=
 =?utf-8?B?aW9sdjdlMDZzZTFPc2Q5cjM0MlVDWXRxWmZWZS9MT2poQ0dGQUV5eE1EVm01?=
 =?utf-8?B?M3FVTUZKZU9QMC93azRXbnNLR2xPT2RZM2I1ZUtoTWJ0eXRYSmlpTmd0Y0ZR?=
 =?utf-8?B?RUx6UmJTbHpGK0NjMW05LzNYQURZL2hnaXZIZHFvRThkMGtqWEd4OEZlTXRD?=
 =?utf-8?B?UlYzcnMwY3JLOW9QK3FUem1YMFAvdFRmOW5uMUVmL2VsMEZqUzBNSHdMQkQr?=
 =?utf-8?B?UW5LMVlQZXMxYkwyNWhUdGYrd3lWN3JJSXBiWW8vZXFXNGFEVjRSUFd6eXlt?=
 =?utf-8?B?M2VuOC95Q2xDUEJIaTdoK0hHRjJza2dQYXd3MysyY1M5ZVBtZjlKTVhZUUl5?=
 =?utf-8?B?VjgwQXM3c2hHT1Nxd0l3OW1YQW8zK1JVUkp6V0lOZWVCUDFlVitnWFphRDNC?=
 =?utf-8?B?S1J0endnZUhnejZteFFKc0oyUU5VRU9CenhtWEF5aTFNMmxkZ0cyZDJYU044?=
 =?utf-8?B?b2R1a0s5Z3NGQXN6Yk1GS2xHM3JJam1XcnNQcTlqM1lXbmUwTGp5OE5PWHVz?=
 =?utf-8?B?L09QQzlsdlY3ZjFkTUdZNUlDZzhHRTRtRllFS3FpR0lSZEN0VWt5Q1Z5QW9o?=
 =?utf-8?B?MVhKanVBL1VsZ0lRSG9TQ3g5RVg0enR0RFdJQVRRTHpHNkZWZlhweVpxcE9W?=
 =?utf-8?B?UVB5a2VXcWdaK2ZIaWlMeDRFM0lSMnlYQ0xzdGxJYUE5Snh3N3pQS2dwK3ZC?=
 =?utf-8?B?ZUxDNlI3VkNoRmlFcEhIQlpHUFFBWlZnRExqVHp5T3FyZkFGYTlmYmJtdHNs?=
 =?utf-8?B?NmxpTGFjK0hKMkJwMFJzdENMc096UWVDdlJGOFlJa0hsUzhsSGNaMitBVjBU?=
 =?utf-8?B?bjBsUHd5dExyK2J0TEpvZjdOcWNLQzJJbjR1VmZZdHhQb3A1Zkp1SkpKR0Rm?=
 =?utf-8?B?MDdUNW9oV016OGVKOHpmaGVtQ282UW5lYUNac25hV2xNb3Q1UkNXZ3p4VE5t?=
 =?utf-8?B?aFF2RlNBeVFZSXFsMmFxYVNvbXNvZVpwNnM3aFFvTXlFM09CanFwaXpiTTFx?=
 =?utf-8?B?ZEpXTWlsT3NYNkQ0NGdRSktvazAxZ2lKUnU1UzZCeDVUWEtUb3l4VU0yWHJE?=
 =?utf-8?B?SFJtVWJJSFZWb2xYUFhobWM5ZHBmZklBc3VpVzRvQTdkRkM4QnZUcG04TEcz?=
 =?utf-8?B?OE42MkR0cEYxeTZMbnFTMW11NUxvV3F2TE5QVVpTcDgzOW9vakFMWitWNkRM?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7028d33-2239-4df0-7dc2-08dd349802d2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 12:36:04.5679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RGA1UbteaPg7aDMO3buEW+Jew4+zXHn3xN9NQcOhbefSdvIrONys2KKvLPX6FAf7wrNEpq1By9nVKE+KqcKfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8470

On 14.01.25 13:32, Florian Bezdeka wrote:
> On Tue, 2025-01-14 at 13:22 +0100, Jan Kiszka wrote:
>> On 13.01.25 15:10, Léo BRIAND wrote:
>>> Issue:  Runtime error on arm64 application:
>>>
>>>         root@ls1046ardb:~# latency
>>>         latency: __vdso_clock_gettime64 not found in vDSO: No such file or directory
>>>
>>> Reason: Due to changed __USE_TIME_BITS64 behavior the vDSO init fails.
>>>
>>> Fix: Adjust the vDSO configuration to correctly handle the selection of
>>> `__vdso_clock_gettime64` or `__kernel_clock_gettime` depending on the environment.
>>>
>>> Impact: Resolves runtime errors on ARM64 platforms caused by incorrect vDSO function
>>> selection, ensuring compatibility with 64-bit and compatibility tasks.
>>>
>>
>> Thanks for the fix.
>>
>> Under which higher-level conditions is this biting us? Does it need
>> specific defaults of the toolchain, certain versions of certain libcs?
>> Do we need to expand our test matrix?
> 
> See
> https://source.denx.de/Xenomai/xenomai/-/commit/db203dc68964235b1c6b549bfaa2c3b88f736814
> 
> I looked at the testing part when doing some "forward tests". The
> result was that it's not that easy to add a single test job build
> against a different Debian version (trixie) which ships a glibc >=
> 2.40.
> 
> But it's doable if we want to test against the upcoming Debian release
> as well.

OK, so this needs a newer libc and would have hit more people in the future.

Thanks, applied.

Jan

> 
> Florian
> 
> 
>>
>> Jan
>>
>>> Signed-off-by: Léo BRIAND <leo.briand@smile.fr>
>>>
>>> diff --git a/lib/cobalt/arch/arm/include/asm/xenomai/time.h b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
>>> index 1b4947b2d..c260acf46 100644
>>> --- a/lib/cobalt/arch/arm/include/asm/xenomai/time.h
>>> +++ b/lib/cobalt/arch/arm/include/asm/xenomai/time.h
>>> @@ -12,7 +12,7 @@
>>>  
>>>  #define COBALT_VDSO_VERSION	"LINUX_2.6"
>>>  
>>> -#ifdef __USE_TIME_BITS64
>>> +#if __USE_TIME_BITS64 && __TIMESIZE == 32
>>>  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
>>>  #else
>>>  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime"
>>> diff --git a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
>>> index 9577aa773..06992e709 100644
>>> --- a/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
>>> +++ b/lib/cobalt/arch/arm64/include/asm/xenomai/time.h
>>> @@ -12,7 +12,7 @@
>>>  
>>>  #define COBALT_VDSO_VERSION	"LINUX_2.6.39"
>>>  
>>> -#ifdef __USE_TIME_BITS64
>>> +#if __USE_TIME_BITS64 && __TIMESIZE == 32
>>>  #define COBALT_VDSO_GETTIME	"__vdso_clock_gettime64"
>>>  #else
>>>  #define COBALT_VDSO_GETTIME	"__kernel_clock_gettime"
>>
>> -- 
>> Siemens AG, Foundational Technologies
>> Linux Expert Center
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

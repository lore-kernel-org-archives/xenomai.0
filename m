Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5E34029E
	for <xenomai@lists.linux.dev>; Fri, 20 Feb 2026 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771588197; cv=fail; b=W7pOEGXlwTQzQMCIqZGH2JGHTStDn7z/CHw746eMCrWXagbk2fAGlR68Yn7CteLJxFJ1XY8pQdEOxgBQs+xSuDD0SFy6tOquzR69/4BBOMwozbIz9q669w/g+tkU7LvpkOAdTooZrx2OedxlHJdhO9v486RgH6wyJsKaDInui7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771588197; c=relaxed/simple;
	bh=Su365CXOeul2f7KyDl/6tZrdhhnuE7ZPqnNGPWqQuvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lUN3ShKauOjuk3m+XtmEzq0UjQNB/UhAgpdLB7CEKMHjNj9VLcdXTw3XlrLaH50+5pwiKTt78GZFkpJTJclfZFpFjfhvjNxgcLGvDIB2wA7buGUd2+yOq7ODUQgUo/Q6MxShmnOeWu1FeHjtXM8w5sKXbJO16QbIHWXWLu9r8i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YKSLVQLa; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YKSLVQLa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdgfyf/Dtck7qQYmyZqC4KI3Z0jCj1fwSHuOpjajtuiLC4EHbPAmYQ2sQ34mqKOD+9k3iBf1u7KrJuGNbaO3NZ6W2Pg4wqmmQLGG2iw6WyRkr3vbLyIiCQFj5YoJgmaFB7ADZ1dF8dtBNSlcrZIg2H0c0cERF4aD8N2M28uubyHA65kJjK45zDqYb+51aqRx9Frg34OBq7LFWPxfoQ2EeeNVOoZ0UX2VLrKTUHQCjrZo1BwoZOY+KlTQePGGHp25PV+D1H8dsmGUnCz8JozWi+sV8g3TFUV4hdGFoi7OxfD2hQA2Zfkbu6m1X5CM40PNqU5TGzkWdn/XxO+LQXgFgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1SuMkV0h7gJE9CIqq0AaJdvxdSE5y2t1oY3oUqL/kM=;
 b=fA5mAxUSRabDc5a6AgIsv5U3inL78vdKgfPWKHpkXP6UHiVmGvu6AIfwdjkAer+y9V5PvijgziOHQq8DA7i9syYihLodDtvVBvPuPXwvZ0eo7lVGpLJ4u40FnYSh/FoX3MKuWrO4TsdZcyG7I/5lXEQEs5x2WWQIfg9POzJHJO7yKPA+NKDFejsasXxMqomz1ipVbUOklQsklyS36EgZTya+wyOUtvw540e1otBisZuJ2sIpGR5d1DfP4+zOBvYobDPIHhRY2vVuXrC965hmKLm//lYT6xt4dO4RQe12YY5JTYLtdpZmUF1rfJrK2rI9SvdM7nF3Q/mFokGhOQMWMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1SuMkV0h7gJE9CIqq0AaJdvxdSE5y2t1oY3oUqL/kM=;
 b=YKSLVQLaZgg+CzurjmClCVJNfQHNeMbJ1gjuEsen2VXLMROSI5ULtgJsXSZFVHXGo++4PHQetqv7cAAF+0GbeVQ/zHs2AF8bC2Hc8OdV7F2dU19rXWf+BPRjR3/zq4M9I63zTEtUSfmFNnliGO5fAwn8OzgsjZ1uGtPtCoco55GbG0ZcT7Pfksq7LWNKwKtPJPgFmBtVPOZGS0qW3nH9bMVcvJyumktTzfbIwz/fW/oZoDvzIOFiaqSnf+j+eWIDSqbBZ5J5P5QsiGxppkji69DEW4XRihzVi+9hQxovTxXlPWbuQhBzzJG7KyihP9iTg/npoYFmMJ9VIcnJ2T4dkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3630.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 11:49:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 11:49:51 +0000
Message-ID: <966dae77-2b67-4d78-a653-d9336e7ee6b5@siemens.com>
Date: Fri, 20 Feb 2026 12:49:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] y2038: libcobalt: Allow both, native + time64_t
 interfaces at the same time
To: Philippe Gerum <rpm@xenomai.org>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
References: <20260220-wip-flo-fix-time64-32bit-native-v1-0-731c773e72cc@siemens.com>
 <87tsvbhigf.fsf@xenomai.org>
 <faebe432-dddb-453a-91d1-77ee48a784ca@siemens.com>
 <87cy1zhdob.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <87cy1zhdob.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3630:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8fe438-eb93-4f41-7454-08de707627ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHU0VHhQQkswMTA1aHZneVZYRVdEcjdZbFZyUTd1YXZjY0dZdXUzTFN5d2Fu?=
 =?utf-8?B?UHpRVkpVYVNtMnkxVE9iQTREazU1OU9HUGdoeWdmQzFQSVNPeE5nVlg4TTU3?=
 =?utf-8?B?L1JTQlRiY3VwV0FqUVpuc3Y4MWRCb3RxTnhERENNQ25pcHBiamV4RG5kd1dm?=
 =?utf-8?B?NjBhV2xqTEkvWUxtTjVteThDbmY0eHVyU1ZhckdvZSsvZllnZkNoeXBtUkhp?=
 =?utf-8?B?KzZuRXBhQ1dLMzY3TWhpVE83TWl3WUp5NWJSMlBzS1pFVmVKcEt5M1hqVG13?=
 =?utf-8?B?a0ZwanBnTkxtUUJRWm1MSzNldjM3RU5OZWpvMTNtUSt0NzF4Rk9aK2U4cWk4?=
 =?utf-8?B?NHNFRFkrdHpaeDdxR3hYRHNpTXZMNk9nVDZ3VFRzSm96dzJHWTFjOVROWVBK?=
 =?utf-8?B?U1hEb2ZlaUhKakNFYWgxV2dySEdacUFQRlk4ZmlyTXUxcTNPdTRsR3VhTmJs?=
 =?utf-8?B?bWNHMWV0Ym5EN2lUNStyeC9WeFI3OWt2bnFXdW9zcjhIZEdJelBIdU9LRnNw?=
 =?utf-8?B?T25yMUM5ZEZybmQyOWJKYXZCa0lMVVBSK0EwVWVYM3J6UW1aYTRaVkM2VVc5?=
 =?utf-8?B?dHJVcFlnZ1BqdmxsRXZEdU55YjZzSXRmZThVLzdUOHJvUnJaeXZDL2dNbElU?=
 =?utf-8?B?ZmpHVHlQbVNWQ1E0YVZEM2xQd0x0QU82ZFhLSW9NSGxoMEY3bVdXTkxYbWkw?=
 =?utf-8?B?NXloWXgyQWV2a3ZYMFpMa0xsa01pVnNTSUwrWnliWmhCcHlaWWJPNDBVOTFz?=
 =?utf-8?B?MGxDNEhwb1AxTlpjdzZUNlVxanJjTzg5U3QxSGZrNkQ2Q1ZBeTk3ZTQvcVZk?=
 =?utf-8?B?RDU4bk9BRmNWallDQi91aGU5c1ZKbERqZVFSUDk4aDJ5eGs2ZjRQZGo3RFV1?=
 =?utf-8?B?OXVnb2Rwc25yMVB1UXp6MlYrNnJvcjZ4RnAwYy9NVk9MT3dFeUdTVFlDNnRt?=
 =?utf-8?B?V0lhS0FQWTBKNytBUEtFZDVENXgyQkpoS20vT09KSjRTckxmZXg3Skl6OXpp?=
 =?utf-8?B?YjZlZzgvcmF5VlE1WE1Cb2t0clF2b21NKzRoN2xsVUZjbSt6U3NvN2dZSHMr?=
 =?utf-8?B?cW9JN1dxbUhGc2J1NVFFTUgrcVBPcm9nejYvazJSTjJqY3VNV2JxWFFCR1FQ?=
 =?utf-8?B?SnphSXZlVmRzVnhwb3hJRTNsditKeGJLajhtUkI3SGplbzlieUowMXpDaHYy?=
 =?utf-8?B?WXVrMno1QWNDcHpaaGNhL2NZc1dMeWd6ZGwxQnVQNlgzTFVPcDBldmxQWlZp?=
 =?utf-8?B?dm8wQjUvM1dlK0x2YXVZWjJJd25VSFVLSHJWV1pFUEFicUVERk1vQjNYUkVY?=
 =?utf-8?B?by9GWUl3TXBWK1E5VkM1VWxibkRzbjErYWRLeFR1Szc4QUZaUFlvWUhVNCtF?=
 =?utf-8?B?YmRNQWs3WGdKMGRnejIwSWhKdkJqMWJ5SmRtcWY5ZnFWL01QVlFMdTdwb1h1?=
 =?utf-8?B?N05YOEpEbm52Tk9NSzNBajVKRy9IazNBV3VHUy9WaU5ZS2tjYmFKYVRFbmlG?=
 =?utf-8?B?Y2xjMWovQjNQMHdaTjNnNFJZb1ZlSkRpK2xXdWMvM3lpMkxEVVJaSDM5VHNP?=
 =?utf-8?B?QU9GeEhLWjIrSXp3VXZ4dG9HbkVqZDg1VGJNWGxzb1FpTDY0KytoR3JnYWlr?=
 =?utf-8?B?MjlSNUhjWUtieE1GcEQrL3ZOak1majFISEZnMHc3Q2s3QUlVUmp6dzhDd0pW?=
 =?utf-8?B?eUk1ZDlaQ2pmejRBbUY3NkNic1lNNFZCb1haL0E0NVZBbGl3dXlMazM5aTYy?=
 =?utf-8?B?OTFYTHdKMkN3cG84RVNlWnd1bkxpV3U0MlhuVzNuRzdHMmJYME5LZnZJMHYw?=
 =?utf-8?B?NlBoNnFrWGNBN2ZNY01lSEhTL0NrRUg0MWFRenNPaXg4cE9aYUNMdkJvTER6?=
 =?utf-8?B?SnVjUzJOLzNYQ1BGcm1WenFhMnkzMVF2V0FOQkNwQjUxUldKR3FTajdCMHNR?=
 =?utf-8?B?MFllYloyNWpOL0F4TVlLUEh3cFFnV0dDUnB0VmdpdFMwSFRybHRUN0s4dEdJ?=
 =?utf-8?B?SDJjelp1SnJRVDU3SGZVWUs3d1VuemVBSWk3SlRiNmlJOSs0dndYUkd3R0J2?=
 =?utf-8?B?c0NSbFN0L0U1azVnekc0SGw0UXhJVWNFU3U1cWg1aXZQRVdPczgrYVhSYjBx?=
 =?utf-8?Q?IsKU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2dtOC9MYmZIbW5YSERkV1JSZjNjMkkxMlJLRmJPWjVCc283RmVtdzZuWFMy?=
 =?utf-8?B?ZFNCdjhSRVorc0pTTi8ySmdxSnh4eHBjanhYVGhmSHFYNjY3cVdrRXJCRy8y?=
 =?utf-8?B?NnBpeFlxMmpGZTJ4WkxqcU1Gc1ZwOHk1Q1hUcW1YM3Y0b2xnVGN1RkM2MWF0?=
 =?utf-8?B?Z0pEeTZXTnN2TUUyeEh1eWNnOHNESzJEYkw0aFlFRjBWWktBYjFmMHRpRUJD?=
 =?utf-8?B?ekx0UERxRU13YTZzemZoaWpKREdVNXdvR2x4VHRJSzg3NitDVXdaa3o4ckhP?=
 =?utf-8?B?ODJpNVo2OWp6d3hkOHcrRUdkYUlnekQzakRhUWJjWHBpYk9YdklOTS9iOFdr?=
 =?utf-8?B?OGUrRkpoMGVQSis3T005TCtaNUIyZVJ5SUtFNXBDTG9LM1gwbmg0WVg2TFJB?=
 =?utf-8?B?UURtdGo4LzNEMGdwcE5EKzJFdG5pRVR6LzVDa01ScEtNUFBBakRmMmF1Zjl6?=
 =?utf-8?B?dWN2ejladDNvd1dNYXdZK1BMN1pHa2NmV0lHNjBLb0tLQUtFQ2NZSFFNN3Bh?=
 =?utf-8?B?UlVZYjlKZnhwNCtPTEZOeDJWd2tyK3BpQ0NQeHFadDh6LzBNVFIwTFl2bEFo?=
 =?utf-8?B?RVUyNlVQNWh4YUdxc0UzTjdjakV2YmVuaitUUHJRdGFZVm96ZDhlTExCMXhQ?=
 =?utf-8?B?MUl3aHZkWWxLMENpOUx0UXc0U0RMN3BmZGpkam5PMitrd2U1Mk5RREJRYVhQ?=
 =?utf-8?B?aS9idlRFWnZmNzdFa2hSQmZ3NVBYUlFzaGtaQ3BiR1c3NkdJa3ptbVc1cGdP?=
 =?utf-8?B?QjB5cGYvOCszeHNjRStmRnM2bVliTUg0KzVjTHUrcjRaRGRhVWtUVm9XeXFY?=
 =?utf-8?B?Q01jVHh3TVlpNjMzenBkOEgrRk9HVmpDMUR1WjI5QjRTUFVOR3gySHNjYlBY?=
 =?utf-8?B?aWZVNXFROUxTclkwVXk1KzJxZjFmQzFOWWRqcFpaaXdJU216QUF0cGpGK01h?=
 =?utf-8?B?b0VvTzBZREpZZjlzcmNSeGk4cXArWlArb0wza09SZlkrdG1DQUdPK2FPSE85?=
 =?utf-8?B?elJOK25uby9RSnlJRUxjMFdUZGFJL2ppN3ZZcnh5QUF3YW5kKy9sUUhrSHdz?=
 =?utf-8?B?MHZoSVc1S2tWS3JhcytMek5HUTN0OFVXYWRNWkpzWDR6bGd5SEl3aElYTDZX?=
 =?utf-8?B?TzgzR0xLVUExenluUVFOTjRxV3pVOEZTNXE2RkNvSHE2NXlIK2IvTWhBSkxU?=
 =?utf-8?B?THlXZGZPWThhdDY2MHdHK0V3ZTE4R1BPYUZJemhCbW5tZkJ1c01oQVAzeFNT?=
 =?utf-8?B?bzVhUmJvd1hVSnI4aXUyWU1IT3Q2YmhGN0JFd1dpUGt2dUdoendxTkRVcU1y?=
 =?utf-8?B?R2xjUXN0SFRnbEJnUjRoUlRFUzVnQk0rZEV4NFA1bFpHbVIwWmtsbVVIV2U2?=
 =?utf-8?B?OXNRVmJNZkJiS2tvM05qM0E2Y1l0N0s1b29iRWVvbVFwbytLeEJPWmxJZFdX?=
 =?utf-8?B?T095a3ZrOEYxck1Sc2NZMWJJczBPYVhlOWVwT2JlNDNISXFhc0lKTCtPM3lN?=
 =?utf-8?B?M2N2cTJXSlJCMkMrVHFmc2dkVTFtVytZK0F4U3NPSDV3bWtMSzNtSUVWUisx?=
 =?utf-8?B?Sk9DRWxLTElDNXZpSHAyUkRGc1EwVFI5TGdBOFJRY01ERWY0TmVTZ1MvMXhk?=
 =?utf-8?B?SDV6YmpQcGRFU2pQbE1KaDdlUm5TZU1iQWVXM3ZBWTlURHpnUnByTndtSmpr?=
 =?utf-8?B?Y04rcjY4VWhVQ1luVEpFNGFZK05RaVZ2QVhUUGZNKzQzVG9CV3FwNmhoWGhh?=
 =?utf-8?B?VlI4WEpFd3pPV05FZzc4WjQ0RGYyQ3F3ZUpLZkFnUXQzNzNCRy9SaDVJdGlY?=
 =?utf-8?B?a1ZFUXhReXlobFdoS1JXSU1ub25XTkVUV1oyRUxXRElMZ2pKRUtwRVlpdzRs?=
 =?utf-8?B?dUxuelcybnUwY0xzYThxcUhZbkI5S0taZVlsTkxiTXlpcDgwd1pmYVJGQTYw?=
 =?utf-8?B?L0ZNMHd3UlNlV0ZzRVdqd21wMVV4Ylhkd0djc1JzL1I2aE9iTmQ1MTFlQzlv?=
 =?utf-8?B?SnY1NHdMNDN6YWVWNjdmRmJZME4wQWE1ejJwK2JPNGdYdklCcU9DSVprVXlQ?=
 =?utf-8?B?cEFoc3lXbnY4MWQzbE5ySzU3eWF5SElxd2xoN3lOYUNKQ3FoaHZwQW1hNERr?=
 =?utf-8?B?RjYvYjY2TjllRkQ1NWxmRkg5ZTJ0bGVpc2JjdSsyNHorZEZjbURaZyttQUth?=
 =?utf-8?B?VVNHeXM2UWo2ZWdwdzhBQ0NUU2t0ZzNZbVZtejRmRE1GS1ZXMk1wdFkvcUwr?=
 =?utf-8?B?TEJEZTR4WmNZWlA0YjF4Rzh5QloyeTNKQlI1WEEyNERyVFloMURIbWx6SGpO?=
 =?utf-8?B?ZDEzQ3VqbG51UEFWTGhKQnl1YjBxSGRXZFg1U0lEVFYvNHgzM0g5QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8fe438-eb93-4f41-7454-08de707627ea
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 11:49:51.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aReGsmjn9i9gJYZ2yZRj3Kgbp27BfFrBNJQ8BPAyPZcjvh2RbguDa8/dOXe/eoCTcRT9ftirtO9rrkendFJzoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3630

On 20.02.26 12:12, Philippe Gerum wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 20.02.26 10:28, Philippe Gerum wrote:
>>> Florian Bezdeka <florian.bezdeka@siemens.com> writes:
>>>
>>>> Hi all,
>>>>
>>>> The current time64_t / y2038 support switched libcobalt to time64_t
>>>> only, removing the interfaces for the native time_t type.
>>>>
>>>> With that series applied both worlds can live together in one libcobalt
>>>> build which should hopefully increase the backward compatibility a bit.
>>>>
>>>
>>> Is this series re-enabling time32 in a way?
>>>
>>
>> It's allowing to keep the time32 ABIs around without having to use
>> --disable-y2038 for configure. It also resolves that we were changing
>> existing time32-only functions to time64 where glibc actually added a
>> separate one (see also
>> https://lore.kernel.org/xenomai/cd03fe98-7237-426d-91c7-c6eae63a617e@siemens.com/T/#u
>> - which probably needs a rework to align with this series).
>>
> 
> Ok, so this is merely to keep the legacy applications building over the
> latest x3 releases as transparently as possible.
> 

...and staying compatible with glibc ABIs.

> x4 is unlikely to support time32 for much longer though. With the
> upcoming support for a POSIX API, we can't make a pledge for a stable
> ABI yet - timeouts on syscalls have to be handled differently on the
> whole user->kernel path in the evl core services, in order to enable
> some of them for POSIX too. I plan to use this change window for phasing
> out time32 entirely in the same move, which would simplify the POSIX
> implementation significantly compared to x3, not to speak of the fact
> that using time32 for new applications in this day and age would be
> obviously wrong anyway.
> 

Of course. Best would be then to not even start exposing the old calls
anymore, rather then bending existing ones to time64.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

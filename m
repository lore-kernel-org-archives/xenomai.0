Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013022.outbound.protection.outlook.com [40.107.162.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498622157B
	for <xenomai@lists.linux.dev>; Tue, 11 Nov 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762883303; cv=fail; b=MqPlOMugzBrTkdKXam1WCynnZStEwlc6BS51khCNsEyax4x6KpDS70Ulje0HKfZFMnzcc51cfJTpfK+Mr41so9vdLpqaRfqQxBN0nAdsPw6sZbwOQamH1QEbfXAyj2FmFTE9T88oHgYKWONdFZtwwIoi1eInn6c5BdHLL3MnJ8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762883303; c=relaxed/simple;
	bh=W4RSQe1qrbd0Ma6MBs0m8YRuLEuMF/fjA2kUcEdG0Ck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dof1Rn5dA963FcMEwcN5cIE1hzo4Cv5mXqYScwbszO7RJjp5nvFH68E9Qjr/JxR4urqArf5rZoXDZ0gCKsJ611T6Yf548T1LKVIJ76wa0LjkFHbXGDFT1bQyUdXHoJwEp0tUB5GVRony51NyTUdNGmKGHtSNNS2S5TWvx8wh7Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uUkLgh2v; arc=fail smtp.client-ip=40.107.162.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uUkLgh2v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wdTkBNO+dW7gt/00G2U6IanyYXMk10dvyn4Fd8zVvr4CFxBf5Uihmgjqed3BCIzWberl53ZwgtVIItzoyOr3OFT9UquUa2duc4ijjZdkNnjT6apWm7ZOP93ALRq4LCzLb0iOipYH9aeyBVlkn6fnkF69CjhrDxBABs8vKY+ycWtLsZQu2J+P8SBex2GZvbYmWD8YhIGVJArocuDhi9Cv+/a1ymYQswPBPoBoMCUYbJTLBrwls+HY9fhVjiCg+v34/ORVPelpS7Dx3Aw0/TSkVIEYuekDmj5n6/y7T+1egYN7myEG/0eBT1tghnlpbVEqLnbV6fhc4o3JqFx2V7btCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77drSWlXmyNxhfsbI2cwpYmmw3kvQPGOCnYVf/+Aa84=;
 b=omxL2wf3ymi/ChHM+ulggCca9eYICF1rzue03yXPXtzMlyvlB9HVJPShIGdUkTyy7/Sg8QA3INFn5L6kgP3sco1S9meofOJEufWT91piYQLkF8y8CFWUppoZsl3hqqObmg2bZMSRfkbEExFJcTkJk25qvfTRwm/6TtazfgDE8YBkM7J0X8A6uXnztkOxkmyxAmHIGBX99R27wDlZ+7KtV5USh6ZDhHjdmok+X37sb/NSMikw+yXMMdvSgGuub1EI0NM5WMi26lWsH4RpqNn+Xm9TTkVZxUki+64VMiHr0uowjzoOkLBXZsGLQLBNttQ+EDwDfZ7EcmZeWcvUlMdy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77drSWlXmyNxhfsbI2cwpYmmw3kvQPGOCnYVf/+Aa84=;
 b=uUkLgh2vXMBgDs/X0EMtvfvXt4mOgpFEYq0RYOPdyKPpz45UHSctW+5Z2Qc0OGfHk+OIYHjsX+ASME06qpgehDY1oWzUwnJHffn7ESO2bjHciiqBdApzZLOQ/AtV8Aw8xQdhRYNjeMp5hPpi9eN+Ds2LQW5X79h1EXkoMLdZk3SXChvES8kuuthKXX4/gZojotfufZn9nfE0JOM29cFXQuv5P48Vp5KGl43WBvzYSbPEbRH/5YVqViansP0E/Y6mPR734PnzG1UY3+LenseyVSxZwPaFgADvwZId0FKbS8PeYHIq8zjj6ngFRyYp57eCrNhpTlok6mXMZqQRWGQxMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA1PR10MB8625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:444::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 17:48:18 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 17:48:18 +0000
Message-ID: <dcfc1a13-f380-4f53-b8ce-9a0b747ec7e1@siemens.com>
Date: Tue, 11 Nov 2025 18:48:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v2 1/2] linux-xenomai: Add arch specific
 debug kernel configuration snippets
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20251107080005.1272435-1-tobias.schaffner@siemens.com>
 <20251107080005.1272435-2-tobias.schaffner@siemens.com>
 <1c4413b7-6d87-408e-9854-bd2c6e0daac7@siemens.com>
 <7876b2fb-e3cb-4815-91eb-aa262c1dabbd@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7876b2fb-e3cb-4815-91eb-aa262c1dabbd@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::7) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA1PR10MB8625:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9a2811-5e1c-45a3-a659-08de214a7f30
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am5HejNGcENjdHFxNDBNTnpwelJhZVIzUy96UWdCbndXbloveUI3MWFTL1ZU?=
 =?utf-8?B?eWdhdnN3TVVvVXBSQ3VSUnVMN05LNXM5NnNZWnB1RlpYRWZuZm10SXRpRkE0?=
 =?utf-8?B?Wkpzb1BnUVo5b3BuY2hsdnNTWGFXMU96WkxVcHFWK1FyRlNBald4NGwrSmRM?=
 =?utf-8?B?N1N1TGZySHRrNUdaT25FTFFNcjBidGdKUTlUQjBvYXZBRWFMeDEzMngwdFFU?=
 =?utf-8?B?eXdTRHR0RjFQekduZ2xhcGxMNStjT1k1WDBSaSsvZ3lJLzN1UkYyZnQ4enhG?=
 =?utf-8?B?aWNuNWthcTZJSFdic1BLazg4VmsycFR2d0NlM2c5T0hja252M2MvZnkyMmxM?=
 =?utf-8?B?aVUxb3g1cG5LTVNnU0tUT2NVZ01Vc0tOeUxEUnVmZGlnWGVMTGJ3bHR0RFcr?=
 =?utf-8?B?cS9jRzdHWloyKzdyT3NhQTdTSDhZaTRnTVVlaHNrdzRBYkJlSkFpc3djUmdT?=
 =?utf-8?B?Q3h4RG11OGhkVGF4ei9GQmd6OU9uQWo3ZlMrNXQvM2J1c0NuQm9jUHFuc0Vz?=
 =?utf-8?B?K3diYlBsNXZJaGp5dnpBTTY2QXpjUG9KME9tdlo5Z00ydjZDV1pEQlJ2eTZR?=
 =?utf-8?B?TldJQmRpWnI0Q2lCd3k3QWNhcEFablowc2t2YjkwTHZLSUhBM3NEUzZUcFlO?=
 =?utf-8?B?UUI3QVV2L09yano4M3lpQTVYQnJWSit0QTJoaEpHbW1GQTVYRmkrY1NUNVFT?=
 =?utf-8?B?UkIwd1ZzWDMwVzZ3cGZsNnFKemJnRnFubmxrR0VwSThYNW8zTnF0ZTN3NU0r?=
 =?utf-8?B?Mm1YVjZPMEZjNFpkdW5VODhUWnQxeVQ0TWdDS0NRcGlhR1NVT0NUSitnWGpu?=
 =?utf-8?B?WmNQc2hDQjNFYzROR0ZDaTZHaTlaUUlKT3hNbm5oZk5hRjgzWkJvZTZIK09y?=
 =?utf-8?B?NVpLblovOGpncU5OblAwMWxZWlhvOFhPd0JGYzUxVkxubXNwc0ZqdTU0SW9R?=
 =?utf-8?B?Ti8xVUs0NlVDRTY3Y2Y5RFI5TjdPbmpiNXcraUliSVd1aWdFUWEwOTJ6THY0?=
 =?utf-8?B?YTdGOWMyQ3dobjhOd1BKQjloaTU5ZTNHUlI4Wkw1Mld6eDlnSndTeDJITXhW?=
 =?utf-8?B?RUZTU3lCZEY3QURhTmJqSTRzTHgySG1iVmVzS1pVYWFXcTFSa3FrU2VTTTBW?=
 =?utf-8?B?VUZxYTdsZVh5K0ZYSm1GSGR2VUN6dGxQcmd0OUtTT2tlOE1CMDJ3VFAvVGp0?=
 =?utf-8?B?Tng1aEZocU5pa1FTYUJEMGlmS0kyeDhtVC9sUXFwbE5FMUg0SVBmUEVFSmNi?=
 =?utf-8?B?USt2TW9uZ0VSYWJ1dE9SMGE1UEo1ZndObnJscnVqaVlLS0hSaW40S1NRZUww?=
 =?utf-8?B?QVlSWTZBbE5sb2g1aC9sd0JHTENHamR5MXpyNWNRL29NVlRpQ3lxZFJZWk1P?=
 =?utf-8?B?ZndMTFl6V3ZNZ3ltbDc3VWxqNjZZVUkyc1lVbElYejZYZG93d1pmV2RpeGNm?=
 =?utf-8?B?ckk3dGR5bjZkNmorL3kvUmdyQkg5ai8vTXFiVTIrMFFLOUlHNFVGV0RUT2da?=
 =?utf-8?B?dlZ1ODdkNEoxdmU5TzRDanJiam1STFFXTUFia3lvWHhXYnY0cUhCY214Z0lQ?=
 =?utf-8?B?aXg2QSt3cUc0T2FYem1idXpBM1RwRTVFT2RMR2VSZXJkaTh1TEJ2RHEzcHRZ?=
 =?utf-8?B?cHM5YUJnUUJKS3k0VnZRTHJsV0JYMi8vM29icDk1NkNuYjRveGFzR3JuakY1?=
 =?utf-8?B?SjBCbjRyM2xndzl5RFJ4WCs1OWc4MmxORlhmUXE3U3A2M3hpSDFWWDhZbmov?=
 =?utf-8?B?dzZLMzlNbHFFc1R6SUI4d1RqbUZlNjBSdHBhd01uVW5UMWEwZXBSQVlscGZ4?=
 =?utf-8?B?Smg4SXNxMmJja042WTd0VGp3OGl2eGtRaS9VSWZYUm8reEFVVEh3UnpjL3Nw?=
 =?utf-8?B?VDZvMHpJUzBQR2pQRVlNZkR5bFFuSHJWc1dQMmU0Q01lNFUwbzRvWWM1TWh6?=
 =?utf-8?Q?RYP9rv4cViJ/Kamne55gCnEn72J++BV8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REdmb3JueERxazhOTnlwS0NadEdMTnZtVThRRndWUHZkcUhhc0x0L21uZExP?=
 =?utf-8?B?MUVuQ0NncW5vYnNkTlhtN3lOR0g0d0NFZnpSK2pnT0R0TnhjRUNGbWVQajFk?=
 =?utf-8?B?YU1hYjVwd0JTQVlzSXpERXRKbjMzelZPV2UzWjF5UXNuV1VLc0dYWDBaQVNs?=
 =?utf-8?B?TFo4bVYva242TWpOS21OSzluWCtMalBKcjdtRUxYTWdmM2hHd1RTRDdDTWpX?=
 =?utf-8?B?R2d3RzJqOEpIbXVzNkQ4UlRmYzhiczR0QndlRS9zbE01RDY1QnBlbTVQdFlp?=
 =?utf-8?B?R0t4M1ducEtONlhTOFlaRzZKOXZ1UzlxK0NPdzYvNWtVQkt6eHNFUEtJOUNI?=
 =?utf-8?B?b0I0akpKOUtKcEV1WWVweFVwbXUxZTdrOGc3L0gxWjkxVTlJcUlRSEdycU5w?=
 =?utf-8?B?bDIwbEhJZzBhWFRaNG95S25NQ2tPL3d1aGxjc3o1eVFNVVFYMGIyblNaQWxj?=
 =?utf-8?B?aUc1dEQralQ0cjlEZUN4QjRsMVJSTHExdDBhb3k4c3Y3NlVZYzEzckhHVG9F?=
 =?utf-8?B?YWdQcXowcnljajVrT01hZEh3cHBEenNpdlRWVE5TaFJwcUE0cVo4Z05VV3RQ?=
 =?utf-8?B?aTE4TVNpd2lYNFk1MmN4ckRLbC9HUGoyVE9ZTXJSZWZWNTQ4MWZ3WEJUODVR?=
 =?utf-8?B?QThzUlVGamFYT3h0eTVaeWFGMFU4U01tdmpodllGVEgzZWVWK3F1T3htSGFD?=
 =?utf-8?B?ajMzM3NQSU5XMVdTWW9jT0Q1a0pXbFcxKytnam90ak1nS0kxVmlwbFJIcXJH?=
 =?utf-8?B?bDdGcWtZVHNyZ3p0SXFmem5IUFhnY01rVlkrN09Ka1RaVVN1UExKbnhINS9R?=
 =?utf-8?B?bGk2T2Nna2NFTEFtakNyMVE5bm9WQ2JGeTdKVldibldRVVVHVnkrNmFUWmlE?=
 =?utf-8?B?WTNBSzJGR3FCQTZaaEFYTm9TOXEyd01sZXRFd25KaUVyYUZVWHFEbzhMU3VI?=
 =?utf-8?B?S2tOK3FIY25TbnJiMEFCdDJzem90eGFYNkQ0TXNsT2o5bEpxTGJod2trS2Ew?=
 =?utf-8?B?Z0RpYXhSV0pPSU0zS3hGdDgxMzYrenAveUlCdEp4cXlsN3N4Q1kxVGhULy9q?=
 =?utf-8?B?aUdhaHN3cmNSZXJ5MFdudE1wcE1ORE13d2ZKOVp0eEwrSXN1OW9CTU1Oc2p6?=
 =?utf-8?B?N2ptM0ozdkZzNmV5aTNXcWhLbXNlSWRDTGtITHFhMnF2NWZ2dndKR1QyWWUv?=
 =?utf-8?B?TUNqdWtEeG5Ka2NjU0RJdnVxN1gwQUpXUWk1SVhuM3NFNXF0OGg3RzIyUElU?=
 =?utf-8?B?NnB5cW8zU3RHL2x2K3doWFkzUkN1a0ZUd2lrTzFTTXdIL2VlYjZnYnQwKysv?=
 =?utf-8?B?Y2Q5aEFFenhIU0xtc2RDNGJiTGJsQkdDM1R2UnRzOCtYeThLd2NlZ2dONVdw?=
 =?utf-8?B?WkVvWjQxQWZzRFBSS1RWcUdIWnZieTdBTTV6NHVEYUh5ckVsdDA1Tk1MeUZD?=
 =?utf-8?B?T3Ftb0tEQncxZWwza0hLeG5hZ3JVT0lQR3ZPVHlVeFk4R2VlWDlyakdzSUF0?=
 =?utf-8?B?eUFwZDdaNW8ydDdzNnhWcVI0WXBYNXBMOWYvdzNzM2pMZHNTWm5IREJ0MDBS?=
 =?utf-8?B?R2IwTXRkdW5OeFIyb0FZeXNSd2JBT1VOQmh2YkpkRkw2cUl0V3ZXNm5GQ2ZJ?=
 =?utf-8?B?dTFET2pQVmNnZit0NUVEOGZuVzlZR1V1b1FuUmdNNXV6MWpaQ0ozZk56Qm81?=
 =?utf-8?B?b1dKUjRDQ3NuL1pkbEo3bklJdkhyMHlyNTNMN09UTkt4VDZ6RG1TQVJkaGVJ?=
 =?utf-8?B?TmF1M1NadGRSRTdCWjZXUnRhMWo3N2h4NlVWNjk3VGh4Q3NabTllMHk3LzJ3?=
 =?utf-8?B?NkFqUnJ1RDB5UnE1UXhBSEhqVlROTlR0clpobGMrZ3FScitXT0lvUzhnamFB?=
 =?utf-8?B?TURuNjFLR1cwUnVnVm1kT29hY3B0dmJQMGhJMWloSkN5bGw4Ni9HcGNSTVY3?=
 =?utf-8?B?RTZ6Tk5PNlp1WjRvRVVlQnVvYjRqYm5HeXQ0clNwb1RJSjd2a2pMOHFGcEdt?=
 =?utf-8?B?ZTJBVlVmWjNDQnNDdjRuNENFR1MxZ0ZOSUNaTHVqUnIyOFNBMGdCM25pYm1z?=
 =?utf-8?B?cTFQVERQN1pBektjcm1hQVFOUTRYWk0zMFZ4ZWhUM3ZlMnNBKzMreVk3bW1Z?=
 =?utf-8?B?RGRnMUtyNFdwMTNsSGphbFpqY04wSU01VDhUcC9VczZENFF5QVJPcEVQVjBP?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9a2811-5e1c-45a3-a659-08de214a7f30
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 17:48:18.5608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NlLCtUJxRX192m5iVmKo1VQ/YVTlDzgsQAzVs0a1UaH0KxNsu1cM7swVlQGZS2LwSmBVAhQd6U62TRPhvMoEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8625

On 11.11.25 17:36, Tobias Schaffner wrote:
> On 11/10/25 07:25, Jan Kiszka wrote:
>> On 07.11.25 09:00, Tobias Schaffner wrote:
>>> Add dedicated debug configuration snippets for each architecture to
>>> consolidate common kernel debugging features. This replaces the
>>> previous approach of using an inverted no-debug configuration to
>>> disable debugging options.
>>>
>>> Separating debug and no-debug configurations improves maintainability
>>> and simplifies future consolidation of debug settings across
>>> architectures.
>>>
>>> The change has been verified using the kconfig library. Applying the
>>> new debug configuration to the updated defconfig and running
>>> ‘make oldconfig’ produces an identical resulting configuration to the
>>> previous defconfig for all supported architectures and kernel
>>> versions.
>>>
>>> Several debug switches that were previously left enabled in the
>>> no-debug configuration have been moved to the new debug snippet.
>>>
>>
>> Do you have an overview of those? Would it be a lot of effort to factor
>> those changes out?
> 
> Hi Jan,
> 
> these are the config changes for all ARCH - kernel combinations in the
> nodebug case:
> 
> ------------------------------------------------------
> - AMD64 - ipipe-x86-4.19.y-cip
> ------------------------------------------------------
>  ARCH_MEMORY_PROBE y -> n
>  BUG_ON_DATA_CORRUPTION n -> y
>  DEBUG_FS y -> n

This is harmless.

>  DEBUG_KERNEL y -> n
>  DEBUG_LIST n -> y
>  DEBUG_RODATA_TEST y -> n
>  DEBUG_SECTION_MISMATCH y -> n
>  DMADEVICES_DEBUG y -> n
>  KPROBES y -> n
>  MAGIC_SYSRQ y -> n

This one as well.

>  MTRR_SANITIZER y -> n
>  PAGE_EXTENSION y -> n
>  PERF_EVENTS_INTEL_CSTATE y -> n
>  PERF_EVENTS_INTEL_RAPL y -> n
>  PERF_EVENTS_INTEL_UNCORE y -> n
>  PM_DEBUG y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  SCHED_OMIT_FRAME_POINTER y -> n
>  SLUB_DEBUG_ON y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_ANALOGY_DEBUG y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_GPIO_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - AMD64 - ipipe-x86-5.4.y
> ------------------------------------------------------
>  ARCH_MEMORY_PROBE y -> n
>  BUG_ON_DATA_CORRUPTION n -> y
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  DEBUG_LIST n -> y

Why is this being turned on?

>  DEBUG_RODATA_TEST y -> n
>  DEBUG_SECTION_MISMATCH y -> n
>  DMADEVICES_DEBUG y -> n
>  KPROBES y -> n
>  MAGIC_SYSRQ y -> n
>  MTRR_SANITIZER y -> n
>  PAGE_EXTENSION y -> n
>  PERF_EVENTS_INTEL_CSTATE y -> n
>  PERF_EVENTS_INTEL_RAPL y -> n
>  PERF_EVENTS_INTEL_UNCORE y -> n
>  PM_DEBUG y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  SCHED_OMIT_FRAME_POINTER y -> n
>  SLUB_DEBUG_ON y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_ANALOGY_DEBUG y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_GPIO_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - AMD64 - v5.10.y-cip-dovetail-rebase
> ------------------------------------------------------
>  ARCH_MEMORY_PROBE y -> n
>  BUG_ON_DATA_CORRUPTION n -> y
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  DEBUG_LIST n -> y
>  DEBUG_RODATA_TEST y -> n
>  DEBUG_SECTION_MISMATCH y -> n
>  DEBUG_VM_PGTABLE y -> n
>  DMADEVICES_DEBUG y -> n
>  KPROBES y -> n
>  MAGIC_SYSRQ y -> n
>  MTRR_SANITIZER y -> n
>  PAGE_EXTENSION y -> n
>  PERF_EVENTS_INTEL_CSTATE y -> n
>  PERF_EVENTS_INTEL_RAPL y -> n
>  PERF_EVENTS_INTEL_UNCORE y -> n
>  PM_DEBUG y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  SCHED_OMIT_FRAME_POINTER y -> n
>  SLUB_DEBUG_ON y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_ANALOGY_DEBUG y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_GPIO_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - AMD64 - v5.15.y-dovetail-rebase
> ------------------------------------------------------
>  ARCH_MEMORY_PROBE y -> n
>  BUG_ON_DATA_CORRUPTION n -> y
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  DEBUG_LIST n -> y
>  DEBUG_RODATA_TEST y -> n
>  DEBUG_SECTION_MISMATCH y -> n
>  DEBUG_VM_PGTABLE y -> n
>  DMADEVICES_DEBUG y -> n
>  KPROBES y -> n
>  MAGIC_SYSRQ y -> n
>  MTRR_SANITIZER y -> n
>  PAGE_EXTENSION y -> n
>  PERF_EVENTS_INTEL_CSTATE y -> n
>  PERF_EVENTS_INTEL_RAPL y -> n
>  PERF_EVENTS_INTEL_UNCORE y -> n
>  PM_DEBUG y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  SCHED_OMIT_FRAME_POINTER y -> n
>  SLUB_DEBUG_ON y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_ANALOGY_DEBUG y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_GPIO_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - AMD64 - v6.1.y-cip-dovetail-rebase
> ------------------------------------------------------
>  ARCH_MEMORY_PROBE y -> n
>  BUG_ON_DATA_CORRUPTION n -> y
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  DEBUG_LIST n -> y
>  DEBUG_RODATA_TEST y -> n
>  DEBUG_SECTION_MISMATCH y -> n
>  DEBUG_VM_PGTABLE y -> n
>  DMADEVICES_DEBUG y -> n
>  KPROBES y -> n
>  MAGIC_SYSRQ y -> n
>  MTRR_SANITIZER y -> n
>  PAGE_EXTENSION y -> n
>  PERF_EVENTS_INTEL_CSTATE y -> n
>  PERF_EVENTS_INTEL_RAPL y -> n
>  PERF_EVENTS_INTEL_UNCORE y -> n
>  PM_DEBUG y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  SCHED_OMIT_FRAME_POINTER y -> n
>  SLUB_DEBUG_ON y -> n
>  XENO_DRIVERS_ANALOGY_DEBUG y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_GPIO_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - AMD64 - v6.12.y-dovetail-rebase
> ------------------------------------------------------
>  ARCH_MEMORY_PROBE y -> n
>  BUG_ON_DATA_CORRUPTION n -> y
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  DEBUG_RODATA_TEST y -> n
>  DEBUG_SECTION_MISMATCH y -> n
>  DEBUG_VM_PGTABLE y -> n
>  DMADEVICES_DEBUG y -> n
>  KPROBES y -> n
>  LIST_HARDENED n -> y
>  MAGIC_SYSRQ y -> n
>  MTRR_SANITIZER y -> n
>  PAGE_EXTENSION y -> n
>  PERF_EVENTS_INTEL_CSTATE y -> n
>  PERF_EVENTS_INTEL_RAPL y -> n
>  PERF_EVENTS_INTEL_UNCORE y -> n
>  PM_DEBUG y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  SCHED_OMIT_FRAME_POINTER y -> n
>  SLUB_DEBUG_ON y -> n
>  XENO_DRIVERS_ANALOGY_DEBUG y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_GPIO_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - ARM64 - ipipe-arm64/ipipe/4.19.y-cip
> ------------------------------------------------------
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - ARM64 - ipipe-arm64/ipipe/5.4.y
> ------------------------------------------------------
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - ARM64 - v5.10.y-cip-dovetail-rebase
> ------------------------------------------------------
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - ARM64 - v5.15.y-dovetail-rebase
> ------------------------------------------------------
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - ARM64 - v6.1.y-cip-dovetail-rebase
> ------------------------------------------------------
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - ARM64 - v6.12.y-dovetail-rebase
> ------------------------------------------------------
>  DEBUG_FS y -> n
>  DEBUG_KERNEL y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  PNP_DEBUG_MESSAGES y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
>  XENO_DRIVERS_NET_RTCFG_DEBUG y -> n
>  XENO_DRIVERS_NET_RTIPV4_DEBUG y -> n
> ------------------------------------------------------
> - ARMHF - ipipe-arm/ipipe/4.19.y-cip
> ------------------------------------------------------
>  DEBUG_ALIGN_RODATA y -> n
>  DEBUG_BUGVERBOSE y -> n
>  DEBUG_FS y -> n
>  KALLSYMS y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  RCU_TRACE y -> n
>  SCHED_DEBUG y -> n
>  SLUB_DEBUG y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
> ------------------------------------------------------
> - ARMHF - ipipe-arm/ipipe/5.4.y
> ------------------------------------------------------
>  DEBUG_ALIGN_RODATA y -> n
>  DEBUG_BUGVERBOSE y -> n
>  DEBUG_FS y -> n
>  KALLSYMS y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  RCU_TRACE y -> n
>  SCHED_DEBUG y -> n
>  SLUB_DEBUG y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
> ------------------------------------------------------
> - ARMHF - v5.10.y-cip-dovetail-rebase
> ------------------------------------------------------
>  DEBUG_ALIGN_RODATA y -> n
>  DEBUG_BUGVERBOSE y -> n
>  DEBUG_FS y -> n
>  KALLSYMS y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  RCU_TRACE y -> n
>  SCHED_DEBUG y -> n
>  SLUB_DEBUG y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
> ------------------------------------------------------
> - ARMHF - v5.15.y-dovetail-rebase
> ------------------------------------------------------
>  DEBUG_ALIGN_RODATA y -> n
>  DEBUG_BUGVERBOSE y -> n
>  DEBUG_FS y -> n
>  KALLSYMS y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  RCU_TRACE y -> n
>  SCHED_DEBUG y -> n
>  SLUB_DEBUG y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
> ------------------------------------------------------
> - ARMHF - v6.1.y-cip-dovetail-rebase
> ------------------------------------------------------
>  DEBUG_ALIGN_RODATA y -> n
>  DEBUG_BUGVERBOSE y -> n
>  DEBUG_FS y -> n
>  KALLSYMS y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  RCU_TRACE y -> n
>  SCHED_DEBUG y -> n
>  SLUB_DEBUG y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
> ------------------------------------------------------
> - ARMHF - v6.12.y-dovetail-rebase
> ------------------------------------------------------
>  DEBUG_ALIGN_RODATA y -> n
>  DEBUG_BUGVERBOSE y -> n
>  DEBUG_FS y -> n
>  KALLSYMS y -> n
>  MAGIC_SYSRQ y -> n
>  PERF_EVENTS y -> n
>  RCU_TRACE y -> n
>  SLUB_DEBUG y -> n
>  STACKTRACE y -> n
>  XENO_DRIVERS_CAN_DEBUG y -> n
>  XENO_DRIVERS_HEAPCHECK y -> n
> 

So, this was helpful (and that's why I'm asking for a separate commit):

 - 2 cases where things could be left on
 - 1 case where debugging is enabled, instead of disabled

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

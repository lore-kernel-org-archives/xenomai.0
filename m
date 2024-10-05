Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C117C8D
	for <xenomai@lists.linux.dev>; Sat,  5 Oct 2024 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124271; cv=fail; b=q+LZIoYkxWoyQasEvoffHwZ750AA/fVA1rHzZBUTSPryTuDyNHNr4PuaGY2jUmz8TmHC3EoTLFuoTo4lbumJMx/ilcHsO1PN6aka+n18E5AVnlxxFhtAEYxurwqbbPBrdOllvQ8XIqJPDuHZ4B0OJFnfjV9fcBeepUVBFJXTIP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124271; c=relaxed/simple;
	bh=wn/f8kDCTZ8xIAjgZe6Js1U3byiWyeCpoAG6vg2kIk8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KEKP8HB4Bk6IKQT/+k3QlY3Quc1AX7ohWggmKmsaW3jByOA+Rnt4LN6wWKcvC9EF6Xf4I8FuAHQ6GYlRgFB3RP0iV4j8Rny9K5Eu4J0Mr4/GB7UYCjVXmIRqSXE6+xoVG7cFrKpbFssbu363xZ/c8dWRMYmh2xW5txSKs8xyo/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Jf8mERsz; arc=fail smtp.client-ip=40.107.247.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Jf8mERsz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0n3KOf2GRD+UGAjK5S1a3hU//PUotp0gO5+4ln705CkM3cqtXWFQr+8hnBovVWhW6dPbhQ8BXuLtxRUdxi/CMPL9RWo7qzngMDYDOBFWX91Mx8+00XIEX1AQBiX8oA9o40UBWmzF7kclclScRYkYEp95bcqnKqMZyM5tMxx1/eprVV65UgVmxYRwhhkVuCzqpyFWnb4hhGHlnmRpGs3LSTKmj1bH3gpSfd/R/ZMMlrvcGD3Ig9Z/tQYTZO+FgC3Z7eDfEn9AY4cK0rp5H9ol8E3qw0AMbiPRQSn5ADuowM2JcJUaTRihfzzkBOV1uRoPGRCoJk90cqSf0d65fJSSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn/f8kDCTZ8xIAjgZe6Js1U3byiWyeCpoAG6vg2kIk8=;
 b=hVBtZ87Y4TeUiXEWlJVOMvQ7vep3HOsZ+nYdei2wTLzzYVANQwMo57JqLGdMIb53DWVqiPgublelU2e2pbAnXan0OmKcDAUwAjq0zODmemUZNyNL1Z34LXN9jN1lwTSLZFVneCkFK1PGcwZg1Gf6Oh9CyBjvOmgw7sDJi1y6F4YwvmrOvBDjNII9LBsgy2F1HDORSxLQbMdqp7F4vR+REevjLROUY9xg9ScjBxzp5bawQj0OIe07QRNJ4BlbpRl1h1ouo8BkvY5RG34whNbbv9qks+HdLB/V9SuheV2tHS3N48PbbkG9qpmec4S8Fe3SCswJHcJSDM+6VGRFbJs5Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn/f8kDCTZ8xIAjgZe6Js1U3byiWyeCpoAG6vg2kIk8=;
 b=Jf8mERszoUM+htXhyueSy5Tc3X5+HTGNugIIXPRGfjBDksy35AtC3q3xa66UOAOg8X5tW2d5gVvD9ibUItJVJIaUzIdsRjk9nGk+S0+JaHXb5RgpERHuUhKzThEo8geP7g721neXtE7zIffmMolbAU1lEFZwARfSE0cSW2MX4feULXugfUu6PrdSL8NTmlGmFp/SOJrE5rG/CPr7N/wwUqsOOE1I9RefloSEK2vPcm0zRxJL5pnPFaWl8RuJp0grHe8fO0+TQ6qn2NS0RvTg0DQKX+2LdUzG8VzeRHhJvcwqtjXSrK747otewwj0bWG51+6elezvfHl3TR7nuYMGQA==
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB5533.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Sat, 5 Oct
 2024 10:31:04 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8048.011; Sat, 5 Oct 2024
 10:31:04 +0000
From: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
To: "pierre.ficheux@smile.fr" <pierre.ficheux@smile.fr>
CC: "rpm@xenomai.org" <rpm@xenomai.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH v2 1/3] dovetail: Guard _TIF_RETUSER with CONFIG_DOVETAIL
Thread-Topic: [PATCH v2 1/3] dovetail: Guard _TIF_RETUSER with CONFIG_DOVETAIL
Thread-Index: AQHbFpCJmIpd7R3W0E60g/kl2TI4lbJ38hKAgAAEJ4A=
Date: Sat, 5 Oct 2024 10:31:03 +0000
Message-ID: <b24aeedd571082c104b782daf950f30d4ac0615b.camel@siemens.com>
References: <20241004190633.1814057-1-tobias.schaffner@siemens.com>
	 <20241004190633.1814057-2-tobias.schaffner@siemens.com>
	 <CAFc1U0ut3dgHZ1ryooBfbfem2zHtHJ_AM33EXQftS9ayVw6iwA@mail.gmail.com>
In-Reply-To:
 <CAFc1U0ut3dgHZ1ryooBfbfem2zHtHJ_AM33EXQftS9ayVw6iwA@mail.gmail.com>
Reply-To: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6349:EE_|DU0PR10MB5533:EE_
x-ms-office365-filtering-correlation-id: 1c512f7a-9f1e-410a-cb29-08dce528d08e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ME9Ob3BXbVR6Ui9NcnQyaW40N1pvdmg5QzlXMGJwa3BhN092c3JjUFNPcTgv?=
 =?utf-8?B?ZUtROTNGblFiaW5CTlJPQ2NucUJTcFB2d0NnZHVCakwxTzFOWVJOOEprOWxn?=
 =?utf-8?B?aDRSUzNqZ1MreUdLeVJoQ1RlSzBGMDZBNDM1NURuQ3gxdjNQaWltcmhpbXpP?=
 =?utf-8?B?WTZsM1NnSWY0NEx0QXlzOXU4Z2Y0UzZEODFOSzJaa2ZydmlvS0Vpb0tocnBh?=
 =?utf-8?B?TldoV3FEdk5zVGxzWHVDOG8rWHpCdTU0b1BPODFpT05jZHQ5OSt3OElUcUxS?=
 =?utf-8?B?SjFSWCtqTFdVczlYaWdjMWowNlZaL0JWbVRoSUpwbXlzTlZDeGx0QWhBQlM4?=
 =?utf-8?B?d0kvaDc1eEk4QXNLK2lzbDRmZDEyMitRUm4ra1gwY3lXNXBrK216T25OT0JO?=
 =?utf-8?B?ZDN4WFpuOFNDNisvdjRyM0Vac3NwNTBPOTNjSW1ibGQyYzBoNXlQamRWODJt?=
 =?utf-8?B?UVdwK20xd1BQcTltVnljWlI4VkxENjBCZ0xMMGtBaTM2Tm9aWTk4MUVlUmFO?=
 =?utf-8?B?a3JFZ3VYRXlFeVVsZUZUSDVwS0kxZkVDZFVDdzRZTHNJcnhzMHNTOUduMlVq?=
 =?utf-8?B?QmdIZzJkVE02VDhnWnltK0lvZWNsR25SYndxZmVDVHkza3Y0cWc4alJOcTlG?=
 =?utf-8?B?MmpUZ3NiNzd3eXJDaXFlcWpoRlFqUUNLS2lFS2x6KzlYZVdGZmRhY0FnVkha?=
 =?utf-8?B?ZW5QbEZXV1JrZVc0QldBOXNhNUpma0lrZTBMNjNEZ2JqdGNaSDY4YlZ5eVA2?=
 =?utf-8?B?ZTBQS1RJaExDZ3ZWZis0bUlOZmMwTUlvUGNlUGtlLzVLdzF4UjZ5SDBWZGU1?=
 =?utf-8?B?OTZoQmNsRFdjQXpDc1hhbjhWUHUvd2pVY2lwNllQTU5nc1hKNEFMdzR3NmJT?=
 =?utf-8?B?KzduSGxCQ1c5eGtuazl6d1ZVcFRyczl0Qlo2eXFFT00vb3UwZGV2WkdrbTdZ?=
 =?utf-8?B?bkU2SDJXaElCSzVyeituU0tBQ1NCdDVqNnlzaCtTQTFHc1JXaVdJZC9yVTZ6?=
 =?utf-8?B?SWhDM2dvK3NtT1VodTZtbnNEamhCOVlxOHNiVklZRnhlbllqcHRPbzNydTkr?=
 =?utf-8?B?NGpQYjdweWUrU0J5OXl4OGhESHhwb2Q4SU1RNFVYNktPUWRRajFZeXNhQW5o?=
 =?utf-8?B?Y1dSN1N6Q2ozOWVKZUJIa0dUMzNtQzdJY0RWZC95N3Y4Q2IxRS83MW9mZHAv?=
 =?utf-8?B?c1k2MEw2VE4vWHI4ekhlZTRkVE5sV3Y4VjBFQXFLMkt5U2FlOEZnb2Q4UUVw?=
 =?utf-8?B?WkNlRWp1SGszdSt1UzJLcVJBZmRseGwwMXp5L3VRdmxuK01oUmVLRHRTZ1JO?=
 =?utf-8?B?dzZxdWxuWno0UFhYU1hwaTVtVlZyOTg5eHg4U2dWa25pT0djdjRUS2s3MWdn?=
 =?utf-8?B?bUtaT2dZVXZ0OS9kZnlrckVCM1RYV1lIUmNJV2pkUGVYMEo3dXB4WG00cWdI?=
 =?utf-8?B?K1hQNUxScmduRTBST0JIQjFFeStWYnZaTXAwQmErTGFQWVNORnpYejZJdllU?=
 =?utf-8?B?TmFhQXlmbzNtRW9EeTI4WFcvcGRSNEcyZ3lzQXQ1Z0RwbzhKYW0vbmJ2OTJN?=
 =?utf-8?B?MWlCdE1LTktnRDROQkM3SzB6dEJTcktyQTRnM2RhQloxSGYvUFFtSTVkODRp?=
 =?utf-8?B?WVhRaGxEL0E2Y0JXcEJQaXVkcjE2K3AyaHBNQ0loWlVRUkM4cURyVThYL0NC?=
 =?utf-8?B?U2tkbVBIR0lFb0pIMGxwVUNja01pcUs3T0ZQa3UxMVJmZWRIaGdsRjRqNVRx?=
 =?utf-8?B?N3FBcUM5bU5ZZyswYlJpUjM1eW4xT1dFREw1d1I5TndoY00yVGF6RUpMaW1r?=
 =?utf-8?B?d2lUT05tMXpTN1BwMjFYdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1Vic1o0UUc3aXplWDdRMUlVZ1k3akJBVWV4Q0dIK0lnakYzeHMwTEZaVndZ?=
 =?utf-8?B?a01udU5jNGxKMzZicXB2Y2ZHV3NqZERWOUl3L2FwWUYrcGFaM3NreVNZNlY1?=
 =?utf-8?B?b2w3cFAwWHNqS2NWVG5hQzhGY1c0bnlNa0xvNThsYWpmQkNYSWdVY3hpY0hK?=
 =?utf-8?B?TVdobnBWYlFJVVRUbncyQ3NtUnhYTDFLNUl5TEgzOW9YNmNXY1BQRDM3V3g0?=
 =?utf-8?B?Nk4ycXhaU3JaOVZsR0tMQjM3Z2wzZ1l1UC9UbFZWaFJCejVzclB4c003dEl0?=
 =?utf-8?B?VUNsbjgxc2QxellIc0ZUUFg1RVJvWWFaQTZMR1RMbVliRURKeWpPSGVKUzBB?=
 =?utf-8?B?N1ltSVg0bnRzQVBKcGoyZEtKckF2S2dlN01keVp0cXdrUlVpK1pGS1J3Wnlu?=
 =?utf-8?B?dkY2ZGZkUzdqR0RWOWRPd1RHRW5DSmJobnY1RUNSVG8raVFUU2pHY3c5dk9l?=
 =?utf-8?B?anAzbm5BYzRUUlY1TVAwd2hKUTA5bnV4aVJHUHp1aTFsb29HbEFkWEYrYlYv?=
 =?utf-8?B?OWh5SzFDSXNOL0RPYS9HYmUvQWdNSXQyemtJWW9KWm1XNERUVEgxT2VsQ2RF?=
 =?utf-8?B?cXI5YTh3VCtaZ1BVTit0bmJSelVmQ20xNENsc0ZxK2hPTXN6STlMVjh0S3Mr?=
 =?utf-8?B?ajFKcW5DTUp4b2JJYjc2djRnR1JLblZzcnpoZDl0Q1l6dmpDYXp1c3pHY1RV?=
 =?utf-8?B?NXBOSWo4U0IzcWx0eks4Ry9uTzFkNjV5NlNIT3E5NTRXU0NheE5uT3Y5RFBV?=
 =?utf-8?B?M0dGWnIvcVNVQ1RueGVxeVRTU1JCZGZDZ3FKNktEcWJOMFNRUVRUNm1pcHpv?=
 =?utf-8?B?VVdFZ2d1YzFzeE1mcFJLYVNVbkZncEZDS0w2VDVLdG01aWlDSnh1SzBrSTFl?=
 =?utf-8?B?cjd0WVlmY3NWTmMwNzRpSlM1VlVPUXZwN0w0K1JGUWNyeVAydU1obVVLWHVC?=
 =?utf-8?B?bGpkVmU0S0plRXdsbHVJMTNkVGN1OHByRXBZaTZIanIrckl3YWJyYURzS2RS?=
 =?utf-8?B?ellpL1Jxb1NPTmUvWXBHVHJIT0gvNFNHbEM5WU5MSElRQzBBY3hjV1B2cWJ1?=
 =?utf-8?B?bWRPckN2UGp3REhtSnhmc1A5MlZZS09tRkxNN0xadHZLVzBXSThGbDNobW9B?=
 =?utf-8?B?dFdnRXQ3T1FyKzI3K3RKV0ZRNmhwc1pHdU9jQzVaMGFWaURuRFIxejFqME0r?=
 =?utf-8?B?NDAvSkhmWStOa1QxeDZuRGJCcDQyZnFOUnJtSkdXQzZsZGxzREs1Z244OFQ2?=
 =?utf-8?B?UkRFQUtuS2JSMTQ0MHVOMFFqWXhnNE1IWlhIUGFURzFDR2cwc2hGYWN4NGtN?=
 =?utf-8?B?cy8zOUN4YlkyQUswOU1pNCtxcHo4ejFDbDF3RGpWcy9penBwanhKR1VPUDdq?=
 =?utf-8?B?cVdXMm9YZEpRZStEUklRMzg5Zk5BOVAwaWVKSzQ0VkpJOVVQd2o2dld1K044?=
 =?utf-8?B?MlVhU0dWSHovUFozcElHR1lUSTF4MWdZakt2ZUxzUmVMWGVxdGRyVG9oV1lu?=
 =?utf-8?B?WTlYSWowSUIvVmIvS01EZHdydnlpZmpyVzRaYTh5OTdod0dNWXU5VWlLRFl2?=
 =?utf-8?B?Qk1UVHF0TkVqSFJwdk44bm9WN2NYa2JvWnVrekh3OTFDNDVETWpsdWdudXVn?=
 =?utf-8?B?YmgrS1RGdWhMdTBGRFhzcWNla1pqOVQvR0Qybml6UXhMRWRpNy9IbThVTzVS?=
 =?utf-8?B?YVMxL2psbURtenJtRnVlZ0J4VHhCVGpxeGFYbStON2J2SkZJcXNpei9NNFRC?=
 =?utf-8?B?cmJJc1NLT3hza25NOFpEOStGOXRFcW5OY3UyVm4rOVp4T0lpQmk5S2RGcWEz?=
 =?utf-8?B?RTQ0dy8yakU5TUlqaVVzaXZMUkNLQXZYU3VwaUh4T3VMUElBZkhBY0RrNDlz?=
 =?utf-8?B?aVllYUIwRHZaNmZDSmNiclFKblNhbzFuRk05L3libnh1YStqVVBqeTNIeXRt?=
 =?utf-8?B?K0owT0tsQWtFcXozSENPSUVVbmRRL0JxcDRNTkZrQmZtbHNBb1Q4MGtoaktq?=
 =?utf-8?B?dURKdFdNbHRieG9Wek4rM3M0SENGcFVpQlpOb1A0NDAyU2RJaTIrenBha3Zp?=
 =?utf-8?B?TDFNdFdaQXl1d01ENHBRU2hTakZTaGE2RGk0Lzkwb0dWNm5VV2RzYVhWR3RU?=
 =?utf-8?B?bEdUTGd2bHUzNEh3TDJ5cHpDRlc3WE5WVWt5cUN6Y2NybnJDRUwySnJKcmZv?=
 =?utf-8?B?MTlGQ0wyNmZ3TG12WEtSR3pSUk5yRXJ5dHdydEZLNFNOWGJ1RTFLc2pvZjdO?=
 =?utf-8?Q?cdPsM/2IZEcqKq2BI1V/mIi0n6PkukYlAG6Y615LRU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01CD92DC2CBC8B4EB5E5AD74A82078BB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c512f7a-9f1e-410a-cb29-08dce528d08e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2024 10:31:04.0019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNnwx5CkwUvIRECuD+hauBMu48JL8A+/oHd4sOw/F3NwhTdU+IRtDoLhr3Bqliqy/fzBXiPIDS9mYCBtlQHvNriZciIrSUFBlykjKfdpmI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5533

T24gU2F0LCAyMDI0LTEwLTA1IGF0IDEyOjE2ICswMjAwLCBQaWVycmUgRklDSEVVWCB3cm90ZToN
Cj4gSGkNCj4gDQo+IFRoYW5rcyBhIGxvdCBmb3IgdGhlIGFuc3dlci4gSSd2ZSBqdXN0IGJvb2tl
ZCBvY3QgMTYgb24gbXkgYWdlbmRhLg0KPiANCg0KV3JvbmcgdGhyZWFkLiA7KQ0KDQo+IMKgSSB0
aGluayBJJ20gYWxyZWFkeSBvbiB0aGUgbmV3IGxpc3QuDQo+IA0KPiBZb3Ugd2VyZSB1bmFibGUg
dG8gYmUgc3Vic2NyaWJlZCB0byB0aGUgbGlzdCBiZWNhdXNlIHlvdSBhcmUgYWxyZWFkeQ0KPiBz
dWJzY3JpYmVkLg0KPiANCj4gcmVnYXJkcw0KPiANCj4gTGUgdmVuLiA0IG9jdC4gMjAyNCDDoCAy
MjowMiwgVG9iaWFzIFNjaGFmZm5lcg0KPiA8dG9iaWFzLnNjaGFmZm5lckBzaWVtZW5zLmNvbT4g
YSDDqWNyaXQgOg0KPiA+IA0KPiA+IF9USUZfUkVUVVNFUiBoYXMgdG8gYmUgZ3VhcmRlZCBieSBD
T05GSUdfRE9WRVRBSUwgdG8gYWxsb3cgYnVpbGRpbmcNCj4gPiBDT05GSUdfSVJRX1BJUEVMSU5F
IHdpdGhvdXQgYSBkb3ZldGFpbCBpbXBsZW1lbnRhdGlvbi4NCj4gPiANCj4gPiBTaWduZWQtb2Zm
LWJ5OiBUb2JpYXMgU2NoYWZmbmVyIDx0b2JpYXMuc2NoYWZmbmVyQHNpZW1lbnMuY29tPg0KPiA+
IC0tLQ0KPiA+IMKgaW5jbHVkZS9saW51eC9lbnRyeS1jb21tb24uaCB8IDQgKysrLQ0KPiA+IMKg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2VudHJ5LWNvbW1vbi5oIGIvaW5jbHVkZS9saW51
eC9lbnRyeS0NCj4gPiBjb21tb24uaA0KPiA+IGluZGV4IDkwMGM2ZTMwM2FiMy4uOGE4NGY1N2Jm
ZGUxIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZW50cnktY29tbW9uLmgNCj4gPiAr
KysgYi9pbmNsdWRlL2xpbnV4L2VudHJ5LWNvbW1vbi5oDQo+ID4gQEAgLTM1MCwxMyArMzUwLDE1
IEBAIHVuc2lnbmVkIGxvbmcgZXhpdF90b191c2VyX21vZGVfbG9vcChzdHJ1Y3QNCj4gPiBwdF9y
ZWdzICpyZWdzLA0KPiA+IA0KPiA+IMKgc3RhdGljIGlubGluZSBib29sIGRvX3JldHVzZXIodW5z
aWduZWQgbG9uZyB0aV93b3JrKQ0KPiA+IMKgew0KPiA+IC3CoMKgwqDCoMKgwqAgaWYgKGRvdmV0
YWlsaW5nKCkgJiYgKHRpX3dvcmsgJiBfVElGX1JFVFVTRVIpKSB7DQo+ID4gKyNpZmRlZiBDT05G
SUdfRE9WRVRBSUwNCj4gPiArwqDCoMKgwqDCoMKgIGlmICh0aV93b3JrICYgX1RJRl9SRVRVU0VS
KSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhhcmRfbG9jYWxfaXJxX2Vu
YWJsZSgpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbmJhbmRfcmV0dXNl
cl9ub3RpZnkoKTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGFyZF9sb2Nh
bF9pcnFfZGlzYWJsZSgpOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBS
RVRVU0VSIG1pZ2h0IGhhdmUgc3dpdGNoZWQgb29iICovDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBydW5uaW5nX2luYmFuZCgpOw0KPiA+IMKgwqDCoMKgwqDCoMKg
IH0NCj4gPiArI2VuZGlmDQo+ID4gDQo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOw0K
PiA+IMKgfQ0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4gDQo+ID4gDQo+IA0KPiANCg0KQmVzdCwN
ClRvYmlhcw0K

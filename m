Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497214F9D6
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915199; cv=fail; b=eyYRrVGaq6MXnbnaQp69JVavzHfL+O+1JUkveE6BlnLr6SLPJ/nsqYMLtRPGkt2uSjMUwHslhdFGFJzLWg6z8aLwfdE80sfUGITUEPzUC7iVVMJesn0ZCt6K6xohHyyY3QKCLC7b94WB5hxMjsS4x2pCcQyfyvDvhevyp+M1j2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915199; c=relaxed/simple;
	bh=p68fQxt0haMR4iZpKM7cu8mRdffonarAgcXi+I2w7kM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mIJ8UWg+l9GKKcFqP+mosk2Clrn41KrzV4Wo5cw8A/RiqTuri3x6aVBZeD2CBjmHnKlT4iaCqYKZ7YVupGCzDfTBek5lkY9vTb7e4NnYTe/XRQ3SvpJzJEoHI38e1xk9VGoPj8M62q021+QobwgIxpQJslf9FsyH8FXjcdRCDCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Vt8eDbmj; arc=fail smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Vt8eDbmj"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 6E9A11A0005
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 07:33:14 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20628.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::628])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 8C0C1941417
	for <xenomai@xenomai.org>; Mon, 18 Nov 2024 07:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpaoiyYjxpMJpWPU9ee0aLnTd6kH797CfQTv6e6HDUIOSRptJtEoJkvEeQGDM2Yqui/9g0LoydlcaRhT9YQ5eWPtGoZ5H5081qDWPY5LARyBIbc2JocBH2+tmSp9I+bOkXQRBC+/bgGZnDoiszdexEgC4miDPJ2FZa/BG/Nr6MmvXFE77YcG2N3jKi1j0OOitO8e5asXwwqXnkh+CIkbJnbbl/ax5t5J9RqzCt3gA2oDjxoVdIVv2+kbSvwhCKv76WgqqMmfi1QXbGEOYh1pkbhO8RqcSfUthsLPnUykjJxB9JvAWRikYWV0Mfxjwc7e5mGwack+pnDphupkdc6sVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80Wf3XIZukizrHJfgHXX6XWSqzYMJnmYdTFxOOobAyY=;
 b=vrvlxj0BQo396ovs+jsuls/UMpSWNvNoigDuxMud+p4im69bE11ku6uVah4i4ulNLkrCpq8hxWShG8NQRSTlLbPhivILGogUm2Wl95DMBL3FnbIRTqg2c3WH1SIAXZG6iho3Z5Rc7jEq703O6Rzu9Y6nQQq8DSK+ycQ+U3AdRLCn9UNhyijj6Q8t0s8t0w4JkQ2s5P31Wq6AHyFaVZ5XXWeonkyWK9M/1VnQvancXIsZtQy/mwu5UeuppBEx5ANx5OZMSi396+LkjqRLVdPPjRTRaXaUK6Ey2zhASiZ1mzJdtavTNNfiiUDita8k8U2RpOtkPtN8N7rqz5QENgSwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80Wf3XIZukizrHJfgHXX6XWSqzYMJnmYdTFxOOobAyY=;
 b=Vt8eDbmjqj35hCdgXH04x6/ZSSsg4lwMhwBYNl2EV3j2sk0DVUFK9t+D2yO6//8esyYzdWfHeARR8hxCh6e5nHUMf+PGBQGS3Ex6DXo7NegwpxGqkiigB+W9Aq3NW7DtwrLOTZDjiDP+P4T1xrlqZxR4Eur3iHE2Cgu5F3sv6Yln4Qo/PvGnXnLbmkO/GXQ8gk0udYt5BQfQfd4VBR1CfdxqxzyNGN2Eol8hKS7CEtDMN3VraxjKBWCEWJF6y7D9QK3oFHIkNgMP0YIIixwBjAxqX6J5qgOKQ8aq4cIGQAucaSGzrmnNHLAy3H4SFD1ZvDqQB2dDM2aOjIDLkF9fGw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5729.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Mon, 18 Nov
 2024 07:33:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.011; Mon, 18 Nov 2024
 07:33:09 +0000
Message-ID: <ea44bb42-1f71-4b46-a44e-57b54777a1ea@siemens.com>
Date: Mon, 18 Nov 2024 08:33:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Error building xenomai-images
To: Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc: xenomai <xenomai@xenomai.org>
References: <CAFc1U0tkcLT2o4VToa_HECaxfMkdtp1W=AuHKw+Xkm+C8-RHBg@mail.gmail.com>
 <f006bb96-5d85-49a6-92ff-b40ab8030db5@siemens.com>
 <CAFc1U0uu3vBf0qx2bkzRXxQCuL0RFA5od4+AOvP6O6m4T9C44w@mail.gmail.com>
 <329cb61c-c663-4260-b240-55ffe834e71a@siemens.com>
 <CAFc1U0s9109_p_L2OpAxNNQVBbVV=Z-UHyvpQK7oqkF13N83WA@mail.gmail.com>
 <d966a535-015c-4ac0-85b6-a9656199660c@siemens.com>
 <CAFc1U0v7vMXNJrwHPXMQLWVwd+TKxvO8Jos5LABnxKMrKZkn9g@mail.gmail.com>
 <CAFc1U0tM8Jozf8SiD6fwru7V4A6GkAb0ONzue0xP5S4r_j0QDw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFc1U0tM8Jozf8SiD6fwru7V4A6GkAb0ONzue0xP5S4r_j0QDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0136.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: c688ef0d-21fc-45fd-aeb2-08dd07a34016
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVBQVElwTlhFYStaeTQ5c3pkSHdTOEdIOStLV1IyVzVHZGE0cUkxNXhQWW1P?=
 =?utf-8?B?a2cvZUtuUVZjS0RTaURWWEFRZkZxZlpIRFhVdDNnOEdnMUE1UVIwUGN0VTA5?=
 =?utf-8?B?NklOcjROVXVUYk9nNllSemFMNDdzRUphaS9TRVJRV29ONkE2aXA0dGpxUGdH?=
 =?utf-8?B?MGpuSWt6MzZBbWlFeUI5TzUxYnhEZmE5bFpvY01yVFZnM0JHRStVUzhLUlI0?=
 =?utf-8?B?aytpMnZSWXdheHhMS0c5NlFMTXRHVjVVcnNMSTd2dnF3T01lZG1PSVpDT21R?=
 =?utf-8?B?MWZIV3lkVjNRUURLYjIzQUlMcG1lTmtuNjZZdjd0aDZ6c0RWVGFrZE5wbUV2?=
 =?utf-8?B?R1NvL1lvSVlMWE00OEovaDJ5Ly82TXIvSWU3ZXozWndDTWp4enBPM3ZWOFFW?=
 =?utf-8?B?R1FTdnhscDk4ZldvRzlkaytJL3k3WXhDeWEyVm1SRDVucFJFOE1UVzZQVmRa?=
 =?utf-8?B?aXpvTUxQSU1aZkhVRVRCcEd5QzJjMk9oZDhzbVkyYjVQUkZqVWZsK09pMXJT?=
 =?utf-8?B?RnRtMTk1NGFSMHF1dWhRMnozeVpYcFJXcWxkRjZaeUZFRithVUtBdjBSSHFJ?=
 =?utf-8?B?b1JQWTBjc3dTMjlrRjQvaUYxMFdXK0ZSNVRsaWd6a2kwVUg4YjVZMkRzMEU5?=
 =?utf-8?B?K2tnMnErVWQ4eFg5M2dXZGRtSU0zZzh6eVYwc2xKOUhFZkZ4WWJFNGtCY1J6?=
 =?utf-8?B?d2V0V0xrNmdZRlF6Y2kzYkxUczRHbllFT3NBTTkxZ2UxM1BGbGpnZXluTnBK?=
 =?utf-8?B?QThCZTBOVmZ1aUlGMmkvRUlrc29NTnRhajYwa1RUREhpeUxEZm1Gcm04L3do?=
 =?utf-8?B?QnZoWFNPOFdjUitTNlprbG40Q0hRbmFtQ2c1UUx3Q0dSUjJNMzRIQkdKdXJw?=
 =?utf-8?B?RWJ3RDMvN281Z2RnaUhtczhadDJZSkpmY2w2dnpzcDFYSm45Vzg2aWQyakVs?=
 =?utf-8?B?NXB2QWtKeE10dkczUzlTMWROdDFKTUdmRDRkdDFLWnczdFZqVG5ENWFPKzRP?=
 =?utf-8?B?Y3licjNUYW40UzR3bndkbXVKTURPVnI1LzhsOGloQUtLWTMwVHBlTG43RnVR?=
 =?utf-8?B?WXVMMTFvT3ozdG9IdGZXQXNIRHhhNE1QZ0pnSE40YjJUNDlXZmp5V0YxVzZT?=
 =?utf-8?B?MmFaMTAybU9lYnRZNUhtaEphYVQ1ZElObk9TU1pZdGE2a0tUeFFsM1ZQSzVD?=
 =?utf-8?B?S3VwVDN6cDZ2RXlCVENjQUZ0YVprWEFRR2ZFVVpVcmx4YzBITjRqRDE4a0Zo?=
 =?utf-8?B?SW1GZmxFT0gwNzAyeHplY2c3cjduU21ROVdJajVvOGtlbDFwWDV3N1ZyZ29z?=
 =?utf-8?B?TTU2SldQcW4xQVhYVFVzbkVocUdTVEFCeHI5ZTJCKzcvR1pYajUwMDM1Smx4?=
 =?utf-8?B?ZkVDOGdFelhqa3VKMU5uRXYwK3BpZm9rQmwyTzZIR1YvVkFZWGliSUFMdXlY?=
 =?utf-8?B?RnFySkFUdU5EdTY5M2FMSmRjaFRkYktGSmdxZlFuRlNsLytaa0JJWno1TXJV?=
 =?utf-8?B?azRkVEw2T21lclE1RzBqczhZMUhJM1NIblBQcU5SM2xLTzNrZWhpOEZFOCtw?=
 =?utf-8?B?cUtuU1JkR3VoZW45R01rK1RRZk8ya2wzMzYyZUtBa3ExOWlKa3NDY1hXMVoy?=
 =?utf-8?B?OEhWRFdJVitTT0JTelRLUXJ2UGcvTHB6c3NHQ0VOV0t1dCtpakRzWjRoSDJM?=
 =?utf-8?B?K1dMZ21uUVRsQndjWGpFWTVHbEs5UGp0QUJQUUY0VDhiRlc2aXh3dkFaQVBm?=
 =?utf-8?Q?zn3SCjQW3e0b00FE35XLqs4KxI1CBG+1M5QSQAc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW11ZDRseWk2dGg3Z2hXWGR1cVRrNCtUT1hrek5jZ1luN09nYnVFdC9zNmRZ?=
 =?utf-8?B?VjB0N1ZNd1VVVW45WGFFcysyenNqN3dNU0ttOElicmRSMDFJaVpMblFKTHk0?=
 =?utf-8?B?d2VPbGJtSVVDcU9JLzlDUzY3N3dwYW1oc3lsTndBN01XTXJ2V3ZRREtPZU5r?=
 =?utf-8?B?MkVOMVZvM0RTelJGMmhONjVaUHMwVFdldThyQ1hOenB0bHhvUEhiZFJaREhp?=
 =?utf-8?B?bHk0SDV6TEk0eUYvSHoxcldXK1N2RHBlNFNrRFRDZ2djb2VJNUo5anZyb3M5?=
 =?utf-8?B?NWNZa3JVdGNMQWU3TnRCSWJFTnRRUVR0ZllvQjdNSmVHaTJxYkNzak1OblhK?=
 =?utf-8?B?aithRHo3UnA5MEFLVnU4azZNQWNZT0xnV3ZKcFU4WmRVaU9iZXJTTkNMUGMy?=
 =?utf-8?B?WmxEa0hBckphV2cyeU9QL0l2b09IMkQxMVYzLy9QR1ZZSUVJT3ZZMnh6anRa?=
 =?utf-8?B?VmNkLzJsQTdodmJrUHBRNS9nMUl1VktycUtZcEpvcGxNbHBLcHVsRExERi94?=
 =?utf-8?B?bTVMU3JnSVJIY0t2bWRqU0ZHRXF3YnlCS1BNdFhYWDVDOS9WTzF3a2EzNTM5?=
 =?utf-8?B?RFlFU1FOak95dWtZWXI0QVhja1J6ZngwZEFtdndFdkFtQ2pFRHkwVzFydUs3?=
 =?utf-8?B?UndxODlneExiSUFPQktIVDRyNXlFYnBIdFhaKy9mbjJoRjFSS0xtdWltdnM2?=
 =?utf-8?B?aC85cTMwcFZRZ3RFV002ZTN2Z3BwaWpySHFPdFRYVGNzZGdhUGdWWXRTUDlQ?=
 =?utf-8?B?V3pxVjE1YVNkRyt6Q0V4aHFITjJRaHZpQ1g4emtqT1pvRElCVTRJTnNQbW5W?=
 =?utf-8?B?TFVlOTVOczRxdVJjTDBUSmVXbmY2UVJPSklLUWxsTU5CbVVGMVFITDNFTlFL?=
 =?utf-8?B?UmplbkpsQm5TbXdobW1XMGZnNXJONTVCbFdmZXBQUUdjOTBLc1ZVWnB0NldH?=
 =?utf-8?B?cmIzYUdjL29udDZyZjBzaGdvTXhQZzd1RmJIWEJpanZ2LzB1ZFdNWFlqY3dL?=
 =?utf-8?B?V2JxMHArRWJXc2I4bmlxcEVTVW5YaFV1cmZkTXZuaDA2eVFDcDZ0VDFJL2N6?=
 =?utf-8?B?SHBWa09ZYU0wYWdiRkxvMVllbmJmdzVlMHowT2tSK29KaXdRaWlOaEZPc0lp?=
 =?utf-8?B?eWpNKzdoUXVBTXFlb3ZXVklEQVBwNFBhRy9FbG5BWlZza0QyVzh6cTkvbitQ?=
 =?utf-8?B?N2NValorZmZBTmJCNTFldS91Y0VsZm51ZWw4WE13c3E1KzdvZzBpclkwb05i?=
 =?utf-8?B?Y1ZUL01CQmd0M2U1V3drRXdyeklrM2U2dHZkWG5PQ3FZWmpLdStXd1h2SnlI?=
 =?utf-8?B?d3ZxWmoyWVpzRW5CQUwzMkd6djAya0hkaHFDUVNVb0E3aUN2a25kbU8ydnlK?=
 =?utf-8?B?Z0I4cjd1bWdLUXhYZkhUazgyTlcxdUVxQ01VV1FFYWlneVFrMU9LTklJMEU1?=
 =?utf-8?B?UlY3RlVzYXJzQXpQdUhlM2tLOFBSTVdVeU82VHllcUFHakxzV0JRUUk5VTJL?=
 =?utf-8?B?dm9iVzdlSFpnLzU3bStIdmgvNnRhVGpXdkNSQkhKUjJDd2N6a3ZxV1hkZTds?=
 =?utf-8?B?ZHJ3b0Yyb05zb01Ob25oa2VBNUk2YmpBWlFXaXl0aU55RjI2ZlZQMjJUcUQz?=
 =?utf-8?B?MEpGamRPbjhUL3hMckFSemxDaUg3QXBFemlFOWlwQ0dHb0pUTHJLUnZINC8x?=
 =?utf-8?B?SFIySGJBUTVxM1d0dlFqRE9KUGc5dkdacjF6SEE4NkpLSGQrVDY2V0o0eUJO?=
 =?utf-8?B?ZklUTkVrek5rdW5rVXMwenRzaHRkYnlVaXhkSXU1ZXRyNXF0WmhKMEJkQWJu?=
 =?utf-8?B?K1pQOCtzRk9ENjhYcGx0L3ZqdmtkOHpoYXk4M0s0bllMbjlJTWJEZll4UUkv?=
 =?utf-8?B?L0N5eVdGOFdjOVgwbUVXa2Y3ZDdiY3JWL05ZeDlDY2tmU0pteTJDQ0JNaERM?=
 =?utf-8?B?aEFINXNkUi9NL2J3WEt0bW1wRURUcjAwZnpPY2dyR3RzOExCL0tuTmlKYmJj?=
 =?utf-8?B?UG5xM0tWV3hxS1ptc3J1elpmQ1lSbmlFRUxtUUVnSU9NeXkzdTJHSDEyaGFo?=
 =?utf-8?B?SHh2c3ZhK1lRMW83QVAxcGppZzd1d2JWN0tuRm50V1AyMnJyY1ljZTE4c0d2?=
 =?utf-8?Q?gr8qSfteU524qPqAugxLJevvx?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c688ef0d-21fc-45fd-aeb2-08dd07a34016
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 07:33:09.3896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKG7sleyGc7jUrOD5a65i+bUeQxMpEKg7wh5Dxk2vz/9u+Vv4CxPwoicvnMTbsK4qkezjriVBnTKNbyheaLiWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5729
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=Vt8eDbmj;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2614::628) smtp.mailfrom=jan.kiszka@siemens.com

On 18.11.24 08:21, Pierre FICHEUX wrote:
> Hi,
> 
> Next step, I did a test on BBB, then Pi 4, here is the error as building libevl:
> 
>  Removing /etc/schroot/chroot.d/isar-builder-f3644be1-d6ee-4923-98fa-e25d65cf6b1d-125491
> | DEBUG: Shell function schroot_delete_configs finished
> | DEBUG: Python function do_dpkg_build finished
> ERROR: Task (/build/../repo/recipes-xenomai/libevl/libevl_latest.bb:do_dpkg_build)
> failed with exit code '1'
> NOTE: Tasks Summary: Attempted 101 tasks of which 80 didn't need to be
> rerun and 1 failed.
> 
> Config and log are attached.
> 
> Any ideas ?
> 

...
Run-time dependency threads found: YES
Program post-install.sh found: YES (/bin/sh /<<PKGBUILDDIR>>/meson/post-install.sh)
Program generate-git-stamp.sh found: YES (/bin/sh /<<PKGBUILDDIR>>/meson/generate-git-stamp.sh)
Found Pkg-config: NO
Found CMake: NO
Run-time dependency libbpf found: NO 

../utils/meson.build:23:0: ERROR: Dependency lookup for libbpf with method 'pkgconfig' failed: Pkg-config binary for machine 1 not found. Giving up.


Seems we regressed with some newer libevl releases. Due to the absence 
of automated load tests in evl, we didn't enable the build in our 
xenomai-images pipeline yet, so this slipped through. Let me check if 
there is a quick fix.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

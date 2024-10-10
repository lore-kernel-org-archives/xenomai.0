Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B5196450
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572540; cv=fail; b=UZz+1dSlV5gwSND1CX+qzvSZobWZmEKzIO219auZRsTqomj7tM/UkMeA/9dr6fiMXBWx9+hVOCCsj2HIWPFxEGsFVVfktc50H2atSjnUe3rJolVV9N6iEaCxsiM9HmLU9J8v00L1aEhGeIdvnpsszFK9Vvw82WUjHZx5sr72uak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572540; c=relaxed/simple;
	bh=nbggWsa7p/lZICcJ5MKYKUgIsJBGaf5WOhifGCEhUwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sq/tDsd8wk3qn7ognfhgcCyB8FbTbo4LLMk2mm1loyibdBA/CzoXuncselW0LUlERbpPrOLyfHs5fzghkgew5T/hEBGk37YE25bFcIfJY+kDThMlxMbmTYdOBMyOUfTDguzN66QOY0O7L1hIVWCTA9+TghXCoZUcOL5vDPfF3pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nIw9cZXY; arc=fail smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nIw9cZXY"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 4B8A210000C
	for <xenomai@lists.linux.dev>; Thu, 10 Oct 2024 15:02:16 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20625.outbound.protection.outlook.com [IPv6:2a01:111:f403:2614::625])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7B1AE7803E1
	for <xenomai@xenomai.org>; Thu, 10 Oct 2024 15:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFpdKsatvwUgcR5J6z40MbT3s5HNXUj9uQOm5x6bIrNMaowTcboS0d+MuojgPYOPOTeZlK9VuIZ7bKP6geHWAnoECuwBvFEZ4sSqB2RkAEM5rnQd8fxypDPa1fF9VxArceSPn0aRVmU7SyKSE/l3K77AhtqAjRoLCCni9sYgzKea1ccfmeaHWDKsoObdN3oY6TZFGyMB3lJU7FqgUHRAakVnLKDMDpKuDTluqS9HTwWLzxljiJiW45Qb5TrtQJ5q1+uS0Ys332NdxZi0hMu3nGJ4fyUxpdEGvM6F8AQRbfS5Hw5J+0tmWdHWbHeczvLvjtptnkQZ70DkxdAFuI4Zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbggWsa7p/lZICcJ5MKYKUgIsJBGaf5WOhifGCEhUwE=;
 b=OeoohQZtJEa+tUSaMum4dQDQe8I2WB5jzOgYVpE4c7ks9I96/0UkQJm+CjUWjePBLwFUGCg/g+nHWuy9w44m3udXP637GsFfOQKV/j1Z0J3+OCyXbpPI6OWyUdumA48fNNdJHbcgPZ045xbxzFv6RXndFTRewDducvRjTLkcyLLeqBpRaJZ+qm288Q1fLuOP3vb62WSstO7ZaLk766qiBKoSoL2tGWAv8RkokOs3pvG+GmGKjH2Q1cmLXIn7W8wvi8c2ixStqJ0Y/ivtLPVj0T2njzYzAX7KBccjba480AXRhfkscjTeb42eKtEnQ3OF5FJA1SqpyiSLoYE46WENTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbggWsa7p/lZICcJ5MKYKUgIsJBGaf5WOhifGCEhUwE=;
 b=nIw9cZXYdSfISSSp03PW2jFQJUerANcXhrbsiX2G14i547PlXNvhjQhEaxnJX8WkspbpXWWU3KsMGpsqh8IZPWL3SA6rzqhisVVGUSXsWr4HiKV5Syy04BcR90oUhyza/gIGIQnOw7giOL3OJ23yJqrkGxK5z5K34I3EqZErXGQlKOHPb8d1/n7Oix2xhOp4HJ2qm+SbOyqXAf4hLszaPxLmKJV1QJct2CYG/xu9Z9Et/mn89KoTiw2IbfQbSGBFzV9ncif8JQVy2db96OOHGIpb9TJvwLDIBdg0aEbCscWm6vPrAZlIbi1eL3D3DAROllRygZfzkx/kJbylAQqvoQ==
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AM9PR10MB4117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Thu, 10 Oct
 2024 15:02:13 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 15:02:13 +0000
From: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
To: "pierre.ficheux@smile.fr" <pierre.ficheux@smile.fr>, "ruiqurm@gmail.com"
	<ruiqurm@gmail.com>
CC: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Re: POSIX API for EVL
Thread-Topic: POSIX API for EVL
Thread-Index: AQHbGxpBTqu5yAsLaUmrMg/HUd/roLKAFJAA
Date: Thu, 10 Oct 2024 15:02:13 +0000
Message-ID: <902323ac26513b7f74940b69b827f786ae59f13c.camel@siemens.com>
References:
 <TYZPR04MB64250B7A13A16179B0044F4DAA782@TYZPR04MB6425.apcprd04.prod.outlook.com>
In-Reply-To:
 <TYZPR04MB64250B7A13A16179B0044F4DAA782@TYZPR04MB6425.apcprd04.prod.outlook.com>
Reply-To: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6349:EE_|AM9PR10MB4117:EE_
x-ms-office365-filtering-correlation-id: a591f9ae-778c-469e-77e6-08dce93c8614
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0NMSVBFZHV2c0tKbHBlZUI4dTE1Q1psVnVuOFdCWHFEdjhialR1Q1JVZ0ZP?=
 =?utf-8?B?a0hDOGhqazJoaStiOFAzaVk1WXptSFRURjFTZjRVNzNRYVgzMzNpNnJJUXZs?=
 =?utf-8?B?MU5nbFk0Z1ZQZEJNNkZzeUx6ZWNrckU1Zm5sL1hiWCtPWmpleW9JRU44MXJG?=
 =?utf-8?B?QmFJRjdNbVNMdDhHQy9wNVRXOVdhRnRIZ0Z3eDUyVXl0MTlKaUFYT2Y2YjN4?=
 =?utf-8?B?QkxNZGZHOU9kZ0lRN1ZET1k1TVpBdzBRVW8vMUhRaFBZdWczY1VPUHB6cHU2?=
 =?utf-8?B?dkl2eXJtK3Q1MW9SbTBGTjd0Q3YvSG0zR3VnRHRvZWI3UXF4eXNldTJvQzEz?=
 =?utf-8?B?MUpEWnBpY0VFQ1Nia0RzVVBydXlSY1VyTWoyQVBtdllEMWlzcHJtMFN1VVlz?=
 =?utf-8?B?M2dSUzNuVXRvTWdueTJhcHA3Q3hoZElUYXhEUUw5OFROaUwxcFptY3dLWTNE?=
 =?utf-8?B?N0dXUmp0SFRSUC91SC9YbGllM1I4M3Jaa1QzMzh3Zng1eXdTYkdTQUx1NWpR?=
 =?utf-8?B?WWgvaXRidkhEVzV3WEdEVGJNc1RlUnR6UFpLTFJqZE1UemR0aU41cGRucVlV?=
 =?utf-8?B?ckVWM1JWZ0JTVUMvT2l2S0p5KzlWdXBoc0RxVTZDWGFUdGMwaG9UeGFHdXJI?=
 =?utf-8?B?T2l1SW9ZNzdjeGVPMUlWM2FBNGRrYklDMTdzQjloM3RlRFN2Z0UvbU10U3dR?=
 =?utf-8?B?dXorVUxoVDdMbnBHelg1MWk5S3FQWE8zTS9KcXdwb3VHcFYyWDNoUitHZ3Ur?=
 =?utf-8?B?OVAxRVVOTUVEQksyTG9hbzJZa09lS1RESmFKQ3FhQ3hKTndENG00YU8xdDJH?=
 =?utf-8?B?NDdvbktMMDdzbEpQYzhSaVl2cFpVWlllMDAzd1ZzNU9POThLNWJib2ZyOXNW?=
 =?utf-8?B?RjQwY0FSNldyTTVwYm50Y2ZDNituREtNOFpsUFpRV1kyclQwVmxCZzBHQ2NE?=
 =?utf-8?B?eC9MTllEdkpVb0l0K3d2L3BONmxVRWpYc0tBSHhFVnVEeUxyNTRTYlFkcE8r?=
 =?utf-8?B?MnF6ODBkME5kTE5xeDdZZ2RrbS9DbE9WZ1plZ1NXY0hFbWNNOFZ1NEg2K2VX?=
 =?utf-8?B?VExON0k0M2NUT0lzUHUrNW9JQm5QOG1lZENtdVJUSkRDZ2tJM1kxUUFVWWpH?=
 =?utf-8?B?U1lsbC9hcEZqL0dEaUNGRlVtNE1acGF4QXdCeTB6cmZscWh6OHVuSWNmTTFB?=
 =?utf-8?B?N1RCVDNlOVhlS2RiTHNKV2FuWmlKeTd5M3d6ZFNHOTJEVndwOTBzK2wzTGJk?=
 =?utf-8?B?cmxpdVBLMHRyOTA5YUJ0MlJ1M2dmYzNmZE96aFJIcUdPeVRCRFFqbXYrUDky?=
 =?utf-8?B?OEZrczJaUkw1Qkl0RmhKNXBNTmduTkRkd3laNGxJemtkSWNKSDVLWlBNdGxj?=
 =?utf-8?B?QUFRWGpuSjhsU2VtNzcvMGlVN2ppa0hnNmxoTXp1NG9JT3ZmWXpUNDErdUVG?=
 =?utf-8?B?N2FIMHRTbWdQMVNBcFdBZ1gvdGJ6SmJrb1YyNzNIelRzQkVtMUZjK1ltZW5k?=
 =?utf-8?B?cEthR2dwVXpYVjZyUm5MdkFOS0FuaG13cWFBRmo0eTJxZHVaWE5WSWlHVzI2?=
 =?utf-8?B?TytKVExia1J2Q29sODNrekE2N3RreWhQSWtMcWJQWm9KNE9Tc0sxWVZGckRC?=
 =?utf-8?B?bEtkVzdBSVJia0RMZ1NuZkhDVWhBWFZocHEyRmFKUlJKRitHVGxjUUNibmZk?=
 =?utf-8?B?NmpLV3FlckRITzJVMjA0QmtPN2NMUjJpazBPbGkxTEJBc2Z2Rlh4bUZFMmJD?=
 =?utf-8?B?OW8yT0dSU3lkQ2krTXlOeEN3T1g3cmVlc0s4RXlLRHhBMnFGOE1KODJLRDkz?=
 =?utf-8?B?SjFPNHdydnJMUlFkRnBBZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnN0ZEZ3dEt4aStLUFRyUFUxcmN0ak9ZQUM5VTBsMWhTQ0xBTTQ5a2RMMkVN?=
 =?utf-8?B?R25JTUFRa2JjYU9LVE8rWmdzRVVnVzZuRDRtb3Qxdm8zS1FycndHcnd6K1Br?=
 =?utf-8?B?UzhrSG9OejJOQTk1bVZlYk1WaDRjVlpVSE5PbStDRTVzUnlJVEdwdjJBTmJm?=
 =?utf-8?B?U01PTjNQNEpYeEp3ejZ6cXBLRTRYTGkyYytPVXhlWnErd3lTbHQ4OXRzRW92?=
 =?utf-8?B?VzY5WXJ3UThKMzJBNmhwcmM3SWhJa3h2ZGNWRWFtckdXb3B6NC9RY0FsZWo4?=
 =?utf-8?B?azcxMEpjb3hvbjJCNlFlcUpCV2xETTh2cHN5Q3lXSXREMElQWExSOFNBNFB0?=
 =?utf-8?B?VVBWdGJLWUhLaXhGQnczakFka0hQd1czNWR0elFmazVYRUZlTjFqNGFuSi8w?=
 =?utf-8?B?emt6Rk5PcHI3Nm5iYThpNTh5eUI5T3F4Z1VxTEQwR2ZPZ0p1NXJFQVZFNStq?=
 =?utf-8?B?WWdTV0FEaW9PbzJQWWdSK0xEVHBtQitVdDEzUGxjRHovNmdFTk10TTVHYkdx?=
 =?utf-8?B?a3dSaU9Ocm5FV1R5bzE5WFpuQm5XdjVOM0VkYkdxTXg5TWdSVi9IMnNCSkZG?=
 =?utf-8?B?cEE5T01IeEkvc1lBTTM0dVZNN1NWQmtFb2lGZXJzakNGMGtEQW5mczNzOTlB?=
 =?utf-8?B?K3JvUW44STFYcWsvdjNjaDZzVHU1Yk0vS2o3UW1JNGtNVTNuL1RzcmpZNXVL?=
 =?utf-8?B?NjhRUm9sNENJM0dEVTNNZEVPcHJTNVNxSWtxZVhEZ05OUUhBZmMxUUxWY01I?=
 =?utf-8?B?YklkRWFuQUhDemVoT09GYnpXZ201N1p1a0p4amREK3YrcHI0SjAyMWtQTDND?=
 =?utf-8?B?RjNjNWswSVkrK2tuL1VURHZIbWxFUWFFL2g5YmhoM04rcTNSdTRscEZjcEJt?=
 =?utf-8?B?OHdSL2cwcldXTjVzcG9CaElKTTRFVk1QdkhibWZFQW5lYXhtTjdldzNNcUdh?=
 =?utf-8?B?eEM5cVV2UjZBUWwzbVdNT3NvU0V2ZG9mYmwzOEJwcVMrT2JmVUd5YjlyN2I1?=
 =?utf-8?B?cE52bWpOQnV1YklWdkQvcHlFNzZQaVh2Y0ZOd1JxUzY0SjVBb3hiSEt6b2NL?=
 =?utf-8?B?NE1FclhHTWdmN2wzclA1VjNiYTd0UjVZWUdreGltREw0Qm4xeE5NTVRkWWdF?=
 =?utf-8?B?SjRxYzJEMWRyU3Izc3RCQWhPQnBIREZqRjV0QURuOExMSjN0UlA3OWZwMWdu?=
 =?utf-8?B?VFRyMndQcURodHQvekUyNGdmK0k3T0NrbWtGTUtpTDNGSWFxKzB5WWcyNG1a?=
 =?utf-8?B?bTQycVByTGpKcXFQeXpNRkNwTHEzUjUycTBIVU81dkZ1Y3l2VjB3S2dQQzVk?=
 =?utf-8?B?L1ptUmZxc1owNzlNaXR4SnpDQS94bkg5RlBsR01pUHl0Ly9NdmdzaDR2VExk?=
 =?utf-8?B?MkFHWlMzeVRZQTRtREFkOURqZjN2ZWZQTGJxRFFwTE9WV1MrQVNOMHpPckhH?=
 =?utf-8?B?MmE4emVtcFhGR1V2bUV4TjRqRytiRFh4dWN0NmNLUUVDU2VOeHYvWkZNNnRD?=
 =?utf-8?B?Rzd3N1Nvcmg1UEI5and3NjA5WCtlWlhDcERlZnRCV0E1NEdXMHNCUDlSY2hG?=
 =?utf-8?B?bVM3SXVwdWtRaTduZ0JLejVUQml5Wk5IL1UzKzhkMjBjM293Z2dkSEpmQXFr?=
 =?utf-8?B?TSt0N3p6empZbVE2bWVUenJJMGd6WWhRVnNUbG0rei9obWNrYzM5cWMvLysr?=
 =?utf-8?B?MHpXdk9LL3J6SmU0c0V6WDlVUE0vcmhqTEN6ZnRwaVUwaHdEYzZNYzdTRkcz?=
 =?utf-8?B?N2JDRTA1NkdiU3d0R1BDRGJzVWRtOVdGNzNHRjlQUXgveVUrR21WcS9udTNz?=
 =?utf-8?B?V051aXhGc0hyRTZHVjdJblRVV0o5ZlFkUkZvaFRXUnYwclZid2RiWTdzditX?=
 =?utf-8?B?RzUxNlRrRnVLclp3alBPd3ZHbjR6QVhCQzU1cnhQNnhUT0hCYWlvWU1zcjlB?=
 =?utf-8?B?enVGN2tVcHAyVWRYSTk3by9zTmkxUi9ndXNPcnM2Y25XMFVvMWNJYnVFalcv?=
 =?utf-8?B?ei9rWCtBZDd5eUxhWEVjNXVzK1R1QlF0RG1jNFl0TUdZb2ZCU1ZXOTdnV1lo?=
 =?utf-8?B?bVo1M2tHRlN3SHptSmlHcGFXM1dOKzFINHl3UHNxUCszei9RNy80Wlp2dDNV?=
 =?utf-8?B?QlMxcGF1WVFtZ0Vtd2FHTHZvTXpSd01nWVVRa1hWSGc0VGlCZGFhdkNYZ3hS?=
 =?utf-8?B?TERITjljeHh3U1d5enNWd3lDalhEMWhHdUpWRXVJWEFmelB6Uk5rSE9GSHJz?=
 =?utf-8?Q?L2n7jg8Or+cecPvuSmvFTvGGq2UhlTjDQjq1vSUaWo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7549799BA6B454B9A19BD90E05C69E0@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a591f9ae-778c-469e-77e6-08dce93c8614
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 15:02:13.6481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIefO4ws4HhMPLkTdBGdxPXanatCao5aCJBSxXg1xpg475pzWaF4qtMh+lhu0/gAsQE15oY1L0CwfNGyct/lWDuD/evwpLLc+IPRdvU/too=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4117
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=nIw9cZXY;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=none (spool.mail.gandi.net: domain of tobias.schaffner@siemens.com has no SPF policy when checking 2a01:111:f403:2614::625) smtp.mailfrom=tobias.schaffner@siemens.com

SGkgU2FtLA0KDQpPbiBUaHUsIDIwMjQtMTAtMTAgYXQgMTQ6MDAgKzAwMDAsIFNhbSBDaGl1IHdy
b3RlOg0KPiBIaS4gSeKAmW0gYWxzbyBpbnRlcmVzdGVkIGluIHRoZSBQT1NJWCB3cmFwcGVyIGZv
ciB0aGUgRVZMIEFQSS4gQSBmZXcNCj4gbW9udGhzIGFnbywgSSB3b3JrZWQgb24gYSByZWxhdGVk
IHByb2plY3QgYW5kIGRldmVsb3BlZCBhIHNpbXBsZSBkZW1vDQo+IHByb2dyYW0uIFlvdSBjYW4g
ZmluZCBpdCBoZXJlOg0KPiBodHRwczovL2dpdGh1Yi5jb20vQlVQVC1PUy9saWJldmwvdHJlZS9w
b3NpeC4gSG93ZXZlciwgaXTigJlzIHN0aWxsDQo+IGp1c3QgYSB0b3kgcHJvamVjdCwgb25seSBp
bmNsdWRpbmcgdGhyZWFkIGNyZWF0aW9uIGFuZCBsb2NraW5nDQo+IGZ1bmN0aW9uYWxpdHksIGFu
ZCBpdCBoYXNu4oCZdCB1bmRlcmdvbmUgcmlnb3JvdXMgdGVzdGluZy4gSeKAmW0gZ2xhZCB0bw0K
PiBzZWUgdGhhdCBzb21lb25lIGZpbmRzIHRoZSBmZWF0dXJlcyB1c2VmdWwsIGFuZCBJ4oCZbGwg
Y29udGludWUgd29ya2luZw0KPiBvbiB0aGlzIHByb2plY3QgbW92aW5nIGZvcndhcmQuDQoNCnRo
YW5rcyBmb3IgdGhlIGhlYWRzIHVwLiBHcmVhdCB0aGF0IHlvdSBhcmUgdXNpbmcgRVZMIGluIFJS
T1MgYW5kIHRoYXQNCnlvdSBhcmUgd29ya2luZyBvbiBhIFBPU0lYIGxheWVyLiBJIHdvdWxkIHJl
Y29tbWVuZCB0byBzZW5kIHRoZQ0KcmVsZXZhbnQgcGF0Y2hlcyBhcyBhbiBSRkMgdG8gdGhpcyBt
YWlsaW5nIGxpc3QuIFRoaXMgd2F5IHlvdSB3aWxsIGdldA0KbW9yZSBmZWVkYmFjayBieSB0aGUg
bWFpbnRhaW5lcnMgb2YgdGhpcyBwcm9qZWN0LiBUaGlzIGNvdWxkIGJlDQp2YWx1YWJsZSBpbnB1
dCBmb3IgeW91ciBuZXh0IHN0ZXBzIGFuZCBpbmNyZWFzZSB0aGUgY2hhbmNlIHRoYXQgaXQgY2Fu
DQpiZSB1cHN0cmVhbWVkIGxhdGVyLiBZb3UgY2FuIGRvIHRoaXMgYnkgdXNpbmcgZ2l0LWZvcm1h
dC1wYXRjaCBbMV0gYW5kDQpnaXQtc2VuZC1lbWFpbCBbMl0uIFRyeSB0byBmaW5kIGEgZ3VpZGUg
b24gaG93IHRvIHNlbmQgcGF0Y2hlcyB0byB0aGUNCmtlcm5lbCBtYWlsaW5nIGxpc3QuIE1vc3Qg
b2YgdGhlIHJ1bGVzIGFsc28gYXBwbHkgaGVyZS4NCg0KRmVlbCBmcmVlIHRvIHNlbmQgbWUgYW4g
ZW1haWwgaWYgeW91IG5lZWQgZnVydGhlciBhc3Npc3RhbmNlIHdpdGggdGhlDQp3b3JrZmxvdy4N
Cg0KQmVzdCwNClRvYmlhcw0KDQpbMV0gaHR0cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdC1mb3Jt
YXQtcGF0Y2gNClsyXSBodHRwczovL2dpdC1zY20uY29tL2RvY3MvZ2l0LXNlbmQtZW1haWwNCg==

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795436796;
	b=T3cAduUIj0eIQ0LvhEYaafwowr3rdCXoGrS/RG8/i071NvnQd6kAXo8NfLW4JPeU9WS9
	 VoY9oYI/PFBPFTGnk7f9qvDS2l6ibJY/1+huZatrH8Lc7Zmoj86zLPVgJ79okarq6WP1J
	 16y5jy288+pnSrnILqRgN8gREP1oeZo4y65ZyHeGZII5CLXlo5uBvBWMGQcsab8ezIqR+
	 f2/Njv3yAiiZ662wXFCwiqf6aW6PSzD/+QSChi4Ybqh9/Biyy/4KbdFrokJ/odLnhTgKA
	 rrUGhHdOlfQArAyasQDCnGvnQJN3d8J/9QwbZy/xcbxrB/icRkJwSWS/DILYt/KvuVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436796;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=m4to5tg+b6EvcMcjBzTOyH7rf182wnGziGXvUk6iFvw=;
	b=z8WuSv8dHqMsCn1cMrELFlboATT2Jah3ssXcrCHLj5nCKBrBWifuVpMOSS2qm0ZkwIcK
	 ab8EUxTGfF3ejafJwhgj4tK1+cwq2e6hwOaMnUFPHqHDzJ814AXeTVQatafE8o2DvjIEe
	 R1HT/yCLV4YX6YfOraH8YdAy4XpNzHzE/8ru1Hwcss2gpKoxtCIe2Gz4aZeYKdVmvbHSM
	 vj9nolkrCbhWseiGwbtwMB3AfOC3voOZY/gRdqK1glqjCBmoKPUCRet5FU/2yCEYT1xvV
	 OonHTu3YJ7EHeyVuNPBvgaJD3kRHpBef9RJOzqqOJzYiijHIWDE0YScqXXAVe9mxkkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="Pcm/ADiL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.57
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0B606A31A
	for <xenomai@lists.linux.dev>; Mon, 23 Nov 2026 12:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11E0B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Pcm/ADiL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VS2ymoHgCn4azvxfIfTXv2Cwq3odTvNPUmlWwOrzy/yakqShgok3xGYqRRbe9RRYfDjHJuIq5au3Flp+u2tlUIBPasKWf91otpRQp0Jz/VO6Vn8ZepmjErozqf3BE9v6JGOjwSkPG2s3oVsCm2NTnCIbc0ZnxiQqNZgV3N6wgYzQkiVnfvLmdktg5Xek7RiZpDeJO8TNws0Arl4io5DuasxKIa+tMRsp5aKQxU7URR371rQg35qOveUzRI6MM0cStTPuqtpGJ5txWkUK79nL3qjrv7ChKhKebABSOGrmguNpPyiNflxx42ytwnzvWaxcIL+JS4I74+Bax7h4b13+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4to5tg+b6EvcMcjBzTOyH7rf182wnGziGXvUk6iFvw=;
 b=AITupILifdqRtXnI7EoEG2a6PYSBy7PkTXvhjjN9QoBEUyftZrj9y4vJbcsi3Eeuu9EWs7+FaEHaMF8nAY7CxHZRQqdOUhcOuP7AYmYgIb4O3+x5ss9auA9W/okmkdAR4Wdrrcie+2oq0yOuxUzFZKCZpLec2ZSRTr0KZ88BVB/bGWETNXP5X7o90kdv0i3RjLdp9r5rFsPiZp8nR8Ov5awE9KGWjfKp6RXlr53+9VcMz9Bi6Jm49bDVx3hADzYCXfftF8mT0y+LFE7mzKn6/O0Oah4OhyVKsvh7XCZb8GD74pN0H3pX6FsACSF+gEUdtz73iHnKtxx85bqX/EnekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4to5tg+b6EvcMcjBzTOyH7rf182wnGziGXvUk6iFvw=;
 b=Pcm/ADiLLhCOB6ARM+MkUkGAWNLUSJh82V1uVhhF8x1E7JMJtLHDagRfAQRGjhzo6VO9dSWHOeqKC+0HAMXmpO53NiDP8dqboOnjiWrc3PXqbMZQPF4hMV78TI1SuMNVFcpVA6fKsOzSE266hSlsysEkDV5+wLhQV0J/TUejjGPvFNo6R5PsCHhNJx6BtlJl9FeC1GbIZulB/zdF2PlqJ5+RzQL7/pJanYNdjVxoY4MmnrPgnndQ7vK/PK5ZYixBVdX8iW0DiXIIGnGdPqUUrqtc2qBolsAxZGO0/Fukr9oqXrW0YzqcYSH17BqAESr4r6S/CbnqNfVLaRfOPuMSIw==
Received: from DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49c::5)
 by BESPR10MB9247.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Mon, 23 Nov
 2026 12:26:33 +0000
Received: from DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aed8:db10:ff00:63db]) by DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aed8:db10:ff00:63db%5]) with mapi id 15.21.0662.001; Mon, 23 Nov 2026
 12:26:33 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "rpm@xenomai.org" <rpm@xenomai.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
Thread-Topic: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
Thread-Index: AQHdedmm06QuFsXyIk2v7DwLWHWj/Lc6u/WAgADPBwCAAAc4AIAABdcA
Date: Mon, 23 Nov 2026 12:26:32 +0000
Message-ID: <2c29967af73156492ed379e98c0a32a1bc0ed96f.camel@siemens.com>
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
		 <20261121165933.57310-4-tobias.schaffner@siemens.com>
		 <DN2371TJAB7G.334DTWMEPJTQI@siemens.com>
		 <915d53fb-fc8b-4c07-935f-a9d4680ee8a5@siemens.com>
	 <87afa16be7aada0d995e63364bb9e7785af24675.camel@siemens.com>
In-Reply-To: <87afa16be7aada0d995e63364bb9e7785af24675.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.62.1 (3.62.1-1.fc45) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR10MB7766:EE_|BESPR10MB9247:EE_
x-ms-office365-filtering-correlation-id: dc7dff42-fd11-45b1-46e3-08df495d0267
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|38070700021|4143699003|56012099006|10067099003|261009223027099003|55112099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 j9W6jm1VEG18tbkCnOjz6UIxEDmxozwAANAyOye9FGZ0vEqb0+YelthD50nZ91Go/Mf5g5JLBETxskNHQ6VlaCBCR2KE8jWpA1I9KgnXeV1yzDOwj2DmUh4xqF5o0DPaPxGPr5wtehrMohfL6hyYQIgD37JNk9uldP+sUppmbpSYSQ1GJlKxn2hJ6Pnv9rWWNhYPDWEmn+auyqmOMXt196oacDJ4XIYaBMf9tVlbEQAJ7Uc2wCqiQtNM8Iu12vflguKUKVL6uris02TJ0aht0YIOVlP0MPt/bid3sW4zRKb9QPQmRf8G/yS9X0qTqow2xvq4yGJ+KMwReDkcWvQxZjyvXn2ywp28FKU3uPMVTv0D3nLgCPMcItXRzssRRL2kxntIhXUhXEIkos28lqy2alc4oFAaTg3KZpUF00SlD3vcAx+9X7n34HTOsDrSvRzfQAglfIWi+a83lHUtkwwiAxbsOaJbs7bZ0wmZtaCbVp+z23PGWZK0yp7b6PcDkpnHkg62Yh4LFUTss16mcUukJcxtdvOro6kZ/GNEUAcb8PHcu7/QxQgbr+boGO4/cEuvcDldxIpLUG7EoDMK8+TOwqV2Ce7fc3jyT8IVjVP450CwMuR2sYnxTvace054apBiIFvvoKFWZPHfJIUiHKn6+S2yKV0HIrAOKxZJ5mcIh96XCPnrWVkIYkFUINZ4IXc6dUg2GTlHy677tOejAdEnqMG92aS7r7iw4J6Ulph7ma0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(38070700021)(4143699003)(56012099006)(10067099003)(261009223027099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?am9LQkpiV25hcGh3ZVZid1RPMW5WY1hVQ0lzUHhDRUJPalhSUElJZzY0aDMw?=
 =?utf-8?B?MmgvN2FITm5GQmxZUko2Tk53c3ViWVRVczhJbXBseGV6aGFzdEhJVEpXTEEr?=
 =?utf-8?B?R3BJWXZ0b0V4NGFjRGlMUUZ3Y1hsbGViZzNqNEdsZlpqenJaREtVbVNjb01P?=
 =?utf-8?B?bTJHRjVCay8wWE1WM0JkdjYrTENTbnk0SDhaTjRuQjQwaDYybVpNU0NoNCs1?=
 =?utf-8?B?eUhVNm1VMU1sTzd6NGFObWFaSTdNU3FEcEtnYURvSmNXMDUyc0lpaVQ3Q3pF?=
 =?utf-8?B?LzRrWUE4ZXJGVDYreVdYZnQva3ZYQ3VBZVY5ZGE0U0EzY2NHRzgyWWV0UFgw?=
 =?utf-8?B?TmFUdklZOEZWdk04R0JvNFArRy9ZSTcreTFlZml0RG8xZzZzK3RVTUZ3Sml3?=
 =?utf-8?B?VWRjRlh5TlQzQXBnRzJIVCs3VkUwL1Y4WVlwNk1ySngwSFJ4ZDVLYno0SnRy?=
 =?utf-8?B?QWxQRmdsNFFiMjZBNklhQWMyUVYyVVFrWTBkNU1TVitCbEtXcHVJL1FwNTNh?=
 =?utf-8?B?RUJIZmZDc1c5VzhCa2dvVTlQcFQxL01DSzRxQitrWTQ2cDdkcEMrTkZDMk5x?=
 =?utf-8?B?NUJ6SWFmY0Zxazhsa3BjbDl0SGgxOFFnN0JOb3B2SFZyTUczSTZxNFV6OFVi?=
 =?utf-8?B?c3VuZllNZDdSalJXSjlQakw4VFZPY3RlNDkvTDlzSDQwK09zT0tmeGdiT3ox?=
 =?utf-8?B?ZTR2Q294Q1JqOG9JYjlIUndVT3NNQWVJaXlmN1lZOXp0dEwzUExuSmVBVGdR?=
 =?utf-8?B?R1NNdEgzdWM1N1NlNlZtVU9Kc1gyNHJRS1V2dlhaVitxeXhpVWlyeTRtc3lZ?=
 =?utf-8?B?R0s3Qy9kUkg5QkV6emp5TXpodUtmOVh1Y1paNGFmWU5iVnFTSjFMaGM2NmJl?=
 =?utf-8?B?VWwwdVB0VStQZDN6VFpITFVPMGdQOW1iL1hMZWtBd2QxaHVPMHpYQzYyVUR3?=
 =?utf-8?B?b2pJWDlZRFpOTW80Umovb3IyeldjT0toRC9sTmJ0bml1V2FkWTl2eXhtUUJU?=
 =?utf-8?B?Vi9ZSjMvY0NjTWsyODVnOGJHWWlnYXNQMko3MStxYmZHclZDUktpOENpQlFI?=
 =?utf-8?B?dnhKYmxUeTl2SXUrNmZIR2U4SndOdDJ0ZXgzbExReXBic3RMRU1pYjJPUC90?=
 =?utf-8?B?MUc4YVpPK3dScG1vV25BcHdzM3ZQUEs3VGRWY3NzOHhzei91ZmZIN29uZUpz?=
 =?utf-8?B?cHkzcG41UjZRZjNNTm5QZVJlQlhVRWZOQnFLbWwvS212aDYrYVl1MUY2WW1S?=
 =?utf-8?B?N3FnNnNMM2xhUnE3MmgwMkNWeGorTzRXRmJxQkFnZnMvSjdIUEtBVG5icDVy?=
 =?utf-8?B?S3dFTzQ3ZFQvMWJOeFpjTDk2ZWhtZnd2SDE1RERzTjkrN0ZKaVZLcENWQmdU?=
 =?utf-8?B?cllmMmViS1NUZWNSQjVjcTFwK3FPU1NUSUJRS0tITVc5SUVpZ3FYZnRYOWRK?=
 =?utf-8?B?WDEzMlRMTGNYcng3L1UvcS93V2JqY1hUTmNVUFVtamlqanFwUi9vS0Z0VmQ4?=
 =?utf-8?B?dnhQMEZIVUpSMWYwTWhFUWZjUHZMNitIaldqQVJGK2RkVkYrYjVWREp4L3p2?=
 =?utf-8?B?SmtyY0c5UkJ2NlRwVG5vQ0htQWE3RGFvdHhnb1plclpGNlJKNG4xV2MvaUt4?=
 =?utf-8?B?RFNyOGRVbTNoTm9seEUyR1Y5bFg2TUNSUndFNlZ6bENJVUd4bUk5QWZ1OXZJ?=
 =?utf-8?B?QlJ3VnZXOG81eTVRekdta3Y3Wm96RVFrZTdURytNdmIvdE9GemRxSXJWTVg0?=
 =?utf-8?B?bklHUWxQeW1BNmRva0VJMEZrc1p5TU1kOVZQTzNFU0hKM1AyQnhmYlloaUR0?=
 =?utf-8?B?R0h3Wnd2TXlLeUhEZVErTXkrWnlWWlNOdmpHQ0oyc3RhVnZiNDV5bHdtcUFV?=
 =?utf-8?B?ZkdZbkdIMG5WOTQ0UXJleGpSSmRwSG1hZk1YWjh5RVBmb015WlRKcjJ1dzZl?=
 =?utf-8?B?MlRmQ29UZXprUlJBcm8vRXdvY2lUTDM2UFA0clZ3RnhRQ2dUTEJpc2I4aHNt?=
 =?utf-8?B?d3NDVk11ZUltYnROQzcwdy9yaXQ3N1VpL3B4WkdSbm51QU9XRnJkNFRXNHd6?=
 =?utf-8?B?Q2xBbXZqaEMyS1JlR0kxT0pSQlpiajBUQnU3d0xCNi9JOFlaTjhMY29ZQ2Rj?=
 =?utf-8?B?MVB1M0wxODlGTVVSTkpMNCtFRERVdGVFNmtxamtwTC9hVW1rQW1yWHpJM1VV?=
 =?utf-8?B?eCtqdnpaZjB0YWRnZTJ5WTE2M0UxVDZMZDhBajdvbVR5ck80cWI4d3J5SWZM?=
 =?utf-8?B?QlJEK25QM0kxUEVVYkZLUE04czhBN3QwSUJzOXNWRHhVM2EyTVNpQWJXWDZ5?=
 =?utf-8?B?OEk1d1h6dno5R2NjZkZzbXNrVm5rcHE2Q3BldkpYZURVYTFZanZZQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D707918E5A1964F9A77C636C731592F@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7dff42-fd11-45b1-46e3-08df495d0267
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 12:26:33.0021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I+bLCAJRZzgh33ymurVcZOYGj2dlQyUZWl6pfmsP62psQHnFuUIDtUYxSeke94iw4WF0yIsAABSfdnxrXBufj5VOS9yeaVw+kLXoVjBRGbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9247

T24gTW9uLCAyMDI2LTExLTIzIGF0IDEzOjA1ICswMTAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
Cj4gPiAKPiA+IFllcy4gVGhpcyBwYXR0ZXJuIGlzIHRha2VuIGZyb20gY29uZF9yZWVuYWJsZV9p
cnFzX2tlcm5lbCgpIGluCj4gPiBhcmNoL3g4Ni9tbS9mYXVsdC5jCj4gCj4gTGV0IG1lIGNoZWNr
LCBidXQgSSB0aGluayB0aGUgZW50cnkgY29kZSBpcyBhIGJpdCBkaWZmZXJlbnQgb24geDg2LgoK
Q29uZmlybWVkLiBjb25kX3JlZW5hYmxlX2lycXNfa2VybmVsKCkgb24geDg2IGlzIGNhbGxlZCAq
YmVmb3JlKgpub3RpZnlpbmcgdGhlIGNvLWtlcm5lbC4gSXQncyBtb3JlIG9yIGxlc3MgdGhlICJy
ZXBsYWNlbWVudCIgZm9yIHlvdXIKbWFya190cmFwX2VudHJ5KCkgb24gcmlzYy12LgoKWW91IGNv
cGllZCBpdCAqYWZ0ZXIqIHRoZSBjby1rZXJuZWwgbm90aWZ5LCB3aGljaCBicmVha3MgdGhlIG9y
ZGVyaW5nLgo=

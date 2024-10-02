Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F61854
	for <xenomai@lists.linux.dev>; Wed,  2 Oct 2024 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890670; cv=fail; b=KMTbi/NExhtEcP66ahA4Aby+sVy0pLt5tdy2sCHlAqFr9hfX3Wks1i5SiNUrpt4N6hEOQCPd59MVG/fzgkY34FT/I+DvAhgEhPOEan+YjMo3PRswUuRQVzQ0EmLYSpl67Z1wkl6mhyG4keiWbcWHS7PIEJYdrbVTifk+rGOEIek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890670; c=relaxed/simple;
	bh=4yFTQWB+e+Sq7POSQcirth/DIqzF965xZNxq0wKSfjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ukrcLeN0cN1cF2o7TVrYsbK+pQeB9JNuOfnBNaYGcI7DJa9129el8abpPdyslU9u2CZwA0L+1cBGB5/ctt0qXkbB/AD6FdN4BgxEqbVqA3LuqwdJS0EAPreko12AhnagHGBNu3kxWe4OO26tbW5Ake12FEeeeivEJAB4EdVW22Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SXdQypv/; arc=fail smtp.client-ip=40.107.247.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SXdQypv/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=df94TIhWexKPsbbEmh6iJzAb7Qr74QMD5+7vbhdlS1UJyYLnTVlHYU1TqlziGpH1Oh/WD+g6yCSF3Jx3MdXECEDIYgyd3s2BqHJrD1Ia9FOibIUe9Gd5L/1t44gCktPgjEn143ViC3xY6Q0SSqWWmVBtLUqK8XE7gGYsGNLcmEj9B5zNBIM66ANxWInE8qWeRo7/97FcUBw53U6NsCv2Q1xfRgYZJ460YZ87zpOcKk5AjP0OnRLkdObQR0VuHp+uvrQtCdbwM8AWOi3QPnTBVi986a0WsYB1oXuceYZ9ETK15GZ7paTk3Hsp4dknzk4HeAux8pKY4iIhrPlYNwVylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yFTQWB+e+Sq7POSQcirth/DIqzF965xZNxq0wKSfjE=;
 b=gIb1gyNaO/MwPkCyf1ojG3KhdjNiJUodZq10e3PaFEpWmXx7Kc6vb42Ayf0nFBxMqfCHmRqgCjKxb/jlnn+aVYjAVqqp4pPpfg7MnVnRTaI8rtzhZLxlV9zJoefNXR23wMPERSTQxScigVcfb6ONXxwrQPydctfJsNqav2O1UKZNZpv+M7sL4NvQbPgtxkLLFs9hKoxQ6y0eF3ln3P3V1Hkd+mxaO3JLse6B8PL3l0gsUt0sRWI4CrNCHNHfb49z+UrVFv1B9AmDAMUVkW+coQooc1hAi63KUGIn4sQSAtOChl4DlCjH78WC8jMV5JIixPgg0qfsWpppSIr8rmLKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yFTQWB+e+Sq7POSQcirth/DIqzF965xZNxq0wKSfjE=;
 b=SXdQypv/PW4lmMkBnY4V6Gr/9IzqtgLPtWbn0vEa5cOGAF10nfIm6V/kCLgNIRn6YP8cWc4XGCi5UU44ItvFRvIGj8F/8detNv1DYHXL2nP1pdi5F2EQL4wGWpLlFrzES63OND0k1KoqPIkhx3nHjZU4VGt4B/Ci3c6W08fiIIF8VpI4A0o5rXBYN7Kbia3NF83j/nlBqHZ6tBy9dVINWjnV8UpwrZMo21L26qsK/NnYtpMQJ2tkXJUPCY+iWgMYJBK+S1H66SlN6CFU3KFcOqxQuwlONtPrHXSTUK5ajD9m5z4AkxL6X/fLJyz9wLlX9cnQsuCecp1vwwsawIU+tQ==
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DB9PR10MB7628.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 17:37:43 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 17:37:43 +0000
From: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: "rpm@xenomai.org" <rpm@xenomai.org>
Subject: Re: [PATCH dovetail 6.11 0/2] RISC-V: IRQ pipelining core
Thread-Topic: [PATCH dovetail 6.11 0/2] RISC-V: IRQ pipelining core
Thread-Index: AQHbFLd4x7g8umsEVk2cTkuE9iwuerJzSZIAgABwjwA=
Date: Wed, 2 Oct 2024 17:37:43 +0000
Message-ID: <692d68684edb5e046287263ceacb15de63353b02.camel@siemens.com>
References: <20241002104007.991278-1-tobias.schaffner@siemens.com>
	 <fd270dfd-f46d-4f1e-96de-41738a973c23@siemens.com>
In-Reply-To: <fd270dfd-f46d-4f1e-96de-41738a973c23@siemens.com>
Reply-To: "Schaffner, Tobias" <tobias.schaffner@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB6349:EE_|DB9PR10MB7628:EE_
x-ms-office365-filtering-correlation-id: 4316fc53-e45c-4164-78f5-08dce308ebc8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cjlzdWRwcXFtVGxTa3VQWU13TG5OVjFPSi94cllzSjFjOTgxandlUS9UcHBv?=
 =?utf-8?B?NDFqaVQwU2NkU3o3NHF3ci9HMXdOa2pqV1BIL2pkRmFYMmdDSndRMlBYYWEv?=
 =?utf-8?B?THgzV2h0ekVUOTVWdmw1a1Q0VFRNeVJNZUNDbjd0c0hOenpXVkpkM1UvV1pR?=
 =?utf-8?B?VkZoQTErSXlIMlhaeGxFUFkyUGxmdS9kTjJpU25mUFFXcngzRmh3NkhVYlRh?=
 =?utf-8?B?YmRNbFhMdVhXZUVzZTEveFVwVmhIWTcxRWVlTTFQWXg4TE1aMTdXUXU4a0tZ?=
 =?utf-8?B?WkFHOGdSNlVBcm1BRDM1aTJ5YVpMbFYwWndSZm4xdnJzOVE2WFBYWVlDY0Jt?=
 =?utf-8?B?R0YwVWd0L2t2NXBDRWJxeVZ6VzVDSFJHKzYwb3R0djJ6c1YwTkM5R0hLdUt0?=
 =?utf-8?B?R3dUd0x0QllkMXlRVnhtNENibnpUdExVcFR2MlZaNy9UcFdxRkxMZEluVGFq?=
 =?utf-8?B?Mkt0YnF2TTJJcEcrTEtLZVV1K2NvVXhFK0FyQXAwWFRjcnduK29CY1RhdGVu?=
 =?utf-8?B?akQ2RWNQMk43Um5sRFp3dUs1R3Z1eDZ4N3AzbGhGVElOUGhMQnRkV09ESmFD?=
 =?utf-8?B?QlcxcnlxRHFoZTJPbk1XL3M5QTJNeTZuSmtWSTBPODV4WitXdzNGaGZ1Nm1h?=
 =?utf-8?B?UmNYNHZOVkNNSzJsc0ZOVlY1dU5kanhiTkI2MHk5dVNIUzBvWDZEYU5pUHFK?=
 =?utf-8?B?aDM0alMvaHJtbUhhb08rMWppK05SVFFZdEJ6YUhhMEdoWVlTMmN0YUJoSmg5?=
 =?utf-8?B?ckRWSkY4UmFKV0NXWVZrMCtIckpYblFwSndoOFkxY0VnelJNclpsdGRQZC9l?=
 =?utf-8?B?MVJjRVI3UXowMG5ZRDRpejdoaTF5dmMxS1BSbUxBenpxMWc5bzRhTUJxTi9l?=
 =?utf-8?B?UlZmUlV4U1VWK2RFZ0d5aVVpUUN2SGtybTZRKzZuNlhXVXpPbVdrWXJJS3BL?=
 =?utf-8?B?bmxhVExoNUJBTU9vQnRjejNUZHJsMFJ4THgwVi9iREZpV1NtZUhwZS9pM2hL?=
 =?utf-8?B?ME1YN0tiRDJwK3Zqd1N2ak1kR1pTZWQzODhERjJQYWdRZml5bmR4SnhpVmlS?=
 =?utf-8?B?TGc3Sm9NMlowTzlBajdDZStjVFYyY244VXlJbXREcHVsY1ZyNHRQcGFOVzlh?=
 =?utf-8?B?bURIa0FhVGtUdloyR3dTNmZNSjUyWmNYbVE5eVpTMzlQSWNJMnpSRDVITjhM?=
 =?utf-8?B?MXJMMjNUTkhKanhUUjJqSktld0V4enppdHJrS1ZPWXBpUXhGQzRTZHVLT2c1?=
 =?utf-8?B?Nm55SG5OZnRMNENlNDEzRlJrK2Y1VEhub0pQekozYWFkbzJ3cWVjT2g1YUs1?=
 =?utf-8?B?UzUxOHlPY2pKNFg0VXFWN1pYS1d3MlhDMTJneGhTYldRNmtTaE5uYmVyMXdI?=
 =?utf-8?B?dW9RUHpWRDIvUXFRZFJLb09wa0M5RWJobzV2RmRYUC9kRUxXekkvOWdLSndE?=
 =?utf-8?B?ZWY1OWtteUVoK3dWclVtaGhYaWphWEVCWGhzWUtrc1FTOFJTSEM5Q3JpWmEv?=
 =?utf-8?B?U0VJZ0R3aHBiOS91ZUttZnhsdzM3cXFnNXAxbHFRTmh0anRXK3hRT0NuM1FN?=
 =?utf-8?B?UUxXc2dtcDRHaHJNby9ZL3hWWHlYZkpMVFMwT2E2emtPL291SWUzVW5vUDNH?=
 =?utf-8?B?eE95QmFOV3RqTTNteSsxUzgwVUNlZHNPTkxsMVBhemVNUDV0NzZMU2dOM08z?=
 =?utf-8?B?ZHpjOEIvZWtkb21FL0RiR3RJaXllQ3dEZXFudWVsdjhqNTJSYmxhdXFaRVVv?=
 =?utf-8?B?bmdxcmNRZlJIL1BITGZYUEJpYXIyc2MxbGFKQ0RRb0VtUXdsVWc2OTMyc2xR?=
 =?utf-8?B?ejFlbExIdTFlaElMbFcvUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEd4SjErbFlsdVJlcGlrY0FjSW9SZTAzVFh6QXhTSUJvUmFWQUtxK3BTZVpr?=
 =?utf-8?B?WlMyOFRFMUNJeDgxaFptVktHVkpIblJDaG5zU0VEaHVqNHFOVVplQldNay9D?=
 =?utf-8?B?SFNhWDBqbEd2STlNNDhkTjFEbmppbWk4SFlTb2t0YzhWcjRSajFqQlAxT1VP?=
 =?utf-8?B?cVlNdzdYbGhvb3B5clJsMEpndmJZcFdkTFV1ZFRSQk9zYkhkL3czOUpXMzVG?=
 =?utf-8?B?dG1GeWF6REROV1hmZGQyVHo4aEJSSUVxUWNsUTJ4Q2J1b1JXbk01STJnTHR5?=
 =?utf-8?B?SWE2alhEbkYwNkgvRU01bENiOVN4UXlVcTZNNUw3dnJLZ1FBbVREQzZvdTZk?=
 =?utf-8?B?YW9scVBFYi9vaXNUWXlPWExKNHV6enh2aXFLWXZYdVgyZ0NDQWwydlJIakM1?=
 =?utf-8?B?ZDJBTXpzM0YxNTk2S0lqdE9vY1hrZFByTEE2MHVaMGlIZjNvOG9ReG8yeTZZ?=
 =?utf-8?B?YVVaQndzZXpMM3JNZ1lsdDBEL2ZaMVk2VlU3N1JxR1h1VmRWZXFQQ1R6cFc5?=
 =?utf-8?B?SHE5emJZaG56S2hBdTBNNGFKSE1oVnVHb2xEVzUvWm02T0NML0NOWCtwWVN5?=
 =?utf-8?B?NnZlVkpySDRpaWRPK1IwYS9uWjdQVTd5WUNwZzlpeHJkV0hTMHQ5dVZrY2Rs?=
 =?utf-8?B?NHdsWUltN2UyQ1A0Nm1CWFJUQXg5aEt6bWVpNXkvRlI5MzRDbFVtNktsUC83?=
 =?utf-8?B?emQzR011MktLbTdhbE4zWUxmUHlxS05ySnJoVVRuSGZneXZZWDhDaXRlTElk?=
 =?utf-8?B?Q1JkWGlFdnpVbXc1Nitpa21GZSszQkI3YWwyTEVvUGdyRFNQWWJrNHBtUVFM?=
 =?utf-8?B?L29aTVN5STIvVWUrSkRDWFR6SUlSckdBSW85MVVsTEN3by82N2lQVmFCSkZP?=
 =?utf-8?B?L0lhVkxNZklyWTU3NXlhQzQzb0NoMFQ1c05FKzR0MC9jaXRhMFpVWmhHcmVK?=
 =?utf-8?B?eFZRamMxOGFLMzVXV3d1RDA3Qmd2SVMvTUEwVVlTVE1lT0xKeTgwR3NQNzFs?=
 =?utf-8?B?Q1VKV0J0bUpyTUpxUmF3TklYcDBXallnZExESlhsK3lQWVg4VEJ3NXZOQU5J?=
 =?utf-8?B?STduM21ENGxtQk1qeHI4dlFhQW1mWUNBTTdrQm1taGRIUkdwWjU2U1RtbXNX?=
 =?utf-8?B?RGIvK3RWQmx1VDJVT0xhWU5zSVZJMmwyYWJSOHlMYUdJdllPZDFoU2R2UHpp?=
 =?utf-8?B?L2Q2OU94bFFlOThjT1pSRXQrdG1TQVpUUERrREZNVWdRMUtaS21VRzI2MTVJ?=
 =?utf-8?B?aTZtbUF3a1pzdytSb3FhYmQ1Z0hDcVU0bTFVNXRQOXBjeGNjRWRnUHRyMFNw?=
 =?utf-8?B?cEpua3FybjNCY2ZUNEY2bGFIcjNlaGNDdHNDQUpyR3NRLy9YRENQOTRHS1Fu?=
 =?utf-8?B?OWtXU3NUa3NwTTZMbFhVVEJTSVVaQ0FVdG14WE1YdktNT0ZhRXpTdjExUExt?=
 =?utf-8?B?ejBtV2R2V1Q1emN0ck94VU5Kcis2b21LcGdhZW5kdWNZbHhWR3k4Y2xWamQz?=
 =?utf-8?B?RFppQUZNaW5ONWZPSVBYRDUrUCtyZEFuV2V5aytFTzVjaHNmMFpwWTIzUGJy?=
 =?utf-8?B?TlVESEwraEtJeFlwUEtoU3lMdzFRVHJMSUpsSDJhSCtrY005dEZEdEJPS1gz?=
 =?utf-8?B?dmhYZWZmRktROGdicU1tdndtVkp4Y2FYdlU4TGljMklhc0UxM2E1anI5dktC?=
 =?utf-8?B?UzJIWU9zYXlZQ1MxNmNzZEhzcWh5UXJjcUJwTWJnTVZpb3J5YnhCeWovWS9D?=
 =?utf-8?B?Rk9kT2xBUEp0a1VBQjlSYkxQdUpxb2JCcGZVT29JSU53V2pVcUNRVm0wOGI1?=
 =?utf-8?B?RzNqdnFXUGhUUXJBWDYyL0tuRzNNU3VRS2lwank0S3FjY0JZQ1VXQ0xvNkJn?=
 =?utf-8?B?SDU1d0QwS0lzZ1hiYnBJa1h3WmkzRTZ3T2c3NnJRK0VJVzRKdUJYQmlNK09u?=
 =?utf-8?B?dUVCQXZ0aVhlaFpwK3ovelNGVzkwZnk0VU9KVmRRYVdvb0NUV1lzV245WmFE?=
 =?utf-8?B?ZmxlYXAvZ3ZFN0FTdHEzWTF6ZmZnY3FiTkFLNmREVXJYdStNSFRqK1JheDB6?=
 =?utf-8?B?TnJTeGh5UHFCM1VxZ3h0empwQWNLdnpDZ3l5UG1ManVvUmhhTEN1aStCdmZo?=
 =?utf-8?B?U1lYYnNJbXB3dndFWTVXS1BmeWFTUmI1RkJQMzVBc2RpRGNoY2swbzZaMjJW?=
 =?utf-8?B?WlBUanpNNkR3dE5rNlgrYWdTVHhqN0s4Y1B0djBxWnNIZk5Gdk5qcGM1WWFn?=
 =?utf-8?Q?ftOJG8xQQb+Tblj6IIPl3/KauBv9+zcv4gZJHqxe8I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F118A2D607C6FD4DB789E4CB904F9972@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4316fc53-e45c-4164-78f5-08dce308ebc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 17:37:43.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMMFuvlJfndmHYMh2ko80gkALmFNyUW9/UKdWfVMBmjv7nWlZMMUuyifAB++PSwmJ/iNf12twaQqQqFswjHIxHg0XBRKAAWn6u4wqSyaKXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7628

T24gV2VkLCAyMDI0LTEwLTAyIGF0IDEyOjU0ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOgo+IE9u
IDAyLjEwLjI0IDEyOjQwLCBUb2JpYXMgU2NoYWZmbmVyIHdyb3RlOgo+ID4gSGkgYWxsLAo+ID4g
Cj4gPiBUaGlzIGludHJvZHVjZXMgSVJRIHBpcGVsaW5pbmcgZm9yIFJJU0MtViBpbnRvIERvdmV0
YWlsLiBUaGUKPiA+IHBhdGNoZXMKPiA+IGFyZSBvbiB0b3Agb2YgdjYuMTEtZG92ZXRhaWwtcmVi
YXNlLiBGZWVsIGZyZWUgdG8gYXNrIGZvciBvdGhlcgo+ID4gdGFyZ2V0cwo+ID4gaWYgbmVlZGVk
Lgo+ID4gCj4gPiBJIHRob3VnaHQgYWJvdXQgc3BsaXR0aW5nIHRoZSBwYXRjaCB1cCBpbnRvIHNt
YWxsZXIgcGFydHMsIGJ1dAo+ID4gZGVjaWRlZAo+ID4gdG8gc3RpY2sgdG8gdGhlIHN0cnVjdHVy
ZSBvZiB0aGUgYW5hbG9nb3VzIHBhdGNoZXMgb2YgdGhlIG90aGVyCj4gPiBhcmNoaXRlY3R1cmVz
LiBNYXliZSB0aGlzIHdpbGwgbWFrZSB0aGUgcmViYXNpbmcgcHJvY2VzcyBlYXNpZXIuCj4gPiAK
PiA+IFRlc3Rpbmcgd2FzIGRvbmUgaW4gUUVNVSB3aXRoIElSUSBwaXBlbGluZSB0b3J0dXJlIHRl
c3RzLCBib3RoIHdpdGgKPiA+IGFuZAo+ID4gd2l0aG91dCBTTVAgZW5hYmxlZC4KPiA+IAo+ID4g
TG9va2luZyBmb3J3YXJkIHRvIHlvdXIgZmVlZGJhY2suCj4gPiAKPiAKPiBDb29sIHN0dWZmIQo+
IAo+IEFscmVhZHkgY2hlY2tlZCB3aGF0IGlzIG5vdyBzdGlsbCBtaXNzaW5nIHRvIGdldCBFVkwg
aXRzZWxmIHJ1bm5pbmc/CgpUaGF0J3MgdGhlIHVsdGltYXRlIGdvYWwuIEkgdGhpbmsgdGhlIHBp
cGVsaW5pbmcgY29yZSBpcyB0aGUgaGFyZGVzdApudXQuIFRoZSBEb3ZldGFpbCBjb3JlIHdpbGwg
YmUgdGhlIG5leHQgc3RlcC4gRm9yIEVWTCB0aGVyZSBpcyBub3QgdGhhdAptdWNoIGFyY2ggc3Bl
Y2lmaWMgc3R1ZmYuIEJ1dCBJIHdpbGwgaGF2ZSB0byBjaGVjayBmb3IgZHJpdmVycyB0aGF0Cmhh
dmUgdG8gYmUgcGF0Y2hlZC4KCkJlc3QsClRvYmkKCj4gCj4gSmFuCj4gCj4gPiBUb2JpYXMgU2No
YWZmbmVyICgyKToKPiA+IMKgIGNsb2Nrc291cmNlL3RpbWVyLXJpc2N2OiBpcnFfcGlwZWxpbmU6
IGVuYWJsZSBwaXBlbGluZWQgY2xvY2sKPiA+IGV2ZW50cwo+ID4gwqAgUklTQ1Y6wqAgaXJxX3Bp
cGVsaW5lOiBhZGQgSVJRIHBpcGVsaW5lIGNvcmUKPiA+IAo+ID4gwqBhcmNoL3Jpc2N2L0tjb25m
aWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAg
MSArCj4gPiDCoGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vaXJxX3BpcGVsaW5lLmjCoMKgwqDCoMKg
IHwgMTQzCj4gPiArKysrKysrKysrKysrKysrKysrKysKPiA+IMKgYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9pcnFmbGFncy5owqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzNSArKystLQo+ID4gwqBhcmNo
L3Jpc2N2L2luY2x1ZGUvYXNtL21tdV9jb250ZXh0LmjCoMKgwqDCoMKgwqAgfMKgwqAgNSArCj4g
PiDCoGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vc3lzY2FsbC5owqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgNiArCj4gPiDCoGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaMKgwqDC
oMKgwqDCoCB8wqAgMTcgKystCj4gPiDCoGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArCj4gPiDCoGFyY2gvcmlzY3Yva2Vy
bmVsL2lycV9waXBlbGluZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI2ICsrKysKPiA+IMKg
YXJjaC9yaXNjdi9rZXJuZWwvc21wLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgOTMgKysrKysrKysrKysrKy0KPiA+IMKgYXJjaC9yaXNjdi9rZXJuZWwvc21wYm9v
dC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKy0KPiA+IMKgYXJjaC9y
aXNjdi9rZXJuZWwvdHJhcHMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDg4ICsrKysrKysrKysrKy0KPiA+IMKgYXJjaC9yaXNjdi9tbS9mYXVsdC5jwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA4MyArKysrKysrKysrLS0KPiA+IMKg
ZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1yaXNjdi5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAx
MSArLQo+ID4gwqBkcml2ZXJzL2lycWNoaXAvaXJxLXJpc2N2LWFwbGljLWRpcmVjdC5jwqDCoCB8
wqDCoCAzICstCj4gPiDCoGRyaXZlcnMvaXJxY2hpcC9pcnEtcmlzY3YtYXBsaWMtbXNpLmPCoMKg
wqDCoMKgIHzCoMKgIDMgKy0KPiA+IMKgZHJpdmVycy9pcnFjaGlwL2lycS1yaXNjdi1pbXNpYy1w
bGF0Zm9ybS5jIHzCoMKgIDMgKy0KPiA+IMKgZHJpdmVycy9pcnFjaGlwL2lycS1yaXNjdi1pbnRj
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsKPiA+IMKgZHJpdmVycy9pcnFjaGlwL2ly
cS1zaWZpdmUtcGxpYy5jwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDMgKy0KPiA+IMKgMTggZmls
ZXMgY2hhbmdlZCwgNDc4IGluc2VydGlvbnMoKyksIDQ3IGRlbGV0aW9ucygtKQo+ID4gwqBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9pcnFfcGlwZWxpbmUuaAo+ID4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9rZXJuZWwvaXJxX3BpcGVsaW5lLmMKPiA+
IAo+IAoK

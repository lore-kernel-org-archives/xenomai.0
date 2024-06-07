Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8D1940B1
	for <xenomai@lists.linux.dev>; Fri,  7 Jun 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767682; cv=fail; b=IworNpwzyfwVCB6NpZ/Zu6w+HfeC/Pt1da+epbHTUn4+2KK5gBPdGCvKS3AkvTnbx/gSNsK4BenjQV+mZGlSz1LbPhi1lND0Eb15AeALJ5cCVmJzFQlcJa8CjsmtFk31FSb5CU9hLgUXpHHQHTDyQRG3e2Zyc4H+7yJymBxOFtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767682; c=relaxed/simple;
	bh=Exczbob/30+6VOlnkxbG1nMeDUk1PVLuRFFke0b3ueA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s36A9Ze34SqRS3XFazilOcsJXmPzJasTQcCIKcWNnyEzDfwPm0uZo1o1eBJzjHPf4W4Qd6Y1C9bpHe9HDIMory2Qorn1aLLNw4QCzR49Un4QFFRLita0aleHu+WkmSVzYqBdm+i/IpCseAK5M8uqBZwk/opgH0ZyRpTPRaHlUBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sJOv05Bx; arc=fail smtp.client-ip=40.107.7.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sJOv05Bx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyQkfqfGFIve5hfxnrVNhSKZJizorA99l65dNbMyRTI7jpH7jyx8ahLjUkaQmDnoPkqUQc1TL7NhQzr7EhNJChwy38ebVqH/zo0BelLAOoJKA6Sg2GXRPc74tcTr5QJ9nRRm6OJLr57rMVIyzAAivNdjEPXQT7w9GPfpeEUDB2dWhnM96KUo/Hy2vvlurABVTgKJWUH+L+WrzUrQP+Ubio1JyszIRwMvfnAzsw/AYpmFXXhPyvX3XRQ9qraDSX6gK/CnrpwbG7YHJEEndaR2DSHxOKBjJgEzADxkkdn567G+Hijx9iVYITSL0iR3ISG/OaEzP4xFnaf43nXiZBSCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Exczbob/30+6VOlnkxbG1nMeDUk1PVLuRFFke0b3ueA=;
 b=YwumeLCl01lvcBpUqVsxlm8GAaMzFI5r2whJavqHqkorF9kllf5m3oEgF3Ry4AR1GzHV0lZcIEmk7FsWAHPk5vgkOMkp2cmMOA6pToMcs9ew3Bzd6zELNoRTPA8y8Nue9WV7PQX9oO5YhbXM61rtyfw2G7XGvEmyVYnVFF9ElCmdSPQqRXwj8xfR1slRvYM7X+Uzmbe7JRCNMggR3KXFf6b+jJ3Naueh9Q1Zotpujmyyvrn2C8CPUbZa+MTMwS6rnTIhkxMBqTMxH9snpw5vS5M2TYF4fIuLZ7GLALWoOKLDBv+2JutfFM34DyMq0/6aJXqXLG2IMssgmnAoFnqopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Exczbob/30+6VOlnkxbG1nMeDUk1PVLuRFFke0b3ueA=;
 b=sJOv05BxhN6DLodtV2RRxdUIE3D3r4IeOjNCV54n+AYo3TP3mW4CkmkrV6oOIgOH0lrpJag5b6LO/iCCVG92OET1CosFBiMe1+nmcFAx8ldVLdf7JbbRcL1V5MGlguOy6sojF5plWiwCY753gzjqVwGKLkbbFSqPRJqmLxLTj7bKA+caLOGzQCaNhyKqSSJy3L73nU4a/qwocBQOTTCVo/lg40goNlFf/5iGJBWIxumM37qLAYPsUQZBBaZNswcOvC7yAssAAMIHcrAvN6Cez0n20Vw5wet6TU58eXoeZUZF7NYUFOyYsTmy/gnpzsMlWlFC8z12jDD1eBA32iMmRg==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 7 Jun
 2024 13:41:15 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::184c:3bea:5551:1c43%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 13:41:15 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Subject: RE: [PATCH 5/5] driver/gpio: Take timestamp according to used clock
Thread-Topic: [PATCH 5/5] driver/gpio: Take timestamp according to used clock
Thread-Index: AQHaj9yG2NfLUhxGjEi5zYHD0zbVbrGiIReAgBp96RA=
Date: Fri, 7 Jun 2024 13:41:15 +0000
Message-ID:
 <AS5PR10MB8173309C83758C3F67E2730093FB2@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
 <20240416085911.62073-6-clara.kowalsky@siemens.com>
 <8545b508-27d7-4e47-b981-6814bd56da89@siemens.com>
In-Reply-To: <8545b508-27d7-4e47-b981-6814bd56da89@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=e8d622d8-3722-430e-ad9a-1253be621994;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-06-07T13:34:03Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|DU0PR10MB5266:EE_
x-ms-office365-filtering-correlation-id: 6ce6b572-c53d-46b8-1245-08dc86f780f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZXdadHp2V3FUOVJJL2xhZjkwQUdYclZQNk13OXhUM2V0NXVlSGh4cWNaUUNB?=
 =?utf-8?B?WVBmVmwvZTJ2UE5NUlBtanFPOEx2UXFtR3dXSlF1RVR5L2t2VGpUNzFraEJr?=
 =?utf-8?B?SjdqRlFpbVFZOUtxOTVFVjFkekJBMnc4MlBqOHBKenMvTmdXckVlNis2Uyt5?=
 =?utf-8?B?TllvSUpCbHE5UFAzOERiMlJxMzg3ck5BTGxTam5TcWJMS3JWcnhUZkJKZ081?=
 =?utf-8?B?RWRUK0JpZ1g1blE2b1M3VlRtYTVKQ0tHN3k0Zk9GT2grKzFPZlk2MkZMczlB?=
 =?utf-8?B?S1pYZytSeWZDQ0RhZzF6YkJLV0J3WHZ3am53SEJOWmlSbFEwaWc1THFwUXdk?=
 =?utf-8?B?Sjh6Z0I0YjA3WHhNTDJIbWpjcHpIQlB5ZGsxTXdoVmRjd2UrK2lLQzVObkZ4?=
 =?utf-8?B?V3R5d1JIYjFJS2FnU2hTKzJKMXIvTEcwR3NMZENpbTdJVSs0cmxEMk52NnZ0?=
 =?utf-8?B?dGlTT2VkMmFTWjI2UkloTFdsMHFWK1NBTUgyQktuNkp6aklvamlwRWhoMXlL?=
 =?utf-8?B?aFkveWdJSGRJVjN1NGZVNkgzdFhTZnA2RzY4ZUc5b1pvd01vcHd2L2RDTjFK?=
 =?utf-8?B?WStQWWFNMUlnUkFGdzVJL3VVMlVvMnFlc21iVmx2cDJDZ3FjQUZ2azNmUVFQ?=
 =?utf-8?B?c2RqNC9QWU40Zm9xR3pMUmJmbTA5blltcE1EQy9ZeTU2VmFxbkhpR24zdTJs?=
 =?utf-8?B?UkViT29rNGduWGFOdGQvZytsbW95c0lLWlF4WXh3N0RFM0RDSng0L293MXdh?=
 =?utf-8?B?TG1zVGFkeWxJcHVvT1N2aGNBeE9NbmNPMDU2MkV6dnpHb1M1Wi8wUXl1a3Q4?=
 =?utf-8?B?YzJ4VEVJY1BDQzNESUUvRWlkN2NHZHdXbk1scW1XbjBGMTFOZXJEbVpHUzF6?=
 =?utf-8?B?NGQrSUs1b2VaVWF6SFRSNkdmT0hGNE56SnBOa0dseUtpZ0VEbzcyLzdIbGlI?=
 =?utf-8?B?MjYwQzRRSzM2VTBxbytJb2dwbWg3OTBwckZIbExUZFova3Z4LzRuNG9yRk9H?=
 =?utf-8?B?eWV3REQvbXBHem95UlR4bTByREtsSkF4WTc3T3d4cmZnT1psWm5ZUlFzNTNC?=
 =?utf-8?B?SnRrMkR2UFU0TUJ3eUhhTVorRGtYZ0Z1aUJpS1ZUUGhrSWQ3N3ZXcmZacnNW?=
 =?utf-8?B?T2RNTkw1Z3hqTmZTOGZvbEVqakdiZU9vMzIxNUVWR0JieUFBZmxQWFFCdndP?=
 =?utf-8?B?b1BvTnVBZXhVL21aM2FHSW1pTjllbHpHaEJRZ3NhQ01GbzBWSVhmbWwzUVpU?=
 =?utf-8?B?QlE4ZVV6NFhoNkIrMlM3QlZCVXVFZnBqU1pQOWdBWU5tZi9ZVWZjL3NYUFM2?=
 =?utf-8?B?SkFHRWs5TTkrM0NZbGcrN1oxU09XNDhpenRwVzliMjJkVkJoak9aR1d5UGY2?=
 =?utf-8?B?TUVVTWxrZDNXZ3E3WEoyMEg1M3hiVXRLdWg4MzE3V1krZlgxWmJ3REFZbVJv?=
 =?utf-8?B?VnJjVEdpSHJUNUI4TXdNWXpEYVlFYTVjVHMveHhyZE5HVHI5TjhxNEx3SHY0?=
 =?utf-8?B?OCtiS1VRaXlRRzhkamdzVnQ5WEtyalJsRkFYN2JWa1hxVjQ3YWhrNHBuMG8x?=
 =?utf-8?B?T2R0enBmakhBRzRTSEZwbExnbWpXb0lnV3MySHhIVVhHMDU1aEQ4M21TWHBk?=
 =?utf-8?B?VFpTVTZqTE54SUNWL0o1RTN4U29zd3pydHFkWGQxaUhuTzBqZWtGZFFxTldm?=
 =?utf-8?B?OGw3VTFMUm1ta2ZVTERzcURwRU1CTmEyUkE1bFRabHp0VmFrdGE1NHRMWTk4?=
 =?utf-8?B?Q1prLzV5dVE4R2JSM0diT2hzLzB1bnVidlVtc0R4cWdvc0g0aytlc1lZUjRE?=
 =?utf-8?Q?eXYaNl3xgrNvn5x2MEI2YbcOUFUiJ24VD1D2E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1lENThHeDhpZUF0cVZ3MUY3a1MwRklNamFBbGtjYkVlQWtubEFoWGk4ckdx?=
 =?utf-8?B?aGtiUnVUS1luWGYyc3dZNkJnSS96enQ4ZGQ5NUtJTVU3UkRyUUo5L3BaWVB5?=
 =?utf-8?B?TE5TZ2xaNysyQzBIbTlzWmx3aE9wdWlJQXF2cHIweXRZa0s3NG8wOGJzWnlh?=
 =?utf-8?B?OTNtWDBwUE81K3hFREl0dDZMdGJqdkE4M292ZVhZdzM1cHpDdVBFdlNZTkdC?=
 =?utf-8?B?VnFDUDBuTlR5VnJzTXdXV0I2U3FWU3JRdEoxenpKaVRUaWpLKzZGSkkzZ3FU?=
 =?utf-8?B?NFBYNzlhZDAxdm54ME85N29yZGxIUmxaemxsb3Vmb2Izc05DOHFPblpaUXJW?=
 =?utf-8?B?Z2JDRzZidTNoaFR3VVVSamx6U0VzYlM2dy9HSFpDOG85a0Y4ZDlVWHhzQXNX?=
 =?utf-8?B?alR2TXZRdkh2Wi9XR2pQR3R4STZXR2VMd2FxYzVkODYrWU1rUEhndGhoU05U?=
 =?utf-8?B?T1pzeUxKSFZ5dEtiM3NZN2Q2VjRrTTQ2d2JNeWlNNmRVUEVLVEQ0V3orWURX?=
 =?utf-8?B?Sm5Tci8wUWZ3QlJ4OEdNRUo1T0w4VVIrbUlwY0xGa0p0NXBpNXd0SnRuTjhz?=
 =?utf-8?B?UTQ2ZXhLTzRZcUxDNGNrV29YZms4cGNJdlZEL04raFlsenRUQjVFQ0laeTd1?=
 =?utf-8?B?aW4rWGNZVEVFMiszN3Ercm4vT2IzOC9jakZaZzRsNTFsNHBoVDg3cnhBNTYy?=
 =?utf-8?B?cTdmRVJHeVp5YjBsMzVXOVNWckZkUHhsMUxPR1Q3aXBjaCtqcmtibytENW13?=
 =?utf-8?B?cS9OYzA0NTJOWmJOQ1BEdEZkUWcvSCtZeUtuZFhjZEtidEcwR2NYUnRpVEN5?=
 =?utf-8?B?VTAySnptdXhyMWdpN0NHemU3T2lLVDllRE0xS3NNMGJ6TmJuY2kvcTNnRTV3?=
 =?utf-8?B?djNNbGJPRFhpeFZVa3NRWWZvWGZqeTVNU3d4dXo2UmVSNzhxemJJT3d6b3hO?=
 =?utf-8?B?UUYxSGVMQ0RrNTJQREVhRjNTRzAwRkhoeXRFcDJneEdVTm5KSHJQM3lPUmNQ?=
 =?utf-8?B?K2JYT3dORU5zR0IrRFZPRk5iYWorcEkrTGdlTnM0eGdTM1pJNjRGUnRsZ1c2?=
 =?utf-8?B?c050S0FsaVhXZW1jK1A5dy9jTWxXM2dLR0pKbWp3MmRGK1RnYmd2YmpTazlV?=
 =?utf-8?B?MzQrT3c5SVFBNWxEK0x3VlhIZG5NZklxZUNBNFRpbmNSaG9RMXRpK0NXVmZy?=
 =?utf-8?B?aU1SWWpwQVAxZUc2d2p5M256cDU4eWFrQ0tFZ3A5WGppRDU4bzB0cjhvODRT?=
 =?utf-8?B?UmJWUUQxQVVjMk9ya1U2Y1hRbVFIbEF3bWpGRi8rVi8ySTgwYTZKN1RxaG5j?=
 =?utf-8?B?M2FXQlBDUzdLMmFsWVBVWEpvTGJFaXdFRmQ0M3h2Z2E4L2VSckh5cTVnN3NV?=
 =?utf-8?B?M1VvMEZrN1ZiRXFoVjdQeUcrQzR1NGtQWklXU0grZWVidUlwbFJaTVhEa2p5?=
 =?utf-8?B?SzlVZkduN0xyYlMzM3FZQnBxSjRHV0F3cmIzSzMwbEQ5Unc1anF3ZTJCUnQ3?=
 =?utf-8?B?dVpWc2QvYlJ3R0FpV0V6dDU1NEltdnd5M0tyUUpQU3RjZ2FhVkRNbElzZHFQ?=
 =?utf-8?B?akJCSzJwa0dhSUxGdFQyMkU5M0RnMjRkZTRwaVlsZWRVWXFOeVV1NnhYcU5m?=
 =?utf-8?B?RGEwbDJyYmJyMW5LYjZUeHg4SVhaSUlZeHdDc21pZmlqZWZHeTBxWEZML2xU?=
 =?utf-8?B?MlZ3bTVNWGMxdi9CbVVDL256T2Z3WWVsWlZwUnU2V3J1bnpmamNyazJEejF4?=
 =?utf-8?B?STIzUjI3MTJsWWJYOCt6emo5YWt1ZmFQZDhNb2xuV2pJT1lIOHJJT0paaTd1?=
 =?utf-8?B?d0NMOUY0ZnVwZzNTbnljMTZVUG9taHh6YSs4a05VYnVNT3FySFJabU1VaVFr?=
 =?utf-8?B?WG5KMURyWHFGQzMxTDRxc2pmNnFQWVU0UlBkb2hRQVVndGpJQ0M3bFQvai80?=
 =?utf-8?B?WU1TTUNaUG8vSlJJZGNXUGg0WDFhWSthYzdyd2ZUMmlha09SaVZTZUxnbUoz?=
 =?utf-8?B?V0xhQ1JwcDNiMGxTSlpSSjZSMGVHYlNESUtGRTNOT0tPVVc0K2Z1VkhTWVI3?=
 =?utf-8?B?YVdOKy9Jd3N4WmZIVk5jbXhnUnJqSjlzNHJIZ0ppVHNHb1JKeU5aQ1lqNkJL?=
 =?utf-8?Q?zXL87WD4d2+vQbJDU7lrnC52V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce6b572-c53d-46b8-1245-08dc86f780f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 13:41:15.8114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqrwwKk2Jq8AXdFgoJJ9Bw7pIAvFK196bvtjD1/e0slOdVR7PhS5vsUYaYmZacRa+iS0l1sRcYB4/nHqNc7j+JANZ9epJtK8Vgj4M7Z/0mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5266

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2lzemthLCBKYW4gKFQg
Q0VEKSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogRGllbnN0YWcsIDIxLiBNYWkg
MjAyNCAxOTowMQ0KPiBUbzogS293YWxza3ksIENsYXJhIChUIENFRCBPRVMtREUpIDxjbGFyYS5r
b3dhbHNreUBzaWVtZW5zLmNvbT47DQo+IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+IENjOiBC
ZXpkZWthLCBGbG9yaWFuIChUIENFRCBPRVMtREUpIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS81XSBkcml2ZXIvZ3BpbzogVGFrZSB0aW1lc3Rh
bXAgYWNjb3JkaW5nIHRvIHVzZWQgY2xvY2sNCj4gDQo+IE9uIDE2LjA0LjI0IDEwOjU5LCBDbGFy
YSBLb3dhbHNreSB3cm90ZToNCj4gPiBUaGUgbG9nIG9mIHRoZSBsb29wYmFjayBkZXZpY2Ugc2hv
d3MgdGhhdCB0aGVyZSBhcmUgcHJvYmxlbXMgaW4gdGhlDQo+ID4gY2xvY2sgcmVhZGluZyBhbmQg
dGhlcmVmb3JlIGluIHRoZSBkaWZmIGNhbGN1bGF0aW9uIG9mIHRoZSB0aW1lc3RhbXBzOg0KPiA+
DQo+ID4gLS0tLXJ0IHRhc2ssIGdwaW8gbG9vcCwgdGVzdCBydW4tLS0tDQo+ID4gaW5kZXg6IDAs
IGlubmVyX2RpZmY6ICAgICAgIDEyLCBvdXRlcl9kaWZmOiAgICAgICAyNQ0KPiA+IGluZGV4OiAx
LCBpbm5lcl9kaWZmOiAxODQ0Njc0NDA3MzY5OTU2OCwgb3V0ZXJfZGlmZjogICAgICAgIDkNCj4g
PiBpbmRleDogMiwgaW5uZXJfZGlmZjogICAgICAgIDUsIG91dGVyX2RpZmY6ICAgICAgIDEzDQo+
ID4gaW5kZXg6IDMsIGlubmVyX2RpZmY6IDE4NDQ2NzQ0MDczNjk5NTQzLCBvdXRlcl9kaWZmOiAg
ICAgICAgOA0KPiA+IGluZGV4OiA0LCBpbm5lcl9kaWZmOiAgICAgICAgNCwgb3V0ZXJfZGlmZjog
ICAgICAgMTINCj4gPiBpbmRleDogNSwgaW5uZXJfZGlmZjogMTg0NDY3NDQwNzM2OTk1NTMsIG91
dGVyX2RpZmY6ICAgICAgICA4DQo+ID4NCj4gPiBJbm5lcl9kaWZmLCB0aGUgZGlmZmVyZW5jZSBi
ZXR3ZWVuIGdwaW9fd3JpdGUgKHdyaXRlIHRpbWUpIGFuZA0KPiA+IHJkby50aW1lc3RhbXAgKHJl
YWQgdGltZSksIHNob3VsZCBhbHdheXMgYmUgcG9zaXRpdmUuIEhvd2V2ZXIsIGFzIHRoZQ0KPiA+
IHNlbGVjdGVkIGNsb2NrIChtb25vdG9uaWMgb3IgcmVhbHRpbWUpIGlzIG5vdCBjb3JyZWN0bHkg
dXNlZCBmb3INCj4gPiBkZXRlcm1pbmluZyByZG8udGltZXN0YW1wLCB0aGUgY2FzZSBvY2N1cnMg
dGhhdCByZG8udGltZXN0YW1wIGlzDQo+ID4gc21hbGxlciB0aGFuIGdwaW9fd3JpdGUsIHJlc3Vs
dGluZyBpbiBhIG5lZ2F0aXZlIGRpZmZlcmVuY2UgYW5kIGluIGFuIG92ZXJmbG93Lg0KPiA+DQo+
ID4gVG8gZml4IHRoaXMsIHRoZSByZG8udGltZXN0YW1wIGlzIGNvcnJlY3RseSByZWFkIGZyb20g
c2VsZWN0ZWQgY2xvY2ssDQo+ID4gZWl0aGVyIG1vbm90b25pYyBvciByZWFsdGltZSBjbG9jay4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENsYXJhIEtvd2Fsc2t5IDxjbGFyYS5rb3dhbHNreUBz
aWVtZW5zLmNvbT4NCj4gPiAtLS0NCj4gPiAga2VybmVsL2RyaXZlcnMvZ3Bpby9ncGlvLWNvcmUu
YyB8IDUgKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvZHJpdmVycy9ncGlvL2dwaW8t
Y29yZS5jDQo+ID4gYi9rZXJuZWwvZHJpdmVycy9ncGlvL2dwaW8tY29yZS5jIGluZGV4IGU0MWM2
NDA1MC4uOGFiOWFlNDNlIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9kcml2ZXJzL2dwaW8vZ3Bp
by1jb3JlLmMNCj4gPiArKysgYi9rZXJuZWwvZHJpdmVycy9ncGlvL2dwaW8tY29yZS5jDQo+ID4g
QEAgLTIzMyw4ICsyMzMsOSBAQCBzdGF0aWMgc3NpemVfdCBncGlvX3Bpbl9yZWFkX3J0KHN0cnVj
dCBydGRtX2ZkICpmZCwNCj4gPiAgCQkJcmV0ID0gcnRkbV9ldmVudF93YWl0KCZwaW4tPmV2ZW50
KTsNCj4gPiAgCQkJaWYgKHJldCkNCj4gPiAgCQkJCXJldHVybiByZXQ7DQo+ID4gLQkJCXJkby50
aW1lc3RhbXAgPSBwaW4tPnRpbWVzdGFtcDsNCj4gPiAtCQl9IGVsc2UgaWYgKHBpbi0+bW9ub3Rv
bmljX3RpbWVzdGFtcCkgew0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJaWYgKHBpbi0+bW9ub3Rv
bmljX3RpbWVzdGFtcCkgew0KPiA+ICAJCQlyZG8udGltZXN0YW1wID0gcnRkbV9jbG9ja19yZWFk
X21vbm90b25pYygpOw0KPiA+ICAJCX0gZWxzZSB7DQo+ID4gIAkJCXJkby50aW1lc3RhbXAgPSBy
dGRtX2Nsb2NrX3JlYWQoKTsNCj4gDQo+IFRoaXMgbG9va3Mgd3JvbmcuIENhbiB5b3UgZXhwbGFp
biB3aHkgZ3Bpb19waW5faW50ZXJydXB0IGFuZA0KPiBydGRtX2dwaW9jaGlwX3Bvc3RfZXZlbnQg
c2VsZWN0IHRoZSB3cm9uZyBjbG9jaz8gT3IgZG8gd2UgcmF0aGVyIHNlZSBzb21lDQo+IG92ZXJm
bG93IGhlcmUgc28gdGhhdCBwaW4tPnRpbWVzdGFtcCBoZXJlIGlzIG5vIGxvbmdlciBpbiBzeW5j
IHdpdGggaXRzDQo+IHNhbXBsaW5nIGluIHRob3NlIHdha2luZyBmdW5jdGlvbnM/DQoNCkkgaGFk
IGEgbG9vayBhdCB0aGlzIGFnYWluIGFuZCBub3csIGFsbW9zdCAyIG1vbnRocyBhZnRlciB0aGUg
bGFzdCB0ZXN0IHJ1biwgSSBhbSBub3QgYWJsZSB0byByZXByb2R1Y2UgdGhpcyB0aW1lc3RhbXAg
ZXJyb3IuIFBlcmhhcHMgSSBtYWRlIGFuIGFwcGxpY2F0aW9uIGVycm9yIGJhY2sgdGhlbi4gVGhl
IHRpbWVzdGFtcHMgYXJlIGNvcnJlY3RseSByZWFkLCBhbmQgdGhlIGRpZmZzIGFyZSBwb3NpdGl2
ZSBhbmQgbG9naWMuIEkgY2hlY2tlZCBpdCwgcnRkbV9ncGlvY2hpcF9wb3N0X2V2ZW50IHVzZXMg
dGhlIGNvcnJlY3QgY2xvY2suIEkgYW0gdGhlcmVmb3JlIGRyb3BwaW5nIHRoaXMgY29tbWl0Lg0K
PiANCj4gSmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+IExpbnV4IEV4
cGVydCBDZW50ZXINCg0K

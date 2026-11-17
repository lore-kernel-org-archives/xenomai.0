Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794949943;
	b=fBcFMuNl49LRrC5hW79UsJTEb+VLAAKo0QHMACyBLAyVB9CWT2iQAlheZFCDSzN2rDXw
	 zNabLIKnojrUKfmR+5lHAsDE2EuFA7CSe9DjsEC7FgDFU4c80L2ArVfUqYvylX3ysyoEE
	 zzP04ckNzp02utgNTxkZ5BQqIUkLvi84Yv/OYFRmr3W4MgKDx/FOOwEoUedK2onoTr1vG
	 QxaTkwgv/uJOooDvUELf9tl9z++46q5kOEbPxHcPQN+cxQMQTixJIcOA6N6CT1VdmLpI3
	 E8BkvVACwBUBThL2MFMLv0ddAHR/H8V12yDV6ZroLU2ITwVfJtOjDP3HWb6nZyU7QpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949943;
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
	bh=LoJan22B/89qmzwHSnCYi0ne69SN7fDdErvdjaorB4A=;
	b=VhW4tFgkpyUaSjg0mU5sjn7enf5N1kjKjuPVydxBZupA6LVKpx9kcqePMrXATls5ao5/
	 RQ02npMKiAaAbHQJsW4XaaYYYN/IEiNfTcc6mqb6PzcvgodA2D3qdwujR7QS3swjwZ0iQ
	 golJcw9eZPTtFUetNE6yLlUmB3/IJQbP1WVf0bIxTfxN5mPiQi/nVmmC+G/fzMHJHcBKp
	 q1/Cu7FGptj+1krHKiS5vcuVeSejZukUDwBiyKKf6VxZE6f9Uhg5fmvNWK93l55zEjNF7
	 d6jQu/vvb/IHW3b5aSSkJ0wpey+xs15GovijnYlBEP9Pfsav63yMkjKjEeBJH65CG6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=d14RS+x2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.37
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899FD606A31C
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 21:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=d14RS+x2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcTNtk5CDDh8mfQoazXIUE6sOibrjbiceWh4p60rUu+Rx+U3FCD1fpW+WJtTDvUYodsDIyC/HnyacOJ2IvpCJ9o+XsxVpTGVfwLQKuepd8+nm/tQwyFpao0phXVppunda/sv8G6M8bZzXWVsyaioHT25eWRVPg2AGg35gTHVZUmN+TWEJCZjOKW5Wkfiohb+/ePu6IIbf2WVCeW/28gNni3V86dv1Wa5CQjDqK86QGvQzjDqK+U6VJSZyIviKn54LTE9Zv+2rERveZ5e0d16Ah82r2V0xD+k7vhFqa6pET2BA4p14t1hOC/cTTqU1DmFjlTG4JUamOiYpcP14rbMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoJan22B/89qmzwHSnCYi0ne69SN7fDdErvdjaorB4A=;
 b=CA2A+fgNTXcQ9N/wULGhmFi276T0D0UUebwCIKEzLJonraDKCUUr01zkfQAfxv+b6Z0ga2tfAEMrCm4d7u0HF0mwLBBN1lNHsA1vk1cxeyIGkVIXkMX1NHB4vp2BABhNPXVKRGr/EAUJsOXF5RcvQJ0IeiuGpw/YI0b/RV4zzrUl8dU4yI0vMXbzM0fehMZyN/XifTSDttdAYXvq70lPpdczI7AohwnayYfjJdIUiRbk1JO3XAfRvR01W75qgvchsDjNopCjbKNfuHrCvQRa/vU4UQdX0wHSDVkzQvepUe/okV3VV2jxRr4sUEYZG/luBjfW2D1YKIfBofA0VaHz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoJan22B/89qmzwHSnCYi0ne69SN7fDdErvdjaorB4A=;
 b=d14RS+x2nd/Fe03TIiyjpUbGcjjtlQ7s6hWQKskPXHVlfAwHCBt4HQWVIkJH0WgOQBRfjXw8Cz9H8Hp4woduuJAt6JOGuHmS21hKCPHhm3D56SBg2f8MbAjfO1iWSBOt/2zgX0Cc7sioybWB0FYP+tPZq8uUVfHOgynCd87mi6QsBoYYu2Uj33vad849+rwg82Q6g2xuKr7h53zKEZzZiM/8iSFj9/+QDXECwmqhpXSIne0GwD/kVLcZpMhjllv0rPhJZk5pCxo/Bp+s98F4lBKmXcbQVh7Da2yJNu7eot61xcVEvH1REAyiTJd15VjSxOCP6/XDrNV7WpQGxC23IA==
Received: from DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49c::5)
 by GV4PR10MB308964.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 21:12:18 +0000
Received: from DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aed8:db10:ff00:63db]) by DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::aed8:db10:ff00:63db%5]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 21:12:18 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "rpm@xenomai.org" <rpm@xenomai.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [PATCH dovetail 4/5] riscv: dovetail: keep hard irqs off for page
 faults handled out-of-band
Thread-Topic: [PATCH dovetail 4/5] riscv: dovetail: keep hard irqs off for
 page faults handled out-of-band
Thread-Index: AQHddpCssB2G75uGW0CIJgQEsVkum7cypVsAgAAeKwA=
Date: Tue, 17 Nov 2026 21:12:18 +0000
Message-ID: <2d17cfe9747a8f98da78fb6fbca52908577b538e.camel@siemens.com>
References: <20261117123925.597027-1-tobias.schaffner@siemens.com>
		 <20261117123925.597027-5-tobias.schaffner@siemens.com>
	 <3b8d95a887bd9740e8ea877e0ac276d6588fc87f.camel@siemens.com>
In-Reply-To: <3b8d95a887bd9740e8ea877e0ac276d6588fc87f.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.62.1 (3.62.1-1.fc45) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR10MB7766:EE_|GV4PR10MB308964:EE_
x-ms-office365-filtering-correlation-id: dc3f3e6b-d971-49c6-a050-08df44ef7673
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261022105027099003|38070700021|4143699003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|10067099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Gbvvx+9fUeuB+FOYx96HCLGrI0NWp9W+9IcVf4zrxBR6EwTfexWeqIwHq//mxggt38nZIVsqA37dMG7p7sxocKqA+/pWjzV6cOUfm4l6odagFsDEmKgcZ1bSdyGTNLi5HbcEsp3WF42Rg0Rl+TDrsgC7IQ+O9TDLkQrMWuzwUp6gI4xDBlRY5FFVRguo+0CIkF3RIJbR8zBLCO4ButiDYiZtStb0B96Cs8JrfrTsaCbLOJm0/5X+IMrIKbCNYQH5GTMrhAwKvWz2RfRuqpKlFQtcoWtWtrMQxqsFpmv0kBwhlBN98lLjH3/ghDhfse76bpNUY09yRRvNaGcw0Da4b9nh3PT7aC2E+utkZlzjd5PLBhFl/iJqtp0yGdsftpK+R1/XWYK6sr3dvC24OBrC4+/4ejBncF5L+CNzD04y7xuMpjCePkPST6VbSGg/hHGlEDkMBJz+vcgX1MSGp3NJLcnhrF7v79YnwVxLVe7rfc7qzuqwKB5HRPmIl5xKLMOoJ9v8pg2cvWsHm1COXb4a43J/5RUoh28bSqpRFixLU+phLAPRTLbXuu0pH4myLVWYNvLIYqBrMz4zUXj/NYk8vSFaeAATI3iuXOaJMbJLddmFvGNYk0IkFyAitDu73/ofg3UFcInGdysOVeZ1KGA7/9ZGn7Hrh8CWquf5O3I2cB/qL32YObuN0YUfPPE4Too8Co2PLs8Ni5jDzz4G8RtFXakp/o+gMypdZXL/UgC6paw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR10MB7766.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261022105027099003)(38070700021)(4143699003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzBzVlRaTjBmVDJjUXNJRjBuZnpUTklaZjBqRGhjYzE2TlBaVnk0bTM4Y2dS?=
 =?utf-8?B?S0ZLTldibUhZcGIzRUZnRzh6S3VwWEQ5SnNJV3ZZSVJpekNzc2xZSmc1RytT?=
 =?utf-8?B?bHdrOXVCdUo0MW92TjFRNkppRGxmbVlhYVBSMnFKS0k1Tno4V1ZCMEVjalRX?=
 =?utf-8?B?TTRVSC9MTTNhbmZaL0s2RGs5S21uWmIxNERyRkVVeStnSHpBQitjMUQvNTdC?=
 =?utf-8?B?TVRkUXZIejRGTUxXL21VNEVZY3RXVC9LVVQvVklvVzJiV3p4YUxZSHY0NkFF?=
 =?utf-8?B?QkJpQUpKa00xRXduemZnbGJHU0lXazhyQXovT1ZxakhWVkoreFo4d241c1RX?=
 =?utf-8?B?a0JkUGRVN05zVzFCdjd5Q0RVeDVFV3R4NU5zMWRaYlBIRDlmZ2NwZnRhbDl4?=
 =?utf-8?B?WVhSYmE0b25GUnVHSzNxYWdKeW5qQXhOMjNWczVaZFl1cmFNTldTbisvM1pN?=
 =?utf-8?B?VE4zOUFyV2FLS0RrcDBXcVFZYUZFMmMwZlIzU21MYjhIVytoTkV5ZmlrYTkr?=
 =?utf-8?B?K1J2TDlHV211WHA1UlFNdGo3RkZtZnFTRXI1cWkxTmprOERGZlVDTTF0MTJW?=
 =?utf-8?B?KzBBZ0RTQ1J4LzhOOVRYZ1p2MFcrVHBqMFhvelBGY2V1SXJpUUdJSm5ZaEZp?=
 =?utf-8?B?TkI1cjl1Umd6UCtMbkl4TzhUWjlxc0RYS0pDbE0rS3MwUDVEV3N6MUpGRGV1?=
 =?utf-8?B?U1lvMFFUU0hKZnNJTFBITmNNRE0wdWVuZmRlZUZRNUluYWhXTUpaeU93SDg4?=
 =?utf-8?B?ZGhKNkpucXV3S2pRZUFKR3JraTVzNnROTGRlbXFwT2Q3MkpkaDY2SDc2cjd6?=
 =?utf-8?B?ZFFPZ1R0bmlydDlQTzJuenRwUWNOc2piQ1dqWXV3blpocWxTVGhwM25hc3pS?=
 =?utf-8?B?SldEZEpad01WWjFrV1FBYUFiNkRqSktxbWZGcEo5aEF5clZBU1B5QythdzIy?=
 =?utf-8?B?Ym1UL2x4ZWFBTFNPbEx2NUFEMnNpOXo0bFp6S2pxQW1SSEl0cDZtUUhLTTYw?=
 =?utf-8?B?dmJHR01RZHFBYlBrU1ZzK2NveWFPMGhtVzVYdDNEZlhMZFptTnFqNG14cU9Q?=
 =?utf-8?B?QlJrcy9Sa1VBM2NUaEQydHVVdlBPT2NqTlBQY1dkeFJyRFJmVHg3Ylh6ZE1u?=
 =?utf-8?B?QW5YN1N3N0dJR0c2VDNKQ3lRYzlxa2lqYVpHa3NQMmI2SG1TWm1QUkRkU0VK?=
 =?utf-8?B?dTdENUtnVFVXWTJBQVgxSHF2b2QxNVVwRkx0OHN1OEJJNU8zMXp0WE9heHBE?=
 =?utf-8?B?RFE0RTZXQTRnKzNQb1RCVnRZRHdxTDRjS20wYkZ3WFJ4V3JYSDI5bnVENys2?=
 =?utf-8?B?YjBRNWd0SGRzdW5hTG1TWmYzWVg1MllCYVRNUDE3YnBmdEpreFFlbXR0QXZp?=
 =?utf-8?B?YTArclFObkhKN1ViK2pXa2IwK00zTGpMMS9HMyt6NHl6T00ybC9SUGtpaWZu?=
 =?utf-8?B?OTFrMkYxemJHQlFNcG1iUTBhMWpHajlXSHVIMldnOUR5OHpwZ0J0MGJnYW5H?=
 =?utf-8?B?bjN0VkhDdjM4bk1VRGR3T0h4ZFFjVUdMOS9SNTl5cXFVNmFFVXh0WXZWYVJv?=
 =?utf-8?B?M2RPbVYwdkJ2c2RpdkNWWE5pTlYwNHovWEY1aEljZW10SkkvaVpLcm84MzdS?=
 =?utf-8?B?Wkh2U2NkREFkbnlvL0lQbzhmbkxISTVaQVVMK2VXT2Z1NWdOWlNyTnhtQmdu?=
 =?utf-8?B?SFk2L2FGSEpIdVRsK2M0RzRIL1BHcUluT1VwMlQ0NmYzMnZwTFBKUm16L3Bv?=
 =?utf-8?B?NDJ0dlp4TzhWd3g5VmVhdlJ3U2xwUVYvOTFlSVRxVUF5dUVWM0dYYVVKclZ3?=
 =?utf-8?B?Yy9Wa2w2N2ExY1owU3JZa3YyOUFJdHFaa25lUlNiMGttOU9oK2M0SnlZVHFB?=
 =?utf-8?B?OTEwOC9UcTA2T3ZnSGFJaGFmUU9VeXpNMXJZM0VNanNWeFRoanBKR3dJWnFD?=
 =?utf-8?B?UlF5eWtsMGJ1SlZWeXM1Z0l0c2NtQzRMM2l4QlQxM2tJTHcrSmgyb09QQThv?=
 =?utf-8?B?QmMzZUVkRkpraTVJV1lSRlhSdmNxUWgySWd5M0FOYWtJSHh4YTR5WWRFYWtr?=
 =?utf-8?B?bkI2OWViVWd1WUJDSFQ4UkZPQ1R4eTFPaHFxS2w1S0RpdWFuOWJPbkYydU02?=
 =?utf-8?B?ZFhtU01CRTBLWGVCcHJtdWhvYXMrY0tBTzhDWW54Z2p2U29YNHdkRjBiTDMy?=
 =?utf-8?B?RWxPU3RQcmI5N3A5U29peG9wRUtkeXZzKzlZOVpHQVl2Wm5mamVtUENCSGFi?=
 =?utf-8?B?MnZwOGFjRDhIU2JDMXdWaXluWS9xOHlQWUdxcnBFQm5BaU83cDZFcERvcEdm?=
 =?utf-8?B?OTVCSlpvbXY4Ly91Y2E2b1c3WVhVNnRlUDRrOXNQQW5GWmhDZVd5UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A745EADAD63324281FF3B537F2EFC3F@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3f3e6b-d971-49c6-a050-08df44ef7673
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 21:12:18.4538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsAV7jR/jK705nIvmf1oEVNvxzXgAkc6JuqFN4yE+u0Z36PT0NIUQc1tWcwhfjtmwYIHiN1deypPjVYigziLsnyP8dlBQYKw9bFXhozHh0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR10MB308964

T24gVHVlLCAyMDI2LTExLTE3IGF0IDIwOjI0ICswMTAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
Cj4gT24gVHVlLCAyMDI2LTExLTE3IGF0IDEzOjM5ICswMTAwLCBUb2JpYXMgU2NoYWZmbmVyIHdy
b3RlOgo+ID4gZG9fcGFnZV9mYXVsdCgpIGVuYWJsZXMgaGFyZCBpcnFzIGZvciBrZXJuZWwgbW9k
ZSBmYXVsdHMgd2hldGhlciB0aGUKPiA+IGNvbXBhbmlvbiBjb3JlIGRlbW90ZWQgdGhlIGN1cnJl
bnQgY29udGV4dCBvciBub3QuIEEga2VybmVsIG1vZGUgZmF1bHQKPiA+IHRoZSBjb3JlIGxlYXZl
cyBvdXQtb2YtYmFuZCwgZS5nLiBhIGZhdWx0aW5nIGtwcm9iZSBmZXRjaCBhcmd1bWVudCB3aXRo
aW4KPiA+IGEga2VybmVsIHRyYXAsIHRoZW4gcnVucyB0aGUgZmF1bHQgaGFuZGxlciBvdmVyIHRo
ZSBvdXQtb2YtYmFuZCBzdGFnZQo+ID4gd2l0aCBoYXJkIGlycXMgb24sIHdoZXJlIGFuIG91dC1v
Zi1iYW5kIGludGVycnVwdCBtYXkgcmVzY2hlZHVsZSBpbiB0aGUKPiA+IG1pZGRsZSBvZiB0aGUg
b3V0ZXIgdHJhcC4gV2l0aCBDT05GSUdfREVCVUdfRE9WRVRBSUwsIHRoZSBCVUdfT04oKQo+ID4g
Y2hlY2tpbmcgZm9yIGEgZGVtb3Rpb24gZmlyZXMgaW5zdGVhZC4KPiA+IAo+ID4gVG9nZ2xlIGhh
cmQgaXJxcyBhbmQgdGhlIGluLWJhbmQgc3RhbGwgb25seSBpZiB0aGUgY29yZSBkZW1vdGVkIHVz
LCBhbmQKPiA+IGtlZXAgdGhlIGRlYnVnIGNoZWNrIGZvciB1c2VyIG1vZGUgZmF1bHRzLgo+ID4g
Cj4gPiBGaXhlczogMWQxZmRlY2NlY2VmICgicmlzY3Y6IGRvdmV0YWlsOiBhZGQgY29yZSBzdXBw
b3J0IikKPiA+IFNpZ25lZC1vZmYtYnk6IFRvYmlhcyBTY2hhZmZuZXIgPHRvYmlhcy5zY2hhZmZu
ZXJAc2llbWVucy5jb20+Cj4gPiAtLS0KPiA+ICBhcmNoL3Jpc2N2L2tlcm5lbC90cmFwcy5jIHwg
MTcgKysrKysrKysrKystLS0tLS0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgNiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVs
L3RyYXBzLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC90cmFwcy5jCj4gPiBpbmRleCBkZGRiMzA3MTE0
NDAuLjlmOGRjNmJkN2I4NSAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL3RyYXBz
LmMKPiA+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL3RyYXBzLmMKPiA+IEBAIC00ODksMjEgKzQ4
OSwyNiBAQCBhc21saW5rYWdlIF9fdmlzaWJsZSBfX3RyYXBfc2VjdGlvbiB2b2lkIGRvX3RyYXBf
c29mdHdhcmVfY2hlY2soc3RydWN0IHB0X3JlZ3MgKgo+ID4gIGFzbWxpbmthZ2UgX192aXNpYmxl
IG5vaW5zdHIgdm9pZCBkb19wYWdlX2ZhdWx0KHN0cnVjdCBwdF9yZWdzICpyZWdzKQo+ID4gIHsK
PiA+ICAJaXJxZW50cnlfc3RhdGVfdCBzdGF0ZSA9IGlycWVudHJ5X2VudGVyKHJlZ3MpOwo+ID4g
Kwlib29sIGluYmFuZCA9IG1hcmtfdHJhcF9lbnRyeShyZWdzKTsKPiA+ICAKPiA+IC0JbWFya190
cmFwX2VudHJ5KHJlZ3MpOwo+ID4gLQo+ID4gLQlCVUdfT04oZG92ZXRhaWxfZGVidWcoKSAmJiAh
cnVubmluZ19pbmJhbmQoKSk7Cj4gPiArCS8qCj4gPiArCSAqIERvdmV0YWlsOiBhIGtlcm5lbCBt
b2RlIGZhdWx0IHRoZSBjb3JlIGRpZCBub3QgZGVtb3RlIGZvciwgZS5nLgo+ID4gKwkgKiBhIGZh
dWx0aW5nIGtwcm9iZSBmZXRjaCB3aXRoaW4gYSBrZXJuZWwgdHJhcCwgaXMgaGFuZGxlZCBvdmVy
Cj4gPiArCSAqIHRoZSBvdXQtb2YtYmFuZCBzdGFnZSB3aXRoIGhhcmQgaXJxcyBvZmYuCj4gPiAr
CSAqLwo+ID4gKwlCVUdfT04oZG92ZXRhaWxfZGVidWcoKSAmJiAhaW5iYW5kICYmIHVzZXJfbW9k
ZShyZWdzKSk7Cj4gPiAgCj4gPiAtCWlmICghdXNlcl9tb2RlKHJlZ3MpKQo+ID4gKwlpZiAoIXVz
ZXJfbW9kZShyZWdzKSAmJiBpbmJhbmQpCj4gPiAgCQloYXJkX2NvbmRfbG9jYWxfaXJxX2VuYWJs
ZSgpOwo+IAo+IEhhbmRsZSB3aXRoIGNhcmUsIGp1c3QgYSAzMCBzZWMgc2NhbjoKPiAKPiBUaGF0
IG9uZSBsb29rcyBzdHJhbmdlLiAhdXNlcl9tb2RlKCkgbWVhbnMgZmF1bHQgb3ZlciBrZXJuZWwg
Y29kZS4gQnV0Cj4gd2hhdCBpZiB0aGUgaGFyZCBJUlFzIGFyZSBkaXNhYmxlZCBpbiB0aGUgcGFy
ZW50IGNvbnRleHQ/Cj4gCj4gV2UgY2FuIG9ubHkgKHVuY29uZGl0aW9uYWxseSkgZW5hYmxlL2Rp
c2FibGUgKGhhcmQpIElSUXMgb3ZlciB1c2VyCj4gY29udGV4dC4KPiAKPiBTZWVtcyB0aGF0IHdh
cyBhbHJlYWR5IHdyb25nIGR1cmluZyBmaXJzdCByaXNjdiBpbnRlZ3JhdGlvbi4gT3I6IFdyb25n
Cj4gQVBJPyBfc2F2ZSgpIF9yZXN0b3JlKCk/CgpFdmVuIG1vcmUgY29uZnVzZWQgb24gYSBzZWNv
bmQgZ2xhbmNlOiBUaGF0IGlzIGFscmVhZHkgaGFuZGxlZCBpbnNpZGUKbWFya190cmFwX2VudHJ5
KCksIGp1c3Qgd2l0aG91dCB0aGUgIXVzZXJfbW9kZSgpIGNoZWNrLCB3aGljaCBtYWtlcyB0aGlz
CmEgZHVwbGljYXRlIC0gZm9yIHRoZSAhdXNlcl9tb2RlKCkgY2FzZS4gCgo+IAo+ID4gIAo+ID4g
IAloYW5kbGVfcGFnZV9mYXVsdChyZWdzLCBzdGF0ZSk7Cj4gPiAgCj4gPiAtCWxvY2FsX2lycV9k
aXNhYmxlKCk7Cj4gPiArCWlmIChpbmJhbmQpCj4gPiArCQlsb2NhbF9pcnFfZGlzYWJsZSgpOwo+
IAo+IFRoYXQgd2FzIGNsZWFybHkgYSBidWcuCj4gCj4gPiAgCj4gPiAgCW1hcmtfdHJhcF9leGl0
KHJlZ3MpOwo+ID4gIAo+ID4gLQlpZiAoIXVzZXJfbW9kZShyZWdzKSkKPiA+ICsJaWYgKCF1c2Vy
X21vZGUocmVncykgJiYgaW5iYW5kKQo+ID4gIAkJaGFyZF9jb25kX2xvY2FsX2lycV9kaXNhYmxl
KCk7Cj4gCj4gTW9zdCBsaWtlbHkgdGhlIHNhbWUgZm9sbG93IHVwIHByb2JsZW0uCj4gCj4gPiAg
Cj4gPiAgCWlycWVudHJ5X2V4aXQocmVncywgc3RhdGUpOwo+ID4gLS0gCj4gPiAyLjUzLjAK

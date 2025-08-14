Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81016258CFF
	for <xenomai@lists.linux.dev>; Thu, 14 Aug 2025 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755138605; cv=fail; b=bIwIUKFl3rRcrfUyI+Q2WoNP5ZwLXX562/IBaFSby5pVNHyvsH7D50Qv27B4IPFxsxgEaau5Dh9jBumHQiAlQ0r6E0mMZDGsJAs7chmea70s9Nhz/akNc5+jpbygcP6kahVTwTxvRjA7VD/2zYfIosl8Z1icak45r2AVx/8Ae00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755138605; c=relaxed/simple;
	bh=DOJRr3Sykvz+4g0cBKMOIAByyncf/y37KXkWpydmyBU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZwUuyN4ddF7l05jQyGslClCoZclcdANRMBeMaxSBT/tTY5tQ2QGR2oi7lxd4uFlFwygcoNGTMfwQuipykE0j44bPS/nkbUwpoykHKvGv4GPuMo0ihezPRcOcxVaRTyK2M/vqDFPnI7Upz9r5JIkLLFfUcailQhvBjnuBjgzOzsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=qZUK04FV; arc=fail smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="qZUK04FV"
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 6C63041C3E
	for <xenomai@lists.linux.dev>; Thu, 14 Aug 2025 02:30:00 +0000 (UTC)
Received: from SEVP216CU002.outbound.protection.outlook.com (mail-koreacentralazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::5])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 9511E940D20
	for <xenomai@xenomai.org>; Thu, 14 Aug 2025 02:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUCOH49jkfttNayoNEnj01JSi0vBNWKsPeOZ0M5ym2UhIOI+4ARO+g71aVLxvbAgIbMdHcBwGi6V4HOwQroV+GNFRqriULvCGbnFVJUX3Bqx1LrCp34YjPg5ALpze834CGL2tytZeW8zJF9ext/BGwo0wKNpr13wy+cfFlzRWVYjS/R4rlU+Xu8Tk+dH2GCl4ytcVd28mve4QvoHiwxjUwMV5TKaKSLAieJINMjYIexCDOgcgbiNz6OK2+NB55uVPYAM0QrghydrdZsXJHZu48LgLE1FqQ/VlMDnzRdtWzFgwrcNFTmCgKbnhpLA7SKkMH/zpEm1kgqYQDItypLcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOJRr3Sykvz+4g0cBKMOIAByyncf/y37KXkWpydmyBU=;
 b=Eiu+b2BgdzFCcKkF8jsRnf0hlejRLagGFrNFic1kuz/uHqtVg147WhNMtw7pnbd47D8uRFACDO9qqSout2PiRWt/ePk8FFpV56KmSOx0aqhpq1vR6BAbtCyu0NFOLx1mQ5tAe7RcnpYakmt6EMLyPs4Qpc8Avaj3dOoQw1ffp5IUz4wesDyi6kv/+bGLTGBXXIfUlpL45cZU+O2mqFcqj68kJMSEQQR3UsHLNIkqYVs4FhsaewUHK/MCPsUAmW6fH+wRel5UErUokb9qCbG6aCFh23k31KWP3YMUw2wT/7xsFzZa3724UOymUXO0t3LzfrDQoFV4I06+DrLd5WlCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOJRr3Sykvz+4g0cBKMOIAByyncf/y37KXkWpydmyBU=;
 b=qZUK04FVNVF/Y8YH7ABAyZJVyJIccff/IadXaW2SGtXwkqunuC76B1fR9DcXtwHhNoNP0HNOWPEka+I82ChkWYSVUpdpE3qBMx9BPoTyH8izlnCMKdBkzMcGd0hkMZgrqzTvBA0yFLVby/TS2RyGrMbx4h1ODnOFPIzPL1ZUhmI=
Received: from PU4P216MB1353.KORP216.PROD.OUTLOOK.COM (2603:1096:301:ab::6) by
 PUYP216MB2859.KORP216.PROD.OUTLOOK.COM (2603:1096:301:154::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.17; Thu, 14 Aug 2025 02:29:54 +0000
Received: from PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
 ([fe80::36d7:72e0:f391:d57e]) by PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
 ([fe80::36d7:72e0:f391:d57e%7]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 02:29:54 +0000
From: =?utf-8?B?7Iug66+87LKgKE1pbmNoZW9sIFNoaW4pIOyEoOyehCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <mincheol1.shin@doosan.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Inquiry Regarding Secondary and Primary Mode Behavior in Xenomai
Thread-Topic: Inquiry Regarding Secondary and Primary Mode Behavior in Xenomai
Thread-Index: AdwMw0IyZGQUbLC5QXiRezBmWDiT5w==
Date: Thu, 14 Aug 2025 02:29:54 +0000
Message-ID:
 <PU4P216MB13538930233E2B4F3D7F2EB5A935A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU4P216MB1353:EE_|PUYP216MB2859:EE_
x-ms-office365-filtering-correlation-id: 63ae047b-1952-465d-4d45-08dddada7440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|3613699012|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1FUNk1XUnh1RUZsaEdac09oeExCcCtudE5Va2JFMDVIMjl6dTA1N2J0TDQy?=
 =?utf-8?B?SDdXOGY4azMwbUVGL2pia0ZzSU1CN0w0ZHJrK2k1bmZXQ3hIakdsQ3pEbmxP?=
 =?utf-8?B?RTNPWUpQZ3ZyamNLUmZMcnk4S1Q1VmgwTnZCQUd6NnN3QjgzeGxmUlBlM2ox?=
 =?utf-8?B?VnVYL1p1UmlDdnNpMWs5bk15RWNCVzFrNXFOVGdGN0Z1UkNDTXM3bzc2WVds?=
 =?utf-8?B?d3k2d2VaZ0d5WXJEKzZWVk5SdVVGakgyZlY2Q3JjNjh0M3VIZm1pbEIwSWov?=
 =?utf-8?B?cEJDTnZoekpWSHNMeStZdWxxZWtJQUYrNFAvVEZUOHFUWVk2V1J5bEdJdFNX?=
 =?utf-8?B?dUlBbUFCeldmc04rL3pkckhMR3Y5eVBUUHZQSGFXbXpWZWxiNDh0KzY5Q3B5?=
 =?utf-8?B?V2YzQ1hkK3VyVW11OVgvSmhKdTA1eTVrc3gxYi95Y1kzcHB4QVRXNUpLb25n?=
 =?utf-8?B?Q2dHQmRTT0hMcWFaYzVIOUZFU3c5N1AwVUpqV1JrSXMxZHorOGlLUTE2SXNM?=
 =?utf-8?B?Tnk1YmVNRDRXQnRhTDZud0poVUlkZUdnTEpyTWIwRnUyN1NIRHZCaHVkUDRp?=
 =?utf-8?B?UjM5UE1UaVorU3o3d1NRMWVXdE8wNzZYVXZHQXM3K2pZMVB6ZnhnZ1BBTVFD?=
 =?utf-8?B?TmtYRmw5b3BXeTY1TllQNU9UL0s1dzkxdVJ6U0lnUVU1ZEJxcVJOVy9vcktl?=
 =?utf-8?B?WTY2MkNVM0JPZndMSitTRUZlUk1CRUMvdHU1QTVhQk9Od2s1YUxHNDR6MXhZ?=
 =?utf-8?B?NmlFOHliVXZuUEJUM0prUGQvR2xUWVVVdmthOWhmY1VoUkxSWkRseWh5M1lv?=
 =?utf-8?B?QkFtQjBXbUh5ZTR2S3phQ1E5US9TM0laWVluM1lGMHF4b2FEVG5LRlROVWhx?=
 =?utf-8?B?b1F0U2dXZ2hBNUZzNE5UNjRoZXhVeE9halNlZmJGMmJuclljcEdzZ1VJbWJu?=
 =?utf-8?B?Z1daTXNqQmxJaUxhdWpBMENYTEltS0JibWNpMVZ3N2M3MjRFRmhrK3ZUWlV1?=
 =?utf-8?B?aWc4QlUwUFFBUXhGK2dVV21jbWNkdWV0OSsxMldyMjRtZEtOVTl1ZG80NHNl?=
 =?utf-8?B?OExyWXB3b3VsaWwrWjg4QWR5T1hsSHFYd3k0Wlh5aXYwbkpsZDFRTmpudlJi?=
 =?utf-8?B?ZXFCcEkwZnVqWjFxWDZWeVBsNkt6NmZkYVNIN2w3c2ZtNVpqYTNkbFo3Rm1J?=
 =?utf-8?B?ZmMrWG1iNnNsKzNZN0ltcEI5SDlDdzczTHgyZ0M3YjJtSW9HazBpSGpBV2lM?=
 =?utf-8?B?bERTYms1enBXR1FNbXFpU0ErYmcvRDBVZ29GR3lKVWRmYWVIdW9GdzZWWmlK?=
 =?utf-8?B?azUzWmF1VHJiRVN4WFI0bFdaeEIwZlEyV1VVSTVSem5lQ2Vrdk9OVHZRc2M1?=
 =?utf-8?B?dE1MTVlhL1RVL05BTm9xdVRsZ1lmWTNKMGJoM2xYeDFNSmJvSXlqYms5cVFm?=
 =?utf-8?B?TU5wNzZBQ2Y0UU9VNnJJckhHZTM5TEZFaU1hOTcvaG1YKzdWU3AyVlB2T1RH?=
 =?utf-8?B?VG1jc0dtNFBRSVZ1QkNUWERWTGNaUDEwQ3BtOVprSk4ydnk0RFhnYXZDZG02?=
 =?utf-8?B?L3ZQSGljTjJMa1dYb1h0bVJyWHhSYk1JUHJzVDZmRTNhWXdZL0Y1WlIyemhr?=
 =?utf-8?B?ekdOaVFVaXBkeGF3VXpEcisyK2F4YlVydlFOYW9KZFpwaEdOT2lZSkloa3VW?=
 =?utf-8?B?ek1WYWpkOW1SaHVBTUtaaGxHcGIxSnF2RzJ0SkFwYVh6OVBuN2xINkFsb0dB?=
 =?utf-8?B?dG43Wkg2V3g1TjltMFJhQlByeWRnZHJ3RUtOc2I1RXFVWGRaV2JzSStoYndT?=
 =?utf-8?B?bjJ3cEpRcytiSm5DRng4SEZHSWVaV2xDZEtGVGUrS0N2WEsvOFNjVGVvY2kr?=
 =?utf-8?B?N21PMmFPNEFlWDFpSUZQQk01MkZDcnRleTVBaFlWR3RDMkROQnZuQzV5Y2pG?=
 =?utf-8?Q?lTcw3VIF9rUK2Dpzf7+8BXvocs/kYS1B?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1353.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3613699012)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UitkdktPNVdaQjRCaDRXTms3Nkt6WGExa2hCeVdVWDZreG1TR1JLVEVNSVdv?=
 =?utf-8?B?Q0lWWFlBekh6cG5HNFlvMVBhNzVENFhlVFhYTEZ4ektxbnlZdXpIRnh4Ny9q?=
 =?utf-8?B?MnErdExicmFsUjczVU5oVUZtZmhpZDZrb2hFTkdTQU9kbUJuN2Z0VVByK3k4?=
 =?utf-8?B?MnVwei83NGhOdmdzeDYza3U1bXFGQThRdi8vcENJTm03bitFQmFWSVNVRlYr?=
 =?utf-8?B?YytyOERCbkszeGJ3WlcrZTNENE13Uzc2TmRCYkc0ZUxKYjlQeUZhTGlpU1Nl?=
 =?utf-8?B?eXVhNCs0TnlXMDUzVTQ2K3p6dFRyNGtVS013OUcwWjVKdlNRS2FmNXVScU94?=
 =?utf-8?B?RDZyQy9QUlFaOThBcm52ck1YMnRTUVpwQk8xQVBHRVFPMlg3bjBrbGRMb3c2?=
 =?utf-8?B?Ymp3UE1Sa3ZONm1qRFA2S1V5ZnJWVUhQbnVUbUJmSkR0Qm96eWpiTHhjbkZu?=
 =?utf-8?B?T1RHVXJBam9za1N5RzNkakZIa3lZOTlYM21BM093dUFDQkdHdnJXWUhwUVpo?=
 =?utf-8?B?NXAwQTYwcXMxMG5USmhmVVhraEEyWGw3TDcyNnZmbzVjd2NIRG1zRlZyNnZi?=
 =?utf-8?B?WTZkSENFVmxqcGhSRzNzMmlzdFY2cVZBOW4rVCtuNUVBOVZXMkxRQ0M3SVZp?=
 =?utf-8?B?WEZ4b05pQWEwaG4valRsM05VNXA5Z2tJMXNGdkY2ZGpnSWJDclYzQjdBUTRy?=
 =?utf-8?B?K2VHUzdCQ2ozNmRWNVA4QWZPZW5RM1N6dDRtMzFxaytTK1hKYmpjOGtzZ3FD?=
 =?utf-8?B?dk9hZXBwSjAvdEtuYWFYbWFVbURrTFBQUkdmVEZTVnJhSDJGcWNNdnQvb2oy?=
 =?utf-8?B?ZktPU0RiNjRjL3pSRzdXbjBOeUhIWmJtSkt2U05weXNaQVdJc1hDWGZYOXpw?=
 =?utf-8?B?OXVJcStiMEZhYVRKRkxvaGdIdDVyVkIyTzY2YkQ3QkRqcG83ejFDMzhvYkVN?=
 =?utf-8?B?OU5uQXBudlNmbzRnRWpaMFJlbGMvNDM1T3VYQ2RJOUYxZDVmTFlralVCdHNH?=
 =?utf-8?B?eVhpdWZIbFpDWU1LRTB0U2pGMTFFNUdCTXZkZEowNFlzRjQ5alRVT0FmNUJz?=
 =?utf-8?B?K012SkRMMmRyQ1daQnJ0ZEtoR0FwakxKQlFjNHpzOEFzWmVXcThyeGpFV3hi?=
 =?utf-8?B?UFNtN3RNSU4wb3hKblNvYnZJejFRMGV1WUF2OC9RUUFJZld6Y1hBckFJc1dD?=
 =?utf-8?B?VEZZQnAxa1ZuaHJnMTFsRkx6RXFZWXNOdktNVFlCZ1lkOTU0eUNUR3liZE5O?=
 =?utf-8?B?TkNNQW14VUY4Q1ZsQmxkbC9yNWNueXllTU9kM0YvUEdVV29xUjlPWnNBdFR5?=
 =?utf-8?B?T2FQSGJIcWlmRGFHUUM2MnJpbEl0eEVjYmRnNGJoVjdJLzlmeGtQaGc1eHF3?=
 =?utf-8?B?U2dVL3dtMFJLMnRTZTJRRTJPQUU4QWU3VlFQTWdaVlE4djBRRDhuaEVpL0JE?=
 =?utf-8?B?REluWVJiLytuL01hMERnM1RjYXhLaWpSMnJSQVRiYytJM09NSFB5emIvYS9L?=
 =?utf-8?B?Q3M1QWlaNWhwTzRwM295T0I1bUxrbXhMeHdjY1BjV2UxSjR2MTV4TGV3WFIv?=
 =?utf-8?B?UWJldXRnSUNZL1o3WS9BZmNvVTdlRWRTcCtDVlBndFIxeEFub1JhTzdETm9L?=
 =?utf-8?B?TkdETlkyd1phTVhLdW9JOWxtdkhxTDMwN1EyY2U1cUVIeXcxMFcwcHBFRC8v?=
 =?utf-8?B?R3BjbUxrMHFZSXhhLzVhcHk4THBTVTBqWHRzd0F2U0szL2RzVnVLdUdmaHBw?=
 =?utf-8?B?ZU9PaEhmY2JKTS9ncHJyemoybm43TnM4MUcva3RXZDF5UlJNR0QwamFMdTFH?=
 =?utf-8?B?RlUyNHpIVmU0cU5kbERGMjB6YTg4RFQydTY2cEZ1UUJLaEJ6aStHZCtBeGcw?=
 =?utf-8?B?VmhVS2ZERjdSZU04dStYVnRiSnRKWi94SGFjVEk0d042VnRxM0x3LzhKNHp2?=
 =?utf-8?B?Y25uNlNtd25WR3VSeVprd05iZEE2ZTVFSkpnMXJIL1FkdlVSbndYWnJGMUZ0?=
 =?utf-8?B?WXZvanJiWHBadU53a25lUy9vY1puelZoMEVpRUsxZ3JvUjU0T1RyOE5DbzV5?=
 =?utf-8?B?VnBkdmVZY01adEt4eTBnamdWWk1BRG1ZNWRpVURMTC81Sjh0d1BtNTU0OEhj?=
 =?utf-8?Q?VCR+OTW+cG13zsebeQOt21yzq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: doosan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ae047b-1952-465d-4d45-08dddada7440
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 02:29:54.4201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWUlonVDUSTvsGhF2gL2QfGn9r3mStI5UWvYbyscm2GFrCPesSC8X3DRIkzLw7CEsBHLx8Rk9VDnFEB6WMnACW05/XsPKCNlNyfUqUlS7xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUYP216MB2859
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=doosan.com header.s=selector1 header.b=qZUK04FV;
	dmarc=pass (policy=none) header.from=doosan.com;
	spf=pass (spool.mail.gandi.net: domain of mincheol1.shin@doosan.com designates 2a01:111:f403:c40f::5 as permitted sender) smtp.mailfrom=mincheol1.shin@doosan.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeelkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufhtfffktgfgggesthgstddttddtjeenucfhrhhomhepmjjmmjdlofhinhgthhgvohhlucfuhhhinhdmucjmmjcumjjmmjjmmjjmuceomhhinhgthhgvohhluddrshhhihhnseguohhoshgrnhdrtghomheqnecuggftrfgrthhtvghrnhephfevgfetvefhhfffveeludehvdeiteevtddvhfegkeejtedtgeeuueevudelteeinecuffhomhgrihhnpeguohhoshgrnhhrohgsohhtihgtshdrtghomhenucfkphepvddujedrjedtrddujeekrddvuddtpddviedtfeemuddtleeimeeftddumegrsgemmeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvuddtpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepmhhinhgthhgvohhluddrshhhihhnseguohhoshgrnhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghv

RGVhciBYZW5vbWFpIFRlYW0sDQoNCkZpcnN0IG9mIGFsbCwgSSB3b3VsZCBsaWtlIHRvIGV4cHJl
c3MgbXkgc2luY2VyZSBhcHByZWNpYXRpb24gZm9yIHlvdXIgY29udGludWVkIHN1cHBvcnQuIFRo
YW5rcyB0byB5b3VyIGhlbHBmdWwgcmVzcG9uc2VzLCBJ4oCZdmUgYmVlbiBhYmxlIHRvIHN1Y2Nl
c3NmdWxseSBidWlsZCByZWFsLXRpbWUgcHJvY2Vzc2VzIHVzaW5nIFhlbm9tYWkuIEkgdHJ1bHkg
YXBwcmVjaWF0ZSB5b3VyIGd1aWRhbmNlLg0KDQpXaGlsZSBkZXZlbG9waW5nLCBJ4oCZdmUgZW5j
b3VudGVyZWQgYSBmZXcgcXVlc3Rpb25zIHJlZ2FyZGluZyB0aGUgYmVoYXZpb3Igb2YgU2Vjb25k
YXJ5IGFuZCBQcmltYXJ5IE1vZGVzLCBhbmQgSSB3b3VsZCBiZSBncmF0ZWZ1bCBmb3IgeW91ciBp
bnNpZ2h0cy4NCg0KSWYgYSBtYWluIHByb2Nlc3MgdHJhbnNpdGlvbnMgaW50byBTZWNvbmRhcnkg
TW9kZSwgZG8gYWxsIHRocmVhZHMgY3JlYXRlZCBieSB0aGF0IHByb2Nlc3MgYWxzbyBhdXRvbWF0
aWNhbGx5IHN3aXRjaCB0byBTZWNvbmRhcnkgTW9kZT8NCg0KSW4gY2FzZXMgd2hlcmUgYSBwcm9j
ZXNzIGZyZXF1ZW50bHkgc3dpdGNoZXMgdG8gU2Vjb25kYXJ5IE1vZGUsIGlzIGl0IHBvc3NpYmxl
IGZvciB0aGUgcHJvY2VzcyBhbmQgaXRzIHRocmVhZHMgdG8gbG9zZSByZWFsLXRpbWUgY2hhcmFj
dGVyaXN0aWNzLCBwb3RlbnRpYWxseSBsZWFkaW5nIHRvIGZyZWV6aW5nIG9yIHVuZXhwZWN0ZWQg
ZGVsYXlzPw0KDQpUaGFuayB5b3UgaW4gYWR2YW5jZSBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIHJl
YWQgYW5kIHJlc3BvbmQuIEkgbG9vayBmb3J3YXJkIHRvIHlvdXIgY2xhcmlmaWNhdGlvbi4NCg0K
QmVzdCByZWdhcmRzLA0KTWluY2hlb2wsIFNoaW4NCg0K7ISg7J6ELCBDb250cm9sIEFyY2hpdGVj
dHVyZSAmIEZyYW1ld29yayBUZWFtDQrCoA0KIA0K6rK96riw64+EwqDshLHrgqjsi5zCoOygleye
kOydvOuhnMKgMTU1DQpFbWFpbCA6wqBtaW5jaGVvbDEuc2hpbkBkb29zYW4uY29tDQpNb2JpbGUg
OiAwMTAgNDY5OSAxNzUxDQpXZWIgOiB3d3cuZG9vc2Fucm9ib3RpY3MuY29tDQrCoA0KIA0KICAg
IA0KwqANCg0KwqANCg0KDQo=

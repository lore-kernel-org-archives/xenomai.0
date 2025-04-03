Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DBD1F12EF
	for <xenomai@lists.linux.dev>; Thu,  3 Apr 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675508; cv=fail; b=g1DHvAxv3RJ0wIzZPlVq1g/dFE6SwPW58vvH3961o0fIGXohF/HSRUAd9OtQLPomZhO/emEIc9y0INvve6lHvbgnMtDS7oRXlSicHyk5GVCw6iv8TthIuOQ3kteHv69hJJws9VMNIcaDeS2O4oM7BOOFWQO86YwKp8RV1F1SXME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675508; c=relaxed/simple;
	bh=EHTjQ+MVg0zcle4sDuRux3jfF/zxlqDAK92fyvtQACw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bJFYaoe+1LyUEZSw5mucy0q1yf/OPc5YfElyyM0UpohfT2V+FuqcsyirLPWFM3Xch2+wUdC+/CYOdRtA3wn1CyU4qOYkxBrNXaTyxk9qit4NMq5EMVDCW1YS8QQ/23f2OO4qgslcEQgjRIkY90ROcUhQrlE6w1fT+gHuT1yp/bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aradex.com; spf=none smtp.mailfrom=aradex.com; dkim=pass (1024-bit key) header.d=xedara.onmicrosoft.com header.i=@xedara.onmicrosoft.com header.b=lrlyFYC7; arc=fail smtp.client-ip=40.107.20.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=aradex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xedara.onmicrosoft.com header.i=@xedara.onmicrosoft.com header.b="lrlyFYC7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUotJWNOfSiDyvAhkQoUrww6azTYIhhMSX/xX9bBLTuqG5ed0odCjxITMFhWLJ2gjnphZirfx5abbwpv9kwkeJKOZBa5YMGBewHqcvsLaVuQX2Sw/r7XtU5baeopREf9NSTHtTlxxUYpTAV+tjb7A0G3ytqc5Y7nXhYZcYBhOuz5Lx/4xS21KfpEEb+7U4wrvH8fDTngDal7on7zS3yXa1s53+V68Gz3Fqf5WSQ5s5re+f/HKY+OhfVtMhm7MAaTeeZvcC/baNSc6X3VsXlfH8NEy9SzPrR2eBnpndwnJWDtoVRS1Ok2zNec+smJbVCeeBYqAHhYx7+JXYiWoUhyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHTjQ+MVg0zcle4sDuRux3jfF/zxlqDAK92fyvtQACw=;
 b=F/f3pdoD0TKOVJnnqHOcORTmqA0Sqx76qKHEtuWKv3CSb0dtwPr6WdxhkJvdF5rGXiLHT+FOTSkd17ttOtparKILTlRf8pHhpDpt8mmi29HFqKjFCRr5PWZOaJaFJvYFXWvfT6i51kYBS1vpBjw4LDFq92gENmwkQKWevPPWDjM6TaHIF2b8hgpr1QeW+MG+kYqw+WwNVaq7GpB+NkgTf4L1zAHjPHXFBxItl+L5HRgAsKCFXlC1j4w3geJJBkLyyVyKKs10jaseDA4uV2OiI/gezohEqZXc0kGmNsH0LiuEwJAkJNUbwbDWfi5bTFFcgtIZUPTntuIPfXAR7Sz3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aradex.com; dmarc=pass action=none header.from=aradex.com;
 dkim=pass header.d=aradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xedara.onmicrosoft.com; s=selector1-xedara-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHTjQ+MVg0zcle4sDuRux3jfF/zxlqDAK92fyvtQACw=;
 b=lrlyFYC7t2M5YKvdHmvQx7hr9wETSAbmqEK4PpQzQK4Kcj3C+Yq3LvDUmSmF3xAT1xaKKsW01IhdlZ/e0XfzOkQ2k9/wFqQ3N9dijXMy3qlmILM7+u2sXcZaB9gCIpu6+kbIoCsF0AmTnFfnMmyTIuHBrmFiQklSMvA6SDYQoUE=
Received: from PAVPR02MB9722.eurprd02.prod.outlook.com (2603:10a6:102:318::19)
 by DB9PR02MB10351.eurprd02.prod.outlook.com (2603:10a6:10:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 10:18:22 +0000
Received: from PAVPR02MB9722.eurprd02.prod.outlook.com
 ([fe80::8add:536:c66a:ff46]) by PAVPR02MB9722.eurprd02.prod.outlook.com
 ([fe80::8add:536:c66a:ff46%5]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 10:18:22 +0000
From: =?utf-8?B?TWFya3VzIFdlacOf?= <mweiss@aradex.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: AW: RTAI -> Xenomai4
Thread-Topic: RTAI -> Xenomai4
Thread-Index: Aduj4fkW/83WlgpyTgeAqOze8Iw+PQAj/x/2AANTrIA=
Date: Thu, 3 Apr 2025 10:18:22 +0000
Message-ID:
 <PAVPR02MB97228DF3A8D2DE428AF0EEAEA8AE2@PAVPR02MB9722.eurprd02.prod.outlook.com>
References:
 <PAVPR02MB9722E8F8B700A3E97C5C45D9A8AF2@PAVPR02MB9722.eurprd02.prod.outlook.com>
 <87ldshhcsv.fsf@xenomai.org>
In-Reply-To: <87ldshhcsv.fsf@xenomai.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aradex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR02MB9722:EE_|DB9PR02MB10351:EE_
x-ms-office365-filtering-correlation-id: bf6cb371-9ec7-47de-c73d-08dd7298dce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z0ZLeFgrSDBtZWNkLzEwd0EwYW95OFhJbGhQbStxbi9GQ0U0L3JuZzkyNGlj?=
 =?utf-8?B?clJMbzEveExOU1g3SFBvTDdVd2dEMWQrVEUzOTZPR3Y0RXVXMXd6bEVkQ0dE?=
 =?utf-8?B?RFlMaFhFNG0yQ2JORGJQVGI3d1g2TUw1aThUTmx4UldPb3hjdHcrWEg5L1Bo?=
 =?utf-8?B?ZlBXZWhpWWFZVzVDRVI4RlhCSjFDbTJ6MWhCTGl5d2Y3Vnlhd2NWS1UxTlU0?=
 =?utf-8?B?OUduRkhneHMwcWFGVzFHQ01PUTZsM2w3ZFNIaVZhYU5vVGx1T0FvYTRMdDQ4?=
 =?utf-8?B?THVuWXNNY0RPMW9vbzk2R01GbVVXQ3hpSkdqYjBEU05mV0xoU0srblJDNFB4?=
 =?utf-8?B?RTMrSFdUV0pPc0laYjFKY3F2MVBaajFOeVZCNm5vM3g5U2s2NFpKeGxyZzZG?=
 =?utf-8?B?UDFtOWFDMVcyMDJSaGlXQnB3Mlp2OC80ZTZvdEVsWmljYmwxUlUzUThoUUVF?=
 =?utf-8?B?STZFaUFyVGpTVk1HZm9jVmxsclMyT0UvS3ppUHVxckpNTVJEa3FjNjNCVk9q?=
 =?utf-8?B?TjVERlRmQjI2d1NnNmhXTTBHSGhYMThaLzUxSjdBcXVzSHc1RXN3R0daRDFJ?=
 =?utf-8?B?RjAwd3VoRFZNczBLTHlybW9qek1ZTW5JUTFaR0tlMy9oK1VpT2tpM2R6cDNq?=
 =?utf-8?B?RTk0bVhxYTdQcGdZOGJDbUp6dHkrNEorRG9uQmw0R3MzMjFyUGgwakRGeEZh?=
 =?utf-8?B?bnRiMDczK1UzQkMrS3J1MVZoTDRJbWw5MkQ4QzE3bnBaQ0dhN1IrNzhlTGZT?=
 =?utf-8?B?SmJwVW5uWGE2NFBMem9VV1Q1YytLT2NpWS9oT3BmNFcvSGVteFRCbjNRU2xu?=
 =?utf-8?B?VWx4Z3NpTVNJZit0SnJ3WEY5ZjA0bmwzNnFVVGFuM3VjNFVIV01FNS8rQVov?=
 =?utf-8?B?M0hnQzY4VzZCeS9hWjBhLzBnQy9TSGFKTXhxdHZxUEs3Q0l2THJzdGVBTGda?=
 =?utf-8?B?OUdnZUNWTk5BdkJ0d0dUVFhCU3E0OE15YUowd2lPbEdiUnFHdkpXUWtwd2Vn?=
 =?utf-8?B?MnU3TktrUFBUbGhQYWhuU2ZhQ09nWFA3WTc1NWFhaVBpVmRLNjg4ZmhYcDNY?=
 =?utf-8?B?UlVWWHl5aGpROGZPM0owMzVSQUtNK0d3UFRNSk9EaE5JeFlVb0lsS2Zha1c1?=
 =?utf-8?B?ckQrMVlTT0wvU1BGWjIwYmpaM1RGb1VZaVpuOU16VUNMZEpTZjNWSW9TYUlP?=
 =?utf-8?B?RXM4Mk1HMGtmdE4yVEVYM2M0MC9nUXJERVdlblRFcElwQzc3ZHRwMnlZWWt0?=
 =?utf-8?B?K2JRNzB5VmJBRjk1bXRDeTZROVVYRVZqZTdWUXpXWWxSRTR4RnhHQ1kwekM5?=
 =?utf-8?B?dm9rZ0V1QWNQenZYdUpVZDZ2UmJsZDhKUjVxOHNRNFNrWHRrTjdyb2c4TFBU?=
 =?utf-8?B?NFFYbjlqUFJWbUczRlFjU1ZRRndxK3lrTWxUZ1R2ay9Yc0xKc2s4Yk5kM1lp?=
 =?utf-8?B?T0kyU3ROK2dFdW5JWXBLbCtBVXM5V0dRWU1yVGxxamJNdlJxM0s4b0xsdlpi?=
 =?utf-8?B?aXJxOTlyazQ1RVBRdkllWUNyYjAzaEhMWUFXQVR0MmNUNUR3RVpzY25CZDVD?=
 =?utf-8?B?SUNVQ3d3V09rbFJ4OFcvcHRKcGFacTRGbWI2M3BydzQyTU5hL0tXMnFXNlhG?=
 =?utf-8?B?dUZUV2V1cGFGTkpNcFVSSjdEVFkzWlVlVGpMVEZWdWR1WHYvTU1Bamc3Y2VF?=
 =?utf-8?B?WTZrV3lRUlcvR0xocVNVQVJxNUtRaThvRGphd0hlMWc4MmwyTTQ2cEpGc3li?=
 =?utf-8?B?bEFZNDlSOXpEc25vSjBqUGVFQmtlNzN4VXlIb3A1RkdSWHZCYVVPU1IvQU1p?=
 =?utf-8?B?dGdWVTZVaUEyNmRGMEcwUlg0NTlIWTlrcCtUcTZ2T2pCRjcxTjZzYXh5WHNV?=
 =?utf-8?Q?dhgy2ddWBPR+Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9722.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHg4M2lweXJFNXhmMEFaL2VreUU2bDRvM3gxYTdNMWw0VE9PQm9TY3BrMVlO?=
 =?utf-8?B?bTh0WHcwRWNHcTMvN2pSN2tZMS9iU1VWOVM4UDlGYldkQTFzVXdHY3hEYWs2?=
 =?utf-8?B?TEszNjJBV0E3ZUhEWThnMXVDMi9semcvQ09lWDZYeUF2dVA5KzZxaVExTXRa?=
 =?utf-8?B?Y1FzWERVcWdFUWh0NTR3aFhmcUVERFZ0bXByWXllQm1STkc5NDVRclU5VW0x?=
 =?utf-8?B?dXRDanhuQTVESmZYOVlBd1UrLzhpZ2N2Y2ZPN0REQVEyY1dFME5uMklrNFNP?=
 =?utf-8?B?TUpFdk1Kc2Q3aGFCUm5zckdkeUZvZENFTUFHQ0FlSXJxY216cnMwYWdva2Fw?=
 =?utf-8?B?MGxGa1dWUXkxZ2x3eHY0QWUzR05xMFBFR0R6eStqRnRiZE14cHFjbTgvS0dV?=
 =?utf-8?B?MUFNSWt2R1RnbDFVOW9oWFVNUFV3TDRNeXMvOW82em5FMmFrOTVvMDREMWpw?=
 =?utf-8?B?eGsvY2ZGVEVMellybDRwTG52R2tLbU1lVWc0Z0dnRXErbktXQmx6WnMrTmRJ?=
 =?utf-8?B?V1BvS3ZCY2ZlOUR5WEp2NDhPcnZpOUZkSlVFUUQ4S252U3BlTEJIaDZnN2tq?=
 =?utf-8?B?c1pZMFNacisrNmExYXZ6cWhhYUo3MFpBbHpzenpPYlAzcHVPWTFXMjh1QkJH?=
 =?utf-8?B?clYrK1lFSEVCUFQwclpobUQxM0VOTGZtZ0l4TjltK0p0dlQ3UzZIREVSSGdM?=
 =?utf-8?B?aFJyMTdBSzBOQ0tzblNrM3UzaWhRMUZVU0Y0c2xSeXlqYUNUa1BpcXg0ZWRW?=
 =?utf-8?B?eHRGN01ROEYxQ2s4UDlUeSt6N1FCS3lsRnBsbndWRUJ5bU10RjFINHdPZk9n?=
 =?utf-8?B?azdEdG5GRUNqb1p1UUdTelVNRFI0TFhrN1ZLbk95TUdPNUtwN1NmckFPVXgz?=
 =?utf-8?B?RHZ1d3pqeXgzZnBPNVNwb29IVzA2ZUZuN1BZS0FMK045aUM3RGM2aThvUGFp?=
 =?utf-8?B?VVFIQWZvYzg5a0JMUGRYSjRZTlMzTWVCWmRLeGhaU3RKWE1BQzNIWjFHS1I3?=
 =?utf-8?B?OThsdTEva2J5NzBoN1hCQmY0VjhQbW9aTXJDd2xyQWVrejNMV3FuQ0laeWcr?=
 =?utf-8?B?RGppMVZqL3V6ZjBpTnhWOERCNk5YZG1FUldSblozbUVlZWl5aWNTQXVGa1Nv?=
 =?utf-8?B?OTZ0ekxJb1E3c2hUOFB6d1dpMFZWQnVBQ0tWK1pkbHRySHhRSDdEMHRLUlRm?=
 =?utf-8?B?MUw0MWJNaXd1SURhUXNvWTZML25UWGlrWFdYazJUakV4UzBPM1JqMnNPbytQ?=
 =?utf-8?B?ejdZUkpSTVV4UHVZQXhaWi92UGJQQmc4S3BPcko4NUk3alFjbnIxdFhjOHd3?=
 =?utf-8?B?dkdXeWdqb0tjalg1cmJxS3ViUnBEVzRhU3EvOElQVmZtdVgraG52VGZRWnZL?=
 =?utf-8?B?WGp5OWFlNFVQbFpsaVU4VDZIcDVmT1RGNkNDUGpObzFSOTV6U2h6VFpOUnRq?=
 =?utf-8?B?UDR0NTlSYWNvSnJxSnh0eDVXLzRFWHBjSWVnRFlRS3B1eFIvYk8vWDVIcG1W?=
 =?utf-8?B?bWJlUTlKQ1k2MFUrb1gvaGpNeXMzTW9rMDRiQjRqSVM2YTBjTTh4MVVzS3I3?=
 =?utf-8?B?a0RBdTJWTGtWU0pjUEN2bDNHZ3hwWVoxWkFjQ3lNdXlBWDg0OGpxVklTakMz?=
 =?utf-8?B?bjBDK2I3VFJBZE9oNW1KSVJ2c2lCZHFYeHE3d1V1UGpJVlgzQnRUM2xLNks5?=
 =?utf-8?B?MEtyVW9nanBGaXBzcVp1RXhQZGkvb085RHdEeTI5RDZ3SGpvZm5wcTlvMXZm?=
 =?utf-8?B?VmVscmMxeG9SN3grTlJ0R2xhbzJ1L2UxMVQrdXBuMXY3TDVLNktxZEVkWm9m?=
 =?utf-8?B?RS9TYUUrdTNwUnVPdkNTRXdPZUlNVDNucWY5eXpBZEZhaEo1OUZJYWtHb1Ny?=
 =?utf-8?B?UFdKZ2wrSXJtRnR6Ly9SUjZmYmNCUk1LWnlRa1g5VjUxVWlmb0dCS21JRnBU?=
 =?utf-8?B?ZWxubjh0Z3JESUhEUExyNDhDd0JKMXlVVW95WDhUQndnc08zZnBHbUpZNUF1?=
 =?utf-8?B?cUF2SW9mL0lSQzYxVitBUFBMRDJTbDR5NEZqd1BobGE0SjFwaUpmdVFPcjls?=
 =?utf-8?B?SkZyakxLU2xzeTVzZk5FNEtrcjliTGhKd2s4ZG1QSFR6ajhtbERudE00amdU?=
 =?utf-8?B?dkNFUkg3bzg1bjJnK2tmaHdNK1UvOGdRRHpPb1FIZXNPNS85UHNIanVTUDhO?=
 =?utf-8?Q?/Qvet8PSTkVveftHC22TKf0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: aradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB9722.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6cb371-9ec7-47de-c73d-08dd7298dce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 10:18:22.2466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e76e219-d340-4c18-a5f1-2dacf99e6e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /upDCW591aTq8LOf/LzWn86p+E33xJ20ue/8MfdjeYwuRznTZJDlpBZDQBdpsWDWkmqdhaVbh808wLum+xsOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB10351

UGhpbGlwcGUsDQoNCkZpcnN0IG9mIGFsbCB0aGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHJl
c3BvbnNlLg0KDQo+IE15IFJUQUkga25vd2xlZGdlIGlzIGEgYml0IHJ1c3R5IHRoZXNlIGRheXMs
IGJ1dCBJIHNlZW0gdG8gcmVtZW1iZXIgdGhhdA0KPiBQYW9sbyBpbXBsZW1lbnRlZCB0aGUgcnBj
XyogY2FsbHMgeW91IG1lbnRpb25lZCBpbiByZW1pbmlzY2VuY2Ugb2YgUU5YJ3MNCj4gUlBDIEFQ
SSwgc28gdW5sZXNzIEknbSBvZmYgYmFzZSwgdGhpcyBzaG91bGQgYmUgYmFzaWNhbGx5IGEgbWVz
c2FnZS1wYXNzaW5nDQo+IGludGVyZmFjZSwgd2l0aCBhIHN5bmNocm9ub3VzIG1vZGUgZm9yIHRo
ZSBzZW5kZXIgdG8gd2FpdCBmb3IgYSByZXBseS4NCg0KWWVzLCBkdXJpbmcgbXkgcmVzZWFyY2gg
b24gSVBDIG1lY2hhbmlzbXMgdGhhdCBjYW4gcmVwbGFjZSBpb2N0bCgpIHRvIGEga2VybmVsDQpt
b2R1bGUgSSBhbHNvIGNhbWUgYWNyb3NzIHRoZSBRTlggUlBDIEFQSS4gVGhleSBib3RoIHNlZW0g
dG8gYmUgdmVyeSBzaW1pbGFyLg0KUlRBSSBycGMgd2FzIGVhc2lseSBhdmFpbGFibGUgYW5kIHR1
cm5lZCBvdXQgdG8gd29yayBuaWNlbHkgaW4gYSBxdWljayB0ZXN0Lg0KDQpGb3IgdGhlIHJlc3Qg
b2YgeW91ciBtZXNzYWdlIGl0IHN1cmVseSBoZWxwcyB0byBnZXQgYW4gaWRlYSBvbiBob3cgdG8g
cHJvY2VlZC4NCkkgbWlnaHQgY29tZSBiYWNrIHdpdGggc29tZSBtb3JlIHF1ZXN0aW9ucy4NCg0K
TWl0IGZyZXVuZGxpY2hlbiBHcsO8w59lbiBJIFdpdGggYmVzdCByZWdhcmRzIEkg56Wd5aW9IQ0K
DQpNYXJrdXMgV2Vpw58NCg0KU29mdHdhcmVlbnR3aWNrbHVuZyDigJMgU29mdHdhcmUgRGV2ZWxv
cG1lbnQNCg0KQVJBREVYIEFHDQpaaWVnZWx3YWxkc3RyYXNzZSAzDQo3MzU0NyBMb3JjaCwgR2Vy
bWFueQ0KUGhvbmUgKzQ5IDcxNzIgOTEgODEgMA0KRmF4ICs0OSA3MTcyIDkxIDgxIDkxDQoNClJl
Z2lzdGVyZ2VyaWNodCAvIENvbXBhbnkgcmVnaXN0ZXI6IFVsbSBIUkIgNzAxODI4DQpWb3JzdMOk
bmRlIC8gZXhlY3V0aXZlIG1hbmFnZW1lbnQ6IERyLiBTdGVmYW4gSGVsbGZlbGQgKFZvcnNpdHpl
bmRlciAvIENoYWlybWFuKSwgSmkgWmhhbmcNCkF1ZnNpY2h0c3JhdHN2b3JzaXR6IC8gQ2hhaXJt
YW4gb2YgdGhlIFN1cGVydmlzb3J5IEJvYXJkOiBZaW5nYm8gV2FuDQp3d3cuYXJhZGV4LmRlwqAg
fMKgIGluZm9AYXJhZGV4LmNvbcKgIHzCoCBodHRwczovL3d3dy5saW5rZWRpbi5jb20vY29tcGFu
eS9hcmFkZXgtYWfCoCB8IGh0dHBzOi8vd3d3LmFyYWRleC5kZS9kYXRlbnNjaHV0emVya2xhZXJ1
bmcvDQoNCg0K

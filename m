Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECB18CBE0
	for <xenomai@lists.linux.dev>; Tue, 10 Sep 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972412; cv=fail; b=WoRruGCKuvbR5oLSxHfEfyYeLBLwD7qV/2gR6Sh5cNzr2CP8f7ixjw+whc9rHCArhDpizUn3R+YyEEiSELBWRorft/qyHlVF+XUnLMGjFqKhF82VC7eVOCyF3NyQxcBfguUmvqYHJr0OoWbyl7c/jr2SvoGKzmi6G2CJKX+2CnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972412; c=relaxed/simple;
	bh=1o5KpIl97zTEHtRVbs2W+z9TsKj/UdBP9V54FYZAha8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JnqxzlY4/MtpTpCMPJwL9tDwal+ZBTcuqaw61vT3aNxO8J6BFviHayZMRR+r8UdJBNI55XnASCOPKMoKm7DG9aNUyNzcVmQrdvUktHpLE6S5R+Wd/2z5Uzz02R5eGzGwxbU196snjuVSViHlOeabap8Pzo8tmp/+kzOw2ANdd8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com; spf=pass smtp.mailfrom=fareco.fayat.com; dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b=l1ZWEkI6; arc=fail smtp.client-ip=40.107.249.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b="l1ZWEkI6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsLsy0w3lcAy9j8MHNThqFBV+vgE/S6Ul5p4xwS03adPey7wno8DSD08iLImtSTKkZEvZd82FaCnmT40qiwEEi0hTQm9y9Cfyuu747NYdXuH9jgPmt+QQlw+s746sV1NW8N4o4zAAe0fxfEOSC583pm087M8AbKihxTdVZKQli/cpWmIElLHhwO5boJPqyRH15ug2sn+/nCU8Gq7tyKZv4LiKJCY9wLVwq1dv6llBWdo7E6tLTKzgJPkOuzH3EtvJHEEdS9fS683QImNzxcf7X6EK6xqk4DYljbE98wJbxelfm/RdlN3ZrweBzRcEuM7cbADvmiRXTqso4Y12t8voQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o5KpIl97zTEHtRVbs2W+z9TsKj/UdBP9V54FYZAha8=;
 b=mNd113xVVjQx0nVQVyT48U3Y0mfal8nfQgVgDTe41ZJSHaI9kVUco4c3X95Tyy0m7iiHqW8pxjfBjAd8QHFguqWu50WVSXaHrzI+nmr91GMeQ0/7mpHkeRYXYAo1pytlVRLYYubtj2H/lOc0gNirpF8bUIIXAVdcVuKFaEyuuOk0+JD7yJnYL744+D2rH2pdaxQ8KjzWQ3t73HMflNPJiabWeSzbItT+oAWJFMT6EbvsA/Qa3+BeV64fXQ3ThNOkyqkwlwCMrLSpJTANrEs0vFbqCTouwRpUNIbz40jGWAxVLqhO5oKW/92Laf4ZHwY2zWYxgv2H3EXl9HabkZN8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fareco.fayat.com; dmarc=pass action=none
 header.from=fareco.fayat.com; dkim=pass header.d=fareco.fayat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fareco.fayat.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o5KpIl97zTEHtRVbs2W+z9TsKj/UdBP9V54FYZAha8=;
 b=l1ZWEkI6U4aE2TFwmw2pKvGPoDVqqk3fcy32tBZL37uG9xLrx+aC2Iqg9VGZTYPnN2+L9LG64lgXzHuN3imRKckA8GlhFnUD8NmKR3NIiBTEzB6GjVKdgqCNm0YB3iO77x7+HglP4YOgTj28e+kMJ/6+UmRguYfcpw/t0bdsKY9oRvG1epWZf9pXhRG2s3iJdjxz2nsQfGDvvamIHivGWEMrpx0r24ANySaBRWKci3TpQDc/l51dAx7yW7ARFsGzw135uaoLdcilioKP+7z1YWlk1EBI7HPIxyiBZlkVpfXaWI5ozkgNXzVOSJq0+8PI+83M6CYhWX/wstAmisq2TA==
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com (2603:10a6:20b:a4::24)
 by DUZPR05MB11023.eurprd05.prod.outlook.com (2603:10a6:10:4da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 12:46:47 +0000
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e]) by AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e%6]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 12:46:46 +0000
From: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Compilation error kernel Xenomai3 for x86 32 bits
Thread-Topic: Compilation error kernel Xenomai3 for x86 32 bits
Thread-Index: AdsCu/A5CIPDzd4nRhuPtAIfDI6JiQABM2kAAAGsaqAACs3ygAAiOqJw
Date: Tue, 10 Sep 2024 12:46:46 +0000
Message-ID:
 <AM6PR05MB60248187776E0975A0D64FBBAD9A2@AM6PR05MB6024.eurprd05.prod.outlook.com>
References:
 <AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
 <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <f8bdb69f-b500-4a5d-9739-90cb1a1a88d8@siemens.com>
In-Reply-To: <f8bdb69f-b500-4a5d-9739-90cb1a1a88d8@siemens.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fareco.fayat.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR05MB6024:EE_|DUZPR05MB11023:EE_
x-ms-office365-filtering-correlation-id: a40ec192-b990-46a3-0558-08dcd196a1a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnMwM1hXSHdIRjhZVUlYckVYT1c2Q1dyQUNCUWE0QVdmZFYvdTFuKzM1VUZG?=
 =?utf-8?B?UW50c1RxazFDU0swUTV2UHNIQWQ2WEswUzlhVzZHdWxWejFvMmF1TG9FOTR3?=
 =?utf-8?B?enh1SmFVVHBWWUZkak9CNisvZ3VGMG1OOGpwNDRHL2dJRXhwcmVoTHNkcnJl?=
 =?utf-8?B?WkVjS1ZYb2crZVpQbXFkUVZIb2dxRzByOGFOSDMvOVF3N21rME5sRU1sTGNW?=
 =?utf-8?B?R25vYkZtYXhxd0JmeU5nWUEzdkdGK3QyZEpQb1p0cklSWGFVNzczcTh6bFFn?=
 =?utf-8?B?Q0FCdURKVG1TcFBEQXUwQVhwZ1Z1ekZ2MnhqQjdtU0hNMkQybnBoL2hQc1ZW?=
 =?utf-8?B?bkk3WUN1V2Y4STJHcU15RzJvQU02S3ZxZ2NBNmVZK3dKYWlRS1d6UDFTRjBB?=
 =?utf-8?B?S09mKytYNEQvazg3SDBrbzliTHFOelI3aU1KTVlDVGxBdDNCaGRQQktqSy93?=
 =?utf-8?B?N1JBV213TEUwQ3pVN0JsbzlyYkpCb1Y1WE1JNXoyeWVuQTQ5Z1o0WVpDU1FD?=
 =?utf-8?B?MkhIWnBUaTNhdURnUnFxdmpaaGs3QjROdGwyOTdVYi9xMkpmOFVmOEhCR055?=
 =?utf-8?B?dkdRdytSd1ZKVUpObm54aDJPeUpkZmYwSmQ1dEU4ZDZUc0dlcjU1bHBaeUxk?=
 =?utf-8?B?bUpVRmlLWEN5bDNCRVZWZytrMjFtNytmUTVaRFJJYzVyMlN3dVdkQytFK0pu?=
 =?utf-8?B?UTgvcjllRFBXUlFtMjFaNmVtODVPNkpkdUt4dWNJemtocmhOeHk1REM3SklP?=
 =?utf-8?B?VkhzMVE4WGo5THA0YjFmZDBMdWt4OUNGSWxHMTl4ZDdEVmdxWXI0djRQNEty?=
 =?utf-8?B?ckNZMG4yTWwwZXk2Uy9uMDdwcitIK0UyaFB4V1hZRUt2WnRTclN1d21oeWlY?=
 =?utf-8?B?NmhTU3hTK1FpU0o0K016bXpja1lUS2M3aFhLZmFaSVlhcjV3MXMwZ2NjV3lp?=
 =?utf-8?B?Y3NuYUpvZllSWUVVV0M3RGxpajlNcFZDOG5QdGcvbURXem92SGtjRWkvT09T?=
 =?utf-8?B?eTJMZmc4QUVaMytPS2IzT3AwdURWa1E5RkxtVU1pT0xlY2tGQllDQ2creWZL?=
 =?utf-8?B?WVB0ZURYQkFMTXhzd0owdDRud0xOcnIwQU55dmZNcmtFcXdwTXIxOHVBT2p4?=
 =?utf-8?B?WGcvTCtxWnpSdzl1OGF4Tk1tcktvMURtZVVXMEpVZ3diN3orMmZJR2dlWUww?=
 =?utf-8?B?bEdpZTRsemVhNngraldMVmlhWDBseWF5RStBeDFzZVNodmxUVE12SlVpbkJh?=
 =?utf-8?B?eE9hNlJSUzF6V3kycnd0ZWJoUE9YNVpHZU1naVVwU0VnMGdiRE5SZCtYUUFK?=
 =?utf-8?B?OUdvMXVxbzlwMFdVRXU4eHp0VWlYTWlGeFdqbW5UQ3MvaGZLTnFCUUlTYWFy?=
 =?utf-8?B?bThYbmdvVW41OFI1Y1l3RVNzUzJkV2xaNlA1VzRnMGFqOHJscnE4ckFJejli?=
 =?utf-8?B?aFFvNjZwSzdoMW9xVFRwNW12NUZ6YzR0S0EybjcvVU9CZVpoOXF2Uy8wZ1l3?=
 =?utf-8?B?anRMRktMdHBpdEFRWWhYWG5pVHNyUXhJWFpydlZ3MmdoOWtHa0ZjVWoyUEM5?=
 =?utf-8?B?bHFjU2RpaCtOMUNqWlZyZWdCVDMvZ2kzNUVlMkhTRW51MHVyUVB5VXRKYzZ5?=
 =?utf-8?B?NUFMVCtZb1hDa250QTloSWlEYkYzdU0rVVB1M1psWENFYUZvSFM5a0RmeFhz?=
 =?utf-8?B?akhHMDFXQWcvM3FDS0pmU3pCL3MzZkJPbi94L3hoRFZSS0NPYTVFNUFLSkJU?=
 =?utf-8?B?Tm9wQ2tNbzFEaS9rdDlZUHh4bnJsMXRwVWtIdTVXMnZaU1dkNno2clZZRU5y?=
 =?utf-8?Q?/CknjfxI6UYJgymrzPjfuu1dPr37yUo968XUE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6024.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dm54UmpDR1h4emZSTmhaeENESDJVUXMwWFN1YzdpOTlKQ3dZeXFEUzBSQnVN?=
 =?utf-8?B?c0I0YmpjTEh5Unc5MzV5VFFPSElwTG9GbEZxTW5RWnVUVngzTDl5ME1DQS9B?=
 =?utf-8?B?TUVtRkpRQnNER0pOby91ZDBXYUk5dVBYektrVDNHUjZRMG1xd1lwRDlJUXpP?=
 =?utf-8?B?UWl5NzJqR0xHczlKT0pCVk0yVHlnQkNkVnVyalFuSVE4YXhCbFpLYktaSjNz?=
 =?utf-8?B?L0orcVpkNUkxSFRhUHZHR1ZLNFdLak52dVBOdEYzNjVoaGM3b3NSNjJZUXEx?=
 =?utf-8?B?M3RaRDBkMWphRGNiemtUaTdCRjI5NGFYckpPcTVqNDRoK05iVnVWZncyM01t?=
 =?utf-8?B?SUpSTG51aXRQS0FoMVdEaDl1Vk0wVmIwd2JZbTgwSGhCMml4emlLRjBMV0RR?=
 =?utf-8?B?LzJKY09xN0Zxb0RkcXc4eEpZWVE5Uk5LZHVBZWZjdWZ4WVRCRUQzRjJ0NkJX?=
 =?utf-8?B?MWZ0clQ5dnRTMHJrYzVNT3JTZzRCUnF0QXlkL0NDSTZ5amd0dWZUU2RUb25k?=
 =?utf-8?B?U2JZU2FjSytSb1FMZmpGYzRMbGVSeVdzSlhHaitOdlRvVzM3TWRveU0vUXA4?=
 =?utf-8?B?MzFMVldXZ3lQQ3E5M1pmODZ1eFZYL3FFd1hOTXVlMzNjL04wRXdZajZURWRP?=
 =?utf-8?B?dzVObkVXbTd0TENMRnJhUkFBRUNPNzZkZXUrUnUzZ3dxL3d2NHlnck1qbHhm?=
 =?utf-8?B?NGMrRkE2WEpIVGlvWFRGQ1lrcGg5ZmRUUTUyclVRWk5uOW5BK2h2OE5YdFZW?=
 =?utf-8?B?OEtqYytQUlVGQXRrdkIyS0pBNHVEOUR6M2pvUStqZU41MUdvdVdYeWdSK0V3?=
 =?utf-8?B?ZEswVWZ5aTFXY0JGWUE3aU1wMEk1Zi9tNGgrcFlRTm9wS0dIL1hTMVlUMkNV?=
 =?utf-8?B?RUJobmFWTXIwN3BSVTR2ejI1TXN2cjVLVGdOZlFpdmI0ZHA3MTZPYzJXSlJI?=
 =?utf-8?B?eXhkbzVmNjBRWVFlU2ZQMzhvNDIrR0lZMU5qdWR0VjRoaTJucHNvOGhaRStn?=
 =?utf-8?B?Y1NuZjJFMDgwRU5reVkwSmFCakZKb2hxbk16V2diZDJSblhzdWRxamJIdDgw?=
 =?utf-8?B?ZitQajh3MlB6b05FaERGQnJtMEJWVjNGdU5tcG9qdFI3cm80OEVjMGVqSktC?=
 =?utf-8?B?YUk2RWRvOWllQTJWbkxHc0s5MVpDSjgzVUJ1VEZ4di9NUmMweTVIVm8yK2tP?=
 =?utf-8?B?YU9FN3ZVZG5wQXBUdTgycEJHKzc1bStReUNWZjUwaFRxQjBHT1BwUmRYU1Nn?=
 =?utf-8?B?cGFjdGpydTVJOVJiaU1KM0dkczlEblpud2p1aGlKV3FvVXFNVmh2NGZXL21v?=
 =?utf-8?B?WXpPOWdEbkxLeTRwc2pWK3kyVmZHV3FIOTZMTUg3QjZnM0xEMkFnaC9wQ0sy?=
 =?utf-8?B?L3JMbGRtdjFsU3ovTFh3YTB0dC9wYXJ5VlY1ZHFHNFU5SmkvQnQwcmh1UUFS?=
 =?utf-8?B?S0F6a3pkL1BrTXI5bUFwbEFVNFB6d3lKREliVm9nbEtwSnhaQjFVTGRpMm9j?=
 =?utf-8?B?T1BHQktUZXg4RDNEakllUWJhemQybmsrdHJaUEg1K3lpYjFpbEtXSlo3dm1B?=
 =?utf-8?B?cStYT3M1RlVVeFNLNDhzZzEwK2dNQUdIU3RPZk92NFJMZWdhelhqZGxhVWNI?=
 =?utf-8?B?UDRVQngrZWRsVDFnbkJYRmhWUTlZL0c4aVV4ekRNd3hjUVRYNEFablBTM0dW?=
 =?utf-8?B?dGV5MnBsZTN2VE9FaFBZbFdvWmNOM1Bld0FaREZFWWlGUUwwMCtMb2tZbDVw?=
 =?utf-8?B?YnNqc3ZVdmxxVEdCOWZjUHp0N1JMam9oYndJMFd5UlNjU1dxeC85ZWpEUzk5?=
 =?utf-8?B?dmNDYW9LV2VSN1pyZlhCKy9zdzdmQXNwVlBUL25FdEt6ZHJiVmx1eXZDWEJJ?=
 =?utf-8?B?Z0IwRzRVaFloVmhJMUFIem9zMUJuTnVRdEdoS1BhVmlrZVJYOEU4VlZUaE9K?=
 =?utf-8?B?Q1A0Qk91eVhrTG1oWWZuMWFQSXRVcC9CSnZXMS9jWmVNMDdndmRpQm4waktN?=
 =?utf-8?B?NXgrTUM3WlhyL0phelV3QkI4Y1NxMmJSOXBkWUlVVkNlRUs0dTBTWHZ3RWFC?=
 =?utf-8?B?c1VxUExXdWxYeXYwRlgrWUVOL1ZqL2FkcFpiZ2lzbk14NFl3MHVSU3R4cHJr?=
 =?utf-8?B?NjhZYUNYS2ExNU9LTGxjekZIL0RRbkVFbGFydFQvWUpUNWNzS2xKbEZQUnRh?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: fareco.fayat.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6024.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40ec192-b990-46a3-0558-08dcd196a1a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 12:46:46.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75428ef7-843d-4df6-9a8e-20c93eb7b405
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pvJTIiEt7VupgGlTRla0g4dxHjFVx7Ysy9nuexna6RuY6SwrEkMh24ofZPwEKMbf11RtXO0IFpDiMmHxDC58P0vF6G15CHRBnsEiZmjL8s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR05MB11023

DQo+PiANCj4+Pj4gSeKAmXZlIHRyaWVkIHRvIGNvbXBpbGUgbGludXgtZG92ZXRhaWwtdjUuMTAu
MjE0LWRvdmV0YWlsMSBnaXRodWIgDQo+Pj4+IHJlcG9zaXRvcnkgZm9yIFhlbm9tYWkgMy4yLjUg
KGZyb20gYSBEZWJpYW4xMi42wqBpMzg2KSwgYW5kIGl0IGZhaWxlZCBvbiB0aGVzZXMgZXJyb3Jz
wqA6DQo+Pj4+ICh0aGUgc2FtZSB3aXRoIFhlbm9tYWkgMy4yLjQpDQo+PiANCj4+PiBJIHRoaW5r
IHRoZSBtYWluIHBvaW50IGhlcmUgaXMgdGhhdCB3ZSBkbyBubyBsb25nZXIgc3VwcG9ydCAzMiBi
aXQga2VybmVscy4gV2Ugc3RpbGwgc3VwcG9ydCB0aGUgY29tcGF0IGNhc2UsIHNvIDMyIGJpdCBh
cHBsaWNhdGlvbnMgcnVubmluZyBvbiBhIDY0IGJpdCBrZXJuZWwuIE1pZ2h0IHRoYXQgYmUgYW4g
b3B0aW9uIGZvciB5b3U/DQo+Pj4gU2hvdWxkIHdvcmsgYXMgbG9uZyBhcyB5b3VyIGJvYXJkIHN1
cHBvcnRzIGlzIDY0IGJpdC4NCj4+IA0KPj4gV2UgYXJlIHdvcmtpbmcgc3RlcCBieSBzdGVwIHRv
IHVwZGF0ZSBPUyB3aXRoIGFuIG9sZCBiYXNlIGhhcmR3YXJlIChJU0EgYnVzKSBhcyB0cmFuc2l0
aW9uYWwgZm9yIG5vdywgYW5kIHdpbGwgdXNlIGEgMzIgYml0cyBDUFUgIlZvcnRleDg2RFgzIi4N
Cj4+ICANCj4+Pj4gwqANCj4+Pj4gSeKAmXZlIHVzZWQgdGhlIGNvbW1hbmQgwqvCoC9wcmVwYXJl
LWtlcm5lbC5zaCAtLWxpbnV4PSMjIyMjIyMjL2xpbnV4LWRvdmV0YWlsLXY1LjEwLjIxNC1kb3Zl
dGFpbDEgLS1hcmNoPWkzODbCoMK7IGJlZm9yZSBjb25maWd1cmluZyBrZXJuZWwuDQo+Pj4+IE5v
dCBiZXR0ZXIgd2l0aCBsaW51eC1kb3ZldGFpbC12Ni42LjIzLWRvdmV0YWlsMi4NCj4+IA0KPj4+
IEhhdmVuJ3QgdG91Y2hlZCB0aGUgcHJlcGFyZS1rZXJuZWwgc2NyaXB0IGZvciBhIHdoaWxlLiBT
ZWVtcyB3ZSBzaG91bGQgYmFpbCBvdXQgYW5kIGNvbXBsYWluIGxvdWRseSB3aGVuIHRyeWluZyB0
byB1c2UgLS1hcmNoPWkzODYuDQo+PiANCj4+IElmIEkgY2FuIHVuZGVyc3RhbmQgdGhhdCBmb3Ig
dGhlIOKAnG5ld+KAnSBYZW5vbWFpIDQsIDMyIGJpdHMgaXMgZXhjbHVkZWQsIA0KPj4gaXQncyBw
ZXJoYXBzIGEgcGl0eSB0aGF0IFhlbm9tYWkgMyBjYW4ndCBjb250aW51ZSB0byBiZSB1c2VkLCBl
c3BlY2lhbGx5IGlmIHRoZXJlJ3Mgbm90IG11Y2ggdG8gYmUgZG9uZSB0byBmaXggaXQgYW5kIG1h
a2UgaXQgd29yayBvbiAzMiBiaXRzLg0KPg0KPiAzMi1iaXQgeDg2IGtlcm5lbHMgYXJlIHByYWN0
aWNhbGx5IGhpc3Rvcnkgc2luY2UgYWxtb3N0IGEgZGVjYWRlLCBpbmRlcGVuZGVudCBvZiBYZW5v
bWFpLiAzMi1iaXQgYXBwbGljYXRpb25zIG9uIDY0LWJpdCBrZXJuZWxzIGFyZSBzdGlsbCBzdXBw
b3J0ZWQgKGV2ZW4gd2l0aCBJbnRlbCB1cGNvbWluZyBjdXRzKSwgYnV0IG9ubHkgZmV3IHBlb3Bs
ZSB3ZXJlIHRlc3RpbmcgMzItYml0LW9ubHkgeDg2IGtlcm5lbHMgdGhhdCBsb25nIGFnby4gUHJv
YmFibHkgYWxtb3N0IG5vIG9uZSBpcyBkb2luZyBpdCBpbiB0aGlzIGRlY2FkZSBhbnltb3JlLiBE
aXN0cm9zIGhhdmUgZHJvcHBlZCAzMi1iaXQsIGFuZCBDUFVzIHRoYXQgbGFjayA2NC1iaXQgc3Vw
cG9ydCBjYW4gYmUgY291bnRlZCB3aXRoIG9uZSBoYW5kIC0gaWYgbm90IGV2ZW4gYSBzaW5nbGUg
ZmluZ2VyLg0KQWx0aG91Z2ggcmFyZSB0aGVzZSBkYXlzLCBzb21lIGRpc3Ryb3MgMzIgYml0cyBh
cmUgc3RpbGwgYXZhaWxhYmxlLCBsaWtlIHRoZSBjbGFzc2ljIERlYmlhbiAhIPCfmIkNCg0KPj4g
SXMgdGhlIGVycm9yLCBvbiBYZW5vbWFpIHNpZGUsIG9yIG1vcmVvdmVyIGtlcm5lbCBwYXRjaGVk
ID8NCj4+IFdoaWNoIGtlcm5lbCAvIFhlbm9tYWkgbGF0ZXN0IHZlcnNpb25zIHdlcmUgcnVubmlu
ZyBvbiAzMiBiaXRzIGZvciBzdXJlLCBvciBhdCB3aGF0IHRpbWUgPw0KDQo+IEkgd291bGQgbm90
IHNheSB0aGF0IFhlbm9tYWkgMyBpcyBkZWZpbml0ZWx5IGRlYWQgb24gaTM4NiBidXQgbm8gb25l
IGxvb2tlZCBhdCBpdCBpbiBhIHZlcnkgbG9uZyB3aGlsZS4gSXQgY291bGQgdGhlb3JldGljYWxs
eSBzdGlsbCB3b3JrIHdpdGggaXBpcGUtNC40LnktY2lwLCBidXQgYW55dGhpbmcgbmV3ZXIgZHJv
cHBlZCBpdC4gV2hpbGUgd2UgYXJlIHN0aWxsIGNhcnJ5aW5nIGkzODYgaW4gdGhhdCBrZXJuZWws
IHdlIGRpZG4ndCB0ZXN0IGl0IGZvciBtYW55IHllYXJzIG5vdy4gQWxzbyBub3RlIHRoYXQgdGhp
cyBrZXJuZWwgaXMgbm93IGdldHRpbmcgY2xvc2VyIHRvIGl0cyBFT0wuDQoNCkkgY291bGQgZWZm
ZWN0aXZlbHkgZ28gYmFjayB0byBpcGlwZSBmb3IgdGhpcyB0cmFuc2l0aW9uIHN0YWdlIG9uIG91
ciBjdXJyZW50IGhhcmR3YXJlLg0KVGhlIGxhdGVzdCBpcGlwZSBrZXJuZWxzIHNlZW1zIHRvIGJl
IGF2YWlsYWJsZSBoZXJlIDogaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS9YZW5vbWFpLw0KYnV0IHdo
YXQgaXMgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiByZXBvc2l0b3JpZXMgaXBpcGUgYW5kIGlwaXBl
LXg4NiA/DQpXaGF0IHdhcyB0aGUgbGFzdCBrbm93biBYZW5vbWFpIHZlcnNpb24gMy54IHJlYWxs
eSB1c2VkIGFuZCB0ZXN0ZWQgd2l0aCBpcGlwZT8NCg0KVGhhbmtzIHRvIHlvdSBhZ2FpbiwNCkJl
c3QgcmVnYXJkcy4NCk1hcmMuDQoNCg0KDQo=

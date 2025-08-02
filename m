Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023084.outbound.protection.outlook.com [40.107.162.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259C478F4F
	for <xenomai@lists.linux.dev>; Sat,  2 Aug 2025 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754155461; cv=fail; b=FyR/qoMNoTdmZyvH9GezSpbyTmkBeRuYCsOq2hg1wXZ+hPyKSpXEjmZhbYE7K4/xkLAvc0mtqac/cv8rP+AT1b0WDuHPvXZ95rJC7tC3/LfGuoK61NYqSW9vZ6RherqN41pJPRPvVP06vAzJckCpfOyYDlhcFzQlmzFCCgqOFgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754155461; c=relaxed/simple;
	bh=9OF9a9fY+y0A8XKZGto32TaqHFN9zbzSxgAYXGI0rRk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUGTK36wf/aVIwU91SPsNSDrSm1ZNnmcUs2k2PcoyXYn4Sazit60VriWgPuD6uQjkjBsMvGxLWdyipGTE/CkJFkWVFsXgiD4YtM16+1dGaATsh+V/XV4rvmQEd14t1+G3+trhpCu5dldyiE4PYkGS8CJNlLhYa3PUXga3u5n0+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=OHo2g54R; arc=fail smtp.client-ip=40.107.162.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="OHo2g54R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kL+wO0ajr3xUtH/UYeUTvyxehNhYc13EiKWlD6hGNn6kF8WYkrh0AdykXyo+KYBGQhInuyeWfIY4YH/8sh6KzRnW1PLvp3+OWa7yqsgrr9gGpph4LCAu4yDiQdY5sQgeFnoUCpicfAvNo9IIteszoZtcDrttsJtQbh5kkrOldK5hW+L58NrEbvypKbA22/s32rjmGgw1Ka68FwsRPdS3XsYokIQ/4/YpZyAvS6+2TN9+QCHwOZqdFNtai79UODBFCt73jLUOhvaWV2zWho2JmYWBfiWNmZ5XDO8Y9cyDlTJTUA9MDlOMrWHYdSjNpZH9PEge59U5WQUmZroJsO8dUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OF9a9fY+y0A8XKZGto32TaqHFN9zbzSxgAYXGI0rRk=;
 b=cXBhjGEg6iaocAvihSOrQ2/1MDTGKuOZ7B+2tUsaRX/huihzfGR0+sxSGgnx+y+e9tyjtf0u0XLrO8eN9AkldjaAo1/7HGXA6nlhrOCjIf5ixEbbmTowg81r5Rrel1r3OvQPqun1FBxLVe/G1TpR5idxVsZIX4X8jeDtYP0QsGoATHZpo4E01nrpkmOd3HwAoBoLPtYA9PTq/r3uBxIuYKOY/AzemNbR6PQIkXBw6R74e/IcdUdupxlh0pHXpAqODPZJg65ne6MWymrkKaUh5zEEfj2CfQ1u/KRGxNOA7GBUf8QzNsoOe7zcOaviQqnO9HRR3z5e/ZrmAFD9zmasAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OF9a9fY+y0A8XKZGto32TaqHFN9zbzSxgAYXGI0rRk=;
 b=OHo2g54RxRlA+Ge/yK477pGSFwSsZnuf9qUoDUUiAGvRo/lmlBRbA3BW1sdUtT3Ji8GAp7/PS11M1MP8d42UIitTvEMIregl2ACz+uGHTADhv8SfjiVBwZN34BvDdNAmMRyIoHEumLDerVypxKRpZVTiXvq4tgN85aZqt7be2K0=
Received: from DB3PR08MB8961.eurprd08.prod.outlook.com (2603:10a6:10:428::14)
 by DU0PR08MB9536.eurprd08.prod.outlook.com (2603:10a6:10:44c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Sat, 2 Aug
 2025 17:24:14 +0000
Received: from DB3PR08MB8961.eurprd08.prod.outlook.com
 ([fe80::d89:c769:9bb0:5348]) by DB3PR08MB8961.eurprd08.prod.outlook.com
 ([fe80::d89:c769:9bb0:5348%4]) with mapi id 15.20.8989.011; Sat, 2 Aug 2025
 17:24:13 +0000
From: Markus Kurz <markus.kurz@sigmatek.at>
To: Steve Rosenbluth <stever8@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Clara Kowalsky <clara.kowalsky@siemens.com>
CC: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai
	<xenomai@lists.linux.dev>
Subject: Re: Xenomai Meetup at OSS Amsterdam in August
Thread-Topic: Xenomai Meetup at OSS Amsterdam in August
Thread-Index: AQHcA7p4NVog9gWJVEuWU07TRJK18rQpwpIAgAHX/oCAAMPZgIAjPqmA
Date: Sat, 2 Aug 2025 17:24:13 +0000
Message-ID: <15630110.O9o76ZdvQC@pop-os>
References:
 <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
 <CAExw09CzR9UXe9y2a+YGtQ5Of-g2wP6hmNh4Y4HvyGgwHQ55TQ@mail.gmail.com>
 <9d3a82e2-118e-4bb3-962b-9b11bb7ddb71@siemens.com>
In-Reply-To: <9d3a82e2-118e-4bb3-962b-9b11bb7ddb71@siemens.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB3PR08MB8961:EE_|DU0PR08MB9536:EE_
x-ms-office365-filtering-correlation-id: fdb49e5f-417b-4e60-77bb-08ddd1e966cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a01HMVErZW54bFY2UFFqbzBnNVJsMkNxM0RBUVJtSUl5YXZhUHR3WmNiSTFp?=
 =?utf-8?B?ZW4zR0JBK1BqTEF2UmFITXFVOVRucGpwWDN3NE0yeHo0anN0UjQ2dDhWSVA4?=
 =?utf-8?B?V2VwYWlKd3paZENob3Z5TCtTTy9vNWFCZ01UOEtSTERYYnJUeFgrV2RQUU8w?=
 =?utf-8?B?aGg2UktzRUM3UlU5aG5vNkdNdkpFQmxHZFVSbEVMMEdrS0FMdWtkS0RrVFY2?=
 =?utf-8?B?ZHZzU0t1WEVETzEvWmhPbSt4eU5vcXZFKzU5Y0Exd240OGpjNnBtUDBweGZs?=
 =?utf-8?B?MFVBd2ZlYS96TEhrY1Q2aS9HdWNuUHBXcTBVamdFSmQvYlZWcEF0bjRIS2lq?=
 =?utf-8?B?TytCV2RNbHl4UWRwTmdUbUhVSTBaaUFmZWxyb0M3TDN6VnhnMk9TZHk1elEy?=
 =?utf-8?B?L003dzdFS3Z1YzNZamhGTi9kek5YM3FJQ2dpMXhGQkgzVXFyaXZWUzV3dWt6?=
 =?utf-8?B?T3l1Rk9QYnRNL0poWHpaTVhRUm1Cb1RKa0RzYmlRbWhmWmRLTWlMVGdoOGhr?=
 =?utf-8?B?Qk5rNHZiUUEyT1RnMkhtTEI5K1pMaUlUMXk5ZVBSRFpsL2xyVkJqY0lGTXhz?=
 =?utf-8?B?UjB0QUMxamJKNDNtM25pRVNjYjA1SHE4MTZ0MGVKSzJVVWkyWTRIYmpsVEdl?=
 =?utf-8?B?MzlHcDlMT2Uyd1gyNjRzWE02YlFRRWJFMUdWK3BlNWJwc3RGUm9VaFQxenFp?=
 =?utf-8?B?bVZweW5vWUJDQUVITXBkWGxORk5EY0FGNFhjVTQvZllrTG9sRFBnZFNSL0R3?=
 =?utf-8?B?dVpRaXpiUjlzR1VldUdWdVJ3SXlZOVM5d3U1ZG5aQ2w4cVk1U1R5T2hSeHRa?=
 =?utf-8?B?K1NnTFZJa0k5OWd2Z3Jtd1JheWhnQmFMUzE3a1U1NC9WTWtvck9Ndk91cmRj?=
 =?utf-8?B?Nnp1Y3VDZ2JYTHdWKy9maFRoazNzZW9wWkU3cVFLemc1R1hZSTIvczl0TWpv?=
 =?utf-8?B?TEFPZkk3NHhQN1kzQUJKOWJQVkVCaS9Ld0d5aUpTWWMrbWdpTll6ekptcG1p?=
 =?utf-8?B?UThrTEEwRkVkWWt6cCtLbjlRaUVpL296bXN0WWpENDBBMUlObWZOM2xGU0VR?=
 =?utf-8?B?UXp5NWlBWTlYOVRKbExmZVhlZkpVZVpyUUhSeVZzSmZtajBqaUI5YWxHakVk?=
 =?utf-8?B?M0ZHSW9zWGZNUjE0dWJqc1A1djJoNFh1RjJOV2ZmaEIrZGhkQ25oYnVLRGlF?=
 =?utf-8?B?elAzTHA3a1JYdWxsVXVzTk9LS2V6c21rclFMRXhuanZNV25WaU9LcTlWZjlU?=
 =?utf-8?B?a1UrTHB6bEREeDFmdEpJMko4ZTB3cVhHUVdGanZDVlJOSkpUc2JsRGxkd1cv?=
 =?utf-8?B?ZzBVd1AwT01PdFF6SFgxaW9hTmo4a0V6RDF6UVZXQzVUM2JDd3VHeW90RGJD?=
 =?utf-8?B?OHN6SlZHbDlvWWJYZStEQzNZWS9Hd29MY0lwNFA1Q1Yxd29jeEk3R3Vaakhx?=
 =?utf-8?B?VjduVTFIQlMzSSt6Y05qV0RBOHQ2S2RXQk8yTUpPclVVUDEzaWtkbjRaWUNm?=
 =?utf-8?B?Tkh1aUhaa2Y2V3hsUnQ4VjQrdDBSSTNRZnVsaGsyRWpNcHpYL2d1aVlBb2pI?=
 =?utf-8?B?dDdYK0Z4RnJac1lQL3VRS2dYK3QrSmJGS1B2bk5YZWk2VDQyVTJPbzBaRHY5?=
 =?utf-8?B?MTFldkswQXg5Zng4MlozUk45TnZGaVV0ZUExcnNTblVMcVc4OHNkbXNNamJ2?=
 =?utf-8?B?WHExeFlGcTU0R3U2NGUxOWR6ZHFBaXZpSVJCVkNwK29nTnQ0Y2R2NUg1aWgw?=
 =?utf-8?B?WXlIa015S0tBQXpGRlVibzg3WDNtb3ZJSEU1YVZuMlRPY2RCZEJ5VUVlblRV?=
 =?utf-8?B?T3J6KzRzVS9TalV1SCtURlRmaGppNjVKUFhmRWc5bnphb080WnQ5VXZtK0hQ?=
 =?utf-8?B?QXhSUWdhbVVKOU56aXQ5VExqajhPQUpwNFRSWGI2WXJqQUhPY2NGdmQ4aU5s?=
 =?utf-8?B?c0RNbmszcTJETmQ5aWZaVHEwVkR2VmUrTk44VHdtek10M3V5d0kvTEMzUitV?=
 =?utf-8?Q?4+nw1pP4YOGz5hDShYou77XV8RtNps=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR08MB8961.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFAydXZjN2RTT3JDbnB1bFJsZ1l0dGhqTStCSGYxdDhmdlpqcmFKQ0t2RHJh?=
 =?utf-8?B?Z3NCZXBqaEN5RktVdVRGclFpZmRmeVVMcUFkMUFycGxLUllodTdYS0dodmU5?=
 =?utf-8?B?RHFRZ2hJdTlTd0VaNjFDNG1VK00zV1hKL2JuTTF1WVcwaVZwZWtIcXN3czIy?=
 =?utf-8?B?bnlXWmUwS1orM2dXR2ErUFQwT3ZwT0VYZjZTN2J4S0lzNGU5b3k4MmwvWnNv?=
 =?utf-8?B?Wjh2MmN0bjZNSGJ0eTMxK0UvT3ByOFdLZXFvRWJyenpNbmo5U3U4VXQ1Zm5Z?=
 =?utf-8?B?c2lxYmRETXkzR2o0VnpMZzFXYnUrTlNoY3dBYmZPdEQrZ0lNMFlZQ1hLcVpi?=
 =?utf-8?B?bG1oaG1hejlmaGN5R1NaSG9oUGJvTUZkc2RMbzRyYUZpd01kU3BhMHA5NVRV?=
 =?utf-8?B?NFUxM0QwamxBaGdzUDBoZE9FakdwdGxiUHBvOWxJQXhhSHEwVUdrZ1hGNVRG?=
 =?utf-8?B?cXdiNkpzVnlPM2REVVhRQndCaXJoS2wxd3VGNW1hTnVHK0xVbHh0TjNEbnVv?=
 =?utf-8?B?WUpKckdlc0dlVndFVGNUWW9uNDF5Qnk5VzE3T3Z0b29vRzhGQU9nL3RoRTVZ?=
 =?utf-8?B?RUZQMkRSWkRVMTRJVThyVUdRSVNkT2Y5ZjZyZGVTQ3hEcFlFS09ZNStBQUJG?=
 =?utf-8?B?TU5EdE5RNEw3eWtVV282U3ZGMEZONTRwR3J0WFhrbEFjeHl2UUtlcTF6RGFn?=
 =?utf-8?B?UVVORzYyTUI1d0szb0xnRTY2MCtneGVzMmtRTDRkZ0J5VTN2MUxib3h6VTJs?=
 =?utf-8?B?eDl6Tms2RU9GV0RFTlJGTWgyb0E2a0ZFTVViZzRobUo0RkJvQVJaRXRDWEZZ?=
 =?utf-8?B?cDJBNGNURWxpdGJsSllvVUtzWkFVWGVHQ3F6SktrVnY2ZDk5TEMzcnJjL1o0?=
 =?utf-8?B?TmJoQm1DK0FZcEJqRkxMMjQ3YjR3TURqOUtFczVOUTloT085SzlJTUwxWGdF?=
 =?utf-8?B?RlBWOWs5SE1RVTQySmdUZjRPM01VZkFnbS9ybGFHRTM1clh6U3FyUHZNall6?=
 =?utf-8?B?MHRLV2Z4Vm90Ni8xaHpUUTZKWmE1QytIRHU3YnZXcmc4d05tbDFRbDBReTB2?=
 =?utf-8?B?ODRBTS9qaTBKcEc0Q1l0RzkvMVZBNGtWK3JnK08ya3BWcVlUeXZmckF6NmZr?=
 =?utf-8?B?MUswM1k5d0VEMUFqeEg1Y1hMR3MrTzQ1TDlUTnliSHZzd0JuM0FoOUc1Myt5?=
 =?utf-8?B?eWJnTVFpL3Boekl4SkNOcmMyVzhzMDJoTHdmcVRIdXBPQnhXYmdTVGFHdnpl?=
 =?utf-8?B?NjFXS0ozZUR1WWVVc2ZUVmgrVjhGQTh2ZElwS2Z2ODRTMFpSUVlkdHp2SmJu?=
 =?utf-8?B?SEFQTnF1czRGYnBXcUJqV0d6L3RVS045bS84ckVMTWY0MjVJRkVBdnh2UGxt?=
 =?utf-8?B?WFZ5RWs5Z0g1dWRsVlAxUjljME1Rb3ozc2ZCUUo5SkFGWEpXV2JpVlp3N1FW?=
 =?utf-8?B?bVhmTUNSZXJYMmNVbEgrTEhVcnFmc3JBb3d3YVgvcSs0cnhZTzBMTXhDc0Fs?=
 =?utf-8?B?K2JqVy9IcWcvVDFBY0loWDA5Zi9UeWw5MG5tUWlpbDhScG1uZHZFNGM1STlV?=
 =?utf-8?B?UGpnZ2d3dDZJeFE3eG9jTWxQMld1TTdvb0pkR3h0RUNnUE9GdWxiVTNqYmdq?=
 =?utf-8?B?SVIraFprY3FzeTM0UEtvRG9JWEVyeTd3S1E4dTJwOHIxd0RxcHFWSXAxMUx1?=
 =?utf-8?B?ZFdmYVlEZjJZSzVnWURSK2hSaHBiTTJHT2ZRNjVMS1BzTlNEK3R3WkJDd3NE?=
 =?utf-8?B?VmVxR2llYk9kRkxVSGxKSzBOMGt5UHJPL05sUmN4NU1YYWxKaUc1OEt4aXFl?=
 =?utf-8?B?bFdKSURjWGxEeEhhL1UxNm4wUXJueUhDQVl1dUVSc1U0dWFwT0JzUnNoRFk0?=
 =?utf-8?B?dkJRdFFMbWx2dTM4V0o1eXZ5YTJnUXIwemhlbTlQSFNKT28yQll6bXJDNHRs?=
 =?utf-8?B?MUVYQ0ErR3ZiSlJNNXMzRVFpTG9pMjNhY0NTWldIb1VMVTBxakJKbWJCbmZX?=
 =?utf-8?B?Z3h6a01TVS9MTVU0SFNpYzBMMzBDNzhtUW9GR3NtSTFDM2dTVmhURi9PeDNw?=
 =?utf-8?B?c0pKb1RkeXVmTFljQjdhNjAvVTZvanJrNzVPV3E3S0huS0pXQmt0Y1ZVSDlG?=
 =?utf-8?B?bkVGN3dhSWFnbG5Ba0FkVXFHWFJkVE5xbEF2djVxZzh4MVZqNlN4b00zTENY?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ABB322705103747A18F508C8A72BE1B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR08MB8961.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb49e5f-417b-4e60-77bb-08ddd1e966cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2025 17:24:13.8416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gv8roRCfW7Y6yPHfUJluLKve5tbsBho7s+Q9rOcSqdgsRgUunFmxPTsbwx4psQo2IAFvPAodeilcNOs9nZpWgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9536

T24gRnJpZGF5LCBKdWx5IDExLCAyMDI1IDk6MTA6NTEgQU0gQ0VTVCBDbGFyYSBLb3dhbHNreSB3
cm90ZToKPiBPbiAxMC4wNy4yNSAyMToyOSwgU3RldmUgUm9zZW5ibHV0aCB3cm90ZToKPiA+IE9u
IFdlZCwgSnVsIDksIDIwMjUgYXQgODoyMeKAr0FNIEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2ll
bWVucy5jb20+IHdyb3RlOgo+ID4+IE9uIDA5LjA3LjI1IDE2OjU1LCBSaWNoYXJkIFdlaW5iZXJn
ZXIgd3JvdGU6Cj4gPj4+IExpa2UgbGFzdCB5ZWFyLCBJIGV4cGVjdCB0aGF0IHNvbWUgbWVtYmVy
cyBvZiB0aGUgWGVub21haSBjb21tdW5pdHkKPiA+Pj4gd2lsbCBiZSBhdHRlbmRpbmcKPiA+Pj4g
dGhlIHVwY29taW5nIE9wZW4gU291cmNlIFN1bW1pdCBpbiBBbXN0ZXJkYW0uIElmIHRoZXJlJ3Mg
ZW5vdWdoCj4gPj4+IGludGVyZXN0LAo+ID4+PiB3ZSBjb3VsZCBhcnJhbmdlIGFuIGluLXBlcnNv
biBjb21tdW5pdHkgbWVldGluZyBhdCBhIGxvY2FsIGJlZXIKPiA+Pj4gZ2FyZGVuPwo+ID4+IAo+
ID4+IEkgd2lsbCBiZSBhcm91bmQuCj4gPj4gCj4gPj4gSmFuCj4gPj4gCj4gPj4gLS0KPiA+PiBT
aWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzCj4gPj4gTGludXggRXhwZXJ0IENl
bnRlcgo+ID4gCj4gPiAnV2lzaCBJIGNvdWxkIGJlIHRoZXJlLgo+ID4gCj4gPiAtU3RldmUKPiAK
PiBJJ2xsIGJlIHRoZXJlIHRvby4KPiBDbGFyYQpDaHJpc3RpYW4sIEppbW15LCBhbmQgSSB3aWxs
IGJlIGpvaW5pbmcgYXMgd2VsbC4KCi8vTWFya3VzCi0tIApTSUdNQVRFSyBHbWJIICYgQ28gS0cg
fCBTaWdtYXRla3N0cmHDn2UgMSwgNTExMiBMYW1wcmVjaHRzaGF1c2VuLCBBVVQK

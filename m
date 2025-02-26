Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2118.outbound.protection.outlook.com [40.107.21.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F9258CF4
	for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566756; cv=fail; b=GybalWU5v697WD5FEnj3FOm960PkecrkCxCDF4lwiSXqwFwpmhGpjoC4llM9F9YyYeIKJ8iflHwQOiJAlriniVm08pXMz3l8r9/ojhmhUHdz4sw7c+2XO43xGSJpL+xjqu60B0C/3eKHuDESZskwShvd0f2D/7J9Az/zKCsreC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566756; c=relaxed/simple;
	bh=dkFi51Q6fbVoo7+CsR3qReG2nHKLStRso2DkI8p9IZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ln9HvumkxMRloWaRAv5DKTtCSbIVHrKMagW1O2bG//Q9JU8d45JHbbGhKRwfc3DP3FtA3acK9uPnZ/e6FqoeDwimrTqUMgHk76QInSvnDDoQ0idlTtyeFFw8D1yVEis0Oh9IAklRFCbhH4YCm6JQu7JU9thO2CkW3J5bW8LDfRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=btIhXCpU; arc=fail smtp.client-ip=40.107.21.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="btIhXCpU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/vbm3vgXPaJ2awSAL3juaOkKzvkYdO8F6bHcXVzfEqD2/IpkKZnejW7Du5RBzlrDZAk3gecjnzTDRJefBMtDoAK50Eia2AhZtoW6UtRXxbc6+AraW68KVoq6IToIqMWM9UhGEYm9ri9ushppnZHxU490KrgFloLb/qepu54ztVP84l0rMLYdheWAqXKJ1YG22C4PZyk4SdqEHd1dyb/XpDdb17tcjUFqXNJCc6F8qxYUF31w+xiXT+07sRo1dCts3jsGilcQxBui4Wjs//kFNkV7GeJSVcR8D5h9agW3I+sSSPyfFNr5jKdcoqicNHniyTMQw7jBVk7v0JbTzJ+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkFi51Q6fbVoo7+CsR3qReG2nHKLStRso2DkI8p9IZE=;
 b=dKrYD3B9vf0UO6uVt9V5L8TxYBoU3JByhc2f/gkYsM2FRMt7d527V074b9EtlPePTDkNlqwUAFah4/c3ey9sLDLDKBNOWCx6+D7hyqKD/FWUFnUc24kqilW5LpcptnhZ+waZsj/vsw99i71I+c5tBiJZJwInmXJ05DdsDsZR3UOwSN6O199Iya8V9+CLjlq1vho1hUACOEgujKCQRA7QknLE+AKcUg0DCMY+E2NCsCVVuYWw0ZOyK1TGIBzuQZtgLcIOsQ+DKszl/A1YpUaSwjGVbkjmjGUTUs0oPbn5RncJd13FJHH861sv8tqRAuTydYxqiqbAAQorZ70sUVmuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkFi51Q6fbVoo7+CsR3qReG2nHKLStRso2DkI8p9IZE=;
 b=btIhXCpU+poLUcAE4dqCPl9bNqllqk61LrbDb/7frTmON7iT9YHgwX4VbOSCTAhq0mLMPqKTPc+H+B/nGqgIYaxB6kRsiNQVveSeBu8Je6DAT5OZg1euH3mLIWke7YKI+RxePIdsKqqmGh7LzmzF+AwhnjxiNUj0NjNBui4uTz0=
Received: from DU2PR08MB7358.eurprd08.prod.outlook.com (2603:10a6:10:2f1::14)
 by PAVPR08MB9062.eurprd08.prod.outlook.com (2603:10a6:102:32d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 10:45:49 +0000
Received: from DU2PR08MB7358.eurprd08.prod.outlook.com
 ([fe80::39fb:2db7:33f9:ed01]) by DU2PR08MB7358.eurprd08.prod.outlook.com
 ([fe80::39fb:2db7:33f9:ed01%3]) with mapi id 15.20.8445.016; Wed, 26 Feb 2025
 10:45:48 +0000
From: Johann Obermayr <johann.obermayr@sigmatek.at>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
CC: Johann Obermayr <johann@fam-obermayr.at>
Subject: AW: [PATCH] cobalt/intr: Restore support for IRQ sharing
Thread-Topic: [PATCH] cobalt/intr: Restore support for IRQ sharing
Thread-Index: AQHbiBIA8TSaO+hz1k+XPLGZb9LParNZZdEw
Date: Wed, 26 Feb 2025 10:45:48 +0000
Message-ID:
 <DU2PR08MB7358E497143134D358C855ADF5C22@DU2PR08MB7358.eurprd08.prod.outlook.com>
References: <51ff9147-9af7-4f5c-9407-b7a73bd1d290@siemens.com>
In-Reply-To: <51ff9147-9af7-4f5c-9407-b7a73bd1d290@siemens.com>
Accept-Language: de-DE, de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR08MB7358:EE_|PAVPR08MB9062:EE_
x-ms-office365-filtering-correlation-id: 20e6d6c3-a7e4-47d8-26b4-08dd5652bb73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzFHc1ZpMVlTWkRMcVR2dXg3Y0RPSXY2TmRIakQycHNxa1hPc1N1VWd1Tm8w?=
 =?utf-8?B?NlFMOERpR2VMUXlEbk1JNzUzSlQyRmhiM3o3WUNxUDFJdVowYXpqdVFnUEwx?=
 =?utf-8?B?YmlCdUxEUzBBVVQrTDNmWFFpLzVDZXo0TkhzZmtUdldxdElSRXNmYzBXS0Zp?=
 =?utf-8?B?R0RQdzIwRnJLanhueWU3YlFMNWNydUpkSFBKU3JNRjZhcEo5WGlUYk1NZWp6?=
 =?utf-8?B?U2wrWlZ2ZzVPNWw1R1N3STljYTBCeW5ISzdNS0hWWFJaVG9YblJuejNibVJj?=
 =?utf-8?B?cGpZVGk4VmFOOFk2UGZ5NHoydDYyZjgyQVVLbVpuL3Z3M056a2dHWUZ2RUFs?=
 =?utf-8?B?QzQxREhoUlN6UDhPSnJzMkJYRDk3MHdMM3Z5bmlodVlTaDEyWmZjeW5qYkd0?=
 =?utf-8?B?ZldLQVpoVXUzTFZwdlBGamNwaHFOd2hZeG94RjVMSVl1bkVEbUdzL1V5eFA1?=
 =?utf-8?B?OGxFMXJNZlRMaXBhRGJHb09CT05XWlJJRlQxTFUzY01qcHpOZHl5RjFOTWNB?=
 =?utf-8?B?aEZzOHV4S1BqRzlYMmlSUWRuNXpUcEVkdFhqTmNCZjNRenB0OGhjbGRoU1Rm?=
 =?utf-8?B?V0hyQ1lBdjdQb21nMEhTNEthcFlpS0c3U09OZ2poWXBOMTBmZ1dUd2kxaHg5?=
 =?utf-8?B?N1pWNjlDRlRxWVhBTythSHhnZWRPaHZ6K3VVdFFLZnJWVHg5SHlSMDZqdGpo?=
 =?utf-8?B?bExaQm9oSnBtcEx4OEdOQXZIdDF0QzZRUmo3WVZJME1UUmROR0pyQytVVFJp?=
 =?utf-8?B?dkM2WmtneVpPVGFWMzhQYVd6Y1lSTTQ5d1hRdUNGR2trejVIQ0c5Z21ndjIy?=
 =?utf-8?B?TFFZTG1zajUxT0ozbndZZGhSN0d1U3kwb2FFNkxNV3R5aDQ5ckQvMzNKbHhv?=
 =?utf-8?B?VDY4UEtFRmFSeGN3RG0rb2x3bThkTVdpZjFnZEEyckdsRjVLWEJ2TmYvbUl2?=
 =?utf-8?B?Sk81SFhudFRpelkzSHgyQ3J0eHp4RGpvRkJPT0RNMjFqeWl5UlF1QUlWcFJt?=
 =?utf-8?B?aDJ5enNxYjFLTFBWMlNUNklZOHE5ZEwxVkduM0lBRTlSRTlaM1B3azBoVHlL?=
 =?utf-8?B?MjMyUWZoejhlbXhPdTFZWnBqSndiRHdPMjAvcGlXcTM4VFdnOUE3anNGQkVq?=
 =?utf-8?B?YUc1NVJPdiswQUQrbGxSd25CRU1RcDJPWjBBZWdvYzVCK2g2RFZXWTZXS2FE?=
 =?utf-8?B?STJERlFuL05NQW10TUlsYTBTUHVDcWdvaEh2N2djcmJLSmp1MXF2b0lyVFN4?=
 =?utf-8?B?RENGclp4NUx5MVM4alBzd2VuejVZNXR6c0NVQ3F5SGwwZUJyZWR3eWxMbmV3?=
 =?utf-8?B?Mm1BMXYxU2NabkYwUXBFbzJ1NzNjWFpPcDhMWjNJbllPUGhoOGhOWjhHWWh5?=
 =?utf-8?B?R3dyK3dmOEpEeUtLSmhDQnpXT1VUWGUwdGIrTlJqL0g0SWtOZGd2RVQxQVkw?=
 =?utf-8?B?VmNwZGlkSEN5ZzZ0VXBEcWdLcndvVE42aGkwZk1LRTlYcWxjZE5SVnJWL0ww?=
 =?utf-8?B?MUdJU1pmbTlKRFRRa1BieXBTakY0MFVvZ0hTSGFKZ0pOTDZJcm53b3RoeGh3?=
 =?utf-8?B?TzNuczJqUjVkYU44ZVhFZnFPa3ZkM1Y0aS9LV1UxdDdodktCUjMxSmt6d28x?=
 =?utf-8?B?b21DWmJmeHQvMlVJQWFiRGYxbWdCS1ZJYnczaWViK0lyVTRjMUdoblJYY2V2?=
 =?utf-8?B?SWQ5M1hUTGduWGh4VFpFYXRTY2JRb1V4LzBQcWNqVDNEajRBWi9JMnAwZzd1?=
 =?utf-8?B?YklteVpCVk40WTk5ek9IYm04K2d6L0dnUXVacmpzWWpueDdBeGxYcmlHS2U0?=
 =?utf-8?B?L1Bsc0RzUThoQURBbCtzc0oyWlgrcFNPV3FhZWZaeWFCMWJwYWNNMCtabUxX?=
 =?utf-8?B?OGtselpmVFhRL3ZEeXZCSWNwZ3QvUXRwUkVDZkRvMEZUVlgvN0ZCeHB4c0Jn?=
 =?utf-8?Q?fXyJMj3kf70RDfcK7YBnPyx+LT0gxFZu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR08MB7358.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkZBWWxuMHUwWXlJWlg4QVlDVjVWS2xJQ1QzOVUrMU5oR1VlL0V2U3p3emZh?=
 =?utf-8?B?aGcrRVJFaDZuM0xKY3NCUnZXWDZKTWMzaWdHS0RpdXRKT2ZXYmIvVEtqNHdj?=
 =?utf-8?B?Q2xpK0dEOVNMRVZHVE55VG5ySnNDcTRBaVgvalF3QWtncVpRNjk5d3FRVVRM?=
 =?utf-8?B?VFdFZkc1Z2x4b0hheHBqdGVERnFBa2JBSy9FQ0FobXErMGxFK2YxUUhUcE5Q?=
 =?utf-8?B?RzZBNzdJR2FNcmlvUjYzN0dhZTk5c2w0UXNvMWljTjVEaGtvaGhGU0ZtUkRN?=
 =?utf-8?B?a0tYSXYrNnJHQmhBNjRSeGNDRGJWUTZremNhQjZ4MlFRTFYwcEx5MG5ta1g5?=
 =?utf-8?B?NG1oMUFmUFdaNkdzdVJ4QisrQ1diekRZY3ZKZXFsWWlZQ2pHb1RwNWs0aWgv?=
 =?utf-8?B?OWFKSUpNVGNEVGFPRE9SQTFzSFFxZ2szMjcwTnB2bjlxd0YvSnIrUTRKWkhF?=
 =?utf-8?B?NGhVZjczWkRsZmR6ODZ0ajJaOE8rbC92MUVVU1BJbi9TRllDWUtLNmh5U1Vh?=
 =?utf-8?B?eUZnM2FJWXpzRDFxY0hnMnQ3aHFoNElUOVUrTkZ2K0tENEhETFFybnM5enho?=
 =?utf-8?B?V05DU0dyQXFoVGtjNnRCZFIzZHloVlkwdG5PQzNJOE5jTENySEpJWDNvdDNH?=
 =?utf-8?B?NUJSa2Mvckh0cmJlaHdVL2prenRoREFaMHlVd2hhTWxXRTRaU3FKbHIvVUxv?=
 =?utf-8?B?OEdRbUR3WGUvWlVvQ3B4NXB1REd4RTBsM2RnR05jNFlPV0pGUlBsR2RDRFh2?=
 =?utf-8?B?YXpvbk9LNmhVTUdXVnJHc2hSUE9GTE9Jc0lkWkpSVjNRUWFtVmxVSTVLUitF?=
 =?utf-8?B?bmI2SXhmc2NUeGpjYStha29UVTlJZFVYRy9xZlZ6ZWZ0RXdibEw4d2pneWZN?=
 =?utf-8?B?ejVXQk54RjhiK3MwajlpMXdSUWMxVnh3UitjN2NMMHZRdHRjNVAyejBPNTQ5?=
 =?utf-8?B?S3JzTFZWN2Y1MUEwLzc4eE4rcFZOL3VVZmliL1RnWFNWaURHZk5ZOTYyN3Fz?=
 =?utf-8?B?UnBSOFl3ci9FZVNaTnlhRkQ2VlFpUGtJT1NPSm9ENGdtYU8wb1FtUHc4YzBG?=
 =?utf-8?B?Q2Y0ellWa28vaitIK3BJK2ErSmMrcFRLcEhGSFM0K0JxMnJzaDN2K0V2bS8x?=
 =?utf-8?B?SUZ4cS9wWlkwUVF2UXQwdWxleUllTm0rK3BLQ2labWlxTnpIdFpIeUJwZjhD?=
 =?utf-8?B?NmRvSFdBRUlvaXkvYW1tTGN4ZUhLVUlnSlVzZm0rRW1OOFVLVVlOdjh4a2ov?=
 =?utf-8?B?TGVDRi9KL3o4ZXUrZk0xeEpkVHM3dE1NSkxzSmxsMG52UGE4b05zQ3IrZFls?=
 =?utf-8?B?SGVvV2hCa2s4WGpLZTMrQ0xsWkpKVW4wZmtHeGdFRFlqTDhNaS9DWTlBZ0NH?=
 =?utf-8?B?OTdJaGtsUVF5UkwzQUxaaHdDM3ZISjQ1eHlWN1Z6UmlKdFMyUnVHNWV4VDdq?=
 =?utf-8?B?Mk80NjQyMExOeitVaWx1TkZyM0xBSjVoNFE0VlIzcFgycFVHL0hrbmlrbldr?=
 =?utf-8?B?MHdYWVRMMFJVZ25LcVRBU1NrT1lHM0tRU3JBSDA3MXk0bW5sK2dRRGJhQWlu?=
 =?utf-8?B?cWU0SitPQjZmZGFZSGU3ZGt1aHJzbHpLQ0E3YUtNNlJrTXBVcnJYNGF3emZK?=
 =?utf-8?B?SmZvVXh4eTN6SW9WT0QzYnlRMk1EQzdTV2puUmZxbW9tQ2lpUkpYSllqMWdt?=
 =?utf-8?B?L0k5RXBScnJnZ2ZQQ0ppaEtoQkRSRERVVUNaUU9ZVE44SkpVOE96OTZueEox?=
 =?utf-8?B?eVkwTy9nU2x4T0NWSFNVNU9GUFQreDc5RFd6M3I0STVzL1dZaTJ6N1RHT24v?=
 =?utf-8?B?RjJQeG9mVXpFTll6bTByV3pVWXlTVU1lYmExT0sveFpiWHpwbGY3ZThTUnRJ?=
 =?utf-8?B?UHo5WDI0YVoyK1E5TEg1ZjNMdTdML3YxbWt0bTZoVEI1bnY1ZU5Tbnl3ejJT?=
 =?utf-8?B?aTlwSjNLeUFaRDBzc3B4c1BRQzJOTzBzdVhQSVhrOVM1OEtyWlJXUU1HV0Rn?=
 =?utf-8?B?b0xoL0dYaEhxQmhQK1RRU3RuLzlLMDJ0azEzWUFzZjM3Yks2QkVmVFp6Mjgr?=
 =?utf-8?B?ZXo1bzBTaWF1V0ZDQXcwd1lKWkNDUTB6TjQraEh0QkxaV3d3Unh4WjJRYTZ0?=
 =?utf-8?B?YTdhcGUrZjRwT1U5aDhuOEJpd0NNcDdOQzBlUzJqeitFQWtrV1lJdVJzbktm?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB7358.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e6d6c3-a7e4-47d8-26b4-08dd5652bb73
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 10:45:48.8276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uR5ljoYlxsy+ENU+i0vN1ODYx+xzL11MUhDMbNAGNIeGyOsmybL6Hn3RshbGVSszyRhHzK95A5AXcquYnRrU0v7Vs1+Dmgz3f3RljjIW+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9062

SGksDQoNCj4gLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246IEphbiBL
aXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+IEdlc2VuZGV0OiBNaXR0d29jaCwgMjYu
IEZlYnJ1YXIgMjAyNSAwNjo0OA0KPiBBbjogWGVub21haSA8eGVub21haUBsaXN0cy5saW51eC5k
ZXY+DQo+IENjOiBKb2hhbm4gT2Jlcm1heXIgPGpvaGFubkBmYW0tb2Jlcm1heXIuYXQ+DQo+IEJl
dHJlZmY6IFtQQVRDSF0gY29iYWx0L2ludHI6IFJlc3RvcmUgc3VwcG9ydCBmb3IgSVJRIHNoYXJp
bmcNCj4gDQo+IENBVVRJT046IEV4dGVybmFsIEUtTWFpbCAhDQo+IA0KPiBGcm9tOiBKYW4gS2lz
emthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiANCj4gVGhpcyB3YXMgbG9zdCB3aGlsZSBw
b3J0aW5nIHRvIGRvdmV0YWlsOiBTaGFyaW5nIGJldHdlZW4gT09CIGludGVycnVwdHMgaXMgYWxz
bw0KPiB3aXRoIGRvdmV0YWlsIHN0aWxsIHBvc3NpYmxlLCB3ZSBvbmx5IG5lZWQgdG8gcmVxdWVz
dCB0aGUgcmlnaHQgdHlwZSBmcm9tIHRoZQ0KPiBpbnRlcnJ1cHQgY29yZS4NCg0KVGhhbmtzLCBp
IHdpbGwgdGVzdCB5b3VyIHBhdGNoLg0KDQogICBKb2hhbm4NCg0KPiANCj4gRml4ZXM6IGIxZGFm
NTViZGZlZiAoImNvYmFsdC9pbnRyOiBkb3ZldGFpbDogaW1wbGVtZW50IGludGVycnVwdCBtYW5h
Z2VtZW50LA0KPiBoYW5kbGluZyIpDQo+IFNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+IC0tLQ0KPiAga2VybmVsL2NvYmFsdC9kb3ZldGFpbC9pbnRy
LmMgfCA3ICsrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2NvYmFsdC9kb3ZldGFpbC9pbnRy
LmMgYi9rZXJuZWwvY29iYWx0L2RvdmV0YWlsL2ludHIuYyBpbmRleA0KPiA4ODExNmM3Yzg5Li4z
NDJlYjRjYWZkIDEwMDY0NA0KPiAtLS0gYS9rZXJuZWwvY29iYWx0L2RvdmV0YWlsL2ludHIuYw0K
PiArKysgYi9rZXJuZWwvY29iYWx0L2RvdmV0YWlsL2ludHIuYw0KPiBAQCAtODYsNiArODYsNyBA
QCBFWFBPUlRfU1lNQk9MX0dQTCh4bmludHJfZGVzdHJveSk7DQo+ICBpbnQgeG5pbnRyX2F0dGFj
aChzdHJ1Y3QgeG5pbnRyICppbnRyLCB2b2lkICpjb29raWUsIGNvbnN0IGNwdW1hc2tfdCAqY3B1
bWFzaykNCj4gew0KPiAgICAgICAgIGNwdW1hc2tfdCB0bXBfbWFzaywgKmVmZmVjdGl2ZV9tYXNr
Ow0KPiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MgPSBJUlFGX09PQjsNCj4gICAgICAgICBp
bnQgcmV0Ow0KPiANCj4gICAgICAgICBzZWNvbmRhcnlfbW9kZV9vbmx5KCk7DQo+IEBAIC0xMDUs
OSArMTA2LDExIEBAIGludCB4bmludHJfYXR0YWNoKHN0cnVjdCB4bmludHIgKmludHIsIHZvaWQg
KmNvb2tpZSwNCj4gY29uc3QgY3B1bWFza190ICpjcHVtYXNrKQ0KPiAgICAgICAgIGlmIChyZXQp
DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgI2VuZGlmDQo+ICsgICAgICAgaWYg
KGludHItPmZsYWdzICYgWE5fSVJRVFlQRV9TSEFSRUQpDQo+ICsgICAgICAgICAgICAgICBmbGFn
cyB8PSBJUlFGX1BST0JFX1NIQVJFRDsNCj4gDQo+IC0gICAgICAgcmV0dXJuIHJlcXVlc3RfaXJx
KGludHItPmlycSwgeG5pbnRyX2lycV9oYW5kbGVyLCBJUlFGX09PQiwNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgaW50ci0+bmFtZSwgaW50cik7DQo+ICsgICAgICAgcmV0dXJuIHJlcXVlc3Rf
aXJxKGludHItPmlycSwgeG5pbnRyX2lycV9oYW5kbGVyLCBmbGFncywNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50ci0+bmFtZSwgaW50cik7DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9M
X0dQTCh4bmludHJfYXR0YWNoKTsNCj4gDQo+IC0tDQo+IDIuNDMuMA0KDQo=

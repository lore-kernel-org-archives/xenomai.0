Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD763EDAA6
	for <xenomai@lists.linux.dev>; Tue,  7 Jul 2026 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421473; cv=fail; b=gbaxm78LJVSIMUy/nV0Gm4hICOFiiNq9VKWOtQ40hLs0VY29W1yZHHQSl9lH5ZqOfjw0YNKsGZ+t4PVxO7P+woLv77MhPydQqOSeaKyMAmpZSAWIrYoq/sMYbD5tKM7ANlw5Zc12Fm4TkjVeCFVWO3Mr3Dhq/ASgMjXhl1CEawY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421473; c=relaxed/simple;
	bh=y6+oZVG0OkVh+ZkTigF6V3MsN97CygVYVJy0LM+L6nA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sKayd8I6eTeSS7zoD4fq6F9xxXURBG1WDmEpMCSqYybJiGt4ug/7gl8JaAtWjBVottMuRjvzlqVxtqNLvdZRLFEM45D5j+vzTgFaGeh7E5pydhxeQ9nFPn3NrsiUJjufU4EA2uIl9k+6dDBBghmOO1ezNffDR9pPIRD+UnL8yTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tKBGNAHc; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tKBGNAHc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXU++0N7jCsp6JFimqH1T/ZfNN/mCc9i9b2LQPd3zlpqQaw+7Y9Q77lMzeEtTdHuBng1W8Qp++4eO5gukfd4+Djx6hG/+J8lfl0ooZ8cWSoUMlvlNYoiGwCWDB6Boyn2TwXcJbiV4qiiQEdsIw+qRzU/NLKdjn0xwzxgtM7SEP+5aN4y/JY1cM6ux/iMaE14LxFqJq4CnQRpJTaVG8VCeg9Cf4pmxGz1iY6fXERMOhraWoEBW+6fuMOsH1mYm64fN1jxjJIXW6Ql81Bq4UJGrkXixSpyfiQKIUaLrNcGzzVdyPqGC+qFxK1AV+lKyrgKMCYalw6y8o/aGBdcm3SkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6+oZVG0OkVh+ZkTigF6V3MsN97CygVYVJy0LM+L6nA=;
 b=Snbeqz3jOAMe5ED6CV5tvqerEbLu2dAyW2jvufJsEZ+fXSXF8o7YeGmsGmuxf2d6NnKW2HWGMwJpLf6T8nPGGO+PhTft6gPlLhz4htYoTyhysu4d0ukJTKnBrCaSDwnw1NvyzAqx4GxskKW5oItYh/Su3a7hemukJANJt+MvGYeA0aIDOLPqfOpH0BfVxVf9k9bOIXxxWakTlQC5Tt/wSA9CmK1/ItmWLqYZGfXYOsHyyWWdWX+Pwuy8NytYu2kyBaGGcakA8U4bd1cOJCER7MkhJuwPXjmu27W/k1zK33iarNQU5bbMEJ6usHFjyoWXeKXjczuCgVThDJh4wr30jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6+oZVG0OkVh+ZkTigF6V3MsN97CygVYVJy0LM+L6nA=;
 b=tKBGNAHc8TopRPneT7FwsjBLkaXTiOBOT1rZWqMeA6u2VORX7JXayGo/WPvNzqX2wf1CzQV/kDiPrRzJpIGXQQN9C2LDRTBmqPvB/jht38UtxGx8to1VTrfGpw0YBU0YKx0itNicPyG3qZzWOb9/NlFlJgmTlLLerYWhaFLTB8KPxwKoZGyuwnS0LbaShwT67qD0o5usyLtUMm2pyHal5wSoX2zCnfeSKn6SFAKDVmQ5hWnrhJooR7NefQ+Jw6oyqIhmjU1fE/cqig2RW9MOH3Us0Vg6uttp/xQx4f461ls0Pic2bjX/uG5sIih5QNOC5+6R0HR33yhPtm7AfRzvTw==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB4PR10MB6286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:382::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 10:51:05 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4072:14dc:7d1:74c7%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 10:51:05 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "Schaffner, Tobias" <tobias.schaffner@siemens.com>, "rpm@xenomai.org"
	<rpm@xenomai.org>, "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [PATCH dovetail v10 00/11] riscv: Add dovetail support
Thread-Topic: [PATCH dovetail v10 00/11] riscv: Add dovetail support
Thread-Index: AQHdDXVmJO3pnsbAREOx9cwAqVjXgrZh1KEAgAANdoA=
Date: Tue, 7 Jul 2026 10:51:05 +0000
Message-ID: <8bbe1df3070e3d031950851525c67386b03cd1e9.camel@siemens.com>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
	 <aea1bc068740212737bd02d3b6317dac1eb8fbc8.camel@siemens.com>
In-Reply-To: <aea1bc068740212737bd02d3b6317dac1eb8fbc8.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.60.2 (3.60.2-1.fc44) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|DB4PR10MB6286:EE_
x-ms-office365-filtering-correlation-id: bf2426fb-2432-4ca7-8d48-08dedc15a512
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021|55112099003;
x-microsoft-antispam-message-info:
 dJ8dwYq9GTbJDqAeWYCUs0L8ROS78UO7hiF3tpobq52x4/Fcji3I1UElAQv42Q043o/SxIMHSnbQ8PmWf+cFzp6uW0uS8vh6JE/I0R1DcqVypB4MFJCmBkHqRY87kCGrJQ9ylIuT+F7mzvfuUWOQJLGbwsb5ewE9EMHY8/VAN8uQcMsULoOJzkVRV8MUW9oyX2S6Sx8HNr+hUuD71W1nKGFq3vRQOlCArCGWpLuAsJLCr0yXJ0SujJQWpxdI4OOd7o7MSBAo2WSAKapi53ClJJm91dO5nHo0bQmAxoaar8GbqlgBRb/CwKYzsrOK6WK4sAM3ee4a5GbwTOqg7pCLBt5uT6M4QBjgyrvVNToxfk6t+gW7/AAkhHPkWfM3ORQdKiHZfV9CbunmsI3cN220q8Dbp/Vl8jBcQQuZ8KkAuBOUPdkjTCpEFs5ZLkWBhqz5RAgq6y5cvo6z1W/GDM2wSYHHOeuGenV3Ikg0lapGAfPOa0QgQdlFvVKvHpM3oErL+9eO4+hR592R0ZTW1wuFcwcKCGyMGL6cM7kLJNRHqYZdscmJuaMtruypn5p9XN8rumq6WU6RcdRUoaR1q+6Ado2G67/DTqxsxoC6/gNE9/zKHYfEZWK04tq+p7n4ubiQn3/6ejuzlVH4rnNXToPGAIARhk0ve6sxTfGGCzHnwxjB0q4mSQ4cv5ySmpfvCJg9pXpV+73BRqKhj5ZrCZkd2v6izc8x3J9RN+LSZGXieJw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2xnL2VhYWlKakpTMFlvVmdic0p0M1l3eDJjL05KZTU4OVdESXRpVUhZZ2xU?=
 =?utf-8?B?bnQ3a2pqdFY0MCtGM3B2MjZRNXBlL2svU29KMnJoQ2Z4Zk1uL1JqRHpmdDU2?=
 =?utf-8?B?Um1MaXN3azRXRFlHWjIxRDE3anZsMjdjekV4ZW5OMTZXMlY1VjBueWcvMDN5?=
 =?utf-8?B?dStFTElkMFphZ2E5cTlkd0NtR3F1WEpYM0xjanZDdG05TG9wTVdjYmwzYzQy?=
 =?utf-8?B?V2pkVys2RjBmSFUySUoyZE42THR2dW5PZjF6cnAwditSTUNJc05wRXVsSnEx?=
 =?utf-8?B?RHhRbGRKby9aQWUwVXUrc0VPVVc0ZUVJUlBzdERUVXN1dXBCUmlja1ZONmZp?=
 =?utf-8?B?dFUvc3hoRWs4cTVVbk81dHFoSW5kQ0RvL3VteVdlSVI1ZVdrL2VFMkEyemlQ?=
 =?utf-8?B?V0tSVnBkT2FqVWtFR2RydEVPM0REeXdqZ1haVTVVSTd3b1hBcjUrRXRNV0NP?=
 =?utf-8?B?NzdOQ3BGYnJSTlZWUlk2Nm5yU0lmSWxUUkJ6cVBtc3pOSHdzT3RPbnRHVHFG?=
 =?utf-8?B?THhObE5RWDJIMHpjWU1JNjBURXdLTldQV3luQWZqMVFSZEVXZWlwWDlBZ1o3?=
 =?utf-8?B?emlFRHNSYnc1Wnl5NExjQWF3ZnBsOUF6OWNzb1pvYzB2RDFwcy8waG4wYTJt?=
 =?utf-8?B?OEQzZmxEWHVIL0VZM3pZUW5jbHdraEVzSG03a1dzSVY2YU9WMzMrb0ozWmg4?=
 =?utf-8?B?WUFtd2VRRDVrb2NuSVRiSXl1Z2lEYzJhbXJiTitMZXY3NEI5ZUlNMXhIUmFB?=
 =?utf-8?B?TmZIbkQ5WE5QV29waDBDZTFHV0l6Yy83R2V3Wm9hbmlJU3ZJeWp3WVlmTmVw?=
 =?utf-8?B?eFlxaktoRHViUXBuRlhHaXkrYVEyVElvN1ZpYWpLM1pYUzZOMHBVOWZqMnBx?=
 =?utf-8?B?bER5aUwxaGt1YU9nZE8xcElUNW1pOEsrY2ZyV0RNTS9RRGVqVi9GYXlvT0Fz?=
 =?utf-8?B?YzNxT0N2cGhaV0NST2pLWjZkdE9jcHczSVdkWHJhYWlBV2dTVysyWEJ2ODlq?=
 =?utf-8?B?MmJ2S0tTRGgwWjZXaGI5di82MlE3VndaT2lmYnBjZG5NTWxIcGxNVkQ3UEpW?=
 =?utf-8?B?cGVsQnBjOWNFaHJiU0xYL2Jydm5XMWM1K0tNZVRicWFSZ1NwRlFPODFPdGto?=
 =?utf-8?B?KzMxVEZLc01hckdtZUxiYkdKREpLbklHRzlJTE1LYk1CWk80cW5YQ3FvRTdF?=
 =?utf-8?B?RERUZVpDSHRCVHdHZ0I2UmdFOGFDMTBFZ3hYdDF4ZDgwdkRSTHpLaDdFaDZt?=
 =?utf-8?B?UjZxMm5KdEY5eVl2YTJ4cHg4MzZyaUlCc3BiZ1ZwNm1sQkljaFFZNFViaElz?=
 =?utf-8?B?c29UU3R4c3dNQTgrVXdjeVhUNXB4OFBWUjNQU21IS2dZYlVNNUdXK1NjYTBF?=
 =?utf-8?B?bUs4aG1zb3lmSlEyMm5jYzk5OGtlM25vNW1zVWZmTlN3MEpkdmV1Q1ZCcGps?=
 =?utf-8?B?Uy9jRzF5RW1YL00xMXZRWm8xUTk3cCthWFFzS0MvT0lFRitxTVM3RVpjOG1m?=
 =?utf-8?B?ZVd3Q1hpbkFsWjZUWWU3bkhjTFJSdDFIN1lWVnF0bFNIU2N0dzFMQ1FXdUcw?=
 =?utf-8?B?Nm5ERHVEYkljMmVJVnZoSHNEbDhaZ3BxUVFhRnZsYTFPWEdLaE12d0cvTkVS?=
 =?utf-8?B?alREODA0VyttcGJCUUVxZktFQW5QNHFCeTlteHA2M0RKS3M0MVE4OEVtY2Qx?=
 =?utf-8?B?bDBMSnJiWVBOeTZIdm5MSlBsT1ROTHdLckFUdFhZNlI4eEYzaXZkY1VXb1A5?=
 =?utf-8?B?SDFNU1BlMFNoanQ5bW4vOVdXaGhCM2hWdUVlZHI3eWpWTjkwRjhmaXk5K0Vs?=
 =?utf-8?B?Y0R6TU1qVHNUKzNhS0FGak1JbGZwM2VUN2x1b1JWN0IyN24xdGtQOUkyMnIz?=
 =?utf-8?B?RGI4T3JkL1dCWlozV2hYWEFzRlUxL1VVNis0U3NNZjc5MXowcW5YZHh5SFZX?=
 =?utf-8?B?eG9jN0FXeTZqdkl5TTVwSVV2UWgxaFhGN3ppTkJPc3V6a3FFYk43UnRtWnlw?=
 =?utf-8?B?SS9wR0tqTTlFaTdONHZQS09oenpzWnk4VTg2UHRSK0dXemNjcnpMRHg0Nk83?=
 =?utf-8?B?RmdSZVBTYVdsRS9zR3FuSnJiTUxPZ0lVWnM3MTJHOXd1Vnl3VXdTTHc4a2VH?=
 =?utf-8?B?Um5uRC80alpHdFc1cHpRT0JGVldJNHhyc2k3Qys0SDAwV05WNkltM1BHUzQr?=
 =?utf-8?B?WFZvbnZScGJkQlNNLzllRlhVdk9tYWs2UzBuY2t3b1lOai9oa1JxRDZNQXk2?=
 =?utf-8?B?aU0rb0xxTU5uK2RIRkNveDh5Ui9kVHcrbjBzSkhtMTFtSUg3OWdtSGxGaGxS?=
 =?utf-8?B?eURxaFVhZmliMTFOK3hFdFRQazhzbDJzMDZaY1JFVFo5RDdKdkN0dGt2QnE4?=
 =?utf-8?Q?BDzUIYUIg1DZsnYs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <891309A4708D2547BE75E12739A02341@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2426fb-2432-4ca7-8d48-08dedc15a512
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 10:51:05.4215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrjxYW57dC4fUvRuOob4PJ28jLoqQpgGsV1maiCKKRdedyuo8C3JWyoFyLW16aqCdnDFHAe8x+MLRUyxU3aXmQD4v2qVMNjXMiaMrbLTdMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6286

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDEyOjAyICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIE1vbiwgMjAyNi0wNy0wNiBhdCAyMDoyOSArMDIwMCwgVG9iaWFzIFNjaGFmZm5lciB3
cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4gDQo+ID4gdGhpcyBzZXJpZXMgaW50cm9kdWNlcyBpbml0
aWFsIHN1cHBvcnQgZm9yIERvdmV0YWlsIG9uIFJJU0MtVi4NCj4gPiANCj4gPiBGZWVkYmFjaywg
c3VnZ2VzdGlvbnMsIGFuZCBlc3BlY2lhbGx5IHJldmlld3MgYXJlIHZlcnkgd2VsY29tZS4NCj4g
PiANCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+ICAqIERpc2FibGUgaW5kZXBlbmRlbnQgaXJx
L3NvZnRpcnEgc3RhY2sgdXNhZ2Ugd2hlbiBwaXBlbGluaW5nDQo+ID4gICogRHJvcCBLVk0gY2hh
bmdlcyBhcyBsb25nIGFzIHRoZXkgY2FuIG5vdCBiZSBwcm9wZXJseSB0ZXN0ZWQNCj4gPiANCj4g
PiBDaGFuZ2VzIHNpbmNlIHYyOg0KPiA+ICAqIFJld29yayB0cmFwIGhhbmRsaW5nDQo+ID4gDQo+
ID4gQ2hhbmdlcyBzaW5jZSB2MzoNCj4gPiAgKiBJbmNsdWRlZCB0aGUgSVJRIHBpcGVsaW5pbmcg
cGF0Y2hlcyB0byBoYXZlIGFsbCByaXNjdiBzcGVjaWZpYw0KPiA+ICAgIHBhdGNoZXMgaW5jbHVk
ZWQNCj4gPiAgKiBSZWJhc2VkIHRvIGRvdmV0YWlsL3Y2LjE4LnktZG92ZXRhaWwtcmViYXNlDQo+
ID4gICogTWVyZ2VkIG1vc3Qgb2YgdGhlIGZpeGVzDQo+ID4gICogRml4ZWQgSVJRIFN0YWNrIGhh
bmRsaW5nIGFuZCBlbmFibGVkIElSUV9TVEFDS1MgYWdhaW4NCj4gPiANCj4gPiBDaGFuZ2VzIHNp
bmNlIHY0Og0KPiA+ICAqIFJlYmFzZWQgdG8gZG92ZXRhaWwvdjcuMC55LWRvdmV0YWlsLXJlYmFz
ZQ0KPiA+ICAqIEFwcGxpZWQgc3VnZ2VzdGlvbnMgZnJvbSB0aGUgbGFzdCBwYXRjaCBzZXQNCj4g
PiAgKiBBZGRlZCBzdGFyZml2ZS12aXNpb25maXZlMiBib2FyZCBzdXBwb3J0DQo+ID4gICogSW50
cm9kdWNlZCByYXcgY29uc29sZSBkZXZpY2UgYmFzZWQgb24gc2JpIGRlYnVnIGNvbnNvbGUNCj4g
PiAgKiBSZXdvcmtlZCBwaXBlbGluZWQgaXJxIGhhbmRsaW5nDQo+ID4gDQo+ID4gQ2hhbmdlcyBz
aW5jZSB2NToNCj4gPiAgKiBSZWJhc2VkIHRvIHRpcCBvZiBkb3ZldGFpbC92Ny4wLnktZG92ZXRh
aWwtcmViYXNlDQo+ID4gICogQXBwbGllZCBzdWdnZXN0aW9ucyBmcm9tIHRoZSBsYXN0IHBhdGNo
IHNldA0KPiA+ICAqIFVzZSBtYXJrX3RyYXBfZW50cnkvZXhpdF9yYXcgZm9yIGtlcm5lbCBtb2Rl
IGV4Y2VwdGlvbiBwYXRocyB3aGljaA0KPiA+ICAgIHVzZSBpcnFfbm1pX2VudHJ5L2V4aXQgZm9y
IG5vdywgYXMgdGhlIG5taSBpcnEgaGFuZGxlcnMgZXhwZWN0IGhhcmQNCj4gPiAgICBpcnFzIHRv
IHN0YXkgb2ZmLiBUaGlzIG1heSBiZSBiZSBzdWJqZWN0IHRvIGZ1cnRoZXIgb3B0aW1pemF0aW9u
IGF0DQo+ID4gICAgYSBsYXRlciBzdGFnZSwgYnV0IEkgZG8gbm90IHNlZSBhbnkgbmVnYXRpdmUg
aW1wYWN0IGxhdGVuY3kgd2lzZSBpbg0KPiA+ICAgIG15IHRlc3RzLg0KPiA+IA0KPiA+IENoYW5n
ZXMgc2luY2UgdjY6DQo+ID4gQWRkcmVzcyB0aGUgcmV2aWV3IGNvbW1lbnRzIGZyb20gdGhlIGxh
c3QgcGF0Y2ggc2V0Og0KPiA+ICAqIEtlZXAgdGhlIHZpcnR1YWwgaXJxIHN0YXRlIGluIHN5bmMg
d2l0aCB0aGUgaGFyZCBpcnEgc3RhdGUgaW4gdHJhcA0KPiA+ICAgIGhhbmRsZXJzDQo+ID4gICog
Rml4IGlycV9uZXN0aW5nIGltYmFsYW5jZSB3aGVuIHJ1bm5pbmcgd2l0aCBkaXNhYmxlZCBJUlFf
U1RBQ0tTDQo+ID4gDQo+ID4gQ2hhbmdlcyBzaW5jZSB2NzoNCj4gPiAgKiBTaW1wbGlmeSBUcmFw
IGhhbmRsaW5nDQo+ID4gICogUmViYXNlIHRvIHdpcC9mbG8vdjcuMS1kb3ZldGFpbC1yZWJhc2UN
Cj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNlIHY4Og0KPiA+ICAqIEZ1cnRoZXIgc2ltcGxpZnkgdHJh
cCBoYW5kbGluZyBhZHJlc3NpbmcgRmxvcmlhbnMgc3VnZ2VzdGlvbnMgYW5kDQo+ID4gICAgcmVj
ZW50IGZpeGVzIHRvIGlycS1lbnRyeS1jb21tb24NCj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNlIHY5
Og0KPiA+ICAqIEZpeCBjaGVja3BhdGNoIGZpbmRpbmcgaW4gcGF0Y2ggMTEgInJpc2N2OiBBZGQg
ZG92ZXRhaWwgc3VwcG9ydCINCj4gPiANCj4gDQo+IFRoYW5rcywgYXBwbGllZCB0byB0aGUgZm9s
bG93aW5nIGJyYW5jaGVzOg0KPiANCj4gZG92ZXRhaWw6IHdpcC9mbG8vdjcuMS1kb3ZldGFpbC1y
ZWJhc2UNCj4gZXZsOiAgICAgIHdpcC9mbG8vdjcuMS1ldmwtcmViYXNlDQo+IA0KPiBQaGlsaXBw
ZSwgZmluYWwgdGVzdCBydW4gaGFzIGJlZW4gc2NoZWR1bGVkLCBleHBlY3RpbmcgYm90aCBicmFu
Y2hlcyB0bw0KPiBiZSB0YWtlbiBvdmVyIGJ5IHlvdS4gQW55IGxlZnQgb3ZlcnM/DQoNClllcC4g
SSBmb3Jnb3QgdHdvIGNvbW1pdHMgNjRhZmQxNjUgYW5kIDA2NzllYjFlIGZyb20gdGhlIDcuMCBi
cmFuY2guDQoNCkkgd2lsbCBmaXggdGhhdCBpbiBhIG1pbnV0ZS4NCg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBGbG9yaWFuDQo=

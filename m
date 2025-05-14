Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63A27A476
	for <xenomai@lists.linux.dev>; Wed, 14 May 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231066; cv=fail; b=QpEVdgl6EWDhUiCoAUN9dNiQg+ru9xQ/tSvO3O5FCDx2vWn/mZ/j1iictD0myYxdgkpOCTdlGMMv24eRheY29uS7FnsTPBflgGz9t2kZzWAWjW2Yj8N+gvGqAnrFKZHW27ycOO/DGMIOMMgUU3JRTwgpcObbUIbhRUYECmxf91k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231066; c=relaxed/simple;
	bh=NtZbz33zX3/K3M27ntm4owDF7D8xp0DE7zvx8zU+2+4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=or91nTfox1HJqjZfpQwQ9Y16zmkeJlnuvTenCifBRIMJLX+6xpv7KLCMGS1Auj0AIxBiJm1/GzqQq3qmV9W9+15coePfkcGfpovICJE/aJ/bMZpJlO8QZMBsKetXgqb3YgJDR7ZEOnFfXgAtgZIvsqaXU269C+zjWvWHlYUP62s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=DvIQTQwO; arc=fail smtp.client-ip=217.70.178.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="DvIQTQwO"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id B6948436D9
	for <xenomai@lists.linux.dev>; Wed, 14 May 2025 13:57:34 +0000 (UTC)
Received: from PUWP216CU001.outbound.protection.outlook.com (mail-koreasouthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c410::1])
	by spool.mail.gandi.net (Postfix) with ESMTPS id C3EFAAC1A56
	for <xenomai@xenomai.org>; Wed, 14 May 2025 13:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXwzYUzK9q3gl4anaAEhUSVW/ZUwm9yYxuVWGL7ysaWS3MGPuQEnBAk7FzbGuJrJpGjwsuVhf7okSXhFqUVBlq7KZ3eqNr4bfCjlJll0QwTxTx2lOWDSuolZWUpwqzLTvJkamsLmzhOliA78isq2yNZl3HKa/tz7RuNW9wcTqxOBfU1QcYIkl3BdLY27EmJWVrcQpzBUaz0zYDDuMZ9oGOD/9BEnPtCt/q+iyUw3+iEJ/KU+j9moyu9RArvLA7KMFH6Ue1ktY2oAXYlclMtUTDvwGKCxWoPcI5RJ+OFN9kJNj55D+UjA3AEuCHsj67NQcTRajOrpcj0v759rAbpM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtZbz33zX3/K3M27ntm4owDF7D8xp0DE7zvx8zU+2+4=;
 b=mnbpoZ+mbVv3j0GecqEzQMxQyDDW1kYEt4sMd3mnZ+ZlFqh3CGS9Fvjm1F9HzQb08fmY/x7jZOzdhuh5jEOuJcRqAzp8aMOwMKbVg0VIGs1NERSGTC4NvAkPcGLPz/XG9vOiD+fSlGF7DKS0baB1ADHHnX1ed0WF/UUdjOvhnfDcikxaSHaKmZJCFfUuL9o4wM6H2t2niyc6XXWdCuowvLnFMb29iw6lCUecc43RHsArbFaVpfNtUtPjjk3aP6eCmGZ1kLYksE8Z28hpisGCudzTPJmIJn035TZE3IxonPuOeGPYMe3n2xoIBT9mkVGAPwGiBzOd+CoLc3zHc8/aVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtZbz33zX3/K3M27ntm4owDF7D8xp0DE7zvx8zU+2+4=;
 b=DvIQTQwOvwJpTuKkjP4usBYMsaWZlNah4bCzE1TG47MkeJrx3Jkg5mDwAXsbQJi8ur5nXWYN1wh05U51Hj5y5eQl8UqJiypCZKUmYJVA1p9nBwQOtxenqi/V2cMOM1kGsMs5dK0u6SMr7FW4j86K72HE8lvD6g+KIdFMKT1xJB4=
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM (2603:1096:101:151::13)
 by SE2P216MB2904.KORP216.PROD.OUTLOOK.COM (2603:1096:101:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 13:57:24 +0000
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4]) by SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 13:57:21 +0000
From: =?utf-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?utf-8?B?7Iqk?= <junesoo.im@doosan.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: Please recommend the appropriate Kernel and Xenomai version for my
 hardware.
Thread-Topic: Please recommend the appropriate Kernel and Xenomai version for
 my hardware.
Thread-Index: AdvE1hezpDCCPZ86SYGuLq6OIRavHw==
Date: Wed, 14 May 2025 13:57:21 +0000
Message-ID:
 <SL2P216MB227453A028F3203C05B5A8B3E091A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB2274:EE_|SE2P216MB2904:EE_
x-ms-office365-filtering-correlation-id: a559a76a-5ae4-4be7-bea4-08dd92ef3f66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3MxSjF0VmwwbTVUZGNmVTBUQU8zQ25PQnZLQS9xWE0yTFNkbXAyMWJTU08x?=
 =?utf-8?B?UjN1KzM3bUVxY1dab08zS1FPdXZMdU9oWUh2eEtMOEFtM0FWaUlEZWVHcjlZ?=
 =?utf-8?B?VlJ1VXZCMHRVRWpxYWEvT1JhamVLUEZXYVdzcnVlYjlrL3hFN2NKb2VHZjNJ?=
 =?utf-8?B?a0NnVFc2ZGJQNTJ4YTBDTW1wRUpPWnZrMWtocFp5T2RDc0RJTkJKRThOOU9z?=
 =?utf-8?B?aDVFY0Z3KzZmWnJPbk44em1ObHZuRG80Yk1kUmZvZUd6MzkybG12ODZhczZX?=
 =?utf-8?B?YWdKSTQvWnFxc3RIblM0YmFLYTdMN1lwSG5OZ0poSjgyTGM0d2s4Z0Y2cHF4?=
 =?utf-8?B?RStaTEE2RGc5OXhTYjZBbmZyeFJINEVXTWpSM051SDc3TVNtM3cyL2Flc0N3?=
 =?utf-8?B?UVJYdFppYVhoaWt1T0FlTmorWUI4WjNPSjZ5WmRIY2RsZkV5MGtTVWJxR1NJ?=
 =?utf-8?B?S2tvY3JlTmQxYndxN1ZMVUhrUmJNMWhVa3dnOTF1bU1yQmVjYTVaVEFzMTYz?=
 =?utf-8?B?cHM2L1V0OVovRWlIaTc4c2hSR2V1aWhXWlNleG1GdldWdVZqNGZjV0VxekdE?=
 =?utf-8?B?N044Y3F2Y2FDbHdEV1R4ZHBWS01zVHBPVDNhNWM4bmZnaWEwbGo2czZMVWdk?=
 =?utf-8?B?QUlROVpyZTZ1ekNqZ3VGb1ZQb3o3eU1MbTY0YUt4bWlVYUhycVlzOWNvQm0r?=
 =?utf-8?B?L1RIeWMvd2g0a0tRMTZXcGNzVWt2UzZ5M1lTN0s3TlNva0tNNkhhcE0xd3JQ?=
 =?utf-8?B?TmdPY0xHUVBPN1FTVGR3NkFobkF6UU5iK3QvcWVqaEVIR1dZc3IwNFltZzBL?=
 =?utf-8?B?d3JIb2d3YTZWQTMzUXBsNHZJczdWY3dyZzZzbjlDaXBvVk4wWDErMk5KR1U0?=
 =?utf-8?B?dzJiS05oZDhiWnlUcTFKSWFSQjhBV1haOGhIRDRnTmMvcEw5UWQ1R2lCbGVO?=
 =?utf-8?B?M2JrREZ6RVpIMDdzcWcrMEFTVGFUeUNxZXM5UmtTam9LREJwTnBNVVpkNVhU?=
 =?utf-8?B?Q3NBVUJna0FacVVzRFk0RUk4d3cyOCtVZEpWZnlpZkthNUliN3dTdzhiSDZC?=
 =?utf-8?B?a3V0dWVDSHBtejdQRStYVWM2aHkwdm0wWGdYQS9XUzB1ZzJ4bGs3a2FjaE9V?=
 =?utf-8?B?L3l5NjlHMDVHYnRVaGM0QjBDVGFudFR1RVVCTksrdkFKZnB0cGdRc1BCSTNt?=
 =?utf-8?B?TDRRSERBVVBQYVhrOGQ4d2duRkhpaVFwSnZWVy9MQ3JLNGN5Y1poY3lZN0ZC?=
 =?utf-8?B?L04xM2ZsZytTb0JHSG1YbjZmcTNVYnlqRWdQYnErMzdOVzBKR2s1MTlBaHpO?=
 =?utf-8?B?SzlrVWNmSElPQVVRVlRNRWtYRXpEdFVXSHZRZlp0UEVBV210RVdMR3hqQnZy?=
 =?utf-8?B?OWllY2lLKzA3TkZFWTU4S3NCaTV1Nm1hc1FtekZNUVhvOXFYWGR4bkVTUk1k?=
 =?utf-8?B?MEJyelBQQ0gzQWxVK1JjYlZhOU42Lzd1SThtVFh4NWtqY2xFQmpoTXpmUFJu?=
 =?utf-8?B?U3Jhei9lakE1K01iUjA5NERIVk4yVUVQcU9jWXNqV0YxRnRTNkdLZFlvekk5?=
 =?utf-8?B?THlNM09BZEl1Y3ZzQ25vc2gxV0hLU0FycENIWmFzMkEweHEwZUZVZjI3TGZB?=
 =?utf-8?B?bUtDNXd4QVFrREVuOXdhZWhrb05BNDdWL2FRSW84Undid2N2dEdNQmVkcHE2?=
 =?utf-8?B?ZTJVLytONkdwZXRtV2UyMXd3a2VYSVhMWk95Z1NGZDVSZnBvNkVocGJHcjQx?=
 =?utf-8?B?WU1zRnJ3dTNPci9XQVdqd2dzVzlSK3VuNUhKb2tScnFnQ2ZhWUJsOEVXOStu?=
 =?utf-8?B?bjdhZDI0RUZHa0wrUFlqZGVCZEJVdlNuRVFRTDZJRmd5bTlJSGI2bmxDNDhz?=
 =?utf-8?B?TkI0T0JmamplU3VlSjRpdWgxUVl2Q0ZEdDl5SzI1UTlyRzBOQTVwNDlVZjYx?=
 =?utf-8?Q?YvOAmGMElBs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB2274.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djkzb1RRZUcySzVHb1N6VXpPdTArdi9TYUVpVmZMSHBQbG1rU2hiMmUwQVhw?=
 =?utf-8?B?eGVlVHE4dXg4MnBCVUNkbU1mbDlNbGdBTFhEVUlEcVFweFJLbnN3WG1XZngr?=
 =?utf-8?B?Nzg1MEdVV1RmT0tvVU9CNnQvK2pqYm5vaTBReFZ6b2h3YlQyWGczZFc1SFlr?=
 =?utf-8?B?VWJFS3ozMUcrRWZyMG1HcjZCK1E4VWoydmlWNUY2K2FRbnQ3S216dlQ5cDlq?=
 =?utf-8?B?R0Fnd1RBai9jM2svMHR3Ui9zRC9YRG9qdXJSakU1N01RM0d3VUY4eFU0WTB6?=
 =?utf-8?B?OGNsMlQybjVxekpDbysxVFNERmx4eTNyZ0diNmV1MGoxZHBCVUtpTVFoaDVC?=
 =?utf-8?B?OVRscm5STE83OTFTNVRmT3V4WDFieTZxQXRJZG1NTkVUMGdmdXRxeVcvUTVx?=
 =?utf-8?B?RGZ3VlhGWHJ3dms3bWEvRkFqYUFEOXhwNElzTmRNNDlvcHZkWVlTZFdnUUlQ?=
 =?utf-8?B?aXAweXRUNktYeXNUbFdZVzNvZ1VhblFwTE1lZVN1Vjdib1FHZHlkUi9ML1BS?=
 =?utf-8?B?RkpSRC9aOU42eFZQK1B3VGhhaWxSR3RkSThIcjlnSm83K0ppWlF3Rlk0aVVW?=
 =?utf-8?B?OE9XemhrajZJbk9qTVdRWWwxT3VQMkI4dlY0YXUrNDU0dVFpVXBwSUdwalho?=
 =?utf-8?B?NzBZVmh4YW43bkg1L0NrYkxjRHk4c0U5dWF5cWN0eHFvdlY3b1ZxeG1KekY2?=
 =?utf-8?B?MUZPVGpvZUEvTk82YW5VcFBSdWJpdzdGUm1FbUFvSktCd2p0TFFwTW13VlE4?=
 =?utf-8?B?eWtjdktmSDVod3RPbkRFay9zZ0NxUTJlN0UrdlpDSEZnd3dQcWdaYURoVHFH?=
 =?utf-8?B?RE9TWTR4dUFId2ZuQ2VZK0V4aUhhT2NSR2M4VTRhZXdjYzl3N1dTNWllNkxE?=
 =?utf-8?B?aWFNU1VMZUNSY1NZOGhhQ0ErWHIwZm9lcjVrTWpocDRUTzdiRi83RGJHVFVi?=
 =?utf-8?B?M3NRWTlZRVFjTlE5SWY3VnJvQkFwV0x3TFRsZHVhWTlIajRyWkE4S3ZUMHNp?=
 =?utf-8?B?NFlwTVpxUmRDc3lBcUw5R2Q0RHlXYVpIbUN6VDk0bjJ2dDU3UnQ4YVhINDI1?=
 =?utf-8?B?MCtRdE9vVGFDR3Z4em5aTUh6TG02enM5WlN0M3ZwNTBWR0NaY2ZWd1NSZWs1?=
 =?utf-8?B?ak9uM3F4UFpZMStZSE5WeG5NcDkvLzd6QTdCYml0ZXUxeHhoRlI1elRaTk51?=
 =?utf-8?B?RW4zMCtHWXZ2ZGJFRUltaTQvcFA0NEVUV2NqSU1nZDhzeFUyUWpESXRWOGx4?=
 =?utf-8?B?RlZ6elhEUy9ETlVDRVpBWDhYaUdqb1ozT1dRYTRUb0V6cE9iNGpTa2ZGZW5V?=
 =?utf-8?B?SXFhMWdJQW1RY0lTdDNWMlRNMk50NXBsMDRIcGtZOEw1TEduNysrM3Fubk8y?=
 =?utf-8?B?QXNJekJucEV6R2VtOEpaTzYxOFc3UTE3SFRIWUNlWDRSd3puVlJXT3BSYkcr?=
 =?utf-8?B?aVpWVDRTLzEzbDJydGhRQml6THd0U2RPcG9mNUhOUkRRK25GY2VjZkZNeXFi?=
 =?utf-8?B?K2QyTmQyYkhBT1Jpci85Tm9EaXBIRm5WZnBscFZyaEVNb3Z5czFMSEU3S0cr?=
 =?utf-8?B?aGc1L0owbjQyZGZ4WjM5WEFQTk9ZQTFFVWFscHExK3VYQjVGcVdpZ2JiWUNq?=
 =?utf-8?B?ZDJSUkh2R2o3cE8rUHlCYXVzamJYb25meW9kMERhRWI5NmgzWkU4ZmFkVkd1?=
 =?utf-8?B?TU1nSmh3NGpQWTJEYThNdFdmbG5JUWl5eURBRDdWNkIxVnZZQ1RMUTRWN01h?=
 =?utf-8?B?Ym5jMDRkNzRESStVVlc4ZlZGZWxsMXo0NHkzT1kvOGZ2YzAzdlByUHcvQWg2?=
 =?utf-8?B?T0dnUkVoaEs5VXFZVmpzOVJKUWxTb09lY1dKcTBBY3ZaLzVaemVmQ3JEeVc2?=
 =?utf-8?B?b2g1NHBXeW9UaDVCQnd4Mkh1a2lkcHJFNURKbUNraHd0OUcrTGNoU2VXRG9H?=
 =?utf-8?B?QUIzdVkwcVA5NjdPM0ZuKytaNHBuMUNzRnFpeXhZNGtBWEp1Y0ZkajdEcTNl?=
 =?utf-8?B?dlBoYXBPNElBTmtwcVFuTmlNZkQ4QzNka2FzVlJqNUtia2g5VE9LUVFrTWE1?=
 =?utf-8?B?dW42SzlnRTFCYTJCdXRHYzhIM2wzV2pKb1llS0FtNDlXR1R0ZmhnYUJrMFJB?=
 =?utf-8?Q?I8nkMfvtXfloiu6DTtFC5sEgA?=
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
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a559a76a-5ae4-4be7-bea4-08dd92ef3f66
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 13:57:21.4899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b61LaKB0fDwQWrG4/oelOrtc8Cvem9y01yggSn4RGoBy9qsT3XXKc8NBeK9K30kKOtC8upKvR68TujUdyMYyLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB2904
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=doosan.com header.s=selector1 header.b=DvIQTQwO;
	dmarc=pass (policy=none) header.from=doosan.com;
	spf=pass (spool.mail.gandi.net: domain of junesoo.im@doosan.com designates 2a01:111:f403:c410::1 as permitted sender) smtp.mailfrom=junesoo.im@doosan.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufhtfffktgfgggesthgstddttddtjeenucfhrhhomhepnjjnnjdllfhunhgvshhoohcukfhmmdcunjjnucjnnjjnnjjnnjcuoehjuhhnvghsohhordhimhesughoohhsrghnrdgtohhmqeenucggtffrrghtthgvrhhnpeetvdeujedvheelvdefueelgeelhffgveeguefgfeffhfffveduffduteekveekveenucffohhmrghinhepughoohhsrghnrhhosghothhitghsrdgtohhmnecukfhppedvudejrdejtddrudejkedrvdduvddpvdeitdefmedutdelieemuddtudemudehudemmedufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduvddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjuhhnvghsohhordhimhesughoohhsrghnrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

SGVsbG8sIEknbSBKdW5lc29vLkltLg0KDQoNCkkgYW0gd3JpdGluZyB0byB5b3UgYmVjYXVzZSBJ
IGhhdmUgYSBmZXcgcXVlc3Rpb25zIGFib3V0IFhlbm9tYWkuDQoNCg0KSSBoYXZlIGFuIEFkdmFu
dGVjaCBQQyB3aXRoIGFuIEludGVsIGkzLU4zMDUgQ1BVLiBUaGUgQ1BVIGhhcyA4IGNvcmVzLg0K
DQpRMS4gQ291bGQgeW91IHJlY29tbWVuZCB0aGUgYXBwcm9wcmlhdGUgS2VybmVsIGFuZCBYZW5v
bWFpIHZlcnNpb24gZm9yIG15IGhhcmR3YXJlPw0KICAgICpJZiBwb3NzaWJsZSwgSSB3b3VsZCBw
cmVmZXIgSS1QSVBFIG9yIERvdmV0YWlsLiBJIHVuZGVyc3RhbmQgdGhhdCBJLVBJUEUgb3IgRG92
ZXRhaWwgYXJlIG1vcmUgdGVzdGVkIGFuZCBoYXZlIHN0YWJsZSB2ZXJzaW9ucyBjb21wYXJlZCB0
byBFVkwuIEkgbWlnaHQgYmUgd3JvbmcgYWJvdXQgdGhpcy4NCg0KDQpRMi4gQWRkaXRpb25hbGx5
LCBmcm9tIHdoYXQgSSBmb3VuZCBvdXQgb24gdGhlIFhlbm9tYWkgc2l0ZSwNCiAgICBkdWFsIGtl
cm5lbCAoQ29iYWx0KSBpcyBiZXR0ZXIgZm9yIDQgY29yZXMgb3IgZmV3ZXIsIGFuZCBzaW5nbGUg
a2VybmVsIGlzIGJldHRlciBmb3IgbW9yZSB0aGFuIDQgY29yZXMuDQogICAgSXMgdGhpcyB0cnVl
Pw0KDQoNClEzLiBJIHdvdWxkIGxpa2UgdG8gbGVhcm4gbW9yZSBhYm91dCBzaW5nbGUga2VybmVs
LiBDb3VsZCB5b3UgcmVjb21tZW5kIGFueSByZXNvdXJjZXM/DQoNCg0KUGxlYXNlIHJlcGx5Lg0K
VGhhbmsgeW91Lg0KQmVzdCByZWdhcmRzLg0KSnVuZXNvby5JbQ0KDQoNCuyehOykgOyImA0K7IiY
7ISd7Jew6rWs7JuQLCBDb250cm9sIEFyY2hpdGVjdHVyZSBGcmFtZXdvcmvtjIANCg0K6rK96riw
64+EwqDshLHrgqjsi5wg67aE64u56rWsIOygleyekOydvOuhnCAxNTUsIE7rj5kgMjPsuLUNCkVt
YWlsIDoganVuZXNvby5pbUBkb29zYW4uY29tDQpNb2JpbGUgOiAwMTAgNjgzMCA1ODMxDQpXZWIg
OiB3d3cuZG9vc2Fucm9ib3RpY3MuY29tDQoNCg0K

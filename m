Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11011014.outbound.protection.outlook.com [40.107.42.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA1189915
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.42.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523553; cv=fail; b=OBS6MXYs5AVcceDuQvcSqM2yba4fowHYu8Erjbi3czuGlfIhUi8eftej7Gkz6Ml+QiYsA3xznsq77XScmQP1Xrgikd46M5T/M74eqtU4V4rePaomXRNp5y6bqH8Y7I/4InlkKijPjnM2X+N2rGx5aR36VBZ7/2769X6jRB+ld4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523553; c=relaxed/simple;
	bh=XL738JIw++y07Lft1cUQCx5hz55XaFT6z3dvKsYnrt0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aWQn9r/1aX/46dFcFG5Q7WJoZwYgq5RQIto11etsfet9EDxmbYKPUc9+j8yQagsO9lmTemhfikxgSWZc2cPTt5lLNRhkDqsyf9XfzI6WgbOq2bmdfkcprLBqE8f2z/AihFEj8ikId4hPE5WzqSHZ2aIs5v4hGbEua97pj0LWiAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=doosan.com; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=eM9Mv0ct; arc=fail smtp.client-ip=40.107.42.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doosan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="eM9Mv0ct"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTpzU6ucWYbvLZeevP3H4MkVxH3cDlRBBQ7+O5QWEYzFsN5OZDTd+QDTV6xGGSX1n8KfGdsKGoTZY8KOTvPP0e89R8yhFTuxhVf0kNb/u96u7Uqs1POS7Noc9h6LmksG2CA37P0MzgiBPwusp/btxmmgWNqnMQZLQmmg+0eiffIjIUcOTOHFAm9rrHNIJ0edSKZ8IzQBIej5Am7kyKRQgVuGTkU46tUZtAfVyEnl3zzpE9ZpkiqU0QEaZOBRBdKpU5JqnRRP6nTRv6FqppSuh1rp6HZpO02tDtZX/4My2Uorl01CBry05qjXJXQC0sYMQkBsxE2SAOn+yQFl2ups7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL738JIw++y07Lft1cUQCx5hz55XaFT6z3dvKsYnrt0=;
 b=ZMkxbTKq+kbkBhNz2Jb1jfK+q8OOo2K4hQYFQGbj9c7PMbqBazWXYYvCZECgnFVriuRqtC4+sEYwxt/e55g/M2z1zoQLOzHz5AzkG6mjOUP7634M8ocHNhIPExIvchuyzZM1XmscZSn5B/GsoTazbtpJwmtFSrdaDiSd7Ervgk5gNH4HBWnKUu2kGM2Pi4p7xn0fmzFUmtVaIyrr1uj/+PkusV8m2gOZBayOIdPktwRjwravsZr/25ckMc19Og/rCt3nOv43BU9CqeaRSGCMZf4B4Hz0Y5/fMjkMk/azQeOpU1HvS+Fuc59ZWxu3OA2lrA8QC8Ctuh6TPPwO9LfOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XL738JIw++y07Lft1cUQCx5hz55XaFT6z3dvKsYnrt0=;
 b=eM9Mv0ctigoBGkGC4CwOBu3qBDEZTNcb31ltW5owEDoruMs48Ny5z40IIGvfQBcg/bfmER5mxP3RQpQgGCYsB1mFaQdkYVc2Ky8AFKUOSoYoW7pL1nsJAgmFdVq2l76WZwx8tC3OxjN+Nf80jscWAD85w3opewuaa4pPCSHLupQ=
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM (2603:1096:101:151::13)
 by SL2P216MB1328.KORP216.PROD.OUTLOOK.COM (2603:1096:101:12::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 08:59:01 +0000
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4]) by SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4%6]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 08:59:01 +0000
From: =?utf-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?utf-8?B?7Iqk?= <junesoo.im@doosan.com>
To: Jan Kiszka <jan.kiszka@web.de>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: =?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?utf-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>,
	=?utf-8?B?7J207ZiV7ISdKEh5dW5nc2VvayBMZWUpIOyImOyEnSDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <hyungseok3.lee@doosan.com>,
	=?utf-8?B?7Iug66+87LKgKE1pbmNoZW9sIFNoaW4pIOyEoOyehCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <mincheol1.shin@doosan.com>
Subject: RE: IPIPE Kernel & Xenomai matching version
Thread-Topic: IPIPE Kernel & Xenomai matching version
Thread-Index: AdtcwPJAZLm3NHC9RvqVAfV7Ax1H+ABUmKwACCln5eA=
Date: Fri, 14 Feb 2025 08:58:58 +0000
Message-ID:
 <SL2P216MB2274CB29EC56BC6515C9F72AE0FE2@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
References:
 <SL2P216MB2274C60D2E87BA84D06C3E7EE0142@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
 <268ca8e1-d96a-4454-b8ad-21b5c615326e@web.de>
In-Reply-To: <268ca8e1-d96a-4454-b8ad-21b5c615326e@web.de>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doosan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB2274:EE_|SL2P216MB1328:EE_
x-ms-office365-filtering-correlation-id: 4e6d151a-6bd8-4d49-fa81-08dd4cd5d1be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cHo4citVSkJ1TVdxUnhvZ0g1a3NiNkJXTHF4L0dKZy9nYlBrYTQ5Z28xOTl4?=
 =?utf-8?B?eE9TM3JyRnllanYzZnY2UkJGVitDd0dXaXZBdGZRckl5a0hhbkNReW1yczRv?=
 =?utf-8?B?M0x4Y3pldlpQMlZ0OFJtc0VYRHJLaFY5WG01V3FOVHVvVVZLZnJEcWIyblNq?=
 =?utf-8?B?dHZ4eEhpS0lLekkxS1hXSmtVL21QVjZaQ2lzYlBPOVR3UGM0V2c0RmNlcWc2?=
 =?utf-8?B?OE1aSHI2YUQrRlJwWkNQTmFrUU5hckJRQUduTEFrYmdSNm5MODdhVjNvSFQ3?=
 =?utf-8?B?OXhTZnBKelo1dnF0NGhhUUhDaFk0bk5RTUl0WnFFQnRtRXZUbDFvdGs4enFB?=
 =?utf-8?B?YUFEc2RmVG5IUjNiSVg1YlNmY0grTkpWczQwUXdVZ0QzdzlNUm9oQzNCb1Jm?=
 =?utf-8?B?a0h4Nnhmd1dya0N0YTlGakJueGxvcERmU05zQlY5Q0J0OVd5eU4rUUovdEhx?=
 =?utf-8?B?Ni9kSTM2M1BOYXdJRTVmY08yQnBUYVdCQXlKNzVGZlg4RUhlZEF2OG5PbVFD?=
 =?utf-8?B?S2g3UTlFVHFNOHI5ZFhQMHYzU2djOXFKWnM2RUlGUFZ4Q0pqQ1NEUkJpMlI0?=
 =?utf-8?B?MWUvdUZuaktSTmczZzRKTWNCajdzMitQZWFHWmJvamNOTTRBNGJ2RzFYOWJ5?=
 =?utf-8?B?RGExTTNzNkR5RGI3eHVnM09hNURUNFdIQ08vcXpDQWF3Zy9WMkVmS3ArZGNh?=
 =?utf-8?B?RUEyYmMvaHEwU2xHclFJYVRXOWFCQzRlUm0xWnJqektrVFRxWTV0ZHVlSDFs?=
 =?utf-8?B?dUVsdFcydVQreU8yamRUY3lVSXI5a2E2eFZaSXZKMXI2UWFlelNyVzN3U29U?=
 =?utf-8?B?MHFLMkl3UGdIcG8vVEpEN1JVZW1mM3dXSkIvaDRvMzVGQzg4a2xNSStDMW9o?=
 =?utf-8?B?SDVrOUJiOGU1K3JrcVJEVHMrWmJqTGNDcE1EMnFxNDRYaFZmQXFNNUxRcnZ2?=
 =?utf-8?B?VGpWNkd4Vmt6U0IvYStacGw2VTl1ZUdEU29UUWRuOWRXcXNDczJpZ3pPdmlN?=
 =?utf-8?B?ZkxnSzc4dUVzY0JJdEd6SWtCd3NuUzJBQ0xXdTdKQ0ozbFdIM3VMcUsxU2Rt?=
 =?utf-8?B?WHNNNXVIZjR3ZEdlbFNyVEdZZEFmbVR0RWdITzk4S0Z0Q2t3eE9VOXBPQmUr?=
 =?utf-8?B?Qkg3MlRZTWc4a1VqNGZYOVBLa1FGOEZYcE5YU1JuVUl1WEhrWkYzTjNXOG93?=
 =?utf-8?B?WFNmN0lkdGV2RUgrVjdNM0t5RHQyK1QrVUVhS0JrSGRJa0xFSnZPNThPa3JH?=
 =?utf-8?B?dmpXR0lCd0liT2JZb0NJOGpPTDQ4M0VNTFYwWlZyNnNvOE8rQUJaYVBuN0Ux?=
 =?utf-8?B?cWFHbGFLZExUV0hRaWpLcjNqWTN2VDhleER2bDRSamVCOTYyc3kyY1pvakxq?=
 =?utf-8?B?Y0I1L0lSaHpzYkJDa3hGTGNiTlJqRHZuNWZjTFBKNWt3Sit6SWdMTHAyTG1y?=
 =?utf-8?B?UWlmeDA4aXFiL3dkN2pZblFobjVwYkNrT3RHWU9GV2NlRld6VVpGMFFlenRi?=
 =?utf-8?B?L2s3dlAzaXF3a1NKR2hwQk9hUTZsSUxPcHhWN2FGQXY0ZEJzNVVkRmZOOFEx?=
 =?utf-8?B?eGEzb29tZzlFT3JraGxwZTZsaGhEUWdYQzROaFdNYk91WTFpS3llOW1kazQ4?=
 =?utf-8?B?Zjhrc1BaU1FxT0MzaFdVUlB5YWtXVmwxNENNbGw1c0ZIc0VNb0pEdVYxNGlv?=
 =?utf-8?B?YXBJQ1RabkwzSExOUG5HT05vMmpjMkRhVEtBaWRnUVcvZnhTcGFoUlZ2SjRH?=
 =?utf-8?B?Wi9nSExpdStTY3gxVEpjUEtQRWUwRi82MGkwdlZlYWtZTFZtZ24zdVEzYWpN?=
 =?utf-8?B?RU0xWEpZaC9nS0c3VEpKdG5xMmdRWDZWSFkvNFIzcEF4UTM4UHY4WXFtbUhx?=
 =?utf-8?B?VElGWVZTc3J4NnVQUWVORHRZaEpqZkJzcWpCaElWVzBuQWZOY2VaRWNxbVM4?=
 =?utf-8?Q?zfzzaBS22fEL2/rY7YKAvDk8BxiOP9rM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB2274.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlZ6dW13bWdoN2J1emZKWFFnS1k3dTRLc0VxaHdma1dBKzVhOWV3SG1lU3kw?=
 =?utf-8?B?SGwrU1NuZ25pU1N4WU1EK3Y3Tk5rRGNvdnlvVWE5ZVlSdDdaSXF6NnZlcHFh?=
 =?utf-8?B?N2ZoUERtKzdIRmpFcTZLVjJWYndPaGliWnNyRVVtZDZLcGNtbWhDanNIVDEx?=
 =?utf-8?B?d1dPM3ZPa0lKNi9QcEZvU0NEM2VOMGZZK0ZYUS9hSERVVUJnZkdCNG9EQ3Fh?=
 =?utf-8?B?ZHhiS3JLOTdYTzdVcG0vT1N1V1NTamJBOG9tK2FDejh2RlFPRXk2L0RkcXpD?=
 =?utf-8?B?SHlwRDJ5YWRxbDgrdEJta3h1MzZGQ1ZrVHVqRmU5bCsxcisxQ2xoZ1MvcGpS?=
 =?utf-8?B?Mmk5UDEycjFUREo5akRxZkMwU1prcDhPaGQwT09TdUZIcnEvbVZiVEhqMzhJ?=
 =?utf-8?B?RXFCeTZab2l2VTJCZU1kZFBxbkJUMzdoR09FYVlvRmRaUUVTMHFscWlITGVS?=
 =?utf-8?B?aWVRU0NuOUVjYnR2UVBPc2c4Y05zMG44alR6emoyS3JRMkFNTnpmSTFVRWs3?=
 =?utf-8?B?VFRqY051aDkvUm5KSXdXazJMK2p2azNiQllBcHdxeHMxVjA5R3pHeGRDczFj?=
 =?utf-8?B?YlEvc3B3bWY0TmkvU3BEeEs5WG9sOHMyK0lVM0VWTUF0enl5ZzV3cXUxL2Nl?=
 =?utf-8?B?dHdFR3JTdmFTQTk2a0JQTWIvRVVRYkZ6TnMwUFVJeWhxNUs2emtrYi81SlJT?=
 =?utf-8?B?ZHd0UmJoZS92WGtDdkFDdWVDd2taTnQwK3U5blBEZVd1UCt6NHZpWXZBVFBk?=
 =?utf-8?B?K3FLS1RBOUtUV1A3NDdaS2ZUK0M2MTRiZTBxMUlrMlBSU1FzWXhCUDg1TDA1?=
 =?utf-8?B?VllwSW5HbWh1WEpxRFRNbWpwQ0FaV2dOcFQ1bmlmU1QvNndtTlhrMEwrWktU?=
 =?utf-8?B?YVFRcFZBeHRNNmIrU1hOemJvT1N3RFF3alRBZFVhVjFmMEFUQU1JdXI4cHRH?=
 =?utf-8?B?TVA4MjczRnRhWjFNT3o2alpLS0JVTmJpQXlRakdxUWozRGVkOFFTdkxndzFO?=
 =?utf-8?B?VTBjVmRUbkpTSFlhWEVlcTB0YlZ0amNGOTZZbjI3Z3Nra1ZIREl5cm43VzFx?=
 =?utf-8?B?NTRZUTdaeDViRW8vbmRVTlBnK2dzbWVTYmp4UEdpcjRNRW1zcVQ4OHRKT2lp?=
 =?utf-8?B?NkNkSHdnY2VMdzlHczdKTWRlVEo1U3E0Yk10dTJJeXpLTjUrd1REWFJmWmtu?=
 =?utf-8?B?bUxEcVd6cDNaY3RNNUJuR1JWekpVeXU3WkJCUFl2WldYZDF1azU1MFpNM2RR?=
 =?utf-8?B?RXliNVRvUVEyMmppaXZPUFNLc1RQT0pmRTl6aTV4TndhUXA2OFpoMEUzVXFP?=
 =?utf-8?B?K3lXc3dyNTc2OUQ2S3hiODA5M1dpc1pSVTJ2bnU5R0J5RHRKT2VHL25uSGVq?=
 =?utf-8?B?QnBHdGxkSTVmV0xOTDYvMWlDOExldlplMG1sYjVsWThselg3NzRKcTlpUWs5?=
 =?utf-8?B?WlJUNGUxQkhKa3pacGVtSXlCa3pPc2YvdUIremdocDBZdTZ5b0s1b01VZnNp?=
 =?utf-8?B?SmdMOWsycm1teWxvTWkvNU9HMGlPdEQ0NjY0YjE3d3cxeG01TDBIMGVKdmR4?=
 =?utf-8?B?SnptRlhIWEV6TDM2Nms5dnA0Z1crcnhlUjkwSHFEOFM3VkV6c2JNeEhMQVor?=
 =?utf-8?B?dDdWTTZBZkxUamVlMzBZbXJwc0duVWJwRlpBS2lpdFg5Rm9FV1pQUlZjaVNw?=
 =?utf-8?B?U014WWs0ejdmbHk2RTVYbm1tdU5PK3pTU1pBR3BKeTRyeFYvc2V5WjRoZThv?=
 =?utf-8?B?eWg1MThpVHF0TnJJc3luUEYrMjJhUHZucmdXK0NJOHpLd0hmdWxtc2V3dnJS?=
 =?utf-8?B?dUFKS2NOSWdibTdNdGM2VEg3UDQyNVJOZDZYeDlobVI2RGdnTXd3QTVXTUxx?=
 =?utf-8?B?ZmFBQ0ZjYkYvaTdqU2k2RWhCSk5HaEVaZUxOeUlaSFFNS3BwclRtOHpyTXE5?=
 =?utf-8?B?VURlREd5bzJQQy9uWmkwYzVUYWxYc2JTTUZkUktndjdwNkVoWXRaWnF1UGVE?=
 =?utf-8?B?UVJBdnFlRUhyeFJ6QTZLaE9CZnZQc3MwbEhMUVNwcW1YTG5tV3RBZVJGYkpu?=
 =?utf-8?B?WHRqOTY2NlBkZjhEM0laU3lmcVRxS2tHM2FEdkI0S2xvNzRrd1d1dUFpMTlT?=
 =?utf-8?Q?PP0bEEJrgaJRpPW48hLXG1ehR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6d151a-6bd8-4d49-fa81-08dd4cd5d1be
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 08:58:58.6945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWfZBvM1QLqL6lOTm1N/Hwi1Z2pB1fe7gGx3hUDnzzMxqQYvkYABkTTOWYIVv/iT6lUfLrmGdTNWhWE5EJlhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB1328

SGVsbG8gYWdhaW4hIEknbSBKdW5lc29vLEltIGZyb20gRG9vc2FuIFJvYm90aWNzLg0KDQoNCkRv
b3NhbiBkZWNpZGVkIENQVTogaTMtTjMwNSAoMTR0aCBnZW5lcmF0aW9uKS4NCkkgbmVlZCB0byBi
dWlsZCBhIFJlYWwtVGltZSBlbnZpcm9ubWVudC4NCg0KSSBhc2tlZCB5b3UgYWJvdXQgdGhpcyBi
ZWZvcmUsIGJ1dCBJIGhhdmUgYWRkaXRpb25hbCBxdWVzdGlvbnMgZHVlIHRvIHNvbWUgY2hhbmdl
cy4NCg0KLSBDYW4geW91IHRlbGwgbWUgdGhlIG1vc3Qgc3RhYmxlIHZlcnNpb25zIG9mIFhlbm9t
YWkgYW5kIEtlcm5lbCBmb3IgIkNQVSBpMy1OMzA1IiBlbnZpcm9ubWVudD8NCiAgKEkgcHJldmlv
dXNseSBtZW50aW9uZWQgdGhhdCBJIHdhcyBob3BpbmcgZm9yIEktUElQRSwgYnV0IG5vdCBub3cu
KQ0KDQotIEFkZGl0aW9uYWxseSwgSSBkb24ndCB3YW50IHRvIGluc3RhbGwgVWJ1bnR1LiBXaGlj
aCBGaWxlc3lzdGVtIHNob3VsZCBJIHVzZSB0byBpbnN0YWxsIFhlbm9tYWkgYW5kIEtlcm5lbD8N
Cg0KLSBMYXN0bHksIERvb3NhbidzIFJlYWwtVGltZSBBcHBsaWNhdGlvbiBpcyBidWlsdCB3aXRo
IFhlbm9tYWkgYnV0IHN0aWxsIHVzZXMgUG9zaXggZnVuY3Rpb25zIGludGVybmFsbHkuDQogIFdv
dWxkIHRoaXMgUmVhbC1UaW1lIEFwcGxpY2F0aW9uIGNhdXNlIGFueSBpc3N1ZSBzdWNoIGFzIEZy
ZWV6aW5nIG9yIFhlbm9tYWkgV2F0Y2hkb2cgcHJvYmxlbXMgaW4gdGhlIG5ldyBlbnZpcm9ubWVu
dD8NCg0KDQpCZXN0IHJlZ2FyZHMuDQpKdW5lc29vLkltDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHdlYi5kZT4gDQpTZW50OiBTYXR1
cmRheSwgSmFudWFyeSA0LCAyMDI1IDQ6MTIgQU0NClRvOiDsnoTspIDsiJgoSnVuZXNvbyBJbSkg
7IiY7ISdIOuRkOyCsOuhnOuztO2LseyKpCA8anVuZXNvby5pbUBkb29zYW4uY29tPjsgeGVub21h
aUBsaXN0cy5saW51eC5kZXYNCkNjOiDrsJXqsr3tm4goS3l1bmdob29uIFBhcmspIO2MgOyepSDr
kZDsgrDroZzrs7Tti7HsiqQgPGt5dW5naG9vbjIucGFya0Bkb29zYW4uY29tPjsg7J207ZiV7ISd
KEh5dW5nc2VvayBMZWUpIOyImOyEnSDrkZDsgrDroZzrs7Tti7HsiqQgPGh5dW5nc2VvazMubGVl
QGRvb3Nhbi5jb20+DQpTdWJqZWN0OiBSZTogSVBJUEUgS2VybmVsICYgWGVub21haSBtYXRjaGlu
ZyB2ZXJzaW9uDQoNCuyjvOydmDog7J20IOuplOydvOydgCDsmbjrtoDsl5DshJwg67Cc7IahIOuQ
mOyXiOyKteuLiOuLpC4g66eB7YGsIO2YueydgCDssqjrtoDtjIzsnbwg7Je0656MIOyLnCDso7zs
nZjtlZjsi5zquLAg67CU656N64uI64ukLg0KDQpDQVVUSU9OOiBUaGlzIGVtYWlsIGlzIHNlbnQg
YnkgYW4gZXh0ZXJuYWwgYWNjb3VudC4gUGxlYXNlIHRha2UgZXh0cmEgY2F1dGlvbiB3aGVuIGNs
aWNraW5nIHRoZSBsaW5rIG9yIG9wZW5pbmcgdGhlIGF0dGFjaG1lbnQuDQoNCk9uIDAyLjAxLjI1
IDAzOjUyLCDsnoTspIDsiJgoSnVuZXNvbyBJbSkg7IiY7ISdIOuRkOyCsOuhnOuztO2LseyKpCB3
cm90ZToNCj4gSGVsbG8sIHRoaXMgaXMgSnVuZXNvbyxJbSBmcm9tIERvb3NhbiBSb2JvdGljcy4N
Cj4NCj4gVGhhbmsgeW91IGZvciB5b3VyIGtpbmQgYW5zd2VycyB0byBtYW55IHF1ZXN0aW9ucyBz
byBmYXIuDQo+DQo+DQo+IERvb3NhbiBSb2JvdGljcyBoaWdobHkgdHJ1c3RzIFhlbm9tYWkncyBv
dmVyYWxsIGZ1bmN0aW9uYWxpdGllcyBhbmQgaG9wZXMgdG8gY29udGludWUgdXNpbmcgaXQuDQo+
DQo+IERvb3NhbiBSb2JvdGljcyBpcyBjb25zaWRlcmluZyBJUElQRSBmaXJzdCwgYW5kIHNlY29u
ZCwgd2UgYXJlIGNvbnNpZGVyaW5nIERvdmV0YWlsLg0KPg0KPg0KPiBUaGVyZWZvcmUsIHdlIHdv
dWxkIGxpa2UgdG8gcmVjZWl2ZSByZWNvbW1lbmRhdGlvbnMgZm9yICJ0aGUgc3RhYmxlIG1hdGNo
aW5nIHZlcnNpb25zIiBvZiB0aGUgS2VybmVsIGFuZCBYZW5vbWFpIGxpYnJhcnkgZm9yIGJvdGgg
SVBJUEUgYW5kIERvdmV0YWlsLg0KPg0KDQpXZSBhbHdheXMgdGVzdCB0aGUgbGF0ZXN0IHZlcnNp
b25zIGNvbWJpbmF0aW9ucy4gSWYgd2Uga2VlcCB0aGUga2VybmVsIG9yIFhlbm9tYWkgZml4ZWQg
b24gc29tZSBvbGRlciBzdGFibGUgcmVsZWFzZSwgeW91IGFyZSBldmVuIG1vcmUgb24geW91ciBv
d24gYW5kIHJpc2sgdG8gbWlzcyBhIHBvc3NpYmx5IHJlbGV2YW50IGJ1ZyBmaXguDQoNCj4NCj4g
Rm9yIHlvdXIgcmVmZXJlbmNlLCBEb29zYW4gUm9ib3RpY3MgaXMgY3VycmVudGx5IHVzaW5nIElQ
SVBFIGtlcm5lbCA1LjQuMjU1IGFuZCBYZW5vbWFpIDMuMS40Lg0KPg0KDQpJLXBpcGUgaXMgc3Rp
bGwgc3VwcG9ydGVkIGJ5IFhlbm9tYWkgMy4yLnguIFdlIG9ubHkgcmVtb3ZlZCBpdHMgc3VwcG9y
dCB3aXRoIHRoZSAzLjMgcmVsZWFzZS4NCg0KSS1waXBlIGtlcm5lbHMgYXJlIG5vdCBmcmVxdWVu
dGx5IHVwZGF0ZWQgYW55bW9yZSwgdGhvdWdoLiBGdXJ0aGVybW9yZSwNCjUuNCBhbmQgNC4xOS1j
aXAgYXJlIG9ubHkgbWFpbnRhaW5lZCBmb3IgeDg2IGF0IHRoaXMgc3RhZ2UuIEZpbmFsbHksIHVw
c3RyZWFtIDUuNCB3aWxsIGJlIGVuZC1vZi1saWZlIGJ5IHRoZSBlbmQgb2YgdGhpcyB5ZWFyLCBv
bmx5IHRoZSA0LjE5LWNpcCBiYXNlIHdpbGwgbGl2ZSBsb25nZXIgKDQgbW9yZSB5ZWFycykuDQoN
Cj4NCj4gSGFwcHkgbmV3IHllYXIgYW5kIHN0YXkgaGVhbHRoeS4NCg0KVGhhbmtzLCBzYW1lIHRv
IHlvdSENCg0KSmFuDQoNCg==

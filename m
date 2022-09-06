Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457BA173
	for <xenomai@lists.linux.dev>; Tue,  6 Sep 2022 01:10:27 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 42372C01AB
	for <xenomai@lists.linux.dev>; Tue,  6 Sep 2022 01:08:55 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 6B439C0003
	for <xenomai@lists.linux.dev>; Tue,  6 Sep 2022 01:08:47 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2054.outbound.protection.outlook.com [40.107.129.54])
	by spool.mail.gandi.net (Postfix) with ESMTPS id DE9147803E1
	for <xenomai@xenomai.org>; Tue,  6 Sep 2022 01:08:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTGnRNQwGa0zBmTpUsmURO6JCGW8qgy+w8c78bZgTeluLSiZtBMwk35K3/44AuRdVJ4FGum9zLp6MZKIdPlxbK/v54Z3rb2VJYUtRldcdILwwVB/H4UycuEp8zRLaT6XmokQVeC4DPaIRM1Hf4d4Y4TScbmDQq5Ul58MMDpJcNM/3wAdiD5vgMqVJjsyOr2Jif4tgapLm0YDj09Gbfx2UJ1W8x5Orh5B1WPaQZePzPZ1h75T2SV9m3IftglxDdnK7AhUJxPI2OzHWPccgXdqvBQL3A5G/RMWOA6zHNj7j+ll0Ky6Ti8VFhrsuc5ZBsVgRIg5P8vOT5bpODhOvIeeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIRHB1e11rcGplX7ry1jf7ArXV0807N2/nzqpPwrncY=;
 b=GFfcQ3hJkX505Ih+34vAR8dlD98kchu5qxHXl4Hp3NK3R3aKU/htNJ2IlHKs9gHTgycWhNWkDkckrv+RQ8dcTwwed2pjjzFQOTN5/tT90H4dNk6jceo8jQmt/v++ie0Z1w2mK+QaStcAI5qsxqw9RRTWeRlCQtyMVM6Euf86Y09WAATE3IsefbszuEni5SUk6v9FgcHghqDkUmPXbs1/EoRmwUrWihb/nQQg1O7XQ9w8vvEr0vyQFaImFxY1p6fzD28nJrihELu3MX1B+UWscy8v1shW870wKivxnuorN3Ckp42RDhSrF1vBsAowCGuu00kQ7a7tg+w8mvwoo9tBgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Doosan.onmicrosoft.com; s=selector1-Doosan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIRHB1e11rcGplX7ry1jf7ArXV0807N2/nzqpPwrncY=;
 b=PJ34iInb+xMx7aZ0RWb2XbJJ/WVQwQqXqjrCFzH3Li4Z1mA5Ceg+ugWrKmTNat7hf75LA3WCGUJW8uY9sHiKB8/ARR+eUAldKaQp6yaSdDjuvErK5YD6NFlMUnvdgu6rQPtj2AugBz2onSDa6QWKgAIeociOZiEHPwcLnwqQDYY=
Received: from SE1P216MB1509.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d::8) by
 PU4P216MB1488.KORP216.PROD.OUTLOOK.COM (2603:1096:301:cf::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Tue, 6 Sep 2022 01:08:42 +0000
Received: from SE1P216MB1509.KORP216.PROD.OUTLOOK.COM
 ([fe80::5911:b05c:c2ca:bd56]) by SE1P216MB1509.KORP216.PROD.OUTLOOK.COM
 ([fe80::5911:b05c:c2ca:bd56%7]) with mapi id 15.20.5588.015; Tue, 6 Sep 2022
 01:08:42 +0000
From: =?utf-8?B?6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
CC: =?utf-8?B?67CV7JiB7LKgKFlvdW5nY2h1bCBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <youngchul3.park@doosan.com>,
	=?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ3sl7Dqtazsm5Ag65GQ?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <kyunghoon2.park@doosan.com>,
	=?utf-8?B?6rmA7IS47ZiEKFNlaHl1biBLaW0pIOyXsOq1rOybkCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <sehyun2.kim@doosan.com>,
	=?utf-8?B?6rmA7IOB7KeEKFNhbmdqaW4gS2ltKSDso7zsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <sangjin5.kim@doosan.com>,
	=?utf-8?B?7J6l7Jqp7ZiBKFlvbmdoeXVrIEphbmcpIOyxheyehOyXsOq1rOybkCDrkZA=?=
 =?utf-8?B?7IKw66Gc67O07Yux7Iqk?= <yonghyuk.jang@doosan.com>,
	=?utf-8?B?6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>
Subject: RE: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index:
 Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkAAHYUU4AADTiNwAAcm6LAABFvNgAAqXeuQAAWtTIABMRjSEAAB/+8AALvKhbAAAd0CAAAu4gsg
Date: Tue, 6 Sep 2022 01:08:42 +0000
Message-ID:
 <SE1P216MB15098FE3F2E5AFC3CA4AD949B17E9@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
References:
 <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE2P216MB1394C7C6A067126F36022F23C2739@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <SE1P216MB1509579188F44BA6C35E8547B1739@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <BY5PR11MB4276CD67150EE6042EB1A849F2729@BY5PR11MB4276.namprd11.prod.outlook.com>
 <SE1P216MB1509E22586BCCE1E4899A946B1729@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285E860217DB23B18016495F2729@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB1509ED1D62553AC566FDA209B1759@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285C21FFFA82081782F2CDFF2759@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB1509F3EB0B85BBA7A7787A5DB17B9@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285C4A26329000A75BF96DBF27B9@MN2PR11MB4285.namprd11.prod.outlook.com>
 <SE1P216MB1509B8CAFA0E44DE487C3CB7B17F9@SE1P216MB1509.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB4285822F4C6778016489535BF27F9@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To:
 <MN2PR11MB4285822F4C6778016489535BF27F9@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14c99543-e822-4c9f-852d-08da8fa456eb
x-ms-traffictypediagnostic: PU4P216MB1488:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /clTe7Ey4C8XuS+VD90QEA5wrD4HHADw9+kv/o6nK0uwLhvu4jrB+nhMldZ+PLk4Fv6UYARnA0Tl9vOX5UCNhnvTeiBt/nlNLNbp4yVPJOLcB1Z8eRRmuqfT864icSp+j+/oRLmoYID4KAGNE3TJxYiotZkhnN5Y66WlwQGWlkqmw3wseG8KtiWftGxzlmBHgHQu4vx23ggypKI05qa/6zHyOS8JWqkevNgYwJ7crDR46KNjHXHI/SZnHtIOANR6ro0D+TvvnE0khwODcikBGt6hXhFg0mP5sS4huBg8pPgYrzF1LOzFldhiPT6uJE7IiiU4ipNsFEu7YVDaOu7umFgKkPXM2pexpXGkdblhxROwHKtqEvDVmDs5v3lVXEf1gd/hyCDAzZ6AGdHiuMJPK9Rk9W2u8hkQ/lc3N5slqJg9WsZd0Ijn4GJrzNuCsYsuXXdHIQchkiqcE1uslRb0Yeff7PZrMBLrUVB0mZobeNQ6Z3Y+AKV4TM9LwP8IQowWSBoVLYkWMemxC3kAVytngH1K4tog3/JXtjEl5XtgioA4US8YWwEkCW4Uf01Lmy3X7aFSDTCi2Kc+RADBLMsox33gWE2DcLGKwdRyo4ohh7jjnG6ftrWI74xpWfoMmq3dnnuJpwss59UhVoX3eZoma8bIdZ7V/isuM3tdH3k9YQIEvHUb19nmMs7/79JGBAXPplzbMHvgZhKMtotQ0xE7PA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB1509.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(38100700002)(122000001)(54906003)(33656002)(316002)(478600001)(71200400001)(966005)(110136005)(38070700005)(86362001)(9686003)(53546011)(7696005)(6506007)(107886003)(41300700001)(55016003)(26005)(83380400001)(4326008)(8676002)(66446008)(76116006)(66946007)(66556008)(66476007)(8936002)(186003)(52536014)(64756008)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MCtWd3BkbDl1ZURRd1VXYVQ3enE5Y0x2bWMycWxXTVptdnJsamlyWDlmQ1Jl?=
 =?utf-8?B?UENhNDdEMVFsNzhaRjZHUXRtY2NaV05menJEUHR3NjA1MWQyMjdaSVQxOEVy?=
 =?utf-8?B?cDVzeFNnWmtPd3YyY3NVTGNqWW1venI3bXgzRVN1Q2w0bVY5Q056c0M2d2J4?=
 =?utf-8?B?UDVHRFBmNEVaZWVWb1YzVGxvUmNWcGhZU0ZNcnVEL2R2TFNpZGtmRWNRQnpO?=
 =?utf-8?B?UWV4WVdIbzBTSUxUWlBCd0g3cjVUaU5EM2xxZ2FvL0JYcEZrS3hzR3Qwakx5?=
 =?utf-8?B?bjBZbS9OOFRYbkRENGN1TWsrZHpmY3pUaTU3SzY5UWZXazJqUXI0U1FRdDcy?=
 =?utf-8?B?YmRWV0orNi9CQzNoWmdqVnRYNTVlbE1VWk1DRUhYM0NPc25NNkcrREZocE5I?=
 =?utf-8?B?TElUWldDbkhNR3g5RHlvYkpCUkNuMmhwMThYeEx3Nzd3Mi81S3h5bGxpcERE?=
 =?utf-8?B?aFA2Z1p2T1lUTmpnWUxXNUZvc01zbDhtVmRuMm0xYTVHbEw0THF6b2k4TUV3?=
 =?utf-8?B?THk2RTN0Q2k2anRTRjhsWEticjZMUXVEOFRnR1Z2UElRbVpsUDU3dzNnT2tJ?=
 =?utf-8?B?WFBhNFNGbENudllOeUtSdVUxWVkvMUU1NS9UWlU2bXYvd3YzNml6djhJV011?=
 =?utf-8?B?Mm0weU9SanlOZ3AwRVk4bitsOWZ0NWNxTCt3MVlRRWJIdWdNWjVxT3piam5n?=
 =?utf-8?B?T3BvUEE3b2lzeHZaTGVHVXpWRThXZGVYSWpCK3AyaEtHM0xpT2V0NWEvTk9L?=
 =?utf-8?B?ZXBiVFlKbnA2akRuVTZZRk9qSTdmLzBWVkprM2EybXZvNlZYVS9WRTREUW9w?=
 =?utf-8?B?WUUraFZqZVVXSkdFaWs1djNSdnd6ckZBcWZoODBQU3AzOVBjMTFSVlVTdXBx?=
 =?utf-8?B?bjVGanlVRTFzRytCemNMTGZMRUgxcHJ4WnNsUmlsRWx6VW12Y3NRQTA3eGQ4?=
 =?utf-8?B?am9lcWF6WktKSURiZXlsZFNyeEVwWlNaS3FYRlJLeDROYzY5d3NZZUdCM2VP?=
 =?utf-8?B?YWRoT0R6N3d1TXlldjE4eXlpaytIcktKZGFCaER3ODVnTzl5L1BtVmZqdytp?=
 =?utf-8?B?M1RYdDdCcGZYcm5YaE5TZ2NsK1JlelFRUnZleDdpMnNCaVl3ek1zN005TEJB?=
 =?utf-8?B?WjdYTGIvL0Z5YzdlRzZuUDlyOWx4UlpiTklqTzBEZlhyRnJPUUhpVTZocEtR?=
 =?utf-8?B?RjZoMk9XOWgwbCt3RnFvdDNwdVpYSVVsQk9FMXNUZ0RtTlhLRFUzRktLTkhE?=
 =?utf-8?B?RTNRT0hicDVjZFM2aGdyNVlTK0llemkwc3NYQllRaTJ6QmtOb0R2Um1Tb2M2?=
 =?utf-8?B?b3I0VjZoSjkvV1lBcTJpMGczbmlYeFlFNTdoYVE1N2wrbmhlRnB1T2hFZzha?=
 =?utf-8?B?K05KMHVQT3RQczRDK0Q0REZrQ3ZqdnNuSUU5aXBXaTFQa0tMYzF2NXEvaDEw?=
 =?utf-8?B?TnVaeU9TeGZ6UXdZWnpQZlNSbmZVc1psZFBRakhrZEZ3d3Y3dFRxVVpJOFNh?=
 =?utf-8?B?amExQThCRHJHdS9seERzOWJmWGRMc1R0YndGRHE0alBnMXplaTMzUDJzOHdn?=
 =?utf-8?B?Nk9aRkJ0WFZQckVZbzNXM3ZWY0RQa2htYTJQdXQ3QzYzb3hOMENaNTFVd2FW?=
 =?utf-8?B?dHUyTG5wUEVpT2QwdkVzajVqekxvaklVZTByNmZPUnFzbkJsTTU3d05HNlF0?=
 =?utf-8?B?TmdPUmk1QzJFU2ZxeGltWnNPZHJteUZ1WnFINHVFZUlIQ0VocDFiTnNxZWNq?=
 =?utf-8?B?OFQ2VmlaOHF6SFVkY0tRSXRCcFdabTEyL2FRN3BobGRQeU1YUTdzdFdtUThZ?=
 =?utf-8?B?Si9FRHZPZnMweUlxYXdWTmFLa3Z4Z09WWkNRN29QQ0hXQnVEM1V4TnRqU2Vn?=
 =?utf-8?B?bzYwWWFZaGIya2dsRTAyYTdhZnFPcDQ2SUU4Rm1CSmJBV2dqSmRJRzVXWE9x?=
 =?utf-8?B?bzU1aGtHem1RZitoN09zWU90SktUcnVMS0hscExRc0w2UXh0aFREZFg0YTZy?=
 =?utf-8?B?WFN6RjNhdGFIb2FuNFpQNUdwMitxVG93KzFjejdqdjFTclRTaEZqckh4YTQw?=
 =?utf-8?B?TTRVdGRjR1RrWTc3enZhdHZNNEZiRHFlaElzcGxWclRzbFhBVlJ2NTlhbHN4?=
 =?utf-8?Q?2f7eYpMypHq5C9++Gi+WRIWIl?=
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
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB1509.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c99543-e822-4c9f-852d-08da8fa456eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 01:08:42.1101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWXPrka4+/VreqYXcIDwptbO4PGRqI8HxXCrXIzVJox/aO0ao+SpUFRFkexOYHbx+CoR/36vH8lfrDK2MabVZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1488
Received-SPF: pass (spool4: domain of doosan.com designates 40.107.129.54 as permitted sender) client-ip=40.107.129.54; envelope-from=dongjoo5.kim@doosan.com; helo=KOR01-SL2-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=Doosan.onmicrosoft.com header.s=selector1-Doosan-onmicrosoft-com header.b=PJ34iInb;
	spf=pass (spool.mail.gandi.net: domain of dongjoo5.kim@doosan.com designates 40.107.129.54 as permitted sender) smtp.mailfrom=dongjoo5.kim@doosan.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=none

RGVhciBYZW5vbWFpLm9yZywgQ2hlbiwgSG9uZ3poYW4NCg0KSSdtIGRvbmcgam9vLg0KDQpUaGFu
a3MgZm9yIHlvdXIgcmVzcG9uc2UgYWJvdXQgb3VyIHF1ZXN0aW9ucy4NCg0KV2UgaGF2ZSBjaGVj
a2VkIHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbiB1c2luZyBYZW5vbWFpLg0KQW5kLCBNb3N0IGd1
aWRlIHJlY29tbWVuZCB0byBkaXNhYmxlIFBvd2VyIG1hbmFnZW1lbnQgb3B0aW9ucy4NCg0KSXMg
dGhlcmUgYW55IHJlYXNvbiB0byBkaXNhYmxlIFBvd2VyIG1hbmFnZW1lbnQgb3B0aW9ucyA/DQoN
CklmIHRoZSBndWlkZSBpcyByaWdodCwgV2UnbGwgZGlzYWJsZSBQb3dlciBtYW5hZ2VtZW50IG9w
dGlvbnMuDQoNCmh0dHBzOi8vcnR0LWx3ci5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3QvcnRwYy94
ZW5vbWFpMy5odG1sDQoNClBvd2VyIG1hbmFnZW1lbnQgYW5kIEFDUEkgb3B0aW9ucw0KICAtLT4g
Q1BVIEZyZXF1ZW5jeSBzY2FsaW5nDQogICAgICAtLT4gQ1BVIEZyZXF1ZW5jeSBzY2FsaW5nIChE
aXNhYmxlKQ0KICAtLT4gQUNQSSAoQWR2YW5jZWQgQ29uZmlndXJhdGlvbiBhbmQgUG93ZXIgSW50
ZXJmYWNlKSBTdXBwb3J0DQogICAgICAtLT4gUHJvY2Vzc29yIChEaXNhYmxlKQ0KICAtLT4gQ1BV
IElkbGUNCiAgICAgIC0tPiBDUFUgaWRsZSBQTSBzdXBwb3J0IChEaXNhYmxlKQ0KDQoNClRoYW5r
cy4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENoZW4sIEhvbmd6aGFuIDxo
b25nemhhbi5jaGVuQGludGVsLmNvbT4NClNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDUsIDIwMjIg
MTE6NDcgQU0NClRvOiDquYDrj5nso7woRG9uZ2pvbyBLaW0pIOyxheyehOyXsOq1rOybkCDrkZDs
grDroZzrs7Tti7HsiqQgPGRvbmdqb281LmtpbUBkb29zYW4uY29tPjsgeGVub21haUB4ZW5vbWFp
Lm9yZw0KQ2M6IOuwleyYgeyyoChZb3VuZ2NodWwgUGFyaykg7IiY7ISd7Jew6rWs7JuQIOuRkOyC
sOuhnOuztO2LseyKpCA8eW91bmdjaHVsMy5wYXJrQGRvb3Nhbi5jb20+OyDrsJXqsr3tm4goS3l1
bmdob29uIFBhcmspIOyImOyEneyXsOq1rOybkCDrkZDsgrDroZzrs7Tti7HsiqQgPGt5dW5naG9v
bjIucGFya0Bkb29zYW4uY29tPjsg6rmA7IS47ZiEKFNlaHl1biBLaW0pIOyXsOq1rOybkCDrkZDs
grDroZzrs7Tti7HsiqQgPHNlaHl1bjIua2ltQGRvb3Nhbi5jb20+OyDquYDsg4Hsp4QoU2FuZ2pp
biBLaW0pIOyjvOyehOyXsOq1rOybkCDrkZDsgrDroZzrs7Tti7HsiqQgPHNhbmdqaW41LmtpbUBk
b29zYW4uY29tPg0KU3ViamVjdDogUkU6IFdoYXQgY2F1c2VzIHRoZSBsYXRlbmN5IG9mIHRoZSBy
dF90YXNrX3lpZWxkKCkgQVBJPw0KDQrso7zsnZg6IOydtCDrqZTsnbzsnYAg7Jm467aA7JeQ7ISc
IOuwnOyGoSDrkJjsl4jsirXri4jri6QuIOunge2BrCDtmLnsnYAg7LKo67aA7YyM7J28IOyXtOue
jCDsi5wg7KO87J2Y7ZWY7Iuc6riwIOuwlOuejeuLiOuLpC4NCg0KQ0FVVElPTjogVGhpcyBlbWFp
bCBpcyBzZW50IGJ5IGFuIGV4dGVybmFsIGFjY291bnQuIFBsZWFzZSB0YWtlIGV4dHJhIGNhdXRp
b24gd2hlbiBjbGlja2luZyB0aGUgbGluayBvciBvcGVuaW5nIHRoZSBhdHRhY2htZW50Lg0KDQo+
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiA/Pz8oRG9uZ2pvbyBLaW0pID8/Pz8/
ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+DQo+U2VudDogTW9uZGF5LCBTZXB0ZW1i
ZXIgNSwgMjAyMiA5OjI0IEFNDQo+VG86IENoZW4sIEhvbmd6aGFuIDxob25nemhhbi5jaGVuQGlu
dGVsLmNvbT47IHhlbm9tYWlAeGVub21haS5vcmcNCj5DYzogPz8/KFlvdW5nY2h1bCBQYXJrKSA/
Pz8/PyA/Pz8/Pz8gPHlvdW5nY2h1bDMucGFya0Bkb29zYW4uY29tPjsgPz8/KEt5dW5naG9vbiBQ
YXJrKSA/Pz8/PyA/Pz8/Pz8gPGt5dW5naG9vbjIucGFya0Bkb29zYW4uY29tPjsgPz8/KFNlaHl1
biBLaW0pID8/PyA/Pz8/Pz8gPHNlaHl1bjIua2ltQGRvb3Nhbi5jb20+OyA/Pz8oU2FuZ2ppbiBL
aW0pID8/Pz8/ID8/Pz8/PyA8c2FuZ2ppbjUua2ltQGRvb3Nhbi5jb20+OyA/Pz8oRG9uZ2pvbyBL
aW0pID8/Pz8/ID8/Pz8/PyA8ZG9uZ2pvbzUua2ltQGRvb3Nhbi5jb20+DQo+U3ViamVjdDogUkU6
IFdoYXQgY2F1c2VzIHRoZSBsYXRlbmN5IG9mIHRoZSBydF90YXNrX3lpZWxkKCkgQVBJPw0KPg0K
PkRlYXIgWGVub21haS5vcmcsIENoZW4sIEhvbmd6aGFuDQo+DQo+SSdtIGRvbmcgam9vLg0KPg0K
PkFmdGVyIGluc3RhbGxpbmcgYnVpbGQtZXNzZW50aWFsLCBYZW5vbWFpIGNvbmZpZ3VyZSBlcnJv
ciBhbHNvIGhhcHBlbi4NCj5Db3VsZCB5b3UgaGVscCBtZSB0byBzb2x2ZSBhIFhlbm9tYWkgY29u
ZmlndXJlIGVycm9yID8NCj4NCj5JZiBXZSBpbnN0YWxsIGdjYy00LjggY29tcGlsZXIgYmFzZWQg
b24gMzJiaXQsIFhlbm9tYWkgY29uZmlndXJlIGVycm9yIGRvbid0IGhhcHBlbi4NCj4NCj4xLiBX
ZSBpbnN0YWxsIGdjYy00LjggY29tcGlsZXIgYmFzZWQgb24gNjRiaXQuDQoNClRvIGNvbXBpbGUg
Z2NjIDQuOCAzMi1iaXQgcHJvZ3JhbToNCg0KUGxlYXNlIG1ha2Ugc3VyZSBhbGwgdGhlIDMyLWJp
dCBnY2MgNC44IGRldmVsb3BtZW50IHRvb2xzIGFyZSBjb21wbGV0ZWx5IGluc3RhbGxlZCBmb3Ig
eW91ciBjYXNlOg0KDQpzdWRvIGFwdC1nZXQgaW5zdGFsbCBsaWIzMmdjYy00LjgtZGV2DQoNCg0K
UmVnYXJkcw0KDQpIb25nemhhbiBDaGVuDQoNCj4NCj4yLiBXZSB3YW50IHRvIGJ1aWxkIGFib3V0
IFhlbm9tYWkgYnVpbGQgZm9yIFg4NiggMzJiaXQpIFRhcmdldC4NCj4gICBTbywgV2UgdXNlIHRo
ZSBzY3JpcHQgYmFzZWQgb24gWGVub21haSBkb2N1bWVudC4NCj4NCj4zLiBjb25maWd1cmUgaGFw
cGVuIHRvIGZhaWwuDQo+DQo+VGhhbmtzLg0KPg0KPg0KDQoNClRoaXMgZS1tYWlsIGFuZCBhbnkg
YXR0YWNobWVudHMgaGVyZWluIG1heSBjb250YWluIGNvbmZpZGVudGlhbCBvciBwcml2aWxlZ2Vk
IGluZm9ybWF0aW9uIGFuZCBpcyBmb3IgdGhlIGV4Y2x1c2l2ZSB1c2Ugb2YgdGhlIGludGVuZGVk
IHJlY2lwaWVudChzKSBuYW1lZCBhYm92ZS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJl
Y2lwaWVudChzKSwgeW91IHNob3VsZCBub3QgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUsIHJldGFp
biwgY29weSBvciBvdGhlcndpc2UgdXNlIGFueSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWlu
LiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlm
eSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGJ5IHJlcGx5aW5nIHRvIHRoaXMgbWVzc2FnZSBhbmQg
ZGVsZXRlIHRoaXMgZS1tYWlsIGFuZCBhc3NvY2lhdGVkIGF0dGFjaG1lbnRzLiBPdXIgY29tcGFu
eSBkb2VzIG5vdCBndWFyYW50ZWUgdGhpcyBlLW1haWwgaXMgc2VjdXJlIG9yIGZyZWUgZnJvbSB2
aXJ1c2VzLg0K7J20IOuplOyLnOyngCDrsI8g7LKo67aA7J6Q66OM64qUIOuyleuloOyDgSDruYTr
sIDroZwg67O07Zi465CY7Ja07JW8IO2VoCDrgrTsmqnsnYQg7Y+s7ZWo7ZWY6rOgIOyeiOqzoCDs
oJXri7ntlZwg7IiY7Iug7J247JeQ6rKM66eMIOyghOuLrO2VoCDrqqnsoIHsnLzroZwg67Cc7Iah
65CY7JeI7Jy866+A66GcIOygleuLue2VnCDsiJjsi6DsnbjsnbQg7JWE64uI652866m0IOuCtOya
qeydmCDqs7XqsJwsIOuwsO2PrCwg67O06rSA7J2AIOusvOuhoCDslrTrlqQg7Jqp64+E66Gc64+E
IOydtOulvCDsnbTsmqntlaAg7IiYIOyXhuycvOupsCwg67O4IOuplOydvOydmCDsnpjrqrvrkJwg
7Leo6riJ7Jy866GcIOuwnOyDne2VmOuKlCDslYjsoITshLEg66y47KCc7JeQIOq0gO2VmOyXrCDr
i7nsgqzripQg7JWE66y065+wIOyxheyehOuPhCDsp4Dsp4Ag7JWE64uI7ZWo7J2EIOyVjOugpCDr
k5zrpr3ri4jri6QuIOyemOuquyDsiJjsi6DtlZjsi6Ag6rK97Jqw7JeQ64qUIOymieyLnCDshqHs
i6DsnpDsl5Dqsowg7ZqM7Iug7ZWY7JesIOyVjOugpOyjvOyLoCDtm4Qg7IKt7KCc7ZWY7JesIOyj
vOyLnOq4sCDrsJTrno3ri4jri6QuIO2YkeyhsOyXkCDqsJDsgqwg65Oc66a964uI64ukLg0K

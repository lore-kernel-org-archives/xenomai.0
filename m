Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992C1F953
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 09:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7NMQY+o6W3QaJVDT4B9V39PX6pQhoJdlfFBgjVTd6x8Re6l+BuskzJyRMKOSwc0oPl6gFSB1fEfh5BLOHwmhU2lZvL7VvayZyVRsGM5aHnI7sut/hG27srGXcXW10uYuCOcvmFFvKuz2n7xHQLIPG9xAlaNExlOXfNeA1K1WHEGTGRNbjJ+QEG3WmY/D5RVOTBWN3PZIjdLtJtEOfMyJC5rk2YeaQFaqp5RFKy9j8TR3eT2blu/FU7xfFCfeVYGIRZDqlGrEmTqJiMMnDudnpdsApwxy9ANjLv2ijq09RdFAEh84U/RaT4EDosgaf/zMF7tW+8pbbANkHiGBK9Gbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrIlJLO6dizuGm5Tq0OycZsNClnc51q3+pN7LGnbMzE=;
 b=gU316YnbDzDciuzphqEtdPKO1aEKSqsq9iyPhe5d6gzMHTp1T0pkU3a4OaTApGw/wTIy4wg53biEOl15bexZp3Sja3C+IEXRMsPBpxa8IT25AolpZja9fX0dW1Ep2H/sc6BrPxjBvTekomPAOaoX95nT9FZK2eTLtNZPRFWmoymVW/v6Qe+gUNwz3WD30jYyT7xV+VWFTSGholO1IZ46a7j5l0XB2GoPYCu+YFDE5AEYXa/3+DlxPGlAuN7Y9gwILxMNBw0F6FOR6LIs+rX39fB0CC7+0TuZxg9HPqgyzoXVcbNQ8kWgPR3TgJL8UC+9JrRkEb3Kkmy+YttpEcbSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrIlJLO6dizuGm5Tq0OycZsNClnc51q3+pN7LGnbMzE=;
 b=qvuciGlSup4+3cqQRWH2eCXI8ezMSWLa+YbpeCvtinYaqKO5KySX2r+KMyy4nuJ0m0bVkFWsVwDhEay/RyNreim56ssU0GBuVGtrtfgQfUbY4k2UsYS5aokjHjTJAl+smqrOSCVcc46sN1X6shZAhmR+y/DHqThoMq6Gt/GQNdWXKREUmCHRg73jnwy4pN8qfwoFaDT/zDaeOnjJ4HZuR3sBQMQ9ivL4Vu8oqAXMtd+DXmC47k9mSPJVLNJb99rskjrDGBOgbeeyYJwIzsroS/GaYjzB2q5xccp7+qbWQhz//7QIjHWRBd1jwHCAhIGSpfHSgHF+LsbBBByjX9Htlg==
Received: from DM6PR14MB3871.namprd14.prod.outlook.com (2603:10b6:5:1b6::20)
 by SJ0PR14MB4664.namprd14.prod.outlook.com (2603:10b6:a03:371::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 09:18:24 +0000
Received: from DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a24d:c80e:726f:9848]) by DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a24d:c80e:726f:9848%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 09:18:24 +0000
From: yo sang <stlfatboy@hotmail.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: data modified by second NRT write with same memory location
Thread-Topic: data modified by second NRT write with same memory location
Thread-Index: AQHZxFkf5jzl3P6vkEqeVqOzGMy4Jg==
Date: Tue, 1 Aug 2023 09:18:23 +0000
Message-ID:
 <DM6PR14MB387142813E6733B5C9DEFEE7A30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
References:
 <DM6PR14MB3871876E6E078D3BE974ADCBA30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
In-Reply-To:
 <DM6PR14MB3871876E6E078D3BE974ADCBA30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Ho/8jS0HlCq8SnaR+4OEPg==]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR14MB3871:EE_|SJ0PR14MB4664:EE_
x-ms-office365-filtering-correlation-id: 62544755-1a30-46c6-c5a3-08db927041bd
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uXLUroTqKGG/mFQQyjUaTGiFAMz3eK7eNaRi1ZCHgu0B0NhH25e+9Koh8ArUgOZB03/bvK3JLiwQo9I1FIPSGqxLgM2ABpzGOOGCTfVgnLE0AgD1nwnl9eVaph1FgTIBFubhekShPLwuY9Rh+GFsKezDQA+Qa7AVA9KHgqeQ4xKZULgpRlzPCXrGspRfp6IQHGskZqGIqcLz/jEduCp8lPStkJsNG2c+WXFBUFYCFT5rGw7SqYxkLYV4eFGbPGkKIj/9nEHsb52roOR7wvLj3Y12vkplRBaWapoBUx66pcCif7oBTW2NkX9WiUStqyVBMyX+Tf0wJNS7fiH2Ie1ZmZDypDZTg8B5Un9+tJA5oLKqf4tRwL+SJ0BDUqFWxXEoO/RN5Ga7gsO0+BcddMMl7yU6o1bzc6hTk8400J25Z37iw+762WPCez6W9wTIwgAou9Mp5g+svTkJJw2Z0xhePselkO+i4OvrMtYarYtiZfqAbXMr7z6wNppX8B91Yyp3mvaNz1kkUAcMum3AS+q1vLGcDS9B8xqpcc09Otcxw7PPpAVITvfOejAo/+dtdUmN
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WG5rQm5LTHJraUVSOXByT0hkMWpueldtekE4MVNBRHNUNFZFN3IyZGpTNGYr?=
 =?gb2312?B?TjBuRHdlOTdTWjB5L3BLQXNEOHNuSWNmWlRFMCtrSEJLeXlzSFp3WEh1aS9h?=
 =?gb2312?B?Y0JvVDVteGFHbzQ3QmczOEQzT3EzL2hHRk01STQ5UkZnV2JXMU8yQS9OaVEy?=
 =?gb2312?B?RTcvblE5cklKMDl6ckswVTQzSDhURmVqK3dKTVpJbXVoTWUvcnB5VjJQQ0du?=
 =?gb2312?B?OW5DQkRzdTg2cGUzQlJpQldGSE9PbjYxeHkvRHRibSt3VDQxMXExQUFHR2Z6?=
 =?gb2312?B?SjhtVUpyOHdETHUzV1F4NDdzQkgyemNVdU9YTVFjMk9lcjNkeTI4RDlPc013?=
 =?gb2312?B?cWg1QlNrTzVOblJpRDdzejBralBLSVQyV3pXMDB4WWlkUllBby9PaTRzUjd3?=
 =?gb2312?B?WlJTUzlMWWczSEMrLzhTMzJzYk4yUHMreFhpajhKYWxrUGp6ZzJNRmlyeEhO?=
 =?gb2312?B?S0ptMkFCRFhQaXVwRUJyeWNvb3BqN0lRTVdaeUlwTUtXdnBqSVhsVVZ5Y0xq?=
 =?gb2312?B?VmlQSmJNWnlSK3prUTRocWZQR3JSclE3a2JIcFd6Y0VGQ2MyclJnQ3BmWmIv?=
 =?gb2312?B?MkpEV0RNV0RSNXVGRTlPZEV4R3RzVCtlZVl3VUJ4MWtFak9SanBHem1FY3lY?=
 =?gb2312?B?eUg4Mi9VUnhPNlRyRUxzMTJXT21ySWN5eGk0WEloYXpWVkpxV0ZMcXpzSmF2?=
 =?gb2312?B?UTNDMlB5eVVTNmNxYktPaE1meitvWGhWMys4K1M0eGpyaHVrZ1pwVVhGVVlB?=
 =?gb2312?B?R25DOUVEMHliTVkrbktxbDJ4cXR6dFNpUVZmWEF6cytPcHF6VmpEdVVyNWh4?=
 =?gb2312?B?UEp6VUJCN1FmUWN1NVNIK0E3TFhTYVlvZlRrelQ0ejdEZnJoMlZ3RUdPTzVV?=
 =?gb2312?B?MFlENzdzMlRkU1F3TkJib1ZSVFhJRThNUUttZS9yOEhhcXJucmxQSkIrUGw4?=
 =?gb2312?B?a3h4NXR6WUdxbUpZU05YK3kxd2NXZDFWVWtpclF1bWdwSVczWklLRjlVRWhr?=
 =?gb2312?B?K3UvekV0Q3VqaE5lZExWQWNtMEVFaFpVNk5OY3JLdTkxSC9FNStTUVZ0VUdz?=
 =?gb2312?B?bnFVL0VQOVFFcHRzUjhCL2RYU2RvZkdXa2NXMVc2eUdIeFU3NzFWcmJwdmV0?=
 =?gb2312?B?TTV6Y0F4T0hXOFlRSzR3N0pxcW5zWUdLS3NTRTVKemJLMGJTaGpvSi9sSFBL?=
 =?gb2312?B?UStwT1JDenVndzlKTUdDNWNkVzJwdEh0QytuV0x4cXJsVlZORWpJOFE0RGdH?=
 =?gb2312?B?VnZFcW9NSmRzOG5ORXgyZnpTZU45ZjFWMjc1RUNYamtiZ0gzZ2NZWUZ2WE13?=
 =?gb2312?B?ZzIzeFZDSjc0ZHp1ZndIWkNvRDh3dU5ETEw4dUY5TnNaclZ0N0hHNE5IYXFl?=
 =?gb2312?B?OU85YUtNWWErMittUlczelpuSFZvYlhsQUNxc1hDVWllOHJNRStMeE9jVjFR?=
 =?gb2312?B?QzlFWXNmSUFBUEd1Z0dQSlNGTjZYbUlvYW5yT090UmRRd3E3TEpzeFUzR3Nl?=
 =?gb2312?B?RjJ6VSt0VStQL21FSnVpWTR4dzRLUmNHeUtpc2IrYUJLNFVnb3oxbzAwOUFR?=
 =?gb2312?Q?vM9b73Z/hN9OslVwXYVZYMNzTZUo8cW55vmFW0S8GmbNGq?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-cd57b.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR14MB3871.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 62544755-1a30-46c6-c5a3-08db927041bd
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 09:18:23.9487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR14MB4664

SGksDQoNCglJIHdhcyBwbGF5aW5nIHdpdGggeGRkcCByZWNlbnRseSwgYW5kIGZvdW5kIGEgc3Ry
YW5nZSBzaXR1YXRpb24uDQoJSSBtb2RpZmllZCBvZmZpY2lhbCBleGFtcGxlIHhkZHAtZWNobyB0
byB0ZXN0IG15IGNhc2U6DQoNCglNYWluKCkNCgkJKiAgID0+ICBnZXQgc29ja2V0ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KIAkJKiAgID0+ICBiaW5kIHNvY2tldCB0
byBwb3J0IDAgICAgDQoJCSogICA9PiAgb3BlbiAvZGV2L3J0cDAgICAgDQoNCgkJKgk9PiAgY3Jl
YXRlIGRhdGEgYnVmIHdpdGggobBmaXJzdKGxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgDQogCQkqICAgPT4gIHdyaXRlIGJ1ZiB0byBSVCBkb21haW4gdmlhIHdyaXRlKCkgICAgDQoJ
CSogCT0+ICBtb2RpZnkgZGF0YSBidWYgdG8gobBzZWNvbmShsQ0KoaGhoQkqICAgPT4gIHdyaXRl
IGJ1ZiB0byBSVCBkb21haW4gdmlhIHdyaXRlKCkgICANCqGhoaENCgkqIFN0YXJ0IHJlYWx0aW1l
X3RocmVhZC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPi0tLS0tLS0tLS0r
ICAgICAgICANCqGhoaEJKiAgID0+ICByZWFkIGZyb20gTlJUIGRvbWFpbiB2aWEgcmVjdmZyb20o
KSAgICAgDQqhoaGhCSoJPT4gIHByaW50IG91dHB1dDogobBzZWNvbmQiDQogCQkqICAgPT4gIHJl
YWQgZnJvbSBOUlQgZG9tYWluIHZpYSByZWN2ZnJvbSgpICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCqGhCQkqCT0+ICBwcmludCBvdXRw
dXQ6IKGwc2Vjb25kobEgICAgICAgDQqhoQ0KoaFJZiBJIHdyaXRlIHR3aWNlIHdpdGggc2FtZSBk
YXRhIGxvY2F0aW9uLCB0aGUgUlQtZW5kIHdpbGwgcmVjZWl2ZSChsHNlY29uZKGxIHR3aWNlLg0K
oaENCqGhQW55IGNvbW1lbnRzPw0KoaFUaGFua3MNCg0KICAgICAgICAgICAgIA0KDQo=

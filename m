Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E92567
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 09:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJRExRhxPeNbnFhSaFCUZpvBBIwrkhCaV33LwPsJLGykv37eH2aU3jx2kK86sR15tNiupxNLnlivzqfZRFn6eLhJZ42auGyVHTTUBgpvO9mPX2LCAen3+I7h3NwIXeNyluSU6P+gZUem3xarRAM54M8MDBe8AxW9Z0Pv3CVHy4KGNc95I93gYFRFi9RBvFYtabEkjnID/eWvlHiWFf4bkIskANVhhQ1NrrCIR1v0D1fOTrUyHM3ARFyWFSEq1yZ94eywLg3Wg1jG3GNriMKFbfCmziobshsuhlrYanCY7RayOvTC+jb1nGqt3V0cwG04dL6OU9nU/ECshoc9I8Mjww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OWEoLz09kVV15YLPJXGCo8sBKtOrYPOAxko3G8dQ4E=;
 b=VylXYrZssctHCpUtiQIdYLaFM4X2lHUoYRfwv0u7GgUxT7umG/JZ7fY88d0YGNvbadVwf8vrpurRiGt75EO5Ho9i5ZLQdRKoeHMrH5FzSaf4JS94fB04kZLVkvQt5g1Bnd6+AYrV8x7StEhdK8ABoTX48dGiRnbC8z7VjtkaeawFUcS62D6K6XwSoYh+TnwePoU6uyJ47SHYTI233OYihduqWBX+pXKS1/NmCGiJuE5G+5TTdDPlsvMII1NAI9t4EuIZpOWtb/FtelNHCrN5AJLDVQQD2lseWFty8YqH69tklfaSISAVPPoMGMTnYGzLUUcT43wIZmzNiQLC6IL54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=e2mtechnologies.eu; dmarc=pass action=none
 header.from=e2mtechnologies.eu; dkim=pass header.d=e2mtechnologies.eu;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e2mtechnologies.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OWEoLz09kVV15YLPJXGCo8sBKtOrYPOAxko3G8dQ4E=;
 b=NO5IsJ/8Xxp73j00lVTICBRIA8Jx5amoiDlsZMT8mpiPSQYFVmhpa3gNNUdR8J6gsVpTp1a3V53Z/MegtDRjsVKocAHcOCD8NeW/ZL7eLWLxlhLHyAO35G+7/lz4dfNN7hSstB0Wvwct8LDEacDe7Iyb6wZ6r6srDaKlziQ4LaxSPp5zAvv8eOSSfpil5/jW9SE2gRMvekUHnr6f2+3e8VWFuCvOiMMRwNMXjbgl8wESVC+GSf1eY424ngnm444VqmLtn1eDNutXAeOSrp2ovMyAgqvRMkYE2jtEtoBoNVrrFk521xxfXd6AZXgNUmdcD/jERWHxjhgP5tfDEWYfKg==
Received: from SJ0PR04MB7405.namprd04.prod.outlook.com (2603:10b6:a03:295::16)
 by DM6PR04MB5787.namprd04.prod.outlook.com (2603:10b6:5:164::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 09:04:42 +0000
Received: from SJ0PR04MB7405.namprd04.prod.outlook.com
 ([fe80::5a89:17ff:557:facd]) by SJ0PR04MB7405.namprd04.prod.outlook.com
 ([fe80::5a89:17ff:557:facd%5]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 09:04:42 +0000
From: "Wielsma, Feiko" <fwielsma@e2mtechnologies.eu>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Xenomai 3.1 on Debian 11
Thread-Topic: Xenomai 3.1 on Debian 11
Thread-Index: AdkO0gA91dGja6lFTt6G46rq4nTm5Q==
Date: Tue, 13 Dec 2022 09:04:42 +0000
Message-ID:
 <SJ0PR04MB7405105B6192C0A4E1706DFAF0E39@SJ0PR04MB7405.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=e2mtechnologies.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7405:EE_|DM6PR04MB5787:EE_
x-ms-office365-filtering-correlation-id: e48a52ca-ba00-4742-8a17-08dadce912b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jMzufGhji1/LGNA+sx2KbF3VmhWKmjPoAsPPcnv0iU+ZD2kzY5g0H6Ooyjr9XYmVxcc3Kxk/ZewpFlbsYi5zBwSpuAJF/aNN76GNVuxC/xKj0B/tS+1NHkDi/gF2nFeQaHi9ZQ+ppqxDISrbJGTLGFuAmDtq0YjxkzGoHSkDVmA6UgriFF4ayzLgwD9/N9VYIwYQNz3XRfbXqkN9cluPy+cDLYEniTQD01ryuGm8ZLfqEnhPJDsxNMUygzL0an7dQE2q0rdRCSxnkcuVY7hIYyZjd/UQxe84JMObxw0V5N8fzSiz2lH3LamfdnuV0HO+BDtOssl4LsPbzYHESGa4hKkKL+JKeWQN5ftHHvRc8fWnjJxFT/THHabKy4F/HblHWl0mMNMfp0MC5nlVnn4sp1w3IorfLM7EJoC2Pm73l18oG3l6wDcvRb90bFnXyUDxL3J1H3tjyv8jqt8riVDam9dzfdsHJaZbX7L0cSF2KbQaicj12J1qVATVquczVCjb3YNFlQNOStLGFoWuSwULSS7mKHevwJVW67IoJFDyGq9n+g3R4GofskxqFoqmHCKzsyM9Uj/wNivKnnwsEr6WV9td2Xoqss0RXez2053fNJ4t9US1mSYzOuzVGR5GlbaidLqQE6RNiykfSjarf+hIG4lbd+xfW8Q+w3rFOlgC6ORYWw+/AaL3Rf8eXkvgMYVjX7I79Fcqsf2W6S3qMzXLzcyvQ1zHTyv2MFcCqyQYP7o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7405.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199015)(38100700002)(38070700005)(33656002)(122000001)(478600001)(966005)(86362001)(316002)(71200400001)(6916009)(8936002)(5660300002)(52536014)(66946007)(64756008)(66446008)(76116006)(83380400001)(41300700001)(8676002)(66556008)(2906002)(6506007)(7696005)(9686003)(186003)(66476007)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVdrNWFsK0t0M1NML01Wd0VKWllzOTFUL3VZSjZhZVA1K2lObi9mb3VMMnRM?=
 =?utf-8?B?amhwZDZsVW1nZWh4TTZ5UDNqMTBwcDNyTW44bkg0Q1V5cUlURFRLWEd2azc0?=
 =?utf-8?B?SXFnR3IzSGtnRnRNL3lpVlZNaEdUVFE5TkpHVTdSRnhYZXlhaXR2MG1ieXB2?=
 =?utf-8?B?cWVMU0x4LzRiKzVxUlhKcEw3dGxWR1hTUUtZa05maXlOd1NZWnQ3b1F3aXpq?=
 =?utf-8?B?TWtFS0hXQWcxb2xZdnNVbERCYkNrUnRVV3Uxc2c3UFdST3N1M3hGK09aczVv?=
 =?utf-8?B?SWVFbERxYkxOa1VOeVNFSEtaYll4cjJEWm5OU1BiV2hwdG9wSHRBb0xkdExm?=
 =?utf-8?B?bDB2MGlrbklJczFoYWpickw4RGdxQS9TT2RUVVU4NkdYbGV2K2R2dzFVUlgx?=
 =?utf-8?B?RTdOclh4WXp5a0Y2QmV6TzZmRGR2WWdXZDdCU2tETngzYVNNVDc5M2hVLzA1?=
 =?utf-8?B?eGRyVWo5UTNqSWdkeU9Idk5pV0Q0dUFSR01uWFJTWDl6enZxV2VTMFUyRFJT?=
 =?utf-8?B?Z1FEMmMrbjdCWDRlWWh5L1VZTTE3b09PRUZqd05HWTl6QnI5V09QWHl4UUVP?=
 =?utf-8?B?K3N1K0VscllKT0tkWlRybWFvSFpyWGpwZXFocFk2SmJ1M0tCaGlTVWFDYm5r?=
 =?utf-8?B?N2J0QmhGQ0dnUHJTSUtIYURwZm83N2tVSjBKRFBTemVxSUQzellCb0U1K216?=
 =?utf-8?B?Qko0Vm1jT2liYkczaDNTYkdPa3RYcDFKUHVubDl1VzFoK1hXRWRLaGNZQnJx?=
 =?utf-8?B?MWs0NEtoMHhkSTZmUDA5SFZkYWR4bFVYSngySVZvZnhVbGxZdWRFU2VTUlpB?=
 =?utf-8?B?dWpFOHhZalorcjlsamxlMHU1dHVsWE0xbjgwT0xtZStXbTd6eitCdmExaDls?=
 =?utf-8?B?TDIxaDJMS1dpUllmWHVRdTdJdU4yVHFSNE5uQWUzZmRPSy90d056OVZ5YWVh?=
 =?utf-8?B?ck9SQ3lJc0o3YXNNcU1ubG9jWnZueklEbkx5ME8xY29Pd0pVR1V3cmJWaUVt?=
 =?utf-8?B?cm1GRG5JNmJOR2lydjViS3pxakpFbU5rcWltcmtnSFZab2s1YWhrZTkwZTdJ?=
 =?utf-8?B?Z2hJS1BYWC9URXQ1R01tTyt5ZTk2dGduYlF4WTdFTTlkY0dwZGJORmhGekl2?=
 =?utf-8?B?M0Y2M1BjZ1pMTDA4SWsxVDl2M29FN3dDUlo1R040emtkR3RkTVV6M3dFL20y?=
 =?utf-8?B?WTBJY2IwSU1CTVZGbDB6V29JQ0k2SUtBamN4VlBYbU5ERkI1elNlQ2JjQ1A5?=
 =?utf-8?B?eG5pcmRjb0pTOWZuSUlIKzd4L0N4TWp3SDRVTXVaOWNFckhSQ3NxNS80aUhy?=
 =?utf-8?B?QTgzNWd4K2Y2RjVFa1BFc0t1VFZaOE9xYWd4NTBxa0lBaTYzVEcvQ0VuYnF2?=
 =?utf-8?B?NkFKeHRsRFcvS3VMTUpMUXRrMWxOYytwdnVvSlFvS3NLc1V0S243My9wYklC?=
 =?utf-8?B?TlhuZWtLTlpLdzV5bE5temlwSnJKOUdoV0pCQzVFN1N5NTFEazVCeXo0WUE5?=
 =?utf-8?B?dEpGR09vcDIyRzA3QW1ScTNDY0RHbEd0V1NHSDlMT3FGUEtKVElPb2Q2T3Zw?=
 =?utf-8?B?SnpwSjQvUi81bTFhcmpwMnljWm9BV3RtVlR3WG82d0dvOEVkdlpRZ3dONGZu?=
 =?utf-8?B?WmhGdm5ITnFVbk1ZOUhpRHRRTW85dEhBRlg5SHAzWExzQ3ZIRWcvV3RhWG8z?=
 =?utf-8?B?NG5wSnBHZ01qVU1qU2ZsOXVtWnkzVnJWcnd6dzcxczJFankwaDdROENGejA4?=
 =?utf-8?B?b2JFa0dYMkx0ckxLN08vM2tBU3U2azFQTnJ3YnZ6SGZNMjhManFkNmZaMmVL?=
 =?utf-8?B?MFRSS3lBT0d1ZGlGVTV2cmFRNFd6SFhXSGFPbXVHcUcwakpITHRRQThsL09s?=
 =?utf-8?B?c0FSU2UxdjB5NHplNk14cEhXWW5GWk5SbHJpQk9IanNVMFdFRSsxSFp3Tmsw?=
 =?utf-8?B?eUNzazJaUUhwbXJ2MXhpTG9lSjI2TzBDOG01bzIwL214b1dJQytwcENYeE9G?=
 =?utf-8?B?NUJjNTdhclN1SGFDcTR4ODdWTGhhRnRVUUJCQzhnQlJHaVUyZTd3SVBGdHJS?=
 =?utf-8?B?WCtJQThaeVBWSVpNTm84ZGhuR2lRZlVMRFhDNDlrOTVKeHhsWTRxcDVFWldm?=
 =?utf-8?Q?hIUXEuWYIz4W7kMQOw6EHqh4P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: e2mtechnologies.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7405.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48a52ca-ba00-4742-8a17-08dadce912b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 09:04:42.5477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7fa3ed9f-fff9-4884-a6e2-8dd98886b775
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /dskR4jzAzkiK20on3x+fBHUjIUByGk6O/7gY9MhaAjwQmq+fLwLS6EJVCtsOqRD6qROAuzXgC543Pu/x7mfrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5787

SGkgWGVub21haSB0ZWFtLA0KDQpXZSdyZSBhbHJlYWR5IGhhcHBpbHkgdXNpbmcgWGVub21haSAz
LjEgb24gRGViaWFuIDEwIHdpdGggTGludXgga2VybmVsIDQuMTkuWCBmb3IgYSB3aGlsZSBub3cu
DQpXZSBoYXZlIG1hbnkgc3VjaCBzeXN0ZW1zIHdpdGggdGhlc2UgaW1hZ2VzIGluIHRoZSBmaWVs
ZCwgYW5kIG91ciBjdXJyZW50IHNvZnR3YXJlIHRhcmdldHMgWGVub21haSAzLjEgZm9yIHRoaXMg
cmVhc29uLiANCg0KV2Ugbm93IHdhbnQgdG8gY3JlYXRlIGEgbmV3ZXIsIG1vcmUgdXAgdG8gZGF0
ZSBpbWFnZS4gT3VyIGZpcnN0IGlkZWEgd2FzIGdvaW5nIHRvIERlYmlhbiAxMSwgd2hpY2ggYWxz
byBoYXMgbmV3ZXIgR0NDIGFuZCBvdGhlciBwYWNrYWdlcyB3ZSdkIGxpa2UsIHdpdGggdGhlIG5l
d2VzdCBEb3ZldGFpbCB2ZXJzaW9uIGZvciB0aGUgZGVmYXVsdCBEZWJpYW4gMTEga2VybmVsICh3
ZSB0cmllZCA1LjEwLlgpLiBHb2luZyB0byBEb3ZldGFpbCBtZWFudCBhbHNvIHVzaW5nIFhlbm9t
YWkgMy4yLiANCg0KVGhlIGlzc3VlIHdlIGZvdW5kIHdpdGggdGhpcyBpcyB0aGF0IHdlIGNhbid0
IHVzZSB0aGUgc2FtZSBzb2Z0d2FyZSBjb21waWxlZCBmb3Igb3VyIG9sZCA0LjE5LlggLyBYZW5v
bWFpIDMuMSBpbWFnZXMgb24gdGhlIG5ldyA1LjEwLlggLyBYZW5vbWFpIDMuMiBpbWFnZXMuIFdl
IHdvdWxkIGxpa2UgdG8gY29tcGlsZSBvdXIgc29mdHdhcmUgb25jZSwgYW5kIGhhdmUgb3VyIHNv
ZnR3YXJlIHJ1biBvbiBib3RoIHRoZSBuZXdlciBhbmQgdGhlIG9sZGVyIGltYWdlcy4NCg0KQXMg
d2UgdW5kZXJzdGFuZCBpdCwgdGhlIGxhc3Qga2VybmVsIHZlcnNpb24gc3VwcG9ydGVkIGJ5IFhl
bm9tYWkgMy4xIGlzIDUuNCwgc2luY2UgdGhlcmUgZG9uJ3Qgc2VlbSB0byBiZSBuZXdlciBpcGlw
ZSBwYXRjaGVzIGF2YWlsYWJsZSBhdCBodHRwczovL3hlbm9tYWkub3JnL2Rvd25sb2Fkcy9pcGlw
ZS92NS54L3g4Ni8NCkRvdmV0YWlsLCBhcyB3ZSB1bmRlcnN0YW5kIGl0LCBvbmx5IHNlZW1zIHRv
IGJlIHN1cHBvcnRlZCBmcm9tIFhlbm9tYWkgMy4yIGFuZCBvbndhcmQuIFNvIGV2ZW4gdGhvdWdo
IERvdmV0YWlsIGlzIGF2YWlsYWJsZSBmb3Iga2VybmVsIDUuMTAgdGhhdCBzaGlwcyB3aXRoIERl
YmlhbiAxMSwgaXQgZG9lc24ndCBzZWVtIGl0IHdpbGwgYmUgYXQgdXNlIGZvciB1cy4NCg0KV2Ug
dHJpZWQgcGF0Y2hpbmcgYSA1LjQga2VybmVsIHdpdGggdGhlIGxhdGVzdCBpcGlwZSBwYXRjaCwg
YW5kIHJ1bm5pbmcgdGhhdCBvbiBEZWJpYW4gMTEgdG8gc3RpbGwgcHJvZml0IGZyb20gbmV3ZXIg
cGFja2FnZXMsIGJ1dCB3ZSdyZSBydW5uaW5nIGludG8gaXNzdWVzIHdpdGggZHJpdmVyL3BhY2th
Z2UgY29tcGF0aWJpbGl0eSB3aXRoIHRoZSBvbGRlciBrZXJuZWwgKGl0IGxvb2tzIGxpa2UgRGVi
aWFuIDExIGV4cGVjdHMgYXQgbGVhc3QgNS4xMD8pDQoNCkJhc2ljYWxseSwgdGhlIHF1ZXN0aW9u
IHdlIGhhdmUgaXM6IElzIHRoZXJlIGEgd2F5IHRvIGtlZXAgWGVub21haSAzLjEgY29tcGF0aWJp
bGl0eSBidXQgb24gRGViaWFuIDExPw0KDQpLaW5kIHJlZ2FyZHMsDQpGZWlrbyBXaWVsc21hDQpF
Mk0gVGVjaG5vbG9naWVzDQoNCg==

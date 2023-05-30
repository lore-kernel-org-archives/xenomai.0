Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232320683
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 19:23:47 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UI3p3Y012919
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 12:04:28 -0700
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0149.outbound.protection.office365.us [23.103.199.149])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3quh1a40u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Tue, 30 May 2023 12:04:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=KgmYwQsMgfeIdHVZ33ia84MU0ueLZkGNwKbWVl0qcO4X47LGnSPEv5YBb4a9Ibk/wq5hI+cbRC98lWwl2JUMo3szRoEMuVNZwCKytAtDYCgXS9S6xEbensd01lMNY9LIt3PSFFvqKk3HZRmaPn3AS0renY2Thuy4yP1B26PujS5knubxA3IVKYBTsVg2nKe1YEn3QoZftoLnBr6DD2b25/I3K20YFUDRgT1TMpSGDQmGfgwfxbGhj5cV6+/JrbwpkWGCqABR6aqfoGZrJbda/Cdu34U1mIEkj5GGRDffoLe7LxAjsgs0t55pNBQ2XAyPiCIqK1PelDkkpDHxSg3qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZT2WV/wFudgWBasKAnjDjHQT3IBWs9wwGq9FeJ+bdg=;
 b=EsdZ/7Ny+pGYvKH4R+TjMg7Iq96CbOE0h+xO0IEIvu3oBs4mT6HsgW9dCHueyvxuMGqmL5qWHjRRJ7NWktI6tbOq1V4n/BBzaS2imzXXkTYls5d8RAK1X2/t7hegWjdknNYPCsDadtp9ynjbAh7CEoTtaH53WW2afARYJ5oodAHxhgsIbHzv8uxGLFHIxrnlJqNPdMqDKMN9bRpxfYGAf3RdFPVhQKeDpgKsLxtM7QldcsnffPAhpkBHb0wcswZeXN2ymWZZ/QiSoOXSLT2xUzGDRxfPb06xeZExpxSRGYrE9etF2Hwf1c7G4Kg9GBksc52qxUyjbS4lYD5L0BCJDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZT2WV/wFudgWBasKAnjDjHQT3IBWs9wwGq9FeJ+bdg=;
 b=gN6xYAY5T6+nL/e5cXdUOV2h2xQPa3sXpk23+dC1VpfzQuAd6vYtuH8w8juW48/imR3qSinLztzas56meIuBSLwRnbDOrHzKkTwwziM1JtrZpaJ4zim3yFZPfV0HsEpXV/YozCP7Rp6OKday1UdyQc/+JUb1Mf8/kFEyfW2H/4KkiPG32pdWHWwgRQc/IH3/ycIkgpia0cf0z2g0IwGUTquETUFgEXCLUuhD7qMqrykg1z1WYEoEf3tm4XCEtZ/fDwPw9qcASVcV0ygyeIwC5+/7zT+jlJFAz3o1wtTnU+2byL3gw9YbaxZsLzNqTNl/TYErL43vJ4KTQiB+6EsJqQ==
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:188::21)
 by PH1P110MB0986.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 19:04:26 +0000
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1b64:cf76:6f6f:756e]) by PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1b64:cf76:6f6f:756e%5]) with mapi id 15.20.6433.020; Tue, 30 May 2023
 19:04:26 +0000
From: Dave Rolenc <Dave.Rolenc@kratosdefense.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Dave Rolenc <Dave.Rolenc@kratosdefense.com>,
        Russell Johnson
	<russell.johnson@kratosdefense.com>
Subject: [PATCH 0/1] rwsem_down_write_slowpath check if oob() before skipping
 schedule()
Thread-Topic: [PATCH 0/1] rwsem_down_write_slowpath check if oob() before
 skipping schedule()
Thread-Index: AdmTKB7ZibIutpduTSuhl0VLfIrkxg==
Date: Tue, 30 May 2023 19:04:26 +0000
Message-ID: 
 <e5624d226deb4a49bbe28867e15eadf9@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1666:EE_|PH1P110MB0986:EE_
x-ms-office365-filtering-correlation-id: 18df6d6c-ffcf-4fce-7414-08db6140b033
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 u6cRELgTbGc1FbuSu0PWKog2Sq3J5TDc38+sydHhrsnRt9227VdFD/B6PEPmfDlwAEKxQm+G+sO/MBqCphRCGE20nJrsDqm1yEWVOFZ6QfK7ddMJ3LERIj1nnkgUaXMRt9OchZokQSovV+RHv6Al9HlIsLJIovhrLWTIL6xFe0BMn8CIxdindWRbN2Ys0HNbcXbyBd2YvtnkZO0eoog7uPpKV63TSM25fHT7TiL3h5w8a0w3w0/1LekmcF/zuh7GaWmva5PliGW8ihaZntQ6A/GyIRvkEtvSzmwR1C3/+atSPCBtkKOUkEnFWuStkZomglxaZLA8apT/fBPxmYzvA77MAbwsQWKAGP07hhUe1rD/hqRi+oYqrWLMc7b5YVYhg2lNHa1xkzsI5CAm6k+0tQITiYIHD6lU+WlmzGkGvVOEY0xVhTwePOywX/un/yfxXJLSwBFzw4PLvD3h6vl+Oz0bZyw382bwQbCWFaBkrl5mHkW+rBBhbSaOKwGFGAxjRYI3JYf8MHLUsjC3C19NizRSSNTMNXETlB5y4U8Lb0CP/j8R71kObPb9dQHiwpHIPh98juhXgyYjDJCXa0ZAy1h1keuiIWV4ibQKV/8RYimBj+MNJwcaGcXZYY/e0KiA
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(39830400003)(396003)(366004)(451199021)(8676002)(86362001)(24736004)(7696005)(508600001)(108616005)(38070700005)(41300700001)(4326008)(55016003)(6916009)(41320700001)(71200400001)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(5660300002)(186003)(2906002)(9686003)(6506007)(26005)(83380400001)(38100700002)(107886003)(54906003)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 ir89SisAPvaOIsn7DxmaHBWPqNhwKcfr8ua6Zbp9J8YXj48GRzyrLHDoQ79wkd4uk9wy3wfsSYtaIilfSVKGZL0JPzfMQ1+uw8MTEOhueCUxUFglXsyUsWJ4ZzOeh53CuEXn758rdO7fN72k0+r5qD37tE2TDuHzqlbD/HsQvdBzW185kCyrQnKeWUMn2C+USL4wWTojpTDEvuytCNGjsrBO0JhxcpuGS0P7No6o0I0yLRjOVXig3AeLjKCKAeco/OfJ3+uHDCk9TEvOhTa9phOLP6i1AUVzzWY1p7bo44lUJrc8tIjI8dBJlp0Kh47QaZuGOlbRxq0vSN97t92T8K0c7CHd7ZwCO45oRdzrzUKr2dhcgxNK/pVyzfqFDz+zHwFQUPhSUI1Z2pDfWK+hwilf6yymPQC8MeIfd+GVkG8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EDfr9y/BnTcWWR5wIxWlQi5D4BeEKQn21iLpi5I6VmD9V6vqt2pYQCCQ5oISDJdC29LytiV6jLZGk/T3tDeq3rZ/ImHF1G/4u7UXY3D9Bk4yfBhfiEF9afmqzNaKUsqz9FTuKKFeaBDwEv1mzLKAJIfLmnBBFGvzOgKj4GiitKFq5c93wx/YDDFk2iPzcKhqU8XKE7Mku1mGee1688FgooGkSgXhh5Cm8DwfuzknSNlo8IbUPdFii71Ca35uHS5tiIy/VxwvUBV8fRwjajr5801G6YY8bmmjTIymAYSCEYCIz/M/64X5hLFy59Xx+FGjXTKsUHU0nmzFVmiLCbisTD0L3YfJAynyZv/MpyD7XSHwpmBdjB2Ee313sNW+Q23pZ9ViIK9UThsphO4a0yO/pNAa1VatkUn/DonN+Wl4Rt6MzfS+b1pOBYGOgnlci9Dq6GpCtbsS/lfeYS6lIAvgaXgeoMRNVnbvPBH+R7IaKFMoJFc/Ep9WanMuBtUVCBJQ5xh6gJyGx29k5x0982ns6BkKelWYOLc45uR58IjyDMU7j3UCEv5w14YR4dX3RZsrHPWFTR4Rlr2HX2IP5GqKQEiNzF3hFxbqogNTraE6t+vuvgx56W+EGU3jATHS7ztgUZlbclKrWp7NHkMi8sKSB3F7rMWgYfppbs6ZODrxMmLPas1NF6He7iP/33WjhihevXf3nJSKwQ0DwC9rf/p2yFjZYABHAGZz4jjx7HBMDGGH0WXpCOD8JiFcEAnEHyzl/kdZeQTIOpppYDeKuS0fgg==
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 18df6d6c-ffcf-4fce-7414-08db6140b033
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 19:04:26.4895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB0986
X-Proofpoint-ORIG-GUID: 7LYjPTf1LXNbw7NqnFsD_NQffuymPiSe
X-Proofpoint-GUID: 7LYjPTf1LXNbw7NqnFsD_NQffuymPiSe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_14,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=475 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305300153

This fixes a timing-dependent bug that would cause a tight loop without
schedule() when running in-band. The rwsem would get released enough to
allow this tight loop without schedule() to execute when the handoff
bit got set, but it would never allow the previous on-CPU owner to
finish releasing the rwsem. Checking to see if we are running oob before
skipping the schedule() seems to fix the problem. This problem was nasty
when the global kernfs_rwsem was the target semaphore since many tasks
ended up in D state waiting on the kernfs_rwsem.=20

We would typically see this problem when repeatedly starting/stopping an
EVL-enabled application, which would create and tear-down a lot of EVL
elements. Eventually, the timing worked out to where we'd get a stuck
CPU message and a bunch of tasks in D-state waiting on the kernfs_rwsem.
The cuplrit task was stuck in a forever loop in
rwsem_down_write_slowpath() with the handoff bit set and skipping the
schedule() call.=20

This patch is based on 5.15.98.

This is also my first patch submission to this group, so if you need me
to follow some specific procedure or checklist for patch submission,
please let me know and I'll comply.

Dave Rolenc (1):
  rwsem_down_write_slowpath check if oob() before skipping schedule()

 kernel/locking/rwsem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.39.1



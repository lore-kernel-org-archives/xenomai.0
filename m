Received: from mx0a-0019b802.pphosted.com (mx0a-0019b802.pphosted.com [205.220.162.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6553715AC
	for <xenomai@lists.linux.dev>; Tue, 13 Dec 2022 02:50:49 +0000 (UTC)
Received: from pps.filterd (m0240894.ppops.net [127.0.0.1])
	by mx0b-0019b802.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD2Pq9L020152
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 21:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3dsystems.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps1; bh=JwNOIMKcDU1pWRZ/FhMT9+OWRRkVlp1gXjfHAWeVIcE=;
 b=tL7igKWKXMQPDFq4skouKefXLULS5RGLEUqTBYTRbgCd/zzWTqdtbIatIKaT4RFjyzno
 hSfQsphGCDTSzdxVTQXVo5i4a7KPnPksouL2sCGF1qaump/NC/oRTjgJNUPm6XuKbmmI
 GSVV3w8PcdqCE/m2cUbBXelgt8i+wyXkXvx5Iw7lBQbBGHMo3/Yy/YfENvqX3nIG/n2N
 TfI3eMewpI1Xa57PY7zFSKpmpLhAoaGOy+QT4csujMduNTvaHeqd15TpLtp1lXpynwud
 ICoNFqfpHQ66/S2z+4KqEb2UGdheJE9PQ8A9N47RXMIkumzS7tKX1nQGT/ywgdjc0jhN ZA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by mx0b-0019b802.pphosted.com (PPS) with ESMTPS id 3mcp6vh9d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 21:26:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9vzObkEsVLizNwJZ/uUX75ojZUK8QHZAWS1bK9+wYDNDlNk+XBpa6VmnbXdsalDtvNx8UooJ4OgJkwQu/UBlKfCG/wavgIlvSENM3Eu6mGrOaXjpaRXaUT8Ry3daM18IsdlxcDxXuXdwe40nz1lrNtWMeYCIPJlZtOIXVzZ7Ebcdh92vIXpcNnYR+p0V2MWiKQ+OWFnF5/xwVjVvOppWbYMvN0uMkxlXlNu36UMSeGeQtKg04jVO1gz/wn5VBq5mI8Rixezf9ssQXLrNp0H+1/mk5V+d9uNLm1kGmAbD93EDUh3WNMJ2LUTViUqo7HpNmpBtyZkxmY1rdFRZugykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwNOIMKcDU1pWRZ/FhMT9+OWRRkVlp1gXjfHAWeVIcE=;
 b=Oc1uxj5vmmpzMGKvn4Qf5B8PZafot/6xDX5dsvwuIC8JD4H6KYcn1nEd/Sz0QaODV5ADu7IzWVZPaN9hHvPj+muPiOjnGzDahw2S7VyK1o28yXKWtqFbxyhO/2oKV6KYkJCSNGT9KP2dYXXiiIyc7R74NJg6aTH2uYFLxsLzFsa2VRxQeFKhnqpp9LGJ6AMEjz/VkqBnVdZ03TBd4pDv1z4hTuimh1CKZO1KTl/aaituKethoVe6bAgBV+kvuJhL0YrRsFh9WW4YBZpI/T9y1T56DeTO3ChPpJ2MCl+917I9gF90MoW/8LFUWGouQT3BWpskOPN6C+k8YdA9Vu+ORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=3dsystems.com; dmarc=pass action=none
 header.from=3dsystems.com; dkim=pass header.d=3dsystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=3dsystems.onmicrosoft.com; s=selector2-3dsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwNOIMKcDU1pWRZ/FhMT9+OWRRkVlp1gXjfHAWeVIcE=;
 b=1m8/6T8be3mKTbwtfc2qgmdsohQluszFEp2X3zaubGYNwNG4hrh2m1Rv7g7eoZnAmUjvqrABjWGcXcYZXMhDEAzAhnHgzFhEldhhiOaPywJgr+TZrgJZ3eP7zOV9g23lN4xfDdysgL2pKtdlC9Uwyxt2QEMsfOZ00wdePG6P7xw=
Received: from MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 02:26:35 +0000
Received: from MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::82ee:198a:5c89:12cf]) by MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::82ee:198a:5c89:12cf%6]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 02:26:35 +0000
From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Kernel source dovetail 1, 2, or 3?
Thread-Topic: Kernel source dovetail 1, 2, or 3?
Thread-Index: AdkOmirUwheJZsjEQ0mBTj9PDBnTQw==
Date: Tue, 13 Dec 2022 02:26:35 +0000
Message-ID: 
 <MW3PR12MB44602042D800C782C18AC8D3C2E39@MW3PR12MB4460.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4460:EE_|SN7PR12MB6982:EE_
x-ms-office365-filtering-correlation-id: b895b036-f2d3-4369-3837-08dadcb174e6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 56zGV0JFQEZ7nUNsbweJHfHchHxaz1GyaqTMjhp3Sx/9//1b7BQBWzt1a0w15k149y26wW/LlLNW8N0/yb1v+B9IhNYn4N6VLUibLVxow0RLvZniIjZUK3PyqLQ/PaGUSfAD6hW5SfVC5rgd8XovzVYOBS1eKWNehN8L39CXUzNTy0AxIP1PLEZmK3OsKYLleOFDSammN94cAgsi+GoNzwM54iR8Frv/GPwhHTIxrO3ek2KINPkDCumfMSK9GmpeaGaQqp42Fky/ourIthRvmgx7fFGHFHEf2oPTCocUPbaVfHYbLwetUWIC7riJ4fHO9PdJe6zVLDXa9Q0Vpyal9UpvPhKZWORzYtupFo7vsby5fl1XWk60jrFguo3s+XyfSnp/3HBn5zqQnVgyBJV/DXmRTXAb7+vFad9Mlp7c76ZHKW4ma3KtPWUKSh9lS5dO0Sblo7bW3pvF0mRA4bWOLKBombELg5YMMvk6sRK56Ho0lI7hQ1SBcKAe0x91Tm1wRBh4nP/EQI4CjzFPwHrHdMYgnr3R5KdHkeQZwg//IatKmDUOim/K4YPAIUBsyBklfZUUonNsmWA927vcjfGX3RgWHitCWdw0uA2H0MbxN3JAQZcuofUHKIy6BwbmfjY+0/N7sCVfofnO0Qlciz2AtD4Jd2dPzrfZXaLfhVWZg3IYzP6BAkzBBhbpgBgEq7e1YYYWSGoYJglVcxevbgsKrg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199015)(316002)(38070700005)(38100700002)(2906002)(8936002)(5660300002)(33656002)(41300700001)(52536014)(4744005)(64756008)(66946007)(76116006)(7696005)(122000001)(66446008)(6916009)(86362001)(55016003)(66476007)(71200400001)(478600001)(8676002)(6506007)(66556008)(186003)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?bbrrlIy2zScaOgPApn8noDS05wHL5bpJ5cXOzn6S+nCz1qG0D3qlPhhqUWM7?=
 =?us-ascii?Q?WZxdJ9f9Ft/UjuARnx3CKUhNPtzcioM0qmKQNHeSrMB+T4CpQOkn3tHKuuj6?=
 =?us-ascii?Q?uDrZ5rZLQjuYIU691ScJWCTAEgHoWqyk+x0QOGIz2SutMzxz3GpgwPgIX9Hr?=
 =?us-ascii?Q?HGBGfSiDa0zsmaW0t4gU4dg7+MaNxQ0so2qIdUQGRNdRPqMkxB/jost1aUjq?=
 =?us-ascii?Q?5K5kQu2d8L2NCZGPim0VMGMCmo7K09Sk+FhI7umr6zE5CGLvOJA0e7/xK4nI?=
 =?us-ascii?Q?CbngFZkVLxaxX9/ApKm84LGJLLNCxbbMjwjQPoby3HiYLVckeT3E6rHsGxXx?=
 =?us-ascii?Q?0c2kyFcIIP6d1uQbP1l0zTJS7QqVGIyRO1xMVjKF1NXPJM5vqJ9S0QxSGvc/?=
 =?us-ascii?Q?XJIDna+k9knkylJ4G4wkV9DycSyyjqiYLQI1Zp2SnCAZ7KTvSItQzaW1FCmt?=
 =?us-ascii?Q?1Jw4ZcXDLi+DL46cvkhETTGI/qrYruA6S7rGGryKFXRyFEgvRzu9R4jcOR+K?=
 =?us-ascii?Q?9xNn2+97LfdmX1pZNrFeZ0svl/V1O2IxhlhZ0Su0GH0JtQRsZQXRDSHfnEwK?=
 =?us-ascii?Q?3XCJd4oI1hBgWi/Dw1LlejuaIDQPLOgbeVLruDEz9WUR5GoTTxA5euOmgX08?=
 =?us-ascii?Q?AliOt6iVbovi8cI22vpZcshVnwvWSQYqFhsP7lKjdlRN9+8CL69IhokNcjzB?=
 =?us-ascii?Q?daQXFQPGnkZ2UlBirxKWqZ6YVp6Idnn3Hg7cftlcG7wTFUwHwrClW0AiZE/x?=
 =?us-ascii?Q?kSct/QuL8Pu3m81XwjmYo72qivzJSG7wheBBCh4B7ye90C+DKky+UiTRGyoJ?=
 =?us-ascii?Q?OKdAYKZWmp+qNIt0FegmjA9XE8UJFxyRadrxwAqPgrZZ/VC1DJ4L5jVac6LA?=
 =?us-ascii?Q?SLKZbhoQ85ybTEqtM4sKYkJx25VRw7RjLeM93CRTdNZMTVM6Y+y9JAcTNJdB?=
 =?us-ascii?Q?uNGO26asvysdEvIaprtEJ6c81eiczEmgey9ULKECmnN3Z80PPga8toTVEy7K?=
 =?us-ascii?Q?7W/1FldCY2xmDHktbjis5cTZ69w6tVCvtz2vMzbtu8xe4f6zRIsu03Jniw5e?=
 =?us-ascii?Q?NimGOIcJNFLP7OxV8ec/QvCJqhDx/p3rAjSKHuVzlIWF4OgeajHOGHUiRTtN?=
 =?us-ascii?Q?WjUPoK2bVcsp4nSQ50+Ir94wOtwMoS5v+kg6Goz8CtJ1wMK3+xxzA7T22o4j?=
 =?us-ascii?Q?EKRFt++3lIE/0nDAI5y81GKuGLngQzfQRU8egJFIUtxdRZOyyrO+Z6MuPA7q?=
 =?us-ascii?Q?6Mb2sxomyFywQk8rDtGSU16xi7yo7GmCq6seBPFYlfbpUHrAvExrw2o/mGpI?=
 =?us-ascii?Q?2kqwvJ6eVMitnl40ez8bkDw0Bm8mQxi0vir/zQsOvHZvkrv9tiOvcJF5Kp6t?=
 =?us-ascii?Q?0R5VBIDWL3ntTf4PEpZajEm2KDigPDWZ6/4wb6yapSD25g2iRsb+1wZk3rG6?=
 =?us-ascii?Q?kCDJmqjG7vGighXpDLSOdjcyQ7rEqKv7M65f9otMnpZ74R1cP9om2XFR0vxl?=
 =?us-ascii?Q?Ols5xSaJ0lUONzy++5AlqBmk60GYHWrmDUvQsZdxCv9+vHRbFBWRQ9gMslVc?=
 =?us-ascii?Q?XXg+R/gSI713aPdX2bPiALYtJ+HZOrlFQTrxDeZl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: 3dsystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b895b036-f2d3-4369-3837-08dadcb174e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:26:35.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 150688f4-8db2-44d3-b980-cd00ab6848fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M711J86liHLhF9Zl/U/RSD8jb8SdfH5VJ2rZ9gUUUMCR/3qdaUvfn46jmTDV++PmVVDmYsH0Oi2nkG8G/gHefLN0a7DpHUR/zqfXYXCYiA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
X-Proofpoint-GUID: EQCCX-hbrxByPvzsVTFoo_1BPlbWa0B0
X-Proofpoint-ORIG-GUID: EQCCX-hbrxByPvzsVTFoo_1BPlbWa0B0

The linux-dovetail git repository has tags such as v5.15.77-dovetail3, v5.1=
0.153-dovetail2, etc.

I'm building a kernel to use with our Xenomai 3.2.2 (Cobalt) drivers and us=
erspace libraries (Ubuntu 20.04). Is there a preference for dovetail 1, 2, =
or 3? Or should I simple get the most recent tag - in this case, the v5.15.=
77-dovetail3? Also, is there any reason I might prefer a rebase tag over an=
y other?

I searched through the documentation on line, and through the email history=
, but I don't see anything explaining the various tag and branch names.

Thanks!
Kendall Auel
3D Systems, Inc.


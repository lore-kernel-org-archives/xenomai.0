Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD32C9D
	for <xenomai@lists.linux.dev>; Fri, 16 Sep 2022 13:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5dEb5n8RuK+/uDon7/JD/84JuctL39bi6JLc0wicoxozlcsc/tRKxN9uScxSVY8VlhS8T7x/KaaYeek4nXQ0gwD5/m+SnQqJ8q1NTB4Xnsm+x/SZn0O/2YULgZMeshEte21pH9nFJS79nS1rJGcpGejkA9Iy0G5mjAlswzXlJhHgu9xKkH8Zloqd7vnb2cmBBncX35ije3z61uL5/UvwMGnnzXxUU3M8HZVlP7fYrEZ0FQf7bjzZj37ikl7cZI6tqxszeX9mGtsGpz9CADSPJOSMohXQkhnQs12TxVN7KAoAZp7uxJHQumBosZDB2rAJ3UhKlMI5gv5ZOP6B/7zYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aofaf0mjIzbZnC6+4jTgfYiFUDHTTNSlpzFISGGf0/Y=;
 b=UZXiXVi9CoVExpzuhE1xs/YYsEEUYEW2PLeqJxhJiY87r51yRdBdj9sU2SkJ41We+sak8BCmnsnrJGvTChS1kf+MH0Pamg77o+I/qLxADI9crLHZ4ucMBfw02FNRziJ90bojAfThPP03ICNiTsJdGBW1DH80/HXvcprCh08q8UNCN/C+yWFhT8MurSd2p7TXytSU9UFw/dSh8fYtzo4Wh4eBZbTA8jCgT65vSaRrQGO3VRm4l/CLxVjad55nZZ6RFDUSf3CuvTHKFoBLNZvA+51BhBKQOwwfVPnDyXZzc0dEGLKq6FzAXVQEu2E74d+zWWF2S2MgKfyUtJL8dzna8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aofaf0mjIzbZnC6+4jTgfYiFUDHTTNSlpzFISGGf0/Y=;
 b=LsMxU4lLBZZv7KraHwXKBGbQXG1cHJ3l8ZMesfRMonnH5UnRmXom2Dgvz611tGL8nsolSgXC1XdNkQi2kl7UhfZaRZF0Gc9GbDV6U6kqY2ZjKng667V1Ergy3C3Am4+tRhFlxYshWkZK75S52MVwaaYjT5K0eoiUV7NaEjec5y2EhpW7NwucUDUYMj36FCKchR7yCwjK7PS66ip6JkbSiWbxJdBd+zh9+EbLDAuk54xMtxJoFLp6rriCiaWpGwB1v6c6syNLVDBvzyjomi7mRktYZV0ojIAvcls0r1apuq6eSPaxUuQC0vMzjvt39+RaPfO1MTAwstIqKEpLw1+b7g==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS8PR10MB6890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Fri, 16 Sep
 2022 13:25:48 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ddac:c6b3:6dfb:77e]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ddac:c6b3:6dfb:77e%6]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 13:25:48 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [xenomai-images][PATCH] ci: Update AWS Deployment settings to use
 Cloudfront URL
Thread-Topic: [xenomai-images][PATCH] ci: Update AWS Deployment settings to
 use Cloudfront URL
Thread-Index: AQHYyc80TurCBXDyg0WtAEK+pO+psq3iDAqA
Date: Fri, 16 Sep 2022 13:25:48 +0000
Message-ID: <20dc6cd3e7bbcdea499b9590c25af2fa8cf0ecc8.camel@siemens.com>
References: <20220916132115.32643-1-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20220916132115.32643-1-Quirin.Gylstorff@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|AS8PR10MB6890:EE_
x-ms-office365-filtering-correlation-id: 817ea365-db7b-4dce-e534-08da97e6f7ff
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +njViU8X8skjdd0kO+Xm04+2t47R11yBclrD5EV1HFYUfdE9xblQ84/mFPvjipFVhR4vchJi/zfmBcFOu4pCFx4N8b6EnrDDKbhtJF+w5ojEqPKcssmvsC433ejVO7zfzAwCrWJrkY6p1Cei4rDGRPbJkwl3cEIEgejAINADEinGonxjOM+5zWqMyo65tGEqHdXKldbQEK3Uuoizavv7KeB5boUkdkcmcMdSem2mgs9ZLS5tLMWSICW8/H7moqXBu7fIR5kWeUYyfhLu9GECt2RN8hfgoDQj9aVOqrbSWNm0hiFAWiVk29tyKzFjpJ3uXlrqc6AeeJSnkVnrkdkNhso53Bt5tQO9kmsZp3MrOV/VjePrvPNN8pK+ZeEFTk9ZpoupabWN//YfBUkViUWL3HdgzoNCZkzkalr9qAfsnNQr3Vr3yZLgScY2EMByDjjICr8+9Ujves7tmi/81EMLtK0yjhM8I89DA6+a88f15qjygY5h8jgsQdIr32JFPIvHLQjSTHAmlJExfYAP/SChIEuW4QAjVBzot28DjbexbaTaCtRKDKZtiiexfOH1ocQE9c02HiI1/v7wYk+QMfGVcKbm2xmpruLLoUIL71S5LQT8Z5rm/MhMRRhKw6fo4A+9GOOse6rR2GX3Vw8cLvZJgSPMi3clkwguiXzbkgY5FVCH3SwnZ6RFs5MbqGxgTGMa88tvySasGqt11hqiGDeG3OxKdzuRM507VImd1pYrU5VjRcB1Snz3fZKRrWukNzHGNOlD+AG3PlU5eyN8iie4tA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(6486002)(5660300002)(478600001)(186003)(86362001)(36756003)(6512007)(6506007)(71200400001)(2616005)(76116006)(64756008)(66946007)(66446008)(66476007)(558084003)(66556008)(8676002)(316002)(91956017)(41300700001)(38070700005)(110136005)(8936002)(82960400001)(2906002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzF6MHRkcHMvaGsrYkQ4dHNxRVMvdkcyMElxWDI0ajE1M2dkSXFhVnFZVlUx?=
 =?utf-8?B?bktCV3pIU25qU1FlZGgvL0JpT1hveFZhQVFaQ2VEOTRzd0FKaFBVR2h2NHlI?=
 =?utf-8?B?cklKU0w2TENjeHdhaDJJMFI4ZDJ4QUxmMHk2WXVIUDBRQmxXbi9oWnE3V0p6?=
 =?utf-8?B?R1NXZnhZTndldkg0d3FVdG9PUytvSTczQXNXNXZ5Tngxazc3Wk9JNXkyRnJG?=
 =?utf-8?B?dTd2TitEM3dCRkwzVERXQzFRM0FiMy9JTWNFcXRNdXhZUGJQS1MvaU1LeFNH?=
 =?utf-8?B?OUZHY1JWMkkxMFUvT3NRWGQ1RDFXNGFmcnVXTm9NWWVTSS9zU1BOeHNzVUM0?=
 =?utf-8?B?bHlkci8vWHBwUkVsRzZPQ3VQZWtmV2xIZHp6bSsxNXJES05hTC9oMklDeVJO?=
 =?utf-8?B?QkxSL1p0ZHhpazFldWhKdUZyT0tRRGxvVnpNK1JKdWNiU0lFWnJZYnR6OE03?=
 =?utf-8?B?cStMZzErMDBYaktHS1IwV0dwOWJJa0NicEwvQmNOekVEZlh6RHhnVm5HUFlF?=
 =?utf-8?B?Z2RpNnZtSnE5c2xNd201YnRKbzBka2k2MFpPQXQ5VnpHZm5YL3dydWtpYXli?=
 =?utf-8?B?YW1zY0lpSkxaL2RKby9waFgxb0lZQ1A5VUxtaGd2WWt0R0R0ZTNRQXhoMGw4?=
 =?utf-8?B?OUZSaEc4UVNHWWVlRENPU09kc3RCNjhTbC9SRUZhSnZxLzMvLzhVOVpFOVJ1?=
 =?utf-8?B?a0pIdVBmTFVWOTZHaGVsREI3SmY2Wk5DbjlRN3ZRYzF6V0VMcHZyYmVwV3Z6?=
 =?utf-8?B?SVNHa3pXbzhJMDIwSE50OXFjOVpPRjVOSDFlU2xtbktkcVkxVmd4UnhtNCtO?=
 =?utf-8?B?Zm9uT3JEeHNROXBrM3dpNE5YTjdGZWpjbEVvdkRCQ1dxRVd6YTZDQVp3KzZa?=
 =?utf-8?B?NFpwRElTNnA3MkVQZjFoQjM3SnFLUTBhbDdxZmtGRjNSa3RFOTI4T1JZZENp?=
 =?utf-8?B?SHU4SDdZL0E0ZTFYTDV0d09sci9NNEFmOVlRRHdhUjBaQzhDYktkekJPUWls?=
 =?utf-8?B?TllTUW1xZ2cyOGwxaWcrZVU1d0s3eEhSZzV6cWhtWWhSaHZpOEhtc1pZd3g3?=
 =?utf-8?B?elV2b2c1QUg5TGs3NzBHTVlSVmtQdzV1djFvSUlWc2p0WHZLQVZUUzljdGNh?=
 =?utf-8?B?anRKNmJyL3hzNXpWcjYyOUp4QWp3cWtlZ0pCNG0rUTY3ck5GVWRpYnM0WjUx?=
 =?utf-8?B?ckpMK0VNZVk0Z3hpUWFTTFErbTc1KzB0MTRwY2lxblM5aE1Rb2wwWGtJbHFM?=
 =?utf-8?B?enpoNHkxcXdzTi9TRUxmU2RxMGs0K2NrSnBxdmtjdlVvL21UM05RblprbkxG?=
 =?utf-8?B?bnJla2FlQzhBM0VaZkIxY3JsTmNwUkE1U2ZBeHFZSTlTSEJSdEhTbngyc1BT?=
 =?utf-8?B?QVdPR3g4cDRydFhaSGloaEozdUk3MnhEbDd6OW41V2lWUFExZ05iVHgyMStX?=
 =?utf-8?B?ZDZ3bzVucDhkRGxCTGFQTkI1MklXdXFNbElsOU9zSjRGeDQrQmU1WDVSRE0y?=
 =?utf-8?B?QjVyMW56SzRpVXUyTlBFRmJLU1BnQzU4aDhVMzZOYzl5WnhaUFh2VDBmSlBj?=
 =?utf-8?B?Y0VBTGNOM1FEbFpxVEdrS1hNRCtBT21ldkx3ZTl0UW1pQnFVVlN1YTVnNWhR?=
 =?utf-8?B?NGsyU01VRm1QNHk5bGxkMnJVS2xJNHlydHI1dUtVTVlTWGtkSXZ0TVQyUi9G?=
 =?utf-8?B?M05CR1pCdW0vd1FWaGVvcXExN2RtRzExeVlFdHUrbUw3K1pOZVdVVUZzU29i?=
 =?utf-8?B?SzZDV2JyYU1sN3F4VTY3azV2ZGFiRzZYV1VFMHJYbkxSMHRSRnNoQlRHaWdS?=
 =?utf-8?B?ODBLS1pxTXF4WXhyNmZ2QUUvTmRBcG93eE1JM082a3BaTmJBL0dvc3VLS0hW?=
 =?utf-8?B?WlJNZm1aTGFQZFBiVnFMTzhJdSsrSWdXTFArRnZNSG96Y0hhMTZyTEFsWHU1?=
 =?utf-8?B?bjQra2E5TFVoVHBvNWVRUEYyVkNHVzJHWk4rd01VMktmSTYxakJIcnRzKzRo?=
 =?utf-8?B?d0Y4UUJBM0tLYVBTdEZDalRmOHVvK3Z6blNsRFM1cWRLdUdZTUc2N2o2Q3g2?=
 =?utf-8?B?S1Y1elQrOGtaa2hySzcwTXU2TFVwYUIrTDNiUjdzVGJ4SlRhQXJBRWM2MVZs?=
 =?utf-8?B?QkV5WG90TjhJOWYzT1F0alVMaitXUGoraEt1aTJCKzl0ZFllWkVKTHl0ZGhK?=
 =?utf-8?B?a3FsQVhZdGlHMS9NbVZIb1lXbzNSMno0WVk0YXFZaUtNS1cwUmR2dVpkcCt6?=
 =?utf-8?B?d2ZoSGYzVWxXcmpIS1dad2lud3N3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D26637BDA54DD848B097A25DAE546230@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 817ea365-db7b-4dce-e534-08da97e6f7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2022 13:25:48.5205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eaB2sjKhUyLVyBA6PRXNW74qJyJFeZkKwxqUiNmVCOrroWRNl21tgXmqdXc6LO2dqV799sakElgNBLuWJxodvRL9HA4AAXjFwzbAux4VICE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6890

T24gRnJpLCAyMDIyLTA5LTE2IGF0IDE1OjIxICswMjAwLCBRdWlyaW4gR3lsc3RvcmZmIHdyb3Rl
Og0KPiBGcm9tOiBRdWlyaW4gR3lsc3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29t
Pg0KPiANCj4gUmVtb3ZlIHRoZSBhY2wgc2V0dGluZ3MgYXMgdGhlIGFyZSBubyBsb25nZXIgdmFs
aWQuDQoNCkhtLi4uIEkgaGF2ZSBubyBiZXR0ZXIgaWRlYSBzbyBmYXIsIGJ1dCB0aGF0IG1lYW5z
IHRoYXQgd2UgY2FuIG5vDQpsb25nZXIgcmUtcnVuIG9sZCBwaXBlbGluZXMsIHJpZ2h0Pw0KDQpS
ZWdhcmRzLA0KRmxvcmlhbg0KDQoNCjxzbmlwPg0K

Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D51110
	for <xenomai@lists.linux.dev>; Wed, 24 Aug 2022 09:14:31 +0000 (UTC)
Received: from spool.mail.gandi.net (spool1.mail.gandi.net [217.70.178.210])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 117FD200009
	for <xenomai@lists.linux.dev>; Wed, 24 Aug 2022 09:14:23 +0000 (UTC)
X-Envelope-To: xenomai@xenomai.org
Received: from KOR01-SL2-obe.outbound.protection.outlook.com (mail-sl2kor01on2072.outbound.protection.outlook.com [40.107.129.72])
	by spool.mail.gandi.net (Postfix) with ESMTPS id CCD2E94117B
	for <xenomai@xenomai.org>; Wed, 24 Aug 2022 09:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd8JH0Vji+CrrIcLutqs18XlBJ1WHJuwJUEXiRwBIZS3HM1QPqY4KrdShpb+dgDYMRy4+KVgA5/IryhOAkghS0KrNfmHJKyQoM1cmf/wlYMeNKwyhkdxWrpuERKMoDTu+dHMql2bAnoW9KAmiGQ/mr3MxSxes/AX5H7iaFDpAxUSHXBrJOH5VqVT+Nbq846I1CxTjjSYWMiJ9uaOrwvqzNl3iKwXYnC5tuPWEcwOkhfUUfWtye5ei49Q710nXPgBxkbbOd9K2HYo9dojiY5y2OGYhsc/tnHTzYRIRK/RFb2DPQMzVC6WBJRH2Or28bG18laE+VrvY+Gnm4fR8O0puQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3BQozjX0Lzde7+TuyDa4hvGERco3qzp1srvpi+sr9U=;
 b=bdxU/nzwP7epkmd5zNQhDu0aAUdneoNLR8grPnTPLQFA+F5xc6ZHYNaEIKJ0v6PGOsc0eFeJRd0EQF3e6ePlVMuGtvn8rthbT/ussJFj0V05EacO7tB5mn/3Dc1+CTKBCC+VGEeivAw13JVpWxKWA7GujE01xj+Ibo/zLDkpxhyiF4DWOv42qpJAC/HPNPA75er+Ow1VKyWD/DWz6invf/HO6J+iSqBGQNfGDJmX7T3TW+JAR4Qdw8fRl1mh2HHoxFkFs0hZW9+7uugfyW6P77mZ8aUafo/4asWPjzqQRj8+mxF/nDbIKMLofJaIwZdcPIIoFg8ikGRoWUAJqQOoew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Doosan.onmicrosoft.com; s=selector1-Doosan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3BQozjX0Lzde7+TuyDa4hvGERco3qzp1srvpi+sr9U=;
 b=tbSpfCadTI24eDsNRIsvaSJL7zFG4mVzeDW2BtqtTdQXcqCaMjRpVW4/XbXihKa69azWenaBHPqSMIMqiisTrt2YXXEfNzDmeUdwY6Nsl8EGejS8vl8/igwptW8JPedsKQUUHodEmw6ssEmYOVmLVEziQMwa57r3lkDMx73+PdE=
Received: from SE2P216MB1394.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2c::13)
 by PS2P216MB1140.KORP216.PROD.OUTLOOK.COM (2603:1096:301:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 09:14:18 +0000
Received: from SE2P216MB1394.KORP216.PROD.OUTLOOK.COM
 ([fe80::2945:32b7:6b5e:7f0d]) by SE2P216MB1394.KORP216.PROD.OUTLOOK.COM
 ([fe80::2945:32b7:6b5e:7f0d%4]) with mapi id 15.20.5546.024; Wed, 24 Aug 2022
 09:14:18 +0000
From: =?utf-8?B?6rmA7IS47ZiEKFNlaHl1biBLaW0pIOyXsOq1rOybkCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <sehyun2.kim@doosan.com>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
CC: =?utf-8?B?6rmA64+Z7KO8KERvbmdqb28gS2ltKSDssYXsnoTsl7Dqtazsm5Ag65GQ7IKw?=
 =?utf-8?B?66Gc67O07Yux7Iqk?= <dongjoo5.kim@doosan.com>
Subject: RE: What causes the latency of the rt_task_yield() API?
Thread-Topic: What causes the latency of the rt_task_yield() API?
Thread-Index: Adi2hA+8NshNMGH/S1C5hT38XRCzfAABQnKAAEPabkA=
Date: Wed, 24 Aug 2022 09:14:17 +0000
Message-ID:
 <SE2P216MB1394C7C6A067126F36022F23C2739@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
References:
 <SE2P216MB1394874A00E10A497FE73DE0C2709@SE2P216MB1394.KORP216.PROD.OUTLOOK.COM>
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
In-Reply-To:
 <MN2PR11MB428519AFC0F522BB25FDA093F2709@MN2PR11MB4285.namprd11.prod.outlook.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18dd6228-ea3d-467c-0954-08da85b105e1
x-ms-traffictypediagnostic: PS2P216MB1140:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kZohEPf6gQ1t7nH9EuhwfrVNGgB10xk4eBE4kBrWnAJ3RKONntYrQNRsyGH+5qogaSigxwgOCbGIEMIoVhaR0t2JDFtjrcuocllx6tb7uphiMjd0xf4zIVnPk5iZ5OxVM/QNjl+xEgPu/CwwrLHNTSu9MKNOI6FFdpstM06o5tT3IeMEOVqMQllnBjvUyzvuc4gnx/IxRfAyaej8GhpcaRZatRqMOsM1dALnodMe+SXeX6V/VR3l2A+qmiCWoiDhM0B+j566HOf1AGMwbUtxizBJKT1tmXj5/2B0QL49omVEZFyAptNQQDqdID/hW/BcWv2izMlhbMnAox3optjLJqTTlx8hE/KJbiU7G4JXBj1VR4sBe4VmI7aKYDlvcG6C9gyJwjz3zvk24ju+40BhTI5iJFNyoXx0fnvnrWZXoY+9rl2ZPauJRtQO+81rHpMq2cjPNgnkpqeEQns2i9JluEtGs635+Mv2TSucJIK/Gbe0qAZxvQZ8bKYmHcJGmNuDaTAwfpmR35O+zInRf01KlbbtLZRgSHQOorP9IW0TLKeTCKchPPKYtnLHPHpoThz2Mhce6UcRJ1XHKKuG/J/5l9uBFYEFVt1DA7hg+24WmN7+sWtWyfmPNJ4k/FKhSobAGPBxU0L1sTzkgCN+JKg68AtbEM2/8zA0qTSDj6DsAR2YA8ShG+4litrqQh26sV1NGmt/nAN0g9B9a95Q2VIsXgZhSQIqsOCQnmdmAjxauTTpvrWpbNKNg8AamYvMZV/0pgX9nrz9tWkeB74I11NyboAFumK+RNSzWeUZoxZ9X0g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB1394.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(83380400001)(71200400001)(478600001)(316002)(966005)(9686003)(26005)(110136005)(33656002)(55016003)(186003)(38070700005)(38100700002)(122000001)(66446008)(64756008)(66946007)(66556008)(8676002)(66476007)(76116006)(4326008)(53546011)(107886003)(41300700001)(2906002)(6506007)(7696005)(86362001)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Uy9BM0lVbXBXSnB4bWUwa0pQdWdRVjVkZW8vU2JCaVY3RStHQkdtKzBBUHRj?=
 =?utf-8?B?SU9oL0svUXk1ekFTQTJhcFU2NW5TM3pjYndlaUlCeUVQU29IMlV0elpvb0tQ?=
 =?utf-8?B?NWt5c05nY2VBdHdZNG9TMzgxTlZEMVlhbk1Na01PVEhVallwNjA4dXQ3VTlw?=
 =?utf-8?B?VTRGYWt3OW84S2plM3djZWw1Mit4WFY3alhGOXFTR0pZVUxDQ094RWVDano1?=
 =?utf-8?B?N09wY1RoeTdpN3JZYnM4dS92Q2hDM2NwSlh2ZTV5K2ZrdVJ3OXo0TDhUcGlV?=
 =?utf-8?B?aGVhWEkvQ1l3ejdFR1ZvUWVveldja3duOFhNOGV0NXdsTitDb1EreDc5bmVj?=
 =?utf-8?B?Y29DeHFiSXdVc2k5NC9pV2s5eHoveEduN2Y2VGNjS0J3ZVYxOU0xbmpJVkpY?=
 =?utf-8?B?Ym4yZFdyR282ZG9taGlCT1RPS1JjR1RyelJWa2g3cGk0TU5vWWdSNGJJRXpK?=
 =?utf-8?B?QjcrRklib2FMSTJKbm1NVUxpcmxBKzBiL29hbnhTZlRyckR5OWJaU0FNLzlJ?=
 =?utf-8?B?RytnTHJySmdRTTlsdm14Zms4QWpqSXhiek80a24xelFEa0ZjWVdsTXJ2aFE2?=
 =?utf-8?B?RlJSOVhLby9SV0VDbFo5L05ZSEhKRGQ0NkUzR213bFZkSXVyR2xtYWw4WW9B?=
 =?utf-8?B?c2dhT3BzR3FOWS9JNmRjRUxQeE5RREx3UEVNbFY2TGVSSjk0RWNrcUFnWEQy?=
 =?utf-8?B?UkdsQ2RpeTNvYTVxbG9HVjhzZkZlUjM1SzJQcFdYZlc2SVdDSUt6OGpoU245?=
 =?utf-8?B?b3dXSGg2WGRHT2N1SlRaSU50cmcxMmxSWFRhVXdkd3dmQklFcGhwR1gyd1Jl?=
 =?utf-8?B?aytUUWh1RnRtdklzV1VlVXFSRjdwaDBoTTIwbVhQZUZlY3haT3hIcTZ3Um55?=
 =?utf-8?B?TEtISFhkT3ZhRTdmYnpVUWMwTmZiaHFiUEdPVmREZTNyYTM2bkUzbXFKQXJi?=
 =?utf-8?B?aEZIdVVTUVYySUo3WTc5UW9WdjNhMVZ0SjZjUGlNYkRlbUF3eE56ak1Udk9p?=
 =?utf-8?B?eTZqSWlDY1FXSmlYRGtsZDAyLy9MWldyNkhML1B0MVkzaDVxYzYrZXdjTk9R?=
 =?utf-8?B?SG1Xdnl5NTNlL3FJZ2xJV25VTElYbjZzeUxrY1ZyT1hmL2xPTTZQSys0cm93?=
 =?utf-8?B?SCtYc2VkVnNFYWxzQWJCcm9GY1hsQ2x0MEkxOWI5YU13c2gxUXN0d2NrOGt3?=
 =?utf-8?B?QXNwaTBIQnNGaEFPRzJFMWwzb2Z3OTNtWnpYdmFJdkExQWtmYzI2WHJMVnhP?=
 =?utf-8?B?SUR2YjZudFhya3VDZ2QrTEI4YXJYTmRYOC84MjJGaDFGTG9lZDhjWjVCZ2xE?=
 =?utf-8?B?ckZSVTVVVFlVWEpySHAwOXcvOFpqek9ETTduTHM5cHptYnF2Zi95OG5Lbm1D?=
 =?utf-8?B?Rk4xV1VScXFQZmZTOHJZakFPVmRxZGhKY2p3b0lQYWtmZUFya0h1SmZJdlZ3?=
 =?utf-8?B?dmFzMk5tb1FNejRpdXEySDB2TDNMOE5qcVVndmdIWHZ1bFExdTc3dllhdVd0?=
 =?utf-8?B?TXVnUHpaUStJdFZlZVJHaTJFdmtwOWptMUVpWHViRnV0UFhIMVEvdEZsMVFz?=
 =?utf-8?B?d3hNREpjMUFWa2kyMlc3WUhyc29VTGZlQ3c5cTBZLzlFNkZwL0gxckN1eS9T?=
 =?utf-8?B?YmZvSTRCTm84YnJpcndRZkpzb01Md1ZKeW9TaWx3K2Vmc2VXNm1RQWp1QkRQ?=
 =?utf-8?B?b3k5cGRxcURiakgwbDBGRkZjNU5qM1BUNHJpVUdNbm80L1ByUHBnOS9MVDhs?=
 =?utf-8?B?VndaK3lyU3c0K0t3YkQ1MnZ0dXExclQrckFOcnp5RFZVcktlaCtYV0ViMlpX?=
 =?utf-8?B?aGdpTi9OWEhDL2lST3Iyc2cwSU4yS0ZlMmJMSjhpeERqMnFJNTByeEMxNmJq?=
 =?utf-8?B?a1gzMkM2bkFTVnBIYjFCeTJrL2ducUFvYVFoejJLb3RCUEE1eGVNWjJHNm5L?=
 =?utf-8?B?aGFKd1U0SklhQkZZY3ZyS1pwQTVTSjVmbnd4K3Y2bzZxNGRyNldnOU5EYUY1?=
 =?utf-8?B?RWZsV041dEZrNVIweVBxWkh4Ti8rSDJXd2QrV3NabmdCdTNiM1pzWk5nM3dI?=
 =?utf-8?B?blNJNThkdUhwTklVM05uSGNwdGdJSVc0d3AzLzlPQUJ5STlDV3lhM0lSaTNK?=
 =?utf-8?Q?7vEjXZvUUn8haKU8jX5+7F/hx?=
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
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB1394.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dd6228-ea3d-467c-0954-08da85b105e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 09:14:17.5061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CTRGFMQzaoJ2586n8FOE7A/bQKVCg8y9GekTjxA7AAAOq/172dsEn2mE9XcCqPIdjepyScvLvXmDE6tbOSJrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2P216MB1140
Received-SPF: pass (spool1: domain of doosan.com designates 40.107.129.72 as permitted sender) client-ip=40.107.129.72; envelope-from=sehyun2.kim@doosan.com; helo=KOR01-SL2-obe.outbound.protection.outlook.com;
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=Doosan.onmicrosoft.com header.s=selector1-Doosan-onmicrosoft-com header.b=tbSpfCad;
	spf=pass (spool.mail.gandi.net: domain of sehyun2.kim@doosan.com designates 40.107.129.72 as permitted sender) smtp.mailfrom=sehyun2.kim@doosan.com;
	dmarc=none

DQpJZiBydF90YXNrX3lpZWxkKCkgd29ya3Mgbm9ybWFsbHksIHdoYXQgaXMgdGhlIGRlbGF5IHRp
bWU/DQoNCg0KDQoNCg0KRnJvbTogQ2hlbiwgSG9uZ3poYW4gPGhvbmd6aGFuLmNoZW5AaW50ZWwu
Y29tPg0KU2VudDogVHVlc2RheSwgQXVndXN0IDIzLCAyMDIyIDk6NTEgQU0NClRvOiDquYDshLjt
mIQoU2VoeXVuIEtpbSkg7Jew6rWs7JuQIOuRkOyCsOuhnOuztO2LseyKpCA8c2VoeXVuMi5raW1A
ZG9vc2FuLmNvbT47IHhlbm9tYWlAeGVub21haS5vcmcNCkNjOiDquYDrj5nso7woRG9uZ2pvbyBL
aW0pIOyxheyehOyXsOq1rOybkCDrkZDsgrDroZzrs7Tti7HsiqQgPGRvbmdqb281LmtpbUBkb29z
YW4uY29tPg0KU3ViamVjdDogUkU6IFdoYXQgY2F1c2VzIHRoZSBsYXRlbmN5IG9mIHRoZSBydF90
YXNrX3lpZWxkKCkgQVBJPw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiA/
Pz8oU2VoeXVuIEtpbSkgPz8/ID8/Pz8/PyBtYWlsdG86c2VoeXVuMi5raW1AZG9vc2FuLmNvbQ0K
PlNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAyMywgMjAyMiA4OjExIEFNDQo+VG86IG1haWx0bzp4ZW5v
bWFpQHhlbm9tYWkub3JnDQo+Q2M6ID8/PyhEb25nam9vIEtpbSkgPz8/Pz8gPz8/Pz8/IG1haWx0
bzpkb25nam9vNS5raW1AZG9vc2FuLmNvbQ0KPlN1YmplY3Q6IFdoYXQgY2F1c2VzIHRoZSBsYXRl
bmN5IG9mIHRoZSBydF90YXNrX3lpZWxkKCkgQVBJPw0KPg0KPg0KPkN1cnJlbnRseSwgSSBhbSB1
c2luZyB4ZW5vbWFpIDIuNi41IHZlcnNpb24gYW5kIGFtIHdvcmtpbmcgb24gY2hhbmdpbmcgaXQg
dG8gMy4wLjggdmVyc2lvbi4NCj4NCj5XaGVuIHVzaW5nIHZlcnNpb24gMy4wLjgsIHRoZXJlIGlz
IGEgZGVsYXkgb2YgYWJvdXQgNG1zIHdoZW4gdXNpbmcgcnRfdGFza195aWVsZCgpDQo+DQo+QWZ0
ZXIgY3JlYXRpbmcgYW5kIHN0YXJ0aW5nIG11bHRpcGxlIHRhc2tzLCBydF90YXNrX3lpZWxkKCkg
aXMgc3RpbGwgcnVubmluZyBvbiBhbGwgdGFza3MuDQo+DQo+VGhpcyBpcyBhIHByb2JsZW0gdGhh
dCBkaWQgbm90IG9jY3VyIGluIHRoZSAyLjYuNSB2ZXJzaW9uLg0KPg0KPklzIHRoZXJlIGFueXRo
aW5nIEkgbmVlZCB0byBzZXQgaW4gdmVyc2lvbiAzLjAuOD8NCj5JZiBub3QsIGlzIGl0IGEga2Vy
bmVsIHZlcnNpb24gaXNzdWU/IChUaGUgY3VycmVudCBrZXJuZWwgdmVyc2lvbiBpcyA0LjEuMTgu
KQ0KPklmIG5vdCwgaXMgdGhlcmUgYW4gQVBJIHRoYXQgY2FuIHJlcGxhY2UgcnRfdGFza195aWVs
ZCgpID8NCg0KSSBzdWdnZXN0IHlvdSBtYXkgbWFrZSB1c2Ugb2YgIGZ0cmFjZSAgYW5kIGVuYWJs
ZSBlbm91Z2ggZXZlbnRzIGZvciBleGFtcGxlIHNjaGVkIGV2ZW50cyB0byBjaGVjayB3aGF0IHRo
ZSBkaWZmZXJlbmNlDQpoYXBwZW4gYmV0d2VlbiB0aGVzZSB0d28gY2FzZXMgaW4gY29iYWx0IGNv
cmUgYW5kIGhlbHAgbmFycm93IGRvd24gdGhlIGlzc3VlLiAgSSBkbyBub3Qga25vdyB3aGF0IGNv
ZGUgZGlmZmVyZW5jZSBtYXkgY2F1c2UNCnN1Y2ggaXNzdWUuDQoNClJlZ2FyZHMNCg0KSG9uZ3po
YW4gQ2hlbg0KPg0KPg0KPi0gcHJldmlvdXMgdmVyc2lvbg0KPg0KPlh1YnVudHUgOiBYdWJ1bnR1
LTE3LjEwLjENCj4NCj5MaW51eCBrZXJuZWwgOiBMaW51eC0zLjE0LjQ0DQo+DQo+WGVub21haSA6
IFhlbm9tYWktMi42LjUNCj4NCj5YZW5vbWFpIElwaXBlIDogaXBpcGUtY29yZS0zLjE0LjQ0LXg4
Ni0xMi5wYXRjaA0KPg0KPg0KPg0KPi0gY3VycmVudCB2ZXJzaW9uDQo+DQo+WHVidW50dSA6IFh1
YnVudHUgMTguMDQgTFRTDQo+DQo+TGludXgga2VybmVsIDogTGludXgga2VybmVsIDQuMS4xOA0K
Pg0KPlhlbm9tYWkgOiBYZW5vbWFpLTMuMC44DQo+DQo+WGVub21haSBJcGlwZSA6IGlwaXBlLWNv
cmUtNC4xLjE4LXg4Ni03LnBhdGNoDQo+DQo+DQo+TG9vayBmb3J3YXJkIHRvIGhlYXJpbmcgZnJv
bSB5b3UuDQo+QmVzdCByZWdhcmRzLg0KPg0KPg0KPg0KPg0KPg0KPg0KPlNFIEhZVU4gS0lNDQo+
UmVzZWFyY2hlciwgUiZEIENlbnRlciBDb250cm9sIEZyYW1ld29yayBUZWFtDQo+DQo+RW1haWwg
OiBtYWlsdG86c2VoeXVuMi5raW1AZG9vc2FuLmNvbQ0KPldlYiA6IGh0dHA6Ly9zZWN1cmUtd2Vi
LmNpc2NvLmNvbS8xY0pzbzk4Z3pfaG5HWkdNUEVBUU4wbGlTWm5EVVJOb3B2NFoxRW5DeUF5Wk5N
QUs3MnBHN25fMkVOSUVNQlF0ODZvZ3JqWkQ0V3J2TkRNWXpsb190a2hHLTdTNldyLWFTay03QWRP
TV9UdkM4dEVEd2Z6aHJuZEtfTXkwZDhsenlCekgzVjJPbExFc21HZm9xbDNNZ3QwQlY3TnhaNlZv
ZnlIVlZZazVIOEJoNUh5YXZhRDBuQkFCcTdWU0swYmltbEEyQllucGFMQ2p1SkFCQ3RxX3JnMGRq
d1ZmOG5mT0xQN25pcndEZXZQSE9TU0hqeVAzRU1OcW9YV2dueXV6MGs5YWFNaF95UnFNaHUwRVJU
Z3k4SXBuOVMxdjR3akxtODBFSFY0b1VIaDlFSVFpX0V6NzlmdkFEMUZ1N25kNjIvaHR0cCUzQSUy
RiUyRnd3dy5kb29zYW5yb2JvdGljcy5jb20NCg0KDQpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFj
aG1lbnRzIGhlcmVpbiBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgb3IgcHJpdmlsZWdlZCBpbmZv
cm1hdGlvbiBhbmQgaXMgZm9yIHRoZSBleGNsdXNpdmUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNp
cGllbnQocykgbmFtZWQgYWJvdmUuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocyksIHlvdSBzaG91bGQgbm90IGRpc3NlbWluYXRlLCBkaXN0cmlidXRlLCByZXRhaW4sIGNv
cHkgb3Igb3RoZXJ3aXNlIHVzZSBhbnkgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbi4gSWYg
eW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhl
IHNlbmRlciBpbW1lZGlhdGVseSBieSByZXBseWluZyB0byB0aGlzIG1lc3NhZ2UgYW5kIGRlbGV0
ZSB0aGlzIGUtbWFpbCBhbmQgYXNzb2NpYXRlZCBhdHRhY2htZW50cy4gT3VyIGNvbXBhbnkgZG9l
cyBub3QgZ3VhcmFudGVlIHRoaXMgZS1tYWlsIGlzIHNlY3VyZSBvciBmcmVlIGZyb20gdmlydXNl
cy4NCuydtCDrqZTsi5zsp4Ag67CPIOyyqOu2gOyekOujjOuKlCDrspXrpaDsg4Eg67mE67CA66Gc
IOuztO2YuOuQmOyWtOyVvCDtlaAg64K07Jqp7J2EIO2PrO2VqO2VmOqzoCDsnojqs6Ag7KCV64u5
7ZWcIOyImOyLoOyduOyXkOqyjOunjCDsoITri6ztlaAg66qp7KCB7Jy866GcIOuwnOyGoeuQmOyX
iOycvOuvgOuhnCDsoJXri7ntlZwg7IiY7Iug7J247J20IOyVhOuLiOudvOuptCDrgrTsmqnsnZgg
6rO16rCcLCDrsLDtj6wsIOuztOq0gOydgCDrrLzroaAg7Ja065akIOyaqeuPhOuhnOuPhCDsnbTr
pbwg7J207Jqp7ZWgIOyImCDsl4bsnLzrqbAsIOuzuCDrqZTsnbzsnZgg7J6Y66q765CcIOy3qOq4
ieycvOuhnCDrsJzsg53tlZjripQg7JWI7KCE7ISxIOusuOygnOyXkCDqtIDtlZjsl6wg64u57IKs
64qUIOyVhOustOufsCDssYXsnoTrj4Qg7KeA7KeAIOyVhOuLiO2VqOydhCDslYzroKQg65Oc66a9
64uI64ukLiDsnpjrqrsg7IiY7Iug7ZWY7IugIOqyveyasOyXkOuKlCDsponsi5wg7Iah7Iug7J6Q
7JeQ6rKMIO2ajOyLoO2VmOyXrCDslYzroKTso7zsi6Ag7ZuEIOyCreygnO2VmOyXrCDso7zsi5zq
uLAg67CU656N64uI64ukLiDtmJHsobDsl5Ag6rCQ7IKsIOuTnOumveuLiOuLpC4NCg==

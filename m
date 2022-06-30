Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737DEBB
	for <xenomai@lists.linux.dev>; Thu, 30 Jun 2022 09:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdgMOp3v+msN8GfLXHKsYOZIsWV3Rdna8O7k8LTGBPm56do9qABrTenFMX66DfmQlc0n51FvOZqq4wx6GGIb1d9aucBBInszxbQlO1C8rZ94Wlg6rFQJX3/S97FsGoAhOWjAdx9axbWF2r2gH3JcD/S+X4OQpGGn4YyAerZJWuyol3nHEDAEb0bhVjmpcxdDj2raT0Wiw1w+v9SNExySyJC/+UExlTzgpTatMa+K+fIcMq5ta01jNi1KXDCYuBF5PCpjDcBKlFhRV18tOQYY9C/XjhOls67JFqT5Ob4eq4OTKRhdTwneqP2pl6VDGfbQOOe1o0y5UOoTSlKX6elvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IrcSU/ajgAgSHQR8i9dA3hSrRwoQ3zDw+iZd5Cj9qY=;
 b=h9Ks2qgmM+HLk9hBoC7nXOd/AQt6XeXsqhciGQ95FYJIhU6BbT+OIydzM1d55mv7RIK2r9sL8j75NYkTc8h+9c8StJEUYDSwkHoiFPT9LQup6dWM2JRUdx11G9kXBvZg0apKtuZeSTT0/HTpRncWCtTroRHLyskngHKUq+rZSzL9GGMparH1P/FVokUkGkppsdcq1zHF8VvuH34l/Qlwkxv5aU/9C5hsKEO/mAU+UrN3It0ptWp9F77RHtDzWYq50mK8I6ofr/hZkJzCslcBF7U3tCmhOXFMwGo/7ggB3Qo6GdQvF7HA5a29sxrK8k6Gxh9Y91TTc9mkyPXBoVwLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IrcSU/ajgAgSHQR8i9dA3hSrRwoQ3zDw+iZd5Cj9qY=;
 b=N7Z4ozQZIzQA+eWrpx93B4bNosqJEC4ciLPsvGZNzUbWgG/gjcgNhVhRhNhlrnx/G+3uztjSUuaa64L1Pd4MalCeCCG+lbDHskoHjTxoz/tnhlU6+rt7J/Zxe+och5vR/NBJrP5xeYOMcNpMf45zeT6i2RKKkgn3cA/MtmrdRhiR4cKncz8/ZrhoXlpGq8x0W+d9EP7RakSWqWgXHpw32WDk94G3v7JhL0Lvw2pkC/VXQx4JnIWfAf8mzWe4o5MH2CyYBOv+F9yUbSv1psekJqNp+Ut3564LMNLW5OqG+89QUO0KKdm8G+syWuPsB1/2vpG5h4aDBBnF6TVK40ixzA==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS4PR10MB5646.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 09:17:47 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c16:ccbf:981d:ea08]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9c16:ccbf:981d:ea08%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 09:17:47 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: Mailing list archive rehosting
Thread-Topic: Mailing list archive rehosting
Thread-Index: AQHYi8stbEJij6+7CECcnDsuIM0no61nrPCA
Date: Thu, 30 Jun 2022 09:17:47 +0000
Message-ID: <344cd21f1804f3a383f25a5e3bea56be956c5649.camel@siemens.com>
References: <87ilojv6ts.fsf@xenomai.org>
In-Reply-To: <87ilojv6ts.fsf@xenomai.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.2 (3.44.2-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47111d95-5565-4001-4016-08da5a796624
x-ms-traffictypediagnostic: AS4PR10MB5646:EE_
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bS5ZindE5ZEqkAu4KuchOCKeuQT9RoulCeP1cEBzrWfNhESh7g0/HoABGLWZ1SqaMkJ87pWjo8LNTffBmyUTpj4cO1mXi8CyVXYljwKMVf8IEnfAvFnYooHC0AANNk+7ck4Xdpo+sQQfYkRXdlIy24Kvjekwdyv2jv0wL1hsMyd2ohrA6cqGmbMdBPyHmm51yyObotg77xxOkPuXESee9zQzYHhbKI7SkjlAk5cL/orNGvZOUJHbabio+ntevB7YhQwosjIC23lrpyWgukJu1t+cfvyIGYLVeO/XJrozU/kMFYi+q1xw2KC4zaP2qi+yPGWD0jIoNRtf9NyuG3KTj7TRvQCgG0v94rpeNqxUXgLk5lTYGWG/HoVvyw0fWDUGqKFGwktlB1X1o0bYwgGrrqcVPD/Yk3lpgmbPRMK6zLZKhmYU0lY6oGmIp+WQyKMIOrBAtHkGL8R2Zv6wwyMAKhDMD0I2QKv8gUrTZ1TzxIPxQ0MNDQ9T/DXF1QUCmoV46ANtifnNQeme4NDrRW3y5alE5m8LX8o76UcuRYdWQAeoDnl8L5D5wkuotU/Qx9vg//MdK5rCRMVpR3QHzf7y58ZAyC3Qv3TSx9oAbCrllqsH5hJc2i1A0mhIv8D0/U0zbA2F2MWyJl1X7Do9cMBe5AWx63t63MHkfeYlCk7pYj7qED7HQORMN2RSF5OBHtH9BOdFO03+FqgBntIi1fGSGqXAG2cvq5Xa8hfq32WEiFKhubTyo9mW4KTeP5KRqzQx+ET+zabSL6Zigrxi3dq9YqWTZIGkRRBEiZ3U1Y8/O3jor2yiUodGjPsCI8RIQjqPBtN6BVmzvceKX0dG0C64sduGeZae6G3nLZOiQU7q9UKDwOv85uaBTta2NHGX45K8mEhjrY7A8sygjQ0XPKG9QbL7ptWm73IH/awOEV6Dz8w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(4744005)(8936002)(2906002)(122000001)(82960400001)(4326008)(5660300002)(38070700005)(3480700007)(66556008)(71200400001)(86362001)(8676002)(478600001)(6486002)(38100700002)(966005)(91956017)(2616005)(76116006)(66946007)(66446008)(66476007)(64756008)(186003)(107886003)(316002)(6512007)(6506007)(41300700001)(110136005)(36756003)(130980200001)(223123001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clU2YzIwWkxZTnRid1F2bmNpUVVRNmZmeDljclBhNWp0NDczZ0F1SmFFQ3dO?=
 =?utf-8?B?aTRuSzR2WXBhMWYxY21zU1NHMU9zMUJ5YmVMZjdCdXdLN1dibVY5OWM5VjFw?=
 =?utf-8?B?QVI2b3ZmdHI2SExVa2VVQm1TbFZSdHF5VmxJZHc0eXBtdGs1UHVkanN6emhD?=
 =?utf-8?B?TjJDejN1YnRhQ0s4bEw5bVY2cnY3N3E4b1FydjN0L1BuZVhDYitWTkhZTDNL?=
 =?utf-8?B?RGI1WlhXMkNaOUczOFo1TDRwa05wTk5GMkI4MkRVTHdCYzVYcnBrSkZmZnc4?=
 =?utf-8?B?ejZha1JaNXowZHdkOS81cXVBeFAydXJaTjhHYXdBeUw5WEhvWkNwUkpubnVC?=
 =?utf-8?B?WGc4S3JoOHpPeVh4ZHhnRGZmY0N0ZVRsWEYrU0lEMENJeEVmZXVpUjNjZ3R3?=
 =?utf-8?B?VllPVHJWN3N2dHpQTnJjUGd3NFVnRThXVEdaWlhvQ0pBenpDOGJHUmRPT2Vu?=
 =?utf-8?B?TUxhb1dMM1FNWlkzRmFKek9uWjNmNnJ0QjJtT1Z3dFlZNHMvVlFFU0xUdXkv?=
 =?utf-8?B?eXZvbk8zUFQyUXBaSFZHeUNXV200RURiNVFaaEZXREk2NWZxZDVSazJmQ1pF?=
 =?utf-8?B?anJpVC9uQ1lJUjJBRStvNFdwcWMvZE03WUtsNDJQU1JjcTRrSHZZRUs3UkNj?=
 =?utf-8?B?aCthem03S3N3WFc0bjFLR3FlVU1KQktpSkdEM2ltR28xRHNmRFEwYXI3bC9k?=
 =?utf-8?B?R09mOFFBRlMvVWpEZzk5ZXQwS0F5MzZnYmg2VVFYLzM0UHRHWWtCRnF3WlU3?=
 =?utf-8?B?QTB6V1lNK0orQVdUc2VxZk03WjZpVDE3M2RIY0dxdHFXTjlDUmwrNXpuNWQ1?=
 =?utf-8?B?TDJ1bTdlZTc0UmVaN0xBQ2ZwNGg5TDZuM3c3Q3NXRHpFV1lEUU51ODFidUM2?=
 =?utf-8?B?Mnh5TG8yMVpqVGlxeGZRci9wU2VmUk00RXFJQmtZbk9Db2t6S3prcFYyUG5Q?=
 =?utf-8?B?d0hmVWNsN2x5bkJ5blFyNmJlMjgvSGQ4cFIxTXdOQ01HTHllMnZZV2J0NDgr?=
 =?utf-8?B?bEh4TGU2Nk1Cc2prbStCSHQ3ZUsxejk4eGhQVERQQnRFU2RlSHArcXJrQm12?=
 =?utf-8?B?SFVRWFh2cS9UNmtlNVJuZmY1VnJ3dnFZRzBzYk5WSFhoaFRTL2JRalEycWVH?=
 =?utf-8?B?V2hnYlFIVmhpVnByU1pHM055VDhpYitaSkYrRnZ3aTVlczNjcXkvaDB4SE5C?=
 =?utf-8?B?bEhJVkprZ1AyNjRNVXB4bVNZaE9WSE8xMlQ0VlR3V2cwekdOdndGS2R5V1Qx?=
 =?utf-8?B?UFhSU0xrSXZPblNTdzUrWHlMaFpIb1lUSEwxcThsa2xQTmg1cTBPSVRNOTRy?=
 =?utf-8?B?ZnVCa0t2NWd5OWR4WStNZ0ZqUGUzUzlRNjJ6K2MzaG5CRFpBZnd6cVdmcGwz?=
 =?utf-8?B?VW9teDBOOEFNY0lBQ2dqVjVzZ1R2d2x6dm5WTlE4QXJKck1BbEJCMy9IcWRw?=
 =?utf-8?B?Rzk0T3VxQUliZFhNV3NLVTcvUEhZRUhDTTdjYXdSWXhabHJPeXZsYkxVaHdT?=
 =?utf-8?B?THI0M2pQOEFqTG9ZWGhHbHpKblhDNUhBZVBHQk5LakZSOC8xa1MxZVI0RHAx?=
 =?utf-8?B?YjZhcDJEMHZZNjRtbW82eGhnQlFUbnRNUXozamIzTWcrU3Y0NW56YVJ0enJs?=
 =?utf-8?B?ckF0VVhCcFJZdS9wRVZWckgvcVM3NFRsOGQrZTk5bm1RbXFIcWtGcytublJF?=
 =?utf-8?B?eXFjYUEwSHUyejNvYUhxNTQvaVZxZkNTNkZneUZ3T0JQdjVmT0dhMmZ2OVNY?=
 =?utf-8?B?aEZNdGxxNDhZSVpmdkt4WTlDeHRmcklJMStkZ1gyVTBkSjVMK1prNmtMUUgr?=
 =?utf-8?B?ektCYU50N2h3dHcyendFR1lWNzhrRUxOMjVCa3dKSVdQcXlzUm85Mm1uZnFj?=
 =?utf-8?B?V1NFdENIaHphM1hmdVVPT051VmRzS1VZL0d3T3FwbWZhcXppYmpISTNBSDdx?=
 =?utf-8?B?WDFieVBjcDY3SHI1eVV0UThtZU05K1VSNHJjQjB5eXgya3Ryc3k2U2lMTllO?=
 =?utf-8?B?clNCcXVkaC9saXRVUHdyNys3K1h6SmEydlY2cHpZQlBTekRsTmdmVXNvNG5m?=
 =?utf-8?B?MmVHR2NoM0VRd3JUdHorWUFRak5NUnYrU0ppRW1lSGJZODZJRkFyMVFLdkpP?=
 =?utf-8?B?Z0d5Qm83dnhDeEVXeXFQK3FxYkh4a0pQSE5vL2p3aWRBNXhLTjZhaFFPMXJQ?=
 =?utf-8?B?NU0wbEtVVVNBWHRFbGVUMUhiS3RRTEtUdVdaM0NMMjZPb3ZNS0ZnSjF3S2dI?=
 =?utf-8?B?OUJWRnF1U2JaVUVSb0dhZWtuaEhBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A6B38BE5CC31449A7082786F182006A@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47111d95-5565-4001-4016-08da5a796624
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 09:17:47.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwxhrxVzKgJyx0LUA9Iom2cYqXiIVMuMnaks6MW7l4XYxMrYOHB0OR3fby00NJFQ3/bPnWqZtOBlT/ReT7kJLqq7DS/ftz2TkvfHrH99DY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5646

T24gV2VkLCAyMDIyLTA2LTI5IGF0IDE3OjA4ICswMjAwLCBQaGlsaXBwZSBHZXJ1bSB3cm90ZToN
Cj4gV2UgaGF2ZSBjb21wbGV0ZWQgdGhlIG1pZ3JhdGlvbiBvZiB0aGUgWGVub21haSBtYWlsaW5n
IGxpc3Qgc2VydmljZSB0bw0KPiBrZXJuZWwub3JnLg0KPiANCj4gVGhlIGxpc3QgYXJjaGl2ZSBp
cyBub3cgYXZhaWxhYmxlIGZyb20gWzFdIChmdWxsIGNvbnRlbnRzIHNpbmNlDQo+IDIwMDIpLiBU
aGUgZm9ybWVyIGFyY2hpdmUgc2VydmljZSBhdCBbMl0gd2lsbCBiZSBzaHV0IGRvd24gc2hvcnRs
eS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy94ZW5v
bWFpLw0KDQpUaGFua3MgZm9yIHRha2luZyBjYXJlIGFuZCBicmluZ2luZyBiYWNrIHRoZSBoaXN0
b3J5Lg0KDQpBcyB0aGUgbWlncmF0aW9uIGlzIG5vdyBkb25lLCBpcyBzb21lb25lIGFscmVhZHkg
d29ya2luZyBvbiBnZXR0aW5nIGEgDQpwYXRjaHdvcmsgaW50ZWdyYXRpb24gYXMgd2VsbD8NCg0K
PiBbMl0gaHR0cHM6Ly94ZW5vbWFpLm9yZy9waXBlcm1haWwveGVub21haS8NCj4gDQoNCg==

Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4EC7EC
	for <xenomai@lists.linux.dev>; Mon, 22 Aug 2022 08:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGOZ1yQwCWOdhzr7w/kiUmbyCkKTfXoMpOT6BOa5dSoav1otHHupqjck7POu93GMNYlsEYVtiaQJpaYNF50bmXTv8JUxdR2WCJWwfZpEdz8KZ/iWUyZlNVmYw3W7u+9lxDGjX92SCt6WmPVYsm2cws5iDuDpPMKDj7/Yt7TF/0PxtCijebTnQkwA9hH/yPbhizKRIB+DkBeMYaaP/OxgpXLcjyurlYrKJMTGIjUQkKltnQTjd7dPzbxTdt5HJa8zBV6ePvIXugbIE1BOPGc2SiJo/SWde5j1YP4DqjRjRKQxvmlqcVi4RKFFQ7+zP29WUHEtTevJ4771EPtdrG1aNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5BZPYiLEybs/rDxduHx5ABDvTUFGjWCtypv22OdtAs=;
 b=l10pYwSFYtiVQ6Rftd7ilLnnYXMXtOxpP+T4LUbsK3EygdP/Ep2zA7t+GjzTONfBUp5zOrXQwzO/WxqP1b1vVbEpMK2qfgVFqyD3tVJj7WTR94mKZVsL1wRWVqfDdFuLkvp68QmV9/Dlp0glpcTjmYPBZL5GvmQl0GByn7gj6ULyC61EhseGqMa1EKKwKWbhqsGT4W84LqHoC7IK8B6K/z3FUCV1+ryoTxkgR1KXAb9WSgvsxwuTWk8plwC8kpWyIJc1eZhsFHCMAJrndsG5Zn44Sbd2SeE0gVTMElZtN2CuE20DgYQBAVgd981toiSV2yZLlZOqNINhDK9D9d5DwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5BZPYiLEybs/rDxduHx5ABDvTUFGjWCtypv22OdtAs=;
 b=BFUYMP53QUHTNGYEyhjGw5mo9eTk/zlBYF1OL6MD2E7uhdP9cOTXE4imAq1MmnjhnF4PtaHDxhTD8bwh7/aPt+ViBKcn+e4Xbqr+m0P9QNJ4s9Sy2eIsEYVgz+78XhMrrTg6ADVl4fkAB5hQ2BlljZp2dmUijKRZT0uOWPvGPbn6ZdZQweUANY3psZ29nNkScHQZyPimBAEnBFK5cWp4qtpaEQ3UGucSxHXIyfFA/9xWqygZlBlBoY+Kazve3WprIrV/3+RRjl6HcWIgTTLJaWvKthBeb0vmXZE8sZkadpz0qTmjkmM20+Wg3fV/ipzAnP5iOUCeKrDuvlq2J+OGcw==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AM4PR1001MB1265.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 08:52:22 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 08:52:21 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "rpm@xenomai.org" <rpm@xenomai.org>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>
Subject: ipipe-4.19 on arm64: Stack overflow when compiled with gcc 12
Thread-Topic: ipipe-4.19 on arm64: Stack overflow when compiled with gcc 12
Thread-Index: AQHYtgR+LV9jgn3KxU22mQmE60hdgw==
Date: Mon, 22 Aug 2022 08:52:21 +0000
Message-ID: <977443ed9083abfe574dcb1aa8582ecf091c2ff1.camel@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c157fc2-585e-4989-43dc-08da841ba08e
x-ms-traffictypediagnostic: AM4PR1001MB1265:EE_
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 azjesJBFIaO/iz4AmoLXWAgE78dXOgOyT6niJIWTI8Bj+pLWmpWhtNkEeIT+K//awI6R/98YWyGsTGjMN+PuetK7LR1GDrEuYIgTiyIPQHGTr5qCr5hexzYsDqibiVxux2OT0jqzGUZZdQGE2SdjFJHSBHIuNME2pD+kcgJnX+N7YZ3SiY58yrECEwr7PQFGbl9E6UiMIc4B4dP3bUvxR+3kvbmh96bHRvLEfA3CVj7nagrluTO029HhYEMOn4QY3m2QXzHGFjnElcTG60kPPctyJlGuxfLwtsZRT7BN3QL9suOyEkpzyH2OhQyKCzyVQCWlT+0mBTH3tB2E9gY/kKYJlkbOcfd9kjZ6UGQE2Qlc6BA0rbfL49XrI+djGxSvkzcw8us+/dLenHjam7Gzy5/a02sD/EMgg4lgJ0i+rPkUbppvGmuPNhyqZfxwK+vLTHboU/DyhSewL/cqZykVSBVo/jGRnIM678Mk16zMGyXVxLD9i1dAQ/kvRgiW42kesINVsdtETsHmOIs41vsklZuIR1hPp/arw4op7G1llEqUonDwz+0BQI5LQ7dLxWCnNh0FsFETljoq0uDZxknLUqE0TS3ZSxz4v4Y6kVbzRjTS4o1Zv1JyJmkxkU1NkDKGo7wmgielpJXL6t3XX0QOXLKUWf9pZrFvO0nMQFDvSltF8cZYOrYW5fEduQ5ATraLwTaX36NdkMyS6N/cLl5YRA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(316002)(6486002)(4326008)(66946007)(966005)(76116006)(91956017)(8676002)(66556008)(66476007)(64756008)(66446008)(71200400001)(5660300002)(8936002)(4744005)(107886003)(41300700001)(54906003)(6916009)(2906002)(6506007)(6512007)(478600001)(36756003)(2616005)(186003)(82960400001)(38070700005)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTBudGhtVk4xRkt1RDQydExrZW4wVURtbnJ6YTlEQ1hicUZNd1lsaEgxeVhU?=
 =?utf-8?B?ZExoaE1GMCs1TENwbnpRZDM0Vk56aFd2bVNpUGhQZWxaRDJWeWJHb0lkY0FD?=
 =?utf-8?B?MEd1RFhFaUxXT3pMVk1ldGY2b2VDaGdBK2dwQ0FFTGZobkJWN2Z2K0M3eTFi?=
 =?utf-8?B?S1R0OHBqRFYxZmV0eE5Fd1QzanpvWW1xME9YSlh4WTB0STFWVWRZMS9CN2NJ?=
 =?utf-8?B?S0VRTzNHSFp6R2FUVXA5KzVjMHFXUTZlaVZRdVJqQ2NwaGlOZXh2RC81Sjl4?=
 =?utf-8?B?L1dTU0ZXWVNYNFJPSndLeHpmOW1WOC9vbW9vZTBLYXZaMmJmUWM0ck84Q1Ns?=
 =?utf-8?B?Z1hsc09Wd29vL2tJc2pta3M1MFFYNUZRczcyMGYrdk1jK2E5SjVCVm1ibmo1?=
 =?utf-8?B?NlVhUUUzSXhwazhOM05IVEh6dkQrenJ4Q3cyZ0dTUzY4RkIrOENCanh4NDlN?=
 =?utf-8?B?TVNCVExKcDRYd0pnOXBrTzlhREQzd3JMT0YwcjNRZjZzVTZ5YVpXSUF4MndX?=
 =?utf-8?B?SmhVQi9xQTNCNGgyQnRkU3Vtc1l0SmkzRXBnN0xYYkFnOGV2NjJvS3ZPVVZJ?=
 =?utf-8?B?MnhFemZqQW52RitPOFFhNWtlUXhXYzRURERieVRmeDduZlR3SUJFK1VieFlV?=
 =?utf-8?B?dyt3SkZXZTd5ZWMzaWl1bFdHdVpNN1Q1aVVObG9Tb3c4eUVJVjNRTEVsTWYv?=
 =?utf-8?B?cURuN1hrbFBXWTJ0Wkxnc1kyK1pmbmNsbERpK29SWVhLRE80WGdpWEE4MEFG?=
 =?utf-8?B?akEybm5aaEhqeFB3dU5ibWt1QXQydG00dlNUWVZVdGVSa0dRd0wwY3dGZ0N3?=
 =?utf-8?B?SWhoOXFyQjVWR1NUSzZOTVQ5MTZjczQwRU9wRFdZNDVVWjhhREZrdGlZa050?=
 =?utf-8?B?cVdlK2wxSkNJZnlqZ25QbHJrZzJqM3RZZzJRaytBM3g0RnBqc1ZQY05CUC9y?=
 =?utf-8?B?c0ZGNnkzNFZRQ2VyWHl0SUlyc0FveElucGJybkI1YjZ1Y1I2eDJiOFdRdG5E?=
 =?utf-8?B?aklMM1UrZURwU2pBTVVsMVpOY3gwSVhJNXJjYWwya0xrOW13Z0tKRFI4MUZ2?=
 =?utf-8?B?Z2Z3MVI3S0V0MExUcE81OHYrMEJhMXUzNFRMYmg4T3pUTEJGR3BaSVJzbXZh?=
 =?utf-8?B?SVVnNDdLbE9LTmJSTnBBS3lpaS9RVTcyajRLQ1dSQ0t1Y1hLTU00WEUvS3Nj?=
 =?utf-8?B?UUFJTmlINllwd0lOL3JGYXE3WERkNUVFUXpXeXJMMEpHSStVeVkrSDFJRGlU?=
 =?utf-8?B?aGRjdXBwdEhNUG0rUjcvblc5UWZrYWVEMFV5ZEdBbGt5aEl6c211MnJuUUxi?=
 =?utf-8?B?R3FFUklrcnkyM204WFk5MDlDSzVVVW9XcEc0ejRyUjJ3V2Q4T0FxY051KzlD?=
 =?utf-8?B?QU9XUE5JRXF5K3NhUm9sbDg4QmM4cUJERmNhbFNWaFlkSitsRytKUC9MSTly?=
 =?utf-8?B?UDFkWStTckM5Ky9aVmVaYi9uR0lZTk1DYkZHbnorL1VabmM3d05ZVGFOK3pF?=
 =?utf-8?B?S0hWdTQ3bFVpV2RkcU5HcTJnalNpdVpzeTFVZ2laNmVUSDFqQ3VqN29zWi9o?=
 =?utf-8?B?bGxLaEZ1bjk3MzFWbWJEUXVLV0dIaFdKMXcyVFo0ajlXSjczT1VnT2NobmNv?=
 =?utf-8?B?S09PRkUzVDFmVXhvQ0ZEU0FZRFlZVzNjTVBtUWpoUWZZR1VRVFhMekVyOWdz?=
 =?utf-8?B?bENPaXpsQ0RFanB3TGtkd2hxWktnbGxFUEhnNXVvaEtnYTQ3eHc1bnFHT0h3?=
 =?utf-8?B?QmtweExucCtENU1PNC9HTHB2dWJyTURaczJBYThQTU8yRUtiUTRLUFN5Nk0v?=
 =?utf-8?B?cVVGNUJwbnlYNDlyMFJTWHBJRnBuMktyZEs1by9DMG4rQTBUM3dOeHBxMWh3?=
 =?utf-8?B?QUZ3b1l4ZU42Y1JFMUVJTmdQYjluRlJjRVU4Sk5yT2YzcEtLNStCVjlKMTJz?=
 =?utf-8?B?RzlhSGpnN25hdDM1bGZUa3V5aGN4aklwTk9YU3V1cWZwYlBDOURGK0tDakc1?=
 =?utf-8?B?Mk8wOG9ndUdRczY2aUFDZm1EdmVadUdpeWhQVEpwd3poRkpJa0FyclYxY2x2?=
 =?utf-8?B?aWhiVU85ZUttR1laWHBCK3hyYUpLV1RlN2VBSUhuc0swNnJ6NDlWditxaHlR?=
 =?utf-8?B?aXNTVnhNdmkvWXl1cW9EWTJlODVCV285YVZ4SVJ5ZHFrSlhuZ2xaTkZWd3VO?=
 =?utf-8?B?T3c1eCt1MFRTYTIzL3g0clljWEdEZ0ZmQ3kxVnJyd2VTRzJzVWI4TzhFdXIw?=
 =?utf-8?B?ZjFhK2M3Ym8rY0dwbG5rYlBmcW5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7A8F4899FC6694BB82A1CC75F9780E3@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c157fc2-585e-4989-43dc-08da841ba08e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 08:52:21.8539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57L1c0GZlbVAHkVrwsYkveZvfgc5P7MzkmGICmP18xdrnXJeu/RRO/bLlBAxJtrswnUgcAqBM7YPMajFwcYaOCQAjeN0dMnc6aADZGqnTgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1265

SGkgYWxsLA0KDQp3aGVuIHRyeWluZyB0byBmaW5kIGEgcGxhdGZvcm0vaW1hZ2UgdGhhdCBpcyBh
YmxlIHRvIGJ1aWxkIGFuZCB0ZXN0IGFsbA0Kb2Ygb3VyIFhlbm9tYWkgYnJhbmNoZXMgYW5kIGtl
cm5lbCBjb21iaW5hdGlvbnMgZm9yIGRyaXZpbmcgdGhlIENJDQppbmZyYXN0cnVjdHVyZSBJIGhp
dCB0aGUgZm9sbG93aW5nIHByb2JsZW06DQoNCldoZW4gY29tcGlsaW5nIGlwaXBlLTQuMTkgdXNp
bmcgZ2NjIDEyIHRoZSBhcm02NCB0ZXN0Ym9hcmQgKGhpa2V5KQ0KY3Jhc2hlcyB3aXRoIGEga2Vy
bmVsIHBhbmljIGR1ZSB0byBhIHN0YWNrIG92ZXJmbG93Lg0KDQpUaGUgbG9ncyBhcmUgYXZhaWxh
YmxlIGhlcmU6DQooU2VhcmNoaW5nIGZvciAiS2VybmVsIHBhbmljIiBtaWdodCBoZWxwKQ0KDQot
IGh0dHBzOi8vbGF2YS54ZW5vbWFpLm9yZy9zY2hlZHVsZXIvam9iLzUwNjkgKHN0YWJsZS92My4x
LngpDQotIGh0dHBzOi8vbGF2YS54ZW5vbWFpLm9yZy9zY2hlZHVsZXIvam9iLzUwNzIgKHN0YWJs
ZS92My4yLngpDQoNCklzIHRoYXQgc29tZXRoaW5nIHRoYXQgc2hvdWxkIHdvcmsgLyBzaG91bGQg
YmUgc3VwcG9ydGVkIG9yIHNob3VsZCB3ZQ0KZGVmaW5lIHN1cHBvcnRlZCBjb21waWxlciB2ZXJz
aW9ucyAocGVyIFhlbm9tYWkvS2VybmVsIGNvbWJpbmF0aW9uKSBhcw0Kd2VsbD8gSSBob3BlZCBJ
IGNvdWxkIGF2b2lkIGFkZGluZyBldmVuIG1vcmUgY29tcGxleGl0eSBpbnRvIHRoZSBDSQ0KYnVp
bGQvdGVzdCBtYXRyaXguDQoNCldhaXRpbmcgZm9yIHlvdXIgY29tbWVudHMuLi4NCg0KQmVzdCBy
ZWdhcmRzLA0KRmxvcmlhbg0K

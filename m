Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6439ACC
	for <xenomai@lists.linux.dev>; Fri, 24 May 2024 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559396; cv=fail; b=EpPBj8i9rS+q8k6ykQz35EzeOCGsRUpLVpaAmOryuxOQH7LloxqJIuAqaEnxWAnW6fwRg/AE/B9EMhf7whYZuWKQTDnSg8MCFYemOe0NIf+eepxFTe0FIHqTwEzM4fn/H9c8CmyDpk1hTKFqL9LYmAzZQgAfIgFo6IbP1l181Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559396; c=relaxed/simple;
	bh=i795SuHyhr1b978lpK8HBBy5rjrFeHIX5dqAEa18FWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a6uxdrimXOmKl0hrf/fH99YXhe1chVvpiAmh0UdW6S5+4s4wgUdDnOAfZSnLPKHcGvLjDgz0XfGiIApcHxIpofg3nO/ktFQMJRiqPd/bo/h59t0bGrtFx4AitIE/w0EtIjXQ/AZttKj7hXE982e+ADSmMnt6Lc4NeHuc9zzY7kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Vn2vtdDZ; arc=fail smtp.client-ip=40.107.105.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Vn2vtdDZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG1UjqqULvVFJEjkkaLeFEKl6xOY0XvtROTmknxMCqCD4EJzljCZgQEPR9L3sJ1UcNY1BAXONZ/wzI5bYTT+rS3wuOpRJ5rw/rUANtZQedDCKmV446IPh37cP2iigpp+inmdx+E6ffEzkuc4KxBDFRH2c19ASexva0pMzYjj/1hTiVYvntjvNAQ1wmfRuvR7Wn4pLBIy3I2sEElu1bIkczoTSsBrrX0ejfufXxZABL/CqY9V1MGt5hAi3qy3/dTHYdb6ayJ9ken4Uj9Tq4Iz13d/zETPgchBzbHBqHgnI7BNUfGTTERSOyVYBWGNkfbE01nAebWs2MC0QlJkD1iIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i795SuHyhr1b978lpK8HBBy5rjrFeHIX5dqAEa18FWo=;
 b=Eewp6ZKldD6tRX8rsXskpaItHKkA9ef/TdFAOngdqwSuEv6MPPXexbUZ7oNJb623MQ9JWq8C9lxH5ASQNFi1inbT7X+w3UgMToNatQS26fSGOGhRUQSR5MlYa3UvOmaaWD4dGm02HFiCO/L0Z6PAVJ4biNROENWnj2ermb1lCeh9fA1wBy1CDrLuX/iJ8QXXTcGyDNqarJznXMhhAweD78dK+tcDgOaUFPBeBoJxmIY+a5ypAzMW7Xmm+OYGrebVjBE2VSi891vQeSWj02E/50tXGVnqSXX7KWSU1oWvZMMgeFvJE03Qkk881/h5eGDn+et6aRFF/Z/546C1cG6AXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i795SuHyhr1b978lpK8HBBy5rjrFeHIX5dqAEa18FWo=;
 b=Vn2vtdDZw8W3DvqLR46WgA5eE//gKCy6+7yWLyD76ew/Ys7YWCQxTHu4hmKSlCoinwk2oWIG9Lv/UZuYJC2Is77fo8dmpCuUcwrp8c1rIm0AETHpdd0BPtlrx9CChoft11r6tQ3xqn71CydzT8lPQZIk4kqSRvO/sSdQXbTsG5ZqgKfpL+KD5dbEnF0bdWC0ew3/bcmTypT/uLyB724mHEGuifu4Vq/6u7S7gKoeN2EUIK3WDrvxoF02qzd9n1D0M18KBcuqkrwQtkJAS+FtA7XTCNnw8RXEwfCNUTLUW1hU8MR+SpNgyJGL/3pGLyqoGKa1H6X2bS5qZZyuhsZySg==
Received: from AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54e::15)
 by GV1PR10MB8026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:80::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 14:03:09 +0000
Received: from AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3715:3406:3bca:ecb4]) by AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3715:3406:3bca:ecb4%4]) with mapi id 15.20.7587.030; Fri, 24 May 2024
 14:03:09 +0000
From: "Jiang, Yi" <yi.jiang@siemens.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [PATCH v2 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target platform
Thread-Topic: [PATCH v2 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target
 platform
Thread-Index: AQHarcnxZizXbb/DpEShmNMVXaVtm7GmSoAAgAAgIQA=
Date: Fri, 24 May 2024 14:03:09 +0000
Message-ID: <18d5348a6609ec9661ef9df3dc2a7852d21b245e.camel@siemens.com>
References: <20240524110254.37483-1-yi.jiang@siemens.com>
	 <20240524110254.37483-3-yi.jiang@siemens.com>
	 <da74792da55cdc921c86a5ac12de49f626f9c47d.camel@siemens.com>
In-Reply-To: <da74792da55cdc921c86a5ac12de49f626f9c47d.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6221:EE_|GV1PR10MB8026:EE_
x-ms-office365-filtering-correlation-id: 8b6bcc43-169b-4a32-cac2-08dc7bfa3e20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1JyS09XNTJKeklDVytPaDhXKzRpSDh1bk5EOHhuRWZrazFDMEprYmprL1Av?=
 =?utf-8?B?d3N5SDlVRVFMckY4dlVqRDM1QmEyNFVIenVUdzJrREZqU3B6Z08wZGdXYVo3?=
 =?utf-8?B?emhlOTJhdTR0Z2ZUcEl4SnpQQ1VqZ2JIVDJvM0MxVUJWUVJETXg2QlZnUlFh?=
 =?utf-8?B?ZXd6NE5EbWo0Zmk0WmpjVUZQN3RLay9iOHZHMTRtcFBIclVwODFBMkhadFJU?=
 =?utf-8?B?MStBL1pzWVhmQ3pNV1hpNHJFVWxONFlwNVFsLyswUFgyL09adXV2TDlUV0Zv?=
 =?utf-8?B?UC9BaWoxcmsrWVVVYlRrVEt3SEgrTkJZTFNRaWxlaVZNYUlwcjN4eHVtbkpk?=
 =?utf-8?B?TUhDSFc2bjViQUFyb1pHSUlIR1pKU2VsaXIrZEwybFZpcjYvQVBBZlhINWFF?=
 =?utf-8?B?bE1mcXIxTDFBVUcwUk56eUhpemlSUXZMdXBmVm1HN3ZIQjh6cEdJa1RWWG85?=
 =?utf-8?B?c1lPd05vVWM1cWZweEdNWEJOSXM4M2k4U0pYbmlwMVRMVTY3VEVtK05TRUZ5?=
 =?utf-8?B?ZnU5RzJpUVc3amh0dUh3MVhkdkVjU2JtcktaZk85Vnl2QkVVbkllNFM4cFBI?=
 =?utf-8?B?UjQ0M2I4Mlh2YkZXSk8yamhMbEJONkFwczRMT3NYMExiQnIydHNxdHJnQTFx?=
 =?utf-8?B?dnRDdTYvSitWV09PWDI3TVBiSFdNUzk5ZkNmaXZZMjV5VCtXdktyS2RCTkEz?=
 =?utf-8?B?VXFHWVl0MTJsRUZiOFJmallBZ202WUZxUFpVdWxFRzgwQXcrL0lPNDhKQTBx?=
 =?utf-8?B?VHc2a3RDdVJ3ak9aMU9vOTF1ZmsybWJjd1ZYcnJNZkJCM0M1Z1IrOGJaUEZN?=
 =?utf-8?B?VUpkYXpISm1DM29Bc2kxQlg5bCtWSUFTaHBJVlNmc0dCTWNIR05pTGluRjIr?=
 =?utf-8?B?TVpnSGpyS2IzdEMyQVowUjluQTlPVVp0T0pxeVU3RkJQWkY4d3M4Wjh5bkNP?=
 =?utf-8?B?cEJUU2NXYVJyS1ZKQWhRTEFwQndMcmVkbEVBb0IzSTFrRDg0a0haVk1mZ3dW?=
 =?utf-8?B?c2JwSU1mc1dUM3YyQVpTY3U0NlJJZkpNRC9ndnRRMERrRzE0S2FIeEYwc0hj?=
 =?utf-8?B?cHcyZEpIODVUd1FOdzF6MVh3bExFSzlZWmthck4vbE9xNi90d1dMTnM0Ty96?=
 =?utf-8?B?ZkpUWDU4VS9oKzhRVndvc0dGa3o4VjlDZllxdzJjbFUwVFRkQ0JseVJNS2VB?=
 =?utf-8?B?cWdFYXdJUU5BVFEyd09maW1XV3ErTVdXVVNRRGRscldsVDJwbkZocUwycVZG?=
 =?utf-8?B?NlRqUCtodlR0cndnQlE4K0lUaFA2dkVtdkM5UEV0ZGd0b1V1TTZYM0pKbkFs?=
 =?utf-8?B?NlNTVmFwTlJ2cW9kR05GbTd0THNvNzNYaUJnZFlGQ0lrR1lKaXV6dzNDaWdX?=
 =?utf-8?B?Q21nOVZxWktBMWR1dWQ0N1lqa0JnNkF1ektJa3NZSmRwK2VwSE5pTnRMck9h?=
 =?utf-8?B?U0hSRXdYS0l1WVNBMGtmMS9DSlNWNjY4c0Vjc1BpOEFCZ0d6MnRKcUVmMmpu?=
 =?utf-8?B?ZXVyQWtPMVdkSi9sNkJDaDBUa0NiT2I1MTZSMjhHcTA0YXZ6OU45cmZPeHFa?=
 =?utf-8?B?NHlDZklhejhvRkkwTXlqR0VLWGVTek91cDJ4czZJYVpObnozZDhrNUxXQVNM?=
 =?utf-8?B?NU9qZ3ZoUDBjRmlQRGMwWlhWSkxrMFphQXJDQm9Yb3dXRW9BQ3EzU2d1Zmho?=
 =?utf-8?B?aTlTK0EvQ1FQbXlwdEJWRGlXZGVHSnJpaHI3cFJxRlVGc01TNWx3UUpRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OExRQ0dGa1ppb2JCV2N2cG1BQ3Y1Q3lIa1JZUTlDSERKSlRDa1JEMlIrSExO?=
 =?utf-8?B?R2Vmb2RHckU1WkRuR3RpRmFqL3NCOWZiVVNwUU9OZmFCdGxLU2oyUGp6Nmcx?=
 =?utf-8?B?Zi9DSUxwNVNYaXpWQlNuazBIQ3R5cjRKYld5a0dUSkRIdy9XVmkrVlR4N1E4?=
 =?utf-8?B?c1hLYUZRVCtKYWx6WENGZ0g3NzNIbGVKR3dJa1ZYcDBsUE1LeXNqYWQvbUZZ?=
 =?utf-8?B?clBibUxULzJ5OVdDUGNsVEZ6Y21SR3BvdTlvV2hRRzBtZG5JTmIvQ1pzY3pF?=
 =?utf-8?B?S0RpMzAwWHc2MEN0Nnd1ek45NFplNWdMNldRNjY5QlI0bHVPbjFMMVNrR1BS?=
 =?utf-8?B?SzFVYXFRallIWlBhU1VycWJnZ3ZDR1EyRXhaQmhEa0FScWwySWZLcTZKQWJM?=
 =?utf-8?B?TitPRVdRa1hHNWpoZHFUSUJkZGhWdFE1SEc5U0p5SlVOdFJyY1lMd0xmUFV0?=
 =?utf-8?B?cXgxQXNIaEd6VzRmd2VtOS9BeUVKUm11M2Z5dW5LZVNXVDhPZUdpWExnL1h6?=
 =?utf-8?B?VjN3NEhxakN5S3grOTdidjlpYml1Q2hmMkh3S3BlWFBJZ0NPbjV5a1RRL0pi?=
 =?utf-8?B?US9jNCt2WUtGNkZFNHI5OFV4enhtTkNCUXBBWDZ4Q2lSS295Zk12OHRSRkUr?=
 =?utf-8?B?T0tZYWxHaVVBQUlvTUpzU1pVU3YwMXBBR0UxSmJQc1FBdHVYSEdlMHczcURh?=
 =?utf-8?B?Vm9oUUFiTUdiUU1ldlIyWkIzYUVnWW9hUmVXM1NiLytyMk42YmRLZjg1OEhV?=
 =?utf-8?B?Lzk1a2gzWTZLbC9EdWs1STNKVGdPcE4wMWRidlhBbkhvZXJsMnpFVnRjdEdl?=
 =?utf-8?B?MGFxVGRvT0wxZHFBSEdQMmRnT0Fzazh3RXE2c2V4eUMzVm5UVW1IYTJoNk56?=
 =?utf-8?B?dWt6M0w1eGpmNjVhZWwrOXcvbE9xOWU5ZFNmZjRBSVVaSnViSWdpNFgwajBE?=
 =?utf-8?B?MHRxN0d4ZHUrZk4wQkpEbldzLzg3VmVCU0VIVmVXWUJoaXhBRnNhSjBZb2U4?=
 =?utf-8?B?Z1gxa04xa1VSenVHYmE1VnE2dlFRRTRCak8xYktHV01RYVVZN2ZoQ1JVTUxF?=
 =?utf-8?B?cDByeXVrVmFyaTgydXM5RnFkNnduMFI4Nm9STlVPWnZUa092UCtjWXcwVFFh?=
 =?utf-8?B?QkNndXU2K3VLemR4a1F2SGc3ZC83UXlKSXgxZ1dCYVdDdklCd3dJSVo4U0xh?=
 =?utf-8?B?TUhSd3l4OHFzOXVuNUZjOGtWZXFaMmlvNXpreTFJQjk5SGpGNmZ1NkhzbzZ0?=
 =?utf-8?B?eVdlUjFIREV2RTVWeWphL1YxQU5sa1hoSjQ4ckFGT1hqQzVkdS9UL3c4RDVl?=
 =?utf-8?B?bzFGV0xScHlXdEdrV0NiSnR5Z25malNsbFl1TmhiVzZtOHc5V2w1ZzRxUjQy?=
 =?utf-8?B?TmFhNTdzNVZ3THIxYUtqeXJPWEc3cGtlOHR4THU3ZmtPdnRhSDdnUEE4SVJY?=
 =?utf-8?B?YW55aWNNVThJdVdwLzgxY1BIQ1RadWlKQ1pWVzRBbXRILys5SlptazRVdzBx?=
 =?utf-8?B?U1ZZVkowMjVtdE0xbjdFbEt6QnUwb282VGxmOVpVY216VlQ0Z0hGNHFSR2RX?=
 =?utf-8?B?eDRKN21ER29TZko4NGE5THluSzNqSXZJNitzNGRFVUFyVkx5R09YS3ljNDE1?=
 =?utf-8?B?akFvd1FnV1ExZys4dGVYbzViTXlZakludVJYdjQ0d05tVVRnRW9wRmhaYmxk?=
 =?utf-8?B?SlROQTBTU1ZnbmRaM2ZDR29FVUtkb3cvcjhQckwyU1dyNmtIYnpOZks4TmlE?=
 =?utf-8?B?VVVJVUw4WERwaWFRVG9qVk5XVTRYS1B5dDk5UVJvTXFGWFNWcXBGVzlzSGd1?=
 =?utf-8?B?RWEwNHJESGM4bkZKQUlYVmQ3LzNqR1lraXdpdW9tMHU1ZloyVGhCZ2NPeWtR?=
 =?utf-8?B?Ty8vaWxxc29abUxHRzVuSmY3M0hkNkhtQ21OQkZHQjVwVmh0K3hwQ2UyRjlX?=
 =?utf-8?B?YXVvbFhsZHJDSkk4WVdCQUdUbklWbXNabWNRVmxMb0k4amVHY0FyRklEZFJy?=
 =?utf-8?B?VHI2U3hBSWxBM2FVU2NYV1RONU95U2VOWlpCajNHSkRLR0UzYXJyZ1lncjUz?=
 =?utf-8?B?aFFyRHR3eTNHYk5yTzBFVGVWOHdxWTNDNnYrSGRzNG9LMDY1dGwyLzJhcGd4?=
 =?utf-8?B?bXFjeXNYUTRjbFlHYkhjOHZ2NzRJczQyeExHenVqSzJjWm14OVNpTGZsdHhV?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C85BDB66527F34E89606E0C91DBD8C1@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6221.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6bcc43-169b-4a32-cac2-08dc7bfa3e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 14:03:09.3945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxYj7/7ghzvu/vRylbE/oh+J0rrKjXwL92q+iQ0WATRvjdFmIgjG+81XcIQ5SDu6GK6FIfAb9prjXQJA3v4NdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8026

T24gRnJpLCAyMDI0LTA1LTI0IGF0IDE0OjA4ICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uIEZyaSwgMjAyNC0wNS0yNCBhdCAxMzowMiArMDIwMCwgWWkgSmlhbmcgd3JvdGU6DQo+
ID4gLS0tIGEvcmVjaXBlcy1rZXJuZWwvbGludXgvbGludXgteGVub21haS0zLWRvdmV0YWlsLmlu
Yw0KPiA+ICsrKyBiL3JlY2lwZXMta2VybmVsL2xpbnV4L2xpbnV4LXhlbm9tYWktMy1kb3ZldGFp
bC5pbmMNCj4gPiBAQCAtMTIsNSArMTIsNiBAQA0KPiA+IMKgcmVxdWlyZSByZWNpcGVzLWtlcm5l
bC9saW51eC9saW51eC14ZW5vbWFpLTMuaW5jDQo+ID4gwqANCj4gPiDCoFNSQ19VUkkgKz0gImdp
dDovL3NvdXJjZS5kZW54LmRlL3hlbm9tYWkvbGludXgtDQo+ID4gZG92ZXRhaWwuZ2l0O3Byb3Rv
Y29sPWh0dHBzO25vYnJhbmNoPTEiDQo+ID4gK1NSQ19VUkk6YXBwZW5kOnJwaTQgPSAiIGZpbGU6
Ly9ycGk0LmNmZyINCj4gDQo+IEhlcmUuLi4NCj4gDQo+ID4gwqANCj4gPiDCoFBWID89ICIke0Bk
LmdldFZhcignU1JDUkVWJykuc3RyaXAoJy0nKVswXS5sc3RyaXAoJ3YnKX0rIg0KPiA+IGRpZmYg
LS1naXQgYS9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC14ZW5vbWFpLTNfbGF0ZXN0LmJiDQo+
ID4gYi9yZWNpcGVzLWtlcm5lbC9saW51eC9saW51eC14ZW5vbWFpLTNfbGF0ZXN0LmJiDQo+ID4g
aW5kZXggYzY1YzI4ZC4uNTkwOGM1OSAxMDA2NDQNCj4gPiAtLS0gYS9yZWNpcGVzLWtlcm5lbC9s
aW51eC9saW51eC14ZW5vbWFpLTNfbGF0ZXN0LmJiDQo+ID4gKysrIGIvcmVjaXBlcy1rZXJuZWwv
bGludXgvbGludXgteGVub21haS0zX2xhdGVzdC5iYg0KPiA+IEBAIC04MCwzICs4MCw0IEBAIFNS
Q19VUkkgKz0NCj4gPiAiJHtHSVRfUkVQT307cHJvdG9jb2w9aHR0cHM7YnJhbmNoPSR7R0lUX0JS
QU5DSH0iDQo+ID4gwqBTUkNSRVYgPSAiJHtBVVRPUkVWfSINCj4gPiDCoA0KPiA+IMKgU1JDX1VS
STphcHBlbmQ6YmVhZ2xlLWJvbmUtYmxhY2sgPSAiICR7QCAnZmlsZTovL2JiYl80LjQuY2ZnJ8Kg
aWYNCj4gPiBpc194ZW5vXzNfMChkKSBlbHNlICcnIH0iDQo+ID4gK1NSQ19VUkk6YXBwZW5kOnJw
aTQgPSAiIGZpbGU6Ly9ycGk0LmNmZyINCj4gDQo+IGFuZCBoZXJlIEknbSBleHBlY3RpbmcgYSBJ
c2FyIGJ1aWxkIGZhaWx1cmUgbm93LiBUaGlzIHR3byBodW5rcyBuZWVkDQo+IHRvDQo+IGJlIHJl
bW92ZWQuDQo+IA0KDQpUaGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4gSSB3aWxsIHJlbW92ZSB0
aGVtLg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gRmxvcmlhbg0KDQotLSANCllpIEppYW5nDQpTaWVt
ZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

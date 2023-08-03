Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2024.outbound.protection.outlook.com [40.92.22.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F347F
	for <xenomai@lists.linux.dev>; Thu,  3 Aug 2023 01:03:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVom9kz3v8Su4bJXB030wJZoroUErzjF8d+BRNPUhiufFJeT8yRv/3Ndva8+M0Rg4xFhnZO1RFgJNT52OjJgq8kMaLsoy1/F4Ioy+SfniUJygWk7tdeq/pzWVhPa9yW2DreF/nGT8NWsGWiz9KDyN1UuiICKrmSoAxAjpIsDB4xjA+ez42N3jvRf4b/uMleGptKQmdEW0+kyDDOcIQunH5/MdJY/IYnG25RgRoUt9lnEaWsDp8LlU2Jr96hTOPsuSNWvcvLBVwPlpQo9Zt9l01b5ClmJdR0HcJOmGNs6ECR/cNu0tzdp36OSnHrWiAJQHhFB9g7bZhZC0YmAxpLvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJkX9vDuTJynIsHQIFn3qwZUPKY9PsVxbyGxGg7sjys=;
 b=TNiElqYMG0+fSSN5NW4Li5mjT9Ov7KUxBal+KS4MQR5SjzKW0cdAjPmzUiG7lJXM+AqCO861x2A4aqlKEGGb+dhDa6dvO+qwxKKsbxfdPuSYjCNwVbVlKSCVQQwOQ4wB9Xq2hY4pix/p1BRHs23Qrgl8g805dr85a0Q56Nbo+1upSEs8hqPos9DAgh03a/XYI31epIwy6sRUDJbeE0XISfQZq/4//0e0/3XGFNBwJyqvM+cyaPuqCya2y36dvDiefJpToS3TvzOPTAdaeXDtMgQODr6dWwlhdAXCUauVniu6mgKoxTEFg/J4r9mGeXXGfOnWggCCS8Jzi3YgZ8wCTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJkX9vDuTJynIsHQIFn3qwZUPKY9PsVxbyGxGg7sjys=;
 b=WYZnyjjL4gHjRnwXb4kETeolHwv6rqYxi9Jquf3qpdjIDY10IEBU1cC8nTii5lLpE0hPm0OaJHB0ODHW2dKBbmWZkPdYnAKGhX4k4vCxYzUjx2ogw2UYksCr6Gl98H2Q2w5qJWAHfiTh4zAt8kRXZMObLeoFNK32QRkOt0KLKjG8M0YWXJFCidT3MGfcrY5ZozNQjxLgM3nqCXefx/r2vR3yOjQeHyXiQrRnXE9EZjBK6TlYa2Kzo6ea2xLnWEb3FKYTBMztoWOx/rboefxA/TP2mPqiJyj3BZ85fEozFic3uaZ3PzhhOxum725HDgRnUYf70cGkWpTtVyIafyQgPQ==
Received: from DM6PR14MB3871.namprd14.prod.outlook.com (2603:10b6:5:1b6::20)
 by DS0PR14MB5787.namprd14.prod.outlook.com (2603:10b6:8:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 01:03:12 +0000
Received: from DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a24d:c80e:726f:9848]) by DM6PR14MB3871.namprd14.prod.outlook.com
 ([fe80::a24d:c80e:726f:9848%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 01:03:12 +0000
From: yo sang <stlfatboy@hotmail.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: data modified by second NRT write with same memory location
Thread-Topic: data modified by second NRT write with same memory location
Thread-Index:
 AQHZxFkf5jzl3P6vkEqeVqOzGMy4Jq/Vsr6AgAB/3MCAAFGRYIAAGagAgAALu7CAAAxEgIABDDEQ
Date: Thu, 3 Aug 2023 01:03:12 +0000
Message-ID:
 <DM6PR14MB38713771375803FD8C2FBF0FA308A@DM6PR14MB3871.namprd14.prod.outlook.com>
References:
 <DM6PR14MB3871876E6E078D3BE974ADCBA30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB387142813E6733B5C9DEFEE7A30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87pm46sm8y.fsf@xenomai.org>
 <DM6PR14MB38719B58539606FEA830CF9CA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB38714729ADDC7529E3268CCEA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87fs51evhn.fsf@xenomai.org>
 <DM6PR14MB3871735C1528F455A73383ABA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87bkfpes2u.fsf@xenomai.org>
In-Reply-To: <87bkfpes2u.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [uc+LiLLYsA5F6OAVwP6xDEZxODmX6cjF]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR14MB3871:EE_|DS0PR14MB5787:EE_
x-ms-office365-filtering-correlation-id: 6c942536-d6a0-4f05-bb0a-08db93bd6944
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZjpaSvy/x2FR0C8fPvVuJeZEpOtB2Cw9e3a5Jy0Ens8IICIuFFGHiKT5fGlmDOAjXeLiYRVBrfW4c35yogdkPChWH70x0bZY5cDByvqlPM+EYvlSZoAxokW56/1P2ekcP0pS8KcEKSBzlsQD5QizuadNcJVOvQD9vGIF9Ijhd8SLAF3JELQglC9xMT1o0bZ/xg5h6wD+v1bv6iKrmWQxuMkWMoGd1TKe66SWRFXmJyv3SxvhPo5F2d75K6mwe/pxTz8kvUHCnkDEkn75N650TvBX191nuE0Wd31wqKTOLSWYzvNWCV1upxWlQzzI0fLjISX5yGIJgwWHsA+56pGuIN9SFWM1JuWJKvu9Z7ShAYkPpJeYsc91fvVCWcrvuewC5c0p2yrBqK3pAel6wWN/opixLwhJEV+/WPokLp1YxUdQMqJQZBhraHoyOQV6hCvxIJb3VUWnNWNBkfA7OVxrbneQvLyDTcFYREaafiYF/w3TVxQ3azUA4MFF3CXAMI1y+LF29I91MPWgTIko+NLi5WXfexWRH6N2nkIfvE9O3jujmn1AtPEdaQWNHw3On350
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VATIx9EtEhdyUdj1sGUAzQEg9v4nKZyXrsTIoLjq5vu1LwH/Smqi/5YaYDqY?=
 =?us-ascii?Q?nca1DZG4cyDlO2RW8ywpibUJElDrUxHdLFUzmPAkmfXHb5zQ7yfGKJWkFKBd?=
 =?us-ascii?Q?9eQ6jnzBAno5P9wib3v/5Ypl3Lj9dR9fJhkxIGKApHRB50lFhDywEC2rmzuM?=
 =?us-ascii?Q?rlCSVM2TCMhkl9o8otcPcwOxQXP63BtiXjr1M38Qttme7cOZhUamHYCYUFE/?=
 =?us-ascii?Q?o/IpZHaEaQe6VclDlcV8lA7AMMzAEs+1guNGv1AYz8ytI/4qq9PyK4nKqEmK?=
 =?us-ascii?Q?ReBV3G0MjAJUOKC8p4A7k0rrSDZHq2/szYDjfFXOAV9LcoHJUWoNda5eJoxN?=
 =?us-ascii?Q?BX7IZQFtUQ7CMTdCRKv7k/UWtxxyNbVwcmu4hLfrBRsCDzNrXMuxwV3otViT?=
 =?us-ascii?Q?Yzl0K9FyC/YhkDF7nSJKiu8gE0dskaId2tBtAaT+gW6M5FDiP2eN+HeoqBgC?=
 =?us-ascii?Q?LXBjkkHm6FUWEtkgPyCChg4sAZtRfQbdcxSkUTVzEcPDpK6GuK23+oMEp6m/?=
 =?us-ascii?Q?d9kaguec66LpXLE/wTsCxXr02E/dVJM3KdfwAYhwRQJtT8ws6KS0ZQRrJNQt?=
 =?us-ascii?Q?y6WYHeYMWzxx9XpM1hVA8irifnMDiGmRgdDMqAQ4Okr9n9DYXKTz5cUmZHUm?=
 =?us-ascii?Q?fmT3gX7JKZLS9U1vnMxlTOonGhrF6BdZfYMQPXJLZJr+UXzPzpbQ43A8eohF?=
 =?us-ascii?Q?99B8NVwKA4H8LzLr/M0387Iu4WAE9psv+JzXsTwqMAIe4nl27OUvPhPa1lPo?=
 =?us-ascii?Q?wmrnHYQsLzDbBGTGj/DG1ZNtIt9fmLktPJiAOjlhYH8+9bAY37Q0NjdTKUAJ?=
 =?us-ascii?Q?y3mwjzG13KBr+aC86IL4+omYnrpbPqPxZgsea3p+yuEH7bqSmKKnvb07Kt28?=
 =?us-ascii?Q?DT63EbF+f5ZH6EGkvFQt9WI/VB8Idp66OihurCAXe1ThW0OrJ0DVRabgvr2e?=
 =?us-ascii?Q?MeI/jytd3AGK+sgUlS9NSqCPUU+v+rv9nBEgoModOIlOX3UDJ1TE0PsGO3NX?=
 =?us-ascii?Q?mTkRG8BtoePGq2LPRVtPxS42AEb+KiLowjOMWTKCLGJSqHvyqroXO8nSmxRh?=
 =?us-ascii?Q?UhfhEaILf6PqBntaUa1ChT19v5ZxBmihQeC1PnwLVONGNdXkL+P7a+HbwmzW?=
 =?us-ascii?Q?t3L9teJTYt9zRHawupZX15Gy83/R+0XaUt9Y7Zafpl1CNsgli46CeXt6vcf2?=
 =?us-ascii?Q?xtz0CB9hdC3iraruYGZdfuUytDFqZE51RkkRBA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c942536-d6a0-4f05-bb0a-08db93bd6944
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 01:03:12.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB5787

Thank you again for the detailed explanation, it really help.

It's my mistake for using private pointer for XDDP. ^-^

-----Original Message-----
From: Philippe Gerum <rpm@xenomai.org>=20
Sent: Wednesday, August 2, 2023 4:57 PM
To: yo sang <stlfatboy@hotmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: data modified by second NRT write with same memory location


yo sang <stlfatboy@hotmail.com> writes:

> Thanks for the reply.
>
> I still have several doubts:
> 1. it's very common to delete data right after calling write(). Data shou=
ld be completely copied to ensure a successful write() call.=20
>

Except that your code is simply not doing that. Please read it again. Hint:=
 this implementation introduces sharing by mean of a pointer.

> 2. The fd opened for nrt is blocking by default. If I'm using un-blocking=
 way of write(), it's reasonable to maintain several distinct RTMem instanc=
es at write end.
>

This is not the point in discussion. The issue is with the broken indirecti=
on the pointer adds.

> 3. If I modify the RTMem class as below, the result is correct then:
>
> class RTMem
> {
>  public:
>  	RTMem() {}
>
>  	RTMem(const char* data, int size, RTMemType type) {
>  		//Data =3D Buf;
>  		memcpy(Data, data, size);
>  		Size =3D size;
>  		Type =3D type;
>  	}
>
>  	int			Size{};
>  	RTMemType	Type{};
>  	//char*		Data{};=09
>  	char		Data[256]{};
>
>  };

Obviously it is, indeed.

--
Philippe.

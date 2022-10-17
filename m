Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594810F7
	for <xenomai@lists.linux.dev>; Mon, 17 Oct 2022 08:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665996235; x=1697532235;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0NJf6/Tkltm8f28G2so8y1KeStOOpXGFVKqBEEZ83gc=;
  b=Q9mzXMZgr3nzYiyUBrqmCrmakZV6u+83sLRKUxwsWSwvVQpwyXw0bwyO
   MZ6+alWGBexIPFpC9b1j2srdbzDKaF5W+gklCChdXrfyHhJR1j3LLNyxy
   DbV+XW0w8NV5MNiq55Ww593gf1Z+yiiG6huZkLrr/L3MDWdtasvbLx0hM
   7aq0qq0k1T39gi/qlKLcrgG9MDuWnG+DvAm/GTCBrgiFcOa7s6KT23bIk
   //v6cJR7JTRNqfmC9B6ZhOFatxVfDgcxsCX4E21N2ww2PcstnZau8QmJY
   UMpn3aA7ulukbqGXEY4fFH5g8dM1Ky1lWSZOehcoy4CchFwHnzg/dLJ0o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="285468652"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="285468652"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 01:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="628221057"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="628221057"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 17 Oct 2022 01:43:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 01:43:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 01:43:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 17 Oct 2022 01:43:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 17 Oct 2022 01:43:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPox4EWLmL2s178lDetxQ+jj7zfr9rqLt8t8BvX2DIeA9o6sTXfgBFAiZtCGYHRphRPWHmbssRaLeb+5WVaejV4M+UTKTFlEOfysg37z8VCpr+q9RC3fE0QqHniRykl1+qh+FhBLyrzwTsjKUhBglZdELYXVgE+oR3LYKliVldgxP2HI/wTvhL9RVb9P+5NcVm89Fp0UzqpsARhQWuJ0xG8+SxZvimZsJaHYYGlwYIcFTmU/cc1OyO1M13P/r+sjuLO3c30s6DoIzIpY0Ou2/65Oy7eyWvfA+b5qWSBmaACv5Q+I+Ie/PpojSFqWJAx01owJ8+un3cljHHpHcixrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4empmERQ9ugJ5U0L4K5vfOXxlylMyGQHbtrbSV0pK8=;
 b=E+xDA+AYQTdajGysG4eWL4jFQEW9xMQXBGPw/qLK/c3dFGIbyYgRjUA6JYp38A6MX5bA1i64weJN/ie3MQAif11WuruhhGPR+goj4WtiBD40g6fO+EGY/frA5XjHKAD3iV2Dhjd2RhgnG2H4/L9nwXUR2jPCojO4U+42r53MDhd6qZUaRPCtfcjyy8eNZyBFFAXaoTADiVDRJ06xfkz3RXLhvdXrVSTAn6Hkjwo0Ye8BqFN0CS54UA45Utovd+EziQziqtgsKoFa7dPJu+K5801NmgEn3/f39P2kO2caGCFGj9z2TUNrwpS47S1LDee6Ba0e3Zau4tXW8bJ1eF6vQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB4845.namprd11.prod.outlook.com (2603:10b6:a03:2d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 08:43:49 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::82e5:4be7:43ce:99c0%8]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 08:43:49 +0000
From: "Zhang, Qiang1" <qiang1.zhang@intel.com>
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "rpm@xenomai.org" <rpm@xenomai.org>
CC: "Wang, Rick Y" <rick.y.wang@intel.com>, "Chen, Hongzhan"
	<hongzhan.chen@intel.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Memory corruptions upon strcpy and similar when being interrupted
 by scheduler
Thread-Topic: Memory corruptions upon strcpy and similar when being
 interrupted by scheduler
Thread-Index: Adjfx7M3PckxyrdzSbOwkv1vwf5NfwCO5U9A
Date: Mon, 17 Oct 2022 08:43:49 +0000
Message-ID: <PH0PR11MB5880489EA92CEF39E1EED88BDA299@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <FR2P281MB2654CD4536C1F2D3592D874EFC249@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR2P281MB2654CD4536C1F2D3592D874EFC249@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SJ0PR11MB4845:EE_
x-ms-office365-filtering-correlation-id: 0bfd61de-6aa0-4614-2697-08dab01bb664
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KYJJuE7eD3cA705D0H2MXuvhNOmwqZ43kJziSvyyzRDmqdzcwxAijzE3GWiy52MhYZ/SJ8EGWcFY0x2EcUO5n75GMuicoDC+4mtpSfI0tj+MsU/cGFis7qfXzT6oolTYNib7uVv4cBb9xZFEyTddbuvre1cSBuJ6CD1g4ImD5CdtcAJ/XZzz1yzQSf+l0heBcnmVH8dx4YGa73jYiN+mWjxrOD/gV8iEcsvHMN3BtiN6zLBarKrVbbnZq6EQKWMrpQ+gw0ZHn53AzVDciK9yWqVBi34g3rRqlPVd1+OrqkGxdqzLYSjxG4hrDMCxm/AOiRcOVax7PDAJS1dYjazRFC3eE7wcXSFo1louhDhSyDfMhuHfS+v9R3AH/9VZRYLYYM+1QWsxRt9/ojWR6beIyeWInOGWpB6o+7EXuyQwjYqzPLRfqaoXq6ICKBI8E45dIOimdNbGA6BW9uiFOoOQr09JUAPUsKMRIiOn9qQPy9S6w4P99JdPUZpVnBEYTLE8vsSTauluKgjcjWDs41WvFPYfXisCbkkFxpyY02aMl/8DcvrhZAWLmuTkgmJpQIB31W0Zm0kdhcMteFCmRJE8TUpWubADGV7AwcRudF/Yn+cZsPhreXemOflAyJge4A7BiFrkDmDkQO0/9hZ2agtrkFqlu/kZSqnbWPXAgXcIyqjW1YHHRW4mNHfB3m1DgpSH5NpY583KrnovcLEp4RhAxrvn/LTubOCnBKQW07B5cujgxfhZqEobo2rie7EPG1t4g8TmlWiZZp5psldODSgjBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199015)(33656002)(86362001)(38100700002)(5660300002)(2906002)(82960400001)(122000001)(186003)(66574015)(83380400001)(38070700005)(53546011)(6506007)(7696005)(316002)(478600001)(26005)(9686003)(110136005)(71200400001)(54906003)(66946007)(66556008)(66476007)(66446008)(76116006)(55016003)(41300700001)(52536014)(4326008)(8936002)(64756008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fLHP63iW2C048bLFgJ4QURv378OY7t3I7b6T2WrTZ5f4XqrNOI/xFtedTm?=
 =?iso-8859-1?Q?GmdJQTnWQ+GyHTrU25gWjMWDQ6RsnVVuX5kQZE9Hc79P18hTgkldOP9k5q?=
 =?iso-8859-1?Q?cbPsBlwtEKJcSIWNld5K1oXcl6JGLbxc/fCj9a6qlR4gyXbCeyQzA4R7Ex?=
 =?iso-8859-1?Q?rnouzNuo9O4JJ3Syq14VMn3YZA/Sy4XSLVsNDnW3LuK2uMHcSLuO1SOYRE?=
 =?iso-8859-1?Q?rYQbwAv2F3EgZbyVEmd0kluOBNb5W1DhA1AJRt+kSPcU4S96MtjPdHAoUO?=
 =?iso-8859-1?Q?5et6sVBUVM6J0tUyUb7f7EXlOLu8lpyTupajjPvhrSmFP/8aAtZDPUe++U?=
 =?iso-8859-1?Q?NyNUD8r9qyYUJga+y7TYW2O13RySoAUsreNWDVF+ggv63mOXU5gzgk8bP1?=
 =?iso-8859-1?Q?YesYE+a+rMJx7FCljKgWJCzTTECYzq+oGTsXo2BMmRaFy2lyZUkbxo+HSv?=
 =?iso-8859-1?Q?mu9Tmjv1E+x4358Yy7lZLxF51gzoZtkvI8IQzeZWRyOfuhreAU8l2gB7vD?=
 =?iso-8859-1?Q?VJ9CdDZURYQknapGUxH053iCj8KNW+eXvOmp1l38mz2DgSXjfAjtmhW13m?=
 =?iso-8859-1?Q?MSbtOpgT2QMYUTytbFvul8SeV4yuT9s4aKWiK6gbZbkiXI2TF7WPUw8VGu?=
 =?iso-8859-1?Q?21bmPw/7n6oBuSMJpcBr7E3weLBTLkLbhKxeASVK4BuAOWDUij8ThR0l6c?=
 =?iso-8859-1?Q?ZkwXR92JFT8oOr1xJWLZ5Nsd9r1RPAMDrXbidqP5Na/y9zjpk94I4DYTZw?=
 =?iso-8859-1?Q?Fsq9pJuOg9th+zN6ikOuiFgvVPxn7i8cJEcToEVBe6ls63QRU9zPlO7WZK?=
 =?iso-8859-1?Q?gcGzH6h8Ck8EfwcxX08ANdiCcXoWxPI6YoFVcj4VDe/TT6gOMBNJd6lSpx?=
 =?iso-8859-1?Q?yR4QwehbSeyb0XdxvlGPMmTrLQjd2pEX2QkCR2vfV5RAawgj3bU8kHpo1j?=
 =?iso-8859-1?Q?kQbxsBhofUOtLqfKjimrZLppG8NGah0RnuZ5qaEeCNDwNHgeAu0xAzYAFU?=
 =?iso-8859-1?Q?idEJ280a6b5pIhf5QbkZ45+GOZ/i74/eJfuxk2VfBHu8/0CzJVlf9td4n/?=
 =?iso-8859-1?Q?wAu38LWT33Cqo3zABEuU2YfG3IRbAJBKPhdYy/BMsmcn91vpcBw+pV4v9C?=
 =?iso-8859-1?Q?1zCiyLSzblV08erxrfdTe6Kn3FZSQoLipD1ih5CXjyh/xBgOYfbT58y5eu?=
 =?iso-8859-1?Q?nboDxdR2akuiqqDMquf2YuaI90wYqXDE1ekiENyttap20vXfvg7m+BlfhN?=
 =?iso-8859-1?Q?2XoeKyNEnpFa30sM5xYkHscj25QLZI48hjTB6L3wvH2wczQmqdpBxSQT0a?=
 =?iso-8859-1?Q?FDs3GD6UnM9xtb4OP7fYymCEU5d1PjwZV78zuiA/jk1N5ErrV9QNRwcxLg?=
 =?iso-8859-1?Q?rfxQO19pbpvhxYYwV0RQyUKtcZs5bS2ZilCBprHG1yZIzF6ltgVXGl0BTF?=
 =?iso-8859-1?Q?kkXCcRjMyA2npf+Kf3ARj4BEflyqL2tG6PluWOxa3JuW/4gTlMlzWd+7WD?=
 =?iso-8859-1?Q?3vtx5A+wWylh5HhFi6x1wFdEpHp0PG0hMkyy/E1+f6nWOClnGZEkX8+MYL?=
 =?iso-8859-1?Q?BNLbhYwSmI0ArfQmymawUIXbfp+il96VVMOD5K5PUYi1PcorqIZX3PnBB7?=
 =?iso-8859-1?Q?YRGSkNN3P9jBz+5UQ/AsYE2qmlmysj6qkc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfd61de-6aa0-4614-2697-08dab01bb664
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 08:43:49.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X1W0ksFAsaSU3G1dCZYdsYZQi5MSKEb68J5LvxfshiKULAbbVHZo3AJoGT3BK/qCjVAQ4hTaKFgwlFdSaRm0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4845
X-OriginatorOrg: intel.com

Hi Stefan

I also use xenomai-v3.2 and linux-v5.10.y-dovetail to test it.=20
This problem does not trigger whether we use memcpy or strcpy=20
(not need to change txr19391test  code).

It seems likely that the problem is related to i-pipe.

Thanks
Zqiang




-----Original Message-----
From: Heber, Stefan <Stefan.Heber@zwickroell.com>=20
Sent: Friday, October 14, 2022 8:49 PM
To: Zhang, Qiang1 <qiang1.zhang@intel.com>; xenomai@lists.linux.dev; Kiszka=
, Jan <jan.kiszka@siemens.com>; rpm@xenomai.org
Cc: Wang, Rick Y <rick.y.wang@intel.com>; Chen, Hongzhan <hongzhan.chen@int=
el.com>
Subject: RE: Memory corruptions upon strcpy and similar when being interrup=
ted by scheduler

Hi Zqiang,

We' re glad to hear that someone else can reproduce our problem.
The problem disappears with your modification (move simple_allocator_init()=
 after pthread_setschedparam()) on our system, too.

We don't understand why this modification helps. Maybe we do when someone f=
ound the root cause.

Thanks
Stefan


-----Urspr=FCngliche Nachricht-----
Von: Zhang, Qiang1 <qiang1.zhang@intel.com>=20
Gesendet: Freitag, 14. Oktober 2022 11:28
An: Heber, Stefan <Stefan.Heber@zwickroell.com>; xenomai@lists.linux.dev; K=
iszka, Jan <jan.kiszka@siemens.com>; rpm@xenomai.org
Cc: Wang, Rick Y <rick.y.wang@intel.com>; Chen, Hongzhan <hongzhan.chen@int=
el.com>
Betreff: RE: Memory corruptions upon strcpy and similar when being interrup=
ted by scheduler


-----Original Message-----
From: Heber, Stefan <Stefan.Heber@zwickroell.com>=20
Sent: Friday, September 30, 2022 7:47 PM
To: xenomai@lists.linux.dev
Subject: Memory corruptions upon strcpy and similar when being interrupted =
by scheduler

Dear list,

we, as long time Xenomai users now have a severe problem. We are currently
in the process of migrating our huge application from xenomai 2.6.4 32bit=20
to 3.2.2 64bit (linux 5.4.105). In general we are almost done, but one=20
problem remains: Obviously we have memory corruptions resulting from=20
strcpy functions (transferring large configurations) being interrupted by=20
high prio tasks.

We now nailed this problem down in two minimal test applications in order=20
to rule out any programming errors in our own sources. These two=20
applications are:=09
a) a simple test that swaps two very large strings forth and back via=20
strcpy (and alternatively other copy implementations) and then check the=20
string contents. This simply happens on the main thread.
b) a "sleepproc" app that simply contains a while/nanosleep loop that=20
wakes up every 500ms just in order to interrupt app a).





Hi Heber, Stefan

I tested according to the steps a), b) you described, and I also can reprod=
uce this problem.

(xenomai-v3.2.1,  linux-5.4.105, ipipe-core-5.4.105-x86-4.patch)
The test method used is as follows:
after launching  txr19391sleepproc, run test.sh
copy methods: memcpy

#!/bin/bash

for host in {1..20000}
do
        ./txr19391test
done

# ./test.sh
ok
ok
ok
ok
error at position 40473600 of string S1: expected 98, actual: -56

but after I made changes to the code

about  txr19391test.c:
I only move simple_allocator_init() after pthread_setschedparam()

use test.sh to test it, this problem cannot reproduce.
But I haven't found the root cause yet,  You can test it according to my mo=
dification to
see if it can be reproduced.
Maybe Jan and Philippe  will have some ideas.

Thanks
Zqiang





When running the test app while sleepproc is running we see sporadically=20
errors (typically less than 20 runs of test until we see that error).=20
Without the sleepproc app, test runs without errors. And don't worry=20
about this magic txr19391 prefix, it is just an issue number ;-)

So, could you please help us and have a look into this problem?

Some remarks:
- The test seems to be highly sensitive concerning timing. So we had to=20
fine-tune a lot to see the error in this minimal test. Also it seems that=20
even the CPU may influence performance enough to make the error=20
disappear. Another weird thing is, that if we let the sleepproc sleep=20
100ms rather than 500ms the error disappears.
- In the test we can either work with individual mallocs for the needed=20
3 string buffers or with one large malloc and specific "pool allocations"=20
from that large pool buffer. We can see the error only, if we use the=20
pool approach (see the two options in the code switchable by commenting/
discommenting).
- We tested 5 different copy methods: strcpy, memcpy, two types of while=20
loops, one for-loop. We can only see the error with strcpy, memcpy and=20
for-loop. (also here: see the options in the code). Maybe that depends on=20
timing, maybe it depends on the implementation ... we don't know.

CPUs we tested on (all with more or less the same kernel config):=20
- Intel(R) Core(TM) i5-8400H CPU @ 2.50GHz, 4 cores
- Intel(R) Core(TM) i7-7820EQ CPU @ 3.00GHz, 4 cores
- Intel(R) Core(TM) i7-4700EQ CPU @ 2.40GHz, 4 cores
- Intel(R) Atom(TM) CPU D525 @ 1.80GHz, 2 cores ... here we couldn't tune=20
  it such that the error appears

So, thanks in advance and, btw, thanks a lot for your excellent work=20
during the last >15 years!

Best regards
Stefan


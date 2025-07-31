Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBC19DF62
	for <xenomai@lists.linux.dev>; Thu, 31 Jul 2025 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999831; cv=fail; b=Sar1mn9EZAsTFV6izE1uHA49NgVU/3+XnaJcZ20/RJaXa8PIIbzTlIgryekHNW5TZQ17WgRPQeBZtoEDKJtRno/7jigV7xwId0l+MrmmtQ4XiTAnal8Pt9LB4J0KxWocnXjuzSODhZPP7cFV+/2SDs2VTeb1IvaDUehklm3umLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999831; c=relaxed/simple;
	bh=7PWroD32FmbbD2c+Dj9F7/fRLENOUed4tucinMpL+Ps=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LQyNwJBm2nCvT7ptiS4cAJSUe5mLskZ3g+MGPopiEySKwmK0PQs9z24wQwwyUOwIwHR6o2q08H8TkG4JOxYrfv5Pns5Yn8zLxL9QwOa396y6V3FK7/6FGQw7FcrUupndxwYofxxcwN9l9mh56L7MrVxga5TqIsmkUcmen+xCEFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com; spf=pass smtp.mailfrom=festo.com; dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b=sbOG5pQd; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=festo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=festo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=festo.com header.i=@festo.com header.b="sbOG5pQd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uayFSORIxyjaTTV+teR0rqamJfnaf1agaNgrRsJnND1ujN4oNUWeAvvM71tYI7htJ3UOHda83CZhxiUINxH49CK8G4Xtzuhzxm11hh4iNJMnQsRpNCYrfUYsn8+i/x3SvJU1HEmBvzLq3016oQdAefCFpFhMxM7DQvCiRo7tFffd3hbLmhIR4UYvd1qw8cLwLAv8Ihil3vn15eJKOzlWJtHl7447TE45vp0PqW343Qfs1U3T+Gy4bEVhK1FEtwSzOHaW2NlhSp4s7dqnswwRzcrsr73Kj7Nfk+hqeuopkN5EXyckz6QeMvTPWIaDe16R20HR4QsDALYvhapukQdQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnSHJbVnc9+jFQyQFaAIcK9p4F1QrcdJ6qlTc2wWj8s=;
 b=gTjc3F32rc97bWn228xWWZRbzQuT81DK0hugJysvdGoVW+59dOI3T2j2J/3ODpq3Uwy+/N75Ke//ImFJjGvDeWzLLh/6Ym5ADgZghukucxuWhn0xkip2v8QDZ2OALYNYVTDpuIvmERd6dpNezBASn/J2AYOmBA3qU6NHiEU458DEf8FteXrZWtgFDbI2ptoyl7V3ADr+oqfTHkYSXxSn8I4N0VlM6ArlZ7iSnIqcy5WHUfsIo3QOMROCnffnGYuVKwmQxIT4O3Z25s5AlIf4munAv31Ws7+wZzts6wDzyQ7pyFJrfrDP0IdNWOcah1duddJXnEcGzW8KyqiZs7Xjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=festo.com; dmarc=pass action=none header.from=festo.com;
 dkim=pass header.d=festo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=festo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnSHJbVnc9+jFQyQFaAIcK9p4F1QrcdJ6qlTc2wWj8s=;
 b=sbOG5pQdr7CQPfflF6Mjp1jKfRSXw1Iqv029Q/gtPJtRBsDNuG4Z1oZ9wB0oJ1OeBbmpAfq/FV9xUEMG6Q0m3u8Q3PYseuRuxdv5Q4JB12HvjCdHpMiAWFXzcy75PRYssjxZ78WWZzwd1upd4eqCCbAw+vt+NuLNiIudigYEZNM=
Received: from AM5PR03MB2882.eurprd03.prod.outlook.com (2603:10a6:206:18::24)
 by GVXPR03MB10247.eurprd03.prod.outlook.com (2603:10a6:150:15c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Thu, 31 Jul
 2025 22:10:22 +0000
Received: from AM5PR03MB2882.eurprd03.prod.outlook.com
 ([fe80::b0f0:d40a:9a12:ba47]) by AM5PR03MB2882.eurprd03.prod.outlook.com
 ([fe80::b0f0:d40a:9a12:ba47%4]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 22:10:22 +0000
From: "Xie, Nick" <nick.xie@festo.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Error during libevl build and runtime settings failed
Thread-Topic: Error during libevl build and runtime settings failed
Thread-Index: AdvhNCsPSr13v8uwQHKA1c0dN9vzhQhJ1t/wAAMSmAA=
Date: Thu, 31 Jul 2025 22:10:22 +0000
Message-ID:
 <AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
References:
 <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
 <AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
In-Reply-To:
 <AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ActionId=8430b061-1df4-4c35-be9f-8402972fc047;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_ContentBits=0;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Enabled=true;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Method=Standard;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_Name=Internal;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SetDate=2025-06-19T16:04:28Z;MSIP_Label_9c86c25f-31f1-46f7-b4f9-3c53b1ed0b07_SiteId=a1ae89fb-21b9-40bf-9d82-a10ae85a2407;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=festo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR03MB2882:EE_|GVXPR03MB10247:EE_
x-ms-office365-filtering-correlation-id: f8a05127-30d5-492c-291d-08ddd07f0b6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QVQNCuvBGVRC6/hdDe/MeucMtAdoiaSXM/O+wZZ5LbfIeRbuQMqbKJ2Ef1Ib?=
 =?us-ascii?Q?enZzlHDGOMsZEcYN/qULH0KHV8tkCMX7sgXs0Pc/LXHfvwrMITm/N5hpcPcN?=
 =?us-ascii?Q?xAvwInKmVqhEYHc5fWqzm7WzrkEU8ycTYQ3waW6DM1IbUhGb1bQWWlRnwXNG?=
 =?us-ascii?Q?4d62SJglybryVVqWEwqKVAi7VVFBxtMfkcVfx5CtX36pjeuD8+x/CQ/hfSNg?=
 =?us-ascii?Q?0EQozyRyKj/hJ25U6KcmLhmoKILB/c8XJoUJQHYVDgdRatHc9saHCgcFKi+c?=
 =?us-ascii?Q?u2yq8qfwFWwtxxJks/QYN5maXo7fwx44uVZzzFXKk8/GGPvdma+paIHDJnXV?=
 =?us-ascii?Q?C/rkyvDWhlAn/2L5tyt7YmKEeM5ufLgzqUyOpUU+zW/v/AiOn5HCvXx7KoQM?=
 =?us-ascii?Q?4KIlFJgqbajaljaelMxu8VBXizr/4v2bUfScBmRScsvWm+X3xii9S24LlnzV?=
 =?us-ascii?Q?XkwBHWaIYr7dDop8ZielH+dNMs6AHCDnOQMDTB7IIJePVklrg4Jv8x1ZLK7L?=
 =?us-ascii?Q?8AG3IfLmr50zo/ctRGrny8s43TOTTvl/b1/d0qePIU4QDYcmH9E7exGvJq+V?=
 =?us-ascii?Q?ontly5/7EBLZXqs1yk/d6EUlq815w+aKaTkPmiTyCkr5u2kxqZ0USMZ4ODWH?=
 =?us-ascii?Q?39KhZg5/MkLaT8f5OXfJAIE92xTfFVfA079dkd9eCvj95j9oKrS+ryn6han6?=
 =?us-ascii?Q?zeDNMpHjHxhNwoM3kR3WboK3qNa/2NIGnthAe5zdDbL3hppUSYlz8OvtU880?=
 =?us-ascii?Q?EDn3JNdiaV3CXQQGyvdJbAs0smtE708M7cCH6Ioq/TpdThPv/yhfhz5yyAW3?=
 =?us-ascii?Q?j+xL3SOeZL+4Kvh6xAgHLX83m2zLMUDtKyZuo4QMrxRpuEbJh9JwFH+3I6d0?=
 =?us-ascii?Q?3G4dacETOsYaq3bIAAb5EAKR13een7jHsrRoL6eyp84CAdiIqym3MRWzQiGs?=
 =?us-ascii?Q?YrZyeVNzZQX3ihEHCo8pYVk8LLDxvsev7s/+OEagGseb1+2M/Mi2W9xouDqv?=
 =?us-ascii?Q?lyDPZ1fepPeipxD15mFEWDPp1OXpQoJAr4ugRb1Vykt1OIxg8f+ZYhY2vP7N?=
 =?us-ascii?Q?AIHxnWk/1+HsPHO3nPercbvgsF6ZztKfJdY+bJaCuTZeIiq6XoVi9xz3Fvc5?=
 =?us-ascii?Q?K6cP/gnNy0xnxT5tfXX3ZQGxPqCUdJeXW6JozvbQz1p1fHWwlQ+bcHhFBt7u?=
 =?us-ascii?Q?xiDZo45cO2k5pFGE288NQ4d2hEibEDPHHNyDRrepdXbAvyGUDUgx7hly7r57?=
 =?us-ascii?Q?+J2bbK27kerQipr3hV2z4xxaSKzdj+UopGx5Qfq4dwwir/mQ2EkKWcIDr2+r?=
 =?us-ascii?Q?2BcJgRKQz6KxDqX55MhsG+78X8yEMRmKBx3n1r9XhMEcv1aIvbyMTyYjLF8V?=
 =?us-ascii?Q?sizt4/nRZEoGXHsrT36Y1VoQsIss5zMPxsBWE0joUR2TeqttVZJ8B9BHgfEx?=
 =?us-ascii?Q?9LDm6bQqoGAwkEcR51MD6GLo59JO4c4ZZ6B7rJMdV8vhYwrNWFMY7w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR03MB2882.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tU+1BZP11mC1VKKtufsQ3rcIxzsIkhN2KhQOxoPFD336T9W+vN1PeSpx2SUQ?=
 =?us-ascii?Q?lZBWTdjquS6HyqgiBiyIQZ+3hwr64W0+LEOCjwhC14Vl6bpMP/JXxgRehK1f?=
 =?us-ascii?Q?NtSGi8J++AHn7Ryof9ixleaMOLFKwnOqVDw/1xy4jjdsCEyjCPdafdKV2bcm?=
 =?us-ascii?Q?gMY+dqG3GC/AgNTS9prDcju2S1QiffHmLB3ZeuZw2qHgYxALGrwOkrg0cFS+?=
 =?us-ascii?Q?G29PgExOeV5tmXPA60SZNsc1VwDMB3chSs2m0BtfZ4JW5ItGbW4v+LIZQoZA?=
 =?us-ascii?Q?N3NLiYoBEdPXHpRDMlUf5R9883s2LPhYCEJJAiAn+XWQxG9bnLYafLY9HuvE?=
 =?us-ascii?Q?M9izEat/Vh5xHlvD1gwBraeo/p5GmWpCwp+e97sUr8GH0kyGM3Hp8pP9eC9v?=
 =?us-ascii?Q?WiwQHF8Ggb8h/1VvMpUTTglAVTUoZl23GIAKXuo62j5LnwZpSPYMG/2yo1TT?=
 =?us-ascii?Q?+/+OfAJhFG8iQUEnremkfG2CnCJ1XD9zruN0Qp0OGy8htCK+uklkZkjicDuw?=
 =?us-ascii?Q?MZ/5vFYrDkKvUmfwB41cquhtXTT/OFrFPkJKFFkMsVUYfVuhBQGN4QC+40UD?=
 =?us-ascii?Q?aUiOlhRA+kMahXbTsCGv0qaeKbg3B5pEFXwDDgUhYT97orxGlnpYiYpnD2yI?=
 =?us-ascii?Q?0qO7HdEpMlM1+L9A2h/62lsZH7OuZOIt+y7pTo4qjlBVND8SRyclW7/zER6C?=
 =?us-ascii?Q?ir6HsyWI3N5mSbdR7qPjrKfW2HyJzak7IU8U1O9qAsvLGz/XrT1YyNG1YElo?=
 =?us-ascii?Q?zSmnbrA5DQhjpE2KDB+czldfkMlegFJVG8qD5e1KFoNBbAhTVwvY3BhACrAA?=
 =?us-ascii?Q?JvB12SqIz+/jZEbP3Tx/tySx7kBtKgVNCzNWJd7jWHgLkopqeyNWgrVxqNo8?=
 =?us-ascii?Q?Pm3FQatmtkdlWfbrGQm+Jdvzbc37Mt0HjKAVM2Tay5H0kL4solmycA1AuIfp?=
 =?us-ascii?Q?LMFun1Xd2zVxkkqkgx+8B5IRr3a75S/fbfo4cqZLK7BFJqjLGMjZ1Q126TYG?=
 =?us-ascii?Q?ZqvU8O8HUM/2VV6OTkqftRpF2vY9fbViHAoPolK2n01urNUqh09v0lDO/Ovl?=
 =?us-ascii?Q?03Zbi/3kB48BtOAU8XL2RPJVw6o7atAX5qf8+WQVc34oAeQJqlp1Pc+7dKW4?=
 =?us-ascii?Q?Zvy5PrJcbEF9f7dw0UCk6mbYX5MpK8noHTVOp0Yuf6gr2lqXMNzcWv+aHlvq?=
 =?us-ascii?Q?Aa+4hFf0he8Zq/tY4SnyI19VeeUPsntWTJhJrR4ygEHxR698Sblaw431JgPZ?=
 =?us-ascii?Q?munYBWt5126GjAMeYx7KKLKcOVm3eoAFqdh08n9iYz5j7YLYlSyUFN051Td2?=
 =?us-ascii?Q?szBaArbKccpfhQo0KairoIsDdLAjye4ss9VFuKY3lHKZ1wAfWF6qyC+wiOR2?=
 =?us-ascii?Q?7LYkScA7JgWpNAGGMFaA28RClesejtuMTE6EYeGKpogqxnJE1951KLBWutNI?=
 =?us-ascii?Q?zxUq/HW4+F9AZjLHN0iyCAhiXSL+kGLGwriH9QhjF4tae0O0qUHiEknnXUiQ?=
 =?us-ascii?Q?pvMEj8rkJqGBxugMsG2YhfFXXB6n+4NAgeNJMN8q27t6BgfcDLa5PD1clAx6?=
 =?us-ascii?Q?zxwhs2qMk6ktpIh/lwg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: festo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR03MB2882.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a05127-30d5-492c-291d-08ddd07f0b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 22:10:22.7035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a1ae89fb-21b9-40bf-9d82-a10ae85a2407
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/ckTypiSmU+LMvqRvy9Wg5PcTfQXwc+lrwbHKIAhIEgxzIJnziv6isLbQMIzYIVUPEtOYyKxRfK63WLitwkFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10247

Dear developers,

I am building EVL for my application. I came across some errors. Please see=
 below.
Am=20
1.	The EVL building was completed, but meson compile failed
nick@nicklinux:~/libevl_build$ meson compile
INFO: autodetecting backend as ninja
INFO: calculating backend command to run: /usr/bin/ninja [11/222] Compiling=
 C object lib/libevl.so.5.0.0.p/net.c.o
FAILED: lib/libevl.so.5.0.0.p/net.c.o
cc -Ilib/libevl.so.5.0.0.p -Ilib -I../libevl/lib -Iinclude -I../libevl/incl=
ude -I../libevl/lib/arch/x86/include -fdiagnostics-color=3Dalways -D_FILE_O=
FFSET_BITS=3D64 -Wall -Winvalid-pch -Wextra -Wpedantic -Werror -std=3Dgnu11=
 -O2 -g -pipe -Wstrict-aliasing -Wno-unused-parameter -Wno-pedantic -D_GNU_=
SOURCE -U_FORTIFY_SOURCE -Wshadow=3Dlocal -Wstrict-prototypes -Wmissing-pro=
totypes -fPIC -pthread '-DLIBVERSION=3D"0.51"' -MD -MQ lib/libevl.so.5.0.0.=
p/net.c.o -MF lib/libevl.so.5.0.0.p/net.c.o.d -o lib/libevl.so.5.0.0.p/net.=
c.o -c ../libevl/lib/net.c
../libevl/lib/net.c: In function 'evl_net_solicit':
../libevl/lib/net.c:48:24: error: incompatible types when assigning to type=
 'struct __kernel_sockaddr_storage' from type 'struct sockaddr'
   48 |         solicit.addr =3D *peer;
      |                        ^
[16/222] Compiling C object lib/libevl.so.5.0.0.p/heap.c.o
ninja: build stopped: subcommand failed.

I changed "solicit.addr" =3D *peer" to "memcpy(&solicit.addr, peer, sizeof(=
*peer))". The EVL and libevl build completed. Am I doing the right thing th=
ere?=20
2.	Runtime settings failed
nick@nicklinux:~$ sudo latmus -t
=3D=3D latmus is now tuning the core timer, period=3D1000 microseconds (may=
 take a while) irq gravity...latmus: tuning setup failed (irq): Invalid arg=
ument nick@nicklinux:~$ sudo /usr/local/libexec/evl/evl-start no EVL core i=
n kernel
               but evl test passed. Please see below.=20
nick@nicklinux:~$ sudo evl test
basic-xbuf: OK
clock-timer-periodic: OK
clone-fork-exec: OK
detach-self: OK
duplicate-element: OK
element-visibility: OK
fault: OK
fpu-preload: OK
fpu-stress: OK
heap-torture: OK
hectic: OK
mapfd: OK
monitor-deadlock: OK
monitor-deboost-stress: OK
monitor-event: OK
monitor-event-targeted: OK
monitor-event-untrack: OK
monitor-flags: OK
monitor-flags-broadcast: OK
monitor-flags-inband: OK
monitor-pi: OK
monitor-pi-deadlock: OK
monitor-pi-deboost: OK
monitor-pi-stress: OK
monitor-pp-dynamic: OK
monitor-pp-lazy: OK
monitor-pp-lower: OK
monitor-pp-nested: OK
monitor-pp-pi: OK
monitor-pp-raise: OK
monitor-pp-tryenter: OK
monitor-pp-weak: OK
monitor-recursive: OK
monitor-steal: OK
monitor-trylock: OK
monitor-wait-multiple: OK
monitor-wait-requeue: OK
observable-hm: OK
observable-inband: OK
observable-onchange: OK
observable-oob: OK
observable-race: OK
observable-thread: OK
observable-unicast: OK
poll-close: OK
poll-flags: OK
poll-many: OK
poll-multiple: OK
poll-nested: OK
poll-observable-inband: OK
poll-observable-oob: OK
poll-sem: OK
poll-xbuf: OK
proxy-echo: OK
proxy-eventfd: OK
proxy-pipe: OK
proxy-poll: OK
ring-spray: OK
rwlock-read: OK
rwlock-write: OK
../libevl/tests/sched-quota-accuracy.c:213: FAILED: evl_control_sched(44, &=
p, &q, test_cpu) (=3DOperation not supported)
sched-quota-accuracy: no kernel support
../libevl/tests/sched-tp-accuracy.c:222: FAILED: evl_control_sched(45, p, (=
(void *)0), test_cpu) (=3DOperation not supported)
sched-tp-accuracy: no kernel support
../libevl/tests/sched-tp-overrun.c:220: FAILED: evl_control_sched(45, p, ((=
void *)0), test_cpu) (=3DOperation not supported)
sched-tp-overrun: no kernel support
sem-close-unblock: OK
sem-flush: OK
sem-timedwait: OK
sem-wait: OK
simple-clone: OK
stax-lock: OK
stax-warn: OK
thread-mode-bits: OK
I am not sure how the installation goes. Please advise. Thank you in advanc=
e.
Best Regards,
Nick Xie

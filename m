Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2D8495
	for <xenomai@lists.linux.dev>; Mon, 14 Nov 2022 22:42:42 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEMQj6L004086;
	Mon, 14 Nov 2022 14:42:36 -0800
Received: from usg02-bn3-obe.outbound.protection.office365.us (mail-bn3usg02lp0150.outbound.protection.office365.us [23.103.199.150])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3ktbhfthet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Nov 2022 14:42:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=BifoXNBju/3/FPCkmS9Og6rjHKlMc2FaDQ5r91hpW2DDisgVC6r/kxGwS+CbZhaKrO2oqnw/OVQcs65qQ4lO/hW6EgFkSNHbQgwt/TNZirY22Vul+t351A9GSH4ArJNk0hfLrueqcQyHrp9jx7nYqBR1Mk4V/VHkSWK+oJWbwSR7asJmFPZA/80SzS730oCHhiqRejKLR/Y7T25TKHQ1hW2ie5eAILF2Qk4jey9b259fMhfbXS51iuUgHMLgYy7q1W3fjg4sKMFGASgHPTmAa7ljTR+zg/T8PoHVoynvQ92XQgiEn2e9X6+gnteU8ORzZ8TOT8CAg3vj9hGfddr4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTb8sHFFOLweOenE058sMpnXwx2lgVV/2N0575C4Kts=;
 b=naavCSZGZvXmdmiG3M5ytI1seA62B89pdFvAVeF+B92xlewEh1K06k92Eg7tXBZKOplLYNgPBNhCaSTqJ3SgEda2UqMD6PmX4HfxlpYimteAdZJeGQy7XEWdsaYO5RjjmFAP4w94FVPGx+Ctz3HPD3KUHONDxTUEK94BvpzehxnblQuV+v39E4SixOLerkmX9Wic2TgErNOr8NaUrrSlyrBzvAYKWqjYjlWJcbxImU8UcOmGy3bUaHbef+VDctex/qdHssYJBzIh41nm4L7kZcHP5OebNuAwPlbABtxYejLfTzp6j/QBcMXZHVFLsIcJdTjctUQl46RrLJNivQrypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTb8sHFFOLweOenE058sMpnXwx2lgVV/2N0575C4Kts=;
 b=M2Qm2xNC7mkoSwi4ir0jtlbot/mUv7i5YlebJ8l0/UuHQnQ48mUptD/8JvZ59LwPCRUAjUdIGMjdqCjTV1hHMgiO/4wcq5Jq3yB4tI90IYLbmFHld5/6M+2CeJYMYzq1Cvh27odvLzq6G+xLF5r3H5SzYCnFTj4q/qCnuR1TbH502BteQQfQDp1RI2xAMRrC2bTWHA2yKZ5GjvIX4OJK8eshzkAOuVP8jRSg37OvmQAcmK0V64iJQQ6AI4j6TMWtvtRScgWDArwtsVIKiO0pKyT7r1fZeBu72/foB1Xc7VKB/C7Axxmn1Te2pZGhRgukLxnT4VD7xc/0fe3Y0PEedA==
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::15)
 by PH1P110MB1330.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 22:42:33 +0000
Received: from PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725]) by PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
 ([fe80::2dc2:8d63:5c5b:f725%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 22:42:33 +0000
From: Russell Johnson <russell.johnson@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Bryan Butler
	<Bryan.Butler@kratosdefense.com>,
        Shawn McManus
	<shawn.mcmanus@kratosdefense.com>
Subject: RE: [External] - Re: EVL Memory
Thread-Topic: [External] - Re: EVL Memory
Thread-Index: 
 Adjz0yff24VAOdNORJO8c3TjB/9lSwAgymPQAAE3ZMAAARoBAABtP6rQAH6X0oAAFuqKwA==
Date: Mon, 14 Nov 2022 22:42:33 +0000
Message-ID: 
 <PH1P110MB105002FA12DD4C10060A7B59E2059@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
References: 
 <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877d04dm52.fsf@xenomai.org>
 <PH1P110MB1050221E0BC34BD641127901E2009@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87leodn9kv.fsf@xenomai.org>
In-Reply-To: <87leodn9kv.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1050:EE_|PH1P110MB1330:EE_
x-ms-office365-filtering-correlation-id: 820ce6d9-6590-49b5-c112-08dac6918505
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 m7k7tQqHqzcLhKF7s9qxETrllAvh6DyNuo5q50zSLN1P1EFuRX29hZzVctubMzsO+SQwQ2gWertoQGy0uu6k2sl23qBcI4vyt0xJbjPevjZpNIipLKBblH7tF69p2JNHG8Sht09m+qfkvG/ms6XiKgcbXjV0Hex+EYR7M3SxBTiLiYTMY5se+hhX7owYFU3q+pfznuIe9UY4CkcpWG+8hJ1DSGEzLGI1ZEEWEcVpJCQ09N7QTpJ+lVjnvO8azATg4g2P2JTvg7cQBjyiuCMBo9RizT/gfSEc8i8nAUlRrr0mh1teDdC00/5DudGBJVj9jCOoz93P3vsPuRob7eoyvL5cvmnsa1w25VKImBViDWJDqEVPLyNXjpxkCnfQv8zzqNBVJtmTRtuomhzu2abm8yaTYKeeHgJVWeMKOcDLfsNlFTWreBtIxsgH15t9l/Fb8nDeA27wn+8TrX4fOfRfmN+QKzmS7FxC9SAdwLmQ4VMxkv0gmad3C86TiejtsCZE/0kkbjvcMk6pIqdFppCpTeupvhgdJupkw7IuPjwsWUzjqLLdbGXY7Nl486IrtUS+5qtcxsvFHsxBWfKICML79n9jAUkCm8yHAtz1YlFAzqjh0+a8X/levPslJkfUHkaAuY0f1Vqc0gf01045ao0kmaOn1LO9I/jJRzcOaeLOYD/m0qTTpQyR8LGgfCptKtdY
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(451199015)(71200400001)(2906002)(107886003)(55016003)(38070700005)(99936003)(86362001)(122000001)(498600001)(186003)(38100700002)(44832011)(8936002)(33656002)(26005)(64756008)(52536014)(558084003)(6506007)(7696005)(5660300002)(54906003)(9686003)(66556008)(66946007)(6916009)(8676002)(76116006)(66446008)(66476007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 rj+iTNrIVNjNLNbbbCmAWbglqnobBikkXe0Ac9hbfwGhHuapgOnygA/qTQFpNNIVa2RmttaxJZDjhZ4LIbS1/N226KQ81hZpIa8/ULob62vAJRQp+qmqQsxeeyFjR9DY+AM10e6ODC7mLYlvD1vmv7mQQ282Uuh4UaNO/rySKQ/zxP5Q9zVXsnEOIHSCKe6lXOErasRzrLHM99kVRN1PMraS2s+VjE9ytoInidUZChuT3X4MZYU/c5CddKUUbhzgvJd7yFhK6u32l0yXzWMKQ4eDPdrc5+6BjpKEr63CHrqmeBKxdhuxoj4NWVpAhrN96o9kBwyu3BnhkQW8nXa+1cTsoElTjKGCs4Kc4EWzuvSqpf7RoySQtqr4YOn4vWgDd/yPKdo5s9YMpbjCuZPAEiARZmktl6/c3pyQT8PC4Fg=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=2.16.840.1.101.3.4.2.1;
	boundary="----=_NextPart_000_00B1_01D8F83F.B5249010"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WflkS5iGVlTUlHmiWO35E+D3Ma0CjRybLh6eWu++B4iDNgH8pqJnGdEGjV/XMytks4VsL9vclJUzPLN8PjYrKO1vzadAygsCURid8vbhXIySz2O/ezEUx72CFpVRPA0o+s39dIaY7coCcaijkeNbcTHGKe8/ysm316YECTjMT8HuqTa+FCtGEcMRKeCGYw6Nn7698LNYt4uJ0MlymhWz3QMMeUS4ZewFQ0/KDGa0LSf60tWG7+qWjLOqYY3aolC6C4PmsGVSw6lFWH5sRFAFLUXrj1B68sl2MMeTb2yKu1tmypMRqgnSWkL4IGL5X6Rrx/9FYbpT8DhjapO2krTVHU38s0sN4M6+AftN5QjTPkiVxrI/qWq6a4/K/rlM3En0kk7RvYjamlXNsZafrUN0Rqv6O1qSQVSP4L/OBGZrnnKKSJW78b4EYGv5azDkrsV9Qxc2qjqNaq78B1PnGThYXr21Za0XOSjzg0cIAzJ9Ddg6fl7FpcaHeXJQfCT7sVjk92AOsoO5Af6JnwJ3CQsvfzcTwZBgFkHjINA8FnOeZYvBgoFFEZhK87BDLwbhmXlk4zaoGq7I6i6HWOZ2QRUoSU+XI6X7nmElFUsoy7lJ+G4VgvTxd65Ek8WdASh4JH8xRJ9ojrSLSPkWHGae2wrDQlIrwIyFa/KWKDXS8Um0oPmZMdY0i/uG/gFNAboW774dtg8O7sBogrXUnslPmfcIvuIYlAK8VUak6eoL/rxORfhn5qlOqz1Ip1EmhKsPhpm1VUvrmohVpXVXeho7nwLf3K1dZjzWfJ3XTXs5Eqt5/xUBa4ZGKAL1XztS83CQ5ILF
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 820ce6d9-6590-49b5-c112-08dac6918505
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 22:42:33.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1330
X-Proofpoint-ORIG-GUID: EyOPyIUaIHCYN25POvlBhOS72zbLQUXK
X-Proofpoint-GUID: EyOPyIUaIHCYN25POvlBhOS72zbLQUXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_15,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140160

------=_NextPart_000_00B1_01D8F83F.B5249010
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_00B2_01D8F83F.B5249010"


------=_NextPart_001_00B2_01D8F83F.B5249010
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Philippe,

I went ahead and tested out your changes on the "next" branch. Looks like it
runs better (so definitely progress), but it still hangs eventually. I have
attached the output from
the debug kernel (a couple runs because the output was different both
times).

Thanks,

Russell

------=_NextPart_001_00B2_01D8F83F.B5249010
Content-Type: text/plain;
	name="stack_trace_1.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stack_trace_1.txt"

Nov 14 15:22:39 10.243.0.116 [  459.485242] rcu: INFO: rcu_sched =
detected stalls on CPUs/tasks:
Nov 14 15:22:39 10.243.0.116 [  459.485772] rcu: #0118-...0: (98 ticks =
this GP) idle=3Dfe5/1/0x4000000000000000 softirq=3D22420/22426 =
fqs=3D13882
Nov 14 15:22:39 10.243.0.116 [  459.486409] #011(detected by 6, =
t=3D65003 jiffies, g=3D25653, q=3D1912)
Nov 14 15:22:39 10.243.0.116 [  459.486634] Sending NMI from CPU 6 to =
CPUs 8:
Nov 14 15:22:39 10.243.0.116 [  459.490943] NMI backtrace for cpu 8
Nov 14 15:22:39 10.243.0.116 [  459.490950] CPU: 8 PID: 1817 Comm: =
TxWorker0 Not tainted 5.15.77evl-g6437d24c6dbc #1
Nov 14 15:22:39 10.243.0.116 [  459.490964] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 14 15:22:39 10.243.0.116 [  459.490969] IRQ stage: EVL
Nov 14 15:22:39 10.243.0.116 [  459.490974] RIP: =
0010:__asan_load4+0x0/0x90
Nov 14 15:22:39 10.243.0.116 [  459.490992] Code: c0 84 c0 75 e1 5d c3 =
cc cc cc cc 48 c1 e8 03 80 3c 10 00 75 e9 5d c3 cc cc cc cc 0f 1f 44 00 =
00 66 2e 0f 1f 84 00 00 00 00 00 <55> 48 89 e5 48 8b 4d 08 48 83 ff fb =
77 53 48 b8 ff ff ff ff ff 7f
Nov 14 15:22:39 10.243.0.116 [  459.491002] RSP: 0018:ffff88811f7df820 =
EFLAGS: 00000002
Nov 14 15:22:39 10.243.0.116 [  459.491012] RAX: 0000000000140001 RBX: =
ffff888125a6a970 RCX: ffffffff9119be53
Nov 14 15:22:39 10.243.0.116 [  459.491021] RDX: 0000000000000003 RSI: =
dffffc0000000000 RDI: ffff888125a6a970
Nov 14 15:22:39 10.243.0.116 [  459.491028] RBP: ffff88811f7df908 R08: =
ffffed1024b4d52f R09: ffffed1024b4d52f
Nov 14 15:22:39 10.243.0.116 [  459.491037] R10: ffff888125a6a973 R11: =
ffffed1024b4d52e R12: 1ffff11023efbf08
Nov 14 15:22:39 10.243.0.116 [  459.491045] R13: ffff8883de66b040 R14: =
ffff88811f7df8e0 R15: 0000000000000000
Nov 14 15:22:39 10.243.0.116 [  459.491053] FS:  00007f39f3fff700(0000) =
GS:ffff8883de600000(0000) knlGS:0000000000000000
Nov 14 15:22:39 10.243.0.116 [  459.491063] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 14 15:22:39 10.243.0.116 [  459.491071] CR2: 00007f1197a22000 CR3: =
0000000111018003 CR4: 00000000003706e0
Nov 14 15:22:39 10.243.0.116 [  459.491079] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 14 15:22:39 10.243.0.116 [  459.491085] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 14 15:22:39 10.243.0.116 [  459.491092] Call Trace:
Nov 14 15:22:39 10.243.0.116 [  459.491096]  <TASK>
Nov 14 15:22:40 10.243.0.116 [  459.491100]  ? =
native_queued_spin_lock_slowpath+0x363/0x4a0
Nov 14 15:22:40 10.243.0.116 [  459.491121]  ? .slowpath+0x1d/0x1d
Nov 14 15:22:40 10.243.0.116 [  459.491137]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:22:40 10.243.0.116 [  459.491151]  ? =
set_mutex_owner+0x190/0x4a0
Nov 14 15:22:40 10.243.0.116 [  459.491177]  =
do_raw_spin_lock+0x1c6/0x1e0
Nov 14 15:22:40 10.243.0.116 [  459.491190]  ? spin_dump+0x90/0x90
Nov 14 15:22:40 10.243.0.116 [  459.491204]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:22:40 10.243.0.116 [  459.491217]  ? =
fast_grab_mutex+0x9c/0x160
Nov 14 15:22:40 10.243.0.116 [  459.491236]  =
evl_lock_mutex_timeout+0x25d/0xee0
Nov 14 15:22:40 10.243.0.116 [  459.491247]  ? _find_next_bit+0x4a/0x130
Nov 14 15:22:40 10.243.0.116 [  459.491277]  ? =
evl_trylock_mutex+0x1c0/0x1c0
Nov 14 15:22:40 10.243.0.116 [  459.491296]  ? =
__kasan_check_read+0x11/0x20
Nov 14 15:22:40 10.243.0.116 [  459.491315]  ? =
__kasan_check_read+0x11/0x20
Nov 14 15:22:40 10.243.0.116 [  459.491335]  enter_monitor+0x117/0x160
Nov 14 15:22:40 10.243.0.116 [  459.491357]  =
monitor_oob_ioctl+0x4e7/0x1380
Nov 14 15:22:40 10.243.0.116 [  459.491373]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:22:40 10.243.0.116 [  459.491396]  ? enter_monitor+0x160/0x160
Nov 14 15:22:40 10.243.0.116 [  459.491412]  ? =
handle_irq_pipelined_finish+0xbe/0x240
Nov 14 15:22:40 10.243.0.116 [  459.491444]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 14 15:22:40 10.243.0.116 [  459.491457]  ? spin_dump+0x90/0x90
Nov 14 15:22:40 10.243.0.116 [  459.491475]  ? =
__kasan_check_read+0x11/0x20
Nov 14 15:22:40 10.243.0.116 [  459.491488]  ? =
do_raw_spin_unlock+0x97/0x140
Nov 14 15:22:40 10.243.0.116 [  459.491512]  EVL_ioctl+0x81/0xf0
Nov 14 15:22:40 10.243.0.116 [  459.491531]  do_oob_syscall+0x699/0x6b0
Nov 14 15:22:40 10.243.0.116 [  459.491548]  ? =
prepare_for_signal+0x180/0x180
Nov 14 15:22:40 10.243.0.116 [  459.491565]  ? do_oob_irq+0x283/0x7e0
Nov 14 15:22:40 10.243.0.116 [  459.491586]  =
handle_oob_syscall+0x189/0x230
Nov 14 15:22:40 10.243.0.116 [  459.491603]  ? =
handle_pipelined_syscall+0x820/0x820
Nov 14 15:22:40 10.243.0.116 [  459.491623]  ? =
rcu_read_lock_sched_held+0x5b/0xd0
Nov 14 15:22:40 10.243.0.116 [  459.491641]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 14 15:22:40 10.243.0.116 [  459.491664]  pipeline_syscall+0xa7/0x1c0
Nov 14 15:22:40 10.243.0.116 [  459.491686]  =
syscall_enter_from_user_mode+0x47/0x110
Nov 14 15:22:40 10.243.0.116 [  459.491704]  do_syscall_64+0x15/0xb0
Nov 14 15:22:40 10.243.0.116 [  459.491720]  =
entry_SYSCALL_64_after_hwframe+0x61/0xcb
Nov 14 15:22:40 10.243.0.116 [  459.491733] RIP: 0033:0x7f3a156e0b4b
Nov 14 15:22:40 10.243.0.116 [  459.491742] Code: Unable to access =
opcode bytes at RIP 0x7f3a156e0b21.
Nov 14 15:22:40 10.243.0.116 [  459.491747] RSP: 002b:00007f39f3fef010 =
EFLAGS: 00000246 ORIG_RAX: 000000000000009d
Nov 14 15:22:40 10.243.0.116 [  459.491758] RAX: ffffffffffffffda RBX: =
00007f39f3fef0a0 RCX: 00007f3a156e0b4b
Nov 14 15:22:40 10.243.0.116 [  459.491766] RDX: 0000000040106d00 RSI: =
0000000000000009 RDI: 0000000010000002
Nov 14 15:22:40 10.243.0.116 [  459.491774] RBP: 0000000040106d00 R08: =
0000000000000000 R09: 0000000083a21068
Nov 14 15:22:40 10.243.0.116 [  459.491781] R10: 00007f39f3fef0a0 R11: =
0000000000000246 R12: 0000000000000009
Nov 14 15:22:40 10.243.0.116 [  459.491788] R13: 0000000001001000 R14: =
0000000000000000 R15: 00007f39f3fff700
Nov 14 15:22:40 10.243.0.116 [  459.491818]  </TASK>
Nov 14 15:23:04 10.243.0.116 [  483.963153] watchdog: BUG: soft lockup - =
CPU#6 stuck for 41s! [kworker/6:1:144]
Nov 14 15:23:04 10.243.0.116 [  483.966775] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm gpio_ich =
iTCO_wdt iTCO_vendor_support mxm_wmi irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr i2c_i801 intel_pch_thermal input_leds i2c_smbus =
joydev sg ftdi_sio lpc_ich mei_me mfd_core mei ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper sd_mod syscopyarea =
sysfillrect sysimgblt sr_mod fb_sys_fops t10_pi drm_ttm_helper cdrom ttm =
drm ixgbe igb ahci
Nov 14 15:23:04 10.243.0.116 [  483.967267]  libahci libata crc32c_intel =
mdio ptp pps_core i2c_algo_bit dca fuse
Nov 14 15:23:04 10.243.0.116 [  484.006663] irq event stamp: 263866
Nov 14 15:23:04 10.243.0.116 [  484.012429] hardirqs last  enabled at =
(263865): [<ffffffff92117f9e>] arch_pipeline_entry+0x5e/0x110
Nov 14 15:23:04 10.243.0.116 [  484.017600] hardirqs last disabled at =
(263866): [<ffffffff911c346b>] sync_current_irq_stage+0x4db/0x500
Nov 14 15:23:04 10.243.0.116 [  484.022771] softirqs last  enabled at =
(28414): [<ffffffff92400403>] __do_softirq+0x403/0x57b
Nov 14 15:23:04 10.243.0.116 [  484.027974] softirqs last disabled at =
(28379): [<ffffffff910d261d>] irq_exit_rcu+0x7d/0x150
Nov 14 15:23:04 10.243.0.116 [  484.033196] CPU: 6 PID: 144 Comm: =
kworker/6:1 Not tainted 5.15.77evl-g6437d24c6dbc #1
Nov 14 15:23:04 10.243.0.116 [  484.038521] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 14 15:23:04 10.243.0.116 [  484.043973] IRQ stage: Linux
Nov 14 15:23:04 10.243.0.116 [  484.049334] Workqueue: events =
netstamp_clear
Nov 14 15:23:04 10.243.0.116 [  484.054767] RIP: =
0010:__asan_load4+0x0/0x90
Nov 14 15:23:04 10.243.0.116 [  484.060203] Code: c0 84 c0 75 e1 5d c3 =
cc cc cc cc 48 c1 e8 03 80 3c 10 00 75 e9 5d c3 cc cc cc cc 0f 1f 44 00 =
00 66 2e 0f 1f 84 00 00 00 00 00 <55> 48 89 e5 48 8b 4d 08 48 83 ff fb =
77 53 48 b8 ff ff ff ff ff 7f
Nov 14 15:23:04 10.243.0.116 [  484.071793] RSP: 0018:ffff88810233fb00 =
EFLAGS: 00000202 ORIG_RAX: 0000000000000000
Nov 14 15:23:04 10.243.0.116 [  484.077714] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Nov 14 15:23:04 10.243.0.116 [  484.083650] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Nov 14 15:23:04 10.243.0.116 [  484.089574] RBP: ffff88810233fb80 R08: =
0000000000000000 R09: 0000000000000000
Nov 14 15:23:04 10.243.0.116 [  484.095474] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Nov 14 15:23:04 10.243.0.116 [  484.101366] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Nov 14 15:23:04 10.243.0.116 [  484.107243] FS:  0000000000000000(0000) =
GS:ffff8883de500000(0000) knlGS:0000000000000000
Nov 14 15:23:04 10.243.0.116 [  484.113203] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 14 15:23:04 10.243.0.116 [  484.119151] CR2: 00007f35560cf830 CR3: =
00000002bee16004 CR4: 00000000003706e0
Nov 14 15:23:04 10.243.0.116 [  484.125195] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 14 15:23:04 10.243.0.116 [  484.131250] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 14 15:23:04 10.243.0.116 [  484.137283] Call Trace:
Nov 14 15:23:04 10.243.0.116 [  484.143250]  <TASK>
Nov 14 15:23:04 10.243.0.116 [  484.149152]  ? =
smp_call_function_many_cond+0x1b0/0x4d0
Nov 14 15:23:04 10.243.0.116 [  484.155158]  ? =
text_poke_bp_batch+0x350/0x350
Nov 14 15:23:04 10.243.0.116 [  484.161161]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:23:04 10.243.0.116 [  484.167196]  =
on_each_cpu_cond_mask+0x24/0x40
Nov 14 15:23:04 10.243.0.116 [  484.173187]  =
text_poke_bp_batch+0x146/0x350
Nov 14 15:23:04 10.243.0.116 [  484.179151]  ? __text_poke+0x620/0x620
Nov 14 15:23:04 10.243.0.116 [  484.185042]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:23:04 10.243.0.116 [  484.190927]  ? =
netif_receive_skb_list_internal+0x10f/0x730
Nov 14 15:23:04 10.243.0.116 [  484.196733]  ? =
netif_receive_skb_list_internal+0x105/0x730
Nov 14 15:23:04 10.243.0.116 [  484.202525]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:23:04 10.243.0.116 [  484.208274]  text_poke_finish+0x1a/0x30
Nov 14 15:23:04 10.243.0.116 [  484.213979]  =
arch_jump_label_transform_apply+0x17/0x30
Nov 14 15:23:04 10.243.0.116 [  484.219692]  =
__jump_label_update+0x105/0x140
Nov 14 15:23:04 10.243.0.116 [  484.225314]  =
jump_label_update+0x16b/0x1a0
Nov 14 15:23:04 10.243.0.116 [  484.230826]  =
static_key_enable_cpuslocked+0xc0/0x100
Nov 14 15:23:04 10.243.0.116 [  484.236186]  static_key_enable+0x15/0x30
Nov 14 15:23:04 10.243.0.116 [  484.241348]  netstamp_clear+0x4b/0x60
Nov 14 15:23:04 10.243.0.116 [  484.246365]  =
process_one_work+0x517/0xa10
Nov 14 15:23:04 10.243.0.116 [  484.251248]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Nov 14 15:23:04 10.243.0.116 [  484.255999]  ? =
lockdep_hardirqs_off+0x8d/0xc0
Nov 14 15:23:04 10.243.0.116 [  484.260592]  worker_thread+0x52/0x580
Nov 14 15:23:04 10.243.0.116 [  484.265003]  ? =
process_one_work+0xa10/0xa10
Nov 14 15:23:04 10.243.0.116 [  484.269288]  kthread+0x1ee/0x220
Nov 14 15:23:04 10.243.0.116 [  484.273484]  ? =
set_kthread_struct+0x80/0x80
Nov 14 15:23:04 10.243.0.116 [  484.277620]  ret_from_fork+0x22/0x30
Nov 14 15:23:04 10.243.0.116 [  484.281740]  </TASK>
Nov 14 15:23:32 10.243.0.116 [  511.964554] watchdog: BUG: soft lockup - =
CPU#6 stuck for 67s! [kworker/6:1:144]
Nov 14 15:23:32 10.243.0.116 [  511.968772] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm gpio_ich =
iTCO_wdt iTCO_vendor_support mxm_wmi irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr i2c_i801 intel_pch_thermal input_leds i2c_smbus =
joydev sg ftdi_sio lpc_ich mei_me mfd_core mei ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper sd_mod syscopyarea =
sysfillrect sysimgblt sr_mod fb_sys_fops t10_pi drm_ttm_helper cdrom ttm =
drm ixgbe igb ahci
Nov 14 15:23:32 10.243.0.116 [  511.969293]  libahci libata crc32c_intel =
mdio ptp pps_core i2c_algo_bit dca fuse
Nov 14 15:23:32 10.243.0.116 [  512.011764] irq event stamp: 429970
Nov 14 15:23:32 10.243.0.116 [  512.016583] hardirqs last  enabled at =
(429969): [<ffffffff92117f9e>] arch_pipeline_entry+0x5e/0x110
Nov 14 15:23:32 10.243.0.116 [  512.021670] hardirqs last disabled at =
(429970): [<ffffffff911c346b>] sync_current_irq_stage+0x4db/0x500
Nov 14 15:23:32 10.243.0.116 [  512.026822] softirqs last  enabled at =
(28414): [<ffffffff92400403>] __do_softirq+0x403/0x57b
Nov 14 15:23:32 10.243.0.116 [  512.032059] softirqs last disabled at =
(28379): [<ffffffff910d261d>] irq_exit_rcu+0x7d/0x150
Nov 14 15:23:32 10.243.0.116 [  512.037247] CPU: 6 PID: 144 Comm: =
kworker/6:1 Tainted: G             L    5.15.77evl-g6437d24c6dbc #1
Nov 14 15:23:32 10.243.0.116 [  512.042513] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 14 15:23:32 10.243.0.116 [  512.047809] IRQ stage: Linux
Nov 14 15:23:32 10.243.0.116 [  512.052993] Workqueue: events =
netstamp_clear
Nov 14 15:23:32 10.243.0.116 [  512.058501] RIP: =
0010:__asan_load4+0x37/0x90
Nov 14 15:23:32 10.243.0.116 [  512.063690] Code: 53 48 b8 ff ff ff ff =
ff 7f ff ff 48 39 c7 76 44 48 8d 47 03 48 89 c2 83 e2 07 48 83 fa 02 76 =
1c 48 be 00 00 00 00 00 fc ff df <48> c1 e8 03 0f b6 04 30 84 c0 75 3c =
5d c3 cc cc cc cc 48 be 00 00
Nov 14 15:23:32 10.243.0.116 [  512.074803] RSP: 0018:ffff88810233faf8 =
EFLAGS: 00000202 ORIG_RAX: 0000000000000000
Nov 14 15:23:32 10.243.0.116 [  512.080492] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Nov 14 15:23:32 10.243.0.116 [  512.086188] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Nov 14 15:23:32 10.243.0.116 [  512.091780] RBP: ffff88810233faf8 R08: =
0000000000000000 R09: 0000000000000000
Nov 14 15:23:32 10.243.0.116 [  512.097397] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Nov 14 15:23:32 10.243.0.116 [  512.103002] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Nov 14 15:23:32 10.243.0.116 [  512.108511] FS:  0000000000000000(0000) =
GS:ffff8883de500000(0000) knlGS:0000000000000000
Nov 14 15:23:32 10.243.0.116 [  512.114164] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 14 15:23:32 10.243.0.116 [  512.119846] CR2: 00007f35560cf830 CR3: =
00000002bee16004 CR4: 00000000003706e0
Nov 14 15:23:32 10.243.0.116 [  512.125688] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 14 15:23:32 10.243.0.116 [  512.131516] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 14 15:23:32 10.243.0.116 [  512.137310] Call Trace:
Nov 14 15:23:32 10.243.0.116 [  512.144464]  <TASK>
Nov 14 15:23:32 10.243.0.116 [  512.150132]  =
smp_call_function_many_cond+0x1b0/0x4d0
Nov 14 15:23:32 10.243.0.116 [  512.155855]  ? =
text_poke_bp_batch+0x350/0x350
Nov 14 15:23:32 10.243.0.116 [  512.161614]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:23:32 10.243.0.116 [  512.167449]  =
on_each_cpu_cond_mask+0x24/0x40
Nov 14 15:23:32 10.243.0.116 [  512.173244]  =
text_poke_bp_batch+0x146/0x350
Nov 14 15:23:32 10.243.0.116 [  512.179047]  ? __text_poke+0x620/0x620
Nov 14 15:23:32 10.243.0.116 [  512.184799]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:23:32 10.243.0.116 [  512.190662]  ? =
netif_receive_skb_list_internal+0x10f/0x730
Nov 14 15:23:32 10.243.0.116 [  512.196457]  ? =
netif_receive_skb_list_internal+0x105/0x730
Nov 14 15:23:32 10.243.0.116 [  512.202211]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:23:32 10.243.0.116 [  512.207942]  text_poke_finish+0x1a/0x30
Nov 14 15:23:32 10.243.0.116 [  512.213597]  =
arch_jump_label_transform_apply+0x17/0x30
Nov 14 15:23:32 10.243.0.116 [  512.219363]  =
__jump_label_update+0x105/0x140
Nov 14 15:23:32 10.243.0.116 [  512.225044]  =
jump_label_update+0x16b/0x1a0
Nov 14 15:23:32 10.243.0.116 [  512.230557]  =
static_key_enable_cpuslocked+0xc0/0x100
Nov 14 15:23:32 10.243.0.116 [  512.235980]  static_key_enable+0x15/0x30
Nov 14 15:23:32 10.243.0.116 [  512.241195]  netstamp_clear+0x4b/0x60
Nov 14 15:23:32 10.243.0.116 [  512.246241]  =
process_one_work+0x517/0xa10
Nov 14 15:23:32 10.243.0.116 [  512.251182]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Nov 14 15:23:32 10.243.0.116 [  512.255963]  ? =
lockdep_hardirqs_off+0x8d/0xc0
Nov 14 15:23:32 10.243.0.116 [  512.260571]  worker_thread+0x52/0x580
Nov 14 15:23:32 10.243.0.116 [  512.265041]  ? =
process_one_work+0xa10/0xa10
Nov 14 15:23:32 10.243.0.116 [  512.269380]  kthread+0x1ee/0x220
Nov 14 15:23:32 10.243.0.116 [  512.273605]  ? =
set_kthread_struct+0x80/0x80
Nov 14 15:23:32 10.243.0.116 [  512.277772]  ret_from_fork+0x22/0x30
Nov 14 15:23:32 10.243.0.116 [  512.281945]  </TASK>
Nov 14 15:24:00 10.243.0.116 [  539.965956] watchdog: BUG: soft lockup - =
CPU#6 stuck for 93s! [kworker/6:1:144]
Nov 14 15:24:00 10.243.0.116 [  539.970187] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm gpio_ich =
iTCO_wdt iTCO_vendor_support mxm_wmi irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr i2c_i801 intel_pch_thermal input_leds i2c_smbus =
joydev sg ftdi_sio lpc_ich mei_me mfd_core mei ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper sd_mod syscopyarea =
sysfillrect sysimgblt sr_mod fb_sys_fops t10_pi drm_ttm_helper cdrom ttm =
drm ixgbe igb ahci
Nov 14 15:24:00 10.243.0.116 [  539.970707]  libahci libata crc32c_intel =
mdio ptp pps_core i2c_algo_bit dca fuse
Nov 14 15:24:00 10.243.0.116 [  540.012415] irq event stamp: 596080
Nov 14 15:24:00 10.243.0.116 [  540.017214] hardirqs last  enabled at =
(596079): [<ffffffff92117f9e>] arch_pipeline_entry+0x5e/0x110
Nov 14 15:24:00 10.243.0.116 [  540.022334] hardirqs last disabled at =
(596080): [<ffffffff911c346b>] sync_current_irq_stage+0x4db/0x500
Nov 14 15:24:00 10.243.0.116 [  540.027485] softirqs last  enabled at =
(28414): [<ffffffff92400403>] __do_softirq+0x403/0x57b
Nov 14 15:24:00 10.243.0.116 [  540.032694] softirqs last disabled at =
(28379): [<ffffffff910d261d>] irq_exit_rcu+0x7d/0x150
Nov 14 15:24:00 10.243.0.116 [  540.037936] CPU: 6 PID: 144 Comm: =
kworker/6:1 Tainted: G             L    5.15.77evl-g6437d24c6dbc #1
Nov 14 15:24:00 10.243.0.116 [  540.043203] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 14 15:24:00 10.243.0.116 [  540.048499] IRQ stage: Linux
Nov 14 15:24:00 10.243.0.116 [  540.053696] Workqueue: events =
netstamp_clear
Nov 14 15:24:00 10.243.0.116 [  540.058927] RIP: =
0010:smp_call_function_many_cond+0x1a8/0x4d0
Nov 14 15:24:00 10.243.0.116 [  540.064174] Code: fd 4c 89 e7 e8 79 8c =
2a 00 4a 8d 3c fd 80 28 d1 92 49 8b 1c 24 e8 68 8c 2a 00 4a 03 1c fd 80 =
28 d1 92 4c 8d 7b 08 eb 02 f3 90 <4c> 89 ff e8 20 8b 2a 00 8b 43 08 a8 =
01 75 ef eb 9f 48 c7 c7 c8 2a
Nov 14 15:24:00 10.243.0.116 [  540.075363] RSP: 0018:ffff88810233fb08 =
EFLAGS: 00000202 ORIG_RAX: 0000000000000000
Nov 14 15:24:00 10.243.0.116 [  540.081049] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Nov 14 15:24:00 10.243.0.116 [  540.086749] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Nov 14 15:24:00 10.243.0.116 [  540.092403] RBP: ffff88810233fb80 R08: =
0000000000000000 R09: 0000000000000000
Nov 14 15:24:00 10.243.0.116 [  540.098020] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Nov 14 15:24:00 10.243.0.116 [  540.103651] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Nov 14 15:24:00 10.243.0.116 [  540.109188] FS:  0000000000000000(0000) =
GS:ffff8883de500000(0000) knlGS:0000000000000000
Nov 14 15:24:00 10.243.0.116 [  540.114865] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 14 15:24:00 10.243.0.116 [  540.120587] CR2: 00007f35560cf830 CR3: =
00000002bee16004 CR4: 00000000003706e0
Nov 14 15:24:00 10.243.0.116 [  540.126464] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 14 15:24:00 10.243.0.116 [  540.132313] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 14 15:24:00 10.243.0.116 [  540.138099] Call Trace:
Nov 14 15:24:00 10.243.0.116 [  540.143805]  <TASK>
Nov 14 15:24:00 10.243.0.116 [  540.149490]  ? =
text_poke_bp_batch+0x350/0x350
Nov 14 15:24:00 10.243.0.116 [  540.155222]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:24:00 10.243.0.116 [  540.161020]  =
on_each_cpu_cond_mask+0x24/0x40
Nov 14 15:24:00 10.243.0.116 [  540.166805]  =
text_poke_bp_batch+0x146/0x350
Nov 14 15:24:00 10.243.0.116 [  540.172636]  ? __text_poke+0x620/0x620
Nov 14 15:24:00 10.243.0.116 [  540.178411]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:24:00 10.243.0.116 [  540.184224]  ? =
netif_receive_skb_list_internal+0x10f/0x730
Nov 14 15:24:00 10.243.0.116 [  540.190013]  ? =
netif_receive_skb_list_internal+0x105/0x730
Nov 14 15:24:00 10.243.0.116 [  540.195776]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:24:00 10.243.0.116 [  540.201502]  text_poke_finish+0x1a/0x30
Nov 14 15:24:00 10.243.0.116 [  540.207155]  =
arch_jump_label_transform_apply+0x17/0x30
Nov 14 15:24:00 10.243.0.116 [  540.212890]  =
__jump_label_update+0x105/0x140
Nov 14 15:24:00 10.243.0.116 [  540.218648]  =
jump_label_update+0x16b/0x1a0
Nov 14 15:24:00 10.243.0.116 [  540.224316]  =
static_key_enable_cpuslocked+0xc0/0x100
Nov 14 15:24:00 10.243.0.116 [  540.229858]  static_key_enable+0x15/0x30
Nov 14 15:24:00 10.243.0.116 [  540.235203]  netstamp_clear+0x4b/0x60
Nov 14 15:24:00 10.243.0.116 [  540.240414]  =
process_one_work+0x517/0xa10
Nov 14 15:24:00 10.243.0.116 [  540.245493]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Nov 14 15:24:00 10.243.0.116 [  540.250416]  ? =
lockdep_hardirqs_off+0x8d/0xc0
Nov 14 15:24:00 10.243.0.116 [  540.255187]  worker_thread+0x52/0x580
Nov 14 15:24:00 10.243.0.116 [  540.259809]  ? =
process_one_work+0xa10/0xa10
Nov 14 15:24:00 10.243.0.116 [  540.264234]  kthread+0x1ee/0x220
Nov 14 15:24:00 10.243.0.116 [  540.268564]  ? =
set_kthread_struct+0x80/0x80
Nov 14 15:24:00 10.243.0.116 [  540.272831]  ret_from_fork+0x22/0x30
Nov 14 15:24:00 10.243.0.116 [  540.277007]  </TASK>
Nov 14 15:24:28 10.243.0.116 [  567.967358] watchdog: BUG: soft lockup - =
CPU#6 stuck for 119s! [kworker/6:1:144]
Nov 14 15:24:28 10.243.0.116 [  567.971610] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod =
x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm gpio_ich =
iTCO_wdt iTCO_vendor_support mxm_wmi irqbypass crct10dif_pclmul =
crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl =
intel_cstate pcspkr i2c_i801 intel_pch_thermal input_leds i2c_smbus =
joydev sg ftdi_sio lpc_ich mei_me mfd_core mei ioatdma wmi ip_tables =
ext4 mbcache jbd2 ast drm_vram_helper drm_kms_helper sd_mod syscopyarea =
sysfillrect sysimgblt sr_mod fb_sys_fops t10_pi drm_ttm_helper cdrom ttm =
drm ixgbe igb ahci
Nov 14 15:24:28 10.243.0.116 [  567.972130]  libahci libata crc32c_intel =
mdio ptp pps_core i2c_algo_bit dca fuse
Nov 14 15:24:28 10.243.0.116 [  568.014341] irq event stamp: 762232
Nov 14 15:24:28 10.243.0.116 [  568.019106] hardirqs last  enabled at =
(762231): [<ffffffff92117f9e>] arch_pipeline_entry+0x5e/0x110
Nov 14 15:24:28 10.243.0.116 [  568.024163] hardirqs last disabled at =
(762232): [<ffffffff911c346b>] sync_current_irq_stage+0x4db/0x500
Nov 14 15:24:28 10.243.0.116 [  568.029268] softirqs last  enabled at =
(28414): [<ffffffff92400403>] __do_softirq+0x403/0x57b
Nov 14 15:24:28 10.243.0.116 [  568.034414] softirqs last disabled at =
(28379): [<ffffffff910d261d>] irq_exit_rcu+0x7d/0x150
Nov 14 15:24:28 10.243.0.116 [  568.039613] CPU: 6 PID: 144 Comm: =
kworker/6:1 Tainted: G             L    5.15.77evl-g6437d24c6dbc #1
Nov 14 15:24:28 10.243.0.116 [  568.044932] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 14 15:24:28 10.243.0.116 [  568.050231] IRQ stage: Linux
Nov 14 15:24:28 10.243.0.116 [  568.055409] Workqueue: events =
netstamp_clear
Nov 14 15:24:28 10.243.0.116 [  568.060592] RIP: =
0010:__asan_load4+0x0/0x90
Nov 14 15:24:28 10.243.0.116 [  568.065844] Code: c0 84 c0 75 e1 5d c3 =
cc cc cc cc 48 c1 e8 03 80 3c 10 00 75 e9 5d c3 cc cc cc cc 0f 1f 44 00 =
00 66 2e 0f 1f 84 00 00 00 00 00 <55> 48 89 e5 48 8b 4d 08 48 83 ff fb =
77 53 48 b8 ff ff ff ff ff 7f
Nov 14 15:24:28 10.243.0.116 [  568.076879] RSP: 0018:ffff88810233fb00 =
EFLAGS: 00000202 ORIG_RAX: 0000000000000000
Nov 14 15:24:28 10.243.0.116 [  568.082543] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Nov 14 15:24:28 10.243.0.116 [  568.088226] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Nov 14 15:24:28 10.243.0.116 [  568.093856] RBP: ffff88810233fb80 R08: =
0000000000000000 R09: 0000000000000000
Nov 14 15:24:28 10.243.0.116 [  568.099441] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Nov 14 15:24:28 10.243.0.116 [  568.105039] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Nov 14 15:24:28 10.243.0.116 [  568.110555] FS:  0000000000000000(0000) =
GS:ffff8883de500000(0000) knlGS:0000000000000000
Nov 14 15:24:28 10.243.0.116 [  568.116232] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 14 15:24:28 10.243.0.116 [  568.121930] CR2: 00007f35560cf830 CR3: =
00000002bee16004 CR4: 00000000003706e0
Nov 14 15:24:28 10.243.0.116 [  568.127768] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 14 15:24:28 10.243.0.116 [  568.133584] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 14 15:24:28 10.243.0.116 [  568.139391] Call Trace:
Nov 14 15:24:28 10.243.0.116 [  568.145079]  <TASK>
Nov 14 15:24:28 10.243.0.116 [  568.150725]  ? =
smp_call_function_many_cond+0x1b0/0x4d0
Nov 14 15:24:28 10.243.0.116 [  568.156467]  ? =
text_poke_bp_batch+0x350/0x350
Nov 14 15:24:28 10.243.0.116 [  568.162243]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:24:28 10.243.0.116 [  568.168050]  =
on_each_cpu_cond_mask+0x24/0x40
Nov 14 15:24:28 10.243.0.116 [  568.173844]  =
text_poke_bp_batch+0x146/0x350
Nov 14 15:24:28 10.243.0.116 [  568.179642]  ? __text_poke+0x620/0x620
Nov 14 15:24:28 10.243.0.116 [  568.185433]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:24:28 10.243.0.116 [  568.191280]  ? =
netif_receive_skb_list_internal+0x10f/0x730
Nov 14 15:24:28 10.243.0.116 [  568.197076]  ? =
netif_receive_skb_list_internal+0x105/0x730
Nov 14 15:24:28 10.243.0.116 [  568.202834]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:24:28 10.243.0.116 [  568.208545]  text_poke_finish+0x1a/0x30
Nov 14 15:24:28 10.243.0.116 [  568.214238]  =
arch_jump_label_transform_apply+0x17/0x30
Nov 14 15:24:28 10.243.0.116 [  568.219993]  =
__jump_label_update+0x105/0x140
Nov 14 15:24:28 10.243.0.116 [  568.225650]  =
jump_label_update+0x16b/0x1a0
Nov 14 15:24:28 10.243.0.116 [  568.231193]  =
static_key_enable_cpuslocked+0xc0/0x100
Nov 14 15:24:28 10.243.0.116 [  568.236602]  static_key_enable+0x15/0x30
Nov 14 15:24:28 10.243.0.116 [  568.241834]  netstamp_clear+0x4b/0x60
Nov 14 15:24:28 10.243.0.116 [  568.246877]  =
process_one_work+0x517/0xa10
Nov 14 15:24:28 10.243.0.116 [  568.251805]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Nov 14 15:24:28 10.243.0.116 [  568.256579]  ? =
lockdep_hardirqs_off+0x8d/0xc0
Nov 14 15:24:28 10.243.0.116 [  568.261226]  worker_thread+0x52/0x580
Nov 14 15:24:28 10.243.0.116 [  568.265742]  ? =
process_one_work+0xa10/0xa10
Nov 14 15:24:28 10.243.0.116 [  568.270071]  kthread+0x1ee/0x220
Nov 14 15:24:28 10.243.0.116 [  568.274299]  ? =
set_kthread_struct+0x80/0x80
Nov 14 15:24:28 10.243.0.116 [  568.278490]  ret_from_fork+0x22/0x30
Nov 14 15:24:28 10.243.0.116 [  568.282655]  </TASK>
------=_NextPart_001_00B2_01D8F83F.B5249010
Content-Type: text/plain;
	name="stack_trace_2.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stack_trace_2.txt"

Nov 14 15:36:46 10.243.0.116 [  528.734461] watchdog: BUG: soft lockup - =
CPU#0 stuck for 22s! [kworker/0:0:7]
Nov 14 15:36:46 10.243.0.116 [  528.735538] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod iTCO_wdt =
gpio_ich iTCO_vendor_support x86_pkg_temp_thermal intel_powerclamp =
mxm_wmi coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul =
ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl intel_cstate =
pcspkr joydev intel_pch_thermal input_leds sg mei_me ftdi_sio i2c_i801 =
lpc_ich mei mfd_core i2c_smbus ioatdma wmi ip_tables ext4 mbcache jbd2 =
ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt =
fb_sys_fops drm_ttm_helper sr_mod ttm sd_mod cdrom t10_pi igb drm ixgbe =
ahci
Nov 14 15:36:46 10.243.0.116 [  528.736553]  libahci libata crc32c_intel =
mdio ptp i2c_algo_bit pps_core dca fuse
Nov 14 15:36:46 10.243.0.116 [  528.805968] irq event stamp: 4404404
Nov 14 15:36:46 10.243.0.116 [  528.816003] hardirqs last  enabled at =
(4404403): [<ffffffffbc117f9e>] arch_pipeline_entry+0x5e/0x110
Nov 14 15:36:46 10.243.0.116 [  528.826492] hardirqs last disabled at =
(4404404): [<ffffffffbb1c346b>] sync_current_irq_stage+0x4db/0x500
Nov 14 15:36:46 10.243.0.116 [  528.836988] softirqs last  enabled at =
(4297982): [<ffffffffbc400403>] __do_softirq+0x403/0x57b
Nov 14 15:36:46 10.243.0.116 [  528.847475] softirqs last disabled at =
(4297951): [<ffffffffbb0d261d>] irq_exit_rcu+0x7d/0x150
Nov 14 15:36:46 10.243.0.116 [  528.857999] CPU: 0 PID: 7 Comm: =
kworker/0:0 Not tainted 5.15.77evl-g6437d24c6dbc #1
Nov 14 15:36:46 10.243.0.116 [  528.868497] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 14 15:36:46 10.243.0.116 [  528.879049] IRQ stage: Linux
Nov 14 15:36:46 10.243.0.116 [  528.889330] Workqueue: events =
netstamp_clear
Nov 14 15:36:46 10.243.0.116 [  528.899642] RIP: =
0010:unlock_stage+0x52/0x80
Nov 14 15:36:46 10.243.0.116 [  528.909837] Code: e8 e3 8e 0a ff 48 f7 =
d0 48 89 c7 48 21 cf e8 d5 8e 0a ff 25 00 02 00 00 48 89 c3 48 85 d2 75 =
10 48 89 c2 48 85 d2 74 01 fb 5b <5d> c3 cc cc cc cc 65 48 8b 3c 25 80 =
6f 02 00 48 81 c7 d8 0d 00 00
Nov 14 15:36:46 10.243.0.116 [  528.931388] RSP: 0018:ffff8883de2092c8 =
EFLAGS: 00000206 ORIG_RAX: 0000000000000000
Nov 14 15:36:46 10.243.0.116 [  528.942274] RAX: 0000000000000000 RBX: =
0000000000000000 RCX: 0000000000000000
Nov 14 15:36:46 10.243.0.116 [  528.953099] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000
Nov 14 15:36:46 10.243.0.116 [  528.963917] RBP: ffff8883de2095c8 R08: =
0000000000000000 R09: 0000000000000000
Nov 14 15:36:46 10.243.0.116 [  528.974628] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Nov 14 15:36:46 10.243.0.116 [  528.985222] R13: 0000000000000000 R14: =
0000000000000000 R15: 0000000000000000
Nov 14 15:36:46 10.243.0.116 [  528.995664] FS:  0000000000000000(0000) =
GS:ffff8883de200000(0000) knlGS:0000000000000000
Nov 14 15:36:46 10.243.0.116 [  529.006128] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 14 15:36:46 10.243.0.116 [  529.016518] CR2: 00007f5155c96d60 CR3: =
0000000122034003 CR4: 00000000003706f0
Nov 14 15:36:46 10.243.0.116 [  529.027064] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 14 15:36:46 10.243.0.116 [  529.037517] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 14 15:36:46 10.243.0.116 [  529.047802] Call Trace:
Nov 14 15:36:46 10.243.0.116 [  529.057827]  <IRQ>
Nov 14 15:36:46 10.243.0.116 [  529.067870]  ? =
__kasan_check_read+0x11/0x20
Nov 14 15:36:46 10.243.0.116 [  529.078161]  ? =
mark_lock.part.53+0x119/0x1460
Nov 14 15:36:46 10.243.0.116 [  529.088516]  ? =
create_prof_cpu_mask+0x30/0x30
Nov 14 15:36:46 10.243.0.116 [  529.098999]  ? arch_stack_walk+0x86/0xf0
Nov 14 15:36:46 10.243.0.116 [  529.109569]  ? print_usage_bug+0x60/0x60
Nov 14 15:36:46 10.243.0.116 [  529.120172]  ret_from_fork+0x22/0x30
Nov 14 15:36:46 10.243.0.116 [  529.130845] WARNING: kernel stack frame =
pointer at 000000009b1db727 in kworker/0:0:7 has bad value =
00000000b3fc3469
Nov 14 15:36:46 10.243.0.116 [  529.130856] unwind stack type:2 =
next_sp:00000000f67bf0e4 mask:0x4 graph_idx:0
Nov 14 15:36:47 10.243.0.116 [  529.130863] 000000009b1db727: =
ffffffffbb1ae7b0 (_prb_commit+0x140/0x140)
Nov 14 15:36:47 10.243.0.116 [  529.130878] 00000000b43a18b9: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:47 10.243.0.116 [  529.130890] 000000004d9a86d2: =
6234336131386239 (0x6234336131386239)
Nov 14 15:36:47 10.243.0.116 [  529.130902] 00000000d8117c58: =
ffffffffbb859c00 (put_dec+0xc0/0xc0)
Nov 14 15:36:47 10.243.0.116 [  529.130918] 00000000c14e1bb9: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:47 10.243.0.116 [  529.130930] 000000004f9a0750: =
ffff103000001005 (0xffff103000001005)
Nov 14 15:36:47 10.243.0.116 [  529.130942] 000000007ec12b4f: =
ffff88811a250200 (0xffff88811a250200)
Nov 14 15:36:47 10.243.0.116 [  529.130954] 00000000ae08693a: =
ffffffffbe539583 (__log_buf+0x17f63/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.130968] 000000005538940a: =
0000003000000000 (0x3000000000)
Nov 14 15:36:47 10.243.0.116 [  529.130980] 000000006d8ad422: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:47 10.243.0.116 [  529.130992] 00000000f28336c7: =
ffffff00ffffffff (0xffffff00ffffffff)
Nov 14 15:36:47 10.243.0.116 [  529.131003] 00000000d311b6ae: =
0000003000000000 (0x3000000000)
Nov 14 15:36:47 10.243.0.116 [  529.131014] 0000000083206f42: =
1ffff1107bc412bd (0x1ffff1107bc412bd)
Nov 14 15:36:47 10.243.0.116 [  529.131026] 000000005a221ff0: =
ffffffffbe539920 (__log_buf+0x18300/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131039] 00000000702c1abb: =
ffffffffbe5399a8 (__log_buf+0x18388/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131052] 000000001d21a716: =
ffff8883de2097b8 (0xffff8883de2097b8)
Nov 14 15:36:47 10.243.0.116 [  529.131063] 00000000f69b2341: =
ffffffffbc653ce9 (__func__.55224+0x129/0xa40)
Nov 14 15:36:47 10.243.0.116 [  529.131080] 00000000816bb13c: =
ffff8883de2095f0 (0xffff8883de2095f0)
Nov 14 15:36:47 10.243.0.116 [  529.131092] 00000000b92630bf: =
ffffffffbb4cb4ff (__asan_loadN+0xf/0x20)
Nov 14 15:36:47 10.243.0.116 [  529.131106] 000000007ae54397: =
ffff8883de209710 (0xffff8883de209710)
Nov 14 15:36:47 10.243.0.116 [  529.131117] 00000000a636e04f: =
ffffffffbb859fcc (number+0x3cc/0x5e0)
Nov 14 15:36:47 10.243.0.116 [  529.131132] 0000000003f95819: =
ffffffffbe539ba1 (__log_buf+0x18581/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131145] 000000002089889d: =
ffffffffbe539bc2 (__log_buf+0x185a2/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131158] 000000009f7f45b6: =
1ffff1107bc412c9 (0x1ffff1107bc412c9)
Nov 14 15:36:47 10.243.0.116 [  529.131170] 000000004a67d2b0: =
ffffffff001aec1a (0xffffffff001aec1a)
Nov 14 15:36:47 10.243.0.116 [  529.131181] 0000000032a1a535: =
0000001010ffc5c8 (0x1010ffc5c8)
Nov 14 15:36:47 10.243.0.116 [  529.131193] 00000000609a6396: =
0000001010ffc5c8 (0x1010ffc5c8)
Nov 14 15:36:47 10.243.0.116 [  529.131204] 000000005e203b6c: =
ffff888300000006 (0xffff888300000006)
Nov 14 15:36:47 10.243.0.116 [  529.131215] 000000006f765dae: =
0000001030100000 (0x1030100000)
Nov 14 15:36:47 10.243.0.116 [  529.131227] 0000000085cd1c75: =
ffffffffbe539dc8 (__log_buf+0x187a8/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131239] 0000000098eac725: =
ffff8883de209778 (0xffff8883de209778)
Nov 14 15:36:47 10.243.0.116 [  529.131251] 0000000010e1f5a2: =
ffff8883de2096e8 (0xffff8883de2096e8)
Nov 14 15:36:47 10.243.0.116 [  529.131263] 00000000b5ca23dd: =
ffff8883de209668 (0xffff8883de209668)
Nov 14 15:36:47 10.243.0.116 [  529.131275] 00000000713044db: =
ffffffffbb4cb4ff (__asan_loadN+0xf/0x20)
Nov 14 15:36:47 10.243.0.116 [  529.131288] 00000000f90beaad: =
ffff8883de209710 (0xffff8883de209710)
Nov 14 15:36:47 10.243.0.116 [  529.131300] 00000000ff98e030: =
ffffffffbb85a976 (format_decode+0xd6/0x5c0)
Nov 14 15:36:47 10.243.0.116 [  529.131315] 00000000d0e54bdf: =
ffffffffbb85fff8 (pointer+0x398/0x5d0)
Nov 14 15:36:47 10.243.0.116 [  529.131327] 00000000c2624c74: =
1ffff1107bc412d1 (0x1ffff1107bc412d1)
Nov 14 15:36:47 10.243.0.116 [  529.131339] 00000000af7737fe: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:47 10.243.0.116 [  529.131350] 000000006eca9803: =
ffffffffbccd37b1 (.LC2+0x80a/0x25639)
Nov 14 15:36:47 10.243.0.116 [  529.131364] 00000000b125007a: =
ffffffffbb85a8a0 (enable_ptr_key_workfn+0x30/0x30)
Nov 14 15:36:47 10.243.0.116 [  529.131380] 00000000cebc573b: =
ffff8883de2096d8 (0xffff8883de2096d8)
Nov 14 15:36:47 10.243.0.116 [  529.131392] 00000000a5fc355e: =
ffffffffbc653cf0 (__func__.55224+0x130/0xa40)
Nov 14 15:36:47 10.243.0.116 [  529.131407] 000000008a64698f: =
6666666666666666 (0x6666666666666666)
Nov 14 15:36:47 10.243.0.116 [  529.131419] 00000000ebabac1b: =
ffffffffbb1aed04 (space_used.isra.9+0x24/0x70)
Nov 14 15:36:47 10.243.0.116 [  529.131432] 00000000b220bd53: =
0000000000000010 (0x10)
Nov 14 15:36:47 10.243.0.116 [  529.131442] 000000007e4e2a59: =
ffff8883de209778 (0xffff8883de209778)
Nov 14 15:36:47 10.243.0.116 [  529.131454] 0000000015d0035c: =
0000000000000002 (0x2)
Nov 14 15:36:47 10.243.0.116 [  529.131464] 0000000063b6edda: =
ffffffffbc653cee (__func__.55224+0x12e/0xa40)
Nov 14 15:36:47 10.243.0.116 [  529.131479] 00000000da7968e1: =
ffffffffbe53a35e (__log_buf+0x18d3e/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131492] 00000000c3628767: =
ffff8883de209710 (0xffff8883de209710)
Nov 14 15:36:47 10.243.0.116 [  529.131504] 000000006d58dd1e: =
ffffffffbb4cbccd (memcpy+0x4d/0x70)
Nov 14 15:36:47 10.243.0.116 [  529.131517] 000000003eea0d3f: =
ffffffffbe53a434 (__log_buf+0x18e14/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131530] 0000000022f84f11: =
ffff8883de2097b8 (0xffff8883de2097b8)
Nov 14 15:36:47 10.243.0.116 [  529.131542] 00000000a5747a88: =
ffffffffbc653cf0 (__func__.55224+0x130/0xa40)
Nov 14 15:36:47 10.243.0.116 [  529.131557] 000000001f28fbc4: =
ffff8883de2097e0 (0xffff8883de2097e0)
Nov 14 15:36:47 10.243.0.116 [  529.131569] 0000000050be520f: =
ffffffffbb860889 (vsnprintf+0x659/0x8e0)
Nov 14 15:36:47 10.243.0.116 [  529.131581] 0000000067024a4c: =
09ff8883de209970 (0x9ff8883de209970)
Nov 14 15:36:47 10.243.0.116 [  529.131593] 000000007e4d11f7: =
1ffff1107bc412eb (0x1ffff1107bc412eb)
Nov 14 15:36:47 10.243.0.116 [  529.131605] 000000006eb87554: =
0000000000000039 (0x39)
Nov 14 15:36:47 10.243.0.116 [  529.131615] 0000000022cdf9cb: =
ffffffffbe53a638 (__log_buf+0x19018/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131628] 00000000d4591335: =
ffff8883de209ae8 (0xffff8883de209ae8)
Nov 14 15:36:47 10.243.0.116 [  529.131640] 00000000276e56c0: =
ffff8883de209778 (0xffff8883de209778)
Nov 14 15:36:47 10.243.0.116 [  529.131652] 000000003890a2c2: =
ffffffffbe53a739 (__log_buf+0x19119/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131664] 000000006ebc4411: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:47 10.243.0.116 [  529.131675] 0000000030cb32c4: =
80000000ffffc5f0 (0x80000000ffffc5f0)
Nov 14 15:36:47 10.243.0.116 [  529.131687] 00000000c2c357f9: =
ffff8883de209970 (0xffff8883de209970)
Nov 14 15:36:47 10.243.0.116 [  529.131699] 0000000029bfd7c2: =
1ffff1107bc412f4 (0x1ffff1107bc412f4)
Nov 14 15:36:47 10.243.0.116 [  529.131711] 00000000f0bd3f33: =
ffff8883de209788 (0xffff8883de209788)
Nov 14 15:36:47 10.243.0.116 [  529.131722] 0000000085ee32de: =
ffffffffbb4cbb64 (__kasan_check_write+0x14/0x20)
Nov 14 15:36:47 10.243.0.116 [  529.131737] 0000000015a2ee2a: =
ffff8883de209828 (0xffff8883de209828)
Nov 14 15:36:47 10.243.0.116 [  529.131749] 00000000d7c82f7f: =
0000000000000087 (0x87)
Nov 14 15:36:47 10.243.0.116 [  529.131759] 00000000eacad8a0: =
0000000ede2099b0 (0xede2099b0)
Nov 14 15:36:47 10.243.0.116 [  529.131770] 0000000031e8cb99: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:47 10.243.0.116 [  529.131781] 0000000072321493: =
ffffffffbcca4e67 (.LC0+0xbef/0x2536)
Nov 14 15:36:47 10.243.0.116 [  529.131793] 00000000ea5e2f62: =
ffffffffbb1ae670 (desc_make_final+0x80/0x80)
Nov 14 15:36:47 10.243.0.116 [  529.131806] 000000001c55a81f: =
ffff8883de2097f8 (0xffff8883de2097f8)
Nov 14 15:36:47 10.243.0.116 [  529.131818] 0000000007d3232b: =
00000000ffffc5fc (0xffffc5fc)
Nov 14 15:36:47 10.243.0.116 [  529.131829] 000000007005b795: =
ffff8883de2098b0 (0xffff8883de2098b0)
Nov 14 15:36:47 10.243.0.116 [  529.131840] 000000002d714708: =
ffffffffbe53ab50 (__log_buf+0x19530/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.131853] 00000000683d01be: =
0000000000000000 ...
Nov 14 15:36:47 10.243.0.116 [  529.131858] 00000000cac33919: =
ffff8883de2098b0 (0xffff8883de2098b0)
Nov 14 15:36:47 10.243.0.116 [  529.131870] 000000003aac650c: =
0000000000000038 (0x38)
Nov 14 15:36:47 10.243.0.116 [  529.131880] 00000000f7e63d6d: =
0000000000000029 (0x29)
Nov 14 15:36:47 10.243.0.116 [  529.131890] 00000000b23eb722: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:47 10.243.0.116 [  529.131902] 0000000030a37258: =
0000000000000037 (0x37)
Nov 14 15:36:47 10.243.0.116 [  529.131912] 00000000230eda56: =
ffff8883de227b2d (0xffff8883de227b2d)
Nov 14 15:36:47 10.243.0.116 [  529.131924] 000000004e4ea23f: =
0000000000000082 (0x82)
Nov 14 15:36:47 10.243.0.116 [  529.131934] 0000000054b24a9f: =
0000000000000002 (0x2)
Nov 14 15:36:47 10.243.0.116 [  529.131944] 000000005d6c8274: =
ffffffffbcf3fa40 (_printk_rb_static_infos+0x212c0/0x160020)
Nov 14 15:36:47 10.243.0.116 [  529.131961] 00000000ced9b71a: =
ffff8883de209838 (0xffff8883de209838)
Nov 14 15:36:47 10.243.0.116 [  529.131973] 00000000af2d2482: =
ffffffffbb1b027e (prb_final_commit+0xe/0x20)
Nov 14 15:36:47 10.243.0.116 [  529.131985] 00000000c8804ec0: =
ffff8883de209a58 (0xffff8883de209a58)
Nov 14 15:36:47 10.243.0.116 [  529.131997] 000000006aa0f304: =
0000000000000246 (0x246)
Nov 14 15:36:47 10.243.0.116 [  529.132008] 00000000db681876: =
ffff8883de209bf0 (0xffff8883de209bf0)
Nov 14 15:36:47 10.243.0.116 [  529.132019] 0000000042b2a7ab: =
0000007b32b9b2e4 (0x7b32b9b2e4)
Nov 14 15:36:47 10.243.0.116 [  529.132031] 0000000011d648e0: =
ffff8883de209930 (0xffff8883de209930)
Nov 14 15:36:47 10.243.0.116 [  529.132043] 000000007f041534: =
0000000080000000 (0x80000000)
Nov 14 15:36:47 10.243.0.116 [  529.132053] 000000001ad273ac: =
0000000000000246 (0x246)
Nov 14 15:36:47 10.243.0.116 [  529.132064] 000000006f742d5d: =
1ffff1107bc41312 (0x1ffff1107bc41312)
Nov 14 15:36:47 10.243.0.116 [  529.132076] 00000000362fb448: =
ffff8883de209970 (0xffff8883de209970)
Nov 14 15:36:47 10.243.0.116 [  529.132087] 000000004c798c91: =
0000000000000000 ...
Nov 14 15:36:47 10.243.0.116 [  529.132092] 000000001378e64d: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:47 10.243.0.116 [  529.132103] 0000000072098fe2: =
ffffffffbcca4d68 (.LC0+0xaf0/0x2536)
Nov 14 15:36:47 10.243.0.116 [  529.132115] 00000000dc0ac9a1: =
ffffffffbb1ad060 (printk_parse_prefix+0x10/0x10)
Nov 14 15:36:47 10.243.0.116 [  529.132128] 000000001acd665a: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:47 10.243.0.116 [  529.132139] 00000000e59ca6a3: =
ffffffff00000002 (0xffffffff00000002)
Nov 14 15:36:47 10.243.0.116 [  529.132151] 000000000e2442fb: =
ffffffffbb1ae670 (desc_make_final+0x80/0x80)
Nov 14 15:36:47 10.243.0.116 [  529.132163] 000000005387815d: =
0000000000000067 (0x67)
Nov 14 15:36:47 10.243.0.116 [  529.132173] 00000000a4995aa7: =
00000000ffffc5ae (0xffffc5ae)
Nov 14 15:36:47 10.243.0.116 [  529.132184] 00000000d43145ee: =
ffffffffbe539518 (__log_buf+0x17ef8/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.132197] 000000008984b050: =
ffff8883de209900 (0xffff8883de209900)
Nov 14 15:36:47 10.243.0.116 [  529.132209] 00000000b96b9174: =
ffffffffbb4cbc5d (memmove+0x4d/0x70)
Nov 14 15:36:47 10.243.0.116 [  529.132222] 00000000b021f99f: =
ffffffffbe539518 (__log_buf+0x17ef8/0x80020)
Nov 14 15:36:47 10.243.0.116 [  529.132234] 000000006d7be158: =
0000000000000004 (0x4)
Nov 14 15:36:47 10.243.0.116 [  529.132244] 000000008e6df9b1: =
ffff8883de2099b8 (0xffff8883de2099b8)
Nov 14 15:36:47 10.243.0.116 [  529.132256] 000000004869db8d: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:47 10.243.0.116 [  529.132268] 0000000001aee0cc: =
0000000000000067 (0x67)
Nov 14 15:36:47 10.243.0.116 [  529.132278] 000000004fccd22e: =
ffff8883de227b2d (0xffff8883de227b2d)
Nov 14 15:36:48 10.243.0.116 [  529.132290] 000000004372c524: =
0000000000000082 (0x82)
Nov 14 15:36:48 10.243.0.116 [  529.132300] 000000004abbd464: =
0000000000000002 (0x2)
Nov 14 15:36:48 10.243.0.116 [  529.132310] 000000006fcd69d2: =
ffffffffbcf3db50 (_printk_rb_static_infos+0x1f3d0/0x160020)
Nov 14 15:36:48 10.243.0.116 [  529.132326] 000000009439164a: =
ffffffffbcf40598 (_printk_rb_static_infos+0x21e18/0x160020)
Nov 14 15:36:48 10.243.0.116 [  529.132342] 000000008f5a51aa: =
ffffffffbe53b6b0 (__log_buf+0x1a090/0x80020)
Nov 14 15:36:48 10.243.0.116 [  529.132354] 00000000ac4d84bc: =
ffff888300000040 (0xffff888300000040)
Nov 14 15:36:48 10.243.0.116 [  529.132366] 000000009c3ce432: =
0000000000000246 (0x246)
Nov 14 15:36:48 10.243.0.116 [  529.132376] 000000007a45154d: =
ffffffffbcca38cd (.LC11+0x52cd/0x5c78)
Nov 14 15:36:48 10.243.0.116 [  529.132389] 0000000049a0772a: =
0000007b32a7f430 (0x7b32a7f430)
Nov 14 15:36:48 10.243.0.116 [  529.132400] 0000000077a21716: =
ffff8883de209a38 (0xffff8883de209a38)
Nov 14 15:36:48 10.243.0.116 [  529.132412] 00000000d46d4179: =
ffffffff80000000 (0xffffffff80000000)
Nov 14 15:36:48 10.243.0.116 [  529.132424] 00000000f51abe41: =
ffffffffbcf1e700 (prb+0x40/0x40)
Nov 14 15:36:48 10.243.0.116 [  529.132437] 000000005388a0e3: =
0000000000000097 (0x97)
Nov 14 15:36:48 10.243.0.116 [  529.132448] 000000003a2562c0: =
00000000ffffc633 (0xffffc633)
Nov 14 15:36:48 10.243.0.116 [  529.132459] 000000006005e98a: =
0000000000000040 (0x40)
Nov 14 15:36:48 10.243.0.116 [  529.132469] 000000003980664b: =
0000000000000000 ...
Nov 14 15:36:48 10.243.0.116 [  529.132473] 000000006ac84573: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:48 10.243.0.116 [  529.132484] 000000003f940649: =
ffffffffbcca4d68 (.LC0+0xaf0/0x2536)
Nov 14 15:36:48 10.243.0.116 [  529.132497] 0000000083fb5b49: =
ffffffffbb1ad060 (printk_parse_prefix+0x10/0x10)
Nov 14 15:36:48 10.243.0.116 [  529.132509] 00000000d29f9f88: =
ffff888300000028 (0xffff888300000028)
Nov 14 15:36:48 10.243.0.116 [  529.132521] 00000000af2f612b: =
ffff8883de209b70 (0xffff8883de209b70)
Nov 14 15:36:48 10.243.0.116 [  529.132533] 000000005c6cdf03: =
ffff8883de209b28 (0xffff8883de209b28)
Nov 14 15:36:48 10.243.0.116 [  529.132544] 00000000c3716aaf: =
ffffed107bc41340 (0xffffed107bc41340)
Nov 14 15:36:48 10.243.0.116 [  529.132556] 0000000048930860: =
0000000000000000 ...
Nov 14 15:36:48 10.243.0.116 [  529.132561] 000000009e1c9be9: =
ffffffffc0d34030 (netconsole+0x10/0xffffffffffffdfe0 [netconsole])
Nov 14 15:36:48 10.243.0.116 [  529.132587] 000000000c9d185b: =
ffff8883de227b18 (0xffff8883de227b18)
Nov 14 15:36:48 10.243.0.116 [  529.132598] 000000005ec3c23d: =
ffff8883de227b10 (0xffff8883de227b10)
Nov 14 15:36:48 10.243.0.116 [  529.132610] 00000000b3de6f5c: =
0000000000000000 ...
Nov 14 15:36:48 10.243.0.116 [  529.132615] 0000000036f9187b: =
ffff8883de209a08 (0xffff8883de209a08)
Nov 14 15:36:48 10.243.0.116 [  529.132626] 000000001ce1c746: =
ffffffffbb4cbb64 (__kasan_check_write+0x14/0x20)
Nov 14 15:36:48 10.243.0.116 [  529.132641] 00000000f2e813a1: =
ffff8883de209a28 (0xffff8883de209a28)
Nov 14 15:36:48 10.243.0.116 [  529.132652] 0000000062195896: =
ffffffffbb2d8be3 (irq_work_claim+0x23/0x50)
Nov 14 15:36:48 10.243.0.116 [  529.132668] 00000000689e2328: =
ffff8883de227b10 (0xffff8883de227b10)
Nov 14 15:36:48 10.243.0.116 [  529.132680] 00000000a7abb420: =
00000000ffffffff (0xffffffff)
Nov 14 15:36:48 10.243.0.116 [  529.132691] 000000004ecc7499: =
ffff8883de227b18 (0xffff8883de227b18)
Nov 14 15:36:48 10.243.0.116 [  529.132702] 00000000ca9cf222: =
ffff8883de227b10 (0xffff8883de227b10)
Nov 14 15:36:48 10.243.0.116 [  529.132714] 00000000b1d7ae89: =
ffff8883de209d28 (0xffff8883de209d28)
Nov 14 15:36:48 10.243.0.116 [  529.132726] 000000004796b255: =
ffff8883de209a50 (0xffff8883de209a50)
Nov 14 15:36:48 10.243.0.116 [  529.132738] 000000008546273e: =
ffffffffbb4cbb64 (__kasan_check_write+0x14/0x20)
Nov 14 15:36:48 10.243.0.116 [  529.132752] 00000000b76fabfe: =
ffff8883de209a70 (0xffff8883de209a70)
Nov 14 15:36:48 10.243.0.116 [  529.132764] 000000000ae0383e: =
ffffffffbb2d8be3 (irq_work_claim+0x23/0x50)
Nov 14 15:36:48 10.243.0.116 [  529.132778] 00000000a93f1368: =
ffff8883de227b10 (0xffff8883de227b10)
Nov 14 15:36:48 10.243.0.116 [  529.132790] 00000000332b6372: =
0000000000000000 ...
Nov 14 15:36:48 10.243.0.116 [  529.132795] 00000000f67a8c42: =
ffff8883de209a90 (0xffff8883de209a90)
Nov 14 15:36:48 10.243.0.116 [  529.132807] 000000000b1d91f0: =
ffffffffbb2d8d61 (irq_work_queue+0x11/0x40)
Nov 14 15:36:48 10.243.0.116 [  529.132822] 00000000d3b34959: =
0000000000000000 ...
Nov 14 15:36:48 10.243.0.116 [  529.132826] 0000000000a68d4f: =
0000000000000026 (0x26)
Nov 14 15:36:48 10.243.0.116 [  529.132837] 000000001013493c: =
ffff8883de209aa0 (0xffff8883de209aa0)
Nov 14 15:36:48 10.243.0.116 [  529.132848] 0000000073d6f50f: =
ffffffffbb1aaf5b (__wake_up_klogd.part.28+0x3b/0x50)
Nov 14 15:36:48 10.243.0.116 [  529.132865] 00000000c90cd880: =
ffff8883de209ab8 (0xffff8883de209ab8)
Nov 14 15:36:48 10.243.0.116 [  529.132877] 00000000d8526066: =
ffffffffbb1ae03e (vprintk_deferred+0x2e/0x40)
Nov 14 15:36:48 10.243.0.116 [  529.132890] 0000000074ae61bd: =
ffffed107bc41359 (0xffffed107bc41359)
Nov 14 15:36:48 10.243.0.116 [  529.132901] 0000000072d580b9: =
ffff8883de209b60 (0xffff8883de209b60)
Nov 14 15:36:48 10.243.0.116 [  529.132913] 00000000428b2550: =
ffffffffbc0c0dbf (_printk_deferred+0x9a/0xc4)
Nov 14 15:36:48 10.243.0.116 [  529.132930] 0000000073070417: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:48 10.243.0.116 [  529.132941] 0000000018bb4b5a: =
ffffffffbcc91fb2 (msr_save_dmi_table+0x203652/0x2093e4)
Nov 14 15:36:48 10.243.0.116 [  529.132955] 0000000058ad4334: =
ffffffffbc0c0d25 (suspend_console.cold.46+0x29/0x29)
Nov 14 15:36:48 10.243.0.116 [  529.132970] 00000000f8c8cd34: =
ffffffffbe520e40 (ext_text.52517+0x2020/0x2020)
Nov 14 15:36:48 10.243.0.116 [  529.132983] 00000000ba49adfa: =
ffff888300000028 (0xffff888300000028)
Nov 14 15:36:48 10.243.0.116 [  529.132995] 00000000aa3c150a: =
ffff8883de209b70 (0xffff8883de209b70)
Nov 14 15:36:48 10.243.0.116 [  529.133007] 000000000595b4d8: =
ffff8883de209b28 (0xffff8883de209b28)
Nov 14 15:36:48 10.243.0.116 [  529.133019] 00000000e0ce4622: =
ffff8883de209b10 (0xffff8883de209b10)
Nov 14 15:36:48 10.243.0.116 [  529.133031] 0000000041edaae1: =
ffffffffbb4cbb64 (__kasan_check_write+0x14/0x20)
Nov 14 15:36:48 10.243.0.116 [  529.133045] 00000000aa8959ed: =
ffff8883de209b30 (0xffff8883de209b30)
Nov 14 15:36:48 10.243.0.116 [  529.133056] 00000000ce0fe119: =
ffffffffbc1168d7 (get_stack_info_noinstr+0x17/0xf0)
Nov 14 15:36:48 10.243.0.116 [  529.133073] 00000000cf07427a: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:48 10.243.0.116 [  529.133085] 00000000dcd0aea6: =
ffff8883de209ba0 (0xffff8883de209ba0)
Nov 14 15:36:48 10.243.0.116 [  529.133097] 000000008a053701: =
ffff8883de209b28 (0xffff8883de209b28)
Nov 14 15:36:48 10.243.0.116 [  529.133108] 00000000c0841b80: =
0000000000000010 (0x10)
Nov 14 15:36:48 10.243.0.116 [  529.133119] 00000000225f2906: =
0000000000000010 (0x10)
Nov 14 15:36:48 10.243.0.116 [  529.133129] 000000000eb7339a: =
0000000000000010 (0x10)
Nov 14 15:36:48 10.243.0.116 [  529.133139] 00000000375afe86: =
0000000000000010 (0x10)
Nov 14 15:36:48 10.243.0.116 [  529.133149] 00000000bd2fe889: =
1ffff1107bc41370 (0x1ffff1107bc41370)
Nov 14 15:36:48 10.243.0.116 [  529.133161] 0000000075557976: =
ffff8883de209c68 (0xffff8883de209c68)
Nov 14 15:36:48 10.243.0.116 [  529.133172] 00000000b4a616c5: =
ffffffffbc0b55b9 (unwind_dump.cold.5+0xcd/0x14a)
Nov 14 15:36:48 10.243.0.116 [  529.133189] 00000000b58a3533: =
ffffffffbc0b55b9 (unwind_dump.cold.5+0xcd/0x14a)
Nov 14 15:36:48 10.243.0.116 [  529.133205] 000000006aae4f94: =
ffff8883de209d50 (0xffff8883de209d50)
Nov 14 15:36:48 10.243.0.116 [  529.133216] 0000000095c7ab22: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:48 10.243.0.116 [  529.133227] 000000006bcfb2eb: =
ffffffffbcc9cce8 (.LC0+0x22e/0xf26)
Nov 14 15:36:48 10.243.0.116 [  529.133240] 00000000fbbc5bab: =
ffffffffbb09a9f0 (__read_once_word_nocheck+0x10/0x10)
Nov 14 15:36:48 10.243.0.116 [  529.133254] 00000000c8e74825: =
ffff8883de209ba8 (0xffff8883de209ba8)
Nov 14 15:36:48 10.243.0.116 [  529.133266] 00000000ebaea821: =
0000000000000004 (0x4)
Nov 14 15:36:48 10.243.0.116 [  529.133276] 00000000f78d2edd: =
ffff8883de209bc0 (0xffff8883de209bc0)
Nov 14 15:36:48 10.243.0.116 [  529.133288] 000000009dcf7811: =
ffffffffbb1ae03e (vprintk_deferred+0x2e/0x40)
Nov 14 15:36:48 10.243.0.116 [  529.133300] 0000000057e33732: =
ffffed107bc4137a (0xffffed107bc4137a)
Nov 14 15:36:48 10.243.0.116 [  529.133312] 0000000076ef0285: =
ffff8883de209c68 (0xffff8883de209c68)
Nov 14 15:36:48 10.243.0.116 [  529.133323] 000000008e3560a2: =
ffffffffbc0c0dbf (_printk_deferred+0x9a/0xc4)
Nov 14 15:36:48 10.243.0.116 [  529.133338] 00000000471659b5: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:48 10.243.0.116 [  529.133349] 0000000016b309ea: =
ffffffffbcc91fb2 (msr_save_dmi_table+0x203652/0x2093e4)
Nov 14 15:36:48 10.243.0.116 [  529.133363] 00000000380170f6: =
0000000000000002 (0x2)
Nov 14 15:36:48 10.243.0.116 [  529.133373] 00000000ae80c40b: =
ffff8883de202000 (0xffff8883de202000)
Nov 14 15:36:48 10.243.0.116 [  529.133385] 00000000e3d881c7: =
ffff8883de20a000 (0xffff8883de20a000)
Nov 14 15:36:48 10.243.0.116 [  529.133397] 000000009daee861: =
ffff8881008ff8d0 (0xffff8881008ff8d0)
Nov 14 15:36:48 10.243.0.116 [  529.133408] 000000000c98541e: =
ffff8883de209c30 (0xffff8883de209c30)
Nov 14 15:36:48 10.243.0.116 [  529.133420] 00000000627c5592: =
ffff8883de209c68 (0xffff8883de209c68)
Nov 14 15:36:48 10.243.0.116 [  529.133432] 00000000aff50ac2: =
ffffffffbb09ac07 (update_stack_state+0x107/0x240)
Nov 14 15:36:48 10.243.0.116 [  529.133445] 000000003db28f9d: =
ffff8883de209568 (0xffff8883de209568)
Nov 14 15:36:48 10.243.0.116 [  529.133457] 00000000e2261d7e: =
0000000000000000 ...
Nov 14 15:36:48 10.243.0.116 [  529.133462] 00000000b72fd78d: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:48 10.243.0.116 [  529.133474] 000000000fc82b45: =
ffff8883de209508 (0xffff8883de209508)
Nov 14 15:36:48 10.243.0.116 [  529.133485] 00000000d8e03dfa: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:48 10.243.0.116 [  529.133497] 00000000743d17c1: =
ffff8883de209d28 (0xffff8883de209d28)
Nov 14 15:36:48 10.243.0.116 [  529.133509] 00000000f14ae4fb: =
ffff8881008f0000 (0xffff8881008f0000)
Nov 14 15:36:48 10.243.0.116 [  529.133521] 00000000a475e855: =
0000000000000007 (0x7)
Nov 14 15:36:48 10.243.0.116 [  529.133530] 00000000b01b20d2: =
ffff8881008f0000 (0xffff8881008f0000)
Nov 14 15:36:48 10.243.0.116 [  529.133542] 00000000b30810fb: =
ffff8883de209d80 (0xffff8883de209d80)
Nov 14 15:36:48 10.243.0.116 [  529.133554] 00000000b89c7941: =
ffff8883de209cc8 (0xffff8883de209cc8)
Nov 14 15:36:48 10.243.0.116 [  529.133566] 0000000041ede0f7: =
ffffffffbb09af74 (unwind_next_frame.part.4+0x1e4/0x3b0)
Nov 14 15:36:48 10.243.0.116 [  529.133580] 000000007c607d29: =
ffff8883de209ca8 (0xffff8883de209ca8)
Nov 14 15:36:48 10.243.0.116 [  529.133591] 0000000076eb8f83: =
ffffffffbcc98b0d (.LC1+0xdc9/0x4d76)
Nov 14 15:36:48 10.243.0.116 [  529.133604] 000000004a8c15ad: =
ffff8883de209d60 (0xffff8883de209d60)
Nov 14 15:36:48 10.243.0.116 [  529.133616] 0000000036baea76: =
ffff8883de209508 (0xffff8883de209508)
Nov 14 15:36:48 10.243.0.116 [  529.133627] 00000000ae384451: =
ffff8883de209d50 (0xffff8883de209d50)
Nov 14 15:36:48 10.243.0.116 [  529.133639] 0000000026e69587: =
ffff8883de209d28 (0xffff8883de209d28)
Nov 14 15:36:48 10.243.0.116 [  529.133651] 00000000de275070: =
0000000000000000 ...
Nov 14 15:36:48 10.243.0.116 [  529.133656] 00000000650ef2cc: =
ffff8881008f0000 (0xffff8881008f0000)
Nov 14 15:36:48 10.243.0.116 [  529.133667] 0000000060521f0e: =
ffffffffbccbbb31 (.LC115+0x223/0x557)
Nov 14 15:36:48 10.243.0.116 [  529.133680] 00000000fab9cdd6: =
ffffffffbcc98b0d (.LC1+0xdc9/0x4d76)
Nov 14 15:36:48 10.243.0.116 [  529.133692] 00000000bab62068: =
ffff8883de209ce0 (0xffff8883de209ce0)
Nov 14 15:36:48 10.243.0.116 [  529.133704] 000000000c7e4825: =
ffffffffbb09b15b (unwind_next_frame+0x1b/0x30)
Nov 14 15:36:48 10.243.0.116 [  529.133717] 000000001c3965ea: =
ffff8883de209560 (0xffff8883de209560)
Nov 14 15:36:48 10.243.0.116 [  529.133729] 00000000b7c5c49b: =
ffff8883de209db8 (0xffff8883de209db8)
Nov 14 15:36:48 10.243.0.116 [  529.133741] 00000000ac071018: =
ffffffffbc0b17f5 (show_trace_log_lvl+0x1f9/0x296)
Nov 14 15:36:48 10.243.0.116 [  529.133754] 00000000bc9c9dd5: =
ffffffffbb002712 (ret_from_fork+0x22/0x30)
Nov 14 15:36:48 10.243.0.116 [  529.133768] 000000000f56a718: =
ffff8883de209560 (0xffff8883de209560)
Nov 14 15:36:48 10.243.0.116 [  529.133779] 00000000e9c18dc2: =
0000000000000004 (0x4)
Nov 14 15:36:48 10.243.0.116 [  529.133789] 00000000188c828d: =
0000000000000002 (0x2)
Nov 14 15:36:48 10.243.0.116 [  529.133799] 0000000081360797: =
ffff8883de202000 (0xffff8883de202000)
Nov 14 15:36:48 10.243.0.116 [  529.133811] 0000000016ee3f0e: =
ffff8883de20a000 (0xffff8883de20a000)
Nov 14 15:36:48 10.243.0.116 [  529.133822] 000000005c8c6dab: =
ffff8881008ff8d0 (0xffff8881008ff8d0)
Nov 14 15:36:49 10.243.0.116 [  529.133834] 00000000741037a5: =
0000000000000002 (0x2)
Nov 14 15:36:49 10.243.0.116 [  529.133844] 00000000f4d844df: =
ffff8883de202000 (0xffff8883de202000)
Nov 14 15:36:49 10.243.0.116 [  529.133856] 0000000092677788: =
ffff8883de20a000 (0xffff8883de20a000)
Nov 14 15:36:49 10.243.0.116 [  529.133867] 00000000cf395131: =
ffff8881008ff8d0 (0xffff8881008ff8d0)
Nov 14 15:36:49 10.243.0.116 [  529.133879] 00000000f682fe51: =
0000000000000004 (0x4)
Nov 14 15:36:49 10.243.0.116 [  529.133889] 00000000b0e88e7d: =
ffff8881008f0000 (0xffff8881008f0000)
Nov 14 15:36:49 10.243.0.116 [  529.133901] 00000000ca2ebd51: =
0000010100000000 (0x10100000000)
Nov 14 15:36:49 10.243.0.116 [  529.133912] 00000000af8db30c: =
ffff8883de209558 (0xffff8883de209558)
Nov 14 15:36:49 10.243.0.116 [  529.133924] 00000000221c07cb: =
ffff8883de209558 (0xffff8883de209558)
Nov 14 15:36:49 10.243.0.116 [  529.133936] 000000008aac9934: =
ffff8883de209628 (0xffff8883de209628)
Nov 14 15:36:49 10.243.0.116 [  529.133947] 00000000997756d0: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.133952] 000000003760ac0a: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:49 10.243.0.116 [  529.133964] 00000000ae588beb: =
ffff8883de258800 (0xffff8883de258800)
Nov 14 15:36:49 10.243.0.116 [  529.133976] 00000000831eed5a: =
ffff8883de258800 (0xffff8883de258800)
Nov 14 15:36:49 10.243.0.116 [  529.133987] 00000000c7f3bb99: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.133992] 00000000662f8ee6: =
0000000000000016 (0x16)
Nov 14 15:36:49 10.243.0.116 [  529.134002] 00000000f2be797d: =
00000000ee6b2800 (0xee6b2800)
Nov 14 15:36:49 10.243.0.116 [  529.134013] 0000000060a61a2a: =
ffff8883de209dd0 (0xffff8883de209dd0)
Nov 14 15:36:49 10.243.0.116 [  529.134025] 0000000038d8a03d: =
ffffffffbc0b190a (show_regs.cold.17+0x1a/0x1f)
Nov 14 15:36:49 10.243.0.116 [  529.134038] 000000009029f41b: =
ffff8881008f0000 (0xffff8881008f0000)
Nov 14 15:36:49 10.243.0.116 [  529.134050] 000000000d9c2b39: =
ffff8883de209e08 (0xffff8883de209e08)
Nov 14 15:36:49 10.243.0.116 [  529.134062] 00000000bd7966f4: =
ffffffffbb2940b0 (watchdog_timer_fn+0x210/0x280)
Nov 14 15:36:49 10.243.0.116 [  529.134076] 00000000973eb3e4: =
ffff8883de25c260 (0xffff8883de25c260)
Nov 14 15:36:49 10.243.0.116 [  529.134088] 00000000d856845d: =
ffff8883de25b3c0 (0xffff8883de25b3c0)
Nov 14 15:36:49 10.243.0.116 [  529.134099] 0000000053bc3834: =
ffff8883de25b440 (0xffff8883de25b440)
Nov 14 15:36:49 10.243.0.116 [  529.134111] 00000000e9f58748: =
ffffffffbd7479e0 (__cpu_present_mask+0x400/0x400)
Nov 14 15:36:49 10.243.0.116 [  529.134126] 0000000075cdd591: =
ffffffffbb293ea0 (lockup_detector_update_enable+0x50/0x50)
Nov 14 15:36:49 10.243.0.116 [  529.134141] 00000000b4e817d1: =
ffff8883de209ef0 (0xffff8883de209ef0)
Nov 14 15:36:49 10.243.0.116 [  529.134153] 0000000087c03c30: =
ffffffffbb1f6f6d (__hrtimer_run_queues+0x38d/0x730)
Nov 14 15:36:49 10.243.0.116 [  529.134169] 0000000003c7cd6c: =
1ffff1107bc413cd (0x1ffff1107bc413cd)
Nov 14 15:36:49 10.243.0.116 [  529.134181] 00000000a70c59f9: =
0000007b0a3a037d (0x7b0a3a037d)
Nov 14 15:36:49 10.243.0.116 [  529.134192] 00000000ae282e6b: =
00000000008f0dd8 (0x8f0dd8)
Nov 14 15:36:49 10.243.0.116 [  529.134203] 000000001b694a5a: =
ffff8883de209e40 (0xffff8883de209e40)
Nov 14 15:36:49 10.243.0.116 [  529.134215] 000000006e1cc746: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.134219] 000000002c95dd6a: =
ffff8883de25b498 (0xffff8883de25b498)
Nov 14 15:36:49 10.243.0.116 [  529.134231] 00000000375b8266: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.134236] 00000000fde59118: =
ffff8883de25b450 (0xffff8883de25b450)
Nov 14 15:36:49 10.243.0.116 [  529.134248] 00000000ce81d14c: =
ffff8883de25b3c0 (0xffff8883de25b3c0)
Nov 14 15:36:49 10.243.0.116 [  529.134259] 000000002c6d5c77: =
ffff8883de25b488 (0xffff8883de25b488)
Nov 14 15:36:49 10.243.0.116 [  529.134271] 00000000a569fe40: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:49 10.243.0.116 [  529.134282] 00000000310ff610: =
ffffffffbcca7192 (.LC2+0x9e4/0xa452)
Nov 14 15:36:49 10.243.0.116 [  529.134294] 00000000409a0852: =
ffffffffbb1f6be0 (enqueue_hrtimer+0x180/0x180)
Nov 14 15:36:49 10.243.0.116 [  529.134310] 0000000083e8f8e7: =
ffff8883de25b3c0 (0xffff8883de25b3c0)
Nov 14 15:36:49 10.243.0.116 [  529.134322] 00000000f10fc082: =
0000007b0a3a037d (0x7b0a3a037d)
Nov 14 15:36:49 10.243.0.116 [  529.134333] 0000000046cceb63: =
ffffffffbb1c38ee (inband_irq_restore+0xe/0x20)
Nov 14 15:36:49 10.243.0.116 [  529.134346] 0000000047adf15b: =
ffff8883de209ef0 (0xffff8883de209ef0)
Nov 14 15:36:49 10.243.0.116 [  529.134358] 000000009202353f: =
ffffffffbb1fd6fe (ktime_get_update_offsets_now+0xee/0x200)
Nov 14 15:36:49 10.243.0.116 [  529.134373] 00000000647e6db1: =
ffff8883de25b628 (0xffff8883de25b628)
Nov 14 15:36:49 10.243.0.116 [  529.134384] 0000000072b985f8: =
ffff8883de25b5a8 (0xffff8883de25b5a8)
Nov 14 15:36:49 10.243.0.116 [  529.134396] 00000000f16adde1: =
ffff8883de25b528 (0xffff8883de25b528)
Nov 14 15:36:49 10.243.0.116 [  529.134408] 00000000cbd7ef02: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:49 10.243.0.116 [  529.134420] 0000000031881ce5: =
ffff8883de25b3c0 (0xffff8883de25b3c0)
Nov 14 15:36:49 10.243.0.116 [  529.134432] 00000000bdf19510: =
0000007b0a3a037d (0x7b0a3a037d)
Nov 14 15:36:49 10.243.0.116 [  529.134443] 000000002a021434: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.134447] 00000000551bbf16: =
ffff8883de25b40c (0xffff8883de25b40c)
Nov 14 15:36:49 10.243.0.116 [  529.134459] 00000000b0f8a932: =
ffff8883de25b528 (0xffff8883de25b528)
Nov 14 15:36:49 10.243.0.116 [  529.134471] 0000000090f9dab7: =
ffff8883de209f88 (0xffff8883de209f88)
Nov 14 15:36:49 10.243.0.116 [  529.134483] 00000000e439fb99: =
ffffffffbb1f85c5 (hrtimer_interrupt+0x1a5/0x350)
Nov 14 15:36:49 10.243.0.116 [  529.134499] 000000006f1a6586: =
0000007b0a3a037d (0x7b0a3a037d)
Nov 14 15:36:49 10.243.0.116 [  529.134510] 0000000051c8bb38: =
000000030635b600 (0x30635b600)
Nov 14 15:36:49 10.243.0.116 [  529.134521] 00000000b7f950ad: =
ffff8883de25b408 (0xffff8883de25b408)
Nov 14 15:36:49 10.243.0.116 [  529.134533] 000000008e7d930d: =
ffff8883de25b828 (0xffff8883de25b828)
Nov 14 15:36:49 10.243.0.116 [  529.134545] 00000000ef911a43: =
ffff8883de25b7a8 (0xffff8883de25b7a8)
Nov 14 15:36:49 10.243.0.116 [  529.134557] 00000000ad03c251: =
ffff8883de25b728 (0xffff8883de25b728)
Nov 14 15:36:49 10.243.0.116 [  529.134568] 00000000beffc89e: =
ffff8883de25b430 (0xffff8883de25b430)
Nov 14 15:36:49 10.243.0.116 [  529.134580] 00000000d36a9c73: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:49 10.243.0.116 [  529.134591] 00000000476ccfaa: =
7fffffffffffffff (0x7fffffffffffffff)
Nov 14 15:36:49 10.243.0.116 [  529.134603] 00000000671568eb: =
ffff8883de25b420 (0xffff8883de25b420)
Nov 14 15:36:49 10.243.0.116 [  529.134615] 00000000f5c8f455: =
ffff8883de25b628 (0xffff8883de25b628)
Nov 14 15:36:49 10.243.0.116 [  529.134626] 00000000663e8768: =
ffff8883de25b5a8 (0xffff8883de25b5a8)
Nov 14 15:36:49 10.243.0.116 [  529.134638] 0000000018aacc2f: =
ffff8883de25bec0 (0xffff8883de25bec0)
Nov 14 15:36:49 10.243.0.116 [  529.134650] 000000002b12bb4d: =
ffff88810635b600 (0xffff88810635b600)
Nov 14 15:36:49 10.243.0.116 [  529.134662] 00000000f62261b2: =
000000000000001a (0x1a)
Nov 14 15:36:49 10.243.0.116 [  529.134672] 0000000073995e4f: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.134677] 00000000eb7f3bf6: =
ffff888100063400 (0xffff888100063400)
Nov 14 15:36:49 10.243.0.116 [  529.134689] 00000000b13173bd: =
ffff8883de209fa0 (0xffff8883de209fa0)
Nov 14 15:36:49 10.243.0.116 [  529.134700] 0000000049b431bb: =
ffffffffbb218342 (proxy_irq_handler+0x32/0x40)
Nov 14 15:36:49 10.243.0.116 [  529.134716] 00000000131ae12f: =
ffff8883de25bec0 (0xffff8883de25bec0)
Nov 14 15:36:49 10.243.0.116 [  529.134727] 00000000bb2d04cc: =
ffff8883de209fd0 (0xffff8883de209fd0)
Nov 14 15:36:49 10.243.0.116 [  529.134739] 00000000930535d7: =
ffffffffbb1c2882 (handle_synthetic_irq+0xd2/0x300)
Nov 14 15:36:49 10.243.0.116 [  529.134753] 00000000fe23b11c: =
ffff8881076d6000 (0xffff8881076d6000)
Nov 14 15:36:49 10.243.0.116 [  529.134765] 00000000a415a2b4: =
000000000000001a (0x1a)
Nov 14 15:36:49 10.243.0.116 [  529.134775] 0000000020f9babf: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.134780] 00000000c17bcf18: =
ffff8883de209fe8 (0xffff8883de209fe8)
Nov 14 15:36:49 10.243.0.116 [  529.134791] 0000000081018e16: =
ffffffffbb0993fa (do_irq_inband+0x2a/0x40)
Nov 14 15:36:49 10.243.0.116 [  529.134804] 00000000732cf632: =
ffff8883de258800 (0xffff8883de258800)
Nov 14 15:36:49 10.243.0.116 [  529.134816] 00000000c06676cd: =
ffff8881008ff8f8 (0xffff8881008ff8f8)
Nov 14 15:36:49 10.243.0.116 [  529.134827] 00000000c1f1d9ee: =
ffffffffbb0995c7 (arch_do_IRQ_pipelined+0xb7/0x5a0)
Nov 14 15:36:49 10.243.0.116 [  529.134841] 000000002752a675: =
ffff8881008ff8d0 (0xffff8881008ff8d0)
Nov 14 15:36:49 10.243.0.116 [  529.134853] 00000000f67bf0e4: =
0000000000000069 (0x69)
Nov 14 15:36:49 10.243.0.116 [  529.134863] 000000001676c077: =
000000000000001a (0x1a)
Nov 14 15:36:49 10.243.0.116 [  529.134873] 000000007318ac7d: =
ffff8881076d6000 (0xffff8881076d6000)
Nov 14 15:36:49 10.243.0.116 [  529.134885] 00000000f30cdb32: =
ffffffffbce0f4c8 (desc_cache+0x348/0x400)
Nov 14 15:36:49 10.243.0.116 [  529.134900] 0000000030519f56: =
ffff8883de2587c0 (0xffff8883de2587c0)
Nov 14 15:36:49 10.243.0.116 [  529.134912] 0000000029065785: =
ffff8881008ff970 (0xffff8881008ff970)
Nov 14 15:36:49 10.243.0.116 [  529.134924] 00000000c42b0c2f: =
ffffffffbb1c326e (sync_current_irq_stage+0x2de/0x500)
Nov 14 15:36:49 10.243.0.116 [  529.134938] 000000005691593f: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.134942] 0000000097622b82: =
0000000000000200 (0x200)
Nov 14 15:36:49 10.243.0.116 [  529.134953] 000000007ae62693: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.134958] 00000000e32336f0: =
ffff8883de227b60 (0xffff8883de227b60)
Nov 14 15:36:49 10.243.0.116 [  529.134969] 000000005620ed6b: =
ffff8883de2587c8 (0xffff8883de2587c8)
Nov 14 15:36:49 10.243.0.116 [  529.134981] 00000000137745d7: =
ffffffffbd0e79e0 (sirq_chip+0x140/0x140)
Nov 14 15:36:49 10.243.0.116 [  529.134996] 000000000e5fa6dd: =
ffff8883de2587c0 (0xffff8883de2587c0)
Nov 14 15:36:49 10.243.0.116 [  529.135008] 000000004ca75486: =
ffffffffbd0e79e0 (sirq_chip+0x140/0x140)
Nov 14 15:36:49 10.243.0.116 [  529.135023] 00000000e54fd845: =
00000000000587c0 (0x587c0)
Nov 14 15:36:49 10.243.0.116 [  529.135034] 00000000f0eaf87b: =
ffff8881008f0dd8 (0xffff8881008f0dd8)
Nov 14 15:36:49 10.243.0.116 [  529.135045] 00000000bc84aa23: =
00000000000646a0 (0x646a0)
Nov 14 15:36:49 10.243.0.116 [  529.135056] 0000000094d709a1: =
ffff8881008ff9a0 (0xffff8881008ff9a0)
Nov 14 15:36:49 10.243.0.116 [  529.135068] 000000008b67c0b4: =
ffffffffbb1c363a (sync_irq_stage+0x1aa/0x1e0)
Nov 14 15:36:49 10.243.0.116 [  529.135081] 00000000d702cf4e: =
ffff8883de2587c0 (0xffff8883de2587c0)
Nov 14 15:36:49 10.243.0.116 [  529.135093] 00000000c01db597: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.135097] 000000008c242e0b: =
ffff8881008f0000 (0xffff8881008f0000)
Nov 14 15:36:49 10.243.0.116 [  529.135109] 0000000026f688ad: =
ffffffffbe5b2d40 (synthetic_irq_domain+0x40/0x40)
Nov 14 15:36:49 10.243.0.116 [  529.135123] 000000009eee558f: =
ffff8881008ff9d0 (0xffff8881008ff9d0)
Nov 14 15:36:49 10.243.0.116 [  529.135135] 00000000c82ca2ba: =
ffffffffbb1c36f6 (synchronize_pipeline+0x86/0xe0)
Nov 14 15:36:49 10.243.0.116 [  529.135149] 000000006e8cf4d6: =
ffff8883de2587c0 (0xffff8883de2587c0)
Nov 14 15:36:49 10.243.0.116 [  529.135161] 00000000f25dd0f4: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.135165] 00000000e94c724e: =
ffff8881008ffa58 (0xffff8881008ffa58)
Nov 14 15:36:49 10.243.0.116 [  529.135177] 000000003904355e: =
ffff8883de2587c0 (0xffff8883de2587c0)
Nov 14 15:36:49 10.243.0.116 [  529.135189] 0000000091b84a2c: =
ffff8881008ffa08 (0xffff8881008ffa08)
Nov 14 15:36:49 10.243.0.116 [  529.135201] 00000000e3d1c0f2: =
ffffffffbb1c4031 (handle_irq_pipelined_finish+0xf1/0x240)
Nov 14 15:36:49 10.243.0.116 [  529.135215] 000000002ff9b1f8: =
ffff8881008ffa58 (0xffff8881008ffa58)
Nov 14 15:36:49 10.243.0.116 [  529.135227] 000000009924227a: =
ffff8881008f0dd8 (0xffff8881008f0dd8)
Nov 14 15:36:49 10.243.0.116 [  529.135239] 000000006c672157: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.135244] 000000002d7e5258: =
ffff8883de2587c0 (0xffff8883de2587c0)
Nov 14 15:36:49 10.243.0.116 [  529.135255] 00000000c2584c15: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.135260] 00000000f938db81: =
ffff8881008ffa38 (0xffff8881008ffa38)
Nov 14 15:36:49 10.243.0.116 [  529.135272] 0000000018f28934: =
ffffffffbc117fc1 (arch_pipeline_entry+0x81/0x110)
Nov 14 15:36:49 10.243.0.116 [  529.135285] 0000000094248c06: =
0000000000000000 ...
Nov 14 15:36:49 10.243.0.116 [  529.135290] 000000008d6ef368: =
ffff8881008ffa48 (0xffff8881008ffa48)
Nov 14 15:36:49 10.243.0.116 [  529.135301] 00000000fd5717a3: =
ffffffffbc117c5e (sysvec_apic_timer_interrupt+0xe/0x20)
Nov 14 15:36:49 10.243.0.116 [  529.135315] 000000004f38b1c4: =
ffff8881008ffa59 (0xffff8881008ffa59)
Nov 14 15:36:49 10.243.0.116 [  529.135326] 000000004c20f858: =
ffffffffbc200d0b (asm_sysvec_apic_timer_interrupt+0x1b/0x20)
Nov 14 15:36:49 10.243.0.116 [  529.135342] 000000009e9bd7f9: =
ffff8883de3ef7a8 (0xffff8883de3ef7a8)
Nov 14 15:36:49 10.243.0.116 [  529.135354] 00000000cd340f20: =
ffff8883de26b5c8 (0xffff8883de26b5c8)
Nov 14 15:36:49 10.243.0.116 [  529.135365] 00000000bb23acc3: =
0000000000000003 (0x3)
Nov 14 15:36:49 10.243.0.116 [  529.135375] 0000000099bcd81e: =
ffff8883de26b5c0 (0xffff8883de26b5c0)
Nov 14 15:36:49 10.243.0.116 [  529.135387] 00000000bfd3a3c2: =
ffff8881008ffb80 (0xffff8881008ffb80)
Nov 14 15:36:50 10.243.0.116 [  529.135399] 000000008f5fba70: =
ffff8883de3ef7a0 (0xffff8883de3ef7a0)
Nov 14 15:36:50 10.243.0.116 [  529.135411] 00000000a150196b: =
ffffed102011e1bb (0xffffed102011e1bb)
Nov 14 15:36:50 10.243.0.116 [  529.135422] 000000008ebf103d: =
ffff8881008f0ddf (0xffff8881008f0ddf)
Nov 14 15:36:50 10.243.0.116 [  529.135434] 000000004721fde9: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.135439] 000000003d7915a2: =
0000000000000011 (0x11)
Nov 14 15:36:50 10.243.0.116 [  529.135449] 000000009fd16d91: =
ffffffffbb222390 (smp_call_function_many_cond+0x1b0/0x4d0)
Nov 14 15:36:50 10.243.0.116 [  529.135463] 0000000044ca1ff3: =
0000000000000003 (0x3)
Nov 14 15:36:50 10.243.0.116 [  529.135473] 000000009f2b594f: =
dffffc0000000000 (0xdffffc0000000000)
Nov 14 15:36:50 10.243.0.116 [  529.135484] 0000000093c8e5a3: =
ffff8883de3ef7a8 (0xffff8883de3ef7a8)
Nov 14 15:36:50 10.243.0.116 [  529.135496] 00000000a0fa40f5: =
ffffffffffffffff (0xffffffffffffffff)
Nov 14 15:36:50 10.243.0.116 [  529.135508] 0000000036c467c1: =
ffffffffbb4caeb0 (__asan_store2+0xa0/0xa0)
Nov 14 15:36:50 10.243.0.116 [  529.135521] 000000002486e91e: =
0000000000000010 (0x10)
Nov 14 15:36:50 10.243.0.116 [  529.135531] 00000000e062a523: =
0000000000000202 (0x202)
Nov 14 15:36:50 10.243.0.116 [  529.135542] 0000000083436bc2: =
ffff8881008ffb00 (0xffff8881008ffb00)
Nov 14 15:36:50 10.243.0.116 [  529.135553] 00000000040fb253: =
0000000000000018 (0x18)
Nov 14 15:36:50 10.243.0.116 [  529.135564] 0000000000d533e6: =
ffffffffbb222390 (smp_call_function_many_cond+0x1b0/0x4d0)
Nov 14 15:36:50 10.243.0.116 [  529.135577] 000000005b3ea390: =
0000000b41b58ab3 (0xb41b58ab3)
Nov 14 15:36:50 10.243.0.116 [  529.135588] 00000000fd07c06a: =
ffff8883de26b5c0 (0xffff8883de26b5c0)
Nov 14 15:36:50 10.243.0.116 [  529.135600] 000000001540963b: =
ffff8883de26b5d0 (0xffff8883de26b5d0)
Nov 14 15:36:50 10.243.0.116 [  529.135612] 0000000095b2d7da: =
01ff88810000000b (0x1ff88810000000b)
Nov 14 15:36:50 10.243.0.116 [  529.135623] 00000000a5cf7e88: =
ffffffffbb04a610 (text_poke_bp_batch+0x350/0x350)
Nov 14 15:36:50 10.243.0.116 [  529.135636] 00000000ac637bae: =
ffff8883de26b5c8 (0xffff8883de26b5c8)
Nov 14 15:36:50 10.243.0.116 [  529.135648] 00000000c18f0abc: =
0000000000000003 (0x3)
Nov 14 15:36:50 10.243.0.116 [  529.135658] 00000000adcb351d: =
ffffffffbcd128d8 (__per_cpu_offset+0x58/0x10000)
Nov 14 15:36:50 10.243.0.116 [  529.135674] 00000000fbd8f7d0: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.135678] 00000000bea0428c: =
ffffffffbda41cb0 (tp_vec+0x50/0x1020)
Nov 14 15:36:50 10.243.0.116 [  529.135692] 000000003781f724: =
ffff8881008ffc78 (0xffff8881008ffc78)
Nov 14 15:36:50 10.243.0.116 [  529.135704] 000000006f6f6b1b: =
ffffffffbda41cb0 (tp_vec+0x50/0x1020)
Nov 14 15:36:50 10.243.0.116 [  529.135717] 00000000582ff280: =
ffffffffbbd1cb70 (netif_receive_skb_list_internal+0x100/0x730)
Nov 14 15:36:50 10.243.0.116 [  529.135734] 0000000029c6e685: =
000000000000000f (0xf)
Nov 14 15:36:50 10.243.0.116 [  529.135743] 000000003330f591: =
ffff8881008ffb90 (0xffff8881008ffb90)
Nov 14 15:36:50 10.243.0.116 [  529.135755] 00000000bd1c51c1: =
ffffffffbb222774 (on_each_cpu_cond_mask+0x24/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.135768] 0000000051d2381a: =
ffff8881008ffca0 (0xffff8881008ffca0)
Nov 14 15:36:50 10.243.0.116 [  529.135780] 000000004ae7cd28: =
ffffffffbb04a406 (text_poke_bp_batch+0x146/0x350)
Nov 14 15:36:50 10.243.0.116 [  529.135793] 0000000014a07231: =
0000000000000040 (0x40)
Nov 14 15:36:50 10.243.0.116 [  529.135803] 00000000eeb7a175: =
1ffff1102011ff7b (0x1ffff1102011ff7b)
Nov 14 15:36:50 10.243.0.116 [  529.135815] 000000004a8f67a1: =
ffffffffbda41c60 (tp_vec_nr+0x40/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.135828] 000000006fdde61f: =
0000000100000000 (0x100000000)
Nov 14 15:36:50 10.243.0.116 [  529.135839] 0000000086891b1b: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.135844] 000000008b335bb2: =
00000401000000d7 (0x401000000d7)
Nov 14 15:36:50 10.243.0.116 [  529.135855] 00000000494f712e: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.135860] 000000004596323f: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:50 10.243.0.116 [  529.135871] 00000000a4ae1f10: =
ffffffffbcc994b8 (.LC1+0x1774/0x4d76)
Nov 14 15:36:50 10.243.0.116 [  529.135883] 000000004c225d53: =
ffffffffbb04a2c0 (__text_poke+0x620/0x620)
Nov 14 15:36:50 10.243.0.116 [  529.135895] 000000002eca7314: =
ffffffffbda4154f (insn.37130+0xf/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.135909] 0000000094ed033c: =
ffffffffbda415cc (page_random+0xc/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.135922] 00000000e2e53e1f: =
ffffffffbbd1cb70 (netif_receive_skb_list_internal+0x100/0x730)
Nov 14 15:36:50 10.243.0.116 [  529.135937] 00000000f756fb83: =
ffffffffbbd1cb7f (netif_receive_skb_list_internal+0x10f/0x730)
Nov 14 15:36:50 10.243.0.116 [  529.135952] 00000000fd2d720c: =
ffffffffbbd1cb75 (netif_receive_skb_list_internal+0x105/0x730)
Nov 14 15:36:50 10.243.0.116 [  529.135967] 000000006374e7ed: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.135972] 00000000a169672f: =
0000000000000001 (0x1)
Nov 14 15:36:50 10.243.0.116 [  529.135982] 00000000ea7e3bb8: =
ffff8881008ffc20 (0xffff8881008ffc20)
Nov 14 15:36:50 10.243.0.116 [  529.135994] 00000000f75b1e26: =
0000000000000040 (0x40)
Nov 14 15:36:50 10.243.0.116 [  529.136004] 0000000091283f70: =
ffffffffbbd1cb70 (netif_receive_skb_list_internal+0x100/0x730)
Nov 14 15:36:50 10.243.0.116 [  529.136019] 0000000010e2cdcb: =
ffffffffbda41540 (i8259A_auto_eoi+0x40/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.136033] 0000000059857621: =
0000000000000005 (0x5)
Nov 14 15:36:50 10.243.0.116 [  529.136043] 0000000064410713: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.136048] 00000000ccda5293: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:50 10.243.0.116 [  529.136060] 0000000078d5cb58: =
ffffffffbcd3db10 (__start___jump_table+0x16790/0x16d40)
Nov 14 15:36:50 10.243.0.116 [  529.136074] 00000000f0bd57fa: =
ffff8881008ffcb0 (0xffff8881008ffcb0)
Nov 14 15:36:50 10.243.0.116 [  529.136086] 000000005203f777: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:50 10.243.0.116 [  529.136098] 00000000ed3246c0: =
ffffffffbcd3db10 (__start___jump_table+0x16790/0x16d40)
Nov 14 15:36:50 10.243.0.116 [  529.136112] 0000000058b38182: =
ffffffffbcd3e0b0 (__start___jump_table+0x16d30/0x16d40)
Nov 14 15:36:50 10.243.0.116 [  529.136126] 00000000fa162c5f: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.136131] 00000000e5c1eec9: =
ffffffffbe881d40 (netstamp_needed_deferred+0x40/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.136147] 000000006a57c819: =
ffffffffbcd3db18 (__start___jump_table+0x16798/0x16d40)
Nov 14 15:36:50 10.243.0.116 [  529.136161] 00000000e54c85fd: =
ffff8881008ffcb0 (0xffff8881008ffcb0)
Nov 14 15:36:50 10.243.0.116 [  529.136173] 000000009e2b1295: =
ffffffffbb04ba2a (text_poke_finish+0x1a/0x30)
Nov 14 15:36:50 10.243.0.116 [  529.136185] 00000000dcb0fc2b: =
ffff8881008ffcc0 (0xffff8881008ffcc0)
Nov 14 15:36:50 10.243.0.116 [  529.136197] 00000000a53a9d84: =
ffffffffbb0455a7 (arch_jump_label_transform_apply+0x17/0x30)
Nov 14 15:36:50 10.243.0.116 [  529.136214] 00000000dafafc1b: =
ffff8881008ffcf8 (0xffff8881008ffcf8)
Nov 14 15:36:50 10.243.0.116 [  529.136226] 00000000ed068850: =
ffffffffbb3c0ea5 (__jump_label_update+0x105/0x140)
Nov 14 15:36:50 10.243.0.116 [  529.136242] 0000000031b257f5: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.136246] 00000000349ae5f3: =
ffffffffbe881d40 (netstamp_needed_deferred+0x40/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.136262] 00000000aabb79dd: =
ffffffffbe881d48 (netstamp_needed_key+0x8/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.136277] 00000000d2f5ae61: =
ffffffffbcd3e0c0 (__start___jump_table+0x16d40/0x16d40)
Nov 14 15:36:50 10.243.0.116 [  529.136291] 000000003328d50e: =
ffff8883de269a40 (0xffff8883de269a40)
Nov 14 15:36:50 10.243.0.116 [  529.136303] 0000000027d50bb3: =
ffff8881008ffd30 (0xffff8881008ffd30)
Nov 14 15:36:50 10.243.0.116 [  529.136314] 00000000ac799d20: =
ffffffffbb3c104b (jump_label_update+0x16b/0x1a0)
Nov 14 15:36:50 10.243.0.116 [  529.136330] 000000000e081f0a: =
ffffffffbe881d40 (netstamp_needed_deferred+0x40/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.136345] 00000000edf0bd3e: =
ffff8881000c1300 (0xffff8881000c1300)
Nov 14 15:36:50 10.243.0.116 [  529.136357] 000000004ee4cd45: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.136362] 00000000a2d6abe0: =
ffff8881008ffe08 (0xffff8881008ffe08)
Nov 14 15:36:50 10.243.0.116 [  529.136373] 000000009615d461: =
ffff8883de269a40 (0xffff8883de269a40)
Nov 14 15:36:50 10.243.0.116 [  529.136385] 00000000dcfbe5ab: =
ffff8881008ffd48 (0xffff8881008ffd48)
Nov 14 15:36:50 10.243.0.116 [  529.136397] 00000000fd2c5fd7: =
ffffffffbb3c1140 (static_key_enable_cpuslocked+0xc0/0x100)
Nov 14 15:36:50 10.243.0.116 [  529.136413] 0000000030211707: =
ffffffffbe881d40 (netstamp_needed_deferred+0x40/0x40)
Nov 14 15:36:50 10.243.0.116 [  529.136428] 00000000af689e67: =
ffff8881008ffd60 (0xffff8881008ffd60)
Nov 14 15:36:50 10.243.0.116 [  529.136440] 000000003c0219a1: =
ffffffffbb3c1275 (static_key_enable+0x15/0x30)
Nov 14 15:36:50 10.243.0.116 [  529.136455] 000000005745c745: =
0000000000000001 (0x1)
Nov 14 15:36:50 10.243.0.116 [  529.136465] 00000000dbf9c702: =
ffff8881008ffd78 (0xffff8881008ffd78)
Nov 14 15:36:50 10.243.0.116 [  529.136477] 00000000fb3eccc9: =
ffffffffbbd05cbb (netstamp_clear+0x4b/0x60)
Nov 14 15:36:50 10.243.0.116 [  529.136491] 000000003ee22c59: =
ffffffffbd658280 (xps_map_mutex+0xc0/0xc0)
Nov 14 15:36:50 10.243.0.116 [  529.136504] 00000000015d5008: =
ffff8881008ffe90 (0xffff8881008ffe90)
Nov 14 15:36:50 10.243.0.116 [  529.136516] 00000000d33d712d: =
ffffffffbb101417 (process_one_work+0x517/0xa10)
Nov 14 15:36:50 10.243.0.116 [  529.136529] 00000000a9bb019c: =
ffff8881000c1348 (0xffff8881000c1348)
Nov 14 15:36:50 10.243.0.116 [  529.136541] 00000000b87f47c2: =
ffff8881000c1308 (0xffff8881000c1308)
Nov 14 15:36:50 10.243.0.116 [  529.136552] 00000000cbe6835b: =
ffff8881000c1320 (0xffff8881000c1320)
Nov 14 15:36:50 10.243.0.116 [  529.136564] 000000006125dcad: =
ffff8881000c1328 (0xffff8881000c1328)
Nov 14 15:36:50 10.243.0.116 [  529.136576] 000000001718abfe: =
ffff8883de26ee05 (0xffff8883de26ee05)
Nov 14 15:36:50 10.243.0.116 [  529.136588] 000000003e8d5470: =
ffff8881000c1310 (0xffff8881000c1310)
Nov 14 15:36:50 10.243.0.116 [  529.136600] 000000006be3b345: =
1ffff1102011ffbd (0x1ffff1102011ffbd)
Nov 14 15:36:50 10.243.0.116 [  529.136611] 00000000575726eb: =
ffff888100061000 (0xffff888100061000)
Nov 14 15:36:50 10.243.0.116 [  529.136623] 000000000fdff907: =
00000000008ffdd8 (0x8ffdd8)
Nov 14 15:36:50 10.243.0.116 [  529.136634] 000000003ca6f586: =
ffff8881000c1318 (0xffff8881000c1318)
Nov 14 15:36:50 10.243.0.116 [  529.136646] 00000000dede653d: =
ffff8883de26ee08 (0xffff8883de26ee08)
Nov 14 15:36:50 10.243.0.116 [  529.136657] 000000003ad88f18: =
ffff8883de26ee00 (0xffff8883de26ee00)
Nov 14 15:36:50 10.243.0.116 [  529.136669] 000000005bb09100: =
0000000041b58ab3 (0x41b58ab3)
Nov 14 15:36:50 10.243.0.116 [  529.136680] 0000000065c2f6f8: =
ffffffffbcca09db (.LC11+0x23db/0x5c78)
Nov 14 15:36:50 10.243.0.116 [  529.136693] 00000000d785747b: =
ffffffffbb100f00 (pwq_dec_nr_in_flight+0x120/0x120)
Nov 14 15:36:50 10.243.0.116 [  529.136706] 000000002e18affb: =
ffff8881008ffe20 (0xffff8881008ffe20)
Nov 14 15:36:50 10.243.0.116 [  529.136718] 000000007429389b: =
ffffffffbd658280 (xps_map_mutex+0xc0/0xc0)
Nov 14 15:36:50 10.243.0.116 [  529.136729] 00000000ae564aab: =
ffffffffbe21b200 (lock_classes+0x462c0/0x180020)
Nov 14 15:36:50 10.243.0.116 [  529.136746] 00000000b1cf89d7: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.136750] 00000000d330e1fc: =
ffffffffbca13fc0 (bpf_xdp_link_lops+0x160/0xf60)
Nov 14 15:36:50 10.243.0.116 [  529.136765] 000000002bff5fc4: =
0000000000000000 ...
Nov 14 15:36:50 10.243.0.116 [  529.136770] 0000000091e22e0f: =
ffff8881008ffe48 (0xffff8881008ffe48)
Nov 14 15:36:50 10.243.0.116 [  529.136782] 0000000097c447a8: =
ffffffffbc11833d (lockdep_hardirqs_off+0x8d/0xc0)
Nov 14 15:36:50 10.243.0.116 [  529.136795] 0000000051ef92a0: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:51 10.243.0.116 [  529.136806] 000000008cb06935: =
ffff8883de269a40 (0xffff8883de269a40)
Nov 14 15:36:51 10.243.0.116 [  529.136818] 00000000acea9a2b: =
ffff8881008f0000 (0xffff8881008f0000)
Nov 14 15:36:51 10.243.0.116 [  529.136830] 00000000003242a4: =
ffff8883de269a40 (0xffff8883de269a40)
Nov 14 15:36:51 10.243.0.116 [  529.136842] 0000000030f27326: =
9fbcf6e6657b4600 (0x9fbcf6e6657b4600)
Nov 14 15:36:51 10.243.0.116 [  529.136854] 000000001c6330e6: =
ffff8881000c1300 (0xffff8881000c1300)
Nov 14 15:36:51 10.243.0.116 [  529.136865] 0000000035ae973b: =
ffff8881000c1330 (0xffff8881000c1330)
Nov 14 15:36:51 10.243.0.116 [  529.136877] 000000003570eedd: =
ffff8883de269a40 (0xffff8883de269a40)
Nov 14 15:36:51 10.243.0.116 [  529.136889] 0000000047d1640c: =
ffff8883de269a98 (0xffff8883de269a98)
Nov 14 15:36:51 10.243.0.116 [  529.136901] 0000000064e5038e: =
ffffffffbd658280 (xps_map_mutex+0xc0/0xc0)
Nov 14 15:36:51 10.243.0.116 [  529.136912] 00000000ca1eb1d8: =
ffff8881008fff00 (0xffff8881008fff00)
Nov 14 15:36:51 10.243.0.116 [  529.136924] 00000000b880b75f: =
ffffffffbb101962 (worker_thread+0x52/0x580)
Nov 14 15:36:51 10.243.0.116 [  529.136936] 000000005672ab19: =
ffff8881000c1348 (0xffff8881000c1348)
Nov 14 15:36:51 10.243.0.116 [  529.136948] 000000003d6e777a: =
ffff8881000c1368 (0xffff8881000c1368)
Nov 14 15:36:51 10.243.0.116 [  529.136960] 0000000088a9e75e: =
ffff8883de269e00 (0xffff8883de269e00)
Nov 14 15:36:51 10.243.0.116 [  529.136972] 00000000a2417c0a: =
ffff8881000c1340 (0xffff8881000c1340)
Nov 14 15:36:51 10.243.0.116 [  529.136984] 000000005a0a7e10: =
ffff8883de269a90 (0xffff8883de269a90)
Nov 14 15:36:51 10.243.0.116 [  529.136995] 00000000d628c6c9: =
ffffffffbd658288 (netstamp_work+0x8/0x80)
Nov 14 15:36:51 10.243.0.116 [  529.137007] 000000009989aa92: =
0000000100032708 (0x100032708)
Nov 14 15:36:51 10.243.0.116 [  529.137019] 000000003763d07a: =
00000000fffffffc (0xfffffffc)
Nov 14 15:36:51 10.243.0.116 [  529.137029] 00000000019278f1: =
ffff8881000c6c00 (0xffff8881000c6c00)
Nov 14 15:36:51 10.243.0.116 [  529.137041] 00000000f64d02e5: =
ffffffffbb101910 (process_one_work+0xa10/0xa10)
Nov 14 15:36:51 10.243.0.116 [  529.137054] 00000000182d84bb: =
ffff8881000c1300 (0xffff8881000c1300)
Nov 14 15:36:51 10.243.0.116 [  529.137065] 00000000da28dade: =
ffff8881008f0000 (0xffff8881008f0000)
Nov 14 15:36:51 10.243.0.116 [  529.137077] 00000000f15a1e28: =
ffff8881008fff48 (0xffff8881008fff48)
Nov 14 15:36:51 10.243.0.116 [  529.137089] 000000003003c269: =
ffffffffbb10e44e (kthread+0x1ee/0x220)
Nov 14 15:36:51 10.243.0.116 [  529.137104] 000000003179e66c: =
ffff888100827b70 (0xffff888100827b70)
Nov 14 15:36:51 10.243.0.116 [  529.137115] 000000008637a83d: =
ffff8881000c6c78 (0xffff8881000c6c78)
Nov 14 15:36:51 10.243.0.116 [  529.137127] 00000000aa291968: =
ffffffffbb10e260 (set_kthread_struct+0x80/0x80)
Nov 14 15:36:51 10.243.0.116 [  529.137142] 000000008d69b706: =
ffff88810013a880 (0xffff88810013a880)
Nov 14 15:36:51 10.243.0.116 [  529.137154] 0000000060ac9456: =
0000000000000000 ...
Nov 14 15:36:51 10.243.0.116 [  529.137159] 00000000bdb3941d: =
ffff8881008fff59 (0xffff8881008fff59)
Nov 14 15:36:51 10.243.0.116 [  529.137171] 00000000121fdcef: =
ffffffffbb002712 (ret_from_fork+0x22/0x30)
Nov 14 15:36:51 10.243.0.116 [  529.137184] 0000000005a17736: =
0000000000000000 ...
Nov 14 15:36:51 10.243.0.116 [  529.137194]  ? put_dec+0xc0/0xc0
Nov 14 15:36:51 10.243.0.116 [  533.416172]  ? =
stack_trace_save+0x82/0xb0
Nov 14 15:36:51 10.243.0.116 [  533.423592]  ? =
filter_irq_stacks+0x80/0x80
Nov 14 15:36:51 10.243.0.116 [  533.430970]  ? =
__kasan_check_read+0x11/0x20
Nov 14 15:36:51 10.243.0.116 [  533.438286]  ? =
mark_lock.part.53+0x119/0x1460
Nov 14 15:36:51 10.243.0.116 [  533.445569]  ? =
__kasan_check_read+0x11/0x20
Nov 14 15:36:51 10.243.0.116 [  533.452762]  ? print_usage_bug+0x60/0x60
Nov 14 15:36:51 10.243.0.116 [  533.459936]  ? print_usage_bug+0x60/0x60
Nov 14 15:36:51 10.243.0.116 [  533.466916]  ? =
dma_map_page_attrs+0x1c2/0x3f0
Nov 14 15:36:51 10.243.0.116 [  533.473894]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:36:51 10.243.0.116 [  533.480745]  ? =
__test_and_set_bit.constprop.24+0x12/0x30
Nov 14 15:36:51 10.243.0.116 [  533.487608]  ? =
test_and_lock_stage+0x98/0xb0
Nov 14 15:36:51 10.243.0.116 [  533.494421]  ? unlock_stage+0x3b/0x80
Nov 14 15:36:51 10.243.0.116 [  533.501106]  ? =
lock_is_held_type+0xdd/0x110
Nov 14 15:36:51 10.243.0.116 [  533.507765]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:36:51 10.243.0.116 [  533.514359]  ? desc_read+0x18f/0x1c0
Nov 14 15:36:51 10.243.0.116 [  533.521000]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:36:51 10.243.0.116 [  533.527661]  ? =
__kasan_check_read+0x11/0x20
Nov 14 15:36:51 10.243.0.116 [  533.534206]  ? =
mark_lock.part.53+0x119/0x1460
Nov 14 15:36:51 10.243.0.116 [  533.540752]  ? =
_prb_read_valid+0x358/0x400
Nov 14 15:36:51 10.243.0.116 [  533.547364]  ? print_usage_bug+0x60/0x60
Nov 14 15:36:51 10.243.0.116 [  533.553990]  ? =
get_data.isra.10+0x1d0/0x1d0
Nov 14 15:36:51 10.243.0.116 [  533.560644]  ? unlock_stage+0x3b/0x80
Nov 14 15:36:51 10.243.0.116 [  533.567226]  ? lock_release+0x297/0x410
Nov 14 15:36:51 10.243.0.116 [  533.573736]  ? up+0x41/0x60
Nov 14 15:36:51 10.243.0.116 [  533.580126]  ? =
lock_downgrade+0x3c0/0x3c0
Nov 14 15:36:51 10.243.0.116 [  533.586522]  ? =
do_raw_spin_lock+0x119/0x1e0
Nov 14 15:36:51 10.243.0.116 [  533.593023]  ? =
__kasan_check_read+0x11/0x20
Nov 14 15:36:51 10.243.0.116 [  533.599541]  ? =
__kasan_check_read+0x11/0x20
Nov 14 15:36:51 10.243.0.116 [  533.605907]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:36:51 10.243.0.116 [  533.612306]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:36:51 10.243.0.116 [  533.618520]  ? =
__test_and_set_bit.constprop.24+0x12/0x30
Nov 14 15:36:51 10.243.0.116 [  533.624769]  ? =
test_and_lock_stage+0x98/0xb0
Nov 14 15:36:51 10.243.0.116 [  533.630999]  ? unlock_stage+0x3b/0x80
Nov 14 15:36:51 10.243.0.116 [  533.637156]  ? =
do_syslog.part.29+0x430/0x430
Nov 14 15:36:51 10.243.0.116 [  533.643293]  ? =
lock_is_held_type+0xdd/0x110
Nov 14 15:36:51 10.243.0.116 [  533.649732]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:36:51 10.243.0.116 [  533.655866]  ? find_held_lock+0xca/0xf0
Nov 14 15:36:51 10.243.0.116 [  533.662017]  ? unlock_stage+0x3b/0x80
Nov 14 15:36:51 10.243.0.116 [  533.668082]  ? lock_release+0x297/0x410
Nov 14 15:36:51 10.243.0.116 [  533.674093]  ? =
is_bpf_text_address+0x50/0xf0
Nov 14 15:36:51 10.243.0.116 [  533.680190]  ? =
lock_downgrade+0x3c0/0x3c0
Nov 14 15:36:51 10.243.0.116 [  533.686253]  ? bpf_ksym_find+0x58/0xf0
Nov 14 15:36:51 10.243.0.116 [  533.692149]  ? =
swsusp_write.cold.20+0x1f5/0x1f5
Nov 14 15:36:51 10.243.0.116 [  533.698123]  ? =
is_bpf_text_address+0x6f/0xf0
Nov 14 15:36:51 10.243.0.116 [  533.704005]  ? =
kernel_text_address+0x111/0x120
Nov 14 15:36:51 10.243.0.116 [  533.709823]  ? =
__kernel_text_address+0xd/0x40
Nov 14 15:36:51 10.243.0.116 [  533.715560]  ? =
show_trace_log_lvl+0x1d0/0x296
Nov 14 15:36:51 10.243.0.116 [  533.721274]  ? =
show_trace_log_lvl+0x1d0/0x296
Nov 14 15:36:51 10.243.0.116 [  533.727009]  ? =
show_regs.cold.17+0x1a/0x1f
Nov 14 15:36:51 10.243.0.116 [  533.732605]  ? =
watchdog_timer_fn+0x210/0x280
Nov 14 15:36:51 10.243.0.116 [  533.738225]  ? =
lockup_detector_update_enable+0x50/0x50
Nov 14 15:36:51 10.243.0.116 [  533.743912]  ? =
__hrtimer_run_queues+0x38d/0x730
Nov 14 15:36:51 10.243.0.116 [  533.749654]  ? =
enqueue_hrtimer+0x180/0x180
Nov 14 15:36:51 10.243.0.116 [  533.755347]  ? =
inband_irq_restore+0xe/0x20
Nov 14 15:36:51 10.243.0.116 [  533.761100]  ? =
ktime_get_update_offsets_now+0xee/0x200
Nov 14 15:36:51 10.243.0.116 [  533.766995]  ? =
hrtimer_interrupt+0x1a5/0x350
Nov 14 15:36:51 10.243.0.116 [  533.772908]  ? =
proxy_irq_handler+0x32/0x40
Nov 14 15:36:51 10.243.0.116 [  533.778704]  ? =
handle_synthetic_irq+0xd2/0x300
Nov 14 15:36:51 10.243.0.116 [  533.789202]  ? do_irq_inband+0x2a/0x40
Nov 14 15:36:51 10.243.0.116 [  533.794970]  ? =
arch_do_IRQ_pipelined+0xb7/0x5a0
Nov 14 15:36:51 10.243.0.116 [  533.800770]  </IRQ>
Nov 14 15:36:51 10.243.0.116 [  533.806430]  <TASK>
Nov 14 15:36:51 10.243.0.116 [  533.812026]  ? =
sync_current_irq_stage+0x2de/0x500
Nov 14 15:36:51 10.243.0.116 [  533.817848]  ? =
sync_irq_stage+0x1aa/0x1e0
Nov 14 15:36:51 10.243.0.116 [  533.823627]  ? =
synchronize_pipeline+0x86/0xe0
Nov 14 15:36:51 10.243.0.116 [  533.829429]  ? =
handle_irq_pipelined_finish+0xf1/0x240
Nov 14 15:36:51 10.243.0.116 [  533.835288]  ? =
arch_pipeline_entry+0x81/0x110
Nov 14 15:36:51 10.243.0.116 [  533.841142]  ? =
sysvec_apic_timer_interrupt+0xe/0x20
Nov 14 15:36:51 10.243.0.116 [  533.847034]  ? =
asm_sysvec_apic_timer_interrupt+0x1b/0x20
Nov 14 15:36:51 10.243.0.116 [  533.853040]  ? =
smp_call_function_many_cond+0x1b0/0x4d0
Nov 14 15:36:51 10.243.0.116 [  533.859090]  ? __asan_store2+0xa0/0xa0
Nov 14 15:36:51 10.243.0.116 [  533.865080]  ? =
smp_call_function_many_cond+0x1b0/0x4d0
Nov 14 15:36:51 10.243.0.116 [  533.871196]  ? =
text_poke_bp_batch+0x350/0x350
Nov 14 15:36:51 10.243.0.116 [  533.877321]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:36:51 10.243.0.116 [  533.883535]  ? =
on_each_cpu_cond_mask+0x24/0x40
Nov 14 15:36:51 10.243.0.116 [  533.889823]  ? =
text_poke_bp_batch+0x146/0x350
Nov 14 15:36:51 10.243.0.116 [  533.896216]  ? __text_poke+0x620/0x620
Nov 14 15:36:51 10.243.0.116 [  533.902611]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:36:51 10.243.0.116 [  533.909124]  ? =
netif_receive_skb_list_internal+0x10f/0x730
Nov 14 15:36:51 10.243.0.116 [  533.915505]  ? =
netif_receive_skb_list_internal+0x105/0x730
Nov 14 15:36:51 10.243.0.116 [  533.921822]  ? =
netif_receive_skb_list_internal+0x100/0x730
Nov 14 15:36:51 10.243.0.116 [  533.928099]  ? =
text_poke_finish+0x1a/0x30
Nov 14 15:36:51 10.243.0.116 [  533.934272]  ? =
arch_jump_label_transform_apply+0x17/0x30
Nov 14 15:36:51 10.243.0.116 [  533.940568]  ? =
__jump_label_update+0x105/0x140
Nov 14 15:36:51 10.243.0.116 [  533.946880]  ? =
jump_label_update+0x16b/0x1a0
Nov 14 15:36:51 10.243.0.116 [  533.953222]  ? =
static_key_enable_cpuslocked+0xc0/0x100
Nov 14 15:36:51 10.243.0.116 [  533.959635]  ? =
static_key_enable+0x15/0x30
Nov 14 15:36:51 10.243.0.116 [  533.965956]  ? netstamp_clear+0x4b/0x60
Nov 14 15:36:51 10.243.0.116 [  533.972263]  ? =
process_one_work+0x517/0xa10
Nov 14 15:36:51 10.243.0.116 [  533.978649]  ? =
pwq_dec_nr_in_flight+0x120/0x120
Nov 14 15:36:51 10.243.0.116 [  533.985025]  ? =
lockdep_hardirqs_off+0x8d/0xc0
Nov 14 15:36:51 10.243.0.116 [  533.991395]  ? worker_thread+0x52/0x580
Nov 14 15:36:51 10.243.0.116 [  533.997787]  ? =
process_one_work+0xa10/0xa10
Nov 14 15:36:51 10.243.0.116 [  534.004145]  ? kthread+0x1ee/0x220
Nov 14 15:36:51 10.243.0.116 [  534.010458]  ? =
set_kthread_struct+0x80/0x80
Nov 14 15:36:51 10.243.0.116 [  534.016928]  ? ret_from_fork+0x22/0x30
Nov 14 15:36:51 10.243.0.116 [  534.023451]  </TASK>
Nov 14 15:37:03 10.243.0.116 [  545.280292] ------------[ cut here =
]------------
Nov 14 15:37:03 10.243.0.116 [  545.283938] NETDEV WATCHDOG: eno1 (igb): =
transmit queue 4 timed out
Nov 14 15:37:03 10.243.0.116 [  545.287501] WARNING: CPU: 1 PID: 0 at =
net/sched/sch_generic.c:478 dev_watchdog+0x4e5/0x550
Nov 14 15:37:03 10.243.0.116 [  545.291073] Modules linked in: =
xt_CHECKSUM xt_MASQUERADE tun netconsole ip6t_rpfilter ip6t_REJECT =
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable_nat =
ebtable_broute ip6table_nat ip6table_mangle ip6table_security =
ip6table_raw iptable_nat nf_nat iptable_mangle iptable_security =
iptable_raw nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip_set =
nfnetlink ebtable_filter ebtables rfkill ip6table_filter ip6_tables =
iptable_filter sunrpc dm_mirror dm_region_hash dm_log dm_mod iTCO_wdt =
gpio_ich iTCO_vendor_support x86_pkg_temp_thermal intel_powerclamp =
mxm_wmi coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul =
ghash_clmulni_intel aesni_intel crypto_simd cryptd rapl intel_cstate =
pcspkr joydev intel_pch_thermal input_leds sg mei_me ftdi_sio i2c_i801 =
lpc_ich mei mfd_core i2c_smbus ioatdma wmi ip_tables ext4 mbcache jbd2 =
ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt =
fb_sys_fops drm_ttm_helper sr_mod ttm sd_mod cdrom t10_pi igb drm ixgbe =
ahci
Nov 14 15:37:03 10.243.0.116 [  545.291724]  libahci libata crc32c_intel =
mdio ptp i2c_algo_bit pps_core dca fuse
Nov 14 15:37:03 10.243.0.116 [  545.331077] CPU: 1 PID: 0 Comm: =
swapper/1 Tainted: G             L    5.15.77evl-g6437d24c6dbc #1
Nov 14 15:37:03 10.243.0.116 [  545.336167] Hardware name: Supermicro =
Super Server/X10SDV-6C+-TLN4F, BIOS 2.1 11/22/2019
Nov 14 15:37:03 10.243.0.116 [  545.341369] IRQ stage: Linux
Nov 14 15:37:03 10.243.0.116 [  545.346449] RIP: =
0010:dev_watchdog+0x4e5/0x550
Nov 14 15:37:03 10.243.0.116 [  545.351559] Code: ff ff 4c 8b 75 b8 c6 =
05 fe 16 94 01 01 4c 89 f7 e8 60 23 f5 ff 44 89 e1 4c 89 f6 48 c7 c7 20 =
2f a3 bc 48 89 c2 e8 24 51 2e 00 <0f> 0b e9 10 ff ff ff 65 ff 05 2d 47 =
25 44 48 c7 c7 c0 3e 72 bd e8
Nov 14 15:37:03 10.243.0.116 [  545.362667] RSP: 0018:ffff8883de289d28 =
EFLAGS: 00010282
Nov 14 15:37:03 10.243.0.116 [  545.368165] RAX: 0000000000000000 RBX: =
ffff888127be4500 RCX: ffffffffbb2172fd
Nov 14 15:37:03 10.243.0.116 [  545.373751] RDX: 1ffff1107bc5b7c1 RSI: =
0000000000000008 RDI: ffff8883de2dbe0c
Nov 14 15:37:03 10.243.0.116 [  545.379379] RBP: ffff8883de289d88 R08: =
ffffed107bc5c8d2 R09: ffffed107bc5c8d2
Nov 14 15:37:03 10.243.0.116 [  545.384992] R10: ffff8883de2e468f R11: =
ffffed107bc5c8d1 R12: 0000000000000004
Nov 14 15:37:03 10.243.0.116 [  545.390682] R13: ffff888127be4408 R14: =
ffff888127be4000 R15: 0000000000000001
Nov 14 15:37:03 10.243.0.116 [  545.396307] FS:  0000000000000000(0000) =
GS:ffff8883de280000(0000) knlGS:0000000000000000
Nov 14 15:37:03 10.243.0.116 [  545.401981] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033
Nov 14 15:37:03 10.243.0.116 [  545.407732] CR2: 00007f75377db000 CR3: =
00000003a4e16001 CR4: 00000000003706e0
Nov 14 15:37:03 10.243.0.116 [  545.413508] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
Nov 14 15:37:03 10.243.0.116 [  545.419347] DR3: 0000000000000000 DR6: =
00000000fffe0ff0 DR7: 0000000000000400
Nov 14 15:37:03 10.243.0.116 [  545.425110] Call Trace:
Nov 14 15:37:03 10.243.0.116 [  545.430991]  <IRQ>
Nov 14 15:37:03 10.243.0.116 [  545.436780]  ? =
qdisc_put_unlocked+0x40/0x40
Nov 14 15:37:03 10.243.0.116 [  545.442693]  call_timer_fn+0x118/0x3a0
Nov 14 15:37:03 10.243.0.116 [  545.448463]  ? =
_raw_spin_unlock_irq+0x22/0x40
Nov 14 15:37:03 10.243.0.116 [  545.454264]  ? add_timer+0x360/0x360
Nov 14 15:37:03 10.243.0.116 [  545.460016]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:37:03 10.243.0.116 [  545.465872]  ? =
qdisc_put_unlocked+0x40/0x40
Nov 14 15:37:03 10.243.0.116 [  545.471638]  =
run_timer_softirq+0x93b/0x9a0
Nov 14 15:37:03 10.243.0.116 [  545.477455]  ? call_timer_fn+0x3a0/0x3a0
Nov 14 15:37:03 10.243.0.116 [  545.483285]  ? =
rcu_read_lock_sched_held+0xa0/0xd0
Nov 14 15:37:03 10.243.0.116 [  545.489075]  ? =
rcu_read_lock_any_held.part.15+0x20/0x20
Nov 14 15:37:03 10.243.0.116 [  545.494936]  ? =
__kasan_check_write+0x14/0x20
Nov 14 15:37:03 10.243.0.116 [  545.500745]  __do_softirq+0xff/0x57b
Nov 14 15:37:03 10.243.0.116 [  545.506538]  irq_exit_rcu+0x7d/0x150
Nov 14 15:37:03 10.243.0.116 [  545.512353]  =
arch_do_IRQ_pipelined+0xbc/0x5a0
Nov 14 15:37:03 10.243.0.116 [  545.518111]  </IRQ>
Nov 14 15:37:03 10.243.0.116 [  545.523839]  <TASK>
Nov 14 15:37:03 10.243.0.116 [  545.529534]  =
sync_current_irq_stage+0x2de/0x500
Nov 14 15:37:03 10.243.0.116 [  545.535377]  =
__inband_irq_enable+0x6f/0x80
Nov 14 15:37:03 10.243.0.116 [  545.541062]  inband_irq_enable+0x1b/0x30
Nov 14 15:37:03 10.243.0.116 [  545.546677]  =
cpuidle_enter_state+0x193/0x780
Nov 14 15:37:03 10.243.0.116 [  545.552173]  cpuidle_enter+0x3c/0x70
Nov 14 15:37:03 10.243.0.116 [  545.557550]  call_cpuidle+0x59/0x90
Nov 14 15:37:03 10.243.0.116 [  545.562691]  do_idle+0x370/0x390
Nov 14 15:37:03 10.243.0.116 [  545.567644]  ? =
arch_cpu_idle_exit+0x40/0x40
Nov 14 15:37:03 10.243.0.116 [  545.572489]  ? schedule_idle+0x43/0x60
Nov 14 15:37:03 10.243.0.116 [  545.577147]  cpu_startup_entry+0x18/0x20
Nov 14 15:37:03 10.243.0.116 [  545.581664]  start_secondary+0x1cc/0x220
Nov 14 15:37:03 10.243.0.116 [  545.586002]  ? =
set_cpu_sibling_map+0xce0/0xce0
Nov 14 15:37:03 10.243.0.116 [  545.590273]  =
secondary_startup_64_no_verify+0xb0/0xbb
Nov 14 15:37:03 10.243.0.116 [  545.594490]  </TASK>
Nov 14 15:37:03 10.243.0.116 [  545.598499] irq event stamp: 3264836
Nov 14 15:37:03 10.243.0.116 [  545.602459] hardirqs last  enabled at =
(3264844): [<ffffffffbb1aaac2>] __up_console_sem+0x62/0x70
Nov 14 15:37:03 10.243.0.116 [  545.606667] hardirqs last disabled at =
(3264851): [<ffffffffbb1aaaa7>] __up_console_sem+0x47/0x70
Nov 14 15:37:03 10.243.0.116 [  545.610707] softirqs last  enabled at =
(3263990): [<ffffffffbc400403>] __do_softirq+0x403/0x57b
Nov 14 15:37:03 10.243.0.116 [  545.614604] softirqs last disabled at =
(3264003): [<ffffffffbb0d261d>] irq_exit_rcu+0x7d/0x150
Nov 14 15:37:03 10.243.0.116 [  545.618433] ---[ end trace =
818597eea2f0e48b ]---
Nov 14 15:37:03 10.243.0.116 [  545.623002] igb 0000:05:00.0 eno1: Reset =
adapter
------=_NextPart_001_00B2_01D8F83F.B5249010--

------=_NextPart_000_00B1_01D8F83F.B5249010
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCFcgw
ggQyMIIDGqADAgECAgEBMA0GCSqGSIb3DQEBBQUAMHsxCzAJBgNVBAYTAkdCMRswGQYDVQQIDBJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcMB1NhbGZvcmQxGjAYBgNVBAoMEUNvbW9kbyBDQSBM
aW1pdGVkMSEwHwYDVQQDDBhBQUEgQ2VydGlmaWNhdGUgU2VydmljZXMwHhcNMDQwMTAxMDAwMDAw
WhcNMjgxMjMxMjM1OTU5WjB7MQswCQYDVQQGEwJHQjEbMBkGA1UECAwSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UE
AwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvkCd9G7h6naHHE1FRI6+RsiDBp3BKv4YH47kAvrzq11QihYxC5oG0MVwIs1JLVRjzLZuaEYL
U+rLTCTAvHJO6vEVrvRUmhIKw3qyM2Di2olV8yJY897cz++DhqKMlE+faPKYkEaEJ8d2v+PMNSyL
XgdkZYLASLCokflhn3YgUKiRx2a163hiA1bwihoT6jGjHqCZ/Tj29icyWG8H9Wu4+xQrr7eqzNZj
X3OM2gWZqDioyxd4NlGs6Z70eDqNzw/ZQuKYDKsvnw4B3u+fmUnxLd+sdE0bmLVHxeUp0fmQGMdi
nL6DxyZ7Poolx8DdneY1aBAgnY/Y3tLDhJwNXugvyQIDAQABo4HAMIG9MB0GA1UdDgQWBBSgEQoj
PpbxB+zirynvgqV/0DCktDAOBgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zB7BgNVHR8E
dDByMDigNqA0hjJodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2Vz
LmNybDA2oDSgMoYwaHR0cDovL2NybC5jb21vZG8ubmV0L0FBQUNlcnRpZmljYXRlU2VydmljZXMu
Y3JsMA0GCSqGSIb3DQEBBQUAA4IBAQAIVvwC8Jvo/6T61nvGRIDOT8TF9gBYzKa2vBRJaAR26Obu
XewCD2DWjVAYTyZOAePmsKXuv7x0VEG//fwSuMdPWvSJYAV/YLcFSvP28cK/xLl0hrYtfWvM0vNG
3S/G4GrDwzQDLH2W3VrCDqcKmcEFi6sML/NcOs9sN1UJh95TQGxY7/y2q2VuBPYb3DzgWhXGntnx
WUgwIWUDbOzpIXPsmwOh4DetoBUYj/q6As6nLKkQEyzU5QgmqyKXYPiQXnTUoppTvfKpaOCibsLX
bLGjD56/62jnVvKu8uMrODoJgbVrhde+Le0/GreyY+L1YiyC1GoAQVDxOYOflek2lphuMIIFgTCC
BGmgAwIBAgIQOXJEOvkit1HX02wQ3TE1lTANBgkqhkiG9w0BAQwFADB7MQswCQYDVQQGEwJHQjEb
MBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRowGAYDVQQKDBFD
b21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmljYXRlIFNlcnZpY2VzMB4XDTE5
MDMxMjAwMDAwMFoXDTI4MTIzMTIzNTk1OVowgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpOZXcg
SmVyc2V5MRQwEgYDVQQHEwtKZXJzZXkgQ2l0eTEeMBwGA1UEChMVVGhlIFVTRVJUUlVTVCBOZXR3
b3JrMS4wLAYDVQQDEyVVU0VSVHJ1c3QgUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MIICIjAN
BgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAgBJlFzYOw9sIs9CsVw127c0n00ytUINh4qogTQkt
ZAnczomfzD2p7PbPwdzx07HWezcoEStH2jnGvDoZtF+mvX2do2NCtnbyqTsrkfjib9DsFiCQCT7i
6HTJGLSR1GJk23+jBvGIGGqQIjy8/hPwhxR79uQfjtTkUcYRZ0YIUcuGFFQ/vDP+fmyc/xadGL1R
jjWmp2bIcmfbIWax1Jt4A8BQOujM8Ny8nkz+rwWWNR9XWrf/zvk9tyy29lTdyOcSOk2uTIq3XJq0
tyA9yn8iNK5+O2hmAUTnAU5GU5szYPeUvlM3kHND8zLDU+/bqv50TmnHa4xgk97Exwzf4TKuzJM7
UXiVZ4vuPVb+DNBpDxsP8yUmazNt925H+nND5X4OpWaxKXwyhGNVicQNwZNUMBkTrNN9N6frXTps
NVzbQdcS2qlJC9/YgIoJk2KOtWbPJYjNhLixP6Q5D9kCnusSTJV882sFqV4Wg8y4Z+LoE53MW4LT
TLPtW//e5XOsIzstAL81VXQJSdhJWBp/kjbmUZIO8yZ9HE0XvMnsQybQv0FfQKlERPSZ51eHnlAf
V1SoPv10Yy+xUGUJ5lhCLkMaTLTwJUdZ+gQek9QmRkpQgbLevni3/GcV4clXhB4PY9bpYrrWX1Uu
6lzGKAgEJTm4Diup8kyXHAc/DVL17e8vgg8CAwEAAaOB8jCB7zAfBgNVHSMEGDAWgBSgEQojPpbx
B+zirynvgqV/0DCktDAdBgNVHQ4EFgQUU3m/WqorSs9UgOHYm8Cd8rIDZsswDgYDVR0PAQH/BAQD
AgGGMA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAAMEMGA1UdHwQ8MDowOKA2oDSG
Mmh0dHA6Ly9jcmwuY29tb2RvY2EuY29tL0FBQUNlcnRpZmljYXRlU2VydmljZXMuY3JsMDQGCCsG
AQUFBwEBBCgwJjAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuY29tb2RvY2EuY29tMA0GCSqGSIb3
DQEBDAUAA4IBAQAYh1HcdCE9nIrgJ7cz0C7M7PDmy14R3iJvm3WOnnL+5Nb+qh+cli3vA0p+rvSN
b3I8QzvAP+u431yqqcau8vzY7qN7Q/aGNnwU4M309z/+3ri0ivCRlv79Q2R+/czSAaF9ffgZGclC
KxO/WIu6pKJmBHaIkU4MiRTOok3JMrO66BQavHHxW/BBC5gACiIDEOUMsfnNkjcZ7Tvx5Dq2+UUT
JnWvu6rvP3t3O9LEApE9GQDTF1w52z97GA1FzZOFli9d31kWTz9RvdVFGD/tSo7oBmF0Ixa1DVBz
J0RHfxBdiSprhTEUxOipakyAvGp4z7h/jnZymQyd/teRCBaho1+VMIIF9TCCBN2gAwIBAgIRAJIF
dv7a2pEWVMfTkiUaPlcwDQYJKoZIhvcNAQELBQAwgZYxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
aXRlZDE+MDwGA1UEAxM1U2VjdGlnbyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1
cmUgRW1haWwgQ0EwHhcNMjIwMzEwMDAwMDAwWhcNMjMwMzEwMjM1OTU5WjCB9jEaMBgGA1UEFBMR
KzEgKDcxOSkgODg0LTYzOTIxDjAMBgNVBBETBTkyMTMxMTIwMAYDVQQKDClLcmF0b3MgRGVmZW5z
ZSAmIFNlY3VyaXR5IFNvbHV0aW9ucywgSW5jLjESMBAGA1UECRMJU3VpdGUgNjAwMRMwEQYDVQQI
EwpDYWxpZm9ybmlhMRIwEAYDVQQHEwlTYW4gRGllZ28xCzAJBgNVBAYTAlVTMRgwFgYDVQQDEw9S
dXNzZWxsIEpvaG5zb24xMDAuBgkqhkiG9w0BCQEWIXJ1c3NlbGwuam9obnNvbkBrcmF0b3NkZWZl
bnNlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALnh/To9+nijBjtTASsMRaO4
eMR3Oh755HRtJdmmnh8R22FPh0g7SqJ0LqsdxB+F2MZuiATU0yGTqCiipYr7rvJe84G+g7buxK89
qShsTVKg7ho0hYqf5st4OofS70TU6tDSok5DonFeoP13o8WSDj6VaTCgdN4R2EpylpCbkwA0Ztab
OVLXq2c3T/2lYz9E3FktVbyW/g98PMreSQw/YHHVJDHIjRVuHWPDXNxWgL8JhvmBgW/sM0+RbOEB
d8BbpUDKKENyfyh7pyWDuaGdwXgZewYN/rsed9sY3CQbjXdPlkNs2hRr3OBF2x7/r2dxC1WcjAqX
nFpkj5GgZAj9ylkCAwEAAaOCAdowggHWMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0A
MB0GA1UdDgQWBBQozNUBGAya4A+1PrjoDHHIppZKmDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/
BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1BgwrBgEEAbIx
AQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9DUFMwWgYDVR0fBFMwUTBP
oE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBigYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRw
Oi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3Vy
ZUVtYWlsQ0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAsBgNVHREE
JTAjgSFydXNzZWxsLmpvaG5zb25Aa3JhdG9zZGVmZW5zZS5jb20wDQYJKoZIhvcNAQELBQADggEB
AFr/GaEORVDnaQlG1aZnzFZxeaplFNh2DXG9CRzdu3U6HWBvAYgQqwVxvRD8O8omtchUCTyApdif
jla9M2OlWeyyAqIvCLqgZu7R2YkDuKzrNkyug95yKSUuG6WnFyr62tmlm7/Z/BOwYKdDracwiiJf
1nhhK9tCUhSLEWmNBv6z6rYmszNdajEGuJ4Om2ul76u21GZzvV9xAeCZtzbpQiVK+ib5T8fe/USd
/GIJkUmeyLNip1x1UA6TWJQNM6Y6vBNj2juHeydhVYUwOwrNiBWfYvbzZgbcTkoPjC5zbNf1/ffM
j37+cmagv+vKIk2eZNfvxAw2iHBK/+oQe8fqbZ0wggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06
KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEU
MBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwG
A1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAw
MDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5j
aGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNV
BAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8
gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUfItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9N
xOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeWQcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6
kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YBrf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlV
x/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewDch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+Q
U5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAUU3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0O
BBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYD
VR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRp
ZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUFBwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDov
L2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJTQUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzAB
hhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0GCSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXe
jpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1G
wmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Y
s7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJ
JIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz
9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG0
3i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8
q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQOZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15us
wgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qodx/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucX
qm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i5ZgtwCLXgAIe5W8mybM2JzGCBF0wggRZAgEB
MIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQH
EwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNB
IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OS
JRo+VzANBglghkgBZQMEAgEFAKCCAoEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMjIxMTE0MjI0MjMxWjAvBgkqhkiG9w0BCQQxIgQgyNuxjeCvNyXPn59VhEuXZzQu
m6MT4GwZzdquVEOFhvAwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAoGCCqGSIb3DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwBwYFKw4DAhowgb0GCSsG
AQQBgjcQBDGBrzCBrDCBljELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3Rl
cjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVT
ZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJIF
dv7a2pEWVMfTkiUaPlcwgb8GCyqGSIb3DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkG
A1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0
aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBh
bmQgU2VjdXJlIEVtYWlsIENBAhEAkgV2/trakRZUx9OSJRo+VzANBgkqhkiG9w0BAQEFAASCAQCf
Oxr2mZOdioC8fXpAnAFlrpacqTuH7Jz6KgFDrBN74+vp+UyLpheD4IS04Srz5khv52wnWS5jerN9
cGvz+4Vv60gPdu3Bw4n0Y5pkomJKnJ1Z1omgcABFRregOW+I7mWW90vRUM1FT0DqtVhPhAQ/7LUY
F8Znk3OKsGlZbaSALJhJsk/CAgobrd5/bPKY+QAVRIpd9cS76n3JQYFggszrOG309Bb03Av0Exfs
k1AWr6UqEOwV/xqYQYb+JAWpnTQaYODmHwMERV23RRzctGmhKPt52+Pjofy31ROZlCYcw9896xYl
f92QPp/EUdptAEovjCRP1tqDZcf+d2FtvvwaAAAAAAAA

------=_NextPart_000_00B1_01D8F83F.B5249010--

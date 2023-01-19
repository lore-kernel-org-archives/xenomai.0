Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2111.outbound.protection.outlook.com [40.107.22.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD73232
	for <xenomai@lists.linux.dev>; Thu, 19 Jan 2023 10:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vw5p8CFFBQVA6xufDPgBjShtcV8DBgDkcjUC83akRu06TBJlP1kNTjsw7vJNIIAc1QnJ4N1PEoSZ4dV6BW9Lf4rPm2dTmEDy5UtAcwYX7ERNGD7Rib1O0IplQMXRcEoanoaeQAxHHKWgAs7eKVTACRCULL/xU75tLveUBrA2VxFU72woERrpWclfz4+XtOXallkKGtRI7nQJhH3Hw6tG+wZc6JCowhI7yKdhdb9GiKLsfwvuQ49DfaIaMXRM5jTO2n0GPgWPgAZqACPsiuSX4+tvSEEodyDE15wDiQA9HYW8eV1cFE89Lhhl0H2k4v6coD7B9IYeJBsXQQ1LmMuy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6us5/NCp4TSyrn3MwCLPbSC5+hQ8bCqqAqRQ+k3x6A=;
 b=Uu3ASljVDHAdRfl8jgw7ijSh80BJbiy0sAWQTFTDKJBeAy9AMgltlfLVg4O5SHo+8jBtwb+Dyh+M8//HgFqmNpjfzaHJ3PB2vGE90lAvLiRICpRsVTolPsAeHBZulWcJ/7l8hyvqqrdvX/HGQAKPl673GFX2HKBMxFA6mRKOn5GMiu9Y1kTEve6Lj+ncNG4+dCspHKoRdqpjIksIx1k53h4kWTUT0AUKQDwWGV7CRaGUUgYdsN4Da8BUshNBwGOxeDg7omsD0CBz0QRrj0D0vKy5BqdM9v4yMdHPiE9Fm9v7ZsOerp/L+Tf7uDMhjX8GSmz3YRbgPO808gndmLpNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6us5/NCp4TSyrn3MwCLPbSC5+hQ8bCqqAqRQ+k3x6A=;
 b=WOtl2OHauWrrhM8Rys1h/1+iNeHDq2aS2dI0BBTsqCV95FLzBJagWx/TiWjBQN6tL75AsNdeWgO/2cUpj9PcRhIhWyA7xor/rRNFRIALK81/oQeZbL8jNKTcwxyxrZiw0Itpqd2YlnyaXBvhDOTX15iOfMEAE6KdTmTqKe+Jz0U=
Received: from DU2PR08MB7358.eurprd08.prod.outlook.com (2603:10a6:10:2f1::14)
 by AM8PR08MB6435.eurprd08.prod.outlook.com (2603:10a6:20b:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Thu, 19 Jan
 2023 10:41:51 +0000
Received: from DU2PR08MB7358.eurprd08.prod.outlook.com
 ([fe80::6a1d:825e:2fcd:4be1]) by DU2PR08MB7358.eurprd08.prod.outlook.com
 ([fe80::6a1d:825e:2fcd:4be1%7]) with mapi id 15.20.6002.012; Thu, 19 Jan 2023
 10:41:50 +0000
From: Johann Obermayr <johann.obermayr@sigmatek.at>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: thread cleanup troubles
Thread-Topic: thread cleanup troubles
Thread-Index: Adkr8outxfoQ6AKMRnaahUrskeeRFQ==
Date: Thu, 19 Jan 2023 10:41:50 +0000
Message-ID:
 <DU2PR08MB735839A582125026237762FCF5C49@DU2PR08MB7358.eurprd08.prod.outlook.com>
Accept-Language: de-AT, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR08MB7358:EE_|AM8PR08MB6435:EE_
x-ms-office365-filtering-correlation-id: 9bbabcc7-e101-4b61-01f1-08dafa09c5f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F0bnFr9dGlV4kOFDXBgL/rbEHwej10gRb5sdSVj06vzeS0gFYW08Z2dQqBrgg8vhxSBjodMwuyZuE+uqWXhUHAG+Hv8CeN0vt/lPJbgN4JxMckqxwFo3Osj2GwjCo5sZuxk4OHAHMSwXHCJgTiLZXDDqHB5Iz1oge+sVbuCUUF5DeTBgsf3lUZo0rImPOfLg69EaQqCiuBYL8FSmAWtq+ELqr63XI9rhquhUqXdGmO6/9lqIycfuPykDLjVJxd4vzkKfeI/6KiCGqiZ1jXRR+ee8oHvLiKeRbmRqqCownYGdoCnRRO6cUlVHm9yUUqKgdWntqcQrUtNSMSVU0XZjTvoK3SAKcGU3nJBSVN+FqLs9/Tfb+Ghdm+gBNt33TICOlbsODefQKEvv3nl6MZXSgPaVF4YZEOaPXBuo+n/3T+wlpfzekXkBAjUCgwB90W7b7sNx9wV0FSABELzULhg42zsJgu58SJ33b9Jp7P3XNUfJoGTnSQZ2lVcbtpqhez8XAr5AeTaWDbfvJDNVbHm2T6ZjUxIVALM15V3mr3rcL/ZJioeF/txKf4Da8OZDh1NKPJ2qL0oJO1n7s3Nq6Gqun79/ciocYk10NjIVi4b5tpyKIP4qVTmMaA3mI3ZCwQm9T/2znXJ2TJs39qvXnCOmlKj6cJ2q/mg47goToBpcizU7f9+05ZI6wsMTWRvBK4A7abZMhctGinjDrIXwSVAfWBLrcfUFHuf0y0Aj+Uqixfw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR08MB7358.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(396003)(376002)(136003)(366004)(346002)(451199015)(86362001)(7696005)(4744005)(6506007)(71200400001)(478600001)(55016003)(33656002)(52536014)(122000001)(8676002)(41300700001)(38100700002)(316002)(76116006)(3480700007)(5660300002)(8936002)(66556008)(26005)(64756008)(66446008)(66476007)(66946007)(186003)(38070700005)(2906002)(83380400001)(6916009)(44832011)(9686003)(7116003)(66899015)(133083001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MKYwsY5u4nj1a5ToWOjMcgVvPQcYkN+k7oco3MWUZMcWIjVTFgwUcA2TPulK?=
 =?us-ascii?Q?E30wML4GWpVsbm8WWuKl/PSfDQ4ktxjo3tvgCu0ivw5ku6dklmabfABIy3bd?=
 =?us-ascii?Q?IFzQ5zcKjg7PP891RvZVlm4Uktac1gdslqH3dpB+dppZnT4YS+ktg2OxUfdy?=
 =?us-ascii?Q?V/OzuHmnGYNQE9sofwqn9Sy2INRqnQ4iMCDxX26POqy8F/BtT0ewCdIrWCMI?=
 =?us-ascii?Q?LfN45fBArd7rn/1JzuSJM6Cshe/Xb5MEfxZhlfWdCGSjF4fHD1Xm7gqTU0zn?=
 =?us-ascii?Q?lZeFaXOtKvXEXu687sNvbf1qfGKIMcy8n4Y5/FELsAjAwysHol6G6zglCnvM?=
 =?us-ascii?Q?GAA8THt7W9KGkxM30xzgkBbRIXA0JzgogT3NLOFesPboDimy2QqmARRd0zSy?=
 =?us-ascii?Q?kNvEcm8lJa2IJY+T8bkAKH3ey1Ti6Fud7oE/WI1WSg1zTmaDcT9WI2jczlzd?=
 =?us-ascii?Q?m+G3J3DrTE7lDkmUUEixMXG/MvN6R1l0UGZSpyrXp0nfJQxleslyfmVbMugM?=
 =?us-ascii?Q?hZlFxhobqYr6oSyZmoL0KoE6o4GVwBgFQ9g90qln1xmW0eOfRhMxr4D8KGka?=
 =?us-ascii?Q?E0/1LPn74cTKMaWE+J1zBlGCblBqcrEcgQtZzJQQph+L4QjPKzl7ihe7CIH3?=
 =?us-ascii?Q?EX8bLOs5SFAs17/ylhawQM5eZetjGiDcv6vvjsBBYvVDQ9a9YJKhyy5PmITD?=
 =?us-ascii?Q?812PxEKGjBH5zBDA0GKzsk6B8URGNM8nzlixII9vX+s28inyf33SPm65+oIS?=
 =?us-ascii?Q?S0+TKj2Dnbl6pqO7dWBwx2JDVS4sT7ICXDTrf1VyKPtw+zPy3FN1yL/OiLEX?=
 =?us-ascii?Q?3XSZmHN1sCeFpmdMk+xdVGgmbYvzbmx5i9spy/yTBUGHbEuzjgAWg8kcrred?=
 =?us-ascii?Q?y/uZ/wgpM49lquWPQI8jGfMlnmlRgFy8f2olt/T7yAtDD0DTI+uz8kNgmT3F?=
 =?us-ascii?Q?eqaeKr5s2xKF4BMDBTMVqi5/Xa5pm+hqi0rppYD6TCc/4SIVSplsvR0sj1Qr?=
 =?us-ascii?Q?4juM15+eA6Jx1B5xtWENOc717XdICs7bqN1bQppiNASztpEc1gHKJcSYytQY?=
 =?us-ascii?Q?5LGxqOOMXW34xFpU5YsPmZtOf5cRD1oYvJrYAIA9+MFI+P7ynaAGfdzxhV/v?=
 =?us-ascii?Q?ofNpy8BOzXJYF7R/PZH5vkdsUv/J0sGtma6IlsLYUR/Bem5b1xpxTXvdWt6V?=
 =?us-ascii?Q?KhgQxogbzs8Oo1peoQOF2fssIaV3Vcm0zh27cjSgQq04COhKtJBqgTRsbH0t?=
 =?us-ascii?Q?QE02hK0gdf6/l3Yxv+gAhcmzBMWtPyihjOLpXhIGKJ9rLsZJVzWvJUplJcO6?=
 =?us-ascii?Q?T/tiKn17NGtcmSjb7PVyNtoAjt4XJosM19kSIiYf4taeFodZ8d6Jo5A1VeEG?=
 =?us-ascii?Q?1rLAc7wxPdA142SsqaXtGvsvRtbtlLjT82CF4vyZ4ZnGFdM/8jlwvZuFcDsf?=
 =?us-ascii?Q?TFefUIUEImGUWLvFIRusVKNDZyCqmX+lh6NP5J73LVDvTPDvHXv3jnKYKkoe?=
 =?us-ascii?Q?xxKGR1brGQMIChGc9iBhUxnLyc3KQ6JYHEv8cFvIn8gQ2o1c+ts5eUnC7qhu?=
 =?us-ascii?Q?S/pB2J1Iq5dlGWA6LbWOWdBQa0318pfhgbMHFO2Xzq2lYv465KLR+GgucpWJ?=
 =?us-ascii?Q?Hg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB7358.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbabcc7-e101-4b61-01f1-08dafa09c5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 10:41:50.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEv9sdqjnbEIeVoSesyGGw9hBUba+6CYI5ehL3NGuec7LH3yJI2Kt9F5eQ0/dlEilr9d/PALNuB89KGcmJdlanMBmy6FNXJxKwKjMJBK9Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6435

Hello,

Like Xenomai, we use pthread_key_create to clean up our threads at the end =
of their execution. In the cleanup function we also need a mutex to unsubsc=
ribe from a thread list, we maintain for certain threads. Xenomai calls fin=
alize_thread on the pthread_key_create callback and finalize_thread deletes=
 the task on the Xenomai side. Because our cleanup function runs after fina=
lize_thread the rt_mutex_lock call fails with EPERM.
What is the best way to solve a problem like this?
An idea would be to add a new function "rt_thread_register_cleanup_handler(=
....)" that registers a callback which can be used for user specific thread=
 cleanup.

--
  Johann

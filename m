Received: from mx0a-0019b802.pphosted.com (mx0a-0019b802.pphosted.com [205.220.162.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A064C74
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 20:16:38 +0000 (UTC)
Received: from pps.filterd (m0240892.ppops.net [127.0.0.1])
	by mx0b-0019b802.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QJDHbr010441
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 15:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3dsystems.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps1; bh=kWTgwzz4Nn4CMP/kF7s1Zb5aBJpt0c+9sIB6NTI4Uak=;
 b=wisg00WMuEKoBMytCt7kUcN9M3jW1XLTUH7ZcdDlki6UZLPekqWhgaaQGi/ZMFrpmcj9
 ugxEnMmG2I60do2f1WyOGlH0HsTIWD79omaJ6wBh92U0Iq4xxmd7/LN+uM6uLpvMGA3R
 EvD+PNyTuVgAAlCnwqYGof+8J4AiCQsgwy71lpGoPDFMzpPr5/0LXZN2uwGTmZfboF+M
 pKkbitTAY/tk+atBqIa2jA8V9UHWTbdfBM0t8mRzFckplqbejpKemAM/UhKNFZeAQk/m
 vOh6W+RPb703MZ9aAJn+gUKS3Rd9wlNcQCniP78FKqTZuqJkSJnw6cr48roVfykXksY1 gw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0b-0019b802.pphosted.com (PPS) with ESMTPS id 3j56nvsrs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <xenomai@lists.linux.dev>; Fri, 26 Aug 2022 15:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9C10O2U9hdjOQy1Rdytfb/gZDjeorEL16mhih7Ir/Ccfe9/Jw5T2DepRTmw8/1Hld/vpcA8b0ClZ/L6eO3JhuP85YVAkPArqfZlhWs1/2xOnsQjmZxOyYXKs0KS1XijVqUFYyHpu2Aj6X9cukwqxC4G8fcX1wBJs47OJ8Es0jkn5we9pHKB+xuL7AzfeX6ew/6p97gDtQBrfO7SL3HvWneQ3qkutJWm5pdegveqqpUd09JTCn2BPRJF9m7eEbvsAJKqfXfQrbUtzlIrkqu6qKFRsWU0nM0qhKTPACtdEbiAVxzQBfF55rdCRp2JzXAfHZv6ZJoaubDyAi/KEo3gbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWTgwzz4Nn4CMP/kF7s1Zb5aBJpt0c+9sIB6NTI4Uak=;
 b=Dn0cPyBNYUHf9TkDwv+h3lRnOEZeSd9b+pmDX+J21FL7irn9BsM/z3dYrAoOkysPcrMMAI0eSVHSatut9XaJxa/PoMYM7KjyBoLWVXPvCU3xk9jbfY3NfIb/+iLWSG9Q8KkOr7cSFjz/rwkQwUwc3WMI1/kmUe+iBvB6SSOxV05uhqlyyBFRFSs/IvDQXtyn5I1dLut0wW52T3OYUZwub8ENc403T8lVchnUexjnbfrct4NpHtLLpocsB2JqiVdi8fRTSmDUyt96SoWDBJWXV4pV9imdrz0JwkcWsL710ucGJUso/TPNl97f11iUk4GX9YXd9D525wxPmZCUif3uIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=3dsystems.com; dmarc=pass action=none
 header.from=3dsystems.com; dkim=pass header.d=3dsystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=3dsystems.onmicrosoft.com; s=selector2-3dsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWTgwzz4Nn4CMP/kF7s1Zb5aBJpt0c+9sIB6NTI4Uak=;
 b=FKIgMhtGU7WdknKXYoc6hpukeiPHj/dYJ6CMRq/dSqPmzlx1AyOgJPP2WlovHEIfrRMctlmE0+DUK7Ts+0ALc+TAmdczao92raCRPXXmJkMLKtXbGDIOI351X9p2DFXd+TvC70RyKTsurhD6W9TlC0Nb7AwRbcGmZgg2kVCrFBA=
Received: from MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7)
 by BY5PR12MB3652.namprd12.prod.outlook.com (2603:10b6:a03:1a7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 19:46:48 +0000
Received: from MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::b86a:14d4:9b71:c819]) by MW3PR12MB4460.namprd12.prod.outlook.com
 ([fe80::b86a:14d4:9b71:c819%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 19:46:48 +0000
From: "Auel, Kendall" <Kendall.Auel@3DSystems.Com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: PCI probe fails (Cobalt 3.2.2 / Dovetail 5.15.y-dovetail)
Thread-Topic: PCI probe fails (Cobalt 3.2.2 / Dovetail 5.15.y-dovetail)
Thread-Index: Adi5hHT1QzOR8y5vTEiAQ2pXMX+pvw==
Date: Fri, 26 Aug 2022 19:46:48 +0000
Message-ID: 
 <MW3PR12MB4460264EEABB2C91E529440BC2759@MW3PR12MB4460.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b74f197a-eb9d-442c-3a6a-08da879bb6c3
x-ms-traffictypediagnostic: BY5PR12MB3652:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NjSZToPJoMFr1AUnWppbokDaGRUHr9ZbdXuvs3kfqeijLp3JotocBHtBVP6VDE5Fqlff03nTLfIr6O7Ss9zYnz9Uicpn7VN+BvLTzvFtEWG83ViVU8E/qxX/px6RhiXPmCf65lK+j2rpzxw3aIFClqUQFHc8GkmoEwWYjSH2cLdpoKcHQ0U0AYk2UAUyaUODySGYcB3T4PPmsmemrfW3mFMDTWUF6r9W2d7UBL/8FdZLWF2VYP2ggCDmSiC6WQa13eA5HirAgWhJOhWJ5QwNo7vWm+tvf4XzKgIJI0wyiCxk5WBQd23Z0bi5C1rxSWezByKzONErDKOqK0ozPW/taHAQf1E4dk1T4DO04iE6eMERWGyERJYMBR6qZ/Gjg9FCFmO3b2OSbsxv9+5EYr9/gZThrzEckQAcK42DFy4Ch+ZtM7HZwvYOHV7I14MAarFLH4ji43iNBvIh1PYCo8NPo4EXQwZ5tANas8U/u7USofLAWvjOiuQOGTnysxs2+tD7IGYCVhasjV44Q+Rqa7Pyfp5NBpVf5d2lXc/84zY/BCZ78hzXpHYQ7oi0jOPwRadbzxrAdyNpUcqWQts1Mcjq8YihZv8VhEyVX5RVQHTY5qoIdtHRfRuiRdBgLwGnrpdtFN7LCbpf/0DpUizodtS+7L15aw9X5B4KQ/GSyOdIThr1axpx0qAD4hoS3vFBaiaDRrFDc7juFwNH/YibdM4LDPU+Cfssaip/Plmte3NSoP3NK5BCIctaILLlGlXjcITUI72FRUrNYvN97O//Qic/uOB1mwUxfl6eD4JobXE/94Fqgc0keLa8Ce42fle5sXOx
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39850400004)(346002)(396003)(136003)(26005)(33656002)(186003)(71200400001)(6916009)(316002)(9686003)(2906002)(7696005)(83380400001)(6506007)(122000001)(40140700001)(86362001)(38070700005)(66556008)(55016003)(45080400002)(8676002)(76116006)(8936002)(5660300002)(64756008)(41300700001)(478600001)(66946007)(966005)(66446008)(52536014)(38100700002)(66476007)(18886065003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Tzcuo536h4QWE4fahbUAdXTUN+cfhZhpSPByt0SPj6QARuB7/FfkTavfuo?=
 =?iso-8859-1?Q?OCqQaM6Af6uAsStOYk1rGSxH9Gl+jidxqV8xHsQ9/NJW0g4Jn6RCZm+uXW?=
 =?iso-8859-1?Q?hmOvrI9D+Cr9JGMmvIbEHAj5CMfg0VcnPbsG8Gy5lMeQ3zTmX0MIpD8IWn?=
 =?iso-8859-1?Q?tXDKRHl7nBanm160JvOWH6z5DY16/jErb+ZHx6YSNzbU31vmK2/LObnHeh?=
 =?iso-8859-1?Q?EaXT6JkZs30L1D2AlQMJ7kSwBeP6t7f9zzm3Dyi0CeofGgiwmRhkZavAQN?=
 =?iso-8859-1?Q?KG819xZv4B7ykllSmIGtgZPAwRwprsTCCt9QRu8MvjOQebIVfacOWvg3Xe?=
 =?iso-8859-1?Q?cp7+9kAcSxnaC/s/OBdnjVyFOS4CYdCRHvo0pF1z/qKuQrtuYFxZMCUziW?=
 =?iso-8859-1?Q?cnL5Kga3xxsLeNMZObZC3gy7PD+PpVVnTeAUVat8y83WV0HF3PyZiPqFz0?=
 =?iso-8859-1?Q?Pt9AcpZxilfDA5Pajpoc1EmVxQQCs8a082+5+owhNGDaa4XNKnDfk7iUcv?=
 =?iso-8859-1?Q?so9iNqP0TUUf8cj8FQBauK9cvchMtCPvR6s8ku7XBshMUEYhEE488HLO9R?=
 =?iso-8859-1?Q?v/RXrWOGB323MxXhjWgxj3Lky96sCQqIU7sdu0/h1qqWEHv1+e+h+OO9NJ?=
 =?iso-8859-1?Q?6GsdAbpwcvCKsRImVh5w8pqPhe+0ZyrnIw3ThqkpTVR5d1w1Ba3glrCQq7?=
 =?iso-8859-1?Q?3ZB6N54/0uWDjPPHpXea1iWVRc1wK99Magb669aob9jWtcGC/WdoHuZgoC?=
 =?iso-8859-1?Q?m73qXALCIr/pbbzLDzDKOc85U9mbCoR9a4De1+hsiIwTBW2epvmENGDVz0?=
 =?iso-8859-1?Q?2Bu6FnaP0b/zOd3J5dCGdbErsOWSyAFbHnbgUOWL1cle4RB1BQy3p52Utj?=
 =?iso-8859-1?Q?cSL+Jbh4uIC0/kvA1JSPHBeRJdb07gDsm+PSWZeOpQKC7ycOxKC+RGW7cU?=
 =?iso-8859-1?Q?U3jN/l5eAmJTkAEwijP2sOj8GitGDW+D9RTB/TGK39soM9/wKcYhtSw1xP?=
 =?iso-8859-1?Q?s1OYp7e+9mLQOmMzpZztP/O8h5jHS2CAW1C4k5mzZKW5CqicOt+0r7aWKp?=
 =?iso-8859-1?Q?2sF7VKTHUnZxERO17JJOTdHpX/JBgMLUWUU0W+0wu6CP54HdATJ7HfyKJf?=
 =?iso-8859-1?Q?BKmW7UHf8iKrGbdFEojOZUUt1rttiPd3imwBPNEyx2wBeK0tyt6uEe9jgD?=
 =?iso-8859-1?Q?gu9VSsMEJOfqhUUpKIPEXsMUKYyxECwmf5A+LIy1qrF4AjuAAGMlt1zTpL?=
 =?iso-8859-1?Q?YdeRyfUoMUlGJO9AFjMgJZNNxBb84vGp7XMBwUDHd1z8S4TQ/PAXzLW9Xn?=
 =?iso-8859-1?Q?56ZNQnoWtnHxgdlYX6tuMeyysDld7Z8lv7oX6I3YamMWKBa1vDvBOVlT6l?=
 =?iso-8859-1?Q?aHjlSg6iDIozKmgfOgMhHxmSpRaBdp+0qIpsWRpNLzc/nf7FJ6O+EPTel9?=
 =?iso-8859-1?Q?GLBKuDOYRnkXJ0rvpw2CWB3VkWdvEB8m2heQ4G6vZViOePUx74Knhp9D16?=
 =?iso-8859-1?Q?sXFN8xCi4iHFRft4WJSdrKzdJQ4sMyEJMTUQrTYUf/+KsAhFdbRPgBhosy?=
 =?iso-8859-1?Q?VR9c0JhjAQj/8l626EMWfd8p+duU9bB98Whm4fX8G2TmNAb8K+BIDmc89N?=
 =?iso-8859-1?Q?Pi9G/5DUHfkPiETTxpT+iBH29sKvJRVRpg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: 3dsystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74f197a-eb9d-442c-3a6a-08da879bb6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 19:46:48.1962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 150688f4-8db2-44d3-b980-cd00ab6848fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGxbc3qpF2ZU+MjvDdP5KCKbFGgUWWCxH8v3zPU7SAoIV887r3OHJw9AGEkGuoT+L6kISzQ5OkwsOHMddUpnXK4TcN/O4MXnvc+rBf8/5gQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3652
X-Proofpoint-ORIG-GUID: 3YxUfoEmbHd7uCsqlg2oQhxcWPm-4OEZ
X-Proofpoint-GUID: 3YxUfoEmbHd7uCsqlg2oQhxcWPm-4OEZ

I'm porting a working PCI device driver from Cobalt/IPipe to Cobalt/Dovetai=
l and everything builds normally. When I attempt to install the driver I ge=
t the error pasted below. I tried sending the IRQF_SHARED flag in rtdm_irq_=
request but it didn't help (the flag was ignored perhaps?). Any thoughts on=
 what to try next? I suppose I'll trace through the cobalt code and into do=
vetail to see why the shared flag didn't take and why xnintr_destroy is bei=
ng called.

Aug 26 11:21:26 xeno-mx3110h-01 kernel: genirq: Flags mismatch irq 16. 0021=
0000 (bolt) vs. 00000080 (i801_smbus)=20
Aug 26 11:21:26 xeno-mx3110h-01 kernel: ------------[ cut here ]-----------=
-
Aug 26 11:21:26 xeno-mx3110h-01 kernel: Trying to free already-free IRQ 16
Aug 26 11:21:26 xeno-mx3110h-01 kernel: WARNING: CPU: 3 PID: 47441 at kerne=
l/irq/manage.c:1942 free_irq+0x249/0x470
Aug 26 11:21:26 xeno-mx3110h-01 kernel: Modules linked in: bolt_driver(OE+)=
 evbus_driver(OE) nls_iso8859_1 i915 intel_rapl_msr intel_rapl_common x86_p=
kg_temp_thermal intel_>
Aug 26 11:21:26 xeno-mx3110h-01 kernel: CPU: 3 PID: 47441 Comm: insmod Tain=
ted: G =A0 =A0 =A0 =A0W =A0OE =A0 =A0 5.15.57-bolt #1
Aug 26 11:21:26 xeno-mx3110h-01 kernel: Hardware name: Default string Defau=
lt string/Default string, BIOS 1.01B 09/21/2020
Aug 26 11:21:26 xeno-mx3110h-01 kernel: IRQ stage: Linux
Aug 26 11:21:26 xeno-mx3110h-01 kernel: RIP: 0010:free_irq+0x249/0x470
Aug 26 11:21:26 xeno-mx3110h-01 kernel: Code: 41 0f b1 94 24 c0 00 00 00 0f=
 85 c0 01 00 00 9c 41 59 e9 76 fe ff ff 44 89 fe 48 c7 c7 18 d2 b2 82 4c 89=
 4d c8 e8 a3 58 9f 00 >
Aug 26 11:21:26 xeno-mx3110h-01 kernel: RSP: 0018:ffffa52ec15579b0 EFLAGS: =
00010082
Aug 26 11:21:26 xeno-mx3110h-01 kernel: RAX: 0000000000000000 RBX: ffffffff=
c0a23aa0 RCX: 0000000000000027
Aug 26 11:21:26 xeno-mx3110h-01 kernel: RDX: 0000000000000027 RSI: 80000000=
ffffe62f RDI: ffff8ac67659f4c8
Aug 26 11:21:26 xeno-mx3110h-01 kernel: RBP: ffffa52ec15579e8 R08: ffff8ac6=
7659f4c0 R09: 0000000000000001
Aug 26 11:21:26 xeno-mx3110h-01 kernel: R10: 0000000000000001 R11: ffffffff=
8335689a R12: ffff8ac5001f6000
Aug 26 11:21:26 xeno-mx3110h-01 kernel: R13: ffff8ac5001f6180 R14: ffff8ac5=
00cfec80 R15: 0000000000000010
Aug 26 11:21:26 xeno-mx3110h-01 kernel: FS: =A000007f1174eda540(0000) GS:ff=
ff8ac676580000(0000) knlGS:0000000000000000
Aug 26 11:21:26 xeno-mx3110h-01 kernel: CS: =A00010 DS: 0000 ES: 0000 CR0: =
0000000080050033
Aug 26 11:21:26 xeno-mx3110h-01 kernel: CR2: 000055ba0acd3c28 CR3: 00000001=
025ec002 CR4: 00000000003706e0
Aug 26 11:21:26 xeno-mx3110h-01 kernel: Call Trace:
Aug 26 11:21:26 xeno-mx3110h-01 kernel: =A0<TASK>
Aug 26 11:21:26 xeno-mx3110h-01 kernel: =A0xnintr_detach+0x25/0x30
Aug 26 11:21:26 xeno-mx3110h-01 kernel: =A0xnintr_destroy+0xe/0x20
Aug 26 11:21:26 xeno-mx3110h-01 kernel: =A0rtdm_irq_request_affine+0x82/0xa=
0
Aug 26 11:21:26 xeno-mx3110h-01 kernel: =A0rtdm_irq_request+0x10/0x20
Aug 26 11:21:26 xeno-mx3110h-01 kernel: =A0bolt_pci_probe+0x192/0x240 [bolt=
_driver]
Aug 26 11:21:26 xeno-mx3110h-01 kernel: =A0local_pci_probe+0x48/0x90
Aug 26 11:21:26 xeno-mx3110h-01 kernel: =A0pci_device_probe+0x113/0x1c0
Aug 26 11:21:26 xeno-mx3110h-01 kernel: =A0really_probe+0x1a4/0x3e0


Kendall Auel, Senior Embedded Software Engineer
3D Systems,=A026600 SW Parkway Ave., Suite 300, Dock 61, Wilsonville OR 970=
70,=A0USA
Tel:=A0+1 503 482 1970 =A0 Mobile:=A0+1 503 939 6862 =A0=A0http://3dsystems=
.com/

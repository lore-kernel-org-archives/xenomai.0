Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2113.outbound.protection.outlook.com [40.107.8.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0824C63AD
	for <xenomai@lists.linux.dev>; Tue, 26 Sep 2023 11:21:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu+1q2b7tWSIUCmeJ5r7NBbzqhx1UMnlEGiZsCanIiQol3e4jcUpsI4V74vUDB4O/IsCZ4qiWZRMDhu4Uttw1nA7bsSPl0qZAYQWlonr/Lkt9sYtm/Lq0O+Wcn8kKtyn6Kh6kI+RF2qPIYFPWbgoKw/qTRh05Ao8xdOySHKnVHoZI3z87CXIAD096w9Vdr3PWQWyzHcUB24giAqZTgJLUva8Qg6pXHBx8tPjx491iR2kkw4863NdJzS4RANkonz+xySselp/yYOLQYRFubYawArHxFydok69uvfZEoxaKtD91fOJROd6M38RRPeF2YzTW000z8iXA+7zXbyqaDKPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MNFTnVNGsGVsxl4b9YTLxlZ6epzc3130ESVVvaJf7c=;
 b=kSETzOgqQDFpFIbsWsFMpBeoKcn14zGV+ozLmOczcB3FsePuBmydm6uAAAq/IutGTzXmk3+xUYYNbhG8MASst/moypDPhy8oGbDPDPAa+0Gr+J0NLcDb9aSrbtmtTd2v6na7ZkLl+kldwX+phAgoHdk3vGsHdQpM2zrNOer4zL9ZXJ4awvPMwtrMVnF0pcOX3yPIjlNjc+MEaYIJatX3Vl7N8yLTCPM0vWDDC7RmHzpcZZ07elO1u7wRMQgXcvmokBSvMSD4cIAsB7L3gK7bmaN+GMkh1t0vTb/Axrq4VOntknElMZ/F73jKm3nC+N96uUy3f3uKmbUPJ0HKmvSUWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ecler.com; dmarc=pass action=none header.from=ecler.com;
 dkim=pass header.d=ecler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ecler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MNFTnVNGsGVsxl4b9YTLxlZ6epzc3130ESVVvaJf7c=;
 b=aNqzMtBoINh4B978lohLqa/ATGC+XYGZ4UjgP71PB+nmxzrFf4Uz7vn2yPXX/lafxlG6jFJs8b9fEs1Dl45ztF35XQ0gQ+0osNrcRNXbUyon30oaUhRkpsy+v01QL5OzVoQdDNwqhldIelUB+16Tc6OC3uBATGbKKOmgoLWtL4zK6AdiCqIJKKstSR2kTyNHc2MlQ9VDMiDgAg3utktwF75MmTcKrWLKVLE7H+25ZDxXiVBCbtIN0HgDrm4IvO6KpQcn+Vdp+npnXeO6lLgor+CCJReu/RyiGMjx/roNg1NgQ5/KbYP+unKTAApG0WYvEYn760AkabyzXL81069m1Q==
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13c::17)
 by DU0PR10MB6106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 11:21:04 +0000
Received: from DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::724b:81b0:1a33:23c8]) by DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::724b:81b0:1a33:23c8%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 11:21:04 +0000
From: Jesus Villena <j.villena@ecler.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: [EVL] Problems writing to physical memory with mmap on oob context
Thread-Topic: [EVL] Problems writing to physical memory with mmap on oob
 context
Thread-Index: AdnwZ6yKI9X5QCLEQ5i2sLHRmtbSsw==
Date: Tue, 26 Sep 2023 11:21:04 +0000
Message-ID:
 <DB8PR10MB370698CF0BAFEAE2198D24A3F9C3A@DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ecler.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3706:EE_|DU0PR10MB6106:EE_
x-ms-office365-filtering-correlation-id: 4847d749-94ae-4aa4-c653-08dbbe82abd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PIsbbhqgTgjqfpHK8iitMKDZ7f7AFehOZFjhY3MxWiLNsbdVR8W1bOib/lYCtlVwBKpP18aG+iXHnD6OVOyQlXBKzNWoq+a1ZgJDqAIfsav6EcPzCGVTBXx5EVzFuIoKnNKZx7TeRQ9aaOzd3R2m13vKYVuZ2wm6m4a0YUdgV8hWecmvmkuAOf3irCIvQPSE31+HSK9R7NqSmoG5KJsg64v13ROvicznVJt4RdPqBhozBMYgO5u7LH6sJHo0He6RiODXjEweo9fX+dB24vFLyowcBd9cmM9EyNWzT0c6GRCO15pFW66ui4nHOVuPejpFbaP0JAXV8ObYQC+VTMi+ce+eXtFdjLBqEguq8zFtS0NMdSLOKsw1W5fUcQ6CO1F4KWI4lKLdBXNfa0XrdYthTXeMMLvAmZjbv7U4ozzJxNXyHEwNUxFoaWyBBq/P7bX1Tbjn1To6YVEnAf9z+w/GPDg6/X8DrMfuGYZx1nmLpOGzu6YtBCtSfqsSkdXmDyjPdNDX8hgGbotvGGUKzmT+gDYwJEOwapY5CFgvUYEo2gG9m2LvGZFEQ8bwQdyWyV5XXIdPcXHzj0s/d0GRxceArO4nmyYdNzskKZ5bFbcDTcXSdR/foTlxIaHxIKOnkq8Z
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39840400004)(366004)(230922051799003)(186009)(1800799009)(451199024)(66446008)(66556008)(64756008)(66476007)(76116006)(66946007)(26005)(8676002)(316002)(6916009)(8936002)(9686003)(52536014)(55016003)(41300700001)(5660300002)(71200400001)(86362001)(2906002)(38070700005)(4744005)(38100700002)(478600001)(122000001)(83380400001)(7696005)(6506007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zdXmqMFZZuCv+euMkjht43tOahQDQ5UsvUtVqJIWXwo21X3tbW3BR5PuerwX?=
 =?us-ascii?Q?VQekwioV1xJPcyN6uBQSQ3LhoJtHZ3QBbrnQCiFUV1Cr0eZzeNGUcWVcyT3c?=
 =?us-ascii?Q?PHfN8tqGdQz/r2o5sSRgKW4PM5aUoMYGxp9vYtvtFx/YmVAhX+4DU5AMPnl7?=
 =?us-ascii?Q?Bng2ZSbV64dNzzUmCv3gEWAvCORNvoU81MRnmQTmIKKDc6ZoW+zebfC5sfOo?=
 =?us-ascii?Q?DoIFbHZ0VEBIR3hb2JMqWt2rW+Oyi9GeTxfFW5FdNUPuVNxWuIH50qo50bZH?=
 =?us-ascii?Q?zHN2kWiE2RxA27CsnE8BMy0SyzAmAfP+v/Z+nkdCdjNAQt+EbN5BHRU9zQs4?=
 =?us-ascii?Q?BSY5kElxFaZdzup661dSBT3/aENzW3KgagxAVrGof2UxbpTrKLJTjrmLXWjw?=
 =?us-ascii?Q?NnVAfboxvobI7PkWWdK+3ysqGV+Vxz5Tik1teOZ7yMatTcnYg9yAY/j4JTOq?=
 =?us-ascii?Q?oIqSlCoTcQ8ORj/Hts+wNQB2pnvhVwn7b9tCxOPty/mrVfv3Z1BqOfwQBC7k?=
 =?us-ascii?Q?VHSNZBup9VgZbqx6u3BbxluUwlYFqB4ioIiV7F0+Nf3wvF6O2sueCR6oQZzX?=
 =?us-ascii?Q?Mgubl+EB1A/s273Jjy/LZkeg00da5btkwJ3cvk8TlSkr3HAh7m4G8lvbcwvm?=
 =?us-ascii?Q?HD/UkhTXGQwyCzgmk8I37y160piMbDcGNMtlYMSr/aYz40f73g9CNo0Lis0K?=
 =?us-ascii?Q?MO5HwoKH1yuZC7iom1qzjC1DeERSmDQHN2RAYTP4T2mwwUuPrNy+bDGlPQba?=
 =?us-ascii?Q?TTT432lPq6DmFjJIQrec3MCsp8oJ+P28jj3Z9Ehm60o/dKKJj6Nh2AfR5CCf?=
 =?us-ascii?Q?3Vwor0QBB8mgpqPh149VtOK3II3dcbuGcSR49YUKf7dId6OWNSWMVddvMGp5?=
 =?us-ascii?Q?plfBVbwDnyVVyqcwsYE88fIZVdVx+UvNOUoJIFDA1nwx7c7C7AnCgtPF486v?=
 =?us-ascii?Q?66/9ndanaK1AWpNIRtdE8WJPitbKBmBARtUl9mfqcJYIObT5Fmh7ohuazrN2?=
 =?us-ascii?Q?rsN73Y+xD/VR+5EG22/2gBeJqVmlidTChd/rrb9Jyeu8Lsn1qYpfoUxFlZkf?=
 =?us-ascii?Q?/4TYtqs4PoHGTC5cXjtv97xDyDQrXG7rtCpmLBu4NZh/KmIDQDa7z6AQnDHn?=
 =?us-ascii?Q?jpNmlO8A3VR6CZTeYGgTzTrEwIHG3AIY1tBD2GGq+2siWXeeYRTGLfC5UGd/?=
 =?us-ascii?Q?5z6EaaMg2XjftTNz9Wy+8Zy0ZSSOXfU5sqwFVpLDbPO90U82/wlj2VmSJ45i?=
 =?us-ascii?Q?0sLiiPG41EOItrAaM8UQqb8p3iTllql876ZcTE56fZ44Z05SM7kgsD3xXpn8?=
 =?us-ascii?Q?8zZjfW60fFKDqyPD6VgLWmgxGtNMicRMWKz8XW3e079aXtFmX6kotnIyjKVK?=
 =?us-ascii?Q?j1xlx8kg6D3nk0NdcDoZ9n/ifEZ280e1v9q6FDFix3m5ruZDvYAgTxzvNKRP?=
 =?us-ascii?Q?2HT91euPfCYErut8gXpOv9pIoqOkD84G/hdnyDAfmfyY+9LW3rFFK7sYUEjt?=
 =?us-ascii?Q?idYQ4M1wf7RFq5zvau9Dcw9RR0uHr3PllYc5dCMoC9rM5FWLm23hGBrxfiWr?=
 =?us-ascii?Q?uIrR0a4PuBzUpNNRpmn1JlVjTrrIxgX4qAHPsBxh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: ecler.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3706.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4847d749-94ae-4aa4-c653-08dbbe82abd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 11:21:04.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f9193a3-7ddb-4a6c-9664-df2759e0e5ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ee82gR7EaQ2nmbg5Dd1ZekjGYd+TwhWgUbW3hENbUPv3qF59hlfMKo/6pn78sj+PUu3PVCDAw74vX4EEqDf7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6106

Hello,

We are using an ARM64 based platform which includes a small Cortex M4 proce=
ssor to run some algorithms, and both subsystems use an internal shared SRA=
M memory to implement the inter-processor communication.

In mainline Linux, we open a "/dev/mem" file in the ARM64 core to get acces=
s to physical memory, and mmap the shared area to read and write directly t=
o the SRAM from userland.

With EVL, it doesn't work: after opening the file and doing mmap, we call e=
vl_attach_self to switch to the oob context, and then, reading on the share=
d area works, but writing aborts the program with the message:

EVL: evl_test switching in-band [pid=3D363, excpt=3D0, user_pc=3D0x404b5c]
oop...
CPU time limit exceeded

I don't understand why EVL is switching to in-band context.

Do you know where is the problem? Why does reading work but writing doesn't=
?

Regards.

Jesus Villena


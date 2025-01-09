Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC101FCFF5
	for <xenomai@lists.linux.dev>; Thu,  9 Jan 2025 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452114; cv=fail; b=VmqYrJrx2s8n6GdhiQWUQCgzjKajkr0VawpqCDQnQfsGcl60cfSD8rWSpzQ2mUW3VZqjwaEIBaPb60AQWF+Ec/PTrmRMq8zMvsrIoxsCfELOPmV/J9fwvonLm1MwQkvLTZTU+k+6iRRG/DNmxuw/nfj6MZGqoq2IrbI0LQipC4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452114; c=relaxed/simple;
	bh=GzK38LOFaCjBQrkgEpzfKXU1AHHDg3QPavKTib59tu0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n7L/AYtRVeydzeSD1b9eEi3zMhZQ0iCij19YpsOgUZwVUafvQ5EavDB22mHNJwCe5NTyv5xu5vR8DijAr+xN9jevIaBtUB5T+cMW7/8Y9BC4osrOHg0FeTgQpYBGrd55UepU/Kehychrv+1x3dAmOkpqgnNQev6O0M4i8L19CC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mts.com; spf=pass smtp.mailfrom=mts.com; dkim=pass (2048-bit key) header.d=mts.com header.i=@mts.com header.b=frf0sr6H; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mts.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mts.com header.i=@mts.com header.b="frf0sr6H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erAoWtI7rHkvpdIL6IiqtdNHpGEro1UPJev7T0ijy7i+ezflFjfPTk2p6WyDW0zYZt9P83cUcGXSYS3D2Iz3BtGCNEK1CsR9rfRC+Fp07NxyDp3rxJoqzzlyOVU91ATUD2EN6FonJe4WFn3tANnYZTyIxyrXO2c3qu+OsQOT/38tROnYXi5hrqWY8NVk3V4zopQSuR8CA3Ly7r8QJEHq7DLTtzKdORW7MQXLsW7KeE7GgoDqRbiRnIfttdIbcFn+gEJuunSDiOM/DsJqQGWg82ZR2K6N2VMFsmI4MQ4TH14dJLI5HLr4CzS9UJ7vUBON7s/e9UIzIIRItLgVkJu34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bga8HzI/FFiV7+6V4PdJj1SEQuTUXCIVa+3mpdu9xDo=;
 b=WBi/FBNDFQjF1YY5NKJSndX6Q9upOimy6VEr7FjHKyTzw9eFZFXrnMYPil82Ds5pyKcWuB9yl0sLeylAVXcqxMHEXhz4QZh5oBFN6V0ICdyq9AvaIZ3fDf5650t0c0U7sp6kdVoEIzXawvqvTnw13zHzv2Op4IzEVMbEmey2grMMXLd3TmIwjIJnsRNnAU4JKYdaaiwOf/l2fwH54UgcijdEg2IvA5GJZGJ1EYK0HllQ/P057hsAdtbqI6AZoWq/zw8Yn6AszWMeEv/Zru6tBSQqoDlHBSD35JV5ZRFWr6s/LCwKyWFPGzeOs837J8KaHQ8zJdgj4PqSiLFvZsKe4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mts.com; dmarc=pass action=none header.from=mts.com; dkim=pass
 header.d=mts.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mts.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bga8HzI/FFiV7+6V4PdJj1SEQuTUXCIVa+3mpdu9xDo=;
 b=frf0sr6Hyn7A1ksqTi2Dwc4S6R6Fjx2uOJqjDoBEqXyqofFHZdavsHPKV9kZx0hcdaQPsbrcnFUXw4m/Tp7o/P19DQuSkiwIVpWo88CrdMI3Khp+lOHLBwic2TiOUtRnruABNQMokDWPPh+1NHVG+G9BKE/VAxAXiXHWustBrIyoW9RRMiw3Euo6UqB0k8z9s7vyI6FYUJb4y5dyVkg71CBRpX0peURCqomorHeCPHPlDdOCfri+VWuDCjTCNHGIHhlJ6eR5d1iiET9SKyc6dOCiLdxpYjZaGp0589xYIzMpqb6Pmj8/p6ocqoYpCMcTmPuRsu6uGQsYskTD+6YH1w==
Received: from MN2PR04MB6255.namprd04.prod.outlook.com (2603:10b6:208:d5::11)
 by SJ0PR04MB8537.namprd04.prod.outlook.com (2603:10b6:a03:4ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 19:48:29 +0000
Received: from MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::a3da:79ff:4eae:2040]) by MN2PR04MB6255.namprd04.prod.outlook.com
 ([fe80::a3da:79ff:4eae:2040%3]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 19:48:29 +0000
From: "Rosenow, James" <jim.rosenow@mts.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Relax tracing not working for me (solved)
Thread-Topic: Relax tracing not working for me (solved)
Thread-Index: AQHbYs90tFVSsHxTmUeMb4R8HcaAZQ==
Date: Thu, 9 Jan 2025 19:48:28 +0000
Message-ID:
 <MN2PR04MB6255FE69E8FA3E63FA62549EE2132@MN2PR04MB6255.namprd04.prod.outlook.com>
References:
 <MN2PR04MB6255403DD160D9EDA3319AA5E2112@MN2PR04MB6255.namprd04.prod.outlook.com>
 <87r05dve9r.fsf@xenomai.org>
In-Reply-To: <87r05dve9r.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mts.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6255:EE_|SJ0PR04MB8537:EE_
x-ms-office365-filtering-correlation-id: dd45dadc-476b-4c61-30b3-08dd30e696f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?u664iwnQAwHJ4pVC/NctHib0wTGhOLdLqOKXXTBd15LKYwswzaSNd6w3+NNo?=
 =?us-ascii?Q?aYrH/we+wROq2XJ0mCTb0pzbofSAR+JhE3SW8rnIESK5CFq19lNmewUfFieT?=
 =?us-ascii?Q?2mrL57eiPE7CJ+h1FNPus2rR5kROfw1tSO64Yn2Ggime1BmPyWdaRO5+NoTw?=
 =?us-ascii?Q?+wqDugQg0N2UbnsJhjnTGM9vuR5E915sO8m6KZgPNsQpM02wcAQd5d2PtZQR?=
 =?us-ascii?Q?d1VFqsgyyRB3ZXVGOPXrcS7RorIO6+3OiQ8amrlbW6NsZn4PdhOkEDWu9TRb?=
 =?us-ascii?Q?w+wkReYhc9PZ59S5HEIBBypSmPgbJkg1HmM2MpgiDlBn/jesCzjF/U+pVx7m?=
 =?us-ascii?Q?cGlV1XaPKhcHecH4QZiHPgDkcQ0ik4ymTHEIccKd/RxaicHxhV5hr81LscgQ?=
 =?us-ascii?Q?SfAlEx1IYMiDof6ctY1kdEoA8NlQROSSGaDyD9trAaFha+e8PAhmsO/FYNwi?=
 =?us-ascii?Q?2arjEu1H0lda/lxjqqP3j9uPlHM7zVcNr2oj56Ih6zi5+dkcUBeX1xcd4Sf0?=
 =?us-ascii?Q?Biapq+FEzfmb2FyyVfu04yaJnr5f1iDoZvDfqiYhDIRC/74UPJRuSQd8/wCS?=
 =?us-ascii?Q?XinUJ+1DnUwlt9Inm/BL0kj6f+lVuiLBm20WZ5INtpILgwifFiuquWqk6ifH?=
 =?us-ascii?Q?W41zND8VpDu1IMLyBRN/HbTrNJtkyA9BeoZNbXB6Qu9REVcbiOXanMOQh+Zq?=
 =?us-ascii?Q?nl0+hChGyzfQ+kZObHmZAJGarE/7lwsomGhiO8LJfqu4Cp8gzj9cUS50q7Lc?=
 =?us-ascii?Q?ylDDwr1Muosq9DID1EBAXs76S3AARvkoJcuQirnKnskgRUVk/vEtoPHNMM0Y?=
 =?us-ascii?Q?LQm8Evp+3JYM0pnCF+2p1JhQiK185BcCSLOG7e3dH+ms0NHLGjtG3TnTcQB0?=
 =?us-ascii?Q?eJDNCody8Kk6cJ94dnp33FRGJPzLOiB2UU/b3RRbpkET23C55BzCD1hJ/vOC?=
 =?us-ascii?Q?HasMb+/li0hzK4c2BlYwTFkcXjk592Y/jvuT7hlxBtvBER0QcCiHqlTJJHJz?=
 =?us-ascii?Q?aM49tJ/S6u3be8bTWgTwNN6hX6l/vOWP75a1TcRVJxs906FuIezt+d29bhwo?=
 =?us-ascii?Q?tYoQ7xZb6HPluBvyIC5iH6UICJscEEJJCtu0tnnDMd0y/SqNKJiN/0z8iL7g?=
 =?us-ascii?Q?QVLlKcuUnEV6aLBVNw89fMKrOiIMN9EpIaHui7XYj6Tj22iXZZFvUfYBgahG?=
 =?us-ascii?Q?C0HjvsXPaHAfCisrg7Y4XPOowonKazESVGbru9eTNDeTm+MsZhU6pZQYX2wK?=
 =?us-ascii?Q?kO4fs9HnWzsRCRNfuyaIWI0tMCi9h/CU1VNqSN4yQYsEGsP4oYYTVM0D3FiT?=
 =?us-ascii?Q?HAXgap5tkZd8SagtdY6k4ND1f59J47AdRkdEPct99IzZH+V2Hg1fpS9JBLZg?=
 =?us-ascii?Q?bagPzK+GIuAVRRcWJQWeMgRabGm1fvJE/ff6W7FDNxLBVg/MwrOhi5NeHvrA?=
 =?us-ascii?Q?dMAMvM1pZBSuG6kCIlY0udQCtTtMjt+p?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6255.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Kch3YkHJtWbnhOS2ip2iaRTWspOuXVbcF9Pj9Otx2wZE3jjnf0X6OFDeOZ33?=
 =?us-ascii?Q?oDYDosg9go1HEJ723rMdIoI9hjbAt/6LLPSi+UCVkXi/Lx2Xd+FQl3ZAQr4y?=
 =?us-ascii?Q?+lX2PbaZlJ2dzmbJBI67snxrVu6kHmYnDm2fT+/evwKaEnV+6XnHjW2IEDLC?=
 =?us-ascii?Q?9E3ZmIqgNKufIByfqF0ldl7X5jN7nJnbju4dRInAig+q5GDdcIl+0IpYsQEx?=
 =?us-ascii?Q?pUCIyPckCTJn6VHqUJARVsVaBNX1oIEobDf7haRvqeSkLUkZBWR0iZAm4SrW?=
 =?us-ascii?Q?ZlNbMTxzRIGgSjrwF2BS8a2SfTN4r+ta3qzRpu6RXFC0n4xutP8EirUh7ccu?=
 =?us-ascii?Q?0FMrCffslJ4BDD69p77QhWQt+5YDF/PW4qqi7Kihvdq+a2fDE6LO/rYPD71g?=
 =?us-ascii?Q?e1ee9X69b0Lt8v9SDVMdJ6rWvFMM2O5soqqxil3vh8Nbn/jNoroNG8ziH0Kv?=
 =?us-ascii?Q?SPy6LCTvvEQMPYlVCesTNxmN7oHCGp6ZfAJxo960ZCWpvx6whXPFjTF5TjW0?=
 =?us-ascii?Q?s0nXgXT2263B06drrdXkJrpSBE+iKRTU+BSA8MHzUtBJ2GniLQnrdk0ya0Sh?=
 =?us-ascii?Q?20l2DZtSKTqS7kFXH9s3yC30vl4TL7CgiKFjqzBYYDdDntobOeQjSOAK5a/7?=
 =?us-ascii?Q?TsuvmVb86p2b2+xCH0RRGN1y3Xi7bNPnpWQFhCze2donmF7nkI9EXGcm059z?=
 =?us-ascii?Q?pRqOg10Dnx/EZq45t5r4NzqW9yeg9ygcYzTRA8wHhnrvtmaoqaS7S4XfUTSS?=
 =?us-ascii?Q?l5y4mDN8urnfZX7/0dPegNcdJiwdfydsAhL7A//qIOfnffpeKTTJRZK9jPcB?=
 =?us-ascii?Q?1WxB8jdw6TW0sK+o/eYeFbTaqUn71xNhuUE02oQLc6AcvQrN9p2H/hxar84C?=
 =?us-ascii?Q?WQM6Ghie2kcNS8TTGMyX5e4qdkEKrm6stT1cgl4FyoFv/F+gJonaMdQpOyqA?=
 =?us-ascii?Q?9JZRnA15RokTmnTopE6vC4K0nXlkWQ5cg5tkEkDZjmmWDhAIakAK6J2KPEvx?=
 =?us-ascii?Q?pxd9H0+IbneyHIZh721LO1PE4TxALiCgSU0vRCxXKgfMPmTU2w3v9zfs+xa+?=
 =?us-ascii?Q?4NbtBtpcxbm9OV87jm7EMdPr8kX0RQUJsv+fDfEjqNDAtQd1UDzd5yR7q8DV?=
 =?us-ascii?Q?8zgqKxf8rqKE4llbjOrXs6QeVo93I1ZYVUKr6LKGdbsSfv1HgJHSYUSRWigo?=
 =?us-ascii?Q?P1sxeCs8oo/DTm77Fb8GJgPXsNboKHEWpDkRi5UAKshgWjklON/I1JEzZQsp?=
 =?us-ascii?Q?K9JCg3RkaYAgwshfOe8BwnR0yPMNJPf9WQ42YHbiaNrOb9IGv2sypUXWUUTA?=
 =?us-ascii?Q?JwDs9WLuwhFKG9r8bEP2BKbyHHcnE9VrToYtpwz3xVXMPXDqJNjgbpn7xCBz?=
 =?us-ascii?Q?+4O67wD0kLS+Sq+WjmpNs8PA3+eXw48pBdL7NUJyhizazT2hlU+gkXAbUwBd?=
 =?us-ascii?Q?F7Bc93tFLJrIcY6WauJtxTjwT7N7oSYU74yKX5oN9qVGiNeJVLQvsEElyUfb?=
 =?us-ascii?Q?A6QIGDHcQuv0cuDxzKYISw6uSH9fmHetl7nyWU4E0EJGGFtMCt5vPlEXhCcm?=
 =?us-ascii?Q?SKYZyjG+M5FtxGg7uQzg2k5CBFxLIydCGm2nQwSR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: mts.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6255.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd45dadc-476b-4c61-30b3-08dd30e696f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 19:48:28.9557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7fa3ed9f-fff9-4884-a6e2-8dd98886b775
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nfIz3FcOlkbpJWRpnPIPngqAsClj8ucIl8MbCwvkhlHPwGWqCkJbFlq4z2mA5hl2onvJGasStw9nwSwWGtRAng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8537

Thank you, Philippe.

This helped; I have located the call source of the MSW and now I am in need=
 some guidance on how to go about fixing it.

The offending calls look like this:

Userspace call:

  int dma_move( struct ioctl_dma_req *dr_p)
  {
    return( ioctl( fd, IOCTL_DMA_MOVE, dr_p));
  }

Kernel driver call:

int=20
ioctl_dma( struct dma_device *dev,
	   unsigned int cmd,
	   unsigned long arg)
{
  int retval;

  retval =3D 0;
  switch ( cmd)
  {
    case IOCTL_DMA_MOVE:
    {
      struct ioctl_dma_req dma_req;

      if( copy_from_user(&dma_req, (void *)arg, sizeof(dma_req)))
      {
        return( -EFAULT);
      }
      retval =3D dma_move( dev, &dma_req);
      if( retval < 0)
      {
        return( retval);
      }
      if( copy_to_user( (void *)arg, &dma_req, sizeof( dma_req)))
      {
        return -EFAULT;
      }
      break;
    }

So my questions are these:
1) Is the MSW occurring due to the ioctl() call from userspace?
2) Or is the MSW occurring in the kernel module?

And finally,
3) In this scenario, which must be somewhat common for real-time systems, i=
.e., a device driver is needed to facilitate some sort of real-time hardwar=
e operation, how does one 'port' this properly into Xenomai such that it do=
es incur MSW?

Thanks and regards,
Jim Rosenow
MTS Systems Corporation

> -----Original Message-----
> From: Philippe Gerum <rpm@xenomai.org>
> Sent: Wednesday, January 8, 2025 3:36 AM
> To: Rosenow, James <jim.rosenow@mts.com>
> Cc: xenomai@lists.linux.dev
> Subject: Re: Relax tracing not working for me
>=20
> CAUTION: External Email
>=20
>=20
> "Rosenow, James" <jim.rosenow@mts.com> writes:
>=20
> > I am using Xenomai v3.2.1 on 5.15.57-dovetail and I have selected the f=
ollowing
> kernel configuration option.
> >
> > .config - Linux/x86 5.15.57 Kernel Configuration  Xenomai/cobalt >
> > Debug support
> > [*]   Trace relax requests
> >
> > When I run my application, I am getting MSW's on one of my real-time ta=
sks, i.e.
> seqTask-00 (below).
> >
> > Every 10.0s: cat /proc/xenomai/sched/stat                              =
   test: Tue Jan  7
> 16:32:14 2025
> > CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAM=
E
> >   0  0      0          3526511    0          0     00018000   99.8  [RO=
OT/0]
> >   1  0      0          22166547   0          0     00018000   98.7  [RO=
OT/1]
> >   2  0      0          6          0          0     00018000  100.0  [RO=
OT/2]
> >   3  0      0          0          0          0     00018000  100.0  [RO=
OT/3]
> >   4  0      0          12         0          0     00018000  100.0  [RO=
OT/4]
> >   5  0      0          0          0          0     00018000  100.0  [RO=
OT/5]
> >   0  311    0          2          0          0     00000042    0.0  [rt=
net-stack]
> >   0  312    0          2          0          0     00020042    0.0  [rt=
net-rtpc]
> >   0  34201  8          8          54         0     000480c0    0.0  coo=
ps_target_main
> >   0  34203  714420     714421     1429756    0     000480c0    0.2  use=
rCycle
> >   1  34204  2          2          571184     0     000480c0    0.0  clo=
ckInterrupt
> >   1  34205  1          571183     1356559    0     00048042    0.4  dis=
patch
> >   1  34206  571182     1142364    713982     0     00048042    0.5  seq=
Task-00
> >   1  34207  1          285594     356993     0     00048042    0.3  seq=
Task-01
> >   1  34208  1          142798     180963     0     00048042    0.1  seq=
Task-02
> >   1  34209  1          2          3          0     00048042    0.0  seq=
Task-03
> >   1  34210  1          2          3          0     00048042    0.0  seq=
Task-04
> >
> > This is an iterative task that is executing at 2000Hz, I get 1 addition=
al MSW for
> each run iteration.  As you can see there are many MSW's.  Shouldn't the =
trace
> buffer be full of these relaxations?  If I cat the buffer, I see nothing.
> >
> > test@test:~$ cat /proc/xenomai/debug/relax test@test:~$
> >
> > What am I doing wrong?
> >
>=20
> In short, you may want to make sure that PTHREAD_WARNSW is set for 'seqTa=
sk-
> 00'. The STAT field for that task reveals that it's not (0x4000 is clear =
there).
>=20
> Why? Because the logic of MSW tracing is as follows when
> CONFIG_XENO_OPT_DEBUG_TRACE_RELAX is set:
>=20
> 1. On MSW detected by the core for the current thread _and only if_
> PTHREAD_WARNSW is set for such thread (which is running a syscall), the l=
atter is
> immediately sent SIGWINCH(aka SIGSHADOW), with
> info=3DSIGSHADOW_ACTION_BACKTRACE (xnthread_relax ->
> xndebug_notify_relax).
>=20
> 2. The pre-defined SIGSHADOW handler in libcobalt.so (see
> lib/cobalt/sigshadow.c) runs, taking a snapshot of the current stack back=
trace,
> then sends it to the core via Cobalt's 'backtrace' system call. Since we =
are not
> using alternate stacks, the code which caused the MSW must appear somewhe=
re
> in the lower frames below the current signal frame. This location is figu=
red out by
> the slackspot utility when analyzing the captured frames.
>=20
> 3. The core receives the backtrace data, then logs it into the appropriat=
e trace
> buffer which is behind /proc/xenomai/debug/relax (backtrace ->
> xndebug_trace_relax, cobalt/posix/syscall.c).
>=20
> HTH,
>=20
> --
> Philippe.

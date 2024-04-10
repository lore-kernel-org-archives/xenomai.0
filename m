Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2103.outbound.protection.outlook.com [40.107.105.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9B13D2A1
	for <xenomai@lists.linux.dev>; Wed, 10 Apr 2024 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735216; cv=fail; b=QBhSv6n5XRsBNnRVZiKO9xE6wClyCvbJtw4ly0npdXb+EPGUzGnLHy/bOW1DDlwZXNXaJwUGyNnbtR+BPIsxH+hd0IqZKsz+JCxHO9Q/22qNA1CtMuB/3R3b+RvhVVTNsOYzWUzhNGKJrSuvL2eUfJ9cblLIajVlxG2czab2FJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735216; c=relaxed/simple;
	bh=P3x+z48/x0vSeNEXx5DbdHMPelKBu/qC695KfqSG/Ug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WmUq2iDmsQ/ErEK2R2MuMaUNggPHaatdbBIl8zEUdpgrillnLBAT1hUeBvqUcWO0yDUeU/wvWFGraNCBtGBI4Sk0ZpdyBp9ZN2fizI8lBfMx8HHP79aOAbcrrmGtJ6jDZmmx8HzdZH4MaOLWoWexxyXyXsDXH0drU0H63LViMsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GHvlrKxB; arc=fail smtp.client-ip=40.107.105.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GHvlrKxB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDkb4Me2qweQyrmwtBBCn+dbiXsjYfSl1lZfoJgZCz9cGD1JvwVqJbsQ7gw8b/Ow5sZ1Zqry8S/wUxITVp+8c9E2Rw/1A7Vb1x4DzhUov9izULWhVIYMEJsaEn5kdGRD1ojw4kKpQ0g87WgyZLmGAqfNsWDraR7j4pHCLNRpMMQhVk08VJIk8ZRRLqmg5Ka0Ww3ru1htf1pmU0JkR2bb8xPi3LjAFLjGdyH2w+i/jduIlo7+K30FuK98SHmrcqIj9Bjn969YQQPat4Ze5Cx8sdGtDJHMbOh0YL5+GtyAyVbEC/AgC/qfPGyZ3RAoOfXHKecZ4LS3ecltKGj1UPXLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51araOFKiHbxuN2J7fcMjpfsfr7blQxTa1Qxh1AeC2s=;
 b=Fj5EAUcl7af2g1fsIqx1bq/M1zrFJ5kDoZSF7fxJBUAFKrVhGutwYadeEOZp4nXltxQ5YhF7QJpsVOF7Wf3w2U1V3sZTQ48UeSnDE4ER3aOPpBLq9JuLspMW7II11ax3T5cBMK1/2JTcrg+4Tp4WS0HP91zqKucnozzkbInT5M3b/Xhpb8b/ixvbfSIcgxTxVTjKRYjPm2dSWDwE872HOmKOwAyXf0zuNhuFpH2b/lzQ9j3h8nQBpbFoPSxH8vbuXs6avD3IUTZ20UlA1BLjLvPEaXrk3dxjPrvpk8UfLYcWIzrWUUkM3Y5/W5vTVcCvRoQsYQ9eoGRPmKIrnF7zQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51araOFKiHbxuN2J7fcMjpfsfr7blQxTa1Qxh1AeC2s=;
 b=GHvlrKxB1vuVYbPtM/n0aVNsJ6/hPbBb6hkXwIr17E9eG97AC3vjT9NqfQjzMqp7iX46Oo1YG+/7/kVs4g7ZzMCC6Ddj7Wc+6Xq+PaTdUNLbWU8NX6f+az7OksAwVe0kshrMxaMMX681TWPgaSELdKZZJvuxzl3gC0bSqz+QyNz3BGRjUxmKmQ6ORS6nqez8UhQbOJfTaho2N01Vhz7LiBSrbAqH9niuZWHCZiZ/Cbn3E7DZj62nHJ/6Qehli0q//xpvjfiirAXB4y34rE4s6bi40a5cbdCdrOdVbXDmtdB0Z3/9omYa0y4l81UH+2H26D+9lP8CbuxLPyQ/grcA7g==
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:672::17)
 by DB4PR10MB6312.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:380::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Wed, 10 Apr
 2024 07:46:48 +0000
Received: from AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f01a:deee:b867:7f2d]) by AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f01a:deee:b867:7f2d%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 07:46:48 +0000
From: "Kowalsky, Clara" <clara.kowalsky@siemens.com>
To: JerryJun <jerryjun123@163.com>, "Kiszka, Jan" <jan.kiszka@siemens.com>
CC: xenomai <xenomai@lists.linux.dev>
Subject: Re: Re:Re: NX-protected page
Thread-Topic: Re:Re: NX-protected page
Thread-Index: AQHaVbMqr2YGR1BdwUu2FOZ8ltzyO7Ec1liAgESxigA=
Date: Wed, 10 Apr 2024 07:46:48 +0000
Message-ID:
 <AS5PR10MB817389FE4D3AE120BC80E6D393062@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
References: <3ce13f2b.183be.18d2f264758.Coremail.jerryjun123@163.com>
 <87ca0f83-bb2f-49fd-8e30-8873778cd8a9@web.de>
 <6bec8d20.61c9.18d5e68d09d.Coremail.jerryjun123@163.com>
 <e1accac9-4044-4379-8d4f-f0eb7cd9d713@siemens.com>
 <fd2a3821-c4e6-4866-bc65-0bbadaf603e5@siemens.com>
 <799babe6.660d.18d68cb571a.Coremail.jerryjun123@163.com>
 <c79218e4-cc6d-4f34-93b3-e1405978476a@siemens.com>
 <40cc100b.12313.18de5d67bf5.Coremail.jerryjun123@163.com>
In-Reply-To: <40cc100b.12313.18de5d67bf5.Coremail.jerryjun123@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=True;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-04-10T07:46:48.193Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=C1
 -
 Restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR10MB8173:EE_|DB4PR10MB6312:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Fgu1CqqIR/S8jaWAx+gT/zCrUD/x8jPs2+/OsOVvGZabMCge+uDh+3GkLsoNJu6VNQBhvnlDHGjUe3t+Rp1NUnS3p33+PJ0WTUdceeMufndpVNFqbK/ZBIN2j61dbPSP/xPV568g1T0NBcvP9SOPFoLQdchVPXjLipKu+kCc1GPVivPueWqE8QBTYWZ/3htPrIrMttTKsrhT8LVR5PsTC5nPv0SzOXa384jvWOKL+vqwZbBHYKYdc6UitlvPe/BmnxqtAug7SaiN8NvCR/oClY+ppemOBqiSLxIumgBFY7TkqbJ4WAKXkTTel1F1VmfhGNpPDTGHJ9ba9CZ3kaqgnebTF3J/NVHYDHL9KKHmxU7054zEBwwZf3vhJuvjUaGpmHMtCgacABVJTGJUGs0+mhcmWxFMgT/a6bpmWbjHzxL9bk4+sTvpfRZPUJzUpzhs3mqfz2TsqCZao7TO+3Wr2U88kDBRe9aJIh8ELx5R/qmVtT2EWxkzZgL7Ro7AzyiMNXzDX9OvjgLPD+IxuyeuJJFfY2kHk1ufWh/Pviuzqa/9PDs+Lwkd6ujCXVL/odZPOhjXAq+ZGJevVORqlPgVu4Y2JyNn98HATI5gAmDuM81Ov3wK6eF1deBWR3gKBMJlsiXx02AgySUhIEKBvW3TIyeoK/yyerRBmiuHgZZ2IdI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?b1BJeHpBRUl1WENiOVFoZ0RoTnlxQ1Juc1dTK2NKUXFJUGs3R3Q2cnk1?=
 =?iso-2022-jp?B?TnRadTJwc3RrQjBpZUtHRm0yTnQwZ2tXNVFleVV1RjZGQTZJTFFQMURr?=
 =?iso-2022-jp?B?RlY5dmJ2eUZEL25QcUlTM2JrWXBUUWtWalU5M3pDa2RWUVF1aDVDSmJZ?=
 =?iso-2022-jp?B?c2ZFSko2aGZlVjNiQk9nNWFSYU1MVmpxM042S3ExRlVWTXlZQ3hlVEgr?=
 =?iso-2022-jp?B?b1pNeHpoc3Brb1QxamtjbE1FK1EwY2I3eHlVMkZRcVVzMkhDb3pWbG1a?=
 =?iso-2022-jp?B?KzBUcXB1bzEyZWI3K0dPaWJOQmpWUWtWOGg0b29HaE9PamNDNENVQXkx?=
 =?iso-2022-jp?B?Z3BoVTk5SkZtT1ZaN2xUcmkwdDAvU004NWV4U3VzeExxKzdkbFU3Smxo?=
 =?iso-2022-jp?B?MUJFU1J2bTRUa2FKV0dPekRDYkZxdFNPeS9WRitROFR4eWtldGxtZWtY?=
 =?iso-2022-jp?B?OG5mK0NKcStqeXBOYUVMS2VGSmd1dlMvOVJRTFhLNXFrb2pHdGc4WTJP?=
 =?iso-2022-jp?B?eTI5bG92cm4wbjBadTJxMDZjemxINy9CY3ZtaktXZE1SY2JCVjZFWUxt?=
 =?iso-2022-jp?B?QmFlbjlaWlRmb2pHb1JnM0c3aGUyOEFSbHo3TE9iemZPTVltRWRVd0pP?=
 =?iso-2022-jp?B?UEU3cVpxVWQ0a2N6eC9MWEMvUkk2YkgxaFZCV2ZNT2M3WGp3dm0zSDdL?=
 =?iso-2022-jp?B?TDBRZEd6SDVGZFVpZFFDUEZ5SDVZYkZpNk1iZm16eUVKelhPWkh1WTBR?=
 =?iso-2022-jp?B?OS95M2lCb3kwMEFqUUZVQ0l0TDFKd0l5SktiU0lURkt0eHUrWTVpdXFP?=
 =?iso-2022-jp?B?QnQ3WkFTUGV4b1hWQlZqNmtuNDluYStzbENKVWdQRTVmdTJGdEx4MEhk?=
 =?iso-2022-jp?B?bVBqM0Q1cUkxVzhBdW16bEJtQ05TaTlPVURyVmVEKzJLUDgwSklUbW81?=
 =?iso-2022-jp?B?QlJmYUlTMkVnc2ZNNDNPYk04bytUSW9aaEhhOXc3K0xIMUIvVDVOYXFv?=
 =?iso-2022-jp?B?dThrbEhsM2pxQkxUYlcxSHMveTlTK0k1MGt6SysyYzNCbFZUdmhIdkdu?=
 =?iso-2022-jp?B?bmN6OUtGV09aR2Q3VGYyamszbWJxRVlmYmtrY0U0ODVVampSbWRZUFdx?=
 =?iso-2022-jp?B?K1ZkMmk2dDBtbUh5NFBjcnJ6QW95WWsvb3hHUlhZQTg3SHR4VHluRith?=
 =?iso-2022-jp?B?TG1Ud2Y5QXY1bkl4ZGZHWHNjaTVWV2lla1A0OFkzdUh6YWRsMG1EeE9O?=
 =?iso-2022-jp?B?TVIzS2VnNXp3Ymp0cEV1VW5kUjV1TVk4a250ZCt3TXpCemI0R21hbkYx?=
 =?iso-2022-jp?B?S05HMW9mZVd3c3hBOU1wMVplS29hWVVVRXVxZTdUSGZhWVZlWm1mQlU2?=
 =?iso-2022-jp?B?OWRNa0lhUVF1c0tMSVAwTi9ObElXd3hEM0tsbUxIeHQ2a0E0TWNDNnRp?=
 =?iso-2022-jp?B?L3BzVzdUMjdtZGJyS3dTSlB0N1pNbVFEVU5abExDU2sxOFE4dS93ZXlI?=
 =?iso-2022-jp?B?U21EZFBnN0xEeGowbXZPY2RsKzJycGF5ckg1SUgwZkVTcEsyZlIwWm5r?=
 =?iso-2022-jp?B?YmxWMDVnUWYyZlh5SFAyUEhJelRhZkk3MC9ERmM2TnZQWEJNQnQwY0NH?=
 =?iso-2022-jp?B?REVrdVpkSFBBYVFmWXkxc1pHSHpWc1RxSmN4UDlCblhOMU9CSy9aSDVa?=
 =?iso-2022-jp?B?RmVmSUFBajcxK0hTMzhOVjQyRm0wa2lnd1I4dVpLRWthYUZiblJaK1dL?=
 =?iso-2022-jp?B?RkNKQUluRk1sM2dkak0wSXNsN2UyV1M3MWFmN1YvTmlDd3lXREVid0xp?=
 =?iso-2022-jp?B?RkZhelRKdnRjN05Xb2wyM3FSa2puMkZxY1grUUI2UVYxWUZjWXoxMnBi?=
 =?iso-2022-jp?B?UXhIOVdFa1BxbHNwTGxyclVRcmZUMFh6QVUzSHRydXpwcFlvUU5tMjd1?=
 =?iso-2022-jp?B?WTN1aEV2TmZ6dDk3dVpmOEk3bFFxVGZyeWhlUjhpa3N4UE1FTmM5dHdC?=
 =?iso-2022-jp?B?UWZUNExESEMyZ2NlVjh0b3gwemJhNG11RlF5OStHL3JRVERkQjhRa0o5?=
 =?iso-2022-jp?B?eTlwd25SMnQwanN6b1dubWFIRGFGc1NxdnlqWTQzWi9jaHFtK2NZMG5K?=
 =?iso-2022-jp?B?UDZqTkRraHNIaTZrdTlIZlZZMHdGbWF6RVFiZlhoM2crbDFnSUk5dXZM?=
 =?iso-2022-jp?B?UStMaVQ5YWNXUVFuRDB1Y1JFWC8yVW0vUXlXR2pwNVJVNVhrUXg0Z0E3?=
 =?iso-2022-jp?B?Z2NTWWFnN2xFUGtad29BQ1RqbmRoaVEwVFVmRHRuRWNweXNqcTVFV3V5?=
 =?iso-2022-jp?B?QmdQOGRXU2Yzd3htYVdGL09CSjBWbktpemc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b0009101-aaab-448c-b358-08dc593260b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 07:46:48.4962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gzjZFaZEfp8gc8I3PrJv84J6tJupp39mlx+0UhIo/Ny93KdczxNgFqNbNhwIdFaQuYz1+MdJbBhYZJdBFCrBohnslP67geYIScPgpAmvFo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6312

Hi,=0A=
=0A=
just so you know, we're looking at this issue.=0A=
Which cmdline did you use? Was xenomai.supported_cpus set?=0A=
In the meantime, if you have more information or if you have been able to c=
reate a simplified application where the bug still occurs, please let us kn=
ow.=0A=
=0A=
Best=0A=
Clara=0A=
=0A=
> -----Original Message-----=0A=
> From: JerryJun <jerryjun123@163.com>=0A=
> Sent: Montag, 26. Februar 2024 15:34=0A=
> To: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>=0A=
> Cc: xenomai <xenomai@lists.linux.dev>=0A=
> Subject: Re:Re: NX-protected page=0A=
> =0A=
> hi, Jan,  if  you have reproducted it  after trying to run the case for h=
ours in=0A=
> qemu=1B$B!)=1B(B or is there any doubt=1B$B!)=1B(B=0A=
> =0A=
> 2024-02-02 16:37:59, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:=0A=
> >On 02.02.24 08:49, JerryJun wrote:=0A=
> >>=0A=
> >> how long did you run it=1B$B!)=1B(Bit will take a while for this crash=
 but not more than=0A=
> 12 hours at mostly.=0A=
> >> ok=1B$B!$=1B(Bi will try to run it without get /proc=1B$B!D!D=1B(B tha=
nk you very much.=0A=
> >>=0A=
> >=0A=
> >Not for hours, but one setup was running for about 30 min. at least.=0A=
> >=0A=
> >Jan=0A=
> >=0A=
> >>=0A=
> >> At 2024-02-02 14:49:53, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:=
=0A=
> >>> On 01.02.24 08:09, Jan Kiszka wrote:=0A=
> >>>> On 31.01.24 08:25, JerryJun wrote:=0A=
> >>>>> yet=1B$B!$=1B(B you just do make in the project to product the bina=
ry of oop-test,=0A=
> run kill_test.sh , and finally wait kernel oop .=0A=
> >>>>> we get the same results of kernel oop in the qemu-amd64, which use=
=0A=
> the config from xenomai-images=0A=
> ,"https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsou=
=0A=
> rce.denx.de%2FXenomai%2Fxenomai-images%2F-=0A=
> %2Fblob%2Fmaster%2Frecipes-=0A=
> kernel%2Flinux%2Ffiles%2Famd64_defconfig%3Fref_type%3Dheads&data=3D0=0A=
> 5%7C02%7Cclara.kowalsky%40siemens.com%7C494bca636f6c48566cc208d=0A=
> c36d843eb%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6384=0A=
> 45549672638180%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD=0A=
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&s=0A=
> data=3DxOckYYYOkjKZ3yKchy4B7kkX2eth%2Bqe88Mrd7XjldFw%3D&reserved=3D=0A=
> 0", as follow.=0A=
> >>>>> [ 6191.671953] BUG: kernel NULL pointer dereference, address:=0A=
> >>>>> 0000000000000000 [ 6191.671955] #PF: supervisor instruction fetch=
=0A=
> >>>>> in kernel mode [ 6191.671956] #PF: error_code(0x0010) -=0A=
> >>>>> not-present page [ 6191.671956] PGD 0 P4D 0 [ 6191.671958] Oops:=0A=
> >>>>> 0010 [#1] PREEMPT SMP PTI IRQ_PIPELINE [ 6191.671959] CPU: 3 PID:=
=0A=
> >>>>> 7047 Comm: oop-test Kdump: loaded Not tainted=0A=
> >>>>> 5.10.199-devo-3.2.4-20240130 #1 [ 6191.671960] Hardware name:=0A=
> QEMU=0A=
> >>>>> Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014 [=0A=
> >>>>> 6191.671961] IRQ stage: Linux [ 6191.671961] RIP: 0010:0x0 [=0A=
> >>>>> 6191.671962] Code: Unable to access opcode bytes at RIP=0A=
> 0xffffffffffffffd6.=0A=
> >>>>> [ 6191.671962] RSP: 0018:ffffc90000118f80 EFLAGS: 00010246 [=0A=
> >>>>> 6191.671963] RAX: 0000000000000000 RBX: ffff888108d3d730 RCX:=0A=
> >>>>> 0000000000000000 [ 6191.671964] RDX: ffff888108d3d738 RSI:=0A=
> >>>>> ffffffff82516284 RDI: ffff888108d3d730 [ 6191.671965] RBP:=0A=
> >>>>> 0000000000000000 R08: 0000000000000000 R09:=0A=
> 0000000000000001 [=0A=
> >>>>> 6191.671965] R10: 0000000000000000 R11: 0000000000000001=0A=
> R12:=0A=
> >>>>> 0000000000000000 [ 6191.671966] R13: 0000000000000018 R14:=0A=
> >>>>> ffffffff811d37e0 R15: 0000000000000000 [ 6191.671967] FS:=0A=
> >>>>> 00007fc6e83ea780(0000) GS:ffff88813bd80000(0000)=0A=
> >>>>> knlGS:0000000000000000 [ 6191.671967] CS:  0010 DS: 0000 ES:=0A=
> 0000 CR0: 0000000080050033 [ 6191.671968] CR2: ffffffffffffffd6 CR3:=0A=
> 0000000106750005 CR4: 0000000000170ee0 [ 6191.671968] Call Trace:=0A=
> >>>>> [ 6191.671968]  <IRQ>=0A=
> >>>>> [ 6191.671969]  ? show_trace_log_lvl+0x1c2/0x2c9 [ 6191.671969]  ?=
=0A=
> >>>>> irq_work_single+0x42/0x80 [ 6191.671969]  ?=0A=
> >>>>> __die_body.cold+0x8/0xd [ 6191.671970]  ? no_context+0x13a/0x270=0A=
> [=0A=
> >>>>> 6191.671970]  ? exc_page_fault+0x6f/0x200 [ 6191.671970]  ?=0A=
> >>>>> asm_exc_page_fault+0x1e/0x30 [ 6191.671970]  ?=0A=
> >>>>> handle_oob_irq+0x90/0x90 [=0A=
> 6191.671971]  irq_work_single+0x42/0x80=0A=
> >>>>> [ 6191.671971]  irq_work_run_list+0x2d/0x40 [ 6191.671971]=0A=
> >>>>> irq_work_run+0x26/0x40 [ 6191.671972]=0A=
> >>>>> inband_work_interrupt+0xa/0x20 [ 6191.671972]=0A=
> >>>>> handle_synthetic_irq+0xb1/0x210 [ 6191.671972]=0A=
> >>>>> asm_call_irq_on_stack+0x12/0x20 [ 6191.671973]  </IRQ> [=0A=
> >>>>> 6191.671973]  arch_do_IRQ_pipelined+0x15d/0x2a0 [ 6191.671973]=0A=
> >>>>> sync_current_irq_stage+0x157/0x1f0=0A=
> >>>>> [ 6191.671974]  __inband_irq_enable+0x4b/0x70 [ 6191.671974]=0A=
> >>>>> _raw_spin_unlock_irqrestore+0x35/0x70=0A=
> >>>>> [ 6191.671974]  __set_cpus_allowed_ptr+0xbf/0x230 [=0A=
> 6191.671975]=0A=
> >>>>> sched_setaffinity+0x383/0x6b0 [ 6191.671975]=0A=
> >>>>> __x64_sys_sched_setaffinity+0x45/0x80=0A=
> >>>>> [ 6191.671975]  do_syscall_64+0x39/0x50 [ 6191.671978]=0A=
> >>>>> entry_SYSCALL_64_after_hwframe+0x62/0xc7=0A=
> >>>>> [ 6191.671979] RIP: 0033:0x7fc6e84d6617 [ 6191.671979] Code: 1f=0A=
> 40=0A=
> >>>>> 00 48 8b 15 79 c8 0e 00 f7 d8 41 b9 ff ff ff ff 64 89 02 44 89 c8=
=0A=
> >>>>> c3 66 2e 0f 1f 84 00 00 00 00 00 b8 cb 00 00 00 0f 05 <48> 3d 00=0A=
> >>>>> f0 ff ff 77 29 41 89 c0 83 f8 ff 74 18 64 c7 04 25 38 00 [=0A=
> >>>>> 6191.671980] RSP: 002b:00007ffd574dfde8 EFLAGS: 00000206=0A=
> ORIG_RAX:=0A=
> >>>>> 00000000000000cb [ 6191.671981] RAX: ffffffffffffffda RBX:=0A=
> >>>>> 00007fc6e7b985c8 RCX: 00007fc6e84d6617 [ 6191.671982] RDX:=0A=
> >>>>> 00007fc6e7b985f0 RSI: 0000000000000080 RDI:=0A=
> 0000000000001b8d [=0A=
> >>>>> 6191.671982] RBP: 00007ffd574dfe70 R08: 00007fc6e83ea780 R09:=0A=
> 00000000ffffffff [ 6191.671983] R10: fffffffffffffdca R11:=0A=
> 0000000000000206 R12: 000055a818eb61c0 [ 6191.671983] R13:=0A=
> 0000000000000000 R14: 0000000000000000 R15: 0000000000000000 [=0A=
> 6191.671984] Modules linked in:=0A=
> >>>>> [ 6191.671985] CR2: 0000000000000000=0A=
> >>>>>=0A=
> >>>>=0A=
> >>>> Okay... that is "good" news - looking for some time slot to=0A=
> >>>> reproduce and debug myself now.=0A=
> >>>>=0A=
> >>>=0A=
> >>> I've tried to reproduce, using the .config.yaml below for=0A=
> >>> xenomai-images, but it does not trigger here. Do I need to run this=
=0A=
> >>> for hours? What exactly did you do to trigger it in the qemu image=0A=
> >>> of xenomai-images?=0A=
> >>>=0A=
> >>> BTW, I assume the access of /proc/xenomai/sched/stat plays an=0A=
> >>> important role in causing the crash, right? You don't get it without =
them?=0A=
> >>>=0A=
> >>> Jan=0A=
> >>>=0A=
> >>> #=0A=
> >>> # Automatically generated by kas 4.2 #=0A=
> >>> _source_dir: /repo=0A=
> >>> build_system: isar=0A=
> >>> header:=0A=
> >>>  includes:=0A=
> >>>  - kas.yml=0A=
> >>>  - board-qemu-amd64.yml=0A=
> >>>  - opt-linux-latest-5.10.yml=0A=
> >>>  version: 16=0A=
> >>> menu_configuration:=0A=
> >>>  DEBUG: false=0A=
> >>>  KERNEL_4_19: false=0A=
> >>>  KERNEL_4_19_LATEST: false=0A=
> >>>  KERNEL_5_10: false=0A=
> >>>  KERNEL_5_10_LATEST: true=0A=
> >>>  KERNEL_5_15: false=0A=
> >>>  KERNEL_5_15_LATEST: false=0A=
> >>>  KERNEL_5_4: false=0A=
> >>>  KERNEL_5_4_LATEST: false=0A=
> >>>  KERNEL_6_1: false=0A=
> >>>  KERNEL_6_1_LATEST: false=0A=
> >>>  TARGET_BBB: false=0A=
> >>>  TARGET_HIKEY: false=0A=
> >>>  TARGET_QEMU_AMD64: true=0A=
> >>>  TARGET_QEMU_ARM: false=0A=
> >>>  TARGET_QEMU_ARM64: false=0A=
> >>>  TARGET_X86_64_EFI: false=0A=
> >>>  XENOMAI3: true=0A=
> >>>  XENOMAI4: false=0A=
> >>>  XENOMAI_3_0_LATEST: false=0A=
> >>>  XENOMAI_3_1_LATEST: false=0A=
> >>>  XENOMAI_3_2: true=0A=
> >>>  XENOMAI_3_2_LATEST: false=0A=
> >>>  XENOMAI_LATEST: false=0A=
> >>>=0A=
> >>> --=0A=
> >>> Siemens AG, Technology=0A=
> >>> Linux Expert Center=0A=
> >=0A=
> >--=0A=
> >Siemens AG, Technology=0A=
> >Linux Expert Center=0A=

Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEEE10E7
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 16:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEero6klu/LhPP82lBHs2Ia5AeBm1DvHUnHMWbi4HQD/1aoqJ2v01pWncZ9vwVBwQ8KboeJ+MJGFycrPBUTFPhwlmpMZYu8xNmLIan2l7wu4XAwSjqeKLDL6NFUZhVfqrtWQvVlFFYLGx8eDcq/mmEqVVDsWrQmi03dxCFJytedIj0hFWzOvpooSRUz+gcIOGojJSWrvAAp4/2RZJ11dnBybkA07G1v7YQtZZakNMwxew9+8jN7+NI7+awQoHnXdemNjxP/omAzx76nvsK3j5r2Qn82F2beGheVrWP9nmxTEowxoLd4IHdBhY/usXNiN5njd04pLJXXcPHrs904kmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEIe7cwFJuHKUXYM+vNAFUbRWRgfk+BdxIc253btZx4=;
 b=Bpq8QjoSb0DPtUyZpSKRo4yz95iEJzqx5aLUHJRm/jZfoX3oLQ8Ff6xqzeUrW59WhGlpgvcB/+yxW8c3Z2l73n3fboWfsCz/Yb1Lky+9PV7eX117YysMJqcNvRRrKu8/S22T3MvVl03UdYJvjexFZlcn6VpfNk5NO0jvM9akY8rnR0lOO1kKnW/d3YCrGVBb92eg+HG6eTb4thbnHx3f90w1+k/Kx37PqymImvihpZHeaoI40ozEgT4EAp0wUGpTnpAkZ12A8A2h+H1Pz3/8H83HdwsH0LOil5fumZ3Cbaj00Haq0fNfF1CxiOYqu8uaMHTMSr+ePE+V1/VK70WtbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mts.com; dmarc=pass action=none header.from=mts.com; dkim=pass
 header.d=mts.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mts.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEIe7cwFJuHKUXYM+vNAFUbRWRgfk+BdxIc253btZx4=;
 b=DBVCpRW8SAp0dE4vcU+2KJ6IQYJGXQ+7SNiZLto/VIIX0rg1Nej6kPlAwTB3N74Mdr6MT5y2jXXqq+Lq0Psh4kHmxSlmfedCSnkiXzTXQDGTgM7i2F86uuAC4CNR3SwHcCTo+tKaVuwrsW417IaPVvYKqIOLed+mRndnMLzOHwZBbOCB+8d5nMXJr/E3DqrENp/LuSW1g7FNFj5enjEct9njR/xKuJ0kEzE85sd4Bx+stIQ7pKN16OrrwjN27Ul/xa8rfryq2P/8Np48kzQZPZwAyNidh456wUQfrQyIIFNqGhR7Pi/MhfhDXnCNhFgenMHZDAF9pN1S6Inb7WdCQQ==
Received: from DM6PR04MB6122.namprd04.prod.outlook.com (2603:10b6:5:131::10)
 by BN8PR04MB5860.namprd04.prod.outlook.com (2603:10b6:408:a4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 16:32:47 +0000
Received: from DM6PR04MB6122.namprd04.prod.outlook.com
 ([fe80::8904:a76e:c018:40c2]) by DM6PR04MB6122.namprd04.prod.outlook.com
 ([fe80::8904:a76e:c018:40c2%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 16:32:47 +0000
From: "Rosenow, James" <jim.rosenow@mts.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: "Ganz, Derek" <derek.ganz@mts.com>
Subject: RE: Inconsistency between documentation and code in
 lib/alchemy/task.c
Thread-Topic: Inconsistency between documentation and code in
 lib/alchemy/task.c
Thread-Index: AdlG2mfbdsDbSVZzT0Cs0QiEzEPn8AAAEybQAAAUgVA=
Date: Wed, 22 Feb 2023 16:32:47 +0000
Message-ID:
 <DM6PR04MB612217B2DBE5BF6E4961612DE2AA9@DM6PR04MB6122.namprd04.prod.outlook.com>
References:
 <DM6PR04MB61228B4C5910471EEEE02ABFE2AA9@DM6PR04MB6122.namprd04.prod.outlook.com>
 <DM6PR04MB6122B1C2A8750460027C8852E2AA9@DM6PR04MB6122.namprd04.prod.outlook.com>
In-Reply-To:
 <DM6PR04MB6122B1C2A8750460027C8852E2AA9@DM6PR04MB6122.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mts.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6122:EE_|BN8PR04MB5860:EE_
x-ms-office365-filtering-correlation-id: cf7ac6d9-7028-4faa-d86c-08db14f26e7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OQZb3cf/ifAQQdyTucDsVcrc3ZnINv66qMopraVZKTiZ/H1ZFmO98nrBPLGvF1Y0FKEQ8Y2SI/Gqyf3ZJA3euS3+Hh3RQxPd7ij02Mr7lcccsFMWcyfQxZOy8O5xbmAGpsfxKb8BOVO3h/uNRbvF2fLKi6RXrTyNTS0U8o9VF9Drtb3CwA+RmFzmr9lsZJ/oU54otm38N9jabRY80Pdknyyn840C7Hu+UgCIpbg5k8tpX7DxUDupIogJ0+cc/i8RtdH4G9llMaF0JY6mfrpoh6oQiRf6XZopguVVb2fofmVqFiGP6vSXAIdqdjJM757uknSYUwWHgV30vnf6rh+jrOWH+BaKV5w0CV5r/XBjvoQWP+YlcJ6Q4VY2JSmsIO+Ivcw2/T3HZ9GWuNiQSzkF7qjaRr1UAk6kMPTPvmyH22/9w2BUqhIwaMimP5mzf4RrCcdORgUB+AnoFzAkx0ttTnYYRuiw4SqPt/oHTleRlefIlzJosAHfYUnSIZzDB/1kDhc764hxFqsGKXTseYVBIf3F2/Nj5iqfne6aqaeUVsE1Ns/IfrDAc2JMSIxPJqJq8vQOFsLbJINO8JjuPCEny0ixDPOrdgBeUieZQRXRjxfoG8mSN2wVBjSV6/+HU1OCu7ytscL7EgMJ5nF1E7nLak1FvDNDRRqMrj09gBOdF+h0EmrrxSmnXEDoLehsCBLJaVSeKeKrOx70Dj0grlds3Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6122.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199018)(33656002)(86362001)(38100700002)(38070700005)(55016003)(122000001)(26005)(6506007)(186003)(2940100002)(9686003)(478600001)(7696005)(8936002)(5660300002)(316002)(71200400001)(4326008)(52536014)(64756008)(8676002)(41300700001)(6916009)(2906002)(76116006)(66946007)(66446008)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KtrLQ/EfScg/Iy0kEqjPcN4IwxIo8nXFgDiy3Xiu4R1p4fFbLtF/s6iVth?=
 =?iso-8859-1?Q?iKmJT5Ku8ybO5dbTUWSj2TdPS7UjRo6XDHJ3ruJRXEgie0ao1EGUcDeZaX?=
 =?iso-8859-1?Q?eoNxy5TCVifyskmbMxj/yo87CnuEXPaXk+okI/A22fcSEu3ZlU8K5afnno?=
 =?iso-8859-1?Q?j9QHfg8/vMM+W2m2e6MZoHTlZDbKvxjt4JV03B4YIO3USUA+t+u27r8Kpc?=
 =?iso-8859-1?Q?qFFXJlYKgyEGVuo030ntPop3g7/xAjuuqGF4OVnB8OMHL8mlCtDkucfjR5?=
 =?iso-8859-1?Q?O2qOcAKVvTEmRRaHEEuz0JjW0Z9Tdt7I7tafBIeWjk4pYEy7QZoO1wkqne?=
 =?iso-8859-1?Q?s55L2QJlOE0QYHkssCYwCd5pcDApfwAgyz9vwqCVYS2TE8gOENMOxerdu1?=
 =?iso-8859-1?Q?ndqwew7SYrBzSG+sZb1XK5J9+96Yzgzr4Y9ptgEGBfDmBkCtJ7CulshOpC?=
 =?iso-8859-1?Q?Pgya8BXr+Wao6DMgq2cJuoI+Rr1Ngkp/WvatUmG0JabX5bo7vnKu2C7gaB?=
 =?iso-8859-1?Q?9KnRAXm2YNcEr6VUXW9lyJN2xTmv7gPakgdTUI1bjJeQBvCtP9xVJoUHQ9?=
 =?iso-8859-1?Q?tneKaLm9XL2Mu7Hud9bwnUujpQja8bag4f3rTsxIL8I1FVlg8yARMiNft2?=
 =?iso-8859-1?Q?m9JO1qyzIVfN24ozSiAEMZvI6cXPDSObI5oy9aHL+801XogLmzz3xym9xe?=
 =?iso-8859-1?Q?5yNp05MRDHJpZJO8zVUEM8HXpxiB/L5jzXoy7wbLRzAvtehtRSupCLLaQc?=
 =?iso-8859-1?Q?IL+skZy3plAdLLw02ZfweHkLPxI99vOd77bpNeBbd+8duYrfXZ5RupNGc0?=
 =?iso-8859-1?Q?x7bQyC8W9tlkmDFUPNXyoGrk7HzJTgub6EUYa9qx+wOm5R8WJyBhLaYIC1?=
 =?iso-8859-1?Q?KcPHcbp/PP/+ECcHGExBxdx7ehtyMdJh2zKxhq+32L3SyK8gDfrwaO9XOR?=
 =?iso-8859-1?Q?OQ9YBynRblDsZE41vOcCJCZSvvX7D/P6GqCxqJAw/bx1bXU8y+Ftp3JiMn?=
 =?iso-8859-1?Q?3IHQ6aO37VZPzElgv5itlw/NFuXW9+vSGD7v5418wtdV7cmhcXsw5XliOi?=
 =?iso-8859-1?Q?2iILvdqoZSmwp4ZRZPvNL6SWhdrg43ioMxkqFGik17lrJdDcoQE7O/aZCa?=
 =?iso-8859-1?Q?bDId1W99pNfdCP+dYK1YySm5M7QWs2Q4pf4T2Bvn1QMB5N/3+HGXLRTsLQ?=
 =?iso-8859-1?Q?PdLRQ04Sqw719zIQLikNT49BYm2m4TaLXPvbrnK0Sk4jFhrfZYd/wjxcjF?=
 =?iso-8859-1?Q?vPR4FAyHN/JuhAHeUfrFJIm0xTljmAMzViTev9ILBujUs2eQwliM8SaBcY?=
 =?iso-8859-1?Q?WfS44ZRadfBjzOEEl6PT0bnbzGza0Z9yCTUnURSUpUys7rTRjRF+MuuLnH?=
 =?iso-8859-1?Q?TZUvwc4mGs+VBMubuFIiif6HijihTXJ9Uc8242y735AJ0x/TUmd3mJzMhy?=
 =?iso-8859-1?Q?jwO/oKHZrnPGtJqAoxdTZ8hg+EdPxAanrb98R86GK9dnYDKjhf0CtolI89?=
 =?iso-8859-1?Q?lG8nGU+iN9L0G5S2cdv5b9I4exQZ/X4pXaV0s5IvCzbn/5CVJ3A+GuAkCW?=
 =?iso-8859-1?Q?OP2rMaP1IBbjnO+UlJGblAR849bPxj7h2Qas/oC6/OMKbbmX/EXPZj8T6k?=
 =?iso-8859-1?Q?BzmOKEeu9OivT9j3So6oxXG+hZRVKqLM2V?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: mts.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6122.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7ac6d9-7028-4faa-d86c-08db14f26e7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 16:32:47.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7fa3ed9f-fff9-4884-a6e2-8dd98886b775
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgdqlYwyYHuJNjCTdoV/MQ6p49vAPuEN/pWeYoblbmaxuDRCx4a9KkCHYG2oMc/jU9qwAe/4UXbgCYq3l5Cq1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5860

Greetings,

We are experiencing a crash in rt_task_inquire() and found an apparent inco=
nsistency between the doc and the code.=A0 Our code is passing a NULL 'info=
' pointer and subsequently crashing.=A0 See code snipped below.

Best regards,
Jim Rosenow
MTS Systems Corporation

/**
* @fn int rt_task_inquire(RT_TASK *task, RT_TASK_INFO *info)
* @brief Retrieve information about a real-time task.
*

<<<<<<< snip >>>>>>>>

* @param info=A0 The address of a structure the task information will be

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Passing NULL is supposed to b=
e valid but
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 below it is not checked befor=
e use.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \/
* written to. Passing NULL is valid, in which case the system is only
* probed for existence of the specified task.
*

<<<<<<< snip >>>>>>>>

*/
int rt_task_inquire(RT_TASK *task, RT_TASK_INFO *info)
{
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct alchemy_ta=
sk *tcb;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct service sv=
c;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret =3D 0;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CANCEL_DEFER(svc)=
;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tcb =3D get_alche=
my_task_or_self(task, &ret);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (tcb =3D=3D NU=
LL)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 'info' is not checked
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 for NULL before
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 dereference.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=
/
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D __bt(thre=
adobj_stat(&tcb->thobj, &info->stat));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out;

<<<<<<< snip >>>>>>>>



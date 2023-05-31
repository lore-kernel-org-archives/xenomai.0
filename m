Received: from mx0a-001f5801.pphosted.com (mx0b-001f5801.pphosted.com [148.163.159.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3C16438
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 15:27:28 +0000 (UTC)
Received: from pps.filterd (m0090335.ppops.net [127.0.0.1])
	by mx0b-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VFRRkq010863;
	Wed, 31 May 2023 08:27:27 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0184.outbound.protection.office365.us [23.103.199.184])
	by mx0b-001f5801.pphosted.com (PPS) with ESMTPS id 3quh1a575q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 May 2023 08:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=dI1oBS85C2UM0R1GmlRUrbhUaV+jyExgV7MxD6y/+RHzM3nwMlWnRc8n4EL7vFCccDBoTGSU4UQoRilJ07/LUBHPi5PXir3SgILUvN+gpYXvNAbUohPm9gvhCgovyEodJsoIRcdH6BGcz1bCwNDFZCM66nq4JAWA/5srzhMdpj4WBqYTXkcVtNFVspk5br58vbnczOR06wUSqsDVzuTQDO2bS2nXfg7e1x1q3jSOIWoJ0K2puyuFbgOsjCyFwCpA/BXUvuiYRIkUaDvdrEJCYNJDz38yrLNby9uNmMrPQ7Dr7XCQqi9k7wuMc13ko+WL3uA8yXQmju63dAxp970ScA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH8fTLQKwfifmTB0Z4eiTFKekq2y/N/5B0BG3PnCWR4=;
 b=u1ek5xd4B0aHf+W1nQcJEHVZis2T+vC+mDN3B/3hT5WNH2gvNNSWDNPT4ybTeTtKOQB8n1vL7+s3hFuvusfjhYjvb56YBaK5rPCBZkGTr+VWIyiUsboQTcmCf/rpk+7tTp+qPo86xqGgLV87PqUny2Q7tUXqRU23C3Fwf2wsDEJTN0k67yfsUj8wvdeWVvwpUcaAPyRGBzsoNbhWVm0lz1W48wuz/By+yp7cvMx+hrPmrTQP3SQUFVlMZ4khcynKQ8c9vPLszHloM05YMTV6Zq/WU3PL9Vg+l+VTvK5dckqmfaWT5oD3uJBMxWHjKmobiBD0jyh2DPW+9NFtdZur1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH8fTLQKwfifmTB0Z4eiTFKekq2y/N/5B0BG3PnCWR4=;
 b=KzR/TVaRzmzoCQppqI8S63iEVwnh+I5etfh9egjkNaM87f6c/p0ComoSsGe3w9RbdMDwFTKQKEfuRcPBkbUXtgJy2vlku6HzG0V0LLa1f2st4OlpmIjuG4wABiUXmdaS5a/O/oPqwKOJoJOb1xyTM0uLCKrMYW6Ue4ovusfTFrFY8PXvWnJelKfEARPxFvlkW1jigibPi8Hu2H279Rapv0aVF8DoakDHf4EQMMTGhLinhv44izXsfdabD2TNq3ZJRyUerz6bnvLkrlTopSGKKOJyW0AwF3pFIpKnyPqH7EuLDcQ3yzuyvnwyBs+k3c7h4+OrNknAc2SBGB4KQpzS2A==
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:188::21)
 by PH1P110MB1524.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 15:27:25 +0000
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1b64:cf76:6f6f:756e]) by PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1b64:cf76:6f6f:756e%5]) with mapi id 15.20.6433.020; Wed, 31 May 2023
 15:27:24 +0000
From: Dave Rolenc <Dave.Rolenc@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Russell Johnson
	<russell.johnson@kratosdefense.com>
Subject: Re: [PATCH 0/1] rwsem_down_write_slowpath check if oob() before
 skipping schedule()
Thread-Topic: [PATCH 0/1] rwsem_down_write_slowpath check if oob() before
 skipping schedule()
Thread-Index: AQHZk9Rmys73gczPGUmDaTrwTOptKQ==
Date: Wed, 31 May 2023 15:27:24 +0000
Message-ID: 
 <eb4b2a7608bf4cb1b16c75b07d095602@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
References: 
 <e5624d226deb4a49bbe28867e15eadf9@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
 <87jzwpxa8l.fsf@xenomai.org>
In-Reply-To: <87jzwpxa8l.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1666:EE_|PH1P110MB1524:EE_
x-ms-office365-filtering-correlation-id: 540be222-677e-4dbe-baee-08db61eb88fe
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SFKesPjiZQDmivsNzZn+/xmd5LBT7CJcEP9h/9Wja5l+hN/OKM8pUitTkcQCXrG3dlOtG7hQ1EmQ1cci3QDBTubbExwEUOodI1lXKd9chbIrBJLdXKwHgEsUNzsL3dDEV/AD+Veuefad0qKkluk+Cz15C+0kYwLFyn6WrZ+Ow6msHL6u0DzS2dosFxrSeE4vn/tMXpCCsMS5wYP6eVOWDqZLOtY5u/k7Dr8S4s0dDqob2UO9zUBBQscu2qtYMPu5N46hUmgA+W+KKS7wHJLG1jEjMuwEOdx6/MnG5kDFLKVN5aLLzofyXlvwhfL+iPDIZR6m4li9ZJgAk2wL5HSqQg+D9aVUolqFaqRo7Uka2Q5W2tuHjgdoL1YapDb4g6jKDIF9lvR6+s8Xo/a5gPgbvTYfIWzpehic41OeDLEG8XFMJAGOuQnNTEZ+EKcj5WvSZmmF5T7pbr8lHJooTWSKmtHxtkjqVJQSyCu0565woKDaZbCiF90w7vbQ5Hi9X5IT4Ck0T/pW4hut4MjcKVMx1RNq4Y4g6t1l/PzPVCh1cxWFGOcLebfd7Ntx4D/+pDAPd/5tTqxVVPHFQVT0Cjtd4Q7bChw0PSaBAuuWDDkxwVh/AV11D4iPl9nAuFkvXfjO
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39830400003)(451199021)(41320700001)(83380400001)(186003)(9686003)(5660300002)(4326008)(26005)(54906003)(6506007)(2906002)(107886003)(86362001)(508600001)(8936002)(66946007)(66556008)(64756008)(66476007)(76116006)(66446008)(8676002)(6916009)(71200400001)(38100700002)(24736004)(108616005)(7696005)(55016003)(41300700001)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 maJAs3K2Wu6bBRFIXu2RKvD4dhsQ71xfLtOl/E/kMXQisfVNw3qO215RUVb++xtEq480F002D2+H0z8ouyvunnqA7y/IPnlfs8iOIWqH49a02mQnzLi+v4ajW1WMTVztZaATiQTDbOBdHgHWGVH5ORW7YyflfHIhUZ2e87tSCcDaA2ekHxRfzhHm403/8aZ4dTanK0R6jyWcDntWHmzrileU+4MSxpWut9iSFI2gXOpw5fsUxUwkgsNhScNCjP3frxamW+dyzbrp9y4d5Efj3Dy+52Tvp78k2rdv8+Mh2a2ZdYijq9zSGwAdqJf8opu/EbK+zsFbue12w91tVmnHooOOpyRgICYDedKLGfnFWHSkdY5iv94OPyFgN9jgabDq4uq6biWiojJWHs2RRSrzbX/H35TP0ynvLF8nu04Shew=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+vS+sCtDegBbXhEnkhugv12s6uvUKh93BMCIPFXkC0IRP7SH15AeC5AFnM1weanwxgUt3wA0ARUcgyvAuq15Nrw0GmYCA0I4FqRqsxkGJIwWrr14fmBsIGbdTLJAgyqDi4DZpGia19zJCbKaLjbAe4cLDfUIG+1oLSp+w1nAcP8t8wQhAzGVIM2to6bKyfPlphlrmBdVCU0E1z6Gnqhhr0ClL6VRy274Ry5vLC9s4fLTaJ+GeJeZ18d4hTaSAullpOYHuMMerK3S6jsu9fJGCQoxZz4BpYn0bH52Nwj1MMRZCnEfs0+U2Zs8ctY/kGRrMFSuF0JeYTngF1cpicF/BvBUQo+FaXFxBosEnUZn28z0/rHSLp2AQxZRXY/Ov/LVbaibxE0JTFask6QfezZXu9yplQ1zNGyNE1f7u5DNUg1PUI1y4KPMnaovGFJ75aQUN9T1r1yi72ZFtv+8lu0URqh5SgWP005tYLzyOVuz1USOxw97M6yPX/iYsOHpQ0AyPWkMIzk8PzWILoE8r22julxQC3XKL2+MMHUl13X/XWmlvSE0tku9Xpp2btQi41/uSR0Vs071wmbnsrUzcbtmPF1LRNucMqRV+VLtkrwcwhpd8KbDUIWzJcM9maLmRErb04uRcqWAj0P7Cychtz4WFuCt9ROKD5BzetJtOeSU8xK/wZPLzN0dOvNytAa0KBSx0CzU6QXvqbZlCwfFGV2JKyHiqBwWAfpIUl3CJQxmWpqWUQcusnnAmGsKqYMAaCq7/7trZ/EUKPpTnOvVbn1mXa2f5t3AvmOIStD7jgrMkpn/ddi7KCqXnFuOsqkS9QaH
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 540be222-677e-4dbe-baee-08db61eb88fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 15:27:24.6632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1524
X-Proofpoint-ORIG-GUID: ENySf5jDlDVGf-6-D2oQSKyqqYgouQWo
X-Proofpoint-GUID: ENySf5jDlDVGf-6-D2oQSKyqqYgouQWo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310131

> What's even worse and the root cause of that issue is that no task on
> the oob stage should ever run rwsem_down_write_slowpath() in the first
> place.

That is probably true, and was likely my misunderstanding of the context
in which it could run. I was simply trying to keep as much of the normal
code path found in vanilla as possible when constructing the patch.

My first attempt at a fix simply commented out the OWNER_NULL check and
goto that skips the schedule() call like this:

                if (waiter.handoff_set) {
                        enum owner_state owner_state;

                        preempt_disable();
                        owner_state =3D rwsem_spin_on_owner(sem);
                        preempt_enable();

                     /*   if (owner_state =3D=3D OWNER_NULL)
                                goto trylock_again; */
                }

                schedule();
                lockevent_inc(rwsem_sleep_writer);
                set_current_state(state);
trylock_again:
                raw_spin_lock_irq(&sem->wait_lock);
        }


That test with the commented out lines worked and the problem went away
, but it seemed like a pretty big hammer. I figured trying the oob
check to preserve as much of the normal vanilla kernel code path as
possible would probably be better. So I ended up with this:

                if (waiter.handoff_set) {
                        enum owner_state owner_state;

                        preempt_disable();
                        owner_state =3D rwsem_spin_on_owner(sem);
                        preempt_enable();

                        if (owner_state =3D=3D OWNER_NULL && running_oob())
                                goto trylock_again;
                }

                schedule();
                lockevent_inc(rwsem_sleep_writer);
                set_current_state(state);
trylock_again:
                raw_spin_lock_irq(&sem->wait_lock);
        }


Assuming you're correct that this code never runs out of band,  that
just means that the schedule call will never get skipped by the goto as
the running_oob() always returns false. The important part I observed is
that if that goto trylock_again gets hit the task never gets out of that
loop. If we make it so the schedule() chunk never gets skipped, things
work fine.

Empirical evidence shows that never skipping that schedule() call makes
the problem go away. My test scenario, which is way too involved to
package up for you and involves custom hardware, will run a couple hours
max before getting a stuck CPU. With the patch it ran over 4 days
without issue. Assuming running_oob always returns false, the code
should be roughly equivalent to commenting out the lines as I did in my
first attempt. My first attempt at commenting out the lines also worked
fine for over 24 hours.  I wish I had more of a definitive answer to the
other task involved, but the stack traces didn't really help there. Not
having a fully working kernel debugger kind of limited what I could see,
so I had to sample stack traces and figure out which code path it was
taking by piecing together the information I had.

I can definitely run your suggested test with the WARN_ONCE if you
really want, but I don't think the cause is some oob context running
this code. It was just my misunderstanding that this code could run in
oob coupled with my desire to not delete those lines if at all possible.

Do you have any thoughts on how to proceed?

Dave

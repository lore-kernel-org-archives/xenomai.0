Received: from mx0a-001f5801.pphosted.com (mx0a-001f5801.pphosted.com [148.163.157.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281019E7C
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 21:50:06 +0000 (UTC)
Received: from pps.filterd (m0090334.ppops.net [127.0.0.1])
	by mx0a-001f5801.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VLcZdF032658;
	Wed, 31 May 2023 14:50:00 -0700
Received: from usg02-cy1-obe.outbound.protection.office365.us (mail-cy1usg02lp0175.outbound.protection.office365.us [23.103.199.175])
	by mx0a-001f5801.pphosted.com (PPS) with ESMTPS id 3qxbpjgdsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 May 2023 14:49:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=pgmbp9eWZczk9ELtFj40oZikxaaUuB4K2jdxR8yCb5PLERmhyoaNE2iai/kFGmKa0j8yuaHeKYAtkt0Pe1pmkmCLNi1GRGACIl3m6UoQyDbzhEUlUL/6rLMfP45yQP0oclYjE2I9hg/c906TVQpaxTAQdtlkQ/2ev8eL6c38Wd7bp87/oKrTp5tjaQY518/1XWK0xH/ilnRaMzAgYZEUCuV008LF3uqDPOhW7e4qf8jiBPnStZblu0NRUN5mDDGAD/c5pI6bY3Kn6YsmpdEhfYyKIhVfGKO5RYy9Ad6RFgfFi13aCY3iz58BzBHFHsyCbG92SpO9Di0mfj6arwRCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3+yLFcxp5N8sU0kzMU6wNe8eWmTnB9VFsv/2kOZ5Ls=;
 b=R1OIWPM2dwnLG5RNsOykRampFEuf5dzD7M0kU2dnq10lQ3TkkQVDFXmj7OPpYyPRc3fOcWTItT9Xi4Jez9lESmIjY5WPVnmXCd6QE9nYZwh2VFi5J7lCAHHMo1dWrcu+kft2jpEGuL9WfLT59OnRvnEkVSS1dNyLMjfVpjwK+l6NsR7qC4oQeFi1fox9FV1+NZZWUwvdSTTSBgva4YELNDF9zT/Acjsd0/54qon9BZWX+gpXgz6k+63M/Ueyjiius2dUJdSVle4a30ga3H7GrtmuiJaKu8SPwvfGLFKpiEZuKmKFBQJYE4/Cx/gnHx03fcfIEK2dpeeT5sqYf7ZCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kratosdefense.com; dmarc=pass action=none
 header.from=kratosdefense.com; dkim=pass header.d=kratosdefense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kratosdefense.onmicrosoft.us; s=selector1-kratosdefense-onmicrosoft-us;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3+yLFcxp5N8sU0kzMU6wNe8eWmTnB9VFsv/2kOZ5Ls=;
 b=mJhrbXmSmAn8QDZbxn5EY7awOT7Gi1yhK9eUB/DqEECSdA1nujqJavHOUZElxuW/fF0M0F1Ghnj3UW14tbzyHgYJDmw8qNPLSv2lmlSewlkcka2GB8AIU+AtoXHKxU94f0XpKDLimBnWprb1zmZkIGVpCysQ4xiW5pCBz13A5ScFSzy1yrzVJSQkWVo3GxN57UGpMeOlRknkIiZ2Ep1DeLd6+hF5Un72sZhwSGBZzZzaeUVEETGOj1ONLa5Ez0/MnefhCdE1YUXlTxY+SzXbkCfCp8/dU0JbAgKsFH0+qPyqOub7e84hTIcxNeEqCUXv4I06zWneztBnn4tooCNvXw==
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:188::21)
 by PH1P110MB0954.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Wed, 31 May
 2023 21:48:58 +0000
Received: from PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1b64:cf76:6f6f:756e]) by PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
 ([fe80::1b64:cf76:6f6f:756e%5]) with mapi id 15.20.6433.020; Wed, 31 May 2023
 21:48:58 +0000
From: Dave Rolenc <Dave.Rolenc@kratosdefense.com>
To: Philippe Gerum <rpm@xenomai.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
        Russell Johnson
	<russell.johnson@kratosdefense.com>
Subject: RE: [External] - Re: [PATCH 0/1] rwsem_down_write_slowpath check if
 oob() before skipping schedule()
Thread-Topic: [External] - Re: [PATCH 0/1] rwsem_down_write_slowpath check if
 oob() before skipping schedule()
Thread-Index: AQHZk9Rmys73gczPGUmDaTrwTOptKa90meGAgABBNEA=
Date: Wed, 31 May 2023 21:48:58 +0000
Message-ID: 
 <5f96b37ba901488780c84581ddb21138@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
References: 
 <e5624d226deb4a49bbe28867e15eadf9@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
 <87jzwpxa8l.fsf@xenomai.org>
 <eb4b2a7608bf4cb1b16c75b07d095602@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
 <877csoxvle.fsf@xenomai.org>
In-Reply-To: <877csoxvle.fsf@xenomai.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1666:EE_|PH1P110MB0954:EE_
x-ms-office365-filtering-correlation-id: 2fc858e0-2afc-48f8-0037-08db6220d6c8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Q7r9VyIB8yzk30Y4s4xdH3GDEUm0EMgt6RdHXtetHm4ge/0/l4L8N+evL3U6gBB6JDnTeIDkMS3ktwucgjEzwmcOMQLRTy8CIG3dv0ntermMz6q6IXJ3mOip3fFgwEAaW7fF1Q/JwGnUhpddKNKg8IRI4ecB58ZADEbVq6ZZ02z9ioHXHv4UMe39pthmvnaDI9IVKPXR8S6mhb7/ufcqfbAQYaC3zYFQJ1mjXD8QQZRImDHZlxvRh8ojrzAj14g2gJ10pv5MdPqgK8alNB/5A18i753D8hZ7YMpjqY+tZQiaW/+gvKYxuLTSsSl6FIl9jYJQuxV8hxVFgI2kLeaWNWP2roEQFqA1DhWe408o6KMD36AUKqheZSGen7h0tBwMChaWjj6ZLr3oKYP3H9fMaEcioCO3htJc+qL22kCz4BkzO2dY77yA96jbyOE3NnmD/9PN472tAIc4QxfYrBjFobhQ2ffB0GhBZgztCE6+t4LRG6LB98+NUUzsPoQ38ctTWGk3fJFqmqzQb36aGbPeXG+ho3uKajOAcBD/s4dZ4EOoKUjapfkjQEUM3ZwQNAaf
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39830400003)(136003)(451199021)(186003)(6506007)(26005)(2906002)(9686003)(5660300002)(8676002)(54906003)(8936002)(38100700002)(122000001)(83380400001)(107886003)(86362001)(108616005)(41300700001)(7696005)(38070700005)(24736004)(508600001)(66446008)(4326008)(71200400001)(76116006)(64756008)(66946007)(66476007)(66556008)(41320700001)(55016003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 1HRvUe9OumoNcwHI4OE/dP2iBmVyDRsDoFMm3yB9iAKFcAuKyzNKUCWsv9NPHmZv8SUfrTnSAIr+0JpJJe5rVTlVVTyXsX97H3HE2+FtpJf1F2r1DjE4snedyqk+tOWLwya+QBYVn3wiTQva3oBAY2OKjIChELl5tQs8v5vocilB/T72HqiuuVCEV/7Lh7Gflo95RQuZwVc5IvujxnLVvnbb5st5Pq8DjgC460YtMBR4j3AyghmUxalNPKlgqr65e+dDzK5eqwWxRME6hCEyQ6dQ0DxEjYEjHHEG6uh6p7QlVMGjEuUu93XJQEm/RNUi7uLxKq3sjmVfUl4zlBhmjkMg7Q28XHj5Bg80U6GnBfvcxUjUXP0NPBi5wV1fBlC19JdnldYdZCwWVjPEsA2Tfn2578WbeMD4HZ0cqftlRwY=
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
	VpVE6D6C4059fVjh6rM3RjLZWrTJ1thuLGwWIKvQtYm+lA62kstjzvvlMge/J+1mRQMlgQR2wjLKNnKOY0mJ1kM07RCGY+NyGSDKWRDxO4YYoo4yJNd86oellY2y1syuphg98bn96s7l8Lmoeqr1FUJnuk7wBrl1OMOo2Yo+Uw4IX3Cd2esRGtr3eI0sDyxEB3JLz+tsQ/FyZLys9EwC8o6NIVSIGWOx6MVE9wIWvDzPh6ERr2W1f0JwbGB7TCHxeuqZT5HvmYeXyjFpR6+YHjywfK5D3RN1mzZxeb9upmz5a7St8h6DNmr9LVFgALv/KMYyLsoebIXZaF6iEFGXElkgaHKvWFbmkBoxY+UY5c8xxprWwqOyIeJyecOjGab6Wy+gnEH0HBcADE94v5be0133oXAgQHtGoIGLu5A3PuKzXqSDZdulGTX3ZEiH1W3gBZhIwNatHeiWyelYiCYf0Ah0LMWiOX8T5EaWHQLJpUAuWNE/mkQ5pBvDa+om/4GMHmAfvKUOKnMc+CDK5h9ftKecDlZXsF97hLWAWEI/LCFlH8MeohrN4c2yLVreUGp3+zJtRrGw6V+Sho5V0hafnAbp5gPE/pOcqRvMETNubUo1hHcPSLq+TtVBAY9TtFPJwiqizpaXf+ltLFh1W2HCCdjJyOIBe0ZH1KKsLP5T0kkydHoZcXZpD8sMaOfwRyXHpU7cdfomFT3W+nrShtcAnAOFtajjD7T+oqYbrMBQHTXh2XcWNmphMWKYwj5spFIVTvkvlK1WRZbbUOWenpy1Y5m/tryqjJSCjR5AMRS4J8YxNChN4xPMKqol7pnGYNOz
X-OriginatorOrg: kratosdefense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc858e0-2afc-48f8-0037-08db6220d6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 21:48:58.4799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7932d891-b9cc-431d-be14-d43339fa1133
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB0954
X-Proofpoint-ORIG-GUID: LrDMrBbRPnrB0Qyq76jraZ5HHMi2MSdg
X-Proofpoint-GUID: LrDMrBbRPnrB0Qyq76jraZ5HHMi2MSdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=959 mlxscore=0
 phishscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305310184

> First thing would be to enable CONFIG_DEBUG_RWSEMS and re-run an overnigh=
t test without any patch in, hoping for the native debug infrastructure to =
give us some hint.

That didn't turn up anything useful, but I did find this in the 5.15.99 cha=
ngelog,
which sounds similar to what I am seeing=20
(https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/ChangeLog-5.15.99):

>> commit db1c5ec57611de759b56c82d273c30ebfc7c25c0
>> Author: Waiman Long <longman@redhat.com>
>> Date:   Wed Jan 25 19:36:25 2023 -0500

>>    locking/rwsem: Prevent non-first waiter from spinning in down_write()=
 slowpath
   =20
>>    commit b613c7f31476c44316bfac1af7cac714b7d6bef9 upstream.
   =20
>>    A non-first waiter can potentially spin in the for loop of
>>    rwsem_down_write_slowpath() without sleeping but fail to acquire the
>>   lock even if the rwsem is free if the following sequence happens:
   =20
>>      Non-first RT waiter    First waiter      Lock holder
>>      -------------------    ------------      -----------
>>      Acquire wait_lock
>>      rwsem_try_write_lock():
>>        Set handoff bit if RT or
>>          wait too long
>>        Set waiter->handoff_set
>>      Release wait_lock
>>                             Acquire wait_lock
>>                             Inherit waiter->handoff_set
>>                             Release wait_lock
>>                                               Clear owner
>>                                               Release lock
>>      if (waiter.handoff_set) {
>>        rwsem_spin_on_owner(();
>>        if (OWNER_NULL)
>>          goto trylock_again;
>>      }
>>      trylock_again:
>>      Acquire wait_lock
>>      rwsem_try_write_lock():
>>         if (first->handoff_set && (waiter !=3D first))
>>            return false;
>>      Release wait_lock
   =20
>>    A non-first waiter cannot really acquire the rwsem even if it mistake=
nly
>>    believes that it can spin on OWNER_NULL value. If that waiter happens
>>    to be an RT task running on the same CPU as the first waiter, it can
>>    block the first waiter from acquiring the rwsem leading to live lock.
>>    Fix this problem by making sure that a non-first waiter cannot spin i=
n
>>    the slowpath loop without sleeping.

It looks like there are some other fixes to rwsem.c in there as well.

The answer may be to try something more recent than 5.15.98. Looks like
5.15.112 is out there, so I'll give that a try.

Thanks!

Dave






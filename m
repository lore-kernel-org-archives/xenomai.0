Received: from mx.manroland-web.com (mx.manroland-web.com [139.29.178.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A935392
	for <xenomai@lists.linux.dev>; Wed,  2 Aug 2023 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manrolandgoss.com; s=manrolandgosscom; h=MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:From:Sender:Reply-To:To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=onX6+9B77jO5AHb0zywQbxpbORao7rMYGqrUhUnyNSM=; b=VJCUic2GCExB
	se7TQhlnvKuyaL1Sq7As7Bfm0GGDxn8OLbnajzVUdc5nDrT9SMnjvN4yazztNN8oR2s9BIDeMjMPp
	O7pl5Pt3kqwsI3syJvem11d7ZdT/lOb6JbjxLVKu+ljU1ZyAtyr/NRFgDvcpGwOvFx7DG0XMjOUTE
	4c7qo=;
Received: from [192.168.56.84] (port=50612 helo=smtpx.manroland-web.com)
	by mx.manroland-web.com with esmtp (Exim 4.96)
	(envelope-from <dietmar.schindler@manrolandgoss.com>)
	id 1qR70Q-0005vV-1H
	for xenomai@lists.linux.dev;
	Wed, 02 Aug 2023 10:14:54 +0200
Received: from smtpx.manroland-web.com (localhost.localdomain [127.0.0.1])
	by smtpx.manroland-web.com (Proxmox) with ESMTP id 189D44140D
	for <xenomai@lists.linux.dev>; Wed,  2 Aug 2023 10:14:54 +0200 (CEST)
Received: from smtp.manroland-web.com (unknown [139.29.160.4])
	by smtpx.manroland-web.com (Proxmox) with ESMTP id 06F314140A
	for <xenomai@lists.linux.dev>; Wed,  2 Aug 2023 10:14:54 +0200 (CEST)
Received: from AUSMXMBX02.mrws.biz (owa.manroland-web.com [139.29.166.82])
	by smtp.manroland-web.com (Postfix) with ESMTP id 13B3F413
	for <xenomai@lists.linux.dev>; Wed,  2 Aug 2023 10:14:54 +0200 (CEST)
Received: from AUSMXMBX01.mrws.biz (139.29.166.81) by AUSMXMBX02.mrws.biz
 (139.29.166.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 10:14:53 +0200
Received: from AUSMXMBX01.mrws.biz ([139.29.166.81]) by AUSMXMBX01.mrws.biz
 ([139.29.166.81]) with mapi id 15.01.2507.027; Wed, 2 Aug 2023 10:14:53 +0200
From: <dietmar.schindler@manrolandgoss.com>
CC: <xenomai@lists.linux.dev>
Subject: RE: data modified by second NRT write with same memory location
Thread-Topic: data modified by second NRT write with same memory location
Thread-Index: AQHZxFkf5jzl3P6vkEqeVqOzGMy4Jq/VkTeAgACDUYCAAE+rgIAAGBkAgAArnbA=
Date: Wed, 2 Aug 2023 08:14:53 +0000
Message-ID: <bcc0cdae5a594bcfa625e3e75fa35e17@manrolandgoss.com>
References: <DM6PR14MB3871876E6E078D3BE974ADCBA30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB387142813E6733B5C9DEFEE7A30AA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87pm46sm8y.fsf@xenomai.org>
 <DM6PR14MB38719B58539606FEA830CF9CA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <DM6PR14MB38714729ADDC7529E3268CCEA30BA@DM6PR14MB3871.namprd14.prod.outlook.com>
 <87fs51evhn.fsf@xenomai.org>
In-Reply-To: <87fs51evhn.fsf@xenomai.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [10.29.52.92]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

> From: Philippe Gerum <rpm@xenomai.org>
> Sent: Wednesday, August 2, 2023 9:31 AM
> ...
> yo sang <stlfatboy@hotmail.com> writes:
>
> > class RTMem
> > {
> > public:
> > RTMem() {}
> >
> > RTMem(const char* data, int size, RTMemType type) {
> > Data =3D Buf;
> > memcpy(Data, data, size);
> > Size =3D size;
> > Type =3D type;
> > }
> >
> > intSize{};
> > RTMemTypeType{};
> > char*Data{};
> > charBuf[256]{};
> >
> > };
>
> <snip>
>
> > static void *realtime_thread(void *arg)
> > {
> >    struct timespec ts;
> >    int ret;
> >    RTMem buf;
> >    for (;;) {
> >        ret =3D recvfrom(s, &buf, sizeof(buf), 0, NULL, 0);
> >        if (ret <=3D 0)
> >fail("recvfrom");
> >        printf("   =3D> %s \n", buf.Data);
>
> <snip>
>
> >
> >     RTMem data("data1", 6, RTMEM_1);
> >     ret =3D write(fd, &data, sizeof(data));
> >     if (ret !=3D sizeof(data))
> >         fail("write");
> >     memcpy(data.Data, "datadata", 9);
> >     data.Size =3D 9;
> >     data.Type =3D RTMEM_2;
> >     ret =3D write(fd, &data, sizeof(data));
> >     if (ret !=3D sizeof(data))
> >         fail("write");
>
> This example code is broken, badly. Please consider what the reader
> thread actually reads, which is definitely not a value, but a descriptor
> containing a pointer to some value, which the writer thread will
> overwrite before realtime_thread() runs. Which explains the outcome.
>
> At the very least, you should have a distinct RTMem instance to feed
> each write() with. This said, since XDDP is by design an inter-stage,
> inter-process IPC, passing process-private pointers in messages looks
> wrong in the first place.

I think it would also work if only the reader used buf.Buf rather than buf.=
Data, i. e.

        printf("   =3D> %s \n", buf.Buf);

since buf.Buf is copied and remains meaningful, unlike the pointer.

--
Best regards,
Dietmar Schindler
________________________________
manroland Goss web systems GmbH | Managing Director: Franz Kriechbaum
Registered Office: Augsburg | Trade Register: AG Augsburg | HRB-No.: 32609 =
| VAT: DE815764857

Confidentiality note:
This message and any attached documents may contain confidential or proprie=
tary information of manroland|Goss. These materials are intended only for t=
he use of the intended recipient. If you are not the intended recipient of =
this transmission, you are hereby notified that any distribution, disclosur=
e, printing, copying, storage, modification or the taking of any action in =
reliance upon this transmission is strictly prohibited. Delivery of this me=
ssage to any person other than the intended recipient shall not compromise =
or waive such confidentiality, privilege or exemption from disclosure as to=
 this communication. If you have received this communication in error, plea=
se immediately notify the sender and delete the message from your system. A=
ll liability for viruses is excluded to the fullest extent permitted by law=
.
________________________________


Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79E1097B
	for <xenomai@lists.linux.dev>; Tue,  8 Aug 2023 13:33:03 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230808133255b4177323993d1b1c9a
        for <xenomai@lists.linux.dev>;
        Tue, 08 Aug 2023 15:32:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JJyY07TXHuoEKwQyDuItC/lSqRTwnw/hxDSgRxk0qvs=;
 b=pacju8sVfTrgRvfHgEvrmcHYS0fpFxU2+fP4b3df2rd4XWsMTDreqfe0eXgxVJwa7yuG7O
 EfFWPLjh+IvkcaSOOTubYqhOtEfQHAQVYeo61lQOz8lb8miNbGpBcJdk+yaXAuKDMkGVRQmo
 PqxOPvyLcy6FXhdJg1/+G6713b7Ik=;
Message-ID: <15d9ce49ae3233ab565eddd92ba34968a73531fa.camel@siemens.com>
Subject: Re: Removal of arm OABI support possible?
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev, Philippe
	Gerum <rpm@xenomai.org>
Cc: Clara Kowalsky <clara.kowalsky@siemens.com>
Date: Tue, 08 Aug 2023 15:32:54 +0200
In-Reply-To: <6c3240eb-896b-403b-3a36-d85fe24f8b5c@siemens.com>
References: <6712560bbd3fb1b22960b14090d0a4c018f61692.camel@siemens.com>
	 <6c3240eb-896b-403b-3a36-d85fe24f8b5c@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Tue, 2023-08-08 at 14:30 +0200, Jan Kiszka wrote:
> On 07.08.23 15:29, Florian Bezdeka wrote:
> > Hi all,
> >=20
> > Clara is currently trying to enable compat support for arm64. That will
> > allow us to run arm(hf) applications on arm64 kernels like we do it for
> > i386 applications on x86_64 kernels.
> >=20
> > We fixed the Xenomai arm specific register layout in a way that is
> > compatible to arm64. That looks promising as the testsuite (smokey) can
> > already be executed successfully in such a compat environment.
> >=20
> > The changes we made affect the EABI only and we left the OABI interface
> > untouched and expect it to be broken right now. We can't really test it
> > here...
> >=20
> > Is there still the need for OABI support in Xenomai? OABI is marked as
> > obsolete since gcc > 4.6.4 (~2013) and Debian stopped shipping oabi
> > toolchains long time ago. Would it be accepted if we simply drop the
> > OABI support of Xenomai?
>=20
> From Xenomai 3 perspective, it would be fine to finally drop that with
> the 3.3 release - patch(es) welcome.
>=20
> Not sure, though, how the situation of Xenomai 4 / EVL is in this regard
> - Philippe?
>=20

According to [1] evl is supporting EABI only.

[1] https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/lib/arch/a=
rm/include/asm/evl/syscall.h#L26

> Jan
>=20


Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350A6AB4
	for <xenomai@lists.linux.dev>; Sat, 20 May 2023 14:58:01 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230520145752c495c1e2813670ecab
        for <xenomai@lists.linux.dev>;
        Sat, 20 May 2023 16:57:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=0hoqGD4gGStHm9sDKlbVHP+s3qU4gVrVfQZbi6dBxeo=;
 b=JMEeyj6Vh6I87kK7mKQ7dRhS6L2HksVvOeHHgKo9zUVTqjoHymXV5MdAW6+HTTti3AlLW/
 ZNiRx0CXOxNit5hUcvkJZScfShlv9tKTqSZQgX9Pe7i6ySf0kBU6b9xh1KCp7/sbcGe7x6o9
 t4RPkEdzaqyOElEhH+EkzNWflNChs=;
Message-ID: <cc9e0bc2e41ade1863b6bf2fe4de867f5e4634ef.camel@siemens.com>
Subject: Re: [PATCH v3 0/11] Revive alchemy, pSOS and VxWorks tests
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Aaron Marcher
 <aaron@sigma-star.at>,  xenomai@lists.linux.dev, richard@nod.at
Date: Sat, 20 May 2023 16:57:51 +0200
In-Reply-To: <fb32757d-4cbe-246c-fc33-f702dec535e5@siemens.com>
References: <20220413215819.22954-1-richard@nod.at>
	 <20230406103341.2914-1-aaron@sigma-star.at>
	 <8ee4086e-580d-3d15-cade-4d983c86e402@siemens.com>
	 <20230517073014.ygkkfjuxd3lzksr6@mail>
	 <fb32757d-4cbe-246c-fc33-f702dec535e5@siemens.com>
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

Hi Aaron,

On Wed, 2023-05-17 at 11:35 +0200, Jan Kiszka wrote:
> On 17.05.23 09:30, Aaron Marcher wrote:
> > Hi Jan,
> >=20
> > I tried integrating the tests into the smokey framework like other ones
> > in the repository. However, the linked tests never show up when listing
> > using `smokey -l`.
> >=20
> > I made sure to place them in the `testsuite/smokey` directory, correctl=
y
> > link them into the testsuite like the other tests and call
> > `smokey_test_plugin()` along with a run function spawning the tests.
> >=20
> > Do you have any hints for me what to watch out for when integrating the
> > tests so that they correctly show up?
> >=20
>=20
> Hard to say without seeing the changes. When looking for past patterns,
> check e.g.
> https://source.denx.de/Xenomai/xenomai/-/commit/78e4d58be37f8a498a03993f7=
4251af57f11c1b7

My best guess would be that the Makefile is missing in AC_CONFIG_FILES
(2nd hunk within the referenced changes) or that
testsuite/smoke/Makefile.am was not updated to include your new test
directory.

If futher help is needed it might be a good idea to post a patch tagged
as RFC.

Florian

>=20
> Jan
>=20


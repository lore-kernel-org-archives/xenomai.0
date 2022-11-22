Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA402A31
	for <xenomai@lists.linux.dev>; Tue, 22 Nov 2022 10:31:09 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202211221020528db47c41e8e4112d33
        for <xenomai@lists.linux.dev>;
        Tue, 22 Nov 2022 11:20:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+zU2ptSTkKoZviMLPSvCaeG8tr0dS9tnUZPdd8rLIEw=;
 b=fvtN/BshMVv2K6A1kcIrYAG+q/fKFXnerskrqi8XfX6kHC11Ok+ZfogZijP1mXxKengFWG
 EC+v152gX88QqnGU9OuZ/OY/Kygw7wKbhixfQWDAg9agZpOdWtEW5LFR8p/2SVZQ+RPkNwta
 keuS4TZM/3P+TWRrGnArWN2qepyhY=;
Message-ID: <70a1564c2e6acb1fde7fdc305c1ca719c38107e4.camel@siemens.com>
Subject: Re: [RFC][stable 3.0.x] lib: Switch to pthread_mutexattr_setrobust
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	 <xenomai@lists.linux.dev>
Date: Tue, 22 Nov 2022 11:20:51 +0100
In-Reply-To: <5d6838c4-acbc-c0b8-4264-e47b1eec1d49@siemens.com>
References: <20221118154220.869584-1-florian.bezdeka@siemens.com>
	 <ea34c26a-e3e5-609e-5af5-2ad3a45e9d96@siemens.com>
	 <0afbc24d39c0f299cbdce15ec33c05e2592d0459.camel@siemens.com>
	 <5d6838c4-acbc-c0b8-4264-e47b1eec1d49@siemens.com>
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

On Mon, 2022-11-21 at 18:49 +0100, Jan Kiszka wrote:
> On 21.11.22 10:51, Bezdeka, Florian (T CED SES-DE) wrote:
> > On Mon, 2022-11-21 at 10:16 +0100, Jan Kiszka wrote:
> > > On 18.11.22 16:42, Florian Bezdeka wrote:
> > > > With recent glibc (at least 2.34), autoconf fails to detect
> > > > pthread_mutexattr_setrobust_np. But that is long deprecated anyway.=
 So
> > > > switch to pthread_mutexattr_setrobust and only fall back to _np whe=
n
> > > > needed.
> > > >=20
> > > > This is a backport of the following commits from stable 3.2:
> > > >=20
> > > > 746cbeb6ccc0 ("lib: Switch to pthread_mutexattr_setrobust")
> > > > 3f85c174e297 ("lib: Fix fallback signature of pthread_mutexattr_set=
robust")
> > > > 2d947e6fe3f8 ("lib: Re-add "static" to pthread_mutexattr_setrobust =
fallback stub")
> > > >=20
> > > > Backporting allows the stable 3.0 branch to be build with the lates=
t
> > > > Debian toolchain, so we don't need a special CI setup for the 3.0
> > > > branch.
> > > >=20
> > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > ---
> > > >=20
> > > > Hi all,
> > > >=20
> > > > would it be acceptable to apply this patch to the 3.0.x stable bran=
ch?=20
> > > > It would allow us to build this branch with the same infrastructure=
 once=20
> > > > we like to update to the next Debian version (12).
> > > >=20
> > > > Especially the y2038 tests require a recent glibc version the next=
=20
> > > > Debian stable release (bookworm, Debian 12) will ship such a versio=
n.
> > > >=20
> > > > One alternative would be to use different build environments for
> > > > different Xenomai stable branches. I fear that's hard to maintain -
> > > > especially the CI configuration will likely explode.
> > > >=20
> > > > WDYT?
> > > >=20
> > > > This patch has been tested with both build environments, so Debian =
11
> > > > (as is now) and the upcoming Debian 12.
> > > >=20
> > >=20
> > > I don't mind backporting with this use case in mind, but why can't we
> > > cherry-pick and possibly massage the original commits?
> >=20
> > Hi Jan,
> >=20
> > I tried but the first one requires merging / does not apply directly to
> > the 3.0.x stable branch.
> >=20
> > How to proceed? Should I resend without RFC tag?
> >=20
>=20
> I've merged these four into stable/3.0.x here:
>=20
> fed3436a19 lib: Re-add "static" to pthread_mutexattr_setrobust fallback s=
tub
> e4111b3c17 lib: Fix fallback signature of pthread_mutexattr_setrobust
> 87c719d48a lib: Switch to pthread_mutexattr_setrobust
> cafb1e21ef lib/boilerplate: Convert pthread_mutexattr_setrobust_np stub i=
nto inline function
>=20
> Only the second one (from the bottom) required a simple conflict=20
> resolution.

Works! Thanks a lot.

>=20
> Jan
>=20


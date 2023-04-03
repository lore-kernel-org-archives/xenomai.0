Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AB20E1
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 08:26:51 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202304030826420dbff8511eae81cddc
        for <xenomai@lists.linux.dev>;
        Mon, 03 Apr 2023 10:26:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=y8Fx6dK3Y5cdZujkiXJZtOu28oS1yVvhQPUkZ9KLQ5k=;
 b=Evhg5GEF2gXqgG+Yl7dzsefBrBUKJjQUM+HLPU7Q5w5ek8wpriZOwsDIW1ZNE5RsBQ5rYs
 LXSq6U9IsyVFvsie6e6rU5lFWFwbP4oZxOGvnaPSPdYhscpzxiJ/zozaS2Zo9fCKVV14OKTM
 OfunuTulmuNgxiLXU5laFhhEPl9ns=;
Message-ID: <49f549e0e1310c36691a9c1320d34de8d23becc5.camel@siemens.com>
Subject: Re: [PATCH] debian/control: Fix missing dependency to gdb
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Jan Kiszka <jan.kiszka@web.de>, 
	xenomai@lists.linux.dev
Date: Mon, 03 Apr 2023 10:26:41 +0200
In-Reply-To: <01cbe2f7-ad57-a8e7-3def-924037a4b42b@siemens.com>
References: <20230327105542.1320510-1-florian.bezdeka@siemens.com>
	 <aeb950f3-558a-f704-dcf0-7e6ffc1c7283@web.de>
	 <54f04d62-9f13-b8c1-f69d-f42f5f394272@siemens.com>
	 <01cbe2f7-ad57-a8e7-3def-924037a4b42b@siemens.com>
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

On Mon, 2023-04-03 at 07:14 +0200, Jan Kiszka wrote:
> On 28.03.23 16:33, Florian Bezdeka wrote:
> > On 28.03.23 00:55, Jan Kiszka wrote:
> > > On 27.03.23 12:55, Florian Bezdeka wrote:
> > > > The xenomai testusite - part of the xenomai-runtime package - needs=
 the
> > > > gdb binary for testing the gdb support. The dependency was missing =
so
> > > > running the testsuite on a fresh Debian system failed.
> > > >=20
> > > > Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > > > ---
> > > >=20
> > > > Backports to all the stable branches will follow.
> > > >=20
> > > >=20
> > > >  debian/control | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/debian/control b/debian/control
> > > > index 857d8ff8f..aba59949c 100644
> > > > --- a/debian/control
> > > > +++ b/debian/control
> > > > @@ -9,7 +9,7 @@ Homepage: http://www.xenomai.org/
> > > >  Package: xenomai-runtime
> > > >  Section: devel
> > > >  Architecture: amd64 arm armeb armel armhf arm64 i386
> > > > -Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
> > > > +Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat, gdb
> > > >  Suggests: xenomai-kernel-source
> > > >  Replaces: xenomai
> > > >  Conflicts: xenomai
> > >=20
> > > Looks like xenomai-images installed that "manually". Can be dropped o=
nce
> > > this fix is in all stable releases.
> > >=20
> > > Eventually, we should split off a testsuite package to allow installi=
ng
> > > tools without pulling all those deps of the former...
> >=20
> > Yes, might be the right follow up. I guess the situation is different
> > for stable branches, so such branches might stay as they are now, right=
?
> >=20
>=20
> In fact, I would not consider this patch stable-relevant. No one
> complained there so far while its side effect is pulling in a rather
> large binary. In that light, let's fix this in next and leave stable as
> is (manual installation of gdb if testsuite should run those test).

I'm fine with that, but to make it clear: We can not clean up xenomai-
images then as we handle all the branches the same way. We have to keep
the manual installation of gdb to make CI happy and gdb tests enabled
(for stable branches).

>=20
> Alternatively, you can make the gdb tests skip in case gdb is missing
> for stable.
>=20
> Jan
>=20


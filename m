Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB636ABC
	for <xenomai@lists.linux.dev>; Fri,  1 Sep 2023 08:08:34 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230901080832745bd0cd8620a46883
        for <xenomai@lists.linux.dev>;
        Fri, 01 Sep 2023 10:08:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=amhPS1l9mku+KCNOjhnopsh12WWrUjokH9kjvP7nyGY=;
 b=GajoGKrUkzFn2ijE8zsPRGO16sTkl0mdkqzI3TJuGpbWL5ztpmv9CFtCUad/fIXUoSmXnL
 7uhaPfTLCmoF3OuCS6I6YkHkWWKlH2Q+WL/eYY6MyyQweeKSfS5AUShosmg9KIqJHCbQk8tK
 37pTa2FbkWP8kqW4JWB7iH8s0vdao=;
Message-ID: <56da2a8495504464611c37de708c4c09222925d5.camel@siemens.com>
Subject: Re: [PATCH 00/19] Enable stable/v3.2.x branch to be buildable with
 6.1 kernels
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 01 Sep 2023 10:08:31 +0200
In-Reply-To: <de7595fc-5ec0-408d-96fd-1e7bdd161a02@siemens.com>
References: 
	<20230828-florian-enable-stable-3-2-for-6-1-v1-0-0e08770820e8@siemens.com>
	 <de7595fc-5ec0-408d-96fd-1e7bdd161a02@siemens.com>
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

On Fri, 2023-09-01 at 09:12 +0200, Jan Kiszka wrote:
> On 31.08.23 22:37, Florian Bezdeka wrote:
> > Hi all,
> >=20
> > with this series applied the stable/3.2.x branch gets buildable with
> > the 6.1 LTS series of Linux / dovetail.
> >=20
> > Most of the patches were taken 1:1 from the master branch. The commit i=
d
> > on the master branch is mentioned in each patch / commit.
> >=20
> > The last patch is a manual backport to support 4.19 kernels. The
> > referenced commit in master did not have to care about such old kernels=
.
> > We already stopped supporting them in master. Please review carefully!
> >=20
>=20
> Yes, this needs careful checking and a second thought. In the one side,
> some driver changes are more invasive than I normally take into stable.
> On the other, most have lived in master now for quite a while.
>=20
> If we take all this, the series should be reworked to avoid obvious
> build breakages during potential bisections. That means folding the
> fixups for kernels <5.10 into the patches that require them.

Folding should be easy, but I think we cannot avoid build breakages.
Each patch is basically fixing one or more build problems.

I separated the necessary backport (we're talking about the last patch
only) to keep as much as possible identical/unmodified to the master
commits. Maybe we should move it next to the patch that it enables for
4.19 instead of folding?

Florian
=20
>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center


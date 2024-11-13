Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548CF2309AC
	for <xenomai@lists.linux.dev>; Wed, 13 Nov 2024 21:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731533816; cv=none; b=VTxV5P5yG7/9SKfBa01qmeVLUZa6D4m2cJCQHOxAHNBQ3973i40SbiyrpozS3h0/+ynQu3ieY+EjnXlMfnKGQnNBhqhz86PN1WmkUUXpgyRdp9ThmfhDpb1D8ej+49WHvN1o6/GVSZrckKVYH2g+pwa52GvmJOjdfUg7fvcIawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731533816; c=relaxed/simple;
	bh=2moFPWKxabXr5U7j4obs3E7qeIGo3KAIhpT91loZVI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k4R7VuAJ9HUPIX7FsSr85HL3CT8Ik02fOP52x+u1qqeGGPjAEKocLzvgs9X71vlgcFZE2HwX6CxUsZ5qzmWWnsMDUrrZ1aM97iau8f7374iydi7V9sFXlaCPyByPTP4R1aH0yUDhkriYUahUDx9H4JIoKjIiV7ABjVnI/Q+1Iyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Odr+SgsO; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Odr+SgsO"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241113213645677c381a526a5cffc7
        for <xenomai@lists.linux.dev>;
        Wed, 13 Nov 2024 22:36:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UotIgkCh3xUEEkWx3YRvmbPsKyF0yViq3kejb6gkPhI=;
 b=Odr+SgsO9czquvB/gEbwGbz4UKsfcPztG15QQ2V+yCk203+an9j1cKKfXsQTM0tKW6NTDW
 +6SDxC5hfdA6WvRqb5PMMpGEg2/5lIIv92idqYHBKXWai6T4mlV4EFgLSuG3M1JQVZOQA9j2
 OiwQEOGqPeGCHpUCSA8mmC/KfI5y2ZJacdMtonII6kqPMu462S+nyg9VcrjPG9QfmXkA6PFK
 BK+Tk8a3gJxTG6SfF+GFVX+KF1QIZSUQA9U+5rtVWbreNSxbAqWcQTvY8/qvq3nan1dSrzjc
 di1x2GJJZ8O+gQbmZt69Vf9sh0TKrZad6QIChoHwcXi+AwzUx13xdgXQ==;
Message-ID: <b75719cfeee4745a4469a89af34fbdbc10d155d7.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 1/2] ci: Add scheduled job to build
 lavacli container
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Date: Wed, 13 Nov 2024 22:36:44 +0100
In-Reply-To: <78aa3c19-7226-47d2-a319-8f890c81e7ec@siemens.com>
References: <cover.1731508393.git.jan.kiszka@siemens.com>
	 <f1e1d2111b007f20009485359b45482d09934429.1731508393.git.jan.kiszka@siemens.com>
	 <af9e0e0eb919c82645a4afa6334f134fecb7b163.camel@siemens.com>
	 <78aa3c19-7226-47d2-a319-8f890c81e7ec@siemens.com>
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

On Wed, 2024-11-13 at 16:47 +0100, Jan Kiszka wrote:
> On 13.11.24 16:24, Florian Bezdeka wrote:
> > On Wed, 2024-11-13 at 15:33 +0100, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >=20
> > > We want to switch to self-built Debian containers with lavacli
> > > pre-installed. That will speed-up the start of test jobs and avoid th=
e
> > > manual installation of lavacli in each of them. To keep that containe=
r
> > > up to date, prepare a pipeline job that will be scheduled once a mont=
h
> > > to perform a build and deployment to gitlab.com (source.denx.de lacks
> > > a container registry).
> > >=20
> > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > ---
> > >  .gitlab-ci.yml        | 14 +++++++++++++-
> > >  ci/Dockerfile.lavacli | 17 +++++++++++++++++
> > >  2 files changed, 30 insertions(+), 1 deletion(-)
> > >  create mode 100644 ci/Dockerfile.lavacli
> > >=20
> > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > index b8945bc..37d2a6d 100644
> > > --- a/.gitlab-ci.yml
> > > +++ b/.gitlab-ci.yml
> > > @@ -15,6 +15,7 @@ variables:
> > > =20
> > >  stages:
> > >    - parent
> > > +  - build
> > > =20
> > >  .parent:
> > >    stage: parent
> > > @@ -56,4 +57,15 @@ xenomai-3/next-long-term:
> > >      include:
> > >        - local: '/ci/xenomai_3_next_long_term.yml'
> > >    rules:
> > > -  - if: $CI_PIPELINE_SOURCE =3D=3D "schedule"
> > > +    - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $ONLY_RUN =3D=3D=
 $CI_JOB_NAME'
> > > +
> > > +lavacli-container:
> > > +  image: quay.io/buildah/stable
> > > +  stage: build
> > > +  before_script:
> > > +    - buildah login -u "$CONTAINER_DEPLOY_TOKEN_USER" --password $CO=
NTAINER_DEPLOY_TOKEN_PWD $CONTAINER_REGISTRY
> >=20
> > Where are those CONTAINER_ variables coming from?
> >=20
> > Using them as cmdline arguments can easily leak them by enabling
> > something like CI_DEBUG_TRACE.
> >=20
>=20
> They are masked vars in your gitlab-ci project if you want to build that
> container. No difference here to other credentials BTW.

Then the documentation is missing. See tests/README.md.


>=20
> > We break the "fork and re-use CI configuration" workflow even more now.
>=20
> Only if you actually trigger this part of the pipeline. It requires a
> dedicated schedule for ONLY_RUN variable set.
>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center


Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3BC157
	for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 11:15:08 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202309291115069cd751569626dfb178
        for <xenomai@lists.linux.dev>;
        Fri, 29 Sep 2023 13:15:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=umttFKYCja0SYsZZyPAqbSYkWwFHguAsEwGbau2PdTE=;
 b=eBi/M8KjLISbk71tozJBnu38SARps5bSvyL6+EmU0cBXbs+B8AjpIozSv4kLbqz/H8fH5d
 wUGWPRzYfgqecQt2vnji7OuYHo6VKwsZ6zCsfHlMLOVGhIXiFAc9iQonhrraus6kWo5mRXzh
 B3iHWWYCcYIrs0oDM0IMWnAnZxDLU=;
Message-ID: <75b00486e78fd4b2199b8c1ca1bc00fe133a009f.camel@siemens.com>
Subject: Re: [PATCH v2 0/9] y2038: Finalize and enable y2038 support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 29 Sep 2023 13:15:05 +0200
In-Reply-To: <d0dc4947-3124-4781-a09a-fc1eeff23578@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
	 <e21e5064-061b-422c-be02-74aa08d26719@siemens.com>
	 <6dccc04e926ae6a658c297cd7f45566e55fbeb7d.camel@siemens.com>
	 <d0dc4947-3124-4781-a09a-fc1eeff23578@siemens.com>
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

On Fri, 2023-09-29 at 10:14 +0200, Jan Kiszka wrote:
> On 29.09.23 09:45, Florian Bezdeka wrote:
> > On Thu, 2023-09-28 at 18:25 +0200, Jan Kiszka wrote:
> > > Thanks, this is sure a major step forward!
> > >=20
> > > How confident are your that all these now possible combinations are
> > > still tested? Our CI will run with y2038 enabled, right? How is the
> > > disabled case tested, at least build-wise? Or the case "unsupported b=
y OS"?
> >=20
> > Per default, y2038 support is enabled if
> >   - the architecture we build for is affected
> >   - glibc provides y2038 support as well
> >=20
> > All 32 bit targets that we have (bbb, x86-compat) are now built with
> > y2038 support enabled.
> >=20
> > All 64 bit targets are not affected, so y2038 support is disabled (not
> > required).
> >=20
> > The only thing that we do not test right now is the building against
> > older glibc versions. I'm not sure if it's worth to add more CI jobs to
> > cover that case.
>=20
> I think adding one disabled or y2038-incompatible build test with 32-bit
> to Xenomai CI (not -images) would be good, at least for now.

The build jobs of Xenomai (not -images) are still based on Debian
bullseye [1]. So we already test that for now, more or less by accident
[2].

I think we should migrate to Debian bookworm and than add one more job
building on bullseye. Does that make sense?

Florian

[1] https://source.denx.de/Xenomai/xenomai/-/blob/master/.gitlab-ci.yml#L16
[2] https://source.denx.de/Xenomai/xenomai/-/jobs/701101#L1298

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center


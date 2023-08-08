Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3A7107B0
	for <xenomai@lists.linux.dev>; Tue,  8 Aug 2023 12:58:20 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2023080812581297a0b4a7bdcf8b0b7d
        for <xenomai@lists.linux.dev>;
        Tue, 08 Aug 2023 14:58:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=4K/Kx78V9yssjkpzPzfmwFDb68kibOuK43e4V2mrezo=;
 b=kxICSGrjQoX55nOYeirw/sZ3tkU1gcGeN8w4iQHy/Ph+3byhn4aPmQaF61b3j3gdpkvIhT
 RjKB4HfHJSu3o6LgbxHfcDX94Ct0zwnxhRACtCk5XDC1HPmkZeRGdEn6L23Gt/cI9nlzLD0B
 u7tFhJDMGfAjLrn8t9zgakfsTLdBA=;
Message-ID: <9aa0c21529b94d4b82c3bee604050482fc248a7e.camel@siemens.com>
Subject: Re: Latest Dovetail patch release?
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Aaron Marcher <aaron@sigma-star.at>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, richard@sigma-star.at
Date: Tue, 08 Aug 2023 14:58:11 +0200
In-Reply-To: <20230808125241.imtt6vqp3lekepj5@mail>
References: <20230808063230.q46u55o7xjzy2dob@mail>
	 <07b6a1c3-b341-60a5-23aa-9338cc8be501@siemens.com>
	 <20230808125241.imtt6vqp3lekepj5@mail>
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

On Tue, 2023-08-08 at 14:52 +0200, Aaron Marcher wrote:
> On Tue, Aug 08, 2023 at 02:45:43PM +0200, Jan Kiszka wrote:
> > With Xenomai 3, we are testing v{5.10,5.15,6.1}.y-dovetail-rebase as
> > well as latest v6.x-dovetail-rebase, always the head revisions.
>=20
> That's what i thought. Thanks for confirming, Jan.
>=20
> > Regarding patches, I would refrain from looking at
> > https://xenomai.org/downloads/dovetail/ as it stalled last year. Use th=
e
> > linux-dovetail repo.
>=20
> Thanks for the information. Maybe this can be added to the documentation
> anywhere or as a README file to the (old) download location to prevent
> further confusion?

We have doc/asciidoc/README.INSTALL.adoc which mentions --dovetil (nice
typo...). Seems we should fix that up (or even remove/retire --dovetail
from the prepare-kernel script if we do not plan to maintain the patch
download location).

>=20
> Aaron
>=20


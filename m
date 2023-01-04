Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7AABA2E
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 22:37:33 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230104223731d8cd811d3d12701dac
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jan 2023 23:37:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Nd39ZLtL/ifSzDPYgyZHRCDJXGgrrK9rUWHScak4ypc=;
 b=NBZ7iUaT2mv30LskuOUgvwnLdEneoMZK7I6zYPZv5PlIX0cF9JkrKAGM8q52alzAKFwZ5C
 tFBYoYKORqnZojlCnGecD3BlyyylJA88gt5JGYByJGzRnn3C2l/1uk5cph2HZAb6GH22VTAf
 6TYwnA0P4QTYWMgRJ97cqTAlUlZwM=;
Message-ID: <c71b036b5d8873b1bfc3beb1aacefd3b7da9e091.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 3/3] start-qemu: Start with
 read-writable rootfs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 04 Jan 2023 23:37:30 +0100
In-Reply-To: <d53d4600-1bed-1c2f-4e63-e4bae00afbec@siemens.com>
References: <cover.1672845695.git.jan.kiszka@siemens.com>
	 <18e4ca3b65ab3881493b4e6a8d019cd62fe5efc8.1672845695.git.jan.kiszka@siemens.com>
	 <87d836c68358798cf64dfd1264974bd67cb6498b.camel@siemens.com>
	 <d53d4600-1bed-1c2f-4e63-e4bae00afbec@siemens.com>
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

On Wed, 2023-01-04 at 17:25 +0100, Jan Kiszka wrote:
> On 04.01.23 16:57, Florian Bezdeka wrote:
> > On Wed, 2023-01-04 at 16:21 +0100, Jan Kiszka wrote:
> > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > >=20
> > > This is needed by systemd to initialize the machine ID on first boot.
> >=20
> > I'm not facing any problem regarding the machine-ID here, but the LAVA
> > tests are failing like this:
> >=20
>=20
> I got
>=20
> Welcome to Debian GNU/Linux 11 (bullseye)!
>=20
> [   12.650423] systemd[1]: Set hostname to <demo>.
> [   12.651334] systemd[1]: System cannot boot: Missing /etc/machine-id an=
d /etc is mounted read-only.
> [   12.651709] systemd[1]: Booting up is supported only when:
> [   12.651992] systemd[1]: 1) /etc/machine-id exists and is populated.
> [   12.652296] systemd[1]: 2) /etc/machine-id exists and is empty.
> [   12.652595] systemd[1]: 3) /etc/machine-id is missing and /etc is writ=
able.
> [   21.224091] systemd[1]: Invalid unit wpa_supplicant-nl80211@.service s=
ymlink multi-user.target.wants/wpa_supplicant-nl80211@.service.
> [   21.224776] systemd[1]: Invalid unit wpa_supplicant-wired@.service sym=
link multi-user.target.wants/wpa_supplicant-wired@.service.
> [   21.226480] systemd[1]: Invalid unit wpa_supplicant@.service symlink m=
ulti-user.target.wants/wpa_supplicant@.service.
> [   21.228235] systemd[1]: Failed to populate /etc with preset unit setti=
ngs, ignoring: Read-only file system
>=20
> with a qemu-arm image before this change.
>=20
> > 2023-01-04T15:10:03 [?2004lmkdir: cannot create directory =E2=80=98/lav=
a-6952=E2=80=99: Read-only file system
> >=20
> > So, in addition to the qemu-script we might have to update the job
> > templates for the qemu tests as well.
> >=20
> > I already added "rw" to the qemu kernel cmdline in my local branch, but
> > I updated to Debian 12 here and up to now was sure that this is
> > something Debian 12 specific. I have no glue what changed in the test
> > setup / LAVA installation that "rw" is necessary now. Any ideas?
>=20
> That's more a question for Quirin, I do not even know when that mkdir=20
> comes from.

This mkdir is coming from the LAVA preparation steps. So LAVA requires
the rootfs to be writable. Might be a configuration topic.

Started some test runs here (internally) as the latest test run on
public next branch was successful today.

The only difference here is a Isar update. Let's wait for the test
results. I will investigate further.

>=20
> Jan
>=20


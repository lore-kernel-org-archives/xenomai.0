Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499A3EA6D
	for <xenomai@lists.linux.dev>; Wed, 10 Jan 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QiS/mpE9"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240110090332bc2957d61b4a499bba
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jan 2024 10:03:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=YYCW5qYpj23sk7Cv7Gs3T5r/zkEr5wmgnI+dd1Ul1XA=;
 b=QiS/mpE92hmulGTp7Uyyglq75VjqdcIW12cglpLhRFS3fzCLMbqDal88vtAWAf2gGGbiwq
 kvTEiz9/xbGFOAImcpjTifwksY+KoG9jNNRP14Agb1yXyBkkZsWyerJjE7y72oTCAGSH/TCY
 lASsS54VODQ5Aryk65GgJ0HE+Si3c=;
Message-ID: <ecf1a4f2e7e2c73c68bba8734cb994d6f2d66971.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH v3 07/10] xenomai-4: Add evl userspace
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 10 Jan 2024 10:03:31 +0100
In-Reply-To: <4308209312d585ddeb399ced286f216e267b6284.1704861962.git.jan.kiszka@siemens.com>
References: <cover.1704861962.git.jan.kiszka@siemens.com>
	 <4308209312d585ddeb399ced286f216e267b6284.1704861962.git.jan.kiszka@siemens.com>
Autocrypt: =?US-ASCII?Q?addr=3Dflorian.bezdeka@siemen?=
 =?US-ASCII?Q?s.com;_prefer-encrypt=3Dmutual?=
 =?US-ASCII?Q?;_keydata=3DmQENBFwsf8QBCAC2f4AQWu92LZC4bKyUYRxWIpWqGz790s?=
 =?US-ASCII?Q?pcYkXO7M8kfea4iC8qMxv2hT4HT0LTncRP6WiovVN2PeoOBfN5BSa5z?=
 =?US-ASCII?Q?LIrZGVXh7KmbdKhwhVU+ynoTq9G5uaO2Kos7Vv7nNCuatIq8tSNILuoB?=
 =?US-ASCII?Q?DFTAZnJW3y1V7YOwhDCPl5gbLSYqUY3OE0yksbtCcVI5istT4ED6mjQ?=
 =?US-ASCII?Q?9W+3uH1LrgFeEF0oxTjrEPxO5ZYATz0f/TYC8WiM0sMrV+n0eMDntlzA?=
 =?US-ASCII?Q?63D6lcRi5mNp2jPsJkq3tbWqyCrAe1sKPVJB44ekFwCk0kDIuhR13Q3R?=
 =?US-ASCII?Q?HE4Or/9sznhMUQjYueWXvTZfzH/VsQJHABEBAAG0LUZsb3JpYW4gQmV6?=
 =?US-ASCII?Q?ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPokBVAQTAQg?=
 =?US-ASCII?Q?APhYhBAzL4P3jiTHdthsq4cj0O1fnOEBVBQJcLH/FAhsDBQkB4TOABQs?=
 =?US-ASCII?Q?JCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMj0O1fnOEBVc6YIAJ8oO4x?=
 =?US-ASCII?Q?TjOCpjxaS8XQE6VW50HE9I6ShbQVWUEGhF4qzJaACTQDjdg/aio7qNRa?=
 =?US-ASCII?Q?mnAy83Hy9sAxKVhXs+1R1fstN+JO8zgD3tJspucUkCiXlYu+Qcv2d6C?=
 =?US-ASCII?Q?ostv+h4nv8fkSoeLfsQu3GJt6W0RN7t+8H/9fUMXyuB8GWo4bhaZcti6?=
 =?US-ASCII?Q?78CotGLs6UGZpYEGiAMto8+9zVO/tdY1BkREM6bCVeQ9FnnpTRQy/tU5?=
 =?US-ASCII?Q?xemMWJI64UUP92TUIbQ3TZKAz4iG/Mle+YjiHBGrJM7TxjE3sDg5J2Fa?=
 =?US-ASCII?Q?HX4wmZPKGdB6wANKupf6HMMt2y7gduVmMKzgb8PDMLPZwWBSvjELQqz?=
 =?US-ASCII?Q?hiZAQ0EYLSqZwEIAIR4HMTQC4F4YxatIl6MIDY03zD4M3ZQpgyQ6QFL9?=
 =?US-ASCII?Q?Dq0I+PGc7A6z5rsGl76+D8pDFSN2BBJiLLlQadxKc3ZyTTlRp4bc=09bf?=
 =?US-ASCII?Q?FZRmsAXwVfLtBauXxGo9pkyhk8Vcjb2EJm6XR8PH99buGOXlFfTLsmeA?=
 =?US-ASCII?Q?ji/F4jU3qlUnwZMBvHZwRSFqOGdwKPMvW3FppfmREQ0o4xJ4b/bxGXx?=
 =?US-ASCII?Q?ko21uyR/S5rEJx6X8Ukw95h3JinXHx/g2cjbKHrWBDKoqtX9IZCamDny?=
 =?US-ASCII?Q?R+sfLWQbOKOrLNYLwLAQwOTVlZWTgue10G1q6Zi0r8RQ2T1Uy+ZLYagv?=
 =?US-ASCII?Q?Cbzp/lT7p3mv3ba68llX896c0AEQEAAbQ/QmV6ZGVrYSwgRmxvcmlhbj?=
 =?US-ASCII?Q?sgQmV6ZGVrYSBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FAc2llbWVuc?=
 =?US-ASCII?Q?y5jb20+iQEcBBABCAAGBQJgtKpnAAoJEEoHyE9rG1dPpJYH+gPnqpu7h?=
 =?US-ASCII?Q?4fsWOxco38e74MsazoUdfndTYP5tgaYTVE51ZhOZBl+4jYaywsmmFm9g?=
 =?US-ASCII?Q?6N4Tw3GiMEDB4YU1X7gQZ60fDKpYL5SnCu5qZirJ4RCV4LDA0789ir+6?=
 =?US-ASCII?Q?8/zfwXBTV5QoMH0+MkXB4BL+Km3f7X/GdN5oRoItAyKDBcEfGJo6afT?=
 =?US-ASCII?Q?PtcUdI9n7ExCSfJwb0SBvvkvUsdNppFDGOOHSioINbEHBs2VUvE43toM?=
 =?US-ASCII?Q?4mPLfhFIAtDcn5Byt80/kotU8v3Iyf86NYCa+0h77xTsKHcCUqe8Rvow?=
 =?US-ASCII?Q?bCIbig9GGbbd54TasfqQQOiAkn/WeGl33+UIVX1Q8zo7eyMJHzLJQ3I=3D?=
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

On Wed, 2024-01-10 at 05:45 +0100, Jan Kiszka wrote:
> @@ -0,0 +1,40 @@
> +From b4447250c7fff6940c1bb6f0308da617bebaa643 Mon Sep 17 00:00:00 2001
> +From: Jan Kiszka <jan.kiszka@siemens.com>
> +Date: Tue, 2 Jan 2024 14:01:19 +0100
> +Subject: [PATCH] meson: setup-uapi: Take Debian multiarch into account
> +
> +Check also the Debian multiarch include path for the chosen architecture
> +so that we can support (self-built) linux-libc-dev packages that contain
> +the evl headers.
> +
> +Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> +---
> + meson/setup-uapi.sh | 12 +++++++++++-
> + 1 file changed, 11 insertions(+), 1 deletion(-)
> +
> +diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh
> +index f2d0774..633c5ed 100644
> +--- a/meson/setup-uapi.sh
> ++++ b/meson/setup-uapi.sh
> +@@ -17,7 +17,17 @@ if test -r $UAPI/Kbuild; then
> +     link_dir $UAPI/arch/$ARCH/include/uapi/asm/evl asm
> +     link_dir $UAPI/include/uapi/asm-generic .
> + else
> ++    DEB_HOST_ARCH=3D$ARCH
> ++    if [ "$DEB_HOST_ARCH" =3D "x86" ]; then
> ++        DEB_HOST_ARCH=3Damd64
> ++    fi
> ++    DEB_HOST_MULTIARCH=3D$( \
> ++        dpkg-architecture -q DEB_HOST_MULTIARCH -a $DEB_HOST_ARCH 2>/de=
v/null)
> +     link_dir $UAPI/evl .
> +-    link_dir $UAPI/asm/evl asm
> ++    if [ -d $UAPI/$DEB_HOST_MULTIARCH/asm/evl ]; then
> ++        link_dir $UAPI/$DEB_HOST_MULTIARCH/asm/evl asm
> ++    else
> ++        link_dir $UAPI/asm/evl asm
> ++    fi
> +     link_dir $UAPI/asm-generic .
> + fi
> +--=20
> +2.35.3
> +
> diff --git a/recipes-xenomai/libevl/files/debian/compat b/recipes-xenomai=
/libevl/files/debian/compat
> new file mode 100644
> index 0000000..f599e28
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/compat
> @@ -0,0 +1 @@
> +10
> diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-x=
enomai/libevl/files/debian/control.tmpl
> new file mode 100644
> index 0000000..36eb68c
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/control.tmpl
> @@ -0,0 +1,11 @@
> +Source: ${PN}
> +Section: misc
> +Priority: optional
> +Standards-Version: 3.9.6
> +Maintainer: Xenomai project <xenomai@lists.linux.dev>
> +Build-Depends: ${DEBIAN_BUILD_DEPENDS}
> +
> +Package: libevl
> +Architecture: ${DISTRO_ARCH}
> +Description: ${DESCRIPTION}
> +Depends: ${shlibs:Depends}
> diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/=
libevl/files/debian/rules
> new file mode 100755
> index 0000000..9c9148f
> --- /dev/null
> +++ b/recipes-xenomai/libevl/files/debian/rules

Wouldn't it make sense to move the debianization into evl like we have
it for Xenomai as well? In addition it would follow the "upstream
first" again.

I think it has some value if someone can run dpkg-buildpackage on evl
and doesn't have to use xenomai-images for building packages.

Florian

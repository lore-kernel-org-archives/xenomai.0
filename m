Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386681A27F
	for <xenomai@lists.linux.dev>; Fri,  3 Nov 2023 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="OLt1NbOU"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023110314473166dfc78f3c735c1ade
        for <xenomai@lists.linux.dev>;
        Fri, 03 Nov 2023 15:47:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=mL5mlLp3cMilVZofcJ1ZbBwdrqwomah8SSl6C4SLGUY=;
 b=OLt1NbOUiNocPI/r7HFBf+1ZI4ILqd3wLvEwrD1n8INmEfuWzTOkFExe4DXt7SzKR7HW2p
 3jho9iWU1izg8WiflZhpaXSD0MpDvp6/ZvVkctN9di5wu9Ku+QwdKaoZySkVCVA8ikb/c/Pt
 GYb4gdw/yRpX2k8Spk4dIX8PSa7AM=;
Message-ID: <4481c3ac97badd74e74849a97b049f1bb5c89fb7.camel@siemens.com>
Subject: evl: Problems while trying to build up a debianization
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: rpm@xenomai.org, clara.kowalsky@siemens.com
Cc: xenomai@lists.linux.dev
Date: Fri, 03 Nov 2023 15:47:30 +0100
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

Hi Philippe,

we're starting with some very first steps regarding EVL here. The idea
was to enable the xenomai-images project to generate images with EVL as
well.

Currently we're failing because there is some confusion about the UAPI
installation here.

The meson build and install steps of libevl refer to some headers
coming from the (sources) of linux-evl.=C2=A0

We're trying to integrate this meson based build into a debianization.
As libevl depends on some headers delivered by the kernel "package" we
would model that as a build dependency. libevl would depend on linux-
evl-headers.

Right now we're failing inside the setup-uapi.sh script because the
sources of linux-evl are not available. We were not able to set -Duapi
correctly.

To my understanding the dance with include/ inside the meson build
directory is necessary to limit the number of "special" include paths.
Is that correct?

Another issue we came across is the installation of the UAPI headers by
the libevl install step. Why is that necessary at all? The only
component that should depend on that headers is libevl itself. No?

Any idea how we could fix that up without breaking your local build
process?

Best regards,
Florian


--=20
Siemens AG, Technology
Linux Expert Center


Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7FE79B7E
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597248; cv=none; b=sHUSJU48N6djXHY6RrbAAy1PdJ5V1pQAZgln5LpKduWy4UnX/SyVUH7HA8CsPzqUmXJigDwJxswFyVzypxgz2mm+xBOTNVMX6SXu5BoKh02gEsdDBk/gzlxfEMqJ0N0Es8rTx3jymw02xJOAqcEyN3GzapWNYxD8cRybzWgWzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597248; c=relaxed/simple;
	bh=5NsbjBkE74EZtSxnHeaQWxgwwaRpNAZpfgS8zONML7s=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=WoFYbrw/LXi0QSU4htI6OP4YMXuLPkJ0FpHERIEEz9AnEXbKWOmxtYw5DWgwOmvkZBr/utf+TpxnCmc8OmLGd3APr35Pk/RSoIOwx+3ydRlJFWvPuWfEzdzzHCLFEEdK/AypBSgsC/P45NypC8tlmY/JQxEXfNp/nMPZcYWnV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Wr5/2k7G; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Wr5/2k7G"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202407100740335634077b12abd3c3db
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jul 2024 09:40:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=5NsbjBkE74EZtSxnHeaQWxgwwaRpNAZpfgS8zONML7s=;
 b=Wr5/2k7GUYs97Wi1yJxvdJE1m5DgypIukjOPGYqvxgGH+8JIMmOwWOZEzxSHnzR8DzCn/W
 j9BU5DQaLlpZp36KH8FWlm0mZby5kUQLjrVrqZIAKnYbNpmrWqIu50iC2IR+Tdh0XZWzfVTA
 zdibFNgTcZ1ox5sWIWQ1azA47lwHU=;
Message-ID: <5c883622fa2ba963f05f652f07c27fed847aaefd.camel@siemens.com>
Subject: Dovetail: Missing backport in Dovetail 6.1 and 6.6
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 10 Jul 2024 09:40:32 +0200
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

I just saw that you updated the 6.1 rebase branches. Thanks for that!

Seems I have a follow up:
The 6.1-rebase and 6.6-rebase branches are missing a backport of=C2=A0

commit e5ca068176e7 ("x86: dovetail: fix unbalanced inst markers (int80_emu=
lation)")=C2=A0

See [1].

I screwed that up in 6.6 with

commit 2a2f595d9ed8 ("x86: dovetail: Fix compat syscall handling, account f=
or new IDT entry")

See [2].

Best regards,
Florian

[1] https://source.denx.de/Xenomai/linux-dovetail/-/commit/e5ca068176e775e9=
d0e9c6c5c9e2a1f6b4a674ee
[2] https://source.denx.de/Xenomai/linux-dovetail/-/commit/2a2f595d9ed8ab6f=
793df6164e0e847f9d8f396c

Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED4A946
	for <xenomai@lists.linux.dev>; Fri,  4 Aug 2023 10:11:12 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 204B340002
	for <xenomai@lists.linux.dev>; Fri,  4 Aug 2023 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1691143865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=q5duidpfVrQcDYfl0Qxx9vD1FMvlYYFOuD4BtuzEVcM=;
	b=cob0LtzAMNkwNwc8AM9rgN61OOtFWRL2YA2UlvJM4p6ctKu0u3wEFGZhC/l6XyuR4K0dXa
	NUYkWWZSaDCqYXD6haGRNvOaQlJneaEAKWHXcTZeT8ciEMF5cdwB14Y3ad2ZrxILGHkucT
	hl3u4kwaNj0KSlUemO95ktnpDUpsWp5mRxNktCKauUk7d2ufIWxc2A8JmVH7iewAtHSCoU
	OAN33lqtWsWT3JacrGEdhxp5ClZp2o2ZU79Haydn+kgi904Q99aAHHEKBCB9EIy1jUvFeO
	TDM9BiV7+6UCyhos6w0vx3iacFtfwpyGWf73VY23y83RKHXeg8roeblJg2NlqQ==
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Subject: Rust interface to Xenomai4
Date: Fri, 04 Aug 2023 11:36:39 +0200
Message-ID: <878rarrubv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


A quick heads up about the state of the Rust support for Xenomai4
applications.

The Rust API to the EVL core underlying Xenomai4 has improved
significantly since its inception a year ago, with more than 80% of the
C interface features (aka 'libevl') now covered. The plan is to publish
it to crates.io once complete.

Building this code requires the FFI bindings (bindgen) to libevl which
are available from [1].

People interested in this work can access it from [2]. Contributions
(obviously) welcome.

[1] https://source.denx.de/Xenomai/xenomai4/evl-sys
[2] https://source.denx.de/Xenomai/xenomai4/revl

HTH,

-- 
Philippe.

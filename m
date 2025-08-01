Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC032149C7B
	for <xenomai@lists.linux.dev>; Fri,  1 Aug 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061601; cv=none; b=CWXpIPLvZuUQEcPDw6x+AX/rxva6+NKIsuE7sYbgJLmh51jM2N8I9Z9n9iZgkayaVpF+yLbUHjNsllGkZm8Au/Y4GAjyP/lBtQMiHrjNkJHsSSjNHdFV1Xu1o4UOnTDYXtk5A6RZYpav0ZfpgTrpo8ZYbl8hIaFe/3lUg5Fk7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061601; c=relaxed/simple;
	bh=6QgW0tXIeXarBX2glLQkgrkOJ0O3a8xBN56DcAT+M0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ta/4iwz4jGmfQcixOaBBoDjtprmznnUOCo8+6g7GMSAH3uvedY3eoC5bBI+EnTBfda1DEzUl9WG5Q47Aurnswv7ZiWX9NITYKt5F15aKzQuD5SsBJdBDlnVN+XvPSWRX/mz6U5ISP5mkTRX+QaHIkNlRHE/UvhYZY/mJ/jPCCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=Nr9uRSYz; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="Nr9uRSYz"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5398B441BE;
	Fri,  1 Aug 2025 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1754061591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MxN8nS+ehQy94ANHVk5CQkrBKeqfaqOUojv6h/h1bGY=;
	b=Nr9uRSYzXklsC8bvk+Hnpw5Juo91psafyjVqHzdmpnsehEKH0AApOEvO66PTAPwadYL56o
	5L/6YMNImLTGHy9EQivmqw7BQX5ZkG+fVZNQcRJsav+eLeD2VllCa9ZRIBDOf4cxhi2C8Z
	2FxAC9yAsPbCNz/tIboHFBJHlaAbPql5tOARjDfLAc9ARtrgG6qIqpZELnVXN6sr5ffi28
	ndBAfRxFjr0KsFUZpnCLtJt0h+Lj7UIu3INOGc/WKlPqLPZaNp5EIi1lOE/UGdRtF9OP3A
	StJIkPtVH5PS65IS6gdiaAJ+POKSuM1d2eJOdvdz+xWCfWaRu5RtIq00HnVs1Q==
From: Philippe Gerum <rpm@xenomai.org>
To: "Xie, Nick" <nick.xie@festo.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Error during libevl build and runtime settings failed
In-Reply-To: <AM5PR03MB28822B3215D9F909FD7BD0818B26A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	(Nick Xie's message of "Fri, 1 Aug 2025 14:30:24 +0000")
References: <AM5PR03MB2882F5ED2ADBA37FAA9562608B7DA@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882F38E95A99A0760C60D1F8B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<AM5PR03MB2882726DD078E29EB76589518B27A@AM5PR03MB2882.eurprd03.prod.outlook.com>
	<878qk3za1e.fsf@xenomai.org>
	<AM5PR03MB28822B3215D9F909FD7BD0818B26A@AM5PR03MB2882.eurprd03.prod.outlook.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 01 Aug 2025 17:19:50 +0200
Message-ID: <87zfcjxe5l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegtdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpedvlefhvdehkeduheevleegiedtueejgfekhfeijeefvdeijeekgeeigfejhfekgeenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepnhhitghkrdigihgvsehfvghsthhordgtohhm
X-GND-Sasl: rpm@xenomai.org

"Xie, Nick" <nick.xie@festo.com> writes:

> Hi Philippe,
>
> Thank you for your response. My main question is below.
> Runtime settings failed
> nick@nicklinux:~$ sudo latmus -t
> == latmus is now tuning the core timer, period=1000 microseconds (may take a while) irq gravity...latmus: tuning setup failed (irq): Invalid argument nick@nicklinux:~$ sudo /usr/local/libexec/evl/evl-start no EVL core in kernel.
>
> Does it mean my installation and build is not complete? How can I check whether my xenomai is running correctly? 
>

Again, please upgrade to libevl 0.54, you are running 0.51 which had the
issues you reported. Those issues have been fixed since then.
e.g. In r53, "39e12fb latmus: fix tuning mode set up"

As a rule of thumb, you want to use the latest release, always.

Once 0.54 is set up, running "evl test" without error is enough to
determine whether your installation is ok. The scheduler-related tests
which failed in your previous setup did so because some kernel options
were turned off, as I explained earlier. So either you turn them on, or
you ignore the failure reports for them (i.e. "evl test -k" would keep
going even if those test fail for the above-mentioned reason).

-- 
Philippe.

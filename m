Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9FA359A65
	for <xenomai@lists.linux.dev>; Wed, 27 May 2026 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863870; cv=none; b=OfTFAp6295We1J/zJowxGv9MAzJlq2H0dHyzjulHtOg5kMpSBVt29H7vwrw2rSupT7RMaXssDceYffzX+KhQygvA4Il+zNYX23xtEffcXF6V0LY1iyKsUPNXKvcVJ+Fg292eldjWLCoDKVyiyHRyhyf+AJ2marslvI4Gx8D7OKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863870; c=relaxed/simple;
	bh=7L95BtHY9079xsrQ0H9nCukXsEb386XAK6qlj2ji8Go=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vA3D6R6Lbj0ydMvC+MNQnWuiR2KSFUJFGFfEUAKXWe8CKXSnX7laNe1alf8iHA23pY8pm8retP+Q34s3zITT8RNZibltqftK/8HiiWssqaVfly77erKNAWqN19x+0ZN8dPgktAR6fwVCMJgtuD62dnURuAuxa/8Mf6AV67mSeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=WzmEeAoS; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="WzmEeAoS"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4F3D2066D;
	Wed, 27 May 2026 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779863864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TbVTEeFk716sAEFwxfK+B9YkfWpDppwQ1EyFOZIhsY4=;
	b=WzmEeAoSI5iyMvnF6Nt2SLS1PwZ7/wLk2NjuxPKDpUjEytaAAxr3VOTjaEQzi8r/RuZg7x
	b7VFEYcf0gfbjrKNc5euq0UHjRvLOkST4nXKITJB6Qw249r39q+rNHRP6G2ExkTJkoCUKg
	+zgsLij0a1SR3WZiANufGbTJ3AN18q5Bx05ESwrnhTnfkVK9h1HxYP2O2NAxbGabp/Jx4Z
	ddJloy22rAGCkB69Nx4TBNSKFxXmWwAYGFpmGDauqImmoBKTtpt7Q60bl4/jnjjyPq/Tdh
	JJT2UaJ8eiqd6HDkeL6guySXF7t6EMCpIrJG6qgHJ3syq8ZhSL+LbxWaigAdqg==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH 0/1] fix error handling in client
In-Reply-To: <20260526182923.4576-1-hannes.diethelm@gmail.com> (Hannes
	Diethelm's message of "Tue, 26 May 2026 20:29:22 +0200")
References: <20260526182923.4576-1-hannes.diethelm@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Wed, 27 May 2026 08:37:43 +0200
Message-ID: <871pexici0.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFPW5I3OGiAa3LEvhtj2iJUjlWzmy3zvTiXG5LGROJr4TUxQeBQUwLUoS/vBHwQASjCLEFwYGS/A0/dJq/QcmxzXGX87AJs2N++KQK4PZ6oInGfNXYC6wTjcbleByFihXjsyCwIpHQCtJYxUNvjPgc+tEkqSHFsMPGux42I2eAdEpa4m7JV3+hhLQItLuGwmya4nRqwhz5WL/vNjOvQXPEdzvbwI4EELtAXSZosOKMNpEH5a6xDjRvtH5EmGe8SJrjA4nSQtcQH+1kOGvbUv7HXS+auZ9n+m7fGd36c3ntkRd6ZN6DDwvNpYLvcTV8cc/Hnlk9EHjvgxKibVhiHOlAolIrQsGfZll2FNWAt4+734nJSybeWcJVDgDq4r0cZ2axjRVJTdLvkGYuDMQ2sxyaUT9Sd5OfyEHm1imyYaMTfKsNm64qn8PX+KsWMfYqmQjP8YrZcqDgcyjYVOuR+xux9mre1ng2qsy0hnyJQxtlfrZjTn6y1GFjtmTVQc02ilDvzkKVbrl0LnP2RB7fFMHLm5DypZTfxQ7FbMd90qs3R704SeilCdU3S4K2Q2929dB6VTjcsfeZ3gzGWwb0WYHhB5B/xj3cjLNgTXoAbNJYuZNYllrCJUVVj4wBSy/u1kxWZmfguco6D4hOxyA8RBBexS2MZRV4RKy4m1ccSQDqTbg

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Hello
>
> While writing the doc, I found a mistake in the last patch. If desired, I can also resend the
> last patch with this fixes in one patch.

No need for this, thanks. Merged upstream.

-- 
Philippe.

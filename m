Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF6814A4D0
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464005; cv=none; b=TV0SjZkyIPjoqXcWse+PThw62JvV6UyW71XTbrmmJAhUGQcaNqhovuPeyBzakRJ4A6wbqO7ot4eETl0Luh430iln3qd0mi97DYa19aEUQnUEAgWhdLxyiggxVmLd7koWJUUASkKAepxdkQwheQTUD9C7oGKwO2WFU8zveO9ET7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464005; c=relaxed/simple;
	bh=tcr5SI3OGOLduM6aHCq9jUgLZN3oYD4MxYrwNvMQp0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsvpqLxDiPOOetup22pR4JL0Y2jN2pn85Y4bLAolQTpMfhzTQFrJFzQSmAyVZWBMPXv7POpQNWfjz3kai8gJoW4H6TAXDFpYpOEucO8NhKs0YlAqfG8G71ld2Q0eSsoNWbwETYV5zXB8SddISxaxlaZyNNViUy0/bDxB0aXk0eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NI8/hjM8; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NI8/hjM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=tcr5SI3OGOLduM6aHCq9jUgLZN3oYD4MxYrwNvMQp0E=;
	b=NI8/hjM88CIUp+sX/jqeUeQ1LJRf6XuAHLwt9t7/2loMZdO+tvXnRZBHU9/yrz
	MAUTzxB6Nj03SoQ+Hx6XbkHySql6fChDqAbR/IQin3ho1Q9Y+RychwQ835msXklg
	RMbq/aJAMLAgs/7bSzfS3khsYdjXjS/wK+RDDehC2V9HA=
Received: from localhost (unknown [106.39.130.120])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wDXvwR4KU9mLBWRFg--.27773S2;
	Thu, 23 May 2024 19:33:13 +0800 (CST)
Date: Thu, 23 May 2024 11:33:12 +0000
From: JiajunDu <wonderboy512@163.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: 87ed9urpex.fsf@xenomai.org, xenomai@lists.linux.dev
Subject: Re: A problem regarding SMP
Message-ID: <Zk8peHJbgRay+Ya/@2956c958a175>
References: <Zk68Q+2tgdwEkcS9@2956c958a175>
 <87r0dtrmbe.fsf@xenomai.org>
 <87msohrm1a.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msohrm1a.fsf@xenomai.org>
X-CM-TRANSID:_____wDXvwR4KU9mLBWRFg--.27773S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRqtCwUUUUU
X-CM-SenderInfo: xzrqvv5uer5kirs6il2tof0z/xtbBFR7nG2XAlkHsZgAAsP

Ok, thanks for your reply. Now I understand.

Best regards,
Jiajun


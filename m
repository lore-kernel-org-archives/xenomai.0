Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2F2EDD59
	for <xenomai@lists.linux.dev>; Thu, 21 Aug 2025 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.158.66.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788209; cv=none; b=aSvHGr6vkovgyTHfthXzPq0omO61uVUqFt8worM+Nj9Z1NOPjr7PpFgN+4zibVt2Sg8WCFjydEX9urhzClJ9AM5Smo/pqLeWfVKQ0BLS0h5zCZ835Afg0XBUqwXlG1hjHMpB73lnSDrWmxw2d+aYO3epObvSQ2eX4vKcBWIOljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788209; c=relaxed/simple;
	bh=P8PeSpkzV0aD5ZP6tdP/vp2rjTTw8lzMvMIZYmS8svI=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=H9PXZy9lRgiHQQED92FAW9nNmCwvA176nWybwgwk9OiK3EGSFjEQqCl31jLevC7jt4l0WkeuqHLRd7NRfcUYCQoRVz1zpfaAqSysj1tCYCHRmE65FqWVpV/cMaPcsbdC4QWvOERuiZAkQ0SFS2bCkFPSrVXeUAH/Y+HF4BsEQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr; spf=pass smtp.mailfrom=lapp.in2p3.fr; arc=none smtp.client-ip=134.158.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lapp.in2p3.fr
Received: from [134.158.99.46] (lappc-p898.in2p3.fr [134.158.99.46])
	(authenticated bits=0)
	by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 57LEugiV028041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <xenomai@lists.linux.dev>; Thu, 21 Aug 2025 16:56:43 +0200
Message-ID: <a597e0a51e4adb69e3ff9041f83a67d588c861e6.camel@lapp.in2p3.fr>
Subject: xenomai4 - running applications as regular user
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
To: xenomai <xenomai@lists.linux.dev>
Date: Thu, 21 Aug 2025 16:56:43 +0200
Content-Type: text/markdown; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi,

What is the recommended way to run out of band applications as regular user=
 using xenomai4 ?

In xenomai3 documentation, there is a dedicated page about this, <https://v=
3.xenomai.org/tips/regular-user/>, but I did not find similar instructions =
in xenomai4 version.

Emmanuel.

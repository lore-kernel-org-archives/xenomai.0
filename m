Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AB316B75B
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176509; cv=none; b=VypDSO5un6elsbSAR0GjyBLE94Gfo584tYpu8xxO0dq1ZDIAngyku1fEFBiq7Y+0VmFtWQ/q1Jj/1B418HGIFjLStDW8x7z6L5LVVw6lH5P3hUNBBBQC7Ex2/9LlMiRGgcQKF9txX1DX5JhrVWfFgWYF28wcj834WZFr25Kqa8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176509; c=relaxed/simple;
	bh=TO6Wv5BMEp7MdbmpnnAeouljsWmK3ja5soccQg5df4U=;
	h=From:To:MIME-Version:Date:Subject:Message-ID:Content-Type; b=YWI8qdW7IpbCWSTUOB06glbggASoHYAFQsKqFNGK1FdisucLUZ+b4GyhrKzqzl3G2DhSyfmG81BDYwV72r4onkkV7OviyeRqnnL3hkjJI6Irl0IKeNrJuRT+wW9XQqUl/LBS6J0grQdWN+gHJG1syCyhvkOKZvQpB+VGOst8Vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=ErcCZ7Te; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="ErcCZ7Te"
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 4BDC28392CF
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 09:07:55 +0200 (CEST)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 5A99860149
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 09:07:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 45C77kLM399065
	for <xenomai@lists.linux.dev>; Wed, 12 Jun 2024 09:07:46 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1718176066;
	bh=TO6Wv5BMEp7MdbmpnnAeouljsWmK3ja5soccQg5df4U=;
	h=From:To:Date:Subject;
	b=ErcCZ7TePBVOsw+5H7FKXVQj0OnHtq0gfHxiSEw+l62lZDXvHryPprUijhm0FtTUD
	 quMq0g1klzmAvh/XqewJzQ43VwNQVyVpHCYqpGhnnr6TjKGKvYrOr+yq7xaUbtuWKH
	 QyoJPIWaqI8olZpWprC6TtchjjLBRsI1g7Lvd/J4jWy0iabUmtfsVzdtEg/F1gqtbQ
	 u7y7YZr8jcNqx+F1Fy8lU6QbOgP5qvCD1BMUZtSzG5T8vc4VfP13x3l17v08eoKIXW
	 HhjFSfgNcByhxysujU3cDlJ6FE9sQ3u2/90dbXiMRFT7tqculIbu89DiFwii4A2WrB
	 86hBH+WwqyUSw==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
To: xenomai@lists.linux.dev
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 12 Jun 2024 09:07:46 +0200
Subject: Porting RT net driver to dovetail
Message-ID: <1158-66694980-9-2e725200@6131738>
X-Forward: 217.109.173.233, 147.161.182.115
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Hello list,

could anybody point me to some example NIC driver for dovetail. I'm sta=
rting to transition from ipipe/rtdm to dovetail.

Thanks in advance

Fran=C3=A7ois


Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424E13632B
	for <xenomai@lists.linux.dev>; Thu, 26 Sep 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361402; cv=none; b=H+SRMe6mFv7OvSVbPHHXBvXKzA6omYj30D54lViZki4xQdfXmZnlcimmdvwomsYur1QgyMW1v9xKwGiEm+oUWC6FzaaZ17dyyKqfcskVFjxwIDsJ49WeMHZQ5bU5hBoLDudqVX7FRdaMvvaLV29DDEGb+CDU+1U7vpfuZHMr5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361402; c=relaxed/simple;
	bh=woWVVH3sdQXsxRqg/3Ww21EoI2mdmC+kR2XkgisJcCg=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=c9RroE8IvSBSRk2z15etSZb6D8y0YJAs9mMUwW2Uh/JSmM26VmLT9lZKJizT9nzLCZb/42YIJYxhusfCISxgCyVJLJArFyEkKVKPtqKvdt2oYRLeouc6lFZYnKKG/T7yOqWVDGMn93i1MnqYZK83XR9PWjiRlwIV1cWnssN4cOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=yIurCuDN; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="yIurCuDN"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 3892C5FF95;
	Thu, 26 Sep 2024 16:36:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 48QEaZhO254550;
	Thu, 26 Sep 2024 16:36:35 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1727361395;
	bh=woWVVH3sdQXsxRqg/3Ww21EoI2mdmC+kR2XkgisJcCg=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=yIurCuDNrgTk4ft31zV117kAM5XNinO6P7tr3YAtMCkwe1e1KyqXXjjK87e1pLyWO
	 ilUqG4ujny34KqTnq5RdFtuTN/okqBK6e8ts2s2xHuwvGmk9rgOHccG1q4Ywmnv54j
	 AQ5IiTv+uu7C2Eua3qnnb3u+VTNQx1MYchwrSKqQMmo2gV+xjkTeS7zcewz8ATrxZT
	 PInE4VnF44Vf6W1E7LJXj2jxldJqyOG/JFgEEvRm3YbGfJd7SgvUGSICW6YBL5ekjj
	 jcRIgzI+3b7i+Nu8shlw4YsnTJTKo1S9PgTeQBR5M8YOXsV2vFP3HPcv1t+1VXLT4Z
	 8GhTWTFS70zYQ==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <a993c124-6d31-4507-a942-f6df2e1f0920@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 147.161.180.114
Date: Thu, 26 Sep 2024 16:36:35 +0200
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <10db-66f57180-d-49b09a80@50985157>
Subject: =?utf-8?q?Re=3A?= Get wallclock time from rtdm driver
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Le Jeudi, Septembre 26, 2024 15:44 CEST, Jan Kiszka <jan.kiszka@siemens=
.com> a =C3=A9crit: 
 
> On 26.09.24 14:24, Fran=C3=A7ois Legal wrote:
> > Le Jeudi, Septembre 26, 2024 12:51 CEST, Jan Kiszka <jan.kiszka@sie=
mens.com> a =C3=A9crit: 
> >  
> >> On 26.09.24 12:03, Fran=C3=A7ois Legal wrote:
> >>> Hello,
> >>>
> >>> in my driver, I need to get the current wallclock value. I tried =
rtdm=5Fclock=5Fread, but this seems to be the boot clock and not the wa=
llclock (the one that is updated by ntp/...)
> >>>
> >>> What shall I use to get the actual wallclock value from my rt dri=
vers (the equivalent from clock=5Fgettime (CLOCK=5FHOST=5FREALTIME)) ?
> >>>
> >>
> >> rtdm=5Fclock=5Fread should give you CLOCK=5FREALIME, rtdm=5Fclock=5F=
read=5Fmonotonic
> >> CLOCK=5FMONOTONIC. Which version are we talking about here? And wh=
ich kernel?
> >>
> > 
> > I'm talking about rtdm=5Fclock=5Fread. What I get from that is abou=
t the number of elasped seconds since system startup. Not the time corr=
ected from RTC or NTP.
> > 
> > I'm on linux 5.4 Ipipe.
> 
> Then you need to compare to Xenomai's real-time clock, not that of th=
e
> system. They were decoupled with I-pipe.

I'm not sure I understand. How shall I compare what with what ?

Fran=C3=A7ois
> 
> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
>


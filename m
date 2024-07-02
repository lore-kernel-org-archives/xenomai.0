Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D561BD005
	for <xenomai@lists.linux.dev>; Tue,  2 Jul 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936798; cv=none; b=LD26WoDb5mFIp2Uuc38PKwSA0NZ5LuQTDQXXxHL8VSaYIp6rMQRSUHrbZRntXq55K81C9yXRTKzY5/xL7f10NwFGI9dZXM4yK/xtYgwp0hFzYKFXtOoPnzHuEh/GJiGmqqeAFW8zn2YIMgWD/c20B4adGE1fs0WOoydc1Mm7hrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936798; c=relaxed/simple;
	bh=oFocqEeeb3thW1+iN3EzgJ+HczdTg6DwQFbf3E1xTHI=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=UU8NV9vkmAbtYirIIKI7oWAYhTOnG8kE1WJ/aexRMA01vCzFec4JGmfrnU/Oxq2C/0tXGphRhKFVQJWG1i6UrNPHjP8eYkXI5JMt7LlZie1pvRbwLcD+6fHFuvz6tyVy+NE0mX4nIzziFgG/CeOdFdsFB+dUwgDlkHlVCDovEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=ZZjOCBId; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="ZZjOCBId"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id DB8BE5FF3F;
	Tue,  2 Jul 2024 18:13:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 462GD1Mo202174;
	Tue, 2 Jul 2024 18:13:01 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1719936782;
	bh=oFocqEeeb3thW1+iN3EzgJ+HczdTg6DwQFbf3E1xTHI=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=ZZjOCBIdaAzSgTX3OloeBodfGF1VJcePfrb2oy+Lv9PU1fuyY2nN/4joyYfPwcPgK
	 uFd1IHPoGv4yyqOXps1juJigAvVnGSxDflypJpOe78KEKKx8/T0sHXBKHFRpA2Qil4
	 25YuNykl7grc2NQ1w6GkQDIKBBxrcYaDPFbZ+X5Je8tg6W23ZwiwZ822LzuEQtTWvd
	 CKk4rNLhapFxXH3AecLSjHXhp3VUniMw+xK2BoXRsU+yut54ZK6wzUhfqN0J5K+UIQ
	 5sr+0x0ubCBSYKdQIgSd8wCw4JwEsfI1kMIL5iQuE16zycaqyi4pVya+97ERylDoEv
	 1JwQEiqKoUC/Q==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <234d7440-99ab-4ba8-bc17-7fff64e960c6@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 165.225.204.99
Date: Tue, 02 Jul 2024 18:13:01 +0200
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <10fa-66842700-9-4b3ab100@82480538>
Subject: =?utf-8?q?Re=3A?= Thread safety of cobalt syslog/syslogv call
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Le Mardi, Juillet 02, 2024 14:50 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 01.07.24 09:39, Fran=C3=A7ois Legal wrote:
> > Le Lundi, Juillet 01, 2024 09:24 CEST, Jan Kiszka <jan.kiszka@sieme=
ns.com> a =C3=A9crit: 
> >  
> >> On 01.07.24 08:47, Fran=C3=A7ois Legal wrote:
> >>> Hello,
> >>>
> >>> I was wondering whether or not the syslog/vsyslog calls in cobalt=
 runtime libs are thread safe. I observer strange behaviour in my logs =
under heavy log load.
> >>>
> >>
> >> Can you be more precise in what you do? And which parts of
> >> lib/cobalt/printf.c you consider problematic /wrt thread safety, t=
he
> >> printout to syslog or the wrapper functions themselves?
> >>
> >> Jan
> >>
> > 
> > I have a set of threads that would each send to syslof under certai=
n conditions. In my syslog, I can see a bunch of truncated log entries.=
 I'd first though that maybe RT=5FPRINT=5FDEFAULT=5FBUFFER & RT=5FPRINT=
=5FDEFAULT=5FBUFFERS=5FCOUNT would be too small in my application, but =
increasing those values did not make any differences.
> > I ended up looking at the code and got to vprint=5Fto=5Fbuffer that=
 should be called when I want to send an entry to syslog in my RT threa=
ds, and was wondering (I believe it is not) whether or not this functio=
n was thread safe.
> > Am I getting something wrong ?
> 
> You application is supposed to call rt=5Fsyslog (& Co.) or regular sy=
slog
> when wrapped to map that on the RT version (analogously to other coba=
lt
> services). Internally, those are mapped on vprint=5Fto=5Fbuffer, true=
, and
> that is supposed to be thread-safe - it operates on per-thread data
> structures and lock-free in a single-producer/single-consumer
> relationship with the printer thread.
> 

Thanks for the clarification. I misread the pthread=5Fgetspecific manua=
l !
So if I understand correctly, my truncated log problem should only be a=
 matter of how large the vprint=5Fto=5Fbuffer buffer is, as my non RT l=
og never seem to get truncated.
I'll take a look into that.
This code is built in libcobalt, so that the only piece I need to rebui=
ld to enlarge these buffers ? Correct ?

Thanks

Fran=C3=A7ois

> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
>


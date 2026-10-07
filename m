Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C406411FA6
	for <xenomai@lists.linux.dev>; Wed,  7 Oct 2026 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358606; cv=none; b=s8w2FAnqXDAaQlyCl6llwkP94LHAM7AfHPoALTE+tZ5kznCxUIXGAiYdF9/YgkSjz6GGabRn9yPhFnGyy+4VlHqSsFFVCsc3Da3HMWdrfwH633KZUR/d7O/HHZ7N2jMHPojR/FlmVOkB/96owSsMWA7COB3bjoINyd4/2AvMJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358606; c=relaxed/simple;
	bh=nnbHa3bW+IMX+oMrHXwPYzZyneeHruUxHCff0Hp8gXM=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=q1TqT3LVbmDG0ENHwRvI1TN5gKOjeqAPEf9hOicRAIumwc/EW1/2CzjmtqmZxkRKyPP5t2G0Ty78tJfZ2S/etJAjsJoqE8tDnJM9/LGLJUL1pi+qJf8IFgHmshL8bDX1KUELxvBei7Gj/YBrXhGcQbOD40phOG3Qc5bCGtG92P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr; spf=pass smtp.mailfrom=eventlab.fr; dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b=cVkRrIRQ; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eventlab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=eventlab.fr header.i=@eventlab.fr header.b="cVkRrIRQ"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp6-g21.free.fr (Postfix) with ESMTPS id AA141780383;
	Wed,  7 Oct 2026 09:36:33 +0200 (CEST)
Authentication-Results: smtp6-g21.free.fr;
	dkim=permerror header.d=eventlab.fr header.i=@eventlab.fr header.a=ed25519-sha256 header.s=default header.b=cVkRrIRQ;
	dkim-atps=neutral
Received: from localhost ([127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 6977aVs3434376;
	Wed, 7 Oct 2026 09:36:32 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=eventlab.fr;
	s=default; t=1791358592;
	bh=nnbHa3bW+IMX+oMrHXwPYzZyneeHruUxHCff0Hp8gXM=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=cVkRrIRQuOm+hoU5t5uUkissG7XUG1r/HKYsRm3MsTmNbGf9gwKlnN3AkDylLx/w9
	 3mV7qRpJr8WFLyYANNth9nD5Sn70ARojB58gGYLaYxOnlthjngCT0m4tyIFo+yz+sV
	 d0MhCUUcNXMfc5eLB2E+0H6OPYRZOk01pZ7hGsqDipph08tW1YmdNQuAHCnAJtEZy7
	 qCozDNd03IiK29IEn6BEcHqpMxHjfohQPPHdizuAfs3Vtm0nS8gXA1jV1mo99xXWb1
	 7bk9gCCBLAyd+IPw1hYk/CCLPsoATIxQR4nav4LDeALYWPvHelhFV8sY9cus1krZQ9
	 DZbWLNG2MmsLQ==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@eventlab.fr>
In-Reply-To: <2417db8d2c58bfe4df77802f7d6883e45af7e6b4.camel@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 194.9.103.72
Date: Wed, 07 Oct 2026 09:36:31 +0200
Cc: xenomai@lists.linux.dev
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1207-6ac5f680-31-3e404bc0@80343394>
Subject: =?utf-8?q?Re=3A?= Issue using recvmsg
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at tls-srv-02
X-Virus-Status: Clean

Le Mardi, Octobre 06, 2026 23:41 CEST, Florian Bezdeka <florian.bezdeka=
@siemens.com> a =C3=A9crit: 
 
> On Tue, 2026-10-06 at 09:09 +0200, Fran=C3=A7ois Legal wrote:
> > Hello,
> > 
> > still porting my system from Xenomai 3.2 + linux 5.4 Ipipe to Xenom=
ai 3.3 + linux 6.12 dovetail, I'm having what looks like a weird build =
issue :
> > I'm using the recvmsg call to get network message + ancillary data.=
 On my new system, it returns -1 + errno set to 88 (ENOTSOCK). So I dug=
 a little, and it happens that recvmsg64 gets called, which does not se=
em to be wrapped by libcobalt to xenomai SC.
> > 
> > The fix for this is decorating the recvmsg call with a =5F=5FRT() o=
r =5F=5FCOBALT() macro
> > 
> > Is it expected ?
> 
> Not sure yet. Probably not.
> 
> Can you please elaborate which (g)libc version is being used and for
> full transparency write down the code from your application and the
> necessary prototypes from your standard libc library.
> 
> The wrappers in place are matching glibc, where the 64 bit variant of=

> recvmsg() is named =5F=5Frecvmsg64.
> 
> 
> Note: There is a conference week going on. Expect some delays. I will=

> try to come back to that topic.

Do you need the complete code of the app ?

My glibc version is 2.35.

It looks like a preprocessor issue, or a build system issue.
By looking at the preprocessed file, I found these lines :

# 178 "/opt/sdk=5Frecorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/us=
r/include/sys/socket.h" 3 4
extern ssize=5Ft sendmsg (int =5F=5Ffd, const struct msghdr *=5F=5Fmess=
age, int =5F=5Fflags) =5F=5Fasm=5F=5F ("" "=5F=5Fsendmsg64")

# 219 "/opt/sdk=5Frecorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/us=
r/include/sys/socket.h" 3 4
extern ssize=5Ft recvmsg (int =5F=5Ffd, struct msghdr *=5F=5Fmessage, i=
nt =5F=5Fflags) =5F=5Fasm=5F=5F ("" "=5F=5Frecvmsg64")

# 108 "/opt/sdk=5Frecorder/sysroots/cortexa9hf-neon-oe-linux-gnueabi/us=
r/include/sys/select.h" 3 4
extern int select (int =5F=5Fnfds, fd=5Fset *=5F=5Frestrict =5F=5Freadf=
ds, fd=5Fset *=5F=5Frestrict =5F=5Fwritefds, fd=5Fset *=5F=5Frestrict =5F=
=5Fexceptfds, struct timeval *=5F=5Frestrict =5F=5Ftimeout) =5F=5Fasm=5F=
=5F ("" "=5F=5Fselect64")

which comes from :
#ifndef =5F=5FUSE=5FTIME=5FBITS64
extern ssize=5Ft recvmsg (int =5F=5Ffd, struct msghdr *=5F=5Fmessage, i=
nt =5F=5Fflags);
#else
# ifdef =5F=5FREDIRECT
extern ssize=5Ft =5F=5FREDIRECT (recvmsg,
			   (int =5F=5Ffd, struct msghdr *=5F=5Fmessage, int =5F=5Fflags),
			   =5F=5Frecvmsg64);
# else
extern ssize=5Ft =5F=5Frecvmsg64 (int =5F=5Ffd, struct msghdr *=5F=5Fme=
ssage, int =5F=5Fflags);
#  define recvmsg =5F=5Frecvmsg64
# endif
#endif

with =5F=5FREDIRECT being defined in sys/cdefs.h :

 /* =5F=5Fasm=5F=5F ("xyz") is used throughout the headers to rename fu=
nctions
   at the assembly language level.  This is wrapped by the =5F=5FREDIRE=
CT
   macro, in order to support compilers that can do this some other
   way.  When compilers don't support asm-names at all, we have to do
   preprocessor tricks instead (which don't have exactly the right
   semantics, but it's the best we can do).

   Example:
   int =5F=5FREDIRECT(setpgrp, (=5F=5Fpid=5Ft pid, =5F=5Fpid=5Ft pgrp),=
 setpgid); */

#if (defined =5F=5FGNUC=5F=5F && =5F=5FGNUC=5F=5F >=3D 2) || (=5F=5Fcla=
ng=5Fmajor=5F=5F >=3D 4)

# define =5F=5FREDIRECT(name, proto, alias) name proto =5F=5Fasm=5F=5F =
(=5F=5FASMNAME (#alias))
# ifdef =5F=5Fcplusplus
#  define =5F=5FREDIRECT=5FNTH(name, proto, alias) \
     name proto =5F=5FTHROW =5F=5Fasm=5F=5F (=5F=5FASMNAME (#alias))
#  define =5F=5FREDIRECT=5FNTHNL(name, proto, alias) \
     name proto =5F=5FTHROWNL =5F=5Fasm=5F=5F (=5F=5FASMNAME (#alias))
# else
#  define =5F=5FREDIRECT=5FNTH(name, proto, alias) \
     name proto =5F=5Fasm=5F=5F (=5F=5FASMNAME (#alias)) =5F=5FTHROW
#  define =5F=5FREDIRECT=5FNTHNL(name, proto, alias) \
     name proto =5F=5Fasm=5F=5F (=5F=5FASMNAME (#alias)) =5F=5FTHROWNL
# endif
# define =5F=5FASMNAME(cname)  =5F=5FASMNAME2 (=5F=5FUSER=5FLABEL=5FPRE=
FIX=5F=5F, cname)
# define =5F=5FASMNAME2(prefix, cname) =5F=5FSTRING (prefix) cname

Fran=C3=A7ois


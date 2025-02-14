Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED755158D96
	for <xenomai@lists.linux.dev>; Fri, 14 Feb 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521959; cv=none; b=in2g7KXcYUEOTSFY2nLDwBvW8iSpVqDLNAbXxOqr8Wy+Z6X7yUPpRlS97B8GN+mISYMndn7MVkME885bAcgXSRXcwkk5S4us0iTBVMQ3E+HzJyQvrFNNbl29QFlp/lDCdeHhUifWED96ExUM5EF8KhbtYLSSiNPpgORnPDI3/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521959; c=relaxed/simple;
	bh=yJDTbfKcLICRXSxj8yNyYb3IRa/Fp8bhof7BRIOfTI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L4rDScUjcIi+aQt3uWs01MazoMJkb4Fr/8wjwUcjL+nMcsIzP8+F2RbG1fKZj8E3qEHfXykj+1ANB0KCb5RC7MWgPEPM+jEuQWJDFgw9DmkiXg982eM+gyRSZcgGpKVokybwlibP+gCoMVGW0i2O0I8t5/YJ64Q4i4sfuCBJtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=PFnlw9il; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="PFnlw9il"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0DC58442BF;
	Fri, 14 Feb 2025 08:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1739521954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJDTbfKcLICRXSxj8yNyYb3IRa/Fp8bhof7BRIOfTI0=;
	b=PFnlw9ilSzvuzLZeNeA5kt6xowOg49FdPMVh8UcvPDACuxBoc6tH0xZECbogNhZ2X7FHjt
	OAyXAaGmeuMDD1DqotS8wpZzouNR8ZWBFzLkV/UpmENS6NKT6PpSwBUTmvEEhAhXM67hB3
	DgtTV2hco43Nnz8trsudHzX+xUJiqmCjb2W35CuJk315ACXwkEksd0wPEW3GyW4REzRcOC
	FGWDgxyU/KMyigwOcEC4U/LSaB1rzhSdd7CSVkMK1MnrSKeQbOHn/f+SfeB5MnL3NaN99G
	gfHY7Y5TWbUC7NpgNLtIw2FGXrc+GIlA5yNY5Z08AfjXtoDvShhcTbLwi9sk0w==
From: Philippe Gerum <rpm@xenomai.org>
To: KOCIK =?utf-8?Q?R=C3=A9my?= <remy.kocik@esiee.fr>
Cc: xenomai@lists.linux.dev
Subject: Re: [Xenomai 4] Compilation issue
In-Reply-To: <0b3100d7-ba07-4839-88ad-2df1c367d094@esiee.fr> ("KOCIK
 =?utf-8?Q?R=C3=A9my=22's?=
	message of "Fri, 14 Feb 2025 09:11:18 +0100")
References: <0b3100d7-ba07-4839-88ad-2df1c367d094@esiee.fr>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 14 Feb 2025 09:32:27 +0100
Message-ID: <87frkh0vvo.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegledukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeevgedujeehtdehiefhleefffelffeliedtlefglefhudehvddtleejkeetgeehhfenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhgvmhihrdhkohgtihhksegvshhivggvrdhfrh
X-GND-Sasl: rpm@xenomai.org

KOCIK R=C3=A9my <remy.kocik@esiee.fr> writes:

> Hi all,
>
> I am new to xenomai 4.
>
> Following the information given on the xenomai 4 website, I installed
> linux-evl version v6.12.y and libevl version r50 on an Ubuntu 24.04
> LTS.
>
> With the kernel compiled and installed, I've managed to run evl test
> correctly.
>
> I'm now trying to compile and run a very simple program given as an
> example on the site.
>
> I don't know meson very well, so I've tried to compile the program
> with the following command:
>
> gcc -o foo foo.c -I/opt/evl/include -L/opt/evl/lib -levl
>
> I get the following error :
>
> /opt/evl/include/evl/syscall.h:11:10: fatal error: evl/syscall-abi.h:
> Aucun fichier ou dossier de ce nom
> =C2=A0=C2=A0 11 | #include <evl/syscall-abi.h>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~
> compilation terminated.
>
> In the evl include directory we find the following files:
>
> drwxr-xr-x 3 root root=C2=A0 4096 f=C3=A9vr. 12 11:52 .
> drwxr-xr-x 3 root root=C2=A0 4096 f=C3=A9vr. 12 09:42 ..
> -rw-r--r-- 1 root root=C2=A0 1899 sept. 25 09:25 atomic.h
> -rw-r--r-- 1 root root=C2=A0=C2=A0 675 sept. 25 09:25 clock.h
> -rw-r--r-- 1 root root=C2=A0 1117 sept. 25 09:25 compat.h
> -rw-r--r-- 1 root root=C2=A0 2439 sept. 25 09:25 compiler.h
> -rw-r--r-- 1 root root=C2=A0 1782 sept. 25 09:25 event.h
> -rw-r--r-- 1 root root=C2=A0=C2=A0 961 sept. 25 09:25 evl.h
> -rw-r--r-- 1 root root=C2=A0 2413 sept. 25 09:25 flags.h
> -rw-r--r-- 1 root root=C2=A0 4202 sept. 25 09:25 heap.h
> -rw-r--r-- 1 root root=C2=A0 4873 sept. 25 09:25 list.h
> -rw-r--r-- 1 root root=C2=A0 2128 sept. 25 09:25 mutex.h
> drwxr-xr-x 2 root root=C2=A0 4096 f=C3=A9vr. 12 11:52 net
> -rw-r--r-- 1 root root=C2=A0=C2=A0 825 sept. 25 09:25 observable.h
> -rw-r--r-- 1 root root=C2=A0=C2=A0 728 sept. 25 09:25 poll.h
> -rw-r--r-- 1 root root=C2=A0 1043 sept. 25 09:25 proxy.h
> -rw-r--r-- 1 root root 10460 sept. 25 09:25 ring_ptr.h
> -rw-r--r-- 1 root root=C2=A0 1422 sept. 25 09:25 rwlock.h
> -rw-r--r-- 1 root root=C2=A0=C2=A0 630 sept. 25 09:25 sched.h
> -rw-r--r-- 1 root root=C2=A0 1774 sept. 25 09:25 sem.h
> -rw-r--r-- 1 root root=C2=A0=C2=A0 462 sept. 25 09:25 syscall.h
> -rw-r--r-- 1 root root=C2=A0=C2=A0 694 sept. 25 09:25 sys.h
> -rw-r--r-- 1 root root=C2=A0 1311 sept. 25 09:25 thread.h
> -rw-r--r-- 1 root root=C2=A0=C2=A0 465 sept. 25 09:25 timer.h
> -rw-r--r-- 1 root root=C2=A0=C2=A0 560 sept. 25 09:25 xbuf.h
>
>
> There is no syscall-abi.h file.
>
> Is there a problem with my installation? I don't understand why this
> file is not in the directory.
>
> Thanks for your help
>
>
> R=C3=A9my

-I$KERNEL_TREE/include/uapi. Ideally, some installation procedure would
 deploy them to the build system, so that they could be found in e.g.
 /usr/include/evl.

--=20
Philippe.

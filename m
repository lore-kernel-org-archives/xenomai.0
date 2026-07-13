Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F162C40B363
	for <xenomai@lists.linux.dev>; Mon, 13 Jul 2026 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945575; cv=none; b=MuIWO8QjrK2RjA3YDJomPWJcMpqVN+uId/kYuUFzyYSC5K1gjv+NOSJbT22g/yt1eZyoYxJHDnrcwsbCrnS6udsURE9707gLfTuROZr92yMYkVTaMJjiGlrhA3W+C8C975YW9d+i2ZczwPrlyk8bumnlnnGCbbqnfO1ZDnLlzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945575; c=relaxed/simple;
	bh=dYCY9Fe69vp+mkNeu3L+3H6k9jYv4g4q4KjdvJa6hX4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r6vXm5g/qF7Nk2lBlhsOEZTnEcASc6aY2kivsNwf4ZW8N4oYhZyhsot964Vw0M/wyH4JFEwRKgn6wOkF/sdYbPliaqXT0nCbeKaYR20Mr9qKBLw+TUp5XOqK1NOzsrS/MOm+EYK4p9EYc1lVN5tzbACeC1rrfMyg90z778IS248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=VRKl45fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="VRKl45fr"
Received: by mail.gandi.net (Postfix) with ESMTPSA id E438D3EC59;
	Mon, 13 Jul 2026 12:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1783945569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvikaeiIKv/Js9xfMG4hqWpJd1f09I8Nq0WvA3zsU+4=;
	b=VRKl45frHvyuCMDSxG6UK2yXBNGT+YotEV94gwpyK98qCAwMnek+beXdays9XQcKmgqaI+
	cl7UxTyW2Z3xEM8hyckFMrBmvj2Zl//FIvbsoKp3+cudk5PAAMmYMnjkGAT+bTnYQUsiYC
	actH4DDW9+yJuAy2Bit51VZqQNrXDXCJkGtUkvFFBgIrPYgCk1T14jW5DrC4OeaMsvOXLJ
	pKIDWG4VHhW/Sss9oNeAuVKG8E5IGJMmfE5DZYN5PXUmzuVCnhUUo6ExzNOwWmqAJk1lHH
	cV+y32pzOsqNAQgfIy754ODDHOhWqOUbH6Qb17LxKi6JhY5tfU/VHz0mKqT9kQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH libevl v3] build: add initial RISC-V support
In-Reply-To: <20260713103445.34208-1-tobias.schaffner@siemens.com> (Tobias
	Schaffner's message of "Mon, 13 Jul 2026 12:34:45 +0200")
References: <20260713103445.34208-1-tobias.schaffner@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 13 Jul 2026 14:26:08 +0200
Message-ID: <87se5n5b4v.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: dmFkZTFDzTHkKqS59RDPv6fO3HB1/rSr3IUradc6L+zCTc2XTLQL7/prreCmKSwrICxMj3vEM985b9AxL3b205uFGm3n6mYG9/0eEPQiAIcGaN827ChVwVy31G2DZANf0wuOPiMtwoHzvtynHf+qCH5IVq8OGajUBPW03RkNeo4Zx2yrDDx1z0BW7vGjuZ1WsuQAwVt8ILOt+73b8iXWAP4odt3jb4ju2QeTYE0EAKntxM95UrcWzRAlgeFP7jI7iQa2df1pkCVcsBtMw+zQz0VYgm/qYoIgp+uTaatIZA72gfRcyu8Hun2dS+pzEonsiO/sP1mqMyOLx8lO9j4nd653f0QZTcJqXeD6JJMeIyugggR86xDvf5OgRDuk2WrE1IO5geizkYZ3heYD33i3aA10oZ22D/5tVkgdpqGhtzjAjAgyROvvRvZRNKy5hYiOX7VEGgmlR/fsdEawN0EDnmznB65Mo8uzx5/zF9WIT4zlGizpcdaM00L33CNJVDLLi+mu/dmebX1Um06wKeE0RMEb+ZBdgQO42sXWrSACTcawWdEEVcOjtE+rflVvkna7QUsbacl11mMk9Dwxb/uclxLEHk/v9Ft1/KNMe3/KumwR2IqMjLRzIgiXVrEx6DqI8XWkRrP7TZsIB2H5/7oS6Cjp3oSHmmeSD9qn82IIa2j58LKH6w
X-GND-State: clean

Tobias Schaffner <tobias.schaffner@siemens.com> writes:

> Provide the basic build infrastructure required to build libevl on RISC-V.
>
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  meson.build             |  4 ++++
>  meson/riscv64-linux-gnu | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 meson/riscv64-linux-gnu
>
> diff --git a/meson.build b/meson.build
> index 674c661..4acbc40 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -63,6 +63,10 @@ if libevl_arch == 'aarch64'
>      libevl_arch = 'arm64'
>  endif
>  
> +if libevl_arch == 'riscv64'
> +    libevl_arch = 'riscv'
> +endif
> +
>  post_install = find_program('post-install.sh',
>      dirs : libevl_scripts,
>      required : true
> diff --git a/meson/riscv64-linux-gnu b/meson/riscv64-linux-gnu
> new file mode 100644
> index 0000000..33c47e4
> --- /dev/null
> +++ b/meson/riscv64-linux-gnu
> @@ -0,0 +1,17 @@
> +[binaries]
> +c = 'riscv64-linux-gnu-gcc'
> +cpp = 'riscv64-linux-gnu-g++'
> +ar = 'riscv64-linux-gnu-ar'
> +strip = 'riscv64-linux-gnu-strip'
> +pkg-config = 'riscv64-linux-gnu-pkg-config'
> +pcap-config = ''
> +
> +[host_machine]
> +system = 'linux'
> +cpu_family = 'riscv64'
> +cpu = 'riscv64'
> +endian = 'little'
> +
> +[properties]
> +platform = 'generic_riscv64'
> +needs_exe_wrapper = false

Merged, thanks.

-- 
Philippe.

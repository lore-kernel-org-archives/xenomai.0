Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54816393DE4
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 07:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.158.66.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846821; cv=none; b=N85Dy1Yp8fu2UI6lghsGeodYL+kAgUPqVq/GiEzrpxaRup0/JS0F5WlQS5bV/Pt7GWLruh/VM1eTwiuz3ab77VQsIbodATl16mVi6UeKj7GUEUcOgAWOTpBZ3BQsLDOPye/k3RTF/ShAnmzW1tWIjDYJyA5/mPpyLcbf6CoXZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846821; c=relaxed/simple;
	bh=oK5S5hVuCAqFKDLAE+i0X+2ZR/H/R3yjyxGSfN0/X9A=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Sm34Zp2NLMK9aoOy9/VpQzEtm7/WDiXtnKVdVdIvknGi0aC/hq+ZU8Q91IzgLwy3/E1JG4wMDbD5ebmiBJMBRRzD8Fdw8Bjdrzs0XKEVqpqt8Kn+CMbRRQBLPYd/2G0+U1IXJaLt0HuVdcOG+VnAwyPii22t1GIRHd0EkVT+NXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr; spf=pass smtp.mailfrom=lapp.in2p3.fr; arc=none smtp.client-ip=134.158.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lapp.in2p3.fr
Received: from [134.158.99.46] (lappc-p898.in2p3.fr [134.158.99.46])
	(authenticated bits=0)
	by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 57M7DYkc031652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 09:13:34 +0200
Message-ID: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
Subject: Simple Xenomai 4 API use examples and a question
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
To: xenomai <xenomai@lists.linux.dev>
Date: Fri, 22 Aug 2025 09:13:34 +0200
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

I have started to work on a repository which is intended as a collection of=
 very simple (dumb) examples of Xenomai 4 API use. Each example is an appli=
cation, sometimes coupled with a kernel module, with the strict minimum aro=
und the actual API use. Applications and kernel modules are built using mes=
on. The meson files are also kept the their simplest form. That was easy fo=
r the application building, not so for the kernel modules.

The repository is here: <https://gitlab.com/emmanuelpacaud/xenomai-c-exampl=
es>

It is similar to what I did for my own project: <https://github.com/AravisP=
roject/aravis-c-examples>. I do think this sort a simple example collection=
 are useful to understand how to use an API.

It is a work on progress, the code should be more commented.

But to be useful, all the examples should work, and I'm blocking on the oob=
_ioctl example :(

* <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325=
b57565edcd691021255adc486b90/oob-ioctl.c>
* <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325=
b57565edcd691021255adc486b90/modules/oob-ioctl.c>
* <https://gitlab.com/emmanuelpacaud/xenomai-c-examples/-/blob/cd9f849d4325=
b57565edcd691021255adc486b90/modules/oob-ioctl.h>

The ioctl call fails with a `Bad file descriptor` error. What I'm doing wro=
ng ?

Emmanuel.

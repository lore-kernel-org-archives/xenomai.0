Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8A72596
	for <xenomai@lists.linux.dev>; Mon, 27 Mar 2023 22:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679957735; i=jan.kiszka@web.de;
	bh=yWq4blz9UvtcRHG3rPtn3x1Rz7zpecVxM4FZMh6pX6Y=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Cmj7VN7sHS5Wmnb8q+PtRY5GwqaAWAQiCEvtJSerJX6nQHNJlF1WkBAhkI6sdHE+k
	 uJB9vpQUtR/xwravAzehBYkdinkrW3RsHnFVxA7+R0IsHHKLSa4Is8IySFQktLBOZt
	 FD6zHTm30xJRb6RgklpiN6ttEIWRP/y1AeupBGCZ6djiv+JMnMnbrxEK76fXHqAC4+
	 GU0Peh/j9rhFKZXoM1vnxsrrjMNBM9TcdVKcPl32rYlv1mhSfX7SGWEyG2glAL4XXG
	 914XPDXSKQAx7/DvvRvSL8T9AjkzxyGQ6jj4SSO2ljn5LKBFZ7HXAGNWKFMv4VhPxh
	 q6+pO3W7FtUMQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.20] ([94.217.148.24]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPvg-1qafQv1634-00ux4G; Tue, 28
 Mar 2023 00:55:35 +0200
Message-ID: <aeb950f3-558a-f704-dcf0-7e6ffc1c7283@web.de>
Date: Tue, 28 Mar 2023 00:55:34 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] debian/control: Fix missing dependency to gdb
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230327105542.1320510-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@web.de>
In-Reply-To: <20230327105542.1320510-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7r8jhHrk56FraDIN7mqn0B15EjH6xjpHeAHT1P8YYDG1qIRI40y
 wX6MhoZ4t9Zok3C4YT4iruc29CzrYFhfXgQqJeJbZPPPyxaFyNv7Xd9iP5Tf30T6SB3ewPl
 Pz76xPzROyzEY2IlMMoRtm/L555EJ/doUbDRnxpgTqFWXE9sBuNuBIfjlMHJfQfl3g1gDFt
 37loo4JytRifhj2snHY0Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q9XSX8KQgzU=;J4d6LLF9CWLnX+XLeEj7S+b0Kd3
 2SBR1KOJ3e1MRlOwOEb/v62UGPx60QDhKY8ZYQ7Y4mqibfAkkgQQWgvH+c/ro0ppPrlfGBJXX
 eIT0KhIGVt0VtqzADcf/C3mmWWbjNq1I3kdoJQqN7yiLtPZ45XF8OsH+Nrn5GOzpJZPi+nZxk
 4v+KfiQgjdy+kJaUvEt96nViYdJxbISbiuNKliy77ycCfDQmcu1hzp2VUgMi5UQLsNqRTskT+
 BVGsl6b32j12zGbHbW/mwnxuvyJJeiBhmCGAgsJqbg8c8diijPwmqSN6cbhymYYVeC3+ZThyP
 /Y5qaViOB9JY2xBA4S96r2jZb7hYQ5U2lWz/uGmxo+CkVX5YyExXb0ICat31Q0A3MZyNRNl4T
 ivbD1KTKlfe1XdOA+u837dIQKY/3hguZrV6SZ/N8nsjfqd9ZevTQViKiOk8Ej19rqDEuvHegQ
 80TvZPqJ6VVeH954pfGZa/ADvEMjLuAaThpV+Ltcd6ZjnntRBDSPgvMDIdohocV+fQJ9ESxJm
 UkVbt9vuPZ77MFw7yKieL/uDh3I23ej2lSRljcNAlNixJJDnl8uS4TWh0NvUFWGH2CYCb6mwv
 58L/LbM8cm1fvrGgORIRUTzxiv3aLzwpTHfQDck5fadKnyIkIpNTnkVJ9ub3Nut5xqOTM2ufs
 oglEWPW/7vgha2DLYOYUrr4MfsMaMtVvbgc//89UQ/EtYw7EA1/pNmRMQKfjBQW42T5c1B9Db
 0/b8NaHVEnCeB9utMBl7LVoA8i1gDSRB6I9bBlnV8nPsasIGUVg5KCjnPY9l/I/o6gtUFsDGF
 FzbZ+cnnnWtVYRByPxoh0DSd75AnYQk4q2SUTBhsKnvTkZxd+BhK93vPjwna4cH9O8rSVZjrd
 24mVOab7hsKGsWnF0x4/+OQCZB/mVacm0Pgu+VVPtRqGqP51NukgTDB9kYVnfzZJ3eKjHxGue
 mczrVS01phxEP5adjjBA7sEjywQ=

On 27.03.23 12:55, Florian Bezdeka wrote:
> The xenomai testusite - part of the xenomai-runtime package - needs the
> gdb binary for testing the gdb support. The dependency was missing so
> running the testsuite on a fresh Debian system failed.
>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>
> Backports to all the stable branches will follow.
>
>
>  debian/control | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/debian/control b/debian/control
> index 857d8ff8f..aba59949c 100644
> --- a/debian/control
> +++ b/debian/control
> @@ -9,7 +9,7 @@ Homepage: http://www.xenomai.org/
>  Package: xenomai-runtime
>  Section: devel
>  Architecture: amd64 arm armeb armel armhf arm64 i386
> -Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat
> +Depends: ${shlibs:Depends}, ${misc:Depends}, psmisc, netcat, gdb
>  Suggests: xenomai-kernel-source
>  Replaces: xenomai
>  Conflicts: xenomai

Looks like xenomai-images installed that "manually". Can be dropped once
this fix is in all stable releases.

Eventually, we should split off a testsuite package to allow installing
tools without pulling all those deps of the former...

Jan

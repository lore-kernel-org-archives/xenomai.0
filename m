Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8B1CF83
	for <xenomai@lists.linux.dev>; Thu, 25 Jan 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175842; cv=none; b=fYytyVqntj75I1I9lD7m4oRrNw/V8FclRjM/6JeNagLaqXGFb4owIz4Os5+NDnuUVMDz8f41kVV4D2Bl7Evi68s1fjzTrs/mZwTFG4SvYVCAzmxaX950zqFDD1SezuONLAuV7ptFXqvzd1fEo8whyLqHtXymcXcQy65W6D/XHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175842; c=relaxed/simple;
	bh=LdexRAWgP5ncvXbtJMEHIz/2YhIAGNbolJFAeD8ajD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=T9rz+Sa7COgCEFrEAEQ0EuYAy/yfDbhvrBdxfHoaXZFdptmm5yNuvUEih6pbTp5W1cqIpKhiwJb96hFyU+itcCek4+B//iEIW7TtQ2r4fGIBqQcVitScZBGWbTTpjnJZVj1byIrFwXze0xQdZtlQ2Bd2f+ZxkK5d5sHO1azJODE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b=iKRqchCX; arc=none smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.kiszka@web.de header.b="iKRqchCX"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id 65AEE240008;
	Thu, 25 Jan 2024 09:43:57 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 6E238740032;
	Thu, 25 Jan 2024 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706175832; x=1706780632; i=jan.kiszka@web.de;
	bh=LdexRAWgP5ncvXbtJMEHIz/2YhIAGNbolJFAeD8ajD4=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:Cc:
	 In-Reply-To;
	b=iKRqchCXVP2/zE2y5kmCph0nQeX/btVacW68ijrL8PouQ7bB4q5eQWholZsz3wgr
	 u/IlfMZUBOnF5WA0r36cLD57y6DheigwMGUvUh1VT0dYU2CQaohd29gpJSGlTBEi9
	 L8OL2a8yp26HBqpeXIFzWHnmyLQuweQZNW8w2AnQDwnjPmyzX1d424iMgec5cMZkH
	 2namAXoTUjHjWLFyhn1TVjJYN0DF1W2GI5o8I9qhv0NSLpZPNOP1RMqucNv2TYCy4
	 pBg7cMNVht8zWsC2Xla6Fqb8axD/lgrTRAqPaYwEf3AM4W0j7xWbHhx0XKw3+WNWu
	 imQ+/mk9EVJEWwcYDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.10.10] ([46.128.89.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2Phi-1rVg621ZdO-003uaC; Thu, 25
 Jan 2024 10:43:52 +0100
Message-ID: <d799980b-fbfc-467b-87b7-5a4fbc6ddf50@web.de>
Date: Thu, 25 Jan 2024 10:43:51 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: calling __get_cpu_fpsimd_context twice in a row when
 kernel_neon_begin running
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
References: <867aed54-563a-4c06-b750-4a7727e6e4c0@163.com>
 <103fdf7d-d3c8-45a9-b25d-283c9af400eb@siemens.com>
 <77c3e1fd-dab9-4b7c-b4f7-67c38dfc37bc@siemens.com>
 <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
From: Jan Kiszka <jan.kiszka@web.de>
Cc: linz <powertree@163.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Autocrypt: addr=jan.kiszka@web.de; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYAQTEQIAIAUCSrSLxAIbIwYLCQgHAwIEFQIIAwQWAgMB
 Ah4BAheAAAoJEIrUrG965ecUhIMAnR6DDCW5cx+cVdYhydbhQXqeief6AJ4p+z4+nrmZLdfU
 7V6nKqKeHeTtj87BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepKvIfi
 M8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+bgvM
 OsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hnclsZ/IY
 hXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVORTOtz
 FK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5gz88
 SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI3KCT
 67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdIvttw
 zG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPxbRea
 9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zpq61t
 oNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+NK8JJ
 BBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wHAJ46
 S16yab+OxNkvOeoOEX0EnHVHaA==
In-Reply-To: <79e83ee2-7406-43c1-9a71-e79cb2cbd127@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:82qVQEjjaTjTxvvfdti8Pe0v5oqCciVzqBD4fXOXZQJftbhAkQc
 Qkvy7aVLemkr0NlYA0UqtWCIVJUv5fJ5UlqU4f2gAOag6Hqy9A0GDBTAr/jR2+sM25q/nSk
 9ZOrfJkQYYUA56SurvQS89xPKEXtLMnN4L9wFB/n96/YUY+zDo2c8ve/1eiCnCxG7Wr2S/c
 HGIl3akUjgI9mMmaAsVwg==
UI-OutboundReport: notjunk:1;M01:P0:d4OPT7HB6zg=;U2JfafQiUOxO6Gd+AMOERtyVOku
 AS1g8H/7VppiBFc+q13E4yibF0MH9i9NfVoqjG6jz16gQHSsX3JfNyNTvFQxUBtGgMAjRelbv
 qbevpnXBkpnLsboMknJHaDYyhTvjVX/wRigHE7zt8wy3UgF0hK/wowJMeXqeEpRB6b6VHr5N8
 Iy+K2/yMqMmL+WoIJEQjIWt+c+pQXEU8cSPyewj+4yJgWIcZJOPIuG42M5qs+9OnjtFLl06Hb
 PuWJGRNAT9Rx5IpA4VnlpkMIj5PsR1D1ApZQnr4gY7kC5uPrKiGDq/h+ZiwpJ32TzKf8WCswQ
 4yWgppP2/KcLkj91V8eJE/HkBHlhsOYujf91iMgkbIcfzaeSdLQWtQabEDlDaPlrEYqyyZoa3
 Ro1Q6omMa5CuSOW/dZmxJV52XWFy9wqs52kSUjTnRTvmFmlhr7PugXoY21mXdim0G4CgJzL2G
 YSXI8d8e34etcm6OC7EPUZUAArpE0iUvpXYBuO79VMIXCcdS+ktKkAUz1Pqvi2nhQY7TCv7LG
 UeKvvka+rAlzFxKzqceCodRu6PIdBnD+1immUqqxBtARcqnl1rKyH0QELw6OHMkBELs6sW9Fh
 ewJhpk1wOX92OtBb2H3nru9LttFE5rXKP+P+cHXhkt+kYZEAu3ybTQdN+jPAcmN1576iz3/wI
 1gYWHFbgAtXk5W/ugV3ARgXNuQFLNt4foMe6ncXZkVO+pKwVRyR4hZIocba9R9Y8dp/kYVb1v
 KLmmD/CYjAf1VSfWYkcdzDv33WGkv1WPUYew/2h+060jeQSGhtIoVJt3DKyHFJoPagLPAjjIL
 EzSJ5exTweQH0OKdLMtpD/8uc52XaOWZbLBXtRcVsDa6s0eCRrUeqf1++dzH9MjAi+OnBg40j
 rak7jVQLmdo27nPl9c53j8OJoIhIEIQBFs2K++H2+vHAFFr0XJnhqca18DZRkG0wMUs1EKBKB
 Um9Y5Q==
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=web.de header.s=s29768273 header.b=iKRqchCX;
	dmarc=pass (policy=quarantine) header.from=web.de;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@web.de designates 212.227.15.14 as permitted sender) smtp.mailfrom=jan.kiszka@web.de

On 25.01.24 04:18, linz wrote:
> I think my patch is not suitable after listening to your suggestions.
> And I don't have any other good solutions.
>
> I think x86 is ok because there is no operation of writing global
> variables in the critical zone.
>
> kernel_fpu_begin
> =C2=A0=C2=A0=C2=A0 =3D>kernel_fpu_begin_mask
> =3D>preempt_disable // enter the critical zone
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>WARN_ON_FPU(!irq_fpu_usab=
le());
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>WARN_ON_FPU(this_cpu_read=
(in_kernel_fpu));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>flags =3D hard_cond_local=
_irq_save(); // leave the critcal zone
>
>
> But in arm64, there is operation of writing global variables in the
> critical zone, unfortunernaly.
> efi_call_rts
> =C2=A0 =3D>__efi_fpsimd_begin
> =C2=A0=C2=A0=C2=A0 =3D>kernel_neon_begin
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>get_cpu_fpsimd_context
> =3D>hard_preempt_disable // disable interrupt, enter the critical zone
> =3D>__get_cpu_fpsimd_context //=C2=A0 first call, modify global variable
> fpsimd_context_busy
> =3D>hard_cond_local_irq_restore // enable interrupt, leave the critcal z=
one
>
> handle_arch_irq_pipelined // Latency timer interrupt triggered
> =3D>handle_irq_pipelined_finish
> =C2=A0 =3D>irq_exit_pipeline
> =C2=A0=C2=A0=C2=A0 =3D>xnsched_run
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__xnsched_run
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>pipeline_schedule
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>run_oob_call
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>_=
__xnsched_run
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D>pipeline_switch_to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D>dovetail_context_switch
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__switch_to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>fpsimd_thread_switch
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D>__get_cpu_fpsim=
d_context // second call
>
> So, I think there are more todos on arm64. Do you have any other good
> suggestions?
>

Philippe, some input on this issue would be helpful to know what the
next step needs to be. It's still unclear to me how fundemental this
issue is (false positive warning or real state corruption?).

Thanks,
Jan


Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE781AA8
	for <xenomai@lists.linux.dev>; Tue, 18 Aug 2026 04:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787027461; cv=pass; b=YO91zvKY0gIIJ7yWH1WA5IgZVELU0dK/8eFYQ8Ed42F4/UJjjKIh3+1YRREz1Rfy0GpZKLvhVXJkVzqdP/Dy83S5yNPWaHTaEKzede7wrGiWUTh0SB1iHKIiExDle499qXORXj/BptdjKtu366FwjnaSwOn+Ia5cwFHqDwg7uQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787027461; c=relaxed/simple;
	bh=6JPdaZbYSq5bnNzIz6tgFRMJ5UKdU5V3LyBikXL2EDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvSJdUm63upibOwVRWSz6NRiP21FvfeJNIAcrkOzeEvQb8tR0Ap9SIzhTW1onXRW74AFAMaCspf9uaU9sUrDbv1GlwClx333FOD6z80M3E1Mn3Pqh2W+cmhuBRt2hDVNCY1VBuEH55eDVUpqqx2+R1LV4A7uw8RuN7VXPnvxbKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=Oh8abRR+; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="Oh8abRR+"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a386a34603so1627313a12.1
        for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 21:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787027458; cv=none;
        d=google.com; s=arc-20260327;
        b=PI+Mr6jFSK9/AfXsKXXduBJ6D8ozcZCGn6lQYOR+p45x+BOUljojit0RWNnvYA3X4w
         ApF3D5w5T+a6FnVnMWAqzzYN5jFRxuso8dbHNOz876f5myxiteAozakjGYAqxlVnvSUm
         Fmb6+bK+sbNkgU7NT7sAwOX2ueSYlMECWqMx6yhRjz39hzL4nCZHWQWCTGka6ad25JB4
         sToCilRjJozNMjpRRMR7n8AkWdZvq+qtFQiCaGnAf+wIQ//b5kLy0XJaTPDIsi/7CEHv
         d78QGen7qZdaeJ4BwnOsC5IF3+QKsC284vrayVG629ixKIs1zO982otIHqP60eB2YsL9
         NnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IExyGfquxlVD8xzpOvw4lWn3YvbUWW7f7sv95sN/r7I=;
        fh=G3e3IUi5dioHWLLxP1KF6cMKfELuzh0BTHVvI8CIfPY=;
        b=aT+MLfFhFlnbrjmvFVgMTRmE1Q4wtShRzYrUvmKFybSDrG213gV2NNNta0agmpjrL6
         X0hrQ42CtLzo+a1U8GcgdY460hEFrBBI7vFd+3yMhiGJWZ/iYNIEkiin90GcLl0dotXF
         /6wERs40szXX3vW1RAu8NH5cNN5ZXp5gJvBCMF/LJ/kq1e7KvNmHs9pp58e9o3qoV5BI
         LDQXLocZmgijIC++lvp4LvQXnSuOWFszu+qaZHuV4n+FqVkKJga1GzFKX2+yW5ZhNV54
         ocwrzSQz3aDGDjkQej3pKdhOE2OF6O4B7k2yb6wSzT2D6xvoc6VgY51fSiaWo1t6Hm2a
         AYEA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1787027458; x=1787632258; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IExyGfquxlVD8xzpOvw4lWn3YvbUWW7f7sv95sN/r7I=;
        b=Oh8abRR+Ov79XGtff3Vt58qYqMBlu5FsbP55uHL5S6Q3ubHWtwQVvPoXSz2KU2TX0N
         pv5dPxT0pwlR4IPcbpGFTPTr/EuWjvqsIEF6v+mX78zpV57LwLgdN8zep52YsJ0tT7hJ
         SVIGwqCtw8WBlZ+hoHuoihZEzGD4o1lzOqetI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787027458; x=1787632258;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IExyGfquxlVD8xzpOvw4lWn3YvbUWW7f7sv95sN/r7I=;
        b=hX18z3pl8FTkJwQIuWMXaF6MM/w1bCu2A3JxYd2E5qh6uxoAhNkJBj0tkN9SCk68j0
         eTqnWGFssd6smt5FeVF/h0kmQIcLH8zLl6txjDQLUozlDda+u7AuLoQhmCE8jkRsSn/P
         twGKNXBydwFmilOZ3gmamfREY3IK/Z2MyF5EFmDbY83Jph+XVFS7r5E80kJxsV7MKj72
         I965p46DOk7uAy5ggCgWYtnyxV9HgorU8Yj9Kvr/MiQYv+wFDne3P2ob5kmZn5ipYBzV
         hwH5JTffPjRcxA8uQtw4ycSdDoX4PJHHJooughAA11iujHqo/Ao2uxRcEnubNevFA5Yc
         u9MA==
X-Forwarded-Encrypted: i=1; AHgh+RrdYcZXiDYZZ2y2jJeVBafIpOyNosHvUD2MavN+65y1CUpq5fgqAVfYB3jUooYHkifPRobNDMqQ@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/F01mH6sZ2+JpZI4tGNIaZkDfiezTlvQhtldz7KZpVwkuqmZP
	oxMAW3bEF7T3BKsx+oqtGz+JFzvR5rFhCGxYHmOkJzydcnY++dp2+053NShYWiMcEoaCUEDZ10+
	vDOvuBjUt+amuiQgi51mE7k81o7y2xAz9f2laQO1uqnBKl2kmrnWBGvgZsh2dBddF57MD1XunrH
	qC4u4kc9UpIMYWHAWduhV97UYaGmdKQaZUxM0/+vhgkp83LnhcDsL35JpzphtaX/mIONWy5F48l
	YO1bSrVb6qemsfmWGDjJKKVqskCZ+C3MFtuHwgc1YUwRgM=
X-Gm-Gg: AR+sD10DP3pHKckyTCTp/4ekn1yTsoEhlvxixluul/ecJS/01LH0ZntBrqhBcq+wp5Q
	UKdZQhotP7uP3SiMdfb7A2HTJoXgYgShYsDiimV1Ejt1NvyknXl8dSwbizFSv3jxfhullgA4vYe
	tne2ofST6gI7+B5uK5pXDDRzzJMweD9V1co6SSZtYrOz7/TvWWf3EUyWOFUmUbBuWz3l/hCYh9q
	l7mSCYGJjsBwAidqBO/PKJRieasptDjF0D3G/J1i5Wgb8CPRL7EYsYNz5JZhFeR7OAeLtVSvaDm
	A9guBuaZ+eEqiuixZT7V50EFCsZatt/KjRWucNEAkTrbM0Bu7F1CM+OgLTNTKauT8HD0eBEkKCU
	LqqvK09ClEKWxAffRguC9omyEvogXxIlEhbnIkzWhoSODWGXC/qL5XIi5IUWZtXo=
X-Received: by 2002:a05:6402:a5d7:10b0:695:4916:b97c with SMTP id
 4fb4d7f45d1cf-6a3e3ca1fa9mr1329824a12.8.1787027457803; Mon, 17 Aug 2026
 21:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
 <87v799kt2q.fsf@xenomai.org> <CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
 <b7d8d1e3-0353-49dd-b626-5aaae76f7526@siemens.com> <CAKndYJFsiha4BZ1VmyM4-XADyNJ0RusC+TPJAm9k2q99=khLLA@mail.gmail.com>
 <87bjb0lqob.fsf@xenomai.org>
In-Reply-To: <87bjb0lqob.fsf@xenomai.org>
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Tue, 18 Aug 2026 06:35:42 +0200
X-Gm-Features: AcwNN1XNxwZdxWY5OIHGibsUI6usKv7-jx17az2r1KxuXWwdtuv-FSZymvXjn14
Message-ID: <CAKndYJGm0Ne6_fMkrNmQoE92LZmSghyH23CYmht0Ogs-obRH1A@mail.gmail.com>
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000d4144a06594ac040"

--000000000000d4144a06594ac040
Content-Type: text/plain; charset="UTF-8"

Hi Jan/Philippe,

Philippe wrote:
> [..] the following patch allows the socfpga to boot, could you please try it on the Zynq?

Thanks for the patch. That patch doesn't make it better or worse; it's
an orthogonal problem and my configuration wasn't affected by it.

Jan wrote:
> That would indeed be welcome already.

We will try to participate.

> [..] I had to manually enable CONFIG_VDSO

Noted. Thanks for the tip.

With a bit of AI research, I landed on something that fixes the
problem for me on "smp_twd" with CONFIG_SMP=y. I'll share the attached
patch to provide further insight into the problem. It may not be the
best candidate for direct adoption, but hopefully it'll shed some
light on the problem.

Furthermore, here's the AI's explanation:

> On Zynq-7000, smp_twd.c sets CLOCK_EVT_FEAT_C3STOP on the TWD unless the DT node
> has "always-on". With no broadcast device registered, tick_is_oneshot_available() never
> returns true, so Linux never switches that CPU to oneshot; and tick_install_proxy() just
> reads td->mode rather than forcing the switch, so the EVL proxy inherits periodic mode too
> and the in-band relay never gets armed. Jiffies freeze silently until the first real timed sleep
> hangs forever.

For me, the "timed sleep" involved a network driver toggling the PHY
reset.  It was asking the kernel for a one second delay (via
"jiffies"), while jiffies was basically stuck. This is why our
original boot attempts never reached userland.

An earlier, simplified, workaround didn't change any C code, but
merely the DTB (oneliner below). I considered it "a shameless hack",
but wanted to share it anyway:

> scutimer: timer@f8f00600 {
>      ...
>      compatible = "arm,cortex-a9-twd-timer";
>      ...
> ++   always-on;  //  workaround!!!
> };

I hope that's helpful. I'm more than happy to try alternative fixes or
future versions. At our organization, we will probably need to upgrade
away from ipipe and getting Dovetail to work properly on Zynq-7000
would be the logical next step for us.

Best,

Gerte Hoogewerf
Senior Software Team Lead
LMI Technologies
Wiebachstraat 25b, Kerkrade 6466 NG, The Netherlands

-- 


This
email and any attachment(s) it may contain is confidential and is 
intended
solely for the use of the individual(s) to whom it is addressed. 
If you are not
the intended recipient of this email, you must not take 
action based on the
contents, nor distribute, nor expose any part of the 
content(s) to entities or
person(s) beyond the original distribution list. 
Please contact the sender and
delete the email if you have received it in 
error. Thank you.

--000000000000d4144a06594ac040
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-evl-force-oneshot-takeover-of-proxy-tick-device-on-i.patch"
Content-Disposition: attachment; 
	filename="0001-evl-force-oneshot-takeover-of-proxy-tick-device-on-i.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msy65rqa0>
X-Attachment-Id: f_msy65rqa0

RnJvbSAzNjMxMGRiYmE0MDVkM2U5OWU4ZTlhNjc1NmE3MWVmMTRjODllODMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZXJ0ZSBIb29nZXdlcmYgPGdob29nZXdlcmZAbG1pM2QuY29t
PgpEYXRlOiBUdWUsIDE4IEF1ZyAyMDI2IDA2OjM0OjExICswMjAwClN1YmplY3Q6IFtQQVRDSF0g
ZXZsOiBmb3JjZSBvbmVzaG90IHRha2VvdmVyIG9mIHByb3h5IHRpY2sgZGV2aWNlIG9uIGluc3Rh
bGwKCi0tLQoga2VybmVsL3RpbWUvdGljay1wcm94eS5jIHwgODAgKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyks
IDMwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC90aW1lL3RpY2stcHJveHkuYyBi
L2tlcm5lbC90aW1lL3RpY2stcHJveHkuYwppbmRleCA1YTg3Nzk4N2E4NGUuLjM4YWY2Y2FmYzgx
OCAxMDA2NDQKLS0tIGEva2VybmVsL3RpbWUvdGljay1wcm94eS5jCisrKyBiL2tlcm5lbC90aW1l
L3RpY2stcHJveHkuYwpAQCAtMjY3LDE2ICsyNjcsNjMgQEAgaW50IHRpY2tfc2V0dXBfcHJveHko
c3RydWN0IGNsb2NrX3Byb3h5X2RldmljZSAqZGV2KQogCXJldHVybiAwOwogfQogCi1zdGF0aWMg
aW50IGVuYWJsZV9vb2JfdGltZXIodm9pZCAqYXJnKSAvKiBoYXJkX2lycXNfZGlzYWJsZWQoKSAq
Lworc3RydWN0IHByb3h5X2luc3RhbGxfYXJnIHsKKwl2b2lkICgqc2V0dXBfcHJveHkpKHN0cnVj
dCBjbG9ja19wcm94eV9kZXZpY2UgKmRldik7CisJaW50IHJlc3VsdDsKK307CisKK3N0YXRpYyBp
bnQgaW5zdGFsbF9wcm94eV9hbmRfdGFrZW92ZXIodm9pZCAqYXJnKSAvKiBoYXJkX2lycXNfZGlz
YWJsZWQoKSwgYWxsIENQVXMgc3RvcHBlZCAqLwogeworCXN0cnVjdCBwcm94eV9pbnN0YWxsX2Fy
ZyAqcmVxID0gYXJnOwogCXN0cnVjdCBjbG9ja19wcm94eV9kZXZpY2UgKmRldiA9IHJhd19jcHVf
cHRyKCZwcm94eV90aWNrX2RldmljZSk7CisJc3RydWN0IHRpY2tfZGV2aWNlICp0ZCA9IHRpY2tf
Z2V0X2RldmljZShzbXBfcHJvY2Vzc29yX2lkKCkpOwogCXN0cnVjdCBjbG9ja19ldmVudF9kZXZp
Y2UgKnJlYWxfZGV2OworCWludCByZXQ7CisKKwkvKgorCSAqIHRpY2tfc2V0dXBfZGV2aWNlKCkg
cGlja3MgcGVyaW9kaWMgdnMuIG9uZXNob3Qgc2V0dXAgZm9yCisJICogdGhlIGluY29taW5nIHBy
b3h5IGRldmljZSBmcm9tIHRkLT5tb2RlIGFsb25lLCB3aXRob3V0CisJICogcmUtY2hlY2tpbmcg
d2hldGhlciB0aGUgcmVhbCBkZXZpY2UgY291bGQgYWN0dWFsbHkgY29tcGxldGUKKwkgKiB0aGF0
IHN3aXRjaCBvbiBpdHMgb3duIChlLmcuIGEgQzNTVE9QIGNsb2NrZXZlbnQgd2l0aCBubworCSAq
IGJyb2FkY2FzdCBkZXZpY2Ugd2lyZWQgdXAgbmV2ZXIgbGVhdmVzIHBlcmlvZGljIG1vZGUgb24K
KwkgKiBzdG9jayBMaW51eCkuIFdlIHRha2Ugb3ZlciBkaXNwYXRjaCBmb3IgdGhpcyBkZXZpY2UK
KwkgKiB1bmNvbmRpdGlvbmFsbHkgcGFzdCB0aGlzIHBvaW50LCBzbyBhbnkgc3VjaCBMaW51eC1z
aWRlCisJICogcHJlY29uZGl0aW9uIG5vIGxvbmdlciBhcHBsaWVzOiBmb3JjZSB0aGUgc3dpdGNo
IGhlcmUuCisJICovCisJaWYgKHRkLT5tb2RlICE9IFRJQ0tERVZfTU9ERV9PTkVTSE9UKSB7CisJ
CXRkLT5tb2RlID0gVElDS0RFVl9NT0RFX09ORVNIT1Q7CisJCS8qCisJCSAqIFRoZSByZWFsIGRl
dmljZSdzIG5leHRfZXZlbnQgd2FzIG5ldmVyIGRyaXZlbiBieQorCQkgKiBnZW51aW5lIG9uZXNo
b3QgcmVwcm9ncmFtbWluZyB3aGlsZSBpbiBwZXJpb2RpYworCQkgKiBtb2RlLCBzbyBpdCBob2xk
cyBhIHN0YWxlIG9yIHVuaW5pdGlhbGl6ZWQgZGVhZGxpbmUuCisJCSAqIHRpY2tfc2V0dXBfZGV2
aWNlKCkgaXMgYWJvdXQgdG8gaW5oZXJpdCBpdCB2ZXJiYXRpbQorCQkgKiBhcyB0aGUgcHJveHkn
cyBmaXJzdCBvbmVzaG90IGRlYWRsaW5lOyBzZWVkIGl0IHdpdGgKKwkJICogYSBzYW5lIG9uZSBu
b3cgc28gdGhhdCBpbmhlcml0YW5jZSBkb2Vzbid0IGhhbmQgdGhlCisJCSAqIHJlcHJvZ3JhbSBs
b29wIGluIHRpY2tfaGFuZGxlX3BlcmlvZGljKCkgYSBkZWFkbGluZQorCQkgKiBmYXIgZW5vdWdo
IGF3YXkgdG8gb3ZlcmZsb3cga3RpbWVfdCBuZWdhdGl2ZSBvbmNlIGEKKwkJICogdGljayBwZXJp
b2QgZ2V0cyBhZGRlZCB0byBpdC4KKwkJICovCisJCWlmICh0ZC0+ZXZ0ZGV2KQorCQkJdGQtPmV2
dGRldi0+bmV4dF9ldmVudCA9IGt0aW1lX2dldCgpOworCX0KKworCWRldi0+X19zZXR1cF9oYW5k
bGVyID0gcmVxLT5zZXR1cF9wcm94eTsKKwlyZXQgPSBjbG9ja2V2ZW50c19yZWdpc3Rlcl9wcm94
eShkZXYpOworCWlmIChyZXQpIHsKKwkJaWYgKCFyZXEtPnJlc3VsdCkKKwkJCXJlcS0+cmVzdWx0
ID0gcmV0OworCQlyZXR1cm4gMDsKKwl9CisJZGV2LT5yZWFsX2RldmljZS0+ZXZlbnRfaGFuZGxl
ciA9IHByb3h5X2V2ZW50X2hhbmRsZXI7CiAKIAkvKgogCSAqIEluc3RhbGwgdGhlIG91dC1vZi1i
YW5kIGhhbmRsZXIgb24gdGhpcyBDUFUncyByZWFsIGNsb2NrCiAJICogZGV2aWNlLCB0aGVuIHR1
cm4gb24gb3V0LW9mLWJhbmQgbW9kZSBmb3IgdGhlIGFzc29jaWF0ZWQKIAkgKiBJUlEgKGR1cGxp
Y2F0ZXMgYXJlIHNpbGVudGx5IGlnbm9yZWQgaWYgdGhlIElSUSBpcyBjb21tb24KLQkgKiB0byBt
dWx0aXBsZSBDUFVzKS4KKwkgKiB0byBtdWx0aXBsZSBDUFVzKS4gQ2FycnlpbmcgdGhpcyBvdXQg
aW4gdGhlIHNhbWUgc3RvcHBlZC0KKwkgKiBtYWNoaW5lIGNvbnRleHQgYXMgdGhlIHJlZ2lzdHJh
dGlvbiBhYm92ZSBjbG9zZXMgdGhlCisJICogd2luZG93IHdoZXJlIGEgZ2VudWluZSB0aWNrIGNv
dWxkIG90aGVyd2lzZSBsYW5kIG9uIHRoZQorCSAqIHJlYWwgZGV2aWNlIGJldHdlZW4gdGhlIHR3
byBzdGVwcywgbWlkLWhhbmRvdmVyLgogCSAqLwogCXJlYWxfZGV2ID0gZGV2LT5yZWFsX2Rldmlj
ZTsKIAlyZWFsX2Rldi0+ZXZlbnRfaGFuZGxlciA9IGRldi0+aGFuZGxlX29vYl9ldmVudDsKQEAg
LTI5MywyNyArMzQwLDYgQEAgc3RhdGljIGludCBlbmFibGVfb29iX3RpbWVyKHZvaWQgKmFyZykg
LyogaGFyZF9pcnFzX2Rpc2FibGVkKCkgKi8KIAlyZXR1cm4gMDsKIH0KIAotc3RydWN0IHByb3h5
X2luc3RhbGxfYXJnIHsKLQl2b2lkICgqc2V0dXBfcHJveHkpKHN0cnVjdCBjbG9ja19wcm94eV9k
ZXZpY2UgKmRldik7Ci0JaW50IHJlc3VsdDsKLX07Ci0KLXN0YXRpYyB2b2lkIHJlZ2lzdGVyX3By
b3h5X2RldmljZSh2b2lkICphcmcpIC8qIGlycXNfZGlzYWJsZWQoKSAqLwotewotCXN0cnVjdCBj
bG9ja19wcm94eV9kZXZpY2UgKmRldiA9IHJhd19jcHVfcHRyKCZwcm94eV90aWNrX2RldmljZSk7
Ci0Jc3RydWN0IHByb3h5X2luc3RhbGxfYXJnICpyZXEgPSBhcmc7Ci0JaW50IHJldDsKLQotCWRl
di0+X19zZXR1cF9oYW5kbGVyID0gcmVxLT5zZXR1cF9wcm94eTsKLQlyZXQgPSBjbG9ja2V2ZW50
c19yZWdpc3Rlcl9wcm94eShkZXYpOwotCWlmIChyZXQpIHsKLQkJaWYgKCFyZXEtPnJlc3VsdCkK
LQkJCXJlcS0+cmVzdWx0ID0gcmV0OwotCX0gZWxzZSB7Ci0JCWRldi0+cmVhbF9kZXZpY2UtPmV2
ZW50X2hhbmRsZXIgPSBwcm94eV9ldmVudF9oYW5kbGVyOwotCX0KLX0KLQogaW50IHRpY2tfaW5z
dGFsbF9wcm94eSh2b2lkICgqc2V0dXBfcHJveHkpKHN0cnVjdCBjbG9ja19wcm94eV9kZXZpY2Ug
KmRldiksCiAJCWNvbnN0IHN0cnVjdCBjcHVtYXNrICpjcHVtYXNrKQogewpAQCAtMzkyLDE3ICs0
MTgsMTEgQEAgaW50IHRpY2tfaW5zdGFsbF9wcm94eSh2b2lkICgqc2V0dXBfcHJveHkpKHN0cnVj
dCBjbG9ja19wcm94eV9kZXZpY2UgKmRldiksCiAJICovCiAJYXJnLnNldHVwX3Byb3h5ID0gc2V0
dXBfcHJveHk7CiAJYXJnLnJlc3VsdCA9IDA7Ci0Jb25fZWFjaF9jcHVfbWFzayhjcHVtYXNrLCBy
ZWdpc3Rlcl9wcm94eV9kZXZpY2UsICZhcmcsIHRydWUpOworCXN0b3BfbWFjaGluZShpbnN0YWxs
X3Byb3h5X2FuZF90YWtlb3ZlciwgJmFyZywgY3B1bWFzayk7CiAJaWYgKGFyZy5yZXN1bHQpIHsK
IAkJdGlja191bmluc3RhbGxfcHJveHkoY3B1bWFzayk7CiAJCXJldHVybiBhcmcucmVzdWx0Owog
CX0KLQotCS8qCi0JICogU3RhcnQgdGlja2luZyBmcm9tIHRoZSBvdXQtb2YtYmFuZCBpbnRlcnJ1
cHQgc3RhZ2UgdXBvbgotCSAqIHJlY2VpcHQgb2Ygb3V0LW9mLWJhbmQgdGltZXIgZXZlbnRzLgot
CSAqLwotCXN0b3BfbWFjaGluZShlbmFibGVfb29iX3RpbWVyLCBOVUxMLCBjcHVtYXNrKTsKIG91
dDoKIAltdXRleF91bmxvY2soJnByb3h5X211dGV4KTsKIAotLSAKMi41NS4wCgo=
--000000000000d4144a06594ac040--

Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314533F3
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730126682; cv=none; b=im2bTGoqE9njNrvVPqL5pRl/tyPQ4jGQH/eUGFOmqgwnJ2kvguvjfMxFuGR3OD1TLPljmz8Q8Tg9NlArDuFIXDJgaIHHTKx3tX1/JzLitul11/0+WIQQSzbavSvveIG0uz5o00KW9x5SPmqBmU3J3xFGBEUUoNLWFWmOcQB+4e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730126682; c=relaxed/simple;
	bh=WiXCLV4twmxkQfGNEkX3VnDrZDJc79kk0B6yAH423wM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rtt+U+dsh1CtMxLEKvGytquvqRbNlXPg9XYKBVhOLX2kjR5qAeS1WbAIWCf7HnFkVdG+l/DRb7QTXnCluYHk0yyBW3NWF23CMaMUcNfA9MKrzVkLH7LVchaXNfxMLBG3D6ek6teY55ZNoH/X/3+/uXsJ7f2lVjMYDL3Zddevnl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
Received: from smtpclient.apple(mailfrom:liyinjie@sinsegye.com.cn fp:SMTPD_---.Zv.RUHQ_1730125719 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 22:28:40 +0800
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] kernel/cobalt: replace unsafe strcpy with memcpy in
 hash_symbol()
From: =?utf-8?B?5p2O6IOk6aKJ?= <liyinjie@sinsegye.com.cn>
In-Reply-To: <be618cf4-7a8c-4e00-beda-f65bc6a278d5@siemens.com>
Date: Mon, 28 Oct 2024 22:28:29 +0800
Cc: xenomai@lists.linux.dev,
 songjianwei@sinsegye.com.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <769DF691-AE8A-4CD5-9009-BDED1BC41C9A@sinsegye.com.cn>
References: <20241028115903.1727776-1-liyinjie@sinsegye.com.cn>
 <be618cf4-7a8c-4e00-beda-f65bc6a278d5@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
X-Mailer: Apple Mail (2.3776.700.51)

Hi Jan,

I have updated the struct hashed_symbol structure to use a =E2=80=9Cflexib=
le array member", This change=20
resolved the compilation error, and the build successfully completed =
with this modification.=20
The updated patch is attached below, including the DCO.

Thank you for your time and support.


=46rom 92e7f1f467822533efd4bfaac56b40589e2fabac Mon Sep 17 00:00:00 2001
From: liyinjie <liyinjie@sinsegye.com.cn>
Date: Mon, 28 Oct 2024 12:01:28 +0800
Subject: [PATCH] kernel/cobalt: use flexible array member for symbol in =
struct
hashed_symbol

Replace the zero-length array `char symbol[0];` with a flexible array =
member `char symbol[];`
in `struct hashed_symbol` to resolve build errors flagged by =
FORTIFY_SOURCE in recent GCC
versions. This change prevents potential buffer overflow risks.

Signed-off-by: liyinjie <liyinjie@sinsegye.com.cn>
---
kernel/cobalt/debug.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
index cde0c17ab..25b194c26 100644
--- a/kernel/cobalt/debug.c
+++ b/kernel/cobalt/debug.c
@@ -47,7 +47,7 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
struct hashed_symbol {
struct hashed_symbol *next;
- char symbol[0];
+ char symbol[];
};
static struct hashed_symbol *symbol_jhash[SYMBOL_HSLOTS];
--=20
2.34.1








> On Oct 28, 2024, at 21:17, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>=20
> On 28.10.24 12:59, liyinjie wrote:
>> Hello,
>>=20
>> While building the Linux kernel with Xenomai support, I encountered a
>> compilation error related to a potential buffer overflow in the
>> hash_symbol() function within kernel/xenomai/debug.c. The error is
>> triggered by the compiler=E2=80=99s buffer overflow protection =
mechanisms
>> (FORTIFY_SOURCE), which detect an unsafe use of strcpy().
>>=20
>> Observed Behavior:
>>=20
>> The build fails with the following error message:
>>=20
>> In function 'strcpy',
>>    inlined from 'hash_symbol' at kernel/xenomai/debug.c:94:2:
>> include/linux/fortify-string.h:812:17: error: call to =
'__write_overflow' declared with attribute error: detected write beyond =
size of object (1st parameter)
>>  812 |                 __write_overflow();
>>      |                 ^~~~~~~~~~~~~~~~~~
>>=20
>> Context:
>>=20
>> - Kernel Version: 6.6.41
>> - Xenomai Version: 3.3-rc.2
>> - Build System: Yocto Project with custom layers at branch scarthgap
>> - Compiler: GCC version [GCC 14.2.0]
>> - Host System: [Ubuntu 22.04 LTS]
>>=20
>=20
> Thanks for bringing this to our attention!
>=20
>> The issue arises during the compilation of the Xenomai integration =
with the Linux kernel. The FORTIFY_SOURCE feature in recent GCC versions =
enhances buffer overflow detection, and it flags the use of strcpy() in =
the kernel code as potentially unsafe.
>>=20
>> Analysis:
>>=20
>> In the hash_symbol() function, strcpy() is used to copy a string into =
a buffer without bounds checking, which can lead to buffer overflows if =
the source string is larger than the destination buffer.
>>=20
>> The specific code causing the issue is:
>>=20
>> p =3D xnheap_alloc(&memory_pool, sizeof(*p) + len + 1);
>> if (p =3D=3D NULL) {
>>    str =3D NULL;
>>    goto out;
>> }
>>=20
>> strcpy(p->symbol, symbol);
>>=20
>> Here, p->symbol may not have a clearly defined size known to the =
compiler, leading to the buffer overflow warning.
>>=20
>> I also tested replacing strcpy() with strscpy(p->symbol, symbol, len =
+ 1), but the error persisted.
>=20
> Yeah, the problem is likely related to the 0-sized symbol field in
> hashed_symbol. Can you first of all try to switch to "flexible array
> members" ("char symbol[];")? This is also described in [1].
>=20
>>=20
>> I am submitting this patch for inclusion in the mainline code. Please =
let me know if any further information is required or if there are any =
suggestions for improvement.
>>=20
>> Thank you for your time and consideration.
>>=20
>=20
> For a ready-to-merge patch, we also need your DCO [2].
>=20
>>=20
>> ---
>> kernel/cobalt/debug.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
>> index cde0c17ab..e901572cd 100644
>> --- a/kernel/cobalt/debug.c
>> +++ b/kernel/cobalt/debug.c
>> @@ -91,7 +91,8 @@ static const char *hash_symbol(const char *symbol)
>> goto out;
>> }
>>=20
>> - strcpy(p->symbol, symbol);
>> + memcpy(p->symbol, symbol, len);
>> + p->symbol[len] =3D '\0';
>> p->next =3D *h;
>> *h =3D p;
>> done:
>=20
> Jan
>=20
> [1]
> =
https://docs.kernel.org/process/deprecated.html#zero-length-and-one-elemen=
t-arrays
> [2]
> =
https://source.denx.de/Xenomai/xenomai/-/blob/master/CONTRIBUTING.md?ref_t=
ype=3Dheads#developers-certificate-of-origin-11
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center



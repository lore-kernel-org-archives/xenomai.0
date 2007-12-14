Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C83E59.998307C1"
Date: Fri, 14 Dec 2007 14:59:52 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB2DF@rennsmail04.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap and DMA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Perrine Martignoni <perrmart@domain.hid>, xenomai-help <xenomai@xenomai.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83E59.998307C1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Perrine Martignoni wrote:
>Currently, I write an RTDM module and I would like to do DMA and mmap
to perform transfers who have hard constraints.
>I would like to know if there is an example in a driver who would help
me to do this.

I'm looking for the same need, except I'm not using RTDM, and everything
is in userland. Using the attached patch against Xenomai 2.4.0, I hope
to make it to work with something like this:

        RT_HEAP_INFO info;
        RT_HEAP heap;
        void *user_addr;	/* DMA buffer, user access */
        unsigned long dma_addr;	/* for use with the DMA controller */

        /* Allocate memory, suitable for DMA. This occurs before
entering RT land. */
        err =3D rt_heap_create (&heap,
                        name,
                        heapsz,
                        H_SHARED|H_DMA);
        if (err) { /* ... */ }

        err =3D rt_heap_alloc (&heap, 0, TM_INFINITE, &user_addr);
        if (err) { /* ... */ }

        err =3D rt_heap_inquire (&heap, &info);
        if (err) { /* ... */ }

        dma_addr =3D info.phys_addr;

Any comments?
--=20
Stephane

------_=_NextPart_001_01C83E59.998307C1
Content-Type: application/octet-stream;
	name="heap_dma.patch"
Content-Transfer-Encoding: base64
Content-Description: heap_dma.patch
Content-Disposition: attachment;
	filename="heap_dma.patch"

LS0tIGtzcmMvbnVjbGV1cy9oZWFwLmMJOCBEZWMgMjAwNyAwOToxNToxOSAtMDAwMAkxLjEuMS41
CisrKyBrc3JjL251Y2xldXMvaGVhcC5jCTE0IERlYyAyMDA3IDEzOjM2OjE2IC0wMDAwCkBAIC0x
MTgwLDcgKzExODAsMTUgQEAKIAkJICogc3BhY2UuIEFzc3VtZSB0aGF0IHdlIGNhbiB3YWl0IHRv
IGdldCB0aGUgcmVxdWlyZWQgbWVtb3J5LgogCQkgKi8KIAotCQlwdHIgPSBrbWFsbG9jKHNpemUs
IGttZmxhZ3MgfCBHRlBfS0VSTkVMKTsKKyNkZWZpbmUgTUFYX0tNQUxMT0NfU0laRSAoMTI4KjEw
MjQpCisJCWlmIChzaXplIDw9IE1BWF9LTUFMTE9DX1NJWkUpCisJCQlwdHIgPSBrbWFsbG9jKHNp
emUsIGttZmxhZ3MgfCBHRlBfS0VSTkVMKTsKKwkJZWxzZSB7CisJCQl1bnNpZ25lZCBsb25nIG9y
ZGVyOworCQkJZm9yIChvcmRlciA9IDA7ICgoMVVMIDw8IG9yZGVyKSA8PCBQQUdFX1NISUZUKSA8
IHNpemU7IG9yZGVyKyspCisJCQkJOworCQkJcHRyID0gKHZvaWQqKSBfX2dldF9mcmVlX3BhZ2Vz
KGttZmxhZ3MgfCBHRlBfS0VSTkVMLCBvcmRlcik7CisJCX0KIAogCQlpZiAoIXB0cikKIAkJCXJl
dHVybiBOVUxMOwpAQCAtMTIxMiw3ICsxMjIwLDE0IEBACiAJCWZvciAodmFkZHIgPSB2YWJhc2U7
IHZhZGRyIDwgdmFiYXNlICsgc2l6ZTsgdmFkZHIgKz0gUEFHRV9TSVpFKQogCQkJQ2xlYXJQYWdl
UmVzZXJ2ZWQodmlydF90b19wYWdlKHZhZGRyKSk7CiAKLQkJa2ZyZWUocHRyKTsKKwkJaWYgKHNp
emUgPD0gTUFYX0tNQUxMT0NfU0laRSkKKwkJCWtmcmVlKHB0cik7CisJCWVsc2UgeworCQkJdW5z
aWduZWQgbG9uZyBvcmRlcjsKKwkJCWZvciAob3JkZXIgPSAwOyAoKDFVTCA8PCBvcmRlcikgPDwg
UEFHRV9TSElGVCkgPCBzaXplOyBvcmRlcisrKQorCQkJCTsKKwkJCWZyZWVfcGFnZXMoKHVuc2ln
bmVkIGxvbmcpcHRyLCBvcmRlcik7CisJCX0KIAl9CiB9CiAKLS0tIGtzcmMvc2tpbnMvbmF0aXZl
L2hlYXAuYwkxMCBEZWMgMjAwNyAwOTo1OTowNyAtMDAwMAkxLjUKKysrIGtzcmMvc2tpbnMvbmF0
aXZlL2hlYXAuYwkxNCBEZWMgMjAwNyAxMzozNjoxNiAtMDAwMApAQCAtNzMwLDYgKzczMCw3IEBA
CiAJaW5mby0+dXNhYmxlbWVtID0geG5oZWFwX3VzYWJsZV9tZW0oJmhlYXAtPmhlYXBfYmFzZSk7
CiAJaW5mby0+dXNlZG1lbSA9IHhuaGVhcF91c2VkX21lbSgmaGVhcC0+aGVhcF9iYXNlKTsKIAlp
bmZvLT5tb2RlID0gaGVhcC0+bW9kZTsKKwlpbmZvLT5waHlzX2FkZHIgPSAoaGVhcC0+bW9kZSAm
IEhfU0lOR0xFKSA/IHZpcnRfdG9fcGh5cyhoZWFwLT5zYmEpOjA7CiAKICAgICAgIHVubG9ja19h
bmRfZXhpdDoKIAotLS0gaW5jbHVkZS9uYXRpdmUvaGVhcC5oCTI1IE5vdiAyMDA3IDE2OjUwOjA0
IC0wMDAwCTEuMS4xLjMKKysrIGluY2x1ZGUvbmF0aXZlL2hlYXAuaAkxNCBEZWMgMjAwNyAxMzoz
NjoyOSAtMDAwMApAQCAtNDgsNiArNDgsOCBAQAogCiAgICAgY2hhciBuYW1lW1hOT0JKRUNUX05B
TUVfTEVOXTsgLyogITwgU3ltYm9saWMgbmFtZS4gKi8KIAorICAgIHVuc2lnbmVkIGxvbmcgcGh5
c19hZGRyOwkvKiAhPCBQaHlzaWNhbCBhZGRyZXNzLiAqLworCiB9IFJUX0hFQVBfSU5GTzsKIAog
dHlwZWRlZiBzdHJ1Y3QgcnRfaGVhcF9wbGFjZWhvbGRlciB7Cg==

------_=_NextPart_001_01C83E59.998307C1--


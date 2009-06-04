MIME-Version: 1.0
Sender: dothemango@domain.hid
In-Reply-To: <4A27ACEA.6010500@domain.hid>
References: <325d766d0906040408w7d9712a0gb8927529796a3913@domain.hid>
	<4A27ACEA.6010500@domain.hid>
Date: Thu, 4 Jun 2009 15:01:30 +0200
Message-ID: <325d766d0906040601v2251a4f6ma5374c967fb98758@domain.hid>
From: martin mangard <martin@domain.hid>
Content-Type: multipart/mixed; boundary=000e0cd25830ec9ac5046b855fa1
Subject: Re: [Xenomai-core] [PATCH] Support for Atmel AT91SAM9G20 processor
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--000e0cd25830ec9ac5046b855fa1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello

You are right! This part of the patch is not necessary and is ignored
if the AT91SAM9G20 is selected in the kernel configuration. I made
this  change  during a test with another kernel configuration. Sadly
this change was still present during the creation of the patch. The
attached patch does not contain this part any more.


On Thu, Jun 4, 2009 at 1:15 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> martin mangard wrote:
>> Hello
>>
>> I made a patch in order to support the Atmel AT91SAM9G20 processor,
>> which has to be applied after the "adeos-ipipe-2.6.27-arm-*" patch.
>> Due to the similarities between the AT91SAM9260 and the AT91SAM9G20
>> processor, only a few changes were necessary. I booted the system on a
>> "AT91SAM9G20-EK" development
>> board and executed "latencytest" and "clocktest". Are there plans to
>> officially support this processor in the future?
>
> Well, now that you sent the patch, this should be included in the next
> adeos patch. However:
> - your mailer mangled the patch, so I can not apply it, please configure
> your mailer to avoid mangling the patch, or if that is not possible,
> send the patch as attachment;
> - =A0there is one change in your patch that I do not like:
>
>> =A0#ifdef CONFIG_ARCH_AT91SAM9260
>> =A0#define cpu_is_at91sam9xe() =A0 =A0(at91_arch_identify() =3D=3D ARCH_=
FAMILY_AT91SAM9XE)
>> -#define cpu_is_at91sam9260() =A0 ((at91_cpu_identify() =3D=3D
>> ARCH_ID_AT91SAM9260) || cpu_is_at91sam9xe())
>> +#define cpu_is_at91sam9260() =A0 ((at91_cpu_identify() =3D=3D
>> ARCH_ID_AT91SAM9260) || cpu_is_at91sam9xe() ||
>> (at91_cpu_identify()=3D=3DARCH_ID_AT91SAM9G20)))
>
> You are touching mailine code here. It this patch is really needed by
> mainline, then post it to the linux arm kernel mailing list.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

--000e0cd25830ec9ac5046b855fa1
Content-Type: text/x-diff; charset=US-ASCII; name="adeos-ipipe-2.6.27-arm-9G20.patch"
Content-Disposition: attachment; 
	filename="adeos-ipipe-2.6.27-arm-9G20.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvjgxgyj0

ZGlmZiAtdXJwIGEvYXJjaC9hcm0vbWFjaC1hdDkxL2F0OTFfaXBpcGVfdGltZS5jIGIvYXJjaC9h
cm0vbWFjaC1hdDkxL2F0OTFfaXBpcGVfdGltZS5jCi0tLSBhL2FyY2gvYXJtL21hY2gtYXQ5MS9h
dDkxX2lwaXBlX3RpbWUuYwkyMDA5LTA2LTAzIDE1OjIzOjMwLjAwMDAwMDAwMCArMDIwMAorKysg
Yi9hcmNoL2FybS9tYWNoLWF0OTEvYXQ5MV9pcGlwZV90aW1lLmMJMjAwOS0wNi0wMyAxNToyNDo1
OS4wMDAwMDAwMDAgKzAyMDAKQEAgLTM0LDcgKzM0LDcgQEAKICNkZWZpbmUgQVQ5MV9JRF9UQzAg
QVQ5MVJNOTIwMF9JRF9UQzAKICNkZWZpbmUgQVQ5MV9JRF9UQzEgQVQ5MVJNOTIwMF9JRF9UQzEK
ICNkZWZpbmUgQVQ5MV9JRF9UQzIgQVQ5MVJNOTIwMF9JRF9UQzIKLSNlbGlmIGRlZmluZWQoQ09O
RklHX0FSQ0hfQVQ5MVNBTTkyNjApCisjZWxpZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05
MjYwKSB8fCBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05RzIwKQogI2RlZmluZSBBVDkxX0lE
X1RDMCBBVDkxU0FNOTI2MF9JRF9UQzAKICNkZWZpbmUgQVQ5MV9JRF9UQzEgQVQ5MVNBTTkyNjBf
SURfVEMxCiAjZGVmaW5lIEFUOTFfSURfVEMyIEFUOTFTQU05MjYwX0lEX1RDMgpAQCAtMzM5LDcg
KzMzOSw3IEBAIHZvaWQgX19pbml0IGF0OTFfdGltZXJfaW5pdCh2b2lkKQogCWF0OTFfc3lzX3dy
aXRlKEFUOTFfU1RfSURSLCBBVDkxX1NUX1BJVFMgfCBBVDkxX1NUX1dET1ZGIHwgQVQ5MV9TVF9S
VFRJTkMgfCBBVDkxX1NUX0FMTVMpOwogCSh2b2lkKSBhdDkxX3N5c19yZWFkKEFUOTFfU1RfU1Ip
OwkvKiBDbGVhciBhbnkgcGVuZGluZyBpbnRlcnJ1cHRzICovCQogI2VsaWYgZGVmaW5lZChDT05G
SUdfQVJDSF9BVDkxU0FNOTI2MCkgfHwgZGVmaW5lZChDT05GSUdfQVJDSF9BVDkxU0FNOTI2MSkg
XAotCXx8IGRlZmluZWQoQ09ORklHX0FSQ0hfQVQ5MVNBTTkyNjMpIHx8IGRlZmluZWQoQ09ORklH
X0FSQ0hfQVQ5MVNBTTlSTCkKKwl8fCBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYzKSB8
fCBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05UkwpIHx8IGRlZmluZWQoQ09ORklHX0FSQ0hf
QVQ5MVNBTTlHMjApIAogCWF0OTFfc3lzX3dyaXRlKEFUOTFfUElUX01SLCAwKTsKIAogCS8qIENs
ZWFyIGFueSBwZW5kaW5nIGludGVycnVwdHMgKi8KQEAgLTM5OSw3ICszOTksNyBAQCB2b2lkIF9f
aW5pdCBhdDkxX3RpbWVyX2luaXQodm9pZCkKICNpZmRlZiBDT05GSUdfQVJDSF9BVDkxUk05MjAw
CiBzdHJ1Y3Qgc3lzX3RpbWVyIGF0OTFybTkyMDBfdGltZXIgPSB7CiAjZWxpZiBkZWZpbmVkKENP
TkZJR19BUkNIX0FUOTFTQU05MjYwKSB8fCBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFTQU05MjYx
KSBcCi0JfHwgZGVmaW5lZChDT05GSUdfQVJDSF9BVDkxU0FNOTI2MykgfHwgZGVmaW5lZChDT05G
SUdfQVJDSF9BVDkxU0FNOVJMKQorCXx8IGRlZmluZWQoQ09ORklHX0FSQ0hfQVQ5MVNBTTkyNjMp
IHx8IGRlZmluZWQoQ09ORklHX0FSQ0hfQVQ5MVNBTTlSTCl8fCBkZWZpbmVkKENPTkZJR19BUkNI
X0FUOTFTQU05UkwpIHx8IGRlZmluZWQoQ09ORklHX0FSQ0hfQVQ5MVNBTTlHMjApIAogc3RydWN0
IHN5c190aW1lciBhdDkxc2FtOTI2eF90aW1lciA9IHsKICNlbGlmIGRlZmluZWQoQ09ORklHX0FS
Q0hfQVQ5MVg0MCkKIHN0cnVjdCBzeXNfdGltZXIgYXQ5MXg0MF90aW1lciA9IHsKZGlmZiAtdXJw
IGEvYXJjaC9hcm0vbWFjaC1hdDkxL2luY2x1ZGUvbWFjaC9oYXJkd2FyZS5oIGIvYXJjaC9hcm0v
bWFjaC1hdDkxL2luY2x1ZGUvbWFjaC9oYXJkd2FyZS5oCi0tLSBhL2FyY2gvYXJtL21hY2gtYXQ5
MS9pbmNsdWRlL21hY2gvaGFyZHdhcmUuaAkyMDA5LTA2LTAzIDE1OjIzOjMwLjAwMDAwMDAwMCAr
MDIwMAorKysgYi9hcmNoL2FybS9tYWNoLWF0OTEvaW5jbHVkZS9tYWNoL2hhcmR3YXJlLmgJMjAw
OS0wNi0wMyAxNToyNDo1OS4wMDAwMDAwMDAgKzAyMDAKQEAgLTY0LDcgKzY0LDcgQEAKICNpZmRl
ZiBDT05GSUdfSVBJUEUKICNpZiBkZWZpbmVkKENPTkZJR19BUkNIX0FUOTFSTTkyMDApCiAjZGVm
aW5lIEFUOTFfQkFTRV9UQ0IwIEFUOTFSTTkyMDBfQkFTRV9UQ0IwCi0jZWxpZiBkZWZpbmVkKENP
TkZJR19BUkNIX0FUOTFTQU05MjYwKQorI2VsaWYgZGVmaW5lZChDT05GSUdfQVJDSF9BVDkxU0FN
OTI2MCkgfHwgZGVmaW5lZChDT05GSUdfQVJDSF9BVDkxU0FNOUcyMCkgCiAjZGVmaW5lIEFUOTFf
QkFTRV9UQ0IwIEFUOTFTQU05MjYwX0JBU0VfVENCMAogI2VsaWYgZGVmaW5lZChDT05GSUdfQVJD
SF9BVDkxU0FNOTI2MSkKICNkZWZpbmUgQVQ5MV9CQVNFX1RDQjAgQVQ5MVNBTTkyNjFfQkFTRV9U
Q0IwCmRpZmYgLXVycCBhL2FyY2gvYXJtL21hY2gtYXQ5MS9pbmNsdWRlL21hY2gvaXJxcy5oIGIv
YXJjaC9hcm0vbWFjaC1hdDkxL2luY2x1ZGUvbWFjaC9pcnFzLmgKLS0tIGEvYXJjaC9hcm0vbWFj
aC1hdDkxL2luY2x1ZGUvbWFjaC9pcnFzLmgJMjAwOS0wNi0wMyAxNToyMzozMC4wMDAwMDAwMDAg
KzAyMDAKKysrIGIvYXJjaC9hcm0vbWFjaC1hdDkxL2luY2x1ZGUvbWFjaC9pcnFzLmgJMjAwOS0w
Ni0wMyAxNToyNDo1OS4wMDAwMDAwMDAgKzAyMDAKQEAgLTUyLDcgKzUyLDcgQEAgZXh0ZXJuIHVu
c2lnbmVkIF9faXBpcGVfYXQ5MV9ncGlvX2JhbmtzOwogI2RlZmluZSBfX2lwaXBlX21hY2hfaXJx
X211eF9wKGlycSkJCQkJCVwKIAkoKHVuc2lnbmVkKSAoaXJxIC0gQVQ5MVJNOTIwMF9JRF9QSU9B
KSA8IF9faXBpcGVfYXQ5MV9ncGlvX2JhbmtzKQogCi0jZWxpZiBkZWZpbmVkKENPTkZJR19BUkNI
X0FUOTFTQU05MjYwKQorI2VsaWYgZGVmaW5lZChDT05GSUdfQVJDSF9BVDkxU0FNOTI2MCkgfHwg
ZGVmaW5lZChDT05GSUdfQVJDSF9BVDkxU0FNOUcyMCkgCiAjZGVmaW5lIF9faXBpcGVfbWFjaF9p
cnFfbXV4X3AoaXJxKQkJCQkJXAogCSgodW5zaWduZWQpIChpcnEgLSBBVDkxU0FNOTI2MF9JRF9Q
SU9BKSA8IF9faXBpcGVfYXQ5MV9ncGlvX2JhbmtzKQogCmRpZmYgLXVycCBhL2FyY2gvYXJtL21h
Y2gtYXQ5MS9NYWtlZmlsZSBiL2FyY2gvYXJtL21hY2gtYXQ5MS9NYWtlZmlsZQotLS0gYS9hcmNo
L2FybS9tYWNoLWF0OTEvTWFrZWZpbGUJMjAwOS0wNi0wMyAxNToyMzozMC4wMDAwMDAwMDAgKzAy
MDAKKysrIGIvYXJjaC9hcm0vbWFjaC1hdDkxL01ha2VmaWxlCTIwMDktMDYtMDMgMTU6MjQ6NTku
MDAwMDAwMDAwICswMjAwCkBAIC04Miw2ICs4Miw3IEBAIGlmZXEgKCQoQ09ORklHX0lQSVBFKSx5
KQogb2JqLXkgOj0gJChmaWx0ZXItb3V0IGF0OTFybTkyMDBfdGltZS5vIGF0OTFzYW05MjZ4X3Rp
bWUubyBhdDkxeDQwX3RpbWUubywgJChvYmoteSkpCiBvYmotJChDT05GSUdfQVJDSF9BVDkxUk05
MjAwKSAgICs9IGF0OTFfaXBpcGVfdGltZS5vCiBvYmotJChDT05GSUdfQVJDSF9BVDkxU0FNOTI2
MCkgICs9IGF0OTFfaXBpcGVfdGltZS5vCitvYmotJChDT05GSUdfQVJDSF9BVDkxU0FNOUcyMCkg
ICs9IGF0OTFfaXBpcGVfdGltZS5vCiBvYmotJChDT05GSUdfQVJDSF9BVDkxU0FNOTI2MSkgICs9
IGF0OTFfaXBpcGVfdGltZS5vCiBvYmotJChDT05GSUdfQVJDSF9BVDkxU0FNOTI2MykJKz0gYXQ5
MV9pcGlwZV90aW1lLm8KIG9iai0kKENPTkZJR19BUkNIX0FUOTFTQU05UkwpCSs9IGF0OTFfaXBp
cGVfdGltZS5vCg==
--000e0cd25830ec9ac5046b855fa1--


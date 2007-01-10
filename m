Message-ID: <b647ffbd0701100759p5432558dv386b5b1a580e3921@domain.hid>
Date: Wed, 10 Jan 2007 16:59:32 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] Xenomai Bug: rt_intr_create with NULL-name leads
	to Kernel oops in /proc/xenomai/irq
In-Reply-To: <b647ffbd0701100758i1ea15b12qab5ac7c33acae0be@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3696_5149520.1168444772058"
References: <15523442.1168430357436.JavaMail.ngmail@domain.hid>
	<45A4DDA8.6090800@domain.hid>
	<b647ffbd0701100549y5d143e8at8e9ac5ab8e1826d6@domain.hid>
	<45A4F18A.4040209@domain.hid>
	<b647ffbd0701100621k25126a1bldb0bef19be65c92b@domain.hid>
	<45A4F9CC.6070807@domain.hid>
	<b647ffbd0701100655wd47af96y244c74d5227d6e85@domain.hid>
	<45A502A9.3060800@domain.hid>
	<b647ffbd0701100758i1ea15b12qab5ac7c33acae0be@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

------=_Part_3696_5149520.1168444772058
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>
> Attached. Keep in mind that although it's a simple patch I,
> personally, haven't tested it (even compilation-wise).
> Anyone who would like to give it a try (Mathias?) is wellcome.

Now finally attached.

-- 
Best regards,
Dmitry Adamushko

------=_Part_3696_5149520.1168444772058
Content-Type: text/x-patch; name=intr.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ewrxtyll
Content-Disposition: attachment; filename="intr.patch"

LS0tIC4va3NyYy9za2lucy9uYXRpdmUvaW50ci5jCTIwMDYtMDYtMTUgMTQ6MTU6NDQuMDAwMDAw
MDAwICswMjAwCisrKyAuL2tzcmMvc2tpbnMvbmF0aXZlL2ludHItbmV3My5jCTIwMDctMDEtMTAg
MTU6NTE6MjIuOTMzOTc2MDAwICswMTAwCkBAIC0yMjMsNiArMjIzLDcgQEAgc3RhdGljIHhucG5v
ZGVfdCBfX2ludHJfcG5vZGUgPSB7CiAgKgogICogLSBLZXJuZWwgbW9kdWxlIGluaXRpYWxpemF0
aW9uL2NsZWFudXAgY29kZQogICogLSBLZXJuZWwtYmFzZWQgdGFzaworICogLSBVc2VyLXNwYWNl
IHRhc2sKICAqCiAgKiBSZXNjaGVkdWxpbmc6IHBvc3NpYmxlLgogICoKQEAgLTI0MSw4ICsyNDIs
MTUgQEAgaW50IHJ0X2ludHJfY3JlYXRlKFJUX0lOVFIgKmludHIsCiAJaWYgKHhucG9kX2FzeW5j
aF9wKCkpCiAJCXJldHVybiAtRVBFUk07CiAKLQl4bmludHJfaW5pdCgmaW50ci0+aW50cl9iYXNl
LCBuYW1lLCBpcnEsIGlzciwgaWFjaywgbW9kZSk7Ci0JeG5vYmplY3RfY29weV9uYW1lKGludHIt
Pm5hbWUsIG5hbWUpOworCWlmIChuYW1lKQorCQl4bm9iamVjdF9jb3B5X25hbWUoaW50ci0+bmFt
ZSwgbmFtZSk7CisJZWxzZQorCQkvKiBLZXJuZWwtc2lkZSAiYW5vbnltb3VzIiBvYmplY3RzIChu
YW1lID09IE5VTEwpIGdldCB1bmlxdWUgbmFtZXMuCisJCSAqIE5ldmVydGhlbGVzcywgdGhleSB3
aWxsIG5vdCBiZSBleHBvcnRlZCB2aWEgdGhlIHJlZ2lzdHJ5LiAqLworCQl4bm9iamVjdF9jcmVh
dGVfbmFtZShpbnRyLT5uYW1lLCBzaXplb2YoaW50ci0+bmFtZSksCisJCQkodm9pZCAqKWludHIp
OworCisJeG5pbnRyX2luaXQoJmludHItPmludHJfYmFzZSwgaW50ci0+bmFtZSwgaXJxLCBpc3Is
IGlhY2ssIG1vZGUpOwogI2lmIGRlZmluZWQoX19LRVJORUxfXykgJiYgZGVmaW5lZChDT05GSUdf
WEVOT19PUFRfUEVSVkFTSVZFKQogCXhuc3luY2hfaW5pdCgmaW50ci0+c3luY2hfYmFzZSwgWE5T
WU5DSF9QUklPKTsKIAlpbnRyLT5wZW5kaW5nID0gMDsKQEAgLTI2MiwxMSArMjcwLDIxIEBAIGlu
dCBydF9pbnRyX2NyZWF0ZShSVF9JTlRSICppbnRyLAogCS8qIDwhPiBTaW5jZSB4bnJlZ2lzdGVy
X2VudGVyKCkgbWF5IHJlc2NoZWR1bGUsIG9ubHkgcmVnaXN0ZXIKIAkgICBjb21wbGV0ZSBvYmpl
Y3RzLCBzbyB0aGF0IHRoZSByZWdpc3RyeSBjYW5ub3QgcmV0dXJuIGhhbmRsZXMgdG8KIAkgICBo
YWxmLWJha2VkIG9iamVjdHMuLi4gKi8KKwlpZiAoIWVyciAmJiBuYW1lKSB7CisJCXhucG5vZGVf
dCAqcG5vZGUgPSAmX19pbnRyX3Bub2RlOwogCi0JaWYgKCFlcnIpCi0JCWVyciA9Ci0JCSAgICB4
bnJlZ2lzdHJ5X2VudGVyKGludHItPm5hbWUsIGludHIsICZpbnRyLT5oYW5kbGUsCi0JCQkJICAg
ICAmX19pbnRyX3Bub2RlKTsKKwkJaWYgKCEqbmFtZSkgeworCQkJLyogU2luY2UgdGhpcyBpcyBh
biBhbm9ueW1vdXMgb2JqZWN0IChlbXB0eSBuYW1lIG9uIGVudHJ5KQorCQkJICogZnJvbSB1c2Vy
LXNwYWNlLCBpdCBnZXRzIHJlZ2lzdGVyZWQgdW5kZXIgYW4gdW5pcXVlCisJCQkgKiBpbnRlcm5h
bCBuYW1lIGJ1dCBpcyBub3QgZXhwb3J0ZWQgdGhyb3VnaCAvcHJvYy4gKi8KKwkJCXhub2JqZWN0
X2NyZWF0ZV9uYW1lKGludHItPm5hbWUsIHNpemVvZihpbnRyLT5uYW1lKSwKKwkJCQkodm9pZCAq
KWludHIpOworCQkJcG5vZGUgPSBOVUxMOworCQl9CisKKwkJZXJyID0geG5yZWdpc3RyeV9lbnRl
cihpbnRyLT5uYW1lLCBpbnRyLCAmaW50ci0+aGFuZGxlLCBwbm9kZSk7CisJfQkKKwkKICNlbmRp
ZiAvKiBDT05GSUdfWEVOT19PUFRfUkVHSVNUUlkgKi8KIAogCWlmIChlcnIpCg==
------=_Part_3696_5149520.1168444772058--


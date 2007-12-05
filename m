Message-ID: <2ff1a98a0712050209o2737f0a9oa9da90859fe5a827@domain.hid>
Date: Wed, 5 Dec 2007 11:09:56 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47563A68.8060404@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12728_32796163.1196849396041"
References: <47563A68.8060404@domain.hid>
Subject: Re: [Xenomai-help] undefined reference to `rt_printf(char const*,
	...)'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dennis Nguyen <dennisnguy@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_12728_32796163.1196849396041
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dec 5, 2007 6:43 AM, Dennis Nguyen <dennisnguy@domain.hid> wrote:
> Hello all,
>
> I got the "undefined reference to rt_printf" function when I called
> rt_printf in my application.  I included the header #include <rtdk.h> in
> the source file and -L /usr/xenomai/lib -lrtdk -lpthread-rt in the
> makefile.  I'm using kernel i386 2.6.23.9 and xenomai 2-4rc7. I have the
> rtdk.h include file in /usr/xenomai/include and librtdk.so in the
> /usr/xenomai/lib.
> What am I missing?

Does the attached patch help ?

-- 
                                               Gilles Chanteperdrix

------=_Part_12728_32796163.1196849396041
Content-Type: application/octet-stream; name=xeno-extern-c-rtdk.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9tp7ra70
Content-Disposition: attachment; filename=xeno-extern-c-rtdk.diff

SW5kZXg6IGluY2x1ZGUvcnRkay5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGluY2x1ZGUvcnRkay5oCShyw6l2
aXNpb24gMzIzNykKKysrIGluY2x1ZGUvcnRkay5oCShjb3BpZSBkZSB0cmF2YWlsKQpAQCAtNDQs
NiArNDQsMTAgQEAKICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPHN0ZGFyZy5oPgogCisj
aWZkZWYgX19jcGx1c3BsdXMKK2V4dGVybiAiQyIgeworI2VuZGlmIC8qIF9fY3BsdXNwbHVzICov
CisKIGludCBydF92ZnByaW50ZihGSUxFICpzdHJlYW0sIGNvbnN0IGNoYXIgKmZvcm1hdCwgdmFf
bGlzdCBhcmdzKTsKIGludCBydF92cHJpbnRmKGNvbnN0IGNoYXIgKmZvcm1hdCwgdmFfbGlzdCBh
cmdzKTsKIGludCBydF9mcHJpbnRmKEZJTEUgKnN0cmVhbSwgY29uc3QgY2hhciAqZm9ybWF0LCAu
Li4pOwpAQCAtNTQsNiArNTgsMTAgQEAKIHZvaWQgcnRfcHJpbnRfYXV0b19pbml0KGludCBlbmFi
bGUpOwogY29uc3QgY2hhciAqcnRfcHJpbnRfYnVmZmVyX25hbWUodm9pZCk7CiAKKyNpZmRlZiBf
X2NwbHVzcGx1cworfQorI2VuZGlmIC8qIF9fY3BsdXNwbHVzICovCisKICNlbmRpZiAvKiAhS0VS
TkVMICovCiAKICNlbmRpZiAvKiAhX1JUVVRJTFNfSCAqLwo=
------=_Part_12728_32796163.1196849396041--


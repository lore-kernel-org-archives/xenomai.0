MIME-Version: 1.0
In-Reply-To: <4AE8748B.3070706@domain.hid>
References: <b88603c30910280734i7a823063s75b420720fdf3707@domain.hid>
	<4AE858F0.4010600@domain.hid>
	<b88603c30910280753uea312e1p3d5f62012814d355@domain.hid>
	<4AE860FB.4090903@domain.hid>
	<b88603c30910280825t39954bddl48f33c76181b9938@domain.hid>
	<4AE86335.5030106@domain.hid>
	<b88603c30910280917x1eaa89f2q26c7283e381d05f1@domain.hid>
	<4AE8748B.3070706@domain.hid>
Date: Wed, 28 Oct 2009 18:34:29 +0100
Message-ID: <b88603c30910281034k4f2dafcwd0ba13b36894151d@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: multipart/mixed; boundary=000325559a6af8fe8804770234f9
Subject: Re: [Xenomai-help] Read TSC results in bus error (ARM iMX25)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--000325559a6af8fe8804770234f9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2009 at 5:42 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Henri Roosen wrote:
>> This code is part of the iMX25 bsp that is not part of any kernel yet,
>> so generating a patch is not possible. Seems the upcoming 2.6.32
>> kernel will have support for iMX25, but the -rc5 still has
>> build-failures for this platform.
>
> Ok. But could you point me to the code in the mach-mx3 tree? I do not
> find any cpu.c. The Denx Qong box probably has the same issue as imx25,
> and I would be interested in fixing it.
>

Ok, now I noticed the cpu.c file is part of the bsp patches I put over
the 2.8.28 vanilla kernel. Please find it attached to this email. What
you are looking for is the s/w workaround part of post_cpu_init, which
removes the Supervisor mode protect bit from the AIPS.

>>
>> Maybe the complete BSP with ipipe for the iMX25 and 2.6.28 kernel
>> might be interesting for release (similar as the patch
>> ipipe-2.6.26-mxc.diff), but is still in an early development state:
>> now the latency app runs I see it runs fine only for a few minutes and
>> then gets overruns... asks for debugging ;-)
>
> Ok. You can try and use the I-pipe tracer. And make sure to run latency
> -p 1000. I can have a look at your I-pipe code to see if I do not see
> anything obvious.

I run with period 1000 already and will use the I-pipe tracer tomorrow
and see if I can find anything. Then your offer to have a look at the
I-pipe code is highly appreciated!

Thanks,
Henri

>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0Gilles
>
>

--000325559a6af8fe8804770234f9
Content-Type: text/x-csrc; charset=US-ASCII; name="cpu.c"
Content-Disposition: attachment; filename="cpu.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1cd6wvo0

LyoKICogIENvcHlyaWdodCAoQykgMjAwMSBEZWVwIEJsdWUgU29sdXRpb25zIEx0ZC4KICogIENv
cHlyaWdodCAyMDA0LTIwMDkgRnJlZXNjYWxlIFNlbWljb25kdWN0b3IsIEluYy4gQWxsIFJpZ2h0
cyBSZXNlcnZlZC4KICoKICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4g
cmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRo
ZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMKICogcHVibGlzaGVkIGJ5
IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCiAqCiAqLwoKLyohCiAqIEBmaWxlIG1hY2gt
bXgzL2NwdS5jCiAqCiAqIEBicmllZiBUaGlzIGZpbGUgY29udGFpbnMgdGhlIENQVSBpbml0aWFs
aXphdGlvbiBjb2RlLgogKgogKiBAaW5ncm91cCBNU0xfTVgzMQogKi8KCiNpbmNsdWRlIDxsaW51
eC90eXBlcy5oPgojaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiNpbmNsdWRlIDxsaW51eC9pbml0
Lmg+CiNpbmNsdWRlIDxtYWNoL2hhcmR3YXJlLmg+CiNpbmNsdWRlIDxsaW51eC9pby5oPgojaW5j
bHVkZSA8YXNtL2hhcmR3YXJlL2NhY2hlLWwyeDAuaD4KCi8qIQogKiBDUFUgaW5pdGlhbGl6YXRp
b24uIEl0IGlzIGNhbGxlZCBieSBmaXh1cF9teGNfYm9hcmQoKQogKi8Kdm9pZCBfX2luaXQgbXhj
X2NwdV9pbml0KHZvaWQpCnsKCS8qIFNldHVwIFBlcmlwaGVyYWwgUG9ydCBSZW1hcCByZWdpc3Rl
ciBmb3IgQVZJQyAqLwoJYXNtKCJsZHIgcjAsID0weEMwMDAwMDE1CQkJCVxuXAoJIG1jciBwMTUs
IDAsIHIwLCBjMTUsIGMyLCA0Iik7CglpZiAoIXN5c3RlbV9yZXYpIHsKCQlteGNfc2V0X3N5c3Rl
bV9yZXYoMHgzMSwgQ0hJUF9SRVZfMl8wKTsKCX0KfQoKLyohCiAqIFBvc3QgQ1BVIGluaXQgY29k
ZQogKgogKiBAcmV0dXJuIDAgYWx3YXlzCiAqLwpzdGF0aWMgaW50IF9faW5pdCBwb3N0X2NwdV9p
bml0KHZvaWQpCnsKCXZvaWQgKmwyX2Jhc2U7Cgl2b2xhdGlsZSB1bnNpZ25lZCBsb25nIGFpcHNf
cmVnOwoKCS8qIEluaXRpYWxpemUgTDIgY2FjaGUgKi8KCWwyX2Jhc2UgPSBpb3JlbWFwKEwyQ0Nf
QkFTRV9BRERSLCBTWl80Syk7CglpZiAobDJfYmFzZSkgewoJCWwyeDBfaW5pdChsMl9iYXNlLCAw
eDAwMDMwMDI0LCAweDAwMDAwMDAwKTsKCX0KCgkvKgoJICogUy9XIHdvcmthcm91bmQ6IENsZWFy
IHRoZSBvZmYgcGxhdGZvcm0gcGVyaXBoZXJhbCBtb2R1bGVzCgkgKiBTdXBlcnZpc29yIFByb3Rl
Y3QgYml0IGZvciBTRE1BIHRvIGFjY2VzcyB0aGVtLgoJICovCglfX3Jhd193cml0ZWwoMHgwLCBJ
T19BRERSRVNTKEFJUFMxX0JBU0VfQUREUiArIDB4NDApKTsKCV9fcmF3X3dyaXRlbCgweDAsIElP
X0FERFJFU1MoQUlQUzFfQkFTRV9BRERSICsgMHg0NCkpOwoJX19yYXdfd3JpdGVsKDB4MCwgSU9f
QUREUkVTUyhBSVBTMV9CQVNFX0FERFIgKyAweDQ4KSk7CglfX3Jhd193cml0ZWwoMHgwLCBJT19B
RERSRVNTKEFJUFMxX0JBU0VfQUREUiArIDB4NEMpKTsKCWFpcHNfcmVnID0gX19yYXdfcmVhZGwo
SU9fQUREUkVTUyhBSVBTMV9CQVNFX0FERFIgKyAweDUwKSk7CglhaXBzX3JlZyAmPSAweDAwRkZG
RkZGOwoJX19yYXdfd3JpdGVsKGFpcHNfcmVnLCBJT19BRERSRVNTKEFJUFMxX0JBU0VfQUREUiAr
IDB4NTApKTsKCglfX3Jhd193cml0ZWwoMHgwLCBJT19BRERSRVNTKEFJUFMyX0JBU0VfQUREUiAr
IDB4NDApKTsKCV9fcmF3X3dyaXRlbCgweDAsIElPX0FERFJFU1MoQUlQUzJfQkFTRV9BRERSICsg
MHg0NCkpOwoJX19yYXdfd3JpdGVsKDB4MCwgSU9fQUREUkVTUyhBSVBTMl9CQVNFX0FERFIgKyAw
eDQ4KSk7CglfX3Jhd193cml0ZWwoMHgwLCBJT19BRERSRVNTKEFJUFMyX0JBU0VfQUREUiArIDB4
NEMpKTsKCWFpcHNfcmVnID0gX19yYXdfcmVhZGwoSU9fQUREUkVTUyhBSVBTMl9CQVNFX0FERFIg
KyAweDUwKSk7CglhaXBzX3JlZyAmPSAweDAwRkZGRkZGOwoJX19yYXdfd3JpdGVsKGFpcHNfcmVn
LCBJT19BRERSRVNTKEFJUFMyX0JBU0VfQUREUiArIDB4NTApKTsKCglyZXR1cm4gMDsKfQoKcG9z
dGNvcmVfaW5pdGNhbGwocG9zdF9jcHVfaW5pdCk7Cg==
--000325559a6af8fe8804770234f9--


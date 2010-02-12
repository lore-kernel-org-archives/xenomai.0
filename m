MIME-Version: 1.0
In-Reply-To: <b88603c31002090214j2d21f572sba26ed3883bc0612@domain.hid>
References: <20100204105700.GB20669@domain.hid>
	<b88603c31002050439n790f4f71kd6e152198de511f2@domain.hid>
	<4B6C1E66.2000008@domain.hid> <4B6C2D59.9060200@domain.hid>
	<b88603c31002050727p1decfdacm919d3f2278fdf2f0@domain.hid>
	<4B7019AA.8020102@domain.hid>
	<b88603c31002080633v1b9ee7b4s2a6ee82eeaab644d@domain.hid>
	<4B71339F.6050300@domain.hid> <4B713462.6000300@domain.hid>
	<b88603c31002090214j2d21f572sba26ed3883bc0612@domain.hid>
Date: Fri, 12 Feb 2010 16:57:22 +0100
Message-ID: <b88603c31002120757m386b5662nd8844a8fbccb22f0@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: multipart/mixed; boundary=001485f44d50b24e06047f6952bc
Subject: Re: [Xenomai-help] Force switch back to primary domain
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

--001485f44d50b24e06047f6952bc
Content-Type: text/plain; charset=ISO-8859-1

Ok, found some time to investigate the mutex problem we see on 2.5.1.

I managed to reproduce with a basic app that uses the same way of
thread creation as we have in our app.
Please find attached the basic app. Note, it runs fine on Xenomai
2.4.10. Fails on 2.5.1.

Also, the problem does not show when creating the threads with rt_task_create.

So the main question is, should it be possible to create threads with
the clone() system call and then shadowing the threads into the
Xenomai domain with rt_task_shadow()? And are we just lucky it runs
this way in 2.4.10?

Thanks,
Henri.

On Tue, Feb 9, 2010 at 11:14 AM, Henri Roosen <henriroosen@domain.hid> wrote:
> It is a generic x86 configuration. Please find attached the .config file we use.
>
> And note that I still think it is a problem in our application... I
> have the feeling there is a problem around our mutex initialization
> code. I might find some time this evening to dig into it a little...
>
> Thanks,
> Henri
>
> On Tue, Feb 9, 2010 at 11:09 AM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>> Gilles Chanteperdrix wrote:
>>> Henri Roosen wrote:
>>>> We run on an x86 (32bit) system on chip (VortexDX chip).
>>>
>>> I could not find the sources for the vortexDX kernel, do they exist, or
>>> are you using a generic x86 configuration?
>>
>> To my knowledge, this thing is supposed to work with generic, though
>> pre-historic (PIT/PIC), settings.
>>
>> Jan
>>
>> --
>> Siemens AG, Corporate Technology, CT T DE IT 1
>> Corporate Competence Center Embedded Linux
>>
>

--001485f44d50b24e06047f6952bc
Content-Type: text/x-csrc; charset=US-ASCII; name="mutex_xeno_native.c"
Content-Disposition: attachment; filename="mutex_xeno_native.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5l62g3j1

I2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdGRpby5o
PgojaW5jbHVkZSA8c3lzL21tYW4uaD4JCS8qIE5lZWRlZCBmb3IgbWxvY2thbGwoKSAqLwojaW5j
bHVkZSA8bGltaXRzLmg+CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgojaW5jbHVkZSA8bmF0aXZl
L211dGV4Lmg+CiNpbmNsdWRlIDxzY2hlZC5oPgoKI2RlZmluZSBOVU1fVEhSRUFEUyAgIDIKI2Rl
ZmluZSBNWV9TVEFDS19TSVpFICgxMDAqMTAyNCkgICAgICAvKiAxMDAga0IgaXMgZW5vdWdoIGZv
ciBub3cuICovCgpzdGF0aWMgUlRfVEFTSyBydF90YXNrX2Rlc2NbTlVNX1RIUkVBRFNdOwoKc3Rh
dGljIFJUX01VVEVYIG11dGV4OwpzdGF0aWMgaW50IHdhaXQwID0gMTsKc3RhdGljIGludCB3YWl0
MSA9IDE7CgpzdGF0aWMgY2hhciAqc3RhY2swOwpzdGF0aWMgY2hhciAqc3RhY2sxOwoKI2RlZmlu
ZSBNQUlOX1RBU0tfUFJJTyA0CiNkZWZpbmUgVEhSRUFEX1BSSU8gICAgMwoKI2RlZmluZSBQUk5U
KHMpIGZwcmludGYoc3RkZXJyLCBzKTsgZmZsdXNoKHN0ZGVycikKCmludCBoYW5kbGVyMCh2b2lk
ICpjb29raWUpCnsKCWlmIChydF90YXNrX3NoYWRvdygmcnRfdGFza19kZXNjWzBdLCAidGhyZWFk
MCIsIFRIUkVBRF9QUklPLCAwKSkgewoJCVBSTlQoIiEgRVJST1Igc2hhZG93IDFcbiIpOwoJCWV4
aXQoRVhJVF9GQUlMVVJFKTsKCX0KCglQUk5UKCJoYW5kbGVyMCBzdGFydGVkXG4iKTsKCXdoaWxl
ICh3YWl0MCkgewoJCVBSTlQoIi0+MFxuIik7CgkJaWYgKHJ0X211dGV4X2FjcXVpcmUoJm11dGV4
LCBUTV9JTkZJTklURSkpIHsKCQkJUFJOVCgiISBFUlJPUiBhY2MgMFxuIik7CgkJCWV4aXQoRVhJ
VF9GQUlMVVJFKTsKCQl9CgkJUFJOVCgiLSAwXG4iKTsKCQlpZiAocnRfbXV0ZXhfcmVsZWFzZSgm
bXV0ZXgpKSB7CgkJCVBSTlQoIiEgRVJST1IgcmVsIDBcbiIpOwoJCQlleGl0KEVYSVRfRkFJTFVS
RSk7CgkJfQoJCQoJCVBSTlQoIjwtMFxuIik7Cgl9CgoJUFJOVCgiaGFuZGxlcjAgZmluaXNoZWRc
biIpOwoJcnRfdGFza19kZWxldGUoTlVMTCk7CglyZXR1cm4gMDsKfQoKaW50IGhhbmRsZXIxKHZv
aWQgKmNvb2tpZSkKewoJaWYgKHJ0X3Rhc2tfc2hhZG93KCZydF90YXNrX2Rlc2NbMV0sICJ0aHJl
YWQxIiwgVEhSRUFEX1BSSU8sIDApKSB7CgkJUFJOVCgiISBFUlJPUiBzaGFkb3cgMVxuIik7CgkJ
ZXhpdChFWElUX0ZBSUxVUkUpOwoJfQoKCVBSTlQoImhhbmRsZXIxIHN0YXJ0ZWRcbiIpOwoJd2hp
bGUgKHdhaXQxKSB7CgkJUFJOVCgiLT4xXG4iKTsKCQlpZiAocnRfbXV0ZXhfYWNxdWlyZSgmbXV0
ZXgsIFRNX0lORklOSVRFKSkgewoJCQlQUk5UKCIhIEVSUk9SIGFjYyAxXG4iKTsKCQkJZXhpdChF
WElUX0ZBSUxVUkUpOwoJCX0KCQlQUk5UKCItIDFcbiIpOwoJCWlmIChydF9tdXRleF9yZWxlYXNl
KCZtdXRleCkpIHsKCQkJUFJOVCgiISBFUlJPUiByZWwgMVxuIik7CgkJCWV4aXQoRVhJVF9GQUlM
VVJFKTsKCQl9CgkJUFJOVCgiPC0xXG4iKTsKCX0KCglQUk5UKCJoYW5kbGVyMSBmaW5pc2hlZFxu
Iik7CglydF90YXNrX2RlbGV0ZShOVUxMKTsKCXJldHVybiAwOwp9CgppbnQgbWFpbih2b2lkKQp7
CgltbG9ja2FsbChNQ0xfQ1VSUkVOVCB8IE1DTF9GVVRVUkUpOwoKCWlmIChydF9tdXRleF9jcmVh
dGUoJm11dGV4LCAibXV0ZXgiKSkgewoJCVBSTlQoIiEgRVJST1IgY3JlYXRlXG4iKTsKCQlleGl0
KEVYSVRfRkFJTFVSRSk7Cgl9CgkJCglzdGFjazAgPSAoY2hhciAqKW1hbGxvYyhNWV9TVEFDS19T
SVpFKTsKCXN0YWNrMSA9IChjaGFyICopbWFsbG9jKE1ZX1NUQUNLX1NJWkUpOwoKCWNsb25lKGhh
bmRsZXIwLCBzdGFjazAgKyBNWV9TVEFDS19TSVpFLCBDTE9ORV9GSUxFUyB8IENMT05FX0ZTIHwK
CQkJQ0xPTkVfSU8gfCBDTE9ORV9TSUdIQU5EIHwgQ0xPTkVfVk0sIE5VTEwpOwoJY2xvbmUoaGFu
ZGxlcjEsIHN0YWNrMSArIE1ZX1NUQUNLX1NJWkUsIENMT05FX0ZJTEVTIHwgQ0xPTkVfRlMgfAoJ
CQlDTE9ORV9JTyB8IENMT05FX1NJR0hBTkQgfCBDTE9ORV9WTSwgTlVMTCk7CgoJUFJOVCgiUHJl
c3MgPEVOVEVSPiB0byBleGl0XG4iKTsKCWdldGMoc3RkaW4pOwoKCXdhaXQwID0gMDsKCXdhaXQx
ID0gMDsKCglQUk5UKCJtYWluIGZpbmlzaGVkXG4iKTsKCXJldHVybiAwOwp9Cgo=
--001485f44d50b24e06047f6952bc--


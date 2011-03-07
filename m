MIME-Version: 1.0
Sender: ismael.ilias@domain.hid
Date: Mon, 7 Mar 2011 10:18:28 +0100
Message-ID: <AANLkTik2mjdhFGGedWVVT=itGeusDPE=QbDhZCC7oD_+@mail.gmail.com>
From: Jonathan ILIAS-PILLET <ismael@domain.hid>
Content-Type: multipart/mixed; boundary=00163683408691785f049de0fa2e
Subject: [Xenomai-help] Program hangs using "rt_task_sleep" in a particular
	way
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: armadeus-forum@domain.hid

--00163683408691785f049de0fa2e
Content-Type: text/plain; charset=UTF-8

Hello,

We encounter a problem in a particular situation. In the attached
source, when we change the value passed to rt_task_sleep (line 35), the
program never returns.

This appears only with values greater or equal to 100000 (and maybe some
other values between 10000 and 100000) and only when we use
rt_task_sleep between the two rt_task_spawn calls.

Is there something we've done wrong ?

We use and Armadeus APF27 platform. I don't know if this behavior is
related to this architecture, to Xenomai or both.

-- 
Jonathan ILIAS-PILLET

--00163683408691785f049de0fa2e
Content-Type: text/x-csrc; charset=US-ASCII; name="projet_vierge.c"
Content-Disposition: attachment; filename="projet_vierge.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkz6aulw0

I2luY2x1ZGUgInV0aWxzLmgiCiNpbmNsdWRlIDxhc3NlcnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+
CiNpbmNsdWRlIDxuYXRpdmUvdGFzay5oPgogCmludCBDb21wdGV1cjE9MDsKaW50IENvbXB0ZXVy
Mj0wOwp2b2xhdGlsZSBpbnQgdGVzdDE9MDsKdm9sYXRpbGUgaW50IHRlc3QyPTA7Cgp2b2lkIFdv
cmtpbmdUYXNrMSgpCnsKCXdoaWxlKHRlc3QxPT0wKQoJewoJCUNvbXB0ZXVyMSsrOwoJfQp9Cgp2
b2lkIFdvcmtpbmdUYXNrMigpCnsgCgl3aGlsZSh0ZXN0Mj09MCkKCXsKCQlDb21wdGV1cjIrKzsK
CX0KfQoKdm9pZCBnbyAoKQp7CglpbnQgZXJyZXVyOwoJUlRfVEFTSyBSdF9Xb3JraW5nX3Rhc2sx
OwoJUlRfVEFTSyBSdF9Xb3JraW5nX3Rhc2syOwoKCXJ0X3Rhc2tfc3Bhd24gKCZSdF9Xb3JraW5n
X3Rhc2sxLCAiV29ya2luZ1Rhc2sxIiwgREVGQVVMVF9TVEFDS19TSVpFLDEwLCBUX0ZQVXxUX0pP
SU5BQkxFLCAmV29ya2luZ1Rhc2sxLCBOVUxMKTsKICAKICBydF90YXNrX3NsZWVwKDEwMDAwMCk7
IC8vIGRvZXMgbm90IHdvcmsKICAvL3J0X3Rhc2tfc2xlZXAoMTAwMDApOyAgLy8gd29ya3MKCgly
dF90YXNrX3NwYXduICgmUnRfV29ya2luZ190YXNrMiwgIldvcmtpbmdUYXNrMiIsIERFRkFVTFRf
U1RBQ0tfU0laRSwgMjAsIFRfRlBVfFRfSk9JTkFCTEUsICZXb3JraW5nVGFzazIsIE5VTEwpOwoK
CXRlc3QxPTE7Cgl0ZXN0Mj0xOwp9CgppbnQgbWFpbiAodm9pZCkKewogIFJUX1RBU0sgUnRfbWFp
bl90YXNrOwogIGludCBlcnJldXI7CgogIGVycmV1ciA9IG1sb2NrYWxsKCBNQ0xfQ1VSUkVOVCB8
IE1DTF9GVVRVUkUgKTsKICBhc3NlcnQgKGVycmV1ciA9PSAwKTsKCiAgZXJyZXVyID0gcnRfdGFz
a19zcGF3biAoJlJ0X21haW5fdGFzaywgImdvIiwgREVGQVVMVF9TVEFDS19TSVpFLCA1MCwgVF9G
UFUgfCBUX0pPSU5BQkxFLCAmZ28sIE5VTEwpOwogIGFzc2VydCAoZXJyZXVyID09IDApOwoKICBl
cnJldXIgPSBydF90YXNrX2pvaW4oJlJ0X21haW5fdGFzayk7CiAgYXNzZXJ0IChlcnJldXIgPT0g
MCk7CiAgCiAgcHJpbnRmKCJGaW4gZHUgcHJvZ3JhbW1lXHJcbiIpOwogIAogIHJldHVybiAwOwp9
Cg==
--00163683408691785f049de0fa2e--


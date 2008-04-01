Message-ID: <2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>
Date: Tue, 1 Apr 2008 16:03:03 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F23E9E.7060801@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4637_16786750.1207058583761"
References: <47ED5DE3.60202@domain.hid>
	<18413.34914.638951.575098@domain.hid>
	<47ED9D05.7060707@domain.hid>
	<18415.63399.305120.344817@domain.hid>
	<47F062DE.5000709@domain.hid>
	<18417.18371.183857.809430@domain.hid>
	<18417.18921.588809.645062@domain.hid>
	<47F17B32.7070505@domain.hid>
	<18417.52630.8850.939898@domain.hid>
	<47F23E9E.7060801@domain.hid>
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_4637_16786750.1207058583761
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Apr 1, 2008 at 3:54 PM, Tomas Kalibera <kalibera@domain.hid> wrote:
>
> Gilles Chanteperdrix wrote:
>  > Tomas Kalibera wrote:
>  >  >
>  >  > I added a missing underscore and re-tried, and none of the debug
>  >  > messages was printed. I added another one to make sure that there is not
>  >  > a problem with getting printk messages to the serial console. The
>  >  > resulting highmem_32.c and the output is attached.
>  >  >
>  >  > T
>  >
>  > The interesting part of the output is the printk which occurs right
>  > before the first bug, what happens afterwards is of little use. Do you
>  > get any output before the first bug ?
>  >
>  There is no output before the first bug. This is why I added the other
>  printk to make sure there is always one on the path leading to the
>  BUG(). After I did that, the newly added message ("type is NOT
>  KM_USER0") appeared in the serial console log after the bug. This is
>  what made me believe that this is the printk we care about, and why I
>  included the longer output.

Ok. In the mean time, I think I may have found the reason for the
crash. Try this patch, you should get a printk and a stack trace
instead of the bug.

-- 
 Gilles

------=_Part_4637_16786750.1207058583761
Content-Type: application/octet-stream; name=ipipe-kmap_atomic-bug.4.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_feijg4cp0
Content-Disposition: attachment; filename=ipipe-kmap_atomic-bug.4.diff

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL2hpZ2htZW1fMzIuYyBiL2FyY2gveDg2L21tL2hpZ2ht
ZW1fMzIuYwppbmRleCAxYzNiZjk1Li5mNGJhZTNiIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9tbS9o
aWdobWVtXzMyLmMKKysrIGIvYXJjaC94ODYvbW0vaGlnaG1lbV8zMi5jCkBAIC02OSw2ICs2OSw5
IEBAIHZvaWQga3VubWFwX2F0b21pYyh2b2lkICprdmFkZHIsIGVudW0ga21fdHlwZSB0eXBlKQog
CQlCVUdfT04odmFkZHIgPCBQQUdFX09GRlNFVCk7CiAJCUJVR19PTih2YWRkciA+PSAodW5zaWdu
ZWQgbG9uZyloaWdoX21lbW9yeSk7CiAjZW5kaWYKKwkJcHJpbnRrKCJXcm9uZyBhZGRyZXNzIHBh
c3NlZCB0byBrdW5tYXBfYXRvbWljIVxuIik7CisJCXNob3dfc3RhY2soTlVMTCwgTlVMTCk7CisJ
CWtwdGVfY2xlYXJfZmx1c2goa21hcF9wdGUtaWR4LCBfX2ZpeF90b192aXJ0KEZJWF9LTUFQX0JF
R0lOK2lkeCkpOwogCX0KIAogCWFyY2hfZmx1c2hfbGF6eV9tbXVfbW9kZSgpOwo=
------=_Part_4637_16786750.1207058583761--


MIME-Version: 1.0
In-Reply-To: <4C1353D8.2060507@domain.hid>
References: <AANLkTim0tClnDQPN3u5ozJSEU6BcX--Xf9Ekw00ADvgy@domain.hid>
	<4C1353D8.2060507@domain.hid>
Date: Sat, 12 Jun 2010 18:13:56 +0800
Message-ID: <AANLkTik39wezPyRC-myOQi_etA5EPAg-LgzSqyO40IX7@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: multipart/mixed; boundary=000e0cd6ac9876cb070488d283c7
Subject: Re: [Xenomai-help] error on rt_dev_read, code Success,
	what does it 	mean?
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

--000e0cd6ac9876cb070488d283c7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks. I looked my code again, which is modified from example
cross-link.c. The section looks like:

...
                 irq_time =3D rx_event.rxpend_timestamp;
                read =3D rt_dev_read(read_fd, &write_time, sz);
                if (read =3D=3D sz) {
                        read_time =3D rt_timer_read();
                        printf("%3d |%16llu |%16llu |%16llu\n", nr,
                               irq_time  - write_time,
                               read_time - irq_time,
                               read_time - write_time);
                        nr++;
                } else if (read < 0 ) {
                        printf(RTASK_PREFIX "error on rt_dev_read, code %s\=
n",
                               strerror(-err)); <<<<<<<=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
                        break;
                } else {
                        printf(RTASK_PREFIX "only %d / %d byte received \n"=
,
                               read, sz);
                        break;
                }
...
I guess I should change the strerror(-err) to strerror(-read). If I do
that, I some
times get a " code input/output error". That is better. What can cause
input/output error? I get my serial port in that state consistently
when I
finish running my GPS program. I can reset it to a usable serial port
again by remove and re-load xeno-16550A module. But setserial -G can't
see anything unusual. Could it be some unclosed serial port?

My simple code is attached.

Thanks,

Everett







On Sat, Jun 12, 2010 at 5:31 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Everett Wang wrote:
>> Hi,
>>
>> I am developing a real time programming using xenomai, RTDM. When
>> I try to read serial port, I sometimes get this message:
>>
>> error on rt_dev_read, code Success
>>
>> I checked my program and found that when rt_dev_read returns a
>> negative number, this message is printed. What does this error message
>> mean? It seems that my port is open when I tried to read from it.
>
> It means that you are probably using errno, and since rt_dev_read does
> not set errno, you get "Success" as error message instead of the real
> error message. If you want to print the real error message, you should
> use strerror(-rc) where rc is the return code of rt_dev_read.
>
> But of course, I am just guessing here, seeing your test code would help
> more.
>
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0Gilles.
>

--000e0cd6ac9876cb070488d283c7
Content-Type: text/x-csrc; charset=US-ASCII; name="gps.c"
Content-Disposition: attachment; filename="gps.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gacaa4lj0

LyoKICogZ3BzLmMKICogUmVhZCBncHMgZGV2aWNlIHBlcmlvZGljYWxseSwgY29tcHV0ZSBkZWxh
eSBhbmQgaml0dGVyaW5nCiAqLwoKCiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c2lnbmFs
Lmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+CgojaW5jbHVkZSA8
bmF0aXZlL3Rhc2suaD4KI2luY2x1ZGUgPG5hdGl2ZS90aW1lci5oPgoKI2luY2x1ZGUgPHJ0ZG0v
cnRzZXJpYWwuaD4KCiNkZWZpbmUgTUFJTl9QUkVGSVggICAibWFpbiA6ICIKI2RlZmluZSBTVEFT
S19QUkVGSVggICJncHNfdGFzazogIgoKI2RlZmluZSBHUFNfRklMRQkicnRzZXIwIgoKI2RlZmlu
ZSBTVEFURV9GSUxFX09QRU5FRCAgICAgICAgIDEKI2RlZmluZSBTVEFURV9UQVNLX0NSRUFURUQg
ICAgICAgIDIKCiNkZWZpbmUgU1NJWkUJNDUwCgppbnQgZ3BzX2ZkID0gLTE7Cgp1bnNpZ25lZCBp
bnQgZ3BzX3N0YXRlID0gMDsKCi8qICAgICAgICAgICAgICAgICAgICAgICAgICAgLS1zLW1zLXVz
LW5zICovClJUSU1FIGdwc190YXNrX3BlcmlvZF9ucyA9ICAgIDEwMDAwMDAwMGxsdTsKUlRfVEFT
SyBncHNfdGFzazsKUlRJTUUgdHJpZ2dlcl90aW1lOwoKc3RhdGljIGNvbnN0IHN0cnVjdCBydHNl
cl9jb25maWcgZ3BzX2NvbmZpZyA9IHsKCS5jb25maWdfbWFzayAgICAgICA9IDB4RkZGRiwKCS5i
YXVkX3JhdGUgICAgICAgICA9IDExNTIwMCwKCS5wYXJpdHkgICAgICAgICAgICA9IFJUU0VSX0RF
Rl9QQVJJVFksCgkuZGF0YV9iaXRzICAgICAgICAgPSBSVFNFUl9ERUZfQklUUywKCS5zdG9wX2Jp
dHMgICAgICAgICA9IFJUU0VSX0RFRl9TVE9QQiwKCS5oYW5kc2hha2UgICAgICAgICA9IFJUU0VS
X0RFRl9IQU5ELAoJLmZpZm9fZGVwdGggICAgICAgID0gUlRTRVJfREVGX0ZJRk9fREVQVEgsCgku
cnhfdGltZW91dCAgICAgICAgPSA0MDAwMDAwMCwJLyogNDAgbXMgKi8KCS50eF90aW1lb3V0ICAg
ICAgICA9IFJUU0VSX0RFRl9USU1FT1VULAoJLmV2ZW50X3RpbWVvdXQgICAgID0gMTAwMDAwMDAw
LCAvKiAwLjEgcyAqLwoJLnRpbWVzdGFtcF9oaXN0b3J5ID0gUlRTRVJfUlhfVElNRVNUQU1QX0hJ
U1RPUlksCgkuZXZlbnRfbWFzayAgICAgICAgPSBSVFNFUl9FVkVOVF9SWFBFTkQsCn07CgpzdGF0
aWMgaW50IGNsb3NlX2ZpbGUoIGludCBmZCwgY2hhciAqbmFtZSkKewoJaW50IGVyciwgaT0wOwoJ
CglkbyB7CgkJaSsrOwoJCWVyciA9IHJ0X2Rldl9jbG9zZShmZCk7CgkJc3dpdGNoIChlcnIpIHsK
CQljYXNlIC1FQUdBSU46CgkJCXByaW50ZihNQUlOX1BSRUZJWCAiJXMgLT4gRUFHQUlOICglZCB0
aW1lcylcbiIsCgkJCSAgICAgICBuYW1lLCBpKTsKCQkJcnRfdGFza19zbGVlcCg1MDAwMCk7IC8q
IHdhaXQgNTB1cyAqLwoJCQlicmVhazsKCQljYXNlIDA6CgkJCXByaW50ZihNQUlOX1BSRUZJWCAi
JXMgLT4gY2xvc2VkXG4iLCBuYW1lKTsKCQkJYnJlYWs7CgkJZGVmYXVsdDoKCQkJcHJpbnRmKE1B
SU5fUFJFRklYICIlcyAtPiAlc1xuIiwgbmFtZSwKCQkJICAgICAgIHN0cmVycm9yKC1lcnIpKTsK
CQkJYnJlYWs7CgkJfQoJfSB3aGlsZSAoZXJyID09IC1FQUdBSU4gJiYgaSA8IDEwKTsKCglyZXR1
cm4gZXJyOwp9Cgp2b2lkIGNsZWFudXBfYWxsKHZvaWQpCnsKCWlmIChncHNfc3RhdGUgJiBTVEFU
RV9GSUxFX09QRU5FRCkgewoJCWNsb3NlX2ZpbGUoZ3BzX2ZkLCBHUFNfRklMRSAiIChncHMpIik7
CgkJZ3BzX3N0YXRlICY9IH5TVEFURV9GSUxFX09QRU5FRDsKCX0KCQoJaWYgKGdwc19zdGF0ZSAm
IFNUQVRFX1RBU0tfQ1JFQVRFRCkgewoJCXByaW50ZihNQUlOX1BSRUZJWCAiZGVsZXRlIGdwc190
YXNrXG4iKTsKCQlydF90YXNrX2RlbGV0ZSgmZ3BzX3Rhc2spOwoJCWdwc19zdGF0ZSAmPSB+U1RB
VEVfVEFTS19DUkVBVEVEOwoJfQoJCn0KCnZvaWQgY2F0Y2hfc2lnbmFsKGludCBzaWcpCnsKCWNs
ZWFudXBfYWxsKCk7CglwcmludGYoTUFJTl9QUkVGSVggImV4aXRcbiIpOwoJcmV0dXJuOwp9Cgp2
b2lkIGdwc190YXNrX3Byb2Modm9pZCAqYXJnKQp7CglpbnQgZXJyLCBuciA9IDA7Cglzc2l6ZV90
IHJlYWQgPSAwOwoJY2hhciBzZGF0YVtTU0laRV07Cglzc2l6ZV90IHNzID0gU1NJWkUqc2l6ZW9m
KGNoYXIpOwoJUlRJTUUgaXJxX3RpbWUgPSAwOwoJUlRJTUUgcmVhZF90aW1lID0gMDsKCVJUSU1F
IGxhc3RfdGltZSA9IDA7CglzdHJ1Y3QgcnRzZXJfZXZlbnQgcnhfZXZlbnQ7CgoJd2hpbGUgKDEp
IHsKIAkJLyogd2FpdGluZyBmb3IgZXZlbnQgKi8KCQllcnIgPSBydF9kZXZfaW9jdGwoZ3BzX2Zk
LCBSVFNFUl9SVElPQ19XQUlUX0VWRU5ULCAmcnhfZXZlbnQpOwogICAgICAgICAgICAgICAgaWYg
KGVycikgewogICAgICAgICAgICAgICAgICAgICAgICBwcmludGYoU1RBU0tfUFJFRklYCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAiZXJyb3Igb24gUlRTRVJfUlRJT0NfV0FJVF9FVkVO
VCwgJXNcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJlcnJvcigtZXJyKSk7
CiAgICAgICAgICAgICAgICAgICAgICAgIGlmIChlcnIgPT0gLUVUSU1FRE9VVCkKICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKICAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7CiAgICAgICAgICAgICAgICB9CgoJCWlycV90aW1lID0gcnhfZXZlbnQucnhwZW5kX3Rp
bWVzdGFtcDsKCgkJcmVhZCA9IHJ0X2Rldl9yZWFkKGdwc19mZCwgc2RhdGEsIHNzKTsKCQlpZiAo
cmVhZCA+PSAwKSB7CgkJCXJlYWRfdGltZSA9IHJ0X3RpbWVyX3JlYWQoKTsKCQkJcHJpbnRmKFNU
QVNLX1BSRUZJWCAiJTNkIHwgJTNkIHwgJTE2bGx1XG4iLCBuciwgcmVhZCwKCQkJICAgICAgIGly
cV90aW1lIC0gbGFzdF90aW1lKTsKLyoqCgkJCXByaW50ZihTVEFTS19QUkVGSVggIiUzZCB8ICUz
ZCB8ICUxNmxsdVxuIiwgbnIsIHJlYWQsCgkJCSAgICAgICByZWFkX3RpbWUgLSBpcnFfdGltZSk7
CgkJCWZvcihpPTA7aTxyZWFkO2krKykKCQkJCXByaW50ZigiJXggIiwgc2RhdGFbaV0pOwoqKi8K
CQkJcHJpbnRmKCJcbiIpOwoJCX0gZWxzZSB7CgkJCXByaW50ZihTVEFTS19QUkVGSVggImVycm9y
IG9uIHJ0X2Rldl9yZWFkLCBjb2RlICVzXG4iLAoJCQkgICAgICAgc3RyZXJyb3IoLXJlYWQpKTsK
CQkJYnJlYWs7CgkJfQoJCWxhc3RfdGltZSA9IGlycV90aW1lOwoKCQlucisrOwoJfQoKCWlmICgo
Z3BzX3N0YXRlICYgU1RBVEVfRklMRV9PUEVORUQpICYmCgkgICAgY2xvc2VfZmlsZShncHNfZmQs
IEdQU19GSUxFICIgKGdwcykiKSA9PSAwKQoJCWdwc19zdGF0ZSAmPSB+U1RBVEVfRklMRV9PUEVO
RUQ7CgoJcHJpbnRmKFNUQVNLX1BSRUZJWCAiZXhpdFxuIik7Cn0KCmludCBtYWluKGludCBhcmdj
LCBjaGFyKiBhcmd2W10pCnsKCWludCBlcnIgPSAwOwoKCXNpZ25hbChTSUdURVJNLCBjYXRjaF9z
aWduYWwpOwoJc2lnbmFsKFNJR0lOVCwgY2F0Y2hfc2lnbmFsKTsKCgkvKiBubyBtZW1vcnktc3dh
cHBpbmcgZm9yIHRoaXMgcHJvZ3JhbW0gKi8KCW1sb2NrYWxsKE1DTF9DVVJSRU5UIHwgTUNMX0ZV
VFVSRSk7CgoJLyogb3BlbiBydHNlcjAgKi8KCWdwc19mZCA9IHJ0X2Rldl9vcGVuKCBHUFNfRklM
RSwgMCk7CglpZiAoZ3BzX2ZkIDwgMCkgewoJCXByaW50ZihNQUlOX1BSRUZJWCAiY2FuJ3Qgb3Bl
biAlcyAoZ3BzKSwgJXNcbiIsIEdQU19GSUxFLAoJCSAgICAgICBzdHJlcnJvcigtZ3BzX2ZkKSk7
CgkJZ290byBlcnJvcjsKCX0KCWdwc19zdGF0ZSB8PSBTVEFURV9GSUxFX09QRU5FRDsKCXByaW50
ZihNQUlOX1BSRUZJWCAiZ3BzLWZpbGUgb3BlbmVkXG4iKTsKCgkvKiB3cml0aW5nIGdwcy1jb25m
aWcgKi8KCWVyciA9IHJ0X2Rldl9pb2N0bChncHNfZmQsIFJUU0VSX1JUSU9DX1NFVF9DT05GSUcs
ICZncHNfY29uZmlnKTsKCWlmIChlcnIpIHsKCQlwcmludGYoTUFJTl9QUkVGSVggImVycm9yIHdo
aWxlIFJUU0VSX1JUSU9DX1NFVF9DT05GSUcsICVzXG4iLAoJCSAgICAgICBzdHJlcnJvcigtZXJy
KSk7CgkJZ290byBlcnJvcjsKCX0KCXByaW50ZihNQUlOX1BSRUZJWCAiZ3BzLWNvbmZpZyB3cml0
dGVuXG4iKTsKCgoJLyogY3JlYXRlIGdwc190YXNrICovCgllcnIgPSBydF90YXNrX2NyZWF0ZSgm
Z3BzX3Rhc2ssICJncHNfdGFzayIsIDAsIDUwLCAwKTsKCWlmIChlcnIpIHsKCQlwcmludGYoTUFJ
Tl9QUkVGSVggImZhaWxlZCB0byBjcmVhdGUgZ3BzX3Rhc2ssICVzXG4iLAoJCSAgICAgICBzdHJl
cnJvcigtZXJyKSk7CgkJZ290byBlcnJvcjsKCX0KCWdwc19zdGF0ZSB8PSBTVEFURV9UQVNLX0NS
RUFURUQ7CglwcmludGYoTUFJTl9QUkVGSVggImdwcy10YXNrIGNyZWF0ZWRcbiIpOwoKCgkvKiBz
dGFydCBncHNfdGFzayAqLwoJcHJpbnRmKE1BSU5fUFJFRklYICJzdGFydGluZyBncHMtdGFza1xu
Iik7CgllcnIgPSBydF90YXNrX3N0YXJ0KCZncHNfdGFzaywgJmdwc190YXNrX3Byb2MsIE5VTEwp
OwoJaWYgKGVycikgewoJCXByaW50ZihNQUlOX1BSRUZJWCAiZmFpbGVkIHRvIHN0YXJ0IGdwc190
YXNrLCAlc1xuIiwKCQkgICAgICAgc3RyZXJyb3IoLWVycikpOwoJCWdvdG8gZXJyb3I7Cgl9CgoJ
cGF1c2UoKTsKCXJldHVybiAwOwoKIGVycm9yOgoJY2xlYW51cF9hbGwoKTsKCXJldHVybiBlcnI7
Cn0KCg==
--000e0cd6ac9876cb070488d283c7--


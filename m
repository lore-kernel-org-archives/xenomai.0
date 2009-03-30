Content-Transfer-Encoding: 7bit
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C9B11A.4082EF7A"
Date: Mon, 30 Mar 2009 11:31:05 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A018D48CC@ARVMAIL1.mra.roland-man.biz>
From: <roderik.wildenburg@domain.hid>
Subject: [Xenomai-help] Some problems with shared memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9B11A.4082EF7A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have two problems with shared memory and Xenomai 2.4.6 (2.4.25 =
PPC-kernel):

1.) If I don=B4t page align the size of shared memory (multiple of 4096) =
I get the following error message :
"createshm mmap: No such device or address"

Detailed programm output of attached testprogram :
{
prompt # ./killtest -c &
[1] 104
prompt # createshm mmap: No such device or address
shmsize =3D 100000; errno : 6 =3D=3D Failed to create shm : -3
killtest user exit !
}

You can reproduce this effect by commenting out line 60 in the attached =
source file and calling the program as follows:

prompt # killtest -c


2.) If I create 2 processes which use the same shared memory and I kill =
the process which created the SHM before (!) the other process, which =
only uses the SHM, the whole system stalls.
You can reproduce this with the attached testprogramm by calling it in =
the following way :

prompt # ./killtest -c &
[1] 105
prompt # ./killtest &
[2] 106
prompt # kill 105
prompt # killtest user exit !
[1]-  Done                    ./killtest -c
prompt # kill 106

System stalls   =20


Is this a problem of Xenomai (Cleanup od SHM) or am I creating/deleting =
the SHM in a wrong way ?
Could you please try to reproduce this problem ?

Many thanks in advance
Roderik

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

------_=_NextPart_001_01C9B11A.4082EF7A
Content-Type: application/octet-stream;
	name="killtest.c"
Content-Transfer-Encoding: base64
Content-Description: killtest.c
Content-Disposition: attachment;
	filename="killtest.c"

LyoKICoga2lsbHRlc3QuYwogKgogKiAgQ3JlYXRlZCBvbjogMjQuMDMuMjAwOQogKiAgICAgIEF1
dGhvcjogYXJvd2lsCiAqLwoKI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4K
I2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN0ZGlv
Lmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN5cy90aW1leC5oPgojaW5jbHVkZSA8
c3lzL3NvY2tldC5oPgojaW5jbHVkZSA8bmV0aW5ldC9pbi5oPgojaW5jbHVkZSA8bmV0ZGIuaD4K
I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPGZjbnRs
Lmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CgoKI2RlZmluZSBTSE1OQU1FICIvdGVzdHNobSIKCmNo
YXIgKnRlc3RzaG09TlVMTDsKaW50IHNobWZkPS0xOwppbnQgc2htc2l6ZT0wOwppbnQgY3JlYXRl
PTA7CmludCBmaW5pc2hlZD0wOwpwdGhyZWFkX3QgdGVzdHRhc2tpZDsKCmludCBjcmVhdGVzaG0o
Y2hhciAqKnNobWJ1ZiwgaW50ICpzaG1mZCwgaW50IGNyZWF0ZSkKewogICBpbnQgcmV0LCBzaG1z
aXplPTA7CiAgIGludCBvZmxhZ3M7CiAgIGNoYXIgKnRzaG07CgogICB0c2htPU1BUF9GQUlMRUQ7
CiAgIHJldD0wOwogICAqc2htYnVmPU5VTEw7CiAgICpzaG1mZD0tMTsKCiAgIGlmKGNyZWF0ZSkK
ICAgICAgb2ZsYWdzPU9fQ1JFQVQgfCBPX1JEV1I7CiAgIGVsc2UKICAgICAgb2ZsYWdzPU9fUkRX
UjsKCiAgICpzaG1mZCA9IHNobV9vcGVuKFNITU5BTUUsIG9mbGFncywgMCk7CiAgIGlmICgqc2ht
ZmQgPT0gLTEpCiAgIHsKICAgICAgIHByaW50Zigic2htX29wZW4gZmFpbHMuIGVycm5vPSVkIFNI
TTolc1xuIixlcnJubyxTSE1OQU1FKTsKICAgICAgIHBlcnJvcigic2htX29wZW4iKTsKICAgICAg
IHJldD0tMTsKICAgICAgIGdvdG8gY3JlYXRlc2htZXhpdDsKICAgfQoKICAgLypTSE0tU2l6ZSov
CiAgIHNobXNpemU9MTAwMDAwOwogICBzaG1zaXplPSgoc2htc2l6ZT4+MTIpKzEpPDwxMjsgLypw
YWdlICg0MDk2KSBhbGlnbiovCiAgIHJldD1zaG1zaXplOwogICBpZiAoZnRydW5jYXRlKCpzaG1m
ZCxzaG1zaXplKSA9PSAtMSkKICAgewogICAgICBwcmludGYoImZ0cnVuY2F0ZSBmYWlscy4gZXJy
bm89JWRcbiIsZXJybm8pOwogICAgICByZXQ9LTI7CiAgICAgIGdvdG8gY3JlYXRlc2htZXhpdDsK
ICAgfQoKICAgLyogTWFwIHNoYXJlZCBtZW1vcnkgb2JqZWN0ICovCiAgIHRzaG0gPSBtbWFwKE5V
TEwsIHNobXNpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsIE1BUF9TSEFSRUQsICpzaG1mZCwg
MCk7CiAgIGlmKHRzaG09PU1BUF9GQUlMRUQpCiAgIHsKICAgICAgcHJpbnRmKCJzaG1zaXplID0g
JWQ7IGVycm5vIDogJWQgPT0gIiwgc2htc2l6ZSwgZXJybm8pOwogICAgICBwZXJyb3IoImNyZWF0
ZXNobSBtbWFwIik7CiAgICAgIHJldD0tMzsKICAgICAgZ290byBjcmVhdGVzaG1leGl0OwogICB9
CiAgIGVsc2UKICAgewogICAgICBpZihjcmVhdGUpCiAgICAgIHsKICAgICAgICAgbWVtc2V0KHRz
aG0sMCxzaG1zaXplKTsKICAgICAgfQogICB9CgogICAqc2htYnVmPXRzaG07CgpjcmVhdGVzaG1l
eGl0IDoKICAgaWYocmV0PDApCiAgIHsKICAgICAgaWYodHNobSE9TUFQX0ZBSUxFRCkKICAgICAg
ewogICAgICAgICBtdW5tYXAodHNobSxzaG1zaXplKTsKICAgICAgfQogICAgICBpZigqc2htZmQ+
PTApCiAgICAgIHsKICAgICAgICAgc2htX3VubGluayhTSE1OQU1FKTsKICAgICAgICAgY2xvc2Uo
KnNobWZkKTsKICAgICAgfQogICAgICAqc2htYnVmPU5VTEw7CiAgICAgICpzaG1mZD0tMTsKICAg
fQoKICAgcmV0dXJuKHJldCk7Cn0KCnZvaWQgZGVsZXRlc2htKGNoYXIgKnRlc3RzaG0sIGludCBz
aG1zaXplLCBpbnQgc2htZmQsIGludCBjcmVhdGUpCnsKICAgaWYoICh0ZXN0c2htIT1OVUxMKSAm
JiAoc2htZmQhPS0xKSApCiAgIHsKICAgICAgbXVubWFwKHRlc3RzaG0sc2htc2l6ZSk7CiAgICAg
IGlmKGNyZWF0ZSkKICAgICAgICAgc2htX3VubGluayhTSE1OQU1FKTsKICAgICAgY2xvc2Uoc2ht
ZmQpOwogICAgICBzaG1mZD0tMTsKICAgfQp9Cgp2b2lkIHVzZXJfZXhpdCh2b2lkKQp7CiAgIGlm
KGNyZWF0ZSkKICAgICAgZGVsZXRlc2htKHRlc3RzaG0sc2htc2l6ZSxzaG1mZCxjcmVhdGUpOwog
ICBwcmludGYoImtpbGx0ZXN0IHVzZXIgZXhpdCAhXG4iKTsKfQoKCgp2b2lkIHNpZ2hhbmQoaW50
IHNpZyBfX2F0dHJpYnV0ZV9fICgodW51c2VkKSkpCnsKICAgZmluaXNoZWQgPSAxOwp9CgppbnQg
bWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQp7CiAgIGludCBjOwoKICAgd2hpbGUoIChjID0g
Z2V0b3B0KGFyZ2MsIGFyZ3YsICJjIikpICE9IEVPRikKICAgewogICAgICBzd2l0Y2ggKGMpCiAg
ICAgIHsKICAgICAgICAgY2FzZSAnYyc6IC8vIGNyZWF0ZSBTSE0KICAgICAgICAgICAgY3JlYXRl
PTE7CiAgICAgICAgICAgIGJyZWFrOwogICAgICAgICBkZWZhdWx0OgogICAgICAgICAgICBwcmlu
dGYoImtpbGx0ZXN0IFstY11cbiIpOwogICAgICAgICAgICByZXR1cm4oMCk7CiAgICAgICAgICAg
IGJyZWFrOwogICAgICB9CiAgIH0KCiAgIHNpZ25hbChTSUdJTlQsIHNpZ2hhbmQpOwogICBzaWdu
YWwoU0lHVEVSTSwgc2lnaGFuZCk7CiAgIHNpZ25hbChTSUdIVVAsIHNpZ2hhbmQpOwogICBzaWdu
YWwoU0lHQUxSTSwgc2lnaGFuZCk7CgoKICAgbWxvY2thbGwoTUNMX0NVUlJFTlR8TUNMX0ZVVFVS
RSk7CgogICBpZiggKHNobXNpemU9Y3JlYXRlc2htKCZ0ZXN0c2htLCAmc2htZmQsIGNyZWF0ZSkp
PDApCiAgIHsKICAgICAgcHJpbnRmKCJGYWlsZWQgdG8gY3JlYXRlIHNobSA6ICVkXG4iLHNobXNp
emUpOwogICAgICB1c2VyX2V4aXQoKTsKICAgICAgcmV0dXJuKC0xKTsKICAgfQoKICAgd2hpbGUg
KCFmaW5pc2hlZCkKICAgICAgcGF1c2UoKTsKCiAgIHVzZXJfZXhpdCgpOwoKICAgcmV0dXJuIDA7
Cn0K

------_=_NextPart_001_01C9B11A.4082EF7A
Content-Type: application/octet-stream;
	name="Makefile"
Content-Transfer-Encoding: base64
Content-Description: Makefile
Content-Disposition: attachment;
	filename="Makefile"

Q1JPU1NDT01QSUxFIDo9IHBwY182eHgKVEFSR0VUUyA6PSBraWxsdGVzdAoKWEVOT19QQVRIPS9v
cHQvZWxkay94ZW5vbWFpLTIuNC42ClhFTk9fQ09ORklHPSQoWEVOT19QQVRIKS9iaW4veGVuby1j
b25maWcKcHJlZml4IDo9ICQoc2hlbGwgJChYRU5PX0NPTkZJRykgLS1wcmVmaXgpCgppZmVxICgk
KHByZWZpeCksKQokKGVycm9yIFBsZWFzZSBhZGQgPHhlbm9tYWktaW5zdGFsbC1wYXRoPi9iaW4g
dG8geW91ciBQQVRIIHZhcmlhYmxlIG9yIHR5cGU6IFwKbWFrZSBYRU5PX0NPTkZJRz08eGVub21h
aS1pbnN0YWxsLXBhdGg+L2Jpbi94ZW5vLWNvbmZpZykKZW5kaWYKCkNGTEFHU19SVDo9ICQoc2hl
bGwgICQoWEVOT19DT05GSUcpIC0tcG9zaXgtY2ZsYWdzKSAtZyAtTyAtV2FsbCAKTERGTEFHU19S
VDo9ICQoc2hlbGwgICQoWEVOT19DT05GSUcpIC0tcG9zaXgtbGRmbGFncykKCkNDIDo9ICQoQ1JP
U1NDT01QSUxFKS1nY2MKCmFsbDogJChUQVJHRVRTKSAKCmtpbGx0ZXN0Lm86IGtpbGx0ZXN0LmMg
CgkkKENDKSAkKENGTEFHU19SVCkgJDwgLWMgLW8gJEAKCmtpbGx0ZXN0OiBraWxsdGVzdC5vIAoJ
JChDQykgICQoTERGTEFHU19SVCkgLVdhbGwgLW8gJEAgIGtpbGx0ZXN0Lm8KCgkKY2xlYW46Cgly
bSAqLm8gJChUQVJHRVRTKSAqLmFzbSA=

------_=_NextPart_001_01C9B11A.4082EF7A--


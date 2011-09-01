From: Sambasiva Rao Manchili <sambasiva.manchili@domain.hid>
Date: Thu, 1 Sep 2011 16:51:14 +0200
Message-ID: <509DA52866E38F47878413CF102D751FED236D783D@poseidon.nexus-ag.com>
References: <509DA52866E38F47878413CF102D751FED236D7830@domain.hid>
	<4E5F6E41.1050606@domain.hid>
	<509DA52866E38F47878413CF102D751FED236D7834@domain.hid>
	<4E5F753C.8070904@domain.hid>
In-Reply-To: <4E5F753C.8070904@domain.hid>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_509DA52866E38F47878413CF102D751FED236D783Dposeidonnexus_"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai-help@domain.hid" <Xenomai-help@domain.hid>

--_004_509DA52866E38F47878413CF102D751FED236D783Dposeidonnexus_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 Hi,
The reason that I have not given this piece of code was because it is not w=
ritten by me oflate but  was code that exists since several years which is =
running on VxWorks  on  different versions.
I just ported this with very very minimal effort to Linux over Xenomai.  It=
 is also huge code base and several dependencies.

In VxWorks  we ran our code in Kernel space and not in user space we used l=
ot of global data as well.
So therefore on Linux, I tied the several tasks that are being spawned into=
 single process on Linux because of dependency and data being shared.

What ever I can explain, I explained over the last email about those tasks =
 in gist.
I can also give bit more information after you look at the code snippet.
Please just search for string "README"  in these files  where I gave my obs=
ervations.

I hope this is one last issue on my table to solve it in whole porting and =
running our legacy VxWorks code  on Linux.
Samba



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Thursday, 01. September, 2011 14:06
To: Sambasiva Rao Manchili
Cc: Xenomai-help@domain.hid
Subject: Re: [Xenomai-help] taskDelete(tid) on VxWorks Skin ?

On 09/01/2011 02:01 PM, Sambasiva Rao Manchili wrote:
>  Hi,
>
> Version info is as follows
> Linux eup1 2.6.37.6_xenomai-2.5.6 #2 PREEMPT Mon Jul 18 21:08:17 CEST
> 2011 i686 i686 i386 GNU/Linux
>
> Kernel Configuraiton attached.
>
> Actually the task that was deleted was "do_forth" task(running at priorit=
y 143)  by Terminator task(priority 97).
> Terminator task also exited.

You missed section 4 in the page I sent you. This is the most important ite=
m.

--
                                            Gilles.


This email and any attachment may contain confidential information which is=
 intended for use only by the addressee(s) named above. If you received thi=
s email by mistake, please notify the sender immediately, and delete the em=
ail from your system. You are prohibited from copying, disseminating or oth=
erwise using the email or any attachment.

--_004_509DA52866E38F47878413CF102D751FED236D783Dposeidonnexus_
Content-Type: text/plain; name="do_forthTask.txt"
Content-Description: do_forthTask.txt
Content-Disposition: attachment; filename="do_forthTask.txt"; size=903;
	creation-date="Thu, 01 Sep 2011 16:14:28 GMT";
	modification-date="Thu, 01 Sep 2011 16:23:18 GMT"
Content-Transfer-Encoding: base64

ZXh0ZXJuIGludCBjcmVhdGVfZm9ydGhfdGFzayhTQ0VOVEFCTEVfRU5UUllfVFlQRSAqZW50cnks
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCAgICAgICAgICAgICAgICAgICBwcmlv
cml0eSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ICAgICAgICAgICAgICAgICAg
IHNwZWNpYWxfc3RhY2tfc2l6ZSkNCnsNCiAgY2hhciBuYW1lWzQwXTsNCiAgaW50ICB1c2VkX3N0
YWNrX3NpemU7DQogIHB0aHJlYWRfdCAgZG9Gb3J0aFRhc2tJZDsNCiAgaW50ICAgICAgICB0YXNr
X2lkOw0KICB1c2VkX3N0YWNrX3NpemUgPSAoc3BlY2lhbF9zdGFja19zaXplICE9IDApID8gc3Bl
Y2lhbF9zdGFja19zaXplIDogKDE2MCAqIDEwMjQpIDsNCiAgc3ByaW50ZihuYW1lLCJ0Rm9ydGgl
ZCIsZW50cnktPnRvZmZzZXQpOw0KDQogIHRhc2tfaWQgPSB0YXNrU3Bhd24obmFtZSwNCgkJICAg
cHJpb3JpdHksDQoJCSAgIDAsDQoJCSAgIHVzZWRfc3RhY2tfc2l6ZSwNCgkJICAgKEZVTkNQVFIp
ZG9fZm9ydGgsDQoJCSAgIChpbnQpIGVudHJ5LT5jb25maWdfcHRyLA0KCQkgICAoaW50KSBlbnRy
eS0+ZGljdF9wdHIsDQogICAgICAgICAgICAgICAgICAgKGludCllbnRyeS0+dG9mZnNldCwwLDAs
MCwwLDAsMCwwKTsNCiAgICAgICAgICAgICAgICAgICANCiBpZiAodGFza19pZCA9PSBFUlJPUikg
DQogIHsNCiAgICBzZXJyX2xvZyhTRVJSX0VSUk9SLCJjYW5ub3Qgc3Bhd24gdEZvcnRoICglcyki
LA0KCSAgICAgc3RyZXJyb3IoZXJybm9HZXQoKSkpOw0KICAgIHJldHVybiAxOw0KICB9DQogcmV0
dXJuIHRhc2tfaWQ7ICAgLyogUkVBRE1FOi0gVXN1YWxseSBJIHNlZSBoZXJlIFhlbm9tYWkgcmV0
dXJucyB0YXNrX2lkIGFzIHR3byBvciB0aHJlZSBkaWdpdCBudW1iZXIqLw0KDQp9

--_004_509DA52866E38F47878413CF102D751FED236D783Dposeidonnexus_
Content-Type: text/plain; name="terminatorTask.txt"
Content-Description: terminatorTask.txt
Content-Disposition: attachment; filename="terminatorTask.txt"; size=2492;
	creation-date="Thu, 01 Sep 2011 16:18:24 GMT";
	modification-date="Thu, 01 Sep 2011 16:23:00 GMT"
Content-Transfer-Encoding: base64

c3RhdGljIHZvaWQgdGVybWluYXRvcl90YXNrKFRBU0tfVEFCX1RZUEUgKnRhc2tfbGlzdHAsIGlu
dCB0ZXJtTm8pDQp7DQogIFVJTlRfMTYgICAgICAgICAgICAgICBpLCBudW1iZXI7DQogIFNDRU5U
QUJMRV9FTlRSWV9UWVBFICplbnRyeTsNCiAgVEVTQV9DTlRSTF9UWVBFICAgICAgIG1zZzsNCiAg
U1RBVFVTICAgICAgICAgICAgICAgIHN0YXR1czsNCiAgVE9mZnNldCAgICAgICAgICAgICAgIHRv
ZmZzZXQ7DQogIGNoYXIgICAgICAgICAgICAgICAgICBuYW1lWzQwXTsNCiAgc3RydWN0IHRpbWVz
cGVjICAgICAgIHRzOw0KICANCiAgDQogIHNwcmludGYobmFtZSwidFRlcm1pbmF0b3IlZCIsdGVy
bU5vKTsNCiAgbG9nT3BlbihuYW1lKTsNCiAgc2Vycl9vcGVuMigidGVzYSIsU0VSUl9MREYsMCwm
dGVzYV9kYXRhX2ZpZWxkcC0+dGVzYV9sZGZfdmFscyk7DQoNCiAgdHMudHZfc2VjICA9IDA7DQog
IHRzLnR2X25zZWMgPSA1MDAwMDsgLyogNTAgbXMgKi8NCg0KICBtc2cubXNndHlwZSA9IFRFU0Ff
Rk9SVEhfQ05UUkw7DQogIG1zZy5kYXRhID0gKHRhc2tfbGlzdHAtPmNvbnRyb2wgPT0gS0lMTF9G
T1JUSCkgPyBGU19LSUxMRUQgOiBGU19SRUxFQVNFRDsNCg0KICBudW1iZXIgPSB0YXNrX2xpc3Rw
LT5hbnphaGw7DQogIHByaW50ZigiJXM6IE51bWJlci0tLT48JWQ+XG4iLF9fRlVOQ1RJT05fXywg
bnVtYmVyKTsNCiAgd2hpbGUgKG51bWJlcikgew0KICANCiAgICBmb3IgKGkgPSAwOyBpIDwgdGFz
a19saXN0cC0+YW56YWhsOyBpKyspIHsNCiAgICAgIA0KICAgICAgaWYgKCh0b2Zmc2V0ID0gdGFz
a19saXN0cC0+dG9mZnNldFtpXSkpIHsNCgkNCgllbnRyeSA9ICZ0ZXNhX3NjZW50YWJsZXBbdG9m
ZnNldF07DQoJdGFza1N1c3BlbmQodGFza19saXN0cC0+dG9rZW5baV0pOyAgLyogUkVBRE1FICBU
cmllZCB3aXRoIHN1c3BlbmQgZGlkIG5vdCBoZWxwICovDQogICAgICAgDQogICAgICAgIC8qIFJF
QURNRSAsIGFzIHRhc2tEZWxldGUgZGlkIG5vdCB3b3JrLCBJIHRyaWVkIHdpdGggZm9yY2UgYnV0
IGRpZCBub3QgaGVscCBlaXRoZXIuDQogICAgICAgICAqIFRoZSB2YWx1ZSBvZiBUYXNrSUQgdGhh
dCBJIHBhc3MgaGVyZSBhcyBwYXJhbWV0ZXIgdG8gdGFza0RlbGV0ZSBpcyB0YXNrRGVsZXRlRm9y
Y2UNCiAgICAgICAgICogaXMgc2FtZSBhcyB3aGF0IEkgZ290IGZyb20gdGFza1NwYXduIGZyb20g
WGVub21haS4NCiAgICAgICAgICovDQoJc3RhdHVzID0gdGFza0RlbGV0ZUZvcmNlKHRhc2tfbGlz
dHAtPnRva2VuW2ldKTsgDQoNCglzZXJyX2xvZyhTRVJSX0lORk8sInRhc2sgJXggZGVsZXRlZCBz
dGF0dXMgJWQiLHRhc2tfbGlzdHAtPnRva2VuW2ldLA0KCQlzdGF0dXMpOw0KCWlmIChzdGF0dXMg
PT0gT0spIHsNCg0KICAgICAgICAgICAvKiBSRUFETUUgIFhFTk9NQUkgUmV0cnVzbiBTVEFUVVMg
T0sgKi8NCgkgIG51bWJlci0tOw0KCSAgdGFza19saXN0cC0+dG9mZnNldFtpXSA9IDA7CSAgDQoJ
ICBtc2cudGVybW9mZnNldCA9IHRvZmZzZXQ7IC8qIHNldCB0ZXJtaW5hbG9mZnNldCBpbiBtZXNz
YWdlICovDQoJICAodm9pZCkgdGVzYV90eF9tZXNzYWdlKCZtc2csc2l6ZW9mKFRFU0FfQ05UUkxf
VFlQRSkpOw0KDQoJfSBlbHNlIHsNCg0KICAgICAgICAgICAvKiBSRUFETUUgIE5FVkVSIEVOVEVS
UyBIRVJFICovIA0KICAgICAgICAgICBzZXJyTG9nKCBzZXJyV2FybiwgInRlcm1pbmF0b3JfdGFz
azogZGVsZXRpb24gb2YgdEZvcnRoJWQgZmFpbGVkISAlcyIsDQogICAgICAgICAgICAgdG9mZnNl
dCwgc3RyZXJyb3IoZXJybm9HZXQoKSkgKTsNCg0KDQoJICAvKiBpZiBlcnJubyBlcXVhbCBTX29i
akxpYl9PQkpfVU5BVkFJTEFCTEU6IHRoZSBpbnRlcnByZXRlciBpcyBpbiANCgkgICAgIGEgY3Jp
dGljYWwgcmVnaW9uICggdGFza1NhdmUgaXMgc2V0ICkgLS0+IHRyeSB0byBkZWxldGUgaXQgbGF0
ZXIgDQoJICAgICANCgkgICAgIGVsc2Ugd2UgYXNzdW1lIHRoYXQgdGhlIHRhc2sgaXMgYWxyZWFk
eSBkZWxldGVkDQoJICAgICANCgkgICovDQoJICBpZiAoZXJybm9HZXQoKSAhPSBTX29iakxpYl9P
QkpfVU5BVkFJTEFCTEUpIHsNCgkgICAgbnVtYmVyLS07DQoJICAgIHRhc2tfbGlzdHAtPnRvZmZz
ZXRbaV0gPSAwOw0KCSAgICBtc2cudGVybW9mZnNldCA9IHRvZmZzZXQ7IC8qIHNldCB0ZXJtaW5h
bG9mZnNldCBpbiBtZXNzYWdlICovDQoJICAgICh2b2lkKSB0ZXNhX3R4X21lc3NhZ2UoJm1zZyxz
aXplb2YoVEVTQV9DTlRSTF9UWVBFKSk7DQoJICB9DQoJfQ0KICAgICAgfSAvKiBpZiAodG9mZnNl
dCkgKi8NCiAgICB9IC8qIGZvciAqLw0KICAgIHRhc2tEZWxheSggMTAgKTsNCiAgfSAvKiB3aGls
ZSAobnVtYmVyKSAqLw0KICBmcmVlKHRhc2tfbGlzdHApOw0KDQogIHByaW50ZigiJXM6IE5vdCBD
YWxsaW5nIEV4aXRcbiIsIF9fRlVOQ1RJT05fXyk7DQogIA0KICAvKnB0aHJlYWRfZXhpdCgwKTsN
CiAgZXhpdCgwKTsgT3JpZ2luYWwgVnhXb3JrcyBjb2RlICovDQp9DQo=

--_004_509DA52866E38F47878413CF102D751FED236D783Dposeidonnexus_
Content-Type: text/plain; name="main.c"
Content-Description: main.c
Content-Disposition: attachment; filename="main.c"; size=752;
	creation-date="Thu, 01 Sep 2011 16:28:57 GMT";
	modification-date="Thu, 01 Sep 2011 16:38:46 GMT"
Content-Transfer-Encoding: base64

DQoNCnN0YXRpYyB2b2lkKiB0aHJlYWRfVGVzYUl0YXNrKHZvaWQgKmFyZykNCnsNCiAgYXJnPWFy
ZzsNCiAgbG9nTXNnKElORk9fMCwiRXhlY3R1dGluZyB0ZXNhX2l0YXNrLi4uLiIpOw0KDQogIC8q
IFJFQURNRSB0ZXNhX2l0YXNrIFNob3VsZCBzcGF3biAzIHRhc2tzIChhbmQgb25lIG9mIHRob3Nl
IDMgdGFza3Mgc3Bhd25lZCAgd2lsbCBzcGF3biANCiAgICogZG9fZm9ydGhUYXNrIG9uIHNvbWUg
ZXZlbnQpIA0KICAgKiBkb19mb3J0aFRhc2sgaXMgZm9yIGV2ZXIgYW5kIHdpbGwgYmUgZGVsZXRl
ZCBieSB0ZXJtaW5hdG9yVGFzayB3aGljaCBpcyBzcGF3bmVkIGJ5IG9uZSBvZiB0aG9zZSAzIHRh
c2tzDQogICAqIGR1cmluZyBjbGVhbnVwIGV2ZW50Lg0KICAgKiANCiAgICovDQogIHRlc2FfaXRh
c2soKTsgIA0KICANCiAgcHJpbnRmKCIlczogR29pbmcgdG8gc2xlZXAgSU5GSU5JVEUiLCBfX0ZV
TkNUSU9OX18pOw0KICB3aGlsZSgxKQ0KICB7DQogICAgc2xlZXAoMzYwMCk7DQogIH0gDQogIHJl
dHVybiAwOw0KfQ0KDQppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQp7DQouLi4NCi4u
Lg0KdGVzYUlUYXNrID0gb3NDcmVhdGVEZXRhY2hlZFRocmVhZCh0aHJlYWRfVGVzYUl0YXNrLE5V
TEwpOw0KICAgbG9nTXNnKElORk9fMCwgIiVzOiBSZXR1cm5lZCBmcm9tIG9zQ3JlYXRlRGV0YWNo
ZWRUaHJlYWQgdGVzYUl0YXNrPCVsZD4iLA0KICAgCQlfX0ZVTkNUSU9OX18sIHRlc2FJVGFzayk7
DQoNCi4uLi4NCn0=

--_004_509DA52866E38F47878413CF102D751FED236D783Dposeidonnexus_--



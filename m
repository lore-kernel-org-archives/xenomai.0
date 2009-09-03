Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA2CA5.423BE4AE"
Date: Thu, 3 Sep 2009 16:46:02 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD386E6@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] Differences in RT_HEAP_INFO struct between
	Xenomai2.4/2.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rus V. Brushkoff" <rus@domain.hid>, xenomai@xenomai.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA2CA5.423BE4AE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Rus V. Brushkoff wrote:
>   Trying to backport Xenomai app from 2.5 to 2.4 noticed that=20
> rt_heap_info struct has no phys_addr field. Is this interface
difference=20
> supposed to exist ?

At the cost of ABI disruption, you may backport the phys_addr field
support with the attached patch.

--=20
Stephane

------_=_NextPart_001_01CA2CA5.423BE4AE
Content-Type: application/octet-stream;
	name="xeno-phys-addr.patch"
Content-Transfer-Encoding: base64
Content-Description: xeno-phys-addr.patch
Content-Disposition: attachment;
	filename="xeno-phys-addr.patch"

LS0tIGluY2x1ZGUvbmF0aXZlL2hlYXAuaAk4IFNlcCAyMDA4IDEwOjA4OjA4IC0wMDAwCTEuMS4x
LjUKKysrIGluY2x1ZGUvbmF0aXZlL2hlYXAuaAkxNyBOb3YgMjAwOCAxMDo0NzoxMyAtMDAwMAkx
LjUKQEAgLTUzLDYgKzUzLDggQEAgdHlwZWRlZiBzdHJ1Y3QgcnRfaGVhcF9pbmZvIHsKIAogICAg
IGNoYXIgbmFtZVtYTk9CSkVDVF9OQU1FX0xFTl07IC8qICE8IFN5bWJvbGljIG5hbWUuICovCiAK
KyAgICB1bnNpZ25lZCBsb25nIHBoeXNfYWRkcjsJLyogITwgUGh5c2ljYWwgYWRkcmVzcy4gKi8K
KwogfSBSVF9IRUFQX0lORk87CiAKIHR5cGVkZWYgc3RydWN0IHJ0X2hlYXBfcGxhY2Vob2xkZXIg
ewotLS0ga3NyYy9za2lucy9uYXRpdmUvaGVhcC5jCTEgRmViIDIwMDkgMTc6MjA6MzEgLTAwMDAJ
MS4xLjEuOQorKysga3NyYy9za2lucy9uYXRpdmUvaGVhcC5jCTI2IEZlYiAyMDA5IDE2OjI2OjQx
IC0wMDAwCTEuMTIKQEAgLTIwMiw4ICsyMDIsOCBAQCBzdGF0aWMgdm9pZCBfX2hlYXBfZmx1c2hf
cHJpdmF0ZSh4bmhlYXBfCiAgKgogICogLSBIX0RNQSBjYXVzZXMgdGhlIGJsb2NrIHBvb2wgYXNz
b2NpYXRlZCB0byB0aGUgaGVhcCB0byBiZQogICogYWxsb2NhdGVkIGluIHBoeXNpY2FsbHkgY29u
dGlndW91cyBtZW1vcnksIHN1aXRhYmxlIGZvciBETUEKLSAqIG9wZXJhdGlvbnMgd2l0aCBJL08g
ZGV2aWNlcy4gQGEgaGVhcHNpemUgYmV5b25kIDEyOEtpQiB3aWxsCi0gKiBiZSByb3VuZGVkIHVw
IHRvIGEgdHdvIGV4cG9ub25lbnQgYWxsb2NhdGlvbi4KKyAqIG9wZXJhdGlvbnMgd2l0aCBJL08g
ZGV2aWNlcy4gVGhlIHBoeXNpY2FsIGFkZHJlc3Mgb2YgdGhlCisgKiBoZWFwIGNhbiBiZSBvYnRh
aW5lZCB0aHJvdWdoIGEgY2FsbCB0byBydF9oZWFwX2lucXVpcmUoKS4KICAqCiAgKiAtIEhfTk9O
Q0FDSEVEIGNhdXNlcyB0aGUgaGVhcCBub3QgdG8gYmUgY2FjaGVkLiBUaGlzIGlzIG5lY2Vzc2Fy
eSBvbgogICogcGxhdGZvcm1zIHN1Y2ggYXMgQVJNIHRvIHNoYXJlIGEgaGVhcCBiZXR3ZWVuIGtl
cm5lbCBhbmQgdXNlci1zcGFjZS4KQEAgLTc1MSw2ICs3NTEsNyBAQCBpbnQgcnRfaGVhcF9pbnF1
aXJlKFJUX0hFQVAgKmhlYXAsIFJUX0hFCiAJaW5mby0+dXNhYmxlbWVtID0geG5oZWFwX3VzYWJs
ZV9tZW0oJmhlYXAtPmhlYXBfYmFzZSk7CiAJaW5mby0+dXNlZG1lbSA9IHhuaGVhcF91c2VkX21l
bSgmaGVhcC0+aGVhcF9iYXNlKTsKIAlpbmZvLT5tb2RlID0gaGVhcC0+bW9kZTsKKwlpbmZvLT5w
aHlzX2FkZHIgPSAoaGVhcC0+bW9kZSAmIEhfU0lOR0xFKSA/IHZpcnRfdG9fcGh5cyhoZWFwLT5z
YmEpOjA7CiAKICAgICAgIHVubG9ja19hbmRfZXhpdDoKIAo=

------_=_NextPart_001_01CA2CA5.423BE4AE--


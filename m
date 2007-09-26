Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C80023.F9C43A8A"
Date: Wed, 26 Sep 2007 10:00:15 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0244B830@domain.hid>
In-Reply-To: <46F7B400.1020209@domain.hid>
References: <46F777EE.3060100@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB023D2124@domain.hid>
	<46F7B400.1020209@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-core] RTCAN (MSCAN) doesn't compile on latest Denx
	2.6.23
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C80023.F9C43A8A
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:

>=20
> I have a patch already since a while but forgot to post it. Could you
> please give the attached patch a try?=20
>=20

I have given the patch a try and it doesn't quite work out of the box,
as there is an index off-by-one error concerning the configured CAN
ports. The result is that probing the CAN controller starts with the
second entry in the device tree and a random address will be probed for
the second CAN controller where ioremap gladly bumps out with an error
which results in a RT-CAN shutdown.

The applied patch solves the issue for me. I don't know if it works in
case of (! #defined CONFIG_PPC_MERGE)


Best regards,

Daniel.

------_=_NextPart_001_01C80023.F9C43A8A
Content-Type: application/octet-stream;
	name="mscan_fix_ot_index.patch"
Content-Transfer-Encoding: base64
Content-Description: mscan_fix_ot_index.patch
Content-Disposition: attachment;
	filename="mscan_fix_ot_index.patch"

LS0tIHJ0Y2FuX21zY2FuLmMub3JpZwkyMDA3LTA5LTI2IDA5OjQ2OjE4LjAwMDAwMDAwMCArMDAw
MAorKysgZHJpdmVycy94ZW5vbWFpL2Nhbi9tc2Nhbi9ydGNhbl9tc2Nhbi5jCTIwMDctMDktMjYg
MDk6NDE6NTIuMDAwMDAwMDAwICswMDAwCkBAIC02MCwxMyArNjAsMTMgQEAKIGludCBwb3J0W1JU
Q0FOX01TQ0FOX0RFVlNdID0gewogI2lmZGVmIENPTkZJR19YRU5PX0RSSVZFUlNfQ0FOX01TQ0FO
XzEKICNpZmRlZiBDT05GSUdfWEVOT19EUklWRVJTX0NBTl9NU0NBTl8yCi0JMSwgMiAgLyogRW5h
YmxlIENBTiAxIGFuZCAyICovCisJMCwgMSAgLyogRW5hYmxlIENBTiAxIGFuZCAyICovCiAjZWxz
ZQotCTEsIDAgIC8qIEVuYWJsZSBDQU4gMSBvbmx5ICAqLworCTAsIC0xICAvKiBFbmFibGUgQ0FO
IDEgb25seSAgKi8KICNlbmRpZgogI2Vsc2UKICNpZmRlZiBDT05GSUdfWEVOT19EUklWRVJTX0NB
Tl9NU0NBTl8yCi0JMiwgMCAgLyogRW5hYmxlIENBTiAyIG9ubHkgICovCisJMSwgLTEgIC8qIEVu
YWJsZSBDQU4gMiBvbmx5ICAqLwogI2Vsc2UKICNlcnJvciAiTm8gQ0FOIGNvbnRyb2xsZXIgZW5h
YmxlZCwgZml4IGNvbmZpZ3VyYXRpb24hIgogI2VuZGlmCkBAIC04ODgsNyArODg4LDcgQEAKIAog
ICAgIGZvciAoaSA9IDA7IGkgPCBydGNhbl9tc2Nhbl9jb3VudDsgaSsrKSB7CiAJaWR4ID0gcG9y
dFtpXTsKLQlpZiAoaWR4IDwgMSB8fCBpZHggPiBydGNhbl9tc2Nhbl9jb3VudCkKKwlpZiAoaWR4
IDwgMCB8fCBpZHggPj0gcnRjYW5fbXNjYW5fY291bnQpCiAJICAgIGNvbnRpbnVlOwogCiAJZXJy
ID0gcnRjYW5fbXNjYW5faW5pdF9vbmUoaWR4LCBhZGRyW2lkeF0sIGlycVtpZHhdKTsK

------_=_NextPart_001_01C80023.F9C43A8A--


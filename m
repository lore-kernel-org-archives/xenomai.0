MIME-Version: 1.0
In-Reply-To: <4C36FD74.9020602@domain.hid>
References: <AANLkTilLcPtUo564fICdJQtOQAjbvVj2l2Oxq8F3yycp@domain.hid> 
	<4C36FD74.9020602@domain.hid>
From: Peter Soetens <peter@domain.hid>
Date: Fri, 9 Jul 2010 15:29:50 +0200
Message-ID: <AANLkTinByUY7Nlk5Rs9zobkmHEPMHsSVmVok_A-x8ecZ@mail.gmail.com>
Content-Type: multipart/mixed; boundary=001636c9284aed9436048af46622
Subject: Re: [Xenomai-help] IXXAT SJA_MOD register refuses to set up dual
	channel cards
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

--001636c9284aed9436048af46622
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 9, 2010 at 12:44 PM, Wolfgang Grandegger <wg@domain.hid> wr=
ote:
> Hi Peter,
>
> On 07/09/2010 12:26 PM, Peter Soetens wrote:
>> Hi,
>>
>> (Xenomai 2.5.2&2.5.3)
>>
>> I'm testing the rtcan ixxat driver for a dual channel card (PLX
>> Technology, Inc. Device 2540)
>>
>> It recognizes the first channel, but refuses to setup the second one
>> because the SJA_MOD flag is 0x7f instead of 0x21
>> The SJA_IR and SJA_SR flags read as are what the driver expects.
>
> In the Socket-CAN "plx_pci" driver we mask the value with 0xa1:
>
> =C2=A00x7f & 0xa1 =3D 0x21 =3D=3D> OK.
>
> See
> http://lxr.linux.no/#linux+v2.6.34.1/drivers/net/can/sja1000/plx_pci.c#L2=
23
>
>> Any suggestions on what it means and how to fix this ?
>
> See above. A patch would be nice.

Your analysis is correct. It works flawlessly now. See attachment.

Peter

--001636c9284aed9436048af46622
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-rtcan-Mask-the-SJA_MOD-register-when-probing-for-cha.patch"
Content-Disposition: attachment; 
	filename="0001-rtcan-Mask-the-SJA_MOD-register-when-probing-for-cha.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gbf2be630

RnJvbSA1YzdiZWMxMGIwOTlmZDE5NzMzOTRiMmE2Y2EzODhhNWUzNzQyYjY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQZXRlciBTb2V0ZW5zIDxwZXRlckB0aGVzb3VyY2V3b3Jrcy5j
b20+CkRhdGU6IEZyaSwgOSBKdWwgMjAxMCAxNToyMTo1MyArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IHJ0Y2FuOiBNYXNrIHRoZSBTSkFfTU9EIHJlZ2lzdGVyIHdoZW4gcHJvYmluZyBmb3IgY2hhbm5l
bHMKCkluc3BpcmVkIGJ5IHRoZSBwbHhfcGNpLmMgZHJpdmVyIHdoaWNoIGRvZXMgdGhlIHNhbWUu
ClRlc3RlZCBvbiBJWFhBVCBQQy1JIDA0CgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTb2V0ZW5zIDxw
ZXRlckB0aGVzb3VyY2V3b3Jrcy5jb20+Ci0tLQoga3NyYy9kcml2ZXJzL2Nhbi9zamExMDAwL3J0
Y2FuX2l4eGF0X3BjaS5jIHwgICAgMyArKy0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2tzcmMvZHJpdmVycy9jYW4vc2phMTAw
MC9ydGNhbl9peHhhdF9wY2kuYyBiL2tzcmMvZHJpdmVycy9jYW4vc2phMTAwMC9ydGNhbl9peHhh
dF9wY2kuYwppbmRleCA1ZmFhNzYzLi44YzkxZWZkIDEwMDY0NAotLS0gYS9rc3JjL2RyaXZlcnMv
Y2FuL3NqYTEwMDAvcnRjYW5faXh4YXRfcGNpLmMKKysrIGIva3NyYy9kcml2ZXJzL2Nhbi9zamEx
MDAwL3J0Y2FuX2l4eGF0X3BjaS5jCkBAIC02Myw2ICs2Myw3IEBAIHN0cnVjdCBydGNhbl9peHhh
dF9wY2kKICNkZWZpbmUgSVhYQVRfSU5UQ1NSX09GRlNFVCAgMHg0YyAvKiBPZmZzZXQgaW4gUExY
OTA1MCBjb25mIHJlZ2lzdGVycyAqLwogI2RlZmluZSBJWFhBVF9JTlRDU1JfU0xBVkUgICAweDQx
IC8qIExJTlQxIGFuZCBQQ0kgaW50ZXJydXB0IGVuYWJsZWQgKi8KICNkZWZpbmUgSVhYQVRfSU5U
Q1NSX01BU1RFUiAgMHgwOCAvKiBMSU5UMiBlbmFibGVkICovCisjZGVmaW5lIElYWEFUX1NKQV9N
T0RfTUFTSyAgIDB4YTEgLyogTWFzayBmb3IgcmVhZGluZyBkdWFsL3NpbmdsZSBjaGFubmVsICov
CiAKIC8qIFBDSSB2ZW5kZXIsIGRldmljZSBhbmQgc3ViLWRldmljZSBJRCAqLwogI2RlZmluZSBJ
WFhBVF9QQ0lfVkVORE9SX0lEICAweDEwYjUKQEAgLTIzOCw3ICsyMzksNyBAQCBzdGF0aWMgaW50
IF9fZGV2aW5pdCBpeHhhdF9wY2lfaW5pdF9vbmUgKHN0cnVjdCBwY2lfZGV2ICpwZGV2LAogICAg
IHdyaXRlYigweDEsIGJhc2VfYWRkciArIENIQU5ORUxfTUFTVEVSX1JFU0VUKTsKICAgICB3cml0
ZWIoMHgxLCBiYXNlX2FkZHIgKyBDSEFOTkVMX1NMQVZFX1JFU0VUKTsKICAgICB1ZGVsYXkoMTAw
KTsKLSAgICBpZiAocmVhZGIoYmFzZV9hZGRyICsgQ0hBTk5FTF9PRkZTRVQgKyBTSkFfTU9EKSAh
PSAweDIxIHx8CisgICAgaWYgKCAocmVhZGIoYmFzZV9hZGRyICsgQ0hBTk5FTF9PRkZTRVQgKyBT
SkFfTU9EKSAmIElYWEFUX1NKQV9NT0RfTUFTSyApICE9IDB4MjEgfHwKIAlyZWFkYihiYXNlX2Fk
ZHIgKyBDSEFOTkVMX09GRlNFVCArIFNKQV9TUiApICE9IDB4MGMgfHwKIAlyZWFkYihiYXNlX2Fk
ZHIgKyBDSEFOTkVMX09GRlNFVCArIFNKQV9JUiApICE9IDB4ZTApCiAJY2hhbm5lbCA9IENIQU5O
RUxfU0lOR0xFOwotLSAKMS42LjMuMwoK
--001636c9284aed9436048af46622--


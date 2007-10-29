Message-ID: <4725EC54.4080301@domain.hid>
Date: Mon, 29 Oct 2007 10:21:08 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090404020903010209090304"
Subject: [Xenomai-core] Ping causes Oops, appears to be a race condition
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090404020903010209090304
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Some more info on the ping crash I reported last week (powerpc kernel 
2.6.23, Xenomai 2.4-rc4, ipipe 2.0-03).  Ping works correctly without 
Xenomai.  With Xenomai, I get an oops, attached below.

I added a printk in __raw_v4_lookup() since the NIP pointed there.  
Interestingly, once I did that, ping worked with Xenomai as shown here:

# ping 127.0.0.1
PING 127.0.0.1 (127.0.0.1): 56 data bytes
sock c06f4040
sock 00000000
sock c06f4040
sock 00000000
64 bytes from 127.0.0.1: seq=0 ttl=64 time=7.571 ms

Here is the printk that changed the behavior:

struct sock *__raw_v4_lookup(struct sock *sk, unsigned short num, __be32 
raddr, __be32 laddr, int dif)
{
    struct hlist_node *node;
    printk("sock %p\n", sk);
    sk_for_each_from(sk, node) {




--------------090404020903010209090304
Content-Type: text/plain;
 name="log"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="log"

IyBwaW5nIDEyNy4wLjAuMQpQSU5HIDEyNy4wLjAuMSAoMTI3LjAuMC4xKTogNTYgZGF0YSBi
eXRlcwpVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBwYWdpbmcgcmVxdWVzdCBmb3IgZGF0YSBh
dCBhZGRyZXNzIDB4MDAwMDAwMDgKRmF1bHRpbmcgaW5zdHJ1Y3Rpb24gYWRkcmVzczogMHhj
MDFjNjY0OApPb3BzOiBLZXJuZWwgYWNjZXNzIG9mIGJhZCBhcmVhLCBzaWc6IDExIFsjMV0K
TmV0ZGVjCk1vZHVsZXMgbGlua2VkIGluOgpOSVA6IGMwMWM2NjQ4IExSOiBjMDFjNmQwOCBD
VFI6IGMwMTgyNzljClJFR1M6IGMwMjhiOWQwIFRSQVA6IDAzMDAgICBOb3QgdGFpbnRlZCAg
KDIuNi4yMykKTVNSOiAwMDAyOTAzMCA8RUUsTUUsSVIsRFI+ICBDUjogNDgwMDA0MjIgIFhF
UjogMDAwMDAwMDAKREVBUjogMDAwMDAwMDgsIEVTUjogMDAwMDAwMDAKVEFTSyA9IGMwZjgz
ODEwWzY2MF0gJ3BpbmcnIFRIUkVBRDogYzAyOGEwMDAKR1BSMDA6IDAwMDAwMDAwIGMwMjhi
YTgwIGMwZjgzODEwIDAwMDAwMDA4IDAwMDAwMDAxIDdmMDAwMDAxIDdmMDAwMDAxIDAwMDAw
MDAyCkdQUjA4OiBjMDJjMDAwMCBjMDJiNTY4MCBjMDJkMDM2MCBjMDJjMDAwMCBjMGYzNWUx
MCAxMDBkMjVmMCAwMGZmOTkwMCAwMDAwMDAwMQpHUFIxNjogMDAwMDAwYTAgYzA2ZTdmNjgg
YzAyYTAwMDAgYzAyZDAwMDAgYzAyOGJiNjggZmZmZWU1MjkgYzAyZmJkODggMDAwMDAwMDAK
R1BSMjQ6IDAwMDAwMDQwIGMwMmQwMDAwIGMwMmQwMDAwIGMwMmQwMDAwIDAwMDAwMDAxIGMw
NmY0MDQwIGMwNmY2YzYwIGMwZjM1ZTEwCk5JUCBbYzAxYzY2NDhdIF9fcmF3X3Y0X2xvb2t1
cCsweDEwLzB4ODQKTFIgW2MwMWM2ZDA4XSByYXdfdjRfaW5wdXQrMHhjYy8weDE4NApDYWxs
IFRyYWNlOgpbYzAyOGJhODBdIFtjMDFjNmNkNF0gcmF3X3Y0X2lucHV0KzB4OTgvMHgxODQg
KHVucmVsaWFibGUpCltjMDI4YmFhMF0gW2MwMWE1YTM0XSBpcF9sb2NhbF9kZWxpdmVyKzB4
YmMvMHgxODgKW2MwMjhiYWMwXSBbYzAxYTVkM2NdIGlwX3JjdisweDIzYy8weDRjYwpbYzAy
OGJhZjBdIFtjMDE4YjVjY10gbmV0aWZfcmVjZWl2ZV9za2IrMHgyMmMvMHgzMTAKW2MwMjhi
YjIwXSBbYzAxOGRlZDhdIHByb2Nlc3NfYmFja2xvZysweGJjLzB4MTljCltjMDI4YmI2MF0g
W2MwMThlMDZjXSBuZXRfcnhfYWN0aW9uKzB4YjQvMHgxYjgKW2MwMjhiYmEwXSBbYzAwMjRm
MThdIF9fZG9fc29mdGlycSsweDg0LzB4MTA4CltjMDI4YmJlMF0gW2MwMDA1MTc4XSBkb19z
b2Z0aXJxKzB4OTQvMHg5OApbYzAyOGJiZjBdIFtjMDAyNGM5Y10gbG9jYWxfYmhfZW5hYmxl
KzB4N2MvMHhhNApbYzAyOGJjMDBdIFtjMDE4ZTg0OF0gZGV2X3F1ZXVlX3htaXQrMHhlNC8w
eDMxYwpbYzAyOGJjMjBdIFtjMDE5NTRjOF0gbmVpZ2hfcmVzb2x2ZV9vdXRwdXQrMHhmYy8w
eDJiNApbYzAyOGJjNTBdIFtjMDFhYTQ5NF0gaXBfb3V0cHV0KzB4MmM0LzB4MzI4CltjMDI4
YmM3MF0gW2MwMWE5OTdjXSBpcF9wdXNoX3BlbmRpbmdfZnJhbWVzKzB4MjgwLzB4NDBjCltj
MDI4YmM5MF0gW2MwMWM3NGQ4XSByYXdfc2VuZG1zZysweDY3NC8weDczOApbYzAyOGJkMTBd
IFtjMDFkMGEzMF0gaW5ldF9zZW5kbXNnKzB4NTAvMHg3OApbYzAyOGJkMzBdIFtjMDE3ZWQy
Y10gc29ja19zZW5kbXNnKzB4YWMvMHhmNApbYzAyOGJlMjBdIFtjMDE3ZjBiY10gc3lzX3Nl
bmR0bysweGNjLzB4MTA4CltjMDI4YmYwMF0gW2MwMTdmYWE0XSBzeXNfc29ja2V0Y2FsbCsw
eDEzOC8weDFkOApbYzAyOGJmNDBdIFtjMDAwZTQ4Y10gcmV0X2Zyb21fc3lzY2FsbCsweDAv
MHgzYwpJbnN0cnVjdGlvbiBkdW1wOgo1NDAwZTAwNiA5MDAxMDAwOCA0MDllZmZkNCA4MDAx
MDAyNCBiYmExMDAxNCA3YzA4MDNhNiAzODIxMDAyMCA0ZTgwMDAyMAoyYzAzMDAwMCA0ZGEy
MDAyMCAzNDYzMDAwOCA0MTgyMDA3MCA8ODEyMzAwMDA+IDJmMDkwMDAwIDQxOWEwMDA4IDdj
MDA0YTJjCktlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24gaW4g
aW50ZXJydXB0Cg==
--------------090404020903010209090304--


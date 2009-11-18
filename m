Message-ID: <4B03E538.1060708@domain.hid>
Date: Wed, 18 Nov 2009 13:14:48 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01D8FADC@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01D8FADC@ARVMAIL1.mra.roland-man.biz>
Content-Type: multipart/mixed; boundary="------------010409090205080707010501"
Subject: Re: [Xenomai-help] network stall
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010409090205080707010501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hallo,

roderik.wildenburg@domain.hid wrote:
>> Are there any FEC related kernel messages? Maybe (likely) the 
>> problem is
> 
> We will check this.
> 
> 
>> caused by Ethernet packet bombardments (I suspect bursts of ARP
>> request). You could try to simulate such bombardments by 
>> using pktgen. I
>> can send you a script in case you are interested.
> 
> Sure I am interested! Would you be so kind to send me the script?

See attachment. Please adapt the MAC address of the target and you may
need a "modprobe pktgen" before running the script. For further info,
please have a look to "Documentation/networking/pktgen.txt"

Wolfgang.

--------------010409090205080707010501
Content-Type: application/x-shellscript;
 name="paketgenerator.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="paketgenerator.sh"

IyEvYmluL2Jhc2gKIyBwa3RnZW4uY29uZiAtLSBTYW1wbGUgY29uZmlndXJhdGlvbiBmb3Ig
c2VuZCBvbiB0d28gZGV2aWNlcyBvbiBhIFVQIHN5c3RlbQoKbW9kcHJvYmUgcGt0Z2VuCgpm
dW5jdGlvbiBwZ3NldCgpIHsKICAgIGxvY2FsIHJlc3VsdAoKICAgIGVjaG8gJDEgPiAkUEdE
RVYKCiAgICByZXN1bHQ9YGNhdCAkUEdERVYgfCBmZ3JlcCAiUmVzdWx0OiBPSzoiYAogICAg
aWYgWyAiJHJlc3VsdCIgPSAiIiBdOyB0aGVuCiAgICAgICAgIGNhdCAkUEdERVYgfCBmZ3Jl
cCBSZXN1bHQ6CiAgICBmaQp9CgpmdW5jdGlvbiBwZygpIHsKICAgIGVjaG8gaW5qZWN0ID4g
JFBHREVWCiAgICBjYXQgJFBHREVWCn0KCiMgT24gVVAgc3lzdGVtcyBvbmx5IG9uZSB0aHJl
YWQgZXhpc3RzIC0tIHNvIGp1c3QgYWRkIGRldmljZXMgCiMgV2UgdXNlIGV0aDAsIGV0aDIK
CmVjaG8gIkFkZGluZyBkZXZpY2VzIHRvIHJ1biIuIAoKUEdERVY9L3Byb2MvbmV0L3BrdGdl
bi9rcGt0Z2VuZF8wCnBnc2V0ICJyZW1fZGV2aWNlX2FsbCIgCnBnc2V0ICJhZGRfZGV2aWNl
IGV0aDEiIAojcGdzZXQgImFkZF9kZXZpY2UgZXRoMiIgCnBnc2V0ICJtYXhfYmVmb3JlX3Nv
ZnRpcnEgMTAwMDAiCgoKIyBDb25maWd1cmUgdGhlIGluZGl2aWR1YWwgZGV2aWNlcwojIGVj
aG8gIkNvbmZpZ3VyaW5nIGRldmljZXMiCgpQR0RFVj0vcHJvYy9uZXQvcGt0Z2VuL2V0aDEK
CnBnc2V0ICJjbG9uZV9za2IgMTAwMDAiIApwZ3NldCAibWluX3BrdF9zaXplIDYwIiAKcGdz
ZXQgIm1heF9wa3Rfc2l6ZSAxMjAiIApwZ3NldCAiZHN0IDEwLjAuMzAuMjEyIiAKcGdzZXQg
ImRzdF9tYWMgMDA6RTA6QkE6OTA6MDk6QzMiCnBnc2V0ICJjb3VudCAxMDAwMDAwMDAwMDAw
MDAwMDAiCiNwZ3NldCAiZGVsYXkgMjAwMDAiCgojIE5leHQgZGV2CiNQR0RFVj0vcHJvYy9u
ZXQvcGt0Z2VuL2V0aDIKIwojcGdzZXQgImNsb25lX3NrYiAxMDAwMCIgCiNwZ3NldCAibWlu
X3BrdF9zaXplIDYwIiAKI3Bnc2V0ICJtYXhfcGt0X3NpemUgNjAiIAojcGdzZXQgIjEwLjI1
NS4yMzAuNzYiIAojcGdzZXQgImRzdF9tYWMgMDA6RTA6QkE6OTA6MEQ6MEEiIAojcGdzZXQg
ImNvdW50IDEwMDAwMDAiCgojIFRpbWUgdG8gcnVuCgpQR0RFVj0vcHJvYy9uZXQvcGt0Z2Vu
L3BnY3RybAoKZWNobyAiUnVubmluZy4uLiBjdHJsXkMgdG8gc3RvcCIKCnBnc2V0ICJzdGFy
dCIgCgplY2hvICJEb25lIgo=
--------------010409090205080707010501--


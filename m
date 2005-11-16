In-Reply-To: <437A5E8E.3020100@domain.hid>
Message-ID: <OFE0FCA674.602362D5-ONC12570BB.00369D55-C12570BB.00376F54@domain.hid>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Wed, 16 Nov 2005 11:05:29 +0100
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=4EBBFA28DFA51BC58f9e8a93df938690918c4EBBFA28DFA51BC5"
Subject: [Xenomai-core] Re: [PATCH] Auto-allocation of minor values for pipe
	objects
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--0__=4EBBFA28DFA51BC58f9e8a93df938690918c4EBBFA28DFA51BC5
Content-type: multipart/alternative; 
	Boundary="1__=4EBBFA28DFA51BC58f9e8a93df938690918c4EBBFA28DFA51BC5"

--1__=4EBBFA28DFA51BC58f9e8a93df938690918c4EBBFA28DFA51BC5
Content-type: text/plain; charset=US-ASCII


Philippe Gerum <rpm@xenomai.org> wrote on 15.11.2005 23:17:50:

> Dmitry Adamushko wrote:
> >
> > Hello,
> >
> > enclosed please find a patch that hopefully adds so desired
> > functionality. I have made various tests with it just now and it seems
> > to work fine.
> >
>
> Sounds good.
>
> > A size of the bitmap is dependent on XNPIPE_NDEVS parameter in the same

> > vein as xnpipe_states depends on it; so hopefully that is what you have

> > meant Philippe (?)
> >
>
> And NDEVS still does not depend on BITS_PER_LONG - yes, that's ok.
>
> Two minor missing points :
>
> - Doc update for rt_pipe_create() describing P_MINOR_AUTO
> - ChangeLog frag

Enclosed a final patch.

One thing I wanted to point out is that the exteneded interface is not
usable for the "rtai" skin since rtf_create() must know a real minor before
calling xnpipe_connect() (at least it's implemented this way at the
moment).

int rtf_create (unsigned minor, int size)

{

...
    fifo = __fifo_table + minor;    <---- That's the reason!

    err = xnpipe_connect(minor,
                         &__fifo_output_handler,
                         &__fifo_exec_handler,
                         NULL,
                         fifo);     <---- it's already dependent on minor.

And I don't think, of course, it's a good idea to export a separate
interface for allocation of minor values from the nucleus. So either:

- rtf_create() should be rewritten differently;

- keep it as is since it looks like the real rtai interface doesn't require
such a functionality.


> --
>
> Philippe.


---
Best regards,
Dmitry

(See attached file: pipe.auto-minor-3.patch)
--1__=4EBBFA28DFA51BC58f9e8a93df938690918c4EBBFA28DFA51BC5
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Philippe Gerum &lt;rpm@xenomai.org&gt; wrote on 15.11.2005 23:17:50:<br>
<br>
&gt; Dmitry Adamushko wrote:<br>
&gt; &gt; <br>
&gt; &gt; Hello,<br>
&gt; &gt; <br>
&gt; &gt; enclosed please find a patch that hopefully adds so desired <br>
&gt; &gt; functionality. I have made various tests with it just now and it seems <br>
&gt; &gt; to work fine.<br>
&gt; &gt; <br>
&gt; <br>
&gt; Sounds good.<br>
&gt; <br>
&gt; &gt; A size of the bitmap is dependent on XNPIPE_NDEVS parameter in the same <br>
&gt; &gt; vein as xnpipe_states depends on it; so hopefully that is what you have <br>
&gt; &gt; meant Philippe (?)<br>
&gt; &gt;<br>
&gt; <br>
&gt; And NDEVS still does not depend on BITS_PER_LONG - yes, that's ok.<br>
&gt; <br>
&gt; Two minor missing points :<br>
&gt; <br>
&gt; - Doc update for rt_pipe_create() describing P_MINOR_AUTO<br>
&gt; - ChangeLog frag<br>
</tt><br>
<tt>Enclosed a final patch.</tt><br>
<br>
<tt>One thing I wanted to point out is that the exteneded interface is not usable for the &quot;rtai&quot; skin since rtf_create() must know a real minor before calling xnpipe_connect() (at least it's implemented this way at the moment).</tt><br>
<br>
<tt>int rtf_create (unsigned minor, int size)</tt><br>
<br>
<tt>{</tt><br>
<br>
<tt>...</tt><br>
<tt> &nbsp; &nbsp;fifo = __fifo_table + minor;	&lt;---- That's the reason!</tt><br>
<br>
<tt> &nbsp; &nbsp;err = xnpipe_connect(minor,</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &amp;__fifo_output_handler,</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &amp;__fifo_exec_handler,</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; NULL,</tt><br>
<tt> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fifo);	&lt;---- it's already dependent on minor.</tt><br>
<br>
<tt>And I don't think, of course, it's a good idea to export a separate interface for allocation of minor values from the nucleus. So either:</tt><br>
<br>
<tt>- rtf_create() should be rewritten differently;</tt><br>
<br>
<tt>- keep it as is since it looks like the real rtai interface doesn't require such a functionality.</tt><br>
<br>
<br>
<tt>&gt; -- <br>
&gt; <br>
&gt; Philippe.<br>
</tt><br>
<br>
<tt>---</tt><br>
<tt>Best regards,</tt><br>
<tt>Dmitry</tt><br>
<br>
<i>(See attached file: pipe.auto-minor-3.patch)</i></body></html>

--1__=4EBBFA28DFA51BC58f9e8a93df938690918c4EBBFA28DFA51BC5--


--0__=4EBBFA28DFA51BC58f9e8a93df938690918c4EBBFA28DFA51BC5
Content-type: application/octet-stream; 
	name="pipe.auto-minor-3.patch"
Content-Disposition: attachment; filename="pipe.auto-minor-3.patch"
Content-ID: <10__=4EBBFA28DFA51BC58f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

ZGlmZiAtdXIgeGVub21haS9DaGFuZ2VMb2cgeGVub21haS1waXBlMi9DaGFuZ2VMb2cKLS0tIHhl
bm9tYWkvQ2hhbmdlTG9nCTIwMDUtMTEtMTQgMTY6MDE6MDYuMDAwMDAwMDAwICswMTAwCisrKyB4
ZW5vbWFpLXBpcGUyL0NoYW5nZUxvZwkyMDA1LTExLTE2IDEyOjExOjA1LjAwMDAwMDAwMCArMDEw
MApAQCAtMSwzICsxLDE0IEBACisKKzIwMDUtMTEtMTYgIERtaXRyeSBBZGFtdXNoa28gPGRtaXRy
eS5hZGFtdXNoa29AZ21haWwuY29tPgorCisJKiBudWNsZXVzL3BpcGUuYywgc2tpbnMvbmF0aXZl
L3BpcGUuYzogU3VwcG9ydCBmb3IgYXV0by1hbGxvY2F0aW9uCisJb2YgbWlub3IgdmFsdWVzIGZv
ciB0aGUgcGlwZSBvYmplY3RzLiBQYXNzaW5nIFBfTUlOT1JfQVVUTyBhcyBhIHRoaXJkIAorCWFy
Z3VtZW50IHRvIHRoZSBydF9waXBlX2NyZWF0ZSgpIGNhdXNlcyB0aGUgbWlub3IgdmFsdWUgdG8g
YmUKKwlhdXRvLWFsbG9jYXRlZC4gSW4gc3VjaCBhIGNhc2UsIHN0YW5kYXJkIGxpbnV4IHByb2Nl
c3NlcyBtdXN0CisJbWFrZSB1c2Ugb2YgdGhlIHZhbGlkIHBpcGUgbmFtZSBleHBvcnRlZCB0aHJv
dWdoIHRoZSByZWdpc3RyeQorCWludGVyZmFjZSBpbiBvcmRlciB0byBnZXQgY29ubmVjdGVkIHRv
IHRoZSBwaXBlCisJKGkuZS4gL3Byb2MveGVub21haS9yZWdpc3RyeS9waXBlcy8qKS4KKwogMjAw
NS0xMS0xNCAgUGhpbGlwcGUgR2VydW0gIDxycG1AeGVub21haS5vcmc+CiAKIAkqIHNraW5zL25h
dGl2ZS9waXBlLmg6IERlY2xhcmUgcnRfcGlwZV9mbHVzaCgpIGluIGtlcm5lbCBzZWN0aW9uLgpk
aWZmIC11ciB4ZW5vbWFpL2luY2x1ZGUvbnVjbGV1cy9waXBlLmggeGVub21haS1waXBlMi9pbmNs
dWRlL251Y2xldXMvcGlwZS5oCi0tLSB4ZW5vbWFpL2luY2x1ZGUvbnVjbGV1cy9waXBlLmgJMjAw
NS0xMC0wNyAyMzoxMToyMy4wMDAwMDAwMDAgKzAyMDAKKysrIHhlbm9tYWktcGlwZTIvaW5jbHVk
ZS9udWNsZXVzL3BpcGUuaAkyMDA1LTExLTE1IDEwOjE5OjE5LjAwMDAwMDAwMCArMDEwMApAQCAt
MzAsNiArMzAsOCBAQAogI2RlZmluZSBYTlBJUEVfTk9STUFMIDB4MAogI2RlZmluZSBYTlBJUEVf
VVJHRU5UIDB4MQogCisjZGVmaW5lIFhOUElQRV9NSU5PUl9BVVRPCS0xCisKICNpZmRlZiBfX0tF
Uk5FTF9fCiAKICNpbmNsdWRlIDxudWNsZXVzL3F1ZXVlLmg+CmRpZmYgLXVyIHhlbm9tYWkvbnVj
bGV1cy9waXBlLmMgeGVub21haS1waXBlMi9udWNsZXVzL3BpcGUuYwotLS0geGVub21haS9udWNs
ZXVzL3BpcGUuYwkyMDA1LTExLTA5IDE5OjIwOjQ3LjAwMDAwMDAwMCArMDEwMAorKysgeGVub21h
aS1waXBlMi9udWNsZXVzL3BpcGUuYwkyMDA1LTExLTE1IDE4OjQ0OjUxLjAwMDAwMDAwMCArMDEw
MApAQCAtNDMsNiArNDMsOSBAQAogCiB4bnBpcGVfc3RhdGVfdCB4bnBpcGVfc3RhdGVzW1hOUElQ
RV9OREVWU107CiAKKyNkZWZpbmUgWE5QSVBFX0JJVE1BUF9TSVpFCSgoWE5QSVBFX05ERVZTICsg
QklUU19QRVJfTE9ORyAtIDEpIC8gQklUU19QRVJfTE9ORykKK3N0YXRpYyB1bnNpZ25lZCBsb25n
IHhucGlwZV9iaXRtYXBbWE5QSVBFX0JJVE1BUF9TSVpFXTsKKwogeG5xdWV1ZV90IHhucGlwZV9z
bGVlcHEsIHhucGlwZV9hc3luY3E7CiAKIGludCB4bnBpcGVfd2FrZXVwX2FwYzsKQEAgLTU3LDYg
KzYwLDM3IEBACiAgICAjZGVmaW5lIGNsYXNzX2Rlc3Ryb3kgY2xhc3Nfc2ltcGxlX2Rlc3Ryb3kK
ICNlbmRpZgogCisvKiBBbGxvY2F0aW9uIG9mIG1pbm9yIHZhbHVlcyAqLworCitzdGF0aWMgaW5s
aW5lIGludCB4bnBpcGVfbWlub3JfYWxsb2MoaW50IG1pbm9yKQoreworICAgIHNwbF90IHM7CisK
KyAgICBpZiAoKG1pbm9yIDwgMCAmJiBtaW5vciAhPSBYTlBJUEVfTUlOT1JfQVVUTykgfHwgbWlu
b3IgPj0gWE5QSVBFX05ERVZTKQorCXJldHVybiAtRU5PREVWOworCisgICAgeG5sb2NrX2dldF9p
cnFzYXZlKCZua2xvY2sscyk7CisKKyAgICBpZiAobWlub3IgPT0gWE5QSVBFX01JTk9SX0FVVE8p
CisJbWlub3IgPSBmaW5kX2ZpcnN0X3plcm9fYml0KHhucGlwZV9iaXRtYXAsWE5QSVBFX05ERVZT
KTsKKworICAgIGlmIChtaW5vciA9PSBYTlBJUEVfTkRFVlMgfHwgdGVzdGJpdHMoeG5waXBlX2Jp
dG1hcFttaW5vciAvIEJJVFNfUEVSX0xPTkddLCAxIDw8IChtaW5vciAlIEJJVFNfUEVSX0xPTkcp
KSkKKyAgICAgICAgbWlub3IgPSAtRUJVU1k7CisgICAgZWxzZSAgICAKKwlfX3NldGJpdHMoeG5w
aXBlX2JpdG1hcFttaW5vciAvIEJJVFNfUEVSX0xPTkddLCAxIDw8IChtaW5vciAlIEJJVFNfUEVS
X0xPTkcpKTsKKworICAgIHhubG9ja19wdXRfaXJxcmVzdG9yZSgmbmtsb2NrLHMpOworICAgIHJl
dHVybiBtaW5vcjsKK30KKworc3RhdGljIGlubGluZSB2b2lkIHhucGlwZV9taW5vcl9mcmVlKGlu
dCBtaW5vcikKK3sKKyAgICBpZiAobWlub3IgPCAwIHx8IG1pbm9yID49IFhOUElQRV9OREVWUykK
KwlyZXR1cm47CisKKyAgICBjbHJiaXRzKHhucGlwZV9iaXRtYXBbbWlub3IgLyBCSVRTX1BFUl9M
T05HXSwgMSA8PCAobWlub3IgJSBCSVRTX1BFUl9MT05HKSk7Cit9CisKIC8qIEdldCBua2xvY2sg
bG9ja2VkIGJlZm9yZSB1c2luZyB0aGlzIG1hY3JvICovCiAKICNkZWZpbmUgeG5waXBlX3JlYWRf
d2FpdChzdGF0ZSxmbGFncykJCQkJCQlcCkBAIC0yMTUsOCArMjQ5LDkgQEAKICAgICBpbnQgbmVl
ZF9zY2hlZCA9IDA7CiAgICAgc3BsX3QgczsKIAotICAgIGlmIChtaW5vciA8IDAgfHwgbWlub3Ig
Pj0gWE5QSVBFX05ERVZTKQotCXJldHVybiAtRU5PREVWOworICAgIG1pbm9yID0geG5waXBlX21p
bm9yX2FsbG9jKG1pbm9yKTsKKyAgICBpZiAobWlub3IgPCAwKQorCXJldHVybiBtaW5vcjsKIAog
ICAgIHN0YXRlID0gJnhucGlwZV9zdGF0ZXNbbWlub3JdOwogCkBAIC0yMjQsMTIgKzI1OSw2IEBA
CiAgICAgICAgdG8gcHJldmVudCB1c2luZyBhIHBhcnRpYWxseSBjcmVhdGVkIG9iamVjdCAqLwog
ICAgIHhubG9ja19nZXRfaXJxc2F2ZSgmbmtsb2NrLHMpOwogCi0gICAgaWYgKHRlc3RiaXRzKHN0
YXRlLT5zdGF0dXMsWE5QSVBFX0tFUk5fQ09OTikpCi0JewotCXhubG9ja19wdXRfaXJxcmVzdG9y
ZSgmbmtsb2NrLHMpOwotCXJldHVybiAtRUJVU1k7Ci0JfQotICAgIAogICAgIHNldGJpdHMoc3Rh
dGUtPnN0YXR1cyxYTlBJUEVfS0VSTl9DT05OKTsKICAgICAKICAgICB4bnN5bmNoX2luaXQoJnN0
YXRlLT5zeW5jaGJhc2UsWE5TWU5DSF9GSUZPKTsKQEAgLTI2MSw3ICsyOTAsNyBAQAogICAgIGlm
IChuZWVkX3NjaGVkKQogICAgICAgICB4bnBpcGVfc2NoZWR1bGVfcmVxdWVzdCgpOwogCi0gICAg
cmV0dXJuIDA7CisgICAgcmV0dXJuIG1pbm9yOwogfQogCiBpbnQgeG5waXBlX2Rpc2Nvbm5lY3Qg
KGludCBtaW5vcikKQEAgLTMyMyw2ICszNTIsOCBAQAogCSAgICB9CiAJfQogCisgICAgeG5waXBl
X21pbm9yX2ZyZWUobWlub3IpOworCiAgICAgeG5sb2NrX3B1dF9pcnFyZXN0b3JlKCZua2xvY2ss
cyk7CiAKICAgICBpZiAobmVlZF9zY2hlZCkKZGlmZiAtdXIgeGVub21haS9za2lucy9uYXRpdmUv
cGlwZS5jIHhlbm9tYWktcGlwZTIvc2tpbnMvbmF0aXZlL3BpcGUuYwotLS0geGVub21haS9za2lu
cy9uYXRpdmUvcGlwZS5jCTIwMDUtMTEtMTQgMTc6MTE6MjIuMDAwMDAwMDAwICswMTAwCisrKyB4
ZW5vbWFpLXBpcGUyL3NraW5zL25hdGl2ZS9waXBlLmMJMjAwNS0xMS0xNiAxMjoxMjo0Ni4wMDAw
MDAwMDAgKzAxMDAKQEAgLTE5NCw2ICsxOTQsMTIgQEAKICAqIHRoZSBjdXJyZW50IHN5c3RlbSBj
b25maWd1cmF0aW9uLgogICoKICAqIEBwYXJhbSBtaW5vciBUaGUgbWlub3IgbnVtYmVyIG9mIHRo
ZSBkZXZpY2UgYXNzb2NpYXRlZCB3aXRoIHRoZSBwaXBlLgorICogUGFzc2luZyBQX01JTk9SX0FV
VE8gY2F1c2VzIHRoZSBtaW5vciBudW1iZXIgdG8gYmUgYXV0by1hbGxvY2F0ZWQuIEluCisgKiBz
dWNoIGEgY2FzZSwgdGhlIEBhIG5hbWUgcGFyYW1ldGVyIG11c3QgYmUgdmFsaWQgYW5kIHRoZSBv
bmx5IHdheQorICogc3RhbmRhcmQgbGludXggcHJvY2Vzc2VzIG1heSBjb25uZWN0IHRvIHRoZSBw
aXBlIGlzIGJ5IGZvbGxvd2luZworICogYSBzeW1ib2xpYyBsaW5rIGZyb20gL3Byb2MveGVub21h
aS9yZWdpc3RyeS9waXBlcy9AYSBuYW1lIHNpbmNlCisgKiB0aGUgbWlub3IgbnVtYmVyIGlzIHVu
a25vd24gYW5kIGRpcmVjdGx5IGFjY2Vzc2luZyB0aGUgYXNzb2NpYXRlZAorICogc3BlY2lhbCBk
ZXZpY2UgKGkuZS4gL2Rldi9ydHAqKSBpcyBub3QgcG9zc2libGUuCiAgKgogICogQHJldHVybiAw
IGlzIHJldHVybmVkIHVwb24gc3VjY2Vzcy4gT3RoZXJ3aXNlOgogICoKQEAgLTIyNywxMiArMjMz
LDExIEBACiAJCSAgICBjb25zdCBjaGFyICpuYW1lLAogCQkgICAgaW50IG1pbm9yKQogewotICAg
IGludCBlcnI7CisgICAgaW50IGVyciA9IDA7CiAKICAgICBpZiAoeG5wb2RfYXN5bmNoX3AoKSkK
IAlyZXR1cm4gLUVQRVJNOwogCi0gICAgcGlwZS0+bWlub3IgPSBtaW5vcjsKICAgICBwaXBlLT5i
dWZmZXIgPSBOVUxMOwogICAgIHBpcGUtPmZpbGxzeiA9IDA7CiAgICAgcGlwZS0+Zmx1c2hhYmxl
ID0gMDsKQEAgLTI0MCwxMyArMjQ1LDE2IEBACiAgICAgcGlwZS0+bWFnaWMgPSBYRU5PX1BJUEVf
TUFHSUM7CiAgICAgeG5vYmplY3RfY29weV9uYW1lKHBpcGUtPm5hbWUsbmFtZSk7CiAKLSAgICBl
cnIgPSB4bnBpcGVfY29ubmVjdChtaW5vciwKKyAgICBtaW5vciA9IHhucGlwZV9jb25uZWN0KG1p
bm9yLAogCQkJICZfX3BpcGVfb3V0cHV0X2hhbmRsZXIsCiAJCQkgTlVMTCwKIAkJCSAmX19waXBl
X2FsbG9jX2hhbmRsZXIsCiAJCQkgcGlwZSk7Ci0gICAgaWYgKGVycikKLQlyZXR1cm4gZXJyOwor
CisgICAgaWYgKG1pbm9yIDwgMCkKKwlyZXR1cm4gbWlub3I7CisKKyAgICBwaXBlLT5taW5vciA9
IG1pbm9yOwogCiAjaWZkZWYgQ09ORklHX1hFTk9fT1BUX1BFUlZBU0lWRQogICAgIHBpcGUtPmNw
aWQgPSAwOwpkaWZmIC11ciB4ZW5vbWFpL3NraW5zL25hdGl2ZS9waXBlLmggeGVub21haS1waXBl
Mi9za2lucy9uYXRpdmUvcGlwZS5oCi0tLSB4ZW5vbWFpL3NraW5zL25hdGl2ZS9waXBlLmgJMjAw
NS0xMS0xNCAxNjowMTowNi4wMDAwMDAwMDAgKzAxMDAKKysrIHhlbm9tYWktcGlwZTIvc2tpbnMv
bmF0aXZlL3BpcGUuaAkyMDA1LTExLTE1IDExOjM0OjAwLjAwMDAwMDAwMCArMDEwMApAQCAtMjks
NiArMjksOCBAQAogI2RlZmluZSBQX05PUk1BTCAgWE5QSVBFX05PUk1BTAogI2RlZmluZSBQX1VS
R0VOVCAgWE5QSVBFX1VSR0VOVAogCisjZGVmaW5lIFBfTUlOT1JfQVVUTwlYTlBJUEVfTUlOT1Jf
QVVUTworCiB0eXBlZGVmIHN0cnVjdCBydF9waXBlX3BsYWNlaG9sZGVyIHsKICAgICBydF9oYW5k
bGVfdCBvcGFxdWU7CiB9IFJUX1BJUEVfUExBQ0VIT0xERVI7Cg==

--0__=4EBBFA28DFA51BC58f9e8a93df938690918c4EBBFA28DFA51BC5--



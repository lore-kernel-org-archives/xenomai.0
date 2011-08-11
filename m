Date: Thu, 11 Aug 2011 10:33:52 +0200
From: "Petr Cervenka" <grugh@domain.hid>
References: <20110809174031.7B1346B2@domain.hid>
	<1312905835.2112.106.camel@domain.hid>
In-Reply-To: <1312905835.2112.106.camel@domain.hid>
MIME-Version: 1.0
Message-Id: <20110811103352.902F5E9E@centrum.cz>
Content-Type: multipart/mixed;
	boundary="_ca29_-------b9292bf0a8ebeffe4be86b79f9fc2cff"
Subject: Re: [Xenomai-help] rt_queue_bind() returns -EACCES
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>


This is a multi-part message in MIME format.
--_ca29_-------b9292bf0a8ebeffe4be86b79f9fc2cff
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello.

I created a simple examples which describe my problem.
It is some kind of server and client.
At first run a qserver and then qclient.
After that close the qserver and try to run it again.
It disallows (in my configuratio) to create the queue because it already =
exists and also the binding to it fails with error -EACCES.
This behavior continues till the qclient is closed. It's perhaps caused b=
y the rt_queue_delete() at the end of qserver.

Also I have one question: How to break the rt_queue_bind call with TM_INF=
INITE parameter, because rt_task_unblock() doesn't work in this case?

______________________________________________________________
> Od: "Philippe Gerum" <rpm@xenomai.org>
> Komu: Petr Cervenka <grugh@domain.hid>
> Datum: 09.08.2011 18:04
> P=C5=99edm=C4=9Bt: Re: [Xenomai-help] rt_queue_bind() returns -EACCES
>
> CC: "xenomai-help" <xenomai@xenomai.org>
>On Tue, 2011-08-09 at 17:40 +0200, Petr Cervenka wrote:
>> Hello everyone.
>>=20
>> I'm trying linux kernel 2.6.38.8 together with xenomai 2.5.6.
>> My application tries to reuse already created rt_queue shared between =
couple of similiar applications.
>> When I try to recreate already existing rt_queue by rt_queue_create i =
get -EEXIST error (as I expected).
>> But if I try to bind it immediately with rt_queue_bind(&queue, QUEUE_N=
AME, TM_NONBLOCK) I get -EACCES error.
>> This error code is not in documentation and with the previously used v=
ersion (kernel 2.6.32.6, xenomai 2.4.10) it was working fine.
>> Do you have any advice or suggestion?
>
>-EACCESS is returned in case an attempt is made to use a binding service
>which does not match the target object. E.g. using rt_queue_bind() for
>binding an existing task.
>
>> Thanks in advance.
>>=20
>> Petr Cervenka
>>=20
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>
>--=20
>Philippe.
>
>
>

--_ca29_-------b9292bf0a8ebeffe4be86b79f9fc2cff
Content-Type: text/x-c++src; name="qserver.cpp"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="qserver.cpp"

I2luY2x1ZGUgPGNzdGRsaWI+CiNpbmNsdWRlIDxpb3N0cmVhbT4KI2luY2x1ZGUgPHN5cy9t
bWFuLmg+CgojaW5jbHVkZSA8bmF0aXZlL3Rhc2suaD4KI2luY2x1ZGUgPG5hdGl2ZS9xdWV1
ZS5oPgojaW5jbHVkZSA8bmF0aXZlL3RpbWVyLmg+Cgp1c2luZyBuYW1lc3BhY2Ugc3RkOwoK
c3RhdGljIFJUX1RBU0sgdGFzazsKc3RhdGljIFJUX1FVRVVFIHF1ZXVlOwpzdGF0aWMgdm9s
YXRpbGUgYm9vbCBlbmQgPSBmYWxzZTsKCnN0YXRpYyB2b2lkIHNpZ0hhbmRsZXIoaW50IHNp
ZyBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSkgewogICAgY291dCA8PCAic2lnbmFsIGhhbmRs
ZXJcbiI7CiAgICBlbmQgPSB0cnVlOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhcioqIGFy
Z3YpIHsKICAgIGludCByZXM7CgogICAgLy8gbG9jayBtZW1vcnkKICAgIG1sb2NrYWxsKE1D
TF9DVVJSRU5UIHwgTUNMX0ZVVFVSRSk7CgogICAgLy8gc2V0dXAgc2lnbmFsIGhhbmRsZXIK
ICAgIHNpZ25hbChTSUdJTlQsIHNpZ0hhbmRsZXIpOwogICAgc2lnbmFsKFNJR1RFUk0sIHNp
Z0hhbmRsZXIpOwogICAgc2lnbmFsKFNJR0hVUCwgc2lnSGFuZGxlcik7CiAgICBzaWduYWwo
U0lHQUxSTSwgc2lnSGFuZGxlcik7CgogICAgLy8gc2hhZG93IHRhc2sKICAgIGNvdXQgPDwg
InJ0X3NoYWRvd190YXNrXG4iOwogICAgcmVzID0gcnRfdGFza19zaGFkb3coCiAgICAgICAg
ICAgICZ0YXNrLCAgICAgICAgICAgICAgLy8gdGFzawogICAgICAgICAgICAiUVNFUlZFUiIs
ICAgICAgICAgIC8vIG5hbWUKICAgICAgICAgICAgMTAsICAgICAgICAgICAgICAgICAvLyBw
cmlvcml0eQogICAgICAgICAgICBUX0ZQVSAgICAgICAgICAgICAgIC8vIG1vZGUgVF9GUFUs
IFRfQ1BVKGkpLCBUX1NVU1AsIC4uLgogICAgICAgICAgICApOwogICAgaWYgKHJlcyA8IDAp
IHsKICAgICAgICBjZXJyIDw8ICJydF90YXNrX3NoYWRvdygpIGZhaWxlZDogIiA8PCByZXMg
PDwgZW5kbDsKICAgICAgICBnb3RvIGNsZWFudXBfZW5kOwogICAgfQoKICAgIC8vIGNyZWF0
ZSBxdWV1ZQogICAgY291dCA8PCAicnRfcXVldWVfY3JlYXRlXG4iOwogICAgcmVzID0gcnRf
cXVldWVfY3JlYXRlKAogICAgICAgICAgICAmcXVldWUsICAgICAgICAgICAgIC8vIHF1ZXVl
CiAgICAgICAgICAgICJRUVVFVUUiLCAgICAgICAgICAgLy8gbmFtZQogICAgICAgICAgICAx
MDAwMDAwLCAgICAgICAgICAgIC8vIHBvb2wgc2l6ZQogICAgICAgICAgICBRX1VOTElNSVRF
RCwgICAgICAgIC8vIHFsaW1pdAogICAgICAgICAgICBRX0ZJRk8gfCBRX1NIQVJFRCAgIC8v
IG1vZGUKICAgICAgICAgICAgKTsKICAgIGlmIChyZXMgPT0gLUVFWElTVCkgewogICAgICAg
IGNvdXQgPDwgInF1ZXVlIGFscmVhZHkgZXhpc3RzLCB0cnlpbmcgdG8gYmluZCBpdFxuIjsK
ICAgICAgICBjb3V0IDw8ICJydF9xdWV1ZV9iaW5kXG4iOwogICAgICAgIHJlcyA9IHJ0X3F1
ZXVlX2JpbmQoJnF1ZXVlLCAiUVFVRVVFIiwgVE1fTk9OQkxPQ0spOwogICAgfQogICAgaWYg
KHJlcyA8IDApIHsKICAgICAgICBjZXJyIDw8ICJydF9xdWV1ZV9jcmVhdGUoKSBvciBydF9x
dWV1ZV9iaW5kKCkgZmFpbGVkOiAiIDw8IHJlcyA8PCBlbmRsOwogICAgICAgIGdvdG8gY2xl
YW51cF90YXNrOwogICAgfQoKICAgIC8vIGVuZGxlc3MgbG9vcAogICAgd2hpbGUgKCFlbmQg
JiYgKHJlcyA9PSAwIHx8IHJlcyA9PSAtRVRJTUVET1VUKSkgewogICAgICAgIGNvdXQgPDwg
Ii4iOwogICAgICAgIGNvdXQuZmx1c2goKTsKICAgICAgICB2b2lkICptc2c7CiAgICAgICAg
cmVzID0gcnRfcXVldWVfcmVjZWl2ZSgmcXVldWUsICZtc2csIHJ0X3RpbWVyX25zMnRpY2tz
KDEwMDAwMDAwMDBsbCkpOwogICAgICAgIGlmIChyZXMgPj0gMCkgewogICAgICAgICAgICBj
b3V0IDw8ICJydF9xdWV1ZV9mcmVlXG4iOwogICAgICAgICAgICBydF9xdWV1ZV9mcmVlKCZx
dWV1ZSwgbXNnKTsKICAgICAgICB9IGVsc2UgaWYgKHJlcyAhPSAtRVRJTUVET1VUKSB7CiAg
ICAgICAgICAgIGNlcnIgPDwgInJ0X3F1ZXVlX3JlY2VpdmUoKSBmYWlsZWQ6ICIgPDwgcmVz
IDw8IGVuZGw7CiAgICAgICAgfQogICAgfQoKY2xlYW51cF9xdWV1ZToKICAgIGNvdXQgPDwg
InJ0X3F1ZXVlX2RlbGV0ZVxuIjsKICAgIHJ0X3F1ZXVlX2RlbGV0ZSgmcXVldWUpOwpjbGVh
bnVwX3Rhc2s6CmNsZWFudXBfZW5kOgogICAgY291dCA8PCAiYXBwbGljYXRpb24gZXhpdFxu
IjsKICAgIHJldHVybiAoRVhJVF9TVUNDRVNTKTsKfQo=
--_ca29_-------b9292bf0a8ebeffe4be86b79f9fc2cff
Content-Type: text/x-c++src; name="qclient.cpp"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="qclient.cpp"

I2luY2x1ZGUgPGNzdGRsaWI+CiNpbmNsdWRlIDxpb3N0cmVhbT4KI2luY2x1ZGUgPHN5cy9t
bWFuLmg+CgojaW5jbHVkZSA8bmF0aXZlL3Rhc2suaD4KI2luY2x1ZGUgPG5hdGl2ZS9xdWV1
ZS5oPgojaW5jbHVkZSA8bmF0aXZlL3RpbWVyLmg+Cgp1c2luZyBuYW1lc3BhY2Ugc3RkOwoK
c3RhdGljIFJUX1RBU0sgdGFzazsKc3RhdGljIFJUX1FVRVVFIHF1ZXVlOwpzdGF0aWMgdm9s
YXRpbGUgYm9vbCBlbmQgPSBmYWxzZTsKCnN0YXRpYyB2b2lkIHNpZ0hhbmRsZXIoaW50IHNp
ZyBfX2F0dHJpYnV0ZV9fKCh1bnVzZWQpKSkgewogICAgY291dCA8PCAic2lnbmFsIGhhbmRs
ZXJcbiI7CiAgICBlbmQgPSB0cnVlOwogICAgcnRfdGFza191bmJsb2NrKCZ0YXNrKTsKfQoK
aW50IG1haW4oaW50IGFyZ2MsIGNoYXIqKiBhcmd2KSB7CiAgICBpbnQgcmVzOwoKICAgIC8v
IGxvY2sgbWVtb3J5CiAgICBtbG9ja2FsbChNQ0xfQ1VSUkVOVCB8IE1DTF9GVVRVUkUpOwoK
ICAgIC8vIHNldHVwIHNpZ25hbCBoYW5kbGVyCiAgICBzaWduYWwoU0lHSU5ULCBzaWdIYW5k
bGVyKTsKICAgIHNpZ25hbChTSUdURVJNLCBzaWdIYW5kbGVyKTsKICAgIHNpZ25hbChTSUdI
VVAsIHNpZ0hhbmRsZXIpOwogICAgc2lnbmFsKFNJR0FMUk0sIHNpZ0hhbmRsZXIpOwoKICAg
IC8vIHNoYWRvdyB0YXNrCiAgICBjb3V0IDw8ICJydF9zaGFkb3dfdGFza1xuIjsKICAgIHJl
cyA9IHJ0X3Rhc2tfc2hhZG93KAogICAgICAgICAgICAmdGFzaywgICAgICAgICAgLy8gdGFz
awogICAgICAgICAgICAiUUNMSUVOVCIsICAgICAgLy8gbmFtZQogICAgICAgICAgICAxMCwg
ICAgICAgICAgICAgLy8gcHJpb3JpdHkKICAgICAgICAgICAgVF9GUFUgICAgICAgICAgIC8v
IG1vZGUgVF9GUFUsIFRfQ1BVKGkpLCBUX1NVU1AsIC4uLgogICAgICAgICAgICApOwogICAg
aWYgKHJlcyA8IDApIHsKICAgICAgICBjZXJyIDw8ICJydF90YXNrX3NoYWRvdygpIGZhaWxl
ZDogIiA8PCByZXMgPDwgZW5kbDsKICAgICAgICBnb3RvIGNsZWFudXBfZW5kOwogICAgfQoK
ICAgIC8vIGJpbmQgcXVldWUKICAgIGNvdXQgPDwgInJ0X3F1ZXVlX2JpbmRcbiI7CiAgICBy
ZXMgPSBydF9xdWV1ZV9iaW5kKCZxdWV1ZSwgIlFRVUVVRSIsIFRNX0lORklOSVRFKTsKICAg
IGlmIChyZXMgPCAwKSB7CiAgICAgICAgY2VyciA8PCAicnRfcXVldWVfYmluZCgpIGZhaWxl
ZDogIiA8PCByZXMgPDwgZW5kbDsKICAgICAgICBnb3RvIGNsZWFudXBfdGFzazsKICAgIH0K
CiAgICAvLyBlbmRsZXNzIGxvb3AKICAgIHdoaWxlICghZW5kKSB7CiAgICAgICAgY291dCA8
PCAiLiI7CiAgICAgICAgY291dC5mbHVzaCgpOwogICAgICAgIHJ0X3Rhc2tfc2xlZXAocnRf
dGltZXJfbnMydGlja3MoMTAwMDAwMDAwMGxsKSk7CiAgICB9CgpjbGVhbnVwX3F1ZXVlOgog
ICAgY291dCA8PCAicnRfcXVldWVfdW5iaW5kXG4iOwogICAgcnRfcXVldWVfdW5iaW5kKCZx
dWV1ZSk7CmNsZWFudXBfdGFzazoKY2xlYW51cF9lbmQ6CiAgICBjb3V0IDw8ICJhcHBsaWNh
dGlvbiBleGl0XG4iOwogICAgcmV0dXJuIChFWElUX1NVQ0NFU1MpOwp9Cg==
--_ca29_-------b9292bf0a8ebeffe4be86b79f9fc2cff--


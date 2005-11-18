In-Reply-To: <437DB5EA.6060201@domain.hid>
Subject: Re: [Xenomai-core] [pipe.c] hairy synchronization -> "flush the output
	queue upon closure"
Message-ID: <OFCFB2F55F.EFC474AA-ONC12570BD.00453247-C12570BD.0045E0FD@datacon.at>
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Date: Fri, 18 Nov 2005 13:43:14 +0100
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=4EBBFA2EDFD6B4D78f9e8a93df938690918c4EBBFA2EDFD6B4D7"
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

--0__=4EBBFA2EDFD6B4D78f9e8a93df938690918c4EBBFA2EDFD6B4D7
Content-type: multipart/alternative; 
	Boundary="1__=4EBBFA2EDFD6B4D78f9e8a93df938690918c4EBBFA2EDFD6B4D7"

--1__=4EBBFA2EDFD6B4D78f9e8a93df938690918c4EBBFA2EDFD6B4D7
Content-type: text/plain; charset=US-ASCII


Philippe Gerum <rpm@xenomai.org> wrote on 18.11.2005 12:07:22:

>
> > Hm.. but we still have fasync_helper(-1,file,0,&state->asyncq); which
is
> > about sending a signal and that's perfectly valid (a file::counter is
> > not involved here). And that call may lead to re-scheduling (linux
> > re-scheduling of course) so we can't put it in a blocked section.
> >
> > So the best way I see is to have something like():
> >
> > xnpipe_drop_user_conn()
> > {
> > xnlock_get_irqsave(&nklock,s);
> >
> > while ((holder = getq(&state->outq)) != NULL)
> >
> >  state->output_handler(minor,link2mh(holder),-EPIPE,state->cookie);
> >            }
> >
> >        while ((holder = getq(&state->inq)) != NULL)
> >            {
> >            if (state->input_handler != NULL)
> >
> >  state->input_handler(minor,link2mh(holder),-EPIPE,state->cookie);
> >            else if (state->alloc_handler == NULL)
> >                xnfree(link2mh(holder));
> >            }
> >
> > __clrbits(state->status,XNPIPE_USER_CONN);
> >
> > xnlock_put_irqrestore(&nklock,s);
> > }
> >
> > and call it everywhere instead of
clrbits(state->status,XNPIPE_USER_CONN);
> >
> > This way we may be sure there are no pending messages left.
> >
> >
>
> Sounds consistent, since USER_CONN flag is semantically bound to the
> active/inactive state
> of the associated data queues anyway.
>

Then a patch is enclosed.


> --
>
> Philippe.

---

Dmitry


(See attached file: pipe.cleanup-user-conn.patch)(See attached file:
ChangeLog-diff.patch)
--1__=4EBBFA2EDFD6B4D78f9e8a93df938690918c4EBBFA2EDFD6B4D7
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt>Philippe Gerum &lt;rpm@xenomai.org&gt; wrote on 18.11.2005 12:07:22:<br>
<br>
&gt; <br>
&gt; &gt; Hm.. but we still have fasync_helper(-1,file,0,&amp;state-&gt;asyncq); which is <br>
&gt; &gt; about sending a signal and that's perfectly valid (a <a href="file::counter">file::counter</a> is <br>
&gt; &gt; not involved here). And that call may lead to re-scheduling (linux <br>
&gt; &gt; re-scheduling of course) so we can't put it in a blocked section.<br>
&gt; &gt; <br>
&gt; &gt; So the best way I see is to have something like():<br>
&gt; &gt; <br>
&gt; &gt; xnpipe_drop_user_conn()<br>
&gt; &gt; {<br>
&gt; &gt; xnlock_get_irqsave(&amp;nklock,s);<br>
&gt; &gt; <br>
&gt; &gt; while ((holder = getq(&amp;state-&gt;outq)) != NULL)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>
&gt; &gt; &nbsp;state-&gt;output_handler(minor,link2mh(holder),-EPIPE,state-&gt;cookie);<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; <br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp;while ((holder = getq(&amp;state-&gt;inq)) != NULL)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (state-&gt;input_handler != NULL)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <br>
&gt; &gt; &nbsp;state-&gt;input_handler(minor,link2mh(holder),-EPIPE,state-&gt;cookie);<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else if (state-&gt;alloc_handler == NULL)<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;xnfree(link2mh(holder));<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; <br>
&gt; &gt; __clrbits(state-&gt;status,XNPIPE_USER_CONN);<br>
&gt; &gt; <br>
&gt; &gt; xnlock_put_irqrestore(&amp;nklock,s);<br>
&gt; &gt; }<br>
&gt; &gt; <br>
&gt; &gt; and call it everywhere instead of clrbits(state-&gt;status,XNPIPE_USER_CONN);<br>
&gt; &gt; <br>
&gt; &gt; This way we may be sure there are no pending messages left.<br>
&gt; &gt; <br>
&gt; &gt;<br>
&gt; <br>
&gt; Sounds consistent, since USER_CONN flag is semantically bound to the<br>
&gt; active/inactive state <br>
&gt; of the associated data queues anyway.<br>
&gt; </tt><br>
<br>
<tt>Then a patch is enclosed.</tt><br>
<br>
<br>
<tt>&gt; -- <br>
&gt; <br>
&gt; Philippe.<br>
</tt><br>
<tt>---</tt><br>
<br>
<tt>Dmitry</tt><br>
<br>
<br>
<i>(See attached file: pipe.cleanup-user-conn.patch)</i><i>(See attached file: ChangeLog-diff.patch)</i></body></html>

--1__=4EBBFA2EDFD6B4D78f9e8a93df938690918c4EBBFA2EDFD6B4D7--


--0__=4EBBFA2EDFD6B4D78f9e8a93df938690918c4EBBFA2EDFD6B4D7
Content-type: application/octet-stream; 
	name="pipe.cleanup-user-conn.patch"
Content-Disposition: attachment; filename="pipe.cleanup-user-conn.patch"
Content-ID: <10__=4EBBFA2EDFD6B4D78f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

LS0tIHBpcGUuYy1vbGQJMjAwNS0xMS0xOCAxMzozMTo0NC4wMDAwMDAwMDAgKzAxMDAKKysrIHBp
cGUuYwkyMDA1LTExLTE4IDE0OjUxOjE2LjAwMDAwMDAwMCArMDEwMApAQCAtMzgxLDE2ICszODEs
MTYgQEAKIAogICAgIHhubG9ja19nZXRfaXJxc2F2ZSgmbmtsb2NrLHMpOwogCi0gICAgaWYgKCF0
ZXN0Yml0cyhzdGF0ZS0+c3RhdHVzLFhOUElQRV9VU0VSX0NPTk4pKQorICAgIGlmICghdGVzdGJp
dHMoc3RhdGUtPnN0YXR1cyxYTlBJUEVfS0VSTl9DT05OKSkKIAl7CiAJeG5sb2NrX3B1dF9pcnFy
ZXN0b3JlKCZua2xvY2sscyk7Ci0JcmV0dXJuIC1FUElQRTsKKwlyZXR1cm4gLUVCQURGOwogCX0K
IAotICAgIGlmICghdGVzdGJpdHMoc3RhdGUtPnN0YXR1cyxYTlBJUEVfS0VSTl9DT05OKSkKKyAg
ICBpZiAoIXRlc3RiaXRzKHN0YXRlLT5zdGF0dXMsWE5QSVBFX1VTRVJfQ09OTikpCiAJewogCXhu
bG9ja19wdXRfaXJxcmVzdG9yZSgmbmtsb2NrLHMpOwotCXJldHVybiAtRUJBREY7CisJcmV0dXJu
IC1FUElQRTsKIAl9CiAKICAgICBpbml0aCh4bnBpcGVfbV9saW5rKG1oKSk7CkBAIC00MDIsMjIg
KzQwMiwxOSBAQAogICAgIGVsc2UKIAlhcHBlbmRxKCZzdGF0ZS0+b3V0cSx4bnBpcGVfbV9saW5r
KG1oKSk7CiAKLSAgICBpZiAodGVzdGJpdHMoc3RhdGUtPnN0YXR1cyxYTlBJUEVfVVNFUl9DT05O
KSkKLQl7Ci0JaWYgKHRlc3RiaXRzKHN0YXRlLT5zdGF0dXMsWE5QSVBFX1VTRVJfV1JFQUQpKQot
CSAgICB7Ci0JICAgIC8qIFdha2UgdXAgdGhlIHVzZXJsYW5kIHRocmVhZCB3YWl0aW5nIGZvciBp
bnB1dAotCSAgICAgICBmcm9tIHRoZSBrZXJuZWwgc2lkZS4gKi8KLQkgICAgc2V0Yml0cyhzdGF0
ZS0+c3RhdHVzLFhOUElQRV9VU0VSX1dSRUFEX1JFQURZKTsKLQkgICAgbmVlZF9zY2hlZCA9IDE7
Ci0JICAgIH0KLQotCWlmIChzdGF0ZS0+YXN5bmNxKSAvKiBTY2hlZHVsZSBhc3luY2ggc2lnLiAq
LwotCSAgICB7Ci0JICAgIHNldGJpdHMoc3RhdGUtPnN0YXR1cyxYTlBJUEVfVVNFUl9TSUdJTyk7
Ci0JICAgIG5lZWRfc2NoZWQgPSAxOwotCSAgICB9Ci0JfQorICAgIGlmICh0ZXN0Yml0cyhzdGF0
ZS0+c3RhdHVzLFhOUElQRV9VU0VSX1dSRUFEKSkKKyAgICAgICAgeworICAgICAgICAvKiBXYWtl
IHVwIHRoZSB1c2VybGFuZCB0aHJlYWQgd2FpdGluZyBmb3IgaW5wdXQKKyAgICAgICAgICAgZnJv
bSB0aGUga2VybmVsIHNpZGUuICovCisgICAgICAgIHNldGJpdHMoc3RhdGUtPnN0YXR1cyxYTlBJ
UEVfVVNFUl9XUkVBRF9SRUFEWSk7CisgICAgICAgIG5lZWRfc2NoZWQgPSAxOworICAgICAgICB9
CisKKyAgICBpZiAoc3RhdGUtPmFzeW5jcSkgLyogU2NoZWR1bGUgYXN5bmNoIHNpZy4gKi8KKyAg
ICAgICAgeworICAgICAgICBzZXRiaXRzKHN0YXRlLT5zdGF0dXMsWE5QSVBFX1VTRVJfU0lHSU8p
OworICAgICAgICBuZWVkX3NjaGVkID0gMTsKKyAgICAgICAgfQogCiAgICAgeG5sb2NrX3B1dF9p
cnFyZXN0b3JlKCZua2xvY2sscyk7CiAKQEAgLTUyNSw2ICs1MjIsMzggQEAKIH0KIAogLyoKKyAq
IENsZWFyIFhOUElQRV9VU0VSX0NPTk4gZmxhZyBhbmQgY2xlYW51cCB0aGUgYXNzb2NpYXRlZCBk
YXRhIHF1ZXVlcworICogaW4gb25lIGF0b21pYyBzdGVwLgorICovCisKK3N0YXRpYyB2b2lkIHhu
cGlwZV9jbGVhbnVwX3VzZXJfY29ubih4bnBpcGVfc3RhdGVfdCAqc3RhdGUpCit7CisgICAgaW50
IG1pbm9yID0geG5taW5vcl9mcm9tX3N0YXRlKHN0YXRlKTsKKyAgICB4bmhvbGRlcl90ICpob2xk
ZXI7CisgICAgc3BsX3QgczsKKworICAgIHhubG9ja19nZXRfaXJxc2F2ZSgmbmtsb2NrLHMpOwor
CisgICAgaWYgKHN0YXRlLT5vdXRwdXRfaGFuZGxlciAhPSBOVUxMKQorICAgICAgICB7CisgICAg
ICAgIHdoaWxlICgoaG9sZGVyID0gZ2V0cSgmc3RhdGUtPm91dHEpKSAhPSBOVUxMKQorICAgIAkg
ICAgc3RhdGUtPm91dHB1dF9oYW5kbGVyKG1pbm9yLGxpbmsybWgoaG9sZGVyKSwtRVBJUEUsc3Rh
dGUtPmNvb2tpZSk7CisgICAgICAgIH0KKworICAgIHdoaWxlICgoaG9sZGVyID0gZ2V0cSgmc3Rh
dGUtPmlucSkpICE9IE5VTEwpCisgICAgICAgIHsKKyAgICAgICAgaWYgKHN0YXRlLT5pbnB1dF9o
YW5kbGVyICE9IE5VTEwpCisJICAgIHN0YXRlLT5pbnB1dF9oYW5kbGVyKG1pbm9yLGxpbmsybWgo
aG9sZGVyKSwtRVBJUEUsc3RhdGUtPmNvb2tpZSk7CisgICAgICAgIGVsc2UgaWYgKHN0YXRlLT5h
bGxvY19oYW5kbGVyID09IE5VTEwpCisJICAgIHhuZnJlZShsaW5rMm1oKGhvbGRlcikpOworCX0K
KworICAgIF9fY2xyYml0cyhzdGF0ZS0+c3RhdHVzLFhOUElQRV9VU0VSX0NPTk4pOworCisgICAg
eG5sb2NrX3B1dF9pcnFyZXN0b3JlKCZua2xvY2sscyk7Cit9CisKKy8qCiAgKiBPcGVuIHRoZSBw
aXBlIGZyb20gdXNlci1zcGFjZS4KICAqLwogCkBAIC01NjksNyArNTk4LDcgQEAKIAogCSAgICBp
ZiAoZXJyICE9IDApCiAJCXsKLQkJY2xyYml0cyhzdGF0ZS0+c3RhdHVzLFhOUElQRV9VU0VSX0NP
Tk4pOworCQl4bnBpcGVfY2xlYW51cF91c2VyX2Nvbm4oc3RhdGUpOwogCQlyZXR1cm4gZXJyOwog
CQl9CiAKQEAgLTU4MSw3ICs2MTAsNyBAQAogCiAJaWYgKHRlc3RiaXRzKGZpbGUtPmZfZmxhZ3Ms
T19OT05CTE9DSykpCiAJICAgIHsKLSAgICAgICAgICAgIGNscmJpdHMoc3RhdGUtPnN0YXR1cyxY
TlBJUEVfVVNFUl9DT05OKTsKKwkgICAgeG5waXBlX2NsZWFudXBfdXNlcl9jb25uKHN0YXRlKTsK
IAkgICAgeG5sb2NrX3B1dF9pcnFyZXN0b3JlKCZua2xvY2sscyk7CiAgICAgICAgICAgICByZXR1
cm4gLUVXT1VMREJMT0NLOwogCSAgICB9CkBAIC01OTAsNyArNjE5LDcgQEAKIAogCWlmIChzaWdw
ZW5kaW5nICYmICF0ZXN0Yml0cyhzdGF0ZS0+c3RhdHVzLFhOUElQRV9LRVJOX0NPTk4pKQogCSAg
ICB7Ci0JICAgIGNscmJpdHMoc3RhdGUtPnN0YXR1cyxYTlBJUEVfVVNFUl9DT05OKTsKKwkgICAg
eG5waXBlX2NsZWFudXBfdXNlcl9jb25uKHN0YXRlKTsKICAgICAJICAgIHhubG9ja19wdXRfaXJx
cmVzdG9yZSgmbmtsb2NrLHMpOwogCSAgICByZXR1cm4gLUVSRVNUQVJUU1lTOwogCSAgICB9CkBA
IC02MDYsNyArNjM1LDcgQEAKIAl9CiAKICAgICBpZihlcnIpCi0gICAgICAgIGNscmJpdHMoc3Rh
dGUtPnN0YXR1cyxYTlBJUEVfVVNFUl9DT05OKTsKKwl4bnBpcGVfY2xlYW51cF91c2VyX2Nvbm4o
c3RhdGUpOwogICAgIAogICAgIHJldHVybiBlcnI7CiB9CkBAIC02MTUsNyArNjQ0LDYgQEAKIAkJ
CSAgIHN0cnVjdCBmaWxlICpmaWxlKQogewogICAgIHhucGlwZV9zdGF0ZV90ICpzdGF0ZTsKLSAg
ICB4bmhvbGRlcl90ICpob2xkZXI7CiAgICAgaW50IGVyciA9IDA7CiAgICAgc3BsX3QgczsKIApA
QCAtNjMyLDIwICs2NjAsNiBAQAogCXsKIAlpbnQgbWlub3IgPSB4bm1pbm9yX2Zyb21fc3RhdGUo
c3RhdGUpOwogCi0JaWYgKHN0YXRlLT5vdXRwdXRfaGFuZGxlciAhPSBOVUxMKQotCSAgICB7Ci0J
ICAgIHdoaWxlICgoaG9sZGVyID0gZ2V0cSgmc3RhdGUtPm91dHEpKSAhPSBOVUxMKQotCQlzdGF0
ZS0+b3V0cHV0X2hhbmRsZXIobWlub3IsbGluazJtaChob2xkZXIpLC1FUElQRSxzdGF0ZS0+Y29v
a2llKTsKLQkgICAgfQotCi0Jd2hpbGUgKChob2xkZXIgPSBnZXRxKCZzdGF0ZS0+aW5xKSkgIT0g
TlVMTCkKLQkgICAgewotCSAgICBpZiAoc3RhdGUtPmlucHV0X2hhbmRsZXIgIT0gTlVMTCkKLQkJ
c3RhdGUtPmlucHV0X2hhbmRsZXIobWlub3IsbGluazJtaChob2xkZXIpLC1FUElQRSxzdGF0ZS0+
Y29va2llKTsKLQkgICAgZWxzZSBpZiAoc3RhdGUtPmFsbG9jX2hhbmRsZXIgPT0gTlVMTCkKLQkJ
eG5mcmVlKGxpbmsybWgoaG9sZGVyKSk7Ci0JICAgIH0KLQogCS8qIElmIGEgcmVhbC10aW1lIGtl
cm5lbCB0aHJlYWQgaXMgd2FpdGluZyBvbiB0aGlzIG9iamVjdCwKIAkgICB3YWtlIGl0IHVwIG5v
dy4gKi8KIApAQCAtNjYzLDkgKzY3Nyw2IEBACiAgICAgZWxzZQogCXhubG9ja19wdXRfaXJxcmVz
dG9yZSgmbmtsb2NrLHMpOwogCi0gICAgaWYgKHdhaXRxdWV1ZV9hY3RpdmUoJnN0YXRlLT5yZWFk
cSkpCi0Jd2FrZV91cF9pbnRlcnJ1cHRpYmxlX2FsbCgmc3RhdGUtPnJlYWRxKTsKLQogICAgIGlm
IChzdGF0ZS0+YXN5bmNxKSAvKiBDbGVhciB0aGUgYXN5bmMgcXVldWUgKi8KIAl7CiAgICAgICAg
IHhubG9ja19nZXRfaXJxc2F2ZSgmbmtsb2NrLHMpOwpAQCAtNjc2LDcgKzY4Nyw3IEBACiAJfQog
CiAgICAgLyogRnJlZSB0aGUgc3RhdGUgb2JqZWN0LiBTaW5jZSB0aGF0IHRpbWUgaXQgY2FuIGJl
IG9wZW4gYnkgc29tZW9uZSBlbHNlICovCi0gICAgY2xyYml0cyhzdGF0ZS0+c3RhdHVzLFhOUElQ
RV9VU0VSX0NPTk4pOworICAgIHhucGlwZV9jbGVhbnVwX3VzZXJfY29ubihzdGF0ZSk7CiAKICAg
ICByZXR1cm4gZXJyOwogfQo=

--0__=4EBBFA2EDFD6B4D78f9e8a93df938690918c4EBBFA2EDFD6B4D7
Content-type: application/octet-stream; 
	name="ChangeLog-diff.patch"
Content-Disposition: attachment; filename="ChangeLog-diff.patch"
Content-ID: <20__=4EBBFA2EDFD6B4D78f9e8a93df938@domain.hid>
Content-transfer-encoding: base64

LS0tIENoYW5nZUxvZy1vbGQJMjAwNS0xMS0xOCAxNDo0MjowMi4wMDAwMDAwMDAgKzAxMDAKKysr
IENoYW5nZUxvZwkyMDA1LTExLTE4IDE0OjUwOjEzLjAwMDAwMDAwMCArMDEwMApAQCAtMSw0ICsx
LDkgQEAKIAorMjAwNS0xMS0xOCAgRG1pdHJ5IEFkYW11c2hrbyA8ZG1pdHJ5LmFkYW11c2hrb0Bn
bWFpbC5jb20+CisKKwkqIG51Y2xldXMvcGlwZS5jICh4bnBpcGVfY2xlYW51cF91c2VyX2Nvbm4p
OiBDbGVhciBYTlBJUEVfVVNFUl9DT05OCisJZmxhZyBhbmQgY2xlYW51cCB0aGUgYXNzb2NpYXRl
ZCBkYXRhIHF1ZXVlcyBpbiBvbmUgYXRvbWljIHN0ZXAuCisJCiAyMDA1LTExLTE2ICBEbWl0cnkg
QWRhbXVzaGtvIDxkbWl0cnkuYWRhbXVzaGtvQGdtYWlsLmNvbT4KIAogCSogbnVjbGV1cy9waXBl
LmMsIHNraW5zL25hdGl2ZS9waXBlLmM6IFN1cHBvcnQgZm9yIGF1dG8tYWxsb2NhdGlvbgo=

--0__=4EBBFA2EDFD6B4D78f9e8a93df938690918c4EBBFA2EDFD6B4D7--



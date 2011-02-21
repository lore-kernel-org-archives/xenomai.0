MIME-Version: 1.0
Date: Mon, 21 Feb 2011 18:54:35 +0100
Message-ID: <AANLkTikH_NciDFN402p-bvPW__K2du9bZRgcS7AUfz+t@domain.hid>
From: varname <varname@domain.hid>
Content-Type: multipart/mixed; boundary=0016e65da30691e33f049cce8e0c
Subject: [Xenomai-help] rt_pipe_stream: not getting EPIPE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016e65da30691e33f049cce8e0c
Content-Type: text/plain; charset=ISO-8859-1

All,

trying to write a simple producer / consumer using message pipes in
the native API, this phrase from the documentation (found here [1])
confuses me:

"-EPIPE is returned if the associated special device is not yet open."

It's not so much the sentence itself, but more the fact that I'm not
getting that return value from rt_pipe_stream() when streaming bytes
to a RT_PIPE that hasn't had its "special device" opened in secondary
domain.

I've attached a modified trivial-periodic.c that demonstrates what I'm
seeing. Afaik there is nothing open(2)-ing the /dev/rtp9 in the
secondary domain. All writes succeed, up to about write 31 (*1024),
after which all writes return 0.

[..]
wrote: 1024, res: 1024
wrote: 1024, res: 948
wrote: 1024, res: 0
wrote: 1024, res: 0
[..]

Is the documentation incorrect, or am I misunderstanding something?

Related info:
  Xenomai: 2.5.5.2
  Kernel: 2.6.32.26

[1] http://www.xenomai.org/documentation/trunk/html/api/group__pipe.html#gb4d85ecda7675a75611500070c28b22e

--0016e65da30691e33f049cce8e0c
Content-Type: text/x-csrc; charset=US-ASCII; name="trivial-periodic.c"
Content-Disposition: attachment; filename="trivial-periodic.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkfoql6y0

I2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvbW1h
bi5oPgoKI2luY2x1ZGUgPG5hdGl2ZS90YXNrLmg+CiNpbmNsdWRlIDxuYXRpdmUvcGlwZS5oPgoj
aW5jbHVkZSA8cnRkay5oPgoKClJUX1RBU0sgZGVtb190YXNrOwoKCnZvaWQgZGVtbyh2b2lkICph
cmcpCnsKCXJ0X3Rhc2tfc2V0X3BlcmlvZGljKE5VTEwsIFRNX05PVywgNWU4KTsKCglSVF9QSVBF
IHBpcGU7CglpbnQgcmVzID0gcnRfcGlwZV9jcmVhdGUoJnBpcGUsICJzb21lX25hbWUiLCA5LCAw
KTsKCWlmKHJlcyA8IDApCgl7CgkJcnRfcHJpbnRmKHN0cmVycm9yKC1yZXMpKTsKCQlyZXR1cm47
Cgl9CgoJY29uc3QgdW5zaWduZWQgaW50IGJzaXplID0gMTAyNDsKCXVuc2lnbmVkIGNoYXIgYnVm
W2JzaXplXTsKCgl3aGlsZSgxKQoJewoJCXJ0X3Rhc2tfd2FpdF9wZXJpb2QoTlVMTCk7CgoJCXJl
cyA9IHJ0X3BpcGVfc3RyZWFtKCZwaXBlLCAmYnVmLCBic2l6ZSk7CgkJcnRfcHJpbnRmKCJ3cm90
ZTogJXUsIHJlczogJWRcbiIsIGJzaXplLCByZXMpOwoKCQlydF90YXNrX3NsZWVwKDFlOCk7Cgl9
Cn0KCnZvaWQgY2F0Y2hfc2lnbmFsKGludCBzaWcpCnsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIqIGFyZ3ZbXSkKewoJc2lnbmFsKFNJR1RFUk0sIGNhdGNoX3NpZ25hbCk7CglzaWduYWwoU0lH
SU5ULCBjYXRjaF9zaWduYWwpOwoKCW1sb2NrYWxsKE1DTF9DVVJSRU5UfE1DTF9GVVRVUkUpOwoK
CXJ0X3ByaW50X2F1dG9faW5pdCgxKTsKCXJ0X3Rhc2tfY3JlYXRlKCZkZW1vX3Rhc2ssICJ0cml2
aWFsIiwgMCwgOTksIDApOwoJcnRfdGFza19zdGFydCgmZGVtb190YXNrLCAmZGVtbywgTlVMTCk7
CgoJcGF1c2UoKTsKCglydF90YXNrX2RlbGV0ZSgmZGVtb190YXNrKTsKCglyZXR1cm4gMDsKfQo=
--0016e65da30691e33f049cce8e0c--


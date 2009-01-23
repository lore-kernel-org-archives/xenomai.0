Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C97D93.D7D1F008"
Date: Fri, 23 Jan 2009 12:50:27 -0700
Message-ID: <51CAD0CE1504444DBE77CBBE51A0135D5908A5@domain.hid>
In-Reply-To: <497A1E95.4080805@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D5908A3@domain.hid>
	<497A1963.8030902@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5908A4@domain.hid>
	<497A1E95.4080805@domain.hid>
From: "Steven Seeger" <sseeger@domain.hid>
Subject: Re: [Xenomai-help] shadow task and rt_task_self()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


This is a multi-part message in MIME format.

------_=_NextPart_001_01C97D93.D7D1F008
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Gilles,

Attached is my simple test that repeats this problem.

Output is:

0
0 0

This is using latest xenomai trunk.

Thanks,
Steven



> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Friday, January 23, 2009 12:46 PM
> To: Steven Seeger
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] shadow task and rt_task_self()
>=20
> Steven Seeger wrote:
> > Gilles, the problem is very simple. The initial task has
self->opaque
> > set to XN_NO_HANDLE. After you shadow that task, rt_task_self()
still
> > returns NULL.
> >
> > This is either an oversight or you aren't supposed to shadow the
> initial
> > task?
>=20
> Maybe, but please do the work of writing the simplest example. Maybe
> you
> will discover that it is something else in your bigger example that
> causes it. And you still did not tell me if this is a trunk issue or a
> v2.4.x branch issue.
>=20
> --
> 					    Gilles.

------_=_NextPart_001_01C97D93.D7D1F008
Content-Type: application/octet-stream;
	name="self.cpp"
Content-Transfer-Encoding: base64
Content-Description: self.cpp
Content-Disposition: attachment;
	filename="self.cpp"

I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxpb3N0cmVhbT4KI2luY2x1ZGUgPG5hdGl2
ZS90YXNrLmg+Ci8vI2luY2x1ZGUgImkzODcuaCIKCnN0YXRpYyBSVF9UQVNLIHNoYWRvd2VkX3Rh
c2s7CgppbnQgbWFpbigpCnsKICAgaW50IHJldDsKICAgCiAgICBtbG9ja2FsbChNQ0xfQ1VSUkVO
VCB8IE1DTF9GVVRVUkUpOwoKICAgIHN0ZDo6Y291dCA8PCAodm9pZCopcnRfdGFza19zZWxmKCkg
PDwgc3RkOjplbmRsOwogICAgCiAgICByZXQgPSBydF90YXNrX3NoYWRvdygmc2hhZG93ZWRfdGFz
aywgInNoYWRvdyB0ZXN0IiwgMSwgMCk7CiAgICBzdGQ6OmNvdXQgPDwgKHZvaWQqKXJ0X3Rhc2tf
c2VsZigpIDw8ICcgJyA8PCByZXQgPDwgc3RkOjplbmRsOwogICAgICAgIAogICAgcmV0dXJuIDA7
Cn0K

------_=_NextPart_001_01C97D93.D7D1F008--


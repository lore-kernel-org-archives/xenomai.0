MIME-Version: 1.0
Date: Wed, 3 Nov 2010 22:42:09 +0100
Message-ID: <AANLkTing6YXQzXTiGG8PsOPnWM6b2bc0u+Lv3Rmn96je@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6dbe6d5dae73904942ce908
Subject: [Xenomai-core] Is anybody using the pSOS skin in userland?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid

--0016e6dbe6d5dae73904942ce908
Content-Type: text/plain; charset=ISO-8859-1

Hello

we are investigating to usage of the pSOS+ skin to port a large legacy pSOS
application to Linux.
The application model consist of several processes in which the application
lives. All processes will make use of the pSOS library.

After playing around with the library for some time we have observed several
missing service calls, bugs and differences in behaviour compared to a real
pSOS implementation:
- missing sm_ident
- missing t_getreg / t_setreg in userland (patch already included in 2.5.5)
- not possible to use skin from the context of different processes (patch
already included in 2.5.5)
- added support for identical task/queue/semaphore/region names by making
names unique.
- strange behaviour in pSOS message queue (see post "Possible memory leak in
psos skin message queue handling").

I can (and will) deliver patches for all issues I have found, but I'm
wondering whether there are other people using the pSOS skin (in userland)
in a real live application. The target for my project would be an embedded
system with strong reliability requirements (very stable / long running
etc).
Any feedback is welcome and appreciated.

It is not clear to me either which tests are executed before a new version
is released. Is there any test-suite available for the pSOS skin?

Best regards,
Ronny

--0016e6dbe6d5dae73904942ce908
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello</div>
<div>=A0</div>
<div>we are=A0investigating to usage of=A0the pSOS+ skin to port a large le=
gacy pSOS application to Linux.</div>
<div>The application=A0model=A0consist of several processes in which the ap=
plication lives. All processes will make use of the pSOS library.</div>
<div>=A0</div>
<div>After playing around with the library for some time we have observed s=
everal missing service calls, bugs and differences in behaviour compared to=
 a real pSOS implementation:</div>
<div>- missing sm_ident </div>
<div>- missing t_getreg / t_setreg in userland (patch already included in 2=
.5.5)</div>
<div>- not possible to use skin from the context of different processes (pa=
tch already included in 2.5.5)</div>
<div>- added support for identical task/queue/semaphore/region names by mak=
ing names unique.</div>
<div>- strange behaviour in pSOS message queue (see post &quot;Possible mem=
ory leak in psos skin message queue handling&quot;).</div>
<div>=A0</div>
<div>I can (and will) deliver patches for all issues I have found, but I&#3=
9;m wondering whether there are other people using the pSOS skin (in userla=
nd) in a real live application. The target for my project would be an embed=
ded system with strong reliability requirements (very stable / long running=
 etc).</div>

<div>Any feedback is welcome and appreciated.</div>
<div>=A0</div>
<div>It is not clear to me either which tests are executed before a new ver=
sion is released. Is there any test-suite available for the pSOS skin?</div=
>
<div>=A0</div>
<div>Best regards,</div>
<div>Ronny=A0</div>
<div>=A0</div>
<div>=A0</div>

--0016e6dbe6d5dae73904942ce908--


MIME-Version: 1.0
Date: Wed, 9 Jun 2010 11:52:40 +0100
Message-ID: <AANLkTilEKG3zHL2p7jqkZlTqBDKXs7gXApmcaNQDxHZa@domain.hid>
From: Stephen Bryant <sbxenomai@domain.hid>
Content-Type: multipart/alternative; boundary=0016e65b635a703a07048896b48b
Subject: [Xenomai-help] Why are open_rt, close_rt and socket_rt deprecated?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016e65b635a703a07048896b48b
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Since moving to Xenomai 2.5.3 I have noticed that loading one of our kernel
drivers leads to a warning about open_rt and close_rt, stating that they are
deprecated and the drivers require update.  I am sure there is a good reason
for this, but I haven't found an explanation in the Xenomai documentation
(API / The Real-Time Driver Model and First Applications) or on the mailing
lists (help / core), or anywhere else (Google).

I can re-write the driver so that it doesn't use open_rt / close_rt without
affecting the applications that use it, but I am curious as to why using
them is a bad idea? Is it just because loading / unloading a driver does not
take a deterministic time, and therefore should not be considered real-time?

Steve

--0016e65b635a703a07048896b48b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"gI"><span class=3D"ik">Hi, <br><br>Since moving to Xenomai 2=
.5.3 I have noticed that loading one of our kernel drivers leads to a warni=
ng about open_rt and close_rt, stating that they are deprecated and the dri=
vers require update.=A0 I am sure there is a good reason for this, but I ha=
ven&#39;t found an explanation in the Xenomai documentation (API / </span><=
/span><span class=3D"gI"><span class=3D"ik">The Real-Time Driver Model and =
First Applications</span></span><span class=3D"gI"><span class=3D"ik">) or =
on the mailing lists (help / core), or anywhere else (Google).<br>
<br>I can re-write the driver so that it doesn&#39;t use open_rt / close_rt=
 without affecting the applications that use it, but I am curious as to why=
 using them is a bad idea? Is it just because loading / unloading a driver =
does not take a deterministic time, and therefore should not be considered =
real-time?<br>
<br>Steve<br></span></span>

--0016e65b635a703a07048896b48b--


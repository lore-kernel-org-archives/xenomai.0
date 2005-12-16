Message-ID: <b647ffbd0512160453w6baa9d4g@domain.hid>
Date: Fri, 16 Dec 2005 14:53:02 +0200
From: Dmitry Adamushko <dmitry.adamushko@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_6628_12524804.1134737582697"
Subject: [Xenomai-help] [testsuite/latency] intervals are much > than 1
	second
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

------=_Part_6628_12524804.1134737582697
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all,

I have been out of xeno-scope for a while so maybe I successufy missed
something important
that might be the explanation of a problem described below.

The problem is as follows:

x86-ipipe-1.0.10 && xenomai-2.1 (CVS: ~ November, 21)

testsuite/letency is used as it is by defaulty (nsamples =3D 1 billion (1
second) / sample (e.g.100000 us))

I am used to getting data with ~1-second-interval on the screen when
"latency" is running and so expected to observe the same behaviour now.

Nevertheless, the interval (with all parameters by default) is ~ 4 seconds,
and it gets up to 16-17 seconds when -p 1000 (sampling period =3D=3D 1 ms.)=
 is
used.

e.g. it took 1 minute and 30 seconds to get 21 lines of statistics on the
screen (-p 100) but should have been ~22-23 seconds.

And the latency thread really reported the presence of collected data 21
times (through rt_sem_v()) .

So have I missed something important? any ideas are wellcome.

--
Best regards,
Dmitry Adamushko

------=_Part_6628_12524804.1134737582697
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br>
Hello all,<br>
<br>
I have been out of xeno-scope for a while so maybe I successufy missed some=
thing important<br>
that might be the explanation of a problem described below.<br>
<br>
The problem is as follows:<br>
<br>
x86-ipipe-1.0.10 &amp;&amp; xenomai-2.1 (CVS: ~ November, 21)<br>
<br>
testsuite/letency is used as it is by defaulty (nsamples =3D 1 billion (1 s=
econd) / sample (e.g.100000 us))<br>
<br>
I am used to getting data with ~1-second-interval on the screen when
&quot;latency&quot; is running and so expected to observe the same behaviou=
r now.<br>
<br>
Nevertheless, the interval (with all parameters by default) is ~ 4
seconds, and it gets up to 16-17 seconds when -p 1000 (sampling period
=3D=3D 1 ms.) is used.<br>
<br>
e.g. it took 1 minute and 30 seconds to get 21 lines of statistics on the s=
creen (-p 100) but should have been ~22-23 seconds.<br>
<br>
And the latency thread really reported the presence of collected data 21 ti=
mes (through rt_sem_v()) .<br>
<br>
So have I missed something important? any ideas are wellcome.<br>
<br>
-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_6628_12524804.1134737582697--


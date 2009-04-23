MIME-Version: 1.0
Date: Thu, 23 Apr 2009 11:20:10 +0200
Message-ID: <b131c9f0904230220j3f0a7d7ej9172ee4fb48aa69c@domain.hid>
From: vikesh rambaran <vikesh.rambaran@domain.hid>
Content-Type: multipart/alternative; boundary=00032555150afc6edc04683562d3
Subject: [Xenomai-help] adeos patch 2.6.28.9-x86-2.2-07 feedback
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

--00032555150afc6edc04683562d3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

Thanx for the updated patch. Some feedback ...

I tested it with Xenomai 2.4.7 under Ubuntu 8.04.2  on three different
platforms
(AMD Athlon Desktop, Intel Core 2 Desktop, Intel Core Duo Laptop)

Typical system lockups when in the gnome desktop do NOT occur anymore !
Great :)

Initial observations when compared to Xenomai 2.4.5 with
adeos-ipipe-2.6.24-x86-2.0-07.patch.  :

1. Latency test shows a slight increase of about 5 to 10 % on the Intel
platforms.
(Still need to do the comparison on the AMD platform). This translates to
less than 5 uS
so it's ok for our case.

2. On the Intel Core 2 Desktop, our application has a much more significant
max scheduling jitter
of about 125 uS (compared with < 60uS for Xenomia 2.4.5). This 'increased
jitter' does not
show up on the other two platforms. Still trying to trace this one.
Already played around with
different ACPI and SMI settings, but no joy (:


Keep well
Vicki

--00032555150afc6edc04683562d3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br>Thanx for the updated patch. Some feedback ...<br><br>I tested it=
 with Xenomai 2.4.7 under Ubuntu 8.04.2=A0 on three different platforms <br=
>(AMD Athlon Desktop, Intel Core 2 Desktop, Intel Core Duo Laptop)<br><br>
Typical system lockups when in the gnome desktop do NOT occur anymore ! Gre=
at :)<br><br>Initial observations when compared to Xenomai 2.4.5 with adeos=
-ipipe-2.6.24-x86-2.0-07.patch.=A0 :<br><br>1. Latency test shows a slight =
increase of about 5 to 10 % on the Intel platforms. <br>
(Still need to do the comparison on the AMD platform). This translates to l=
ess than 5 uS <br>so it&#39;s ok for our case.<br><br>2. On the Intel Core =
2 Desktop, our application has a much more significant max scheduling jitte=
r<br>
of about 125 uS (compared with &lt; 60uS for Xenomia 2.4.5). This &#39;incr=
eased jitter&#39; does not<br>show up on the other two platforms. Still try=
ing to trace this one. Already=A0played around with <br>different ACPI and =
SMI settings, but no joy (:<br>
<br><br>Keep well<br>Vicki<br><br>

--00032555150afc6edc04683562d3--


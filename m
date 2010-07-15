MIME-Version: 1.0
Date: Thu, 15 Jul 2010 11:24:13 +0200
Message-ID: <AANLkTinwyQgI26INSzLlvgyP2hlAmuziK7V3iNCVa8Nd@domain.hid>
From: Cyril Wallois <walloiscyril@domain.hid>
Content-Type: multipart/alternative; boundary=0015174be6a8651123048b69aa3a
Subject: Re: [Xenomai-help] [RTnet-users] Alignment problem
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

--0015174be6a8651123048b69aa3a
Content-Type: text/plain; charset=ISO-8859-1

Hi everybody,

I have try to solve my problem by using a newer kernel (2.6.30) without
success, I have always the same issue with rtnet when I try rtping :

#./rtping 127.0.0.1
Xenomai: suspending kernel thread bf009310 ('rtnet-rtpc') at 0xc002d3c8
after exception #0

I tried other kernel like 2.6.33 but I have a known problem with the
Ethernet controller (dm9000 NETDEV WATCHDOG timeout).

I would like to solve this problem, in /proc/xenomai/faults, the exception
#0 is describe as a data or instruction access error, What does it means ?

Best regards,

WALLOIS Cyril

--0015174be6a8651123048b69aa3a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi everybody,<br><br>I have try to solve my problem by using a newer kernel=
 (2.6.30) without success, I have always the same issue with rtnet when I t=
ry rtping :<br><br>#./rtping 127.0.0.1<br>Xenomai: suspending kernel thread=
 bf009310 (&#39;rtnet-rtpc&#39;) at 0xc002d3c8 after exception #0<br>
<br>I tried other kernel like 2.6.33 but I have a known problem with the Et=
hernet controller (dm9000 NETDEV WATCHDOG timeout).<br><br>I would like to =
solve this problem, in /proc/xenomai/faults, the exception #0 is describe a=
s a data or instruction access error, What does it means ?<br>
<br>Best regards,<br><br>WALLOIS Cyril<br>

--0015174be6a8651123048b69aa3a--


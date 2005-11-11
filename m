Message-ID: <437464B2.6030204@domain.hid>
Date: Fri, 11 Nov 2005 10:30:26 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E004305A@EINT11.einet.ad.eivd.ch>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E004305A@EINT11.einet.ad.eivd.ch>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] printk
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

Hi,

I'm porting an app from RTAI to Xenomai, and when it came to the
rt_printk function, I had to replace it with plain printk (the
xnarch_log* functions all use printk).

What I want to know if:

1- Is totally safe to call the standard kernel printk function from a
real time task?

2- Even if it's safe, can it affect the performance of a real time task?
(or can it block under *any* conceivable condition?)

Thanks.

Nacho.




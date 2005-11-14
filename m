Message-ID: <43786B29.7000601@domain.hid>
Date: Mon, 14 Nov 2005 11:47:05 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <FDBBB5CC70676540B3EF7CFE83FD94E004305A@EINT11.einet.ad.eivd.ch>
	<437464B2.6030204@domain.hid>
In-Reply-To: <437464B2.6030204@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Invalid characters in task's names
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

I just noticed "/" is not a valid character for a task's name. Probably
something to do with the clever use that xeno makes of the /proc
filesystem. Anyway:

1- Are there any other "forbidden" characters?

2- Does this limitation apply to the other named objects?

3- Shouldn't those characters be internally escaped somehow to overcome
this limitation?

4- If (2) is not possible, shouldn't this limitation be mentioned in the
API documentation.

Thanks.


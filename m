Message-ID: <43787FCB.2050909@domain.hid>
Date: Mon, 14 Nov 2005 13:15:07 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <OF1D0CCC98.82E4D674-ONC12570B6.003B9ABD-C12570B6.003D16B7@domain.hid>
	<43786C64.1050404@domain.hid>
In-Reply-To: <43786C64.1050404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] xn_pipe_create [minor]
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

The registry system is great, allows to forget about agreeing about an
arbitrary minor number for pipes. But as far as I ca see, you still have
to pass an unique "minor" number to rt_pipe_create.

What if you have several rt modules?... you must make sure you assign
different minor numbers to each pipe!.

Wouldn't be useful to have a way to let the rt_pipe_create decide which
minor to use? (a free one, of course)

Nacho.




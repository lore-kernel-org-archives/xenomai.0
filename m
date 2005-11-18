Message-ID: <437E036D.4010707@domain.hid>
Date: Fri, 18 Nov 2005 17:38:05 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] v2.1 status
References: <437CB8BA.8040902@domain.hid>	<437DD08E.1020202@domain.hid>
	<437DE7FD.7050206@domain.hid>
In-Reply-To: <437DE7FD.7050206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

I had a first contact with the new build system. I really really don't
like the fact it touches my kernel source tree. Besides adeos, I like to
keep the kernel source independent of xenomai, because that tree is
shared for other projects.

Also, why does it default to monolithic build of the xeno modules when
in 2.0 you always got them as modules?.



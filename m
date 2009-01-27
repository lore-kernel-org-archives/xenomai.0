From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <497F6524.2080601@domain.hid>
References: <497F6524.2080601@domain.hid>
Date: Wed, 28 Jan 2009 00:22:10 +0100
Message-Id: <20090127232210.67027832E416@domain.hid>
Subject: Re: [Xenomai-core] [Xenomai-help] [RFC] FPU support
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>

Dear Gilles Chanteperdrix,

In message <497F6524.2080601@domain.hid> you wrote:
> 
> So, the question is: are there people around who either:
> - need FPU support for kernel-space real-time threads;
> - do not want to pay the price of a trap when using the FPU in user-space.

My gut feeling (and this is all I can offer at this point) is that
there will probably be only very few (but still some) people inthe
first group, but a larger number of users in the second group.
Especially on smaller embedded processors taking a trap is a penalty
you usually want to avoid.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
In C we had to code our own bugs, in C++ we can inherit them.


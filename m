Message-ID: <44BE8ECF.2050608@domain.hid>
Date: Wed, 19 Jul 2006 21:58:07 +0200
From: Hannes Mayer <h.mayer@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.2
References: <1153227929.5029.25.camel@domain.hid>
In-Reply-To: <1153227929.5029.25.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Cc: xenomai@xenomai.org

Ciao Philippe et al.!

Philippe Gerum wrote:
[...]
> http://download.gna.org/xenomai/stable/xenomai-2.2.0.tar.bz2

Congratulations on the newest release! :-)

I've encountered a probably minor problem:
I compiled the 16550A driver as module (everything else into
the kernel), but when modprobing it said:
couldn't find the kernel version the module was compiled for

I then recompiled the module with an own makefile, then it
worked.

Jan, I also updated the serial port example (I got my devel
machine working again, so I tested on 2.2.0 today :-).
Re. "mode-change explanation in your original email":
I read thru them again and couldn't find what important
stuff I left out. Please enlighten. Thanks :-)

Best regards,
Hannes.



Message-ID: <4A61A0CD.6010607@domain.hid>
Date: Sat, 18 Jul 2009 12:15:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <899865CA54E4444DAF2E3639C04C5F4806005D@trillian.at.omicron.at>
In-Reply-To: <899865CA54E4444DAF2E3639C04C5F4806005D@trillian.at.omicron.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Strange results with ARM EABI, gcc 4.3.2
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Richard Cochran <richard.cochran@domain.hid>
Cc: xenomai@xenomai.org

Richard Cochran wrote:
> A certain xenomai project on ARM Linux of mine has been working fine
> using gcc 3.4.5. I wanted to use a more recent compiler and the EABI,
> so I used a default setting from crosstool-NG-1.4.1, which produces
> gcc version 4.3.2.
> 
> However, I get the following result running the trivial-periodic
> example program:
> 
> # ./trivial-periodic &
> # cat /proc/xenomai/sched 
> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>   0  0       -1      0          0          master    R          ROOT
>   0  850     99      1000000000 79513195085358725 master    D          trivial
> 
> Looks like I will be waiting a long, long time for the timeout ;^)
> Any ideas?

gcc 4.3 has a bug with Xenomai on arm. You should stay with gcc 4.2
(which also has a bug, but we know how to workaround it).

I think I will add a dynamic detection of this bug, print an error
message when it happens and exit.

-- 
					    Gilles.


Message-ID: <ba98230140e2190e763c418428e3198d.squirrel@domain.hid>
Date: Thu, 27 Oct 2011 11:05:38 +0200 (CEST)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] installing xenomai on pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org



Robert wrote:
> Ok, so now latency test looks good, but board still hangs up on xeno-test.
>

Please try, as I suggested in a previous mail, to get the kernel console
output on the serial port, and see if the hang is not due to a kernel
oops.

And I am also asking again: are you compiling user-space support for thumb?

-- 
                    Gilles.



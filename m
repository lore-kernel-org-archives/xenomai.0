Message-ID: <bc4264770702231136u74de12f3q9bbcfe980390c5f8@domain.hid>
Date: Fri, 23 Feb 2007 19:36:53 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] include-path conundrum types.h
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

Hi

In the first steps of introducing xenomai into my project I notice
that there seems to
be a strange misdirection in one of the header files.

#include <asm/xenomai/system.h>

in <nucleus/types.h> does not seem to make sense. I seem to have to
change this to

#include <asm-i386/system.h>

But before I start hacking perhaps someone wants to shed some light on
what is going on here?

Regards,

Roland


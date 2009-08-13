Message-ID: <4A83F99B.9070703@domain.hid>
Date: Thu, 13 Aug 2009 13:31:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE20060EFA4BEC@us194mx002.tycoelectronics.net>
	<4A81CA67.9060301@domain.hid> <4A81CE4F.9060301@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4DEE@us194mx002.tycoelectronics.net>
	<4A82DC78.9060408@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4EE1@domain.hid>
	<4A83108E.10309@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060EFA4F19@domain.hid>
	<4A8314D1.9060702@domain.hid>
	<CF7FB0793253794F9F45991443E5FE20060F03FA83@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE20060F03FA83@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_setschedparam: Function not implemented
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Charlton, John wrote:
> Gilles,
> 
> Here is another piece of the puzzle, my colleague Jay Snyder who is working on the Open Embedded bitbake build for Xenomai found this: 
> 
>    I have narrowed the problem down to
> /usr/xenomai/lib/libpthread_rt.so.1.0.0
> 
> I can install the full OE package, and then overwrite this file from the native-compiler build, and the tests run.

Ah. So, it is a build issue. Show us the flags with which Xenomai is
configured by this build tool? Note however that since latency is not
linked with libpthread_rt.so.1.0.0 I do not see how overwriting
libpthread_rt.so can make latency -t 1 or latency -t 2 run.

-- 
                                          Gilles



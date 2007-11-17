MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18239.3938.28607.266649@domain.hid>
Date: Sat, 17 Nov 2007 16:57:22 +0100
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB026DBC4E@is-hdq-exchange.marel.net>
References: <DD39B5C3F4963040ADC9768BE7E430CB026DBC4E@is-hdq-exchange.marel.net>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Houston,
	we have a problem ... In timed POSIX space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
 > Hi,
 >  
 > The attached program demonstrates that mq_timedsend() doesn't work. The
 > sent value changes on the way to the receiver. Always! mq_send() works
 > fine.
 > Additionally if no asolute timeout value is used, there will be no error
 > returned which is contrary to the POSIX standard (however glibc2.3 also
 > fails here).

You misread the POSIX spec. It says:
"The timeout shall expire when the absolute time specified by abs_timeout
passes, as measured by the clock on which timeouts are based (that is,
when the value of that clock equals or exceeds abs_timeout), or if the
absolute time specified by abs_timeout has already been passed at the
time of the call."

But it also says:
"Under no circumstance shall the operation fail with a timeout if there
is sufficient room in the queue to add the message immediately. The
validity of the abs_timeout parameter need not be checked when there is
sufficient room in the queue."


-- 


					    Gilles Chanteperdrix.


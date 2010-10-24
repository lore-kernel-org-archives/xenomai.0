From: Wolfgang Denk <wd@domain.hid>
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: <AANLkTinONvkO75DF7mrWJQC1zosSZv-_hstOyi-AxpAK@mail.gmail.com>
References: <AANLkTinONvkO75DF7mrWJQC1zosSZv-_hstOyi-AxpAK@mail.gmail.com>
Date: Sun, 24 Oct 2010 09:17:59 +0200
Message-Id: <20101024071759.40060134F26@domain.hid>
Subject: Re: [Xenomai-help] denx ELDK installation...xenomai error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ali Khan <ali.khan1430@domain.hid>
Cc: xenomai@xenomai.org

Dear Ali Khan,

In message <AANLkTinONvkO75DF7mrWJQC1zosSZv-_hstOyi-AxpAK@mail.gmail.com> you wrote:
> 
> I am using Ubuntu 10.10 and I tried installing denx ELDK (ppc-2007-01-19) on
> my laptop in /opt/eldk as a root user.

This is not a Xenomi question - you are off topic here. You should
have asked this on the ELDK mailing list instead, see
http://lists.denx.de/mailman/listinfo/eldk

> The installation seems to go fine however I am getting the following error
> messages towards the end:
...
> /opt/eldk/ppc_4xxFP/usr/local/xenomai/kbuild/scripts/prepare-kernel.sh: line
> 376: patch: command not found
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is this not a very precise error message?

The "patch" command cannot be found on your system, most probably
because you did not install it.

Try "apt-get install patch" to fix that.


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
EMACS belongs in <sys/errno.h>: Editor too big!


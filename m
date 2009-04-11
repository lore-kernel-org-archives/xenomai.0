Date: Fri, 10 Apr 2009 17:35:41 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
Message-ID: <Pine.LNX.4.64.0904101729031.4820@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org


On Fri, 10 Apr 2009, Steven Seeger wrote:
> It klat.ko installed?

Yes, assuming that by this you mean xeno_klat.ko. I don't see klat.ko
without the xeno_ prefix in /lib/modules, and I opted for all of the
Xenomai testing drivers to be built by the kernel installation, apart
from irqbench.

The pertinent section of the kernel .config file is:

  #
  # Testing drivers
  #
  CONFIG_XENO_KLATENCY_MODULE=m
  CONFIG_XENO_DRIVERS_TIMERBENCH=m
  CONFIG_XENO_DRIVERS_KLATENCY=m
  # CONFIG_XENO_DRIVERS_IRQBENCH is not set
  CONFIG_XENO_DRIVERS_SWITCHTEST=m

and lsmod shows the following Xenomai drivers as being loaded:

  $ lsmod | grep xeno
  xeno_klat               5168  0
  xeno_timerbench         7172  0
  xeno_switchtest         6924  0

Thanks for the help,

Martin



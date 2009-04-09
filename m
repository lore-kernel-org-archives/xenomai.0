Date: Wed, 8 Apr 2009 17:11:34 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
Message-ID: <Pine.LNX.4.64.0904081659110.22300@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Selecting the TSC
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


On Wed, 8 Apr 2009, Martin Shepherd wrote:
> The reason is that for any processor type other than the
> various Pentium CPUs, "make menuconfig" doesn't define CONFIG_X86_TSC
> in the .config file

Oops. I got this part wrong. I hadn't realized that there were many
more CPU options than the 6 options that "make menuconfig" initially
shows in the Processor family configuration page. Scrolling down and
selecting Athlon/Duron/K7 does indeed turn on the CONFIG_X86_TSC
compilation option. So I was incorrect to say that this can't be done.

Regardless, I would still be interested to hear whether there are any
moves to switch Xenomai over to consulting the run-time cpu_has_tsc
macro, now that the CONFIG_X86_TSC option no longer configures the use
of the TSC in the kernel.

Martin


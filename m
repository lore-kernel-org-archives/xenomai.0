Date: Fri, 2 Feb 2007 16:36:43 +0200 (EET)
From: "Rus V. Brushkoff" <rus@domain.hid>
Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
In-Reply-To: <1170426719.4981.66.camel@domain.hid>
Message-ID: <Pine.LNX.4.64.0702021635150.12191@domain.hid>
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170408789.4981.1.camel@domain.hid> <1170409755.4981.11.camel@domain.hid>
	<45C309BF.9090808@domain.hid>  <1170415388.4981.36.camel@domain.hid>
	<1170420270.4981.58.camel@domain.hid>
	<Pine.LNX.4.64.0702021456170.12191@domain.hid>
	<1170426719.4981.66.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2 Feb 2007, Philippe Gerum wrote:

:>  Tested on K8 x86_64 SMP and K8 x86 UP : SMP system leaks memory, UP 
:> doesn't.
:
:Thanks. I do have a leak on UP here though; vmstat or any other command
:do not eat this memory (at least neither ps or top report any continuous
:growth of their vm space while running the test), so I would wildly
:guess that's a kernel-based leakage occurring somewhere in the procfs
:support.

 May be the time to announce this to linux-kernel, last rc7 for 2.6.20 
is out ;)

:
:

		Rus


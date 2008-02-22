Message-ID: <47BED2C7.3050004@domain.hid>
Date: Fri, 22 Feb 2008 14:48:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4256e7340802220457m6a4f7737qd5a572ef7f6707e7@domain.hid>
In-Reply-To: <4256e7340802220457m6a4f7737qd5a572ef7f6707e7@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Advice on running Xenosim/MVM
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Moti M <tabulo@domain.hid>
Cc: xenomai@xenomai.org

Moti M wrote:
> Hello,
> 
> I need some general advice on Xenosim v2.4.1. I have successfully (as
> far as I can see) built and installed the MVM environment, however
> when I try running the Xenoscope application it always exits with
> error 99. From the source code it looks like this happens if SIGINT,
> SIGTERM or SIGHUP are received, but I am not sure why one of these
> would always occur when I run Xenoscope.
> 

Normally, this tool outputs a message to stderr before exiting on error.
If not, try running the Xenoscope over GDB, setting a breakpoint in
_exit(). Then ask for a backtrace once the breakpoint is hit.

You can add more traces this way, in case this happens when starting the
debug session:

$ export MVM_GDBTRACE=-
$ xenoscope

> Is there something I am missing when running Xenoscope, or perhaps
> some setting I should have enabled during the kernel config process?

No, this is purely user-space stuff.

> (I am using Xenomai 2.4.1/Linux kernel version 2.6.23.14 on x86.)
> 
> Thanks,
> M Tabz
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.


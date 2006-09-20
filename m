Subject: Re: [Xenomai-core] rare brokenness in latency output - FPU bug!
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4511784C.3060807@domain.hid>
References: <450E6745.6050903@domain.hid> <450F061A.6090507@domain.hid>
	<450F084A.1070303@domain.hid> <450F0ECA.2050100@domain.hid>
	<4510034F.70008@domain.hid> <1158681135.4972.63.camel@domain.hid>
	<4511784C.3060807@domain.hid>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 20:01:27 +0200
Message-Id: <1158775287.5043.40.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-09-20 at 12:20 -0500, Jeff Webb wrote:
> Philippe Gerum wrote:
> > On Tue, 2006-09-19 at 09:48 -0500, Jeff Webb wrote:
> >> Jeff Webb wrote:
> >>> I don't have a plain xenomai-2.2.2 kernel handy, but I do have a patched 
> >>> version.  I do not have any problems with switchtest for xenomai-2.2.2 
> >>> with the following patches:
> >>>
> >>>  https://mail.gna.org/public/xenomai-help/2006-09/msg00084.html
> >>>  https://mail.gna.org/public/xenomai-help/2006-09/msg00096.html
> >>>
> >>> These patches are to nucleus pipe.c and pipe.h / rtai fifo.c and fifo.h.
> >>>
> >>> I am running an Athlon64 X2 in with 32-bit Fedora Core 5.
> >> I have done a couple more tests using xenomai from subversion.  Here is a summary of all the results I have so far:
> >>
> >> xenomai-2.2.2 (patched as described above): switchtest runs
> >> svn/xenomai/trunk (r1586): switchtest runs
> >> svn/xenomai/trunk (r1589): switchtest runs
> >> xenomai-2.2.3 : switchtest fails
> >>
> >> This is on my Fedora Core 5 (32-bit x86), linux-2.6.17.13 SMP, ipipe-1.3 (except 1.4 for 2.2.3), gcc-4.1.1, Athlon64 X2.
> >>
> >> Hopefully this will help,
> > 
> > It does, thanks. This confirms Jan's findings that something went wrong
> > from #1595. The issue is spotted now, somewhere in the FPU save/restore
> > code in the x86 support layer.
> 
> I just rebuilt 2.2.3 with the latest FPU fix patch posted by Philippe:
> 
>   https://mail.gna.org/public/xenomai-help/2006-09/msg00157.html
> 
> This appears to fix the FPU switchtest bug on my Athlon64 X2 (2.6 kernel) machine.  Great job!
> 
> Thanks for the hard work,
> 

Gilles did the work actually. I've just relayed it.

> Jeff
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.




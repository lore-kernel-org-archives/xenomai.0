Message-ID: <450F0ECA.2050100@domain.hid>
Date: Mon, 18 Sep 2006 16:25:30 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rare brokenness in latency output - FPU bug!
References: <450E6745.6050903@domain.hid> <450F061A.6090507@domain.hid>
	<450F084A.1070303@domain.hid>
In-Reply-To: <450F084A.1070303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka wrote:
> Welcome to the club!
> 
> Everyone's busy behind the curtain to analyse what's going on here. So
> far we thought it's a post 2.2.2 regresssion (SVN rev 1595 for trunk,
> 1597 for 2.2.x), but the issue may be more tricky.
> 
> Do you get the switchtest failure also with plain 2.2.2?
> 
> What processor do you use? I was only able to trigger my problems on
> Pentium MMX and older or an Athlon 800 here. A Pentium III worked fine.
> 
> Jan
> 

I don't have a plain xenomai-2.2.2 kernel handy, but I do have a patched version.  I do not have any problems with switchtest for xenomai-2.2.2 with the following patches:

  https://mail.gna.org/public/xenomai-help/2006-09/msg00084.html
  https://mail.gna.org/public/xenomai-help/2006-09/msg00096.html

These patches are to nucleus pipe.c and pipe.h / rtai fifo.c and fifo.h.

I am running an Athlon64 X2 in with 32-bit Fedora Core 5.

-Jeff


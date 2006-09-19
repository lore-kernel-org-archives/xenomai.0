Message-ID: <4510034F.70008@domain.hid>
Date: Tue, 19 Sep 2006 09:48:47 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rare brokenness in latency output - FPU bug!
References: <450E6745.6050903@domain.hid>
	<450F061A.6090507@domain.hid>	<450F084A.1070303@domain.hid>
	<450F0ECA.2050100@domain.hid>
In-Reply-To: <450F0ECA.2050100@domain.hid>
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

Jeff Webb wrote:
> I don't have a plain xenomai-2.2.2 kernel handy, but I do have a patched 
> version.  I do not have any problems with switchtest for xenomai-2.2.2 
> with the following patches:
> 
>  https://mail.gna.org/public/xenomai-help/2006-09/msg00084.html
>  https://mail.gna.org/public/xenomai-help/2006-09/msg00096.html
> 
> These patches are to nucleus pipe.c and pipe.h / rtai fifo.c and fifo.h.
> 
> I am running an Athlon64 X2 in with 32-bit Fedora Core 5.

I have done a couple more tests using xenomai from subversion.  Here is a summary of all the results I have so far:

xenomai-2.2.2 (patched as described above): switchtest runs
svn/xenomai/trunk (r1586): switchtest runs
svn/xenomai/trunk (r1589): switchtest runs
xenomai-2.2.3 : switchtest fails

This is on my Fedora Core 5 (32-bit x86), linux-2.6.17.13 SMP, ipipe-1.3 (except 1.4 for 2.2.3), gcc-4.1.1, Athlon64 X2.

Hopefully this will help,

-Jeff



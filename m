Message-ID: <4452307D.5060108@domain.hid>
Date: Fri, 28 Apr 2006 11:10:53 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] xeno-test manpage patch
References: <200604251502.12312.rlenglet@domain.hid>
In-Reply-To: <200604251502.12312.rlenglet@domain.hid>
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
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

Romain Lenglet wrote:
> Added documentation for the new -U option, and did some cleanups.
>   

FYI,

a few *tiny* issues.

-d   eg: /dev/hda1 might be better than /dev/hda/,  and drop trailing slash.

-m, -M.    log-file not required.

-N   path can be /absolute too, not just ../relative

-p 'cmd'   no longer run between latencies, just before & after

pass-thru:

 -s -T 10 -q    the 10 is now 120.

more subtly - your intro doesnt express the defaulting behavior that 
this section does describe.
any pass-thru provided with turn off those defaults, so if you just use 
-h, the test will output lines
each second, and never finish, so you dont get histogram (IIRC - you may 
get it from ^C handler).
Im not at all sure its worth touching, and I should probably change the 
defaults to add histogram,
and drop quiet.

-h implies -s   (its just easier that way)

--  needed by testsuite/*/run scripts, not by xeno-test.  I dont recall 
every using it.

BUGS

-N   name is timestamped, giving uniqueness.  This is a caveat, not a bug

-p   oops.   Im open to suggestions whether this is worth fixing.

(workload mgmt)

   workload tasks arent always (ever?) restarted once they finish,
so a real /dev/hda1 workload may end before your test does, causing 
non-uniform &
unexpected load variations.

workloads arent always killed if test is interrupted.


thanks,
jimc


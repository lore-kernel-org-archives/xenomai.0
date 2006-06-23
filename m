Subject: Re: [Xenomai-core] Improved xeno-test: Ready for checkin
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200606222337.30022.niklaus.giger@domain.hid>
References: <200606222337.30022.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 11:30:31 +0200
Message-Id: <1151055031.4438.24.camel@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2006-06-22 at 23:37 +0200, Niklaus Giger wrote:
> Hi
> 
> Here is my patch for improved versions of xeno-info/load/config/test
> as well as a Ruby test script for the maintainers.
> 
> The modified scripts pass the test for most options to xeno-test. The only 
> exception is "-v" for verbose. As I have no clue how/what this option should 
> do I left it as is.

The getopt list lacked the "v" option letter. Fixed, thanks.

> 
> The modifications are:
> - busybox supported
> - The load jobs (dd) are killed correctly
> - two new lines for my buildbot "xeno-test started" and "xeno-test finished"
> - the options -m / -L are no more silent, but echo also on the standard out.
>   If the old behaviour is preferred, it would be simple to restore it. But
>   the actual behaviour is easier to debug and fits better into the buildbot
>   logs.

Logs look ok.

> As rc3 is still not out, I do not see any reason not to check in this patch.
> But I would like to see this happen soon, as I will not be able to fix errors 
> after next Wednesday.
> 

Applied, thanks.

-- 
Philippe.




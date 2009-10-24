From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20091024080304.22784.46688.stgit@domain.hid>
References: <20091024080304.22784.46688.stgit@domain.hid>
Content-Type: text/plain
Date: Sat, 24 Oct 2009 18:38:44 +0200
Message-Id: <1256402324.2862.495.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 0/2] fork-safe rt_print,
	rt_syslog extension
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, Oliver Schlenker <oliver.schlenker@domain.hid>

On Sat, 2009-10-24 at 10:03 +0200, Jan Kiszka wrote:
> Please pull Oliver's rt_print patches from
> 
>     git://xenomai.org/xenomai-jki.git for-upstream
> 
> 
> Oliver Schlenker (2):
>       Fork-safe rt_print
>       Syslog extension of rt_print
> 
>  include/rtdk.h      |    2 +
>  src/rtdk/rt_print.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 67 insertions(+), 7 deletions(-)
> 
> PS: Trying to manage patches by hand is doomed to fail. I can only
> recommend anyone investing the time to get familiar with basic git
> commands. It quickly pays off, even for managing only private changes.

Please, make sure to provide a prefix in your short log; this makes
sorting the short logs for changes by topic a bit easier. E.g.

rtdk: fork-safe rt_print
rtdk: syslog extension of rt_print

-- 
Philippe.




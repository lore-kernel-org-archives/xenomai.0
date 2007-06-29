Message-ID: <4684BD02.1070002@domain.hid>
Date: Fri, 29 Jun 2007 10:04:18 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB14C@rennsmail04.eu.thmulti.com>
	<4680DA9B.5020501@domain.hid> <46838C9C.7030303@domain.hid>
In-Reply-To: <46838C9C.7030303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Group-based RT caps
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> I couldn't resist, the approach looked too simple and appealing:
> http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/rt-caps-group.patch
>
> Actually, it's even more advanced than realtime-lsm in so far as it also
> checks for secondary group membership. You can use the nucleus module
> parameter "xenomai_gid" to control the Xenomai group, also during
> runtime using /sys.
>
> Works nicely for me. I'm able to run testsuite programs under my user
> account that now additionally belongs to the "xenomai" group. :)
>
> Jan
>   

I used the patch (and reversed my modification of MLOCK_LIMIT) and this 
works OK now, on a plain 2.3.1 version. Thanks!

One thing I would like to see is to have the xenomai_gid parameter as a 
kernel config parameter, next to the module parameter. The default can 
be -1, but I would like to have my configured xenomai-group as the 
default value, so I don't have to pass an extra parameter or modify 
/sys/module/xeno_nucleus/parameters/xenomai_gid.

Kind regards,
    Johan Borkhuis



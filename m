Message-ID: <cbe23c50703300045s5a389ce0s91ec515604a87404@domain.hid>
Date: Fri, 30 Mar 2007 09:45:27 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] Newbie problem : xenomai 2.3.1 and kernel 2.6.20.4
	installation problem
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C603221032@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221032@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

2007/3/29, RAKOTOSALAMA, Nirilanto <NIRILANTO.RAKOTOSALAMA@airbus.com>:
> Hello everybody !
>
> I installed xenomai 2.3.0 on a FC6 linux distribution with vanilla kernel 2.6.19.7 following the
> http://www.captain.at/xenomai-2.1-installation.php installation guide.
> It worked well until I install a new xenomai version (2.3.1) and linux kernel (2.6.20.4)
> with the same kernel configuration than the first install.

In your .config you have
CONFIG_HPET_TIMER=y

Can you provider boot log in order to see if your box effectively
have HPET discovered at boot time?

On my box with Xenomai 2.3.0 + linux 2.6.19 this setup make
xeno-test to hard lock,
see:
https://mail.gna.org/public/xenomai-help/2007-02/msg00085.html

I don't know if HPET_TIMER is an issue in Xenomai 2.3.1
anymore since my FAQ comment on this issues seems to
have been removed
see
(http://www.xenomai.org/index.php?title=FAQs&diff=1674&oldid=1642)

Nevertheless SVN history says the HPET issue is not confirmed...

>>>>>>>>>>
Filename: branches/v2.3.x/scripts/Kconfig.frag
Revision 2311 - (view) (download) - [select for diffs]
Modified Sun Mar 18 17:40:44 2007 CET (11 days, 14 hours ago) by rpm
File length: 917 byte(s)
Diff to previous 2237

Revert #2237, until we either fix or prove the issue with HPET

Filename: branches/v2.3.x/scripts/Kconfig.frag
Revision 2237 - (view) (download) - [select for diffs]
Modified Fri Feb 23 19:54:34 2007 CET (4 weeks, 6 days ago) by rpm
File length: 1104 byte(s)
Diff to previous 2005

Warn about CONFIG_HPET_TIMER being set
>>>>>>>>>>

Can any Xenomai developer confirm that
CONFIG_HPET_TIMER is or is not an issue with xenomai 2.3.1?

If you're still working on it
and need to reproduce the problem I may
retry my buggy HPET config with 2.3.1 in order to see
if it really was the only difference between my working and
non-working Xenomai config.


-- 
Erk


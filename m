Message-ID: <cbe23c50703300212v3c7521bj98e3fb12fceafeb9@domain.hid>
Date: Fri, 30 Mar 2007 11:12:23 +0200
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] Newbie problem : xenomai 2.3.1 and kernel 2.6.20.4
	installation problem
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C603221034@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221034@domain.hid>
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

2007/3/30, RAKOTOSALAMA, Nirilanto <NIRILANTO.RAKOTOSALAMA@airbus.com>:
> Is that files you want me to provide ?

yes even if your "messages" file is empty, dmesg is fine.

> I don't see any hpet references in messages and dmesg files!

You are right.
Your machine doesn't seems to have HPET even if you .config
shows you configured HPET timer.
If you had one (and set up CONFIG_HPET_xxx) you would see something like

ACPI: HPET id: 0xffffffff base: 0xfed00000

and later on

Using HPET for base-timer

> Thanks, I will test your suggestions.

As far as I understand disabling HPET in .config
 shouldn't change anything since your host does not have any HPET.

-- 
Erk


Message-ID: <cbe23c50703231012j54c5dbf8se804c72f9878e7e@domain.hid>
Date: Fri, 23 Mar 2007 18:12:50 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
In-Reply-To: <032320071533.27467.4603F3590000E5E600006B4B2216557996070E0301020A98@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <032320071533.27467.4603F3590000E5E600006B4B2216557996070E0301020A98@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@domain.hid" <xenomai@domain.hid>
Cc: xenomai@xenomai.org

2007/3/23, xenomai@domain.hid <xenomai@domain.hid>:
> I still however can't get my network connection to work
>properly.  It is a Broadcom NetExtreme GigE card.  It successfully
get's a DHCP
>address as if it is working fine.  No messages in any of the log
files.  I however
>can not get out at all.  When trying to get in from the outside with
ssh it supplies
>me the host key but then hangs for about 1 minute then prompts me for a
>password and works fine from there.    From inside, even pings dont work.


Did you tried mii-tool or ethtool on the I/F
your I/F may wrongly negotiate the link (wrong speed and/or half duplex...)

I did configure a dual-core box with Broadcom GigE I/F and experience
trouble weird behavior and total lockup if
 MSI was enabled
 HPET was enabled.

My trouble comes out only to 1 of the 3 ethernet I/F but...

I disabled MSI and HPET and all is working fine until now (with xenomai 2.3.0).

-- 
Erk


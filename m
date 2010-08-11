Message-ID: <4C62C103.4020207@domain.hid>
Date: Wed, 11 Aug 2010 17:25:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1278943817.7023.18.camel@domain.hid> <4C3EF6D6.6040907@domain.hid>	
	<1279210298.1995.38.camel@domain.hid>	
	<1279623645.2187.35.camel@domain.hid> <4C469259.3000708@domain.hid>
	<1281538723.2246.120.camel@domain.hid>
In-Reply-To: <1281538723.2246.120.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Marvell sheeva support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tim Cussins <timcussins@domain.hid>
Cc: xenomai@xenomai.org

Tim Cussins wrote:
> I've had a good play with mkrootfs - nice. I had to make a couple of
> changes to meet my needs (and system, ubuntu 10.04). Is there a git repo
> for mkrootfs that I can base my patches on? They're very small btw. More
> on that off-list if you want.

Yes, there is a git repo for mkrootfs, it is not public yet, which does
not really make sense, since I talked about it publicly. I am going to
make it public. I just do not want to pollute the Xenomai mailing list
with the mkrootfs maintenance, so, we will have to set-up a mailing list
elsewhere.

> 
>>>> You can also use the patch below as a starting point for your port:
>>>> http://download.gna.org/adeos/patches/tmp/adeos-ipipe-2.6.29-mv88f6290.patch
>>> I've tried applying this to vanilla 2.6.29 and 2.6.29.6 - it doesn't
>>> apply cleanly (well, fails :P). Am I approaching this the wrong way?
>>> Also tried chucking the patch into the xenomai tree and getting
>>> prepare_kernel.sh to try: still no joy.
>> It probably does not apply to vanilla because vanilla has no support for
>> the Sheevaplug board. Or am I missing something?
> 
> Well, I don't think so. Some hunks are expecting lines of context that
> simply don't exist in 2.6.29 == fail.

Well yes, that is exactly my point: the patch is made to be applied to
another kernel tree, a marvell specific kernel tree.

> 
> I took the mv88f6290 patch and bullied it into applying to vanilla
> 2.6.29. Built ok, but was at home and no way to test, so I just got on
> with migrating it to 2.6.33. That seems to be done - check the 2.6.33
> boot output:
>   
>    ...
>   I-pipe: Domain Xenomai registered.
>   Xenomai: hal/arm started.
>   Xenomai: scheduling class idle registered.
>   Xenomai: scheduling class rt registered.
>   Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
>   Xenomai: starting native API services.
>   Xenomai: starting POSIX services.
>   Xenomai: starting RTDM services.
>    ...
> 
> Full boot output is attached FYI.
> 
> However, I've got a problem with busybox/getty and /dev/ttyS0 so I can't
> log in via console OR telnet. Once that's solved, I'll be able to run
> the xenomai tests. (In case you've seen it before - /var/log/messages is
> slowly filling with:

There are two ptys style, the BSD one corresponding to the
CONFIG_LEGACY_PTYS in kernel configuration, and the new style,
corresponding to the CONFIG_UNIX98_PTYS. busybox uses one style by
default (I believe it is the new style), but will not work if your
kernel is only configured for the other style. Anyway, you have to check
that the busybox and kernel configurations match. This is probably the
reason why telnetd does not work.

As for the reason why ttyS0 is not working, well, it is strange. Maybe
something missing in the kernel configuration? Could you send me your
.config?

-- 
					    Gilles.


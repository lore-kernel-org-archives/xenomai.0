Message-ID: <4C7BED23.5050400@domain.hid>
Date: Mon, 30 Aug 2010 19:40:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <loom.20100830T183243-347@domain.hid>
In-Reply-To: <loom.20100830T183243-347@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to resolve this lockup situation?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jmf <xeno.nonono@domain.hid>
Cc: xenomai@xenomai.org

jmf wrote:
> Dear all,
> 
> this is the situation: from a Xeno task, a shared library function is called
> to control some device. After a system update (both Xeno and the device
> drivers) that function returns with a timeout. As it turns out, as a part of
> the device drivers, there is also a deamon running which the shared lib
> tries to talk to. Obviously, while the RT task waits for the function to return,
> that deamon does not get any CPU time to answer so the function returns
> a timeout.

I do not understand how this is obvious. If the RT task waits, the rest
of the system may run, including the daemon.

If the daemon is not an RT application, and you have an RT task wait for
it, then your system has a serious flaw: it is not real-time. As could
have told you the T_WARNSW bit if you are using the native skin, or the
PTHREAD_WARNSW if you are using the posix skin (for more details, see
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Using_the_PTHREAD_WARNSW_bit.
)


> 
> Now, the questions are: why did it work before the update, before we
> noticed the existence of a deamon? Is there any way to make Xenomai give
> the Linux scheduler some time so the deamon can do its work? Or can that
> deamon process somehow be moved to the Xeno domain? I think I stumbled
> upon a respective function meant for testing once but can't find it anymore...
> 
> Thanks a lot for any clue!

Without seeing any code, we have no clue either.

-- 
					    Gilles.


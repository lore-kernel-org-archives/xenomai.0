Subject: Re: Fwd: Debugging system freeze, SIGXCPU
References: <CAJA_znn4P=_tmbcKCipcmYrhPUhFw4JrMWv2VAMVR0DYSx9iMA@mail.gmail.com>
 <CAJA_znnmCr7QSjsnSQbLRYTM+CyBex05sBV0gbOdVQgYuBK0Tw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0509ec7d-20b3-bc38-7a04-7516f24249a1@xenomai.org>
Date: Mon, 25 Feb 2019 17:08:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAJA_znnmCr7QSjsnSQbLRYTM+CyBex05sBV0gbOdVQgYuBK0Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ari Mozes <arimozes@neocisinc.com>, xenomai@xenomai.org

On 2/25/19 2:32 PM, Ari Mozes via Xenomai wrote:
> Resending this question with testcase.
> Can someone give the testcase a try to see if it reproduces the problem I
> am seeing?  Is more information needed?
> It takes a couple of minutes before I see the issue occur.

The random lockup is due to std::chrono::high_resolution_clock::now()
invoking the vDSO form of clock_gettime().

SIGXCPU aka Xenomai's SIGDEBUG may be sent by the core in various
situations, but since the code does not set the T_WARNSW for any task,
the only explanation is receiving a Xenomai watchdog notification. See
the help information about CONFIG_XENO_OPT_WATCHDOG in your kernel
configuration.

After a few secs spinning in the vDSO code which may not be called from
real-time context, the Xenomai core pulls the break and sends SIGXCPU to
the offending process, unless the system locks up before the watchdog
could even trigger.

Solution: use clock_gettime(CLOCK_HOST_REALTIME) instead of
std::chrono::high_resolution_clock::now() for getting timestamps.

A related discussion is available at this URL:
https://www.xenomai.org/pipermail/xenomai/2018-December/040133.html

-- 
Philippe.


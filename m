Message-ID: <53BAC9BC.7020208@xenomai.org>
Date: Mon, 07 Jul 2014 18:24:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53BAC761.1000602@free.fr>
In-Reply-To: <53BAC761.1000602@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] core I5 latency+USB
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/07/2014 06:14 PM, Stéphane ANCELOT wrote:
> Hi,
> 
> I have got high latencies up to 25us using my usb keyboard,
> which setting in kernel 3.10 should I set ?

Follow the troubleshooting guide:

http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_the_latency_test_shows_high_latencies

That said, 25us may not be such a high latency. You may also
want to try xenomai 2.6 git, which has a workaround for some
core i* automatic switch to C1E state when idle.

-- 
                                                                Gilles.


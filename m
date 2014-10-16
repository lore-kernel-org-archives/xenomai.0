Message-ID: <543F845C.3000304@xenomai.org>
Date: Thu, 16 Oct 2014 10:39:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <543E4B9F.60602@cgglobal.com> <543E5380.3080700@cgglobal.com>
 <543F70C5.1090005@xenomai.org> <543F7ED2.2080201@xenomai.org>
 <543F82E2.3040403@cgglobal.com>
In-Reply-To: <543F82E2.3040403@cgglobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] First call to rt_timer_tsc() causes an unexpected
 switch to secondary mode.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alberto.ozalla@cgglobal.com
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/16/2014 10:33 AM, ZIV-Alberto Ozalla Cantabrana wrote:
> We moved one step ahead:
> 
> *   Xenomai updated from 2.6.3.git to 2.6.4 *   Linux updated from
> 3.14.9 to 3.14.17
> 
> The problem has gone away. And I hope for good.
> 
> Anyway, during this evening I will recover former situation (former
> versions of Xenomai and Linux) and try the test you pointed out
> (uisng tsc_init and my_rdtsc).

Xenomai 2.6.3 does not support Linux 3.14. You need at least that patch:
http://git.xenomai.org/xenomai-2.6.git/commit/?id=41cb1f73814d1094e0ea75ccbbd23ff01280787e

To get things (context switches) to work properly on ARM.

-- 
                                                                Gilles.


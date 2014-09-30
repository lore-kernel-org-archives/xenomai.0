Message-ID: <542A945E.9000904@xenomai.org>
Date: Tue, 30 Sep 2014 13:30:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACreCVKF=VQuWhaxkAPTOAaDui0aze+Vc4MOq+vby+2eBRx1iA@mail.gmail.com>
In-Reply-To: <CACreCVKF=VQuWhaxkAPTOAaDui0aze+Vc4MOq+vby+2eBRx1iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Switchtest failures on ODROIDU3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: GP Orcullo <kinsamanka@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 09/30/2014 07:31 AM, GP Orcullo wrote:
> Hi,
> 
> Running the switchtest for extended periods (>10 mins) causes the
> machine to lockup.
> 
> I'm running a modified xeno-regression-test which contains only the
> following tests:
> 
> check_alive /usr/lib/xenomai/testsuite/switchtest
> check_alive /usr/lib/xenomai/testsuite/switchtest -s 1000
> check_alive /usr/lib/xenomai/testsuite/latency ${1+"$@"}
> 
> The script is invoked with the following arguments:
> 
> nohup sudo ./xeno-regression-test -l
> "/usr/lib/xenomai/testsuite/dohell -m /media/work 36000" -t 2 >
> /dev/null & top -d0.5
> 
> The kernel dumps the OOPS information intermittently so it's difficult
> to diagnose the issue.
> 
> Attached is the kernel config and the logfile.

Ok, this is an exynos. Sorry, but I have never seen the patch for
exynos, so I do not know what is inside. You should direct your
questions to whoever provided you with this support.

-- 
                                                                Gilles.


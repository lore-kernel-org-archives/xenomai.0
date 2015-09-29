Date: Tue, 29 Sep 2015 15:33:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929133317.GB13638@hermes.click-hack.org>
References: <560A8662.8050204@sigmatek.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <560A8662.8050204@sigmatek.at>
Subject: Re: [Xenomai] ipipe_read_tsc, ipipe_tsc2ns
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johann Obermayr <johann.obermayr@sigmatek.at>
Cc: xenomai@xenomai.org

On Tue, Sep 29, 2015 at 02:38:58PM +0200, Johann Obermayr wrote:
> Hello,
> 
> in a loadable kernel module i use ipipe_read_tsc and ipipe_tsc2ns.
> But at compiling i get follow warning.
> 
> WARNING: "__ipipe_kuser_tsc_freq" [km_testsample.ko] undefined!
> 
> we have ARM, Linux 3.0 + xenomai 2.6.2.1

These are I-pipe internal functions. You should be using Xenomai
API:
- If developing a driver, you should be using rtdm_clock_read(),
- if using the deprecated kernel-space native API, rt_timer_tsc()
/ rt_timer_tsc2ns
- if using the deprecated kernel-space posix API,
clock_gettime(CLOCK_MONOTONIC).

-- 
					    Gilles.
https://click-hack.org


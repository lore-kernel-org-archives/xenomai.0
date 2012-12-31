Message-ID: <50E1D1A8.4020803@xenomai.org>
Date: Mon, 31 Dec 2012 18:55:52 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50e1cc2fb40c67.12589971@wp.pl>	<50E1CE62.9010806@xenomai.org>
	<CAMYDobURJ8z9JMVD=kwzHfQKQrLSeEP=bXP4cAouOGPM8C9uBg@mail.gmail.com>
In-Reply-To: <CAMYDobURJ8z9JMVD=kwzHfQKQrLSeEP=bXP4cAouOGPM8C9uBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] SIGXCPU with rt_mutex_release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: peter@thesourceworks.com
Cc: Xenomai <xenomai@xenomai.org>

On 12/31/2012 06:52 PM, Peter Soetens wrote:

> Hi all,
> 
> Thanks for the analysis. I'd propose to move this to bugs.orocos.org
> <http://bugs.orocos.org> where we can try to reproduce and track this
> bug in orocos.
> 
> We've been testing in our buildfarm against xenomai 2.5, so this might
> be something we did not notice until now...


It is related to the automatic migration of threads running with
SCHED_OTHER policy introduced in Xenomai 2.6.


-- 
                                                                Gilles.


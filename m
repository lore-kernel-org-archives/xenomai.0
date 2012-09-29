From: Paul <paul_c@tuxcnc.org>
Date: Sat, 29 Sep 2012 10:40:40 +0100
References: <CAKKWdtctThpDZ=_QTGrLRXVkoc16hVg-CbFO1U7MsdWRtywFFg@mail.gmail.com>
	<CAKKWdte3Y9CFJXwjaVRuAE0ee=syRzcpTq6XGH+nX+hYppUj6g@mail.gmail.com>
	<5066AA95.9030705@xenomai.org>
In-Reply-To: <5066AA95.9030705@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201209291040.40941.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] some errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Saturday 29 September 2012, Gilles Chanteperdrix wrote:
> On 09/29/2012 09:59 AM, ali hagigat wrote:
> > CONFIG_XENO_DRIVERS_TIMERBENCH=y
> > but i do not see any xeno_timerbench module!
>
> You will only see a module if CONFIG_XENO_DRIVERS_TIMERBENCH is m

/lib/modules/3.2.27-ipipe/kernel/drivers/xenomai/testing$ ls -1
xeno_irqbench.ko
xeno_klat.ko
xeno_rtdmtest.ko
xeno_switchtest.ko
xeno_timerbench.ko

Everything in place and working on _my_ system. The documentation is NOT 
in error.





Date: Tue, 20 Oct 2015 18:01:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151020160113.GE8927@hermes.click-hack.org>
References: <20150909113151.0fed6fd7@md1em3qc> <55F02DB0.1090801@xenomai.org>
 <20150915104854.56a7b13f@md1em3qc>
 <20150917143955.01a71eb6@md1em3qc> <561ED42E.5080608@xenomai.org>
 <562658C0.8090006@xenomai.org> <56265F30.1030308@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56265F30.1030308@xenomai.org>
Subject: Re: [Xenomai] 4.x merge
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>, "KISZKA, JAN" <jan.kiszka@siemens.com>

On Tue, Oct 20, 2015 at 05:35:12PM +0200, Philippe Gerum wrote:
> On 10/20/2015 05:07 PM, Jorge Ramirez Ortiz wrote:
> > On 10/14/2015 06:16 PM, Jorge Ramirez Ortiz wrote:
> >>
> >>>
> >>> I did push my current state to github. Check out 
> >>> https://github.com/siemens/linux-ipipe
> >>> branches ipipe-3.19 and -4.0
> >>
> >>
> >>
> >> I just noticed -while reusing some of your changes for aarch64 - that his needs
> >> fixing (redeclaration of 'flags')
> >> https://github.com/siemens/linux-ipipe/blob/ipipe-4.0/drivers/irqchip/irq-gic.c#L270
> >>
> > 
> > Hi Henning,
> > 
> > have you tried running the switchtest with the boot parameter
> > xenomai.supported_cpus=0x1?
> > 
> > 
> > 
> 
> That won't work, switchtest attempts to spread the rt test load over all
> online CPUs, which your kernel setting contradicts.

That will not work without passing any argument to switchtest, but
can work if you specify to switchtest a list of tasks to run on the
first cpu.

Such as:
# switchtest rtk0 rtk0 rtk_fp0 rtk_fp0 rtk_fp_ufpp0 rtkfp_ufpp0 rtup0 \
rtup0 rtup_ufpp0 rtup_ufpp0 rtus0 rtus0 rtus_ufps0 rtus_ufps0 \
rtuo0 rtuo0 rtuo_ufpp0 rtuo_ufpp0 rtuo_ufps0 rtuo_ufps0 \
rtuo_ufpp_ufps0 rtuo_ufpp_ufps0

-- 
					    Gilles.
https://click-hack.org


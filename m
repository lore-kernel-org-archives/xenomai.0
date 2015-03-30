MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <55196DB0.8020308@xenomai.org>
References: <CAKk99t15m2dbUzGNxi4TsAVk4suZGc14qxv2cBh+iG1nWcM-kQ@mail.gmail.com>
 <55196828.9020207@xenomai.org>
 <20150330152002.GL32766@hermes.click-hack.org>
 <55196B64.9010901@xenomai.org>
 <20150330152957.GN32766@hermes.click-hack.org>
 <55196DB0.8020308@xenomai.org>
Date: Mon, 30 Mar 2015 16:40:04 +0100
Message-ID: <CAKk99t2LDG0+CC3360XmaQ-F6zb=OuKLMRCtEgfKYFYouoOYqw@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] There is XDDP Sockets support in kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I think it is.
xeno_rtipc was successfully loaded before inserting my module.



On 30 March 2015 at 16:37, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/30/2015 05:29 PM, Gilles Chanteperdrix wrote:
> > On Mon, Mar 30, 2015 at 05:27:32PM +0200, Philippe Gerum wrote:
> >> On 03/30/2015 05:20 PM, Gilles Chanteperdrix wrote:
> >>> On Mon, Mar 30, 2015 at 05:13:44PM +0200, Philippe Gerum wrote:
> >>>> On 03/30/2015 04:55 PM, Helder Daniel wrote:
> >>>>> Hi,
> >>>>>
> >>>>> When trying to compile a kernel module that sets up a XDDP socket
> (code
> >>>>> snippet below) with Xenomai 3.x-rc3 on Cobalt setup,
> >>>>> rtdm_bind() returns ENOSYS.
> >>>>> This means that XDDP sockets can not be used in kernel?
> >>>>>
> >>>>
> >>>> No, in this case it likely means that you are calling it from a
> >>>> real-time context (i.e. a real-time kthread started with
> >>>> rtdm_task_create()). The binding op can only run from a non-rt
> context,
> >>>> e.g. module init code, regular kthread context, _nrt handler.
> >>>
> >>> Or that XDDP is not enabled in the kernel configuration, maybe?
> >>>
> >>
> >> It's an intra-kernel call, so it must be there.
> >
> > Not sure I follow. If RTDM is enabled in the kernel configuration,
> > and XDDP is not, then rtdm_bind will return -ENOSYS.
> >
>
> It's a binding operation, so if the code did receive a valid XDDP
> socket, the XDDP support must be there.
>
> --
> Philippe.
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel

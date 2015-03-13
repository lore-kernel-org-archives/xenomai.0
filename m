Date: Fri, 13 Mar 2015 17:44:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150313164459.GF1497@hermes.click-hack.org>
References: <CANWkrRPz2B5FgOAVLy5-i+DOFOHf5QDZQoHP28n_oAdaSmYTBw@mail.gmail.com>
 <5502AEAF.3010003@xenomai.org>
 <CANWkrRNmZqnN7p2nmNCc_8C8iFUW79E03L1Z62nnx4zWmSJ8Sw@mail.gmail.com>
 <CANWkrRM3hD_LG-7EQFDxF5U-YS3YJYe8jNyL3cOZqSEL+tqQNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWkrRM3hD_LG-7EQFDxF5U-YS3YJYe8jNyL3cOZqSEL+tqQNg@mail.gmail.com>
Subject: Re: [Xenomai] rtdm/driver.h location - Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Mar 13, 2015 at 06:39:03PM +0200, Michael Smith wrote:
> On Fri, Mar 13, 2015 at 1:42 PM, Michael Smith <2michael.smith@gmail.com> wrote:
> > On Fri, Mar 13, 2015 at 11:32 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> >> On 03/13/2015 09:17 AM, Michael Smith wrote:
> >>> Hi.
> >>> I am busy porting device drivers over to Xenomai 3.0.
> >>> At the moment I'm having trouble figuring out the location of
> >>> rtdm/driver.h.
> >>> I would assume it should be installed under /usr/include/xenomai, because
> >>> in my previous Xenomai 2.x build the rtdm/rtdm_driver.h was located there.
> >>> I can see the file in the Xenomai source code but its not installed under
> >>> /usr/include/xenomai after Xenomai 3.0 the build and install.
> >>> I'm using cobalt with an x86_64 architecture.
> >>>
> >>> Am I missing something? Is there something that I should have setup in the
> >>> configuration file with the install? I went back and had a look in the
> >>> Linux kernel
> >>> build setup under the Xenomai heading, but I could not see any obvious
> >>> options that I missed.
> >>>
> >>
> >> In short, Xenomai 3 introduces a split between kernel and userland
> >> headers, with only a few of them shared in order to expose the ABI. So
> >> you need to build against a kernel prepared with the Xenomai sources,
> >> adding the proper extra CFLAGS to your kernel Makefile for building the
> >> module with the proper -I directives to find them.
> >>
> >> Everything under /usr/include/xenomai now belongs to userland
> >> exclusively, barring the ABI bits (uapi/).
> >>
> >> See http://www.xenomai.org/pipermail/xenomai/2015-March/033558.html
> >>
> >> --
> >> Philippe.
> >
> > I understand.
> > Thanks Phillipe.
> > Will implement it like that.
> > If I can suggest, maybe to have a note of this somewhere in the
> > documentation, or
> > a RTDM example will clarify similar questions in the future.
> >
> > Regards
> > Michael
> 
> I am trying to do a out of tree compile for my RTDM driver.
> As I include the line $(shell xeno-config --kcflags)) in my make file,
> it expands to the line -Iarch/$(SRCARCH)/xenomai/include -Iinclude/xenomai.
> 
> My problem is my compiler is not finding the $(SRCARCH) variable in
> the make process.
> I had a look and its not defined in my environmental variables either.
> I see the only place it is defined is in linux/Makefile on the top
> level of the Linux tree.
> 
> But does this mean I can only compile a Xenomai driver as part of the
> full Linux tree?
> And do I need to re-make the whole kernel tree when I want to compile a custom
> Xenomai driver?
> Where would I need to place the RTDM source code if I want to compile
> it, linux/drivers perhaps?
> Or can I still do a out of tree compile for a Xenomai driver?

Compilation of kernel modules outside of the kernel sources is
documented in Documentation/kbuild/modules.txt in kernel sources.
Since RTDM modules are ordinary kernel modules, these instructions
apply. 

-- 
					    Gilles.


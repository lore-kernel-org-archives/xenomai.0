Message-ID: <5502AEAF.3010003@xenomai.org>
Date: Fri, 13 Mar 2015 10:32:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CANWkrRPz2B5FgOAVLy5-i+DOFOHf5QDZQoHP28n_oAdaSmYTBw@mail.gmail.com>
In-Reply-To: <CANWkrRPz2B5FgOAVLy5-i+DOFOHf5QDZQoHP28n_oAdaSmYTBw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm/driver.h location - Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>, xenomai@xenomai.org

On 03/13/2015 09:17 AM, Michael Smith wrote:
> Hi.
> I am busy porting device drivers over to Xenomai 3.0.
> At the moment I'm having trouble figuring out the location of
> rtdm/driver.h.
> I would assume it should be installed under /usr/include/xenomai, because
> in my previous Xenomai 2.x build the rtdm/rtdm_driver.h was located there.
> I can see the file in the Xenomai source code but its not installed under
> /usr/include/xenomai after Xenomai 3.0 the build and install.
> I'm using cobalt with an x86_64 architecture.
> 
> Am I missing something? Is there something that I should have setup in the
> configuration file with the install? I went back and had a look in the
> Linux kernel
> build setup under the Xenomai heading, but I could not see any obvious
> options that I missed.
> 

In short, Xenomai 3 introduces a split between kernel and userland
headers, with only a few of them shared in order to expose the ABI. So
you need to build against a kernel prepared with the Xenomai sources,
adding the proper extra CFLAGS to your kernel Makefile for building the
module with the proper -I directives to find them.

Everything under /usr/include/xenomai now belongs to userland
exclusively, barring the ABI bits (uapi/).

See http://www.xenomai.org/pipermail/xenomai/2015-March/033558.html

-- 
Philippe.


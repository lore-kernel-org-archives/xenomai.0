Message-ID: <54F74016.7000400@xenomai.org>
Date: Wed, 04 Mar 2015 18:25:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAEMXjGyiUw52yB3SD1vZT5pwnmAR6Sh_qCgxbc_-RTu1kKRDdA@mail.gmail.com>
In-Reply-To: <CAEMXjGyiUw52yB3SD1vZT5pwnmAR6Sh_qCgxbc_-RTu1kKRDdA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM device driver interrupts over primary mode task?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>, xenomai <xenomai@xenomai.org>

On 03/04/2015 05:59 PM, Steve B wrote:
> Hello,
> 
> Is it possible that my hardware interrupts tied to RTDM device drivers are
> able to pre-empt my high priority task running in primary mode, or do the
> interrupts get serviced after the task yields the CPU?
> 

If taken by the CPU, IRQs hooked by a RTDM driver will preempt any
real-time task code immediately (in kernel or userland). IRQs hooked by
regular kernel drivers will be postponed until all rt activity has
completed on the receiving CPU.

-- 
Philippe.


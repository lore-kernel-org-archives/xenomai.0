Message-ID: <500CF868.70208@xenomai.org>
Date: Mon, 23 Jul 2012 09:08:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5009DF76.5010306@nta-inc.net> <500A6516.10703@xenomai.org>
	<bc8da858918a991cb436fa7f40576b87.squirrel@www.nta-inc.net>
In-Reply-To: <bc8da858918a991cb436fa7f40576b87.squirrel@www.nta-inc.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue with Xenomai 2.6.1 / Linux 2.6.38.8 on logout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: webb-ja@nta-inc.net
Cc: xenomai@xenomai.org

On 07/23/2012 03:42 AM, webb-ja@nta-inc.net wrote:

>> On 07/21/2012 12:45 AM, Jeff Webb wrote:
>>> I have built and installed Xenomai 2.6.1 with a Linux 2.6.38.8 kernel on
>>> an Intel X5650 machine running Ubuntu 10.04.  It seems to boot and run
>>> fine.  If I try to log out of my GUI session, the monitors go into power
>>> save mode and never come back.  I can SSH into the machine to reboot it.
>>>  I get the following in /var/log/syslog:
>>>
>>> irq 16: nobody cared (try booting with the "irqpoll" option)
>>> Pid: 2694, comm: Xorg Tainted: P            2.6.38.8-xenomai-2.6.1 #1
>>> Call Trace:
>>>   [<ffffffff8109da26>] ? __report_bad_irq+0x26/0xa0
>>>   [<ffffffff8109dc2c>] ? note_interrupt+0x18c/0x1d0
>>>   [<ffffffff8109e89d>] ? handle_fasteoi_irq+0xed/0x120
>>>   [<ffffffff81005bdd>] ? handle_irq+0x1d/0x30
>>>   [<ffffffff81005091>] ? do_IRQ+0x61/0xf0
>>>   [<ffffffff810a4790>] ? __ipipe_sync_stage+0x1f0/0x1f6
>>>   [<ffffffff81005030>] ? do_IRQ+0x0/0xf0
>>>   [<ffffffff810a4796>] ? __xirq_end+0x0/0xa
>>>   [<ffffffff81005030>] ? do_IRQ+0x0/0xf0
>>>   [<ffffffff810a4c0e>] ? __ipipe_walk_pipeline+0x10e/0x120
>>>   [<ffffffff8101c587>] ? __ipipe_handle_irq+0x137/0x300
>>>   [<ffffffff8109e0b0>] ? __ipipe_ack_fasteoi_irq+0x0/0x20
>>>   [<ffffffff81555ad3>] ? common_interrupt+0x13/0x30
>>> handlers:
>>> [<ffffffff813e2990>] (usb_hcd_irq+0x0/0xb0)
>>> Disabling IRQ #16
>>>
>>> I have tried changing some kernel config option to no avail.  I have
>>> attached the .config that goes with the information above.  Any help in
>>> debugging would be appreciated.
>>
>> fasteoi irqs have been reworked in the I-pipe core patch (for linux
>> 3.2). It would be nice if you could check whether 3.2 solves the issue
>> you have.
> 
> I did try using linux 3.2.21 (?) with the I-pipe core patch, but the
> system locks up shortly after the login prompt appears.  I didn't have an
> easy way to post the stack trace, so I haven't reported that issue yet.  I
> was going to look through the mailing list archives to see how you
> recommend collecting useful information to report in this situation, but I
> haven't had a chance to do that yet.  What's the next step in debugging
> the problem?


If there is a stack trace, it is the best lead. In order to collect it,
you need another computer, and either use the serial console or
netconsole. In the past, we have already received photos of a stack trace.

-- 
                                                                Gilles.


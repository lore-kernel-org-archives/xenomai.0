Subject: Re: [Xenomai-help] BUG: unable to handle kernel paging request
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1169811995.462.13.camel@domain.hid>
References: <1169811995.462.13.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 26 Jan 2007 17:07:47 +0100
Message-Id: <1169827668.3346.61.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Victor Shulyak <V.I.Shulyak@domain.hid>
Cc: Ace Help <xenomai@xenomai.org>

On Fri, 2007-01-26 at 17:46 +0600, Victor Shulyak wrote:
> Hello,
> 
> Today I upgraded my system to xenomai 2.3.0 + kernel 2.6.19.2.
> I encountered the following syslog message:
> 
> BUG: unable to handle kernel paging request at virtual address 0d40004a
> while no xenomai application running.
> 
> The system didn't crash, just such kernel message.
> 
> 
> p4, nvidia geforce 4, FC6, gnome + compiz manager, gcc 4.1.1 shipped
> with FC6, NVIDIA-Linux-x86-1.0-9631 nvidia driver.
> 

> BUG: unable to handle kernel paging request at virtual address >
0d40004a
> printing eip:
> c7b84d51
> *pde = 00000000
> Oops: 0002 [#1]

I guess that you already know what kind of answer you would obtain on
the LKML when reporting faults with Nvidia modules loaded, right?
However, since there seem to be a clean backtrace, maybe we could give a
try anyway. Could you objdump your kernel image, then locate the faulty
routine containing eip=0xc7b84d51? TIA,

> Thanks, Victor
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.




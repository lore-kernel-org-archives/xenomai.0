Date: Thu, 12 Jul 2018 16:09:46 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180712160946.551f3019@md1pvb1c.ad001.siemens.net>
In-Reply-To: <CAFUnMknWBmuLjGbQfv+uqy49xo-+SNUWAtAgjwULUgY6nybgmA@mail.gmail.com>
References: <CAFUnMknWBmuLjGbQfv+uqy49xo-+SNUWAtAgjwULUgY6nybgmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] BUG: unable to handle kernel paging request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Am Thu, 12 Jul 2018 19:22:39 +0530
schrieb Ashok kumar <ashokkumar.bb@gmail.com>:

> Hi,
> 
> I am patching  linux- 3.14.44 with -xenomai-2.6.4,  I am using
> ipipe-core-3.14.44-x86-12.patch

Ok, have you tried 4.9.90 with xenomai 3.0.7? What you are using is far
from still being supported.

The only possible reason you are using such an outdated kernel is
because you rely on other patches as well. Do you see the same bug when
not applying these other patches?
 
> and in menu config
> 
> Required Options:
> * Real-time sub-system
>   --> Xenomai (Enable)
>   --> Nucleus (Enable)  
> * Power management and ACPI options
>   --> Run-time PM core functionality (Disable)
>   --> ACPI (Advanced Configuration and Power Interface) Support
>       --> Processor (Disable)
>   --> CPU Frequency scaling
>       --> CPU Frequency scaling (Disable)
>   --> CPU idle
>       --> CPU idle PM support (Disable)  
> 
> after installing the xenomai user library, while  checking latency I
> am getting the following error
> 
> BUG: unable to handle kernel paging  request
> 
> I have attached the screen shot of this bug

Please attach a serial console and provide this as text.

Henning
 
> anybody can help me to solve this issue
> 
> Thank you
> R.Ashokkumar
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: Screenshot from 2018-07-12 19:14:08.png
> Type: image/png
> Size: 129556 bytes
> Desc: not available
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20180712/df4ce641/attachment.png>
> _______________________________________________ Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai



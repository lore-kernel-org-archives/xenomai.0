From: Paul <paul_c@tuxcnc.org>
Date: Mon, 24 Feb 2014 00:22:11 +0000
References: <CAEbDrgkifqMcqqEqh5hKA90YzFzcyDxLHFC79F8CWvZi5heyWQ@mail.gmail.com>
 <CAK4EZFTRhDxJkRdY7epTqQ=f0rpoK570uJckq4aOYnt7z6fzxA@mail.gmail.com>
 <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
In-Reply-To: <CAEbDrgkAqAGWrap1156fiQnLiuBJ_P6NUdxQQQRBiLkDEKRwGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201402240022.11419.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] RaspberryPi kernel 3.8 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Sunday 23 February 2014, Gregory Dymarek wrote:
> I will give it a try with stack unwinding disabled and report back.
>
> Why I picked up this warning was because I mostly get kernel panics
> when unplugging usb devices:
> http://pastebin.com/uAhDGuzm
>
> I thought this is to do with the warning when booting the kernel.

Can you please try booting the kernel with dwc_otg.fiq_fix_enable=1 and 
then compare it to booting with dwc_otg.fiq_fix_enable=0

This boot option, along with all others, is set in cmdline.txt


It has been a while since I looked at the RPi kernel, but will help 
where I can.


Regards, Paul.


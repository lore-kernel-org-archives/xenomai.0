From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C73EC62.80703@domain.hid>
References: <4C73EC62.80703@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Aug 2010 18:59:06 +0200
Message-ID: <1282669146.1961.153.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Adeos-main] [RFT] ipipe patch for 2.6.35.3-x86
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

On Tue, 2010-08-24 at 17:59 +0200, Jan Kiszka wrote:
> Hi,
> 
> just uploaded a forward port of the 2.6.34 ipipe patch for x86 to latest
> stable 2.6.35.3. It boots and runs fine here in 64-bit mode with Xenomai
> head, but I only ran light tests so far. Anyone interested in upgrading
> the host kernel (I think I read some request recently) is welcome to
> give it a try and report results back (specifically on 32 bit as that is
> a bit out of focus for me ATM). You can download the full git tree from
> 
> 	git://git.kiszka.org/ipipe-2.6.git queues/2.6.35-x86
> 	(alternatively also via http://)
> 

Btw, could you pick Wolfgang's host rt clock patch in your queue as
well? I only have a few minor issues with it, which are no showstopper.
The only thing to care of before merging this to mainline, is that no
other arch does support this feature yet, so it is important to make it
fully optional in -noarch, and Xenomai-wise also.

We likely need some __IPIPE_FEATURE_* symbol to be defined in
arch/x86/include/ipipe_base.h for this purpose, so that depending code
could test for presence.

I'll pull the whole thing from your tree when x86_32 is known to rock as
well.

> Looking forward to feedback,
> Jan
> 

-- 
Philippe.




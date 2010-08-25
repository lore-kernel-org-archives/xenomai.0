Date: Tue, 24 Aug 2010 22:36:39 -0400
From: Edward Hoffman <quantalgo@domain.hid>
In-reply-to: <4C73EC62.80703@domain.hid>
Message-id: <1282703799.2170.4.camel@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <4C73EC62.80703@domain.hid>
Subject: Re: [Xenomai-help] [RFT] ipipe patch for 2.6.35.3-x86
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


I do not have a git repository setup.  Where can I download a version of
the patch that to put in the xenomai-2.5.4 patches directory?

I will then rebuild the 2.6.35.3 32-bit kernel and provide you with
feedback.

RSVP.

Ed

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
> Looking forward to feedback,
> Jan
> 




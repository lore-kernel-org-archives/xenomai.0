Message-ID: <bc4264770702271434x6efb5955sd75768a39f14c187@domain.hid>
Date: Tue, 27 Feb 2007 22:34:11 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] CAN question
In-Reply-To: <45E46D5C.8040001@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770702270848t6a65ec84nb72f9df20a52ba8f@domain.hid>
	<45E46D5C.8040001@domain.hid>
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
Cc: xenomai@xenomai.org

Hi .

It sounds like I will be setting to listen_only in most practical
cases with a fully operational bus connected. Correct?

Thanks.

Roland



On 2/27/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> roland Tollenaar wrote:
> > Hi,
> >
> > In choosing listen_only or Loop_back. What am I actually selecting?
> > The documentation only tells me that the parameter sets loop_back or
> > listen_only mode. Not what the difference is between those modes.
> > Again one of those general network programming features I presume.
>
> Both modes affect the controller directly if it supports it. Listen-only
> means that this CAN node will not acknowledge incoming frames even if
> they are correct, it will just sit there and sniff passively.
>
> Loopback means that the hardware emulates a fully working bus (i.e.
> correctly terminated) with only one node that simply receives what it sends.
>
> [Granted, documentation might be improvable here for CAN beginners.
> Still, you need basic some CAN understanding to deal with real-life
> issues anyway.]
>
> >
> > When working with the virtual device. Does it matter which mode is chosen?
>
> Nope, none of them is emulated so far.
>
> Jan
>
>
>


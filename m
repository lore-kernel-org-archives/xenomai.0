Message-ID: <4638A493.50601@domain.hid>
Date: Wed, 02 May 2007 16:47:47 +0200
MIME-Version: 1.0
References: <46388DCC.5070303@domain.hid> <46389325.7080200@domain.hid>
In-Reply-To: <46389325.7080200@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] HELP!!
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-help@domain.hid

Hi Jan,

> Maybe you missed the separated lists? rtnet-user-at-lists.sourceforge.net

I did. Sorry. I think you even mentioned it before. Sorry again.

> 
> But note in advance that RTnet for I/O coupling requires RTnet I/O
> coupler that you cannot buy as there are no commercial ones. You would
> have to embed it on your own. Maybe you then rather want to use the
> Ethercat MasterLibrary with RTnet to attach Ethercat I/O nodes.

This looks like it may be a break. I had just found ethercat before this
mail came in. By the look of things (very early) the hardware (Beckhoff)
will give the IO and according to the vendor (who I have limited faith
in by now) should make the time.

According to the same vendor (whom I have limited faith in) I can use
the standard ethernet hardware in PC's for ethercat. Unlike Powerlink
(B&R whom I am at war with and also have limited faith in :)) which
requires a special powerlink card.

But my next problem will be to get xenomai to work with ethercat. You
say I can try using the Ethercat Master library with RTnet. But why
would I need RTnet? How will the layering look in this case? IOW what
functionality will the ethernet master library provide and what will the
RTnet provide?

Has anyone done this before?

Thanks.

Roland.

> 
> Jan
> 



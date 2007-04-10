Message-ID: <461B5F47.9090001@domain.hid>
Date: Tue, 10 Apr 2007 11:56:23 +0200
From: Theo Veenker <Theo.Veenker@domain.hid>
MIME-Version: 1.0
References: <46180AB8.3000905@domain.hid> <200704072306.46154.paul_c@domain.hid>
	<4618A2BF.1030104@domain.hid> <200704081056.06867.paul_c@domain.hid>
In-Reply-To: <200704081056.06867.paul_c@domain.hid>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai Live CD
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: xenomai@xenomai.org

Paul wrote:
> Hi Theo
> 
> On Sunday 08 April 2007 09:07, Theo Veenker wrote:
> 
>>So you are saying I went through all this ff-ing trouble for nothing?
> 
> 
> Not at all... And my apologies if my comments came across as being negative.
> 
> 
>>You have all the knowledge and experience but did't bother putting it
>>to use for a Xenomai live CD? If it is not too much work maybe you could
>>put something together. I'm sure many people, including me, would be
>>interested.
> 
> 
> The bulk of the work (for Morphix builds) is in the patching & packaging of 
> the kernel - Once that is done, it boils down to deciding what applications 
> to put on a CD.. As to the question of "why I didn't do it" - To be honest, 
> didn't think about it or realise there was a need for one.
> 
> 
>>>[Side note: I already do nightly Sarge based Morphix modules,
>>>so slipping in a Xenomai version once in a while is possible].
>>
>>Would be nice. I'm very interested in having a (small) live cd which I can
>>customize and give to my clients.
> 
> 
> I've posted an RFC to the Morphix list suggesting the next kernel uses the 
> Xenomai patches, it won't be a major problem if the answer is no - I can 
> always add the unionfs & squashfs patches to the kernel debs currently found 
> on http://zathras.tuxcnc.org/xenomai
>  You have shown that there is interest in a LiveCD, so perhaps we could work 
> together on one - I have the build system set up and running, you know what 
> packages you need on a CD..

I don't know what you have in mind but I think there a two types of use.

1) A CD that can be used to quicly check the real-time capabilities of a PC.
    Preferably with multiple images to select in boot menu: with/without SMI
    work-around, UP/SMP, etc. if possible.

2) A CD with a live system (with gnome or kde) on it. Of course it should
    be possible to recreate the CD and add desired (real-time) apps to it.
    In my case I like to be able to give our non-technical students/researchers
    a CD which allows them to play with the same (real-time) linux apps as
    they see in the lab.

Regards,
Theo




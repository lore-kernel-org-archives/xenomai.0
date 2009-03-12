Message-ID: <49B8D5AB.7040005@domain.hid>
Date: Thu, 12 Mar 2009 10:28:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5558ce5d0903112316n61d4b1b6n86763d3917418fc5@domain.hid>
In-Reply-To: <5558ce5d0903112316n61d4b1b6n86763d3917418fc5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Microblaze or other soft core support
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
To: Brendon Costa <brendon.j.costa@domain.hid>
Cc: xenomai@xenomai.org

Brendon Costa wrote:
> Hi all,
> 
> Does Xenomai have any support for soft core processors such as
> Microblaze that are complete or in development?

Not to my knowledge.

  I would like to use a
> RTOS in a project that has an FPGA on board. I didn't see anything of
> this kind in the FAQ which lists supported platforms.
> 
> I was told that RTAI was the predecessor to Xenomai

The Xenomai history is a bit more complex:
http://www.xenomai.org/index.php/Xenomai:History

  and that the devs
> here would be very familiar with the RTAI predecessor and so it would
> be a good idea to ask a question about it here. Is anyone is aware of
> support for the Microblaze soft-core that was being developed for RTAI
> and where it got to?
>
> For example the link to the post below indicates that someone was
> close to completing a port of RTAI for the Microblaze, but I cant seem
> to find much more information about it:
> http://fossplanet.com/linux.uclinux.microblaze/message-7511911-uclinux/
> 

I guess the original effort started there, but this is quite old now:
http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/archive/2003/06/msg00004.html
http://www.itee.uq.edu.au/~jwilliams/mblaze-uclinux/

I have helped maintaining RTAI until October 2005, and saw no Microblaze port 
submitted for inclusion so far. This said, this does not mean that such port 
does not exist elsewhere, it does happen that ports to non-proprietary hardware 
remain undisclosed and get never submitted upstream for whatever silly reason. 
For instance, I know for sure that there are at least three different 
Xenomai/MIPS port bit roting in various basements all around the world with 
people stuck to outdated Xenomai releases, and still no MIPS support in Xenomai 
mainline.

Anyway, back to the initial question, maybe you should ask Dr. John Williams 
regarding RTAI/Microblaze. Xenomai/Microblaze would be achievable, no doubt 
about it (e.g. we do support uClinux/Blackfin), but there has been no sign of 
such port yet.

> Thanks,
> Brendon.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.


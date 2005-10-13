Date: Thu, 13 Oct 2005 10:37:53 +0200 (CEST)
From: Herman Bruyninckx <Herman.Bruyninckx@domain.hid>
Subject: Re: [Xenomai-core] Future of fusion
In-Reply-To: <434E19AD.4030500@domain.hid>
Message-ID: <Pine.LNX.4.64.0510131033300.5110@domain.hid>
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
	<434E19AD.4030500@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Reply-To: Herman Bruyninckx <herman.bruyninckx@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 13 Oct 2005, Philippe Gerum wrote:

> Marco Cavallini wrote:
>> I'd like to know (if is possible) the future plans and task schedule of 
>> fusion into xenomai project.
>
> There are things already going on "under the surface" right now, and others 
> that would depend on everyone's input in order to start them or not. The 
> roadmap will clearly depend on the combination of both aspects. I will give 
> some details shortly about the current or next-to-be-started efforts, but the 
> feedback part is important too, so here is the call for discussion once 
> posted to this list:
>
[...]
> I propose that we start discussing along the following lines, going into 
> deeper detail as needed,

[...]
> - Drivers: Now that we have a deeply integrated port of RTDM, what's next? 
> Field busses and other industrial gizmos anyone?

That's an interesting avenue for all our machine control oriented realtime
applications. But this avenue is full of incomplete or non-free
specifications and interfaces...

[...]
> - New skins: Any new colors for the "chameleon"?
"Perfect POSIX" is, to me, more important than new skins. "Perfect" means,
among other things, that the interference problem with the Posix thread
library (libraries) under Linux is solved.

Herman

--
   K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
     <http://people.mech.kuleuven.be/~bruyninc> Tel: +32 16 322480

Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm



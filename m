Message-ID: <4B978653.9020608@domain.hid>
Date: Wed, 10 Mar 2010 12:45:23 +0100
From: Daniele Nicolodi <daniele@domain.hid>
MIME-Version: 1.0
References: <4B968538.7030204@domain.hid> <4B968BAC.5090205@domain.hid>	
	<4B977F1F.8030304@domain.hid>
	<1268220794.27899.50.camel@domain.hid>
In-Reply-To: <1268220794.27899.50.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] COMEDI vs Analogy
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum wrote:

>> I would like to have the possibility to use (the far from perfect but
>> working) Comedi over RTDM while Analogy is worked out. Would it be
>> possible to recover the early work done to port Comedi over RTDM and put
>> it to some use? Given enough informations I can try to do it myself.
> 
> Beats me. Why do you assume that Comedi/RTDM provides more support
> compared to Analogy, since it is stated that Analogy started off from
> the Comedi/RTDM code base, months ago?

Sorry for my misunderstanding. I simply thought that, since Comedi works
with RTAI and Xenomai offers similar interfaces, a Comedi port to
Xenomai was quite straight forward. It must not be so.

> If you do want to help, you may want investing your time in developing
> and testing a better code base like Analogy with other people, instead
> of re-opening a dead development effort all alone.

Unfortunately I do not have so much time to invest into this activity.
I'll simply check if the PREEMP_RT patch gives me low enough latencies,
otherwise I'll switch to use Comedi on top of RTAI (sadly, because I
prefer Xenomai and its posix api).

Thanks. Cheers,
-- 
Daniele



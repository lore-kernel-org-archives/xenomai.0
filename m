Message-ID: <48E23B98.3000403@domain.hid>
Date: Tue, 30 Sep 2008 10:45:44 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <48C1053E.4010507@domain.hid> <48E20246.7060406@domain.hid>
	<48E22F37.2000903@domain.hid>
In-Reply-To: <48E22F37.2000903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Oops with ifconfig on Sequioa AMCC 440EPX board
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Steven A. Falco wrote:
> Philippe Gerum wrote:
>> Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> I get the following Oops with a Xenomai patch kernel when configuring
>>> the EEPRO100 on the PCI slot:
> ...
>>> Any idea where the problem could be?
>>>
>> As you pointed out, there was an issue with cascaded UICs. The following patch
>> should fix it (will be merged in the upcoming 2.2-05):
> 
> Thanks!  The patch does indeed fix it.  One comment, though.  I had
> turned on spinlock debugging as well as adding your patch.  That
> combination produces the bugs below.  Once I turn off spinlock
> debugging (with the patch still included), then things work properly.
> 
> So, I don't know if this bug is totally unrelated to Ipipe.  I'll
> investigate and post again with the results.
> 
> 	Steve
> 
> 

Turns out the spinlock bug is totally unrelated to Ipipe, as per the following:

http://kerneltrap.org/mailarchive/linux-netdev/2008/8/13/2926664/thread

So, I believe your patch completely fixes the issue I initially reported.

	Thanks,
	Steve





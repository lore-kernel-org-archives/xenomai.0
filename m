Message-ID: <49E23FB1.5030505@domain.hid>
Date: Sun, 12 Apr 2009 21:23:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
	<Pine.LNX.4.64.0904111233180.32647@domain.hid>
	<49E0F887.40805@domain.hid>
	<Pine.LNX.4.64.0904111820330.6444@domain.hid>
	<49E1B05A.4040705@domain.hid>
	<Pine.LNX.4.64.0904121206040.23562@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904121206040.23562@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> On Sun, 12 Apr 2009, Gilles Chanteperdrix wrote:
>> ...
>> Could you tell us the versions of Linux and Xenomai you are using and
>> post your .config ?
> 
> I am using Xenomai 2.4.7, with Linux kernel 2.6.28.7, under Ubuntu 8.10.
> 
> The following are the contents of the linux-2.6.28.7/.config file:

Ok. You seem to have avoided the usual pitfalls, however you really have
a lot of options enabled. The symptoms of your problem really look like
a bug which I had and turned out to be a NO_HZ problem. So, maybe you
could try and disable CONFIG_NO_HZ ? You can also try to enable
Xenomai's NMI watchdog, which will fire if a timer overrun occur.

-- 
					    Gilles.


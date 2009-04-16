Date: Thu, 16 Apr 2009 15:18:45 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <91569DDB-D66D-41FA-B8C4-7B40FC526EBC@comcast.net>
Message-ID: <Pine.LNX.4.64.0904161456240.26955@domain.hid>
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
	<49E23FB1.5030505@domain.hid>
	<Pine.LNX.4.64.0904151951500.9694@domain.hid>
	<4F0B1E98-862D-4031-B22E-D7DAEA554EEB@comcast.net>
	<Pine.LNX.4.64.0904161059220.24221@domain.hid>
	<91569DDB-D66D-41FA-B8C4-7B40FC526EBC@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>


On Thu, 16 Apr 2009, Steven Seeger wrote:
> Sorry I wasn't clear. I want to test the timing of sleep while the
> system has no load. The issue we had was a timing problem, so unless
> interrupts were firing the system timer was off by like a factor of
> 1000.

I tried a number of sleep's with no other load, and they all lasted
the requested duration, even in between hangs.

> Weird that dd dropped so much in top.

I have since noticed that the dd process usually gets very little CPU
time, even when the system is apparently working okay, and nothing
else is running. While dd is running, even though no other processes
are shown as using anything significant, the total CPU usage is 100%,
dominated by system usage. If I stop dd, then the total CPU usage goes
back down to close to zero.

> Aren't you the one with the failing memtest sometimes?

The reason that I don't believe that this is a memory problem, is that
the symptoms don't change when I swap between two different memory
sticks. Although both of these memory sticks each have two bytes that
memtest occasionally flags, their locations of these bytes are very
different from one stick to the other. So I would expect the symptoms
to change when I swap sticks.

> Perhaps you should wait for that new computer. :)

The new computers should arrive in a couple of days, but I'm expected
to work on this in the meantime.

What I'm going to try next, is to compile the 2.6.28.7 kernel without
xenomai patches, and see if that also misbehaves.

Martin


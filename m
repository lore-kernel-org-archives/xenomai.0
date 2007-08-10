From: =?iso-8859-1?Q?Torsten_Kr=F6ger?= <t.kroeger@domain.hid>
Date: Fri, 10 Aug 2007 16:16:47 +0200
Message-ID: <000c01c7db59$181f8680$c124a986@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: 
Subject: Re: [Xenomai-help] POSIX Skin: Changing scheduling parameters of
	threads in other processes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi everyone,

to summarize my discussion form yesterday:

1. I would like to implement 'real' synchronous message passing using
the posix skin. 'Real' synchronous message passing shall mean that a
receiver _always_ inherits the priority of the sender. Right now, I
think this is not possible. Please let me know, if anyone knows a
possibility.
 
2. 'Real' synchronous message passing could be realized with the native
skin, because here a sender RT_TASK is able to change the priority of a
blocked receiver RT_TASK before sending a message to it. Is this
correct? If yes, I might consider changing the skin.

3. Is there a possibility of using the native skin and the posix skin at
the same time?

4. I guess, it more a philosophical question: wouldn't another concept
of send/receive/reply-messaging lead to a general avoidance of priority
inversion? This is surely not an easy point regarding its
implementation, but when looking at long-term aims of the Xenomai
project, this might be a point, which worth to discuss about -
especially when heading for distributed systems, where
send/receive/reply-messaging is one of the key methodologies for
real-time systems.


Any reply posting is highly appreciated again :-)
 

Best regards,
Torsten



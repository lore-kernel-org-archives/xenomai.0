Message-ID: <45EC0243.1060301@domain.hid>
Date: Mon, 05 Mar 2007 12:42:59 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] CAN errors and real-time behaviour (IRQ raise
	forever and may lock system)
References: <bc4264770703030609w188a675cj618872986ff1071c@domain.hid>
	<45EBD9A3.9000303@domain.hid> <45EBF37F.6090604@domain.hid>
	<E1HOBKy-0000tp-Kt@domain.hid>
In-Reply-To: <E1HOBKy-0000tp-Kt@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
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
To: Sebastian Smolorz <ssm@domain.hid>, Xenomai-help@domain.hid

Hi,

my comments:

> Note that the current implementation of RT-Socket-CAN shows this behaviour on 
> purpose. See also [1] ("may flood!"). Whether this is the right handling or 
> not may be discussed here. I admit that the current implementation forces an
> application developer to take more responsibility but that is not a bug of 
> the underlying driver/stack per se.
Agreed.


> Look, you don't connect anything to the 
> CAN bus, start a *real-time* application which sends a message to a 
> non-existent CAN node. This is an error situation an it is more than ever for 
> a real-time task. So the proper reaction for a RT-application would be to 
> handle those errors and e.g. shut down the CAN interface which in this case 
> will force the CAN hardware to stop its endless attempts to send the message.

Just an example:

Say for arguments sake that my application is running two CAN buses. One 
gets addressed from one task and the other from another task. The tasks 
belong to the same physical process(machine) but are otherwise 
unrelated. Say the one is controlling the the quality of the mayonnaise 
the other of the ketchup. If the can-bus of the ketchup gets unplugged I 
don't want a batch of bad mayo as well. :) At the moment this is what 
seems to be happening.

IMHO it would be nice if the warning did get into the message buffer 
(assuming that they cannot -easily- be expelled elsewhere) but that the 
overflowing does not result in triggering non-application warning or 
error handeling mechanisms.


?

Kind regards,

Roland.



> 
> [1]http://www.xenomai.org/documentation/trunk/html/api/group__rtcan.html#g0b068b1221129441b89967ee2ddb9f44
> 
> --
> Sebastian
> 


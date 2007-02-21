Message-ID: <45DC4C85.8090807@domain.hid>
Date: Wed, 21 Feb 2007 14:43:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] real-time ethernet
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
To: Xenomai-help@domain.hid

Hi,

Again a bit of advice required. I have the choice of interacting with a 
remoteIO station via ethernet or CAN as well. I need CAN anyway for the 
sensor but I suspect that communicating with the remote IO station via 
ethernet might be substantially easier programming than doing this with 
CANOpen.

Can anyone confirm this? Does anyone with experience in both prefer one 
or the other?

And what can be said about this and xenomai? Would I use the standard 
sys/socket library or is there a real-time xenomai implementation of the 
same functionality?

Kind regards again,

Roland.


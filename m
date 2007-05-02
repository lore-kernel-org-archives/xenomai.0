Message-ID: <46388DCC.5070303@domain.hid>
Date: Wed, 02 May 2007 15:10:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: [Xenomai-help] HELP!!
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

Sorry about the subject but I badly need some advice.

I have tried 2 different makes of remote IO over CAN to achieve my 1ms
control loop. The makes are WAGO and Schleicher. These are industrial
modules that link to buscouplers (in my case CAN) and make the IO
available to andy device that can talk CAN. In this case my xenomai'd PC
platform.

However both makes (and all others I have contacted) have bus couplers
which are too slow to achieve this. 5ms is about the best they can do.
The engineering departments (who were not aware of this restriction)
agree that it is not a fundamental CAN problem but a matter of their
hardware not being able to respond fast enough.

I have given up hope of finding suppliers who can supply industrial (the
latter is important) equipment that will give me what I am looking for
based on CAN. So I am willing to settle on another bus protocol (I will
still be using CAN for other sensors which are responding fast enough on
CAN) for the remote IO.

Can anyone tell me what companies can supply remote IO that is fast enough.

Can anyone comment on the use of RTNET (real time ethernet I believe)
with xenomai. I ahve not seen any evidence of it being alove on this
mailing list.


Thanks,

Roland



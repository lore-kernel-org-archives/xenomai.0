Message-ID: <46C1851B.8040800@domain.hid>
Date: Tue, 14 Aug 2007 12:34:03 +0200
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid>
	<46C07AF2.60402@domain.hid>	<46C07D73.7070302@domain.hid>
	<46C080C8.10906@domain.hid>	<46C0835E.8010105@domain.hid>
	<46C0B036.3030306@domain.hid>	<46C0B1DF.6090509@domain.hid>
	<46C0B9F7.9060103@domain.hid> <46C0D686.6000007@domain.hid>
	<46C14FE2.8000507@domain.hid>
In-Reply-To: <46C14FE2.8000507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] rtcan bufferoverflow but no evidence
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Hi,

> Roland, could you please check the return code of [rt_dev_]close. 
> Nevertheless, I'm still puzzled why the socket shows up in 
> /proc/rtcan/sockets because rtcan_raw_close() is called before returning 
> -EAGAIN and the error mask shown there is weired as well.
> Roland, do you perform the open and close in a serialized way (same 
> task) and in nrt context?

I have now got the close loop with the printf in it. You are probably 
right that I was closing in the rt context because syslog shows an error 
from rtdm stating that one cannot close from rea time. I understand from 
a thread elsewhere that printf brings the program to secondary mode 
hence helps with the closing?

Its working now infallibly, no more open sockets remain so I can work 
like this. Also applied the suggestion to turn off the loopback with 
setsockopt and that functions well too (no more buffer overflows)

I only still have the problem with EML which does not seem happy in 
combination with rtcan. Even if I increase the rtskbf_cache_size value 
(now on 2048). It still occurs incidentally and even after the program 
has been running for a while. Anyhow that seems to have nothing to do 
with this topic....drifting a bit.


Thanks.

Roland


> 
> Wolfgang.
> 
> 
> 


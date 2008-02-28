Message-ID: <47C6B43B.6080601@domain.hid>
Date: Thu, 28 Feb 2008 14:16:43 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <001501c87a09$08a9f6f0$2401a8c0@domain.hid>
In-Reply-To: <001501c87a09$08a9f6f0$2401a8c0@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] FW: xeno_can: socket buffer overflow for fd=0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Urs.Eichholzer" <urs.eichholzer@domain.hid>
Cc: xenomai@xenomai.org

Hi Urs,

Urs.Eichholzer wrote:
> Dear Xenomai Help
> 
>  
> 
> The write to CAN is fast and have no problem... this can  be performed
> fast and even in microsecond  resolution
> 
> The read to CAN is working... but not fast enough as we expect it should
> be reading the network... The Xenomai CAN  can  read the network
> transfers in seconds and  about 40 milliseconds but once the read is
> performed on a much faster rate... the Xenomai CAN is having errors
> already... The message is:
> xeno_can: socket buffer overflow for fd=0
> 
> Something like this would be printed on screen and the system scrolls
> with this message again and again.
> 
> Here are some of the remedies I tried but still this problem occurs:
> 
> 1.) Increase the buffer size for receive in the menuconfig from 1024 to
> 4096, same problem.
> 
> 2.) Link the CAN drivers statically to the OS, same problem.
> 
> 3.) Link the CAN drivers with dynamic loading of driver, same problem.
> 
> 4.) Create my own test program, same problem
> 
> 5.) Create my own xenomai task based on how a task should be made, same
> problem...
> 
> 
> I have investigated this and it is coming from the rtdm file of 
> Xenomai... when it detects  a low buffer resource, it will  trigger this
> error. But allocating more buffer space to 4096 will not solve this
> problem. On my investigation, the problem is buried deep in the Xenomai
> itself for the CAN driver and RTCAN socket. The file which is
> responsible for this is involved in the Xenomai RTCAN driver support.

If a RT application does not read the CAN messages from the RX socket
buffer fast enough, such socket overflows can happen. Check if your
application switches (accidentally) to secondary mode.

Do you use sockets just for sending messages? Then it helps to disable
the reception of messages by using sendto

http://www.rts.uni-hannover.de/xenomai/lxr/source/src/utils/can/rtcansend.c#085

or disable the receive filter:

http://www.rts.uni-hannover.de/xenomai/lxr/source/src/utils/can/rtcansend.c#252

It also helps to disable the CAN debugging because the printk's provoke
further buffer overflows. You can also see the socket buffer overflows
in /proc/rtcan/sockets.

Wolfgang.


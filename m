Message-ID: <43EB80BC.1060403@domain.hid>
Date: Thu, 09 Feb 2006 10:49:48 -0700
From: John Schipper <jschipper@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Isolated CPU, SMI problems an thoughts
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello,
I'm new to this list but have in the past used RTAI in a single 
processor off the shelf solution. I'm looking to switch to native 
Xenomai api but have a general problem...
  The problem is SMI on new systems, and other latency killers that 
sometimes are not controllable by software always popping up when trying 
to migrate to a newer platform.  Can a dual core processor using 
isolcpus, preemp-rt and xenomai effectively future proof agains smi/chip 
set issues (specificly AMD or Intel dual core solutions) by isolating a 
cpu for exclusively xenomai/realtime use?

Some background information: 
  The realtime software I've developed in the past (with RTAI/adeos in 
user space) is a simple high speed serializer driver (mmap) to 
communicate with outside hardware and is responsible for syncronizing 
(with a semaphore/mutex) a linux process (soft realtime) at ~60Hz.  The 
realtime process is periodic at 1.2Khz or 2.4Khz and calculates/filters 
the data before sending commands back down the serializer interface and 
to the linux process for soft realtime network access.

  Generally we like to use "off the shelf" business PC's (Dell 170's and 
Dell 270's, HP 5000 with 1Gig memory) and find that 20-30us latency is 
achievable.  We use "off the shelf" hardware because availability 
(recieve within a week) and low cost are desired.   Whenever looking for 
an alernative solution either availablity or cost becomes a show 
stopper.  I'm open to suggestions and invite anyones thoughts on the 
subject.

Thanks for your time !

JKS




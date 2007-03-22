Message-ID: <46023A6D.5010002@domain.hid>
Date: Thu, 22 Mar 2007 09:12:29 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <460237BD.1020205@domain.hid>
In-Reply-To: <460237BD.1020205@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: RT-Socket-CAN bus error rate and latencies
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Hartkopp, Oliver (K-GEFE/E)" <oliver.hartkopp@domain.hid>
Cc: socketcan-core@domain.hid, Oliver Hartkopp <socketcan@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Hartkopp, Oliver (K-GEFE/E) wrote:
> Even if i know, that my reply with our f*cking exchange mailserver will 
> break the thread ...
> 
> Jan Kiszka wrote:
>> I think Oliver's suggestions points in the right direction. But instead
>> of only coding a timer into the stack, I still vote for closing the loop
>> over the application:
>>
>> After the first error in a potential series, the related error frame is
>> queued, listeners are woken up, and BEI is disabled for now. Once some
>> listener read the error frame *and* decided to call into the stack for
>> further bus errors, BEI is enabled again.
>>
>>   
> IMO this is really a good idea! Even if it look just a bit different on 
> (non-RT) socketcan, the procedure could look like this:
> 
> 1. BEI occurs => disable BEI & lauch receiption of one error frame for 
> the user
> 2. Wait for user interaction
> 
> I would suggest to create an IOCTL, where you can define, if you only 
> want to receive one BE-frame (== default!) or every BE-frame (may flood 
> your system). After an occurance of a BEI the BE-frames are disabled (in 
> the default case) until the user decides to reenable it via the 
> suggested IOCTL.
> 
> Does this look acceptable to you?

No extra IOCTL please. I would place re-enabling of BEI in sendmsg.

> Btw. Currently the enabling of error frames (in socketcan) currently 
> does not depend on subscribed listeners (what is definitely a good idea!).

Why?

Wolfgang.



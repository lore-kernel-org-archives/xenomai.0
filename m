Message-ID: <49C16F57.8090808@domain.hid>
Date: Wed, 18 Mar 2009 23:01:59 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1237393895.5495.7.camel@domain.hid> <49C16D55.1080003@domain.hid>
In-Reply-To: <49C16D55.1080003@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash in
	xnheap_test_and_free	(native/heap.c)
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Andreas Glatz wrote:
>> Hi,
>>
>> I got a kernel crash because inside xnheap_test_and_free a 
>> invalid pointer contained in variable 'nextpage' is dereferenced:
>>
> 
> <snip>
> 
> This turned out to be caused by an out-of-bound write triggered by the streaming 
> output service.
> 
> The patch below fixes the issue; it has been committed to both the maintenance 
> (v2.4.x) and development branches.
> 
> Sidenote: your test scenario involves echoing some data to /dev/rtp0 for 
> triggering the issue; this will now work, but you won't get that input available 
> to rt_pipe_read(). In case you wonder why, the reason is that 'echo' will exit 
> immediately after sending the bytes, which will cause the user-space side of the 
> channel to be closed, and the input queue (the one that goes user -> kernel) to 
> be flushed from any pending data.
> 

...unless your polling RT read loop wakes up at the right time and manages to 
preempt the Linux kernel shortly after the echo sent the bytes, in which case 
you will receive the data, but that is obviously not the most frequent situation.

-- 
Philippe.


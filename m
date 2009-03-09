Message-Id: <2FD407A9-747D-44DD-AEE7-54AE200C99CA@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <1236608449.3587.32.camel@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Mon, 9 Mar 2009 10:36:26 -0400
References: <1236608449.3587.32.camel@domain.hid>
Subject: Re: [Xenomai-core] rt_queue_create in RT task?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: xenomai@xenomai.org

Andreas,

I do not know your situation but it is generally better to not  
allocate things in realtime contexts because it is not deterministic.  
You may consider redesigning your applications to use pre-allocated  
queues as it would be better overall.

Regards,
Steven

On Mar 9, 2009, at 10:20 AM, Andreas Glatz wrote:

> Hi,
>
> Calling rt_queue_create in a real-time task is supposed to fail
> according to the documentation.
>
> I found out, that the reason for this is, that the memory for
> the queue memory pool is allocated with vmalloc/kmalloc.
> Is there another reason?
>
> I still would like to be able to call rt_queue_create in a
> real-time task in my activity of porting real-time applications
> to Xenomai because I think that patching rt_queue_create would
> be less time consuming than redesigning the applications.
>
> My approach to get there would be to split rt_queue_create into
> two separate functions, one that allocates the memory pool
> and another one which initializes the queue structure...
>
> Best regards,
> Andreas
>
>
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core



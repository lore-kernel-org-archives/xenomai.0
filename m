Message-ID: <473492EF.6090309@domain.hid>
Date: Fri, 09 Nov 2007 18:03:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <473391B0.5040809@domain.hid> <4733A2B8.8070100@domain.hid>
	<47344759.4020505@domain.hid> <473484C6.6050101@domain.hid>
In-Reply-To: <473484C6.6050101@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] User space drivers on PPC440
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
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> Your patch makes sense.
> 
> I have some results, but I'm not sure I understand what they mean.  I've
> attached the test program that I am using.  Here is what it outputs:
> 
> bash-3.00# ./o2
> Trying to free nonexistent resource <0000000000000000-00000000c0000001>
> get leds: -16 Device or resource busy
> put leds: 0 Success
> 
> Trying to free nonexistent resource <0000000000000000-ffffffffffffffff>
> get low_mem: -16 Device or resource busy
> put low_mem: 0 Success

Actually, we should define rt_misc_put_io_region() as a void routine,
since the kernel does not return any status from release_region(). At
this chance, I've fixed this, since returning 0 albeit a failure message
is dumped to the kernel log upon error is disturbing.

> 
> I am a little unclear on request_resource() - the return code is
> backwards of what I would have expected.  Looking at examples in the
> kernel, it appears that request_resource() returns EBUSY when things go
> well, and it returns 0 when things go badly.  Like I said, that seems
> backwards, but I guess it makes sense - EBUSY apparently means that the
> resource is _now_ busy?
>

request_resource() should return a valid resource descriptor address
upon success, which Xenomai converts to zero. Conversely, -EBUSY is
returned if request_region() sends us back a NULL value, since this is
how check_region() behaves.

> Anyway, following the kernel examples, my program considers a non-zero
> return as success.  At that point I release the region.  If instead, I
> get a zero return, then I treat that as a failure, and don't release the
> region.
> 
> The part I don't understand is why I get the "Trying to free nonexistent
> resource" messages.  Since I am getting an EBUSY, I thought that meant I
> owned the resource, and that I should release it...
> 

I suspect request_region() did actually fail.

> Also, the addresses printed above are a bit strange.  For example, I
> would have thought that instead of
> "<0000000000000000-00000000c0000001>", it would print
> "<00000001c0000000-00000001c0000013>".  Perhaps that is a clue - maybe
> the start and length are not being passed correctly.
> 
> One more question.  It appears that if my program crashes, that the
> region will never be released.  So, the normal behavior of an exiting
> process freeing all its resources doesn't seem to be guaranteed.
> 

As a matter of fact, we track all common objects like sema4s, mutexes,
queues, and so on, but not I/O regions. Consider this as an illustration
of our absolute laziness, since we do have the proper infrastructure to
handle I/O regions in the auto-cleanup process too.

>     Steve
> 
> 
> Philippe Gerum wrote:
>> Philippe Gerum wrote:
>>   
>>> Steven A. Falco wrote:
>>>     
>>>> The rt_misc_get_io_region() has the "start" argument as an unsigned 
>>>> long.  On the PPC440, we have a 36-bit address space, where the I/O 
>>>> registers are generally above the 4GB area.  For example, the UART is at 
>>>> address 0x1ef600300.
>>>>
>>>> The Linux request_region call has "start" typed as a resource_size_t, 
>>>> which is a u64 on the PPC440 (i.e. CONFIG_RESOURCES_64BIT is set even 
>>>> though this is a 23-bit processor).
>>>>
>>>> Is this something that should be handled by xeno-config?  It could 
>>>> append a CFLAG indicating the size of a resource.
>>>>       
>>> Or use a 64bit long unconditionally, to keep the same kernel-based
>>> implementation, since there is no performance issue for this call. In
>>> any case, we need to fix the API before 2.4 final is out -- which will
>>> also affect the ABI, but it already changed during the 2.4 development
>>> phase anyway.
>>>
>>>     
>>
>> Does this patch work for you?
>>
>>   


-- 
Philippe.


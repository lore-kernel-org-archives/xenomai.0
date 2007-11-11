Message-ID: <47373B92.1050008@domain.hid>
Date: Sun, 11 Nov 2007 18:27:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <473391B0.5040809@domain.hid> <4733A2B8.8070100@domain.hid>
	<47344759.4020505@domain.hid> <473484C6.6050101@domain.hid>
	<473492EF.6090309@domain.hid> <4734995E.7090105@domain.hid>
	<4735DC17.1070003@domain.hid>
In-Reply-To: <4735DC17.1070003@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> Steven A. Falco wrote:
>> Solved.  As you pointed out, Xenomai inverts the returned value from
>> request_region.  So, that was a bug in my application.
>>
>> However, turns out that instead of request_region, I have to use
>> request_mem_region.  This is because the I/O region only goes up to
>> 2^32, but the mem region goes up to 2^64.
>>
>> So, attached is a patch to add two new syscalls: rt_misc_get_mem_region
>> and rt_misc_put_mem_region.
>>
> 
> Thanks. At this chance, I've reworked the I/O region support to
> introduce descriptors, so that this API conforms to the
> one-descriptor-per-object rule commonly followed by other services from
> the native skin. I've merged your MMIO support on top of this. The added
> bonus is that auto-cleanup upon process exit becomes available with I/O
> regions too, since we now have the proper descriptor to hold the cleanup
> data.
> 
> The calls supporting this scheme are named rt_io_get_region, and
> rt_io_put_region, taking a RT_IOREGION object descriptor to hold the
> internal resource information. The rt_misc_io_get/put_region API is now
> deprecated starting with 2.4-rc6, albeit still available to allow for
> smooth transition; one will only get a warning as a reminder to upgrade
> to the new calls when using the old ones. e.g.
> 
> RT_IOREGION iorn;
> 
> rt_io_get_region(&iorn, label, start, len, IORN_IOPORT)
> is equivalent to calling:
> rt_misc_get_io_region(start, len, label)
> 
> the same way,
> 
> rt_io_get_region(&iorn, label, start, len, IORN_MEMORY)

s,IORN_MEMORY,IORN_IOMEM,

(for consistency reason with Linux's naming scheme)

> is equivalent to calling:
> rt_misc_get_mem_region(start, len, label)
> 
> Conversely,
> 
> rt_io_put_region(&iorn)
> is equivalent to calling:
> rt_misc_put_io/mem_region(start, len)
> 
> 


-- 
Philippe.


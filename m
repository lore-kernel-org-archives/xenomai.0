Subject: Re: [Xenomai-help] BUG: unable to handle kernel paging request
From: Victor Shulyak <V.I.Shulyak@domain.hid>
In-Reply-To: <b647ffbd0701261046m52172774lf5a7b4d08e090583@domain.hid>
References: <1169811995.462.13.camel@domain.hid>
	<1169827668.3346.61.camel@domain.hid>
	<b647ffbd0701261046m52172774lf5a7b4d08e090583@domain.hid>
Content-Type: multipart/mixed; boundary="=-9VaK3ZRji4sGHMGxZr5+"
Date: Mon, 29 Jan 2007 22:17:22 +0600
Message-Id: <1170087442.24120.6.camel@domain.hid>
Mime-Version: 1.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>


--=-9VaK3ZRji4sGHMGxZr5+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

> Let's suppose we can believe in sanity of the call trace, then would
> you, Victor, provide a disassembled code for
> __ipipe_handle_exception() ?
> 
> Call Trace:
>  [<c0112566>] __ipipe_handle_exception+0x58/0x11e
>  [<c01050f4>] do_divide_error+0x0/0xb1
>  [<c0309202>] error_code+0x3e/0x4c
> 
> 
> Memory: 384496k/393152k available (2088k kernel code, 8108k reserved,
> 633k data, 180k init, 0k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
>     vmalloc : 0xd8800000 - 0xfffb5000   ( 631 MB)
>     lowmem  : 0xc0000000 - 0xd7ff0000   ( 383 MB)
>    .init : 0xc03ac000 - 0xc03d9000   ( 180 kB)
>    .data : 0xc030a212 - 0xc03a88f4   ( 633 kB)
>    .text : 0xc0100000 - 0xc030a212   (2088 kB)

Attached file contains objdump -D of my kernel image with
__ipipe_handle_exception function.


How could I locate the faulty routine containing eip=0xc7b84d51?


Thanks, Victor

--=-9VaK3ZRji4sGHMGxZr5+
Content-Disposition: attachment; filename=disassembled.bz2
Content-Type: application/x-bzip; name=disassembled.bz2
Content-Transfer-Encoding: base64

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


--=-9VaK3ZRji4sGHMGxZr5+--


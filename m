Message-ID: <2ff1a98a0711090902u5b940ed0w3ab34f6e1a040f46@domain.hid>
Date: Fri, 9 Nov 2007 18:02:39 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <473484C6.6050101@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <473391B0.5040809@domain.hid> <4733A2B8.8070100@domain.hid>
	<47344759.4020505@domain.hid> <473484C6.6050101@domain.hid>
Subject: Re: [Xenomai-core] User space drivers on PPC440
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

On Nov 9, 2007 5:03 PM, Steven A. Falco <sfalco@domain.hid> wrote:
>
>  Your patch makes sense.
>
>  I have some results, but I'm not sure I understand what they mean.  I've
> attached the test program that I am using.  Here is what it outputs:
>
>  bash-3.00# ./o2
>  Trying to free nonexistent resource <0000000000000000-00000000c0000001>
>  get leds: -16 Device or resource busy
>  put leds: 0 Success
>
>  Trying to free nonexistent resource <0000000000000000-ffffffffffffffff>
>  get low_mem: -16 Device or resource busy
>  put low_mem: 0 Success
>
>  I am a little unclear on request_resource() - the return code is backwards
> of what I would have expected.  Looking at examples in the kernel, it
> appears that request_resource() returns EBUSY when things go well, and it
> returns 0 when things go badly.  Like I said, that seems backwards, but I
> guess it makes sense - EBUSY apparently means that the resource is _now_
> busy?

request_region returns a pointer to a struct resource, and NULL if the
resource is already reserved.


-- 
                                               Gilles Chanteperdrix


Message-ID: <894886ec0809191008m3b1eac19s45a1d67316eba626@domain.hid>
Date: Fri, 19 Sep 2008 10:08:29 -0700
From: "Rob Wheeler" <wheeler@domain.hid>
In-Reply-To: <48D34936.7090206@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7ed3bc8b0809171347j6744978ck69959990435942ea@domain.hid>
	<48D176F0.7060805@domain.hid>
	<894886ec0809181640t3d413a73h5c02da73dc3000c9@domain.hid>
	<48D34936.7090206@domain.hid>
Subject: Re: [Xenomai-help] Xenomai IRQ Disable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: soa@domain.hid, xenomai@xenomai.org

On Thu, Sep 18, 2008 at 11:39 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Rob Wheeler wrote:
>> I'm having similar issues with IRQs and keyboard/mouse configurations.
>>  For me, if I use a combination mouse/keyboard device then the kernel
>> has issues.  So I have to use the most simplistic form of USB keyboard
>> I can locate.  Also, it seems to be dependent on which USB port I plug
>> into.  Finally, I need to use the 'irqpoll' option to the kernel,
>> otherwise I can't boot with even a simple USB keyboard.
>
> Are these effects limited to I-pipe-patched kernels? Or do you have the
> same issues with the corresponding vanilla Linux?

Just the I-pipe patched kernel.  The vanilla kernel operates fine with
devices in any of the four USB ports.

-R


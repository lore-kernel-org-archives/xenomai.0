Message-ID: <4FE22000.5090102@xenomai.org>
Date: Wed, 20 Jun 2012 21:09:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAM1yFZ8PK+i3quP2MfFeEAR2Wya0f9bV=bjYehXeY5KTw8EJuQ@mail.gmail.com>
In-Reply-To: <CAM1yFZ8PK+i3quP2MfFeEAR2Wya0f9bV=bjYehXeY5KTw8EJuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] =?utf-8?q?error=3A_storage_size_of_=E2=80=98sysinfo?=
 =?utf-8?b?4oCZIGlzbuKAmXQga25vd24=?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anisha Kaul <born.rebel.83@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 06/20/2012 02:50 PM, Anisha Kaul wrote:
> [ ] ACPI (Advanced Configuration and Power Interface) Support  --->

> asks us to disable the following:
> 
> * CONFIG_APM
> * CONFIG_ACPI_PROCESSOR

I see a discrepancy here, you are told to disable CONFIG_ACPI_PROCESSOR
and you disable CONFIG_ACPI, whereas the documentation explicitely tells
you:

"Do not disable power management globally, the only configuration
options which should be disabled in this area are:

    CONFIG_APM
    CONFIG_ACPI_PROCESSOR

for reasons mentioned here:

http://www.xenomai.org/index.php/FAQs#Tips_and_tricks_setting_up_your_x86_kernel

In particular, keeping the ACPI enabled bears no risks of high
latencies, whereas disabling it may prevent your system from booting
correctly."


> What could I have done wrong this time? Please help. :(

You seem to have botched the kernel preparation of configuration, as
usual. From what I can remember, this is the third time I help you
configuring your kernel configuration. Can't you simply keep the kernel
configuration from one trial to the next, and reuse it, instead of
trying again from scratch, and making the same mistakes, and asking for
help, again and again? What do you think, that our time is unlimited and
you can get us to do your job for free?

So, now the answer is: get your head out of your ass, find and fix the
problem yourself, I am tired of answering you.

-- 
                                                                Gilles.


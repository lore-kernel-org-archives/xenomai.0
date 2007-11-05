Message-ID: <ff1d78710711050757r474a6d86g5790a3f3b76eae1a@domain.hid>
Date: Mon, 5 Nov 2007 16:57:31 +0100
From: "Steven Kauffmann" <steven.kauffmann@domain.hid>
In-Reply-To: <fd6a47a90711050117h1d2afbd1p56add10625a8da6f@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_10548_25332278.1194278251306"
References: <200710311542.l9VFgax19256@domain.hid>
	<ff1d78710711050043h7ebe3bc1l88c180d36c800d3@domain.hid>
	<ff1d78710711050046o29f8520bu8356bbb4b479cd46@domain.hid>
	<fd6a47a90711050117h1d2afbd1p56add10625a8da6f@domain.hid>
Subject: Re: [Xenomai-help] RTDM interrupt questions
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>, xenomai@xenomai.org

------=_Part_10548_25332278.1194278251306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Nov 5, 2007 10:17 AM, Jeroen Van den Keybus <
jeroen.vandenkeybus@domain.hid> wrote:

>  Ok, dev->irq gives number 22 and interrupt is working.
> >
> >
> >
> > >
> > > >
> > > > The result is 10, but the result of lspci -v is:
> > >
> >
> As far as I know, the IRQ value field in the PCI config area is rather a
> scratch pad memory, and intended to be set correctly by the BIOS after PCI
> device enumeration. When interrupts are changed from the BIOS
> defaults during e.g. ACPI config, no one seems to care about this value
> anymore. As pointed out earlier, use dev->irq, which is always correct.
>
>
> >
> >
> Is there not something like a signal I can set in the interrupt routine of
> the driver. The user space application have to wait its execution until the
> signal is set?
>
> Yes, you could use the following code:
>
> #include <rtdm/rtdm_driver.h>
>
> static rtdm_event_t evt;
>
> static int realtime_intr(rtdm_irq_t *irq_context)
> {
>     acknowledge_irq_on_fpga_card();
>     rtdm_event_signal(&evt);
> }
>
> static int realtime_read(struct rtdm_dev_context *context,
> rtdm_user_info_t *user_info, void *buf, size_t nbyte)
> {
>     // ...
>     err = rtdm_event_wait(&evt);
>     get_data_from_fpga_card();
>     // ...
> }
>
> static int realtime_open()
> {
>     // ...
>     evt = rtdm_evt_init(&evt);
>     enable_irq_from_fpga_card();
>     // ...
> }
>
> This is assuming use of the RTDM. You can do the rtdm_event_wait from a
> user task equally, I would think.
>

The RTDM code is compiled as a kernel module, so I can't use the
rtdm_event_wait function in the driver. That part should be in the user
space application which is a real-time task. The API documentation says that
the rtdm_event_wait function can be called from an user-space task(RT). How
do I have to use it in an user-space task(RT) if rtdm_event_wait is not
defined in rtdm.h?

For the moment I have the kernel module(driver that communicates with the
FPGA card), 1 user space applications(real-time tasks). For example the FPGA
implements a multiplier. The user space task sends 2 values to the driver,
after that it should wait (rtdm_event_wait if it is possible). When the
multiplier on the FPGA is done, it generates an interrupt. The RTDM driver
receives this interrupt and sends a signal to the user space task that it
can stop waiting and read the result of the multiplying.

I hope that this makes it easier to understand my problem.

Steven

------=_Part_10548_25332278.1194278251306
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Nov 5, 2007 10:17 AM, Jeroen Van den Keybus &lt;<a href="mailto:jeroen.vandenkeybus@domain.hid">jeroen.vandenkeybus@domain.hid</a>&gt; wrote:<br><div class="gmail_quote"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d"><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0px 0px 0px 0.8ex; padding-left: 1ex;">
<div class="gmail_quote">
<div class="gmail_quote">
<div>Ok, dev-&gt;irq gives number 22 and interrupt is working.<br><br>&nbsp;</div><span>
<div>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><br>&gt;<br>&gt; The result is 10, but the result of lspci -v is:</div></blockquote></div></span></div></div></blockquote>
<div>&nbsp;</div></div>
<div>As far as I know, the IRQ value field in the PCI config area is rather a scratch pad memory, and intended to be set correctly by the BIOS&nbsp;after PCI device enumeration. When interrupts are&nbsp;changed from the BIOS defaults&nbsp;during 
e.g. ACPI config, no one seems to care about this value anymore. As pointed out earlier, use dev-&gt;irq, which is always correct.</div><div class="Ih2E3d">
<div>&nbsp;</div>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0px 0px 0px 0.8ex; padding-left: 1ex;">
<div class="gmail_quote">
<div class="gmail_quote"><span>
<div>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div></div></blockquote></div></span>&nbsp;</div></div></blockquote>
<div>Is there not something like a signal I can set in the interrupt routine of the driver. The user space application have to wait its execution until the signal is set? </div>
<div>&nbsp;</div></div>
<div>Yes, you could use the following&nbsp;code:</div>
<div>&nbsp;</div>
<div>#include &lt;rtdm/rtdm_driver.h&gt;</div>
<div>&nbsp;</div>
<div>static rtdm_event_t evt;</div>
<div>&nbsp;</div>
<div>static int realtime_intr(rtdm_irq_t *irq_context)</div>
<div>{</div>
<div>&nbsp;&nbsp;&nbsp; acknowledge_irq_on_fpga_card();</div>
<div>&nbsp;&nbsp;&nbsp; rtdm_event_signal(&amp;evt);</div>
<div>}</div>
<div>&nbsp;</div>
<div>static int realtime_read(struct rtdm_dev_context *context, rtdm_user_info_t *user_info, void *buf, size_t nbyte)</div>
<div>{</div>
<div>&nbsp;&nbsp;&nbsp; // ...</div>
<div>&nbsp;&nbsp;&nbsp; err = rtdm_event_wait(&amp;evt);</div>
<div>&nbsp;&nbsp;&nbsp; get_data_from_fpga_card();</div>
<div>&nbsp;&nbsp;&nbsp; // ...</div>
<div>}<br>&nbsp;</div>
<div>static int realtime_open()</div>
<div>{</div>
<div>&nbsp;&nbsp;&nbsp; // ...</div>
<div>&nbsp;&nbsp;&nbsp; evt = rtdm_evt_init(&amp;evt);</div>
<div>&nbsp;&nbsp;&nbsp; enable_irq_from_fpga_card();</div>
<div>&nbsp;&nbsp;&nbsp; // ...</div>
<div>}</div>
<div>&nbsp;</div>
<div>This is assuming use of the RTDM. You can do the rtdm_event_wait from a user task equally, I would think.</div></blockquote><div><br>The RTDM code is compiled as a kernel module, so I can&#39;t use the rtdm_event_wait function in the driver. That part should be in the user space application which is a real-time task. The API documentation says that the rtdm_event_wait function can be called from an user-space task(RT). How do I have to use it in an user-space task(RT) if rtdm_event_wait is not defined in 
rtdm.h?<br><br>For the moment I have the kernel module(driver that communicates with the FPGA card), 1 user space applications(real-time tasks). For example the FPGA implements a multiplier. The user space task sends 2 values to the driver, after that it should wait (rtdm_event_wait if it is possible). When the multiplier on the FPGA is done, it generates an interrupt. The RTDM driver receives this interrupt and sends a signal to the user space task that it can stop waiting and read the result of the multiplying.
<br><br>I hope that this makes it easier to understand my problem.<br><br>Steven<br></div></div>

------=_Part_10548_25332278.1194278251306--


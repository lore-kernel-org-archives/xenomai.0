Message-ID: <BLU437-SMTP82C3E059EB476E2624582EF02C0@phx.gbl>
References: <56358DE3.8030308@hotmail.com>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sun, 1 Nov 2015 18:58:12 -0800
MIME-Version: 1.0
In-Reply-To: <56358DE3.8030308@hotmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Support for Raspberry PI 2 B
	(devm_request_threaded_irq)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 15-10-31 08:58 PM, Mathieu Rondonneau wrote:
> Hi,
>
> irq handlers registered with devm_request_threaded_irq does not get
> triggered when interrupt fires.
>
> The mmc driver uses this (can not load the rootfs).
> Only the IPIPE patch is enabled.
> the armctrl chipirq is triggering the .ack handler instead so the
> interrupt is happening.
>
> Any suggestion on where I should look? how is this supported by the
> ipipe layer?
>
> Thanks,
> -Mathieu

I think I might have answered my own question.
Looks like I need to use ipipe_request_irq() instead.

Regards,
-Mathieu


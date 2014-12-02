Date: Tue, 2 Dec 2014 10:57:07 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141202095707.GG2076@hermes>
References: <314E5ECDAA86314791309FA670550F89C9C51961@SINTEFEXMBX05.sintef.no>
 <20141202093346.GE2076@hermes>
 <314E5ECDAA86314791309FA670550F89C9C519EE@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C9C519EE@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] IRQ155 not handled. Disabling IRQ line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 02, 2014 at 09:51:01AM +0000, Terje Frøysa wrote:
> Well, the code:
> 	DEBUG_PRINT(KERN_DEBUG "RTDM IMU %d - enable IRQ\n", info->gpio_pin_n);
> 	err = rtdm_irq_enable(&info->gpio_irq);
> only exists one place in the driver and is only executed in the kernel-context of  rt_dev_open() from user-space.
> The irq-device is opened only once before entering the read-loop.
> 
> The repeated read calls from the user space (rt_dev_read()) only blocs on the irq semaphore and copies the irq-time back to the user.
> I don't see how the irq-line can be re-enabled by this code.
> If the device have been repeatedly opened, the dmesg would have been flooded with log-messages.

What flags do you pass to rtdm_irq_request?

-- 
					    Gilles.


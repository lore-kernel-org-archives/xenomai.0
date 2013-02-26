Message-ID: <512CC6A3.1010005@siemens.com>
Date: Tue, 26 Feb 2013 15:28:51 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com> <512C9E78.1060208@siemens.com>
	<512CC5C6.8050204@hilscher.com>
In-Reply-To: <512CC5C6.8050204@hilscher.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-02-26 15:25, Jerome Poncin wrote:
> Hello Jan,
> 
> Thank you for your answer. I checked /proc/interrupts and lspci -v, and I saw that the IRQ is shared.
> 
> "If yes, resolve that conflict."
> 
> => What must I do ? I'm not sure to have understood ?

See
http://xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_devices_share_the_same_IRQ.3F

> 
> 
> /*****************************************************************************/
> /*!
> *   \brief  cifx_handler
> *
> *   \param  [in]    irq      Resource task pointer
> *
> *   \return RTDM_IRQ_NONE or RTDM_IRQ_HANDLED
> *
> *   \note   cifx interrupt handler
> */
> /*****************************************************************************/
> static /*inline*/ int cifx_handler(rtdm_irq_t *irq)
> {
>     struct rtdm_device    *info             = (struct rtdm_device *)rtdm_irq_get_arg(irq, void);
>     io_info_t             *device_data     = (io_info_t *) info->device_data;
> 
>     if ((device_data->priv != NULL) || (device_data->irq_registered == FALSE) || (device_data->irq_enable == FALSE))
>     {
>         /* This is a PLX device and cannot produce an IRQ */
>         return RTDM_IRQ_NONE;
>     }
>     else
>     {
>         void __iomem *int_enable_reg = device_data->mem[DPM_INDEX].internal_addr + DPM_HOST_INT_EN0;
>         void __iomem *int_status_reg = device_data->mem[DPM_INDEX].internal_addr + DPM_HOST_INT_STAT0;
> 
>         /* Is one of our interrupts enabled and active ? */
>         if (!(ioread32(int_enable_reg) & ioread32(int_status_reg) & DPM_HOST_INT_MASK))
>             return RTDM_IRQ_NONE;
> 
>         /* Disable interrupt */
>         iowrite32(ioread32(int_enable_reg) & ~DPM_HOST_INT_GLOBAL_EN, int_enable_reg);
> 
>         return RTDM_IRQ_HANDLED;
>     }
> }
> 
> If IRQ is not mine, I return RTDM_IRQ_NONE, it's not correct ?

It is. The problem is the sharing between RT and Linux. That cannot work.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux


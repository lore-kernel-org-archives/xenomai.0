Message-ID: <512CC5C6.8050204@hilscher.com>
Date: Tue, 26 Feb 2013 15:25:10 +0100
From: Jerome Poncin <JPoncin@hilscher.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com> <512C9E78.1060208@siemens.com>
In-Reply-To: <512C9E78.1060208@siemens.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Hello Jan,

Thank you for your answer. I checked /proc/interrupts and lspci -v, and I s=
aw that the IRQ is shared.

"If yes, resolve that conflict."

=3D> What must I do ? I'm not sure to have understood ?

/**************************************************************************=
***/
/*!
*   \brief  cifx_handler
*
*   \param  [in]    irq      Resource task pointer
*
*   \return RTDM_IRQ_NONE or RTDM_IRQ_HANDLED
*
*   \note   cifx interrupt handler
*/
/**************************************************************************=
***/
static /*inline*/ int cifx_handler(rtdm_irq_t *irq)
{
     struct rtdm_device    *info             =3D (struct rtdm_device=20
*)rtdm_irq_get_arg(irq, void);
     io_info_t             *device_data     =3D (io_info_t *)=20
info->device_data;

     if ((device_data->priv !=3D NULL) || (device_data->irq_registered =3D=
=3D=20
FALSE) || (device_data->irq_enable =3D=3D FALSE))
     {
         /* This is a PLX device and cannot produce an IRQ */
         return RTDM_IRQ_NONE;
     }
     else
     {
         void __iomem *int_enable_reg =3D=20
device_data->mem[DPM_INDEX].internal_addr + DPM_HOST_INT_EN0;
         void __iomem *int_status_reg =3D=20
device_data->mem[DPM_INDEX].internal_addr + DPM_HOST_INT_STAT0;

         /* Is one of our interrupts enabled and active ? */
         if (!(ioread32(int_enable_reg) & ioread32(int_status_reg) &=20
DPM_HOST_INT_MASK))
             return RTDM_IRQ_NONE;

         /* Disable interrupt */
         iowrite32(ioread32(int_enable_reg) & ~DPM_HOST_INT_GLOBAL_EN,=20
int_enable_reg);

         return RTDM_IRQ_HANDLED;
     }
}

If IRQ is not mine, I return RTDM_IRQ_NONE, it's not correct ?

Thank you very much for your help,

Hilscher France
12, rue du 35=E8me R=E9giment d'Aviation
Miniparc du Ch=EAne
69500 BRON
France
T=E9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http://www.hilscher.fr
HILSCHER FRANCE 	J=E9r=F4me Poncin
jponcin@hilscher.com
Ing=E9nieur D=E9veloppement Logiciel
T=E9l. : +33 (0) 4 72 37 98 44





Le 26/02/2013 12:37, Jan Kiszka a =E9crit :
> On 2013-02-26 10:29, Jerome Poncin wrote:
>> Hello,
>>
>> I have a problem with driver for Hilscher cifx with IRQ.
>>
>> All driver run good (I verified in polling mode) but in case I activate
>> IRQ the system freeze.
>>
>> I checked parameters of "rtdm_irq_request" function without success (all
>> seems good) ! I tried to see on internet to get some information about
>> the use of "rtdm_irq_request", or compare my code with other driver but
>> it's not easy...
>> I give you in attached file my code because I have no idea about my
>> problem, and it's really difficult to have some information or trace
>> after system freeze...
>> Do you have an idea about my problem ?
>> static inline int cifx_handler(rtdm_irq_t *irq)
>           ^^^^^^
> But I suspect the compiler is smart enough to ignore this.
>
> Is the line you are registering for shared with other devices? Check
> /proc/interrupts and lspci -v. If yes, resolve that conflict.
>
> If not, add printk to your IRQ handler, redirect the kernel messages to
> a serial console and try to find out how far and how ofter you get into
> the handler.
>
> Well, and then there is the option of source-level debugging. kgdb for
> I-pipe patches aren't merged yet, but more convenient is KVM-based
> debugging anyway. See [1] for the concept. Just requires VT-d or AMD
> IOMMU on your target.
>
> Jan
>
> PS: Still no kernel coding style. Specifically the long lines makes it
> hard to read.
>
> [1]
> http://chemnitzer.linux-tage.de/2012/vortraege/folien/1061-VirtualDebuggi=
ng.pdf
>


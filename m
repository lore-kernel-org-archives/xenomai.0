Message-ID: <4C51223A.2070700@domain.hid>
Date: Thu, 29 Jul 2010 08:39:54 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTikTyH5R8oMS-f-1jcJqryAwT-DKfzxNf1YROALK@mail.gmail.com>
	<AANLkTinvhF72tWwCEy85jT3Kk2cQZwRyCtBZNcSZk-yA@mail.gmail.com>
In-Reply-To: <AANLkTinvhF72tWwCEy85jT3Kk2cQZwRyCtBZNcSZk-yA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Bug - Can 2 devices.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Rodolfo Oliveira <rodolforomao@domain.hid>
Cc: xenomai@xenomai.org

Hello,

On 07/28/2010 08:15 PM, Rodolfo Oliveira wrote:
> Hello friends,
> 
> I am developing a project and I'm using two CAN. The Can one is working, but
> the CAN 2 is not, i 'm recompile the kernel enabled the can 2, but I can not
> make it work.
> Scenario:
> - I can print the frames in CAN 2, I get in the kernel log (dmesg) and the
> frames are correct.
> - CAN 2 works normally if I disable the CAN 1 and recompile the kernel.
> 
> Problem:
> In the "rtcan_raw.c" in function "void rtcan_rcv (struct rtcan_device * dev,
> struct rtcan_skb * skb)" there is a verification "while (recv_listener! =
> NULL) " and the problem is that the variable "recv_listener" is equal to
> NULL . This variable comes from the function "static int
> rtcan_mscan_interrupt (rtdm_irq_t irq_handle *)" (which is on file
> rtcan_mscan.c) this function passes a struct as a parameter "dev = (struct
> rtcan_device *) rtdm_irq_get_arg (irq_handle, void)" to "rtcan_rcv" and it
> contains the recv_listener = dev-> recv_list.
> 
> Soon the CAN2 is working but there are some configuration issues in this
> code.
> 
> Can anyone help me with this problem?

Are you speaking about the MSCAN driver for the MPC5200? The routing of
the second CAN port is configurable. Maybe it's not using the right I/O
pins. What CPU and Linux version are you using?

Wolfgang.




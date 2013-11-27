Message-ID: <52964FD6.6090802@grandegger.com>
Date: Wed, 27 Nov 2013 21:02:30 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <52962CC0.20505@geral.com>
In-Reply-To: <52962CC0.20505@geral.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtcan_flexcan on a i.MX28 board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexandre COFFIGNAL <acoffignal@geral.com>, xenomai@xenomai.org

Hi Alexandre,

On 11/27/2013 06:32 PM, Alexandre COFFIGNAL wrote:
> Hi all.
> 
> I'm trying to use rtcan_flexcan on a i.MX28 board with Xenomai 2.6.3
> under Linux v3.8.13.
> I use a dtb file and it seem to be a mistake in flexcan_probe function.
> 
> If flexcan device id is found in dtb, devtype_data points to the
> flexcan_id_table driver_data structure. In this case, the condition in
> flexcan_probe function (!devtype_data && pdev->id_entry->driver_data)
> will always fail and it will always return ENODEV, whereas devtype_data
> points to a valid value.

I see the problem. It should be like in the Linux kernel:

http://lxr.linux.no/#linux/drivers/net/can/flexcan.c#L1041

> I submit this patch which fixes this issue

Could you please send your patch inline in a separate mail with the
subject "[PATCH] rtcan_flexcan: ...".  Apart from that, I your RTCAN
Flexcan driver working properly, I assume.

Wolfgang.



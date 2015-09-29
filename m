Date: Tue, 29 Sep 2015 15:35:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929133538.GC13638@hermes.click-hack.org>
References: <CANWkrRMksLWR10fuM=M1Oc25GYzDHTzFqEq5cDJmGBpjdyxwyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANWkrRMksLWR10fuM=M1Oc25GYzDHTzFqEq5cDJmGBpjdyxwyg@mail.gmail.com>
Subject: Re: [Xenomai] Oops message on rtdm_read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Sep 29, 2015 at 03:10:38PM +0200, Michael Smith wrote:
> Hi. I'm unclear what I am doing wrong. But I get a oops message when I am
> trying to do a read() (RTDM) from user space into my device driver.
> 
> The read function in the driver has been setup as follows:
> 
>     .ops = {
>             .open           = open_dev,
>             .close          = close_dev,
>             .ioctl_rt       = device_ioctl,
>             .ioctl_nrt      = device_ioctl,
>             .read_nrt       = read_dev,
>             .read_rt        = read_dev,
>             .write_nrt      = write_dev,
>             .write_rt       = write_dev,
> 
> As can be seen I call the same read routine in real-time and non
> real-time, because they both boil down to the same type of callback
> function nl.
> 
> ssize_t rtdm_read_handler(struct rtdm_fd * fd,void __user * buf,size_t size )
> 
> When the read() call is done from user space (non real-time) I get a
> oops as follows:
> 
> [62847.263710] I-pipe: Detected illicit call from head domain 'Xenomai'
> [62847.263710]         into a regular Linux service
> [62847.263716] CPU: 2 PID: 4466 Comm: flash.out Tainted: G
> OE 3.16.0-xenomai-3.0.6 #2
> [62847.263718] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./Z87 Extreme4, BIOS P2.30 07/03/2013
> [62847.263719]  0000000000051730 ffff880092d6fd50 ffffffff817530ca
> 000000000000dde0
> [62847.263723]  ffff880092d6fd80 ffffffff8110b59d 0000000000000001
> 0000000000000004
> [62847.263727]  0000000000020000 0000000000002000 ffff880092d6fd98
> ffffffff8110c922
> [62847.263731] Call Trace:
> [62847.263738]  [<ffffffff817530ca>] dump_stack+0x45/0x56
> [62847.263742]  [<ffffffff8110b59d>] ipipe_root_only+0x18d/0x1b0
> [62847.263745]  [<ffffffff8110c922>] ipipe_restore_root+0x12/0x50
> [62847.263747]  [<ffffffff8175a17a>] _raw_spin_unlock_irqrestore+0x2a/0x30
> [62847.263751]  [<ffffffff816344e3>] pci_conf1_read+0xd3/0x130
> [62847.263754]  [<ffffffff81637763>] raw_pci_read+0x23/0x40
> [62847.263757]  [<ffffffff816377ac>] pci_read+0x2c/0x30
> [62847.263761]  [<ffffffff813e3dd6>]
> pci_bus_read_config_dword+0x66/0xa0

pci_bus_read_config_dword uses a plain Linux spinlock, thus can not
be called from primary mode.

So, read_dev may be a valid handler for read_nrt, but not for
read_rt.

-- 
					    Gilles.
https://click-hack.org


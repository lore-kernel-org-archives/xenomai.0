MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18447.40214.569540.276791@domain.hid>
Date: Wed, 23 Apr 2008 22:33:26 +0200
In-Reply-To: <480F5BA9.5010003@domain.hid>
References: <480F5BA9.5010003@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] rtdm mmap entry point
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: zakaria ElQotbi <zakaria.elqotbi@domain.hid>
Cc: xenomai@xenomai.org

zakaria ElQotbi wrote:
 > Hi
 > 
 > There is a way to handle mmap outside a rtdm ioctl entry point ??
 > Just like :
 >    
 >         open_nrt:               rtdm_ipci_open,
 > 
 >         ops:{
 >                 close_rt:        rtdm_ipci_close,
 >                 close_nrt:      rtdm_ipci_close,
 > 
 >                 ioctl_rt:        NULL,
 >                 ioctl_nrt:      NULL,
 > 
 >                 read_rt:        rtdm_ipci_read_rt,
 >                 read_nrt:      rtdm_ipci_read_nrt,               
 > 
 >                 mmap_rt:     NULL,
 >                 mmap_nrt:   rtdm_ipci_read_nrt,               
 > ......
 > 
 > i need this to port a code to rtdm.
 > 
 > my std Linux code is :
 > 
 > static struct file_operations ipci_fops <cid:part1.07040204.02010302@domain.hid> = {
 >      .owner   =  THIS_MODULE,
 >      .mmap    =  ipci_mmap <cid:part2.04040306.03010502@domain.hid>,
 >      .read    =  ipci_read <cid:part3.03040709.02050608@domain.hid>,
 >      .write   =  ipci_write <cid:part4.05050209.09030202@domain.hid>,
 >      .open    =  ipci_open <cid:part5.03080906.01020608@domain.hid>,
 >      .release =  ipci_release <cid:part6.07030805.04090101@domain.hid>,
 > };

Well, even if mmap is implemented as an ioctl, nothing prevents you from
replacing calls to mmap in the application you are making real-time by
calls to the ioctl.

Look, for instance at how setsockopt, bind, connect, accept, etc... are
implemented, they are all implemented as ioctls under the hood. mmap has
not yet such an official ioctl, but that could change.

-- 


					    Gilles.


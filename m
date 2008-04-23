Message-ID: <480F5BA9.5010003@domain.hid>
Date: Wed, 23 Apr 2008 17:54:17 +0200
From: zakaria ElQotbi <zakaria.elqotbi@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rtdm mmap entry point
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi

There is a way to handle mmap outside a rtdm ioctl entry point ??
Just like :
   
        open_nrt:               rtdm_ipci_open,

        ops:{
                close_rt:        rtdm_ipci_close,
                close_nrt:      rtdm_ipci_close,

                ioctl_rt:        NULL,
                ioctl_nrt:      NULL,

                read_rt:        rtdm_ipci_read_rt,
                read_nrt:      rtdm_ipci_read_nrt,               

                mmap_rt:     NULL,
                mmap_nrt:   rtdm_ipci_read_nrt,               
......

i need this to port a code to rtdm.

my std Linux code is :

static struct file_operations ipci_fops <cid:part1.07040204.02010302@domain.hid> = {
     .owner   =  THIS_MODULE,
     .mmap    =  ipci_mmap <cid:part2.04040306.03010502@domain.hid>,
     .read    =  ipci_read <cid:part3.03040709.02050608@domain.hid>,
     .write   =  ipci_write <cid:part4.05050209.09030202@domain.hid>,
     .open    =  ipci_open <cid:part5.03080906.01020608@domain.hid>,
     .release =  ipci_release <cid:part6.07030805.04090101@domain.hid>,
};

Thanks



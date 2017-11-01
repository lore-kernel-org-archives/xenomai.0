References: <CADXNiGXxi3m+CK9BOGJaKdt4KzZ_KOFTdjXW3AT-cWM=YT4BHw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <97a922b1-dd4c-3d63-80c7-1f71cb34dfeb@xenomai.org>
Date: Wed, 1 Nov 2017 22:14:15 +0100
MIME-Version: 1.0
In-Reply-To: <CADXNiGXxi3m+CK9BOGJaKdt4KzZ_KOFTdjXW3AT-cWM=YT4BHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_safe_copy_from_user() causing mode switch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jackson Jones <jackson.jones@gmail.com>, xenomai@xenomai.org

On 10/07/2017 03:56 AM, Jackson Jones wrote:
> I noticed that when I call rtdm_safe_copy_from_user() it causes a mode
> switch. I am looking to pass a uint32_t (u32 in kernel space) from
> user-space to a rtdm driver.
> 
> Is there a way of doing this that avoids a mode switch. I am doing this in
> an rtdm spi driver for the imx6. It is used to change the transfer size
> (number of words) for the next call to transfer_iobufs (using the
> SPI_RTIOC_TRANSFER ioctl).
> 

The mode switch is most likely caused by an access fault taken by the
CPU. Is /proc/xenomai/fault confirming this?

> Below is a modified spi_master_ioctl_rt which is inside of spi-master.c. I
> added an ioctl to do this. I verified that the ioctls SPI_RTIOC_SET_CONFIG,
> and SPI_RTIOC_GET_CONFIG cause a mode switch as well as the former calls
> rtdm_safe_copy_from_user() and the latter calls rtdm_safe_copy_to_user().
> Any advice would be appreciated.

What kind of source memory in user-space, stack-based?

-- 
Philippe.


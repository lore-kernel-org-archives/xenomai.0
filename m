From: Philippe Gerum <rpm@xenomai.org>
References: <CADXNiGXxi3m+CK9BOGJaKdt4KzZ_KOFTdjXW3AT-cWM=YT4BHw@mail.gmail.com>
 <97a922b1-dd4c-3d63-80c7-1f71cb34dfeb@xenomai.org>
Message-ID: <a6059dd1-27d4-15ac-a611-8f2d513299ba@xenomai.org>
Date: Wed, 1 Nov 2017 22:19:00 +0100
MIME-Version: 1.0
In-Reply-To: <97a922b1-dd4c-3d63-80c7-1f71cb34dfeb@xenomai.org>
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

On 11/01/2017 10:14 PM, Philippe Gerum wrote:
> On 10/07/2017 03:56 AM, Jackson Jones wrote:
>> I noticed that when I call rtdm_safe_copy_from_user() it causes a mode
>> switch. I am looking to pass a uint32_t (u32 in kernel space) from
>> user-space to a rtdm driver.
>>
>> Is there a way of doing this that avoids a mode switch. I am doing this in
>> an rtdm spi driver for the imx6. It is used to change the transfer size
>> (number of words) for the next call to transfer_iobufs (using the
>> SPI_RTIOC_TRANSFER ioctl).
>>
> 
> The mode switch is most likely caused by an access fault taken by the
> CPU. Is /proc/xenomai/fault confirming this?
> 

More precisely, this is most likely a fault due to a page table miss
which cannot be resolved on the fly by a simple page table fixup then
return. Instead, the whole thing has to go through the regular kernel
page fault handler, which requires Cobalt to switch to secondary mode
first.

-- 
Philippe.


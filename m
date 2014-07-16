Message-ID: <53C65367.1050301@xenomai.org>
Date: Wed, 16 Jul 2014 12:26:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <53C550DF.4090500@axelsw.it>
In-Reply-To: <53C550DF.4090500@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Question about rtdm_mmap_to user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>, xenomai@xenomai.org

On 07/15/2014 06:03 PM, Marco Tessore wrote:
> Good morning,
> I would like to share a buffer between user space task and kernel space 
> realtime driver.
> 
> I used the function rtdm_mmap_to user in the following way:
> 
> In the driver, in the function myDriver_ioctl_rt I have the code:
> 
>         spild->agg_write_frame_buffer allocated with kalloc
> 
>          ret = rtdm_mmap_to_user( user_info,
>                  spild->agg_write_frame_buffer,
>                  agg_fun_local.data_size,
>                  PROT_READ|PROT_WRITE ,
>                  &tmpPtr,
>                  NULL,
>                  NULL
>          );
>          agg_fun_local.data_buffer = (uint8_t *) tmpPtr;
> 
>          rtdm_printk("mmap = %X\n", (unsigned) 
> agg_fun_local.data_buffer); // print the returned address
> 
>          if (ret)
>          {
>              rtdm_printk("mmap error1\n");
> 
>              kfree(spild->agg_write_frame_buffer);
>              return ret;
>          }
> 
>          // check data
>          spild->agg_write_frame_buffer[0] = 0xBE;
>          spild->agg_write_frame_buffer[1] = 0xEF;
> 
>          // then returned the agg_fun_local structure to userspace
> 
> In the user space process I have the following code:
>      ret = rt_dev_ioctl( device, IOCTL_MYDRIVER, &agg_fun );
>      if (ret)
>      {
>          printf("PREP_AGG_WRITE failed, ret = %X", (int) ret);
>      }
> 
>      printf("USER = Address = %X\n", (unsigned) agg_fun.data_buffer);
>      printf("USER check %X%X\n", pAggFun->data_buffer[0], 
> agg_fun.data_buffer[1]);
> 
> I have verified that the address in userspace is the same of the one 
> returned by the rtdm_mmap_to_user.
> The problem is that in the process I cannot see the check data written 
> in the driver.
> 
> Is there something wrong in my code?
> Are there some constraints tha I haven't took into account?

On which platform do you do this? If on ARM with a VIVT cache, you have
to flush the cache after writing one side for the other side to see the
change, or map the region with writecombine.

-- 
                                                                Gilles.


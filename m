Message-ID: <4B0670FC.4080907@domain.hid>
Date: Fri, 20 Nov 2009 11:35:40 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48FD1044@domain.hid>	<4AF99CAD.9070105@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD107D@troe2k1.cs.myharris.net>	<4AF9AD44.10000@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD1085@domain.hid>	<4AF9B6F2.9040206@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD10A9@domain.hid>	<4AF9D976.4020701@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F48FD1129@domain.hid>	<4AFAC4E1.1090109@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48FD17F8@domain.hid>
	<4B0423EF.9030307@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F48FD187B@troe2k1.cs.myharris.net>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F48FD187B@troe2k1.cs.myharris.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm_iomap_to_user with phys addr > 4G
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Please make sure to always preserve CCs.

Herrera-Bendezu, Luis wrote:
>> -----Original Message-----
>> From: Jan Kiszka [mailto:jan.kiszka@domain.hid] 
>> Sent: Wednesday, November 18, 2009 11:42 AM
>> To: Herrera-Bendezu, Luis
>> Cc: xenomai@xenomai.org
>> Subject: Re: rtdm_iomap_to_user with phys addr > 4G
>>
>>
>> Herrera-Bendezu, Luis wrote:
>>> Jan,
>>>
>>>> I think we can change rtdm_iomap_to_user to take src_addr as 
>>>> phys_addr_t
>>>> and propagate this internally properly. We also need to add 
>> a wrapper
>>>> for phys_addr_t for kernels that doesn't support this 
>> (<2.6.28). To my
>>>> current understanding, this should be sufficient, right?
>>>>
>>> This is a diff against Xenomai version 2.4.8 and Linux 
>> version 2.6.28 to
>>> handle RTDM mapping to user space of devices located at addresses > 4
>>> GB.
>> Does it apply against git-head as well? Note that this won't make it
>> into stable 2.4.
>>
> Yes, included bellow.
> 
>>> Rather than modifying existing rtdm_iomap_to_user() API a new one is
>>> added, rtdm_iomap_to_user64() (to mimic mmap64()). Since 
>> this is a user
>>> API it can not use phys_addr_t so unsigned long long is used for the
>>> interface.
>> 64 bit is not related to phys_addr_t. It /may/ be 64 bit, but it may
>> also be less (or more one day...?). So let's switch the existing
>> interface, just like the kernel does.
>>
>> And it is not a user API; it is used between the driver and RTDM only.
>> How the driver deals with this in its user interface is a different
>> story. I think there is currently no publicly available driver 
>> that maps
>> I/O space into a user application, thus there is probably no 
>> stable RTDM
>> profile that uses unsigned long to specify a physical address.
>>
> I was mislead by the function description on both accounts (only to
> be used by drivers and should be called from user application via
> driver, open, ioctl):
> Environments:
> 
> This service can be called from:
> 
>     * Kernel module initialization/cleanup code
>     * User-space task (non-RT)

Yeah, this can be confusing on first sight. It describes on behalf of
which calling context an RTDM driver can execute a service.

> 
>>> I tried to use rtdm_iomap_to_user() on a kernel module initialization
>>> section of my RTDM driver and passing NULL to user_info 
>> argument. This
>>> causes an invalid memory access and system panic. How can this
>>> function be called from kernel intialization code?
>> Not at all. It is supposed to be called on behalf of a user 
>> application,
>> asking the driver to map some area into its address space. 
>> Then you have
>> a valid user_info at hand.
>>
>> Jan
>>
>> -- 
>> Siemens AG, Corporate Technology, CT T DE IT 1
>> Corporate Competence Center Embedded Linux
>>
> 
> 
> diff --git a/include/asm-generic/system.h b/include/asm-generic/system.h
> index 020e763..f2a9424 100644
> --- a/include/asm-generic/system.h
> +++ b/include/asm-generic/system.h
> @@ -417,7 +417,7 @@ static inline int xnarch_remap_vm_page(struct
> vm_area_struct *vma,
>  static inline int xnarch_remap_io_page_range(struct file *filp,
>  					     struct vm_area_struct *vma,
>  					     unsigned long from,
> -					     unsigned long to,
> +					     phys_addr_t to,
>  					     unsigned long size,
>  					     pgprot_t prot)
>  {
> diff --git a/include/asm-generic/wrappers.h
> b/include/asm-generic/wrappers.h
> index 943ed34..5dfef95 100644
> --- a/include/asm-generic/wrappers.h
> +++ b/include/asm-generic/wrappers.h
> @@ -400,4 +400,9 @@ static inline int wrap_raise_cap(int cap)
>  }
>  #endif /* LINUX_VERSION_CODE >= 2.6.29 */
>  
> +/* for Linux versions < 2.6.28 */
> +#ifndef CONFIG_PHYS_ADDR_T_64BIT
> +typedef unsigned long phys_addr_t;
> +#endif

Let's make this cleanly depend on the kernel version, not some other
define which may or may not be defined independent of this type.

> +
>  #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
> diff --git a/include/rtdm/rtdm_driver.h b/include/rtdm/rtdm_driver.h
> index 3026aff..0340de8 100644
> --- a/include/rtdm/rtdm_driver.h
> +++ b/include/rtdm/rtdm_driver.h
> @@ -1168,7 +1168,7 @@ int rtdm_mmap_to_user(rtdm_user_info_t *user_info,
>  		      struct vm_operations_struct *vm_ops,
>  		      void *vm_private_data);
>  int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
> -		       unsigned long src_addr, size_t len,
> +		       phys_addr_t src_addr, size_t len,
>  		       int prot, void **pptr,
>  		       struct vm_operations_struct *vm_ops,
>  		       void *vm_private_data);
> diff --git a/ksrc/skins/rtdm/drvlib.c b/ksrc/skins/rtdm/drvlib.c
> index 65c630f..525fe09 100644
> --- a/ksrc/skins/rtdm/drvlib.c
> +++ b/ksrc/skins/rtdm/drvlib.c
> @@ -1765,7 +1765,7 @@ void rtdm_nrtsig_pend(rtdm_nrtsig_t *nrt_sig);
>  #if defined(CONFIG_XENO_OPT_PERVASIVE) || defined(DOXYGEN_CPP)
>  struct rtdm_mmap_data {
>  	void *src_vaddr;
> -	unsigned long src_paddr;
> +	phys_addr_t src_paddr;
>  	struct vm_operations_struct *vm_ops;
>  	void *vm_private_data;
>  };
> @@ -1773,14 +1773,15 @@ struct rtdm_mmap_data {
>  static int rtdm_mmap_buffer(struct file *filp, struct vm_area_struct
> *vma)
>  {
>  	struct rtdm_mmap_data *mmap_data = filp->private_data;
> -	unsigned long vaddr, paddr, maddr, size;
> +	unsigned long vaddr, maddr, size;
> +	phys_addr_t paddr;
>  	int ret;
>  
>  	vma->vm_ops = mmap_data->vm_ops;
>  	vma->vm_private_data = mmap_data->vm_private_data;
>  
>  	vaddr = (unsigned long)mmap_data->src_vaddr;
> -	paddr = (unsigned long)mmap_data->src_paddr;
> +	paddr = (phys_addr_t)mmap_data->src_paddr;

A good chance to drop this typecast-nop (paddr and src_paddr are already
of the same type).

>  	if (!paddr)
>  		/* kmalloc memory */
>  		paddr = virt_to_phys((void *)vaddr);
> @@ -1982,7 +1983,7 @@ EXPORT_SYMBOL(rtdm_mmap_to_user);
>   * Rescheduling: possible.
>   */
>  int rtdm_iomap_to_user(rtdm_user_info_t *user_info,
> -		       unsigned long src_addr, size_t len,
> +		       phys_addr_t src_addr, size_t len,
>  		       int prot, void **pptr,
>  		       struct vm_operations_struct *vm_ops,
>  		       void *vm_private_data)
> 
> Luis

Except for the minor remarks, I'm fine with the patch. Please repost in
a proper format: patch subject, a short description, a signed-off, and
then the diff.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux


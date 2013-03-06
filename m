Message-ID: <5137AA3D.7020907@xenomai.org>
Date: Wed, 06 Mar 2013 21:42:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>	<5130B39C.70300@hilscher.com>	<513465CF.4030807@hilscher.com>	<51350D5B.6060309@xenomai.org>	<5135CCDE.5090401@hilscher.com>	<5135D667.8060309@siemens.com>	<51361281.20307@hilscher.com>
	<51364A61.3090002@xenomai.org>	<5136F9E9.9030604@hilscher.com>
	<5136FC1E.6060608@xenomai.org>	<51371B89.4020103@hilscher.com>
	<513730CE.2070102@xenomai.org> <51374B98.7030103@hilscher.com>
In-Reply-To: <51374B98.7030103@hilscher.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/06/2013 02:58 PM, Jerome Poncin wrote:

> Gilles,
> 
> I don't know, perhaps I missed some remarks, it's possible (by error or 
> by misunderstanding) .


Again, that is because you seem to be used to top-posting, which is the opposite way this mailing list (and many others) work.

> +static ssize_t cifx_pci_write(struct rtdm_dev_context *context,
> +			      rtdm_user_info_t *user_info, const void *buf,
> +			      size_t nbyte)
> +{
> +	struct io_map_mem map_mem;
> +	int ret;
> +
> +	switch (nbyte) {
> +	case sizeof(map_mem):
> +		/* Copy data information for Kernel */
> +		if (rtdm_safe_copy_from_user(user_info, &map_mem, buf, nbyte))
> +			return 0;
> +
> +		if (*map_mem.virt_addr == NULL) {
> +			/* Map physical on virtual memory */
> +			ret = rtdm_iomap_to_user(user_info,
> +						map_mem.
> +						phys_addr,
> +						map_mem.length,
> +						(PROT_READ | PROT_WRITE),
> +						map_mem.virt_addr,
> +						NULL,
> +						NULL);
> +
> +			if (ret != 0)
> +				return 0;
> +		} else {
> +			/* Unap virtual memory */
> +			ret = rtdm_munmap(user_info,
> +					*map_mem.virt_addr,
> +					map_mem.length);
> +
> +			if (ret != 0)
> +				return 0;
> +		}
> +		break;
> +
> +	default:
> +		/* Error */
> +		return 0;
> +	}
> +
> +	return nbyte;


Again, left alone the fact that this function should not be a "write" 
method, this should be:

if (nbyte != sizeof(mmap_mem))
	return -EINVAL;

if (rtdm_safe_copy_from_user(user_info, &map_mem, buf, nbyte))
	return -EFAULT;

if (*map_mem.virt_addr)
	return rtdm_munmap(user_info, *map_mem.virt_addr, map_mem.length);

return rtdm_iomap_to_user(user_info, map_mem.phys_addr, map_mem.length,
			(PROT_READ | PROT_WRITE), map_mem.virt_addr, NULL, NULL);


And I am wondering, if this is even correct: if map_mem.virt_addr is a 
user-space address, it is forbidden to dereference it directly in 
kernel-space, we should use another copy_from/to_user, even if it appears
to work on some (most in fact) architectures. It is probably better to 
put the virtual address directly in the map_mem structure instead of
a pointer requiring more contorsions.

-- 
                                                                Gilles.


Message-ID: <4F775BD0.4070109@domain.hid>
Date: Sat, 31 Mar 2012 21:32:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F749006.8060804@domain.hid>
In-Reply-To: <4F749006.8060804@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [PATCH 1/2] ipipe: Factor out ipipe_pin_vma
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On 03/29/2012 06:38 PM, Jan Kiszka wrote:
>  	for (vma = mm->mmap; vma; vma = vma->vm_next) {
> -		if (!is_cow_mapping(vma->vm_flags)
> -		    || !(vma->vm_flags & VM_WRITE))
> -			continue;

I prefer this style.

> (...)
> +		if (is_cow_mapping(vma->vm_flags) &&
> +		    (vma->vm_flags & VM_WRITE)) {
> +			result = __ipipe_pin_vma(mm, vma);
> +			if (result < 0)
>  				goto done_mm;

Than this one, which uselessly cause indentation and scopes nesting.

-- 
                                                                Gilles.


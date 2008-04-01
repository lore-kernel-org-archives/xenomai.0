Message-ID: <2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>
Date: Tue, 1 Apr 2008 17:58:15 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F258AD.3000103@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47ED5DE3.60202@domain.hid>
	<18415.63399.305120.344817@domain.hid>
	<47F062DE.5000709@domain.hid>
	<18417.18371.183857.809430@domain.hid>
	<18417.18921.588809.645062@domain.hid>
	<47F17B32.7070505@domain.hid>
	<18417.52630.8850.939898@domain.hid>
	<47F23E9E.7060801@domain.hid>
	<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>
	<47F258AD.3000103@domain.hid>
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, Apr 1, 2008 at 5:45 PM, Tomas Kalibera <kalibera@domain.hid> wrote:
>
>  The stack trace starts getting printed even before the kernel boots - the
> first occurrence is below. It then repeats printing so frequently that the
> system is unusable (and I could not run the Xenomai task).
>
>  I've attached the highmem_32.c I used.

Ok. You can get rid of old patches. What happens if you make the
printk, stack trace and fix up, conditional to type == KM_PTE0 || type
== KM_PTE1 ? As in:

if (type == KM_PTE0 || type == KM_PTE1) {
			printk("Wrong address passed to kunmap_atomic!\n");
			show_stack(NULL, NULL);
			kpte_clear_flush(kmap_pte-idx, __fix_to_virt(FIX_KMAP_BEGIN+idx));
		}

-- 
 Gilles


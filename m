Subject: Re: tested cpu/hardware for ipipe-x86-4.19.y-cip
References: <BN6PR11MB1620092660A6607B68195DE5EEB10@BN6PR11MB1620.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ad54c435-1333-944f-c102-1bf0530fc5cb@siemens.com>
Date: Wed, 27 May 2020 16:00:10 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR11MB1620092660A6607B68195DE5EEB10@BN6PR11MB1620.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>, xenomai <xenomai@xenomai.org>
Cc: "Pirou, Florent" <florent.pirou@intel.com>

On 27.05.20 14:07, Meng, Fino via Xenomai wrote:
> hi Jan&Quirin:
> 
> with the x86-64_defconfig in  gitlab.denx.de/Xenomai/xenomai-images, 
> the built image cannot boot on our test device (CPU is WHL8665U)
> after changed to another defconfig, finally we make it boot OK.

If you have both pieces (configs), I supposed you can figure out which
switches we might be missing. Is there no output at all on the UART?

> To print boot msg we add kernel cmdline: console=tty1 console=ttyS0, 115200n8 
> So I am curious on which cpu that you are testing ipipe-x86-4.19.y-cip? 

Currently on a Celeron E3845 ET and some other Atom which I do not know
by heart. I think we had the image running against an i5 as well. Of
course, there can always be some switch missing, and we would be glad to
extend the range to make the image bootable on more devices.

> Why console is missing in the kernel cmdline? 

It's shouldn't:
https://gitlab.denx.de/Xenomai/xenomai-images/-/blob/master/wic/x86-64-efi.wks

Or are you referring to a screen console (ttyN)? We operate headless in
the testlab.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


Subject: Re: patchset update for Xenomai/IPIPE's kernel 5.4 porting
References: <MWHPR11MB19189E6207803066525EEBA2EE230@MWHPR11MB1918.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ede09276-e50f-21b9-44b0-7c707c4edd8b@siemens.com>
Date: Mon, 14 Sep 2020 17:51:01 +0200
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB19189E6207803066525EEBA2EE230@MWHPR11MB1918.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>
Cc: "Zhang, Wei E" <wei.e.zhang@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>

On 14.09.20 17:40, Meng, Fino via Xenomai wrote:
> Hi all,
> 
> A updated patchset was updated to this branch:
> https://github.com/intel/linux-stable-xenomai/tree/review/5.4.59/stable/ipipe/xenomai-3.1
> this version is more clean than previous, only one more patch for IPIPE part,
> and one more patch for Xenomai 3.1 part.
> 
> ....
> 0150-x86-ipipe-Harden-__speculation_ctrl_update-for-share.patch
> 0151-x86-ipipe-Let-HAVE_ARCH_JUMP_LABEL-depend-on-IPIPE.patch
> 0152-drm-i915-gt-rename-setup_irq-to-avoid-compile-confli.patch
> 0153-xenomai-patch-xenomai-3.1-directly.patch
> 0154-WIP-xenomai-fix-xenomai-kernel-part-for-kernel-5.4.y.patch

Please make this one ready for upstream, possibly breaking it up into 
logical chunks. Will help to keep your queue cleanly focused on I-pipe.

BTW, commenting out fpu__initialize() is likely problematic. Better make 
that function available again with the I-pipe patch.

> 0155-test-kernel-config-for-xenomai.patch
> 
> On my test device, boot OK and Xenomai's latency can run, other smokey test may fail.
> 

Does the switchtest explode? That's the first one to expose FPU issues, 
see above.

> A quick guide:
> 
>      usage:
>      $cp kernel_config_xenomai .config
>      $make olddefconfig
>      $make bindeb-pkg -j16 2>&1 | tee build.log
>      if build ok, install it over a Debian or Ubuntu on test board,
>      #dpkg -i  linux-image-*.deb
>      #reboot
> 
>      to clean up:
>      $make distclean
> 
>      bug:
>      out of tree build will fail for kernel 5.4, need fix.
> 
> BR / Fino (孟祥夫)
> Intel – IOTG Developer Enabling
> 

In any case: great progress!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


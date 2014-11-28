Date: Fri, 28 Nov 2014 19:21:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141128182141.GB4817@hermes>
References: <CAPozGf=zAFgV=fbinambu1_xEiR3qD7Affppw-i6ZbD4nvJsRw@mail.gmail.com>
 <20141128111325.GD5069@hermes>
 <CAPozGf=6OQBChvSAfypNH7KpAReg+u6PS3dhEJDtVZ-jrnW7bg@mail.gmail.com>
 <CAPozGfkxmv+7=Q3LXAmOv_eTPZ08XV3SO9SETPomSAs+bbxV0A@mail.gmail.com>
 <CAPozGfk9LizYFbCRKUDS1-mhX+bw3fOpgqzwF6AcH64Pspw4Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPozGfk9LizYFbCRKUDS1-mhX+bw3fOpgqzwF6AcH64Pspw4Gg@mail.gmail.com>
Subject: Re: [Xenomai] Section mismatch - Porting Xenomai to
 linux-xlnx-V14.5 zynq SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Sini <jhnsini@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Nov 28, 2014 at 07:19:14PM +0100, John Sini wrote:
> Hi,
> 
> I have added __init attribute in the ipipe-core-3.8-arm-1.patch and applied
> patches and now I have no more warning you mentioned. I got rid of the
> warning which was not related to Xenomai. The only warning that I am
> getting now is this one:$
> 
> WARNING: vmlinux.o(.cpuinit.text+0xdc4): Section mismatch in reference from
> the function gt_setup.part.2.constprop.4() to the function
> .init.text:__ipipe_tsc_register()
> The function __cpuinit gt_setup.part.2.constprop.4() references
> a function __init __ipipe_tsc_register().
> If __ipipe_tsc_register is only used by gt_setup.part.2.constprop.4 then
> annotate __ipipe_tsc_register with a matching annotation.

Well, guess what you have to do to fix the warning?

> WARNING: at
> /home/john/project/components/linux-kernel/linux-xlnx-xenomai/kernel/lockdep.c:3158

lockdep is currently broken with Xenomai on ARM, disable lockdep.

-- 
					    Gilles.


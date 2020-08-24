Subject: Re: initial porting of IPIPE x86_64 patches onto Linux stable 5.4.52
References: <MWHPR11MB1918BC3591D43C7A139375A0EE560@MWHPR11MB1918.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <38d73dec-3163-cfbc-609e-60b9d65d6246@siemens.com>
Date: Mon, 24 Aug 2020 08:09:39 +0200
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1918BC3591D43C7A139375A0EE560@MWHPR11MB1918.namprd11.prod.outlook.com>
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
To: "Meng, Fino" <fino.meng@intel.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Greg Gallagher <greg@embeddedgreg.com>, Steven Seeger <steven.seeger@flightsystems.net>
Cc: "Wang, Rick Y" <rick.y.wang@intel.com>, "Pirou, Florent" <florent.pirou@intel.com>, "Hu, Mingliang" <mingliang.hu@intel.com>, Henning Schild <henning.schild@siemens.com>

On 24.08.20 02:48, Meng, Fino wrote:
> Dear all, 
> 
> We ported IPIPE patch from 4.19.89-x86-9 to Linux stable 5.4.52,  temporarily uploaded to github for review: 
> 
> https://github.com/intel/linux-stable-xenomai/tree/review/5.4.52/stable/ipipe/xenomai-3.1
> 
> pls help to review and check mistakes.  I didn't build it yet, due to I am not confidence on make a perfect kernel config
> 
> plan of this week:
>   Make a good kernel config, build, fix bugs and patch format.
>   Check and pick some CIP branch' patches.
> 

Thanks a lot for your effort already!

> @Jan,  I didn't fully catch about the ARCH/NON ARCH separation discussed on last meeting,
> What I should do about it? 

All non-x86 I-pipe commit should be at the beginning of the queue so
that I can split them off into ipipe-noarch. On first glance, this
already seems to be the case.

Greg, with this baseline available, porting ARM/ARM64 to 5.4 should
become possible. Thought I would wait until we have basic confidence on
x86 into the generic pieces. Steven, same for powerpc.

For 5.<next-lts> (5.10 likely), the plan remains going for dovetail.
However, that may requires a xenomai-3.2, thus this can give us some
time for the existing 3.1 series, and also for converting to 64-bit time_t.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


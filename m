Subject: Re: Does perf working for Xenomai?
References: <CO1PR11MB5187796E7817657FD67BE5D2EE999@CO1PR11MB5187.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <09363e5e-5ed3-8e37-d45b-27331b8ae3da@siemens.com>
Date: Tue, 2 Mar 2021 15:37:28 +0100
MIME-Version: 1.0
In-Reply-To: <CO1PR11MB5187796E7817657FD67BE5D2EE999@CO1PR11MB5187.namprd11.prod.outlook.com>
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
To: "Meng, Fino" <fino.meng@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02.03.21 14:30, Meng, Fino via Xenomai wrote:
> I did some search but didn't find any detailed paper about use perf with Xenomai, 
> Assume on x86_64, in theory, does perf can work on Xenomai out-of-box, 
> or need adapt for IPIPE and Cobalt scheduler? 
> 

Not generally. E.g., we cannot do stack backtracing into userspace
because of [1] (old kernel, but this is what I had at hand), possibly
more. It should be solvable, and possibly it is solved already for
dovetail, didn't check yet.

Jan

[1]
https://source.denx.de/Xenomai/ipipe/-/blob/ipipe-4.4.y/arch/x86/lib/usercopy.c#L22

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


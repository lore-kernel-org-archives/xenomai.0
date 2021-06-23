Subject: Re: about issue #14 on xenomai-hacker-space
References: <BN9PR11MB5227421B89F9B4FBD590E6E7F2089@BN9PR11MB5227.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5a964733-0e24-2135-c61c-5f066c0ff2d3@siemens.com>
Date: Wed, 23 Jun 2021 07:12:53 +0200
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5227421B89F9B4FBD590E6E7F2089@BN9PR11MB5227.namprd11.prod.outlook.com>
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
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 23.06.21 04:54, Chen, Hongzhan wrote:
> Hi Jan
> 
> I do not know if the issue #14 you reported is about  "cpu_affinity skipped (no kernel support)" in log [1].
> The issue "cpu_affinity skipped (no kernel support)" is because there is no non-RT cpu found in system 
> and we may pass xenomai.supported_cpus in commandline to restrict RT cpu to fix it.
> 

Yes, at least for some boards with >2 CPUs, we should make sure that one
CPU is declared "unsupported" so that this path is tested as well.

Thanks,
Jan

> 
> [1]: https://source.denx.de/Xenomai/xenomai-images/-/jobs/281066
> 
> 
> Regards
> 
> Hongzhan Chen
> 


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


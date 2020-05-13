Subject: Re: strategy of isar-debian bsp for x86-64
References: <BN6PR11MB1620D18376AC410EC44ED57DEEBF0@BN6PR11MB1620.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <58ad2c34-0d06-b3f0-4f0f-5ad4739325b3@siemens.com>
Date: Wed, 13 May 2020 18:15:13 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR11MB1620D18376AC410EC44ED57DEEBF0@BN6PR11MB1620.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: "Meng, Fino" <fino.meng@intel.com>, xenomai <xenomai@xenomai.org>, Gylstorff Quirin <quirin.gylstorff@siemens.com>
Cc: "Pirou, Florent" <florent.pirou@intel.com>, "Quast, Johannes" <johannes.quast@intel.com>, "Ouillette, Jeremy" <jeremy.ouillette@intel.com>

Hi Fino,

On 13.05.20 17:56, Meng, Fino wrote:
> Hi Jan & Quirin:
> 
> We have studied ISAR & kas-docker in these 2 weeks and mastered basic knowledges,
> thanks for the example code gitlab.denx.de/Xenomai/xenomai-images;
> 
> then we want to make a production BSP for general x86-64 uefi board,  including Xenomai/preempt-rt/vanilla kernel
> but currently in repo (gitlab.denx.de/Xenomai/xenomai-images), the name of distro & target includes "demo", in kas.yml:
> this may confuse our users.
> 
> So I would to ask for your suggestion for further strategy:
> 1) we work together on gitlab.denx.de/Xenomai/xenomai-images, or maybe other url, add our recipes ;
> 2) we create a folk on github.com/intel/new-name-of-the-bsp;
> how do u think? Thanks~
> 

There is also option 3): You add a layer that reuses xenomai-images 
(includes it), adding only deviations from it on top.

I would not recommend to fork, rather to work on 1) or enhance 
xenomai-images so that 3) is almost trivial. It also depends on what you 
want to customize and how you want to do configuration and release 
management of the result. Adding e.g. non-cobalt kernel configurations 
to allow testing of the mercury setup of Xenomai or comparing RT 
qualities would be of common value.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


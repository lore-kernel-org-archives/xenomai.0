Subject: Re: xenomai on kernel 5.4 update
References: <MWHPR11MB1918B0733FE56F68A11840B5EE2E0@MWHPR11MB1918.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3c0a5889-5ede-997c-13a3-2734badd6b57@siemens.com>
Date: Tue, 1 Sep 2020 12:01:35 +0200
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1918B0733FE56F68A11840B5EE2E0@MWHPR11MB1918.namprd11.prod.outlook.com>
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
To: "Meng, Fino" <fino.meng@intel.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 01.09.20 11:37, Meng, Fino via Xenomai wrote:
> Hi all,
> 
> Today I uploaded a new version that can build and run, 
> 
> https://github.com/intel/linux-stable-xenomai/commits/review/5.4.58/stable/ipipe/xenomai-3.1
> 
> step to build after clone: 
> 
> cp kernel_config_xenomai  .config
> make olddefconfig
> make bindeb-pkg -j16
> 
> if build OK, u can install linux-image_*.deb with Debian 10,
> I tested  Xenomai 3.1's latency on Debian 10, runs good.
> Ubuntu should also work but I didn't test yet.
> Next step is do more test and refine the patches.
> 

That's great news, thanks for the update!

An interesting next test to run is switchtest, BTW... :)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


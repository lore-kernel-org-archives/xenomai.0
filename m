Subject: Re: [PATCH 2/2] drm/i195: control LLC CLOS for gpu via debugfs
 interface
References: <20210221150136.22456-1-fino.meng@linux.intel.com>
 <20210221151227.GA22504@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <260b0b1b-bde5-13d4-3794-51983176f0a3@siemens.com>
Date: Tue, 23 Feb 2021 08:32:50 +0100
MIME-Version: 1.0
In-Reply-To: <20210221151227.GA22504@linux.intel.com>
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
To: Fino Meng <fino.meng@linux.intel.com>
Cc: xenomai@xenomai.org

On 21.02.21 16:12, Fino Meng via Xenomai wrote:
> 
> these 2 patches:
> "drm/i915/pm: support disable SAGV via debugfs interface" and
> "drm/i195: control LLC CLOS for gpu via debugfs interface"
> are for deterministic tuning, tested on x86_64's kernel 5.4 branch.
> 
> if think them OK for merged into IPIPE patches, I will send 4.19 version
> also.
> 

Already commented on patch: I would prefer sorting this out in upstream
first. Once the is a path forward, I'm fine with taking backports from
new versions.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


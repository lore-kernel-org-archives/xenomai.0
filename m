Subject: Re: ipipe-arm64 kernel config questions
References: <47AB2CE9-6B2A-4C41-A82C-E07AA672AAFB@korgrd.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6acf0040-bd82-8d97-70d2-2e52aff5c392@xenomai.org>
Date: Thu, 29 Nov 2018 15:15:04 +0100
MIME-Version: 1.0
In-Reply-To: <47AB2CE9-6B2A-4C41-A82C-E07AA672AAFB@korgrd.com>
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
To: Steve Pavao <stevep@korgrd.com>, xenomai@xenomai.org

On 11/26/18 9:08 PM, Steve Pavao via Xenomai wrote:
> Is there a kernel config snippet available which contains only the real-time specific options of the ipipe-arm64 kernel?  If so, could someone please point me to it?  If not, could someone please make it available?  I need it so I can merge it with the config I use in Yocto to build my customized Linux system.
> 

It really depends on the features you need, but using Cobalt's default
Kconfig settings is a safe bet if you want to enable the real-time core
with no bells and whistles.

A diff between a properly tuned .config for running a vanilla kernel on
your arm64 SoC, and the [make] defconfig output for that kernel with
Xenomai patched in may be what you are looking for.

> Background: Sometimes, I build my customized system to use the raspberrypi/linux kernel; other times I build it to use the ipipe-arm64 kernel.  I need to merge the real-time specific options of the ipipe-arm64 default config into my existing default config for my Yocto build, such that I can have an acceptable minimal default config for ipipe-arm64.  Currently, the two configs are wildly divergent, thus the desire to merge only the minimal config changes needed for ipipe-arm64 real-time benefits.
> 
> If this is possible, I plan to use the Linux utility script merge-configs to achieve this.  If this is not possible, I can provide the output of the diffconfig script, which shows a concise diff of the differences between the two config files.  Given that, maybe someone could analyze that, and inform me as to which of the kernel options that are different or added for ipie-arm64are the ones that truly have an impact on real-time performance.
> 

If this is concise, please post it there.

-- 
Philippe.


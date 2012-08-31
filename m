Message-ID: <50406A3D.4080801@xenomai.org>
Date: Fri, 31 Aug 2012 09:39:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50405C4F.5030301@ebus.com>
In-Reply-To: <50405C4F.5030301@ebus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Upgrading to Xenomai 2.6.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Doug Brunner <dbrunner@ebus.com>
Cc: xenomai@xenomai.org

On 08/31/2012 08:40 AM, Doug Brunner wrote:

> I've been having a very hard time with the upgrade from Xenomai 2.6.0 to 
> 2.6.1--hoping someone might have a suggestion for me. My thinking was 
> that, to get the most possible bug fixes, I should also upgrade to the 
> latest kernel for which there is a stable I-pipe patch, which appears to 
> be 3.2.21 from examining the list of available patches distributed with 
> Xenomai.
> 
> Unfortunately, 3.2.21 (even unmodified, using a vanilla Debian kernel 
> config, set for 586 cpu type) will not boot on my target platform 
> (Winsystems PPM-LX800-G, which has a Geode LX800 CPU). It immediately 
> resets after "Loading initial ramdisk", without even any early printk 
> output. I have no idea what could be causing that :(


Ok. I have just booted my geode with 3.4, both with 586 cpu type without
tsc and with geode cpu type with tsc. The kernel boots and the latency
test starts. So, I guess you selected a kernel configuration option we
do not support (such as CONFIG_KGDB).

You can download the configuration which works for me here:
http://xenomai.org/~gch/config-geode

-- 
                                                                Gilles.


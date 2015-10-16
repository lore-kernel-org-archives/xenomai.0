Date: Fri, 16 Oct 2015 13:17:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151016111756.GI16010@hermes.click-hack.org>
References: <5620DBC8.4080508@ixion.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5620DBC8.4080508@ixion.es>
Subject: Re: [Xenomai] Problem with Xenomai 3.0 Cobalt executing latency app
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alvaro <aramos@ixion.es>
Cc: xenomai@xenomai.org

On Fri, Oct 16, 2015 at 01:13:12PM +0200, Alvaro wrote:
> Good morning,
> I 'm trying Xenomai 3.0 Kernel. I have compiled and encapsulated a 
> preempt_rt_kernel from 
> https://pixhawk.org/dev/ros/px4linux#rt_preempt_kernel that contains a 
> Xenomai 3.0 with cobalt configuration on a Odroid C1 board. Afterwards, 
> I downloaded the xenomai 3-3.0 files from your repository

Hi,

"your repository" is a bit vague here. Which repository?

> to install the 
> libraries and the tools. I have compiled the libraries for Cobalt mode 
> (./configure --with-core=cobalt --enable-smp --enable-pshared). When I 
> execute latency application the system responses as: low init():binding 
> failed: function not implemented. If I compile for Mercury mode when I 
> execute the application latency I get: WARNING: [main] failed to lock 
> memory .

The most common reason for failing to lock memory is because you are
not running the application with root privileges. See:
http://xenomai.org/2014/06/running-a-xenomai-application-as-a-regular-user/

Regards.

-- 
					    Gilles.
https://click-hack.org


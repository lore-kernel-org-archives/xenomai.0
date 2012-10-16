Message-ID: <507D1EB8.3000406@xenomai.org>
Date: Tue, 16 Oct 2012 10:45:44 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.94.1350341580.29827.xenomai@xenomai.org>
	<1350374085.35200.YahooMailNeo@web164604.mail.gq1.yahoo.com>
In-Reply-To: <1350374085.35200.YahooMailNeo@web164604.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Beagleboard-XM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ahmet Tekelioglu <vtam370@yahoo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/16/2012 09:54 AM, Ahmet Tekelioglu wrote:
> Hello,
> 
> I am new. Is there a a step-by-step guide for installing Xenomai on BeagleBoard-XM? 
> 
> I have gcc toolchain but can install the Sourcery toolchain if necessary. 

There is nothing special about the BeagleBoard-XM, the generic
installation instructions apply, you have them in xenomai sources, it is
the README.INSTALL file, or can find them on the web:

http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/

What you may want to find is how to run a custom kernel on your beagle,
depending on what environment you use (debian, openembedded, etc...).

Also note that xenomai 2.6.1 does not support thumb kernels or thumb
user-space, so, if you are compiling with a toolchain which compiles for
thumb by default (like, it seems, linaro cross toolchain), please add
-mthumb to the cflags when compiling xenomai user-space. Also pay
attention not to enable CONFIG_THUMB2_KERNEL when compiling the kernel.

Regards.

-- 
					    Gilles.


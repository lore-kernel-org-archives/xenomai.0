Message-ID: <5213BA7F.9050708@xenomai.org>
Date: Tue, 20 Aug 2013 20:50:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <521364EF.8050006@siemens.com>
In-Reply-To: <521364EF.8050006@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno-regression-test returns SUCCESS when Xenomai not
 available
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gernot Hillier <gernot.hillier@siemens.com>
Cc: xenomai@xenomai.org

On 08/20/2013 02:45 PM, Gernot Hillier wrote:
> Hi there!
> 
> I'm currently working on an automatic test environment for Xenomai
> kernels. Sometimes, Xenomai integration into my kernel fails completely 
> and I expected this to be detected in a xeno-regression-test run - however:

You might want to use:
http://git.xenomai.org/?p=mkrootfs.git;a=summary

Which verifies at compilation time that the kernel has Xenomai enabled
if the Xenomai user-space package is enabled. I use this tool to build
rootfses for Xenomai system on ARM and x86 systems and I believe
Philippe uses it also. It is not as feature-rich or package-rich as
alternatives such as buildroot, ptxdist, openembedded, but it has some
unique features which are more adapted to a (Xenomai ?) developer usage.

-- 
                                                                Gilles.


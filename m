Message-ID: <513F83B2.1030903@xenomai.org>
Date: Tue, 12 Mar 2013 20:36:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <513F5C23.2090603@yahoo.com> <513F7196.2070305@antcom.de>
In-Reply-To: <513F7196.2070305@antcom.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] problems while patching Debian kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Stigge <stigge@antcom.de>
Cc: xenomai@xenomai.org

On 03/12/2013 07:19 PM, Roland Stigge wrote:

> Hi,
> 
> thanks for using Xenomai and Debian!
> 
> On 03/12/2013 05:47 PM, Tom Z wrote:
>> Does that mean "2.6.32 48squeeze1" is not supported by this patch?
> 
> Strictly speaking, yes.
> 
>> what caused the above problems?
> 
> When Debian was released (or when Xenomai in Debian was updated the last
> time), the patch was made to apply to Debian's kernel back then.
> Meanwhile, the kernel (sources) changed due to security fixes and other
> important changes.
> 
> So the patch doesn't apply anymore. Until I update the patch in the
> Xenomai package in Debian.
> 
> I'll need to adjust the patch in the Debian stable package and integrate
> into the updates for Debian squeeze.
> 
>> How can I solve them?
> 
> You can either wait until my updated patch is available from the Debian
> mirror network which will be in a few days.
> 
> Remember that Debian stable currently contains Xenomai 2.5.4 (with
> patches), so you might be interested in current "upstream" Xenomai
> 2.6.2.1 from xenomai.org. This one should work fine with Debian since
> newer kernels up to 3.8 are commonly used with Debian. For this option,
> you would take Xenomai directly from xenomai.org (follow the common
> installation instructions there).


Last time I tried, the "kernel-package" package from debian backporst
was needed to build post 3.3 kernels on squeeze. But anyway, as Tom Z
can find in the first answer to its mail there are two downloadable
pre-build packages of Xenomai 2.6.2.1 for Debian squeeze.

-- 
                                                                Gilles.


Message-ID: <516C1000.7000106@nta-inc.net>
Date: Mon, 15 Apr 2013 09:34:40 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <5169643D.9020207@xenomai.org>
In-Reply-To: <5169643D.9020207@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Debian: reworking kernel package generation.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 04/13/2013 08:57 AM, Gilles Chanteperdrix wrote:
> So, I propose to:
> - remove the generation of the linux-patch-xenomai kernel
> - remove the prepare-patch script
> - require people who want to compile xenomai kernels to install the
> xenomai source package and run prepare-kernel.sh script, and change the
> installation instructions in accordance with this new approach.
>
> If nobody is opposed to this approach, I will make the modifications in
> the next few weeks for the 2.6.3 release.

That works for me.  I switched to using prepare-kernel.sh a while back anyway, since that approach seemed to have fewer issues.

-Jeff



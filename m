Message-ID: <51697685.4030509@xenomai.org>
Date: Sat, 13 Apr 2013 17:15:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5169643D.9020207@xenomai.org>
In-Reply-To: <5169643D.9020207@xenomai.org>
Content-Type: text/plain; charset=UTF-8
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
To: Xenomai <xenomai@xenomai.org>

On 04/13/2013 03:57 PM, Gilles Chanteperdrix wrote:

> So, I propose to:
> - remove the generation of the linux-patch-xenomai kernel
> - remove the prepare-patch script
> - require people who want to compile xenomai kernels to install the
> xenomai source package and run prepare-kernel.sh script, and change the
> installation instructions in accordance with this new approach.


- maybe create an ipipe-archive package with many I-pipe patches.


-- 
                                                                Gilles.


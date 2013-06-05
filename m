Message-ID: <51AF1F11.6040107@xenomai.org>
Date: Wed, 05 Jun 2013 13:20:49 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51AF1561.6090401@xenomai.org>
In-Reply-To: <51AF1561.6090401@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [POWERPC] bug alert with
 CONFIG_XENO_HW_UNLOCKED_SWITCH, >= kernel 3.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 06/05/2013 12:39 PM, Philippe Gerum wrote:

> 
> A bad bug has been fixed in the unlocked context switching code for 
> powerpc platforms. This affects all I-pipe patches for 3.4 kernels and 
> above. The typical manifestation of this bug is random segmentation 
> faults in user-space applications (sometimes after hours under stress 
> load), usually the Xenomai-dependent ones.
> 
> A work around not to change the kernel code is to disable 
> CONFIG_XENO_HW_UNLOCKED_SWITCH. Patches for fixing this issue are 
> available for 3.5.7 and above:
> 
> http://git.xenomai.org/?p=ipipe.git;a=commit;h=614aa59453dacf7693fbb18229c27676c2803dbb
> http://git.xenomai.org/?p=ipipe.git;a=commit;h=04ea520ab96a16ec65529a2efed92c9a4a8bda34


Well, with these patches, the whole mm switch now runs with irqs off, is
this the intended effect?

-- 
                                                                Gilles.


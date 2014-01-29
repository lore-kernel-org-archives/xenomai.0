Message-ID: <52E93D72.7070108@xenomai.org>
Date: Wed, 29 Jan 2014 18:42:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52E90C95.702@axelsw.it>
In-Reply-To: <52E90C95.702@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Please,
 can anybody help me to find where is supposed to be the handler
 function for the Xenomai syscall in the kernel tree?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>
Cc: xenomai@xenomai.org

On 01/29/2014 03:13 PM, Marco Tessore wrote:
> Good morning,
> I am a newbie of Xenomai, and I'm trying to patch a modified (non
> vanilla) Linux kernel 3.11.0rc3 for ARM architecture (Freescale iMx28)
> with Xenomai 2.6.3.
> To achieve this goal I have modified, then applied the patch
> ipipe-core-3.8.13-arm-3, but, probably because of my changes, something
> seems to not work properly.
> 
> In particular, when I launch any sample application, I get the following
> error message:
> Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
> (modprobe xeno_native?)

See:
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_xenomai_native_skin_or_config_xeno_opt_pervasive_disabled


-- 
					    Gilles.


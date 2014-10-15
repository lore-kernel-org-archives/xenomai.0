Date: Wed, 15 Oct 2014 20:59:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141015185915.GA30661@sisyphus.hd.free.fr>
References: <543E3D59.4000604@univ-amu.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <543E3D59.4000604@univ-amu.fr>
Subject: Re: [Xenomai] problem when compiling xenomai-2.6.3 and linux-3.14.17
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <Gilles.Chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Oct 15, 2014 at 11:24:41AM +0200, François Touchard wrote:
> Hello,
> when compiling linux-3.14.17 patched with ipipe-core-3.14.17
> x86-4.patch, I get the following error :
> [...]
> CC kernel/xenomai/nucleus/pod.o
> In file included from kernel/xenomai/nucleus/pod.c:48:
> /usr/src/kernels/linux-3.14.17-xeno/arch/x86/include/asm/xenomai/bits/pod.h:
> In function ‘xnarch_switch_to’:
> /usr/src/kernels/linux-3.14.17-xeno/arch/x86/include/asm/xenomai/bits/pod.h:90:
> erreur: ‘struct task_struct’ has no member named ‘fpu_counter’
> make[3]: *** [kernel/xenomai/nucleus/pod.o] Erreur 1
> make[2]: *** [kernel/xenomai/nucleus] Erreur 2
> make[1]: *** [kernel/xenomai] Erreur 2
> make: *** [kernel] Erreur 2
> 
> My machine is an old Dell Optiplex GX520 with a Pentium4 at 3.20 GHz
> I attach my .config file
> Thanks in advance for your help
> Francois Touchard
> 
test test test
-- 
					    Gilles.


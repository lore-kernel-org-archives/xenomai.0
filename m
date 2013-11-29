Date: Fri, 29 Nov 2013 08:45:02 +0100
From: Bukuli Norbert <norbert.bukuli@mediso.hu>
Message-ID: <20131129084502.1031fab3.norbert.bukuli@mediso.hu>
In-Reply-To: <5297A4E3.50807@xenomai.org>
References: <20131128143152.04ac3eab.norbert.bukuli@mediso.hu>
 <5297A4E3.50807@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] test suite programs crash with Illegal instruction on
 MPC5200
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The latency test works well for user task, kernel task and timer IRQ,
too. Does it make a sense to try the patch in this case?

I have done some trivial test with the native and posix skins, by the
time: Create a realtime task with appropriate scheduling policy and
priority, and increase a static integer variable in it.
With the native skin it works well, however, with the posix skin it
crashes with the following message:

pthread_create: 11 Resource temporarily unavailable
Trace/breakpoint trap

Before the creation of the pthread, the stacksize is set to
PTHREAD_STACK_MIN (128 Kib)
Corresponding kernel option:
CONFIG_XENO_OPT_SYS_HEAPSZ = 4096.

This issue probably related to the original one.

On Thu, 28 Nov 2013 21:17:39 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 11/28/2013 02:31 PM, Bukuli Norbert wrote:
> > Hello!
> > 
> > I am having a little problem with some programs from the Xenomai
> > test suite. The clocktest, cyclictest and switchtest crashes with
> > "Illegal instruction":
> 
> What about the latency test? If it fails with the same error, you
> could try the following patch for powerpc SPE:
> 
> https://git.xenomai.org/xenomai-2.6.git/commit/?id=d09932cfd0ca422989b3c3a9d736236d74590ade
> 



-- 
Norbert Bukuli
software engineer
embedded development

Mediso Ltd.
Tel.: +36 1 3993 030 Fax.: +36 1 3993 040
Mailing address: Hungary, H-1047 Budapest, Baross utca 91-95.
Billing address: Hungary, H-1022 Budapest, Alsotorokvesz 14.
norbert.bukuli@mediso.com
www.mediso.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20131129/038c502f/attachment.sig>

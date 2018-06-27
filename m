Date: Wed, 27 Jun 2018 14:54:54 -0400 (EDT)
From: Jeff Melvile <jmelville@mitre.org>
In-Reply-To: <f9fc1bc9-5794-4408-8f85-f7ad3a12a05e@xenomai.org>
Message-ID: <alpine.DEB.2.20.1806271450060.17374@af78237-pc.mitre.org>
References: <f9fc1bc9-5794-4408-8f85-f7ad3a12a05e@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Xenomai] Xenomai 3.0.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Philippe,

Thanks again for all your work on this release.

On Mon, 25 Jun 2018, Philippe Gerum wrote:

> 
> Xenomai 3.0.7 is out [1]. The GIT repository can be cloned from [2].
> 
> Some GPIO driver updates, several bug fixes in the Cobalt core, and a
> critical bug removed from the pshared heap (for users of non-POSIX APIs
> building with --enable-pshared).
> 
> An effort to sanitize some legacy from RTnet causing invalid accesses
> from kernel space to userland memory also stands out, although more work
> remains in this area.
> 
> This release supports up to the Linux 4.14 series for ARM, ARM64 and
> PPC32. Work is still ahead for running Cobalt over 4.14/x86 though.

Is ARM64 a typo? The v3.0.7 tag doesn't have ARM64 directories in 
{kernel,lib}/cobalt/arch

> 
> [1] http://xenomai.org/downloads/xenomai/stable/latest/
> [2] https://git.xenomai.org/xenomai/
> 
> -- 
> Philippe.
> 
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
> 

Thanks,
Jeff


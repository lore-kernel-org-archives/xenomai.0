Date: Wed, 3 Feb 2016 12:35:18 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160203123518.20f0d884@md1em3qc>
In-Reply-To: <20160202192654.GA29937@hermes.click-hack.org>
References: <1453821607-20836-1-git-send-email-henning.schild@siemens.com>
 <1453902069-18824-1-git-send-email-henning.schild@siemens.com>
 <56A9F314.9030808@xenomai.org> <20160128215313.7717dafb@md1em3qc>
 <56AB9D2B.1030905@xenomai.org>
 <20160129183948.GE24550@hermes.click-hack.org>
 <20160202130849.44ee20d5@md1em3qc> <56B0B611.4070505@xenomai.org>
 <20160202173849.1a5e43fc@md1em3qc>
 <20160202192654.GA29937@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH v2] ipipe x86 mm: handle huge pages in memory
 pinning
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Tue, 2 Feb 2016 20:26:54 +0100
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> On Tue, Feb 02, 2016 at 05:38:49PM +0100, Henning Schild wrote:
> > I do not want to keep working on that patch just to hear that it is
> > not required in the next round. Gilles suggested it might not be
> > and you are the one that introduced the pinning.
> > 
> > Maybe a HAVE_ARCH_HUGE_VMAP depends on !IPIPE would also be fine?  
> 
> I did not expect you to use my remark as an excuse for dropping the
> ball. What I meant is that maybe, there is a way to skip the call to
> __ipipe_pin_mapping_globally() entirely in the upper layers, for the
> "huge pages" case. And if there is, this should be preferred over
> patching vmalloc_sync_one, a function not meant to be used for huge
> mappings anyway.

Please do not get me wrong here. I am not about to drop the ball!
Making the two things mutually exclusive is a valid solution with
little complexity. Keeping the patch small might after all be more
important than catering for questionable features with more patching.
Hence the suggestion.

The x86_64 portion of my patch is fine but the 32bit version is indeed
pretty wrong. I just took over what i did for 64bit without thinking ...

Henning


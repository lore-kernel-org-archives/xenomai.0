Date: Wed, 8 Jun 2016 07:38:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160608053823.GB13922@hermes.click-hack.org>
References: <CADBr2WMjHDrGzPYAHqShJkz3ix-bLbkoWbaJMUUvwNv0MNR0VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADBr2WMjHDrGzPYAHqShJkz3ix-bLbkoWbaJMUUvwNv0MNR0VQ@mail.gmail.com>
Subject: Re: [Xenomai] Installing Xenomai step 1 - patching
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ons jallouli <onsjallouli90@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Jun 08, 2016 at 12:36:23AM +0200, ons jallouli wrote:
> Hi all,
> 
> I am a beginner in the Xenomai World  and I want to install Xenomai 3
> 
> I'm trying to patch the Linux kernel as described here:
> https://xenomai.org/installing-xenomai-3-x/
> 
> I get this error :
> prepare-kernel.sh: Unable to patch kernel 3.16.7-ckt27 with
> ipipe-core-3.16.7-x86-3.patch.
> 
> Some one can help me, please ?

This question has been answered many times on the mailing list, you
could have found the answer in the archives.

Anyway, the I-pipe patches are released for the mainline Linux
kernel. The kernel 3.16.7-ckt27 is the Linux kernel fork maintained
by the Canonical kernel team, has differences with the mainline
kernel and thus the patch do not apply to it. As has also been
repeated many times on this mailing list, using the mainline kernel
rather than forks is advised.

-- 
					    Gilles.
https://click-hack.org


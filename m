Date: Thu, 22 Jan 2015 15:56:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150122145624.GF26731@hermes.click-hack.org>
References: <1537147.Wm9AbiuW5D@soho> <2296691.2JpS0rAJbA@soho>
 <20150122114038.GE23461@hermes.click-hack.org>
 <4743020.6q5RsBy8Ia@soho> <54C0F262.6010806@siemens.com>
 <20150122144930.GL30245@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150122144930.GL30245@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Xenomai-3 creating debian packages
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Thu, Jan 22, 2015 at 09:49:30AM -0500, Lennart Sorensen wrote:
> On Thu, Jan 22, 2015 at 01:51:46PM +0100, Jan Kiszka wrote:
> > See
> > http://git.xenomai.org/xenomai-jki.git/commit/?h=for-forge&id=5d104b1de84c8f4cbfb9d6b79cfaa633ef550e1c
> > for the fix. The bug was the improper variable use in the Kconfig
> > fragment. You only had to revert the whole commit as you were falling
> > back to the obsolete prepare-time patching then, which involved the script.
> 
> What a handy change.  That should make multiple architectures in one
> source tree finally possible without merge conflicts in that file.

Unfortunately not, if you want to work with the I-pipe git, you can
not run prepare-kernel.sh in that directory anyway, otherwise you
could end-up commiting the Xenomai fragments with the I-pipe kernel.

-- 
					    Gilles.


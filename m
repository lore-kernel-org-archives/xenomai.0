From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 22 Jan 2015 14:27:57 -0500
Message-ID: <20150122192757.GO30245@csclub.uwaterloo.ca>
References: <1537147.Wm9AbiuW5D@soho> <2296691.2JpS0rAJbA@soho>
 <20150122114038.GE23461@hermes.click-hack.org>
 <4743020.6q5RsBy8Ia@soho> <54C0F262.6010806@siemens.com>
 <20150122144930.GL30245@csclub.uwaterloo.ca>
 <20150122145624.GF26731@hermes.click-hack.org>
 <20150122172142.GM30245@csclub.uwaterloo.ca>
 <20150122191640.GC29604@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150122191640.GC29604@hermes.click-hack.org>
Subject: Re: [Xenomai] Xenomai-3 creating debian packages
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On Thu, Jan 22, 2015 at 08:16:40PM +0100, Gilles Chanteperdrix wrote:
> Then I can tell you, using one I-pipe tree and one Xenomai tree for
> multiple architectures has been possible for years, this is how I
> develop on Xenomai.

Well the patches for arm and patches for powerpc had a merge conflict
when applying the patch in init/Kconfig where both want to add 1 line
for source "arch/<current arch>/xenomai/Kconfig"

Everything else applies great (using the patches generated from the
xenomai tree with one patch for arm, one for powerpc and one for common).

-- 
Len Sorensen


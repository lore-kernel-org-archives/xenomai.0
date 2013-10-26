Message-ID: <526BE170.40303@xenomai.org>
Date: Sat, 26 Oct 2013 17:36:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1VZdtC-0006QX-9h@xenomai.org>
In-Reply-To: <E1VZdtC-0006QX-9h@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : x86: Remove bogus test for
 x86-32 around xsave assembly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 10/25/2013 11:41 AM, git repository hosting wrote:
> Module: xenomai-jki
> Branch: for-upstream
> Commit: a9d60e4c0d60e699e1700b3577eab8d946ef41de
> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=a9d60e4c0d60e699e1700b3577eab8d946ef41de
> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Thu Oct 24 18:22:32 2013 +0100
> 
> x86: Remove bogus test for x86-32 around xsave assembly
> 
> We catch 32 vs. 64 already via XSAVE_PREFIX/SUFFIX. Rather, this
> additional condition breaks x86-32 build for old binutils.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Merged, thanks.

-- 
                                                                Gilles.


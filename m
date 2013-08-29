Message-ID: <521FB189.9020905@xenomai.org>
Date: Thu, 29 Aug 2013 22:39:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <521E3326.2010806@siemens.com> <521E56D9.3010803@xenomai.org>
	<521E6E31.20308@web.de>
In-Reply-To: <521E6E31.20308@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] Enable build against 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 08/28/2013 11:40 PM, Jan Kiszka wrote:
> On 2013-08-28 22:00, Gilles Chanteperdrix wrote:
>> On 08/28/2013 07:28 PM, Jan Kiszka wrote:
>>> The following changes since commit
>>> 60957fb42f76275c2851c5720b65ce60fbd3e75d:
>>> 
>>> posix: Skip auto-shadowing if current thread is already
>>> shadowed (2013-07-29 00:05:05 +0200)
>>> 
>>> are available in the git repository at:
>>> 
>>> git://git.xenomai.org/xenomai-jki.git for-upstream
>>> 
>>> for you to fetch changes up to
>>> d63fd4e8be4d57a9a90481f6cfe5374be91fce8d:
>>> 
>>> analogy: Update procfs usage to latest kernel API (2013-08-21
>>> 17:00:53 +0200)
>> 
>> Merged, thanks, but it breaks the build on powerpc lite 5200 and
>> 2.4 kernels:
>> 
>> http://sisyphus.hd.free.fr/~gilles/bx/
>> 
> 
> Pushed two patches that should address the issues.

Merged, thanks, it now builds.

-- 
                                                                Gilles.


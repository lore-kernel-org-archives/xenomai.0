Message-ID: <50F8CFD1.6070708@xenomai.org>
Date: Fri, 18 Jan 2013 05:30:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50F8C6D6.8070209@zultron.com>
In-Reply-To: <50F8C6D6.8070209@zultron.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] mmap() segfaults
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: John Morris <john@zultron.com>
Cc: xenomai@xenomai.org

On 01/18/2013 04:51 AM, John Morris wrote:

> Hi list,
> 
> The linux 3.5.7/i-ipipe ipipe-gch for-core-3.5.7/xenomai master packages
> haven't been tested much yet, but both el6 and deb packages seem to be
> working great.  Those will be available in the next day or so.
> 
> For the use of others, I prefer the linux 3.5.3/xenomai 2.6.2
> combination, since it has undergone more testing.  There's a problem
> mixing the 3.5.3 kernel with xenomai-2.6.git master.  The mprotect
> regression is failing again, but in a different way.


That is expected, you need a fix in the I-pipe kernel. 2.6.2.1 will be
released using the 3.5.7 kernel, containing the fix for this issue.
3.5.3 is a dead end now.

> Then curiously, some non-xenomai applications that work fine before the
> regression test begin to segfault in mmap() when run after the test; a
> simple example is 'git fetch'.  Nothing funny in dmesg; kernel .config
> and strace linked below.


That is expected.

-- 
                                                                Gilles.


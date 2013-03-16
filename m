Message-ID: <5144D3E9.2050205@xenomai.org>
Date: Sat, 16 Mar 2013 21:19:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] __get_user/__put_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

xenomai asm-generic/syscall.h defines __xn_put_user/__xn_get_user as
aliases for __put_user/__get_user, which implementation, for the ARM
architecture calls might_fault() which triggers an ipipe_root_only() check.

So, the question is, what is the best way of avoiding this issue? Remove
the call to might_fault() when compiling with CONFIG_IPIPE enabled?
Define __ipipe_safe_put_user which avoids the call to might_fault() ?

Thanks in advance.

-- 
                                                                Gilles.


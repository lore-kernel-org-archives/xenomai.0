Message-ID: <530F96D3.4040407@xenomai.org>
Date: Thu, 27 Feb 2014 20:49:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1WJ3I1-00060i-NR@sd-51317.dedibox.fr>
In-Reply-To: <E1WJ3I1-00060i-NR@sd-51317.dedibox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Philippe Gerum : copperplate/registry:
 reap sysregd selectively
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 02/27/2014 04:54 PM, git repository hosting wrote:
>  	memset(&sa, 0, sizeof(sa));
>  	sa.sa_handler = SIG_IGN;
>  	sigaction(SIGCHLD, &sa, NULL);

Why not masking the signal here instead of ignoring it? So that the
notifications which would happen during the short interval are not lost?


-- 
                                                                Gilles.


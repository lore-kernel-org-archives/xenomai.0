Message-ID: <5584142A.9030203@xenomai.org>
Date: Fri, 19 Jun 2015 15:07:54 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1840957946.1843713.1434718942501.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <1840957946.1843713.1434718942501.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] include guard trank/posix/pthread.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Frederik Bayart <frederik_bayart@yahoo.co.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/19/2015 03:02 PM, Frederik Bayart wrote:
> Hallo,
> I noticed that both /usr/xenomai/include/trank/trank.h and  /usr/xenomai/include/trank/posix/pthread.h share the same include guard (_XENOMAI_TRANK_TRANK_H).Can this be an error ? I use compile flags 'xeno-config --skin=native --cflags' and get compile errors. If I change the include guard of pthread.h to _XENOMAI_TRANK_POSIX_PTHREAD_H, the problem seems to be solved.In attachment a diff with my changes.
> Frederik
> 

Yes, the guard is definitely wrong, will fix. Thanks for pointing this out.

-- 
Philippe.


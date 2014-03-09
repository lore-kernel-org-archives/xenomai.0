Message-ID: <531CA891.9020105@xenomai.org>
Date: Sun, 09 Mar 2014 18:44:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKKWdtfhwYwQv+TnEgtH6vQCiN4LAdz+gA9VZk=bc3W1=2k1hA@mail.gmail.com>
In-Reply-To: <CAKKWdtfhwYwQv+TnEgtH6vQCiN4LAdz+gA9VZk=bc3W1=2k1hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question about rt_pipe_read()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 03/09/2014 03:41 PM, ali hagigat wrote:
> examp1 executed and then examp3
> xtask2 remains in W state after examp3 executes and writes 10 bytes to xpipe1.
> Why?

Likely because of the stdio buffering. Try open and write instead of
fopen and fwrite.


-- 
                                                                Gilles.


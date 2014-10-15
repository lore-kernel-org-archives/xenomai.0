Message-ID: <543E581C.3040207@xenomai.org>
Date: Wed, 15 Oct 2014 13:18:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <543e4671.a479420a.486e.ffffd5b3@mx.google.com>
In-Reply-To: <543e4671.a479420a.486e.ffffd5b3@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai Digest, Vol 30, Issue 24
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "crazylinuxcnc@gmail.com" <crazylinuxcnc@gmail.com>, xenomai@xenomai.org

On 10/15/2014 12:03 PM, crazylinuxcnc@gmail.com wrote:
> Please try steps as follow:
> 1. download linux kernel source code
> 2. check out version 3.14.17
> 3.git remote add ipipe git://git.xenomai.org/ipipe.git
> 4. git pull ipipe ipipe-3.14
> 5.$(xenomai source directory)/scripts/prepare-kernel.sh
> 6.start to configure and compile your kernel
> 
> I hope it helps.

Hi,

Do not get me wrong, I am glad to not be the only one to answer
questions on this list. However, when answering mails, please try and
have a little respect for netiquette:
- do not answer digest mails, answer the mail sent by the original
poster, if you prefer to receive digest mails, you can still answer the
original mail by downloading the mailbox here:
http://www.xenomai.org/pipermail/xenomai/
(in the "downloadable version" column)
- do not top post.

As for the contents of your answer, if you had issues with I-pipe
patches that were solved by downloading the I-pipe git, we would
consider this a bug of the way we generate I-pipe patches and would like
you to describe the particular issue you had.

Thanks for your contribution.
Regards.


-- 
                                                                Gilles.


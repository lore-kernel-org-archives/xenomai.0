Message-ID: <536F796F.7070007@xenomai.org>
Date: Sun, 11 May 2014 15:21:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMbo_3DjWPb2xt27WAR6MF6bLHf-QZM-n-VduNTugx34cQ0LPg@mail.gmail.com>
 <536DF390.9000604@xenomai.org> <536E1962.30008@xenomai.org>
 <CAMbo_3Av1qCUpXk1osvwczvu5OtCzyge3wxSgsfbOZcYq786uw@mail.gmail.com>
In-Reply-To: <CAMbo_3Av1qCUpXk1osvwczvu5OtCzyge3wxSgsfbOZcYq786uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on v3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Brian Morel <brianmorel99@gmail.com>, Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 05/11/2014 02:07 AM, Brian Morel wrote:
> I cloned the ipipe.git repository & checked out ipipe-3.14 .  I tried
> running the genpatches.sh script, but it appears that tag v3.14 doesn't
> exist in the repository.  I tried the same process for 3.8 & it worked
> fine.  I assume this is because the stable tree isn't there, but my git foo
> isn't good, so I don't know how to add it.  Any advice would be great.

Note that you can work directly with the ipipe git instead of generating
patches, simply run prepare-kernel.sh from the ipipe git,
prepare-kernel.sh will detect that the kernel already contains the ipipe
bits and will not try and apply an I-pipe patch. This makes testing
changes to the I-pipe kernel a lot easier.


-- 
                                                                Gilles.


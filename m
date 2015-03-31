Message-ID: <551A470C.5060909@xenomai.org>
Date: Tue, 31 Mar 2015 09:04:44 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <7615c5d3d380485499b229435e14ee65@MUC-S-EX13B.advaoptical.com>
 <55195485.9070302@xenomai.org>
 <2b2ffe256e0547af996997c833660a44@MUC-S-EX13B.advaoptical.com>
In-Reply-To: <2b2ffe256e0547af996997c833660a44@MUC-S-EX13B.advaoptical.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using xenomai posix routines instead of Linux POSIX
 routines
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagi Maimon <SMaimon@advaoptical.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/31/2015 08:23 AM, Sagi Maimon wrote:
> Hi, 
> thanks for the help.
> I have read the document, and the use of wrapper makes good sense. 
> According to the document, when calling "pthread_create" (by using the XENO_POSIX_LIBS flags),  it will call  "__wrap_pthread_create" routine.
> But I am using Xenomai 2.6.4 , and there is no implementation of "__wrap_pthread_create" routine, 
> instead there is implementation of "pthread_create" under  kernel/xenomai/skins/posix/thread.c
> 
> Can you please explain it?

Wrappers are implemented in user-space (see src/skins/posix).

-- 
Philippe.


Message-ID: <53F3B4D0.9080908@xenomai.org>
Date: Tue, 19 Aug 2014 22:34:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.1.1408010401.9958.xenomai@xenomai.org>
 <e3bdea6dcdb84852972a720789331cb2@CVEX13.valentin-carl.de>,
 <53EE2CD3.507@xenomai.org>
 <8a9221baf06e4cf8b7ad859fab3af388@CVEX13.valentin-carl.de>
In-Reply-To: <8a9221baf06e4cf8b7ad859fab3af388@CVEX13.valentin-carl.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] access SPI and DMA hardware from application
 ("external abort...")
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Reitinger, Peter" <preitinger@carl-valentin.de>
Cc: Xenomai <xenomai@xenomai.org>

On 08/19/2014 02:13 PM, Reitinger, Peter wrote:
> Hello,
> 
> so I am not up-to-date that it is no longer recommended to do as much
> in user space as possible?

It has never been recommended. Maybe by people developing micro-kernels,
but Linux is not a micro-kernel.

> I see here a relation to the fact that
> interrupt api is going to be removed (or is already removed in 3.0)?

The user-space interrupt API were removed from 3.0 (but replaced by the
UDD framework, see recent commits in the xenomai-forge repository),
because they were a sure way to shoot one-self in the foot. But also
note that the kernel-space API were removed from xenomai-forge, because
moving everything to kernel-space is not recommended either.

> 
> But, it is correct that all kernel-space sources have to be GPL?

Yes, but normally, a driver is dumb (if you read the excellent "Linux
device drivers", I believe the advice is "no policy in kernel-space"),
so there is nothing to hide. Do you really think that an SPI controller
driver is worth hiding?

Please no top-posting, nor private mails (I usually ignore private mails).

-- 
                                                                Gilles.


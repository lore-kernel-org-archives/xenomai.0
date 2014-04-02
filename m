Message-ID: <533C5104.6000002@xenomai.org>
Date: Wed, 02 Apr 2014 20:03:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEbDrgmdy_u5O-1VW+sE6bF4xbM9QaQTtGZh7Ljf8TnDiCpT6w@mail.gmail.com>
 <201404021840.39308.paul_c@tuxcnc.org>
 <CAEbDrgnr9yqa=SoZBjQqR-xRJYDxg1hP4WrKmAgphqv5hW9jfQ@mail.gmail.com>
In-Reply-To: <CAEbDrgnr9yqa=SoZBjQqR-xRJYDxg1hP4WrKmAgphqv5hW9jfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [patch] Raspberry Pi - 3.10.34
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gregory Dymarek <gregd72002@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/02/2014 07:48 PM, Gregory Dymarek wrote:
> Well, have you looked inside it?
> it consists of 3 items:
> 1) local_fiq_enable/disable fix
>     - from previous discussions it was obvious this should be in the
> ipipe-core patch
>     - it is not raspberry pi specific
> 
> 2) clockchips.h fix
>     - a systemic change to linux-kernel breaks this
>     - it is not raspberry pi specific


So, these have to be submitted as patch for the I-pipe kernel git. This
will be included when the next I-pipe patch will be generated.

> 
> 3) PAGE_SIZE vs FIRST_USER_ADDRESS
>    - this looks like a conflict between vanilla kernel and raspberry
> pi kernel that rejects the original ipipe patch
>    - what do you suggest to do?

I have explained you how to generate pre- and post- patches. Please go
back and read again.

http://www.xenomai.org/pipermail/xenomai/2014-March/030441.html

-- 
                                                                Gilles.


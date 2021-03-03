MIME-Version: 1.0
References: <CAFZ-hKg3kxBCEkQD3NsRT+fmo_N25se9+VSeMBDM_MNvX=uC=Q@mail.gmail.com>
 <20210303120206.GA19836@linux.intel.com>
In-Reply-To: <20210303120206.GA19836@linux.intel.com>
From: Leandro Bucci <guestleandro11@gmail.com>
Date: Wed, 3 Mar 2021 13:14:42 +0100
Message-ID: <CAFZ-hKhJoEq4j-+35qSjMPCpFNYKL3GqUkSE0j3iaQZ-4crKrA@mail.gmail.com>
Subject: Re: Linux and Xenomai task
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fino Meng <fino.meng@linux.intel.com>
Cc: xenomai <xenomai@xenomai.org>

thanks for the reply, I mean if I have 4 real time tasks assigned to a
single core and a linux process assigned to another core, the linux process
is not interrupted right?

Il mer 3 mar 2021, 13:03 Fino Meng <fino.meng@linux.intel.com> ha scritto:

> O Wed, Mar 03, 2021 at 11:24:00AM +0100, Leandro Bucci via Xenomai wrote:
> > hello, I would like confirmation to this question.  If I run a Linux
> > process on a certain processor # 0 and on another processor task of
> Xenomai
> > # 1, will the Xenomai tasks never interrupt the execution of the Linux
> task?
>
> by cpu isolation , cpu affinity and irq affinity,
>
> real-time threads are locked to its own core, should not migration,
>
> when u say interrupt, do u mean non-rt Linux task are interrupt by IRQ?
>
> BR fino
>

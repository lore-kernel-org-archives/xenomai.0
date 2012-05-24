Message-ID: <4FBE1E76.7020900@xenomai.org>
Date: Thu, 24 May 2012 13:41:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHzTO8=tcqM4-NbZiZnt9VNAMPSg-swPr-d8pM_e=OV=d_K=Ug@mail.gmail.com>
In-Reply-To: <CAHzTO8=tcqM4-NbZiZnt9VNAMPSg-swPr-d8pM_e=OV=d_K=Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai API
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giampaolo Bellini <iw2lsi@gmail.com>
Cc: Xenomai@xenomai.org

On 05/24/2012 01:14 PM, Giampaolo Bellini wrote:
> Hi all
> 
>   I'm totally new to xenomai... so my question could be stupid :-(
> 
>   I wonder if there are xenomai's counterpart of RTAI's SCB (Shared memory
> Circular Buffer),  MBX (MailBox)

Hi,

I do not know enough RTAI APIs to answer this question. Anyway, from the
sound of it, something equivalent would be shared memory, and message
queues, which both the native and posix skins propose.
You may find some answers, starting from here:
http://www.xenomai.org/documentation/xenomai-2.6/html/api/group__posix.html

You will also find some documentation on xenomai website:
http://www.xenomai.org


> and LXRT (soft-hard real time in user space
> ).

Yes, xenomai has always proposed hard real-time in user-space. And in
fact, writing hard real-time applications in kernel-space is considered
deprecated.


-- 
                                                                Gilles.


Message-ID: <4FBE262C.9080409@xenomai.org>
Date: Thu, 24 May 2012 14:14:36 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAHzTO8=tcqM4-NbZiZnt9VNAMPSg-swPr-d8pM_e=OV=d_K=Ug@mail.gmail.com>
In-Reply-To: <CAHzTO8=tcqM4-NbZiZnt9VNAMPSg-swPr-d8pM_e=OV=d_K=Ug@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
>    I'm totally new to xenomai... so my question could be stupid :-(
>
>    I wonder if there are xenomai's counterpart of RTAI's SCB (Shared memory
> Circular Buffer),

RT_QUEUE for the shared memory property.

   MBX (MailBox)

RT_BUFFER.

  and LXRT (soft-hard real time in user space
> ).
>

As pointed out by Gilles already, this is built in.

>          thanks a lot
>
>                      Giampaolo
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.


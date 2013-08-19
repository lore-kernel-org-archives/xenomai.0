Message-ID: <52123B76.1070600@xenomai.org>
Date: Mon, 19 Aug 2013 17:36:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAGQdp5zSpTPymv=J69LKaKSV0GxY-6TtKYVPVrvrOWG9fOURDw@mail.gmail.com>
In-Reply-To: <CAGQdp5zSpTPymv=J69LKaKSV0GxY-6TtKYVPVrvrOWG9fOURDw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to synchronize a non-realtime Linux thread with a
 Xenomai task?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Robert McCullough <robmccullough13@gmail.com>
Cc: xenomai@xenomai.org

On 08/19/2013 03:06 PM, Robert McCullough wrote:
> Hi,
>
> I tried using a semaphore to synchronize the two, but when I call
> rt_sem_p(...) in the  non-realtime Linux thread* *I
> get the -EPERM error.
>
> Is there a way to synchronize a non-realtime Linux thread with a Xenomai
> task?

You need to make your non-rt thread Xenomai-enabled, so that it may wait 
on Xenomai events. Check rt_task_shadow() from the native API.

>
> Rob McCullough
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>


-- 
Philippe.


Message-ID: <5535202C.6060007@xenomai.org>
Date: Mon, 20 Apr 2015 17:50:04 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAL92PvWNqZ4SF=WToXa_vhYkpn0R5pOdqZGwtsPNgjyx84vmJQ@mail.gmail.com>
In-Reply-To: <CAL92PvWNqZ4SF=WToXa_vhYkpn0R5pOdqZGwtsPNgjyx84vmJQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_sem_p(&semCC_, TM_INFINITE);
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: cristian ramos <cristian0084@gmail.com>, xenomai@xenomai.org

On 04/20/2015 04:51 PM, cristian ramos wrote:
> Hello everyone,
> 
>    I get error -3 when I use int status = rt_sem_p(&semCC_, TM_INFINITE). I
> have seen in the documentation that the possible values are: -EINVAL(-22),
> -EIDRM(43), -EWOULDBLOCK(11), -EINTR(4), -ETIMEDOUT(110), -EPERM(-1),
> somebody know what is meaning -3 values?
> 
> Thank you very much for your time and would appreciate any help.
> 

You receive -ESRCH as semCC_ does not seem to be a valid semaphore
descriptor. The native API in 2.x is confusing in this respect, you
should interpret this as receiving -EINVAL.

PS: please make sure to always mention the Xenomai release you are
working with, when starting a thread.
See http://xenomai.org/asking-for-help/

-- 
Philippe.


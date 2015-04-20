From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <CAL92PvWNqZ4SF=WToXa_vhYkpn0R5pOdqZGwtsPNgjyx84vmJQ@mail.gmail.com>
Date: Mon, 20 Apr 2015 11:20:01 -0400
In-Reply-To: <CAL92PvWNqZ4SF=WToXa_vhYkpn0R5pOdqZGwtsPNgjyx84vmJQ@mail.gmail.com>
 (cristian ramos's message of "Mon, 20 Apr 2015 15:51:57 +0100")
Message-ID: <447ft6hlni.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] rt_sem_p(&semCC_, TM_INFINITE);
Reply-To: xenomai@xenomai.org
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: cristian ramos <cristian0084@gmail.com>
Cc: xenomai@xenomai.org

cristian ramos <cristian0084@gmail.com> writes:

>    I get error -3 when I use int status = rt_sem_p(&semCC_, TM_INFINITE). I
> have seen in the documentation that the possible values are: -EINVAL(-22),
> -EIDRM(43), -EWOULDBLOCK(11), -EINTR(4), -ETIMEDOUT(110), -EPERM(-1),
> somebody know what is meaning -3 values?

#define    ESRCH         3      /* No such process */

You know about strerror(), right?


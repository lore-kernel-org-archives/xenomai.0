From: Giulio Moro <g.moro@qmul.ac.uk>
Subject: Re: "cheap", RT-safe way of detecting if a thread is Xenomai or Linux
Date: Sun, 13 Jan 2019 12:55:00 +0000
Message-ID: <AM0PR07MB557267E7ED71B85AB8C55AE5B5870@AM0PR07MB5572.eurprd07.prod.outlook.com>
References: <AM0PR07MB5572ECC01EEA3054C3B02A59B5870@AM0PR07MB5572.eurprd07.prod.outlook.com>,
 <25b1c9ee-362f-b45f-4615-1f458e04a576@web.de>
In-Reply-To: <25b1c9ee-362f-b45f-4615-1f458e04a576@web.de>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

> What is the use case of this query?

I am trying to write some C++ classes to wrap `pthread_mutex_...` and `pthr=
ead_cond_...` in such a way that the caller does not need to be aware of Xe=
nomai. It would be up to the wrapping class to check whether it is being ca=
lled by a Xenomai thread and whether xenomai has been init'ed before runnin=
g any of:

__wrap_pthread_mutex_init()
__wrap_pthread_cond_init()
__wrap_pthread_mutex_lock()
__wrap_pthread_mutex_unlock()
__wrap_pthread_cond_wait()
__wrap_pthread_cond_signal()

If it detects that Xenomai has not been init'ed, it should do it. If it det=
ects that it is *not* being called by a Xenomai thread, it should turn the =
current thread into a Xenomai thread. If there was a low-cost option to det=
ect if we are on a Xenomai thread, then it could be checked before any such=
 calls. In particular mutex_lock(), mutex_unlock(), cond_signal() are likel=
y to be called from a RT-priority thread to which I would not want to add o=
verhead.

Now that I think of it, I guess an alternative would be:=20
A- if one of the _init() functions returns EPERM, it means Xenomai is not i=
nit'ed and should be init'ed
B- if any of the other functions returns EPERM, then it is not called from =
a Xenomai thread and the current thread should be switched to Xenomai.

Now I tested A and B, and it seems to work, any known pitfalls?

Thanks,
Giulio

________________________________________
From: Jan Kiszka <jan.kiszka@web.de>
Sent: 13 January 2019 03:30
To: Giulio Moro; Xenomai@xenomai.org
Subject: Re: "cheap", RT-safe way of detecting if a thread is Xenomai or Li=
nux

On 13.01.19 10:33, Giulio Moro via Xenomai wrote:
> Hi all,
> is there a "cheap", RT-safe call that can be made in order to find out if=
 the current thread is a Xenomai thread or a Linux thread? Also, to detect =
whether the Xenomai thread is in primary or secondary mode?
>
> It seems that cobalt_thread_mode() gives some (all?) of these details. Is=
 it RT-safe? How much overhead does it incur? Is it the recommended way?

What is the use case of this query? Debugging purposes? We expose APIs for =
the
latter (e.g. cobalt_assert_nrt(), typically only called by internal wrapper=
s)
but we are intentionally not proposing them for production purposes.

Jan


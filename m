Subject: Re: cobalt lib does not have pthread_mutexattr_settype
References: <BB5C4F5E3633C64999D0577F81995AE70287F476@XMAIL.tecom.nnov.ru>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <7c4c5975-a489-55a4-7e77-f5fcc885b605@web.de>
Date: Thu, 16 May 2019 15:05:53 +0200
MIME-Version: 1.0
In-Reply-To: <BB5C4F5E3633C64999D0577F81995AE70287F476@XMAIL.tecom.nnov.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexander Sharabanov <sharabanov.a@tecomgroup.ru>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 16.05.19 14:16, Alexander Sharabanov via Xenomai wrote:
> Hi All,
>
> I have upgraded the Xenomai in userspace from 2.x.x to 3.x.x. I use libc=
obalt, but it does not have 3 references:
> wrap_pthread_mutexattr_settype
> wrap_pthread_mutexattr_init
> wrap_shm_open.
>

Xenomai 2 and 3 are not ABI-compatible. You need to relink your applicatio=
n so
that the no longer needed references to those wrappers are removed.

Jan


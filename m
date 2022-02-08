Date: Tue, 08 Feb 2022 08:09:26 +0000
From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Reply-To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH] cobalt/thread: add missing EXPORT_SYMBOL_GPL for
 xnthread_host_pid
Message-ID: <1f672e15-c8a4-7532-62a0-b24124f61355@sigma-star.at>
In-Reply-To: <7eed4fdc-0e29-57c1-2c1a-545e3c490c1a@siemens.com>
References: <20220208050609.5007-1-david.oberhollenzer@sigma-star.at>
 <7eed4fdc-0e29-57c1-2c1a-545e3c490c1a@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

Hi,

On 2/8/22 08:04, Jan Kiszka wrote:
>
> No general concern - but can you help me where this is used by a module?
> In-tree or out-of-tree?
>

the issue cropped up with an out-of-tree module on our end.

When porting an application + kernel module from Xenomai 2 to 3,
calls to xnthread_user_pid in the module were replaced with
xnthread_host_pid, but this now breaks with more recent Xenomai 3
releases.

Given how the original function and the replacement were externally
available, I assumed the missing export statement was accidental
when removing the inline definition?

David



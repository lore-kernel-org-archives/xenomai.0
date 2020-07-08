Subject: Re: Question on tx/rx queue in RTnet
References: <CABQtCRFiwDnHmaGqudAxXOp5jrAykjP7cpL=S8Q2Ce2hVkocOQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <2dd12c8e-1b44-1fc6-4cb3-6bc98725a3e9@web.de>
Date: Wed, 8 Jul 2020 19:11:02 +0200
MIME-Version: 1.0
In-Reply-To: <CABQtCRFiwDnHmaGqudAxXOp5jrAykjP7cpL=S8Q2Ce2hVkocOQ@mail.gmail.com>
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
To: Jordan Paul <jordanjp7701@gmail.com>, xenomai@xenomai.org

On 07.07.20 04:32, Jordan Paul via Xenomai wrote:
> Hi
>
> I am using i210 driver with xenomai 3.1 on kernel 4.19
>
> rt_igb 0000:01:00.0: Using MSI-X interrupts. 1 rx queue(s), 1 tx queue(s=
)
>
>
> based on the above dmesg log, I am currently getting 1 tx and 1 rx queue=
,
> is this by design for RTnet?
>
> igb 0000:01:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)
>
>
> compared with linux drivers for igb, I am getting 4 tx and 4 rx queue.
>

RTnet has indeed no infrastructure for supporting multiple queues per
interface. Consequently, the related code in the ported drivers is
deactivated (if it existed at all when ported).

Jan


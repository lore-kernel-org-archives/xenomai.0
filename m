Subject: Re: RTDM module ownership
References: <CAFLxGvxru2Y==qboUgwHdsQvOT5MEL2O8CexkhkQpKz0Qj+jqw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <77dc555e-10dd-8e05-0770-1f1f673259fd@siemens.com>
Date: Fri, 3 Jul 2020 08:14:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFLxGvxru2Y==qboUgwHdsQvOT5MEL2O8CexkhkQpKz0Qj+jqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard.weinberger@gmail.com>, Xenomai <xenomai@xenomai.org>

On 02.07.20 10:32, Richard Weinberger via Xenomai wrote:
> Hi!
> 
> I'm working on a kernel module which is used on plain Linux and
> Xenomai (RTDM), while reviewing RTDM to understand refcounting I found
> something that is not entirely clear to me.
> 
> Why does __rtdm_dev_open() not grab a reference on the RTDM module owner?
> This leads to the case where one can rmmod the module while it is in use.
> Unloading will block uninterruptible in rtdm_dev_unregister() in the
> module's cleanup funktion.
> 
> In contrast, on regular Linux rmmod will refuse to unload the module
> if the device node is still open because fops_get() or other helpers
> gained a reference on the owner.
> 

First of all, your driver is apparently not reacting on the close 
request that it receives in that case. This leads the the stall you see.

Still, we could indeed run some module_put/get on open/socket/close. I 
thought we did, but that was once RTnet [1].

Jan

[1] 
https://gitlab.denx.de/Xenomai/xenomai/-/commit/11bbdef0e9486d8f952ea29023882449331af1aa

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


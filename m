Subject: Re: [PATCH] cobalt/rtdm: allow for device teardown
References: <20190617155323.21337-1-rpm@xenomai.org>
 <3853279e-922b-6c5a-d05f-9508124dbe3f@xenomai.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <78517593-82c1-493e-08e6-3ebf9bcebe78@web.de>
Date: Thu, 20 Jun 2019 10:20:49 +0200
MIME-Version: 1.0
In-Reply-To: <3853279e-922b-6c5a-d05f-9508124dbe3f@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 20.06.19 09:46, Philippe Gerum via Xenomai wrote:
> On 6/17/19 5:53 PM, Philippe Gerum wrote:
>> rtdm_dev_unregister() will hang soft until all references on the
>> dismantled device have been dropped, which in turn cannot happen until
>> all rtdm_fds on the device have been closed, which cannot happen until
>> all references on those fds have been dropped eventually. We need a
>> way to force a teardown on devices, so that rtdm_dev_unregister() will
>> not hang.
>
> This needs v2, let's drop this one.
>

I started to review but got distracted again. One thing, though: Don't we =
want
to convert at least some existing drivers to the new interface?

Jan


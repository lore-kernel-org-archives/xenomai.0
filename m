Subject: Re: linux not getting gpio interrupts on xenomai 3.0.8 on raspberrypi
 raspbian/stretch kernel 4.9
References: <4707bb12-658a-f74c-84b6-332424be2bb9@cs.ru.nl>
 <844c96f4-191f-dd82-8a02-d3a99ac74fef@cs.ru.nl>
 <CALLqZ8RM0_yLbM+K=Wo4SVa46a7Dp8SYBLdAMxGWfAbrtR5hQg@mail.gmail.com>
 <9dd68ccb-054a-5ccb-91d9-55267145a34f@cs.ru.nl>
 <CALLqZ8R9o356vp0pcbkfbqFJt09ENDLwnd62ziUTW86SSbKw8g@mail.gmail.com>
 <41dedf13-0136-b905-d70d-fef1ade4dbe7@cs.ru.nl>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <bac8728d-459b-ad23-3bd4-362494ccc615@web.de>
Date: Thu, 20 Jun 2019 09:37:03 +0200
MIME-Version: 1.0
In-Reply-To: <41dedf13-0136-b905-d70d-fef1ade4dbe7@cs.ru.nl>
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
To: Harco Kuppens <h.kuppens@cs.ru.nl>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 19.06.19 23:52, Harco Kuppens via Xenomai wrote:
>
>
> Op 19/06/2019 om 17:00 schreef Greg Gallagher:
>> On Wed, Jun 19, 2019 at 8:44 AM Harco Kuppens <h.kuppens@cs.ru.nl> wrot=
e:
>>> The ipipe patched not entirely cleanly on the rpi kernel source; I had=
 to
>>> make little changes in the patch, but not anything really seriously. S=
o I
>>> expect it to be fine.
>>>
>>> I used the rasbpian kernel source because it has better support for th=
e
>>> raspberry pi's and mainly because it has better support for the gpio p=
ins in
>>> its kernel.
>>>
>>> However to help you debug I did a similar install using the mainline k=
ernel
>>> source. The ipipe patch just worked smoothly, however to get the gpio =
pins
>>> running in xenomai I had to still port some code of the file
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ./drivers/pinctrl/bcm/pinctrl-bcm2835.c
>>>
>> What did you have to change here to get the pins to work with Xenomai?
>> You shouldn't need to change anything here.=C2=A0 If you did then it ma=
y be
>> a bug in the ipipe.=C2=A0 Can you try with 4.14 ipipe ?
> I did try with ipipe 4.19 and when compiling the kernel I got lot of err=
ors.
> Some I could solve, but at the end I gave up.
>
> See my notes on
> https://github.com/harcokuppens/xenomai3_rpi_gpio/blob/master/install/__=
INSTALL_FAILURES__/install__compile_vanilla_kernel_4.19_with_xenomai_3.0.8=
__assert_error.txt
> Maybe this is also interesting for you.
>

4.19 requires Xenomai master. See our CI (e.g.
https://travis-ci.com/xenomai-ci/xenomai/jobs/209347407) for a working set=
up.

Jan


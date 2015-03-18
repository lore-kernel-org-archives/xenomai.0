MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <CAKk99t3_aG=3LOCqHpVostRnhhPtZ7XSFLNjT8uJXtrjevTYSA@mail.gmail.com>
References: <CAKk99t3x2u4GN0D2w_pSBY8jWVRuE1yFki66dYNUfFBSd2GQ6w@mail.gmail.com>
 <CAKk99t2arbqbKke7EdM8accaghhdYstyVFQiysYoYB1LPGjnKA@mail.gmail.com>
 <CAKk99t0-b0bkndpxVDkFq-_pqzpq4FdEzV6nULMHq6bd+JkihQ@mail.gmail.com>
 <5509B7D8.2020807@xenomai.org>
 <CAKk99t3_aG=3LOCqHpVostRnhhPtZ7XSFLNjT8uJXtrjevTYSA@mail.gmail.com>
Date: Wed, 18 Mar 2015 20:26:36 +0000
Message-ID: <CAKk99t0+Yxd+a9TXbgpM7Te98vUHO_4AADqO3EADfwg=zeN+Mg@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Makefile to use 2 APIs (rtdm and alchemy)
	simultaneously
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I figure it out.
My mistake. I thought I had xeno_rtipc.ko inserted but it wasn't.

After inserting it start runing again:

insmod /lib/modules/$(uname -r)/kernel/drivers/xenomai/ipc/xeno_rtipc.ko

Sorry.




On 18 March 2015 at 19:04, Helder Daniel <hdaniel@ualg.pt> wrote:

> Yes
>
> CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
>
>
> On 18 March 2015 at 17:37, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> On 03/18/2015 05:07 PM, Helder Daniel wrote:
>> > I also took a look here:
>> >
>> > http://comments.gmane.org/gmane.linux.real-time.xenomai.users/11767
>> >
>> > I did a: nm -s xddp-echo > symbols
>> >
>> > cat symbols | grep sock
>> >                  U __wrap_setsockopt
>> >                  U __wrap_socket
>> >
>> > So the wrappers seems to be applied.
>> >
>>
>> Is CONFIG_XENO_DRIVERS_RTIPC_XDDP enabled in your kernel config?
>>
>> --
>> Philippe.
>>
>
>
>
> --
> Helder Daniel
> UALG - FCT
> DEEI
>
> http://w3.ualg.pt/~hdaniel
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel

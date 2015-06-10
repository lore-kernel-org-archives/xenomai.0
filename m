MIME-Version: 1.0
In-Reply-To: <CAHH_qdACfPLuXRAQqDkgtmPJGD71pe+-qnRJKAg_a5WT1RY+SQ@mail.gmail.com>
References: <CAHH_qdD+0RnjOZejUuYp9Z7-7sSDfEE+c=sZGds3i_u=8zpKvg@mail.gmail.com>
 <20150603130935.GR27570@hermes.click-hack.org>
 <CAHH_qdACfPLuXRAQqDkgtmPJGD71pe+-qnRJKAg_a5WT1RY+SQ@mail.gmail.com>
Date: Wed, 10 Jun 2015 11:53:28 +0200
Message-ID: <CAHH_qdA3ymeDgraTLYPw0Mhq2Xw=-cUevBhwpgofDkWzpxefZA@mail.gmail.com>
From: Gautier HAOUY <gautier.haouy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] [Xenomai 2.6] iMX6 + linux 3.16.7 + ipipe arm-7 +
 inconsistent lock state on kdevtmpfs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Hello Gilles,

I do confirm that there is no more message while changing the configuration
of the kernel such like:
CONFIG_PROVE_LOCKING=n
CONFIG_DEBUG_LOCK_ALLOC=y

Thank you again & have a nice day,
Gautier.

2015-06-03 15:23 GMT+02:00 Gautier HAOUY <gautier.haouy@gmail.com>:

> Thank you for your prompt feedback, I'm going to look for the dependencies
> and let you know.
>
> 2015-06-03 15:09 GMT+02:00 Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org>:
>
>> On Wed, Jun 03, 2015 at 03:00:33PM +0200, Gautier HAOUY wrote:
>> > Hello everyone,
>> >
>> > I'm requesting once again your help as I'm getting an "INFO message on
>> > inconsistent lock state" while booting linux 3.16.7 with ipipe arm-7 on
>> an
>> > iMX6 platform. I would like to understand how I could dive in and
>> determine
>> > if this is going to be an issue or just informational.
>> >
>> > I kindly ask for assistance as I did not find anything on the internet
>> on
>> > how to proceed with such case.
>>
>> Please try disabling CONFIG_TRACE_IRQFLAGS. It is known to be broken
>> with the I-pipe patch on ARM. You probably can not disable it
>> directly, you will have to remove all the options that depend on
>> this one.
>>
>> --
>>                                             Gilles.
>>
>
>

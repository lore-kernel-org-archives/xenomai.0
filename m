From: JackLee <jacklee11@foxmail.com>
References: <830662c3-0cbc-78ab-b7ab-4568616793a7@foxmail.com>
Message-ID: <acccef47-bb98-284f-d305-b2c36c8a5f48@foxmail.com>+5669DEBCEAEE31FA
Date: Thu, 7 Dec 2017 10:37:20 +0800
MIME-Version: 1.0
In-Reply-To: <830662c3-0cbc-78ab-b7ab-4568616793a7@foxmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai 3.0.3 POSIX rtnet API
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



On 12/07/2017 10:35 AM, JackLee wrote:
>
> Hi, all,
>
>   My Xenomai version is 3.0.3 and I use the POSIX API with the 
> following build options.
>
>
> XENO_CONFIG := /usr/xenomai/bin/xeno-config
> CFLAGS := $(shell $(XENO_CONFIG) --vxworks --cflags)
> LDFLAGS := $(shell $(XENO_CONFIG) --vxworks --ldflags)
> CC := $(shell $(XENO_CONFIG) --cc)
>
>   What APIs can I use for RTnet?
>
>   The Link below uses alchemy APIs?
>
> http://xenomai.org/rtnet-programming/
>
>
> Thanks for your help!
>
should be

XENO_CONFIG := /usr/xenomai/bin/xeno-config
CFLAGS := $(shell $(XENO_CONFIG) --posix --cflags)
LDFLAGS := $(shell $(XENO_CONFIG) --posix --ldflags)
CC := $(shell $(XENO_CONFIG) --cc)


Message-ID: <514B7C8C.7030603@yahoo.com>
Date: Thu, 21 Mar 2013 16:33:00 -0500
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
References: <5140EEEA.2080209@yahoo.com> <5140F1FA.6060205@xenomai.org>
In-Reply-To: <5140F1FA.6060205@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] linkage problem under 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

Thanks for your answer. You're right, the order was wrong. After a few 
trial&error, I changed to the following order, everything seems work well.
CFLAGS=$(shell $(XENOCONFIG) --skin=native --cflags)
LDFLAGS=$(shell $(XENOCONFIG) --skin=native --ldflags)
gcc $(CFLAGS) main.c $(LDFLAGS) -o main

Sincerely,
Tom

On 3/13/2013 4:39 PM, Gilles Chanteperdrix wrote:
> On 03/13/2013 10:26 PM, Tom Z wrote:
>
>> Hi,
>
> Hi,
>
>> gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__
>> -lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt -lxenomai ex01.c -o
>> ex01
>
> The link order seems wrong.
>



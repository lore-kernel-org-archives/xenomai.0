Message-ID: <4E022C64.3040805@domain.hid>
Date: Wed, 22 Jun 2011 10:54:44 -0700
From: David Wiebe <dwiebe2@domain.hid>
MIME-Version: 1.0
References: <BANLkTi=qe3CqD9U_T3nF6xBN+nZNbxF7Gg@domain.hid>	
	<4E00A476.2080006@domain.hid> <4E01977E.1080202@domain.hid>	
	<4E01AB2C.4070409@domain.hid> <1308733051.2159.12.camel@domain.hid>	
	<4E02162A.9060004@domain.hid> <1308760138.2159.92.camel@domain.hid>
In-Reply-To: <1308760138.2159.92.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_dev_ioctl
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 11-06-22 09:28 AM, Philippe Gerum wrote:
> On Wed, 2011-06-22 at 09:19 -0700, David Wiebe wrote:
>> On 11-06-22 01:57 AM, Philippe Gerum wrote:
>> Still not compiling.
>>
> Your build flags are likely wrong. Did you get them via xeno-config?

Here are my build flags.

CFLAGS=`DESTDIR=/home/david/sdir 
/home/david/sdir/usr/xenomai/bin/xenomai-config --skin native --cflags`

LDFLAGS=`DESTDIR=/home/david/sdir 
/home/david/sdir/usr/xenomai/bin/xenomai-config --skin native --ldflags`



>>> On Wed, 2011-06-22 at 01:43 -0700, David Wiebe wrote:
>>>> Hello,
>>>>
>>>> I'm re-writing my code to work with xenomai and I don't know how to get
>>>> rt_dev_ioctl to compile in my program.
>>>>
>>>> #include<rtdk.h>   in my program doesn't help
>>> #include<rtdm/rtdm.h>
>>>
>>>> david@domain.hid$
>>>> arm-none-linux-gnueabi-gcc -o xenomai-spi-eth-00002 $CFLAGS
>>>> xenomai-spi-eth-00002.c $LDFLAGS -I
>>>> /home/david/122720101858-beagleboard-working-set/kernel/linux/include/
>>>> xenomai-spi-eth-00002.c: In function 'main':
>>>> xenomai-spi-eth-00002.c:137: warning: implicit declaration of function
>>>> 'rt_dev_open'
>>>> xenomai-spi-eth-00002.c:145: warning: implicit declaration of function
>>>> 'rt_dev_ioctl'
>>>> /tmp/ccZErCuj.o: In function `main':
>>>> xenomai-spi-eth-00002.c:(.text+0x2c4): undefined reference to `rt_dev_open'
>>>> xenomai-spi-eth-00002.c:(.text+0x318): undefined reference to `rt_dev_ioctl'
>>>> collect2: ld returned 1 exit status
>>>>
>>>>
>>>> David
>>>>
>>>>
>>>> _______________________________________________
>>>> Xenomai-help mailing list
>>>> Xenomai-help@domain.hid
>>>> https://mail.gna.org/listinfo/xenomai-help



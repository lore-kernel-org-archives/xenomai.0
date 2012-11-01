Message-ID: <5092A5BC.3090103@gmail.com>
Date: Thu, 01 Nov 2012 16:39:24 +0000
From: Stefan Videv <videvstefan@gmail.com>
MIME-Version: 1.0
References: <5092984A.5050907@gmail.com>
	<984605f116e3f118be8a39540ec40a64.squirrel@www.xenomai.org>
In-Reply-To: <984605f116e3f118be8a39540ec40a64.squirrel@www.xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling the Xenomai examples
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



On 11/01/2012 04:32 PM, Gilles Chanteperdrix wrote:
> Stefan Videv wrote:
>> Hi All,
>>
>> I've been following this:
>>
>> http://www.xenomai.org/index.php/Examples
>>
>> on how to cross-compile the examples that come with Xenomai.
>>
>> However, running:
>>
>> make XENO=/media/rootfs/usr/xenomai/ ARCH=arm-linux-gnueabi-
>> KSRC=/media/rootfs/usr/include
>>
>> where /media/rootfs/usr/xenomai is where xenomai is installed on the SD
>> card that "powers" my embedded system, arm-linux-gnueabi- is the cross
>> compiler chain I have running on my virtual box, and finally
>> /media/rootfs/usr/include is where I installed the header files for the
>> kernel that is running on my embedded board.
>>
>> To me it seems that the XENO parameter is ignored altogether (same for
>> the KSRC it seems) which results in the particular included .h files not
>> being found on the path. Do I have any options rather than compiling
>> manually?
> The problem is that you are cross-compiling, the instructions apply to
> native compilation. The XENO parameter is not ignored, but as explained on
> the page you linked its role is to locate the xeno-config script. But in
> order for this script to produce the correct flags (and as explained if you
> read xeno-config help) the DESTDIR environment variable needs to be set (to
> /media/rootfs if I understand correctly).
I suspected as much, but was not sure exactly what I should set DESTDIR 
to. Thanks!

>
> Anyway, the examples are examples, to show you how to use Xenomai API and
> compile programs for Xenomai, so, you are supposed to read their Makefiles
> and understand how they work in order to adapt them to your particular
> programs. Running these programs on your target will not bring you much.
> Running the testsuite and the xeno-test script should be more useful.
>
>
>
I am trying to compile the examples in order to figure out exactly how I 
should compile the little Xenomai RTDM module I've just written.

-- Stefan



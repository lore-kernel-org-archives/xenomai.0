Message-ID: <5093F975.9060807@gmail.com>
Date: Fri, 02 Nov 2012 16:48:53 +0000
From: Stefan Videv <videvstefan@gmail.com>
MIME-Version: 1.0
References: <a81ced276a31df626d584233b83aeb10.squirrel@www.xenomai.org>
	<5092AEB3.2070009@gmail.com>
	<4b27818deb6c26a74a2ab839cb07f718.squirrel@www.xenomai.org>
In-Reply-To: <4b27818deb6c26a74a2ab839cb07f718.squirrel@www.xenomai.org>
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

On 11/01/2012 06:25 PM, Gilles Chanteperdrix wrote:
> Stefan Videv wrote:
>> On 11/01/2012 05:04 PM, Gilles Chanteperdrix wrote:
>>> Stefan Videv wrote:
>>>> On 11/01/2012 04:32 PM, Gilles Chanteperdrix wrote:
>>>>> Stefan Videv wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> I've been following this:
>>>>>>
>>>>>> http://www.xenomai.org/index.php/Examples
>>>>>>
>>>>>> on how to cross-compile the examples that come with Xenomai.
>>>>>>
>>>>>> However, running:
>>>>>>
>>>>>> make XENO=/media/rootfs/usr/xenomai/ ARCH=arm-linux-gnueabi-
>>>>>> KSRC=/media/rootfs/usr/include
>>>>>>
>>>>>> where /media/rootfs/usr/xenomai is where xenomai is installed on the
>>> SD card that "powers" my embedded system, arm-linux-gnueabi- is the
>>> cross compiler chain I have running on my virtual box, and finally
>>>>>> /media/rootfs/usr/include is where I installed the header files for
>>> the kernel that is running on my embedded board.
>>>>>> To me it seems that the XENO parameter is ignored altogether (same
>>>>>> for
>>> the KSRC it seems) which results in the particular included .h files
>>> not
>>>>>> being found on the path. Do I have any options rather than compiling
>>> manually?
>>>>> The problem is that you are cross-compiling, the instructions apply to
>>> native compilation. The XENO parameter is not ignored, but as explained
>>> on
>>>>> the page you linked its role is to locate the xeno-config script. But
>>> in order for this script to produce the correct flags (and as explained
>>> if you
>>>>> read xeno-config help) the DESTDIR environment variable needs to be
>>>>> set
>>> (to
>>>>> /media/rootfs if I understand correctly).
>>>> After a quick attempt, things are looking better with DESTDIR. However,
>>> it still gives errors:
>>>> arm-linux-gnueabi-gcc -I/media/rootfs/usr/xenomai/include -D_GNU_SOURCE
>>> -D_REENTRANT -D__XENO__   -lnative -L/media/rootfs/usr/xenomai/lib
>>> -lxenomai -lpthread -lrt  -Xlinker -rpath -Xlinker
>>>> /media/rootfs/usr/xenomai/lib  trivial-periodic.c   -o trivial-periodic
>>> /tmp/ccZ8pOKK.o: In function `demo':
>>>> trivial-periodic.c:(.text+0x1e): undefined reference to
>>>> `rt_task_set_periodic'
>>>> trivial-periodic.c:(.text+0x22): undefined reference to `rt_timer_read'
>>> trivial-periodic.c:(.text+0x2e): undefined reference to
>>>> `rt_task_wait_period'
>>>> trivial-periodic.c:(.text+0x32): undefined reference to `rt_timer_read'
>>> /tmp/ccZ8pOKK.o: In function `main':
>>>> trivial-periodic.c:(.text+0x10c): undefined reference to
>>> `rt_task_create' trivial-periodic.c:(.text+0x124): undefined reference
>>> to `rt_task_start' trivial-periodic.c:(.text+0x134): undefined reference
>>> to `rt_task_delete' collect2: ld returned 1 exit status
>>>> make[1]: *** [trivial-periodic] Error 1
>>>> make[1]: Leaving directory
>>>> `/home/stefan/roosenXenomaiBone/xenomai-2.6.1/examples/native'
>>>>
>>>> However, if the above command is modified to look like this:
>>>>
>>>> arm-linux-gnueabi-gcc -I/media/rootfs/usr/xenomai/include -D_GNU_SOURCE
>>> -D_REENTRANT -D__XENO__   -lnative -L/media/rootfs/usr/xenomai/lib
>>> -lxenomai -lpthread -lrt  -Xlinker -rpath -Xlinker
>>>> /media/rootfs/usr/xenomai/lib  trivial-periodic.c   -o trivial-periodic
>>> -lnative -lpthread -lxenomai
>>>> It works just fine. How can I fix this in the Makefile, or am I still
>>> doing something wrong?
>>>
>>> This has been reported several times. I proposed a patch in the
>>> following
>>> mail:
>>> http://www.xenomai.org/pipermail/xenomai/2012-October/026561.html
>>> But since nobody reported whether it fixes anything, it is not merged
>>> yet.
>>>
>>>
>> Yes this fixes the compilation for the examples in the native folder
>> (kind of obvious since the patch fixes that particular make file).
>> Should I go ahead and replicate the fix over the other make files?
> Yes, and please tell us if you get the compilation working.
>
I've done the changes. However, the kernel modules are still not being made:

make XENO=/media/rootfs/usr/xenomai/ ARCH=arm-linux-gnueabi- 
KSRC=/media/rootfs/usr/include DESTDIR=/media/rootfs
make[1]: Entering directory `/home/stefan/xenomai-2.6.1/examples/native'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/home/stefan/xenomai-2.6.1/examples/native'
make[1]: Entering directory 
`/home/stefan/xenomai-2.6.1/examples/rtdm/profiles/can'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory 
`/home/stefan/xenomai-2.6.1/examples/rtdm/profiles/can'
make[1]: Entering directory 
`/home/stefan/xenomai-2.6.1/examples/rtdm/profiles/ipc'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory 
`/home/stefan/xenomai-2.6.1/examples/rtdm/profiles/ipc'
make[1]: Entering directory 
`/home/stefan/xenomai-2.6.1/examples/rtdm/profiles/serial'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory 
`/home/stefan/xenomai-2.6.1/examples/rtdm/profiles/serial'
sed: can't read /media/rootfs/usr/include/Makefile: No such file or 
directory
make[1]: Entering directory 
`/home/stefan/xenomai-2.6.1/examples/rtdm/driver-api'
make -C /media/rootfs/usr/include 
SUBDIRS=/home/stefan/xenomai-2.6.1/examples/rtdm/driver-api modules
make[2]: Entering directory `/media/rootfs/usr/include'
make[2]: *** No rule to make target `modules'. Stop.
make[2]: Leaving directory `/media/rootfs/usr/include'
make[1]: *** [all] Error 2
make[1]: Leaving directory 
`/home/stefan/xenomai-2.6.1/examples/rtdm/driver-api'
sed: can't read /media/rootfs/usr/include/Makefile: No such file or 
directory
make[1]: Entering directory `/home/stefan/xenomai-2.6.1/examples/posix'
make -C /media/rootfs/usr/include ARCH=arm-linux-gnueabi- CROSS_COMPILE= 
SUBDIRS=/home/stefan/xenomai-2.6.1/examples/posix modules
make[2]: Entering directory `/media/rootfs/usr/include'
make[2]: *** No rule to make target `modules'. Stop.
make[2]: Leaving directory `/media/rootfs/usr/include'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/stefan/xenomai-2.6.1/examples/posix'
make[1]: Entering directory `/home/stefan/xenomai-2.6.1/examples/common'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/home/stefan/xenomai-2.6.1/examples/common'

How do we get around that? That's actually what I was hoping to 
understand from this "exercise."

The patch for the Make files is exactly the same one as the one for the 
native examples with the exception for the one for the driver-api, where 
I explicitly added the xenomai library to get it to compile:

LOADLIBES=$(shell $(XENOCONFIG) --skin=native --ldflags) $(MY_LDFLAGS) 
-lrtdm -lxenomai

The common examples compile without the need for the patch (or so it 
seems). Apologies, for not providing a patch file, but I just realized I 
had not checked out the git repository where I made the changes but 
rather it was a direct download from the website.

Thanks!
-- Stefan




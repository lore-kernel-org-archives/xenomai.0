Message-ID: <4DD107AD.5000307@domain.hid>
Date: Mon, 16 May 2011 13:17:01 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>	<4DCD2EE8.2010904@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B910B@ontex.i.omicron.de>
	<4DD102DA.9080206@domain.hid>
In-Reply-To: <4DD102DA.9080206@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] build xenomai userspace app, illegal instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Koenig, Florian" <F.Koenig@domain.hid>
Cc: xenomai@xenomai.org

On 05/16/2011 12:56 PM, Wolfgang Grandegger wrote:
> On 05/16/2011 12:23 PM, Koenig, Florian wrote:
>> Hi,
>>
>> i installed eldk into /opt/eldk-4.2, then i installed (make install) xenomai
>> user-space into /opt/eldk-4.2/ppc_4xx .
>>
>> Now when i try to build the xenomai examples with
>>
>> $ make XENO=/opt/eldk-4.2/usr/xenomai-2.5.6/bin
>>
>> It uses /lib/modules/2.6.32-5-686 from the local kernel, so i used
>>
>> $ make XENO=/opt/eldk-4.2/usr/xenomai-2.5.6/bin KSRC=/usr/src/linux-2.6.36
> 
> For building kernel space modules you need to specifiy KSRC as well, but
> not for user space apps.
> 
>> But then it returns:
>> make[1]: Entering directory `/usr/src/xenomai-2.5.6/examples/native'
>> powerpc-linux-gcc -I/usr/xenomai-2.5.6/include -D_GNU_SOURCE -D_REENTRANT
>> -Wall -pipe -D__XENO__   -L/usr/xenomai-2.5.6/lib -lxenomai -lpthread
>> -lnative -Xlinker -rpath -Xlinker /usr/xenomai-2.5.6/lib  trivial-periodic.c
>> -o trivial-periodic
>> trivial-periodic.c: In function 'main':
>> trivial-periodic.c:72: warning: control reaches end of non-void function
> 
> I think you didn't specify DESTDIR? Or did you install xenomai-2.5.6
> into /usr ? Normally you do:
> 
>   cd xenomai-2.5.6
>   ./configure --host=powerpc-linux --prefix=/usr/xenomai
>   make
>   export DESTDIR=/opt/eldk/ppc_4xx
>   make install
> 
> You also need the DESTDIR for building your apps.
> 
>> When i now use trivial-periodic on the 405GP cpu, it also returns: illegal
>> instruction
>>
>> When i try to build the hello_world app with your command it returns:
>>
>> powerpc-linux-gcc -o test test.c
>> 'XENO=/opt/eldk-4.2/ppc_4xx/usr/xenomai-2.5.6/bin/xeno-config --skin native
>> --cflags --ldflags' -lrtdk
>> powerpc-linux-gcc:
>> XENO=/opt/eldk-4.2/ppc_4xx/usr/xenomai-2.5.6/bin/xeno-config --skin native
>> --cflags --ldflags: No such file or directory
>>
>> Why is xenomai using local /lib/modules/2.6.32-5-686 directory ? what do i
>> wrong with xenomai userspace part ?
> 
> See above? Hope it helps.

Just to be sure. The installed Xenomai programs from the test suite like
"latency" or "cyclictest" do work fine, right?

Wolfgang.


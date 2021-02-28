Date: Sun, 28 Feb 2021 10:16:07 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: Re: GPIO interrupt reading timeout
Message-ID: <SN6PR08MB566192E804B7CE74B7286DC9939B9@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <CALLqZ8TGuwZ5Z0djHjGS7RkR7H=c8oWiGPwsmgWLhGhmCmAzaw@mail.gmail.com>
References: <SN6PR08MB5661EE942B37DBEF57E8272F939B9@SN6PR08MB5661.namprd08.prod.outlook.com>
 <CALLqZ8TGuwZ5Z0djHjGS7RkR7H=c8oWiGPwsmgWLhGhmCmAzaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai@xenomai.org



On Sun, Feb 28, 2021 at 8:08 am, Greg Gallagher <greg@embeddedgreg.com> 
wrote:
> 
> 
> On Sun, Feb 28, 2021 at 7:18 AM Gabriel Dinse via Xenomai 
> <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> wrote:
>> Hello,
>> 
>>  I currently have a loop rt_task for reading interrupts on a GPIO 
>> pin of
>>  my raspberry pi.
>> 
>>  I'm using:
>>  ret = read(pin, &value, sizeof(value));
>> 
>>  but I don't want it to block forever, because my task should exit 
>> when
>>  there are not more interrupts to read. Can I use "select" for
>>  introducing a reading timeout on my loop and yet being "real-time"?
>> 
>>  Thank you,
>>  Gabriel Dinse
>> 
> 
> If you are using the posix skin ( which I believe you are) then yes, 
> using select will translate into using the RT version of select, and 
> you can use a timeout.
> 
> Thanks
> 
> Greg
>> 

Should I specify posix on compilation? I'm using alchemy as well right 
now. my Makefile is like this:

   0 STAGE=../../output/target/
   1 XENO_CONFIG := ../../output/target/usr/xenomai/bin/xeno-config
   2 CFLAGS := $(shell DESTDIR=$(STAGE) $(XENO_CONFIG) --rtdm 
--skin=alchemy --      cflags)
   3 LDFLAGS := $(shell DESTDIR=$(STAGE) $(XENO_CONFIG) --rtdm 
--skin=alchemy --     ldflags)
   4 CC := $(shell DESTDIR=$(STAGE) $(XENO_CONFIG) --cc)
   5
   6 EXECUTABLE := program
   7
   8
   9 all: $(EXECUTABLE)
  10
  11 %: %.c
  12     $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)



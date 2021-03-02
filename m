Date: Tue, 02 Mar 2021 20:53:05 -0300
From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: Re: Cannot disable Page migration on kernel configuration
Message-ID: <SN6PR08MB56613FEEB66D13ED60CD95BE93999@SN6PR08MB5661.namprd08.prod.outlook.com>
In-Reply-To: <CALLqZ8R7ktiYDEAUUqquVhM8CBXco8Kvr7nV3CFX18ggEOno7w@mail.gmail.com>
References: <SN6PR08MB5661FBDD5171C06547422CD293999@SN6PR08MB5661.namprd08.prod.outlook.com>
 <CALLqZ8R7ktiYDEAUUqquVhM8CBXco8Kvr7nV3CFX18ggEOno7w@mail.gmail.com>
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

Oh, disabling Continuous Memory Allocation makes Page migration item to 
disappear, but it does not make sense as CMA is bellow Page migration 
option lol. But at least it worked.
Thank you!
Gabriel Dinse

On Tue, Mar 2, 2021 at 6:45 pm, Greg Gallagher <greg@embeddedgreg.com> 
wrote:
> 
> 
> On Tue, Mar 2, 2021 at 6:43 PM Gabriel Dinse via Xenomai 
> <xenomai@xenomai.org <mailto:xenomai@xenomai.org>> wrote:
>> When configuring kernel (4.19.144 arm) through menuconfig, I get the
>>  following warning:
>>  [*] Xenomai/cobalt  --->
>>  *** WARNING! Page migration (CONFIG_MIGRATION) may increase ***
>>  *** latency. ***
>> 
>>  But I'm not able to disable it:
>>  Memory Management options  --->
>>           -*-   Page migration
>> 
>>  Is it possible to do it different than using menuconfig?
>> 
>>  Thank you,
>>  Gabriel Dinse
>> 
> Are you using multiv7_defconfig? Try disabling the imx platform in 
> menu config then try disabling page migration and CMA.
> 
> -Greg


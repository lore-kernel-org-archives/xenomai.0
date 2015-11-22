Message-ID: <BLU437-SMTP28ED04ABD900BC8E661228F0180@phx.gbl>
References: <BLU436-SMTP145401599CFFDB6392A7DA3F01C0@phx.gbl>
 <BLU437-SMTP1580D36EAE2265F83692A4F01B0@phx.gbl>
From: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Date: Sat, 21 Nov 2015 20:51:18 -0800
MIME-Version: 1.0
In-Reply-To: <BLU437-SMTP1580D36EAE2265F83692A4F01B0@phx.gbl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai skin's test suite not built
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 15-11-18 10:05 PM, Mathieu Rondonneau wrote:
> On 15-11-17 09:33 PM, Mathieu Rondonneau wrote:
>> Hi Xenomai team,
>>
>> It looks like the makefile of the testsuite directory of the different
>> skins are not called for some reason when building the xenomai library
>> and tools.
>>
>> Am I missomg a flag somewhere?
>>
>> Thanks,
>> -Mathieu
>>
> got them to build manually and run.
> 
> I am running a freertos skin but some testsuite are failing.
> Will look at it more in details.
> 
> thanks,
> -Mathieu
> 

tests failing were due to problem accessing the registry (files created
by the skin could not be read by the app).

The problem was because of the wrong path being used by the app.

Thanks,
-Mathieu


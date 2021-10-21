Subject: Re: [PATCH] testsuite/xeno-test: Restore timesyncd running state on
 smokey failure
References: <20211021115508.36110-1-florian.bezdeka@siemens.com>
 <851fd680-a5e7-6755-a66c-bffc2c31c71d@siemens.com>
 <6f3ceac348b11114fe267b3cf1c5e229a4d83b69.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <40ebf01e-3f97-49b5-c652-412555ecca7c@siemens.com>
Date: Thu, 21 Oct 2021 18:38:24 +0200
MIME-Version: 1.0
In-Reply-To: <6f3ceac348b11114fe267b3cf1c5e229a4d83b69.camel@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 21.10.21 14:18, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Thu, 2021-10-21 at 14:15 +0200, Jan Kiszka wrote:
>> On 21.10.21 13:55, Florian Bezdeka wrote:
>>> We stop systemd-timesyncd before running the smokey testsuite and start
>>> it again once the smokey tests are complete. As xeno-test has a "set -e"
>>> we will stop the execution on the first error. So if smokey reports an
>>> error systemd-timesyncd is not started again. We don't properly restore
>>> the system state in this case.
>>>
>>> Install a bash trap to make sure that we restart the service in all
>>> cases if it was running on script entry.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>  testsuite/xeno-test/xeno-test.in | 17 ++++++++++++-----
>>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/testsuite/xeno-test/xeno-test.in b/testsuite/xeno-test/xeno-test.in
>>> index 95bf59606..cfa28df18 100644
>>> --- a/testsuite/xeno-test/xeno-test.in
>>> +++ b/testsuite/xeno-test/xeno-test.in
>>> @@ -39,9 +39,19 @@ timer irq latency.
>>>  EOF
>>>  }
>>>
>>> +start_timesyncd()
>>> +{
>>> +    if $timesyncd_was_running; then
>>> +        systemctl start systemd-timesyncd
>>> +        timesyncd_was_running=false
>>> +    fi
>>
>> Plus "trap - EXIT" here? Or at least after explicit start_timesyncd below.
> 
> We set timesyncd_was_running to false once the service has been
> started. So even if called twice (on test suite success) everything is
> fine. Even if called twice, starting an already running service is a
> NOOP.
> 

OK - applied.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


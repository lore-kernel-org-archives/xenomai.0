Subject: Re: rt_pipe_write memory allocation bug - xenomai 3.x
References: <5adc97a4-014f-3a50-9109-4e574662cf7b@numalliance.com>
 <7f4384d6-c318-2448-99d9-bbfa7061f78e@siemens.com>
 <fc73b728-50c8-119b-4029-e4c1953a2ed0@numalliance.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <f6ba4f26-82b9-4c4d-3f09-dc69fccc1393@siemens.com>
Date: Thu, 30 Jul 2020 00:08:18 +0200
MIME-Version: 1.0
In-Reply-To: <fc73b728-50c8-119b-4029-e4c1953a2ed0@numalliance.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, Bastien COUNILH <bcounilh@numalliance.com>

On 28.07.20 15:28, Stéphane Ancelot wrote:
> 
> Le 27/07/2020 à 15:17, Jan Kiszka a écrit :
>> On 27.07.20 14:44, Stéphane Ancelot via Xenomai wrote:
>>> Hi,
>>>
>>> Using pipe created with poolsize = 0, meaning all message allocations 
>>> for this pipe are performed on the Cobalt core heap.
>>>
>>> Unfortunately,  using rt_pipe_write(), when no user task is consuming 
>>> it, we discovered after almost many rt_pipe_write() cycles (700000 at 
>>> least in our process)  , that the cobalt heap and system heap seem 
>>> being corrupted.
>>>
>>> Leading to system issues like unattended task crashes .....
>>>
>>
>> "3.x" implies both 3.1 and 3.0 are affected?
>>
>> Do you see a constantly growing use of system heap (leak)? If that is 
>> not the case, we might have some wrap-around issue somewhere.
>>
> The version we are using is  based on release b3e18b6d  of master branch.
> 
> We don't sea system memory increasing (using top).
> 
> Comparing it to the latest releases, we have not found any big 
> differences in xddp code .
> 
> Using other releases , applications and compiled kernel does not 
> warranty  to identify it has been solved , since the memory mapping to 
> reproduce it , changes.
> 
> For certifications reasons, we can't validate the latest source code, 
> but only cherry pick a localised hotfix in the xenomai code.
> 
> 
>> Reproduction case would be nice.
>>
> It is not easy, the initial problem was reported by one of our users , 
> we spent lot of time to achieve to reproduce it in our context.
> 
> Some graphics user tasks were locking or crashing after some days usage 
> and production .
> 
> At first,  we went in wrong directions in order to identify from where 
> it could happen.
> 
> In our system, we had to test each code commits back....in order to 
> isolate the problem, and understand that it was visible after almost 
> 700000 rt_pipe_write calls in our case.
> 
> 
> As a unittest, we can provide the enclosed snippet.That is the extracted 
> code that would cause problem.
> 

Under which condition does that test_pipe.cpp cause the issue? I've 
given it a quick try, and as it's late, I disabled the delay in the 
loop. That so far did not trigger an issue. Is the delay important?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


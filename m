Message-ID: <55C515F0.8080307@xenomai.org>
Date: Fri, 07 Aug 2015 16:32:48 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <55C17C8E.5000909@gatech.edu> <55C3AEBE.9080603@xenomai.org>
 <55C3C3F8.1090808@gatech.edu> <55C3C7F4.1030107@xenomai.org>
 <12F45B9B-70C3-4278-BA0E-DFC26E19DBF0@gatech.edu>
 <55C495D6.2070706@xenomai.org>
 <06B32287-9FE2-42E5-BC2B-E9C807D0BD69@gatech.edu>
 <55C4BD22.9060809@xenomai.org>
 <EB72B89E-CA71-4F7F-9A35-99A87C282A61@gatech.edu>
In-Reply-To: <EB72B89E-CA71-4F7F-9A35-99A87C282A61@gatech.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/07/2015 04:15 PM, Yogi A. Patel wrote:
>> On Aug 7, 2015, at 10:13, Jorge Ramirez Ortiz <jro@xenomai.org> wrote:
>>
>>
>>>>>
>>>>> This is because it is looking for the elements string under “analog_output” in 
>>>>> the calibration file, however there is no such section in the calibration file.
>>
>> please pull from here for updates:
>> http://git.xenomai.org/xenomai-jro.git/log/?h=devel <http://git.xenomai.org/xenomai-jro.git/log/?h=devel>
> 
> I’ve moved to your development branch. I just compiled and ran insn_read - and get:
> 
> error reading the calibration file: -1
> 
> Yogi

it means your calibration file is not correct.
any errors while generating it?
post the file please and I can have a look.




-- 
jro


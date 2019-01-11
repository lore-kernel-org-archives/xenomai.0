Subject: Re: FW: LD_PRELOAD checker for clock_gettime and consorts
References: <b79c8b2eb4074371a41bf54872a1c0a2@andritz.com>
 <77dd1ba999524c1fb408af59693caf3e@andritz.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fd6b20e3-f5e4-f618-e7cc-ad9006e2cc36@siemens.com>
Date: Fri, 11 Jan 2019 10:25:57 +0800
MIME-Version: 1.0
In-Reply-To: <77dd1ba999524c1fb408af59693caf3e@andritz.com>
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 11.01.19 02:14, Lange Norbert via Xenomai wrote:
> And heres a checker for malloc/free and consorts. This one is a bit trickier and I have barely tested it.
> 

Looks useful, thanks for sharing!

In order to make it more easily accessible to users, we could provide it as 
"libcobalt-modecheck.so" or so in-tree and descibe its usage.

I think, rather than the gcc-dependent open-coded solution, pthread_once should 
address your needs to initialize pointers and state on first invocation.

What would also be good is to have a couple of tests for it that stress the 
basic and also non-trival cases the tool should catch.

Jan

>> -----Original Message-----
>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Lange
>> Norbert via Xenomai
>> Sent: Donnerstag, 10. Jänner 2019 14:47
>> To: Xenomai (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Subject: LD_PRELOAD checker for clock_gettime and consorts
>>
>> E-MAIL FROM A NON-ANDRITZ SOURCE: AS A SECURITY MEASURE, PLEASE
>> EXERCISE CAUTION WITH E-MAIL CONTENT AND ANY LINKS OR
>> ATTACHMENTS.
>>
>>
>> Hello,
>>
>> as you might know, I run into alot of troubles with realtime code calling
>> clock_gettime.
>> This function is now a syscall on many architectures and depends on a linux
>> kernel spinlock, so a RT thread might deadlock itself when both trying to
>> claim that lock and preventing the linux kernel to free it.
>>
>> Usage is rather simple, the code compiles without any Cobalt/Xenomai
>> headers.
>> RT-threads need to enable PTHREAD_WARNSW:
>> pthread_setmode_np(0, PTHREAD_WARNSW, NULL);
>>
>> And the checker library needs to be preloaded:
>> LD_PRELOAD=libcobalt-gettime_checker.so ./yourapp -and -your -params.
>>
>> Unlike the existing mode-checker, this does not need any changes to the
>> binary, and will also catch calls from all directly and indirectly loaded DSOs.
>>
>> Other skins should be supported aswell, aslong as libcobalt is loaded (or more
>> specific, the code looks for a symbol "cobalt_assert_nrt").
>>
>> Kind regards,
>> Norbert
>> ________________________________
>>
>> This message and any attachments are solely for the use of the intended
>> recipients. They may contain privileged and/or confidential information or
>> other information protected from disclosure. If you are not an intended
>> recipient, you are hereby notified that you received this email in error and
>> that any review, dissemination, distribution or copying of this email and any
>> attachment is strictly prohibited. If you have received this email in error,
>> please contact the sender and delete the message and any attachment from
>> your system.
>>
>> ANDRITZ HYDRO GmbH
>>
>>
>> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
>>
>> Firmensitz/ Registered seat: Wien
>>
>> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
>>
>> Firmenbuchnummer/ Company registration: FN 61833 g
>>
>> DVR: 0605077
>>
>> UID-Nr.: ATU14756806
>>
>>
>> Thank You
>> ________________________________
>> -------------- next part --------------
>> An embedded and charset-unspecified text was scrubbed...
>> Name: libcobalt-gettime_checker.c
>> URL:
>> <http://xenomai.org/pipermail/xenomai/attachments/20190110/bc2720f2/a
>> ttachment.c>
> ________________________________
> 
> This message and any attachments are solely for the use of the intended recipients. They may contain privileged and/or confidential information or other information protected from disclosure. If you are not an intended recipient, you are hereby notified that you received this email in error and that any review, dissemination, distribution or copying of this email and any attachment is strictly prohibited. If you have received this email in error, please contact the sender and delete the message and any attachment from your system.
> 
> ANDRITZ HYDRO GmbH
> 
> 
> Rechtsform/ Legal form: Gesellschaft mit beschränkter Haftung / Corporation
> 
> Firmensitz/ Registered seat: Wien
> 
> Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> 
> Firmenbuchnummer/ Company registration: FN 61833 g
> 
> DVR: 0605077
> 
> UID-Nr.: ATU14756806
> 
> 
> Thank You
> ________________________________
> -------------- next part --------------
> An embedded and charset-unspecified text was scrubbed...
> Name: libcobalt-malloc_checker.c
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20190110/4a80304a/attachment.c>
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux


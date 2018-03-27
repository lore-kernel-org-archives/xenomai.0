Date: Tue, 27 Mar 2018 16:30:23 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <1522259079.8157400.1522157423318.JavaMail.zimbra@triolcorp.com.ua>
In-Reply-To: <54cd6098-3828-b028-3328-daf91b46d9da@xenomai.org>
References: <6aedc4bc-74b5-4a9f-5c38-036a3d7850b9@siemens.com>
 <ee7647d4-0bfd-0933-2f10-e9fdc5da2880@web.de>
 <54cd6098-3828-b028-3328-daf91b46d9da@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 4.9 for x86 issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>

Sorry, but no
I install 4.9.90 and new patch
Ive the same problems   - no responce with  my LKM  and SD card reader
I can add logs

with sd discover new details:
  if boot with sd-card inserted in reader   - sd-card can read , if I remove card  - get no responce 
 
difference with lsmod command output (when inserted card and not) is nls_iso8859_1  
 this module is absent without sd-card

I try boot without sd card and do modprobe nls_iso8859_1  after insert sdcard   -  get no responce 




----- Original Message -----
From: "Philippe Gerum" <rpm@xenomai.org>
To: "Jan Kiszka" <jan.kiszka@web.de>
Cc: "xenomai" <xenomai@xenomai.org>
Sent: Tuesday, March 27, 2018 4:12:32 PM
Subject: Re: [Xenomai] 4.9 for x86 issue

On 03/10/2018 11:06 PM, Jan Kiszka wrote:
> On 2018-03-09 08:51, Jan Kiszka wrote:
>> 4.9 requires more work, I've pushed the beginning to wip/4.9 in the same
>> repo.
> 
> I started to patch further on this during my flight (wip/4.9 updated),
> noticed that the 4.14-wip queue will need a little bit sysentry tweaking
> as well (missing 64-bit syscall dispatching), and then had to find 4.9
> in a rather unfortunate state /wrt x86-64: CPUs are no longer idling
> properly. I went back to ipipe-core-4.9.24-x86-2, without a difference.
> 
> If you should look into 4.9-x86 as you indicated, please check this.

Both issues fixed in 4.9.90/x86 as pushed lately. The result has run
overnight in 64bit mode, and for a couple of hours in ia32emu mode. So
far so good.

-- 
Philippe.

_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
https://xenomai.org/mailman/listinfo/xenomai


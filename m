Message-ID: <52E68F5B.20805@siemens.com>
Date: Mon, 27 Jan 2014 17:54:51 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <52E67336.1010709@siemens.com> <52E6811E.10406@xenomai.org>
 <52E6813E.1050406@siemens.com> <52E6845E.2040300@xenomai.org>
In-Reply-To: <52E6845E.2040300@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL][forge] Only export required CFLAGS via
	xeno-config
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2014-01-27 17:07, Philippe Gerum wrote:
> On 01/27/2014 04:54 PM, Jan Kiszka wrote:
>> On 2014-01-27 16:54, Philippe Gerum wrote:
>>> On 01/27/2014 03:54 PM, Jan Kiszka wrote:
>>>> The following changes since commit
>>>> 14872270fbfd58e88d5d14f3691a1728500b61b3:
>>>>
>>>>     cobalt/timer: fix description of CONFIG_XENO_OPT_NRTIMERS
>>>> (2014-01-20 17:31:47 +0100)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>     git://git.xenomai.org/xenomai-jki.git for-forge
>>>>
>>>> for you to fetch changes up to
>>>> cfe5d34959c52d67f21463d9b98a8b6b33b458ae:
>>>>
>>>>     Only export required CFLAGS via xeno-config (2014-01-27 15:47:39
>>>> +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> Jan Kiszka (1):
>>>>         Only export required CFLAGS via xeno-config
>>>>
>>>>    configure.ac | 14 +++++++-------
>>>>    1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>
>>> This breaks builds with --enable-registry set. Unlike CFLAGS, every link
>>> flag required for building the Xenomai stack is implicitly required for
>>> building apps.
>>
>> So we lack the fuse linker switches? Or more?
>>
> 
> So far only the fuse switches, but we may add more deps in the future.

Strangely, I can't reproduce - is this affecting cobalt, mercury or both?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux


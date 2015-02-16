Message-ID: <54E22C35.1070904@xenomai.org>
Date: Mon, 16 Feb 2015 18:43:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5491B5E9.4030200@siemens.com> <5491C2CA.7000906@xenomai.org>
 <5491C179.2000600@siemens.com> <5491CB3F.2050509@xenomai.org>
 <5491CC27.6080909@siemens.com> <5491D196.3040309@xenomai.org>
 <54D0E961.4060705@xenomai.org> <54DCD68F.5020005@siemens.com>
 <54DCDC98.5070402@siemens.com> <54DCDDC7.5060700@xenomai.org>
 <54DCDFD5.9090202@siemens.com> <54DCE07F.5020902@xenomai.org>
 <54DCE08F.6050304@siemens.com> <54DCE6D6.7060305@siemens.com>
 <54E22AEB.1010508@siemens.com>
In-Reply-To: <54E22AEB.1010508@siemens.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mayday mechanism broken on x86-64 - simpler approach
 feasible?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 02/16/2015 06:37 PM, Jan Kiszka wrote:
> On 2015-02-12 18:45, Jan Kiszka wrote:
>>>> Ok. While we are at it, we should get rid of the syscall return type in
>>>> the COBALT_SYSCALL[_DECL] macro helpers, this is pointless.
>>>
>>> Jep, that's what I did - hard-wired it to long.
>>>
>>> First tests look good, just need to split things up into 3 or 4 patches now.
>>
>> Done, see my for-forge branch.
> 
> BTW, we should also clean up the 32-bit syscall macros in the same way,
> just to be consistent (on issue to fix over there). Can do when I ran
> out of bugs (or need some distraction).
> 

Ack.


-- 
Philippe.


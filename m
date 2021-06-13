Subject: Re: [PATCH 00/17] Dovetail integration - the finals
References: <cover.1623434743.git.jan.kiszka@siemens.com>
 <87r1h57kx5.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a10bb646-fea6-7bbd-60f2-b02c08789dbc@siemens.com>
Date: Sun, 13 Jun 2021 19:12:43 +0200
MIME-Version: 1.0
In-Reply-To: <87r1h57kx5.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Hongzhan Chen <hongzhan.chen@intel.com>

On 13.06.21 19:07, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On top, I would also still like to understand - and ideally address
>> prior to releasing a new major version - if we cannot align the ARM
>> syscall ABI of Xenomai to the kernel /wrt argument passing. Now is a
>> good chance to do that.
> 
> That would be fairly simple implementation-wise, problem though: this
> would require to add this change to the next I-pipe/arm releases,
> invalidating all previous I-pipe releases for 3.2 in the same move. In
> theory, all existing I-pipe/arm patches starting from kernel 3.10 can
> run the -next branch (although it may be better to stick with 4.14+ in
> practice).
> 

4.14 is long dead, 4.19 could be the lowest target. Yes, that might
involve some some complications. Maybe we could add a feature flag for
the new ABI, start with dovetail and then look into lifting 4.19 and 5.4
I-pipe.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


Subject: Re: [PATCH 3/3] boilerplate/avl: fix NULL link representation in
 pshared mode - take #2
References: <20191117114100.3473-1-rpm@xenomai.org>
 <20191117114100.3473-3-rpm@xenomai.org>
 <9aaa820e-e71b-4e9d-8f8c-5f471c9502ee@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <43c53250-b052-d545-49c5-f79f7d9d0011@xenomai.org>
Date: Mon, 18 Nov 2019 09:20:05 +0100
MIME-Version: 1.0
In-Reply-To: <9aaa820e-e71b-4e9d-8f8c-5f471c9502ee@siemens.com>
Content-Type: text/plain; charset="utf-8"
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 11/18/19 9:12 AM, Jan Kiszka wrote:
> On 17.11.19 12:41, Philippe Gerum via Xenomai wrote:
>> Since zero is the offset pointing at the AVL tree anchor, it cannot be
>> used for representing a NULL link. Use (ptrdiff_t)-1 instead.
>>
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>>   include/boilerplate/avl-inner.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/boilerplate/avl-inner.h b/include/boilerplate/avl-inner.h
>> index 8e4de8487..9c0576213 100644
>> --- a/include/boilerplate/avl-inner.h
>> +++ b/include/boilerplate/avl-inner.h
>> @@ -105,14 +105,14 @@ shavlh_link(const struct shavl *const avl,
>>           const struct shavlh *const holder, unsigned int dir)
>>   {
>>       ptrdiff_t offset = holder->link[avl_type2index(dir)].offset;
>> -    return offset ? (void *)avl + offset : NULL;
>> +    return offset == (ptrdiff_t)-1 ? NULL : (void *)avl + offset;
>>   }
>>     static inline void
>>   shavlh_set_link(struct shavl *const avl, struct shavlh *lhs,
>>           int dir, struct shavlh *rhs)
>>   {
>> -    ptrdiff_t offset = rhs ? (void *)rhs - (void *)avl : 0;
>> +    ptrdiff_t offset = rhs ? (void *)rhs - (void *)avl : (ptrdiff_t)-1;
>>       lhs->link[avl_type2index(dir)].offset = offset;
>>   }
>>   @@ -120,13 +120,13 @@ static inline
>>   struct shavlh *shavl_end(const struct shavl *const avl, int dir)
>>   {
>>       ptrdiff_t offset = avl->end[avl_type2index(dir)].offset;
>> -    return offset ? (void *)avl + offset : NULL;
>> +    return offset == (ptrdiff_t)-1 ? NULL : (void *)avl + offset;
>>   }
>>     static inline void
>>   shavl_set_end(struct shavl *const avl, int dir, struct shavlh *holder)
>>   {
>> -    ptrdiff_t offset = holder ? (void *)holder - (void *)avl : 0;
>> +    ptrdiff_t offset = holder ? (void *)holder - (void *)avl : (ptrdiff_t)-1;
>>       avl->end[avl_type2index(dir)].offset = offset;
>>   }
>>  
> 
> Thanks, all applied to next.
> 
> But, again, please always add a proper "From:" line to the commit so that I do not need to manually edit all of them to avoid the infamous "Philippe Gerum via Xenomai <xenomai@xenomai.org>" entries. TIA.
> 

This is the output of git send-email. Will check.


-- 
Philippe.


Message-ID: <527D1E27.3030708@xenomai.org>
Date: Fri, 08 Nov 2013 18:23:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <527B5BBF.2040301@siemens.com> <527BD591.9060504@xenomai.org>
 <527C7CE6.6090603@siemens.com>
In-Reply-To: <527C7CE6.6090603@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-forge] [PATCH] Silence unused_result warning
 from write()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gernot Hillier <gernot.hillier@siemens.com>
Cc: xenomai@xenomai.org

On 11/08/2013 06:55 AM, Gernot Hillier wrote:
> Am 07.11.2013 19:01, schrieb Gilles Chanteperdrix:
>> On 11/07/2013 10:22 AM, Gernot Hillier wrote:
>>> Some glibc versions mark write() with attribute warn_unused_result (found in
>>> Ubuntu 12.04 / eglibc 2.15 / gcc 4.6.3), so we need to silence this warning,
>>> especially when building with -Werror.
>>
>> Why not casting write result to void, it does not work?
>>
> 
> No, it doesn't. For rationale, please see 
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=25509.
> 
Ok, but I do not like your patch anyway:
- it compares directly the function result, which no other code in
Xenomai sources does, we always store the result in a variable and test
the variable
- it opens and closes braces for no good reason.

I believe you still can do:

rc = write
(void)rc

The link you sent also indicates that the warning can be disabled with
-Wno-unused-result

Can you not compile with this option on distributions with this behaviour?

-- 
                                                                Gilles.


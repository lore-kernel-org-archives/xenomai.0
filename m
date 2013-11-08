Message-ID: <527C7CE6.6090603@siemens.com>
Date: Fri, 08 Nov 2013 06:55:50 +0100
From: Gernot Hillier <gernot.hillier@siemens.com>
MIME-Version: 1.0
References: <527B5BBF.2040301@siemens.com> <527BD591.9060504@xenomai.org>
In-Reply-To: <527BD591.9060504@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Am 07.11.2013 19:01, schrieb Gilles Chanteperdrix:
> On 11/07/2013 10:22 AM, Gernot Hillier wrote:
>> Some glibc versions mark write() with attribute warn_unused_result (found in
>> Ubuntu 12.04 / eglibc 2.15 / gcc 4.6.3), so we need to silence this warning,
>> especially when building with -Werror.
>
> Why not casting write result to void, it does not work?
>

No, it doesn't. For rationale, please see 
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=25509.

-- 
Gernot



Message-ID: <530F3FA5.9090001@xenomai.org>
Date: Thu, 27 Feb 2014 14:37:41 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <530CD8B9.2010303@xenomai.org> <530CDCD3.6070703@xenomai.org>
 <530DB691.7010106@xenomai.org> <530F2BA3.5040005@xenomai.org>
In-Reply-To: <530F2BA3.5040005@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Road to 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 02/27/2014 01:12 PM, Gilles Chanteperdrix wrote:
> On 02/26/2014 10:40 AM, Philippe Gerum wrote:
>> On 02/25/2014 07:11 PM, Gilles Chanteperdrix wrote:
>>
>>> The API documentation already lives in a per-version directory on the
>>> server. README.INSTALL, TROUBLESHOOTING and manual pages link directly
>>> to 2.6 documentation.
>>>
>>
>> There will be significant differences, and I'd rather split the entire
>> documentation, compared to crippling this material with version-specific
>> notes and footers.
>
> What I meant is that it is already split. The direct links to
> README.INSTALL, TROUBLESHOOTING and manual pages point to the 2.6
> directory.
>

With that layout, we can't explicitly access to a particular 
version-specific documentation bundle from the heading menu. So when we 
will move current to 3.x, most of the user base which runs 2.6 will 
suddenly refer implicitly to 3.x documentation, which may be confusing.

This is why I suggest that we explicitly split the documentation 
bundles. Besides, more documentation material for 3.x may exist in the 
future which may not have any counterpart in 2.x.

-- 
Philippe.


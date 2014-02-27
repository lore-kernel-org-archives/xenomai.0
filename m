Message-ID: <530F45DB.7000606@xenomai.org>
Date: Thu, 27 Feb 2014 15:04:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <530CD8B9.2010303@xenomai.org> <530CDCD3.6070703@xenomai.org>
 <530DB691.7010106@xenomai.org> <530F2BA3.5040005@xenomai.org>
 <530F3FA5.9090001@xenomai.org> <530F4052.8000501@xenomai.org>
 <530F437D.6090901@xenomai.org>
In-Reply-To: <530F437D.6090901@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 02/27/2014 02:54 PM, Philippe Gerum wrote:
> On 02/27/2014 02:40 PM, Gilles Chanteperdrix wrote:
>> On 02/27/2014 02:37 PM, Philippe Gerum wrote:
>>> On 02/27/2014 01:12 PM, Gilles Chanteperdrix wrote:
>>>> On 02/26/2014 10:40 AM, Philippe Gerum wrote:
>>>>> On 02/25/2014 07:11 PM, Gilles Chanteperdrix wrote:
>>>>>
>>>>>> The API documentation already lives in a per-version directory on the
>>>>>> server. README.INSTALL, TROUBLESHOOTING and manual pages link directly
>>>>>> to 2.6 documentation.
>>>>>>
>>>>>
>>>>> There will be significant differences, and I'd rather split the entire
>>>>> documentation, compared to crippling this material with
>>>>> version-specific
>>>>> notes and footers.
>>>>
>>>> What I meant is that it is already split. The direct links to
>>>> README.INSTALL, TROUBLESHOOTING and manual pages point to the 2.6
>>>> directory.
>>>>
>>>
>>> With that layout, we can't explicitly access to a particular
>>> version-specific documentation bundle from the heading menu.
>>
>> The problem is the nenu, not the layout of the documentation. As I said,
>> on the server disk, the documentation is already split.
>>
>> You can try:
>> http://www.xenomai.org/documentation/xenomai-2.5/README.INSTALL
>> http://www.xenomai.org/documentation/xenomai-2.4/README.INSTALL
>>
>> And you will find previsous versions installation instructions.
>>
>
> Thanks, I'm aware of this. My point is: would you ask anyone who wants
> to find information about the RTDM API over 2.6 to know about a URL? Or
> shall we kill that menu in its current form, and provide something less
> confusing, which can be found on the main page?
>
> Now, we might point people at:
> http://xenomai.org/index.php/Included_documentation_summary
>
> Unfortunately, 3.x has a migration guide which 2.x does not have, 3.x
> does not have a "native" API but an "alchemy" API, and 3.x will likely
> have distinct/additional testing tools from 2.x. So this won't fly.
>
> http://xenomai.org/index.php/<version>/Included_documentation_summary
> would make more sense in this case.
>
> But again, regardless of the layout of the information on disk which no
> user cares a dime about, this is first and foremost a problem with the
> layout of the information on the website's main page.
>
What I meant is that it is a much easier task than having to change the 
way the documentation is kept up-to-date on the server. Of course users 
do not care, they are not the ones who maintain the server-side scripts.

-- 
					    Gilles.


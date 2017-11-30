References: <61813822-bfb7-e2ec-bce2-85a508eab0a5@alaxarxa.net>
 <49014e60-4b55-ed4e-a8c1-576231633c50@xenomai.org>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <94ebb798-5816-98d0-dcb6-6ebe1651861c@alaxarxa.net>
Date: Thu, 30 Nov 2017 15:41:21 +0100
MIME-Version: 1.0
In-Reply-To: <49014e60-4b55-ed4e-a8c1-576231633c50@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno-config options to build Xenomai applications
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai List <xenomai@xenomai.org>

Hi,

first of all thanks!!

On 30/11/17 14:31, Philippe Gerum wrote:
> On 11/30/2017 01:32 PM, Leopold Palomo-Avellaneda wrote:

[....]
> 
>> 3) C/C++ POSIX shared library with native (2.x) (--alchemy) code and xddm
>> mechanism to interchange data. The posix code must not be wrapped
>>
> 
> Assuming you meant: the posix code should not be wrapped (i.e.
> application requirement, not a Xenomai requirement).

ok, but could be any kind of conflict in the posix code is wrapped? xddm, etc?


And just asking an idea. Could be possible "in theory" to build some big library
as POCO to convert it to RT wrapping its POSIX funcions? I'm thinking in the
thread class and the network module (RTNET)

Leopold


-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?


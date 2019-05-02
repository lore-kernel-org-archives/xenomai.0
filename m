Subject: Re: [Xenomai] called regular poll() rtdm-socket
References: <f4d38a1b-0676-fc70-e42e-c07bc2c98cb0@alaxarxa.net>
 <CALLqZ8QGLU56XY4YDj-QkOKjLp6bGucURc1DASPQ_7GQ-rSd4g@mail.gmail.com>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <4c3b2a42-de26-2180-d0ba-299593462265@alaxarxa.net>
Date: Thu, 2 May 2019 16:39:24 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8QGLU56XY4YDj-QkOKjLp6bGucURc1DASPQ_7GQ-rSd4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: ca-ES
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

El 2/5/19 a les 16:28, Greg Gallagher ha escrit:
> On Thu, May 2, 2019 at 10:07 AM Leopold Palomo-Avellaneda via Xenomai
> <xenomai@xenomai.org> wrote:
>>
>> Hi,
>>
>>
>> we developed a C++ library that used rtnet with ethercat. It implements a class
>> that interchange information between the RT and NON_RT using xddm. It was
>> working but now (using POSIX skin) fails and I several (less than 10) and got
>> this message.
>>
>> [Xenomai] platformnode[8324] called regular poll() on /dev/rtdm/[rtdm-socket]
>>
>> Could you explain me what is it? because I have searched on web and what I found
>> I didn't understand well.
>>
> 
> From my understanding, this means you are talking to the RTDM driver
> with a non RT thread.  I don't think Xenomai has a poll system call.
> Can you check if the thread that is causing this is in the primary
> domain?
> 

AFAIK yes ... but checking. It's C++ code that uses native and rt_task.

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


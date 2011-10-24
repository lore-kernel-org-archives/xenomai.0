Message-ID: <4EA5916E.2030708@domain.hid>
Date: Mon, 24 Oct 2011 09:25:18 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <1319401552.9644.YahooMailNeo@domain.hid>
In-Reply-To: <1319401552.9644.YahooMailNeo@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] address spaces of real-time task and standard
 linux process
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "haitaozhumail-disc@domain.hid" <haitaozhumail-disc@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/23/2011 01:25 PM, haitaozhumail-disc@domain.hid wrote:
> Hi All,
>
> Do a standard Linux process and a real-time task (spawned by the
> standard Linux process with rt_task_create and rt_task_start ) share the
> same address space? More specifically, I have a C++ program like this:
...
> Can the function demo() correctly access the object created in main()?
> What if pA is a smart pointer defined in Boost library?

Yes, yes, and yes (though I didn't look at the actual code, the address 
space is shared).

For things like smart pointers, just make sure that someone is keeping a 
reference to the object so the reference count does not go to zero.

hth

                   - Tom


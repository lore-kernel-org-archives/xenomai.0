Message-ID: <50B5CFC8.1060705@gmail.com>
Date: Wed, 28 Nov 2012 09:48:08 +0100
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <50B5B966.4080506@gmail.com> <50B5CED9.2000600@antcom.de>
In-Reply-To: <50B5CED9.2000600@antcom.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] GPIO in Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Roland Stigge <stigge@antcom.de>
Cc: xenomai@xenomai.org

On 11/28/2012 09:44 AM, Roland Stigge wrote:
> On 11/28/2012 08:12 AM, Stefan Roese wrote:
>> I'm looking for a way to use the SoC GPIO's (MPC5200) in an RT thread.
>> Accessing them via the sysfs (the Linux userspace way) is not an option
>> since we need to access the GPIO's at a quite high frequency.
>>
>> How could the Linux gpiolib infrastructure best be exposed to RT
>> threads? Has this been discussed before? Any ideas about the "best"
>> approach here?
> 
> Have you seen my block gpio patches (v7) that I posted recently to the
> kernel list? It now contains a dev interface - much faster than sysfs,
> and can operate on several GPIOs at once.
> 
> I can re-post here if it helps.

No, I haven't seen those patches. Could you please post a link to those
patches (re-posting here is not necessary).

Thanks,
Stefan




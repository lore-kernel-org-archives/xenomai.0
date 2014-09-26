Message-ID: <54252E54.2070404@xenomai.org>
Date: Fri, 26 Sep 2014 11:13:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <54243D1E.9090904@axelsw.it> <54244037.8060507@xenomai.org>
 <54251160.304@axelsw.it>
In-Reply-To: <54251160.304@axelsw.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problems triggering a nested interrupt to a user
 space process
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marco Tessore <marco.tessore@axelsw.it>, Xenomai <xenomai@xenomai.org>

On 09/26/2014 09:10 AM, Marco Tessore wrote:
> Il 25/09/2014 18:17, Gilles Chanteperdrix ha scritto:
>> On 09/25/2014 06:04 PM, Marco Tessore wrote:
>>> Good morning,
>>> I'd like to manage, from user-space, the reaction to interrupts on GPIO
>>> pins, on a board based on processor Freescale iMX28.
>>> I have Linux 3.11 and Xenomai 2.6.3.
>> We did not make an I-pipe patch for Linux 3.11. Are you able to
>> reproduce the issue with an I-pipe patch we delivered?
>>
> I-pipe patch is the 3.10.18 stable one.
> It was applied to a kernel 3.11.0rc3.

Using an rc kernel is a bad idea. Especially since the 3.11 kernel has
been released for several monthes now. Anyway, could you test with a
kernel for which we provide an I-pipe patch?

Other than that, I suggest you read:
http://xenomai.org/2014/09/porting-xenomai-dual-kernel-to-a-new-arm-soc/
And use it to check that everything is made correctly for the SOC you use.

Please keep the conversation on the list.

-- 
                                                                Gilles.


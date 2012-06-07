Message-ID: <4FD0F09F.9050304@xenomai.org>
Date: Thu, 07 Jun 2012 20:19:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBCB442.5030208@wanadoo.fr>
	<4FBCB64E.6090209@xenomai.org>	<4FBCB89A.9090801@wanadoo.fr>
	<4FBCD8EC.60305@xenomai.org>	<4FD0DF23.2030909@wanadoo.fr>
	<4FD0E198.7000606@xenomai.org>
In-Reply-To: <4FD0E198.7000606@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] iMX6 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 06/07/2012 07:15 PM, Gilles Chanteperdrix wrote:
> On 06/07/2012 07:04 PM, Thierry Bultel wrote:
>> Hi,
>> I have another question about the iMX6,
>> it is about the TSC emulation .
>>
>> I have been told that the Pentium TSC could not be accurate enough
>> for a one of our application that performs high precision data acquisition.
>>
>> Can we expect a better accuracy with the TSC emulation based
>> on the ARM timer or not ?
> 
> Xenomai tsc emulation is usually based on a hardware timer which has a
> lower frequency than the core.

ARM tsc emulation. Other architectures are different.

-- 
                                                                Gilles.


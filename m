Message-ID: <50B8B7A8.2010800@xenomai.org>
Date: Fri, 30 Nov 2012 14:42:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.0.1354186801.18650.xenomai@xenomai.org>	<6F62EBB3-71FC-47B6-B6A4-9A2A7EFE793B@kabelmail.de>	<bf6a998422f24fab874ae21fd0adb396@isir.upmc.fr>
	<F74C5334-2EAF-4D8E-AE55-38BF37437EE6@mah.priv.at>
In-Reply-To: <F74C5334-2EAF-4D8E-AE55-38BF37437EE6@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Compiling I-pipe patched kernel on beaglebone from
 Angstrom branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 11/30/2012 12:45 PM, Michael Haberler wrote:
> 
> Am 30.11.2012 um 09:54 schrieb WONG Sheng Chao:
> 
>> On Thu, 29 Nov 2012 13:16:31 +0100, Stephan Kappertz wrote:
>>>
>>> The problem is that you are using the wrong timer.
>>> ...
> 
>>>
>>> #endif
>>>
>>> - Stephan
>>
>> Thanks a lot Stephan and Gilles! The kernel is now able to boot with both CONFIG_XENOMAI and CONFIG_IPIPE.
> 
> great! could you publish a complete patch relative to a known base?
> 
> thanks in advance,

As I already said, if someone takes the little time it takes to generate
a pre and post patch (I explained the why and how in a previous mail),
we can even integrate it in xenomai repository.

-- 
					    Gilles.


Message-ID: <548EF7BE.5090305@nta-inc.net>
Date: Mon, 15 Dec 2014 09:01:18 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <548B67E3.1090309@nta-inc.net>
 <20141212235631.GB11058@hermes.click-hack.org>
In-Reply-To: <20141212235631.GB11058@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Add cards parameter to rt_e1000e module?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 12/12/2014 05:56 PM, Gilles Chanteperdrix wrote:
> On Fri, Dec 12, 2014 at 04:10:43PM -0600, Jeff Webb wrote:
>> The rtnet rt_e1000e module does not implement the 'cards'
>> parameter. I have attached a patch for the 'next' branch of
>> xenomai-3.git that adds this parameter, and it seems to work fine
>> on my hardware. The code was ported straight from the rt_e1000
>> module. My machine has two e1000e cards, so this is a useful
>> feature for me. (I actually applied the same fix to the standard
>> e1000e driver, which is even more useful to me, but I know it
>> would be a maintenance nightmare for Xenomai to start maintaining
>> that sort of patching...)
>>
>> I am trying to learn rtnet, but it seems that the code from the
>> rtnet git repo won't compile with linux-3.14.17/xenomai-2.6.4. I
>> saw that Gilles has pulled the rtnet code into the Xenomai-3 git
>> repo, so it seemed to me that beta testing the Xenomai-3 rtnet
>> code would be a better use of my time than messing with the old
>> code base. So far, so good. My machine's primary ethernet
>> interface is using the standard linux e1000e driver, and the
>> secondary ethernet interface is up and running under rtnet using
>> the rt_e1000e driver. I can use rtping to talk to another linux
>> box that is connected via a switch, provided I ping in the reverse
>> direction first to set up the route information.
>
> You can get rtnet to send an arp request to learn the route by using
> the rtroute solicit command.
>

That works great.  Thanks for the ip.


